Return-Path: <netdev+bounces-255341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m2hoJdKJfWlBSgIAu9opvQ
	(envelope-from <netdev+bounces-255341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:49:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA8C0A72
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B75DD3006128
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CBC30F92F;
	Sat, 31 Jan 2026 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="fCqtSdJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBA25F98A
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769834958; cv=none; b=EnqUwtGuECKUurztFbNijQXKmijKpRfSbPHRjqBm8nkTRlIb4u9dHNODeTP5Ba8NjEhyKXcZuPx7JHufja6r1jPfttHyKrut+5tiUeAcZ0jIPpMW2opHbewMpEysI5Uuc2jW5k9h0QT0GXxurE9WIZrQB61Tzyo8Ds9NRNp/Yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769834958; c=relaxed/simple;
	bh=NI/J5YVJoSSiQ3mTUWeXWKPuwaq80Ooxo7G978V0aCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EKWiN8gldAamiNq4Dlhll5yHJ9toYwSxSovLU+eUIMaotCa2Cepilbx3SRpZk6MTXM6QU608ZiQKkU7KoC8vCh663tNhV4AHVJqzOuQevVemfx61jiqorcdeTimcVvuG1ttCQ/aOXXgLZiw1XfjfFChDardlqZT1raRzne6ePa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=fCqtSdJ+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4094b31a037so1253940fac.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769834955; x=1770439755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZXYKxyu6lh9MR30vXXlY8KAs8v4vrLS853z6QRmTzQ=;
        b=fCqtSdJ+a6VSXJwzpanDWyP0YCiILHw+8OmmZBBN5joYz/lor2ZdmLU5R9hoKCaZ67
         Msh3XxVASrCH1MkQ5wo+PVOYGmg+hzQkjsrv3eDUw94kUODm8Es997pI5Jar3GGKQCft
         W4PEG6ZmL49/1NWV3iFEGd0yoWBsZ6mRGErHkqFD0CFMYGx2K3Tx3FtO5wdOfQauGudC
         z+/wklq27h2T4IETcXcLPVfVrp+7pCIMJ2tIOhM3I8q5Upnve1gbeyLGLuGqIsSgena5
         iJa1+S8l/30haO2T1rtknYY0oL0mglJHMzAY5AEmaosweHe/WoBxWjeFRJvU8hyJn9NW
         9thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769834955; x=1770439755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZXYKxyu6lh9MR30vXXlY8KAs8v4vrLS853z6QRmTzQ=;
        b=iGJ4lNmEOUErrZuYWa/UqMXbls04ktouTdJO2L+2TqCkJQ+P3Jtfhj9ojHqe8hpLL/
         jaft3SFuxrUEBr4UPn8aX2lIxe/BVjk+xrS30h7SVyoLZ1M7sGxVCx6jonQOsEHXEJ58
         xzr+vC/V4iW7vj+0Cflbc1qjkkVEio/5rBHSlkX3Vwh1MREA6lPcxf/9BLZ7ixdPz/WM
         QX0EBtkzAaQObU1bEcirNDJMAE/16zdI+Etn1UfTrMcl5cY+99p11Ci44FWe6L1Htc3F
         ULv2CpxE733/2l4TJQMIqPFMof9Nz7XJctomAHpuOqFVnTLDxHrbeurUR6qvGjxOQLwc
         8X9A==
X-Forwarded-Encrypted: i=1; AJvYcCV98WKTS686/zLWv/Pptw57TnBdM6xrhqaD5WTwSI6Oif4IhIHl6qjBvUmmmdk+AQZOUo0S9hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpy6u/zVY40kJcbcJHEfFSNb9NXg9F81Q5p82+r4dLw9i61Yjr
	PND4/DDNbzsKU2Wpy7XI6gWktWGTLN+VRJOGYpthBwutV7VZTpj3rSILZDIHYEWtwAQ=
X-Gm-Gg: AZuq6aJKNI46XFrffAWl/lJtWqvVuHKk7lmBVuUpxPihh95J7E4mywz2HZNg3wjtQrz
	K6yIkzFYFtZpWG5xtyYgx6/GzL0GzF3t+SFviOCUfqdtruAEjvlGem8TVfHdpXnZxzW56miDgqf
	LirOOjPYM/4F4G24rDRNtjSkpUGzIJNw87gf0ay8+h217KMW5gYARGl1oigi9O+CG7gpr1A4RiL
	MlfQivxLOKj/tzjNmScwJfja6FvzLQ2AOR+oDSkexf7ucMXdgRdwPHPuC6zsN1g17ZC6Uv5JxLE
	66fMkzRcTRMaZPox/kIn2x505AwxBwvdtrLjmaQ2ZK5N5wcKxHVtDUE37vy0jb7NypbGYbiNlGh
	2PDwYhQilg5SeopIKhi87ejyuZMv9tBynzYBMm18Bjr4cb0fmcQGlOhSTUq8JjBuGg7AzonwgXA
	NM1x7bxVa5hjlLz0Kdz146jgGIgJ5kaL+M8fKAVA1II6U9aVf2hzpfLyC12C4ffp1+TFRzNO7XR
	Rm6E46CNqLbjKa38VPk427hE5UJ7mU=
X-Received: by 2002:a05:6870:48d:b0:408:882c:90f6 with SMTP id 586e51a60fabf-409a7026d2cmr2673953fac.57.1769834954611;
        Fri, 30 Jan 2026 20:49:14 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409570f3029sm7367575fac.1.2026.01.30.20.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 20:49:14 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v2] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit()
Date: Sat, 31 Jan 2026 04:49:11 +0000
Message-Id: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255341-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,u-northwestern-edu.20230601.gappssmtp.com:dkim,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: D7AA8C0A72
X-Rspamd-Action: no action

ocelot_port_xmit() calls ocelot_can_inject() and ocelot_port_inject_frame()
without holding ocelot->inj_lock. However, both functions have
lockdep_assert_held(&ocelot->inj_lock) indicating that callers must hold
this lock.

The correct caller felix_port_deferred_xmit() properly acquires the lock
using ocelot_lock_inj_grp() before calling these functions.

Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() around the injection
code path in ocelot_port_xmit() to fix the missing lock protection.

Fixes: c5e12ac3beb0 ("net: mscc: ocelot: serialize access to the injection/extraction groups")
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
v2:
 - Add missing Fixes tag

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


