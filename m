Return-Path: <netdev+bounces-20033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C275D6BA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 23:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81582823CC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF4100A3;
	Fri, 21 Jul 2023 21:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A7F9E4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 21:45:01 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 14:45:00 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6E3A86
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:45:00 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gl-netdev-2@m.gmane-mx.org>)
	id 1qMxqt-0002Kf-2d
	for netdev@vger.kernel.org; Fri, 21 Jul 2023 23:39:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: netdev@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v1 2/5] net: hpe: Add GXP UMAC MDIO
Date: Fri, 21 Jul 2023 23:39:47 +0200
Message-ID: <d53ae62c-b5e3-d543-d7e9-93cd59d43415@wanadoo.fr>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-3-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: fr
In-Reply-To: <20230721212044.59666-3-nick.hawkins@hpe.com>
Cc: devicetree@vger.kernel.org,linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 21/07/2023 à 23:20, nick.hawkins@hpe.com a écrit :
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Universal Ethernet MACs that can be
> connected externally to several physical devices. From an external
> interface perspective the BMC provides two SERDES interface connections
> capable of either SGMII or 1000Base-X operation. The BMC also provides
> a RMII interface for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration. The MDIO(mdio1) interface from
> the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
> on the two SERDES interface connections.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---

[...]

> +static int umac_mdio_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	struct umac_mdio_priv *umac_mdio;
> +
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "fail to get resource\n");
> +		return -ENODEV;
> +	}
> +
> +	bus = devm_mdiobus_alloc_size(&pdev->dev,
> +				      sizeof(struct umac_mdio_priv));
> +	if (!bus) {
> +		dev_err(&pdev->dev, "failed to alloc mii bus\n");
> +		return -ENOMEM;
> +	}
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(&pdev->dev));
> +
> +	bus->name	= dev_name(&pdev->dev);
> +	bus->read	= umac_mdio_read,
> +	bus->write	= umac_mdio_write,
> +	bus->parent	= &pdev->dev;
> +	umac_mdio = bus->priv;
> +	umac_mdio->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!umac_mdio->base) {
> +		dev_err(&pdev->dev, "failed to do ioremap\n");
> +		return -ENODEV;
> +	}
> +
> +	platform_set_drvdata(pdev, umac_mdio);
> +
> +	ret = of_mdiobus_register(bus, pdev->dev.of_node);

devm_of_mdiobus_register()?

This makes the platform_set_drvdata() just above and umac_mdio_remove() 
useless.

CJ

> +
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int umac_mdio_remove(struct platform_device *pdev)
> +{
> +	struct mii_bus *bus = platform_get_drvdata(pdev);
> +
> +	if (bus)
> +		mdiobus_unregister(bus);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id umac_mdio_of_matches[] = {
> +	{ .compatible = "hpe,gxp-umac-mdio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, umac_mdio_of_matches);
> +
> +static struct platform_driver umac_driver = {
> +	.driver	= {
> +		.name    = "gxp-umac-mdio",
> +		.of_match_table = of_match_ptr(umac_mdio_of_matches),
> +	},
> +	.probe   = umac_mdio_probe,
> +	.remove  = umac_mdio_remove,
> +};
> +
> +module_platform_driver(umac_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP UMAC MDIO driver");
> +MODULE_LICENSE("GPL");



