Return-Path: <netdev+bounces-148404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BD9E15DD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B9F1629A0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B081D7989;
	Tue,  3 Dec 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwS9jaYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5451BDA99;
	Tue,  3 Dec 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214917; cv=none; b=TEiN2lTTJsAh1Hhklso8ox0Ds9KFQLfRTDLi9bk021KoFhu185KFQeArJXtvbAYVuNsGF1iczzRHEingZafTqplMskSGOUyxKUdcLyXi2YH0mL7m2GLg1J/EcvVC9h6tOTuK3R+VqwY2JE6f1Gpv3xt7/fhO0F1i/Trb/Tm57PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214917; c=relaxed/simple;
	bh=uZc7L7ep3NbmsWUxJIlU5jpt4fDLkO4yvxvBwenDTc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec7dSdA3JztAMM64/Gxvrq0h8bMck73laaRJNaLwB6A9ujcFxp0e/rgBHY3J5XpA09nzOJsAtrQn/Tp5SXjnJvaOyjG74TwlNT+/vaDrw3ZsvYQksBp8L0fb5d7UAMQEzK7Up8lop45dvlNnlD1cKBbwMLEzDNFwX2nPrhTqln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwS9jaYw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724d5e309dfso358630b3a.2;
        Tue, 03 Dec 2024 00:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733214915; x=1733819715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoysy7ExY2zCGFO4vPz0GcjfXx6pttZhUm7NeZ7P5/w=;
        b=VwS9jaYwnfD0flJ1RINiWTsMIEF8jbZgz/SZDopqmFcEIX2skkjQyLhTnL1hVka+oI
         rJkQNFYwVjzcHTBgzFHRV6/uF3OEbsd1PobbUpvTR5BNOeiGgZBWtoOnbvJm2dhx2+Fr
         bhbyXzJMowmx++q1dzZVN+ynsYAlhkwT1AysAgyQ4UJKvNvG11fz807sTgEdk0/HB0A/
         o1bko72TVSzVAZFNLc5s8DtwDLos9s8z3Z85+Ck9jHxdFZX4DSBHPUiQX8qOzOmWb7a2
         Xu7VuGil+2vdrFfg9s9sBVRFcENgGopWD6tOAwlbcwyu1kG3hXC79EGd61dm98YcNtsU
         NZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733214915; x=1733819715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qoysy7ExY2zCGFO4vPz0GcjfXx6pttZhUm7NeZ7P5/w=;
        b=kN23pdDZ+6qrKHnd5IRpgqH8JMqOqE1EIGH1OfysGxQiY65uSUckRmGepHJkbti9Y+
         1j1WL4hLi4+6RDTSc0MI/R+D96kP7VlGbrV9Nc6hsIX2b5YGuUnLiPdgWd9nPO9C5CL2
         bJcVTsY55SkoE9Jm5P0kA4tf8/a9Hpq+mw8XQWsT/MBU4BduaYIIKl3hiGo50KU/+Ygi
         WZB5tg53kpzi419MSSxtXyQbk9tMMvriR/dOQVxvXDU1jEsL2/yzJo9WC1gtOXTVRDSU
         RFEuZhkLersq46RAl3Z/zr8o9P2+ZCtJX/stK81qQqGIdA3b18zBHTvk8b+qX2dd4g8S
         hs6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlo0x1GYkp7A9LmXAm14KvzErGTVZrIutM8LV7pZXHixRRZPx+vgl+HmItSaUrZWWhAY6b7hQo@vger.kernel.org, AJvYcCXw8IEcKcyveYMpgREbCznaL2Vtf67XzZwZ7GzmTbhaGE9P7G6Mnq/GZu9yheCjbskiTLGF5Lxv0+HKFtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfO73kpn7p51pVhKhrAlT7o0zOjnwuNpy/GRaP4ZXo/zFnAqvU
	RzH2drZl3+U5wdogiQswwoDPi6SjzyJMd7K0ZZc88gzSn7mpbcHW
X-Gm-Gg: ASbGncsb1paPcEGMT0FVe2RviqaLknJNHnW9Yoh6EFc2ZzkQsT48x+BcsL5g7gXzNFX
	n0I5NL0QAxZhXRI5DCDJJsVV6KfQZnl2QzpoHeDhoQ+BiAdFykcQbf28C2P8ALLHbAcbYmm0b3L
	mJSyGDLISSyMAvaXBIVVWENybfMzClxQdRQ0F1jG1JF7BxopW6ctVVE7AlWMCMBpHBzcf2eQQaP
	aX0kxyEA8lUx84tTLjeJUqg/VZp44Ei7RDLsVqmutkOt/4x
X-Google-Smtp-Source: AGHT+IH1zwTWafOZvLWv10ywkeAMr9jVubxriQ5H1aFGuJsGF2S54NKi8mJKq6I7Y4zgGy3JA8PjOQ==
X-Received: by 2002:a05:6a00:3a12:b0:71e:5b2b:9927 with SMTP id d2e1a72fcca58-7257fa42635mr997870b3a.1.1733214914821;
        Tue, 03 Dec 2024 00:35:14 -0800 (PST)
Received: from [10.96.3.69] ([23.225.64.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541770786sm9874099b3a.79.2024.12.03.00.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 00:35:14 -0800 (PST)
Message-ID: <e707044d-a1d3-40c4-aeef-fad68c6a1785@gmail.com>
Date: Tue, 3 Dec 2024 16:35:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy.liu@realtek.com,
 Yuki Lee <febrieac@outlook.com>, andrew@lunn.ch
References: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
 <20241203071853.2067014-1-kmlinuxm@gmail.com>
 <d2490036-418e-4ed9-99f6-2c4134fece7b@gmail.com>
From: Zhiyuan Wan <kmlinuxm@gmail.com>
In-Reply-To: <d2490036-418e-4ed9-99f6-2c4134fece7b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/3 15:38, Heiner Kallweit wrote:
> 
> Take care to remove the Rb tag if you make changes to the patch.
> 
Roger that.
> 
> This still uses the _changed version even if not needed.
> 
I'm not sure is it okay to directly write PHYCR1 register, because not
only it controls ALDPS and broadcast PHY address, but also controls
MDI mode/Jabber detection.

I'm afraid that maybe it causes problem if I don't use RMW to clear
the PHYAD_EN bit. Because the following code in `rtl8211f_config_init`
also utilizes `phy_modify_paged_changed` to change ALDPS setting
without touching anything else.

But if you insist, I can modify code to this if you like:


	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
	if (ret < 0)
		return ret;

	dev_dbg(dev, "disabling MDIO address 0 for this phy");
	priv->phycr1 = ret & (u16)~RTL8211F_PHYAD0_EN;
	ret = phy_write_paged(phydev, 0xa43, RTL8211F_PHYCR1,
			      priv->phycr1);
	if (ret < 0) {
		return dev_err_probe(dev, ret,
			             "disabling MDIO address 0 failed\n");
	}
	/* Don't allow using broadcast address as PHY address */
	if (phydev->mdio.addr == 0)
		return -ENODEV;

 	priv->phycr1 &= (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
...



>> +	if (ret < 0) {
>> +		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
>> +			ERR_PTR(ret));
> 
> You may want to use dev_err_probe() here. And is it by intent that
> the error is ignored and you go on?
> 

I'm sorry that I made a mistake.

> 
> And one more formal issue:
> You annotated the patch as 1/2, but submit it as single patch.
> 
I have another patch to enable support optical/copper combo support
of RTL8211FS PHY in this mail thread, but since Andrew said that patch
(migrated from Rockchip SDK) is low quality and I'm too busy with my
job, don't have much time to read and improve it, so I decided to
suspend that patch's submission and I'll resume to submit that patch
when I'm free. Could you please give me some advice or recommends on it?

Sincerely,

Zhiyuan Wan

