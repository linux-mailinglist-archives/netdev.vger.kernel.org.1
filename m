Return-Path: <netdev+bounces-238477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F0C59639
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26CD83AB3B4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE73043B8;
	Thu, 13 Nov 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D+JuzB50"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D85283CB1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057031; cv=none; b=gYnn4JjuPuHvIt+4TjjxADbpecWidpQz7gHrpw1/rcbhU1oLNojA9QzoBLxC96QwUV3RVd8kAVbgXizP+9nyV7SG7M315zDC13kz0OsFy8PcmqF8wznPCHHgwe7itl0SuZP7LjO74z2Kn4is8AKhuw4PUlByd85FKkds8/DRRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057031; c=relaxed/simple;
	bh=OgQEtZevv/TAxpCIbeFnFWHkt/Aw2tCU9SycoKr4JMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWQz6Lm7673DcLopKXV9A9qH/2VaM18r2hFUEN+vlXiw56A5B/Q6eliWsSqeKnug/GQSEG25CLZGz80b15Q0I3oFIxM2EUcPdldKOtNQiM4kTJaLTzxyHm3XG7dhKXSxzdCNb+HW4SBUW1hSTwFn0U3UpuYR9ZH3vjcMfR6Ie4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D+JuzB50; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b93f827f-90d1-4914-9244-4fb23b6cfbc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763057026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhR09nr7jyNFWwLEy9Hi6BakpxQTeSGbGOIQL5EXdVM=;
	b=D+JuzB50eYTbIugAkKMI2MEKWc6Rkbm0JIgAOu55Z3qoyvi/PV/rD1IMjieLL5r8vBlHqr
	MQUe9rhgOd25IDlV2lHkON9FOs78ey7tLPSMPcPLe7sdm4AEMlfWPs1aBAatd72I0zqdad
	WoMZcKYmL8kj/2O1TjzDZCV+/ojX4i4=
Date: Thu, 13 Nov 2025 18:03:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
 <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
 <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
 <aRYN-r7T9tz2eLip@shell.armlinux.org.uk>
 <69ec62f4-649b-4d88-8c06-6bf675160b0b@linux.dev>
 <aRYSPKmGennbjxwj@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aRYSPKmGennbjxwj@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 17:15, Russell King (Oracle) wrote:
> On Thu, Nov 13, 2025 at 05:05:18PM +0000, Vadim Fedorenko wrote:
>> On 13/11/2025 16:57, Russell King (Oracle) wrote:
>>> On Thu, Nov 13, 2025 at 04:48:00PM +0000, Vadim Fedorenko wrote:
>>>> If the above is correct, then yes, there is no reason to implement
>>>> SIOCGHWTSTAMP, and even more, SIOCSHWTSTAMP can be technically removed
>>>> as a dead code.
>>>
>>> I think you're missing the clarification in this sentence "... to
>>> implement SIOCGHWTSTAMP in phy_mii_ioctl(), and even more,
>>> SIOCSHWTSTAMP can be removed from this function as dead code.""
>>
>> Ok, it's better to "there is no reason to have SIOCGHWTSTAMP chunk,
>> provided in patch 2 of this series"
>>
>> Or are you asking for the clarification of SIOCSHWTSTAMP removal?
>> I don't plan to remove it, at least not in this series. I just wanted
>> to mention that there will be no way to reach SIOCSHWTSTAMP case in
>> phy_mii_ioctl() from user-space ABI. Does it make sense?
> 
> I'm not asking. I'm trying to work out what you're trying to say, and
> suggesting a clarification to your last paragraph that would clarify
> what I thought you mean. Now I'm even more confused about what you're
> proposing.

The original idea is to have SIOCGHWTSTAMP and netlink hwtstamp_get for
PHY devices. But as ioctl is deprecated interface, I'm thinking of
removing SIOCSHWTSTAMP in favor of netlink hwtstamp_set.


