Return-Path: <netdev+bounces-99997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8E8D7661
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A5E1C21A4A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4077E563;
	Sun,  2 Jun 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzgnCH8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6F78C79;
	Sun,  2 Jun 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339026; cv=none; b=t5J+Cyz8K30jod1emSapFK/B7yCGpRXbyO6ZZZHtXwp3UdaIEnFbNQJXAEA4hCLNuTuopgIrq3+JgP+qZW26LtZpvbg0dr/eCg4lqhqFq3u7fEKJq3Cm1JhkD92n+nDrgJfFa7HUSRtCIdawG7B3BY2i9gFIpklUedJBmG0ZZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339026; c=relaxed/simple;
	bh=IgeH3NtZfgVCNuT/fZC/EjAkaOCyYtD8Ar2FpuVB4Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8Ze5B3yKEDbBq1favrvLnHc5k0HtqAkGas2NzOh6/xk8UgpfXc85F616QtjSFLMgUd2xvgCyyWzE+tCumoWdA+s84drYbFEvZpd5pztDcpBcy8a/Gy2FPMxhJuIi+rKmLjRNehqtwUgWX5+wZ+uV5KkhRvfTfCqeDvo10V0q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzgnCH8f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b919d1fc0so780276e87.0;
        Sun, 02 Jun 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339023; x=1717943823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU7sOuoCnE7DZBaFJYawXWXaLrHsBgPyxKdpukglgGI=;
        b=MzgnCH8fIEvlVeENCVv2NJnCW/o3q3mBfChHp334+anYG371Dpsx96kLCcsJoOM60L
         kIPuH3NhiUvb8iN8XQfKwGF9l3fu/z+4T2UYFw816coboERULLCXjOnv65UyfpNKesek
         zxbtHCA3riPW6eBY/smUDPnkTOHrIOwiOmix5qfvZpI8wJ17aQVc8/0y2L6GydPFvp3b
         K5z7wsFqf7nXITQJDImA9quBf3k4N7dvWKZ3sFOjK6PVC2JFXUnbtTsG9dQaFnsRj14I
         mjTeYreJKryUkZLFKJ/74i75HHPqKSMhYDbOKT2P5TgUx0VIH/a84KTeP1ybQ7VbXpGr
         k8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339023; x=1717943823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU7sOuoCnE7DZBaFJYawXWXaLrHsBgPyxKdpukglgGI=;
        b=CnxUAcCT9QSMeGbQJ++uONbxdKWOahW3rkuj2Yzhyj4LfCcy4r6v+lRvq5M9syrJo7
         ANlWeibIm7T3e6sI9FFjjQWcsU7qkMPUU2bcKMxH+x3pU1SonMUlHHse7JohlyxajraJ
         QrcqdcT6Cj7NryNLiy+JjHiuv8cCRtO8BBua+DGl1VlT2C13EJuStraQYp/Ip8m0SpGP
         L0HkQSdFIK5TDJY7P8DMTxLr0QwQNj6jjHAz6RMcSDqVOSYgOBWcj1kR2WFD1T6s/rDx
         FLlOG3XABcoxtE0mZWSXjDCADAvxtQGd3VPp19KUoInhsuyLo5JY0pkb2Xvl2wQn+tsv
         QiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWCphfqYwfl7ncxupRJKbc/bg4rkauhCqq+QxPVOk3EAhAjkpb7Utge5EoWv8KfCAmqBviroExvxZ4AKR7pPZIi/xy892AcbB22FuHwXvsgtPsroNHQPxfpMznSJ/4Tv1mVCWdV819QQKy7kOn/IfOeFRvkxFX7eKkcbiKqPeclJg==
X-Gm-Message-State: AOJu0YyQ00SJlVcLURRWCw6bnAm3UYh0FW1g3WDOt33bknGBtl+by/J9
	cS9xi1aeIs6YPRd0XqMiSYHafpDufIx04BE99NF9GQxSbMpewrNO
X-Google-Smtp-Source: AGHT+IGG30UwFOotd/0Zdrr/C30omiONtB0LV+xIFdYgqxXQLjQdJQlWg/j2uttrnvCHheKu72hvDg==
X-Received: by 2002:a19:5f53:0:b0:52b:8912:2843 with SMTP id 2adb3069b0e04-52b89122a59mr1943524e87.32.1717339022871;
        Sun, 02 Jun 2024 07:37:02 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d34b18sm966116e87.12.2024.06.02.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:37:02 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via "pcs-handle" support
Date: Sun,  2 Jun 2024 17:36:24 +0300
Message-ID: <20240602143636.5839-11-fancer.lancer@gmail.com>
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

Recently the DW XPCS DT-bindings have been introduced and the DW XPCS
driver has been altered to support the DW XPCS registered as a platform
device. In order to have the DW XPCS DT-device accessed from the STMMAC
driver let's alter the STMMAC PCS-setup procedure to support the
"pcs-handle" property containing the phandle reference to the DW XPCS
device DT-node. The respective fwnode will be then passed to the
xpcs_create_fwnode() function which in its turn will create the DW XPCS
descriptor utilized in the main driver for the PCS-related setups.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 807789d7309a..dc040051aa53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -497,15 +497,22 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 
 int stmmac_pcs_setup(struct net_device *ndev)
 {
+	struct fwnode_handle *devnode, *pcsnode;
 	struct dw_xpcs *xpcs = NULL;
 	struct stmmac_priv *priv;
 	int addr, mode, ret;
 
 	priv = netdev_priv(ndev);
 	mode = priv->plat->phy_interface;
+	devnode = priv->plat->port_node;
 
 	if (priv->plat->pcs_init) {
 		ret = priv->plat->pcs_init(priv);
+	} else if (fwnode_property_present(devnode, "pcs-handle")) {
+		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
+		xpcs = xpcs_create_fwnode(pcsnode, mode);
+		fwnode_handle_put(pcsnode);
+		ret = PTR_ERR_OR_ZERO(xpcs);
 	} else if (priv->plat->mdio_bus_data &&
 		   priv->plat->mdio_bus_data->has_xpcs) {
 		addr = priv->plat->mdio_bus_data->xpcs_addr;
@@ -515,10 +522,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
 		return 0;
 	}
 
-	if (ret) {
-		dev_warn(priv->device, "No xPCS found\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
 	priv->hw->xpcs = xpcs;
 
-- 
2.43.0


