Return-Path: <netdev+bounces-213074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D29B23316
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624D43B3FBB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F921D416C;
	Tue, 12 Aug 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbvtVuqo"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D667282E1
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022849; cv=none; b=AtPZXirdLsCRskRoDGPbCX54OeaVX2rBC6HQ8l/VW2D5JM/3d9I2Z7+2rc12h2Q6esNhvtwW78n+6fUWRGHgpSfbS9ehYwJIOrt2CNhZLr2o010/oHPn+tGQxGavoxxhKdQ067BZSOLbdck2B/zdDKEqPcGgyvJSbQg37h5m+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022849; c=relaxed/simple;
	bh=v/nsCGs2xmu59cnfR1Tz4Wld6szL/A5pJS3oBSOfQp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbWBGK/q4NpRVw615M3rNOzZBtgXS4+6q5f119lz1ggqc4qNgO/AugfIKB4nxGW187HdvcKtNkM/BWF7LnLxv8N2gPs2s1bOHhGBot3oGoV4IPLbbcOaOGG3ccbFRuEZPvKhjry7kxQSk5BhTKidWNwAMsHDpD0vHgEL0n6XQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbvtVuqo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755022845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1oQvtxW/ScS+64KV6i67Bpm+cSlP1i/7We44hEj0RE=;
	b=CbvtVuqoUcEzfe3i81tee05aN0G26f/yHxQG3mDPFX1KzRf0a5GWVZKV79+dOLJIlxiAY4
	kWy3mbvZzljmjmyZvFXljzYxk0f7fTJxx7vfyqOBy/p89Z60A11dNVyLZW5xYPedX1rMc3
	B3wfk7kWzEcUqimaXx/Tmh0I6sZ/tWg=
Date: Tue, 12 Aug 2025 11:20:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access from
 a modified skb clone
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
 <20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
 <7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
 <87h5yi82gp.fsf@cloudflare.com>
 <e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
 <87tt2cr8eb.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87tt2cr8eb.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/25 6:12 AM, Jakub Sitnicki wrote:
>> No strong opinion to either copy the metadata on a clone or set the dynptr
>> rdonly for a clone. I am ok with either way.
>>
>> A brain dump:
>> On one hand, it is hard to comment without visibility on how will it look like
>> when data_meta can be preserved in the future, e.g. what may be the overhead but
>> there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is
>> some flexibility. On the other hand, having a copy will be less surprise on the
>> clone skb like what we have discovered in this and the earlier email thread but
>> I suspect there is actually no write use case on the skb data_meta now.
> 
> All makes sense.
> 
> To keep things simple and consistent, it would be best to have a single
> unclone (bpf_try_make_writable) point caused by a write to metadata
> through an skb clone.
> 
> Today, the unclone in the prologue can already be triggered by a write
> to data_meta from a dead branch. Despite being useless, since
> pskb_expand_head resets meta_len.
> 
> We also need the prologue unclone for bpf_dynptr_slice_rdwr created from
> an skb_meta dynptr, because creating a slice does not invalidate packet
> pointers by contract.
> 
> So I'm thinking it makes sense to unclone in the prologue if we see a
> potential bpf_dynptr_write to skb_meta dynptr as well. This could be
> done by tweaking check_helper_call to set the seen_direct_write flag:
> 
> static int check_helper_call(...)
> {
>          // ...
>         	switch (func_id) {
>          // ...
> 	case BPF_FUNC_dynptr_write:
> 	{
>                  // ...
> 		dynptr_type = dynptr_get_type(env, reg);
>                  // ...
> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
> 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
> 			changes_data = true;

This looks ok.

> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
> 			env->seen_direct_write = true;

The "seen_direct_write = true;" addition will be gone from the verifier 
eventually when pskb_expand_head can keep the data_meta (?). Right, there are 
existing cases that the prologue call might be unnecessary. However, I don't 
think it should be the reason that it can set "seen_direct_write" on top of the 
"changes_data". I think it is confusing.

> 
> 		break;
> 	}
>          // ...
> }
> 
> That would my the plan for the next iteration, if it sounds sensible.
> 
> As for keeping metadata intact past a pskb_expand_head call, on second
> thought, I'd leave that for the next patch set, to keep the patch count
> within single digits.

If the plan is to make pskb_expand_head support the data_meta later, just set 
the rdonly bit in the bpf_dynptr_from_skb_meta now. Then the future 
pskb_expand_head change will be a clean change in netdev and filter.c, and no 
need to revert the "seen_direct_write" changes from the verifier.

