Return-Path: <netdev+bounces-199260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C463ADF937
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9380D5621AD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A427E1B1;
	Wed, 18 Jun 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+g0qva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08F27E04A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284480; cv=none; b=oM8wrSUzUcdOC5ysmRFQ5UBVm9Z0ykEMj9O2usGc+2J5X3kMD/qa2yiuttYMUjCMPxM+9a9pnby6KO4IL3E/PA4VSKWy5x/HLnV+lcsL2asLWV85EyJlU+PL1U9zuFEC9rxmmWcOPD+ZbUnVIjA9qF8w8PIBtY29iJmcLQIsrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284480; c=relaxed/simple;
	bh=BxT2XQr36XOy3MCCiR3sj6Mts2IYPdP6vyLboaNfUh8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+/W1g5dRp4Wv14d5rxg3AFDTBQY0CBl3tmg6mzYyjYEMGFBkfQWaJzupgDK091ZNRDSgoSjGXehzLAgp9qrCXC4rx4a6NSq6BGMX8gKceLEa8CmsRWXnseG1Kemgo+rQ3hT5AlxJnPiPi9OCa/4vd8xkNeVwCKe1LKZ+u0Jo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl+g0qva; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2363616a1a6so1326255ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284478; x=1750889278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVJF5+xo5fOy5dQ0BNtdaMLHtgwZ7O1Nqt+5vJFhnMI=;
        b=Wl+g0qva4syCCf7LJ53NArcKyffRp9gapeKA81yaAXVBaQi6wek3NqIqYT2+2bxden
         4FErzNK4l1Ot20JzqAE81Q6whRQmoTsNWbqyK+7ioDdNatVhw1GgKS28408bUuibkb7h
         VqzlOQ2sEi7htRdjggNaqygguOOUmNnZrNI62KH2bE1ZzJsanfOg6w9NK3r7Ibf8uvxK
         XXY2jGUO4yC4Tyb8kqSWp+pRxQB3B2eiKhExJTNy2kElxoGHrWl7/PEl6UPPcjmKmtAr
         189KdPx7XkiBC7JPhNchD6EiGyqMhZcSui19uo7IAeRqhJU4DAzVmSZDR8kPfr0Gfyjz
         qjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284478; x=1750889278;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVJF5+xo5fOy5dQ0BNtdaMLHtgwZ7O1Nqt+5vJFhnMI=;
        b=hmRrygLSGT1DMHI+5WvFSrvHqOKwQQkvCtxWqAhIeNRuBOI/oyn9S7Ja6qYNlO9tAf
         /LTnexw7edSyLMltgXnCiRLiCCLmzwiywkjSxBgIGszbfxNpy5sjwJjeT59cf4l5UzmG
         oiz3tuk6LNmyLeJHtMsoTydulHwAJJz0Kn0d0Yza58n1YGZSMm7DvngaZ+omCC8deUE0
         xOPl6ekWbuhV/ZT1WKOCnja0n7W6fUJ5XYKB2TNsUvUoMOCwY4odtlNqIIBahFwMU2ic
         fP+zclLNP7MIgWN84w+1dKxIU93zsaDvvU4rF6MLrGjKIMdaZF5B6aXceEU9CDGZheqe
         veQw==
X-Gm-Message-State: AOJu0Ywrj/Ff/LdYgRaMIfC57bGKWDhzvsUzvpMUvCVvY22K7dbg14GL
	Dlo1/KvrtQ1IVVK5b94ifNBpcmy/sDCKAq+w4UZ5UEKWbu2CRhh7xC1Xk/X3wQ==
X-Gm-Gg: ASbGncsS+4dhVB+DHyfApJzhSPXklRQxNpiVberdyj75X2FWGvK7/+QGnk0qm2nAprn
	o9T3GEXsqsScExCuOggz0gTnwdHmiUxmRSIbChFQvLya6ZivuZMUWLa87K9iWJP+wxQz8mBi8DK
	8o9vVm+mLvKQ8McL/Os5MbgkFD4LTCELNsr7d+kd2igEJMHlkg+zb/eH8UADSRbRstaEINXt6FM
	IM/+IieOSU3L8vakrr9sw1vzqpVuJSWQopx6T0ahF9bMJhn7JtHEIFDuDEEtHZkewXWly3zi2VF
	uIZ2nH5i4FOFln83/7o8ZPURxfCTQ4eChAAAlc/6z8badtXDP6z80dYBTLDHJNSFaE70lWJEvgg
	vFCAxUS/CI3copQrRArjYKZNL
X-Google-Smtp-Source: AGHT+IHRRTaX0QI1r/CMOh9zZoMS4JTk7SGAUIlcVTra/yzAUMR4tWeZmtAfGcjsJSv/phPS0Rs8Kg==
X-Received: by 2002:a17:902:f690:b0:22d:b243:2fee with SMTP id d9443c01a7336-2366b005d10mr250847455ad.13.1750284477561;
        Wed, 18 Jun 2025 15:07:57 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.35.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bf24sm106560425ad.38.2025.06.18.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:07:57 -0700 (PDT)
Subject: [net-next PATCH v3 6/8] fbnic: Set correct supported modes and speeds
 based on FW setting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Wed, 18 Jun 2025 15:07:55 -0700
Message-ID: 
 <175028447568.625704.17971496887030109107.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
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

The fbnic driver was using the XLGMII link mode to enable phylink, however
that mode wasn't the correct one to use as the NIC doesn't actually use
XLGMII, it is using a combinations of 25G, 50G, and 100G interface modes
and configuring those via pins exposed on the PCS, MAC, and PHY interfaces.
To more accurately reflect that we should drop the uxe of XGMII and XLGMII
and instead use the correct interface types.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |    7 +----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   32 +++++++++++++++++++----
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 284fcfbedb74..5ff45463f9d2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -540,7 +540,7 @@ static bool fbnic_pcs_get_link_asic(struct fbnic_dev *fbd)
 	return link;
 }
 
-static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
+void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 {
 	/* Retrieve default speed from FW */
 	switch (fbd->fw_cap.link_speed) {
@@ -580,15 +580,10 @@ static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 
 static int fbnic_pcs_enable_asic(struct fbnic_dev *fbd)
 {
-	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
-
 	/* Mask and clear the PCS interrupt, will be enabled by link handler */
 	wr32(fbd, FBNIC_SIG_PCS_INTR_MASK, ~0);
 	wr32(fbd, FBNIC_SIG_PCS_INTR_STS, ~0);
 
-	/* Pull in settings from FW */
-	fbnic_mac_get_fw_settings(fbd, &fbn->aui, &fbn->fec);
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 151d785116cb..86fa06da2b3e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -93,4 +93,5 @@ struct fbnic_mac {
 };
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
+void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec);
 #endif /* _FBNIC_MAC_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index edd8738c981a..a693a9f4d5fd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -8,6 +8,22 @@
 #include "fbnic_mac.h"
 #include "fbnic_netdev.h"
 
+static phy_interface_t fbnic_phylink_select_interface(u8 aui)
+{
+	switch (aui) {
+	case FBNIC_AUI_100GAUI2:
+		return PHY_INTERFACE_MODE_100GBASEP;
+	case FBNIC_AUI_50GAUI1:
+		return PHY_INTERFACE_MODE_50GBASER;
+	case FBNIC_AUI_LAUI2:
+		return PHY_INTERFACE_MODE_LAUI;
+	case FBNIC_AUI_25GAUI:
+		return PHY_INTERFACE_MODE_25GBASER;
+	}
+
+	return PHY_INTERFACE_MODE_NA;
+}
+
 static struct fbnic_net *
 fbnic_pcs_to_net(struct phylink_pcs *pcs)
 {
@@ -128,6 +144,7 @@ static const struct phylink_mac_ops fbnic_phylink_mac_ops = {
 int fbnic_phylink_init(struct net_device *netdev)
 {
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
 	struct phylink *phylink;
 
 	fbn->phylink_pcs.ops = &fbnic_phylink_pcs_ops;
@@ -135,18 +152,23 @@ int fbnic_phylink_init(struct net_device *netdev)
 	fbn->phylink_config.dev = &netdev->dev;
 	fbn->phylink_config.type = PHYLINK_NETDEV;
 	fbn->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
-					       MAC_10000FD | MAC_25000FD |
-					       MAC_40000FD | MAC_50000FD |
+					       MAC_25000FD | MAC_50000FD |
 					       MAC_100000FD;
 	fbn->phylink_config.default_an_inband = true;
 
-	__set_bit(PHY_INTERFACE_MODE_XGMII,
+	__set_bit(PHY_INTERFACE_MODE_100GBASEP,
 		  fbn->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_XLGMII,
+	__set_bit(PHY_INTERFACE_MODE_50GBASER,
 		  fbn->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_LAUI,
+		  fbn->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_25GBASER,
+		  fbn->phylink_config.supported_interfaces);
+
+	fbnic_mac_get_fw_settings(fbd, &fbn->aui, &fbn->fec);
 
 	phylink = phylink_create(&fbn->phylink_config, NULL,
-				 PHY_INTERFACE_MODE_XLGMII,
+				 fbnic_phylink_select_interface(fbn->aui),
 				 &fbnic_phylink_mac_ops);
 	if (IS_ERR(phylink))
 		return PTR_ERR(phylink);



