Return-Path: <netdev+bounces-301661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1N8LFndO2qNeQgAu9opvQ
	(envelope-from <netdev+bounces-301661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:36:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 253146BEAAC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:36:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=HpUn2zPj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301661-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743A53019127
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B223B8920;
	Wed, 24 Jun 2026 13:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208893B635E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:36:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308172; cv=none; b=mCeOUsFniQCsYEL5hvyRwo1ukcruVViIqlSGv9nxMeppUj18AeTPASOXqI0AVV3KnjQhimbh6Zc42sjHvpNhD7YTeosmxLsFU1AJPnGRjF/VP1T8vJ0RWUds4oYqeq2F5n+fyM/V+23LwceJeWmICjVViZ8ZbLwdE38bORM65EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308172; c=relaxed/simple;
	bh=i/PjI4m04aPw0PQLU5HQ2rF0LE8MVaue1ZoAwrK1SYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSi7exNflUKEubvT+OQBtZxC/+95ZkngVyaY1WxfixKZBE4pxIgUf6KmmAetZ6snyS7Rvp7JAe03NjqR2G5Y1aSJrUr1KdvLHq4A9W/8QrD45JHfVuT+ihNGsGliep05wDHgD3FPfS0Xe9Or+kqATYYjjpdvZwBMWVqVejshBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HpUn2zPj; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso1933102a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782308167; x=1782912967; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvxFHr+pWEoc4bhYu8JwbhnPbjylaRVmeM2W41MKswU=;
        b=HpUn2zPjP4mX6UAQRBTOkdF3i/ZQkh+OBP5R9zfZr4UV1ikejir6e27iIYyUjgSoOE
         dydBVdYbDakXnIAcNbvMc34cqvyItyiDGLgHyWZYHJtDf9DtE2KY0rh1VqcQec7BPaQ7
         VO+r1TEbGMNQKxrGX+7HcqyAcfIiuuvNi/7fzx5DKIZqi/sBPKIJDmxbUIX/2+IbgcwX
         kPFggf+LXSmiiQUrgfNAjgv31sEpcUndyONlCE+p2mhtJIQtfUaqhLC6uJUe5A9f1NRe
         vw0/X/Yc2ZSTrTtGxeHoSKuvUYx2yYk5yQJOYr1NbY6f/8kXw3/STbSUZ3WFKpYNolsl
         xCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308167; x=1782912967;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RvxFHr+pWEoc4bhYu8JwbhnPbjylaRVmeM2W41MKswU=;
        b=hrqfmKpB//XtZBGudTnK5EKDnwAB+9USsgeSTv6kH2x/IQdgVbpQjjRDNb08M4OuSs
         8afbZBAUMPX6AW1KZk2bEUXXtWKz6RQv5UzbYwtrt8JY/8WIrVQGSvLeDPaLve74zxZw
         HTBEe9wmFWmmRL8R9O9XoQPd/4YvOGBDY2JFiiaoQPoHKWDYpDRT/eXVVCZTZzYDua0/
         VZKUr37JkTaGKHCjzr7GC6rSGvbv4c6GPHLUM7PZTTjTV8KhY23OP8EH3vHsXT2oxuV5
         ku88Knh5bgTVkIPeSU3mXzm6fNwWvEF96VYK5zU0w7LDH6X1XbC1wMUp+DnnhfuYZ9b2
         waxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob3MHfnwrv7yZdUz9R71899emN+AjkAstw9/T5RabpTfhZEyEsTX5ai0RTPUh2yE1ANvW3qWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLP3KQPcFElAlEFZPd/ELxyn5Hp/M6nxf/9qx1EUsYpdj1uZ3
	jgmTu+5Tjp6app1RKR0YtSMs8svM7SGcD0dJPKSbiQPtuCsfgpKQGu1CgO6vnl2wjTc=
X-Gm-Gg: AfdE7cnRNkXOGymXa4jaN9mfm4PGB6n63euZ4HS0HqcbdFZ6QyYziqvr5CHP10uIcXd
	LiftK7oVzYUgnEWUBe4WgCee0XyG+Tz078DcVTglgSy+zh17WONaD85DY0bWVy8UMcSuKhNpHHy
	AnsohY0KnVfcsPPgc7oD37v8rOLN/M42R+katJbVz8AVXp9bE+gSa0zR3FZltnZCDHfxHC3148S
	4jZYJZmPxq4uSPKBIz2uomFQO577LH0w/XPhirVOaUtbPL8tJjexdjaS+SP+vJLvrAczLef18Jk
	v3buiUSbbXVCLjqn7+y/LO2NokY66COtxL7iMfghTzHOLmwLyhOn60T5ayL6xlXelqAZXnfBYDn
	a4gTGJcm6muar4YFkwjYupMiFEtqYA9Ak56rRNJ1r1V3QeESrIzINz82P9B+KyNOA5n03/HLMyr
	J94qul4clVI4NgWDI=
X-Received: by 2002:a05:6402:1e91:b0:697:de64:ae9a with SMTP id 4fb4d7f45d1cf-697f376fafamr1997570a12.6.1782308167524;
        Wed, 24 Jun 2026 06:36:07 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd36adsm1202161a12.27.2026.06.24.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:36:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Shuah Khan <shuah@kernel.org>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
	(Michal Luczaj's message of "Tue, 23 Jun 2026 20:03:09 +0200")
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
	<20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 24 Jun 2026 15:36:06 +0200
Message-ID: <87wlvoxdq1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301661-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:mid,cloudflare.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 253146BEAAC

On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
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
> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
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
> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  	if (sk->sk_family == AF_INET6)
>  		udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
>  
> +	/* Treat all sockets as non-refcounted, regardless of binding state. */
> +	sock_set_flag(sk, SOCK_RCU_FREE);
> +
>  	sock_replace_proto(sk, &udp_bpf_prots[family]);
>  	return 0;
>  }

There is a side effect that an unhashed (unbound) UDP socket can now be
selected in sk_lookup with bpf_sk_assign. Though perhaps that's for the
better because TC bpf_sk_assign doesn't reject non-refcounted UDP
sockets either, so we would have both socket dispatch sites behave the
same way.

Also, with this patch, if we insert & remove an unhashed UDP socket
into/from a sockmap, we end up with an unhashed non-refcounted UDP
socket. Not entirely sure if that is actually a problem or not.

Willem, what is your take on having unhashed non-refcoted UDP sockets?

