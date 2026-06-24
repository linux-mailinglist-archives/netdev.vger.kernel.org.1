Return-Path: <netdev+bounces-301769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvipEI43PGqSlQgAu9opvQ
	(envelope-from <netdev+bounces-301769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E248E6C1248
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:01:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZwdMobqj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301769-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301769-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E45A301DD22
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99118388E55;
	Wed, 24 Jun 2026 20:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E535F60A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 20:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331273; cv=none; b=mk5tvoCBsuA4iMvRxESMQZQDA8tbIXOGvzpyq5+n5kRRJqZS/6B3MnRgif72AVZbn8a3NQN+Mcx/c8e9IOvo20tJHWpxQ7MMhbC8D6wbmwX8aiJxMVo8Y/xVn1NH1pcOfbt20i02I+h6jqvMkrlBbdx+DvOFfYOeASsE3k5ry2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331273; c=relaxed/simple;
	bh=EKxSlgEBSBkAM5+htBMrWemn3+ErZ8FA7IixhRa/dSI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gCpxx2V44rERmvTqlf2Sy3T9XFFfYszu0CPqyvgHTzcdTkEjc5tP06nur9VMyhUBahwKD5xALHdhJ/8ExoCgfphIhpy5+gN3qf+Ouc016U4VCxT9H3MoKXVDWk9NCNXfQFhMqENKL123v+n1gweiNrfgA2hn1WIeG2hbVEe7h9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwdMobqj; arc=none smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664346e66daso1103972d50.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782331271; x=1782936071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2A8EKBL3N7BN+s6tAkTzPMXNdRY8rqNJI+vtC/7pCo=;
        b=ZwdMobqjUPsGo8LE+n+nM5S8ddB2K481rM2YXvRTlZ505ci9yGifHg+gt5MYNxfMPB
         S+L0gDss0iYi9r1lYUDac8g86JTt+88aGXWL1x2Jpx4WoRWJjOS787sM0YBHvbbJltPx
         yW6t/b1RNv256eGRL47SKNFYsSi3Fno6nU2/FElT8xzozEIOU6w9iOBvw+uMBL/c+Tms
         cGLK26Nya42GtqrkIrO0MEjwvmWcRQUxmLaThPXj9sOKFbT5fZ3rBhRu9v177IUk9OXb
         dRAgQH+mD8GX5N3W0phJvSPehqQExV4MLN43I1JFZvSBXWLA2IgqSmhgtCyt2bicuxXy
         UDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782331271; x=1782936071;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2A8EKBL3N7BN+s6tAkTzPMXNdRY8rqNJI+vtC/7pCo=;
        b=jfxU6pdlty2B/NqbYKDGe1NU4/k6BurhX18a+rWkQJ9Ks4jMFgfdmi1fEs1obpB46L
         VuznJ4iI51VlIPhl9GTpg5JN1Qj0P3UpgBra2FhppmDoyUxbtwsyG/T9xHTla1CSsJkl
         6wqRVXHU0KMzhZqJLs1BcOK/KWphb6e1jsqTttVt7TBjbU7yh1cHyF8dVXQ8P/SmzsrA
         zh//QbrI2+nI+cpRotHPUCcMzX/jrRiNR8q9RiLlGkJOFtLmLMOyD42/cycpPAmCd/ke
         KxjFnu7VmuqbVI8cAplaEhamj216InArh7Tp7YDiL1QPijVZC9QlHq3WhtE/X1wIpLZF
         xMww==
X-Forwarded-Encrypted: i=1; AHgh+RrbxlKw9pmyI8W3e4AjGlASuKg8dcC9yZFOIV5vL/1xpy+xo5v9u1X56Y++BkS/lCHjX7niy4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQrAnbM2wWMjg7EDpkNoP+FNLHrEdoJ7ZGqmT5wzzLpA90rKP
	kjh9Mn+epKQBL8MZDNfyNZ19rosb8NnSgkedbpgrQWLJezETc8bXFmnq
X-Gm-Gg: AfdE7cn5ch6lR+KNW1coesxw+CHeyyRxN/27zvteHxeFzC7svEQfyVs5I4tjYJixKI7
	NSedQSJtT9V/0jZOLJM8FPS9VWtFdmHTeLYqyMQbFf8HtZHSmmflvs3IRHBJxyJ5iB12rQGQ27m
	kLd0/m6ic5l86X+NtinNM6+8l6jy0JrxybYsJSpYdV+Nw38u+TRS6IuHLd93bT/dqfjleSyZPT/
	i/fYDtXl2l+0nG6re5XdMTPej4NR2CLH/C0mTAnRB5urpN4R2NDgBjo9eTF8glrePc+t848bMaa
	5bfiIr/bVKsvGg+7rUo8QqMYVUwg/PtGii0os9pHxwokNiivc9cUjflXgLTIWSe741RwcAemEcd
	iOc5jXjntbElJ/BbNMUhpCny+AyCtpO6Kz8tSVcTmzOpCd13yu6gw6e/wRRLLrTkHusUX4W5JT7
	7CXEgb10hZexmbZEYW8KbqKHHz0bGM6noyBpZWudBQMLTcodu0LA5DAovNEdAx9IZlh/BM
X-Received: by 2002:a05:690e:1909:b0:660:56ee:ebf1 with SMTP id 956f58d0204a3-6636e489415mr4425430d50.22.1782331270986;
        Wed, 24 Jun 2026 13:01:10 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f99b601sm351024d50.20.2026.06.24.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 13:01:10 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:01:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kuniyu@google.com
Message-ID: <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
In-Reply-To: <87wlvoxdq1.fsf@cloudflare.com>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301769-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kuniyu@google.com,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[cloudflare.com,rbox.co,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E248E6C1248

Jakub Sitnicki wrote:
> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
> > UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> > sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
> >
> > Because sockmap accepts unbound UDP sockets, a BPF program can increment a
> > socket's refcount via lookup. If the socket is subsequently bound, the
> > transition from unbound to bound causes bpf_sk_release() to skip the
> > decrement of the refcount, causing a memory leak.
> >
> > unreferenced object 0xffff88810bc2eb40 (size 1984):
> >   comm "test_progs", pid 2451, jiffies 4295320596
> >   hex dump (first 32 bytes):
> >     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
> >     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
> >   backtrace (crc bdee079d):
> >     kmem_cache_alloc_noprof+0x557/0x660
> >     sk_prot_alloc+0x69/0x240
> >     sk_alloc+0x30/0x460
> >     inet_create+0x2ce/0xf80
> >     __sock_create+0x25b/0x5c0
> >     __sys_socket+0x119/0x1d0
> >     __x64_sys_socket+0x72/0xd0
> >     do_syscall_64+0xa1/0x5f0
> >     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Maintain balanced refcounts across sk lookup/release: (re-)set
> > SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> > unbound) as not requiring a refcount increment on (a RCU protected) lookup.
> >
> > Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > ---
> > Note: this issue is related to commit 67312adc96b5 ("bpf: reject unhashed
> > sockets in bpf_sk_assign").
> > ---
> >  net/ipv4/udp_bpf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index ad57c4c9eaab..970327b59582 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> >  	if (sk->sk_family == AF_INET6)
> >  		udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> >  
> > +	/* Treat all sockets as non-refcounted, regardless of binding state. */
> > +	sock_set_flag(sk, SOCK_RCU_FREE);
> > +
> >  	sock_replace_proto(sk, &udp_bpf_prots[family]);
> >  	return 0;
> >  }
> 
> There is a side effect that an unhashed (unbound) UDP socket can now be
> selected in sk_lookup with bpf_sk_assign.

The commit does mention a related fix, beneath the ---, commit
67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
That fixes a similar issue by exactly disallowing this:

    Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
    This matches the behaviour of __inet_lookup_skb which is ultimately
    the goal of bpf_sk_assign().

So ..

> Though perhaps that's for the
> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
> sockets either, so we would have both socket dispatch sites behave the
> same way.

.. there are two conflicting types of consistency here? Consistent with
__inet_lookup_skb or the TC bpf hook. Of those the first is the more
canonical.

> Also, with this patch, if we insert & remove an unhashed UDP socket
> into/from a sockmap, we end up with an unhashed non-refcounted UDP
> socket. Not entirely sure if that is actually a problem or not.
> 
> Willem, what is your take on having unhashed non-refcoted UDP sockets?

I don't immediately see a problem, but I'm not an expert on SOCK_RCU_FREE.


