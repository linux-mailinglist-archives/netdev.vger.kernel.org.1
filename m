Return-Path: <netdev+bounces-142458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB19BF3D2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C361C235C3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843EB1DEFE7;
	Wed,  6 Nov 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fv8908II"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA3166307
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912431; cv=none; b=pcUsdsbzb/lenUmAKh1NXmxouYfZMG9z3UdMsVt3FGbwrQNS4DQdJIfyU1vGYpRXD3iEDRSs70xwUwYzVAtO+Jp4/SdvF9whRNkBBW1fSFYBgCi9TNPXws/TL8JG/FLp/ptFM5RxSPB9HTa8xKmJYo58N2vjHEu9OWsHIkkwGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912431; c=relaxed/simple;
	bh=M0P7cs84jjZ9MZPgSMNMZ4jFY7gU+GyjBVnr9jmkpNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sv8t+j6Mh6LRI2/CLkDtWzJOK6aYQ0S/dRnn9mPE8Ln/52nTw4WRRhjDVXNw+yrzTgWzb4/DnpSJN4H7n08tswv6DV0YfmYmBMnTQOTak108q2+6Y5WezR/cQytheMxSoYACAAfokuQYzpApPkVi06Y/qrNalFzaqQINRTAvMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fv8908II; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4707466f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912427; x=1731517227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLNouObUorCzJ6AkcXYcYQkgJBmZc32SGAGNMMbQIqo=;
        b=Fv8908IIWKbmy2IzdZhM+rXLzKQDIh35Pyg+zUqFd1hp+8/KaQM0B/BbcvgEx0X9tb
         LMrDs+HRM1Amudb7fo19JACipRDY0poa96ro0fZyNNgZUl8EzI8IO8b3oHkfH/4JLOFu
         svnavBQ6kbRqydpZycJyzmaNY0FTehqW0ZUIfHb5MVGkTGag5O6p2Kq4/EGJgY0D1WjH
         q19PSr9Sv6vPwr2QUsk6ew8yRPoKCaa8kRUTiwkHO2pmklPG9wL44uQcohz55pfjh6ep
         GZpsJekj1kOGIIbrpALXxQiDqgd+oWVqh7WdHYTfdM+sj9PzZfWx7J5d0pMXpw1Y/Yku
         tmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912427; x=1731517227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLNouObUorCzJ6AkcXYcYQkgJBmZc32SGAGNMMbQIqo=;
        b=djBGo7axRPfH43tT8C2youoOi97QSG86qACKFnkkKoMNjkbSKwtrOTbMu1c9dpONdY
         3AEvjGCA7/AHzWBNwypmsaPGUJi721HBkejSBkG2c/DMWlhaPCVsZK/bz7wfryk4yd6r
         uhNjFrr6hJt6h2tL92htZE1ShNKB80Jfkbz53ro1zcvk9e2+YUyqzUGXLpV6B+Zoco+S
         WYfPFgvqZtbA84Y2uQ1Ggu9cEedcWsjieRf3sF0qGkrUDjLIulIA7fwWcO1ok7WvG10U
         xQwJD6/Pn1ldVbM3Xmp8MOcrd/J+H24JPtrm9Ok1KR1Yx8nCvbRH5f804Gh/CfA3in+p
         h23A==
X-Forwarded-Encrypted: i=1; AJvYcCUj4SS0RdkxQHsOwMKwQWc6bCi0Ch08H3v7RJrYLDzX7gJ94mIroYgBSRJkI4B2Vtps7ybw5IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4nrMGNsFdmNGrvyN23DLZzo2eEqi+DdS5xqxej/Tf2lmcnab
	7Bh6GMcainIgynGgkvzKaV7KKc+exOPMXHahVDKDzQRNc9aSwG0TKZW/HmLRlW2Pqb0odgYueYi
	DJrHdZNAAhIW22OF0K1bW+J93hfazUFYCaUOL
X-Google-Smtp-Source: AGHT+IHrnx1TLzKwmMZlGwZeX1FBkou/Z8ONAtZQvMq43XEgpy8Y8EBDJpgktHzfFZkFyumWTNC5i3EASlSIUyX9odk=
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id
 ffacd0b85a97d-381be776c81mr20504534f8f.15.1730912426398; Wed, 06 Nov 2024
 09:00:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
In-Reply-To: <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 18:00:14 +0100
Message-ID: <CANn89iJj2sQX3rZvmbL0zQjX7K-OFwyautgAXqxNvk2M17++bw@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:54=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Wed, Nov 6, 2024 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Nov 6, 2024 at 4:55=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> > >
> > > SELinux tracks the number of allocated xfrm_state/xfrm_policy objects
> > > (via the selinux_xfrm_refcount variable) as an input in deciding if p=
eer
> > > labeling should be used.
> > >
> > > However, as a result of commits f35f821935d8 ("tcp: defer skb freeing
> > > after socket lock is released") and 68822bdf76f1 ("net: generalize sk=
b
> > > freeing deferral to per-cpu lists"), freeing of a sk_buff object, whi=
ch
> > > may hold a reference to an xfrm_state object, can be deferred for
> > > processing on another CPU core, so even after xfrm_state is deleted f=
rom
> > > the configuration by userspace, the refcount isn't decremented until =
the
> > > deferred freeing of relevant sk_buffs happens. On a system with many
> > > cores this can take a very long time (even minutes or more if the sys=
tem
> > > is not very active), leading to peer labeling being enabled for much
> > > longer than expected.
> > >
> > > Fix this by moving the selinux_xfrm_refcount decrementing to just aft=
er
> > > the actual deletion of the xfrm objects rather than waiting for the
> > > freeing to happen. For xfrm_policy it currently doesn't seem to be
> > > necessary, but let's do the same there for consistency and
> > > future-proofing.
> > >
> > > We hit this issue on a specific aarch64 256-core system, where the
> > > sequence of unix_socket/test and inet_socket/tcp/test from
> > > selinux-testsuite [1] would quite reliably trigger this scenario, and=
 a
> > > subsequent sctp/test run would then stumble because the policy for th=
at
> > > test misses some rules that would make it work under peer labeling
> > > enabled (namely it was getting the netif::egress permission denied in
> > > some of the test cases).
> > >
> > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > >
> > > Fixes: f35f821935d8 ("tcp: defer skb freeing after socket lock is rel=
eased")
> > > Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu=
 lists")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> > Can we explain why TCP packets sitting in TCP receive queues would
> > need to keep xfrm_state around ?
> >
> > With thousands of TCP sockets. I would imagine that a similar issue
> > would be hit,
> > regardless of f35f821935d8 ("tcp: defer skb freeing after socket lock
> > is released") and 68822bdf76f1 ("net: generalize skb freeing deferral
> > to per-cpu lists")
> >
> > We remove the dst from these incoming packets (see skb_dst_drop() in
> > tcp_data_queue() and tcp_add_backlog()),
> > I do not see how XFRM state could be kept ?
>
> The problem is not with the xfrm_state reference via dst_entry, but
> the one in skb_ext (skb->extensions) -> sec_path
> (skb_ext_get_ptr(skb->extensions, SKB_EXT_SEC_PATH)) -> the xvec
> array. But you have a point that I should say that in the commit
> message...
>

So some secpath_reset() calls should be added in various protocol handlers
before packets are possibly queued for hours in a socket queue  ?

I see one in l2tp_eth_dev_recv().

> And I think you're right that even without those commits a delay in
> processing the RCU free callbacks could cause a similar issue, it just
> wouldn't be as easy to trigger. That made me look deeper into history
> which commit actually added the decrement on free and it turns out it
> was done intentionally as a bugfix - see commit e4e8536f65b5
> ("selinux: fix the labeled xfrm/IPsec reference count handling").
> Before that commit the logic was similar to what my patch is doing, so
> I could be re-introducing another bug here :-/ The commit message is
> not very helpful there - Paul, do you happen to remember what the
> issue was that prompted it? I guess there can be some alloc's that
> won't have a matching delete in the right circumstances? Or something
> involving the selinux_xfrm_policy_clone() case?
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>

