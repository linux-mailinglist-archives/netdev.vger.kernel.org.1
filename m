Return-Path: <netdev+bounces-18717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D47585D8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12D71C20D1A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5B171C9;
	Tue, 18 Jul 2023 19:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00110946
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E0CC433C8;
	Tue, 18 Jul 2023 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689710010;
	bh=iS8olXu4j8uUvayUIlwSeJUyNl508dh0P8150fs7BRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=agag+Gscd6wX7IDzIqBzi1Td8r+5wRVep1vJYbhVCCNwdq7eUERxITKXmAznPuLjC
	 Q9CsueWTJkjgLZNgENnGENdB65aKIQR3t+pX6x6bzsS0r5v/TqhfN80UoETNjYJvBl
	 L9NLlaPvmfFIT9w1sCIKqNtK3VrqWYsA9zgt9xUIbFmmvMX1s/+Sy2YWnL1w6h4RhI
	 JaN49/blYRgppryxR/SFyfl5LUdAo/JJNhzjhf3/0Q236Pw4hIPHe6t8lIEpcm/ZGI
	 /3arPWc8kABMo0tFmDJ87cWSYExO75nEy0GlfEkFPObnJi3nwszvuQa7s66aKl9o+p
	 fu4AD4wLNGwlg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jul 2023 21:53:25 +0200
From: Michael Walle <mwalle@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 03/11] net: phy: replace is_c45 with
 phy_accces_mode
In-Reply-To: <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-3-9eb37edf7be0@kernel.org>
 <509889a3-f633-40b0-8349-9ef378818cc7@lunn.ch>
Message-ID: <66d9daa106d7840e972dba35914e6983@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 2023-07-18 19:40, schrieb Andrew Lunn:
>>  static inline bool phy_has_c45_registers(struct phy_device *phydev)
>>  {
>> -	return phydev->is_c45;
>> +	return phydev->access_mode != PHY_ACCESS_C22;
>>  }
> 
> So this is making me wounder if we have a clean separation between
> register spaces and access methods.

The idea is to at least have it behind a helper which can be changed
if we get that information from somewhere else.

But right now, a PHY is considered to have c45 registers if it is
probed via c45 (accesses).

Instead of checking the access mode, I could also introduce a
bitmask(?)/flags has_c22/has_c45_registers. But how would you tell
if a PHY as c22 registers? Probe both c22 and c45? What if the bus
can't do c45?

> Should there be a phy_has_c22_registers() ?
> 
> A PHY can have both C22 registers and C45 registers. It is up to the
> driver to decide which it wants to access when.

But isn't it also the driver which has the ultimate information whether
a PHY has c22 register space and/or c45 one?

Maybe we need to clarify what "has c22/c45 registers space" actually
means. Responds to MII c22/c45 access?

-michael

> Should phydev->access_mode really be phydev->access_mode_c45_registers
> to indicate how to access the C45 registers if phy_has_c45_registers()
> is true?
> 
> Has there been a review of all uses of phydev->is_c45 to determine if
> the user wants to know if C45 registers exist,
> a.k.a. phy_has_c45_registers(), or if C45 bus transactions can be
> performed, and then later in this series, additionally if C45 over C22
> can be performed. These are different things.
> 
> I need to keep reading the patches...
> 
>   Andrew

