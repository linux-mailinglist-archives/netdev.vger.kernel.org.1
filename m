Return-Path: <netdev+bounces-159219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B15F5A14D6E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED27818879E8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133F1FA8EB;
	Fri, 17 Jan 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QHzfqnYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4PB/wjj"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118141F8682;
	Fri, 17 Jan 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109168; cv=none; b=PJ9U0Gr1g4XVRDRRBVMoElc49sG5nQY5C72Qt/K1W6FBhXYtaCfbdKNpbGWM86dkHk/Tyf4ccODG8FdNxIuGFNjgSZV0kvv6XT+5Sr80bQf5jrTQMLVQRtAiXr4IzcBUUi8Dq0Y901SzgqTVWtSEHdlBd2QAkn/IyLK/gX33KQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109168; c=relaxed/simple;
	bh=xfH+xJBQEgFIKW0ZOqeYEE1RGUKUI+5XrcBjSVVII20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InPiVVyndUORzLqlPIIpH/DLgtxvqLLYaKRYWzE2cEWVhDjjbt3dzdxAfmUtj8oJyQc0qywHl9CmjKY/zFXXAeCcrcQuMt8lAYl2VyAUx1W1KgxQjVcPcAwlOwyY1fWWYej1UrD1kPWt6o7V8fwSOtoFp34jvkRYuNvd9bPvYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=QHzfqnYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4PB/wjj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C12861140153;
	Fri, 17 Jan 2025 05:19:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 05:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1737109164;
	 x=1737195564; bh=GtCIWUCrx0rlHBwr16r/uEODNWR1gvdry2oSPbxKVis=; b=
	QHzfqnYyMd5f3YT+JGD64n/W4NMUp1tAneJDKKEwswLvXIgLnUJFRUVMD7ev/YKK
	jj6Na1Sn4HlXn7aSGf4mdWacRFfh4lTE5avwIjvRkpym9KBa9W1H/ewTBOPo8xiH
	+OmKe6czwVSEc4H8i7ONNuriyTKWzSii4siE47u1ZRGlQfFXYjhiSUwRG55hyRq4
	3pnJnM+DvnC6+hbKwGym1yqeyLY+JIZ9SxSFA6PjUrFUIcudhTiW77exqMR2kymV
	DVZwC7+stba0Y4Xco2uXpuSqLgCakx+nGUDWuqXXP+FHqOpNBC40mmYYqCrb8NuG
	cDlVo7m3gVskLSmbKleYMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737109164; x=
	1737195564; bh=GtCIWUCrx0rlHBwr16r/uEODNWR1gvdry2oSPbxKVis=; b=g
	4PB/wjjCg3Y4bxNkJ0Ht1bSPdMKO/bwjX/hLantOygjcc7YKnvym/dy8qXrvwRQL
	ItKA3LqNliCy9ZUmeSDMVP/NgGfZHm6SGCDBpMIX4/kV1+FUys43OYYzj52gugTp
	Kv33iHfhUlSS5PrEcWRFQJRVwBpYN/OGfrPLMxyl8IW0/adtyxdzKClq1+MizrHt
	GS9fCz13ov3bFdzK6N+uA7BbSyNr/+wOoattiVdWwQsEiKPHuC+VY8U5ZBCKi7OG
	nzAG9Yti26Z/nLWbfkmNaTI7qnTWHGJQCCd8ieYQNvNgU9AKnDTyKQleHOdFjH2m
	82Slx91rSsd28OiboJzZw==
X-ME-Sender: <xms:qy6KZ48Qaplj5pZa0959dmh_uZTy9nj4ZdWp_MyXgGCetVY-k6YGUQ>
    <xme:qy6KZwuj0yroq_628twwzJqBaxeP3sak93sq6ZbmvJ_nnIbribANSHse_8XohLZXp
    W0TWTpvX1S78db1V-s>
X-ME-Received: <xmr:qy6KZ-ClHDAb_6CY7YAaGrYi9icmVjx3Gp3pRLvicwnEyERr7LOxfSDFA_7KIgT0LYAS-jDSLko1VN9CyEbV1S1xpCU1EtKsKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhoug
    gvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrght
    thgvrhhnpeefhfellefhffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvd
    elieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehn
    ihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrsh
    gvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ughimhgrrdhfvggurhgruhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfi
    eslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    ghhrvghgohhrrdhhvghrsghurhhgvghrsegvfidrthhqqdhgrhhouhhprdgtohhm
X-ME-Proxy: <xmx:qy6KZ4dMnagc-GSGHQWNs8Rp5PPlQp-a7Xup4xl0wFwWXM9bwRjDqw>
    <xmx:qy6KZ9Ojcvhg4oXUCGcW1av9ULECzOgCgOChlGzBexSviIy6xlry8g>
    <xmx:qy6KZynvaUm4EnnnlkU2rqunzRYhn99wZp5ZIjD44YLWrcQDgq71Jw>
    <xmx:qy6KZ_s7Y-lBnYLtRWp1lNXpjdB2bC6kF9QqAvY9SsatYc4mftMpqw>
    <xmx:rC6KZxkxEv0qVAh2s2XocbKvcsLFe84Mn79Ds9susBNmSyhBcA3zCsvw>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 05:19:23 -0500 (EST)
Date: Fri, 17 Jan 2025 11:19:21 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
Message-ID: <20250117101921.GE873961@ragnatech.se>
References: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>

Hello Dimitri,

Thanks for your work.

On 2025-01-16 16:37:44 +0100, Dimitri Fedrau wrote:
> When using temperature measurement on Marvell 88Q2XXX devices and the
> reset-gpios property is set in DT, the device does a hardware reset when
> interface is brought down and up again. That means that the content of
> the register MDIO_MMD_PCS_MV_TEMP_SENSOR2 is reset to default and that
> leads to permanent deactivation of the temperature measurement, because
> activation is done in mv88q2xxx_probe. To fix this move activation of
> temperature measurement to mv88q222x_config_init.

I only have access to a mv88q2110 device so I can't test the change, but 
it looks good.

> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/net/phy/marvell-88q2xxx.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 4494b3e39ce2b672efe49d53d7021b765def6aa6..a3996471a1c9a5d4060d5d19ce44aa70e902a83f 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -95,6 +95,10 @@
>  
>  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
>  
> +struct mv88q2xxx_priv {
> +	bool enable_temp;
> +};
> +
>  struct mmd_val {
>  	int devad;
>  	u32 regnum;
> @@ -710,17 +714,12 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
>  
>  static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  {
> +	struct mv88q2xxx_priv *priv = phydev->priv;
>  	struct device *dev = &phydev->mdio.dev;
>  	struct device *hwmon;
>  	char *hwmon_name;
> -	int ret;
> -
> -	/* Enable temperature sense */
> -	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> -			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> -	if (ret < 0)
> -		return ret;
>  
> +	priv->enable_temp = true;
>  	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
>  	if (IS_ERR(hwmon_name))
>  		return PTR_ERR(hwmon_name);
> @@ -743,6 +742,14 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  
>  static int mv88q2xxx_probe(struct phy_device *phydev)
>  {
> +	struct mv88q2xxx_priv *priv;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
>  	return mv88q2xxx_hwmon_probe(phydev);
>  }
>  
> @@ -810,6 +817,18 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
>  
>  static int mv88q222x_config_init(struct phy_device *phydev)
>  {
> +	struct mv88q2xxx_priv *priv = phydev->priv;
> +	int ret;
> +
> +	/* Enable temperature sense */
> +	if (priv->enable_temp) {
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
>  		return mv88q222x_revb0_config_init(phydev);
>  	else
> 
> ---
> base-commit: b44e27b4df1a1cd3fd84cf26c82156ed0301575f
> change-id: 20250116-marvell-88q2xxx-fix-hwmon-d6700aae9227
> 
> Best regards,
> -- 
> Dimitri Fedrau <dima.fedrau@gmail.com>
> 

-- 
Kind Regards,
Niklas Söderlund

