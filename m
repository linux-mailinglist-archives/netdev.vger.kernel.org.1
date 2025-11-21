Return-Path: <netdev+bounces-240821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C1DC7AEA4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 211814ECB86
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F02E9EB1;
	Fri, 21 Nov 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjWqvx2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5172E7F1C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743257; cv=none; b=Zvp/Dvyy5/4KeiozyP76EDVtGs3fpLzc1HpUJanqn1nNviyA30f9F1Jseg9KTnxiTRQ/LwYkO7dW/obknwZs2oAgoe6MDWz5XIdWXHArGwxuE2Eq4FBiKCZ6yjE/reN7sIyBgWwcVBiUtY9d3+aHOcX+VnZEEXJZj60kuhYvo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743257; c=relaxed/simple;
	bh=cOlu56qTo1pZa1QDVW0RvIP0UVfYaHfDQyAPTO7iLU0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUVIOgd40XeI7plc/nXe+IYywgTUJ2aBnT7GS0JOCywp9rapB702ycKcIxOkVKlF+KNPbSltJTC9ufppk9Tclyx9stTrSlQbF3oFlTSjtM9200kbZesONwISEn3L+yIL3XSPKNSi9WF31eZj2q0H++5nqijQx9U53OAjDX4a1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjWqvx2/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e264528aso25970265ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743255; x=1764348055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/WGtU0UVJKlb1wsfZJEXpuOAXqZ+cM323d7iu9zqyw=;
        b=RjWqvx2/Sd5t+ehz+ch5XBbG5+3B0gOevFo/E6mS+Tc08YEf2n/sB1wCxwvnpBNIn0
         prPSi5ROhwKpcCXfyY/w3yh3UbMoVz3yiBEcv6BnEr9GRPPBt0Pu6AlDREhpBA3yCHtw
         X6PEKj7bIFLkdxK/HccU14AY3pK5hg7pzxWKb9OwzpeXzS2RTKdZftRj2Oe/XUJppaft
         f0fRowX0t0hBmG/vk3wCgJ9mfedX4cWjlZig6NoX6buFggLWNdvcx3EIOsNKuhhwbEqv
         +X6hZ1xR74j3y2DwzfCr80dXD81uDnJ+EiiNySeOyufrxf5WGEWfLqmPkjweV7emX0y/
         t0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743255; x=1764348055;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/WGtU0UVJKlb1wsfZJEXpuOAXqZ+cM323d7iu9zqyw=;
        b=jPkWLiePKn/WCODGZeeVh7cPWDXh7IY/8niaRbyv2SkkLHxnFu11nLCq+HrLFs69T5
         6ouM8Pc5z17GK3Xqpt2YS4sBLL4EA7CNpe6zvWeYD5/zYquW43j4DN3d6OLB4vsunBcc
         SDsz62tb+O8OLYK/58FyrpJFDNWgpCCB4EN+kX3yGmRMQeqRVV+3rxme7+AqAdSd2234
         aEizxiWedrGH4Yq7sAcJoRn2MPv7Ajc9KAmWBx15fksLDgqNEr/q4LmSiS69c+syHx58
         /TptRIC0de5WpMyR+tKHhbfdxksfLjSgZRH0CiQWa60qzcMUEAeKX6MOLbBrFGb91RLL
         tAhA==
X-Gm-Message-State: AOJu0YzOIy3ByU4tTtPWdqCE1gPSMWF0frDYZ1tNkuj9TNYQ1o0YAylx
	0yjaAnmcx55SawKCeu2vxtEpKLzTofgPoJp798QiimXBUseKVcDA6zur
X-Gm-Gg: ASbGncvUe1PIg2Q9m2bRkaJu28asmPY1njnOX7oGTF4GkwE0PTeIZswYFgYpjlmb/0F
	4Yo5zYgXE6wgGQCcKBnUxLSAWradngY0qmT3owMTwt8A9W61/aIEBhRnPzZBxkSJiW6rLPgGnRs
	WiPfTbxgwhNxIRChd/dJKx+nRhS1r6mo6iJcK2ftDapREYy2FAiVRD2aa7ynKAuV/vRnmptL5qp
	z4wqd0pamEWNh9cwGHUmcJmaeu0S2zuC7dn0ZmGcaBIRPvpsNjyMjLXck/KFK0LuoxiEKl8mjKp
	bQM5rF1qIAEF+gbFv9FaLvqBpRzsEjbvt7sBB7D0LkSwDMpF1Bq0ilwNykOrq8IcdjjLM8Khlvx
	XM7Dw5XJYpBkG6SY2EAf7wkIU58ppAkBMebsBKfep30xEKHNw86p3RdKktjcCpmu9fllNHMFDGD
	O5gQsRPWhfINE6a5SH19SJQwkhDr90FhwrdVcItlJiVh1h
X-Google-Smtp-Source: AGHT+IFUCW9s6DyXeMDerEXVQ99uM+N77KRt+sSmtrMBGS8lUWe+ho+OTxm52vaB26Y1jocL9ATNkA==
X-Received: by 2002:a17:903:3d0e:b0:29b:6750:c65f with SMTP id d9443c01a7336-29b6be8c8b0mr39068225ad.10.1763743255302;
        Fri, 21 Nov 2025 08:40:55 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b15b851sm60558615ad.43.2025.11.21.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:40:54 -0800 (PST)
Subject: [net-next PATCH v5 9/9] fbnic: Replace use of internal PCS w/
 Designware XPCS
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:40:52 -0800
Message-ID: 
 <176374325295.959489.14521115864034905277.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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

As we have exposed the PCS registers via the SWMII we can now start looking
at connecting the XPCS driver to those registers and let it mange the PCS
instead of us doing it directly from the fbnic driver.

For now this just gets us the ability to detect link. The hope is in the
future to add some of the vendor specific registers to begin enabling XPCS
configuration of the interface.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/Kconfig               |    1 
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c  |    7 --
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h  |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |  104 +++++++++++------------
 5 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index dff51f23d295..ca5c7ac2a5bc 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -26,6 +26,7 @@ config FBNIC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DEVLINK
 	select PAGE_POOL
+	select PCS_XPCS
 	select PHYLINK
 	select PLDMFW
 	help
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 9b068b82f30a..02e8b0b257fe 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -133,7 +133,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 
 	/* Record link down events */
 	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
-		phylink_pcs_change(&fbn->phylink_pcs, false);
+		phylink_pcs_change(fbn->pcs, false);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 65318a5b466e..81c9d5c9a4b2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -697,10 +697,7 @@ void fbnic_reset_queues(struct fbnic_net *fbn,
  **/
 void fbnic_netdev_free(struct fbnic_dev *fbd)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
-
-	if (fbn->phylink)
-		phylink_destroy(fbn->phylink);
+	fbnic_phylink_destroy(fbd->netdev);
 
 	free_netdev(fbd->netdev);
 	fbd->netdev = NULL;
@@ -802,7 +799,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 
 	netif_tx_stop_all_queues(netdev);
 
-	if (fbnic_phylink_init(netdev)) {
+	if (fbnic_phylink_create(netdev)) {
 		fbnic_netdev_free(fbd);
 		return NULL;
 	}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index deab789b2a6c..9129a658f8fa 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -44,7 +44,7 @@ struct fbnic_net {
 
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
-	struct phylink_pcs phylink_pcs;
+	struct phylink_pcs *pcs;
 
 	u8 aui;
 	u8 fec;
@@ -108,6 +108,8 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 					struct ethtool_link_ksettings *cmd);
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
+int fbnic_phylink_create(struct net_device *netdev);
+void fbnic_phylink_destroy(struct net_device *netdev);
 int fbnic_phylink_init(struct net_device *netdev);
 void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 20f88c8dcc79..09c5225111be 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 
@@ -101,56 +102,6 @@ int fbnic_phylink_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
-static struct fbnic_net *
-fbnic_pcs_to_net(struct phylink_pcs *pcs)
-{
-	return container_of(pcs, struct fbnic_net, phylink_pcs);
-}
-
-static void
-fbnic_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
-			    struct phylink_link_state *state)
-{
-	struct fbnic_net *fbn = fbnic_pcs_to_net(pcs);
-	struct fbnic_dev *fbd = fbn->fbd;
-
-	switch (fbn->aui) {
-	case FBNIC_AUI_25GAUI:
-		state->speed = SPEED_25000;
-		break;
-	case FBNIC_AUI_LAUI2:
-	case FBNIC_AUI_50GAUI1:
-		state->speed = SPEED_50000;
-		break;
-	case FBNIC_AUI_100GAUI2:
-		state->speed = SPEED_100000;
-		break;
-	default:
-		state->link = 0;
-		return;
-	}
-
-	state->duplex = DUPLEX_FULL;
-
-	state->link = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) &&
-		      (rd32(fbd, FBNIC_PCS(MDIO_STAT1, 0)) &
-		       MDIO_STAT1_LSTATUS);
-}
-
-static int
-fbnic_phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
-			 phy_interface_t interface,
-			 const unsigned long *advertising,
-			 bool permit_pause_to_mac)
-{
-	return 0;
-}
-
-static const struct phylink_pcs_ops fbnic_phylink_pcs_ops = {
-	.pcs_config = fbnic_phylink_pcs_config,
-	.pcs_get_state = fbnic_phylink_pcs_get_state,
-};
-
 static struct phylink_pcs *
 fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 			     phy_interface_t interface)
@@ -158,7 +109,7 @@ fbnic_phylink_mac_select_pcs(struct phylink_config *config,
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct fbnic_net *fbn = netdev_priv(netdev);
 
-	return &fbn->phylink_pcs;
+	return fbn->pcs;
 }
 
 static int
@@ -232,13 +183,33 @@ static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
 	.mac_link_up = fbnic_phylink_mac_link_up,
 };
 
-int fbnic_phylink_init(struct net_device *netdev)
+/**
+ * fbnic_phylink_create - Phylink device creation
+ * @netdev: Network Device struct to attach phylink device
+ *
+ * Initialize and attach a phylink instance to the device. The phylink
+ * device will make use of the netdev struct to track carrier and will
+ * eventually be used to expose the current state of the MAC and PCS
+ * setup.
+ *
+ * Return: 0 on success, negative on failure
+ **/
+int fbnic_phylink_create(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_dev *fbd = fbn->fbd;
+	struct phylink_pcs *pcs;
 	struct phylink *phylink;
+	int err;
+
+	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
+	if (IS_ERR(pcs)) {
+		err = PTR_ERR(pcs);
+		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);
+		return err;
+	}
 
-	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;
+	fbn->pcs = pcs;
 
 	fbn->phylink_config.dev = &netdev->dev;
 	fbn->phylink_config.type = PHYLINK_NETDEV;
@@ -261,14 +232,35 @@ int fbnic_phylink_init(struct net_device *netdev)
 	phylink = phylink_create(&fbn->phylink_config, NULL,
 				 fbnic_phylink_select_interface(fbn->aui),
 				 &fbnic_phylink_mac_ops);
-	if (IS_ERR(phylink))
-		return PTR_ERR(phylink);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		dev_err(netdev->dev.parent,
+			"Failed to create Phylink interface, err: %d\n", err);
+		xpcs_destroy_pcs(pcs);
+		return err;
+	}
 
 	fbn->phylink = phylink;
 
 	return 0;
 }
 
+/**
+ * fbnic_phylink_destroy - Teardown phylink related interfaces
+ * @netdev: Network Device struct containing phylink device
+ *
+ * Detach and free resources related to phylink interface.
+ **/
+void fbnic_phylink_destroy(struct net_device *netdev)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (fbn->phylink)
+		phylink_destroy(fbn->phylink);
+	if (fbn->pcs)
+		xpcs_destroy_pcs(fbn->pcs);
+}
+
 /**
  * fbnic_phylink_pmd_training_complete_notify - PMD training complete notifier
  * @netdev: Netdev struct phylink device attached to
@@ -315,5 +307,5 @@ void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev)
 		    FBNIC_PMD_SEND_DATA) != FBNIC_PMD_LINK_READY)
 		return;
 
-	phylink_pcs_change(&fbn->phylink_pcs, false);
+	phylink_pcs_change(fbn->pcs, false);
 }



