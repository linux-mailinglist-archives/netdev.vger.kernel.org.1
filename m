Return-Path: <netdev+bounces-301935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JarMmwIPWqTwAgAu9opvQ
	(envelope-from <netdev+bounces-301935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:52:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B66C4DDB
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=Wfwq5q4q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301935-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C189D306FC06
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7812459C5;
	Thu, 25 Jun 2026 10:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783B329E46
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:48:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384541; cv=none; b=PZv5R4c0B8pH+37ghAie99jdQbrEO90JraT6EDzYcg1aMcwmA0tD2jO7bslDTfr8u3Wh4NdCxa7iHwO0uKubiDDuyptBcb80itMVXihDHUIh+Czq21EBSnwYghNVQ178oIbBRL5ZN89E/BzGdX3yBLDYw//mcDwc7KO0mZlBvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384541; c=relaxed/simple;
	bh=Ps2PqFYe0uSu8kMn+2yUb7YCUrEj5lUz/Jd3hDbXnNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f73I3S6eh8DTueBQ6TToRpLu9FsyvoTuNa2VwjftG3nSu20RoHU8LwKcT5W1ONeDSjMJ+xeCeGX70fKIJK4GE0N4dELd5HjQQOl3KvJW3WAT3oI2j4HJJPk3Kkwr8nOpEQmfSK0a8/YUXKhTn+UO3dM84dT8dZMnJnFukeXwZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wfwq5q4q; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c0d6c75c58cso30169666b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782384537; x=1782989337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhnTEE3eR7tyCRGO7cEDK/PBoNBoXGQu9h1tWf3iFxw=;
        b=Wfwq5q4qdayb+YXK0COgNQ2Ux8sKEDn7v+K7FL2AbxFLROD9uVGJ0IrJIT0ZZZXExW
         jdUSDZbz+aFUR+Eycmh3EZ5WwGMIOFf7WsfURBpfHixqwVqIFvaKryxh3CBCkTaZzIl6
         KH+VObJOTcwPTRIAdogLRy3FnC3JXudHFYHh/g3xjZ3jOYj8BRdD+6PIkJb1+EobDmfP
         2Zzu0zfy9C2pJ1wnYBU0k5ZBbQ1QsRiESjXFEO9SJ77+nhMHOv50zuHEkhQQ9V6XbUaQ
         InCv6e0HSqaZd/RWI93UQK/m33dn8ns+34dxE3StIGhktRQvlbN20v/8vfrUtjXd27G+
         PVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782384537; x=1782989337;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhnTEE3eR7tyCRGO7cEDK/PBoNBoXGQu9h1tWf3iFxw=;
        b=fDGGcBXD9SHQ6Rrgefn3eDUGJY8xTByKWO9PttSV1iSpXKee0GjVMAPtbRd5N5WTge
         CJDng+4b6G/rp7ybPMqcc6yXCsAAoNnxXbNAfzo/ais5PmXUFRZDY8BanBYyy8PMk4B0
         kDklq1Kp4eQ8qwucZgNgnU7mWHw9Zi2ALOI6j01mNvTJWPborPAqU1zAzDSpHu3oCMat
         GcN9nY8Dtj2Zo9QgbTt1G82ODmq9TS6XBy6euZPxBaW5GJlH/o0Sc+iFUCIFOVfqujcN
         0mF8/XY4KgZVIGWKWRNon+rxOEV6EBvpOYUNc4t5wmgNDsHgJz9alZeBHjW7fEzDuX2T
         g7Og==
X-Forwarded-Encrypted: i=1; AHgh+RrkLmrx9bEeQRZfsbl+HQZuSjIpDZyD65UwNuTAYI46fiQzTBV3lV9FrxH803V9yeaVvw444SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqir3RPnazRPyYPJ7XMUfFfGVJuxV9QJ8OSToBnXAi/Zymdb0
	r3cibkDY8bfr6GPi5C6VfMr4yzvdmurqNOssn4IIxkopI04+SZD+N/NUa+LkcJ4hUTQ=
X-Gm-Gg: AfdE7cmmlZqroCVgDLX/N4q9gnGQ5wfQYitmwCL1j9c97VEcosSuGhjdjQ4gW3ozmeg
	8o8JHpSSDxHMIQ1/Srwi+x+WMl2fou4AV4ZglnGiN5Mc5Hr7VhCGlA9ppftNUj24fspzobKXPRE
	UEqLI5+usI55g4x2qC8Jep22JBkNwptOBmtSgvoPPk29VKmTRSC9qmBSbmCvErE2sQzcjR7WhZj
	CzZmltNEqr7sCXfYWrI1qLWnyiOAyP7NFzeNsOUyeps6xj9vAK6DIH5jrW/d4L6ZTw2mSznr8sJ
	DEMTm5lJzW++PwUELQmPuiIJW0o3kl8DDLUq3djh8HH6VUngpW3kZOKFbRO+zWLz6ThPthBJcQr
	gG7CdnKTdqRFjADIIz7IrwCVHhggoA54vKZktB6r4JdqNN5tnQCVbFCmZtdsmqU3ug2zMIy/5p9
	lnhindLRZHZ7NcOC0=
X-Received: by 2002:a17:907:dab:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-c1205e1fe84mr141629266b.20.1782384536940;
        Thu, 25 Jun 2026 03:48:56 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba862asm158442066b.9.2026.06.25.03.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:48:56 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Michal Luczaj <mhal@rbox.co>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  John Fastabend
 <john.fastabend@gmail.com>,  Jiayuan Chen <jiayuan.chen@linux.dev>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei Starovoitov
 <ast@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
In-Reply-To: <CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Wed, 24 Jun 2026 14:39:35 -0700")
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
	<20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
	<87wlvoxdq1.fsf@cloudflare.com>
	<willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
	<dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
	<CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
	<CAAVpQUAy=EVZcZRmXJPr=neJh7Q+UbYML5L4+nBynVrDPidUkw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 25 Jun 2026 12:48:55 +0200
Message-ID: <87o6gyyjxk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:mhal@rbox.co,m:willemdebruijn.kernel@gmail.com,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[rbox.co,gmail.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:mid,cloudflare.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9B66C4DDB

On Wed, Jun 24, 2026 at 02:39 PM -07, Kuniyuki Iwashima wrote:
> On Wed, Jun 24, 2026 at 2:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
>>
>> On Wed, Jun 24, 2026 at 2:26=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wro=
te:
>> >
>> > On 6/24/26 22:01, Willem de Bruijn wrote:
>> > > Jakub Sitnicki wrote:
>> > >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
>> > >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
>> > >>> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =
=3D false.
>> > >>>
>> > >>> Because sockmap accepts unbound UDP sockets, a BPF program can inc=
rement a
>> > >>> socket's refcount via lookup. If the socket is subsequently bound,=
 the
>> > >>> transition from unbound to bound causes bpf_sk_release() to skip t=
he
>> > >>> decrement of the refcount, causing a memory leak.
>> > >>>
>> > >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
>> > >>>   comm "test_progs", pid 2451, jiffies 4295320596
>> > >>>   hex dump (first 32 bytes):
>> > >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  .............=
...
>> > >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@.........=
...
>> > >>>   backtrace (crc bdee079d):
>> > >>>     kmem_cache_alloc_noprof+0x557/0x660
>> > >>>     sk_prot_alloc+0x69/0x240
>> > >>>     sk_alloc+0x30/0x460
>> > >>>     inet_create+0x2ce/0xf80
>> > >>>     __sock_create+0x25b/0x5c0
>> > >>>     __sys_socket+0x119/0x1d0
>> > >>>     __x64_sys_socket+0x72/0xd0
>> > >>>     do_syscall_64+0xa1/0x5f0
>> > >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> > >>>
>> > >>> Maintain balanced refcounts across sk lookup/release: (re-)set
>> > >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
>> > >>> unbound) as not requiring a refcount increment on (a RCU protected=
) lookup.
>> > >>>
>> > >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for =
datagram sockets")
>> > >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> > >>> ---
>> > >>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject u=
nhashed
>> > >>> sockets in bpf_sk_assign").
>> > >>> ---
>> > >>>  net/ipv4/udp_bpf.c | 3 +++
>> > >>>  1 file changed, 3 insertions(+)
>> > >>>
>> > >>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>> > >>> index ad57c4c9eaab..970327b59582 100644
>> > >>> --- a/net/ipv4/udp_bpf.c
>> > >>> +++ b/net/ipv4/udp_bpf.c
>> > >>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, stru=
ct sk_psock *psock, bool restore)
>> > >>>     if (sk->sk_family =3D=3D AF_INET6)
>> > >>>             udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
>> > >>>
>> > >>> +   /* Treat all sockets as non-refcounted, regardless of binding =
state. */
>> > >>> +   sock_set_flag(sk, SOCK_RCU_FREE);
>> > >>> +
>> > >>>     sock_replace_proto(sk, &udp_bpf_prots[family]);
>> > >>>     return 0;
>> > >>>  }
>> > >>
>> > >> There is a side effect that an unhashed (unbound) UDP socket can no=
w be
>> > >> selected in sk_lookup with bpf_sk_assign.
>> > >
>> > > The commit does mention a related fix, beneath the ---, commit
>> > > 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
>> > > That fixes a similar issue by exactly disallowing this:
>> > >
>> > >     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
>> > >     This matches the behaviour of __inet_lookup_skb which is ultimat=
ely
>> > >     the goal of bpf_sk_assign().
>> > >
>> > > So ..
>> > >
>> > >> Though perhaps that's for the
>> > >> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
>> > >> sockets either, so we would have both socket dispatch sites behave =
the
>> > >> same way.
>> > >
>> > > .. there are two conflicting types of consistency here? Consistent w=
ith
>> > > __inet_lookup_skb or the TC bpf hook. Of those the first is the more
>> > > canonical.
>> > >
>> > >> Also, with this patch, if we insert & remove an unhashed UDP socket
>> > >> into/from a sockmap, we end up with an unhashed non-refcounted UDP
>> > >> socket. Not entirely sure if that is actually a problem or not.
>> > >>
>> > >> Willem, what is your take on having unhashed non-refcoted UDP socke=
ts?
>> > >
>> > > I don't immediately see a problem, but I'm not an expert on SOCK_RCU=
_FREE.
>> >
>> > Perhaps it's worth mentioning that unhashed non-refcounted UDP socket =
is
>> > already possible: first auto-bind via connect(AF_INET) (which also sets
>> > SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).
>>
>> Setting SOCK_RCU_FREE itself should not cause a problem, but I think
>> we should take a step back.
>>
>> AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
>> into sockmap, not to allow using unconnected UDP sockets in sk_lookup et=
c.
>>
>> Actually, v4 of the patch was implemented as such but did not get any fe=
edback,
>> https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.=
com/#t
>>
>> ... and v5 (the final commit) somehow removed the restriction for unconn=
ected
>> UDP socket as well.
>> https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.=
com/
>>
>> Given the initial use case, sockmap redirect, is still blocked by
>> TCP_ESTABLISHED
>> check in sock_map_redirect_allowed(), I feel there is no point in suppor=
ting
>> unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
>> (without buggy sk_lookup).
>
> s/unconnected/unhashed/g :)

Rejecting unhashed UDP sockets on insert to sockmap SGTM.
It is also in line with disable-problematic-cases strategy.

