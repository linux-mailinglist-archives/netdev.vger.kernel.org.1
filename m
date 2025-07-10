Return-Path: <netdev+bounces-205881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C275DB00A0F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E58D641F5F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1F2E6D22;
	Thu, 10 Jul 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JeSzlV3b"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F6264FB3
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169263; cv=none; b=QL6Qu1qruLydMSUyj90A/Yd5yq9nE40/KTxIqDXXcykhFISS/1WA0y4O1e1Wh3zm9raxbkRcAide1u8EfwiGI9bOLJ3VxtHhViMs/RhHqigmi/gl6c6rszsO68Rm0yYyPqUwcpc5fAG3L/No6X0Y8XhqA+lxyio8ZmFi95HxRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169263; c=relaxed/simple;
	bh=L857CHlhsuSTW0TQ7rB6RRCcVIwDIbTqeg3ypLKG03U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SBXRdx5B8xIvkSliMka4zomnyEeyOdWc/Uio+so6J7Zw75zkt5TC523UDibXQMdBnkNzijbrLDO4YsDzc4yPfpAPe2yarpbwDzl3zQK9BbcNdH+hEj9J94ZM7Mtx8pUBTyj5Jcy9ZkTqrdxW3ksMu9MtRx3tE28AOuo7Sf4TR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JeSzlV3b; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752169249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+ATdybQuRHQN8pHe9yiY9p1Aahzgdi9W0V+GBopZ7g=;
	b=JeSzlV3bGL7GVxrL5W/GIoU8aHFdnOtC0RpkYg+LYzCk+cSKcIzUJ7Ym3K9jqEkO1gsxrK
	8j0Z3HBn4MAWYgTYOquf/JPtD8lWZSveIs3YbtA7HtJ065fl77er4AJlZv1f7YFR30sGpZ
	VzZ+w3FRt1ZZZrodbUuJiIp0RL530VY=
Date: Thu, 10 Jul 2025 13:40:33 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <20250707163219.64c99f4d@kernel.org>
 <3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
Content-Language: en-US
In-Reply-To: <3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Jakub,

On 7/8/25 11:52, Sean Anderson wrote:
> On 7/7/25 19:32, Jakub Kicinski wrote:
>> On Mon,  7 Jul 2025 15:58:03 -0400 Sean Anderson wrote:
>>> -	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
>>> +	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
>>> +	    !phy_driver_is_genphy_10g(phydev))
>> 
>> Breaks build for smaller configs:
>> 
>> drivers/net/phy/phy_device.c: In function ‘phy_probe’:
>> drivers/net/phy/phy_device.c:3506:14: error: implicit declaration of function ‘phy_driver_is_genphy_10g’; did you mean ‘phy_driver_is_genphy’? [-Werror=implicit-function-declaration]
>>  3506 |             !phy_driver_is_genphy_10g(phydev))
>>       |              ^~~~~~~~~~~~~~~~~~~~~~~~
>>       |              phy_driver_is_genphy
> 
> This is due to
> https://github.com/linux-netdev/testing/commit/42ed7f7e94da01391d3519ffb5747698d2be0a67
> which is not in net/main yet.
> 
> --Sean

I see this is marked "Changes Requested" in patchwork. However, I don't
believe that I need to change anything until the above commit is merged
into net/main. Will you be merging that commit? Or should I just resend
without changes?

--Sean

