Return-Path: <netdev+bounces-265574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOqhLfXdrmm/JQIAu9opvQ
	(envelope-from <netdev+bounces-265574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C92FC23ADD8
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 765F13025EE8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F393D3492;
	Mon,  9 Mar 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6LsJuB6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzq1TrSs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E383D3D07
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067461; cv=none; b=PUAnDMIeas3QddauvI1YuPiKHW1KY0S+D9w1tT7Y1rG25zGfnhVJlAN5PNtWh+vK0ZmeQ35scjvcKRdbGhJDsG2oFVM1cz+39Vs0O0RccZn1qbcYlICXsJqqoGvAG910jDajNtPcS2d2jl8IbqZtcxqavgM9CeagXWbk8ONmjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067461; c=relaxed/simple;
	bh=8q4Vi9WcirNBgdFJTdGM8EnOimX4zwg6HUJgFZ38iA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzIhcclNt3/3BpOnasCTIm7ONlL6eveEUenCm2P2BHtz7cZjCzN2+Jypfl6R2Rq47B4QDzcjfJeGvWTTkkndGkZnB3JqwE6Wy/Iol45FyBmqYgQytBNUz/6D7EBF0E0dqHftQLDzTssQhVoe8PGCJCtpRw9VXcA42XtGiUPSIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6LsJuB6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fzq1TrSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocFGbW8/J5/2mHjLWwL9cljMJ+yWYhQXTAd8O91Cxto=;
	b=T6LsJuB6wdlGIssJ4M1XNjtGCYbwBX5EiFmBSnL8iVsY7s5CYkmpxdATf2/ff7EVz6SxG4
	XCF8cVPMWq0dZSzOhkZ6FSeKiBnBROF//UGI8kfB4VmJHVCm86sjE8zyz2Tk1BLGIixjG8
	ve6bXhYenoOpcFTMlLaMcOP4FtTxdmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-YFcB9L1YNp-kbAeYVEj3ug-1; Mon, 09 Mar 2026 10:44:16 -0400
X-MC-Unique: YFcB9L1YNp-kbAeYVEj3ug-1
X-Mimecast-MFC-AGG-ID: YFcB9L1YNp-kbAeYVEj3ug_1773067455
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b474594so5903925e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067453; x=1773672253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocFGbW8/J5/2mHjLWwL9cljMJ+yWYhQXTAd8O91Cxto=;
        b=Fzq1TrSs0UbKPCU54lGq2Y9PltpkByuOFhhsRNpuuPwzVeWVXnCHyepXh318Al3WS8
         78VVa9yRvJHf6vg6eVzaNneyJEaO5u52g5DFTktrZCjnwDhdPJ6eGgStHzv5ww6PQ96e
         lUoRuE+6hiyp4WC+dlzYVTHgz01wghJaR1rbrH+WjfFHlXkZLqqkJ0c/OMzyZ0gojdEU
         92nHtcGymN8pC6RmO/ij3EmB+8SjEvKR8ERe0Ddsl1vjZUZ9/XPww9MyioAC49SjsJQS
         Rxvz5Qrz4egDSZ8kBGDh6dlGGmneS4zhnM4nqZpu2X4w3jOqeWnRM4NEUhzKStSTlg/f
         Csgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067453; x=1773672253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ocFGbW8/J5/2mHjLWwL9cljMJ+yWYhQXTAd8O91Cxto=;
        b=K2365JEZviUk91S0JTd9w77CjjZkMtvU3KXAFhnqUTBC+Fvl1B3CW5sY6ool1e1XSy
         t7aIkOwY86vjBVE84RHNSYZRcThetQp8UJJu6sp1YVttdgp5rjVp0os3geblBCSc6m/E
         eb8L/uBVqW1UAz9s7YIWGDvQJznLkuHnKmzhU+RB5tsFF9ZslcdomCbGvPDkuGROibTg
         LdeHWMS6ZhwLtckHIJmPkKFsa66e3q/Dc36Kw9nSKB3DjJZN1jvrTVbSWyz1ir/iArsl
         5ORR3ffWXFKwHdYMElMSKQZabUkNfieluJCdINrXIwfhxggTCnqa4S41rtoe3aWPGdZk
         NRaA==
X-Gm-Message-State: AOJu0Yyv+DXKkCyxCYIfbfCv6XIrgG7dIVWceTS7SGibUwgVyPvIv6Xe
	0jN9Wkvdp1+sq/Ei3mmaKKUX36/6ZrKgKpA5EKj7P4kY3pJB7zrM6kgjXgBZl9Qgo996ZIN8xGJ
	phI2MpqI4VGix1XLa2Lsc4/ethwmpA3z1pLGYcsHsrBOI9EEodWmZOl+S1n3Knud8iUFt+kEzK4
	x6soSEfDPDJy/94z+8IaYwMEF5neenAj7FTXV6V/5E3Q==
X-Gm-Gg: ATEYQzycDHJyXLYCF/KdipH7UOcZn5kbL5i5vSwSfQKYYj5+ZMzyHAUPaz4q4tq38TK
	2X0+g/lmxHVCcVFVbcVUO29F5VXNuCi3C3Z10IrPAUYnWG5lT1bg95dQIaH2o+7t116766gYRO0
	e7M2hCZy4hK1tlLJkhFr2aGJDQrynYDrXYXURcMFpffHMQSPbuzksHcBk3o9lxYai6lu5RaEcDA
	Ho+dHB+5HF87ujWgVrtmt+nQ1n6sLMXu7J4E/5QJMhIbVfRJBhD1A3tSLopbeoxzbd2lc0BM7r/
	l109T0S1IYt/rVlL84TQ4IjBb4sGMokwlEutmPMDntd4xtaVA4LzQ3sWrRHbd6/+0vv3TUuFtHA
	Y7LkVA9TNk8/143yBTHzfyw48J65QcPbf6s/FjZWJDv2xrlcbHH9Y3xtzABY=
X-Received: by 2002:a05:600c:4fc4:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-4852671c9a6mr174160615e9.5.1773067453327;
        Mon, 09 Mar 2026 07:44:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc4:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-4852671c9a6mr174160065e9.5.1773067452762;
        Mon, 09 Mar 2026 07:44:12 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48536150e61sm161087395e9.1.2026.03.09.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:44:11 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/8] net: macb: use the current queue number for stats
Date: Mon,  9 Mar 2026 15:43:49 +0100
Message-ID: <20260309144353.1213770-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309144353.1213770-1-pvalerio@redhat.com>
References: <20260309144353.1213770-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C92FC23ADD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265574-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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
index e295065b293b..5bf653e5879e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3436,7 +3436,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.53.0


