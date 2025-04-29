Return-Path: <netdev+bounces-186650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B9AA00EA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DC07A475D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DD267714;
	Tue, 29 Apr 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXPe+xK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B34205E25;
	Tue, 29 Apr 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898784; cv=none; b=sWajYS36IQQzGjMV5K/1qlZo6iHmCP9n+27b0FM3Sq4ley+0BipsJKnMzx8hHyZZVky/THBkjT6FZ3hQyzEuazt/ZC6fOMHuGAmP7selE2pbnodjUO1ROd3yXsrj2K0EqHvUeuLQC/iEa+vmBQnwG4vhHFPeH4KY1LthKkvLiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898784; c=relaxed/simple;
	bh=JWP+LbOHv+wP6QUKbnuoS82KW8BLjO/OX50Wl4RrBvA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y9K89FjMTOD0MQc9XuoZi1oPOY+HoTBeJ8NHsDt+Qy0U3FS4HqQRIYDAZIV6+IFU0XzSZSoHWxUZGbwJG32uNnTPEngKO21CKVkhOqvH/SjN4akGrc9f+3B7DvCmfKow1OWP70DWKjt+EbgUK/XkTZkdd1FyBMQtGGbgRLIMmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXPe+xK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9267C4CEE3;
	Tue, 29 Apr 2025 03:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745898783;
	bh=JWP+LbOHv+wP6QUKbnuoS82KW8BLjO/OX50Wl4RrBvA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UXPe+xK7W1n6JfmrEvk3rT8BlQ5a83ZevoU2kyn+wzd8Ar7yChP+jqoJfqqsfi/m4
	 lxtZUIlU53ngV541nq+Q8TGiLWcXTbwtMCXuGiS5GjIt/8arD37Tm4YJ508NGThi2q
	 hPj9pGmrJa0tUWwoVZm3t8ogVz7x+AIIwhhLxmdunt6dUGYa0Ii7btT5RQLcH4st5l
	 xlQ5Z9ebYjqHs25Hs1OJ3QQC442cXCu6Ulhazo9ByaFjO9QSSYgyeZ2ebThmLkZmFj
	 qF/hWhAhCIuaDfOozGzGl9M4T9na4MDLAfbGDB4fUsQXCPuIOyx2zLZqX+H8fVFfcm
	 GrMCC6O5hXJSQ==
Date: Mon, 28 Apr 2025 20:52:59 -0700
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, dsahern@kernel.org
CC: davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 kuniyu@amazon.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] ipv4: fib: Fix fib_info_hash_alloc() allocation type
User-Agent: K-9 Mail for Android
In-Reply-To: <20250429004310.52559-1-kuniyu@amazon.com>
References: <12141842-39ff-47fc-ac2b-7a72d778117a@kernel.org> <20250429004310.52559-1-kuniyu@amazon.com>
Message-ID: <89BC8935-21D1-45A9-AEA1-A4E52D193434@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 28, 2025 5:43:05 PM PDT, Kuniyuki Iwashima <kuniyu@amazon=2Ecom> =
wrote:
>Thanks for CC me, David=2E
>
>From: David Ahern <dsahern@kernel=2Eorg>
>Date: Mon, 28 Apr 2025 16:50:53 -0600
>> On 4/25/25 11:05 PM, Kees Cook wrote:
>> > In preparation for making the kmalloc family of allocators type aware=
,
>> > we need to make sure that the returned type from the allocation match=
es
>> > the type of the variable being assigned=2E (Before, the allocator wou=
ld
>> > always return "void *", which can be implicitly cast to any pointer t=
ype=2E)
>> >=20
>> > This was allocating many sizeof(struct hlist_head *) when it actually
>> > wanted sizeof(struct hlist_head)=2E Luckily these are the same size=
=2E
>> > Adjust the allocation type to match the assignment=2E
>> >=20
>> > Signed-off-by: Kees Cook <kees@kernel=2Eorg>
>> > ---
>> > Cc: "David S=2E Miller" <davem@davemloft=2Enet>
>> > Cc: David Ahern <dsahern@kernel=2Eorg>
>> > Cc: Eric Dumazet <edumazet@google=2Ecom>
>> > Cc: Jakub Kicinski <kuba@kernel=2Eorg>
>> > Cc: Paolo Abeni <pabeni@redhat=2Ecom>
>> > Cc: Simon Horman <horms@kernel=2Eorg>
>> > Cc: <netdev@vger=2Ekernel=2Eorg>
>> > ---
>> >  net/ipv4/fib_semantics=2Ec | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/net/ipv4/fib_semantics=2Ec b/net/ipv4/fib_semantics=2Ec
>> > index f68bb9e34c34=2E=2E37d12b0bc6be 100644
>> > --- a/net/ipv4/fib_semantics=2Ec
>> > +++ b/net/ipv4/fib_semantics=2Ec
>> > @@ -365,7 +365,7 @@ static struct hlist_head *fib_info_laddrhash_buck=
et(const struct net *net,
>> >  static struct hlist_head *fib_info_hash_alloc(unsigned int hash_bits=
)
>> >  {
>> >  	/* The second half is used for prefsrc */
>> > -	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head *),
>> > +	return kvcalloc((1 << hash_bits) * 2, sizeof(struct hlist_head),
>> >  			GFP_KERNEL);
>> >  }
>> > =20
>>=20
>> Reviewed-by: David Ahern <dsahern@kernel=2Eorg>
>>=20
>> Fixes: fa336adc100e ("ipv4: fib: Allocate fib_info_hash[] and
>> fib_info_laddrhash[] by kvcalloc()=2E)
>
>I agree this should target net=2Egit as the last statement
>will be false with LOCKDEP=2E

Which will be false with lockdep? Unless I'm missing it, I think hlist_hea=
d is always pointer sized:

struct hlist_head {
	struct hlist_node *first;
};

>
>Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon=2Ecom>

Thanks!

--=20
Kees Cook

