Return-Path: <netdev+bounces-281135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n6wdIk2x7WlumgAAu9opvQ
	(envelope-from <netdev+bounces-281135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:31:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFC468D8D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 692503004D0A
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE6274B2B;
	Sun, 26 Apr 2026 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUraleRI"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BCEEC0
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777185097; cv=none; b=JDV6dZ94gBOYtCf75zoRJdjeS2BFXgSjaf2R7eg5Y+lneGAcx9tq1m6MvlWzWLRmgao2WrHG2R44E+tOXA5ZpItPL81KJDViCaYgII1+h3ROrPK1V+i4eQbnXF+LhQLeMpPH/VpQMoNTvhvylC7Z8S41bQ+eSWy/VOdpI1J6pcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777185097; c=relaxed/simple;
	bh=HxZVHvWazSVorOvbpUJDJhXnaoAWTKCRWrUhAhzsq0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhQrKfA/Yz4d6hQGx9DkwabnLRGmYxw5tAQblwTkgVqf5TH/wJ5l2OabxKZahZAA5agaFnPMiFoGFhF753b/pLUTWwLeSxchPgXcVHgYrENsnBBfR61c56HTmWxdU8S5YL7atpR6xBbNSXehnf7VwVfIFvmrYqvBDkbZEcIDEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUraleRI; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <daab27eb-2763-462b-8a9f-34adf0c92e0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777185093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcsw6u5oUUHH4lK0hwux6zR3OGq3uFxkPRUG26PVa5Q=;
	b=qUraleRIi/EyCohjYn2anF9Btn8a9wY0sT35yziTGOQMt/MbggGIR+OnbXTX4sdxfvOnJ3
	gNnqfgRScqb77nvNSdn0uxC1ShrMJdmM/DAG1pMZsxw9Q4yP6zEXJuTt5/Souia32wR4eg
	ItNqMVDBNhDywQPHfcGVjhIul9vHil8=
Date: Sun, 26 Apr 2026 14:31:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
To: Weiming Shi <bestswngs@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
 <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev> <aey55I9gC0VtaN1p@Air.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aey55I9gC0VtaN1p@Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1DDFC468D8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281135-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org,asu.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]


On 4/26/26 1:59 AM, Weiming Shi wrote:
> On 26-04-25 11:17, Jiayuan Chen wrote:
>> On 4/25/26 3:03 AM, Weiming Shi wrote:
>>> bpf_msg_push_data() allocates pages via alloc_pages() without
>>> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
>>> heap content is added directly to the sk_msg scatterlist, which is
>>> then transmitted over TCP to userspace via tcp_bpf_push(). In the
>>> copy path, a gap of len bytes between the front and back memcpy
>>> regions is similarly left uninitialized.
>>>
>>> This leads to a kernel heap information leak: stale page content
>>> including kernel pointers from the direct-map and vmemmap regions
>>> is transmitted to userspace, which can be used to defeat KASLR.
>>>
>>> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
>>> page is always zeroed before it enters the scatterlist.
>>
>>
>> As the helper's own documentation says:
>>
>>      If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
>>      want to insert metadata or options into the msg. This can later be
>>      read and used by any of the lower layer BPF hooks.
>>
>> The inserted region is meant to be written by the BPF program — that's the
>> entire point of calling push.
>>
>> If the program doesn't fill it,  the push has no purpose to begin with.
>>
>>
>> Isn't the uninitialized content a bug in the BPF program rather than
>> something the kernel helper should paper over?
>>
> Hi, Thanks for the review.
>
> In my testing a process with only CAP_BPF + CAP_NET_ADMIN can receive
> kernel heap and vmalloc pointers through recv() from the uninitialized
> pushed region. The uninitialized memory contains critical kernel metadata
> such as direct-map and vmalloc pointers, which breaks KASLR.
>
> Kernels without CONFIG_INIT_ON_ALLOC_DEFAULT_ON (e.g. RHEL) are
> directly affected the leak is not masked by any mitigation.
>
> Thanks,
> Weiming Shi
>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Previously I thought this was as same as bpf_xdp_adjust_head / 
bpf_xdp_adjust_meta,
but the function itself allocates a page, I believed the cost of 
GFP_ZERO flag was irrelevant.

Add one more thing: in the future, more and more AI systems will 
complain about
this kind of problem. I believe it is worth it.



