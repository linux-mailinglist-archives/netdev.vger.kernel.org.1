Return-Path: <netdev+bounces-45902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1347E0345
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4644E280DA4
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3B171B2;
	Fri,  3 Nov 2023 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="114y9TKm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28216422
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:01:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9F19D;
	Fri,  3 Nov 2023 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dGbTfODFaQzTymCMKEV4+gY6lqOjwrcNQtCi7t1dngQ=; b=114y9TKmgmpqZxfr5SUUGUwg3L
	CUYpXioth0kSgDDzNVy8SBlQ+UQzs/+w1iS6vooSrIrgednlC/U+5VEEOyngQOzvmURjwX6LPuD4r
	YO7NfhLU+F4rb++V3vo40Bz3688mScCQAaF6m/V2+Ual1GqI0b1/V4aVWhyG6+odvQLQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qytnV-000oat-W6; Fri, 03 Nov 2023 14:01:13 +0100
Date: Fri, 3 Nov 2023 14:01:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <806fb6b6-d9b6-457b-b079-48f8b958cc5a@lunn.ch>
References: <20231103123538.15735-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103123538.15735-1-quic_luoj@quicinc.com>

>  #define QCA8081_PHY_ID				0x004dd101
> +#define QCA8081_PHY_MASK			0xffffff00

That is an unusual mask. Please check it is correct. All you should
need its PHY_ID_MATCH_EXACT, PHY_ID_MATCH_MODEL, PHY_ID_MATCH_VENDOR.

> @@ -1767,6 +1781,20 @@ static int qca808x_config_init(struct phy_device *phydev)
>  {
>  	int ret;
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> +		/* Invert ADC clock edge */
> +		ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
> +					    QCA8084_ADC_CLK_SEL_ACLK,
> +					    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
> +						       QCA8084_ADC_CLK_SEL_ACLK_FALL));
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Adjust MSE threshold value to avoid link issue with some link partner */
> +		return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
> +				QCA8084_MSE_THRESHOLD, QCA8084_MSE_THRESHOLD_2P5G_VAL);
> +	}
> +

Please add a qca8084_config_init() and use that from the phy_driver
structure.

>  	/* Active adc&vga on 802.3az for the link 1000M and 100M */
>  	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
>  			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
> @@ -1958,6 +1986,11 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
>  	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
>  
> +	if (phydev->phy_id == QCA8084_PHY_ID) {
> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8075, 0xa060);
> +		phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807f, 0x1eb0);
> +	}
> +

Please add a comment what this is doing.

>  }, {
>  	/* Qualcomm QCA8081 */
> -	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
> -	.name			= "Qualcomm QCA8081",
> +	.phy_id			= QCA8081_PHY_ID,
> +	.phy_id_mask		= QCA8081_PHY_MASK,
> +	.name			= "Qualcomm QCA808X",

Please add a new entry for the 8084. 

       Andrew

