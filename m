Return-Path: <netdev+bounces-222122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB39B53324
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB323AA7E4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E62321F4D;
	Thu, 11 Sep 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpLaEWgh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235CD314A97;
	Thu, 11 Sep 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595920; cv=none; b=tztCmS0krYBq9t7cdVJGD3dp1tQJElgCgbpFIcPHj3/+hIBoJxfQcgQAptOY61OBQzOncPSH/CEdqr6O71h4FDPgtpeoHwlvYD2SwsrXCiHO5mR8d6ETABrgR7qGGBE2/q5UZPSLkx6NrAwCsS+KMWym1759Z3eZromu8llwehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595920; c=relaxed/simple;
	bh=3cTu3t1kABFgYDURDBVW7RvACYUtHwzvTu1HQFQwBrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcVnJrQFgoY0Du1o33xwXAOPw6W+bLWbHXghQ6JqeUmDF9lXzJd9rS2LXEaR4rQ0ofoSbjjAIqXy8ZKnZMuK9lnN7PW6kwQXbEuJVIgegX4PR0FRQQ0PmRx6Zz9TVX5AkCcQ8HxVIolTxKLWXQ5lqFciuzQ6uWZjaIvo0TUmDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpLaEWgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E26CC4CEF7;
	Thu, 11 Sep 2025 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595919;
	bh=3cTu3t1kABFgYDURDBVW7RvACYUtHwzvTu1HQFQwBrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IpLaEWghBa5tYMxCDG0sjjg4V/u3gIB5GXvKS0QT+rYChZqB/iW30acZpzJ16tDhN
	 6bPsToGoA15Qk39Wj4KtZBN1J7438fQNLDVueFH7TQ78kwKlLjdyQDXqlYWt6aeCfv
	 YecrLMEM4j062LMtihWQ7MCSdN/CzonOyBg0j2RG3CZUvgFhLgJhHYE7J1vlbAD4on
	 zk2x3sS6JLkz+nWyyHyGgp4Ho+O8r/u21CwaUqTYTQf7rhkSLmlhjF9dQ8FfVsBziN
	 NHrGjOKn6AJb7wQeLgrp7623OIDdui++gANvZqO26Lt8gO2J7/Q0MOuTzTKPyx7UKz
	 ZXnlDSBzMOCUg==
Message-ID: <7ea8e560-89f6-4f3a-97a6-cf70c1d3d0d0@kernel.org>
Date: Thu, 11 Sep 2025 15:05:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] page_pool: always add GFP_NOWARN for ATOMIC
 allocations
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ilias.apalodimas@linaro.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, llvm@lists.linux.dev, Linux-MM <linux-mm@kvack.org>
References: <20250908152123.97829-1-kuba@kernel.org>
 <20250910175240.72c56e86@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250910175240.72c56e86@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2025 02.52, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 08:21:23 -0700 Jakub Kicinski wrote:
>> Driver authors often forget to add GFP_NOWARN for page allocation
>> from the datapath. This is annoying to operators as OOMs are a fact
>> of life, and we pretty much expect network Rx to hit page allocation
>> failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
>> by default.
> 
> Hi Jesper! Are you okay with this? [2] It's not a lot of instructions and
> it's in the _slow() function, anyway. 

For this "_slow()" function I don't worry about the performance.
The optimization you did seems a bit premature... did you run the
page_pool benchmark to see if it is worth it?

> TBH I wrote the patch to fix the
> driver (again) first but when writing the commit message I realized my
> explanation why we can't fix this in the core was sounding like BS :$

It feels slightly strange to fix drivers misuse of the API in the core,
but again I'm not going to nack it, as it might be easier for us as
maintainers as it is hard to catch all cases during driver review.

All driver are suppose to use page_pool_dev_alloc[1] as it sets
(GFP_ATOMIC | __GFP_NOWARN).  Or page_pool_dev_alloc_netmems().

  [1] https://elixir.bootlin.com/linux/v6.16.6/source/include/net/
page_pool/helpers.h#L175-L179

The reason I added page_pool_dev_alloc() is because all driver used to
call a function named dev_alloc_page(), that also sets the appropriate
GFP flags.  So, I simple piggybacked on that design decision (which I
don't know whom came up with). Thus, I'm open to change.  Maybe DaveM
can remember/explain why "dev_alloc" was a requirement.

I'll let it be up to you,
--Jesper

[2] https://lore.kernel.org/all/20250908152123.97829-1-kuba@kernel.org/

