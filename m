Return-Path: <netdev+bounces-212026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E0B1D547
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E049916B1D1
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351172248BA;
	Thu,  7 Aug 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ur8avi2j"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A611DED5C;
	Thu,  7 Aug 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560227; cv=none; b=ecJ8NCe3vejM107uMeZzDlMjIQQqze6zelpNcQOQeJgvQLMLTXi1L1nNSlw7NssvS0m82RJjlYheEOee6gNZAruuMxUYYPxHP0WccWkJxKod2uVt132X0ul4JkAVSGVWyn0QGigLwCsZ9afQN5EfzN8HLe6+UcboJb1WUZXldOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560227; c=relaxed/simple;
	bh=zNlml1UCdpfFEi8OpKphMeqD2CluP70X/mlWqFfABf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd1nzgq2UytQSnCVxjoEftCeyAAhfI5sMhBJO7l6zbbRU9amXlaTz2IQzUJXZyMCiuvbq6al2sj9XE3ThBtjgQxtKqjnGREVDAXxnb/XDdYjmBJY6RpjmH9VOLf3OQDAW2jVi/NEmLGME78Q9nUTp7wR5/R5FaU0BoUQkvmUJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ur8avi2j; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=KGDncYSsxc1ieNgfCKAG+ROM7VI2/GSPqA10lbXeo/8=; b=Ur8avi2jIr7rJcClT5zqUgfiTf
	5OdTsiHg4ofdRsA5qF0vl+bWhAORYX+r0VoLxzTYm5rsLl/1sRcZWB1Rjuju5imafvsp5DL8MbXmG
	uP5RfDczseyIPsUIdxRAJ2YejisCirz0DS9hgAkaI4r6yvJR4Ot+HyZa81Brb4oiponV+Yi6ctdt4
	UoW3xk1yBFbuwKXXFfgiAFJhnIbpN6yA+RNoIEKnpTBseMKw/UBdsHMH2bfiz/uFg70PdV36K4ZDR
	8wPwBsgHuRX2LmNlNzgII8Q2NCDtAPZd15W4m9ql1bQ3JbNfkK9ANJS4FkSEFd2zEDMyHb693ztpM
	25xQXmSA==;
Received: from i53875a15.versanet.de ([83.135.90.21] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ujxGB-00078w-Kn; Thu, 07 Aug 2025 11:50:07 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Jijie Shao <shaojijie@huawei.com>
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shaojijie@huawei.com
Subject:
 Re: [PATCH net-next 1/2] net: phy: motorcomm: Add support for PHY LEDs on
 YT8521
Date: Thu, 07 Aug 2025 11:50:06 +0200
Message-ID: <7978337.lvqk35OSZv@diego>
In-Reply-To: <20250716100041.2833168-2-shaojijie@huawei.com>
References:
 <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 16. Juli 2025, 12:00:40 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Jijie Shao:
> Add minimal LED controller driver supporting
> the most common uses with the 'netdev' trigger.
>=20
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

On a Qnap TS233 NAS using this phy, I get the expected device LEDs
to light up (with appropriate config via sysfs), so

Tested-by: Heiko Stuebner <heiko@sntech.de>

(haven't found a v2 yet yesterday, so hopefully still the right thread
to reply to ;-) )

Thanks
Heiko


> ---
>  drivers/net/phy/motorcomm.c | 120 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>=20
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 0e91f5d1a4fd..e1a1c3a1c9d0 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -213,6 +213,23 @@
>  #define YT8521_RC1R_RGMII_2_100_NS		14
>  #define YT8521_RC1R_RGMII_2_250_NS		15
> =20
> +/* LED CONFIG */
> +#define YT8521_MAX_LEDS				3
> +#define YT8521_LED0_CFG_REG			0xA00C
> +#define YT8521_LED1_CFG_REG			0xA00D
> +#define YT8521_LED2_CFG_REG			0xA00E
> +#define YT8521_LED_ACT_BLK_IND			BIT(13)
> +#define YT8521_LED_FDX_ON_EN			BIT(12)
> +#define YT8521_LED_HDX_ON_EN			BIT(11)
> +#define YT8521_LED_TXACT_BLK_EN			BIT(10)
> +#define YT8521_LED_RXACT_BLK_EN			BIT(9)
> +/* 1000Mbps */
> +#define YT8521_LED_GT_ON_EN			BIT(6)
> +/* 100Mbps */
> +#define YT8521_LED_HT_ON_EN			BIT(5)
> +/* 10Mbps */
> +#define YT8521_LED_BT_ON_EN			BIT(4)
> +
>  #define YTPHY_MISC_CONFIG_REG			0xA006
>  #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
>  #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
> @@ -1681,6 +1698,106 @@ static int yt8521_config_init(struct phy_device *=
phydev)
>  	return phy_restore_page(phydev, old_page, ret);
>  }
> =20
> +static const unsigned long supported_trgs =3D (BIT(TRIGGER_NETDEV_FULL_D=
UPLEX) |
> +					     BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +					     BIT(TRIGGER_NETDEV_LINK)        |
> +					     BIT(TRIGGER_NETDEV_LINK_10)     |
> +					     BIT(TRIGGER_NETDEV_LINK_100)    |
> +					     BIT(TRIGGER_NETDEV_LINK_1000)   |
> +					     BIT(TRIGGER_NETDEV_RX)          |
> +					     BIT(TRIGGER_NETDEV_TX));
> +
> +static int yt8521_led_hw_is_supported(struct phy_device *phydev, u8 inde=
x,
> +				      unsigned long rules)
> +{
> +	if (index >=3D YT8521_MAX_LEDS)
> +		return -EINVAL;
> +
> +	/* All combinations of the supported triggers are allowed */
> +	if (rules & ~supported_trgs)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int yt8521_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				     unsigned long rules)
> +{
> +	u16 val =3D 0;
> +
> +	if (index >=3D YT8521_MAX_LEDS)
> +		return -EINVAL;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK, &rules)) {
> +		val |=3D YT8521_LED_BT_ON_EN;
> +		val |=3D YT8521_LED_HT_ON_EN;
> +		val |=3D YT8521_LED_GT_ON_EN;
> +	}
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
> +		val |=3D YT8521_LED_BT_ON_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
> +		val |=3D YT8521_LED_HT_ON_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
> +		val |=3D YT8521_LED_GT_ON_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
> +		val |=3D YT8521_LED_HDX_ON_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
> +		val |=3D YT8521_LED_FDX_ON_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_TX, &rules) ||
> +	    test_bit(TRIGGER_NETDEV_RX, &rules))
> +		val |=3D YT8521_LED_ACT_BLK_IND;
> +
> +	if (test_bit(TRIGGER_NETDEV_TX, &rules))
> +		val |=3D YT8521_LED_TXACT_BLK_EN;
> +
> +	if (test_bit(TRIGGER_NETDEV_RX, &rules))
> +		val |=3D YT8521_LED_RXACT_BLK_EN;
> +
> +	return ytphy_write_ext(phydev, YT8521_LED0_CFG_REG + index, val);
> +}
> +
> +static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				     unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index >=3D YT8521_MAX_LEDS)
> +		return -EINVAL;
> +
> +	val =3D ytphy_read_ext(phydev, YT8521_LED0_CFG_REG + index);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & YT8521_LED_TXACT_BLK_EN)
> +		set_bit(TRIGGER_NETDEV_TX, rules);
> +
> +	if (val & YT8521_LED_RXACT_BLK_EN)
> +		set_bit(TRIGGER_NETDEV_RX, rules);
> +
> +	if (val & YT8521_LED_FDX_ON_EN)
> +		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
> +
> +	if (val & YT8521_LED_HDX_ON_EN)
> +		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
> +
> +	if (val & YT8521_LED_GT_ON_EN)
> +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
> +
> +	if (val & YT8521_LED_HT_ON_EN)
> +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
> +
> +	if (val & YT8521_LED_BT_ON_EN)
> +		set_bit(TRIGGER_NETDEV_LINK_10, rules);
> +
> +	return 0;
> +}
> +
>  static int yt8531_config_init(struct phy_device *phydev)
>  {
>  	struct device_node *node =3D phydev->mdio.dev.of_node;
> @@ -2920,6 +3037,9 @@ static struct phy_driver motorcomm_phy_drvs[] =3D {
>  		.soft_reset	=3D yt8521_soft_reset,
>  		.suspend	=3D yt8521_suspend,
>  		.resume		=3D yt8521_resume,
> +		.led_hw_is_supported =3D yt8521_led_hw_is_supported,
> +		.led_hw_control_set =3D yt8521_led_hw_control_set,
> +		.led_hw_control_get =3D yt8521_led_hw_control_get,
>  	},
>  	{
>  		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
>=20





