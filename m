Return-Path: <netdev+bounces-260148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPkNJi+cnGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCB17B7A1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD987303AF17
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C75E340295;
	Mon, 23 Feb 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyV/VI0M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcsiF4io"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C84340285
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871244; cv=none; b=kY5s/xgRmkYAhOE/gFa1EM04Fkoqb0Jq0SDbGRg1XdgqUvLJcUOQlw8804pTflujHxxAxFIcT0mCetig7UpN3ydDa18URSeE6j4eSZk5adIQtuiCgAJF0HFYwL46xUZLvnU37Z57ljplsKQJHovxrn9cVsid/Duss8udeYOshOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871244; c=relaxed/simple;
	bh=ljG77N6wAsig+8Mu1ygsi+LWjH07dy7dr6AaR+wFDNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYkWwhCmAleYrBWYi+woQQZ8DvG3XCxQJvvTT4soMGU/1N40ggxIO7KVq47yIhguyrE+TJBAiweNPtYXgXV++cbvmI4ey4EfghKRHboVn8h84RA2LdbsMCTWks3R7qP01zDRmVwLQAFtb3Hy2Qf6Vk8uPNlOE1IQgjdpHWu2MRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyV/VI0M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcsiF4io; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbQg7NPsILd3D2TNODA/LEKFJ+11IZWcnnP3a7hokDs=;
	b=OyV/VI0MQD9vJO8lFDjg9DSebQ3shuFcfy6Zd2RH5qKKMqmn265T1pE0T+ruzdqTSnGcaw
	MN0ORk3LlPVBYooV9V/JrFcCMsNzIE2moaZeuF/uq5LBonhlGa1qs9f5aPcRpuVJp975cr
	sFiU2IeiOjGvFPtRl1GGiBv35niUgDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-h_Z90No6M_i4Ou9gN-IEuQ-1; Mon, 23 Feb 2026 13:27:20 -0500
X-MC-Unique: h_Z90No6M_i4Ou9gN-IEuQ-1
X-Mimecast-MFC-AGG-ID: h_Z90No6M_i4Ou9gN-IEuQ_1771871240
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48069a43217so39965015e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871239; x=1772476039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbQg7NPsILd3D2TNODA/LEKFJ+11IZWcnnP3a7hokDs=;
        b=DcsiF4iohrf1slGXEI8uLEuHJu66LzxUjzfC31kYdl9ULwYFgctioDFP4F6XpEDAbm
         VrQRHrY5T9B8GhOnVfYVk6HLcfOS48p04I7WVnJM1Whlh5LaeyFDkZcS/HyJN4ibNY1L
         csmvMDMkvBikAnJ0cQ0rauGAScx2gahSA1PZ2dP00QhFaMdpztCo6Xib/TwAkfjVV7eE
         /P9GnD/vCQFxdl/0opwYqpwewBqOIHyy+mB5O0nSD0Vd+FONA/YVJZiseenpp/Cq08nI
         wp844lc2RbYnguD+Bh9xHy3GhexQ1K54JZIXHamB3LW7dxDI/DHqMOMK8n6Mftdpbnip
         QssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871239; x=1772476039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbQg7NPsILd3D2TNODA/LEKFJ+11IZWcnnP3a7hokDs=;
        b=RPkwehdAvpJnvjsF8hybpykLbT6Wt5gF5TcDajG35gzkFvkLpXNiLqRH52mD0LqWMu
         KfOFLkxdMRqZxDpfnM2wD+JBhTsHDnktWNqePFAfXckgyUzCCYBCl+8QA3C4aiKlD1Ct
         1yNMm6W/KRaQa6G79Bwu6d4hkm599BMkVtCxsD5x5rqfo5QUEMUjJ/Cxw+hIyD1oZhp2
         32ZraxyUh8/0i6L2BXaQgTBZ+CJ9TL3Mwsc4ufapmlI/jBTFCAar78MrxcQi0TuybArL
         3SppJ1jV9qroqATlpRlOrTB1FFmeZHvNGvcxoh4Ko8wZhSLn6ukHVw3AuaTOn4B+qck7
         rrDQ==
X-Gm-Message-State: AOJu0YwVuKL0oHi2iOnSpT+1IrTgVIJDV3XTauyBRZkPlUjE+mzS3dY2
	PKGwo7nFdxfWvUlsSfLhgu8coaVKMmCvBGSC2TL5o4txzRnBi1ygbxOo9p67oZH8gWsoOZxx8Rj
	ERGXHGO5+sCR+MtWgtQj2nG4ZfpJ/S8VVn/IsRAWyFKbkjdr6LWHhDEkzpv++jEihvVj26KexpH
	gOxPJ4cDZeYPuLoxuT4OxnqnMPlxO8q5Ju1TrZzLBUAQ==
X-Gm-Gg: AZuq6aId8vHSmxeP6JOUuOk4KmzWUxm+VNX28K9B6L9NaVi1y8fOQ0jwnaomCq6WjLP
	SdhUXiFdndBUxpu29i9OPvzEJ9PMRUvrUhGPGU80HwzofI+XjmqPRjr+BSiEEgAvjYJ4UB2++HB
	dph9S6lzFguqFOQn0uZOPLia6/b8QiZECSXzUUg9DwqMBwkptIMU1bhViT9aSP4KPSgKoufJo6Z
	dAKI8NOSPmWPMT2Tk4Ovtg5O3nFrqi6pIt9yCz5HbSxruVj3uUFdV8CUeVEyVyJGTTn0VVqRKTt
	Gm8PxJi6c1O9ajHJvP7lTLYr6qKol4Qf7nP6o/rZZIAzQT47NBcME0wK1QJbPRoefN6zmql6pin
	hTqmSfyRZF4jblD7rLWfcZMGoxrjx4DzXeJmfGDVvL7SI5bL41dNKYQ9/x6k=
X-Received: by 2002:a05:600c:8107:b0:483:103c:b1ee with SMTP id 5b1f17b1804b1-483a95c536dmr134054335e9.8.1771871239105;
        Mon, 23 Feb 2026 10:27:19 -0800 (PST)
X-Received: by 2002:a05:600c:8107:b0:483:103c:b1ee with SMTP id 5b1f17b1804b1-483a95c536dmr134053855e9.8.1771871238665;
        Mon, 23 Feb 2026 10:27:18 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm293878875e9.7.2026.02.23.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:17 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 4/8] net: macb: use the current queue number for stats
Date: Mon, 23 Feb 2026 19:26:28 +0100
Message-ID: <20260223182632.1681809-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260148-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13BCB17B7A1
X-Rspamd-Action: no action

gem_get_ethtool_stats calculates the size of the statistics
data to copy always considering maximum number of queues.

The patch makes sure the statistics are copied only for the
active queues as returned in the string set count op.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d42a49a25a62..708107e47ae3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3264,7 +3264,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.52.0


