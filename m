Return-Path: <netdev+bounces-54671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E60807C8D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10321F2177B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B264328AF;
	Wed,  6 Dec 2023 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTZVBEzA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2A5C6
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701906380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8esKVkgkdO38qfOOlPF2GDuWhXzWAxbw0J892C+UC7Y=;
	b=gTZVBEzA7eNmgI4iUx3i5yXgZYBlR6AQa1CCVSAJX1XXwQMTnhFHngolz8mg7rKv2G28pL
	/hCPLquzeSMY7fCeeTJcjtlGcZSVi0KopQxWyoMaWZEHMC6W/cv1WRwQotvn25Bxk2Fz/Y
	OcBRm9ADIU2MULWQwKQ6BBZ8fsYxG6E=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-cuYXFI89M5u8OuoNXZKV5A-1; Wed, 06 Dec 2023 18:46:18 -0500
X-MC-Unique: cuYXFI89M5u8OuoNXZKV5A-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58d53348a03so88019eaf.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 15:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906378; x=1702511178;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8esKVkgkdO38qfOOlPF2GDuWhXzWAxbw0J892C+UC7Y=;
        b=OPmSqKSvwyIOxyYDdO3JSTLOI7uoS51kBr+CggELbNMWjBujXzWxeboSJMum9iP3V0
         MxdvRdQwb6x+rOeMB2CJU/pQpI73l/S70BfAcTz+4o9suvbJ3rU6gWOQPceXUlChpoRV
         A4NFd8vbvGmbPhB0dWnSNZMYGdT81sR96pon3SJdV7oM3fq0QgRRJOOmaMja+FYHLRXs
         mWI4XM3w4kO94WAYSaUmcsed3TtYnrZCuj+CXRePcqXhyF0iSMv8vJ87u7Giyp8gYH9K
         F75MFB7MAu5+TxcguKyHeESYBkUBysgvPHctFSnlMM5cmupCZLsaHMxQy08VrDDiuwAC
         Sc1g==
X-Gm-Message-State: AOJu0YzXNgXPQSQTzceMJaNO4iUcUu25TCvGA5bJwSKp1TPCQygJxHn4
	doVXd+CbdVEYWX14uSuRiTB2W+xmxQWNx1UciGKlh5X1R25vMQ9VeslBy3pXOYQ84r1lSXwTGpk
	lQb1TKvc8V8IjQl2w
X-Received: by 2002:a05:6358:2910:b0:16d:bbb3:69c6 with SMTP id y16-20020a056358291000b0016dbbb369c6mr2398877rwb.13.1701906377931;
        Wed, 06 Dec 2023 15:46:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAsIygwOoQKZlum7cq8klqlJozHBJy1wvtOxVzB6Tfsb98hdv5DwTkASEhC5ZBOAlTAOdQBA==
X-Received: by 2002:a05:6358:2910:b0:16d:bbb3:69c6 with SMTP id y16-20020a056358291000b0016dbbb369c6mr2398863rwb.13.1701906377591;
        Wed, 06 Dec 2023 15:46:17 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id lg21-20020a056214549500b0067a14238fa9sm11568qvb.94.2023.12.06.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:46:17 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 06 Dec 2023 17:46:09 -0600
Subject: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
X-B4-Tracking: v=1; b=H4sIAMAHcWUC/z2MwQqDMBBEf0X23BU31lY99T9KD9FdNWASSYII4
 r839NDTzGOYd0KUYCRCX5wQZDfReJdB3QoYF+1mQcOZQVWqJlJPjMlaPaLzaNn4nCxIPHSsW60
 a7iA/tyCTOX7WNzhJ6ORI8MnLFLzFtATRf2vVVi3l0txLokdTI+EQ5vU1zCx7ua1wXV/b0uTPp
 gAAAA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

The stmmac_dt_phy() function, which parses the devicetree node of the
MAC and ultimately causes MDIO bus allocation, misinterprets what
fixed-link means in relation to the MAC's MDIO bus. This results in
a MDIO bus being created in situations it need not be.

Currently a MDIO bus is created if the description is either:

    1. Not fixed-link
    2. fixed-link but contains a MDIO bus as well

The "1" case above isn't always accurate. If there's a phy-handle,
it could be referencing a phy on another MDIO controller's bus[1]. In
this case currently the MAC will make a MDIO bus and scan it all
anyways unnecessarily.

There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
be created and scanned for a phy. This case can also be inferred from
the platform description by not having a phy-handle && not being
fixed-link. This hits case "1" in the current driver's logic.

Let's improve the logic to create a MDIO bus if either:

    - Devicetree contains a MDIO bus
    - !fixed-link && !phy-handle (legacy handling)

Below upstream devicetree snippets can be found that explain some of
the cases above more concretely.

Here's[0] a devicetree example where the MAC is both fixed-link and
driving a switch on MDIO (case "2" above). This needs a MDIO bus to
be created:

    &fec1 {
            phy-mode = "rmii";

            fixed-link {
                    speed = <100>;
                    full-duplex;
            };

            mdio1: mdio {
                    switch0: switch0@0 {
                            compatible = "marvell,mv88e6190";
                            pinctrl-0 = <&pinctrl_gpio_switch0>;
                    };
            };
    };

Here's[1] an example where there is no MDIO bus or fixed-link for
the ethernet1 MAC, so no MDIO bus should be created since ethernet0
is the MDIO master for ethernet1's phy:

    &ethernet0 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy0>;

            mdio {
                    compatible = "snps,dwmac-mdio";
                    sgmii_phy0: phy@8 {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0x8>;
                            device_type = "ethernet-phy";
                    };

                    sgmii_phy1: phy@a {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0xa>;
                            device_type = "ethernet-phy";
                    };
            };
    };

    &ethernet1 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy1>;
    };

Finally there's descriptions like this[2] which don't describe the
MDIO bus but expect it to be created and the whole address space
scanned for a phy since there's no phy-handle or fixed-link described:

    &gmac {
            phy-supply = <&vcc_lan>;
            phy-mode = "rmii";
            snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
            snps,reset-active-low;
            snps,reset-delays-us = <0 10000 1000000>;
    };

[0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
[1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
[2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164

Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 85 ++++++++++------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 1ffde555da47..7da461fe93f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -296,69 +296,39 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 }
 
 /**
- * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
- * @plat: driver data platform structure
- * @np: device tree node
- * @dev: device pointer
- * Description:
- * The mdio bus will be allocated in case of a phy transceiver is on board;
- * it will be NULL if the fixed-link is configured.
- * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
- * in any case (for DSA, mdio must be registered even if fixed-link).
- * The table below sums the supported configurations:
- *	-------------------------------
- *	snps,phy-addr	|     Y
- *	-------------------------------
- *	phy-handle	|     Y
- *	-------------------------------
- *	fixed-link	|     N
- *	-------------------------------
- *	snps,dwmac-mdio	|
- *	  even if	|     Y
- *	fixed-link	|
- *	-------------------------------
+ * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree
+ * @np: devicetree node
  *
- * It returns 0 in case of success otherwise -ENODEV.
+ * The MDIO bus will be searched for in the following ways:
+ * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
+ *    child node exists
+ * 2. A child node with the "snps,dwmac-mdio" compatible is present
+ *
+ * Return: The MDIO node if present otherwise NULL
  */
-static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
-			 struct device_node *np, struct device *dev)
+static struct device_node *stmmac_of_get_mdio(struct device_node *np)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
+	struct device_node *mdio_node = NULL;
 
 	if (of_match_node(need_mdio_ids, np)) {
-		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
 		/**
 		 * If snps,dwmac-mdio is passed from DT, always register
 		 * the MDIO
 		 */
-		for_each_child_of_node(np, plat->mdio_node) {
-			if (of_device_is_compatible(plat->mdio_node,
+		for_each_child_of_node(np, mdio_node) {
+			if (of_device_is_compatible(mdio_node,
 						    "snps,dwmac-mdio"))
 				break;
 		}
 	}
 
-	if (plat->mdio_node) {
-		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
-
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
-		if (!plat->mdio_bus_data)
-			return -ENOMEM;
-
-		plat->mdio_bus_data->needs_reset = true;
-	}
-
-	return 0;
+	return mdio_node;
 }
 
 /**
@@ -417,6 +387,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
+	bool legacy_mdio;
 	int phy_mode;
 	void *ret;
 	int rc;
@@ -471,10 +442,28 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
-	/* To Configure PHY by using all device-tree supported properties */
-	rc = stmmac_dt_phy(plat, np, &pdev->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	plat->mdio_node = stmmac_of_get_mdio(np);
+	if (plat->mdio_node)
+		dev_dbg(&pdev->dev, "Found MDIO subnode\n");
+
+	/* Legacy devicetrees allowed for no MDIO bus description and expect
+	 * the bus to be scanned for devices. If there's no phy or fixed-link
+	 * described assume this is the case since there must be something
+	 * connected to the MAC.
+	 */
+	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
+	if (legacy_mdio)
+		dev_info(&pdev->dev, "Deprecated MDIO bus assumption used\n");
+
+	if (plat->mdio_node || legacy_mdio) {
+		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
+						   sizeof(struct stmmac_mdio_bus_data),
+						   GFP_KERNEL);
+		if (!plat->mdio_bus_data)
+			return ERR_PTR(-ENOMEM);
+
+		plat->mdio_bus_data->needs_reset = true;
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 

---
base-commit: fd8a79b63710acb84321be3ce74be23c876873fb
change-id: 20231127-stmmac-no-mdio-node-1db9da8a25d9

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


