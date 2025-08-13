Return-Path: <netdev+bounces-213306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B283B247B6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002D97AE843
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06082F3C02;
	Wed, 13 Aug 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MMj7flaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A2F1FE2
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082266; cv=none; b=u6vmaDHvsLQXCEoztkHiCGTCgZdE5vDsD7eVGchuamIHbpaeS4CyU/IE6qEArItqV9LtzXJ7J5STnnkyxcLPfkBesvlLZGai/CP6y781uTaVlEgvRMkZI/QuK6fPe667uaxLZW+l5uIfEDBPehtbkG3ADftDWLPtWp5tnTuWG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082266; c=relaxed/simple;
	bh=wNK5lBJzwimNHmcXGboZZmgAmZaqShiy3WWQ+VHyvok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqkZ0X0HLNpXl1/tKBXe/1y4hECYRDrJtSmlBjFn2zATVkEjc23u6ADM9fm/dX4wJ2sL1IKJiLQ1mSjwtm5PJr5xDiS5Z4Q/yU3gOUm5yPqDNiB11ABHsTywljOPs6K/WzfYe4Em6uGGbcNl3RdDemAd5O2z83GvGWQv5mLhfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MMj7flaC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so12636103a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755082263; x=1755687063; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oAiMi3nnvltNkOnmAA+pFRA1Bt8cfGMzxHvnl7fWPg=;
        b=MMj7flaCsZQn8EHgCOzS3k5eDGl/vHpwncLHHBSQlW0YHEVaAJ/ZFBsEPvuIE4nySK
         BRvKx//elz60Desfk5j72y6XoUcCXguJn4r0lpvkP4EO94OCXZ0lJsvZUo4pJ+Wu8UF4
         R0HrrMVlwziwCUkdbn9sgpnpkK22NE7egd0lqcnZqcza2lP0riHBpTJcelnodQ4iWPlB
         Zp35W+EcUWEwHlRwPdIZSOrp1u/1PEIwBm5dZ9td3aEYFFpOo+TUC+Od5HUEDCrfW06+
         9hBVLzjkTHqnP+pK/y7l1NmWr2anILXXQ2xna3uKGlLp5S2kW3tZA6LuIlmZ5wq4OzXA
         HaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082263; x=1755687063;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oAiMi3nnvltNkOnmAA+pFRA1Bt8cfGMzxHvnl7fWPg=;
        b=jdAeMtAP+0z+0yzmeuGu7dOxrbV4wLysJWzNSwlmC04dS+2MBI3rj0yJ78IN0xFzW0
         FLL7sFlSkutkp9O8mn8mX5pI+svGFltJs722wlWrqLeKSx/CNrYEhJhcP4zlan00UJV3
         IO8soHN3K6+Zo47OqDOoDwp7eF5O/2OWSP9rLU1rOa2nBZQD+WenC1n6w8zHPfq2+zlE
         +sqrEt/MWxCep7V7qUg16iOR/lY7M0XlvX2RJxi/QN6MxetbuVOLaEVi2sBcY7vBjHxC
         ZCQK7LxOvRI+M0fPsUnuVPlgh89wB+j3vHDUS5wITsuEaWY9gUtS0RlFhftHRXpUj18B
         8dEw==
X-Forwarded-Encrypted: i=1; AJvYcCX7JlvXdOqbpTHIqlmw4NBPK3/ShJ0h3R5h476kPl8tCIYxW9Ck5pM2xVTbJATiw1jQARo/JIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfLVF0YiUcZezhlPjpvB8uHQZdxkd55nuG/LcXWnp98nMbHIG
	sp6yuaei3hJRqa0vIFYkuP0yc4zgXRxHvvFpAGwrDXUIYGUvtG6qT/c4IG4zq/5slyc=
X-Gm-Gg: ASbGncvDpgIEcQs7yhCZylJuqFMuKkVfxH+Tml7tyIsCHH+I6N/Ir+zTB3OedvITVgR
	S0euJe6AcwJXpWHOZTn2uV2SK0XEFaaMI2Iy+Nfs+HIusHG/Na37Fbh6+m5avy7spiOEkg4dUP0
	5KdcEJw8y9sxuJP8wYx7+prQqNEWxigp1uyCMA0+T9sjyBEAnEYB23KpdMwNVLsnIvEabjqFH4I
	cQSwYX1GTht9OeKu/nZm3M7N2ff4PVw+l8KRg++bkDq6Hnc36RAasj9DCVAZUgKiY897YQcRpKt
	wW+VwkFLcW3NO/aOJiOZZbzUL8wilHSbyAf36C43yyMR3Spj9r2Ene5xnrRVx22wi3Of28xb+PZ
	y8jriKSgnGRSgjkyqboFWmIAYP/sK2OI=
X-Google-Smtp-Source: AGHT+IHXn8ZGpEgaNIv9TfD+n1v38FElmDllM3HbdYQuhuq+CPsrYjrA1BiA3xDaFDKkCPVB+44ctQ==
X-Received: by 2002:a17:907:d28:b0:af2:3c43:b104 with SMTP id a640c23a62f3a-afca4ef2446mr267215266b.54.1755082263167;
        Wed, 13 Aug 2025 03:51:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df2e4sm2366000666b.62.2025.08.13.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:51:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access
 from a modified skb clone
In-Reply-To: <ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev> (Martin KaFai
	Lau's message of "Tue, 12 Aug 2025 11:20:35 -0700")
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
	<20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
	<7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
	<87h5yi82gp.fsf@cloudflare.com>
	<e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
	<87tt2cr8eb.fsf@cloudflare.com>
	<ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev>
Date: Wed, 13 Aug 2025 12:51:01 +0200
Message-ID: <87plczqyui.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 12, 2025 at 11:20 AM -07, Martin KaFai Lau wrote:
> On 8/12/25 6:12 AM, Jakub Sitnicki wrote:
>>> No strong opinion to either copy the metadata on a clone or set the dynptr
>>> rdonly for a clone. I am ok with either way.
>>>
>>> A brain dump:
>>> On one hand, it is hard to comment without visibility on how will it look like
>>> when data_meta can be preserved in the future, e.g. what may be the overhead but
>>> there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is
>>> some flexibility. On the other hand, having a copy will be less surprise on the
>>> clone skb like what we have discovered in this and the earlier email thread but
>>> I suspect there is actually no write use case on the skb data_meta now.
>> All makes sense.
>> To keep things simple and consistent, it would be best to have a single
>> unclone (bpf_try_make_writable) point caused by a write to metadata
>> through an skb clone.
>> Today, the unclone in the prologue can already be triggered by a write
>> to data_meta from a dead branch. Despite being useless, since
>> pskb_expand_head resets meta_len.
>> We also need the prologue unclone for bpf_dynptr_slice_rdwr created from
>> an skb_meta dynptr, because creating a slice does not invalidate packet
>> pointers by contract.
>> So I'm thinking it makes sense to unclone in the prologue if we see a
>> potential bpf_dynptr_write to skb_meta dynptr as well. This could be
>> done by tweaking check_helper_call to set the seen_direct_write flag:
>> static int check_helper_call(...)
>> {
>>          // ...
>>         	switch (func_id) {
>>          // ...
>> 	case BPF_FUNC_dynptr_write:
>> 	{
>>                  // ...
>> 		dynptr_type = dynptr_get_type(env, reg);
>>                  // ...
>> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
>> 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
>> 			changes_data = true;
>
> This looks ok.
>
>> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
>> 			env->seen_direct_write = true;
>
> The "seen_direct_write = true;" addition will be gone from the verifier
> eventually when pskb_expand_head can keep the data_meta (?). Right, there are
> existing cases that the prologue call might be unnecessary. However, I don't
> think it should be the reason that it can set "seen_direct_write" on top of the
> "changes_data". I think it is confusing.
>
>> 		break;
>> 	}
>>          // ...
>> }
>> That would my the plan for the next iteration, if it sounds sensible.
>> As for keeping metadata intact past a pskb_expand_head call, on second
>> thought, I'd leave that for the next patch set, to keep the patch count
>> within single digits.
>
> If the plan is to make pskb_expand_head support the data_meta later, just set
> the rdonly bit in the bpf_dynptr_from_skb_meta now. Then the future
> pskb_expand_head change will be a clean change in netdev and filter.c, and no
> need to revert the "seen_direct_write" changes from the verifier.

I was planning to keep the "seen_direct_write" change once
pskb_expand_head is patched to preserve the metadata. That way
bpf_dynptr_write(&meta, ...) could remain just a memmove.

But to be fair, at this point I don't have the code worked out, so who
knows how things are going to eventually play out.

All right. Let me make the skb_meta dynptr read-only for skb clones for
now. That sounds like a clean cut compromise since it's a corner case
which we expect no one cares about at the moment.

Thanks for guidance.

