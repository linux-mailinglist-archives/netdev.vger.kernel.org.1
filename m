Return-Path: <netdev+bounces-18442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F9756FC6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 00:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264BD1C20BCB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B4D11184;
	Mon, 17 Jul 2023 22:27:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312010977
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 22:27:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B6C0;
	Mon, 17 Jul 2023 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eokIwBNJv5OtIZE3uQ713rkqW4eN4iVKfN1MALeYmUA=; b=R8pOWROGxLsJn3q6owdrhbLuoZ
	edDM8s5U3mYHmqIMH32wwAV+PYc1ROKE9P3gR3GA2TmRS0vyc7bi6UY6pSF29amyzd9AG7s3hJsxE
	81nOpsRYwvvq6sR3PMkbqhvQVAftvLwAbRRYZsp+SJltnl89UXEJYl/pjlFHqPj+59ds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLWgI-001aGJ-CE; Tue, 18 Jul 2023 00:27:02 +0200
Date: Tue, 18 Jul 2023 00:27:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 2/2] net: stmmac: platform: add support for
 phy-supply
Message-ID: <cd8c177e-7840-4636-a039-dbe8884b3d2b@lunn.ch>
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
 <20230717164307.2868264-2-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717164307.2868264-2-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int stmmac_phy_power(struct platform_device *pdev,
> +			    struct plat_stmmacenet_data *plat,
> +			    bool enable)
> +{
> +	struct regulator *regulator = plat->phy_regulator;
> +	int ret = 0;
> +
> +	if (regulator) {
> +		if (enable)
> +			ret = regulator_enable(regulator);
> +		else
> +			regulator_disable(regulator);
> +	}
> +
> +	if (ret)
> +		dev_err(&pdev->dev, "Fail to enable regulator\n");

'enable' is only correct 50% of the time.

> @@ -742,6 +786,8 @@ static int __maybe_unused stmmac_pltfr_suspend(struct device *dev)
>  	if (priv->plat->exit)
>  		priv->plat->exit(pdev, priv->plat->bsp_priv);
>  
> +	stmmac_phy_power_off(pdev, priv->plat);
> +

What about WOL? You probably want to leave the PHY with power in that
case.

> @@ -757,6 +803,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  	struct platform_device *pdev = to_platform_device(dev);
> +	int ret;
> +
> +	ret = stmmac_phy_power_on(pdev, priv->plat);
> +	if (ret)
> +		return ret;

And this needs to balance with _suspend when WOL is being used.

    Andrew

