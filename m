Return-Path: <netdev+bounces-191894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B523ABDC3E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57E44E39C8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF248884;
	Tue, 20 May 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBHrOACn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1324468C;
	Tue, 20 May 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750247; cv=none; b=Jk1HvNofGTb0Bo/MDGFifaxAEnI/5gbg7Xq6032Ou2AnHYeqZ/aokHmFeFD0C8sUzH5bAJprMLl/yUH6YzHnqjuPBP7GRa7WbQzY7QwkjxAaBU4dYI1hMD9QauNEGpNdvzDBDE+e5iDrrtZMyDHFnRGi5hHEeYflKm9RFv4fE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750247; c=relaxed/simple;
	bh=0zzPxcrKaRRaEExrpVwAADAxkoqXzBJhm287CR/1xO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsWM9M+22mES0XXAhiu8y7Dvt+9hRIoh3FxNN+hVMc/6XoZEQW7hQuW+hSXVHUoqatC05pYFGJ3zJ1lep8wKqAVcvqAegwxb2qmMofD3PKwGqU6OHEzi1nworOGzckbz2CtIZv6JklK5pIrMqCpCCA0tZ6MxKWiVEb8lEFd1dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBHrOACn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70cb1e8263bso33849427b3.0;
        Tue, 20 May 2025 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750244; x=1748355044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKasDRix2ZH5HzwwP3vm1dzw8DWoYQgUG8/zkJuQn0g=;
        b=EBHrOACnkoSSlvfgRtLGsLARd4OXtEInVTtK2HhudZrIGMk99usd4Wt/ukZ5yRd4T0
         UtakYC6c7XvZxMWUXPCwMJotzOOZIc54CxU+srNsm6DvGftHcm+OGY6pbqkiqiRp+nuH
         dyEbDHrlaR8i4bE/akDD2IncuLxz0dIWxjDh1JzJb/EcMGaTG9E0scmic/XTtw4gEQiw
         Lu/vH7KLzzcp+Mi5uuenfAhnH4/zelzDgM0ZCtcbbpXzDuthNuxDx0QRHeURkea/uD8F
         mF+7jJeC5zRpbLe7kilwYb068Okb9QltMpU8YhMxPo0hy0nvOaT1Yj3HqQ+V9/5EiDVi
         zdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750244; x=1748355044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKasDRix2ZH5HzwwP3vm1dzw8DWoYQgUG8/zkJuQn0g=;
        b=dtghqVQyzVVC3+4hpph3ASRL/GJHyRyjDaLiVbyt8u1rdYr0QaEQiNTdstaPDIDSiO
         tAUqTJtLVYBX6DuJ70bR4IUqR8E2AyMus69FZSnVzWCCL4RLNzD4xel3hQSTzmjIdA3u
         mhhtd4Zq+t6DTaHYLNILJpxlU+jMkEN6+TlqmTPbA7goi/jqKDKQhChPh6KBQNbclEHx
         R66T17ep3Px93o+HmZfAhlA8Fds1wfjBWsqifjKV2s/yZjfcMyJ4Y/9ZD31xuo0lycNa
         qdfbd7M3TnXZ6qxTWU40zRi+j13iFB2Evqd+DfvS9o+6aTwcZNhVaxEB8Z87ndj+15RZ
         W4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU47XcJysBUuuA8uFkjicIapgpirSatAFYAkPUUYq6QvKZQpQkplb4WYjA4VbTUrOf+ee8c7u+fDvSChL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8IM6i032RRljEpR4GlDzZjzO/xpkiYK5Cfym1EB4Mo0oZ3tl
	cbekIYvWZK76iHtCmCaBNv93trTHerx4t7mRJT4mTAUcu5hlQ5kKDpXJX2NLOp10tMNzykqtkk3
	949vbT6A2OfCYrh3daX8bPRARWXXULhM=
X-Gm-Gg: ASbGncthoMRXpAdi9YJpnVZwT5fQYWnD4RIDOF8uzwv+9Bb9/IeY3H84eEqZiPr+zRN
	sibINDsW6D6MEzO+TZb/Bg36prPf+hfiapmvIwskgS7keG1NdaHoHaGJ/B7R1ub8S9V9mca8Nga
	EljI5Ie50758T8fAsYJdOqW9+JP9jMHBo9rKnFg6b7
X-Google-Smtp-Source: AGHT+IGygCde47l2/CfJmaNDpwt0giSsbJYgV3eV5MgUAOCz3XX3MrREe9YxXA7I43bEzNhjKFJyvtyk9qrhfB+r3X8=
X-Received: by 2002:a05:690c:39c:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-70caafc5f61mr211004157b3.17.1747750243838; Tue, 20 May 2025
 07:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com> <53e692f9-296c-4f4b-8593-058fa6cfaa13@oracle.com>
In-Reply-To: <53e692f9-296c-4f4b-8593-058fa6cfaa13@oracle.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Tue, 20 May 2025 16:10:27 +0200
X-Gm-Features: AX0GCFsB2UFVWN-j1QXu7GWx5n48GqYXeUx-sUW5KZB3vBHiWtqSEaP4IiVCiMw
Message-ID: <CAK+owoiUHDhHMmt0MuTckeUzW=uHwKrORU0gEWGoaZg2XHCeag@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110 PHY
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alok,

Thanks a lot for the review.
I'll include these minor fixes in the upcoming v5 shortly.

Best regards,

Stefano

Il giorno mar 20 mag 2025 alle ore 15:34 ALOK TIWARI
<alok.a.tiwari@oracle.com> ha scritto:
>
>
> [snip]
> > +#define PHY_ID_MXL86110              0xc1335580
> > +
> > +/* required to access extended registers */
> > +#define MXL86110_EXTD_REG_ADDR_OFFSET                        0x1E
> > +#define MXL86110_EXTD_REG_ADDR_DATA                  0x1F
> > +#define PHY_IRQ_ENABLE_REG                           0x12
> > +#define PHY_IRQ_ENABLE_REG_WOL                               BIT(6)
> > +
> > +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> > +#define MXL86110_EXT_SYNCE_CFG_REG                   0xA012
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL           BIT(4)
> > +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN        BIT(5)
> > +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E             BIT(6)
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK              GENMASK(3, 1)
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL  0
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M               4
> > +
> > +/* MAC Address registers */
> > +#define MXL86110_EXT_MAC_ADDR_CFG1                   0xA007
> > +#define MXL86110_EXT_MAC_ADDR_CFG2                   0xA008
> > +#define MXL86110_EXT_MAC_ADDR_CFG3                   0xA009
> > +
> > +#define MXL86110_EXT_WOL_CFG_REG                     0xA00A
> > +#define MXL86110_WOL_CFG_WOLE_MASK                   BIT(3)
> > +#define MXL86110_EXT_WOL_CFG_WOLE                    BIT(3)
>
> seems Redundant since MXL86110_WOL_CFG_WOLE_MASK is defined
>
> > +
> > +/* RGMII register */
> > +#define MXL86110_EXT_RGMII_CFG1_REG                  0xA003
> > +/* delay can be adjusted in steps of about 150ps */
> > +#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY          (0x0 << 10)
> > +/* Closest value to 2000 ps */
> > +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS              (0xD << 10)
> > +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK                GENMASK(13, 10)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS   (0xD << 0)
> > +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK     GENMASK(3, 0)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS   (0xD << 4)
> > +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK     GENMASK(7, 4)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
> > +                     ((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
> > +                     (MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
> > +                     (MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK))
> > +
> > +/* EXT Sleep Control register */
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_REG                      0x27
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF  0
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK BIT(15)
> > +
> > +/* RGMII In-Band Status and MDIO Configuration Register */
> > +#define MXL86110_EXT_RGMII_MDIO_CFG                  0xA005
> > +#define MXL86110_RGMII_MDIO_CFG_EPA0_MASK            GENMASK(6, 6)
> > +#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK         GENMASK(5, 5)
> > +#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK          GENMASK(4, 0)
> > +
> > +#define MXL86110_MAX_LEDS    3
> > +/* LED registers and defines */
> > +#define MXL86110_LED0_CFG_REG 0xA00C
> > +#define MXL86110_LED1_CFG_REG 0xA00D
> > +#define MXL86110_LED2_CFG_REG 0xA00E
> > +
> > +#define MXL86110_LEDX_CFG_LAB_BLINK                  BIT(13)
> > +#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON     BIT(12)
> > +#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON     BIT(11)
> > +#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON          BIT(10)
> > +#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON          BIT(9)
> > +#define MXL86110_LEDX_CFG_LINK_UP_TX_ON                      BIT(8)
> > +#define MXL86110_LEDX_CFG_LINK_UP_RX_ON                      BIT(7)
> > +#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON             BIT(6)
> > +#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON           BIT(5)
> > +#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON            BIT(4)
> > +#define MXL86110_LEDX_CFG_LINK_UP_COLLISION          BIT(3)
> > +#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK          BIT(2)
> > +#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK                BIT(1)
> > +#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK         BIT(0)
> > +
> > +#define MXL86110_LED_BLINK_CFG_REG                   0xA00F
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ                0
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ                BIT(0)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ                BIT(1)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ               (BIT(1) | BIT(0))
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ                0
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ                BIT(2)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ                BIT(3)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ               (BIT(3) | BIT(2))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_ON              0
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_ON              (BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_ON              (BIT(5))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_ON              (BIT(5) | BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_OFF     (BIT(6))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_ON              (BIT(6) | BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_ON              (BIT(6) | BIT(5))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_ON      (BIT(6) | BIT(5) | BIT(4))
> > +
> > +/* Chip Configuration Register - COM_EXT_CHIP_CFG */
> > +#define MXL86110_EXT_CHIP_CFG_REG                    0xA001
> > +#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE           BIT(8)
> > +#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE          BIT(15)
> > +
> > +/**
> > + * mxl86110_write_extended_reg() - write to a PHY's extended register
> > + * @phydev: pointer to a &struct phy_device
> > + * @regnum: register number to write
> > + * @val: value to write to @regnum
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative error code
> > + */
> > +static int mxl86110_write_extended_reg(struct phy_device *phydev,
> > +                                    u16 regnum, u16 val)
> > +{
> > +     int ret;
> > +
> > +     ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
> > +}
> > +
> > +/**
> > + * mxl86110_read_extended_reg - Read a PHY's extended register
> > + * @phydev: Pointer to the PHY device structure
> > + * @regnum: Extended register number to read (address written to reg 30)
> > + *
> > + * Reads the content of a PHY extended register using the MaxLinear
> > + * 2-step access mechanism: write the register address to reg 30 (0x1E),
> > + * then read the value from reg 31 (0x1F).
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 16-bit register value on success, or negative errno code on failure.
> > + */
> > +static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
> > +{
> > +     int ret;
> > +
> > +     ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> > +     if (ret < 0)
> > +             return ret;
> > +     return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
> > +}
> > +
> > +/**
> > + * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
> > + * @phydev: pointer to the phy_device
> > + * @regnum: register number to write
> > + * @mask: bit mask of bits to clear
> > + * @set: bit mask of bits to set
> > + *
> > + * Note: register value = (old register value & ~mask) | set.
> > + * This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative error code
> > + */
> > +static int mxl86110_modify_extended_reg(struct phy_device *phydev,
> > +                                     u16 regnum, u16 mask, u16 set)
> > +{
> > +     int ret;
> > +
> > +     ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, set);
> > +}
> > +
> > +/**
> > + * mxl86110_get_wol() - report if wake-on-lan is enabled
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + */
> > +static void mxl86110_get_wol(struct phy_device *phydev,
> > +                          struct ethtool_wolinfo *wol)
> > +{
> > +     int value;
> > +
> > +     wol->supported = WAKE_MAGIC;
> > +     wol->wolopts = 0;
> > +     phy_lock_mdio_bus(phydev);
> > +     value = mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
> > +     phy_unlock_mdio_bus(phydev);
> > +     if (value >= 0 && (value & MXL86110_WOL_CFG_WOLE_MASK))
> > +             wol->wolopts |= WAKE_MAGIC;
> > +}
> > +
> > +/**
> > + * mxl86110_set_wol() - enable/disable wake-on-lan
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + *
> > + * Configures the WOL Magic Packet MAC
> > + *
> > + * Return: 0 or negative errno code
> > + */
> > +static int mxl86110_set_wol(struct phy_device *phydev,
> > +                         struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     const u8 *mac;
> > +     int ret = 0;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev = phydev->attached_dev;
> > +             if (!netdev) {
> > +                     ret = -ENODEV;
> > +                     goto out;
> > +             }
> > +
> > +             /* Configure the MAC address of the WOL magic packet */
> > +             mac = (const u8 *)netdev->dev_addr;
>
> is netdev->dev_addr not already of type u8 * ?
>
> > +             ret = mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_CFG1,
> > +                                               ((mac[0] << 8) | mac[1]));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret = mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_CFG2,
> > +                                               ((mac[2] << 8) | mac[3]));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret = mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_CFG3,
> > +                                               ((mac[4] << 8) | mac[5]));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret = mxl86110_modify_extended_reg(phydev,
> > +                                                MXL86110_EXT_WOL_CFG_REG,
> > +                                                MXL86110_WOL_CFG_WOLE_MASK,
> > +                                                MXL86110_EXT_WOL_CFG_WOLE);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             /* Enables Wake-on-LAN interrupt in the PHY. */
> > +             ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> > +                                PHY_IRQ_ENABLE_REG_WOL);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             phydev_dbg(phydev,
> > +                        "%s, MAC Addr: %02X:%02X:%02X:%02X:%02X:%02X\n",
> > +                        __func__,
> > +                        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> > +     } else {
> > +             ret = mxl86110_modify_extended_reg(phydev,
> > +                                                MXL86110_EXT_WOL_CFG_REG,
> > +                                                MXL86110_WOL_CFG_WOLE_MASK,
> > +                                                0);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             /* Disables Wake-on-LAN interrupt in the PHY. */
> > +             ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> > +                                PHY_IRQ_ENABLE_REG_WOL, 0);
> > +     }
> > +
> > +out:
> > +     phy_unlock_mdio_bus(phydev);
> > +     return ret;
> > +}
> > +
> > +static const unsigned long supported_trgs = (BIT(TRIGGER_NETDEV_LINK_10) |
> > +                                           BIT(TRIGGER_NETDEV_LINK_100) |
> > +                                           BIT(TRIGGER_NETDEV_LINK_1000) |
> > +                                           BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> > +                                           BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> > +                                           BIT(TRIGGER_NETDEV_TX) |
> > +                                           BIT(TRIGGER_NETDEV_RX));
> > +
> > +static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 index,
> > +                                     unsigned long rules)
> > +{
> > +     if (index >= MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     /* All combinations of the supported triggers are allowed */
> > +     if (rules & ~supported_trgs)
> > +             return -EOPNOTSUPP;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> > +                                    unsigned long *rules)
> > +{
> > +     int val;
> > +
> > +     if (index >= MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     val = mxl86110_read_extended_reg(phydev,
> > +                                      MXL86110_LED0_CFG_REG + index);
> > +     phy_unlock_mdio_bus(phydev);
> > +     if (val < 0)
> > +             return val;
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_TX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_RX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_LINK_10);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_LINK_100);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
> > +             *rules |= BIT(TRIGGER_NETDEV_LINK_1000);
> > +
> > +     return 0;
> > +};
>
> extra ;
>
> > +
> > +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +                                    unsigned long rules)
> > +{
> > +     u16 val = 0;
> > +     int ret;
> > +
> > +     if (index >= MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_10))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_100))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_TX))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_RX))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> > +             val |= MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_TX) ||
> > +         rules & BIT(TRIGGER_NETDEV_RX))
> > +             val |= MXL86110_LEDX_CFG_LAB_BLINK;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     ret = mxl86110_write_extended_reg(phydev,
> > +                                       MXL86110_LED0_CFG_REG + index, val);
> > +     phy_unlock_mdio_bus(phydev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +};
>
> extra ;
>
> > +
> > +/**
> > + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> > + * @phydev: pointer to the phy_device
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative errno code
> > + */
> > +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> > +{
> > +     u16 mask = 0, val = 0;
> > +     int ret;
> > +
> > +     /*
> > +      * Configures the clock output to its default
> > +      * setting as per the datasheet.
> > +      * This results in a 25MHz clock output being selected in the
> > +      * COM_EXT_SYNCE_CFG register for SyncE configuration.
> > +      */
> > +     val = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +                     FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> > +                                MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> > +     mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> > +
> > +     /* Write clock output configuration */
> > +     ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> > +                                        mask, val);
> > +
> > +     return ret;
> > +}
> > +
>
> Thanks,
> Alok

