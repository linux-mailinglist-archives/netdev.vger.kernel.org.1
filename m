Return-Path: <netdev+bounces-89424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160B8AA3F9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC94C1F2282C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92695180A8D;
	Thu, 18 Apr 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+gMIrZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C717335B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471639; cv=none; b=efvj3n29Bn5Pc0ra7S8xjI0ACEuTuD82LWsFQeA5+vLFTP6TU9O4+lilxQpnVYo+FQclU2Ef+cHFzz5etY+5LhE0P2SZQE7L5e531ax+TtC7IiEI+IZ9JOMf0mlyyDW+/WsBZbzrwNXl0TmgxaeWyNpZq1T/ubpXIU4nENMMAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471639; c=relaxed/simple;
	bh=1QbGatMHVWUgzHqicfmSCgb3DA46haEIhxlTc9G6cnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2WpdDldF40oi2YvuS449BVhi4ssvMAlQOXEM4qNVAHZWZZSyQchLf/0+zZ+2TenORtVdgo09gSxfUcPHQWr/FAesTaGHp4H88vKjn63c9cr3KQu5d9zC4Y2EiX0u2uFvw55c2ePIC8/QmdNtYNDWG7mw+U6hjEFs6Xe7r6IFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+gMIrZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E91C113CC;
	Thu, 18 Apr 2024 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471639;
	bh=1QbGatMHVWUgzHqicfmSCgb3DA46haEIhxlTc9G6cnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S+gMIrZ5nyM7sOzL3U6ja6HT7ugU3Tt25JLLPOt5dgSlH2aZS8xknHTSq7DrFJtds
	 nuz/6Hk2yB7UJshor6lt1OKu/LPfMlOJf/CtR/1n3a+2sEbj6wBINM1WoVHv/p7o0C
	 tlj7qdh/kFaD7kprSL1QudG7qmEc9dr6XEeApFnqbwaU80kFcO4cKajjTN+SIK/RM3
	 rJEMmxWwQ+gYSG+X+RAq1w6KRvx1lvn9+N8zA+no5Lug8EU1G81wmBiZv+Wwwzj6fn
	 BlW6DVBgUMfcFtcw1VqcYxM808nyP52m292SRsXzM3FAriYrvjfeIzYsZAmh6yoAV9
	 XqYekm7jNZz6g==
Message-ID: <ada9d2bb-d179-4cda-8c5c-bc7a39473e05@kernel.org>
Date: Thu, 18 Apr 2024 13:20:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from
 tcp_v4_err()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 eric.dumazet@gmail.com, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Willem de Bruijn <willemb@google.com>,
 Shachar Kagan <skagan@nvidia.com>
References: <20240417165756.2531620-1-edumazet@google.com>
 <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
 <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
 <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
 <20240418110909.091b0550@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240418110909.091b0550@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 12:09 PM, Jakub Kicinski wrote:
> On Thu, 18 Apr 2024 19:47:51 +0200 Eric Dumazet wrote:
>>> You have a kernel patch that makes a test fail, and your solution is
>>> changing userspace? The tests are examples of userspace applications and
>>> how they can use APIs, so if the patch breaks a test it is by definition
>>> breaking userspace which is not allowed.  
> 
> Tests are often overly sensitive to kernel behavior, while this is

That test script is a fairly comprehensive sweep of uAPIs and kernel
behavior. Its sole job is to detect user visible changes and breakage
from patches. It has done its job here. Do not shoot or criticize the
messenger because you do not like the message.


> obviously a red flag it's not an automatic nack. The more tests we
> have the more often we'll catch tiny changes. A lot of tests started
> flaking with 6.9 because of the optimizations in the timer subsystem.
> You know where I'm going with this..
> 
>> I think the userspace program relied on a bug added in linux in 2020
>>
>> Jakub, I will stop trying to push the patches, this is a lost battle.
> 
> If you have the patches ready - please post them.
> I'm happy to take the blame if they actually regress something in 
> the wild :(

And because of this test suite you are making a conscious decision to
merge a patch that is making a user visible change. That is part of the
tough decisions a maintainer has to make; I have no problem with that.

