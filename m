Return-Path: <netdev+bounces-108235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CA91E77C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AAF283485
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976C16F849;
	Mon,  1 Jul 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKUcs/C4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5A16F288;
	Mon,  1 Jul 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858564; cv=none; b=iYrffHh+4FnBtXZtGU+qGsODUmLEx29CGOnfeWnbZRsNs73LN2gp5KltnQXEryt9T8IKG05mgxxhzNInfc9iRT/DjawL/gPDfc+RlxyxiPl5jVm4aAOAwLOn8m5rvwOJi9k9MxwB+bx0LWUuSkhQnD64eQjo2GlNiyDCclk5Fdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858564; c=relaxed/simple;
	bh=jtwdjo9EjfDax0z1lAjVonxsE77nEAbZMJ4Z3stjtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4kzB+LoMd8woqnGT6CZ4FJtiagFO7Y7kLY1llEyzSe6/TnuAo3YvtdD0l/Z1NDSP1sFnEGcjm5b0/7a/W6L3PXQYGR6WYmskKTBFD2/EntjEJ4sdnDUSY3leLAIoWRxp5lc7xSsIqi0Hh57FjdZVRel661/EUIBqudEBbU3aEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKUcs/C4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52caebc6137so2689271e87.0;
        Mon, 01 Jul 2024 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858561; x=1720463361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzEq4SI8AvgE+sl3vSIIsnkN1WPxiJIMB0O5ItHvhEY=;
        b=gKUcs/C4hCRECU6uu5tQEHn7QJLDMy1HcXpXPzr7lySufiEWv4EZ5fJHU6H2IXIbqY
         Q1rVxCuxrMJdt3iBM+Xg7Qe2F94JOCcXOiYVjiA9zZ+GQXppqGaWXTxcs53Uu/29d4de
         3kEiSZVD7+ycOQvhuq0gqCNCNemlh0k8ZogR4pHG091dcdzeh88Sps/tV9Q+Mp7/c0uO
         LERDHGjZW7+s0D5+9UOrkaMlK3I+/TOV4OGuc/8zqpNtQK+MJXUhzw3RoQbEtAFXwsXm
         7dCeO0Ueei2jLajlh4VyF/M0C2Wf4c6ZBiQ9rnFSZT8NbjtNMOY7NPyIC79wfPKTkpy3
         vYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858561; x=1720463361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzEq4SI8AvgE+sl3vSIIsnkN1WPxiJIMB0O5ItHvhEY=;
        b=wNjSLgsC3RgoSK6CglWtPlvLKzu/z3M6krJEACOhOvCEZaJECoqIKnKrTJHb+UaBfe
         q6F70NafTay1gJfY9Bn4K5YMts8NQgZUtKVBAqY2EiO8jB8hRRG9m+3tE5+pGwCY/nHt
         Sekl+pgXxDAtEUUeWgv2OhXtgXdN8nbv5Vaba7JS/bE61n+HG1dLXcPnCiiwxwYy6Fwo
         zqzlmBZOIJtAMf9CM2Z1IIJX5ykUFVfh/ouT5hgUdY+tYCm5NVCj436GYI1kZFwf5M6z
         /CLhzDDkE0RiGug493xL4XsCqaDCI87r7PhnsmUW+zwey7zYqYWNl9TWoVIHpBzKnQSZ
         3ptg==
X-Forwarded-Encrypted: i=1; AJvYcCWNBuyrO53zHIcSyFJkJ2yN7rqjMBCp1w5K4WQld5DrkCsgIe33P8KDwOx2oru1iNJtu48r1O+wiJaJTP0uc7CijaRzjQm7SO0zkvXVVwMNKUyjS21EyGrsKFQEjl3IarqeMXCq5tHxwXrIx6l+vvonrkawb1o5Qrwe3j+oK8Pyog==
X-Gm-Message-State: AOJu0YzPO82DP2eQB57OpowFl4hLDFwN8+FiOib8GmDEI7DSN9RlOFQq
	5l3IXNll1SvBu32QLgIjVI5gzS8WrqNx1o8yuNdR56+vrG+Q5xVl
X-Google-Smtp-Source: AGHT+IE/etHJAnWcmMWJBFVe1i6uXWQScY4I8hZ6fWBgLdchKVkO+d1WEwoCvntz/UO4myc5aMRp/g==
X-Received: by 2002:a05:6512:1043:b0:52c:891f:d732 with SMTP id 2adb3069b0e04-52e82735c74mr4492490e87.56.1719858560885;
        Mon, 01 Jul 2024 11:29:20 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2776bsm1495170e87.175.2024.07.01.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 02/10] net: pcs: xpcs: Split up xpcs_create() body to sub-functions
Date: Mon,  1 Jul 2024 21:28:33 +0300
Message-ID: <20240701182900.13402-3-fancer.lancer@gmail.com>
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

As an initial preparation before adding the fwnode-based DW XPCS device
support let's split the xpcs_create() function code up to a set of the
small sub-functions. Thus the xpcs_create() implementation will get to
look simpler and turn to be more coherent. Further updates will just touch
the new sub-functions a bit: add platform-specific device info, add the
reference clock getting and enabling.

The xpcs_create() method will now contain the next static methods calls:

xpcs_create_data() - create the DW XPCS device descriptor, pre-initialize
it' fields and increase the mdio device refcount-er;

xpcs_init_id() - find XPCS ID instance and save it in the device
descriptor;

xpcs_init_iface() - find MAC/PCS interface descriptor and perform
basic initialization specific to it: soft-reset, disable polling.

The update doesn't imply any semantic change but merely makes the code
looking simpler and more ready for adding new features support.

Note the xpcs_destroy() has been moved to being defined below the
xpcs_create_mdiodev() function as the driver now implies having the
protagonist-then-antagonist functions definition order.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

---

Changelog v2:
- Preserve the strict refcount-ing pattern. (@Russell)
---
 drivers/net/pcs/pcs-xpcs.c | 102 +++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 33 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 99adbf15ab36..2dcfd0ff069a 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1365,12 +1365,9 @@ static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_link_up = xpcs_link_up,
 };
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
-				   phy_interface_t interface)
+static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 {
 	struct dw_xpcs *xpcs;
-	u32 xpcs_id;
-	int i, ret;
 
 	xpcs = kzalloc(sizeof(*xpcs), GFP_KERNEL);
 	if (!xpcs)
@@ -1378,59 +1375,89 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
 
 	mdio_device_get(mdiodev);
 	xpcs->mdiodev = mdiodev;
+	xpcs->pcs.ops = &xpcs_phylink_ops;
+	xpcs->pcs.neg_mode = true;
+	xpcs->pcs.poll = true;
+
+	return xpcs;
+}
+
+static void xpcs_free_data(struct dw_xpcs *xpcs)
+{
+	mdio_device_put(xpcs->mdiodev);
+	kfree(xpcs);
+}
+
+static int xpcs_init_id(struct dw_xpcs *xpcs)
+{
+	u32 xpcs_id;
+	int i, ret;
 
 	xpcs_id = xpcs_get_id(xpcs);
 
 	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
 		const struct xpcs_id *entry = &xpcs_id_list[i];
-		const struct xpcs_compat *compat;
 
 		if ((xpcs_id & entry->mask) != entry->id)
 			continue;
 
 		xpcs->id = entry;
 
-		compat = xpcs_find_compat(entry, interface);
-		if (!compat) {
-			ret = -ENODEV;
-			goto out;
-		}
+		break;
+	}
 
-		ret = xpcs_dev_flag(xpcs);
-		if (ret)
-			goto out;
+	if (!xpcs->id)
+		return -ENODEV;
 
-		xpcs->pcs.ops = &xpcs_phylink_ops;
-		xpcs->pcs.neg_mode = true;
+	ret = xpcs_dev_flag(xpcs);
+	if (ret < 0)
+		return ret;
 
-		if (xpcs->dev_flag != DW_DEV_TXGBE) {
-			xpcs->pcs.poll = true;
+	return 0;
+}
 
-			ret = xpcs_soft_reset(xpcs, compat);
-			if (ret)
-				goto out;
-		}
+static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
+{
+	const struct xpcs_compat *compat;
 
-		return xpcs;
+	compat = xpcs_find_compat(xpcs->id, interface);
+	if (!compat)
+		return -EINVAL;
+
+	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+		xpcs->pcs.poll = false;
+		return 0;
 	}
 
-	ret = -ENODEV;
+	return xpcs_soft_reset(xpcs, compat);
+}
+
+static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
+				   phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs;
+	int ret;
+
+	xpcs = xpcs_create_data(mdiodev);
+	if (IS_ERR(xpcs))
+		return xpcs;
+
+	ret = xpcs_init_id(xpcs);
+	if (ret)
+		goto out;
+
+	ret = xpcs_init_iface(xpcs, interface);
+	if (ret)
+		goto out;
+
+	return xpcs;
 
 out:
-	mdio_device_put(mdiodev);
-	kfree(xpcs);
+	xpcs_free_data(xpcs);
 
 	return ERR_PTR(ret);
 }
 
-void xpcs_destroy(struct dw_xpcs *xpcs)
-{
-	if (xpcs)
-		mdio_device_put(xpcs->mdiodev);
-	kfree(xpcs);
-}
-EXPORT_SYMBOL_GPL(xpcs_destroy);
-
 struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 				    phy_interface_t interface)
 {
@@ -1455,5 +1482,14 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+void xpcs_destroy(struct dw_xpcs *xpcs)
+{
+	if (!xpcs)
+		return;
+
+	xpcs_free_data(xpcs);
+}
+EXPORT_SYMBOL_GPL(xpcs_destroy);
+
 MODULE_DESCRIPTION("Synopsys DesignWare XPCS library");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


