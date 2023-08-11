Return-Path: <netdev+bounces-26907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFADA7794AC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94702824BC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEAE1172E;
	Fri, 11 Aug 2023 16:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A7360C5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:30:08 +0000 (UTC)
Received: from out-109.mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA10109
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:30:07 -0700 (PDT)
Message-ID: <ac6a4318-3a47-2c77-6b81-b5f04765c04e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691771405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkTa9G5S/FeoXOCCv/+crAQmvYZG+/2VvbNesTP1weA=;
	b=Na4dtDhbGnLWU675SQ8MrLY3u2OqKGbns6Lg7/4w7dRyehX/GunZOzdk7UcBWfU4GMOQHw
	JpS2ikfpkKxF56Qc53ssyVsSgwbzw3jInK1ebxB7kWaHkHg7af4BiRe7IpBTAlVt6oj62w
	wfUePsjO4BbpjBVEGt7x7ckrqh9DWPw=
Date: Fri, 11 Aug 2023 17:30:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: mediatek-ge-soc: support PHY LEDs
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a21288bf80f26dda6c9729edb5b25d0995df5e38.1691724757.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 04:35, Daniel Golle wrote:
> Implement netdev trigger and primitive bliking offloading as well as
> simple set_brigthness function for both PHY LEDs of the in-SoC PHYs
> found in MT7981 and MT7988.
> 
> On MT7988 it is necessary to read the boottrap register and apply LED
> polarities accordingly to get uniform behavior from all LEDs.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

[...]

> +
> +static int mt7988_phy_fix_leds_polarities(struct phy_device *phydev)
> +{
> +	struct pinctrl *pinctrl;
> +	int index;
> +
> +	/* Setup LED polarity according to bootstrap use of LED pins */
> +	for (index = 0; index < 2; ++index)
> +		phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
> +				MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
> +			       MTK_PHY_LED_ON_POLARITY,
> +			       mt7988_phy_led_get_polarity(phydev, index) ?
> +				MTK_PHY_LED_ON_POLARITY : 0);
> +
> +	/* Only now setup pinctrl to avoid bogus blinking */
> +	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");

This function gets reference on phydev->mdio.dev, but there is no code
to release it. It looks like a leak which will prevent module unload,
but I don't have hardware now to prove it.

> +	if (IS_ERR(pinctrl))
> +		dev_err(&phydev->mdio.bus->dev, "Failed to setup PHY LED pinctrl\n");
> +
> +	return 0;
> +}


