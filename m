Return-Path: <netdev+bounces-292002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNFEDmU2FmrrjAcAu9opvQ
	(envelope-from <netdev+bounces-292002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:10:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5675DDDE6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBDF0303FFEE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE929BDB1;
	Wed, 27 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUJQfWF4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6927057D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840607; cv=none; b=jPDOdeg3n82HdtEQT1eswdQTvZ2A5kapdhgKSQPB7H+E1DxJ1pn3vd/4q1cDbLZFblLepqOmnX7K6G75dT6yxA5BHT7zxsWdq1lG2EGMw+MB6iHgxNP0V7j0EYsyyWCSI1dKNuz9X79brw/MJeAJlUHLSp4un/OF+7PosMIKD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840607; c=relaxed/simple;
	bh=83HXOB5C+y710z7LBWDFkSqsXErHX9dcdgz6SKoYq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM59DYd4uDuFNNQrXCjKXqCOHzAM1AHIcwcc06mXrPfozjSgXdQmfmMWzpxaJCCDtnB1dIpVJZ6vRKLtFBM4knM/3hj50viVaHNBt+duE20+rwAkc9ZdSrdZYxsvFRaVopPA6/x5xeEg/ckD8TjGJjXJM3HoQfzw4URhTDbyg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUJQfWF4; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-911796e9885so987340385a.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779840602; x=1780445402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp5j/n0cvOeBIVPinOKHA637ZSRit4YvVz4OGICE4DE=;
        b=qUJQfWF4B0A1cA47kvzsEVltQIc3CmXeKlkSrazpTzug9PIfCRSFux3xxh4zKIXb7O
         sQiiHVpwYO8cpEz+ct3+KdVW0k7ikEx0OiWqsAtg56fP+1m5oMIGkOvuOsQ+xHUipKFU
         l6lTLM1Ah4lzDYSS8PbI6R09uH/CeFYeWIB7iOdqxuQZ1azx7jPv2+whknekA26TEiaO
         Vo/tA6iT1XP6edI1L+6Mfbv25eB9REbbbhmh4wpIv0oP2Q8DqqvOi6Wjo1qQ4Y2kXZHu
         n1rDWfmqrv08QfHcvhHx/kdobuxGgKum3ULG6NOEI50iXsMOwwt1FVzr3QxZMMsZOKA1
         5EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779840602; x=1780445402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zp5j/n0cvOeBIVPinOKHA637ZSRit4YvVz4OGICE4DE=;
        b=FcPdrgDuxvnj2X7q9GkvxH1nQn+U7b46+zW8mrg7z9sR7Aq3bKtbmBwNIMkWiJenht
         nXAlGCIojVzeINRtWRSjqPsZWkgSEh2eh6prpK7mFcnzdBsVBF4z5Q1sXLCS5K705l6l
         mV/s3zMtlWJYPWLhegskW3nWhwBJpzOmBTX6pOYBb+kb5lRmJ8MtGfkl/o31/EWbTZT7
         jPJgyU6tMW8coShxJaQJfAwhQytmZM9OKrCDl8GsNWDlOM6a06R0wyPG/PzML6Y4HM17
         YTmNEyUMLPr5F2hfWuXoqUQRcVCmq+d6CrTrEqKibqoLPP6MQxFD6A8T/q44QTkk8XlW
         wMGw==
X-Forwarded-Encrypted: i=1; AFNElJ91xMPjhLElmgqaXTC/ePw7Y0hTDLiNJ9GNjsweCfH98uTBY2RzWK2/quI4KUdT4tYffoLX6nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgj+gHiGgPcsD0ljl8FtXCmwbSxg0VSQ7rC7KmLfU/+CBO8C6f
	gCOPgmQCIAgfY4rQBqmyMoXRSR1H13sQWMPYELuHNwKSxNlwY0iWt4Oa
X-Gm-Gg: Acq92OENN07/VauRitMywP4YPVtPMjOThHVUbcPSzrx92gmGKkO14Pn2iTZdmk0gDkK
	PFhSP2v5Q7qAxIHDoXjthS3XW/D1oaL4My9UeA5MK3q4djlYmY+O75TX0yNcPfUZB+ZEMRCIZZ6
	3rPHzDiuzAJfR4eZCHZ/8HAjfvRCjIMg3RbcCjd/9nRzLXe2MDiV+8eXEpq2FP0y7ZVHw/J1AcD
	gfmdex1juZCeDy96MpDlYAS+uzT6LngFnoZeIxPWcVhgPtcV1VF1Isa+BWxzYfb9XeuYKRJia7X
	/13VsRFREU5+J63KSC77yBvbthjfRPVpW1h4epBo2hsfUEJI9FusbVaV/zek9O2K1AnJqkiFIOk
	3+ItP7CyKU84YvvRP3OP++qea+7HLM22KrYVfDH5/3qZLa4UrhpH4YS7oQfSQ4hQ8QZEaoaUzUb
	bSN+rmStqG+JfLU6hf+WZZA5+NPwZpj2fDmNSX0i5q0+RFFqtuN22/ixDyUIa4SZ/W1ko=
X-Received: by 2002:a05:620a:3186:b0:8ed:6ac5:bac7 with SMTP id af79cd13be357-914b50457aemr2413458385a.10.1779840601568;
        Tue, 26 May 2026 17:10:01 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm363803585a.35.2026.05.26.17.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:10:01 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: pcs: xpcs: Expand mdiodev member as an array
Date: Tue, 26 May 2026 20:09:55 -0400
Message-ID: <20260527000958.81108-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
References: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292002-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,trustnetic.com,net-swift.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 8F5675DDDE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This allows for support of 50GR2 and 100GR2 by extending the
current singleton mdiodev to an array.

DW XPCS can support 25GR1 and 50GR1 using just a single group
channel.   To operate at 50R2 or 100R2 we need both halves
of the channel combined into one group channel device.

Adjust current use of singleton mdiodev to use the 0th element.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - new to series
  - Added DW XPCS details to commit message
  - change mdiodev to an array in dw_xpcs
  - adjust singleton use case to use mdiodev[0]

 drivers/net/pcs/pcs-xpcs-wx.c |  4 ++--
 drivers/net/pcs/pcs-xpcs.c    | 42 +++++++++++++++++------------------
 drivers/net/pcs/pcs-xpcs.h    |  5 ++++-
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index fc52f7aa5f59..38c980f974b4 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -123,7 +123,7 @@ static int txgbe_pcs_poll_power_up(struct dw_xpcs *xpcs)
 				10000, 1000000, false,
 				xpcs, DW_VR_XS_PCS_DIG_STS);
 	if (ret < 0)
-		dev_err(&xpcs->mdiodev->dev, "xpcs power-up timeout\n");
+		dev_err(&xpcs->mdiodev[0]->dev, "xpcs power-up timeout\n");
 
 	return ret;
 }
@@ -139,7 +139,7 @@ static int txgbe_pma_init_done(struct dw_xpcs *xpcs)
 				100000, 10000000, false,
 				xpcs, DW_VR_XS_PCS_DIG_CTRL1);
 	if (ret < 0)
-		dev_err(&xpcs->mdiodev->dev, "xpcs pma initialization timeout\n");
+		dev_err(&xpcs->mdiodev[0]->dev, "xpcs pma initialization timeout\n");
 
 	return ret;
 }
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8..3c11c9552b60 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -211,23 +211,23 @@ static bool __xpcs_linkmode_supported(const struct dw_xpcs_compat *compat,
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
 {
-	return mdiodev_c45_read(xpcs->mdiodev, dev, reg);
+	return mdiodev_c45_read(xpcs->mdiodev[0], dev, reg);
 }
 
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 {
-	return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
+	return mdiodev_c45_write(xpcs->mdiodev[0], dev, reg, val);
 }
 
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
 {
-	return mdiodev_c45_modify(xpcs->mdiodev, dev, reg, mask, set);
+	return mdiodev_c45_modify(xpcs->mdiodev[0], dev, reg, mask, set);
 }
 
 static int xpcs_modify_changed(struct dw_xpcs *xpcs, int dev, u32 reg,
 			       u16 mask, u16 set)
 {
-	return mdiodev_c45_modify_changed(xpcs->mdiodev, dev, reg, mask, set);
+	return mdiodev_c45_modify_changed(xpcs->mdiodev[0], dev, reg, mask, set);
 }
 
 static int xpcs_read_vendor(struct dw_xpcs *xpcs, int dev, u32 reg)
@@ -304,7 +304,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 #define xpcs_warn(__xpcs, __state, __args...) \
 ({ \
 	if ((__state)->link) \
-		dev_warn(&(__xpcs)->mdiodev->dev, ##__args); \
+		dev_warn(&(__xpcs)->mdiodev[0]->dev, ##__args); \
 })
 
 static int xpcs_read_fault_c73(struct dw_xpcs *xpcs,
@@ -400,7 +400,7 @@ static void xpcs_link_up_usxgmii(struct dw_xpcs *xpcs, int speed)
 	return;
 
 out:
-	dev_err(&xpcs->mdiodev->dev, "%s: XPCS access returned %pe\n",
+	dev_err(&xpcs->mdiodev[0]->dev, "%s: XPCS access returned %pe\n",
 		__func__, ERR_PTR(ret));
 }
 
@@ -726,7 +726,7 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 
 	ret = xpcs_switch_interface_mode(xpcs, interface);
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "switch interface failed: %pe\n",
 			ERR_PTR(ret));
 
 	if (!xpcs->need_reset)
@@ -734,14 +734,14 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 
 	compat = xpcs_find_compat(xpcs, interface);
 	if (!compat) {
-		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "unsupported interface %s\n",
 			phy_modes(interface));
 		return;
 	}
 
 	ret = xpcs_soft_reset(xpcs, compat);
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "soft reset failed: %pe\n",
 			ERR_PTR(ret));
 
 	xpcs->need_reset = false;
@@ -1189,30 +1189,30 @@ static void xpcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	switch (compat->an_mode) {
 	case DW_10GBASER:
-		phylink_mii_c45_pcs_get_state(xpcs->mdiodev, state);
+		phylink_mii_c45_pcs_get_state(xpcs->mdiodev[0], state);
 		break;
 	case DW_AN_C73:
 		ret = xpcs_get_state_c73(xpcs, state, compat);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c73", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_SGMII:
 		ret = xpcs_get_state_c37_sgmii(xpcs, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_1000BASEX:
 		ret = xpcs_get_state_c37_1000basex(xpcs, neg_mode, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_1000basex", ERR_PTR(ret));
 		break;
 	case DW_2500BASEX:
 		ret = xpcs_get_state_2500basex(xpcs, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_2500basex", ERR_PTR(ret));
 		break;
 	default:
@@ -1232,14 +1232,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
 		if (speed != SPEED_1000) {
-			dev_err(&xpcs->mdiodev->dev,
+			dev_err(&xpcs->mdiodev[0]->dev,
 				"%s: speed %dMbps not supported\n",
 				__func__, speed);
 			return;
 		}
 
 		if (duplex != DUPLEX_FULL)
-			dev_err(&xpcs->mdiodev->dev,
+			dev_err(&xpcs->mdiodev[0]->dev,
 				"%s: half duplex not supported\n",
 				__func__);
 	}
@@ -1247,7 +1247,7 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
 			 mii_bmcr_encode_fixed(speed, duplex));
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
 }
 
@@ -1533,7 +1533,7 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 		return ERR_PTR(-ENOMEM);
 
 	mdio_device_get(mdiodev);
-	xpcs->mdiodev = mdiodev;
+	xpcs->mdiodev[0] = mdiodev;
 	xpcs->pcs.ops = &xpcs_phylink_ops;
 	xpcs->pcs.poll = true;
 
@@ -1542,7 +1542,7 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 
 static void xpcs_free_data(struct dw_xpcs *xpcs)
 {
-	mdio_device_put(xpcs->mdiodev);
+	mdio_device_put(xpcs->mdiodev[0]);
 	kfree(xpcs);
 }
 
@@ -1552,7 +1552,7 @@ static int xpcs_init_clks(struct dw_xpcs *xpcs)
 		[DW_XPCS_CORE_CLK] = "core",
 		[DW_XPCS_PAD_CLK] = "pad",
 	};
-	struct device *dev = &xpcs->mdiodev->dev;
+	struct device *dev = &xpcs->mdiodev[0]->dev;
 	int ret, i;
 
 	for (i = 0; i < DW_XPCS_NUM_CLKS; ++i)
@@ -1580,7 +1580,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 {
 	const struct dw_xpcs_info *info;
 
-	info = dev_get_platdata(&xpcs->mdiodev->dev);
+	info = dev_get_platdata(&xpcs->mdiodev[0]->dev);
 	if (!info) {
 		xpcs->info.pcs = DW_XPCS_ID_NATIVE;
 		xpcs->info.pma = DW_XPCS_PMA_ID_NATIVE;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..5c804cfd47d3 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -105,10 +105,13 @@ enum dw_xpcs_clock {
 	DW_XPCS_NUM_CLKS,
 };
 
+/* 2 channels per group DW PCS devices */
+#define DW_XPCS_MAX_CHANNELS 2
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
-	struct mdio_device *mdiodev;
+	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS];
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
-- 
2.43.0


