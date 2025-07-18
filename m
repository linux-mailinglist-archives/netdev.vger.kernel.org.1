Return-Path: <netdev+bounces-208049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6EB098BD
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFED5871FD
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F731136E;
	Fri, 18 Jul 2025 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hK2m6b+/"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC21C36
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797207; cv=none; b=Oo9jRln9EW08VEEHD86vFHmuEh+yQsEuPUo8MkrTGt0n1x1ca2OM24vhdsUUezZIyZOwSEsxXyJcfXX7iGGKNstZP1jtON+vgAFXzaaJY1pdJNA8KHKSnSvM5CiTKPSW7XkVKyTiOcU0eB5L3eJlv6O0fYEwa9uEnP1lBUpHQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797207; c=relaxed/simple;
	bh=dOnHT1O4o8iCOwSptjp2ySxhR3MdCkibLVHO4gmri5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgc0KKq06CHQvt3VLwcv8rnPNh6GwzOWfxQgop7E5WYudrR8IrGF+H3SDxHkFIOgH7Nsh8usaZSNUgzYpv/qu9AMZlthk8fuRLAMeFnyIKpGoH/cbUrALr7F1BQpvFdnTiPYU7Ugrv8cTx5jaiIV0oS9xJXct7b2yr3b2ODy/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hK2m6b+/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9aa1f2b0-0f63-45e8-b787-e14d53cac75a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752797190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQSDr0byqbFtfvyKe7vKuiXAwUwfEr/1uYNCRHy3ILA=;
	b=hK2m6b+/FJtRrOP5huZj2OkAtyxfhk/RLzHCdmha1g5yvjf25/M1T9eTKcdT5FygUP+PuX
	CFWEKT4jqFtQbaAKTzWBDxSJZt18mnysfXV5pQDFrogVnN0evjg+SjuhMaN0l9kHIb9u5q
	i7iEAvpKCefySsAlyTx1ReCIN0YZQO4=
Date: Thu, 17 Jul 2025 17:06:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 01/13] bpf: Add dynptr type for skb metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
 <20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 9:16 AM, Jakub Sitnicki wrote:
> +__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
> +					 struct bpf_dynptr *ptr__uninit)
> +{
> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
> +}
> +
>   __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
>   				    struct bpf_dynptr *ptr__uninit)
>   {
> @@ -12165,8 +12190,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
>   	return 0;
>   }
>   
> +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
> +				    struct bpf_dynptr *ptr__uninit)
> +{
> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
> +}
> +
>   BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>   BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)

I looked at the high level of the set. I have a quick question.

Have you considered to create another bpf_kfunc_check_set_xxx that is only for 
the tc and tracing prog type? No need to expose this kfunc to other prog types 
if the skb_meta is not available now at those hooks.

It seems patch 5 is to ensure other prog types has meta_len 0 and some of the 
tests are to ensure that the other prog types cannot do useful things with the 
new skb_meta kfunc. The tests will also be different eventually when the 
skb_meta can be preserved beyond tc.


