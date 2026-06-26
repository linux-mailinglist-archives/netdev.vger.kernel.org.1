Return-Path: <netdev+bounces-302273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PUe4KYDyPmq0NQkAu9opvQ
	(envelope-from <netdev+bounces-302273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B64496D055B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HcneWN+f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302273-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15203036485
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8993C0A03;
	Fri, 26 Jun 2026 21:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE653BFE41
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 21:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510193; cv=none; b=ixDj3nT/LJKF52TyUkKc0QQG8sR2nzbIVh5Wvr0ZWlGDBNAVpCoI47rc+u3Fc5e/D+W0G+xHO4PbmwhS/zssx4va7u71ssiPDM1u5O09tN+nvxKFdASW23nD4Hm6Jr23IBspvvMo+k2nq5mZLjSzDVG79TV5eUJCV7xS+T9Opm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510193; c=relaxed/simple;
	bh=ojAE35OYkjQ5Ta8z6j4eofFJGg/eZvKv0lvdydmDurE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnc1a5Za396gK5wBXRkguLbvG9MtD6WdDvthOQeZDsP43hhLPYtxndVao5HjBH4zRlDOFdaD6KaJqaSNfcJkwABP0inGkujVf0FI7s8u8OWQU4rGmanHRxgY9O9mCx/xm4GUc+wsXq9aTyf4te3MHyVJw/XFXofD7QPS63y0Joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcneWN+f; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7f11646c3so10801215ad.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782510191; x=1783114991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=87C0TqpdzgkT/i/TbUSL1BACHUANW3mTasT2WjTMKNM=;
        b=HcneWN+fJdEfejOPPPUTcHeKO/vUZ9Guakon5GWvyWePOGM5IErTddkOzEO74lcBHx
         NMpjuWUaCLc5RT9aSkJX7V47104iURHwxtkfu47J/FoLJjdBhh2VfbiK9HHTdGvMXL6J
         tyoNc9aoYgqTe7GZoGjUrQE/Jl0LSE1Nu9WNAtOUgfoYSr0wFyhR2PSMPDzAqPl5Yk8c
         Tlyw/yE+YRcISrKvpDeO7t13k1xHJm19emABGmf3WSY4M7Q6bS7Oiz8lUgvMA9nSeXBS
         B2DODMNF8JmPnEm6z38Eyu3B3/vXIJsLlsuR2dutgKqR2XmgNK5wrxWe3y5IDR5zf8P5
         Z9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510191; x=1783114991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87C0TqpdzgkT/i/TbUSL1BACHUANW3mTasT2WjTMKNM=;
        b=TCiCbKVRxzR4h1IvXnEAFggADzrWt8ft0PjSgMqqyBMqRJvs7ZinQLFhwwe/iK6V6a
         YwWMiIVQ+rDC2qWhnHacdso1ZSkRVc4GvdHe4fobiKWH19rPT6lUgp6uPU5XZThJSeTR
         1Z5yjS5UnQ3aWawlVgw7xECfWlPbxpAe68tsW+x1yEnA16jTdX+JI0XWXfzrbHDCNCXJ
         T2lD293zQvTuSbt00jBKa72UqC7g/1kv2hlt1s0ZHSRCPuxNqJXHt1kwefgL3YGodlxS
         yULXOpa1gMGgDEwQNPvWb72tz8oEpOkrO8qAIjdUIWYNzGeWaK+CBxxwuW8oT7gfbyiR
         OMuA==
X-Forwarded-Encrypted: i=1; AHgh+RqVChHCm9ZuQsRwlwIuITIkCiPv5Kl7QDxXnZpNWJEb2+8kCVzxonY0iapi7PEpQ+hsRjSkbuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/Hspmub5etugnvZ6diTcoLo9fj7e8M9D3MdQAPSXs0kqHYfh
	CN6b7Vq9sNWGo+Yb0tQqSOTiPOAY0eqCUS/NRnxdoGG8Kd55+RFVFXKG
X-Gm-Gg: AfdE7clLdTOxJLHJVafR4g+07oJZ/FqVnxOCziE+QNl6KOMITlWSJgKV79eGCg+11jS
	1futnMKDGC/pM/gg6vITmniK5DQOmqAxHqeINVIjsp4Vx3kDRuxSaHyjaj41ZzZslq41KCCPl3b
	J/UpIkLsNcAA3UHGfJ3P7ftng4S07qQgXxVAORW92+y4PsVmhau3Ken8FVtzzYZ87GyygDlaNZe
	mxkNQDNeLkFhCkTtQ09e+2ITgtM5nkDIwKYv83EZnsOUzeDpN6o576O9+sIpfQWhv1fA4Bgy/hQ
	5eTvrRygew+e7BlAX9kOZ9IiuAjF0EjysexJnfrAnzpPC1/GIAxt2OY1MRt+OGIrr8xaUp6RTyr
	KmIAWnTDnZYf3Kg1PTPausbyJxAbGJXFjrUgBgM6b5RKMef97PgCopnSRMrOSxa3jCLJPUuaffF
	is8amFDz6gBI8=
X-Received: by 2002:a17:902:e78e:b0:2c4:608:167c with SMTP id d9443c01a7336-2c7fc663951mr79432975ad.6.1782510191468;
        Fri, 26 Jun 2026 14:43:11 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae2092sm46078615ad.20.2026.06.26.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:43:10 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:43:08 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
Message-ID: <aj7ySF4F-s4oLaoY@john-p8>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com>
 <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
 <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
 <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
 <87o6gyyjxk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6gyyjxk.fsf@cloudflare.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jakub@cloudflare.com,m:kuniyu@google.com,m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,rbox.co,gmail.com,linux.dev,davemloft.net,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:email,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B64496D055B

On Thu, Jun 25, 2026 at 12:48:55PM +0200, Jakub Sitnicki wrote:
>On Wed, Jun 24, 2026 at 02:39 PM -07, Kuniyuki Iwashima wrote:
>> On Wed, Jun 24, 2026 at 2:33 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>
>>> On Wed, Jun 24, 2026 at 2:26 PM Michal Luczaj <mhal@rbox.co> wrote:
>>> >
>>> > On 6/24/26 22:01, Willem de Bruijn wrote:
>>> > > Jakub Sitnicki wrote:
>>> > >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
>>> > >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>>> > >>> sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.
>>> > >>>
>>> > >>> Because sockmap accepts unbound UDP sockets, a BPF program can increment a
>>> > >>> socket's refcount via lookup. If the socket is subsequently bound, the
>>> > >>> transition from unbound to bound causes bpf_sk_release() to skip the
>>> > >>> decrement of the refcount, causing a memory leak.
>>> > >>>
>>> > >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>>> > >>>   comm "test_progs", pid 2451, jiffies 4295320596
>>> > >>>   hex dump (first 32 bytes):
>>> > >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>>> > >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>>> > >>>   backtrace (crc bdee079d):
>>> > >>>     kmem_cache_alloc_noprof+0x557/0x660
>>> > >>>     sk_prot_alloc+0x69/0x240
>>> > >>>     sk_alloc+0x30/0x460
>>> > >>>     inet_create+0x2ce/0xf80
>>> > >>>     __sock_create+0x25b/0x5c0
>>> > >>>     __sys_socket+0x119/0x1d0
>>> > >>>     __x64_sys_socket+0x72/0xd0
>>> > >>>     do_syscall_64+0xa1/0x5f0
>>> > >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> > >>>
>>> > >>> Maintain balanced refcounts across sk lookup/release: (re-)set
>>> > >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
>>> > >>> unbound) as not requiring a refcount increment on (a RCU protected) lookup.
>>> > >>>
>>> > >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
>>> > >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>

[...]

>Rejecting unhashed UDP sockets on insert to sockmap SGTM.
>It is also in line with disable-problematic-cases strategy.

Agree ACK just disallow it.

