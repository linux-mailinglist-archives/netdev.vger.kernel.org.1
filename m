Return-Path: <netdev+bounces-247185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E0CF5624
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A349030E5050
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21733F397;
	Mon,  5 Jan 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0lSVVHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DC31B836
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641425; cv=none; b=CwV9jR4xPirgMCjaSFGyC2tMNW1L6NTcGo9fFgvtQ0mAvwv6+7S2jx/DInXhDzv1/V5W0TWtUJ83kFaZIyHYXoj++bjGBDisJ1f47nM/CVBaYTZ6T+ApgeXztk4rB5lSUQ98/UqQYtEXJrdimAFSY+PmiXgIpK5PBEHtDCDn2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641425; c=relaxed/simple;
	bh=jk017enyCY0MubT0YFx9+1GhXlNdXEhZMuEWdoIF9dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDeMAw7OTqoDT7cWO/zZ3zUg/wHWE8aYoTo/r1UQsea3y1rV4ybVrLNiVks+Mdiy/S79bnhNlsLFDRyeGLM44RWTgpV+g4vqI8Yv8X8X1/KwnhEFgRCb9WsQkzKT7oAynXOdZVnl9AvBWaAZXeK+dj+V5rMwdbc4vxbZhlzbPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0lSVVHR; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47798f4059fso393015e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641420; x=1768246220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNW0iCCo5tpZtmL9/mWOiumOafwQ/3mQ8ApPqR8WIss=;
        b=a0lSVVHRpKfWO0Vo1rqnH4c4Hu9duJUWOtwV12JYu2KCAku+wDi8q1UfP06BST+Mns
         +bh9/dCf3mGL8S7bNcm6Y8qnPnuzZA64HqlgPHXMmYdRP/5LnZNUg8vCcz1ODvRJcY2I
         2WkfvWl6bh9PAAgfQ8khiREJ7B/XLqAdlMY+X27wLcKVpsUdr9w+kMQMzOlp6iiKdeXn
         hBdREvNnleH4VJjp0hip5FaHs6rr3bDHzUoKiOPeqogNgzLIHpH+1YauG6tAvQwbRUCQ
         DTW+E1RL4tEQpCQg037XbBHFyqANdnhN5arpNVugJZrE+wCPWhIOf9kr+Da6QQFGG7eb
         69fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641420; x=1768246220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNW0iCCo5tpZtmL9/mWOiumOafwQ/3mQ8ApPqR8WIss=;
        b=tiBH2NGAmvLoSlm/tHiyjHtMEdRbFgVnxmG4ufJf8QJALgUGMjZLnqtKDzPSRr+KwQ
         MAJS7KGzm01d0KShY60WfE+JBNDFBoCJusnuAf/x9MYuIAMRTTYNsr08euB+mUQSMT8d
         7oq9/aozGR35U4UCQeUXQJpSjTGtpTfXCVBK/Vrjd9rimPt4DDcSFcDVYdeF8+szTMXL
         RL1E0LCthbyZLHJfFUymwsF8JH5augsCwyG0g6SKL0fK1hBYrX4BO/knbV/tC1rBeLnB
         P6S875gxjWfY7c/kpsOS9QFgw5ND3rl2nHJgK/L3tFPqq5iLXeSOPTYiCOm3MkxOV0a5
         OkIA==
X-Gm-Message-State: AOJu0YzL+1lu2CbBivkUIF06Pba2hLuGF72HTDVs8CukTEfTcYQsCJh5
	3Qumea9ALO4TBHpDAXW8815Z4CoWfdcgdFGKx6SngzjgK+Hy2eXI8CGK
X-Gm-Gg: AY/fxX55nwp+Y5/ogdZfnokdmcwN6cZAbNRtEH0NOm6LltqnF6jewWjVlc7C2mU8+wO
	UWjpS1M0TAkcA29JuzS2GquY2QswfrunPApSCDCAu+0CznnwPs72pJyt9iQYYjAcKqyK9txwJmx
	IQ9e8/dohdXZKG/mH63Wr6N3zz6+Xnt1XDDvlpWyJ381WwqJNFjRgG5NOASV11EK4STLpKTxTwA
	LrxtAbtrWtIEE4zKbJqgRb4Z5bfyTynrEik1NC4/t3zodPfjNdJev1tnuRnrJDmikohCFW4PMfP
	KAEMe58wB5uxw/BHjUan+J2eO4M/GouqhnZWqzST0MRHumcRBCvWy4WrSSSiO+r+/COvt+mPBxF
	9K+S1nDnB4xaxhbeGYqx3PSIq/SVJ6aFrxV4hFseHwEzRRo2TGVBUF88WfLq/5LgGNuF0gO80ns
	HxSw==
X-Google-Smtp-Source: AGHT+IHwZzU5FZzh6NQxafc7OaAUsOfBFPnuTk0t/DBCRISPJiemadkoEI7ZUKSbKxXi6Ztaw7wmOg==
X-Received: by 2002:a05:6000:144c:b0:42b:3ad7:fdbb with SMTP id ffacd0b85a97d-432bc9ef071mr678765f8f.3.1767641420066;
        Mon, 05 Jan 2026 11:30:20 -0800 (PST)
Received: from skbuf ([2a02:2f04:d804:300:888b:7b37:c8bc:6130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm218672f8f.8.2026.01.05.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:30:18 -0800 (PST)
Date: Mon, 5 Jan 2026 21:30:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Message-ID: <20260105193016.jlnsvgavlilhync7@skbuf>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
 <20260105175320.2141753-3-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105175320.2141753-3-alexander.sverdlin@siemens.com>

Hi Alexander,

On Mon, Jan 05, 2026 at 06:53:11PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Support newly introduced slew-rate device tree property to configure
> R(G)MII interface pins slew rate. It might be used to reduce the radiated
> emissions.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v3:
> - use [pinctrl] standard "slew-rate" property as suggested by Rob
>   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
> - better sorted struct gswip_hw_info initialisers as suggested by Daniel
> v2:
> - do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
>   introduce struct gswip_hw_info::port_setup callback
> - actively configure "normal" slew rate (if the new DT property is missing)
> - properly use regmap_set_bits() (v1 had reg and value mixed up)
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.h        |  1 +
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c |  6 ++++
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 31 ++++++++++++++++++++
>  drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 ++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 2e0f2afbadbbc..8fc4c7cc5283a 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -263,6 +263,7 @@ struct gswip_hw_info {
>  				 struct phylink_config *config);
>  	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
>  					      phy_interface_t interface);
> +	int (*port_setup)(struct dsa_switch *ds, int port);
>  };
>  
>  struct gswip_gphy_fw {
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index e790f2ef75884..17a61e445f00f 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -425,6 +425,12 @@ static int gswip_port_setup(struct dsa_switch *ds, int port)
>  	struct gswip_priv *priv = ds->priv;
>  	int err;
>  
> +	if (priv->hw_info->port_setup) {
> +		err = priv->hw_info->port_setup(ds, port);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (!dsa_is_cpu_port(ds, port)) {
>  		err = gswip_add_single_port_br(priv, port, true);
>  		if (err)
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index f8ff8a604bf53..6c290bac537ad 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -559,6 +559,34 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
>  	}
>  }
>  
> +static int gsw1xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct gsw1xx_priv *gsw1xx_priv;
> +	struct gswip_priv *gswip_priv;
> +	u32 rate;
> +	int ret;
> +
> +	if (dp->index != GSW1XX_MII_PORT)
> +		return 0;
> +
> +	gswip_priv = ds->priv;
> +	gsw1xx_priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
> +
> +	ret = of_property_read_u32(dp->dn, "slew-rate", &rate);
> +	/* Optional property */
> +	if (ret == -EINVAL)
> +		return 0;
> +	if (ret < 0 || rate > 1) {
> +		dev_err(&gsw1xx_priv->mdio_dev->dev, "Invalid slew-rate\n");
> +		return (ret < 0) ? ret : -EINVAL;
> +	}
> +
> +	return regmap_update_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
> +				  RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC,
> +				  (RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC) * rate);

I don't have a particularly strong EE background, but my understanding
is this:

RGMII MACs provide individual slew rate configuration for TXD[3:0] and
for TX_CLK because normally, you'd want to focus on the TX_CLK slew rate
(in the sense of reducing EMI) more than on the TXD[3:0] slew rate.
This is for 2 reasons:
(1) the EMI noise produced by TX_CLK is in a much narrower spectrum
    (runs at fixed 125/25/2.5 MHz) than TXD[3:0] (pseudo-random data).
(2) reducing the slew rate for TXD[3:0] risks introducing inter-symbol
    interference, risk which does not exist for TX_CLK

Your dt-binding does not permit configuring the slew rates separately,
even though the hardware permits that. Was it intentional?

> +}
> +
>  static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
>  					 const char *name,
>  					 unsigned int reg_base,
> @@ -707,6 +735,7 @@ static const struct gswip_hw_info gsw12x_data = {
>  	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
>  	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
>  	.supports_2500m		= true,
> +	.port_setup		= gsw1xx_port_setup,
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> @@ -720,6 +749,7 @@ static const struct gswip_hw_info gsw140_data = {
>  	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
>  	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
>  	.supports_2500m		= true,
> +	.port_setup		= gsw1xx_port_setup,
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> @@ -732,6 +762,7 @@ static const struct gswip_hw_info gsw141_data = {
>  	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
>  	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
>  	.phylink_get_caps	= gsw1xx_phylink_get_caps,
> +	.port_setup		= gsw1xx_port_setup,
>  	.pce_microcode		= &gsw1xx_pce_microcode,
>  	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
>  	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> index 38e03c048a26c..8c0298b2b7663 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> @@ -110,6 +110,8 @@
>  #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
>  /* RGMII PAD Slew Control Register */
>  #define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
> +#define   RGMII_SLEW_CFG_DRV_TXC		BIT(2)
> +#define   RGMII_SLEW_CFG_DRV_TXD		BIT(3)
>  #define   RGMII_SLEW_CFG_RX_2_5_V		BIT(4)
>  #define   RGMII_SLEW_CFG_TX_2_5_V		BIT(5)
>  
> -- 
> 2.52.0
> 

