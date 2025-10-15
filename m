Return-Path: <netdev+bounces-229758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327CBE093D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C9D19A7BC8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2328BA81;
	Wed, 15 Oct 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z30A4E12"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD41DDC07
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558724; cv=none; b=gNt8ZH/jifHJpUjaesdAmb7zUHf3FZhye5n6iV4m6TvV63OiGyfoe0c9FArILJUiE0eG2R82/xhj3/WAcjnsiHWVXPYUPRgmMH9Pf8y2xpuLyN+AKmRoCDBh6dKKkCEUfrXkf06UtBcNk0PaWIschV28f1gUVZ301h1GFH6Br38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558724; c=relaxed/simple;
	bh=0qiDxOuu2yCWrCtYNQQJQ5nsm8opD9K0+H+qVjLN9c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXGbUY8w1waiewtJBNa2jnPGTRwuAiwA+YAa5zBx7T3VOaL7dx/+nOZiqizqx24jVkKI+rpZ7DXWsU5MbppfkWPSJlt+mBTUayqTHDq993Yaj5rMDBI6VIULOWnjqvz/biXZXEqk8yoGCKZR3vNnqliSlBelrthg5S96zLOE7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z30A4E12; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1639cc31-b57f-4370-8062-6a06252451f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760558719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhI+YWV+MQ/zsGtekn1H8fCQlsoHB7Hu0mNXLHEte/M=;
	b=Z30A4E12wWKQgkrOkSHfii3Ji2k7MkVj38ZzSojaE1uECXQm9qhi3O4bKeZfp47x2ly3CK
	iqvQSnkdMfbhWJn7bYjaoobgsmxIjdmgP+R7BCYsU7RaMMfhgIzGKbSbU/nS1Uu4z7RPh0
	beCZANdYdYko6WpRwz3B3lUX/kL9sSo=
Date: Wed, 15 Oct 2025 21:05:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 5/7] cxgb4: convert to ndo_hwtstamp API
To: Simon Horman <horms@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-6-vadim.fedorenko@linux.dev>
 <aO9x7EpgTMiBBfER@horms.kernel.org>
 <193627cf-a8c7-4428-a5d3-8813b1edc04d@linux.dev>
 <aO-xnXskSie2PKQq@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aO-xnXskSie2PKQq@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15.10.2025 15:37, Simon Horman wrote:
> On Wed, Oct 15, 2025 at 11:33:02AM +0100, Vadim Fedorenko wrote:
>> On 15/10/2025 11:05, Simon Horman wrote:
>>> On Tue, Oct 14, 2025 at 10:42:14PM +0000, Vadim Fedorenko wrote:
>>>> Convert to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>>>>
>>>> Though I'm not quite sure it worked properly before the conversion.
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>
>>> Hi Vadim,
>>>
>>> There is quite a lot of change here. Probably it's not worth "fixing"
>>> the current code before migrating it. But I think it would be worth
>>> expanding a bit on the statement about not being sure it worked?
>>
>> Hi Simon!
>>
>> Well, let me try to explain the statement about not being sure it
>> worked. The original code was copying new configuration into netdev's
>> private structure before validating that the values are acceptable by
>> the hardware. In case of error, the driver was not restoring original
>> values, and after the call:
>>
>> ioctl(SIOCSHWTSTAMP, <unsupported_config>) = -ERANGE
>>
>> the driver would have configuration which could not be reapplied and not
>> synced to the actual hardware config:
>>
>> ioctl(SIOCGHWTSTAMP) = <unsupported_config>
>>
>> The logic change in the patch is to just keep original configuration in
>> case of -ERANGE error. Otherwise the logic is not changed.
> 
> Thanks Vadim,
> 
> I see that now and it makes sense to me.
> I do think it would be worth mentioning in the patch description.

Fair point, I'll update commit message for v3.

