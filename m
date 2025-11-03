Return-Path: <netdev+bounces-235201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A1C2D582
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 063274EE7DA
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FE31AF12;
	Mon,  3 Nov 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXI6U8jK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BC31A7FF
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189273; cv=none; b=N6SpasEmOmU+UwuHl5fH2wo1Y+dlB7c9Xx/fvSNm7CTr/nNK9WstXrXNW3J/xCM2/M5boKL8n6spa6BGRhICj+E358q3/zX+SqsZvo0Cun7GRA4h8Nip6XYZiIaOM5MkFiCH5EQrydQHC+qgwrZUJTsaGiYU8ulhDHvatHOKUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189273; c=relaxed/simple;
	bh=tPH3Ip/dOaFgAXzZanr6PahO+v6k2Z17w73EygtSYyw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4qTBhu0krx0SOUFlsCa0zk8JNfgEdcAKArKwnV/cMhRaZ6xSVgqi4oY6vPeYuoD6MDEgcXuCswfwMjhO/soACdXN1V5cpGciBf4hCuvV3Tjq8P59fn2MaprAbU2iv2EEZ66QeqgJ/bGALn60+qWFxLCAueROhnbcklEtxSi1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXI6U8jK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3240585a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189270; x=1762794070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d4iv0IyAlKWnpe2VI/iCFfN77HbwYzZJuo0DoWONu2Y=;
        b=CXI6U8jKEqR6vqX+Qr2p6USocAIq14x1mWVX1K6+0rbw6qwXjqYrAXGrDvyCBBHliU
         m366bpXFyNVipuwQ/cOHhyc3WCEsW1EE3JlBuxYDBe3CTcmuyjRg6gABMETB6verQUKi
         jIFdjNOw5QXrt3cu2ga7liXWI1Htu2naXcFnm/sZze0iKAT2atq3UPjVb9XIjz/UmOQt
         0uWku+zZQ1KFeTdGSsyASAjExjlDZrazH1hJM/Yu0l6ZEbSxfYznynIfbsRN9zt79Rim
         FGjXWlvL3m4h8qUWnaihQbwliHz/ubslxZJUrNuxVcBnGQh9E1bgwzrx7sacRlPulq9x
         8Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189270; x=1762794070;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4iv0IyAlKWnpe2VI/iCFfN77HbwYzZJuo0DoWONu2Y=;
        b=ASEUJfw4JmpHwM6wdsMDTidR8XjwbvLuzFuOVRMW55beiU+rDULAA/HZHngWMlAcpF
         WgzAhNPtH0ZC6p+1r2vcWTQktCPyeFFWAsYazLi/s8HRlcj8svKCRs/7F521N5ZdsnWb
         4FOqXWJGgbLdAg+zk+eOm9UoxCAMRWkWGGmMWoEpjQTCiA03MGv65hCs9j63Puf3bISY
         7SJL6/4wnFJseRn3JVngWsI2+RPI2FRMif5BCFE0j+CJefhwpyYYfyoFHNIoXjpdbGRE
         c3XXrm8lxyE2axa6u7KM3fnbuMTnJbtB5Ftpb8NgndbORBBNOffioEi4BPzVWLbUpUUy
         Q1ZQ==
X-Gm-Message-State: AOJu0YxtpOabq4I1/CTxEyDkp3OMrLMpkRD83TpJdUdksh5/hyxYysPn
	git4cVta9MQaL52wRKeC553kOztwdGtMzBnehd624j27i3HmcVhbIohrCbDZvA==
X-Gm-Gg: ASbGncuJgFxELPPOClVmb2i7oWQSSXwP4LfFUx3Mc8zum7XBQhmq2nTJ255LOgFQRFd
	5F6B0iv8fx3fT2bXLHhgu3J7Jm4vBgOEmxD8X+YJ26fztsQSTyJ+BjnzKL1pmrxuUJo9KOwX1c7
	qOKe9Uquxl8i/y8ld0vCq1YBuymdS4w8LmC0vBmhXruz3OdGPoJNwAOuyF/5xK875hoY5eHgNqQ
	WxfF+GZFrEbtlfwng8QWxhvdpAzjeQb6UX0LlI6Ze7jKqtCBOFUm4evKc+FiqRw09WX4LBACLYM
	0HMnInpLBmU7diWECaJlHRfuUkFVbObz7oJE82W82iD2ibBaejIPqezzc1qCR9qqsQBeKdsOuOB
	ch22mMpVi1PR4b2AYI0QJ9iVo1DeYrch/NE8yDQlHN26TlV5KdZutAS2cODCP/+kg09s1gsX8Db
	ZluZwyR2z6WoQXz08Dc0Lb5aCO4vC+KV2ZzUdHUO8FITFQkdYI0oRe+58=
X-Google-Smtp-Source: AGHT+IGivuK5xjM/Wt2/IVIymgbgLYgsMG+smpYxfBCxOppEtgoe9bazrKJdFt1MXk0DRBHOCW30pw==
X-Received: by 2002:a17:903:11cd:b0:27d:c542:fe25 with SMTP id d9443c01a7336-2951a587e32mr168550465ad.41.1762189269330;
        Mon, 03 Nov 2025 09:01:09 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aac02eec0bsm5059646b3a.30.2025.11.03.09.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:01:08 -0800 (PST)
Subject: [net-next PATCH v2 10/11] fbnic: Add phydev representing PMD to
 phylink setup
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:01:07 -0800
Message-ID: 
 <176218926788.2759873.2345667871349722199.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/Kconfig               |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |   16 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   40 +++++++++++++++++++++--
 6 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index dff51f23d295..23676b530a83 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -24,6 +24,7 @@ config FBNIC
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select FBNIC_PHY
 	select NET_DEVLINK
 	select PAGE_POOL
 	select PHYLINK
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
index 65318a5b466e..51cf88b62927 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -101,6 +101,20 @@ static int fbnic_stop(struct net_device *netdev)
 	return 0;
 }
 
+static int fbnic_init(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	return fbnic_phylink_connect(fbn);
+}
+
+static void fbnic_uninit(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	phylink_disconnect_phy(fbn->phylink);
+}
+
 static int fbnic_uc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
@@ -529,6 +543,8 @@ static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
+	.ndo_init		= fbnic_init,
+	.ndo_uninit		= fbnic_uninit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_start_xmit		= fbnic_xmit_frame,
 	.ndo_features_check	= fbnic_features_check,
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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b3f05bdb4f52..befcb1e7747a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -16,6 +16,7 @@
 char fbnic_driver_name[] = DRV_NAME;
 
 MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_SOFTDEP("pre: fbnic_phy");
 MODULE_LICENSE("GPL");
 
 static const struct fbnic_info fbnic_asic_info = {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index e10fc08f22f2..59ee2fb32f91 100644
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
@@ -264,6 +263,39 @@ int fbnic_phylink_init(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * fbnic_phylink_connect - Connect phylink structure to IRQ and enable it
+ * @fbn: FBNIC Netdev private data struct phylink device attached to
+ *
+ * Return: zero on success, negative on failure
+ *
+ * This function connects the phylink structure to the IRQ and then enables it
+ * to resume operations. With this function completed the PHY will be able to
+ * obtain link and notify the netdev of its current state.
+ **/
+int fbnic_phylink_connect(struct fbnic_net *fbn)
+{
+	struct fbnic_dev *fbd = fbn->fbd;
+	struct phy_device *phydev;
+	int err;
+
+	phydev = mdiobus_get_phy(fbd->mdio_bus, 0);
+	if (!phydev) {
+		dev_err(fbd->dev, "No PHY found\n");
+		return -ENODEV;
+	}
+
+	/* We don't need to poll, the MAC will notify us of events */
+	phydev->irq = PHY_MAC_INTERRUPT;
+	phy_attached_info(phydev);
+
+	err = phylink_connect_phy(fbn->phylink, phydev);
+	if (err)
+		dev_err(fbd->dev, "Error connecting phy, err: %d\n", err);
+
+	return err;
+}
+
 /**
  * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
  * @fbn: FBNIC Netdev private data struct phylink device attached to
@@ -285,5 +317,5 @@ void fbnic_phylink_pmd_training_complete_notify(struct fbnic_net *fbn)
 		return;
 
 	fbd->pmd_state = FBNIC_PMD_SEND_DATA;
-	phylink_mac_change(fbn->phylink, true);
+	phy_mac_interrupt(fbd->netdev->phydev);
 }



