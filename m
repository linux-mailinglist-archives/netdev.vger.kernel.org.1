Return-Path: <netdev+bounces-227221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A25BAA74D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 21:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D111C432A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B11254B18;
	Mon, 29 Sep 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b="Z2E6PxRN"
X-Original-To: netdev@vger.kernel.org
Received: from www642.your-server.de (www642.your-server.de [188.40.219.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFF24EA90;
	Mon, 29 Sep 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.219.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174243; cv=none; b=Ofxw49L/F+kbtNzgNUnIOgWSqI3hwVCsRvD90VWdybB6a3tp5ENUpJdRSFI9RV17rZ4ck1vRkRsV1fV3l/eD9UQIaAmJYb0DEtEfAeMQ/pIkjjIvtqN1SUV/r0Rw8jqcWDj+xM09RbBboPS8jOeTsxP8h6rEcmTg5XX4bCPDFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174243; c=relaxed/simple;
	bh=/waXztsr6YTRkimHehZgAqOF2mDSBckHa3qINtyrNaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuyMMepuxkUdexFWwC5A1Yp0Fg2NWrEAeB1cf/u0zIH+G1w08NZF7UKpfhjYu0Q3DGbAQyXMPI5nHn9CJo1LxRa7aWSGbiuR98NfaZBeQgi2yF1limYcVx3u9eDHLKYHQSBfWordYzuSEeXd8xZlcQy7mpacAHsrDNFbGK25C80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org; spf=pass smtp.mailfrom=raschen.org; dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b=Z2E6PxRN; arc=none smtp.client-ip=188.40.219.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raschen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=raschen.org
	; s=default2505; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vQ4lh3lUpQcafFTvdozObD4o4bYVpMEd4Qh0MjYHNFU=; b=Z2E6PxRNw+JG4ba+TAjsuM2qkk
	4yh+mGfIl6+5tS5PB5FBAyB0KcL1DpxHPDp5FQEqHxrtczTI71oIymMTaV8RwVXWk2H3AE7T0fg7q
	dznWdOHGC+sSvZ5XLud9K2EVjaYOktFaaU3r59DZSrp+ZMQFTpra6rCwTFZBzKLswQ4IugGFs2vF+
	BD0SW9a8Hu4AXhupSkDD8EzxuzisVo5YA4eRI0ur22br+ZNScxJfJ/HQOQ+P+eGjoMvyionkDB5kY
	/zYF5xBLMPLywSgm86+EJZBRdP5QvBPmR8j2DHW7ZdGV3kwETI2cZJ93dU4t20r5qM1vMWs5LqDCS
	2nM/242Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www642.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <josef@raschen.org>)
	id 1v3JZt-000HsN-06;
	Mon, 29 Sep 2025 21:30:29 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <josef@raschen.org>)
	id 1v3JZs-0000VW-0f;
	Mon, 29 Sep 2025 21:30:28 +0200
Message-ID: <fbe66b6d-2517-4a6b-8bd2-ec6d94b8dc8e@raschen.org>
Date: Mon, 29 Sep 2025 21:30:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
To: Andrew Lunn <andrew@lunn.ch>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
 <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
 <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
Content-Language: en-US
From: Josef Raschen <josef@raschen.org>
In-Reply-To: <0737ef75-b9ac-4979-8040-a3f1a83e974e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27777/Mon Sep 29 10:27:51 2025)



On 9/26/25 23:46, Andrew Lunn wrote:
> On Fri, Sep 26, 2025 at 11:24:56PM +0200, Josef Raschen wrote:
>> Hello Andrew,
>>
>> Thanks for your feedback.
>>
>> On 9/26/25 00:00, Andrew Lunn wrote:
>>> On Thu, Sep 25, 2025 at 10:52:22PM +0200, Josef Raschen wrote:
>>>> Currently, for a LAN8870 phy, before link up, a call to ethtool to set
>>>> master-slave fails with 'operation not supported'. Reason: speed, duplex
>>>> and master/slave are not properly initialized.
>>>>
>>>> This change sets proper initial states for speed and duplex and publishes
>>>> master-slave states. A default link up for speed 1000, full duplex and
>>>> slave mode then works without having to call ethtool.
>>>
>>> Hi Josef
>>>
>>> What you are missing from the commit message is an explanation why the
>>> LAN8870 is special, it needs to do something no other PHY does. Is
>>> there something broken with this PHY? Some register not following
>>> 802.3?
>>>
>>>       Andrew
>>>
>>> ---
>>> pw-bot: cr
>>>
>>
>> Special about the LAN8870 might be that it is a dual speed T1 phy.
>> As most other T1 pyhs have only one possible configuration the unknown
>> speed configuration was not a problem so far. But here, when
>> calling link up without manually setting the speed before, it seems to
>> pick speed 100 in phy_sanitize_settings(). I assume that this is not the
>> desired behavior?
> 
> What speeds does the PHY say it supports?
> 
> phy_sanitize_settings() should pick the highest speed the PHY supports
> as the default. So if it is picking 100, it suggests the PHY is not
> reporting it supports 1000? Or phy_sanitize_settings() is broken for
> 1000Base-T1? Please try understand why it is picking 100.

It should pick 1000 then for this phy. I checked already that the device 
is actually reporting being 100Base-T1 and 1000Base-T1 capable. I will 
have a look, why it doesn't pick SPEED_1000 then. I did not know that 
phy_sanitize_settings() is supposed to pick the highest speed already.

>> The second problem is that ethtool initially does not allow to set
>> master-slave at all. You first have to call ethtool without the
>> master-slave argument, then again with it. This is fixed by reading
>> the master slave configuration from the device which seems to be missing
>> in the .config_init and .config_aneg functions. I took this solution from
>> net/phy/dp83tg720.c.
> 
> How does this work with a regular T4 or T2 PHY? Ideally, A T1 should
> be no different. And ideally, we want a solution for all T1 PHYs,
> assuming it is not something which is special for this PHY.

I agree, a generic solution would be best. I will read a bit into the 
code to see if there is a better solution.

Thanks,
Josef

