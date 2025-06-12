Return-Path: <netdev+bounces-197011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D30AD7546
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387217A5AE7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354F26E719;
	Thu, 12 Jun 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckoy1bBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA34271454
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740931; cv=none; b=MFQywQAst9UxYhDHXZT6kLfMPs9dUJnHByVjj3qWIOzTDfo4SFlAr7c0qL+T9dprVOmbciC0+7exEUFZLjinRCO37YKVDTk1IALdfY5qhsb0C4TXctnkvCga1Ixs9NGTuyStrUecr7lbSB9btegaPed8Ri9Byc263n70/jIgf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740931; c=relaxed/simple;
	bh=AO7gOmLFlnb3weCzYCnYLpYDoCrhoVL2yw+P4iuYwZY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX8RpL76buYNvIJKKu1PQyt7ldDFdTySo0dzgxkgj7YdYoEknwWWmr/AgHFR7v24p/JzuDfR5w+gzZHlcMrFhX6w2zhtcOvcgTqeclzzPXgS8E4ebWVmkW8oioQi/lNjhyUG603XuFiKdr5dvewittKkq2QFMrbeEiiopv4GM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckoy1bBX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso1428384b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749740929; x=1750345729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCBf6hLaudME/ncqn5QF+BKKakCsqiJKqA7HRAeOX7A=;
        b=Ckoy1bBXW+tfudKD6aFRtBgyF0VDblfGD9OeGGUyHwbAHjMMxKkLilFgd77R8bucpH
         M4gGik9CGDxvCgf0cj4rZA87NKoctQMPTW37765VDuVApV7G9qAegekC/i/ln/sYr33s
         os1cXkHQYClA0ViCUXSUwpfNBySkX8UWLoWHEDeu6PG5+zUlINez8ncWEcWUFxqOpfiw
         CT2RCHea1cfONGdiBEPzU1ap+PiOgfLdJ+Fkyb657aBk1LLc7wskZt4ngSKpRk9LQyE2
         MAMkvj5FydQrG2lrARMy24BrY/+k6ta2Ra8wok0e5DL1tZUyo35iWKrmrpRPVld3kOTW
         NMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749740929; x=1750345729;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCBf6hLaudME/ncqn5QF+BKKakCsqiJKqA7HRAeOX7A=;
        b=wOqqQyE973KmLWu2ggmBB5AhrcsK96q6FEz5sskR5gPMwxaq31ttuuYVr5bL/fWBrJ
         3Q6w+fzGXR1Vukw1l5BqYp4LBFgYH67F0iq0X4Pm3W/CBVrUCz82NTAFNEU0zlpEfP4s
         6BwM7yGZysPW7WqBjPKBsYGjlGysXA4y+hOBhsY0L0KbQTkfj2rVj9nG6CPepM02ec/f
         ntdHuyT2GwPfeC8c/bPUlfyUrKwzF1CO/ZKFjZ81gzeMcZOz+0v1nu5kVKsJdzLt2/tn
         Rg/UbSDz3GwudUbRIKm7pz242K3Bnj5uYXTr3XQfelSl4bu7YVV3sh10C/DTCQnh26S3
         73Bg==
X-Gm-Message-State: AOJu0YxqeMpXiIMUfOuCQTfYtDF95XbwwicG17nNg/aIkAekMJMTy/zJ
	TOKmxy9x0+AeGyyyTXz2LFB5e42uNHVGkdU1B5VEEFjvV6V1tawxMr/QNKs2Xw==
X-Gm-Gg: ASbGncuh9OBSubE9AD0trbRrqNg82Ghh7ZhGSLK9u0Z6FUoTf9sEZzmETYei76KO0Yb
	Q1ARpmwYWmOOuaIW1kHYE9z1t/Y3qiyq4JTW2/RZ5JRljEphG+xIjUyrYibKS2bHxTndgRab8gc
	RNRNG7Lhbf/OAEp4IJqupglGiWwcL23hXPqPLHAJ4xBEn32rklbDeEW/oY41jH5l0+1qJnPBrwX
	YeLgxf16r2O+fVGJ/mqlD/m1OZqnPUN7un+XIFHHzeBBz/QyAbLX4WXGceC9h7v2S4dkOgQxZOx
	cgallSeEjQdc1hQeE604e5lQq7Cu89ydv4wfX09ll7POnLWUwpkO5gJ43zmgSnshA9/ZmQdhVeT
	k3TP7azBtJwykYWU=
X-Google-Smtp-Source: AGHT+IHdE1LvvJIQjoysUHduBBnt1ktguyuEG8ZhL6hBkTR2m8GzL4bgi5y23chgwc90BbGY+5z/7g==
X-Received: by 2002:a05:6a00:2d1e:b0:748:33f3:8da8 with SMTP id d2e1a72fcca58-7487c209347mr4432684b3a.5.1749740928798;
        Thu, 12 Jun 2025 08:08:48 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.39.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880a0bcd4sm1605423b3a.149.2025.06.12.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:08:48 -0700 (PDT)
Subject: [net-next PATCH v2 4/6] fbnic: Set correct supported modes and speeds
 based on FW setting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
 kernel-team@meta.com, edumazet@google.com
Date: Thu, 12 Jun 2025 08:08:47 -0700
Message-ID: 
 <174974092733.3327565.16398491313519496047.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
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
index 0219675d0a71..32be1cf849b8 100644
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
@@ -578,15 +578,10 @@ static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)
 
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
index f228b12144be..f0a238ece3f5 100644
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



