Return-Path: <netdev+bounces-232688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B380C08185
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB1C3AD7C6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3CC2F7443;
	Fri, 24 Oct 2025 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqZQCuRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E42F7442
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338492; cv=none; b=DaXg4ELjMTMH+sEZbHHMdrU0IcxyThpV7dKU7qSn6hwYhadD0VQ88LaXPzSSz1DV+BsmT3T6KL0SbjTerPCW1JzxjD/F4HGBfrKyac/ijmMcRZoyhffQhPuqAdPaiTFjVctCYAi2tRq7PdqTFCSMi0GiPX/Q2Iwxa2TZY6K/NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338492; c=relaxed/simple;
	bh=6Ig5JvJqdUnu5NrtnRLqoxp1NSWP5pVlnBBNn1lIA8Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2L0eBoubhF9QU1tOyW865GEmLn7R3zTbv8B26RJnJEE3ly1/x2LZIFnBE8e3PTiZH4q9Hx9ID0oA8B4KpmTUcd9XN/GfxLwsgRkNo6QwMosFF7lsvJ7z0HNCUta/mkwz7sx3O4Udtlr31CsRgsE3GvFYajzytpw8HboWVDzkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqZQCuRL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a28226dd13so1556622b3a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338490; x=1761943290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9XZzo5/abI/P2a526BPNM1QX2CIMe2iREhHaWzwR9dI=;
        b=EqZQCuRLyYsX1RvtzmYQafSllZB85pCs6dSFkDS6G7j26Vne92YEweQ/JoMJ1sQx4V
         7vk0DIZz7rK95zr9pfe9WoitrS1mJyCXv1TXD7S5cvqiMwLxr1haDiivTalwl5BHkiPA
         p/YI6XSnKu7yNvOEp6CtNk55ipWxT9jHhfrQipFwfonToG6oN1piuX5e0fIxb67tlOUE
         a04qeWTVBGNB6e+CF0FEAgNSnXFZDvjGSIoS96BewxD4TJs3MWDhgpvW4jxesxZy6xUV
         wdvHXUGMNQN01d1s5daaeOOZVKACohRHCLTtdogzojFGthTJzng88Gebp6paf1qfWfbB
         7FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338490; x=1761943290;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XZzo5/abI/P2a526BPNM1QX2CIMe2iREhHaWzwR9dI=;
        b=lqxf4nAJEmWjKaliNXP+PBGaCyUE9VPeefQfdwvzejMzmq7oS/rppSdzGLlHgvTU12
         +qlXliiqQmbXGit/HwesYqWDEOCxD0SizIhSXP78HX6LXZeztSe4q2665TXr4/cK4GE/
         X3zPZGSPSPhaDdd55U9To4FpKo1yIuiQwOEoBhlJNWF0m48SwJNOYjo8s8AsvE39GPgd
         0/6o8KZ2t8Ur2wOu3slTZfp3GOf9ddMFWPibnoq8Hm69vu6+Yu+DHFtmONQVOhJqhVSp
         EbQ5BScDqH3QHARSRptWRiGTOsHyJbUHw7lCCIUdLycDD9Up83ZOQOmiUdsjxkAzUWoM
         eswQ==
X-Gm-Message-State: AOJu0Yz174+HXvcY3DFfHGo3wAORM3IkC4uvUsmQouwEbK7nOzXX1ul4
	id3f94SbrBqER0Sb7jPJ3OTwuZnshqj9gRtkYB/P55A8XHUVG0DsIh6u
X-Gm-Gg: ASbGncsB8Sz/ESkEVJCHr3jahfeoN9b6eCdfsyYfZsk1tznohtew7wF4NppFt4v9UMU
	hCJXYt1ObcFJiPpJYZUVwADQKc+qphNeQz++JaXF1qQMkVVbVQiddNngntV5Ltmmow++M6tKCRo
	whtyoFO++e+5T4Pjqzu252mSKamciqKNEJ9za1e/yeKGHIMYILL4mMN19txiHlqqSaNeV7UbWxQ
	x8fnqnqCPVpsK8IH7EQj03Nv3g5lGLC5iDK5sexiybMdu5+sRbx53skdNIpW5i+iYJDuxIffTH4
	XNjZZqQevtrG89sG481M1w+snYg/qz8b7tlKPaX4rQtyrwdwUUqZv3rpnACYuimUn6UGTwD0wqW
	lMee6JoDz43r+CVzEf/cS7x9FE5awPN94KHp7d1SiG5Z4rNS5hp97AX+5tKX6t5XuwSFJfcBq8a
	8MG2V48dXYOiEbff5SBf1eLJiJFXeTLu9opQ==
X-Google-Smtp-Source: AGHT+IHUfBgwoqza/GrXnhsrybG9gjHhVeM2FPBW1p5LniC07VlvVV0lkUx1twTFi8vTGFD0wTlAxg==
X-Received: by 2002:a05:6a00:1803:b0:7a2:7abf:75cf with SMTP id d2e1a72fcca58-7a27abf782bmr6545121b3a.22.1761338490551;
        Fri, 24 Oct 2025 13:41:30 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm122802b3a.19.2025.10.24.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:29 -0700 (PDT)
Subject: [net-next PATCH 8/8] fbnic: Add phydev representing PMD to phylink
 setup
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:41:28 -0700
Message-ID: 
 <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

With this patch we add support for a phydev which represents the PMD state
to the phylink interface. As we now have this path we can separate the link
state from the PCS and instead report it through the phydev which allows us
to more easily transition to using the XPCS when the time comes.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    7 +--
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   50 +++++++++++++++++++++--
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 45af6c1331fb..432b053b5ed6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -140,7 +140,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 	/* Record link down events */
 	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec)) {
 		fbn->link_down_events = link_down_events;
-		phylink_mac_change(fbn->phylink, false);
+		phy_mac_interrupt(fbd->netdev->phydev);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 2d5ae89b4a15..1d732cf22ec5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -44,7 +44,7 @@ int __fbnic_open(struct fbnic_net *fbn)
 	if (err)
 		goto time_stop;
 
-	err = fbnic_mac_request_irq(fbd);
+	err = fbnic_phylink_connect(fbn);
 	if (err)
 		goto time_stop;
 
@@ -52,8 +52,6 @@ int __fbnic_open(struct fbnic_net *fbn)
 	fbnic_bmc_rpc_init(fbd);
 	fbnic_rss_reinit(fbd, fbn);
 
-	phylink_resume(fbn->phylink);
-
 	return 0;
 time_stop:
 	fbnic_time_stop(fbn);
@@ -86,10 +84,11 @@ static int fbnic_stop(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
+	fbnic_mac_free_irq(fbn->fbd);
+	phylink_disconnect_phy(fbn->phylink);
 	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
 
 	fbnic_down(fbn);
-	fbnic_mac_free_irq(fbn->fbd);
 
 	fbnic_time_stop(fbn);
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 7b773c06e245..f8807f6e443d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -107,6 +107,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
+int fbnic_phylink_connect(struct fbnic_net *fbn);
 void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
 			      unsigned int mtu, u32 hds_threshold);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index a9b2fc8108b7..b42cc5ad3055 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -132,9 +132,8 @@ fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	state->duplex = DUPLEX_FULL;
 
-	state->link = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) &&
-		      (rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
-		       MDIO_STAT1_LSTATUS);
+	state->link = !!(rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
+			 MDIO_STAT1_LSTATUS);
 }
 
 static int
@@ -264,6 +263,49 @@ int fbnic_phylink_init(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * fbnic_phylink_connect - Connect phylink structure to IRQ, PHY, and enable it
+ * @fbn: FBNIC Netdev private data struct phylink device attached to
+ *
+ * This function connects the phylink structure to the PHY and IRQ and then
+ * enables it to resuem operations. With this function completed the PHY will
+ * be able to obtain link and notify the netdev of its current state.
+ **/
+int fbnic_phylink_connect(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct phy_device *phydev;
+	int err;
+
+	phydev = phy_find_first(fbd->mii_bus);
+	if (!phydev) {
+		dev_err(fbd->dev, "No PHY found\n");
+		return -ENODEV;
+	}
+
+	/* We don't need to poll, the MAC will notify us of events */
+	phydev->irq = PHY_MAC_INTERRUPT;
+
+	phy_attached_info(phydev);
+
+	err = phylink_connect_phy(fbn->phylink, phydev);
+	if (err) {
+		dev_err(fbd->dev, "Error connecting phy, err: %d\n", err);
+		return err;
+	}
+
+	err = fbnic_mac_request_irq(fbd);
+	if (err) {
+		phylink_disconnect_phy(fbn->phylink);
+		dev_err(fbd->dev, "Error requesting MAC IRQ, err: %d", err);
+		return err;
+	}
+
+	phylink_resume(fbn->phylink);
+
+	return 0;
+}
+
 /**
  * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
  * @fbn: FBNIC Netdev private data struct phylink device attached to
@@ -285,5 +327,5 @@ void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn)
 		return;
 
 	fbd->pmd_state = FBNIC_PMD_SEND_DATA;
-	phylink_mac_change(fbn->phylink, true);
+	phy_mac_interrupt(fbd->netdev->phydev);
 }



