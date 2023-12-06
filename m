Return-Path: <netdev+bounces-54548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1C8076FD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646F4281CA6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C151675B5;
	Wed,  6 Dec 2023 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDHqvkco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E330E364B2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4514C433C8;
	Wed,  6 Dec 2023 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885110;
	bh=YMA3TAsSiUul57FlmdTimYbCUDIjWoEz6/pHObLXG7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iDHqvkcoAXQo1mrhbAIkDpwA0Pez0mmJTk0fEIJi2jFFE6O/CGvrguCIeT8PEIa/6
	 hzI6RV7iU6NxKEuLQzhac8mPU/xN3wdnoPElZSxiF5jARVzMB7do7e/hVTztB2wsx0
	 GaW5Va9v5AeLvvrHH6w/yA84FOGsWxXbVRFfeA18OuYkh4e2u7gYRWvKCaOIDY0fbO
	 qT9Dur0ozn6JuwNDUZpOaFB48PvVrA1LTIa1hnTQZ5XpIcnsI+5HdNvNyoREXrkgK8
	 EHGDgEO6WH1SSzU3Xq7zAhLu9xawZgXsSxXnGWvIwWKN7LO2Kgu9AkwK4wXlgdGbD9
	 MX4sfAL5N7Tfg==
Message-ID: <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
Date: Wed, 6 Dec 2023 10:51:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Judy Hsiao <judyhsiao@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Brian Haley
 <haleyb.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Joel Granados <joel.granados@gmail.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
 <20231206093917.04fd57b5@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231206093917.04fd57b5@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/23 10:39 AM, Stephen Hemminger wrote:
> On Wed,  6 Dec 2023 03:38:33 +0000
> Judy Hsiao <judyhsiao@chromium.org> wrote:
> 
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index df81c1f0a570..552719c3bbc3 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>  {
>>  	int max_clean = atomic_read(&tbl->gc_entries) -
>>  			READ_ONCE(tbl->gc_thresh2);
>> +	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>>  	unsigned long tref = jiffies - 5 * HZ;
>>  	struct neighbour *n, *tmp;
>>  	int shrunk = 0;
>> +	int loop = 0;
>>  
>>  	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>>  
>> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>  				shrunk++;
>>  			if (shrunk >= max_clean)
>>  				break;
>> +			if (++loop == 16) {
> 
> Overall looks good.
> Minor comments:
> 	- loop count should probably be unsigned
>         - the magic constant 16 should be a sysctl tuneable

A tunable is needed here; the loop counter is just to keep the overhead
of the ktime_get_ns call in check.

