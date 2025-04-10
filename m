Return-Path: <netdev+bounces-181195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9AA840B9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3687B4E57
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3CC280CCA;
	Thu, 10 Apr 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z5KSZ7nJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGIH6PgK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328227C174;
	Thu, 10 Apr 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281091; cv=none; b=nqfosNtgGl8AmPZAJiz1dAwu5aOyGxdCcP7pewdao4WHG20lPgkHVeZ4NBDXuOcmOg3s+hJ70frgyhIFbZ5CDmB6XKEZhWXWtoJ5qL7Jw2IEVreHcJzwjsimoy9ljaTFV9y2ZaB1n2obiub4yLqLAP0zWm1qhgLsqieEUWff+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281091; c=relaxed/simple;
	bh=opPUQXMhWtBJmc7jz6lSZrMMt13KBQ4R3PfYwixknn8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JSOim4aXVuaX5/riqwU30GLuEPJRcT9vTQ8IcKi3UcLjnxUeJPvIrFZLmE4C0dVL1IZol7eqWYV7QmBDK/Ys9u8WGBrIQv0UUOoKwLXzEMSIc4/TZ1ZBj4Z90GJYycLIG4nUbxw2jnv0Dn2OIe2C4yNt4VVEAMKmukUdHAU/ajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z5KSZ7nJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGIH6PgK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3584C114010E;
	Thu, 10 Apr 2025 06:31:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744281087;
	 x=1744367487; bh=V0yBdNIFiNFE1FpbrRAP6wKPm7LpSS3P6fwzuoGhPPM=; b=
	Z5KSZ7nJVbdwy9BhFww8lYpEdyJhzZWk9XLxTa+UG6uUBBj2rdqhWZasS+ErZ8br
	mmUPLlBEmpfYJIDD7uVeMUmMYiBjyGZgs/HwTvPomyyTjU/hsaS+Tj3qnpELuLOW
	UiSzIvC0FQbWRGhRVBBXcm5geduHs3X895U2faeoAz/I5BqKN9n2YdT7xQ7kbv8i
	kcvro6iOqTcI77aVWnuwZOEp8rXsVe0E9jGXy+BcNgQKQN2DZZf6LzTqj1+gG7Eb
	o6eQdAVs+cHkzQZfEL3E9l7Q1Dqnhh2Kq66Nt7WPvABBc7ABXFmP/yijnqgrsiLE
	QdcVLp7yRrgF3tTiOEeMiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744281087; x=1744367487; bh=V
	0yBdNIFiNFE1FpbrRAP6wKPm7LpSS3P6fwzuoGhPPM=; b=UGIH6PgKM3vhT2VIE
	aBFuE80+Eqjo+S2oIkcsH9rO6OwI2i3iLbm8V+IIiqH0iRGxiyvau0fMgSetdXrC
	vPTxWhYmJRX7ieCba6fEtWSxY5nLKN9h5hcPaR2XNdUEKmXCiPv3IXWJmLv09J7w
	UZ1zoymlOy0QxnMDOpVjw1XjPQ7a7nHmdxM5CMx77iaEGbSpb/l3nljsOmUCZOAj
	jXoaw5SEJ+wb64IkHMKhSZ4pEvqjMSNEAf76Rasxzb+zsVAm1gNIJSByrqa2X7Ki
	pFnGJ1GHzJvrrYnvjw6iZDr17tCrP4klibJT2pQKIsXB8MJzbkXrtA06Bd0Z9B3W
	DEUtA==
X-ME-Sender: <xms:_Z33Z0X5BqMn_cSrL6aNS3-Obxa46Z30GQgcGGj5mGDQ2U_QPS42pw>
    <xme:_Z33Z4k8fpfX5TEMQkjQr9zko--N8gtzQjf_0X_bMjOnXUkuE--Xg7CRb7_hv1H9e
    i65puKGMioFG0Teklw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggv
    lhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhhsuhgvlhhsmhhthhesghhmrghi
    lhdrtghomhdprhgtphhtthhopeguqhhfvgigthesghhmrghilhdrtghomhdprhgtphhtth
    hopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhh
    ihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdr
    ohhrgh
X-ME-Proxy: <xmx:_Z33Z4Y0z37CzBhOWyz0En_d25z8H-7acC6HizYeN82BV-W20FZqUA>
    <xmx:_Z33ZzUt1QtGrN8Djm48g4a2K4XfLgUtr5tKUMuMsIgGpV6FRSmoSw>
    <xmx:_Z33Z-mhgW8KNjQWLry_fGsAqqkVl8MtKBxcdRwxElndIhjGUvRyAQ>
    <xmx:_Z33Z4fiW8MWbivsSOLRkzI2hBWPm-P9xIDG-hopMChnOXfz_poiPA>
    <xmx:_533Z4eNW4OfL-TJflZ4WA5fweG31XUM5p8BeO5Qwv_WwyvyJp7acXfw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E3E72220073; Thu, 10 Apr 2025 06:31:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2340d8c52bdbc82d
Date: Thu, 10 Apr 2025 12:31:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Marangi" <ansuelsmth@gmail.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Daniel Golle" <daniel@makrotopia.org>,
 "Qingfang Deng" <dqfext@gmail.com>,
 "SkyLake Huang" <SkyLake.Huang@mediatek.com>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Simon Horman" <horms@kernel.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Message-Id: <c108aee9-f668-4cd7-b276-d5e0a266eaa4@app.fastmail.com>
In-Reply-To: <20250410100410.348-1-ansuelsmth@gmail.com>
References: <20250410100410.348-1-ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: mediatek: permit to compile test GE SOC
 PHY driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 10, 2025, at 12:04, Christian Marangi wrote:
> When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
> dependencies") fixed the dependency, it should have also introduced
> an or on COMPILE_TEST to permit this driver to be compile-tested even if
> NVMEM_MTK_EFUSE wasn't selected

Why does this matter? NVMEM_MTK_EFUSE can be enabled for both
allmodconfig and randconfig builds on any architecture, so you
get build coverage either way, it's just a little less likely
to be enabled in randconfig I guess?

> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> index 2a8ac5aed0f8..6a4c2b328c41 100644
> --- a/drivers/net/phy/mediatek/Kconfig
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -15,8 +15,7 @@ config MEDIATEK_GE_PHY
> 
>  config MEDIATEK_GE_SOC_PHY
>  	tristate "MediaTek SoC Ethernet PHYs"
> -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> -	depends on NVMEM_MTK_EFUSE
> +	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
>  	select MTK_NET_PHYLIB
>  	help
>  	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> -- 

I would expect this to break the build with CONFIG_NVMEM=m
and MEDIATEK_GE_SOC_PHY=y.

The normal thing here would be to have a dependency on
CONFIG_NVMEM in place of the NVMEM_MTK_EFUSE dependency,
or possible on 'NVMEM || !NVMEM' if you want to make it
more likely to be enabled in randconfig builds.

       Arnd

