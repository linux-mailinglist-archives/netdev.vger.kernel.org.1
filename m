Return-Path: <netdev+bounces-205970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA847B00FC8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE1717029C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA222D4DD;
	Thu, 10 Jul 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCeT6JmA"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450418CC13
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190672; cv=none; b=Q67/uyw2lgXbPsNXb0U+1Jq5dUz7KxT36r8iIFNDH7hqo/AZ+IilF8ExUozUIFDV/So2ShhIW44thCJQ5pPXX5DDFHtOMcju+9AeUX13ifaJ8LEsKtoNGv2kXXt9+9DNQtnFfgK3nC0rBv3mc38+p8bJzdF9m5FCHVqwKJa4qvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190672; c=relaxed/simple;
	bh=BOcEwciZG3UPwczqc6Kffau7PK4yhnLOxhmVELp8uO4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hV1x3PZCqUDXtwjNtlnMEfo7RPF59p6OyXS9sCC0ldC70zV6zDsBJuM3OZu2XBmsKmXxVORZuon9CGclWLtKcxXiOH17+MRLOT+0FN0THPgYLsqYF2DZfSYaSQvth4GnMo+uGFMmKf93Gyh132/kxaQaCpx4LY3OKmpXI/otl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCeT6JmA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a80e55af-14a2-41d8-afcc-7dbf267e85ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752190657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNqapVscHGzGt/oRXqDPP8IZMAkPeXOSaImaeu0zjIk=;
	b=oCeT6JmAYdHCBQ23iBszQP13Vxu1XWtzMxx3lim7ILp4a4qM/+agQQHNG0zQsgM14dUDIV
	h0IWjOLnf4GMEsPBluiBclPCzFsPFsFEWZsGAMxz5VYBbdnix9lQl18FtpfHI87qNCSWOW
	jYw/sB0IpXV6aAe22E8MwX9ggSJVOTA=
Date: Thu, 10 Jul 2025 19:37:28 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Saravana Kannan <saravanak@google.com>,
 Leon Romanovsky <leon@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-arm-kernel@lists.infradead.org
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
 <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
 <0854ddee-1b53-472c-a4fe-0a345f65da65@linux.dev>
 <c543674a-305e-4691-b600-03ede59488ef@lunn.ch>
 <a8a3e849-bef9-4320-8b32-71d79afbab87@linux.dev>
 <3e2acebe-a9db-494b-bca8-2e1bbc3c1eaf@lunn.ch>
 <d87ab382-cc6c-46df-bd7e-1200154dd84f@linux.dev>
Content-Language: en-US
In-Reply-To: <d87ab382-cc6c-46df-bd7e-1200154dd84f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

On 6/23/25 19:16, Sean Anderson wrote:
> On 6/23/25 18:45, Andrew Lunn wrote:
>> On Mon, Jun 23, 2025 at 02:48:53PM -0400, Sean Anderson wrote:
>>> On 6/23/25 14:27, Andrew Lunn wrote:
>>> > On Mon, Jun 23, 2025 at 11:16:08AM -0400, Sean Anderson wrote:
>>> >> On 6/21/25 03:33, Andrew Lunn wrote:
>>> >> > On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
>>> >> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
>>> >> >> probe loop if the EPROBE_DEFER error is never resolved.
>>> >> > 
>>> >> > That sounds like a core problem. I also thought there was a time
>>> >> > limit, how long the system will repeat probes for drivers which defer.
>>> >> > 
>>> >> > This seems like the wrong fix to me.
>>> >> 
>>> >> I agree. My first attempt to fix this did so by ignoring deferred probes
>>> >> from child devices, which would prevent "recursive" loops like this one
>>> >> [1]. But I was informed that failing with EPROBE_DEFER after creating a
>>> >> bus was not allowed at all, hence this patch.
>>> > 
>>> > O.K. So why not change the order so that you know you have all the
>>> > needed dependencies before registering the MDIO bus?
>>> > 
>>> > Quoting your previous email:
>>> > 
>>> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
>>> >> probe loop if the EPROBE_DEFER error is never resolved. For example,
>>> >> if the PCS is located on another MDIO bus and that MDIO bus is
>>> >> missing its driver then we will always return EPROBE_DEFER.
>>> > 
>>> > Why not get a reference on the PCS device before registering the MDIO
>>> > bus?
>>> 
>>> Because the PCS may be on the MDIO bus. This is probably the most-common
>>> case.
>> 
>> So you are saying the PCS is physically there, but the driver is
>> missing because of configuration errors? Then it sounds like a kconfig
>> issue?
>> 
>> Or are you saying the driver has been built but then removed from
>> /lib/modules/
> 
> The latter. Or maybe someone just forgot to install it (or include it
> with their initramfs). Or maybe there was some error with the MDIO bus.
> 
> There are two mutually-exclusive scenarios (that can both occur in the
> same system). First, the PCS can be attached to our own MDIO bus:
> 
> MAC
>  |
>  +->MDIO
>      |
>      +->PCS
>      +->PHY (etc)
> 
> In this scenario, we have to probe the MDIO bus before we can look up
> the PCS, since otherwise the PCS will always be missing when we look for
> it. But if we do things in the right order then we can't get
> EPROBE_DEFER, and so there's no risk of a probe loop.
> 
> Second, the PCS can be attached to some other MDIO bus:
> 
> MAC              MDIO
>  |                 |
>  +->MDIO           +->PCS
>       |
>       +->PHY (etc)
> 
> In this scenario, the MDIO bus might not be present for whatever reason
> and we have the possibility of an EPROBE_DEFER error. If that happens,
> we will end up in a probe loop because the PHY on the MDIO bus
> incremented deferred_trigger_count when it probed successfully:
> 
> deferred_probe_work_func()
>   driver_probe_device(MAC)
>     axienet_probe(MAC)
>       mdiobus_register(MDIO)
>         device_add(PHY)
>           (probe successful)
>           driver_bound(PHY)
>             driver_deferred_probe_trigger()
>       return -EPROBE_DEFER
>     driver_deferred_probe_add(MAC)
>     // deferred_trigger_count changed, so...
>     driver_deferred_probe_trigger()

Does the above scenario make sense? As I see it, the only approaches are

- Modify the driver core to detect and mitigate this sort of scenario
  (NACKed by Greg).
- Split the driver into MAC and MDIO parts (this patch).
- Modify phylink to allow connecting a PCS after phylink_create but
  before phylink_start. This is tricky because the PCS can affect the
  supported phy interfaces, and phy interfaces are validated in
  phylink_create.
- Defer phylink_create to ndo_open. This means that all the
  netdev/ethtool ops that use phylink now need to check ip the netdev is
  open and fall back to some other implementation. I don't think we can
  just return -EINVAL or whatever because using ethtool on a down device
  has historically worked. I am wary of breaking userspace because some
  tool assumes it can get_ksettings while the netdev is down.

Do you see any other options? IMO, aside from the first option, the
second one has the best UX. With the latter two, you could have a netdev
that never comes up and the user may not have very good insight as to
why. E.g. it may not be obvious that the user should try to bring the
netdev up again after the PCS is probed. By waiting to create the netdev
until after we successfully probe the PCS we show up in
devices_deferred and the netdev can be brought up as usual.

--Sean

