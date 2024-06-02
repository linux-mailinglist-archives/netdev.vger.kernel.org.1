Return-Path: <netdev+bounces-99990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF38D764A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E2281863
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B54FB5;
	Sun,  2 Jun 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJST1o34"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DD4F5F9;
	Sun,  2 Jun 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339011; cv=none; b=CfLeRgrbQfQ31xGXKTN1o3HzjUaCHtOCc+RpdhJpVUzaLr1LtlcHkWXjgTx0aEtpKUZ7/giEYmXNQfOAa7RxtGZ9sBJw/MiIhwIAQ/kN2rUBMxGuYFcW71wQ8a6MhPrd4MWiKOdjot0hEVXjINO0dsbuJxZpu4WV8Luslvhzx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339011; c=relaxed/simple;
	bh=942HWtrrwMZHj8NhKUHjxOd6FxhubpGj857au8oAFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMWz6PcvRIToqUW4+taMZNSluCxQa/q7yxVbZBwlS9Ee9NOwLCPDGG7YyGIu3z9MvKrTrntSZMht7KbUY/jg1CrPyVfLq4MXqxt9xDz0r2UD0xMIkKX0nkx31DTxbh8duUxuQkM/EOQ90ePbc5QNLRffTN/guKdEjjtJgFq9DqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJST1o34; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b90038cf7so1787994e87.0;
        Sun, 02 Jun 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339007; x=1717943807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1aUmiEcMZ+VAXZ9+5FXW90knS868BRwEpAdgXfPTGM=;
        b=JJST1o34POs2uLNTtTJGTpEgDGGuHaDs+j4yV3D6UmHXEIqNt7h8fwXP/mmNtY4zjA
         MqtnhZdMACo1kBPJZoUBkPdgFBrR+1U55FF4qnLHn38usvGWRwusQHWRrMXrofVDQX6w
         LEskAp4zW4GH2/T2QiIZ/uARP3wbWt9Gbt0E02uZWzsLaB77sMm45dG4hor8hxXYFkln
         wJpAsN+3p+Tjpp6bJ7/tCw8QYLaqKOd8G5iN4nydvTq67ctBauvpAtWVHOwROQLFqSMI
         MZq3QYDpmnOjTcPoWfOzCzTJxMwbMcMn/kvHcA1SP8jAXD4dEHh+opVdqdC3E5UbUkBz
         ozvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339007; x=1717943807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1aUmiEcMZ+VAXZ9+5FXW90knS868BRwEpAdgXfPTGM=;
        b=jGZd26fm2fIsKwMDaLdLtQRRVY1nr/+aUDfme01o+s8Ro/e+huvnAkYNjvi/RTFlz4
         sc8s2FTnuStmw9C3dkS4GW0puOHML27u1sW69PjnUONDHT7PEHtNhMwgVorNfQeWdpAv
         HK1y9HIe+PgcN54vicYrVSo/AxHvMpwUyocE6nP3THRqR+iMIXUQeVsgTZbM1P3YEN7D
         ZPdD5GX0Ow9QqmaB628wxOJlusB1/4C81c5bA3jwrsR8qIEEw9jhphTKul3TMBzPJwfe
         kpRQflN5ufAzqFGYeHZv53GfJfNXMqZsYW1VQGG/VFLM/AEQ/5Kq/CHLtrybCXNvcbCY
         DNBw==
X-Forwarded-Encrypted: i=1; AJvYcCX+014frxuotM3D/C3yXmQquO1pk4w3HIFS99ePAfTlHX8X9ouBdALYW2iyeQPyVaNF2pEnbd9WWfqLDei+goxUd2SsHFOj15xCRoeQkyFG4RQk7DddB5qeXxq523xAq5EGq7W3qdw+h7vgWBbgA1zM8U3WLKtMgcxP7/6uJApUoA==
X-Gm-Message-State: AOJu0YwIqxr+G83FP4OPMtgvEIrgFRgCHQ3U3W0s05aCL/A5xffVk3Lt
	L32kLyhRN11CbZxQsRSbADygm6X6KySbqHNnE0/uRTcInRcGY5Tn
X-Google-Smtp-Source: AGHT+IFQIkTMVlNgNktVJJk2l6Dn1nauzPWvJqXGt6FVgZVFK7u+tMEKQScgX/2bTN7d7XbmjOV/Jg==
X-Received: by 2002:a05:6512:3145:b0:52b:51ad:13f with SMTP id 2adb3069b0e04-52b896c1515mr4088383e87.49.1717339007085;
        Sun, 02 Jun 2024 07:36:47 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8dcb41e6sm641305e87.266.2024.06.02.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:46 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 03/10] net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
Date: Sun,  2 Jun 2024 17:36:17 +0300
Message-ID: <20240602143636.5839-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A structure with the PCS/PMA MMD IDs data is being introduced in one of
the next commits. In order to prevent the names ambiguity let's convert
the xpcs_id structure name to dw_xpcs_desc. The later version is more
suitable since the structure content is indeed the device descriptor
containing the data and callbacks required for the driver to correctly set
the device up.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.
---
 drivers/net/pcs/pcs-xpcs.c   | 30 +++++++++++++++---------------
 include/linux/pcs/pcs-xpcs.h |  4 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2dcfd0ff069a..48c61975db22 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -151,19 +151,19 @@ struct xpcs_compat {
 	int (*pma_config)(struct dw_xpcs *xpcs);
 };
 
-struct xpcs_id {
+struct dw_xpcs_desc {
 	u32 id;
 	u32 mask;
 	const struct xpcs_compat *compat;
 };
 
-static const struct xpcs_compat *xpcs_find_compat(const struct xpcs_id *id,
-						  phy_interface_t interface)
+static const struct xpcs_compat *
+xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
 {
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &id->compat[i];
+		const struct xpcs_compat *compat = &desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			if (compat->interface[j] == interface)
@@ -177,7 +177,7 @@ int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct xpcs_compat *compat;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -612,7 +612,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 	int i;
 
 	xpcs = phylink_pcs_to_xpcs(pcs);
-	compat = xpcs_find_compat(xpcs->id, state->interface);
+	compat = xpcs_find_compat(xpcs->desc, state->interface);
 	if (!compat)
 		return -EINVAL;
 
@@ -633,7 +633,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &xpcs->id->compat[i];
+		const struct xpcs_compat *compat = &xpcs->desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			__set_bit(compat->interface[j], interfaces);
@@ -853,7 +853,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	const struct xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -1118,7 +1118,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 	const struct xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->id, state->interface);
+	compat = xpcs_find_compat(xpcs->desc, state->interface);
 	if (!compat)
 		return;
 
@@ -1341,7 +1341,7 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 	},
 };
 
-static const struct xpcs_id xpcs_id_list[] = {
+static const struct dw_xpcs_desc xpcs_desc_list[] = {
 	{
 		.id = DW_XPCS_ID,
 		.mask = DW_XPCS_ID_MASK,
@@ -1395,18 +1395,18 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 
 	xpcs_id = xpcs_get_id(xpcs);
 
-	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
-		const struct xpcs_id *entry = &xpcs_id_list[i];
+	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
+		const struct dw_xpcs_desc *entry = &xpcs_desc_list[i];
 
 		if ((xpcs_id & entry->mask) != entry->id)
 			continue;
 
-		xpcs->id = entry;
+		xpcs->desc = entry;
 
 		break;
 	}
 
-	if (!xpcs->id)
+	if (!xpcs->desc)
 		return -ENODEV;
 
 	ret = xpcs_dev_flag(xpcs);
@@ -1420,7 +1420,7 @@ static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct xpcs_compat *compat;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -EINVAL;
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 8dfe90295f12..e706bd16b986 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -28,11 +28,11 @@
 /* dev_flag */
 #define DW_DEV_TXGBE			BIT(0)
 
-struct xpcs_id;
+struct dw_xpcs_desc;
 
 struct dw_xpcs {
+	const struct dw_xpcs_desc *desc;
 	struct mdio_device *mdiodev;
-	const struct xpcs_id *id;
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	int dev_flag;
-- 
2.43.0


