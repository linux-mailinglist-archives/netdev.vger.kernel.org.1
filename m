Return-Path: <netdev+bounces-281097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CJcO1Iy7GnCVQAAu9opvQ
	(envelope-from <netdev+bounces-281097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 05:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64049464E3C
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6532730066B0
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70634250E;
	Sat, 25 Apr 2026 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDopzlCF"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAD40DFB2
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777087056; cv=none; b=b6ioQuirOQixZyOCBJSonei1wh4pe7ElFGJzoi/rKsW2AO4oDU8POzQm9OrF1fxhVbtKNEppmxUzMiLarzSvRZ91Rl4Ul7mzzKUd1MzJW0BuKY7tgKo84pDUxDDQNhbh+G6kKtAu/widM6gxwXhjDtkD5ifrcDWsBGBjcw1kAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777087056; c=relaxed/simple;
	bh=P/jCRwI+vb3hmgLl3TD2Y/H7nGJHvOWxFGiCx+eUJTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcCXZ11FE1TKiXai3nXvM+0kGeaIFZ2u1AjibVH7mBl62vkrzgD3UOLRKemwwtGbIK9AnFMsInmqyjYXq1BbdBgfgnL9ni4N4+2pwQtkg+54KgC5cfLstMca55aHvAhuU+JN048NMfSjRk40NFIYz/pUvvrR0BH6qV1Q9ISTxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDopzlCF; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777087042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvFrmnSTSSnKofZYD+adzsXaKTvHU//GdzJAoINgsm4=;
	b=xDopzlCFZJqDsrVe1A5POf9VnZxVWhEBxIvuyDA8pHtvOzoQFcKfl2DurcfgIzS3HWNEjT
	u+v4eyupBGPg3VFEeltYj4teLoXabacwa96nSUyg406cILXaaXE9ofROuoqRCDd+SLhM1U
	RBA2OEbSRGYJFOwhAXhaBiQqVU7W8QA=
Date: Sat, 25 Apr 2026 11:17:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
To: Weiming Shi <bestswngs@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260424190310.1520555-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 64049464E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281097-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,vger.kernel.org,asu.edu];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.438];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email,linux.dev:dkim,linux.dev:mid]


On 4/25/26 3:03 AM, Weiming Shi wrote:
> bpf_msg_push_data() allocates pages via alloc_pages() without
> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> heap content is added directly to the sk_msg scatterlist, which is
> then transmitted over TCP to userspace via tcp_bpf_push(). In the
> copy path, a gap of len bytes between the front and back memcpy
> regions is similarly left uninitialized.
>
> This leads to a kernel heap information leak: stale page content
> including kernel pointers from the direct-map and vmemmap regions
> is transmitted to userspace, which can be used to defeat KASLR.
>
> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> page is always zeroed before it enters the scatterlist.



As the helper's own documentation says:

     If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
     want to insert metadata or options into the msg. This can later be
     read and used by any of the lower layer BPF hooks.

The inserted region is meant to be written by the BPF program — that's 
the entire point of calling push.

If the program doesn't fill it,  the push has no purpose to begin with.


Isn't the uninitialized content a bug in the BPF program rather than 
something the kernel helper should paper over?


> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e0..ea02239892fd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>   	if (!space || (space == 1 && start != offset))
>   		copy = msg->sg.data[i].length;
>   
> -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
>   			   get_order(copy + len));
>   	if (unlikely(!page))
>   		return -ENOMEM;

