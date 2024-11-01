Return-Path: <netdev+bounces-141134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9A59B9B23
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DCB1F21A0D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F61953BB;
	Fri,  1 Nov 2024 23:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CE374D1
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730503282; cv=none; b=jPNO6nvMuMkaq4udlJBRKqbntdd7lMbElTuQtQNZvamdZcp4ASLCi0td8dwvPtFPUF5Qodm9OGg9Q9UiJfKRQnYWPiDCPTuPRq92vNIMJQ+m1Q96Mapwcin6IgFzgAqlYLHwWGu2WNJCNedCn8HqvihswggHTSHuDIrBZu2R5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730503282; c=relaxed/simple;
	bh=/B4HEx6OP81tdsQ614lzO/vPZVrWZ6kg4vDRWNU7FHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoPPozHUa1OXya2etrpohHWyQAnwE8qWAmMdTzNmJLNyo1iXj9exj08MR3055/e9utWksVbu+MbVa3F7tVzs7fU9xOBu+nCnH7IpniN1lz0Njczr6QH145fyWr0+LRyHuyz1dMudiejrpwd7VgKg8MaBYJPdEuppW6/fD6mIoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t70x5-0004uF-47; Fri, 01 Nov 2024 23:21:11 +0000
Message-ID: <c593e14c-edde-45e7-8330-c095456af474@trager.us>
Date: Fri, 1 Nov 2024 16:21:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection for
 PHY drivers
To: Andrew Lunn <andrew@lunn.ch>,
 Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
 <adada090-97fc-4007-a473-04251d8c091f@trager.us>
 <436283e7-16c3-46ef-9970-13ddbf3a2de3@engleder-embedded.com>
 <9f6262bf-b559-48e0-97f0-9d83b3c9c5f8@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <9f6262bf-b559-48e0-97f0-9d83b3c9c5f8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the explanations, both make sense.

Lee

On 10/29/24 6:02 AM, Andrew Lunn wrote:
> On Tue, Oct 29, 2024 at 06:58:12AM +0100, Gerhard Engleder wrote:
>> On 29.10.24 00:23, Lee Trager wrote:
>>> On 10/28/24 1:38 PM, Gerhard Engleder wrote:
>>>> -int genphy_loopback(struct phy_device *phydev, bool enable)
>>>> +int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
>>>>    {
>>>>        if (enable) {
>>>>            u16 ctl = BMCR_LOOPBACK;
>>>>            int ret, val;
>>>> +        if (speed == SPEED_10 || speed == SPEED_100 ||
>>>> +            speed == SPEED_1000)
>>>> +            phydev->speed = speed;
>>> Why is this limited to 1000? Shouldn't the max loopback speed be limited
>>> by max hardware speed? We currently have definitions going up to
>>> SPEED_800000 so some devices should support higher than 1000.
>> This generic loopback implementation only supports those three speeds
>> currently. If there is the need for higher speed, then there should be
>> PHY specific implementations in the PHY drivers.
>>
>>>    Why is speed defined as an int? It can never be negative, I normally
>>> see it defined as u32.
> https://elixir.bootlin.com/linux/v6.11.5/source/include/uapi/linux/ethtool.h#L2172
>
> #define SPEED_UNKNOWN		-1
>
> It cannot be unsigned.
>
> 	Andrew
>

