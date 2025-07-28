Return-Path: <netdev+bounces-210505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9AB13A97
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A06189085B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A79263F2D;
	Mon, 28 Jul 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="XHSF6rfC"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECD6EB79
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706183; cv=none; b=q7LuY3dEIYMXEzwQUtfz09lZgEukyYNmxEj4Sownp9mT9yagQqd869YfLzuz/dPgZB5Fhn4r9jFznsv/F2Czwyoz9RV3jCW7TdRZlKZfQPzzPpYij2HlVz+WKY9OmR/vHLZju3kpIYmlSR+PobLyKylGRlkjDJkT3S9tSX5uJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706183; c=relaxed/simple;
	bh=rk9yUECkUl4KsK35L6zCsXaQGPevHVZb7a6c5P/HEEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fc0vnsS9eF+wgWih96KEYyDdBharlsb2KTB389D4Q1/fuhLN/c+CBVaey7iXvfB5AWJfgitCGjqh4FgAEJZjHDr7R/VTiBUlHFTC0S01bwpaMVVXNoYLX+C36WUUz0PA3CtZ5OO45GbYMs3JY91N76ZZtFlK9PDS/BWcG0sifbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=XHSF6rfC; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4C844240027
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 14:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753706179;
	bh=AUKcL5dzuhxvDSh1cg5flYblUDexYB6jKcILarUkhu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=XHSF6rfC29eg9+FsZrAf9qFo00W+b2sn3onkoMQ1D0orxOnD+WZAYdd2jtl+bbMqM
	 K9Dr4SWGPwHWWn87UVnVhbqS277Zv369cp+EQB0649c980MX/mfbedTvWCW0y6nKj+
	 jE/ciNy6f+NuZaWGQ5VrevtDaF76dCaRKDEBltAjQ6uNHzaMvriipfP6WjWRG3x2/T
	 NWtMD1zyo6myt9ROqoWWKcbjAj+nIyk0cBmCQlE/713ymDp02UfyIRLxL+YtL7Lig0
	 C0oaNSm1GUOR9wHglik9UYiWKEoa+yaPYft5lCkIFmj/4IuSDH4ZOTixrikWzkA84X
	 WRk74JGkLWUbTcvCqL9mq3qmLUIUmQf5vbo8Jk9AvwPzfLyT1z6tpYSnoixnhcohRO
	 a/KoI8aOsMtSwR3EugSX0o/quxos0KzThBgVIhlMYXFefMQYzbyoveDW67rH199Wj6
	 Fs2P/yRee2nGd8yjGC1Do+XA62idd4X7mU7YmNSYlyc3OsZqd3n
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4brHym2Sm7z6tvm;
	Mon, 28 Jul 2025 14:36:16 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Simon Horman <horms@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
  David Ahern <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: ipv6: fix buffer overflow in AH output
In-Reply-To: <20250728113656.GA1367887@horms.kernel.org>
References: <20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net>
	<20250728113656.GA1367887@horms.kernel.org>
Date: Mon, 28 Jul 2025 12:36:18 +0000
Message-ID: <871pq05w74.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> On Sun, Jul 27, 2025 at 09:51:40PM +0000, Charalampos Mitrodimas wrote:
>> Fix a buffer overflow where extension headers are incorrectly copied
>> to the IPv6 address fields, resulting in a field-spanning write of up
>> to 40 bytes into a 16-byte field (IPv6 address).
>> 
>>   memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
>>   WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
>> 
>> The issue occurs in ah6_output() and ah6_output_done() where the code
>> attempts to save/restore extension headers by copying them to/from the
>> IPv6 source/destination address fields based on the CONFIG_IPV6_MIP6
>> setting.
>> 
>> Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
>> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
>> ---
>> Changes in v2:
>> - Link correct syzbot dashboard link in patch tags
>> - Link to v1: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net
>
> You posted two versions of this patch within a few minutes.
> Please don't do that. Rather, please wait 24h to allow review to occur.

I'm aware. The reason for posting the second version so soon was because
I did not want people to get confused about which syzbot report this
solves, as the one in v1 was the wrong.

>
> https://docs.kernel.org/process/maintainer-netdev.html
>
>> ---
>>  net/ipv6/ah6.c | 24 +++++-------------------
>>  1 file changed, 5 insertions(+), 19 deletions(-)
>> 
>> diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
>> index eb474f0987ae016b9d800e9f83d70d73171b21d2..0fa3ed3c64c4ed1a1907d73fb3477e11ef0bd5b8 100644
>> --- a/net/ipv6/ah6.c
>> +++ b/net/ipv6/ah6.c
>> @@ -301,13 +301,8 @@ static void ah6_output_done(void *data, int err)
>>  	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
>>  	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
>>  
>> -	if (extlen) {
>> -#if IS_ENABLED(CONFIG_IPV6_MIP6)
>> -		memcpy(&top_iph->saddr, iph_ext, extlen);
>> -#else
>> -		memcpy(&top_iph->daddr, iph_ext, extlen);
>> -#endif
>> -	}
>> +	if (extlen)
>> +		memcpy((u8 *)(top_iph + 1), iph_ext, extlen);
>
> nit: The cast seems unnecessary.

You're right.

>
>>  
>>  	kfree(AH_SKB_CB(skb)->tmp);
>>  	xfrm_output_resume(skb->sk, skb, err);
>
> I am somewhat confused about both your description of the problem,
> and the solution.
>
> It seems to me that:
>
> 1. The existing memcpy (two variants, depending on CONFIG_IPV6_MIP6),
>    are copying data to the correct location (else this fetuare would not work).
> 2. Due to the structure layout of struct ipv6hdr, syzcaller is warning that
>    the write overruns he end of the structure.
> 3. Although that syzcaller is correct about the structure field being too
>    small for the data, there is space to write into.
>
> Are these three points correct?

Yes, you're right. The code works because extension headers come right
after the IPv6 header in memory, and the warning is a false positive. I
now see my patch could break things by only copying extension headers
instead of both addresses and extension headers like the original code
does.

>
> If so, I don't think it is correct to describe this as a buffer overflow
> in the patch description. But rather a warning about one, that turns
> out to be a false positive. And if so, I think this patch is more of
> a clean-up for ipsec-next, rather than a fix for ipsec or net.

Yes this can be changed to mention something with "field-spanning memcpy
warning".

>
> Also, if so, I don't think your patch is correct because it changes the
> destination address that data is written to from towards the end of
> top_iph, to immediately after the end of top_iph (which is further into
> overflow territory, if that is the problem).
>
> I'm unsure of a concise way to resolve this problem, but it seems to me
> that the following is correct (compile tested only!):
>
> diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
> index eb474f0987ae..5bf22b007053 100644
> --- a/net/ipv6/ah6.c
> +++ b/net/ipv6/ah6.c
> @@ -303,10 +303,10 @@ static void ah6_output_done(void *data, int err)
>  
>  	if (extlen) {
>  #if IS_ENABLED(CONFIG_IPV6_MIP6)
> -		memcpy(&top_iph->saddr, iph_ext, extlen);
> -#else
> -		memcpy(&top_iph->daddr, iph_ext, extlen);
> +		top_iph->saddr = iph_ext->saddr;
>  #endif
> +		top_iph->daddr = iph_ext->daddr;
> +		memcpy(top_iph + 1, &iph_ext->hdrs, extlen - sizeof(*iph_ext));
>  	}
>  
>  	kfree(AH_SKB_CB(skb)->tmp);

This is much better actually, thanks a lot. I tested it with the syzbot
reproducer and no issues were found.

>
> I would also suggest adding a helper (or two), to avoid (repeatedly) open
> coding whatever approach is taken.

I'll do that and go on with a patch targetting ipsec-next. Is it okay to
keep the the versioning or it should a completely new patch?

>
> ...

Thanks,
C. Mitrodimas

