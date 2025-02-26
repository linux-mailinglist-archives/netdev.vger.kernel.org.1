Return-Path: <netdev+bounces-169943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0FA4693F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D27AAB83
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A28233151;
	Wed, 26 Feb 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwtpG6HH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DE22F163
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593535; cv=none; b=W1yYvXjHpzXMZzFtksia/ZTvuRTX/XFkIaYpjF3RBZ91jY0+eWc/pmDoQBXMN1NfmLTLX8y4p0qObVXmLrjjg/iDuRTVQuWZhnbP4jJVgSGKPzvQcbF23UzaCY4AH/RguJhF1K2ZjgB807yQR2tREQ2oDvIl3R9V4HisFiW1Qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593535; c=relaxed/simple;
	bh=iAjhGQtRVnaCjyPUnU3kuwHrKcHfDbtkH21BgknbVMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HabTIAuA1IrCQbgUUd2iRXYiHQPRoDs6GdmtNFMAYeLXpBbsCPasAfhIaKKBdKZUWOsL9zfHvxyxfgeMCrwgquPJHWjYgzGx8m9Y6mzdT+pHOLmnQwqew02s/3hdfHJ73NToE+kYCo0ZEBiBDhqXDLfuDLLC5nEvG3G78i+PUfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwtpG6HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970CEC4CEEC;
	Wed, 26 Feb 2025 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593535;
	bh=iAjhGQtRVnaCjyPUnU3kuwHrKcHfDbtkH21BgknbVMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JwtpG6HHO48X+FtfXjNTIaIQG94kQ1nYi/gz2WxvmGmTx5/gWic4Djuf08WAno07O
	 1OfZl4zXCqBYMK0gLNyAsQO4upncbNaAuKxlUPwRWwQ6S0KE7oONl8eU4g93yZyWFV
	 hsJfq1B9vF38WJpfmHkZBCZsCh27DgZkgjTSLVfpPvb9PTTSG3DOLMLrgt0QQc4Em8
	 b1n6z6xpr2GZGHoetDc/Zvo0naqEhElke2OuwNKsdrOjOhMC4/vlDXyfVJxTnnYSuz
	 wkO97J0ofzjdojbtHLqor1hZ9kl1rCr8R3E7nblesynZqMbSX3roHuTDfWeELMsZyX
	 jDA6EyZgEwy2w==
Message-ID: <a0a1ee91-b557-4721-9d35-a7914f75ed2b@kernel.org>
Date: Wed, 26 Feb 2025 11:12:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 03/12] ipv4: fib: Allocate fib_info_hash[]
 during netns initialisation.
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250225182250.74650-1-kuniyu@amazon.com>
 <20250225182250.74650-4-kuniyu@amazon.com>
 <35e7f0a9-3c8d-479c-9a4c-012354f08c5d@kernel.org>
 <CANn89iJ5c+Dq6WLb6DDxD=eEkueS_awg6CcFGcTBrpJPBNgrsw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJ5c+Dq6WLb6DDxD=eEkueS_awg6CcFGcTBrpJPBNgrsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:09 AM, Eric Dumazet wrote:
>>> @@ -1627,6 +1633,8 @@ static int __net_init fib_net_init(struct net *net)
>>>  out_proc:
>>>       nl_fib_lookup_exit(net);
>>>  out_nlfl:
>>> +     fib4_semantics_init(net);
>>
>> _exit?
> 
> Yes, this was mentioned yesterday.

not in this code path but rather fib_net_exit. Hence me pointing out
this one only

