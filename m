Return-Path: <netdev+bounces-216345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43390B33387
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172421B224AA
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8B1E8323;
	Mon, 25 Aug 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMq7PBU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BF8834;
	Mon, 25 Aug 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085313; cv=none; b=ii003jMcFroGQxWA+8G4QoUFtfrcg9pgE3tEpPdEaZ6lTQwy4tB1h6/7wsWPVd+v8dwRJF82x0z2iNOgftdkGx4O1mGBtM1kfDb7hVf69SAwSCpb88TdJwguUsQ09xzqhwzOLvvX0NWM+Lsrzgh8jseF4C87fnI437hiZOGqe5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085313; c=relaxed/simple;
	bh=mWjmv8nS+0hMtTfIlk2YI24AKZd72l8+M58ZvUGENTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PaKcMAlkk5duQhUpUuwD/bV9F2hpYp3hfET5IVUi+EK8qXSGMkHWzxgh1kCv/ri4x1rC03rzEpwoI+RB+iRWY3hzGBellhjbFfnCs2enKcrDOCjsJ7abAVXZkKWp6uXCOJjfTGzAUgMTy1pKlHBMqSYLA5lV0QhNWE3fFO94zy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMq7PBU3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so3139765b3a.0;
        Sun, 24 Aug 2025 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756085311; x=1756690111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLTz8EuNv2P1jX8ids+qXdU9eb4foeqMQi2kaAA03Ss=;
        b=LMq7PBU3cKy1+k2/B/BHlPv39RMpMjiTgoXGLH2ueZHtR9buZBvW3aK3xPAHvWhQQ7
         GFRCu/t8gUGErGBljeRsVtgN/w2gUNVMYZOtKxBzEi8UDrPvnA0eNFO7AecUnTZIiPL7
         0poMHsFMCUb+W0GHZd6QMJs2VGmJtAgkgDCvn+OK3SC5kYFAr1S8FDclPfIh65t+WQET
         fSsMNfaCb61oOJ0j12VlU0r6U1xDG+OcQ97yzDUTBGaGwDkLeCD2lapl6GrvVP+jT8Zf
         KYqlQKqnj7O1B8kZczM3nYlUlzuB9zd6f0wPEXOQq5DEvRPumxXIg5Y7qx3FxzlGRMd6
         kkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085311; x=1756690111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLTz8EuNv2P1jX8ids+qXdU9eb4foeqMQi2kaAA03Ss=;
        b=ZYP51AYxCLFzUzoS5CLNmGUMfoRCvVMkGRS8FOdCnFqjY+OV+tBl86slZLjaXytrbe
         NuAUxo0i5MrL+pXZVoZz6wTehwacj+/qtJygFoKlyYZgU9tREwcaJW2ORPaJdyvgnhqC
         sHWK0gFHDnx6TNJHvfFAz+99NfmhPGwSOe9FpF+WeBlIii/SNK7hMQ19XH+J0zzOe2Bc
         01d9Sfz4EmQQuflC24LvFR8GRaZnCUIZeOvISi+QplRLfODjfXRxZ+ezGkLLXhzW30HH
         wyI4W9fa6aERh3IDcwzcT0BRY+W5D1eYJXtojUsaHRhAzc+c3e5uzmi2PrN0c2ofHNpw
         Da8A==
X-Forwarded-Encrypted: i=1; AJvYcCU72+V107UAkiUfpLuVKiNKwYQajP3ZTE/AjPBw18TKr0DD2bajyQ2308mS/Z/KN3KIYsavFyfTEXvyZeA=@vger.kernel.org, AJvYcCXEzb5MNMX2gbxUYwZ3/CJ2s0SEHw4WJmZr6oyQOkCtBq8oa2ZHWEIY+oy/baqT4DtV5KjLQrnt@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsDCOtRwr6j4Kz+jHj4T34eZIlkEBQRgVe/tvxZQlxgJU1NLr
	bGWpB4azCPZ41ap+LJlWIxeAJIeNauVAkcW7SH3id3jfiHODXEkokjhz
X-Gm-Gg: ASbGncsBCfTnZEPo1AZXWfh2L8qa1MV938hN/17LbZVxAERtbIwTjJa7guneyXaajVQ
	RVGQpbUcqSILJmvtOyHAMKGggVNKULkXXF3eKYEs38mS0/ZTPSjRmrwoxs02oLh40EtZjEzi+xd
	s6HtGinVKNl0DfWUhi2zoa0xOscSL0jHfXuKaTu1sZLvP5hR6JKh1+xPcaZzi3+6aoPHdBBkymU
	j2zZPg3jtbCrHDw46MY5hegnwSTPaUDHfQ+k8YNKl7gX2QUPELWz6A7OsN8TjeNFt31/iCAJ60I
	Wt4Lljyz9NuSlpKWm7vnE7jV5URPzcX/G35x/EcuSFuXqEhVmynokUhtu8V31EVTpLTuc4joUNH
	xY7wkmMc6f/7tGVpUtDqH+6OhjTq/4lV6HH4YPJZ/ntURnf+V6F4k
X-Google-Smtp-Source: AGHT+IG9+K1FJPLf7FqFjjyuA4Onx8fz6b3EE2IGUZMWkS9dLz+Am3xXjDIAdBZ+6dP7kK+UVKvOGw==
X-Received: by 2002:a05:6a00:4b16:b0:76e:7ab9:a236 with SMTP id d2e1a72fcca58-76ea30f4f65mr16004138b3a.13.1756085310798;
        Sun, 24 Aug 2025 18:28:30 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040021393sm5773113b3a.49.2025.08.24.18.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:28:30 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH net v1] Fixes: xircom auto-negoation timer
Date: Sun, 24 Aug 2025 18:28:21 -0700
Message-ID: <20250825012821.492355-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auto negoation for DP83840A takes ~3.5 seconds.
Removed sleeping in loop and replaced with timer based completion.

Ignored the CHECK from checkpatch.pl:
CHECK: Avoid CamelCase: <MediaSelect>
GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;

This can be addressed in a separate refactoring patch.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/net/ethernet/xircom/xirc2ps_cs.c | 76 ++++++++++++++++--------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index a31d5d5e6..6e552f79b 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -100,6 +100,11 @@
 /* Time in jiffies before concluding Tx hung */
 #define TX_TIMEOUT	((400*HZ)/1000)
 
+/* Time in jiffies before autoneg interval ends*/
+#define AUTONEG_TIMEOUT ((100 * HZ) / 1000)
+
+#define RUN_AT(x) (jiffies + (x))
+
 /****************
  * Some constants used to access the hardware
  */
@@ -281,6 +286,9 @@ struct local_info {
     unsigned last_ptr_value; /* last packets transmitted value */
     const char *manf_str;
     struct work_struct tx_timeout_task;
+	struct timer_list timer; /* auto negotiation timer*/
+	int autoneg_attempts;
+	struct completion autoneg_done;
 };
 
 /****************
@@ -300,6 +308,7 @@ static const struct ethtool_ops netdev_ethtool_ops;
 static void hardreset(struct net_device *dev);
 static void do_reset(struct net_device *dev, int full);
 static int init_mii(struct net_device *dev);
+static void autoneg_timer(struct timer_list *t);
 static void do_powerdown(struct net_device *dev);
 static int do_stop(struct net_device *dev);
 
@@ -1561,6 +1570,8 @@ do_reset(struct net_device *dev, int full)
     PutByte(XIRCREG40_TXST1,  0x00); /* TEN, rsv, PTD, EXT, retry_counter:4  */
 
     if (full && local->mohawk && init_mii(dev)) {
+	if (local->probe_port)
+		wait_for_completion(&local->autoneg_done);
 	if (dev->if_port == 4 || local->dingo || local->new_mii) {
 	    netdev_info(dev, "MII selected\n");
 	    SelectPage(2);
@@ -1629,8 +1640,7 @@ init_mii(struct net_device *dev)
 {
     struct local_info *local = netdev_priv(dev);
     unsigned int ioaddr = dev->base_addr;
-    unsigned control, status, linkpartner;
-    int i;
+	unsigned int control, status;
 
     if (if_port == 4 || if_port == 1) { /* force 100BaseT or 10BaseT */
 	dev->if_port = if_port;
@@ -1663,35 +1673,49 @@ init_mii(struct net_device *dev)
     if (local->probe_port) {
 	/* according to the DP83840A specs the auto negotiation process
 	 * may take up to 3.5 sec, so we use this also for our ML6692
-	 * Fixme: Better to use a timer here!
 	 */
-	for (i=0; i < 35; i++) {
-	    msleep(100);	 /* wait 100 msec */
-	    status = mii_rd(ioaddr,  0, 1);
-	    if ((status & 0x0020) && (status & 0x0004))
-		break;
+	local->dev = dev;
+	local->autoneg_attempts = 0;
+	init_completion(&local->autoneg_done);
+	timer_setup(&local->timer, autoneg_timer, 0);
+	local->timer.expires = RUN_AT(AUTONEG_TIMEOUT); /* 100msec intervals*/
+	add_timer(&local->timer);
 	}
 
-	if (!(status & 0x0020)) {
-	    netdev_info(dev, "autonegotiation failed; using 10mbs\n");
-	    if (!local->new_mii) {
-		control = 0x0000;
-		mii_wr(ioaddr,  0, 0, control, 16);
-		udelay(100);
-		SelectPage(0);
-		dev->if_port = (GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;
-	    }
+	return 1;
+}
+
+static void autoneg_timer(struct timer_list *t)
+{
+	struct local_info *local = timer_container_of(local, t, timer);
+	unsigned int ioaddr = local->dev->base_addr;
+	unsigned int status, linkpartner, control;
+
+	status = mii_rd(ioaddr, 0, 1);
+	if ((status & 0x0020) && (status & 0x0004)) {
+		linkpartner = mii_rd(ioaddr, 0, 5);
+		netdev_info(local->dev, "MII link partner: %04x\n",
+			    linkpartner);
+		if (linkpartner & 0x0080)
+			local->dev->if_port = 4;
+		else
+			local->dev->if_port = 1;
+		complete(&local->autoneg_done);
+	} else if (local->autoneg_attempts++ < 35) {
+		mod_timer(&local->timer, RUN_AT(AUTONEG_TIMEOUT));
 	} else {
-	    linkpartner = mii_rd(ioaddr, 0, 5);
-	    netdev_info(dev, "MII link partner: %04x\n", linkpartner);
-	    if (linkpartner & 0x0080) {
-		dev->if_port = 4;
-	    } else
-		dev->if_port = 1;
+		netdev_info(local->dev,
+			    "autonegotiation failed; using 10mbs\n");
+		if (!local->new_mii) {
+			control = 0x0000;
+			mii_wr(ioaddr, 0, 0, control, 16);
+			usleep_range(100, 150);
+			SelectPage(0);
+			local->dev->if_port =
+				(GetByte(XIRCREG_ESR) & MediaSelect) ? 1 : 2;
+		}
+		complete(&local->autoneg_done);
 	}
-    }
-
-    return 1;
 }
 
 static void
-- 
2.51.0


