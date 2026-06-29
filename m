Return-Path: <netdev+bounces-302597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kk15KiRcQmqn5QkAu9opvQ
	(envelope-from <netdev+bounces-302597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D76D9A6E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:51:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Gkk611Jv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302597-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FFD31613F0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D62765D7;
	Mon, 29 Jun 2026 11:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A483BBFD9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:38:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733084; cv=none; b=VsNXidDFtx7Lf7kUFd75c80a4uY9mSrnBJMfSbVNWn9zfjuhn6v666QTn0Esqoc6r+WAf/xkEMAWip4Nt0upzXr/79p9k7iroQV29rkWdrLLSu2NpK5XfGOFDbxUoELRpl3OWKZebM7lqLZYoneQuJVHMGQVm/l1TbHnuQ2nHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733084; c=relaxed/simple;
	bh=hlmaqdyJeKGEvjfmMwcdchUWTlUnrqFhj6hHVaVVdRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXhAJKcHEN0996j1dxTmuKxd2bXzDfV332D2wDL9AvCd65Cymswhm/1sjzEBwM/O1Mqox92AOdWjztNm2iq/Jk1ZDTw0VUTRotakSx5xjYc+gMt++IJVznCQz0ycPDCpAk9zIrjvFdbozbD680/+oR4H7VGsO5HOTrQ57ADfzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gkk611Jv; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1269e4721aso118564166b.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782733081; x=1783337881; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4j0J7ecW2SntxG8Jcu8wz/94ArS1e5wO0N1ClDdsWM=;
        b=Gkk611Jv6oFA/Q0Dw+AmY9jQBJXLxe/qb/Ws8V2rB3CJaQVuTRd7Bs82oHrwF1j7My
         xtufsjTZCUIJwm9QeqOBY+mxkvkvyQOuPk8IgiSDA9jsueDcmacO2c58mprdYpsK5dQJ
         pzOz4BMgAlkbUUTDvB1I0zdopvHtgsHsrG0nzSooYV8V/7Hmf9Xg3Pw0HzOCGtE/Lsbx
         kCumAtwPGgG9Hzhgy31vRBITqtLYzY3kfUvJWrIVHylHDamquuoZH95+u8XVi0bLNEb6
         xxhjeeYODQdqqHBk1ro/SMiQozlRyXtsjPARftMeI4m1b6xBjuKgJl7GHSuIkoG93ifJ
         ZFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733081; x=1783337881;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4j0J7ecW2SntxG8Jcu8wz/94ArS1e5wO0N1ClDdsWM=;
        b=d7OraPy6kNy6/Eo3i4zI3T3YhKTjhhhm7KSbgDNTCECG2dKOQOmgZ2TaV1Cnep9CRt
         VMy6eX9udsanc2+S+zJh+MiubnKoq2oxT1aMho4TIYvdHeXW0sRpQ38Uheh/O3oCb797
         caaZ3LKC4u14NXjtvnQKZMaewnygkFn5W4an0CUh5j5nSDI0ifA08w9tliD2ifJvnjIS
         P/AbzkAynEt8yuHpeMmswSxI9xxfyDj0TCqnkICewIxn6kIRf0AQp5+6IdTsqvpAmgvE
         oxZiBTYUdcYQTSwZPG9me5e+Z7sjBz8+bk0tBZRHRPVr7NeMbxBC0CKwtFO7UmOyGMay
         U5EA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3J3e2NG165GJ7suQf2tc8cbFpREowMFsvLorNZCzxrGDSthSQoum7uVLb2Ft3u3NczK94svo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwzlf+DBshgBhf7BQ/aUsSWokMyUbq91nl61R/zSLwkz3hhxD
	HpDTg+1atNWVsx6jr+v7VKC+KvkFKO+B3F7eToeVqqANjiSUKfD/wOAd7/kCTwSGUOc=
X-Gm-Gg: AfdE7cnW/lzH6kN9iapPdmYQzji8LbIEpGPjaf/EStPOc12LoQqnZlPryGuI3eA+JCW
	QBgUSuAirWsn/OfXuc+7/EpazI5MzxBaDTEutsSTs9i/TdRT7QweVxdfGUZBz6Xn/dWBKChGfAg
	f0Zea6fNJEPhpxYNIg2CEP/TJzHSRn39DTxnvBxwzIXbDh5P87wXRYFlIPA2DGcTsZ/FQ8BAi7C
	daFIXY/D99aDt/QkShH2RUjwzLGORlskyUWHje4I72rWpWhgbbmIH1WsKyUGOfk1kgUQh/q8A3p
	YqqQ12ZlRMs3LCJumS0jXM5fLvs951PQS9ZIVk/AQkd3bL1E6f8jHM+GRQxmocpaz61F/wuUrNk
	pdeVZ5XKvI9cXEblqixsji0+YZKt5xvuJxja3lpyxmOZpdRvmnWXN3G1ToAFGu7aQpgATjVdoQn
	Eh0npldX/DKs8oIlw=
X-Received: by 2002:a17:906:f5a2:b0:bfe:ed06:5a20 with SMTP id a640c23a62f3a-c12061a4554mr955436766b.53.1782733081465;
        Mon, 29 Jun 2026 04:38:01 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1268fdc5b7sm142329066b.30.2026.06.29.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:38:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,
  Jakub Kicinski <kuba@kernel.org>,  Simon Horman <horms@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Cong Wang
 <cong.wang@bytedance.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil
 Tsalapatis <emil@etsalapatis.com>,  Shuah Khan <shuah@kernel.org>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
	(Michal Luczaj's message of "Fri, 26 Jun 2026 22:36:29 +0200")
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
	<20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 29 Jun 2026 13:38:00 +0200
Message-ID: <87pl1937c7.fsf@cloudflare.com>
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
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302597-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,redhat.com,gmail.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,rbox.co:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 145D76D9A6E

On Fri, Jun 26, 2026 at 10:36 PM +02, Michal Luczaj wrote:
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
> Instead of special-casing for refcounted sockets, reject unhashed UDP
> sockets during sockmap updates, as there is no benefit to supporting those.
> This effectively reverts the commit under Fixes, with two exceptions:
>
> 1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
> 2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
>    handler for BPF sockmap usage"), the proto::unhash BPF handler is not
>    reintroduced.
>
> Historical note: this issue is related to commit 67312adc96b5 ("bpf: reject
> unhashed sockets in bpf_sk_assign").
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

