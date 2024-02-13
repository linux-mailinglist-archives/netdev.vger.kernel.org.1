Return-Path: <netdev+bounces-71343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DF853077
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB5D1F28B5D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0753D54D;
	Tue, 13 Feb 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgVELclO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02B43AD1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827067; cv=none; b=d++NKhhamxDiRjrU0ZT+mKe6zPzUELoOwCnvv9frmDpQV1nt8V5Hcz3DvYhOjJkNnty0ckZF4is/H8hv+fbCZDRsRYr5K+O4sCSuOvGLVmccefmFItLaBMnbO2wJ/ag4n9/FVfzgUwJg8nNUdquNr7LuqatOiysb/M1uL/JkPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827067; c=relaxed/simple;
	bh=gMjcVfvFqkhk+9MZYM6JIe8vGqmGK1MFNHV+HcU1mE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5su7+wA1J92W4eAP7d6pHTnNItvmiuxF9YN6MjiOdLGJNs2NJAeYW88Fg5zdZIcz1WUaH2QgfePSrr8nF2sRR1y2pNd8HJHByJy+LGL8/YWGO57ixiUF41a/7BGZvJe8aVjeRidr9CvHdSgmvJXAupR6Qs8MQ68GWjBvOESMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgVELclO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso8191a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707827063; x=1708431863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ST4HsRTSQGGHe/8wtHnxbc4k3ENKew4mrzP3O6ekKg=;
        b=QgVELclO+s9ScvVS+CkNKQDmPJ4gv2Dj9ZtmFH8N3qoD49OFHx18VsGSWBZfgBr2c/
         oxJrLtCyHD7IRVwwot053fD6aZN6vSv9btUS7jSXm8T0tF+gTSSxVq93jjnxcjzTjvHJ
         K9Z/1bOKEtfQnVmiagNrhpsvDeqAMr8mCJ30fhvhJxSRtPIL/JhD1PFY7wIY8PpgrqIr
         SZmG+bkk1l0kvDahvWDQhiB76ckFrJURq75VZLI22Pxt+Zd3jObAU7OmwVc7vOzRdEed
         R+vmfduWe8KQNyyDgNm86PBa2s/INNA4PE5/IV1Nkolv2F6VrgQYmj9ilJqq6Xm8Pybb
         mWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827063; x=1708431863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ST4HsRTSQGGHe/8wtHnxbc4k3ENKew4mrzP3O6ekKg=;
        b=VcGO7cq7bMxyf21cLEUk37obkBMbDZFG/DEug2kmOJ+Fc0bj2fbgPHqs3+SKqAG1xg
         va8GDMDe79iyeXzIipKXkj356U2k31RfmS5z2G2hAbDQYr69AR9LRO0s18djvb1lB/5Q
         FiPzBEHi2F5E1CUCDNm97sJp1e9V8jN1ME9OprNgrzPTkuCIpJ1V5Hab8f9uOR+CmoRn
         dzpjTVKIMtrOdfWgAMR8dvXjxq2LZ+By4hQlyKUUrDCYekn3cfSe+uvMknFAonaYKMbf
         Q89LRKCzmT2NEM5dPpTNLdW8lB/zxD/FIs+saPUZUk/AGBdp8Lq8an1H15djkCj0wmFI
         Hglg==
X-Forwarded-Encrypted: i=1; AJvYcCWIvUojHK6gXZwaOyNk4aFP77LCe7GVyT2GaxKCK9wtu75sYqPK1+EAaXqwJoFwGSbT12UuFwRFDTJFQRvWkigKueYGiBmf
X-Gm-Message-State: AOJu0YxcAgOVMRx1/t593DMoiRGDrWJOBtKp9sLGTrdntDNa3uQZBrC8
	pYriTH+1zFI7BxOygtsP+RiimaygfBDkmd9IenT2/MzQslsLzvpPma1GimPqeiZrbgms6dDauju
	W9v3sfpdkD/fSnZF6TC9lDZsx03vE/mP2A1VO2YDgmtWFrUmhGOG4
X-Google-Smtp-Source: AGHT+IEEk8i34t4IIaHLuADvQ6bIc/V6sdm5SSDqjOv43NGGebnZi+E8L5kbdmjHcuwBKxGpErfGRmA1rqvH2M0Rh3c=
X-Received: by 2002:a50:cc96:0:b0:560:ea86:4d28 with SMTP id
 q22-20020a50cc96000000b00560ea864d28mr140644edi.4.1707827062901; Tue, 13 Feb
 2024 04:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
In-Reply-To: <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 13:24:09 +0100
Message-ID: <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, jmaloy@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Oops,
>
> I just noticed Eric is missing from the recipients list, adding him
> now.
>

Hmmm thanks.

> On Fri, 2024-02-09 at 17:12 -0500, jmaloy@redhat.com wrote:
> > From: Jon Maloy <jmaloy@redhat.com>
> >
> > When reading received messages from a socket with MSG_PEEK, we may want
> > to read the contents with an offset, like we can do with pread/preadv()
> > when reading files. Currently, it is not possible to do that.
> >
> > In this commit, we add support for the SO_PEEK_OFF socket option for TC=
P,
> > in a similar way it is done for Unix Domain sockets.
> >
> > In the iperf3 log examples shown below, we can observe a throughput
> > improvement of 15-20 % in the direction host->namespace when using the
> > protocol splicer 'pasta' (https://passt.top).
> > This is a consistent result.
> >
> > pasta(1) and passt(1) implement user-mode networking for network
> > namespaces (containers) and virtual machines by means of a translation
> > layer between Layer-2 network interface and native Layer-4 sockets
> > (TCP, UDP, ICMP/ICMPv6 echo).
> >
> > Received, pending TCP data to the container/guest is kept in kernel
> > buffers until acknowledged, so the tool routinely needs to fetch new
> > data from socket, skipping data that was already sent.
> >
> > At the moment this is implemented using a dummy buffer passed to
> > recvmsg(). With this change, we don't need a dummy buffer and the
> > related buffer copy (copy_to_user()) anymore.
> >
> > passt and pasta are supported in KubeVirt and libvirt/qemu.
> >
> > jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> > SO_PEEK_OFF not supported by kernel.
> >
> > jmaloy@freyr:~/passt# iperf3 -s
> > -----------------------------------------------------------
> > Server listening on 5201 (test #1)
> > -----------------------------------------------------------
> > Accepted connection from 192.168.122.1, port 44822
> > [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 4=
4832
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec  1.02 GBytes  8.78 Gbits/sec
> > [  5]   1.00-2.00   sec  1.06 GBytes  9.08 Gbits/sec
> > [  5]   2.00-3.00   sec  1.07 GBytes  9.15 Gbits/sec
> > [  5]   3.00-4.00   sec  1.10 GBytes  9.46 Gbits/sec
> > [  5]   4.00-5.00   sec  1.03 GBytes  8.85 Gbits/sec
> > [  5]   5.00-6.00   sec  1.10 GBytes  9.44 Gbits/sec
> > [  5]   6.00-7.00   sec  1.11 GBytes  9.56 Gbits/sec
> > [  5]   7.00-8.00   sec  1.07 GBytes  9.20 Gbits/sec
> > [  5]   8.00-9.00   sec   667 MBytes  5.59 Gbits/sec
> > [  5]   9.00-10.00  sec  1.03 GBytes  8.83 Gbits/sec
> > [  5]  10.00-10.04  sec  30.1 MBytes  6.36 Gbits/sec
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-10.04  sec  10.3 GBytes  8.78 Gbits/sec   receiver
> > -----------------------------------------------------------
> > Server listening on 5201 (test #2)
> > -----------------------------------------------------------
> > ^Ciperf3: interrupt - the server has terminated
> > jmaloy@freyr:~/passt#
> > logout
> > [ perf record: Woken up 23 times to write data ]
> > [ perf record: Captured and wrote 5.696 MB perf.data (35580 samples) ]
> > jmaloy@freyr:~/passt$
> >
> > jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
> > SO_PEEK_OFF supported by kernel.
> >
> > jmaloy@freyr:~/passt# iperf3 -s
> > -----------------------------------------------------------
> > Server listening on 5201 (test #1)
> > -----------------------------------------------------------
> > Accepted connection from 192.168.122.1, port 52084
> > [  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 5=
2098
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-1.00   sec  1.32 GBytes  11.3 Gbits/sec
> > [  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
> > [  5]   2.00-3.00   sec  1.26 GBytes  10.8 Gbits/sec
> > [  5]   3.00-4.00   sec  1.36 GBytes  11.7 Gbits/sec
> > [  5]   4.00-5.00   sec  1.33 GBytes  11.4 Gbits/sec
> > [  5]   5.00-6.00   sec  1.21 GBytes  10.4 Gbits/sec
> > [  5]   6.00-7.00   sec  1.31 GBytes  11.2 Gbits/sec
> > [  5]   7.00-8.00   sec  1.25 GBytes  10.7 Gbits/sec
> > [  5]   8.00-9.00   sec  1.33 GBytes  11.5 Gbits/sec
> > [  5]   9.00-10.00  sec  1.24 GBytes  10.7 Gbits/sec
> > [  5]  10.00-10.04  sec  56.0 MBytes  12.1 Gbits/sec
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval           Transfer     Bitrate
> > [  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec  receiver
> > -----------------------------------------------------------
> > Server listening on 5201 (test #2)
> > -----------------------------------------------------------
> > ^Ciperf3: interrupt - the server has terminated
> > logout
> > [ perf record: Woken up 20 times to write data ]
> > [ perf record: Captured and wrote 5.040 MB perf.data (33411 samples) ]
> > jmaloy@freyr:~/passt$
> >
> > The perf record confirms this result. Below, we can observe that the
> > CPU spends significantly less time in the function ____sys_recvmsg()
> > when we have offset support.
> >
> > Without offset support:
> > ----------------------
> > jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
> >                        -p ____sys_recvmsg -x --stdio -i  perf.data | he=
ad -1
> > 46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____=
sys_recvmsg
> >
> > With offset support:
> > ----------------------
> > jmaloy@freyr:~/passt$ perf report -q --symbol-filter=3Ddo_syscall_64 \
> >                        -p ____sys_recvmsg -x --stdio -i  perf.data | he=
ad -1
> > 28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____=
sys_recvmsg
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> >
> > ---
> > v3: - Applied changes suggested by Stefano Brivio and Paolo Abeni
> > ---
> >  net/ipv4/af_inet.c |  1 +
> >  net/ipv4/tcp.c     | 16 ++++++++++------
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index 4e635dd3d3c8..5f0e5d10c416 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -1071,6 +1071,7 @@ const struct proto_ops inet_stream_ops =3D {
> >  #endif
> >       .splice_eof        =3D inet_splice_eof,
> >       .splice_read       =3D tcp_splice_read,
> > +     .set_peek_off      =3D sk_set_peek_off,
> >       .read_sock         =3D tcp_read_sock,
> >       .read_skb          =3D tcp_read_skb,
> >       .sendmsg_locked    =3D tcp_sendmsg_locked,
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 7e2481b9eae1..1c8cab14a32c 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1415,8 +1415,6 @@ static int tcp_peek_sndq(struct sock *sk, struct =
msghdr *msg, int len)
> >       struct sk_buff *skb;
> >       int copied =3D 0, err =3D 0;
> >
> > -     /* XXX -- need to support SO_PEEK_OFF */
> > -
> >       skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
> >               err =3D skb_copy_datagram_msg(skb, 0, msg, skb->len);
> >               if (err)
> > @@ -2327,6 +2325,7 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
> >       int target;             /* Read at least this many bytes */
> >       long timeo;
> >       struct sk_buff *skb, *last;
> > +     u32 peek_offset =3D 0;
> >       u32 urg_hole =3D 0;
> >
> >       err =3D -ENOTCONN;
> > @@ -2360,7 +2359,8 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
> >
> >       seq =3D &tp->copied_seq;
> >       if (flags & MSG_PEEK) {
> > -             peek_seq =3D tp->copied_seq;
> > +             peek_offset =3D max(sk_peek_offset(sk, flags), 0);
> > +             peek_seq =3D tp->copied_seq + peek_offset;
> >               seq =3D &peek_seq;
> >       }
> >
> > @@ -2463,11 +2463,11 @@ static int tcp_recvmsg_locked(struct sock *sk, =
struct msghdr *msg, size_t len,
> >               }
> >
> >               if ((flags & MSG_PEEK) &&
> > -                 (peek_seq - copied - urg_hole !=3D tp->copied_seq)) {
> > +                 (peek_seq - peek_offset - copied - urg_hole !=3D tp->=
copied_seq)) {
> >                       net_dbg_ratelimited("TCP(%s:%d): Application bug,=
 race in MSG_PEEK\n",
> >                                           current->comm,
> >                                           task_pid_nr(current));
> > -                     peek_seq =3D tp->copied_seq;
> > +                     peek_seq =3D tp->copied_seq + peek_offset;
> >               }
> >               continue;
> >
> > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct sock *sk, s=
truct msghdr *msg, size_t len,
> >               WRITE_ONCE(*seq, *seq + used);
> >               copied +=3D used;
> >               len -=3D used;
> > -
> > +             if (flags & MSG_PEEK)
> > +                     sk_peek_offset_fwd(sk, used);
> > +             else
> > +                     sk_peek_offset_bwd(sk, used);

Yet another cache miss in TCP fast path...

We need to move sk_peek_off in a better location before we accept this patc=
h.

I always thought MSK_PEEK was very inefficient, I am surprised we
allow arbitrary loops in recvmsg().

