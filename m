Return-Path: <netdev+bounces-66112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CA83D484
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0427D288CAD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E2125AB;
	Fri, 26 Jan 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="snpsI9ya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uCY10h2P"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042B849C
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250521; cv=none; b=DlHD3K1bifuc6tsE5a2RV5iiK2p+Az0XEjwWsILdUaF0vHvLDlKtH/KqxfxcxKcEuzSsmLkjJ1todRQIYGiUdhMaFo2OWeGX31mecIql+/TR4/yEJUvtmGwm9IOo5kExpkcINp2k2ARk6iK8MG1VElQ+HSClBtrm1WXQQhvBj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250521; c=relaxed/simple;
	bh=ad0kpR9iULl2DfHdCM5l2R5z1+A2Bhcd9+5UqkbPGiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvWZMQAalyCJwnswNaCk8l/53WaF5Wg6kL4uUXCWiS6y0dtD1iTSUVFVZjzvLOcQ6IM74WcInCeqiR5uHB/QqvbWbjHMQJd9gSJ1b3Asnw/kYcAN4pB+eLrHqT8CTqvDeS7159kXbD+GIET/ASMQ2dv8DR0SEV6NKgnZ0KJXABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch; spf=pass smtp.mailfrom=bernat.ch; dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b=snpsI9ya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uCY10h2P; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernat.ch
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8FFA25C016C;
	Fri, 26 Jan 2024 01:28:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jan 2024 01:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706250518;
	 x=1706336918; bh=2apXPwBudnAqwTmoFumlNwhOQ/9DSn7RYHWKWNlMQRc=; b=
	snpsI9yamomTMclQg8TCYrMcTZK+Y260ayfuoqDH8Leem+uga1YdfHHImYYcEdmC
	wDtn58IIJWXezfCdkjWeMopTUr0m+JD8DhTZjGix4NMWTyH0r7+/lriwBoYyN82n
	VUsvEEhDuG7PkKeh9wWJ0NIxfYX74ABU40uf84Wq8bk8ZkWQxhd67Vvoq9ei1E8D
	+jY/hG6Kdqfma+y6ymcGadV19SaHbEtoNL3G0wObTLbX8Cdz2s1ia5ic1G70nBHP
	dDAu/JSnSri0u64t7WC6SqkeKwxnoh7sMPxtshisSB6DJEvQWLmQDOfPhFyIDTn7
	aVLyHzGWzyqfahuW8s0/Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706250518; x=
	1706336918; bh=2apXPwBudnAqwTmoFumlNwhOQ/9DSn7RYHWKWNlMQRc=; b=u
	CY10h2PSvKUhwpx3/xMCaSXHJia74LI5I0rrIi0Mbu90m/UxsNa/H2hr2bIpGyDi
	uib/mONBzQEMTMkX+oSwcAF1jj5bCUJVG8n8sMgPuJ3wo1ISQs2HD0S7Q9rWEPMK
	Zyno53Z8XVpF/UhtV8n4tuqdzfONzvAE0veUPrcZwH6PV3QgjIIKx7XuYm4f3ECT
	lv2wtotlxK3aZgIwwVIUipz7MtRFMBksMDcv0EMZio4ItscyaBAjjuFbJCNeea/d
	aeWDnoxuc9c+y5XfZ/z2FIVctMXX7VyT+k3I49cNDr1eH0qPTymi/zu8zMIQ7hhQ
	3FR2XDTy11ziR1Euau5cg==
X-ME-Sender: <xms:FlGzZUvQGAiGms-HtUcP8_1wiWBpC7qsUi_2HXEqu-0E9bODo5YdSg>
    <xme:FlGzZRcuzhSeZOh3quhSJKwq-2SAtQfsrWJq3xB_uuBrOf52qn2uOjMRyRAfgQ3Xs
    rn8RxjW027hpVb7r8w>
X-ME-Received: <xmr:FlGzZfyhxn_6AyG-R7o0ZwxAzkukqa3aryNsqDJjC4_1K4FhzzcDxonEdizeGXVPePwOfSDAxehEG8_e7TQTKr9lagXZYoguVQmmwLYWdFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeggihhn
    tggvnhhtuceuvghrnhgrthcuoehvihhntggvnhhtsegsvghrnhgrthdrtghhqeenucggtf
    frrghtthgvrhhnpeehveekuedtieeltdffleduheetgeduffejffdtlefftedtgfekueel
    fffgudekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehvihhntggvnhhtsegsvghrnhgrthdrtghh
X-ME-Proxy: <xmx:FlGzZXPMTv7FGd-4Ty5giVB_4M7nUk5fFeuhpCYGlYfEywRheDCM0g>
    <xmx:FlGzZU8jhIMQfTZ28nQr-LAaXEVi7N9KXRaOHRwmpMYrBuwM8j19Rg>
    <xmx:FlGzZfWetkYA0iJf0Ko0rwvEqGXo41hXfrNLi8PBBzywPqi2CMllAQ>
    <xmx:FlGzZTYOVpSoHQHGedFvLml3JYY1vH6d5NI0v-oLrRE7rSm45I5PmA>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 01:28:37 -0500 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by wally.luffy.cx (Postfix) with ESMTP id 9A7D85F803;
	Fri, 26 Jan 2024 07:28:35 +0100 (CET)
Message-ID: <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
Date: Fri, 26 Jan 2024 07:28:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
To: David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
 <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
Content-Language: en-US, fr
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-25 16:50, David Ahern wrote:

>>>>>> My personal
>>>>>> preference would be to add a new keyword for the new attribute:
>>>>>>
>>>>>> # ip link set dev vx0 type vxlan flowlabel_policy inherit
>>>>>> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
>>>>>>
>>>>>> But let's see what David thinks.
>>>>>>
>>>>>
>>>>> A new keyword for the new attribute seems like the most robust.
>>>>>
>>>>> That said, inherit is already used in several ip commands for dscp, ttl
>>>>> and flowlabel for example; I do not see a separate keyword - e.g.,
>>>>> ip6tunnel.c.
>>>>
>>>> The implementation for flowlabel was modeled along ttl. We did diverge
>>>> for kernel, we can diverge for iproute2 as well. However, I am unsure if
>>>> you say we should go for option A (new attribute) or option B (do like
>>>> for dscp/ttl).
>>>
>>> A divergent kernel API does not mean the command line for iproute2 needs
>>> to be divergent. Consistent syntax across ip commands is best from a
>>> user perspective. What are the downsides to making 'inherit' for
>>> flowlabel work for vxlan like it does for ip6tunnel, ip6tnl and gre6?
>>> Presumably inherit is relevant for geneve? (We really need to stop
>>> making these tweaks on a single protocol basis.)
>>
>> Currently, the patch implements "inherit" without a new keyword, like
>> this is done for the other protocols. I don't really see a downside,
>> except the kernel could one day implement a policy that may be difficult
>> to express this way (inherit-during-the-day-fixed-during-the-night).
> 
> Wouldn't other uses of inherit be subject to the same kind of problem?
> ie., my primary point is for consistency in behavior across commands.

Honestly, I have a hard time finding a real downside. The day we need to 
specify both a value and a policy, it will still be time to introduce a 
new keyword. For now, it seems better to be consistent with the other 
protocols and with the other keywords (ttl, for example) using the same 
approach.

