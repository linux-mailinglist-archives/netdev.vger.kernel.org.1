Return-Path: <netdev+bounces-42252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8C7CDDE1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8797281D57
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507236AF4;
	Wed, 18 Oct 2023 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rpKkGHaV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E626335C2;
	Wed, 18 Oct 2023 13:52:38 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D610D;
	Wed, 18 Oct 2023 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MdxbVK2tvmk2aLnaTFO7BqSkjrur0tS0YlDENPEDgcE=; b=rpKkGHaVMoFaAaL0mv2cFROH8Y
	ow9MAkCO2kA5IGxvNkqn9LUSPgpbYKRaRgkXIPYc9fuve+vBSH0MPHtU1oAXTV5kkHWbCMkVQMbBx
	82d/Tqt0FYTImfXx6h13iTt9+XiIy6d+f1O0MX3oOPaJtUTf6y4c3PBmlR2X5EBPAtGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qt6yJ-002aVA-SP; Wed, 18 Oct 2023 15:52:27 +0200
Date: Wed, 18 Oct 2023 15:52:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to
 select internal RMII reference clock
Message-ID: <92a18413-fa28-4420-88f8-e7dedaa8c45e@lunn.ch>
References: <351f7993397a496bf7d6d79b9096079a41157919.1697620929.git.ante.knezic@helmholz.de>
 <893a3ad19b28c6bb1bf5ea18dee2fa5855f0c207.1697620929.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893a3ad19b28c6bb1bf5ea18dee2fa5855f0c207.1697620929.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 11:24:14AM +0200, Ante Knezic wrote:
> Microchip KSZ8863/KSZ8873 have the ability to select between internal
> and external RMII reference clock. By default, reference clock
> needs to be provided via REFCLKI_3 pin. If required, device can be
> setup to provide RMII clock internally so that REFCLKI_3 pin can be
> left unconnected.
> Add a new "microchip,rmii-clk-internal" property which will set
> RMII clock reference to internal. If property is not set, reference
> clock needs to be provided externally.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  drivers/net/dsa/microchip/ksz8795.c     | 10 +++++++++-
>  drivers/net/dsa/microchip/ksz8795_reg.h |  3 +++
>  drivers/net/dsa/microchip/ksz_common.h  |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 91aba470fb2f..b50ad9552c65 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -1312,8 +1312,16 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  	ksz_port_cfg(dev, port, P_PRIO_CTRL, PORT_802_1P_ENABLE, true);
>  
>  	if (cpu_port) {
> -		if (!ksz_is_ksz88x3(dev))
> +		if (!ksz_is_ksz88x3(dev)) {
>  			ksz8795_cpu_interface_select(dev, port);
> +		} else {
> +			dev->rmii_clk_internal = of_property_read_bool(dev->dev->of_node,
> +								       "microchip,rmii-clk-internal");
> +
> +			ksz_cfg(dev, KSZ88X3_REG_FVID_AND_HOST_MODE,
> +				KSZ88X3_PORT3_RMII_CLK_INTERNAL,
> +				dev->rmii_clk_internal);
> +		}

It looks like this is the only use of dev->rmii_clk_internal? So does
it actually need to be a member of ksz_device? 

   Andrew

