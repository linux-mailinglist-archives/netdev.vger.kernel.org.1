Return-Path: <netdev+bounces-238331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9CC57588
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1DA3B398D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF234D38A;
	Thu, 13 Nov 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZsPiwZo4"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001934AB09
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035972; cv=none; b=lsFvdobw9J3mgcgLvhEPnUmvJ9tuKnDRUNASce21YOfgsdSGuiCuYGpHXzx8MYoBfzxNuHzFM0m7BCW4cgU8PthZJZACiK70MUePivMxUl/rX9OuaUEc39TkUFTgJty/y0d8MPSchhbe7KuBR2vBeTd6lmrBO0+3nyCkFxUWU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035972; c=relaxed/simple;
	bh=GfuTaw1adoGZtRsyURe8H59Ws3u9eEsEy/A2MZfRPp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLN4ZmCuKDKXP4Dd61YmmOGo/qmUOBiY7qJKX5rAbAUPDe1HgRGL465NC9qjwMl//0tzjwFD8n2lFGUktm4TJ7bNUB2EjxpRtCdQUEZu1E78wNUDLJCafvhEbnxc3EjndAtrDSOF0fEO8WF/VeNvAYR+IMGVcEez5hdeW10rdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZsPiwZo4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763035967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zLcDPI+Ia6zlE9l24xSWBLs7fDEgMrkelfTUYtYriw0=;
	b=ZsPiwZo4I3Lk3kNvDMPxkwQTx22DV/pjFoZGrY0nhbrgH/d2f/YjGGr0PKapCAMG5xSMXA
	pMgXG46iW99qv4Y/FKh/PvbDoXvUi+OVu3DVPDgQH1jzw/ZXXBiDj9g1u6auRr5iZx/46p
	ZVdtqcK8k+prwSvQ0mO190pZHUoZCBI=
Date: Thu, 13 Nov 2025 12:12:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 12:02, Russell King (Oracle) wrote:
> On Thu, Nov 13, 2025 at 11:32:00AM +0000, Vadim Fedorenko wrote:
>> PHY devices had lack of hwtstamp_get callback even though most of them
>> are tracking configuration info. Introduce new call back to
>> mii_timestamper.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> As part of my Marvell PTP work, I have a similar patch, but it's
> way simpler. Is this not sufficient?
> 
> __phy_hwtstamp_get() is called via phylib_stubs struct and
> phy_hwtstamp_get(), dev_get_hwtstamp_phylib(), dev_get_hwtstamp(),
> and dev_ifsioc().
> 
> Using the phylib ioctl handler means we're implementing a path that
> is already marked as legacy - see dev_get_hwtstamp():
> 
>          if (!ops->ndo_hwtstamp_get)
>                  return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
> 
> So, I think the below would be the preferred implementation.

You mean do not add SIOCGHWTSTAMP case in phy_mii_ioctl() as we should
never reach this legacy option? Technically, some drivers are (yet) not
converted to ndo_hwtstamp callbacks and this part can potentially work
for bnx2x driver, until the other series lands.

I was planning to remove SIOCSHWTSTAMP/SIOCGHWTSTAMP dev_eth_ioctl calls
later once everything has landed and we have tests confirming that ioctl
and netlink interfaces work exactly the same way.

> 
> 8<===
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH net-next] net: phy: add hwtstamp_get() method for mii
>   timestampers
> 
> Add the missing hwtstamp_get() method for mii timestampers so PHYs can
> report their configuration back to userspace.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/net/phy/phy.c           | 3 +++
>   include/linux/mii_timestamper.h | 5 +++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 02da4a203ddd..b6fae9299b36 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -476,6 +476,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
>   	if (!phydev)
>   		return -ENODEV;
>   
> +	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
> +		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
> +
>   	return -EOPNOTSUPP;
>   }
>   
> diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
> index 995db62570f9..b6485f602eb9 100644
> --- a/include/linux/mii_timestamper.h
> +++ b/include/linux/mii_timestamper.h
> @@ -29,6 +29,8 @@ struct phy_device;
>    *
>    * @hwtstamp:	Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
>    *
> + * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.
> + *
>    * @link_state: Allows the device to respond to changes in the link
>    *		state.  The caller invokes this function while holding
>    *		the phy_device mutex.
> @@ -55,6 +57,9 @@ struct mii_timestamper {
>   			 struct kernel_hwtstamp_config *kernel_config,
>   			 struct netlink_ext_ack *extack);
>   
> +	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
> +			     struct kernel_hwtstamp_config *kernel_config);
> +
>   	void (*link_state)(struct mii_timestamper *mii_ts,
>   			   struct phy_device *phydev);
>   


