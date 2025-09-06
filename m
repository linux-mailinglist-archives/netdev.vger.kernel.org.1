Return-Path: <netdev+bounces-220582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA49BB46E02
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDE21C245C8
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E42F0C56;
	Sat,  6 Sep 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="O3J+fR62"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA11527B4;
	Sat,  6 Sep 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164940; cv=none; b=VAHKpXEXGSuIpHzB9kRD1FQ9079G2H33Db362FZPZHnNGoirvwHkkciCa4j+szD1xXCso4teEq/tn2DJ0ub3zxR0jY2b4hbr8Yt2U28ox+YqiUswPn4/mYMJEbk+jo4afr5PC9lezdsmqKCCh96dJEuOvAf6HuKI028lrG7NkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164940; c=relaxed/simple;
	bh=WuJjhnpVAljlL69bb7BMFtboVVhRumBRvD7e4BdACi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IemsSBqZYuU2U1iIREaQsXk30jsiZGWziBTr1xsjBY8l8QEjV/NoDfiQwzF7v818JgXyqlaQlxqITcTJGcMuH4bH7zQ4dg3bjup2YH0GfllzpSH2k81YyeP1/2Ewcoixkz9qaQEL82VcvGRi+08zE27Vx9mXDBPcUS7Z/DdZj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=O3J+fR62; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757164932;
	bh=WuJjhnpVAljlL69bb7BMFtboVVhRumBRvD7e4BdACi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O3J+fR624oSv3ySdbCx2BarAaQYFJR8TAxdaB7GcuXgRmuPbzHvlvD/5ZiwSD9ncv
	 GE6N5x9WREsaDYQKVBhAkWuCgxa7JR40Ex+P+FNRKVmCNakhhfnxJGCReTKUO4ugdu
	 erOh9hBWfj4Kmue+GGCV8bCn2MMJktm7n7GGLKPppwanRWdkuA2gC4CoZhXTR+sr0z
	 S8PMkbTxuw1pXDAyDpeK4yd892mFhLu18g6cVGij3FyFp07JP54NygG505Z6LJ9sWG
	 2ZwuAlwQ690SJUPrX8g2asaN5thk2jvK6dvsMZcR1irzsnPUZOvZao8DHChUqv/shZ
	 qyDKYlRb9vKhQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 738776000C;
	Sat,  6 Sep 2025 13:22:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id B6DB6200438;
	Sat, 06 Sep 2025 13:22:01 +0000 (UTC)
Message-ID: <0a9a7c41-7deb-4078-8cc9-aee8f8784443@fiberby.net>
Date: Sat, 6 Sep 2025 13:22:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-6-ast@fiberby.net>
 <20250905172334.0411e05e@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250905172334.0411e05e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/25 12:23 AM, Jakub Kicinski wrote:
> On Thu,  4 Sep 2025 22:01:29 +0000 Asbjørn Sloth Tønnesen wrote:
>> In nested arrays don't require that the intermediate
>> attribute type should be a valid attribute type, it
>> might just be an index or simple 0, it is often not
>> even used.
>>
>> See include/net/netlink.h about NLA_NESTED_ARRAY:
>>> The difference to NLA_NESTED is the structure:
>>> NLA_NESTED has the nested attributes directly inside
>>> while an array has the nested attributes at another
>>> level down and the attribute types directly in the
>>> nesting don't matter.
> 
> I don't understand, please provide more details.
> This is an ArrayNest, right?
> 
> [ARRAY-ATTR]
>    [ENTRY]
>      [MEMBER1]
>      [MEMBER2]
>    [ENTRY]
>      [MEMBER1]
>      [MEMBER2]
> 
> Which level are you saying doesn't matter?
> If entry is a nest it must be a valid nest.
> What the comment you're quoting is saying is that the nla_type of ENTRY
> doesn't matter.

I will expand this in v2, but the gist of it is that this is part of the
"split attribute counting, and later allocating an array to hold them" code.

The check that I remove for nested arrays, is an early exit during the
counting phase. Later in the allocation and parse phase it validates the
nested payload.

In include/uapi/linux/wireguard.h:
 > WGDEVICE_A_PEERS: NLA_NESTED
 >   0: NLA_NESTED
 >     WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 >     [..]
 >   0: NLA_NESTED
 >     ...
 >   ...

The current check requires that the nested type is valid in the nested
attribute set, which in this case resolves to WGDEVICE_A_UNSPEC, which is
YNL_PT_REJECT, and it takes the early exit and returns YNL_PARSE_CB_ERROR.

