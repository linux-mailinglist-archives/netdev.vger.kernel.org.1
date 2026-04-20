Return-Path: <netdev+bounces-279713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eED3E4AL5mluqwEAu9opvQ
	(envelope-from <netdev+bounces-279713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F43429DB1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A5C3047079
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745E399368;
	Mon, 20 Apr 2026 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dW1pAJ5Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADD2D8DC2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682948; cv=none; b=qZM8Wio8z18JUKMwIbVKRemg4eObGB6WWkEjX0iERrGuQ5wzuLLnuXcJnLJV9Q3uIReivSIEoMGPLmrFmO9qBuPwIufvp6AG9uQJAT99Z8PKPn6PhvB1Z5ZvPsbJori1V9BBOpPwdgaWe+A5U0I/dUJrGcDoBoacIT7bYd96IOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682948; c=relaxed/simple;
	bh=1aRttrrBP0iCZYc0rvz52hQkbSo7VxgBOO63EUEhW+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sl+s53PCD5QVyIWTzdc5gStczry753KBeTHjd/Vl9cK1vkb4PTGr/gSKCv6sA0w0XBey0tT2frqvGLn2oZ1c0ob3oUkU57PWEh1OQbDJ+fxVMsKSsXcMDPwKAhU9GOJkbe1amcMnSeGGWOsHiqTrUqxWVFRg6rcBvF+j3NyCFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dW1pAJ5Q; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4d05627-875a-4d4f-9d58-ee049b711aa0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776682934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M+mBywnMu+XNm7UR9zjkEyZpd9/dF14yBgmIQ6PV5Q=;
	b=dW1pAJ5QZWa418lIiNPagOPpCKEiCyzqD6onTfEjOSJGHx1494+cb3nVlO7S3Tjqxlu/FE
	HyY80omAhUPqu+fT+GlvDwDooBY1H8WkX2jd8DIozb7V8b1lOUiFT2szSnNu1Ym+Pl1mYP
	xYfP4+egEW4qmWo5jvWuo4+uTugXL68=
Date: Mon, 20 Apr 2026 19:01:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_skb_fib_lookup()
To: Weiming Shi <bestswngs@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
References: <20260419170131.3899757-2-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260419170131.3899757-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279713-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,asu.edu];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.866];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: A3F43429DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/20/26 1:01 AM, Weiming Shi wrote:
> When tot_len is not provided by the user, bpf_skb_fib_lookup()
> resolves the FIB result's output device via dev_get_by_index_rcu()
> to check skb forwardability and fill in mtu_result. The returned
> pointer is dereferenced without a NULL check. If the device is
> concurrently unregistered, dev_get_by_index_rcu() returns NULL and
> is_skb_forwardable() crashes at dev->flags:
>
>   KASAN: null-ptr-deref in range
>    [0x00000000000000b0-0x00000000000000b7]
>   Call Trace:
>    is_skb_forwardable (include/linux/netdevice.h:4365)
>    bpf_skb_fib_lookup (net/core/filter.c:6446)
>    bpf_prog_test_run_skb (net/bpf/test_run.c)
>    __sys_bpf (kernel/bpf/syscall.c)
>
> Add the missing NULL check, returning -ENODEV to be consistent
> with how bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() handle
> the same condition.
>
> Fixes: e1850ea9bd9e ("bpf: bpf_fib_lookup return MTU value as output when looked up")

Is it correct to blame  this commit?

I find such code block 'if (!is_skb_forwardable(dev, skb))' was 
introduced by 4f74fede40df


> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   net/core/filter.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..3e56b567bd18 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
>   		 * against MTU of FIB lookup resulting net_device
>   		 */
>   		dev = dev_get_by_index_rcu(net, params->ifindex);
> +		if (!dev)
> +			return -ENODEV;
>   		if (!is_skb_forwardable(dev, skb))
>   			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
>   

