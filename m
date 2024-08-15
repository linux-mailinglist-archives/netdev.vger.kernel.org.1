Return-Path: <netdev+bounces-119024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C5953DDB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B200AB26F72
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75815155385;
	Thu, 15 Aug 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AjrU+an2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374F12B94
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763513; cv=none; b=l/EEtbha9ymD4LWlju0YmBl44pQAG9IPd+CSDE8M2U4LqCj1tvQvTBW2rMd7lI3S/hM3FCf6l+SdUw69QRr4WFu+VZHUoD77Zo6QE1oMXXv5Xi7EcJECEm+kHlsiYWTgrD50EnLBMKyN/lp9Z2lzullnoh/xkaVouHhoVlBpGWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763513; c=relaxed/simple;
	bh=Ec8h09rEooXMLSUW91MkFZkyw6M+PqveKq4WGFsqfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8HQs/uQg06OxbPisV8/7RNomcq15rILx6zFJd8it9Mag+32hIhdqy/wMg1phyBisE9EQR5QEFfIwVaL5ywhBRPUZ11Sp1D9h5roS2lm0Nvs19e9JG9koYZ/E+3S86NWdKoCzFriXNrXl5EFSqlkCFuOidV2JpWCcFPAGsWiNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AjrU+an2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J43jmhnC+s2StBUpkeCduuqxxGyHhIWLNhI4QZ0eZzg=; b=AjrU+an2Kg5RmeP3gS0bwa0bUl
	va59xGGD95WaBlqDW/LEZN6JZVIEi8wtiZgwV+261zjRhYejoQU/j+dpuiNAoD/Dcm058LDtVudKS
	Xd4YugiKhY3aHL1J6h/5nHELoDVYz8sz963PK3gHUlz1iobAE9dRReflsxcPprKp7Dhw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sejdA-004sXJ-1w; Fri, 16 Aug 2024 01:11:44 +0200
Date: Fri, 16 Aug 2024 01:11:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <a1bb18d0-174f-486a-bdfd-295d7c5ce4b2@lunn.ch>
References: <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
 <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
 <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
 <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>

On Fri, Aug 16, 2024 at 12:06:51AM +0200, Maciek Machnikowski wrote:
> 
> 
> On 15/08/2024 23:08, Richard Cochran wrote:
> > On Thu, Aug 15, 2024 at 05:00:24PM +0200, Maciek Machnikowski wrote:
> > 
> >> Think about a Time Card
> >> (https://opencomputeproject.github.io/Time-Appliance-Project/docs/time-card/introduction).
> > 
> > No, I won't think about that!
> > 
> > You need to present the technical details in the form of patches.
> > 
> > Hand-wavey hints don't cut it.
> > 
> > Thanks,
> > Richard
> 
> This implementation addresses 3 use cases:
> 
> 1. Autonomous devices that synchronize themselves to some external
> sources (GNSS, NTP, dedicated time sync networks) and have the ability
> to return the estimated error from the HW or FW loop to users

So this contradicts what you said earlier, when you said the device
does not know its own error, it has to be told it.

So what is user space supposed to do with this error? And given that
you said it is undefined what this error includes and excludes, how is
user space supposed to deal with the error in the error? Given how
poorly this is defined, what is user space supposed to do when the
device changes the definition of the error?

The message Richard has always given is that those who care about
errors freeze their kernel and do measurement campaign to determine
what the real error is and then configure user space to deal with
it. Does this error value negate the need for this?

> 2. Multi function devices that may have a single isolated function
> synchronizing the device clock (by means of PTP, or PPS or any other)
> and letting other functions access the uncertainty information

So this is the simple message passing API, which could be implemented
purely in the core? This sounds like it should be a patch of its own,
explaining the use case. 

> 3. Create a common interface to read the uncertainty from a device
> (currently you can use PMC for PTP, but there is no way of receiving
> that information from ts2phc)

That sounds like a problem with ts2phc? Please could you expand on why
the kernel should be involved in feature deficits of user space tools?

> Also this is an RFC to help align work on this functionality across
> different devices ] and validate if that's the right direction. If it is
> - there will be a patch series with real drivers returning uncertainty
> information using that interface. If it's not - I'd like to understand
> what should I improve in the interface.

I think you took the wrong approach. You should first state in detail
the use cases. Then show how you solve each use cases, both the user
and kernel space parts, and include the needed changes to a real
device driver.

	Andrew

