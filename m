Return-Path: <netdev+bounces-210502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0207B139F9
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF457A4943
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81925D1E6;
	Mon, 28 Jul 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcR81GNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCED21CA0C;
	Mon, 28 Jul 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702621; cv=none; b=uQi9P2GuroVsXrb9ET0soxafCFKuNyZfGXL9mLwsXhQcIPhx699ls6JbUB/Ao56NMpLXfXOwohP4IMYcI5IWUJbj3sdsj2n1mDb1PHNeFfuH5gaMmDUPPY+9r5JN5acjKWTML/WdUM/hpLF4Q5Ff+1+jNFryHyykylpLctph1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702621; c=relaxed/simple;
	bh=2Jf+hnJN4REnGQk5VFSNOD1c2NERXFX5MULoUGyYvt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHxP71+E4BfPTjMb82y45249CiqRRGNw9jjbIoOtU9Lmvh6OXAMbJ51hs4HY2kw4BSl/66nRMNRiNseNcjNcmC6OVogCbfBM5A25qL71SOhDf9qQFpszpHYjbQRHmdRZLefSPSaNy2CLV3iqLzvMANADP1isBH0Hw7xHHCYFSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcR81GNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD842C4CEF6;
	Mon, 28 Jul 2025 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753702620;
	bh=2Jf+hnJN4REnGQk5VFSNOD1c2NERXFX5MULoUGyYvt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcR81GNNNE+91UM0GR5CNUwyFAu+Fl23f3VdiVf3BSudX3wKrHrlEzkLMd+NRZ1ZZ
	 ctKNHOG/ZeL5CcmRvQRN4Hygl9YFAeyzjJ8vg2r91KcdVx1eYWFHQUtECw1S7oMChb
	 zSmavO3sN6LlJS0OoWwh6RqcFI9Wz2t0MuWwtR/NzDby6EpwDMSceH3cY2flaSo5Mn
	 yM0aKZiyQogu0VXpBKYryMLnhhlxa6wXA2I4gnZPWTt3Re3DQ3lbl/TEyYcfJyDkSt
	 QdNCVMyhxHFJeJXTL0f4x5UbEIyLvHjLwOkcmjUOWZp1NUSczcjOXUP4+fktimuuT+
	 rl4hHrowMemhQ==
Date: Mon, 28 Jul 2025 12:36:56 +0100
From: Simon Horman <horms@kernel.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: ipv6: fix buffer overflow in AH output
Message-ID: <20250728113656.GA1367887@horms.kernel.org>
References: <20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net>

On Sun, Jul 27, 2025 at 09:51:40PM +0000, Charalampos Mitrodimas wrote:
> Fix a buffer overflow where extension headers are incorrectly copied
> to the IPv6 address fields, resulting in a field-spanning write of up
> to 40 bytes into a 16-byte field (IPv6 address).
> 
>   memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
>   WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
> 
> The issue occurs in ah6_output() and ah6_output_done() where the code
> attempts to save/restore extension headers by copying them to/from the
> IPv6 source/destination address fields based on the CONFIG_IPV6_MIP6
> setting.
> 
> Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
> Changes in v2:
> - Link correct syzbot dashboard link in patch tags
> - Link to v1: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net

You posted two versions of this patch within a few minutes.
Please don't do that. Rather, please wait 24h to allow review to occur.

https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  net/ipv6/ah6.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
> index eb474f0987ae016b9d800e9f83d70d73171b21d2..0fa3ed3c64c4ed1a1907d73fb3477e11ef0bd5b8 100644
> --- a/net/ipv6/ah6.c
> +++ b/net/ipv6/ah6.c
> @@ -301,13 +301,8 @@ static void ah6_output_done(void *data, int err)
>  	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
>  	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
>  
> -	if (extlen) {
> -#if IS_ENABLED(CONFIG_IPV6_MIP6)
> -		memcpy(&top_iph->saddr, iph_ext, extlen);
> -#else
> -		memcpy(&top_iph->daddr, iph_ext, extlen);
> -#endif
> -	}
> +	if (extlen)
> +		memcpy((u8 *)(top_iph + 1), iph_ext, extlen);

nit: The cast seems unnecessary.

>  
>  	kfree(AH_SKB_CB(skb)->tmp);
>  	xfrm_output_resume(skb->sk, skb, err);

I am somewhat confused about both your description of the problem,
and the solution.

It seems to me that:

1. The existing memcpy (two variants, depending on CONFIG_IPV6_MIP6),
   are copying data to the correct location (else this fetuare would not work).
2. Due to the structure layout of struct ipv6hdr, syzcaller is warning that
   the write overruns he end of the structure.
3. Although that syzcaller is correct about the structure field being too
   small for the data, there is space to write into.

Are these three points correct?

If so, I don't think it is correct to describe this as a buffer overflow
in the patch description. But rather a warning about one, that turns
out to be a false positive. And if so, I think this patch is more of
a clean-up for ipsec-next, rather than a fix for ipsec or net.

Also, if so, I don't think your patch is correct because it changes the
destination address that data is written to from towards the end of
top_iph, to immediately after the end of top_iph (which is further into
overflow territory, if that is the problem).

I'm unsure of a concise way to resolve this problem, but it seems to me
that the following is correct (compile tested only!):

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index eb474f0987ae..5bf22b007053 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -303,10 +303,10 @@ static void ah6_output_done(void *data, int err)
 
 	if (extlen) {
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(&top_iph->saddr, iph_ext, extlen);
-#else
-		memcpy(&top_iph->daddr, iph_ext, extlen);
+		top_iph->saddr = iph_ext->saddr;
 #endif
+		top_iph->daddr = iph_ext->daddr;
+		memcpy(top_iph + 1, &iph_ext->hdrs, extlen - sizeof(*iph_ext));
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);

I would also suggest adding a helper (or two), to avoid (repeatedly) open
coding whatever approach is taken.

...

