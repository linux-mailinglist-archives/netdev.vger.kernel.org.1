Return-Path: <netdev+bounces-65660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB183B46B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6F31C2093B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A013540C;
	Wed, 24 Jan 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="qPhesHM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="juXG0FEc"
X-Original-To: netdev@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A51353E4
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133668; cv=none; b=aEwt2JXFEm2pL0zKIp+TiHv249z1c4/JVDzg0hh7d1IEjsQUlC2pd+MzsHF6J9qKcDIp4T2GxM2v2XPXNHsdz4f4hvHgHV/e56tKq6w1AOsCm49l8N2PlGys4j58MJgQWO1A8QfHuPIJ+g2UtJRkIg1ZmwvCYUdSw8ir223tnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133668; c=relaxed/simple;
	bh=yWDZrTatLDbKC9/qLqIOZXB91WEnUUb7iYfdhVlU27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/a3q55P6DAAXeiwBq4DnGQN0hjOhviFIPHk5ixbpuYwL1cUDnhkOtb1UIn/uouxDMPYX/wuCE3SDiC/PvhRHp0h4pEnLDIno4mWG6feZjO6Cfvua2tHSp+YvsVfauSUnzn2slBI/FPmOh24AT3ddehR7dySaGn39q9L2UlOwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch; spf=pass smtp.mailfrom=bernat.ch; dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b=qPhesHM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=juXG0FEc; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernat.ch
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9D98A3200B20;
	Wed, 24 Jan 2024 17:01:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 17:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706133661;
	 x=1706220061; bh=l2f1tVNSEBCkTWzB9YyMUtVJKSEYUrw4M+cG/OSQHN4=; b=
	qPhesHM2zmnDEqCYayIv4pDoBG3fiov+VNHeitKQFVfZcB/f/+X0Qq50Xrr+ICCA
	2WlRRLYcf1PyL0j57+F9/b6e6wxaekLZSA58qgv7z81YKwPvTQRLssfyh2hEKrN4
	jVn+5TmJHNgAgPEPikdtdtss9H3wHIlnWADL53/kctkN2H3us8ROGh9lxirG/VI0
	KP2ctnQnndWQk6v5DlaqQz1iH9K0F03oEI4NAspZs01W5LYX307Mh5MOIVu8Ge1N
	HtCrQKqz8sIGycBFUNSNn9A665gwY+Hl21pRbcoYN86KGXMm+fIVpDg+xShaevPR
	Knff2f9oQz1J2/wl4PBrMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706133661; x=
	1706220061; bh=l2f1tVNSEBCkTWzB9YyMUtVJKSEYUrw4M+cG/OSQHN4=; b=j
	uXG0FEcr56fHNbeIFKLgNETGZbUZSY2a/STFMPE7nnsFxdoP4RE7KEWBoEUZ3AQy
	tbeFIwXUXnwIdSM3TaJa5vWZNYgWg9t+dF2+kHDfnHE7uRunmUaeSY2g2jTcD8um
	ro2QwyTwU5M6tfq8jd1hZ7Qyn50P1AvS9N/dKwK6++YtFWtMNIM0aDArbM6xMkXE
	KqYbhyfjdK5du0MMfCM1BWVb5vW4A04EeoWJ0OVlW/5cVhPI0sXHoPgi5pfQgc69
	F83kGYutMOZ3XuiD39yLD1FEmGGwxMIFTY9iw0cqTJQDz44QeQGCrQNqokoEbKad
	ZX0dlHAQUbOqeBMT/lgnw==
X-ME-Sender: <xms:nIixZYMYMRBUq4cCna18DaBYvcvpzFSz6_MvrvIvYmB2-cryWu2BVA>
    <xme:nIixZe89p3tFXAyvQo24kjad2yURRA6JYJqyAbZdRgTkMZ2gDIZUHtZsyiwAaVwYW
    EM2ZIFLHLlwuBhGdqc>
X-ME-Received: <xmr:nIixZfRwjjkuBFp_Mx1xz_sq87QVWWO2GQEftyYOKbwI1XYBylAAwnJ7yz1mVRMsjUoycMIQIGsutApPYaeNU6kPpowqJAoYjXg77Iwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghi
    nhgtvghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecugg
    ftrfgrthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeu
    leffgfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:nIixZQu89Hh09OO1oWN7-etiMkIJa-qdeHBXkQnAsR8DprqYQGN4Eg>
    <xmx:nIixZQe3jYEeMy0P26Wrh7j7HRYrJKz-N9gGpeC2Hkn0XPa9yiMGaQ>
    <xmx:nIixZU3UIcn5qRLri7Dzy8IzVog341H8miVIawc9f5NtXWDSLT2Rww>
    <xmx:nYixZY6WAVh-iuNDMWKPGrIIlXdrr8T2HEmDeVpdRDDQIuUzstxTpg>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 17:01:00 -0500 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id B3FD05CF;
	Wed, 24 Jan 2024 23:00:58 +0100 (CET)
Message-ID: <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
Date: Wed, 24 Jan 2024 23:00:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US, fr
To: David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-23 17:19, David Ahern wrote:

>>>> My personal
>>>> preference would be to add a new keyword for the new attribute:
>>>>
>>>> # ip link set dev vx0 type vxlan flowlabel_policy inherit
>>>> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
>>>>
>>>> But let's see what David thinks.
>>>>
>>>
>>> A new keyword for the new attribute seems like the most robust.
>>>
>>> That said, inherit is already used in several ip commands for dscp, ttl
>>> and flowlabel for example; I do not see a separate keyword - e.g.,
>>> ip6tunnel.c.
>>
>> The implementation for flowlabel was modeled along ttl. We did diverge
>> for kernel, we can diverge for iproute2 as well. However, I am unsure if
>> you say we should go for option A (new attribute) or option B (do like
>> for dscp/ttl).
> 
> A divergent kernel API does not mean the command line for iproute2 needs
> to be divergent. Consistent syntax across ip commands is best from a
> user perspective. What are the downsides to making 'inherit' for
> flowlabel work for vxlan like it does for ip6tunnel, ip6tnl and gre6?
> Presumably inherit is relevant for geneve? (We really need to stop
> making these tweaks on a single protocol basis.)

Currently, the patch implements "inherit" without a new keyword, like 
this is done for the other protocols. I don't really see a downside, 
except the kernel could one day implement a policy that may be difficult 
to express this way (inherit-during-the-day-fixed-during-the-night).

