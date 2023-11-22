Return-Path: <netdev+bounces-50172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECAC7F4C46
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42100281258
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DA44F216;
	Wed, 22 Nov 2023 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH4/G4FS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F734D123
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9677BC433C8;
	Wed, 22 Nov 2023 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700670096;
	bh=YxSTGpi5wCjA4gd/xjRzTNwMG0wkCbpUfELzk/0OBG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hH4/G4FSA5UKzOiAtk6WwvGyXHQCwR3swzXBBLu2R72yrM+IJR/TmUzCOff+4xYBB
	 hp/odjD260CaTfNYcRI2DVL5UMqxOuXS+V+IbB/KQ1+Hzf0rVE395cWrHxcZoFJY8n
	 qf8DgjyxWbX1JI3TUqPhmo4WKoJAzTAqtrgfQyv8P4Q9kcbYomYvgU0TkNl2ZVyM00
	 S1r72p0E3BgY4SRl/CWZRQ7i8K9sIJyIdtIV6+ZhkGmm9c9Vwvu9r/FFzDSNeHsc1e
	 97MCjqM7npDY5nTSlSkFKEIgtMB6hg+O6VCODO9f3EjkdCIc3JquRRJL7h9TwK8r1e
	 qt4/hE9tDNaeQ==
Message-ID: <114d3f16-2b49-46ab-b02a-dbf6ea9cd7c4@kernel.org>
Date: Wed, 22 Nov 2023 17:21:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/13] net: page_pool: implement GET in the
 netlink API
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-8-kuba@kernel.org>
 <27b172a5-5161-4fe2-90b1-83b83ef3b073@kernel.org>
 <20231122080042.212c054d@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122080042.212c054d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 17:00, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 15:39:48 +0100 Jesper Dangaard Brouer wrote:
>> Can we still somehow list "detached" page_pool's with ifindex==1
>> (LOOPBACK_IFINDEX) ?
> 
> Do you mean filter at the kernel level to dump just them? Or whether
> they are visible at all?
> 

I mean if they are visible.

> They are visible, with ifindex attribute absent.
> 

Okay, I thought they would be listed with ifindex==1, but good to know.

> If you mean filtering - I was considering various filters but it seems
> like in "production" use we dump all the page pools, anyway.
> The detached ones need to be kept in check, obviously, but the "live"
> ones also have to be monitored to make sure they don't eat up too much
> memory.
> 
> The code we prepared at Meta for when this gets merged logs:
>   - sum(inflight-mem), not detached
>   - sum(inflight-mem), detached
>   - recycling rate (similar calculation to the sample in the last patch)
> 
> It may be useful in CLI to dump all detached pools but ad-hoc CLI can
> just filter in user space, doesn't have to be super efficient.

I think it will be okay to let userspace filter these.

--Jesper

