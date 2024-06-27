Return-Path: <netdev+bounces-107097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696A919BFE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33AC2831B6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F063D3BD;
	Thu, 27 Jun 2024 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsMTfT0Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E579F4;
	Thu, 27 Jun 2024 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448944; cv=none; b=mWzRZ9y8HtpTau7cxRz1B6KJGG4zdRYjP8jEzp6ur0eEf2KJ+cChMSBH64G1EB3hBXlV5QvYxfF9TCnN8Ni5uUjLP+aBCg7yBzCHICYrS/H4RFrDmZzHSxZkxK0LsyLwReomk4NBjhDJVR3JEVqJLFQ/5xb2Jptvlmh0iSOtQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448944; c=relaxed/simple;
	bh=xj2Cr4TyHsmmOYefzTQwzoHeqZD22q0utO2EV+/SVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFlk9s9NSzK3pT8/pHKLbWM99mJjfXSmLQX7YDpDxuvxjrDDglLxx7Tz/k/1Xw6SOAkBIjtzxXwo1PMNqad4R872E72Mo+G7Tb5UNfmQ5m0ISD+hsuGz//F3t2lF2Nt/l0bpJDnSwwuK/0ZXzFpBGal2fJIjsT3KATd+oBOO77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsMTfT0Y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cdfb69724so5578417e87.1;
        Wed, 26 Jun 2024 17:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448941; x=1720053741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGa0V/+q1PY+8AtdQff4+HTCc2sbpBqj/v0lwdLsGCU=;
        b=IsMTfT0YO5MieIYtUwcXQsxT6GQwGWoaPinqfloBtuF0rlmdtRBD8Vl8Kf8ifXxtkB
         iz/bOJ+hVgBMeJ/Ns2q0Y2Qjprrz+thbDVBjnC9W+kcA1n5XV+q71m1mxEnAN+Z0/fdu
         N7cT/IQWQoYCQlqqLmOhe13H2NuXQVMJgF+t04V05i2QIOKTtSHwUx2dUv/HwbzRrzSw
         trghARWEcsK3Alw3M8qg2JJ4nMIrcWkx/vZgin5NlmODCHpZWssL+fkCBd3UMDGTCmom
         2sZeMSWhdoUb+fpes7vchD3EKAHJHiwUS48yQBQBHeAbxUPVpWNoQsKSmjQWfvzUV2Eq
         GRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448941; x=1720053741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGa0V/+q1PY+8AtdQff4+HTCc2sbpBqj/v0lwdLsGCU=;
        b=J3NTDAzov3ew+ZjYMjL7rz3U9z0FDrUp/KZA7q5xPjI/a5sgdcXGOVQT5g5lZVaMHR
         /OFg0Nn/XbY7Y+oCKdzhvWq2HHq8c9tMFgfuUlBewnyVUSQ7l4qIGel0iVEVw0dB6O2q
         IYuwdG2oGTaPKmEs8FqkpgD4C6lnTNNqJnwubQpc8+VDT8TJll5uCvR4x4161FewWN/7
         RO4p0HijIVDeJwF0alWwsvFnP+wq6QbfYlP5xWWztSpM7FhQB/VD3Xj+NNNtV4Fqb2c6
         OJsQB9RPk+QbO0229G4QLNCbnIjaKLsKc1x56CP5FBUWvYfhSawzXIU1ViAfGv85uM0p
         VE/A==
X-Forwarded-Encrypted: i=1; AJvYcCXS2ds2hxTzPwX86J/UNPWnNJk0Mf0m1+s4DHXdGeBBSy13V4gkC4le4jcADZrMUdQjTR2/TMNfo+XMJ1ah2dmQdWuOve6pxxmqhLadradpKYKO3Frt1Zc1Uoh1icTM1ja214TUSmupzJ/HxoDPc2rGakXQuXPmYD3REygUaEFuuA==
X-Gm-Message-State: AOJu0YxrqANLAcIrqsFGcSD2cLhyQhELnwi8i6OaKpjvYaFv4A5zw0po
	LY0uusA6o0hVbfkPc7T/YCB+VTQhjJGrpOgxCKt4HmG7OEv1gmTs
X-Google-Smtp-Source: AGHT+IHkActpZTtjsuzyiNyp+unFcBPGmpORKiX6h3v1xsvn9qGifn4FXEoGGX308UY64dnWHiAHzA==
X-Received: by 2002:ac2:46ee:0:b0:52c:dc25:d706 with SMTP id 2adb3069b0e04-52ce185ec9emr6605174e87.52.1719448940728;
        Wed, 26 Jun 2024 17:42:20 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7131ec55sm18792e87.231.2024.06.26.17.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:42:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/10] net: stmmac: Add DW XPCS specified via "pcs-handle" support
Date: Thu, 27 Jun 2024 03:41:30 +0300
Message-ID: <20240627004142.8106-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
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
index 74de6ec00bbf..03f90676b3ad 100644
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
 		   priv->plat->mdio_bus_data->pcs_mask) {
 		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
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


