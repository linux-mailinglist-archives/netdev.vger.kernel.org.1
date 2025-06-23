Return-Path: <netdev+bounces-200419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C25AE57D5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB21164B85
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402D22A808;
	Mon, 23 Jun 2025 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g3zCtqLR"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE423A9AD
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720633; cv=none; b=Hw9WpQahpuUgSFsLKu+RCPBe22YDbL36nniHfOnEQwsA3vTd2aOiEIpAQpEY64+2h4/Wb/a116xB1XmjfvE5iZTNLB1HAED6RgGS/Ek/rbfe9RNLB58yF0hKWtZh/Ii1Le4uq8n2pKNSUQinJbXjhxl2rm5QytZ3xcSBK87C2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720633; c=relaxed/simple;
	bh=q1ee59jU9asBAzYHJYdCJKtSTPXV9820D8vITCtcaC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sr2BmWp6Y/vr8Nr2I3X2kodSOGjqvbyP21wVlHHj1vyKn85fFgiNE8g5zh4QnKarJwanBg/APP8rm5tXLqCtTIXxMik3yeCm8xCcEbhbQzwP0W945OC+8wqHBWds2igOKP92nRyIWTuAmyJQAOyw0KkEIkl782ExlspbrdSGj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g3zCtqLR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d87ab382-cc6c-46df-bd7e-1200154dd84f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750720619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMLuqEEmB90h4r00MzRwYNp3Oo/PGki0fb0ws8udUSM=;
	b=g3zCtqLRxmPfhCgbxCQEg6i4iLxj8I8QtrxLtOUrr/eQxxOy34RNxKdhGE+WZId/GtZfur
	JyFfKxNY0T57L1VRhlunB4w3XeZD3ZetoQXsOB+ayco/2oUeYo8QBuL4dBg25gbD2Y8Ddj
	f/3jhFJ8d+j770X2Wb9P+iKxrVsVNJ4=
Date: Mon, 23 Jun 2025 19:16:53 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <3e2acebe-a9db-494b-bca8-2e1bbc3c1eaf@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/23/25 18:45, Andrew Lunn wrote:
> On Mon, Jun 23, 2025 at 02:48:53PM -0400, Sean Anderson wrote:
>> On 6/23/25 14:27, Andrew Lunn wrote:
>> > On Mon, Jun 23, 2025 at 11:16:08AM -0400, Sean Anderson wrote:
>> >> On 6/21/25 03:33, Andrew Lunn wrote:
>> >> > On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
>> >> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
>> >> >> probe loop if the EPROBE_DEFER error is never resolved.
>> >> > 
>> >> > That sounds like a core problem. I also thought there was a time
>> >> > limit, how long the system will repeat probes for drivers which defer.
>> >> > 
>> >> > This seems like the wrong fix to me.
>> >> 
>> >> I agree. My first attempt to fix this did so by ignoring deferred probes
>> >> from child devices, which would prevent "recursive" loops like this one
>> >> [1]. But I was informed that failing with EPROBE_DEFER after creating a
>> >> bus was not allowed at all, hence this patch.
>> > 
>> > O.K. So why not change the order so that you know you have all the
>> > needed dependencies before registering the MDIO bus?
>> > 
>> > Quoting your previous email:
>> > 
>> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
>> >> probe loop if the EPROBE_DEFER error is never resolved. For example,
>> >> if the PCS is located on another MDIO bus and that MDIO bus is
>> >> missing its driver then we will always return EPROBE_DEFER.
>> > 
>> > Why not get a reference on the PCS device before registering the MDIO
>> > bus?
>> 
>> Because the PCS may be on the MDIO bus. This is probably the most-common
>> case.
> 
> So you are saying the PCS is physically there, but the driver is
> missing because of configuration errors? Then it sounds like a kconfig
> issue?
> 
> Or are you saying the driver has been built but then removed from
> /lib/modules/

The latter. Or maybe someone just forgot to install it (or include it
with their initramfs). Or maybe there was some error with the MDIO bus.

There are two mutually-exclusive scenarios (that can both occur in the
same system). First, the PCS can be attached to our own MDIO bus:

MAC
 |
 +->MDIO
     |
     +->PCS
     +->PHY (etc)

In this scenario, we have to probe the MDIO bus before we can look up
the PCS, since otherwise the PCS will always be missing when we look for
it. But if we do things in the right order then we can't get
EPROBE_DEFER, and so there's no risk of a probe loop.

Second, the PCS can be attached to some other MDIO bus:

MAC              MDIO
 |                 |
 +->MDIO           +->PCS
      |
      +->PHY (etc)

In this scenario, the MDIO bus might not be present for whatever reason
and we have the possibility of an EPROBE_DEFER error. If that happens,
we will end up in a probe loop because the PHY on the MDIO bus
incremented deferred_trigger_count when it probed successfully:

deferred_probe_work_func()
  driver_probe_device(MAC)
    axienet_probe(MAC)
      mdiobus_register(MDIO)
        device_add(PHY)
          (probe successful)
          driver_bound(PHY)
            driver_deferred_probe_trigger()
      return -EPROBE_DEFER
    driver_deferred_probe_add(MAC)
    // deferred_trigger_count changed, so...
    driver_deferred_probe_trigger()

--Sean 

