Return-Path: <netdev+bounces-61969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C500C825697
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AF11F22AA8
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB52E630;
	Fri,  5 Jan 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsTBvmJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB428E34
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 15:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6056C433C8;
	Fri,  5 Jan 2024 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704468603;
	bh=um3RCdU6vHZ8fq/ZxNHWili3pxluQ6gDbhgicSFok+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SsTBvmJJcffOmcwHm5v5zBVFxJKNcWNCFHRhH/7rHeEMTynuuiApAxsQ7eIFvsNTH
	 9CEL0bZCyj/zTaib0dBmTNqMdslZYvtzIzwlHRodEwcMeG+MbNIBvGdu9fUGmldInU
	 vbuUn3niNm0q6EjRYKq4qn6wtCwCY+ROZci7hDyW3CSPAT7+0Zcyu+GYCZFWNrnfnk
	 5WvUtuiNqo/i9Pl8aUQ3jC2zPY5ps9Taii5etZT54iOXXcoz+XcUrUPKmD4ch72dDi
	 yRrFDQTZA0IM0JhQvOxjRIBr6kiPKWnxNpJwdFrnfsOenVIDEbz9GjPzv+ZSKKOZNC
	 vQV9u80SpYgJA==
Date: Fri, 5 Jan 2024 07:30:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20240105073001.15f2f3cb@kernel.org>
In-Reply-To: <ZZftxhXzQykx8j6b@linux.intel.com>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231206084448.53b48c49@kernel.org>
	<ZZU3OaybyLfrAa/0@linux.intel.com>
	<20240103153405.6b19492a@kernel.org>
	<ZZZrbUPUCTtDcUFU@linux.intel.com>
	<9bcfb259-1249-4efc-b581-056fb0a1c144@gmail.com>
	<20240104081656.67c6030c@kernel.org>
	<ZZftxhXzQykx8j6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 12:53:42 +0100 Stanislaw Gruszka wrote:
> On Thu, Jan 04, 2024 at 08:16:56AM -0800, Jakub Kicinski wrote:
> > __dev_open() tries to resume as well, and is also under rtnl_lock.  
> 
> This one is plain 100% deadlock for igc (and igb before ac8c58f5b535)
> I'm opting for remove those rpm calls from __dev_open() and ethtool.

I don't know what gets powered down, exactly, in this device,
so I can't give you a concrete example. But usually there's
at least one ndo / ethtool callback which needs to resume
the device (and already holds rtnl_lock). Taking rtnl_lock
on the resume path is fundamentally broken. Removing the
rpm calls from the core is just going to lead to a whack-a-mole
of bugs in the drivers themselves.

IOW I look at the RPM calls in the core as a canary for people
doing the wrong thing :(

> > So that resume call somehow must never happen or users would see
> > -ENODEV? Sorry for the basic questions, the flow is confusing :S  
> 
> If we talk about situation before rpm calls were added to net core
> (i.e. < 5.9) there was open/ethtool -ENODEV error when igc/igb
> was runtime suspend due to netif_device_present() check fail.
> 
> That was by design, what for open the device and loose
> energy if there is no cable and device can not be used anyway ?

I think "link" means actual link up here, no? As opposed to no cable
plugged in. If I understand that right - the device would have to train
the link in DOWN state in order for the device to be opened?
That would be quite wasteful in terms of power.

Regardless, returning -ENODEV is really not how netdevs should behave.
That's what carrier reporting is for! :(

