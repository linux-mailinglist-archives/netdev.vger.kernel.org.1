Return-Path: <netdev+bounces-301491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E+DfD2f4OmrPNQgAu9opvQ
	(envelope-from <netdev+bounces-301491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B83146BA3C3
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=XBhaFr3g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301491-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301491-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CE83044128
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E253AF66D;
	Tue, 23 Jun 2026 21:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1A3ACF02
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 21:19:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249555; cv=none; b=m8JN1Dw+8lxe8MSrq9tsS9nRxWtNzKO0DIEyWAp95aCxmOz+UQpPpZSwlPiv8BHQcq3+7RIUqKse52FgnvFgsV8Ocm+imx5eABcufd0Uv9jJVrBAT6BbAxIPKi8cvKFoh/K0Aer41lUHtqkMyvpU9xXn4ch4+5Fazzycyd4UMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249555; c=relaxed/simple;
	bh=wjU+QQV4ZbhrClmDZG0wh2L8aqWrT43sZmShel/LIuw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W8J8v66VSXgYjlWiqs2qI7bjT3+gjoRJKMeYLzZ+NFjcmmUuOOyQWzByfXZWlJvOEOIqWlCz2RDIpB1kAeYCrKftlNGTUSooa2+R2TZk8XXFQaRNK8LAsfkG+Z3ggsQNv7LoYnWJzLBhIv73nKTb+AmK3bJ6+/Y0V4GKLFnIPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XBhaFr3g; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c09f29b64so286699eec.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782249554; x=1782854354; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdxmerIAihadrns5k6AeCU+dX7jwGWrd5Ynsr92j6uE=;
        b=XBhaFr3gRyUgr3akoYHpuKyF/S6FyR4zDIpUJZzvE6L+RDzhxBFzCRRJwJTOViKwQY
         PhaFT5Zqd6w0Q+iFrBhRPwOJljeT1MMiDhc0hYr8NU9vTUYocB7E07KBWxvV0xmwV2u3
         T7Qs0z9mPTehQYRn0OMGK5VcaBu+IFA1Z+VSXOBIVPEfFIKM8Qrl1dHWSY8uqsmksNFT
         xjRxFEsyLMiF1uVFVwAExfQOUZ+FeCSiLuxwhIsQTKlwjIMfJ6TPgDe1dUm9P1zabfqC
         ITJGAmD6MC/4jyWlKnV6eJIH+3VUoztvFNo9N41u6D3kaZAkSZwjS0kMvvwSFKmlS3nz
         D7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249554; x=1782854354;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdxmerIAihadrns5k6AeCU+dX7jwGWrd5Ynsr92j6uE=;
        b=eSv76mPUFVz4jsWbnu/pnzTBxdgLP2fuEZx5YuoyQqF5dnmdTia7KD92cs5JhSkFB1
         7f7rq0qepb1D9oeAg0n3pxJvlIiWsVksT1zpDUuScXc+07bjjMJaRWXw1MBNDe7Yhm1f
         gtS9ebtnOlPAQdvC72+7D961dGB/PXalIeowjecds5h5ciXcFFKuY4WsWchBUoN1DtaY
         SPuYkyr2RmrIXF/ohi0tB6Vt78fstaGYayJEloSgeQaMrQnCQd1axQA4LwIxaECNkBGl
         /aT100eB7aQe+v95tlKLViFg7H1JYM37GXGr2NDMBx/w/OOXhCpcsThF3f60qizBGo+O
         EhZA==
X-Gm-Message-State: AOJu0YyLfnJ3ofsYY+mT4z4BMEVK4WH98p2HinILM3x46NN2q7Uvp6Fe
	RHHm8OY8/64vXjXOM0FcKs7/UnjBpHHCRFGgG0ZFcKNSoJqLcFcW/3oBYfQB1jOhVo4=
X-Gm-Gg: AfdE7cle+7fjHCsD1zHWK4bhZnDklnvQAMSP62qgHEnNEOQLD/eOdIwzrBz3pO1GEVb
	+GMsgS0puMWp2KPC79FcyQ0xzzlo5xYShd6DzizmlBq1iiMVIMJV+/mlqHyZ23HmyN2SGDQ1kSs
	CK2Ix6KZ6jqWueprjYZGm5D05XGO4Z/SbbkC/2EsnTqnuiZs9+lf25YWCqj1nRbneyEmRQqSOE8
	xiOKEiGbLnWdzbMdpvRpDrnb/AoMbfvRBI7PWA8mcPJvcVZxO77XX0YXSqrqw98zIYVdfoF5GET
	jiD8nY498fF2I0X//DHkudVj8yj1yCBApnEv2om3GjN9p9wUvrOoxKxR4xxoDCINZy8LCE86Vt2
	zuYf6vefxgTIquGGL03zcAcrVO20DrQKdKcqkJ+dl5YbdMf9HqlXpnz91aiGO2+X+75DJNQ==
X-Received: by 2002:a05:7301:3e0b:b0:30a:e52f:9b99 with SMTP id 5a478bee46e88-30c553f5be2mr4493143eec.0.1782249553428;
        Tue, 23 Jun 2026 14:19:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm17804817eec.26.2026.06.23.14.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 14:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 17:19:10 -0400
Message-Id: <DJGQQKCPFMSC.19R6QFGHXVMQ5@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Michal Luczaj" <mhal@rbox.co>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Cong
 Wang" <cong.wang@bytedance.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:mhal@rbox.co,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301491-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B83146BA3C3

On Tue Jun 23, 2026 at 2:03 PM EDT, Michal Luczaj wrote:
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =3D fal=
se.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment =
a
> socket's refcount via lookup. If the socket is subsequently bound, the
> transition from unbound to bound causes bpf_sk_release() to skip the
> decrement of the refcount, causing a memory leak.
>
> unreferenced object 0xffff88810bc2eb40 (size 1984):
>   comm "test_progs", pid 2451, jiffies 4295320596
>   hex dump (first 32 bytes):
>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>   backtrace (crc bdee079d):
>     kmem_cache_alloc_noprof+0x557/0x660
>     sk_prot_alloc+0x69/0x240
>     sk_alloc+0x30/0x460
>     inet_create+0x2ce/0xf80
>     __sock_create+0x25b/0x5c0
>     __sys_socket+0x119/0x1d0
>     __x64_sys_socket+0x72/0xd0
>     do_syscall_64+0xa1/0x5f0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Maintain balanced refcounts across sk lookup/release: (re-)set
> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> unbound) as not requiring a refcount increment on (a RCU protected) looku=
p.
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagra=
m sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Note: this issue is related to commit 67312adc96b5 ("bpf: reject unhashed
> sockets in bpf_sk_assign").
> ---
>  net/ipv4/udp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index ad57c4c9eaab..970327b59582 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_p=
sock *psock, bool restore)
>  	if (sk->sk_family =3D=3D AF_INET6)
>  		udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> =20
> +	/* Treat all sockets as non-refcounted, regardless of binding state. */
> +	sock_set_flag(sk, SOCK_RCU_FREE);
> +
>  	sock_replace_proto(sk, &udp_bpf_prots[family]);
>  	return 0;
>  }


