Return-Path: <netdev+bounces-189100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CEAB05E2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DFC3A78B6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8BD15624D;
	Thu,  8 May 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnm/AbNs"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0357E1
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742546; cv=none; b=rYnMgVNRXUaaptU/QjQG5mp7brdIV5QjYTSnMcms7NwGmYGkKdzg+wQeRCHK5QdwWYRtPzuMV2JaAAFAFCI7XYW8+G1d7hKOUY4z2U/r18xFEfrwIJ35uXDmxImmwAF7wLB8u4x9HRov5v8s3CyAaPm2/FnlVkbll8YyW+HGV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742546; c=relaxed/simple;
	bh=h1gJmKSPX8Aqf4DE5miz7vFOkB0UzrYOWBn1TTkc6tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfiij4uBpSHmD+TREXXYubAO2yzlzC72DYbXakXT7YJy4nrPNoTLPRCBggxD93mCrmwEvAj35ilG42bOwkliUN/LG/oGy7p9U7QhFyijN8itOuXhIEpgX4sJIdXNxMdHnpOrmqXcAx/43BGB1rXyzGK8SqrxxUiRufNXfplbAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnm/AbNs; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <904c9113-0b01-4b9d-995f-f2729426281e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746742542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qPlOIrbF6O7aqwbaQXtNOg0sgeetX70jL3/HgUCUYs=;
	b=pnm/AbNskz79gn7Jtq+/4DiJrPRL1aVTE2j/xFucRrcf1uWwe2LXY+GODZ6FuwGHNbQuN8
	bEfms0aWUHaFGxp1Y0rxvLw0GnXwuHlpfBJk+fuwtjF2dVzHqRf2FaTqFv9bx6TI9ajhiR
	rIDR3NAuVJs+2A68FeEVzt2Vm8AE0y8=
Date: Thu, 8 May 2025 23:15:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?K=C3=83=C2=B6ry_Maincent?=
 <kory.maincent@bootlin.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
 <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
 <20250508204059.msdda5kll4s7coti@skbuf>
 <1aab25ca-aed5-4041-a42a-59922b909c02@linux.dev>
 <20250508205641.dsoksrasn4wicz76@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508205641.dsoksrasn4wicz76@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 21:56, Vladimir Oltean wrote:
> On Thu, May 08, 2025 at 09:48:40PM +0100, Vadim Fedorenko wrote:
>> On 08/05/2025 21:40, Vladimir Oltean wrote:
>>> On Thu, May 08, 2025 at 09:25:14PM +0100, Vadim Fedorenko wrote:
>>>> The new interface also supports providing error explanation via extack,
>>>> it would be great to add some error messages in case when setter fails.
>>>> For example, HIRSCHMANN HellCreek switch doesn't support disabling
>>>> of timestamps, it's not obvious from general -ERANGE error code, but can
>>>> be explained by the text in extack message.
>>>
>>> I wanted to keep the patches spartan and not lose track of the conversion
>>> subtleties in embelishments like extack messages which can be added later
>>> and do not require nearly as much attention to the flow before and after.
>>> I'm afraid if I say "yes" here to the request to add extack to hellcreek
>>> I'm opening the door to further requests to do that for other DSA drivers,
>>> and sadly I do not have infinite time to fulfill them. Plus, I would
>>> like to finalize the conversion tree-wide by the end of this development
>>> cycle.
>>>
>>> Even if I were to follow through with your request, I would do so in a
>>> separate patch. I've self-reviewed this patch prior to posting it, and I
>>> was already of the impression that it is pretty busy as it is.
>>
>> I agree that the patch is pretty busy, and the extack additions should
>> go into separate patch. The only thing which bothers me is that it may never
>> happen if it's not done with this patch.
> 
> That may well be. But look at it another way, I wrote this patch in July
> 2023 and never got to upstream it, then Kory pinged me because it's
> necessary to get rid of the old API. I don't want to go back and spend
> time on extack messages when there's still a long way to go, and the
> priority is obviously somewhere else. I've added this request to my
> to-do list, and if I still have time at the end of all conversions, I'll
> go through DSA drivers and see what can be improved.
> 
>> Anyway, the conversion code looks good, so
>>
>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Thanks for the review, here and elsewhere. Do you want me to copy you on
> the remaining conversions?

Yes, please. I'm trying to follow all PTP-related things as it's my
current focus.

Thanks,
Vadim

