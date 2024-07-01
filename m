Return-Path: <netdev+bounces-108236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07B91E77F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C131F201A0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D016FF30;
	Mon,  1 Jul 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGdYAwoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455616F0D6;
	Mon,  1 Jul 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858568; cv=none; b=HvmHo2m2vK1Lix369fV0cTIEQsofiB2Nmqlf4X7d6wz4ANJafhfab2NWsi6h5FC/lEEpV2lNFer8S3Msau3pwy7yVRQVcd/HMIuC+hT3RrBAdNJAvLXsSf8LGOsKNPqyqaM2lXvQ8vaEh1xLoLizt9uWaCw5Ue/lut9dsO6qRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858568; c=relaxed/simple;
	bh=de6neOOamv+K5oJz8iEg6gjfr7Mh6FMVWmpCrAVBRuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6V1srzxat3eDTK4hxseb0KVZn0/W1PS4sEsqKCfKrIIK5hlxIKmKCNnYhXJVZbsQ3+qbsrWgHnCS6/hoYzTkXzzXW76ZFs0TcT0icDRWEhMEbV766HfudFOISjRUKK7zAbBWNaBQB1e21Rv3N9BzMLZvo1/B5/oUju3cUb+E8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGdYAwoI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd628f21cso3421886e87.3;
        Mon, 01 Jul 2024 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858564; x=1720463364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvlJk8oP+tmHFi1mC8gnmikt6FGOAr8ZwLY+NpWyHOQ=;
        b=CGdYAwoIUYOKspY9fzvlZjTNcVJNsVBXXq1yq1tWEx5otZ5cKj4xaANPfXMqtI2dzg
         A/jAg6nbsjolQH3o/YpM2nS6U+Zl7A9AnTqqCc8ZuJyzgDJvZ1CQVVfLtGdDoNpcqKbz
         ILz4y3wEeC8XAShM1SER4miUnDtLuZEGtKj14w4wySwWFY+0Y2oW9DdMR5MgLJEbCAVa
         bRvph3XbxFbwgK+H2ePoI2t2vYHKZgMPA6RSWYxJi5lM5lxx0epFXxzbR/fnoY3QC0Ke
         bWOcFxDB6UFSUxO08adjVuTygOR3/HAnXUdTa69qemxRdtr6nVKOGBK1+uwmsxin8wlV
         1Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858564; x=1720463364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvlJk8oP+tmHFi1mC8gnmikt6FGOAr8ZwLY+NpWyHOQ=;
        b=PnJC4y5GQyat8kqt9OBte4reD7u+VnWhscgyPaXC5DZqlKg6XKee+BJ28jUBuRfy41
         3Nc39LpeQnMY61h9Z2PzDEo15eIZacMhDsMMsLLOqSnzo2FK4Q/pehmcHYeV5ar5hBAi
         Xq0H7SSuMuWC9ArCDbY8hrMGA/B5wT2Oo/Wl08ovAKM1bmBGTwAk2qOXqBcQSbBnU1rO
         Z4nQ2CX/34AQJ337t+9Hqc7VJCra2ObEO7Wrgm30lVrrpyvAuO/rovJUPR1nZhAsm5O+
         y3Cw8qXnQacTYLGY/79JeC66KblMxt0ZF39W9gAfuLaTIK6M5h6RgyH3K2cExVQir42S
         lYzA==
X-Forwarded-Encrypted: i=1; AJvYcCWqW1Ma/4YpJlCTN+Bwqc2ExKfAZPLsToqSYiHMqmOJqSn7HIOdbmJTiame8eHgXDNtmosBPe88sHnFjol1dZgbn5hsJ7UQtyOIAF2dFgsL5ZyLYu3rxI6+RciryZtdqmZovCik5eJYblENLodEJYl3x7e8F1ZCFln4Vhk4kvdmoQ==
X-Gm-Message-State: AOJu0YyiO3V6i220qtm9LdPDh8EBQd/Ecl0tHFdyYne+BrZoJ4lG6jJd
	+NI86M9uoP8yT7oruA8/SudfSw5Q6rlRM/rIf1CN23lFX7pRTRr1
X-Google-Smtp-Source: AGHT+IGqL6/dCwF3L6iDrxmgBaANQBOWFRcd6ouou8X4pnSp7jsDRzM2DgR/vflHym+AIxFL9iW86A==
X-Received: by 2002:a05:6512:6c3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-52e8268b40amr4149294e87.31.1719858563288;
        Mon, 01 Jul 2024 11:29:23 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27837sm1501644e87.140.2024.07.01.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:22 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/10] net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
Date: Mon,  1 Jul 2024 21:28:34 +0300
Message-ID: <20240701182900.13402-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.

Changelog v4:
- Rename "entry" local variable to "desc". (@Andrew)
---
 drivers/net/pcs/pcs-xpcs.c   | 32 ++++++++++++++++----------------
 include/linux/pcs/pcs-xpcs.h |  4 ++--
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2dcfd0ff069a..4ed29df8c963 100644
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
+		const struct dw_xpcs_desc *desc = &xpcs_desc_list[i];
 
-		if ((xpcs_id & entry->mask) != entry->id)
+		if ((xpcs_id & desc->mask) != desc->id)
 			continue;
 
-		xpcs->id = entry;
+		xpcs->desc = desc;
 
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


