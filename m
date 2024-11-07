Return-Path: <netdev+bounces-143103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FE9C12BB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF831C22269
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DE1E5718;
	Thu,  7 Nov 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HBc4aorI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4E1D8E01
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023464; cv=none; b=NxwZYF9wx7dcKPUEtLMIz7hMH17YEJYWYc0p0ZG2+EaOrBMdPagDTmals7CeZQlQFijRdqRNICiEDTj9nf0mrBqnvLihxZNjWX2yCz5ZuzCoFz/z1K1FYo5O4OkNY4EnboNxmTw0pTSDVNwSWbrbXtsP5aHPJMqyjccpPkRvVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023464; c=relaxed/simple;
	bh=VGQa/dfmMCi7k0Ero8n21PXo6Z224JQz/T5pDsCjwTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTMvfjKv+pmmXqf4uJDGJNBjwQKpCJtZZ5FrW0bYnpFaGjoW8/6mbpUnUrb544xtFhgslOcSM9A/e3kPwegrZrfz5rNZKKvxxEBH9puX2EoK5qj3sXaKs9xSdt/KVroAvyZ4KP9wIBlc4kB/11WJxiGmPPTP1LTwEtqzdWuXnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HBc4aorI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e291f1d659aso1541879276.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731023461; x=1731628261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o2QdvUrmjtWvx1OaQyam1dECjHJOE9NkQJ80zYMUbI=;
        b=HBc4aorIZXUVUO4LsJtCtlaLxoX4OcnUmFX6+qVS7xCBEU2i5FQHEnABs2cPYAj7cq
         tT4X7/GkU+H1zvoUFEcuCGmK1Gy7gtkyxOloPQUar/ymjpK8hfRqgrcuRfb8bpOwfSSe
         McwGwG5YJ45yulIBsn5T64spbJdVXgFLvOhH1dzBWFEwDZ8hzJeyVLh2khuEJyefZRbe
         QmFSQvH/+D518fWt8S+C6kxepBdbY0C01/NMyHNy0SL2zcJGVEhBn9XdwtAgAlUYVQbo
         iPGmtHTbklaA+DS+FdO9Ws812ObtuY57ggCuXxB1Nuba1XozYgBjsvhN6X8iMedmMbHf
         3Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023461; x=1731628261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o2QdvUrmjtWvx1OaQyam1dECjHJOE9NkQJ80zYMUbI=;
        b=pboB3LEYjWQx868ufDI2dmGD0jpp4OP3c4plQs7p+PElP5uHAUXSBHEz2euA3Zhwf8
         wBmNm3AHPcrXNp8kUzvtwufF4mKMVOGC4enu1YYQavBpxZv14Qcn1Ouq996f+3sepmDw
         4OJUW2e2wmxMYoDWZohtSGXCdLba/mJcfKQbskw6dPn4pW5vx/v88g5tM5m8iJlN5Gud
         ElE3r4MgsAXSfVFyR3/RDteR4hJRn/nBxmsf/ZRURI9u7p275c2K2lRsIgZBRnidbow0
         UdveI8Uuxsxeumq8XlPK52Ke2rtS9Qb/ZnMSUwlN9Y/SUEW3nbz0qQGslU6KFbTzK64q
         5yig==
X-Forwarded-Encrypted: i=1; AJvYcCW9Qm0anDcVqbwgLYc0kb99OVUMwlwqo84W7fQq9EfzsZY0f4szMsJx5W5KlIXuHeDg+i1PLYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqi5w8dBa+Cu/voXbNQy9lphIA0bAn9iT+YMyxzNqze4G5DfyI
	fEJwy4UBDwEZG3mNGFYSCM1LFGNb61gN5z6i+qF6Yd+q/SoT/gn7YdideLAy2vmAan1785+CwC9
	qDDhg2aUqsr/K4a4t3WtZngJoRYrlIoBNBlyC
X-Google-Smtp-Source: AGHT+IGBMUSkXgES6Kte8jOJe/wokdN/D/ojyHVde+avcBK17qucFa9cz89V/ErnOqwmSAzAR1B9I5C0gq66/E0ugkM=
X-Received: by 2002:a05:6902:20c7:b0:e30:cbde:1252 with SMTP id
 3f1490d57ef6-e337f8cef7bmr1103118276.36.1731023461324; Thu, 07 Nov 2024
 15:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com> <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
In-Reply-To: <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Nov 2024 18:50:50 -0500
Message-ID: <CAHC9VhS3yuwrOPcH5_iRy50O_TtBCh_OVWHZgzfFTYqyfrw_zQ@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Eric Dumazet <edumazet@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> On Wed, Nov 6, 2024 at 5:54=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> > On Wed, Nov 6, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> > > >
> > > > SELinux tracks the number of allocated xfrm_state/xfrm_policy objec=
ts
> > > > (via the selinux_xfrm_refcount variable) as an input in deciding if=
 peer
> > > > labeling should be used.
> > > >
> > > > However, as a result of commits f35f821935d8 ("tcp: defer skb freei=
ng
> > > > after socket lock is released") and 68822bdf76f1 ("net: generalize =
skb
> > > > freeing deferral to per-cpu lists"), freeing of a sk_buff object, w=
hich
> > > > may hold a reference to an xfrm_state object, can be deferred for
> > > > processing on another CPU core, so even after xfrm_state is deleted=
 from
> > > > the configuration by userspace, the refcount isn't decremented unti=
l the
> > > > deferred freeing of relevant sk_buffs happens. On a system with man=
y
> > > > cores this can take a very long time (even minutes or more if the s=
ystem
> > > > is not very active), leading to peer labeling being enabled for muc=
h
> > > > longer than expected.
> > > >
> > > > Fix this by moving the selinux_xfrm_refcount decrementing to just a=
fter
> > > > the actual deletion of the xfrm objects rather than waiting for the
> > > > freeing to happen. For xfrm_policy it currently doesn't seem to be
> > > > necessary, but let's do the same there for consistency and
> > > > future-proofing.
> > > >
> > > > We hit this issue on a specific aarch64 256-core system, where the
> > > > sequence of unix_socket/test and inet_socket/tcp/test from
> > > > selinux-testsuite [1] would quite reliably trigger this scenario, a=
nd a
> > > > subsequent sctp/test run would then stumble because the policy for =
that
> > > > test misses some rules that would make it work under peer labeling
> > > > enabled (namely it was getting the netif::egress permission denied =
in
> > > > some of the test cases).
> > > >
> > > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > > >
> > > > Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is r=
eleased")
> > > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-c=
pu lists")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > >
> > > Can we explain why TCP packets sitting in TCP receive queues would
> > > need to keep xfrm_state around ?
> > >
> > > With thousands of TCP sockets. I would imagine that a similar issue
> > > would be hit,
> > > regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
> > > is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
> > > to per-cpu lists")
> > >
> > > We remove the dst from these incoming packets (see skb_dst_drop() in
> > > tcp_data_queue() and tcp_add_backlog()),
> > > I do not see how XFRM state could be kept ?
> >
> > The problem is not with the xfrm_state reference via dst_entry, but
> > the one in skb_ext (skb->extensions) -> sec_path
> > (skb_ext_get_ptr(skb->extensions, SKB_EXT_SEC_PATH)) -> the xvec
> > array. But you have a point that I should say that in the commit
> > message...
> >
>
> So some secpath_reset() calls should be added in various protocol handler=
s
> before packets are possibly queued for hours in a socket queue  ?
>
> I see one in l2tp_eth_dev_recv().

We just need to make sure that skb_sec_path()/SKB_EXT_SEC_PATH is
still valid when the socket filter is run as that is currently where
the LSM hooks into the stack and authorizes a packet to be received on
a sock.

If there are xfrm packets still alive somewhere in the system in a way
that they could be sent or consumed by a task then the SELinux xfrm
reference count should probably still be non-zero, unless of course
we've already done all the access controls.

--=20
paul-moore.com

