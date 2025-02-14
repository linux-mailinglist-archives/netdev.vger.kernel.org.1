Return-Path: <netdev+bounces-166521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0019CA36501
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F31E1718AE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCA268C54;
	Fri, 14 Feb 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="LrRl20Tl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DM4d0jLu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB0268C42;
	Fri, 14 Feb 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555558; cv=none; b=qDLh6Pz+gyjwB5Pi7N/rdFwYza9paPjnaVJbRGkRG0b63ZUud5cxMpIqfQE3Sjim1605zrDh+nnmenxnWtKD6M9E7n7vuDpYqz7kBRuvWGbOY5Fs23pjbREfR7Shss1pAqHYpADvIsKHDviPCoxLVnYZBcWC+yL2irZSQRZWuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555558; c=relaxed/simple;
	bh=Lip7qN3JcK6Yt5IvPXTuZfrkEoruXj4AW02UI1Pz9jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQKb2L/+HKl8MuNdaFFFQIDUF3uv3vxKMbwQH06i7AO0Lz3MTVPG1Ob3x+7f2eJKeTFkXG/zTWV+BLVNS2uo33jWsdfVnYXIX5VLiz05IuOV6O4CalY1eZs8AFZEsCYn6DnBPfO5AGtAZmRgW/vA6T0UPSqonIHiv9FtnR/AkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=LrRl20Tl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DM4d0jLu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B6AA2540115;
	Fri, 14 Feb 2025 12:52:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 14 Feb 2025 12:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739555555;
	 x=1739641955; bh=OuHerLoiYlUijccupvl/Wcae7xiqI+nuHvIG6lHY3oM=; b=
	LrRl20Tl0jYJovl6RUxYFA3RJsjHU7tKySuaNWnowQLdBCwx+z4gazjA5mn7w1Yu
	41j1sWX387+IGzkr6mVQVntccxqBspzwiu2YkMKvgrBkfuZWaawcMaQz+Crrq/6E
	kIfXbqOTaK3az+B1V+Puy3cr8d8m/0k4FR5EbIMt/XgPov8Zgh4DkdBHOnbAsdFR
	9Lvnw6Uy0/ZyaE60RiZISonULcGvfhA7TOgi//wrkRJUw6uH0FDujKFBFMojfeCv
	CmpifYo3pzXfshrQHkfPUoU/wFOiNlu7CiVCN29DmRdegJ24RMVniwt9YA36rO1x
	+rm6V6EyA2yQh3RBHr/YVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739555555; x=
	1739641955; bh=OuHerLoiYlUijccupvl/Wcae7xiqI+nuHvIG6lHY3oM=; b=D
	M4d0jLuCQHZxRn08AAMogTpP71DDrv/Kq0Gn1ZQfaAiW3xiioYsT+LkvY+VR3nys
	lcyyMUDjX8a0p7hV+mxVaYjRbdI2zOXoCOgwb9NqOnI5GB3Pha8dS/VTLa5zVydO
	sXWrKn+p1x3s1M9GD312mEYVzh6d32NztAAJNQo+iYbbQZS6HE5izyTg5Rer8H6P
	LQqLjpzdgGSD44OrAqDpH3wHYIOsmjSm/nJadb0xnbEyNrklP1DeDGGmBpEvDJU7
	mOosbIcw688NQN2eVqGSLmz9eZtHGUZB8FYDudKQdIh1XoCGTkcd8RqTMlvw6beT
	5F6Hh5ezrwjA1NSl5HwWw==
X-ME-Sender: <xms:4oKvZx91ZxPKq2m5DeJtW7ej2mi9HoOkqdcYTI4jfZXDq5gOf6Blng>
    <xme:4oKvZ1vU0FjakUX2jA3IX6dxZKqFn0KKClaM3m7-f5_aVSFqtYTMYkFlLuvRdzbor
    GW0E8PUO5RP4BdwbzQ>
X-ME-Received: <xmr:4oKvZ_CE-BSwyNY7u9qNeGcCtvHMv8cF21zYHGT8ReALcDPHUk9RsP4-uNt5DNDoDns96_IUIJRdFyqrjpz5xTGd3AGAYGhvng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsoh
    guvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgr
    thhtvghrnhepfefhleelhfffjefgfedugfegjeelhfevheeikefhueelgfdtfeeuhefftd
    dvleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    nhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrd
    hsvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peguihhmrgdrfhgvughrrghusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvg
    ifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehgrhgvghhorhdrhhgvrhgsuhhrghgvrhesvgifrdhtqhdqghhrohhuphdrtghomh
X-ME-Proxy: <xmx:4oKvZ1emYyecsSLMWa3Rkr5X2zGupBXlOBDKp_6CvMFLmodIwEl0gg>
    <xmx:4oKvZ2PBV1Md0xc4FONrna0veKNjeN7Hg9ikkZK0OLC5ek6opapvJw>
    <xmx:4oKvZ3nlRvbPnkopmcrLNtRbpLFpcwgdXFdaaS21H47uMOk_IfkU8w>
    <xmx:4oKvZwv8g3omXye2KriVMkDlTZaI5kkXJef6J8TMwEY8mcIjGcRGWQ>
    <xmx:44KvZykVIx8kp433OUJWCdDSBEI8sIzOjjoP5ElAhBxUPPnJCvNYTXxE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 12:52:34 -0500 (EST)
Date: Fri, 14 Feb 2025 18:52:31 +0100
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
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <20250214175231.GC2392035@ragnatech.se>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>

Hi Dimitri,

Thanks for your work.

On 2025-02-14 17:32:03 +0100, Dimitri Fedrau wrote:
> Align some defines.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/net/phy/marvell-88q2xxx.c | 62 +++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index bad5e7b2357da067bfd1ec6bd1307c42f5dc5c91..6e95de080bc65e8e8543d4effb9846fdd823a9d4 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -12,29 +12,29 @@
>  #include <linux/phy.h>
>  #include <linux/hwmon.h>
>  
> -#define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
> -#define PHY_ID_88Q2220_REVB1	(MARVELL_PHY_ID_88Q2220 | 0x2)
> -#define PHY_ID_88Q2220_REVB2	(MARVELL_PHY_ID_88Q2220 | 0x3)
> -
> -#define MDIO_MMD_AN_MV_STAT			32769
> -#define MDIO_MMD_AN_MV_STAT_ANEG		0x0100
> -#define MDIO_MMD_AN_MV_STAT_LOCAL_RX		0x1000
> -#define MDIO_MMD_AN_MV_STAT_REMOTE_RX		0x2000
> -#define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER	0x4000
> -#define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT	0x8000
> -
> -#define MDIO_MMD_AN_MV_STAT2			32794
> -#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED	0x0800
> -#define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> -#define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> -
> -#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> -#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> -
> -#define MDIO_MMD_PCS_MV_INT_EN			32784
> -#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> -#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> -#define MDIO_MMD_PCS_MV_INT_EN_100BT1		0x1000
> +#define PHY_ID_88Q2220_REVB0				(MARVELL_PHY_ID_88Q2220 | 0x1)
> +#define PHY_ID_88Q2220_REVB1				(MARVELL_PHY_ID_88Q2220 | 0x2)
> +#define PHY_ID_88Q2220_REVB2				(MARVELL_PHY_ID_88Q2220 | 0x3)
> +
> +#define MDIO_MMD_AN_MV_STAT				32769
> +#define MDIO_MMD_AN_MV_STAT_ANEG			0x0100
> +#define MDIO_MMD_AN_MV_STAT_LOCAL_RX			0x1000
> +#define MDIO_MMD_AN_MV_STAT_REMOTE_RX			0x2000
> +#define MDIO_MMD_AN_MV_STAT_LOCAL_MASTER		0x4000
> +#define MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT		0x8000
> +
> +#define MDIO_MMD_AN_MV_STAT2				32794
> +#define MDIO_MMD_AN_MV_STAT2_AN_RESOLVED		0x0800
> +#define MDIO_MMD_AN_MV_STAT2_100BT1			0x2000
> +#define MDIO_MMD_AN_MV_STAT2_1000BT1			0x4000
> +
> +#define MDIO_MMD_PCS_MV_RESET_CTRL			32768
> +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE		0x8
> +
> +#define MDIO_MMD_PCS_MV_INT_EN				32784
> +#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP			0x0040
> +#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN		0x0080
> +#define MDIO_MMD_PCS_MV_INT_EN_100BT1			0x1000
>  
>  #define MDIO_MMD_PCS_MV_GPIO_INT_STAT			32785
>  #define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP		0x0040
> @@ -80,11 +80,11 @@
>  #define MDIO_MMD_PCS_MV_100BT1_STAT1_REMOTE_RX		0x2000
>  #define MDIO_MMD_PCS_MV_100BT1_STAT1_LOCAL_MASTER	0x4000
>  
> -#define MDIO_MMD_PCS_MV_100BT1_STAT2		33033
> -#define MDIO_MMD_PCS_MV_100BT1_STAT2_JABBER	0x0001
> -#define MDIO_MMD_PCS_MV_100BT1_STAT2_POL	0x0002
> -#define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
> -#define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
> +#define MDIO_MMD_PCS_MV_100BT1_STAT2			33033
> +#define MDIO_MMD_PCS_MV_100BT1_STAT2_JABBER		0x0001
> +#define MDIO_MMD_PCS_MV_100BT1_STAT2_POL		0x0002
> +#define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK		0x0004
> +#define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE		0x0008
>  
>  #define MDIO_MMD_PCS_MV_100BT1_INT_EN			33042
>  #define MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT		0x0400
> @@ -92,7 +92,7 @@
>  #define MDIO_MMD_PCS_MV_COPPER_INT_STAT			33043
>  #define MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT	0x0400
>  
> -#define MDIO_MMD_PCS_MV_RX_STAT			33328
> +#define MDIO_MMD_PCS_MV_RX_STAT				33328
>  
>  #define MDIO_MMD_PCS_MV_TDR_RESET			65226
>  #define MDIO_MMD_PCS_MV_TDR_RESET_TDR_RST		0x1000
> @@ -115,8 +115,8 @@
>  
>  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
>  
> -#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> -#define MV88Q2XXX_LED_INDEX_GPIO	1
> +#define MV88Q2XXX_LED_INDEX_TX_ENABLE			0
> +#define MV88Q2XXX_LED_INDEX_GPIO			1
>  
>  struct mv88q2xxx_priv {
>  	bool enable_temp;
> 
> -- 
> 2.39.5
> 

-- 
Kind Regards,
Niklas Söderlund

