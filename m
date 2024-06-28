Return-Path: <netdev+bounces-107624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B290091BB94
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150DB1F2179E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36276152E03;
	Fri, 28 Jun 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmD3ApQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0315278D;
	Fri, 28 Jun 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567430; cv=none; b=pZW3cdxdKf8N69b0Bhq4RAq28q7gm9J9Z1wtu1MVaakxHWzpf9lHgxuepPTKR/fas3ZGfSzwdL2K+JGil0Z3thpSFd8l5qx6GaG9UmAtyQQdYGOJII5JU2Q4+ktsTwkuOzGMA7UEpcDjEo/ldBChwivCrZw/fTMiPXi2RG7nXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567430; c=relaxed/simple;
	bh=VDmEj/cwUJjAJeEoNi4alm75+sGyk2YjqZ0y5PfkbPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXHbJbO7pyhHeb+PJZLO5QVzkLk34mnSFPhYqDx40gS+6aXg8y4OEYCxlzObAjdqk5K0ACmXDwbyGETlO5j/E8+fJ/38/6HBdRlxhdgjjHYnv2gvO1fBl5q4jCRhRRnAqiTPIZXrmGD3Paog/vQlVSTl5EDKlmviDFYOikl5KdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmD3ApQL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d55ec570a7so225538b6e.1;
        Fri, 28 Jun 2024 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719567428; x=1720172228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k3Rd7uvuD4w7EE2WK1HzrikRlBWrM23sNJsR+VublGE=;
        b=HmD3ApQLb0cf6nic/L1NKrS5unXVpyJlZW3SkQEBMXQyRqLc40ynAWmdHBnZBZ01Ln
         lbIEJZmaqW8BfzT18m9pZYnal7BR1KIF97EF470/aehUkeMh6HPWl/z7iTPgOsNzZbmY
         DGvEHHzjV90AfYpii80MniEaEnSaRy2qE3OrNqwJeVM2lCsYFCEHjgfDXC69ROsCsRMI
         L2kU88R+Ik898zQ3CYFsVCDfjfCt/CJbJh1NvNWp+og9iQbNOWinonsSgU9YFzayE+Iv
         irO9Y4L2yqFGfdx+jcOV0tKKOAsPPbym02TJZmx//w7EdAwcpYpjfP+AYBsYBkjsTp+q
         luPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567428; x=1720172228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3Rd7uvuD4w7EE2WK1HzrikRlBWrM23sNJsR+VublGE=;
        b=bRkI2aNqQ5F6/Wd7z3fjL8tAaELDw+tGfYKvTMv7jMITmSQxxNru/TEkR9kvOglLjT
         ZSvzQXQgPaGooGAR2tSJ6kNtR4lS+sgNKS33S/Zl+wPpsfjekSSX7RA+xrejIFKK+hsD
         GMJ1XPSsAmPEB2yy1qzBPI2BdkaCWpm/wPIA8ddjmOkgl+MyrGg11r9rwuZkr1nsDnYL
         zNqLcZStxgVXQtGAqCDIkpwRwsF/UyRlHQbn9PXKdx9ZS+kM3DwC8gIB52NktLSLkIaZ
         BoG1UPoFkQUjKxG38N8jyDJrTesoJrS+G3HnqrqJAO83NyqMTQrOyfLZucgDds8YQsLT
         QPbA==
X-Forwarded-Encrypted: i=1; AJvYcCWDdnUZRIlQhwuk6FF3Jmpfl5GZpB8hC860ypx4PwnxUU/h9e/2WTFwlkr9k6jX02yPvB4o/fTnwDJCs9QPxMEyT5fepFUh8y0YbGrdoP9YYqgbW11eqj1R+Py4xc9TPIXyuaBU
X-Gm-Message-State: AOJu0YxngOt8N57/gwDTnRMnBpdYsh67ZGs1jZ2f3Nj9ltISmghkeQHK
	bjeFgiBWWRHgaTqquiDJRlII43wCH/8lFm11in1mdY0PjMilZu03
X-Google-Smtp-Source: AGHT+IFNYcP8yn20V50FXenqjQ7bbisnvWrp+nnWjYMaN4UWEq1txFuUga5dMa6gTj8C9XtepCEMlA==
X-Received: by 2002:a05:6808:2217:b0:3d6:32c9:cc87 with SMTP id 5614622812f47-3d632c9ce60mr500198b6e.1.1719567426048;
        Fri, 28 Jun 2024 02:37:06 -0700 (PDT)
Received: from [192.168.3.22] (89-145-235-100.xdsl.murphx.net. [89.145.235.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f72a7sm951125a12.63.2024.06.28.02.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:37:05 -0700 (PDT)
Message-ID: <99ac96ff-df39-4446-9ee7-752f4bf18a3e@gmail.com>
Date: Fri, 28 Jun 2024 10:37:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_device: fix PHY WOL enabled, PM failed to
 suspend
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Youwan Wang <youwan@nfschina.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240628060318.458925-1-youwan@nfschina.com>
 <Zn5xmMpTLK/fRoYh@shell.armlinux.org.uk>
 <249879ad-aa97-452c-a173-65255818d2d4@gmail.com>
 <Zn6BZ4b4h8YJ3Z0u@shell.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <Zn6BZ4b4h8YJ3Z0u@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/2024 10:24 AM, Russell King (Oracle) wrote:
> On Fri, Jun 28, 2024 at 09:25:54AM +0100, Florian Fainelli wrote:
>> Would not the situation described here be solved by having the Motorcomm PHY
>> driver set PHY_ALWAYS_CALL_SUSPEND since it deals with checking whether WoL
>> is enabled or not and will just return then.
> 
> Let's also look at PHY_ALWAYS_CALL_SUSPEND. There are currently two
> drivers that make use of it - realtek and broadcom.
> 
> Looking at realtek, it is used with driver instances that call
> 	rtl821x_suspend
> 	rtl821x_resume
> 
> rtl821x_suspend() does nothing if phydev->wol_enabled is true.
> rtl821x_resume() only re-enabled the clock if phydev->wol_enabled
> was false (in other words, rtl821x has disabled the clock.) However,
> it always calls genphy_resume() - presumably this is the reason for
> the flag.
> 
> The realtek driver instances do not populate .set_wol nor .get_wol,
> so the PHY itself does not support WoL configuration. This means
> that the phy_ethtool_get_wol() call in phy_suspend() will also fail,
> and since wol.wolopts is initialised to zero, phydev->wol_enabled
> will only be true if netdev->wol_enabled is true.
> 
> Thus, for phydev->wol_enabled to be true, netdev->wol_enabled must
> be true, and we won't get here via mdio_bus_phy_suspend() as
> mdio_bus_phy_may_suspend() will return false in this case.
> 
> 
> Looking at broadcom, it's used with only one driver instance for
> BCM54210E which calls:
> 	bcm54xx_suspend
> 	bcm54xx_resume
> 
> Other driver instances also call these two functions but do not
> set this flag - BCM54612E, BCM54810, BCM54811, BCM50610, and
> BCM50610M. Moreover, none of these implement the .get_wol and
> .set_wol methods which means the behaviour is as I describe for
> Realtek above that also doesn't implement these methods.
> 
> The only case where this is different is BCM54210E which does
> populate these methods.
> 
> bcm54xx_suspend() stops ptp, and if WoL is enabled, configures the
> wakeup IRQ. bcm54xx_resume() deconfigures the wakeup IRQ.
> 
> This could lead us into a case where the PHY has WoL enabled, the
> phy_ethtool_get_wol() call returns that, causing phydev->wol_enabled
> to be set, and netdev->wol_enabled is not set.
> 
> However, in this case, it would not be a problem because the driver
> has set PHY_ALWAYS_CALL_SUSPEND, so we won't return -EBUSY.
> 
> 
> Now, looking again at motorcomm, yt8521_resume() disables auto-sleep
> before checking whether WoL is enabled. So, the driver is probably
> missing PHY_ALWAYS_CALL_SUSPEND if auto-sleep needs to be disabled
> each and every resume whether WoL is enabled or not.
> 
> However, if we look at yt8521_config_init(), this will also disable
> auto sleep. This will be called from phy_init_hw(), and in the
> mdio_bus_phy_resume() path, immediately before phy_resume(). Likewise
> when we attach the PHY.
> 
> Then we have some net drivers that call phy_resume() directly...
> 
> drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> 	(we already have a workaround merged for
> 	PHY-not-providing-clock)
> 
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> 	A suspend/resume cycle of the PHY is done when entering loopback mode.
> 
> drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
> 	No idea on this one - it resumes the PHY before enabling
> 	loopback mode, and enters suspend when disabling loopback
> 	mode!
> 
> drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 	bcmgenet_resume() calls phy_init_hw() before phy_resume().

Yes, there was a reason for that, that had to do with a finicky PHY 
IIRC, should be documented properly in the commit message since this 
came from my colleague Doug.

> 
> drivers/net/ethernet/broadcom/bcmsysport.c
> 	bcm_sysport_resume() *doesn't* appear to call phy_init_hw()
> 	before phy_resume(), so I wonder whether the config is
> 	properly restored on resume?

This driver is using the fixed PHY emulation so it does not really 
matter, it also sets mac_managed_pm to true.

> 
> drivers/net/ethernet/realtek/r8169_main.c
> 	rtl8169_up() calls phy_init_hw() before phy_resume().
> 
> drivers/net/usb/ax88172a.c
> 	This doesn't actually call phy_resume(), but calls
> 	genphy_resume() directly from ax88172a_reset() immediately
> 	after phy_connect(). However, connecting to a PHY will
> 	call phy_resume()... confused here.
> 
> So I'm left wondering whether yt8521_resume() should be fiddling with
> this auto-sleep mode, especially as yt8521_config_init() will do that
> if the appropriate DT property is set... and whether this should be
> done unconditionally.
> 

-- 
Florian

