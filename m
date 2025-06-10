Return-Path: <netdev+bounces-196153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF7AD3BB4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2571D18887FB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4FE218593;
	Tue, 10 Jun 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIA1Z4Fc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91921171F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567099; cv=none; b=VgPevCdMw096oaZSnKgkSTDFnRp47n29vve0Y1uAtqsE6FwipGIisDOoSS0P4b1W0XxIG3Y91dkLpI8zIQLOYEKuWm2KDLrqe0Tl7u9Nxy09sKoCvKQ+9bEuYlVPDiQLHHcRtJmzqBLFbw9qeUqJ3fSkdQfiwd7DUhvet/4Cm5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567099; c=relaxed/simple;
	bh=k2bQWiAqRQmt16wJJPiacwt8NnNX/6x+COlM42kgelM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cissT8KPaVHmCpxTZU2jybXIYDcfkysopDe1OVRtdOPo+K2lcjaeKFA82sCrur3AhXqWHn2EfyVkf4nJJa4PX0CoZgf9XR35/4oQVdJHLxWEGQbzTku77vACdFZv5+gm0jKwm6JDquxuelSWmzhR75T++s7IH+l63RP5bVXraWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIA1Z4Fc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c3d06de3so6359660b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567096; x=1750171896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y9WFETwbztspWE8wwaGprzEOcxTxDTX3vBqM/1DVUI=;
        b=nIA1Z4FcsBooHTWz+7722PeC7SWNLpE8FS38DPADZYdWW8c0oj1xH3szTE7cDbFxqW
         We5gcD3g7ouoizqIotBMH3rpK+YMpu8aMRABLmrj7fm2N3pXrMYTor3OyPSRHzv1na9b
         Ues5c41kSvkDPmpQ+Bmu5m11P7TeQWPkfeHXIWDVKCVS0hM1w+rWAz1IuECkpEy4tXnV
         pdCHwKxdblC7Dh9FtFJH2OM1iXhshfd9jtDYehlPgCEArUSmUuniaqhSJmnG+tb1ONuC
         EoljmEWOhpOsM7DN+cuUPsX2HmT448+hhVzYdrc4N+wvr/Oz5nH+aIsZQuZjvtopiJ9e
         kSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567096; x=1750171896;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y9WFETwbztspWE8wwaGprzEOcxTxDTX3vBqM/1DVUI=;
        b=pfDbeiQ2/w6bRCOfTrLBmW07tD6fIxG/k0fmo4HVfBrbYXQLHnJ1emJA5ICXOaQuhD
         HAlepY0WT84Akg7wtT11aI7L5It3Mvabvl/atrby+CkIPnHuyBXIE2QEhi6sSi3yGrRD
         FRXR8ON2CnHB+EWtm0duse1ljc4NnpsPo9XhxCwZNB4cbN3anMiBDf1GJv/qR8iHmQGZ
         j8cV2psIGadMPj3PgUzs27d9jK7YOV1AcC56bbMiISiqr6LYLHu+cvK898Qu76qd3KJF
         dU7c0l+Xx8WhSK9xoeElPwnp4GzIgl2aXbGGsGgO0YRZfKzpKWy7rjDfCzDFT5GS0hFL
         zkZA==
X-Gm-Message-State: AOJu0YxHRMDC5vxtjwCH7zpGVPah9IIHWB+PE/DaIleXY/Ego3sR1brM
	t4xDEk4iQk1VhkBxt2i0J8YvI+Lx71f9ZapOaUbU6BFfXojcF/f4/3kyD7er9g==
X-Gm-Gg: ASbGncvnWTxn6YiBsWwpHXAOAzoLzKqWvehgyWKnS3Am26K14P49jky5l3CAzmZqF9H
	w5VLViOM0/QdBU0VpXOyYZ+aoJE/5qveTdZbtbGJRTj8g8on78oYddRpEzpQ6uapac3wd+wDqcS
	xpvIAsuy1VpTFxCqgfLhezHS8BjAI0W31lWB8VgGElR8GPkLoYIz2Or1/xc/+4SHuFB9As2dktQ
	bn9UV8Ev5kds1UcOPCz4uMidUQDlDoNxc6zbLwQRwex/5Q279tqp7f2kF4dZu8LHhNwrA1veeyo
	3pTdszVUUGernQuLXLQh6K+AY7C4++Nhh5O8PEkgFZNIcaU2O8yMCUWMtdn/fQLBqP1S+5CWxV2
	RCzbsQwxUQHcZww==
X-Google-Smtp-Source: AGHT+IFQ+5e8k/HyDT15KEMfy8+c1YUdNcDdqLq1M5UKJb9LLOu6ebhrMYsw3vkUvoS67fqnRS/u+Q==
X-Received: by 2002:a05:6a00:855:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-74827e52592mr22772525b3a.2.1749567096035;
        Tue, 10 Jun 2025 07:51:36 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7b606sm7786182b3a.67.2025.06.10.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:51:35 -0700 (PDT)
Subject: [net-next PATCH 4/6] fbnic: Set correct supported modes and speeds
 based on FW setting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Date: Tue, 10 Jun 2025 07:51:34 -0700
Message-ID: 
 <174956709473.2686723.14072421385071568018.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |   32 +++++++++++++++++++----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 19159885b28e..32be1cf849b8 100644
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



