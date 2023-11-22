Return-Path: <netdev+bounces-49947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB17F4098
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99379281150
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165722EE8;
	Wed, 22 Nov 2023 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1cN3M9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54101DFCD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E01CC433C8;
	Wed, 22 Nov 2023 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643190;
	bh=9LiQ550tg1K+p2ZoEVvreXt20JNQHlcQGfGnZoPU5U8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G1cN3M9lndBTKpW8D1KE0wVIVdtOFmx1OONkM5SMP9hEmvzQai5IH0R97c163o/8X
	 upmoBVhgqXQL30R6z/tTybPPub5siSOyjfcXdH1XWRWVFPV10yNxb1B3yg+3OnT2rj
	 kMzZE31FMOVPgWLFceXX0aXS8tjZh+bDmwwjVEQy48MNHm7HozA2CooyxxcCFqT3Du
	 prwFy/77gBpgMlO4v7Z83d4cd8+vTCQePRru2SFVAMYRI6/QBTRkm1p5YoSHpzOmKJ
	 6dtYekQysAPEBQZQJTLBH1wisOTU9EEiDYCnAUlrtVcBfcZZVPP6UAoqGanODkSBJG
	 nUwAw/iACa3Kg==
Message-ID: <8504074e-5cf0-4e47-a10d-517a1e848764@kernel.org>
Date: Wed, 22 Nov 2023 09:53:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/15] net: page_pool: report when page pool
 was destroyed
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com,
 kernel-team <kernel-team@cloudflare.com>
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121000048.789613-13-kuba@kernel.org>
 <e64de1a2-a9c6-43e0-8036-7be7fbf18d52@kernel.org>
 <20231121134908.54619aa5@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231121134908.54619aa5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/23 22:49, Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 21:45:57 +0100 Jesper Dangaard Brouer wrote:
>> Hmm, this is called when kernel could *NOT* destroy the PP, but have to
>> start a work-queue that will retry deleting this. Thus, I think naming
>> this "destroyed" is confusing as I then assumed was successfully
>> destroyed, but it is not, instead it is on "deathrow".
> 
> I wasn't sure what to call it so I called what the driver API is
> called...
> 
> "deathrow" does not sound very intuitive to me. How about "detached"
> or "removed"?

I like "detached".

> 
>> Could we place this PP instance on another list of PP instances about to
>> be deleted?
>>
>> (e.g. a deathrow or sched_destroy list)
> 
> Is there a need for that?
> 
> I mean - many interesting extensions to this API are possible.
> I don't think they should all can all be here from day 1..
> 
>> Perhaps this could also allow us to list those PP instances that
>> no-longer have a netdev associated?
> 
> The current implementation uses loopback for that, since it's naturally
> tied to a name space.

Okay, guess it makes sense to tie this to loopback.

--Jesper

