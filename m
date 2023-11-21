Return-Path: <netdev+bounces-49766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7E7F368D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C73C1C209D5
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4258111;
	Tue, 21 Nov 2023 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISW9tAm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497F4369A
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 18:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E211C433C8;
	Tue, 21 Nov 2023 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700592845;
	bh=co9lMUzvw3BfxT6r7XtEhDDe5hhA8tulVxZdHRcAkE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISW9tAm/yGrJQpNo6XTzZkUNwdPwdPqYh/2v/hvXHUByZDPwQ2x45l+FnJg8xw3kz
	 VZbZm7KoTgiEDbrLU9AekSnhiiCC3LTKiakbme3HPHemzht88vslNhl6XeS7sbAWip
	 jAYCp0KSMXy/MqW2S8DpkDiutWV6gqpja3FuMgNkpwMHYrPeVwCmhWWAYY+Lua7Ceq
	 q+ykpM9z9Le4JQ2Gt1lUOgWFwH1Lq1HHJYBxyVFSNL2cqfLCMF2TywHu0OyTPKfH1F
	 Z7n5XSZ/nTZSlAVtjV7hEDbQwlSBf2IAV/b1UKGPaHHn3BifFxyjmzH+ASLEZZxks6
	 iIuYq8OzNfbDg==
Date: Tue, 21 Nov 2023 18:53:58 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20231121185358.GA16629@kernel.org>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-8-arinc.unal@arinc9.com>

On Sat, Nov 18, 2023 at 03:31:57PM +0300, Arınç ÜNAL wrote:
> There's no need to run all the code on mt7530_setup_port5() if port 5 is
> disabled. The only case for calling mt7530_setup_port5() from
> mt7530_setup() is when PHY muxing is enabled. That is because port 5 is not
> defined as a port on the devicetree, therefore, it cannot be controlled by
> phylink.
> 
> Because of this, run mt7530_setup_port5() if priv->p5_intf_sel is
> P5_INTF_SEL_PHY_P0 or P5_INTF_SEL_PHY_P4. Remove the P5_DISABLED case from
> mt7530_setup_port5().
> 
> Stop initialising the interface variable as the remaining cases will always
> call mt7530_setup_port5() with it initialised.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  drivers/net/dsa/mt7530.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index fc87ec817672..1aab4c3f28b0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -942,9 +942,6 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
>  		/* MT7530_P5_MODE_GMAC: P5 -> External phy or 2nd GMAC */
>  		val &= ~MHWTRAP_P5_DIS;
>  		break;
> -	case P5_DISABLED:
> -		interface = PHY_INTERFACE_MODE_NA;
> -		break;
>  	default:
>  		dev_err(ds->dev, "Unsupported p5_intf_sel %d\n",
>  			priv->p5_intf_sel);
> @@ -2313,8 +2310,6 @@ mt7530_setup(struct dsa_switch *ds)
>  		 * Set priv->p5_intf_sel to the appropriate value if PHY muxing
>  		 * is detected.
>  		 */
> -		interface = PHY_INTERFACE_MODE_NA;
> -
>  		for_each_child_of_node(dn, mac_np) {
>  			if (!of_device_is_compatible(mac_np,
>  						     "mediatek,eth-mac"))
> @@ -2346,7 +2341,9 @@ mt7530_setup(struct dsa_switch *ds)
>  			break;
>  		}
>  
> -		mt7530_setup_port5(ds, interface);
> +		if (priv->p5_intf_sel == P5_INTF_SEL_PHY_P0 ||
> +		    priv->p5_intf_sel == P5_INTF_SEL_PHY_P4)
> +			mt7530_setup_port5(ds, interface);

Hi Arınç,

It appears that interface is now uninitialised here.

Flagged by Smatch.

>  	}
>  
>  #ifdef CONFIG_GPIOLIB
> -- 
> 2.40.1
> 

