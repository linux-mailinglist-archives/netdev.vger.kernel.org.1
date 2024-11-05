Return-Path: <netdev+bounces-142029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC049BD0E2
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4E01C22961
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF313CFAD;
	Tue,  5 Nov 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErB6775z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDED13C8F9;
	Tue,  5 Nov 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821452; cv=none; b=o6ictEVxE8rF4WeihUAkIntVFp/NbDpl1HgccaX92+2JNDGRM2b9HBmiqeVUSqLEI0ZSRkPlNJdL7nAgIUDrswtic5h0KrB4CTtoLvbcANu/6dVBSbZk6W0YyMCzxjM/5DGFrIi7dezaJmZEd6gwR80/BK5FMToWkra3boDI0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821452; c=relaxed/simple;
	bh=A8g3p/LCl0KxQtsa6vCzZw7KyoH0lh2MRWGvZAzkJ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M26xOzailDHvMCaxiXweC4qHRraDnmgYTXnWfjPCkuLjNAWdGk28D8lqQiCIJYlnbKtyzVQKDRsdUEK3iaqjzVfbfZyq7sY/ds0kHU4JyBdlHWd/JaPRfbAzYIJ+R47PmH/gxWRhtcV8hTexMqw0InOKRRoAlkQ/ZIKBHRLsx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErB6775z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E251C4CECF;
	Tue,  5 Nov 2024 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730821451;
	bh=A8g3p/LCl0KxQtsa6vCzZw7KyoH0lh2MRWGvZAzkJ8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ErB6775zaIPLlM70+2FRzP+rKgAp2F6drZLM1xGF1JHOLBj+Lry6lgmIGg88zAlZY
	 qwZmq/eUPS62Ys2FWbueJjPP4XPOrcjKBbIny9H7I51+FTmXYPPfOBNXHRgnnKItjB
	 xzu+nA7JphG9fmHSLdipKEp90j7vujJnGcL6b30b1PN92rrqlFlhjfaAk0J88aB3/M
	 Z820Np6FITtWBKOsdUZJCfscN01bgLaIeMdKbwHWNw4yQ0X+9qYrfvHxTsN9Hl6fwT
	 YCcxd8Z/ONeAn5Is4c9fbp82t8Ih3XMuM4ifcMTpyWPRdt99GfOP4vM94c69vcOJCw
	 NENEJQ0w6KHag==
Message-ID: <17db0b5f-a0aa-448a-8fdf-a1264dcf95d0@kernel.org>
Date: Tue, 5 Nov 2024 08:44:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: ip6_fib: fix possible null-pointer-dereference in
 ipv6_route_native_seq_show
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Yi Zou <03zouyi09.25@gmail.com>,
 davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101044828.55960-1-03zouyi09.25@gmail.com>
 <68f209ba-2979-4a15-b344-4613c465b005@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <68f209ba-2979-4a15-b344-4613c465b005@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 5:28 AM, Paolo Abeni wrote:
> 
> 
> On 11/1/24 05:48, Yi Zou wrote:
>> In the ipv6_route_native_seq_show function, the fib6_nh variable
>> is assigned the value from nexthop_fib6_nh(rt->nh), which could
>> return NULL. This creates a risk of a null-pointer-dereference
>> when accessing fib6_nh->fib_nh_gw_family. This can be resolved by
>> checking if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
>>  and assign dev using dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
>> to prevent null-pointer dereference errors.
>>
>> Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
> 
> Please send a new revision, including a the target tree in the subj
> prefix - in this case 'net' and a suitable Fixes tag.
> 
> /P
> 

I would also like to understand why you believe NULL can really happen -
excluding memory corruption or custom patches to a kernel. If you look
at the make up of nexthop_fib6_nh it is defensive around bugs elsewhere
(nhsel > number of nexthops) and future changes (support for ipv6
nexthops that are not IPV6 addresses).

That comment applies to all of these patches around nexthop_fib6_nh
possibly returning NULL.

