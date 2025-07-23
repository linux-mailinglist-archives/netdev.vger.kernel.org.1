Return-Path: <netdev+bounces-209151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079ABB0E7A4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3663A5808D5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5717FBA2;
	Wed, 23 Jul 2025 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MrSMwD9h"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D02F43
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231053; cv=none; b=AC4J5zRQfjcPfFnvSDwjywjCmrOM2FLdoFk5LIn4New+6DwITQ9VP2sIuEnM4JET1ETGvRIO0x+PX9cDjbRbsrGJJNaFgsBxW4i3BYkDe707rnlw2rtctEcQp6QpFdImU4/wlfwSTHLGljCtrYHkgk1KGNEKloX9NIhPsK7RmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231053; c=relaxed/simple;
	bh=E0UPxY2Bh56RvJMoF0lZQ2lcY0O5+XW+alctZh4qnTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZInkZf6K1zEve4Qk8yTQlta/sZWIALdzZwNNKaCOMnWmYS1gVIJBiW0Ze3FuvkFuKtZbpXVL4u6lecREuFioq9SHLYysoR7e8kc20arJaELGUnU8dMM4R21vUKG71qGR+ThcjWDkSB9gewlT61U/iws5eDLPwz8Bki+tHRTMq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MrSMwD9h; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753231039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9HSIZ+/nil3w0TqqXcDvUAZwBf7JWFXYE5kn6ZSk3c=;
	b=MrSMwD9hcHVHJriA0ySI/rTHkR0IePOHmAqYhQM0dBUeOd8rWYUWnZCsedxuolkSc41H/J
	PxidM35k8jKnMorNYzKAK7jsk4GnYnBqDuwPB7dDUKyaqXESYGPbwIrJkMgmD54MKJeBXz
	Y8GUhJQPomjpqyoyxoz1EnMXsAgJUkI=
Date: Tue, 22 Jul 2025 17:37:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
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
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
 <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/21/25 3:52 AM, Jakub Sitnicki wrote:
> @@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>   	if (offset)
>   		return;
>   
> -	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
> +	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {

I don't think this check is needed. The skb_meta is writable to tc.

>   		seen_direct_write = env->seen_direct_write;
>   		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);

is_rdonly is always false here.

>   
> -		if (is_rdonly)
> -			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +		if (is_rdonly) {
> +			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
> +				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
> +				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
> +		}

[ ... ]

> +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,

so I suspect this is never used and not needed now. Please check.
It can be revisited in the future when other hooks are supported. It will be a 
useful comment in the commit message.

> +				    struct bpf_dynptr *ptr__uninit)
> +{
> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
> +}

