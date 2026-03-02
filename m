Return-Path: <netdev+bounces-262630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJT8F1B6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:53:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA21D7E6B
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40F69303EFEF
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EC3644BA;
	Mon,  2 Mar 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KER00bwO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t+j/ug99"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4603630AA
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452368; cv=none; b=En8+CmfAXmQzdTfAQvYmM4A0YLRgc6eVTPM2/52iJ96OxJgdCgUmpaSFmJkLjVxBKqtpFEVSVqVEkMAHvOW5YPgL9IT1M6XOB0pJcJUtRKUOBJ3v46WqwTo1s8UJLWV1wEaXTeGyKhPz/bSzAGXAxjZFVEwFP0WhNWS4iEB3uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452368; c=relaxed/simple;
	bh=zMHE5M0mmQWDOYzYouin18yZytaYU8bZnkbzDaVihFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYhDCKQDnD0+PkK4KLw1DzWKRC37l1czHV8nDWagSzzoSN5mEmtPb9L59qfB5pNAe7iPgPCCSeNaU3Y9bz9MSomw7PlrSpr2O1IJHJUFY5S+4TKbP5HZ1QRXGBpeJP6hANeIcBR7Nt+fYorzbs6MkbTNK+RJ+ePa3LVtsT4xDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KER00bwO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t+j/ug99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGTllrq2Q0pAaevrlKemig4WncAMlUnW+rKno1veeiY=;
	b=KER00bwOaqopjEOH0lqNupNu0ewIkAsvjW4BlkFnGKjuTrqTZ8neSoM9OnOLCkqPRG7vgI
	AA2ZjYjkAoX37YWjZw7OzizJ3KJPtu82EKS8raAZMiMI/9pCO5XNlkaEZfsZNh40gIcebQ
	5LjOGxulwizR0f7GIyaj2lrADADUwWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-dx_ScOKlPwahJefFqdm6cw-1; Mon, 02 Mar 2026 06:52:45 -0500
X-MC-Unique: dx_ScOKlPwahJefFqdm6cw-1
X-Mimecast-MFC-AGG-ID: dx_ScOKlPwahJefFqdm6cw_1772452365
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso36560055e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452364; x=1773057164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGTllrq2Q0pAaevrlKemig4WncAMlUnW+rKno1veeiY=;
        b=t+j/ug99jVwjSxXl9y/zzq9md/ym1Tgf8OBEAj5FMkGQC1IMu8gmPP1pu6sfKuHXLK
         Iqupg6COGB5N1QtJpimaqE/it3WKA143xPlw/M3r4B7DgzRZcVhw7dJTQXY+bciUO7By
         WnZbptZDk887gKSEY4MVczMPPcHzppTv0juvxG4S2W8cJoX4CjcVW1MetBfPa9fyQH+n
         OGielsitHpT1gZ9oSTnLt26XoyyOiWskuHFWGA1qtJM3Z335wybpNyzIelXJR3V4NkvD
         paNM02btG03kjHTNbx+RbfbhVXEcWI2P9zUFH7wTlRIRZnhTSB9H8YM7VA5jNoqie/tQ
         DCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452364; x=1773057164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGTllrq2Q0pAaevrlKemig4WncAMlUnW+rKno1veeiY=;
        b=KyuEpepvNUppyFXq5O8eyQIVt5xz6DhOCWfYhGH5CYJSrsjbmrhsA+u6RUwP2PV6K4
         hT912PG/lFQnQAtiRVaZK5KwzTXCZQCqbRVysxJK60GT1gyU+c9RgzTfVZ0R8nb2tBgN
         Hq/IjwTkncVLO69EsBd7coqTQTNOqM0/SHC9O7z2lxwS8KvxkRoBlNDVOJ6IM7Fs3WGk
         V5mJIvCxVCnNy8qNyw4bSnTfpGB7VIw0rLpVwEGVIc7hL7Dz9T/xhc4CsCv5Iv/h6Qoz
         V8x1eeFRE8wFCtF31xuV1YhiN94FxwR25MZO8SxMWpd6P6IyyAVDVRtyXCafXcVQiovi
         WCUg==
X-Gm-Message-State: AOJu0YyGNivY9LFJo3mSpYtnNawROh5W7EB3An1wTsmLjXeXyYSZXyia
	36QuWL7O27XUtCMPbZbwxNObYn4tQ8QVek56e9B7InCPG20NgHZxYf6TRz6JV8tb/fUNXTcJ1pK
	ByfbXbxpJD8Fr4TFlqtNdFJxu1ySENB0KbYVUa0zW5IBQJnnEPw36d9OD3godLhBkDimejr4pTr
	3IlmVRFrtx9+hWFzRtLApSqebhfgbYzY30pP0DBPxryA==
X-Gm-Gg: ATEYQzwmySnuYGkOypTzLrWJiZOrDlsFyZf5Spty+jILZqHgZnDvmgwxU0w8ladCJDP
	M5vvAGP3ZSzk5+21OB9uDgIAoPvWq3fqK3r692b6JEhDihFEW7adTg5LPywCrcDp3UWIeb6yQPW
	3sFeAEN8YZ6xNNih4y61kQ6kFdmjXbjWMwhLTaoNOdz9Po2uDBRTHurkBdSsOsZw5W3Q2fTCyWC
	x7rYXUOknZOPxo7XCU0cWXlhB9TuVG2UsYMx+iloE7Ki5wO3sisb9jeMKVjGe4Gr6eyi/mbCCw4
	uoJLwyRu+t50ak+1ui3jGGxD1ByQ5FpR6n9UkW46w8GMyoEL5+czIQ43aT2fqzBR7mHmbJhzpMg
	4RY9bSphMnlt632fmMTp/A8OesqhUbS/FANMdxnp81PgKusJaTd1aaujDy+E=
X-Received: by 2002:a05:600c:8106:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-483c9c24049mr187337095e9.25.1772452364010;
        Mon, 02 Mar 2026 03:52:44 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-483c9c24049mr187336525e9.25.1772452363430;
        Mon, 02 Mar 2026 03:52:43 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm235569395e9.1.2026.03.02.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:41 -0800 (PST)
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
Subject: [PATCH net-next v3 4/8] net: macb: use the current queue number for stats
Date: Mon,  2 Mar 2026 12:52:28 +0100
Message-ID: <20260302115232.1430640-5-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262630-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAFA21D7E6B
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
index 621bca2e1844..b8b2b0111b49 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3307,7 +3307,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.52.0


