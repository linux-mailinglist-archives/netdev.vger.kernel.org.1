Return-Path: <netdev+bounces-300818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7dULG7ueNmrcBwcAu9opvQ
	(envelope-from <netdev+bounces-300818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65596A8FB8
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ax3sJYRj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300818-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32409301C161
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5D394499;
	Sat, 20 Jun 2026 14:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9173346ADA
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 14:07:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781964454; cv=none; b=mb3zkOVFYhLzBxklzh9QybEB7vFDsvzkKMH4+3FBv2uhqTnjwo1lF1zVTUbfYLgT5Q4u5HKs7M5Jn4CoRWXhjync30Ha+mtqSMlzLBxjsB77nTYJIGorUjjJAZ3g1hTaXchUkYD9k+2DnZT89uhgql1A9OvuJzKJls8M/K9EwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781964454; c=relaxed/simple;
	bh=kQoC3+53mxvsoMCxdX1jN1XmvLUZhAauBoctIev/5SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ8rabpuUnAdmoxQo+FPeL2TItBw1YvRKROmCJkDhIZhiGkLOO14PF3Iro6vQM2zfcjwaj+zXrRWacnLBVF9V0ra1E5mJO03rBlQlGPnx0JWlfki/js3Q/p1uQG2+OxLIedgaKRYx/nW/gUC1uD88YPeUgadTjVbWtdgMHdPRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ax3sJYRj; arc=none smtp.client-ip=95.215.58.187
Message-ID: <2c8ca8f1-a08b-47fb-a675-dd8c7975d1a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781964441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L55hBgBPhek+J5BD81/5VRyCzAYzeVaP0SnRXv3ngGg=;
	b=Ax3sJYRjIJpkCJwaQWhtsGfiEcDIc9WJl6yxMbSA+6BltiV9ZZu7k0MYsczkpgO/ielblf
	+iFU0G7yFYext1exz29dpfYHrSWr/mzp9oEZaNgQA0937PSF5GMO1uxw9KxsK+RPUsbE+x
	W/eHSB/J3qVz4r4VxsHLXF+4SwJCVDQ=
Date: Sat, 20 Jun 2026 22:06:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[cressey.dev:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300818-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FORGED_RECIPIENTS(0.00)[m:jose.fernandez@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:yonghong.song@linux.dev,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:ben@cressey.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D65596A8FB8


On 6/20/26 8:32 AM, Jose Fernandez (Anthropic) wrote:
> reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
> the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
> return) and only afterwards refcount_set()s rsk_refcnt to 3.
>
> Lockless readers such as __inet_lookup_established() account for this by
> using refcount_inc_not_zero(), but bpf_iter_tcp_established_batch() uses
> plain sock_hold() while holding the bucket lock, on the assumption that
> the lock guarantees sk_refcnt > 0. That assumption does not hold for
> request_sock:
>
>    CPU 0                                CPU 1
>    -----                                -----
>    tcp_conn_request()
>     reqsk_queue_hash_req()
>      inet_ehash_insert(req)
>       spin_lock(bucket)
>       __sk_nulls_add_node_rcu(req)      // rsk_refcnt == 0
>       spin_unlock(bucket)
>                                         bpf_iter_tcp_established_batch()
>                                          spin_lock(bucket)
>                                          sock_hold(req)   <-- addition on 0
>                                          spin_unlock(bucket)
>      refcount_set(&req->rsk_refcnt, 3)  // clobbers saturated value
>
> which surfaces as:
>
>    refcount_t: addition on 0; use-after-free.
>    WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x48/0x90, CPU#1
>    Call Trace:
>     bpf_iter_tcp_established_batch+0x14e/0x170
>     bpf_iter_tcp_batch+0x53/0x200
>     bpf_iter_tcp_seq_next+0x27/0x70
>     bpf_seq_read+0x107/0x410
>     vfs_read+0xb9/0x380
>
> refcount_warn_saturate() then saturates the count, the publishing CPU's
> refcount_set() clobbers it, and the socket is left one reference short.
> When the last legitimate owner drops its reference the reqsk is freed
> while still reachable, leading to use-after-free panics in e.g.
> inet_csk_accept() or inet_csk_listen_stop().
>
> This reproduces in seconds with tcp_syncookies=0, a handful of threads
> doing connect()/close() to a local listener while others read an
> iter/tcp link in a tight loop.
>
> Use refcount_inc_not_zero() and skip the socket on failure, the same way
> every other ehash walker does. The listening hash is unaffected as
> listeners are always inserted into lhash2 with sk_refcnt >= 1, so
> bpf_iter_tcp_listening_batch() is left as-is.
>
> If every matching socket in a bucket is mid-init, end_sk can stay at 0;
> advance to the next bucket in that case rather than terminating the
> whole iteration on a stale batch[0].
>
> Fixes: 04c7820b776f ("bpf: tcp: Bpf iter batching and lock_sock")
> Reviewed-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>


LGTM.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   net/ipv4/tcp_ipv4.c | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6c..92342dcc6892 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3074,25 +3074,25 @@ static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
>   {
>   	struct bpf_tcp_iter_state *iter = seq->private;
>   	struct hlist_nulls_node *node;
> -	unsigned int expected = 1;
> -	struct sock *sk;
> +	unsigned int expected = 0;
> +	struct sock *sk = *start_sk;
>   
> -	sock_hold(*start_sk);
> -	iter->batch[iter->end_sk++].sk = *start_sk;
> -
> -	sk = sk_nulls_next(*start_sk);



Folding the open-coded first *start_sk into the loop is a good
cleanup — it was the one socket that bypassed the refcnt check.


The double-put on the realloc-failure path reported by ai is a separate,
pre-existing issue and can be addressed in a follow-up.



