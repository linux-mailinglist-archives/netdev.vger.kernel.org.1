Return-Path: <netdev+bounces-232665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78EC07E2C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729144052E6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B7274643;
	Fri, 24 Oct 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qEkNa02U"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8E26ED43;
	Fri, 24 Oct 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333571; cv=none; b=refjrii1j5g57z2u7FD59fLbBKoXwNcZWOH6ow49nnDegsSPRIYff37xPHvTKyzG3Kb+7KSUtjOjVt4/HiMvDaTIStWIO4xB4oKkFAk53gya/ARcnwygSaK6qSMWx4y2jLqaeZbNJfJotixwdD0VWoc93Utm2Z2q0FFZx9H/9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333571; c=relaxed/simple;
	bh=yvAVzrE+ZlCE1/5Y8HUlvffD12Ez+joCObeQu+lX2T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jzg3n7d3Qdp7ebqe5nXP2WnXai6Zz1YU6wiv1bDPIe27fIRCSCVqQGLS9wnY6aclqW3j+RQ9ZBOfUYLGTW0dlvEuTomrF/1Lj4WaNrJXyq82BJ5q3MFLZmOrYMHHYezoLta4uIuuptiPBsvQfa8HbYexgRJ2tysOwFxCsQcbfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qEkNa02U; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761333559;
	bh=yvAVzrE+ZlCE1/5Y8HUlvffD12Ez+joCObeQu+lX2T8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qEkNa02Ut8U3tQigEL5Tuqlt1zPxq2NmonEZ6lIdGX9PwOV/QUabMUnhOvt54gYlV
	 ciISDENcpKXrMuZle/OnsjMKKxF+PBDuhuvkRMzLzQCzZiisbghvTQpAsqhGILT/ra
	 iKe8QVGvB6GDXVfCvzvwX8iVD7ZxNbkI4ZoXGXUzFYaidU3H9BDjWc21dxINsIwZK/
	 /l5OIOdiLLCxK8z+GfDVO6HeLaG3pXcXj44euS3VALoXswDc13qVG6PVVhuPfnyRNw
	 14tsQnQkUT322EtYL50NG+XhQfsOU6iC0YPg6dq+ystBQVXPemRTSOIbuj9p+QMnhv
	 bfuayfiKbQJzA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9E83B600BF;
	Fri, 24 Oct 2025 19:19:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id EB7D5201241;
	Fri, 24 Oct 2025 19:19:10 +0000 (UTC)
Message-ID: <ee3b6ed7-a00d-4679-9aa6-482b8064d18f@fiberby.net>
Date: Fri, 24 Oct 2025 19:19:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] ynl: add ignore-index flag for indexed-array
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Chuck Lever <chuck.lever@oracle.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Zahari Doychev <zahari.doychev@linux.com>
References: <20251022182701.250897-1-ast@fiberby.net>
 <20251022184517.55b95744@kernel.org>
 <f35cb9c8-7a5d-4fb7-b69b-aa14ab7f1dd5@fiberby.net>
 <20251023170342.2bb7ce83@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251023170342.2bb7ce83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/24/25 12:03 AM, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 18:37:09 +0000 Asbjørn Sloth Tønnesen wrote:
>>   > C code already does this, right? We just collect the attributes
>>   > completely ignoring the index.
>>
>> In the userspace C code, for sub-type nest the index is preserved
>> in struct member idx, and elided for other sub-types.
> 
> I see it now, I guess I added it for get but forgot to obey it
> for put :(

I can fix that up in v2.

Do we wanna do the same for sub-type nest in the python client?
>>   > So why do we need to extend the spec.
>>
>> For me it's mostly the naming "indexed-array". Earlier it was
>> "array-nest", then we renamed it to "indexed-array" because
>> it doesn't always contain nests.  I think it's counter-intuitive
>> to elide the index by default, for something called "indexed-array".
>> The majority of the families using it don't care about the index.
>>
>> What if we called it "ordered-array", and then always counted from 1
>> (for families that cares) when packing in user-space code?
>>
>>   > Have you found any case where the index matters and can be
>>   > non-contiguous (other than the known TC kerfuffle).
>>
>> IFLA_OFFLOAD_XSTATS_HW_S_INFO could be re-defined as a nest,
>> IFLA_OFFLOAD_XSTATS_L3_STATS is the only index atm.
> 
> Isn't that pretty much always true? If the index is significant
> the whole thing could be redefined as a nest, with names provided
> in the spec?
I guess it depends on the range of indexes, the aboveIFLA_OFFLOAD_XSTATS_L3_STATS is aka. 3, so the new nest policy would be
(0..2 = unused, 3 = .._L3_STATS}, which is fine, but for higher indexes
it might get a bit silly, but I haven't found any too high indexes.

NLBL_CIPSOV4_A_MLSCATLST has NLBL_CIPSOV4_A_MLSCAT which is 11, but that
corner seams very dusty, so I don't expect that to get YNL support.

Nest + multi-attr is great for the cases where we want per-attr typing,
like IFLA_PROP_LIST / IFLA_ALT_IFNAME, but a bit awkward if they all
are nests with the same policy.

>> IFLA_INET_CONF / IFLA_INET6_CONF is on input, but those are
>> also special by having different types depending on direction.
>>
>> I found a bunch of other ones, using a static index, but they
>> can also be defined as a multi-attr wrapped in an additional
>> outer nest, like IFLA_VF_VLAN_LIST already is.
> 
> Multi-attr with an outer nest should at least solve your wg problem
> I guess? If all the attrs have type of 0 we can make it a multi-attr.
WG don't use the index, so it's fine with incrementing from 1.

Converting it to nest + multi-attr would require extra pollution in
the UAPI, so I don't think I can get that past Jason. It would also be
hard to shove in between the elements in the existing naming.

I am just trying to get the nits that came up in the previous discussions
handled, so they are fixed when I submit the WG spec again, so that I
don't have to go back and update it shortly after, as the WG/Jason
bandwidth seams pretty limited atm.

