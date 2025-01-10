Return-Path: <netdev+bounces-157228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5CA0987E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B8C16AABA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F1213E75;
	Fri, 10 Jan 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7mwIpEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C85213E64;
	Fri, 10 Jan 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530069; cv=none; b=TvCO6SteydZJZ3DnPFGRgM0mBvRs8Kx1PE3fV32AOF0NJmmaQipK+Eb/ZfY4nvSAER1IqBwgBdUjbsFR9s/ftqjGPFyBA0HY+RAf2yoHQeLzFSJ3rgCR9qRyi83ILI8eoWXemjvUjNOToi+PINqNY271D9O3A5OJmbn0bTajiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530069; c=relaxed/simple;
	bh=66+vp09goA3DnbhKdfW10WUJkLNeuXFTkULTe0zNz0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bODsjbtEkv6FNkWNiXL+IVRQBdOAAFWk3VAh0LHEOhJRvyZjJSGpquTjVCxvwuod8Ft0jH/IVnrhPJSx8avjGl0fS49OD0zmdw3gCjv2A+vhbwhGO6D+w+PtOmj8Mn+/1tgSHSS98lZFu1o9XICGolr+nfNfiXE3SZtN/Q1UDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7mwIpEF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1293440f8f.2;
        Fri, 10 Jan 2025 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736530066; x=1737134866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y70TazRAzKLJfxs3UFYuoG9edRIAMSdYaHHcHNvhiHk=;
        b=A7mwIpEF4bzZktBbTuTYqkikMY7Ew+5DmfPfwatngns5quITPNIeYDRXE9EXrl7bFE
         TYkx2XyDStfCquj4lyK5nuXPVwz0QAnGm6cFIwzXtHyAFPjJWufpyVjIIFtNTkeprGe0
         QlcMdu5ypr1hDo3qaayrojjmG10Bux6a5jPAs6WJLbrB741UzFNEOkCOtMPZYsMJZxYC
         0ymEiJbAPu4dJjwFQz5i8H8Cy8jtzDGyGJIl8mj6ab3w8MHKS7WlxCF2l7jYpQAEuuO1
         GhUS86vj7X/2dSC/Bm48P501JXJcRHXlTUwk2h1e6zrB+aVqmGKPFPq8SE6nYzraDZA5
         Vk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530066; x=1737134866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y70TazRAzKLJfxs3UFYuoG9edRIAMSdYaHHcHNvhiHk=;
        b=KsamOS23xstCJ3997RFzFRNbKntq4aWWChj4ltPPfXCLvIlY7Er+UC//pHFfzjBOnv
         yp1eI1VSgNX+5s1cyFByqb4fn6IM/nziaZUFk9JPeqpt0xNlYPsqwSv48bIE0dmBqnrQ
         Oavr9KD2eFJMHVVyBMSBk+Giopods/uPLslI4YPPf2i82ceKLTCs8wrBGykTgMzc/Wtr
         DG+m+3QsK6i2mH3TxQe5kvYw9t0maM3GTOgttek8v3E+crz9i77ueN0DpaA1lpeDaYY2
         BG7eWb4yWtwGtyzW/EjNBF/wrPnA/9hvUgE43q4Eiuy00jIJS24liQi3i2RRp+kLbgQC
         qGQA==
X-Forwarded-Encrypted: i=1; AJvYcCUXpx7R28zzLPC5cHqhox5MOE6uS99b72ruspQI1ibo3FpwooaCBzolGLvgQpaC/X/FiY7GrfS2vWIfvTI=@vger.kernel.org, AJvYcCVoeR9qVHc6oHB4GdU2wik0zs+WQOM21DzYLkBN2fujclUGNb2lnGKFhWeJ9vdG0zBkoUAahb6P@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqBEwZjf45xYggNItpTgHhSre1mnkkaWECDN8v/vyImDlNp+v
	ukJ+zIZcUr85PepotycF12luK6z2wwCpID9K4ZKoPfkeRB+hZaY6
X-Gm-Gg: ASbGncsQDicqDV3DL36Jreb/K5g0r0Z5qAUK+0qeYcQvqM9nYYg3Kq/UkznAfIi2Y8e
	CrteEGa84HG2tP8R5U3ScSPXppwq510dd0EOMNH5slyS4fBqFLV/nwCrJzFuHQ2A9Pi2Mpzb8cX
	zDc+x4uQQI8cDVRcEGPpvTzLoPp7eDnsCl3Dxp2+wSayYv9PhKe7tTqA92gJrFsXq2pQivTfU/u
	qtKsslQZm0GIkXHZDnXo2c4JSNBmm/OwFziT6rkF9mxC+C9nwdZuj69
X-Google-Smtp-Source: AGHT+IGlZRijJZTdBbYFl8QjhHo2NinKz53bmadD7OTZDSZpFQ6OLEwzgLVY2sZGuT8CSYFC8o1AKw==
X-Received: by 2002:a5d:6da6:0:b0:385:e3d3:be1b with SMTP id ffacd0b85a97d-38a872e8f19mr10914052f8f.28.1736530065935;
        Fri, 10 Jan 2025 09:27:45 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:d0fc:3598:a372:ece6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd113sm95170465e9.25.2025.01.10.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:27:45 -0800 (PST)
Date: Fri, 10 Jan 2025 18:27:43 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <Z4FYjw596FQE4RMP@eichest-laptop>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>

Hi Dimitri ,

On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> Marvell 88Q2XXX devices support up to two configurable Light Emitting
> Diode (LED). Add minimal LED controller driver supporting the most common
> uses with the 'netdev' trigger.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/ethtool_netlink.h>
>  #include <linux/marvell_phy.h>
> +#include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/hwmon.h>
>  
> @@ -27,6 +28,9 @@
>  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
>  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
>  
> +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> +
>  #define MDIO_MMD_PCS_MV_INT_EN			32784
>  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
>  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> @@ -40,6 +44,15 @@
>  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
>  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
>  
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> +
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> @@ -95,6 +108,9 @@
>  
>  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
>  
> +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> +#define MV88Q2XXX_LED_INDEX_GPIO	1

Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
TX_ENABLE), is this a problem? Would we need a led_count variable per
chip? 

In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
pin. In the register description they just call it LED [0] Control and
LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.

> +
>  struct mmd_val {
>  	int devad;
>  	u32 regnum;
> @@ -741,8 +757,58 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_OF_MDIO)
> +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> +{
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	struct device_node *leds;
> +	int ret = 0;
> +	u32 index;
> +
> +	if (!node)
> +		return 0;
> +
> +	leds = of_get_child_by_name(node, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node_scoped(leds, led) {
> +		ret = of_property_read_u32(led, "reg", &index);
> +		if (ret)
> +			goto exit;
> +
> +		if (index > MV88Q2XXX_LED_INDEX_GPIO) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> +			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> +						 MDIO_MMD_PCS_MV_RESET_CTRL,
> +						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);

If I understand it correctly, this switches the function of the pin from
TX_DISABLE to GPIO? Can you maybe add a comment here?

Regards,
Stefan

