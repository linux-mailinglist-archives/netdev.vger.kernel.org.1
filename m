Return-Path: <netdev+bounces-254971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJloCbUTfGm4KQIAu9opvQ
	(envelope-from <netdev+bounces-254971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:13:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75732B659F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD133017045
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EE2F5A1A;
	Fri, 30 Jan 2026 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="PvW12i2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741982DFF28
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739186; cv=none; b=p57TFdU5R/OleEJCv0SjzsE0lPFsi/M3/IHdLNm6Dd+kYLRlXiTMfHzt/XrwfD+pQJiB2tQ9lL9uC4D5cCduSH8CJfAmbF7eevKRP18CaqGcBBT0AgwRwlY213TLMg/E1w1qZNVtM8m3suDsOWljgVG9ldMOjVln0QmOXtGgjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739186; c=relaxed/simple;
	bh=Dn0oqzj3iBayzVAA5eJCgjCzUszuWjmSuPyXMeMUfZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/unLsjr6n8njccaXZ/wkhRx6GWUu+kyDQPaBcW6iZLUp59eCVyph0JcN7uQk4PUgasnDM3nbWJGTGqxd00c2+kDD/CMw3kVi5jIbZjV3/3nu5gOYcvrNcRaIy5JcgibRVG+DyNc5TXPkZydacBmpujLcHgA+z0Y8twXq4Gos7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=PvW12i2p; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6630d0685abso568557eaf.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769739183; x=1770343983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80SaEL47Vnh+hnTyM2lFliJDSZtWJHU4tFxt7GihUPg=;
        b=PvW12i2p5K2TP42HSutgF8M2AWPe1rct45nHTUL3YX32iFnRa0Xz3fxdD8c6LhyS4+
         SFtifCrIoFbrUyt4jBr2rWn+9Vd3mfByr/9Syx5zJwMAVTOpuE0+gsq0ETFI2xgBiTVf
         RpVbwBZcuDuq9GByjQOSUTJeFQRdFQ4LrwprCT0Pflt7uQ8QxtnrGRRP1sgHSStG4EWr
         OlsyUs4z7plnwDS/Uq+vnCJviwCMWkEpUaZx0xsTA5vi/a6YpUttrtx/3uSnZLrm7mQk
         QX0+RxnMwS8N3kcQbRljnVAYb53tKekzMrXtjE7HmUuG6eP+rJLsKZWznThGkWpgvP5x
         O3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769739183; x=1770343983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80SaEL47Vnh+hnTyM2lFliJDSZtWJHU4tFxt7GihUPg=;
        b=CewBmJM3oO9ahvZzB2mUftdlXFEH5APXI6bLx75R9MrqM8JdCFyvMT+adxWpZWUkR8
         X4sIbNUEalGO3Y/+9QcADwSiXFNH4eEY3ZO2sg5aKzH/qkQsr9tb4+lvqRqIu0ROVp/1
         24xShQMaZkgch2Tw5kOZov/beHm6YWxRArcITdvmzrLLAFDgxun8lcVoUsH0DVHh9B+O
         qu1XlZjTVijmY0tWqNtD+faNShsdDkVtJ8ahRitgznmQxIfYETt3LBabDzv2m8mu9vKm
         moXXXGAm88QQjwiCagk4BtI4FEbm7jm4cBLkDsNEW6e7Rc9VLuUiFOpTU8gdQHFdoDXS
         QXQg==
X-Forwarded-Encrypted: i=1; AJvYcCXkeIr0HtzS7K9Srcf3KQjrwKaWznUU7MZdpgtSrl11Gp14f2KyFGP524FMPXrXTl2/wQW6EdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1l/ccCK1tibDk+l8SIhoYdtTtqou+LTpBO2GlWBU/PGgF40VP
	EXUzOkOsdDoISSBNbIf9BEp/YzuV++6OY1THx2iidf0R555tO9fUI9p9Xz//QwCncsk=
X-Gm-Gg: AZuq6aLOfWMGP2BBoI+39XwQ95LX4rqiHURoQJp1+HV/oQ7Rhuw9sP/yg7KpYRJSPoQ
	Tgn2aCVHP5tik+JvW3hlDspbXtcxBpLT7Lq6E8ToMTwaajGbaIy+j+bx+ZGByMvudFqEzXv5WBS
	qW39pKSEATKRZSJuriOn7cDnLqcUEZi0ZriMeY4DQQuoBCiDt7717mLnZHhbk1zKpc9AA7dpvap
	mMste7cNLwVDaUYoFW/OReZMhLmb1QIs4/20OBUUR6z09PDsyW2V4TILnbLdQQ0a2OlyLlZQJoA
	eniakoFFD45rwomd82eog8ADU2yTUaf+UUb4I6iyTEGg1G7K9upmG6qK1wyagxcyHGUvV8KI0AP
	fks26rgZWJGhn2ZZxg2TYTxWh8a90EbO5CJQ96OkhX9HGZwvfENj9jvp4Hv0LBGDKsiOFcWJ5FJ
	/wnZGXKHlRj3N9hzSbVQp9j5/Bro7rtHPbWQmxV3RW4v0Bst4LX7ZOk0h3tv0ZOp1kli0sqqAI1
	pFgULVmo0a2e7eF1vVaNY1lSbpAIIk=
X-Received: by 2002:a05:6820:2909:b0:662:f997:8448 with SMTP id 006d021491bc7-6630f37792emr947590eaf.58.1769739183295;
        Thu, 29 Jan 2026 18:13:03 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9a1a876sm4140788eaf.10.2026.01.29.18.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:13:02 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit()
Date: Fri, 30 Jan 2026 02:12:58 +0000
Message-Id: <20260130021258.95045-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-254971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u.northwestern.edu:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75732B659F
X-Rspamd-Action: no action

ocelot_port_xmit() calls ocelot_can_inject() and ocelot_port_inject_frame()
without holding ocelot->inj_lock. However, both functions have
lockdep_assert_held(&ocelot->inj_lock) indicating that callers must hold
this lock.

The correct caller felix_port_deferred_xmit() properly acquires the lock
using ocelot_lock_inj_grp() before calling these functions.

Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() around the injection
code path in ocelot_port_xmit() to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 469784d3a1a6..da8579abea1e 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -559,15 +559,22 @@ static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 	int port = priv->port.index;
 	u32 rew_op = 0;
 
-	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
-	    !ocelot_can_inject(ocelot, 0))
-		return NETDEV_TX_BUSY;
+	if (!static_branch_unlikely(&ocelot_fdma_enabled)) {
+		ocelot_lock_inj_grp(ocelot, 0);
+
+		if (!ocelot_can_inject(ocelot, 0)) {
+			ocelot_unlock_inj_grp(ocelot, 0);
+			return NETDEV_TX_BUSY;
+		}
+	}
 
 	/* Check if timestamping is needed */
 	if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct sk_buff *clone = NULL;
 
 		if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)) {
+			if (!static_branch_unlikely(&ocelot_fdma_enabled))
+				ocelot_unlock_inj_grp(ocelot, 0);
 			kfree_skb(skb);
 			return NETDEV_TX_OK;
 		}
@@ -582,6 +589,7 @@ static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 		ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
 	} else {
 		ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
+		ocelot_unlock_inj_grp(ocelot, 0);
 
 		consume_skb(skb);
 	}
-- 
2.34.1


