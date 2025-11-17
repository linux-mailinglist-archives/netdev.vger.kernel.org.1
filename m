Return-Path: <netdev+bounces-239206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984DC658E2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4C39428B47
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F92BD5B9;
	Mon, 17 Nov 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whzQxRT+"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E827935F
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401161; cv=none; b=CSr3ngn0WVcLjUHeCmKcX/BS4QTZ8aqSHbwk8RUcts+rK1AoioTiAWNJ9L26jmCEqcr/wVUx7CkpSURktETJJ3QppyGzIPXyhcUqoKfxTkOduvqOE263q0ft+Jhya8qnT/IKq8wFtutekeH+8atYAwo/vUXSrrOOt/NQj5nsjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401161; c=relaxed/simple;
	bh=gCVi1ujSlZCVvKqC5qVeWlGdEHW5kKS+H5GkDDqAhkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRbvJp0stGNpjZCcPZHXFyCmKm+qJKE3lvn0oO73iXjQmgKv+V6P7SVE5iBqh0S4eAqq/W09+xyvYeIf2Yb/6VjjuXgNrb5Xigp7zFV6Omvmg4RQVZs6hCBzMfSZKzm+1Hhz4rMUbqbR63mY4VpV/hswc+gRkVinK+3h3XH4nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whzQxRT+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <59d08292-6f38-4784-b12b-520fd24600a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763401157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHX3MnQzc/7gW3re+k58QWQwpOD8JJvZtIAKZeMj+3A=;
	b=whzQxRT+fXYazHXwaGm87corTH12nfT500cAkbAUUNKnEf1HPy3QVZazCegEkXdJP9sxwb
	E9C5db42EQhDYIyYWIyf0YgSS1jyMlhSVNFD0Hzb3SnO26HzHlgELDUdlEG4EiL3KWx4Ff
	fFM547I9DZVOmPcYH35Cuwo7I/nJ2As=
Date: Mon, 17 Nov 2025 17:39:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
 <aRXN61oICP3Vkk84@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aRXN61oICP3Vkk84@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 12:24, Russell King (Oracle) wrote:
> On Thu, Nov 13, 2025 at 12:12:44PM +0000, Vadim Fedorenko wrote:
>> On 13/11/2025 12:02, Russell King (Oracle) wrote:
>>> On Thu, Nov 13, 2025 at 11:32:00AM +0000, Vadim Fedorenko wrote:
>>>> PHY devices had lack of hwtstamp_get callback even though most of them
>>>> are tracking configuration info. Introduce new call back to
>>>> mii_timestamper.
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>> As part of my Marvell PTP work, I have a similar patch, but it's
>>> way simpler. Is this not sufficient?
>>>
>>> __phy_hwtstamp_get() is called via phylib_stubs struct and
>>> phy_hwtstamp_get(), dev_get_hwtstamp_phylib(), dev_get_hwtstamp(),
>>> and dev_ifsioc().
>>>
>>> Using the phylib ioctl handler means we're implementing a path that
>>> is already marked as legacy - see dev_get_hwtstamp():
>>>
>>>           if (!ops->ndo_hwtstamp_get)
>>>                   return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
>>>
>>> So, I think the below would be the preferred implementation.
>>
>> You mean do not add SIOCGHWTSTAMP case in phy_mii_ioctl() as we should
>> never reach this legacy option?
> 
> We _can_ reach phy_mii_ioctl() for SIOCGHWTSTAMP where drivers do not
> provide the ndo_hwtstamp_get() method. However, as this is legacy code,
> the question is: should we add it?
> 
>> Technically, some drivers are (yet) not
>> converted to ndo_hwtstamp callbacks and this part can potentially work
>> for bnx2x driver, until the other series lands.
> 
> Right, but providing new features to legacy paths gives less reason for
> people to stop using the legacy paths.
> 
>> I was planning to remove SIOCSHWTSTAMP/SIOCGHWTSTAMP dev_eth_ioctl calls
>> later once everything has landed and we have tests confirming that ioctl
>> and netlink interfaces work exactly the same way.
> 
> However, implementations that do populate non-legacy ndo_hwtstamp_get()
> won't work correctly with your conversion, since we'll fall through to
> the path which calls __phy_hwtstamp_get() which won't do anything.
> 
> So I disagree with your patch - it only adds support for legacy net
> drivers to get the hwtstamp settings from the PHY. Non-legacy won't be
> supported.
> 
> At minimum, we should be adding support for non-legacy, and _possibly_
> legacy.
> 
> Let's wait for others to comment on my point about adding this for the
> legacy drivers/code path.
As there was no conversation for a couple of days, and Andrew expressed
the same thought about not going to implement SIOCGHWTSTAMP, I'm going
to publish new version with this part removed.

