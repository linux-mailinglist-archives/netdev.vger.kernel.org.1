Return-Path: <netdev+bounces-216735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1FB3502A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC57201054
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAEC21883F;
	Tue, 26 Aug 2025 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3tClbnK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB791FF1C7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167854; cv=none; b=fO4DXGr8MTkcv5tf8BLgTHFkMbAaOh6HF6Byc0aAzwTlsEwy1NXXVImN8FTrBxEhPfNESrK+aQl3ptMM64zFCUHXhLROhU4z+S4XQRRKKGe9jx5zSVdy1jRffjNWl7IvnimMUQ5VIis7Vyb12IdwU4eCFriJT3CbWHy2xILxlnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167854; c=relaxed/simple;
	bh=PPuq2LaTPZ2Kq+dIBU8MAqHySuEzTVDZmGzuekpTMGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RD2X58PI0u2XWuSaVOR6JAhJeLLARQE3QOMPsyWaMcMHRL7TCh0npAaHmUQBAVKNOsLCg7iLtlXgRFLV5BR88AUPoKiwZ+QcJYMzde4+8kuBtmnxEcwG344BhTpa8V4T9gvk4pXz73bdipJ8N9cESS8PxO2iwCL6qWQ1uBAozEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3tClbnK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32749ac0a1eso40002a91.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756167852; x=1756772652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOBtZ7lsc6acNC62BdnE/bcdWxe4f0AQVDZ0h0RytCY=;
        b=g3tClbnKRTOotHhZSgZhgRXWltsF0viQk2d26xWjsHrT7GLwiD6tz6S8zb2GvIOYPp
         HNKSPv7sngCNDDOJKkifj2FITYRr+Ja8YA02hlPNJyLTjqsxw/k+4uVWRbXhSQHNxgfd
         RSRcUwK3SEzahzI0xPZm8R1r/pQS00yyJfm4tBvqQQNZtdAei4DOHRzswFOjFY9tAIM7
         I0IBet5OS4vSL7Qf7Fc9u8bNi10+LBJs2hf5ZE6VvKfxfs3tKViJsid2v26HH2iefPNx
         8BwDx0C331l5m6X81i1n/9OlgzVTMrnk66wAKxPocbSX17NxmZUvGk3oR1o8RVRMuElV
         eUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756167852; x=1756772652;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VOBtZ7lsc6acNC62BdnE/bcdWxe4f0AQVDZ0h0RytCY=;
        b=pai4j5IhNUFDs0bZwumdZncYa9LHopWptyZwGATsWCF+OfEgHegoE0hNM85HbaUnMH
         tcRFFmAw/BScaePJ1gSP+zYhzzDk67INm30TOd44SVLzFqj9YNw1+xgA6PYH2J9Tt7L0
         Vt2lNvEYCEDDpLZNAPXFQpUwyWVx5vOVFLPQcUuhv3pfpvKkpggzejEdDC7BR3FcZcyE
         LnvK6Ao1Cev3VxTEKQuBCOkK+XBRzDTxxYpGJ1RySxWxMLhb8+iIgreIAVeaRBtv3bJ3
         i1HoBT03DIUlmFpQR6E5JyxxpPO/oCtSnoS4Jj8JXRgFcFVxwznVTAUjZCTOo53zkFki
         9XkA==
X-Forwarded-Encrypted: i=1; AJvYcCXgAtyYw4vXwMdSzE0C5PYL6TreQk5eEpZS2CuU2gHkQ4pKt0q8J/DElBxK5SmdF3TUWwN4pFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/tq8gFSCTsJ4gHYgtrJgPc+ch07Q5K8q19ozhaIE/234H59N
	4B6qSptnXdMsCUxCkT59oURFkVwfRf1Y9PRABACEbPX9BePGY3xs0DZSU1og6peDUVPgZl38PQz
	vGyK0Dw==
X-Google-Smtp-Source: AGHT+IGBWI85n2wonmWGyA2qKlDhvgemyEgdU9aAQ5VZxWmyKpfaEgnkR3hnTPbhC3zo1N61CKbPQHNqYzg=
X-Received: from pjad16.prod.google.com ([2002:a17:90a:1110:b0:325:4747:a99b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:258c:b0:325:11d1:1fb
 with SMTP id 98e67ed59e1d1-32515ee12ffmr18088663a91.6.1756167852010; Mon, 25
 Aug 2025 17:24:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:23:39 +0000
In-Reply-To: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826002410.2608702-1-kuniyu@google.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: martin.lau@linux.dev
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, mhocko@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	roman.gushchin@linux.dev, sdf@fomichev.me, shakeel.butt@linux.dev, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Mon, 25 Aug 2025 16:14:35 -0700
> On 8/25/25 11:14 AM, Kuniyuki Iwashima wrote:
> > On Mon, Aug 25, 2025 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
> >>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >>> index ae83ecda3983..ab613abdfaa4 100644
> >>> --- a/net/ipv4/af_inet.c
> >>> +++ b/net/ipv4/af_inet.c
> >>> @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct so=
cket *newsock, struct sock *new
> >>>                kmem_cache_charge(newsk, gfp);
> >>>        }
> >>>
> >>> +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
> >>> +
> >>>        if (mem_cgroup_sk_enabled(newsk)) {
> >>>                int amt;
> >>>
> >>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linu=
x/bpf.h
> >>> index 233de8677382..80df246d4741 100644
> >>> --- a/tools/include/uapi/linux/bpf.h
> >>> +++ b/tools/include/uapi/linux/bpf.h
> >>> @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
> >>>        BPF_NETKIT_PEER,
> >>>        BPF_TRACE_KPROBE_SESSION,
> >>>        BPF_TRACE_UPROBE_SESSION,
> >>> +     BPF_CGROUP_INET_SOCK_ACCEPT,
> >>
> >> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit=
 be
> >> inherited from the listener?
> >=20
> > Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
> > accept() because the child socket could be created during irq context w=
ith
> > unrelated cgroup.  This had another reason; if the listener was created=
 in the
> > root cgroup and passed to a process under cgroup, child sockets would n=
ever
> > have sk_memcg if sk_memcg was inherited.
> >=20
> > So, the child's memcg is not always the same one with the listener's, a=
nd
> > we cannot rely on the listener's sk_memcg.
>=20
> I didn't mean to inherit the entire sk_memcg pointer. I meant to only inh=
erit=20
> the SK_BPF_MEMCG_SOCK_ISOLATED bit.

I didn't want to let the flag remain alone without accept() (error-prone
but works because we always check mem_cgroup_from_sk() before the bit)
and wanted to check mem_cgroup_sk_enabled() in setsockopt(), but if we
don't care, it will be doable with other hooks, PASSIVE_ESTABLISHED_CB
or bpf_iter etc.

---8<---
diff --git a/net/core/filter.c b/net/core/filter.c
index a78356682442..9ef458fe706e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5269,7 +5269,7 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk, c=
har *optval, bool getopt)
=20
 static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bool g=
etopt)
 {
-	if (!mem_cgroup_sk_enabled(sk))
+	if (!sk_has_account(sk))
 		return -EOPNOTSUPP;
=20
 	if (getopt) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e92dfca0a0ff..efae15d04306 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -760,7 +760,10 @@ void __inet_accept(struct socket *sock, struct socket =
*newsock, struct sock *new
 	if (mem_cgroup_sockets_enabled &&
 	    (!IS_ENABLED(CONFIG_IP_SCTP) ||
 	     sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
+		unsigned short flags =3D mem_cgroup_sk_get_flags(newsk);
+
 		mem_cgroup_sk_alloc(newsk);
+		mem_cgroup_sk_set_flags(newsk, flags);
 		kmem_cache_charge(newsk, gfp);
 	}
=20
---8<---


>=20
> If it can only be done at accept, there is already an existing=20
> SEC("lsm_cgroup/socket_accept") hook. Take a look at=20
> tools/testing/selftests/bpf/progs/lsm_cgroup.c. The lsm socket_accept doe=
sn't=20
> have access to the "newsock->sk" but it should have access to the "sock->=
sk", do=20
> bpf_setsockopt and then inherit by the newsock->sk (?)
>=20
> There are already quite enough cgroup-sk style hooks. I would prefer not =
to add=20
> another cgroup attach_type and instead see if some of the existing ones c=
an be=20
> reused. There is also SEC("lsm/sock_graft").

We need to do fixup below, so lsm_cgroup/socket_accept won't work
if we keep the code in __inet_accept().  We can move this after
lsm/sock_graft within __inet_accept().

if (mem_cgroup_sk_isolated(newsk))
	sk_memory_allocated_sub(newsk, amt);

But then, we cannot distinguish it with other hooks (lock_sock() &&
sk->sk_socket !=3D NULL), and finally the fixup must be done dynamically
in setsockopt().

But I didn't want to place that in setsockopt() to avoid caring about
weird scenario that introduces unnecessary complexity.

e.g. bpf_setsockopt() fixes up once and a new data comes in before
accept() and we need to handle another fixup in accept() or close(),
in the latter case, we need to check the bit only even if sk_memcg
itself is NULL.

