Return-Path: <netdev+bounces-72323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A369C8578BD
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EA91C21556
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFF1B959;
	Fri, 16 Feb 2024 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnQyXg7T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741D1B962
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075332; cv=none; b=OWkMDuZAs1Mzo/lYPI/JpcPA1U9Mfk/oJ9dnp8UAawqxeEBln+8eBJjofnDyTZ9Wy5m9qsJ7TqCNqBgDBuWILuhbSygrNMEfk5jYeuRUgHoDD1MJyIUOIB2RP9LOANw3NRdDVuB4HD3CtSaIbaLhPqcq+U/k6kZvKH2ruoT0tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075332; c=relaxed/simple;
	bh=lx1118YQ9Y5HEvOQDj9s6IAXGKYar4+Q7DSgLYq46OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYPXIUdfDOe221UuaKHYBC1xZSEwH5BnKMmekPicjQJqXzL9oyflg6BOu/39ThBX6ZrQVyMwIT9Og4gfPoAkfFW10raa0409//o0vuAaZFcjr5A3ex2sV1JXsUIypAlKxcpHchSO4Cy3zqHHLdWS5q2S+SLxUlSsTCWCTi7Q3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnQyXg7T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so4992a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708075329; x=1708680129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bBdfctTPwqXx3EHXILft1vvn13/jEBJ3nvmxfdVnVk=;
        b=qnQyXg7TiHa+FLNbkMrrovDSJ4CI9DtDbrNrIuAYJrIny97gKBNdbWwVYvcKqp/LEg
         spNLHr3LaywBwbl9ainf/RagOqMybUI4dkUh+tefrVTdWvN0CmZkqM0ZEfRG0Inw1X4o
         MrukVWgYfs48cX+T4Ah9mIdsXQbH5xEzCrJDLRAqyrBPUAdhcIe+FWov+v51quAzlEA1
         smAFBqXjjyrqDmG8xP9j6J1PgQ8N8YMu7Bh20XlEmwr+r9LQ+90rfi2NghZnSVy6t5XR
         6je2u6kcCV+oisuPupC9B06ZQ03EhT6IhqGhJ5kFUNNJG40Z4mZTaQJz34lAsHPN+drn
         jRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075329; x=1708680129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bBdfctTPwqXx3EHXILft1vvn13/jEBJ3nvmxfdVnVk=;
        b=VEj+nTh3qq0v43EitVtctCcPsupkNkbWmqg7yWfk5IV3Mnla/62L7OVd7WmB+sH9hM
         wPXIBZGNqMiqM1NVWHDrNvX4kF2m0rcfqZp+j1mLp6+w3xetcn5qXXgpO5CfAOsUnCx8
         xpjtKXWI19Nyxr8Af5QSxdj3LPQLH37Ye8OA7OqohxKt+/KEpwqCYeHByLh5g6AvOTgS
         TUNkfVJK5aVWA4dQsraTtLiH/blZk+eg3QdAs/oZcnQHz/CHaejVu/cbDhwOAqhvhDg8
         67eQql32NueoaonWyReoZdAHmANTCiWaOvbmpf5+7w+X3cpZKgOGxBrKhLOA4HaxTNbi
         Tblw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9f4rVLVGI51LFrecKqPiPI3l0PtWG3ugs/nSJh7Fj2bR54TCPxwZbC9E95S00XMV9JPpKdmXbsPOqJ0ny04AoEq1aaSg
X-Gm-Message-State: AOJu0Yy0LmIq7wW1QSfDFiHDfMvs7iNSjKaFxrEhGHJ9UqFLxzQPvsTI
	6YHMfvWhYGnP70rpqeCrGUFRx1HYntsynTDi+oG4DRtt+QQ73tCUEh+sLNmI6uSWwX+yCh6Ced/
	MXBWTmfTcw/GpV0G/KpwEUvsHQYZPPwX0ohv9
X-Google-Smtp-Source: AGHT+IHjg/nhYCKRW2LdnagfUJiZzLg6NULr5aVrf4xAGyWJAnai7crxUzqTw55wKXII2jt2TLCJfRpuzv1oGVJKHZQ=
X-Received: by 2002:a50:d607:0:b0:563:adf3:f5f4 with SMTP id
 x7-20020a50d607000000b00563adf3f5f4mr127188edi.1.1708075328663; Fri, 16 Feb
 2024 01:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com> <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
 <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
 <89f263be-3403-8404-69ed-313539d59669@redhat.com> <9cb12376da3f6cd316320b29f294cc84eaba6cfa.camel@redhat.com>
In-Reply-To: <9cb12376da3f6cd316320b29f294cc84eaba6cfa.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 10:21:54 +0100
Message-ID: <CANn89i+C_mQmTFsqKb3geRADET2ELWeZ=0QHdvuq+v+PKtW0AQ@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, kuba@kernel.org, passt-dev@passt.top, 
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:14=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-02-15 at 17:24 -0500, Jon Maloy wrote:
> >
> > On 2024-02-15 12:46, Eric Dumazet wrote:
> > > On Thu, Feb 15, 2024 at 6:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > > Note: please send text-only email to netdev.
> > > >
> > > > On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
> > > > > I wonder if the following could be acceptable:
> > > > >
> > > > >   if (flags & MSG_PEEK)
> > > > >          sk_peek_offset_fwd(sk, used);
> > > > >   else if (peek_offset > 0)
> > > > >         sk_peek_offset_bwd(sk, used);
> > > > >
> > > > >   peek_offset is already present in the data cache, and if it has=
 the value
> > > > >   zero it means either that that sk->sk_peek_off is unused (-1) o=
r actually is zero.
> > > > >   Either way, no rewind is needed in that case.
> > > > I agree the above should avoid touching cold cachelines in the
> > > > fastpath, and looks functionally correct to me.
> > > >
> > > > The last word is up to Eric :)
> > > >
> > > An actual patch seems needed.
> > >
> > > In the current form, local variable peek_offset is 0 when !MSG_PEEK.
> > >
> > > So the "else if (peek_offset > 0)" would always be false.
> > >
> > Yes, of course. This wouldn't work unless we read sk->sk_peek_off at th=
e
> > beginning of the function.
> > I will look at the other suggestions.
>
> I *think* that moving sk_peek_off this way:
>
> ---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a9d99a9c583f..576a6a6abb03 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -413,7 +413,7 @@ struct sock {
>         unsigned int            sk_napi_id;
>  #endif
>         int                     sk_rcvbuf;
> -       int                     sk_disconnects;
> +       int                     sk_peek_off;
>
>         struct sk_filter __rcu  *sk_filter;
>         union {
> @@ -439,7 +439,7 @@ struct sock {
>                 struct rb_root  tcp_rtx_queue;
>         };
>         struct sk_buff_head     sk_write_queue;
> -       __s32                   sk_peek_off;
> +       int                     sk_disconnects;
>         int                     sk_write_pending;
>         __u32                   sk_dst_pending_confirm;
>         u32                     sk_pacing_status; /* see enum sk_pacing *=
/
> ---
>
> should avoid problematic accesses,
>
> The relevant cachelines layout is as follow:
>
>                         /* --- cacheline 4 boundary (256 bytes) --- */
>                 struct sk_buff *   tail;                 /*   256     8 *=
/
>         } sk_backlog;                                    /*   240    24 *=
/
>         int                        sk_forward_alloc;     /*   264     4 *=
/
>         u32                        sk_reserved_mem;      /*   268     4 *=
/
>         unsigned int               sk_ll_usec;           /*   272     4 *=
/
>         unsigned int               sk_napi_id;           /*   276     4 *=
/
>         int                        sk_rcvbuf;            /*   280     4 *=
/
>         int                        sk_disconnects;       /*   284     4 *=
/
>                                 // will become sk_peek_off
>         struct sk_filter *         sk_filter;            /*   288     8 *=
/
>         union {
>                 struct socket_wq * sk_wq;                /*   296     8 *=
/
>                 struct socket_wq * sk_wq_raw;            /*   296     8 *=
/
>         };                                               /*   296     8 *=
/
>         struct xfrm_policy *       sk_policy[2];         /*   304    16 *=
/
>         /* --- cacheline 5 boundary (320 bytes) --- */
>
>         //  ...
>
>         /* --- cacheline 6 boundary (384 bytes) --- */
>         __s32                      sk_peek_off;          /*   384     4 *=
/
>                                 // will become sk_diconnects
>         int                        sk_write_pending;     /*   388     4 *=
/
>         __u32                      sk_dst_pending_confirm; /*   392     4=
 */
>         u32                        sk_pacing_status;     /*   396     4 *=
/
>         long int                   sk_sndtimeo;          /*   400     8 *=
/
>         struct timer_list          sk_timer;             /*   408    40 *=
/
>
>         /* XXX last struct has 4 bytes of padding */
>
>         /* --- cacheline 7 boundary (448 bytes) --- */
>
> sk_peek_off will be in the same cachline of sk_forward_alloc /
> sk_reserved_mem / backlog tail, that are already touched by the
> tcp_recvmsg_locked() main loop.
>
> WDYT?

I was about to send a similar change, also moving sk_rcvtimeo, and
adding __cacheline_group_begin()/__cacheline_group_end
annotations.

I can finish this today.

