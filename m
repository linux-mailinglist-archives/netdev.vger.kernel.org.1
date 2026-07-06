Return-Path: <netdev+bounces-305234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQM8HKYxTGo6hgEAu9opvQ
	(envelope-from <netdev+bounces-305234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EC7162BA
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 00:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=R1PCSElC;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305234-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305234-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B98305041C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140838B7CD;
	Mon,  6 Jul 2026 22:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABB318EC4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 22:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378250; cv=none; b=aE0yMGrJr+ivzWaJYaoZ5k9vDHd+ZMe53hq2rOb0GwB74gbJVsX6JulbxEYroOv4AO6yG+/Jf4PqwxKZAEWZVuI0QFEHi5+itct+V9Rm5DMy7wW2KVCq+DbYEF29a7GJGtxC2Clc06bsSWHaU+zryZaDS4mHPOqtRY0mFKUzuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378250; c=relaxed/simple;
	bh=4SQ6iNVvvOZW2cmYvz3muDtCp1kUXi6EHpnqLm01IuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E82XAnGSQemo7lnfqrQer2zVYOjgcjjFj37B+y8SaBAwdQyy2tCHk/Qn/z+JpcKVLLL2mBRdJQbhQ1NjUiXI2s0CWQyFFMw1uCJjw6aUSFx0/zih1FmN+HsoMC+V5IGlz/xshqKSihxLejEpGzuCjCtvhiqRCQvGQqnztKG941A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1PCSElC; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8479b7c3adbso6072382b3a.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 15:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783378248; x=1783983048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sV5zgIzwAjP+f/AjnTpHO4CByiDzAfCtpUnBWys2RGg=;
        b=R1PCSElCVgEM99KLEa/r1pmUqBzfiWUM8+ZzRIRSkNYAehQMt1aU+tfSLBwzc8g0IG
         62ClLcXh3fQzdeTXqb7Qfd7t5GN1XYKPFzFuVlTOHg96fD+K+pdpF0PSMoUGADd5T98D
         eiJ8oxKkgQmoE7iy5Ot/D9jOV29haA+77AshIEFoc36Ttn6h3V6OEN9Y3pyrr1ZrGXb2
         DOeF1TmbLadwDzp1FnrtNOokMZGFUfLlb/+oomJVzEtcbLsTqK4p5bSTUQiIbYdHhvfP
         N2g616JE6dKOAfOxzw6f76+B/sH48R3uYG6hZSNWBwb1QI5slroVCpCtW32GJT+rhBTh
         Za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378248; x=1783983048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sV5zgIzwAjP+f/AjnTpHO4CByiDzAfCtpUnBWys2RGg=;
        b=ijxePoBWaiISRvq33fauYDh55NixaZTBxDIxA2BWWlsnILKB1jU0aeHkJqfBjWzUqN
         iKctp7L2FW8h5hqfLbEUaANeAcIJat7APf9S6XyQzSEMQtVLwbCEJKMSl5TyREJhqFSh
         Uj9bMkzIBT0hxG/bB4tCXL7WJqcj8+qJfU/VYchm+S8wjAtG/RdgxH6xCAQOt/Ab4LTG
         7kVsi6/VgrGc0bOsrIoP9uukgPHAvPV2YreYwI9DSQvHDrtmGOTSB3t58F7VqbLJ2Vj2
         036zBdXuW5C9M7QW7tNl22n5q4t4mHetmlaLzMfM/CvopWp9cRCSALCgoT67OjQ8txJk
         16iA==
X-Forwarded-Encrypted: i=1; AHgh+RqaEpcSzy32Rcb7wbO49qE10P37lzulRIUXGacuAH0XOR++oDtrvv3E3jgSodi8QcKvlVJK8W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1vYKdl/PdQxsjT7CwhBJA12dNPsPBeLlKnQ8IbBBSUcNIClX
	j/a4gDFnVY3EyucPBgHg5XEt6yxbv4QVlnaWUjEs8QJkWueQp1xxYk+u+xRAGRRtM8L0W+9SZVp
	GDhYKbQ==
X-Received: from pfble11.prod.google.com ([2002:a05:6a00:4fcb:b0:846:f544:63bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4f:b0:845:e66d:919f
 with SMTP id d2e1a72fcca58-84826bb4c1bmr2477083b3a.12.1783378248168; Mon, 06
 Jul 2026 15:50:48 -0700 (PDT)
Date: Mon,  6 Jul 2026 22:50:33 +0000
In-Reply-To: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706225047.1684039-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
From: Kuniyuki Iwashima <kuniyu@google.com>
To: sdf.kernel@gmail.com
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, mahe.tardy@gmail.com, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305234-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:mahe.tardy@gmail.com,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:song@kernel.org,m:sdfkernel@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E71EC7162BA

From: Stanislav Fomichev <sdf.kernel@gmail.com>
Date: Mon, 6 Jul 2026 14:02:39 -0700
> On 07/06, Mahe Tardy wrote:
> > On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > > On 07/06, Mahe Tardy wrote:
> > > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > > > sending data. This provides a mechanism for BPF programs to emit
> > > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > > socket types with IPPROTO_UDP protocol but could be easily extended to
> > > > SOCK_STREAM and IPPROTO_TCP in the future.
> > > > 
> > > > The API consists of six kfuncs:
> > > > 
> > > >   bpf_ksock_create()   - Create a socket (sleepable)
> > > 
> > > [..]
> > > 
> > > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> > > 
> > > Since you're doing only UDP for now, maybe you don't need bind/connect? The
> > > kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).
> > 
> > Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> > and mostly added the args checks. Another thing is that send is simpler
> > since only used on connected sockets, so you just pass the struct
> > bpf_ksock and data. So on one side it would simplify the current
> > UDP-only API for now by removing the kfuncs but we might need a more
> > complex send kfunc (something like sendto).
> 
> Since you were targeting bpf_netpoll_send_udp originally, maybe sendto
> is a better fit? You get the payload and the destination and you
> bpf_sendto() it? We can later move to stateful bind/connect if needed.
> 
> (mostly coming from the pow of minimizing api exposure initially, but
> not a strong preference)

+1, small start would be better.


> 
> > > 
> > > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > > >   bpf_ksock_release()  - Release a reference (cleanup via
> > > >                          queue_rcu_work since sock_release sleeps)
> > > > 
> > > > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > > > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > > > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > > > programs.
> > > > 
> > > > The implementation follows the established kfunc lifecycle pattern
> > > > (create/acquire/release with refcounting, kptr map storage, dtor
> > > > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > > > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > > > may sleep.
> > > > 
> > > > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > > > specifically support AF_INET and AF_INET6 sockets.
> > > > 
> > > > The socket operations go through the expected LSM hooks instead of
> > > > by-passing them like many kernel sockets since those are created by BPF
> > > > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > > > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > > > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > > > asynchronous workqueue as the current value would then be invalid.
> > > 
> > > [..]
> > > 
> > > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > > kernel sockets that may exist in each network namespace. Out of
> > > > simplicity for now, the settings is host wide but the counters are per
> > > > network namespace.
> > > 
> > > What is this guarding against? Rogue bpf programs creating too many sockets?
> > 
> > Yes. AI review raised this because users are prevented from creating too
> > many sockets by bumping against the max number of fd and this would
> > allow them to create way more sockets. I kind of agreed that having "a
> > limit" on resource creation would make sense but maybe it doesn't and we
> > can simplify this!
> 
> I believe even the kernel sockets go via lsm layer, so this enforcement
> can be done in an lsm bpf program. Seems like that should be enough?

Right, I don't think the per-netns limit is useful for CAP_BPF users.

