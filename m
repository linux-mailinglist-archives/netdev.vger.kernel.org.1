Return-Path: <netdev+bounces-190567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E76AAB7911
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9E38C5147
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8295223DCA;
	Wed, 14 May 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRcUafVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738F1E7C12;
	Wed, 14 May 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261802; cv=none; b=uAeq25IghlIKndSAtq88pfXQjz0Kd2KLzs0DyPru+nOI5vQbtx6CV95ehufPzwoYvrUOj1fcokaHeVTmeTDXa4/LGQyfUYclJVPtDF3Erlmb3ZTm3YDev+4MvkU1NaQYR/RFlGvzvo6dSyaiCGg0TTcUnqcNMmZcfYfTeBJVQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261802; c=relaxed/simple;
	bh=ybLV5qDtHWlYbRzNgkg1Kyzahak4Prmv21m1drH4baU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZkJvc6fQSglxlUPtk9z5EGZSrQh+Dl5tDKxBCcP1spiXdCtVbKvOQUQHU8GtqvM9HA09zeMPUI0b6pV0zHipVqAAyADgty+2pykiR2CIKjCkx6HNYi5bt5Bl6J1ArSLIhKikDVw7UP29bY2TrJKx2TB9qZbhqmdjFSFL4mC5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRcUafVM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7adcaea616so399306276.0;
        Wed, 14 May 2025 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747261799; x=1747866599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2e3LNwKajsjF933UHwBT95viTZVsIz8/UVM3Zuk/YDY=;
        b=XRcUafVMuHJ/xGvmNK60/qnWxgT7/AKRO0be+/BANUcDSRuwSeVz6dUDQbGiZdO7FU
         VKc77w/AOhxBgsTcCzSsXiZI9/IyDQjXv74TKlm88RxlFv1+0yrNu3pVMqpRR09Rw1vW
         PRFRsDpp4K+lby6PTl7SFQbgmx8yqe/HSHsZ6eb+96sHYNskLNVzxPkpivNpTlzKyJFZ
         oun7YDL4tkHTSC41vQAgEEqHC36pMuxC5SI9h0g+T/IfqBtP3Kzs261L0jNN0E8mIBxm
         45fWQoatvnhCSrYBcyf9syzXAztP7JlrJ1YCngM9U4FjVg0oFuWX3S6GMPgOQMGXJuHs
         b5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747261799; x=1747866599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e3LNwKajsjF933UHwBT95viTZVsIz8/UVM3Zuk/YDY=;
        b=QfUdQlzbo8zbVVzcK/LLe1gYwsR5EgmhwuchBoEiDPIT4XfIJjcsh8cXRyir+k6pc5
         Eb5Yl9z3RJwETX934xiLP80k6UiRv/hAobW4b1kmiHSqbOHelZi17TxzrVb8tsE4vTi6
         qF5xk+dRWNxQzqyUEMJAKJbx6iFEQzMGEZaAf/1uKpl60R6pSXNo5l7Q/21luRaq7CIC
         FJtGfMXY612E4jRMNdYHFMmd+EMLCMQVx2pnNkGmhQou4EKNxYKPgsxLSlI6Nb111WeU
         ekExiM8yHDl4Ts9Q+6uQYKnnsozUd2DuKCrzJxjwY50nEaPAeRts5fSJ0uf9VuKim17K
         yx3g==
X-Forwarded-Encrypted: i=1; AJvYcCWO3WetBmKQY29brbTb5ZaHAaVM04y9qf3WroABK8oeZ7oW13usbJ6a0WfBJVe5vVUoNKcKgXMcgSTYsyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpPqazy/1GK5/YXtVjajY3ImOK+7avY64Bdl8nYQkqng4IBMH
	w4Te8C2ex0UfdeiHQ6H5mewnipCaW5Aa/KRCfkV5xJfK0nOVvMrwdqokUOKo3L/hDuAWHRMiqvt
	Ypt+ZHk/uWqKjh0E8k5MHVR2KQq4=
X-Gm-Gg: ASbGncthUkcILFD5x2sBpwJRpG5/qFprJcQ2+SHGArpRYd9o/I9T+jq2KnsqVzR73X+
	yK2NV3tQZ7ug1kmx4AwlHHdf7AtmvqD4+hyzNAq2B5hJ5Qod6IjpK+aZ2SMjO9Msm/cc7jY22O5
	p8SjUKsbFcDOcneWJD/bXr9KTSLyR9ul/d
X-Google-Smtp-Source: AGHT+IHhRvLb+K2gEdmVmsISDZwK7j/NlMEtJEv2o0teTlV8QEXAO9gUgKgotTfY0wVczMegv0BzRd+AIWVT9n5MEFg=
X-Received: by 2002:a05:6902:2381:b0:e6d:f287:bf9 with SMTP id
 3f1490d57ef6-e7b5431c689mr228393276.22.1747261799295; Wed, 14 May 2025
 15:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512191901.73823-1-stefano.radaelli21@gmail.com>
 <20250514173511.158088-1-stefano.radaelli21@gmail.com> <4c64695a-fb98-4b77-a886-3a056e6b229f@lunn.ch>
In-Reply-To: <4c64695a-fb98-4b77-a886-3a056e6b229f@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 15 May 2025 00:29:48 +0200
X-Gm-Features: AX0GCFt_YUS_yTiuq9aTWZwKuiqnJZyBAr62I5gGF2xerF890NUzcgFdI6CrbuU
Message-ID: <CAK+owoid1woDTiCxcGiEmdvKNHJeCnaKBjPEHyNrtHt_hKqi9g@mail.gmail.com>
Subject: Re: [PATCH v2] net: phy: mxl-8611: add support for MaxLinear
 MxL86110/MxL86111 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks again for your detailed review and suggestions,
I really appreciate the time you took to go through the patch.

After reviewing your feedback, I realized that most of the more complex issues
are specific to the MXL86111. The MXL86110 side, on the other hand, seems much
closer to being ready once I address the points you raised.

Would you be open to me submitting a revised version of the driver
with support for the
MXL86110 only, for now? This would allow me to properly support the
PHYs I'm currently
using on Variscite boards, while taking the necessary time to rework
and structure the MXL86111
support for a future submission.

Please let me know if that sounds reasonable.

Thanks again,

Stefano


Il giorno mer 14 mag 2025 alle ore 20:49 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
> On Wed, May 14, 2025 at 07:35:06PM +0200, Stefano Radaelli wrote:
> > The MaxLinear MxL86110 is a low power Ethernet PHY transceiver IC
> > compliant with the IEEE 802.3 Ethernet standard. It offers a
> > cost-optimized solution suitable for routers, switches, and home
> > gateways, supporting 1000, 100, and 10 Mbit/s data rates over
> > CAT5e or higher twisted pair copper cable.
> >
> > The driver for this PHY is based on initial code provided by MaxLinear
> > (MaxLinear Driver V1.0.0).
> >
> > Supported features:
> > ----------------------------------------+----------+----------+
> > Feature                                | MxL86110 | MxL86111 |
> > ----------------------------------------+----------+----------+
> > General Device Initialization          |    x     |    x     |
> > Wake on LAN (WoL)                      |    x     |    x     |
> > LED Configuration                      |    x     |    x     |
> > RGMII Interface Configuration          |    x     |    x     |
> > SyncE Clock Output Config              |    x     |    x     |
> > Dual Media Mode (Fiber/Copper)         |    -     |    x     |
> > ----------------------------------------+----------+----------+
> >
> > This driver was tested on a Variscite i.MX93-VAR-SOM and
> > a i.MX8MP-VAR-SOM. LEDs configuration were tested using
> > /sys/class/leds interface
> >
> > Changes since v1:
> > - Rewrote the driver following the PHY subsystem documentation
> >   and the style of existing PHY drivers
> > - Removed all vendor-specific code and unnecessary workarounds
> > - Reimplemented LED control using the generic /sys/class/leds interface
>
> Please start a new thread for each new version.
>
> > +static int mxlphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     int page_to_restore;
> > +     const u8 *mac;
> > +     int ret = 0;
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev = phydev->attached_dev;
> > +             if (!netdev)
> > +                     return -ENODEV;
> > +
> > +             page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
> > +             if (page_to_restore < 0)
> > +                     goto error;
> > +
> > +             /* Configure the MAC address of the WOL magic packet */
> > +             mac = (const u8 *)netdev->dev_addr;
> > +             ret = mxlphy_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG,
> > +                                             ((mac[0] << 8) | mac[1]));
>
> ...
>
> > +error:
> > +     return phy_restore_page(phydev, page_to_restore, ret);
> > +}
> > +
> > +/**
> > + * mxl8611x_enable_leds_activity_blink() - Enable activity blink on all PHY LEDs
> > + * @phydev: pointer to the PHY device structure
> > + *
> > + * Configure all PHY LEDs to blink on traffic activity regardless of their
> > + * ON or OFF state. This behavior allows each LED to serve as a pure activity
> > + * indicator, independently of its use as a link status indicator.
> > + *
> > + * By default, each LED blinks only when it is also in the ON state. This function
> > + * modifies the appropriate registers (LABx fields) to enable blinking even
> > + * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
> > + * without requiring it to also serve as a link status LED.
> > + *
> > + * NOTE: Any further LED customization can be performed via the
> > + * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
> > + * led_hw_control_set are used to support this mechanism.
> > + *
> > + * Return: 0 on success or a negative error code.
> > + */
> > +static int mxl8611x_enable_led_activity_blink(struct phy_device *phydev)
> > +{
> > +     u16 val;
> > +     int ret, index;
> > +
> > +     for (index = 0; index < MXL8611x_MAX_LEDS; index++) {
> > +             val = mxlphy_read_extended_reg(phydev, MXL8611X_LED0_CFG_REG + index);
> > +             if (val < 0)
> > +                     return val;
> > +
> > +             val |= MXL8611X_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> > +
> > +             ret = mxlphy_write_extended_reg(phydev, MXL8611X_LED0_CFG_REG + index, val);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> mxlphy_set_wol() swaps to the default page before making use of
> mxlphy_write_extended_reg(). Here you don't. What are the rules?
>
> > +/**
> > + * mxl8611x_broadcast_cfg() - applies broadcast configuration
> > + * @phydev: pointer to the phy_device
> > + *
> > + * configures the broadcast setting for the PHY based on the device tree
> > + * if the "mxl-8611x,broadcast-enabled" property is present the PHY broadcasts
> > + * address 0 on the MDIO bus. This feature enables PHY to always respond to MDIO access
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl8611x_broadcast_cfg(struct phy_device *phydev)
> > +{
> > +     int ret = 0;
> > +     struct device_node *node;
> > +     u32 val;
> > +
> > +     if (!phydev) {
> > +             pr_err("%s, Invalid phy_device pointer\n", __func__);
> > +             return -EINVAL;
> > +     }
>
> How would that happen?
>
> We avoid defensive code like this, you should spend the time to
> understand all the ways you can get to here, and avoid passing a NULL
> pointer.
>
> > +
> > +     node = phydev->mdio.dev.of_node;
> > +     if (!node) {
> > +             phydev_err(phydev, "%s, Invalid device tree node\n", __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     val = mxlphy_read_extended_reg(phydev, MXL8611X_EXT_RGMII_MDIO_CFG);
> > +
> > +     if (of_property_read_bool(node, "mxl-8611x,broadcast-enabled"))
> > +             val |= MXL8611X_EXT_RGMII_MDIO_CFG_EPA0_MASK;
> > +     else
> > +             val &= ~MXL8611X_EXT_RGMII_MDIO_CFG_EPA0_MASK;
>
> In my previous review i said drop this. Just hard code broadcast
> disabled.
>
> > +/**
> > + * mxl86110_config_init() - initialize the PHY
> > + * @phydev: pointer to the phy_device
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86110_config_init(struct phy_device *phydev)
> > +{
> > +     int page_to_restore, ret = 0;
> > +     unsigned int val = 0;
> > +
> > +     page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
> > +     if (page_to_restore < 0)
> > +             goto err_restore_page;
> > +
> > +     switch (phydev->interface) {
> > +     case PHY_INTERFACE_MODE_RGMII:
> > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > +             val = MXL8611X_EXT_RGMII_CFG1_RX_DELAY_DEFAULT;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > +             val = MXL8611X_EXT_RGMII_CFG1_TX_1G_DELAY_DEFAULT |
> > +                             MXL8611X_EXT_RGMII_CFG1_TX_10MB_100MB_DEFAULT;
> > +             val |= MXL8611X_EXT_RGMII_CFG1_RX_DELAY_DEFAULT;
> > +             break;
>
> This looks wrong. The four RGMII modes should require different
> values. Also, if delays are added, they should be 2ns. Don't use
> _DEFAULT, use a name to indicate it is 2ns.
>
> > +struct mxl86111_priv {
> > +     /* dual_media_advertising used for Dual Media mode (MXL86111_EXT_SMI_SDS_PHY_AUTO) */
> > +     __ETHTOOL_DECLARE_LINK_MODE_MASK(dual_media_advertising);
> > +
> > +     /* MXL86111_MODE_FIBER / MXL86111_MODE_UTP / MXL86111_MODE_AUTO*/
> > +     u8 reg_page_mode;
> > +     u8 strap_mode; /* 8 working modes  */
> > +     /* current reg page of mxl86111 phy:
> > +      * MXL86111_EXT_SMI_SDS_PHYUTP_SPACE
> > +      * MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE
> > +      * MXL86111_EXT_SMI_SDS_PHY_AUTO
> > +      */
> > +     u8 reg_page;
> > +};
> > +
> > +/**
> > + * mxl86111_read_page() - read reg page
> > + * @phydev: pointer to the phy_device
> > + *
> > + * returns current reg space of mxl86111 (MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE/
> > + * MXL86111_EXT_SMI_SDS_PHYUTP_SPACE) or negative errno code
> > + */
> > +static int mxl86111_read_page(struct phy_device *phydev)
> > +{
> > +     int old_page;
> > +
> > +     old_page = mxlphy_locked_read_extended_reg(phydev, MXL86111_EXT_SMI_SDS_PHY_REG);
> > +     if (old_page < 0)
> > +             return old_page;
> > +
> > +     if ((old_page & MXL86111_EXT_SMI_SDS_PHYSPACE_MASK) == MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE)
> > +             return MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE;
> > +
> > +     return MXL86111_EXT_SMI_SDS_PHYUTP_SPACE;
> > +};
> > +
> > +/**
> > + * mxl86111_write_page() - Set reg page
> > + * @phydev: pointer to the phy_device
> > + * @page: The reg page to set
> > + * (MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE/MXL86111_EXT_SMI_SDS_PHYUTP_SPACE)
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86111_write_page(struct phy_device *phydev, int page)
> > +{
> > +     int mask = MXL86111_EXT_SMI_SDS_PHYSPACE_MASK;
> > +     int set;
> > +
> > +     if ((page & MXL86111_EXT_SMI_SDS_PHYSPACE_MASK) == MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE)
> > +             set = MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE;
> > +     else
> > +             set = MXL86111_EXT_SMI_SDS_PHYUTP_SPACE;
> > +
> > +     return mxlphy_modify_extended_reg(phydev, MXL86111_EXT_SMI_SDS_PHY_REG, mask, set);
> > +};
>
> We need some sort of overview of all these different functions
> accessing pages, and how they interact with each other.
>
> > +
> > +/**
> > + * mxl86111_modify_bmcr_paged - modify bits of the PHY's BMCR register of a given page
> > + * @phydev: pointer to the phy_device
> > + * @page: The reg page to operate
> > + * (MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE/MXL86111_EXT_SMI_SDS_PHYUTP_SPACE)
> > + * @mask: bit mask of bits to clear
> > + * @set: bit mask of bits to set
> > + *
> > + * NOTE: new register value = (old register value & ~mask) | set.
> > + * MxL86111 has 2 register spaces (utp/fiber) and 3 modes (utp/fiber/auto).
> > + * Each space has its MII_BMCR.
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86111_modify_bmcr_paged(struct phy_device *phydev, int page,
> > +                                   u16 mask, u16 set)
> > +{
> > +     int bmcr_timeout = BMCR_RESET_TIMEOUT;
> > +     int page_to_restore;
> > +     int ret = 0;
> > +
> > +     page_to_restore = phy_select_page(phydev, page & MXL86111_EXT_SMI_SDS_PHYSPACE_MASK);
> > +     if (page_to_restore < 0)
> > +             goto err_restore_page;
> > +
> > +     ret = __phy_modify(phydev, MII_BMCR, mask, set);
> > +     if (ret < 0)
> > +             goto err_restore_page;
> > +
> > +     /* In case of BMCR_RESET, check until reset bit is cleared */
> > +     if (set == BMCR_RESET) {
> > +             while (bmcr_timeout--) {
> > +                     usleep_range(1000, 1050);
> > +                     ret = __phy_read(phydev, MII_BMCR);
> > +                     if (ret < 0)
> > +                             goto err_restore_page;
> > +
> > +                     if (!(ret & BMCR_RESET))
> > +                             return phy_restore_page(phydev, page_to_restore, 0);
> > +             }
> > +             phydev_warn(phydev, "%s, BMCR reset not completed until timeout", __func__);
>
> Loops like this after often buggy. Please take a look at
> phy_poll_reset().
>
> Also, is there really two BMCR registers? Does resetting one not also
> perform a reset on the other?
>
> > +/**
> > + * mxl86111_set_fiber_features() -  setup fiber mode features.
> > + * @phydev: pointer to the phy_device
> > + * @dst: a pointer to store fiber mode features
> > + */
> > +static void mxl86111_set_fiber_features(struct phy_device *phydev,
> > +                                     unsigned long *dst)
> > +{
> > +     linkmode_set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, dst);
> > +     linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, dst);
> > +     linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, dst);
> > +     linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, dst);
>
> Normally you can read these from the Extended Status register. Is that
> register broken?
>
> > +}
> > +
> > +/**
> > + * mxlphy_utp_read_abilities - read PHY abilities from Clause 22 registers
> > + * @phydev: pointer to the phy_device
> > + *
> > + * NOTE: Read the PHY abilities and set phydev->supported.
> > + * The caller must have taken the MDIO bus lock.
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxlphy_utp_read_abilities(struct phy_device *phydev)
> > +{
>
> This appears to be mostly a copy of genphy_read_abilities(). Please
> try to use that helper. Sometimes you need to call it, and then fixup
> whatever is broken. It might also be you need to call it twice, with
> to different pages selected. The .get_features call is made very
> early, before the PHY is published, so you don't need to worry about
> something changing the page.
>
> > +static int mxl86111_probe(struct phy_device *phydev)
> > +{
> > +     struct device *dev = &phydev->mdio.dev;
> > +     struct mxl86111_priv *priv;
> > +     int chip_config;
> > +     int ret;
> > +
> > +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     phydev->priv = priv;
> > +
> > +     // TM: Debugging of pinstrap mode
> > +     ret = mxlphy_locked_modify_extended_reg(phydev, MXL86111_EXT_CHIP_CFG_REG,
> > +                                             MXL86111_EXT_CHIP_CFG_MODE_SEL_MASK,
> > +                                             MXL86111_EXT_CHIP_CFG_MODE_UTP_TO_RGMII);
> > +     if (ret < 0)
> > +             return ret;
> > +     // TM: Debugging of pinstrap mode
> > +     ret = mxlphy_locked_modify_extended_reg(phydev, MXL86111_EXT_CHIP_CFG_REG,
> > +                                             MXL86111_EXT_CHIP_CFG_SW_RST_N_MODE, 0);
>
> What are these two modifies doing?
>
> > +/**
> > + * mxlphy_check_and_restart_aneg - Enable and restart auto-negotiation
> > + * @phydev: pointer to the phy_device
> > + * @restart: bool if aneg restart is requested
> > + *
> > + * NOTE: The caller must have taken the MDIO bus lock.
> > + *
> > + * identical to genphy_check_and_restart_aneg, but phy_read without mdio lock
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxlphy_check_and_restart_aneg(struct phy_device *phydev, bool restart)
> > +{
>
> This is genphy_check_and_restart_aneg().
>
> > +/**
> > + * mxlphy_config_advert - sanitize and advertise auto-negotiation parameters
> > + * @phydev: pointer to the phy_device
> > + *
> > + * NOTE: Writes MII_ADVERTISE with the appropriate values,
> > + * Returns < 0 on error, 0 if the PHY's advertisement hasn't changed,
> > + * and > 0 if it has changed.
> > + *
> > + * identical to genphy_config_advert, but phy_read without mdio lock
> > + *
> > + * NOTE: The caller must have taken the MDIO bus lock.
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxlphy_config_advert(struct phy_device *phydev)
> > +{
>
> > +     int err, bmsr, changed = 0;
> > +     u32 adv;
> > +
> > +     /* Only allow advertising what this PHY supports */
> > +     linkmode_and(phydev->advertising, phydev->advertising,
> > +                  phydev->supported);
>
> The core should of already done that.
>
> > +
> > +     adv = linkmode_adv_to_mii_adv_t(phydev->advertising);
> > +
> > +     /* Setup standard advertisement */
> > +     err = __phy_modify_changed(phydev, MII_ADVERTISE,
> > +                                ADVERTISE_ALL | ADVERTISE_100BASE4 |
> > +                                ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM,
> > +                                adv);
> > +     if (err < 0)
> > +             return err;
> > +     if (err > 0)
> > +             changed = 1;
>
> And this looks to be genphy_config_advert(). Please look at how you
> can use these helpers. Does the marvell driver also have
> reimplementations of all these functions?
>
>         Andrew

