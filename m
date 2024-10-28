Return-Path: <netdev+bounces-139716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406659B3E61
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B801B21BA4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D661F7565;
	Mon, 28 Oct 2024 23:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836221865E3
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730157807; cv=none; b=kiIQ3j0EiJzXdVTYlJH0/3iMlWoXJmuN2r4fSKYmSKxtTSk1rhtakYYQmzsDHQkReF0Gap/rSRRlyiIPquAev/ZVwvBFIad6x2+Qd2kJKtuqfr+rBtF4Q+eMwhSmhcWe+n7h0HLAuY+19v5LrrWcjcbgy8aPxFzH7ik18dZ1brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730157807; c=relaxed/simple;
	bh=GynyyRqGXggmgP0KehUeJT45nvmXMrrd1/+EHyAHepg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reIhxg1PKKWrgEX2npVvBK8p3+y4n58ZV2ATCZ8S6ii0bh/55UyuJ0U9HdqNhbECOc5dvUwt/J9bvrppg8NvX/ANDP9exxZSmaa91nYNgeYRkboijWayDYwo22bHAS0EGqQWrEv1lepo7s2U5Nx1tLeRHCbWz6yJFuOREDbhQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t5Z4o-0006QF-Ob; Mon, 28 Oct 2024 23:23:10 +0000
Message-ID: <adada090-97fc-4007-a473-04251d8c091f@trager.us>
Date: Mon, 28 Oct 2024 16:23:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection for
 PHY drivers
To: Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20241028203804.41689-2-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/24 1:38 PM, Gerhard Engleder wrote:
> PHY drivers support loopback mode, but it is not possible to select the
> speed of the loopback mode. The speed is chosen by the set_loopback()
> operation of the PHY driver. Same is valid for genphy_loopback().
>
> There are PHYs that support loopback with different speeds. Extend
> set_loopback() to make loopback speed selection possible.
>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>   drivers/net/phy/adin1100.c          |  5 ++++-
>   drivers/net/phy/dp83867.c           |  5 ++++-
>   drivers/net/phy/marvell.c           |  8 +++++++-
>   drivers/net/phy/mxl-gpy.c           | 11 +++++++----
>   drivers/net/phy/phy-c45.c           |  5 ++++-
>   drivers/net/phy/phy_device.c        | 12 +++++++++---
>   drivers/net/phy/xilinx_gmii2rgmii.c |  7 ++++---
>   include/linux/phy.h                 | 16 ++++++++++++----
>   8 files changed, 51 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index 85f910e2d4fb..dd8cce925668 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -215,8 +215,11 @@ static int adin_resume(struct phy_device *phydev)
>   	return adin_set_powerdown_mode(phydev, false);
>   }
>   
> -static int adin_set_loopback(struct phy_device *phydev, bool enable)
> +static int adin_set_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
> +	if (enable && speed)
> +		return -EOPNOTSUPP;
> +
>   	if (enable)
>   		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_10T1L_CTRL,
>   					BMCR_LOOPBACK);
> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 4120385c5a79..b10ad482d566 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -1009,8 +1009,11 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
>   	}
>   }
>   
> -static int dp83867_loopback(struct phy_device *phydev, bool enable)
> +static int dp83867_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
> +	if (enable && speed)
> +		return -EOPNOTSUPP;
> +
>   	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
>   			  enable ? BMCR_LOOPBACK : 0);
>   }
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 28aec37acd2c..c70c5c23b339 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -2095,13 +2095,19 @@ static void marvell_get_stats_simple(struct phy_device *phydev,
>   		data[i] = marvell_get_stat_simple(phydev, i);
>   }
>   
> -static int m88e1510_loopback(struct phy_device *phydev, bool enable)
> +static int m88e1510_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
>   	int err;
>   
>   	if (enable) {
>   		u16 bmcr_ctl, mscr2_ctl = 0;
>   
> +		if (speed == SPEED_10 || speed == SPEED_100 ||
> +		    speed == SPEED_1000)
> +			phydev->speed = speed;
> +		else if (speed)
> +			return -EINVAL;
> +
>   		bmcr_ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
>   
>   		err = phy_write(phydev, MII_BMCR, bmcr_ctl);
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index db3c1f72b407..9b863b18a043 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -813,7 +813,7 @@ static void gpy_get_wol(struct phy_device *phydev,
>   	wol->wolopts = priv->wolopts;
>   }
>   
> -static int gpy_loopback(struct phy_device *phydev, bool enable)
> +static int gpy_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
>   	struct gpy_priv *priv = phydev->priv;
>   	u16 set = 0;
> @@ -822,6 +822,9 @@ static int gpy_loopback(struct phy_device *phydev, bool enable)
>   	if (enable) {
>   		u64 now = get_jiffies_64();
>   
> +		if (speed)
> +			return -EOPNOTSUPP;
> +
>   		/* wait until 3 seconds from last disable */
>   		if (time_before64(now, priv->lb_dis_to))
>   			msleep(jiffies64_to_msecs(priv->lb_dis_to - now));
> @@ -845,15 +848,15 @@ static int gpy_loopback(struct phy_device *phydev, bool enable)
>   	return 0;
>   }
>   
> -static int gpy115_loopback(struct phy_device *phydev, bool enable)
> +static int gpy115_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
>   	struct gpy_priv *priv = phydev->priv;
>   
>   	if (enable)
> -		return gpy_loopback(phydev, enable);
> +		return gpy_loopback(phydev, enable, speed);
>   
>   	if (priv->fw_minor > 0x76)
> -		return gpy_loopback(phydev, 0);
> +		return gpy_loopback(phydev, 0, 0);
>   
>   	return genphy_soft_reset(phydev);
>   }
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 5695935fdce9..3399028f0e92 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -1230,8 +1230,11 @@ int gen10g_config_aneg(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL_GPL(gen10g_config_aneg);
>   
> -int genphy_c45_loopback(struct phy_device *phydev, bool enable)
> +int genphy_c45_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
> +	if (enable && speed)
> +		return -EOPNOTSUPP;
> +
>   	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
>   			      MDIO_PCS_CTRL1_LOOPBACK,
>   			      enable ? MDIO_PCS_CTRL1_LOOPBACK : 0);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 563497a3274c..1c34cb947588 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2112,9 +2112,9 @@ int phy_loopback(struct phy_device *phydev, bool enable)
>   	}
>   
>   	if (phydev->drv->set_loopback)
> -		ret = phydev->drv->set_loopback(phydev, enable);
> +		ret = phydev->drv->set_loopback(phydev, enable, 0);
>   	else
> -		ret = genphy_loopback(phydev, enable);
> +		ret = genphy_loopback(phydev, enable, 0);
>   
>   	if (ret)
>   		goto out;
> @@ -2906,12 +2906,18 @@ int genphy_resume(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL(genphy_resume);
>   
> -int genphy_loopback(struct phy_device *phydev, bool enable)
> +int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
>   {
>   	if (enable) {
>   		u16 ctl = BMCR_LOOPBACK;
>   		int ret, val;
>   
> +		if (speed == SPEED_10 || speed == SPEED_100 ||
> +		    speed == SPEED_1000)
> +			phydev->speed = speed;
Why is this limited to 1000? Shouldn't the max loopback speed be limited 
by max hardware speed? We currently have definitions going up to 
SPEED_800000 so some devices should support higher than 1000.
> +		else if (speed)
> +			return -EINVAL;
> +
>   		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
>   
>   		phy_modify(phydev, MII_BMCR, ~0, ctl);
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 7c51daecf18e..2024d8ef36d9 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -64,15 +64,16 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
>   	return 0;
>   }
>   
> -static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable)
> +static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable,
> +				     int speed)
>   {
>   	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
>   	int err;
>   
>   	if (priv->phy_drv->set_loopback)
> -		err = priv->phy_drv->set_loopback(phydev, enable);
> +		err = priv->phy_drv->set_loopback(phydev, enable, speed);
>   	else
> -		err = genphy_loopback(phydev, enable);
> +		err = genphy_loopback(phydev, enable, speed);
>   	if (err < 0)
>   		return err;
>   
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index bf0eb4e5d35c..83b705cfbf46 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1107,8 +1107,16 @@ struct phy_driver {
>   	int (*set_tunable)(struct phy_device *dev,
>   			    struct ethtool_tunable *tuna,
>   			    const void *data);
> -	/** @set_loopback: Set the loopback mood of the PHY */
> -	int (*set_loopback)(struct phy_device *dev, bool enable);
> +	/**
> +	 * @set_loopback: Set the loopback mode of the PHY
> +	 * enable selects if the loopback mode is enabled or disabled. If the
> +	 * loopback mode is enabled, then the speed of the loopback mode can be
> +	 * requested with the speed argument. If the speed argument is zero,
> +	 * then any speed can be selected. If the speed argument is > 0, then
> +	 * this speed shall be selected for the loopback mode or EOPNOTSUPP
> +	 * shall be returned if speed selection is not supported.
> +	 */
> +	int (*set_loopback)(struct phy_device *dev, bool enable, int speed);
>   	/** @get_sqi: Get the signal quality indication */
>   	int (*get_sqi)(struct phy_device *dev);
>   	/** @get_sqi_max: Get the maximum signal quality indication */
> @@ -1895,7 +1903,7 @@ int genphy_read_status(struct phy_device *phydev);
>   int genphy_read_master_slave(struct phy_device *phydev);
>   int genphy_suspend(struct phy_device *phydev);
>   int genphy_resume(struct phy_device *phydev);
> -int genphy_loopback(struct phy_device *phydev, bool enable);
> +int genphy_loopback(struct phy_device *phydev, bool enable, int speed);
>   int genphy_soft_reset(struct phy_device *phydev);
>   irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);
>   
> @@ -1937,7 +1945,7 @@ int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev);
>   int genphy_c45_read_status(struct phy_device *phydev);
>   int genphy_c45_baset1_read_status(struct phy_device *phydev);
>   int genphy_c45_config_aneg(struct phy_device *phydev);
> -int genphy_c45_loopback(struct phy_device *phydev, bool enable);
> +int genphy_c45_loopback(struct phy_device *phydev, bool enable, int speed);
>   int genphy_c45_pma_resume(struct phy_device *phydev);
>   int genphy_c45_pma_suspend(struct phy_device *phydev);
>   int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable);

  Why is speed defined as an int? It can never be negative, I normally 
see it defined as u32.


