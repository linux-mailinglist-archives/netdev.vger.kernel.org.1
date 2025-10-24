Return-Path: <netdev+bounces-232498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C4C05FB0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CA06344EFD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A63128D5;
	Fri, 24 Oct 2025 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjh6Xq8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32D304BBD
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305139; cv=none; b=XdYAuHrjkJJ+0anBwPIw4eznPVKR4lGnGtSW8GL7K8JPFYPI5zmn/1zCkNHIPqKob/hrovlV1OO7lEbk+cQY5hirdWk848YeLCRGrKwCoxec9FWbBwyodmGoZb5WksPUm5oBfoCNt7HmEeyxqbf/R4/TP3K2ngPOfB+2AX7HS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305139; c=relaxed/simple;
	bh=olQ1xps2HmtwecDlVgoSoeP56RCYrmDX2/DvWE5KoWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oSRSmPrtZ2Z/S84J6tW/si0zW6Ob8qKgYsT9XvB2gwk2G2kPFEiTqXY9OP5lmdRaro9ztDLVg+t7JzQBc0BLAbt3nchGQdFBInRUgUUHWDNVy4PyCyJYDjyHx7k0tAdoz3n/CcnZTR1NeEWQ38CybT53eXFvD4kRzcLCFpGjlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zjh6Xq8v; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so15807235e9.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761305136; x=1761909936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr5XQE9G7Q4RiAtGe3G7AF7+XiyFY/b7a404nwk33fs=;
        b=zjh6Xq8vmlu2TRJRW/DQIkrYKwZgT6Ez/g88z1OVdncJsh1JtQZuVgfCSMxTPtDDFz
         Wxg7BnjyoY5rpKDDsCur+YRMBxoAltt5NzFbmMjYT3oYPh7uvuopFBvtvOTURUGAt/9p
         5QrAw9hCnPdy/Gv6cGYeDKJtXA975DUPV9JJHmHBGB4VSnT9xAUyINxAceCxwkgIzrXu
         eEM3lXnIrMYo2TObwtyoG7A4W24kUWlYPmRkuowu6gpeODizhi6n5PQzEtIhsvucekoP
         8c8VwrWvDlwXSOAaS/0QV+2JzsHk8LyBtkHGitDeGD49GQqSwJbv9gXmeqvWklPblPNC
         6/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305136; x=1761909936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tr5XQE9G7Q4RiAtGe3G7AF7+XiyFY/b7a404nwk33fs=;
        b=iYnJJB8IQax+iIKvOrZt9aXpvPDZOqtrNagYChAq1k4XYdOkSa3dMV70XTfOG745Vo
         3u/RgX0GoG+F+/oAXCACXaSXkYzm1Za5HeT5AeJNoLIWi/lD31/OpWMaMSP7VkTTHhNU
         ZG6ZkNfjXeSWRHSFWvMQ1X43FgLaJeusI7nZUfdhVeisGdezNTwvbGcdDLjNQAwTFGvF
         yeLWcB2oQN6XL0phtEhvla8OyGMZ34p1bUPE5fxrSadDgcZjIB49UbBaCsQpxjcXAVJq
         lBYvriLIm59Si5z+LAZz3Ns+rhmrEHwF2dHLWQIdAx9ooahr1BTrFCDnc+QeXxJsoKBD
         vXyA==
X-Gm-Message-State: AOJu0Yy+c67rI6qV1jndd1rIfnNfXvS+F/t2Z0Yz1Ij/BpfPlMdPsjRy
	iAd87wLVmMggoVuN7BeAkG7FE1wUTEgUgdT9GvToe8EqSMKe5wjOc/o6E3bdkjehm2k=
X-Gm-Gg: ASbGncuM6wM4jxqhj9daL3VMZRaJsyh53uyGaNjtyn5j3SUNnqoxpZDjL6XNcchEn21
	CqBr/OPxjD+l/RtxZGFfLfl/FIzHROwdTNGhm2ftkG2+LS6IF5BwZy4hcQ/nHcVCOqFXsNnxjSI
	MtxfjeccEbtNGx0kZ46byjnPI/6qmBhqz3pyrVS3CXSXOJvl+qvjswY8UAaaR45apkN/gMXBHlJ
	6x7yf/rFlRPTxyUwvZbV5Dh43E+fM3BBDy1r2OlJESXrvW95601UxWpKX8XCtET58rX2GHYwcM6
	xded6i3aD6siuP0RD05ulPzsLPEChfpKXlc750BN3MsG1/qVReYaCwaWEoslsQhXKLPNfRrkgzY
	ToNAiGS4eCSyZsPhBhnu3m8ZaRAg7TBCpcn95yH/3Wuvl93hgV+eiM5nPJ6aKsPf3+9ULBCH6rC
	w85nNPQg==
X-Google-Smtp-Source: AGHT+IHG2UOfgCSfT5f2IPjva8C/uUrJrSCpnDpaGpqxbFfTTkDA9B80HxhsLvEl06gewpKrKUWdeQ==
X-Received: by 2002:a05:600c:1912:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-475d2ebff3cmr14312085e9.26.1761305136010;
        Fri, 24 Oct 2025 04:25:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475cae9f8eesm86706515e9.6.2025.10.24.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:25:35 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: stmmac: mdio: use phy_find_first to simplify
 stmmac_mdio_register
Message-ID: <aPtiLLlLu-KbnCz_@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Heiner Kallweit,

Commit 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to
simplify stmmac_mdio_register") from Oct 18, 2025 (linux-next), leads
to the following (unpublished) Smatch static checker warning:

	drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:684 stmmac_mdio_register()
	warn: array off by one? 'new_bus->irq[phydev->mdio.addr]'

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
    577 int stmmac_mdio_register(struct net_device *ndev)
    578 {
    579         int err = 0;
    580         struct mii_bus *new_bus;
    581         struct stmmac_priv *priv = netdev_priv(ndev);
    582         struct stmmac_mdio_bus_data *mdio_bus_data = priv->plat->mdio_bus_data;
    583         struct device_node *mdio_node = priv->plat->mdio_node;
    584         struct device *dev = ndev->dev.parent;
    585         struct fwnode_handle *fixed_node;
    586         struct fwnode_handle *fwnode;
    587         struct phy_device *phydev;
    588         int max_addr;
    589 
    590         if (!mdio_bus_data)
    591                 return 0;
    592 
    593         stmmac_mdio_bus_config(priv);
    594 
    595         new_bus = mdiobus_alloc();
    596         if (!new_bus)
    597                 return -ENOMEM;
    598 
    599         if (mdio_bus_data->irqs)
    600                 memcpy(new_bus->irq, mdio_bus_data->irqs, sizeof(new_bus->irq));
    601 
    602         new_bus->name = "stmmac";
    603 
    604         if (priv->plat->has_xgmac) {
    605                 new_bus->read = &stmmac_xgmac2_mdio_read_c22;
    606                 new_bus->write = &stmmac_xgmac2_mdio_write_c22;
    607                 new_bus->read_c45 = &stmmac_xgmac2_mdio_read_c45;
    608                 new_bus->write_c45 = &stmmac_xgmac2_mdio_write_c45;
    609 
    610                 if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
    611                         /* Right now only C22 phys are supported */
    612                         max_addr = MII_XGMAC_MAX_C22ADDR + 1;
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
max_addr set here.  This is the line which gave me pause.
MII_XGMAC_MAX_C22ADDR is 3, but why do we do a "+ 1"?

    613 
    614                         /* Check if DT specified an unsupported phy addr */
    615                         if (priv->plat->phy_addr > MII_XGMAC_MAX_C22ADDR)
    616                                 dev_err(dev, "Unsupported phy_addr (max=%d)\n",
    617                                         MII_XGMAC_MAX_C22ADDR);
    618                 } else {
    619                         /* XGMAC version 2.20 onwards support 32 phy addr */
    620                         max_addr = PHY_MAX_ADDR;
                                ^^^^^^^^^^^^^^^^^^^^^^^^
    621                 }
    622         } else {
    623                 new_bus->read = &stmmac_mdio_read_c22;
    624                 new_bus->write = &stmmac_mdio_write_c22;
    625                 if (priv->plat->has_gmac4) {
    626                         new_bus->read_c45 = &stmmac_mdio_read_c45;
    627                         new_bus->write_c45 = &stmmac_mdio_write_c45;
    628                 }
    629 
    630                 max_addr = PHY_MAX_ADDR;
                        ^^^^^^^^^^^^^^^^^^^^^^^
    631         }
    632 
    633         if (mdio_bus_data->needs_reset)
    634                 new_bus->reset = &stmmac_mdio_reset;
    635 
    636         snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s-%x",
    637                  new_bus->name, priv->plat->bus_id);
    638         new_bus->priv = ndev;
    639         new_bus->phy_mask = mdio_bus_data->phy_mask | mdio_bus_data->pcs_mask;
    640         new_bus->parent = priv->device;
    641 
    642         err = of_mdiobus_register(new_bus, mdio_node);
    643         if (err == -ENODEV) {
    644                 err = 0;
    645                 dev_info(dev, "MDIO bus is disabled\n");
    646                 goto bus_register_fail;
    647         } else if (err) {
    648                 dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
    649                 goto bus_register_fail;
    650         }
    651 
    652         /* Looks like we need a dummy read for XGMAC only and C45 PHYs */
    653         if (priv->plat->has_xgmac)
    654                 stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
    655 
    656         /* If fixed-link is set, skip PHY scanning */
    657         fwnode = priv->plat->port_node;
    658         if (!fwnode)
    659                 fwnode = dev_fwnode(priv->device);
    660 
    661         if (fwnode) {
    662                 fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
    663                 if (fixed_node) {
    664                         fwnode_handle_put(fixed_node);
    665                         goto bus_register_done;
    666                 }
    667         }
    668 
    669         if (priv->plat->phy_node || mdio_node)
    670                 goto bus_register_done;
    671 
    672         phydev = phy_find_first(new_bus);
    673         if (!phydev || phydev->mdio.addr > max_addr) {

This is an unpublished check because it assumes that every > comparison
is off by one unless proven otherwise.  In this case
max_addr is PHY_MAX_ADDR (32) and phydev->mdio.addr is also 32.

    674                 dev_warn(dev, "No PHY found\n");
    675                 err = -ENODEV;
    676                 goto no_phy_found;
    677         }
    678 
    679         /*
    680          * If an IRQ was provided to be assigned after
    681          * the bus probe, do it here.
    682          */
    683         if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
--> 684                 new_bus->irq[phydev->mdio.addr] = mdio_bus_data->probed_phy_irq;
                                     ^^^^^^^^^^^^^^^^^
Then this will corrupt memory.

    685                 phydev->irq = mdio_bus_data->probed_phy_irq;
    686         }
    687 
    688         /*
    689          * If we're going to bind the MAC to this PHY bus, and no PHY number
    690          * was provided to the MAC, use the one probed here.
    691          */
    692         if (priv->plat->phy_addr == -1)
    693                 priv->plat->phy_addr = phydev->mdio.addr;
    694 
    695         phy_attached_info(phydev);
    696 
    697 bus_register_done:
    698         priv->mii = new_bus;
    699 
    700         return 0;
    701 
    702 no_phy_found:
    703         mdiobus_unregister(new_bus);
    704 bus_register_fail:
    705         mdiobus_free(new_bus);
    706         return err;
    707 }

regards,
dan carpenter

