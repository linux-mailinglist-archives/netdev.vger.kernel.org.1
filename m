Return-Path: <netdev+bounces-159847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D03A17284
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231053A3008
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B281E8823;
	Mon, 20 Jan 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjzuxFH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F549EC0
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396276; cv=none; b=QOc9M0+NfLcV6mQ2o+zpofxHBZ4S2rtVB0nFZmKPHQGMUOYheLlsrwEz3KQyjadPH2MXHR43c6KbicYSx0nK5v85dfgNNeeJNT825ACZuMSKo4PXTmbPqoM0VS5lL7jZmRTcJxZR55UYy7GwNEpyykwAis1MomY2wT7EBfJs4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396276; c=relaxed/simple;
	bh=HbQ2YsIoKBJM9KpNByBkWZ771QMm5cXFRZl0Wq2INr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiVI/MdshEspYn78ZWiqNRElHgaHTjRfjyhxgI5oHmY/q/yv5Eci09FlOtwCzICzr8hKEQqbFIXaMX3g+ijjTObVtK1CVY9jvHBgmFw42ixJCTzxTJkV31vZ457jw0cSpellQaVgMNkQjOpzqtgPDbFkFNPqhHg0ofjAEcsNytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjzuxFH5; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd1962a75bso41662176d6.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737396273; x=1738001073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaiOg4FC85NhxG7+wG/MF1IX/HKUj0jIRe1OVSMpaWs=;
        b=AjzuxFH5s600JCzeZZdc6ybpoWko+PfXh/cLvWGYzCrQlvQmUvyOQHCxUbpfBSdvKK
         9qwP04grlnYs8QiFa+r1JAyPmA8/jFN0/c2Wt9AbpuliddGeWVsE61VTLAWybktZe64n
         VU4Gr2G05phHSsjDKyEUFUjUniZzO3q5HoMkb3Svn7R7BSDSmmk1aryZJTs05MO4H58n
         yCPsb7OF251OuHah5ZVN1VBDTpAVkMKEiJeusOdQNb4NktNiekvYe7BCVIpqyh3jMXWy
         Fq/4akymKhP91obrkQjA/bc/96YZ8N14RKgvNTNHJvaP/XspM8JJZBgcDZQ/cOAVkBS3
         KCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737396273; x=1738001073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaiOg4FC85NhxG7+wG/MF1IX/HKUj0jIRe1OVSMpaWs=;
        b=Zff642ibC74M6iIOuwB8oddeqWHXYdsW9vdG9QzpkJTijE+VVR/hVmrQVtYL4yXo23
         ADkRkpqZfQO6vXN3kPA1mp0z9DDM+72SwzgFA3/XPDWfn/xvYs+n7b4Dp/kRxXju9iKt
         XPYdKrGHOkagcNp/vlLZABUkUSEZhJvmIX99e3B1blTfaGFFVuxEeP6G4/xn7hndqn6n
         mAhVEh4eH1H1+A57lzBn2eWDiOGXjz1FfH/zIc6jpE3OMRpa1ruBI7IN86T6e5a1nvwv
         5ADVDW24vgBWRhb9Xj67efw6S1iopddUOtzQK95K978e8EIEmKFi3IFb8hTlPt2NTopm
         PI3g==
X-Gm-Message-State: AOJu0YxM78fA2fFnJFM7mUB8sc0FmU8Uo9d6cJi2GteL4/N1xOzsm6JW
	7MTIDBoUUnohUu3iPtuJ1bYV5qkG9EebFiAkr/nCrb3TeMUv/xtnyea6fqd3zAN5WDNxKxPOqIc
	kqb8bpbAKSvB8o+g+diDF2kijYVc=
X-Gm-Gg: ASbGncvJ/Ui3p/VtcQTECPzVXEcHQ/lXrW6k/jUoPSkfBG+kgiHNX5EiVmCkfLWNODq
	gYzsBOuib+vOS/X0wiFNS4dDkpgiC84o8VQi4RFT4de6PlNNaXuo=
X-Google-Smtp-Source: AGHT+IFNH0M1y/CZGNW7TDUrhnOOlVgL7fNGdCbRsQ/UkrQGAmEpo6rUoDXmdEz1AVwYhiE6jGsn0wrterO/faMBMHE=
X-Received: by 2002:a05:6214:762:b0:6d8:7ed4:3364 with SMTP id
 6a1803df08f44-6e1b2168b97mr198936646d6.3.1737396272993; Mon, 20 Jan 2025
 10:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117192859.28252-1-dzq.aishenghu0@gmail.com>
 <CAFmV8Nc=5Yd-ZA-MqKmTMWcz+LLC8p7YG-nbfge_WAaHcp4G8A@mail.gmail.com> <CANn89iL355opLJTJUFmiuy7GW5mu9NmihN-xoAtV2=RFVMO3qg@mail.gmail.com>
In-Reply-To: <CANn89iL355opLJTJUFmiuy7GW5mu9NmihN-xoAtV2=RFVMO3qg@mail.gmail.com>
From: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Date: Tue, 21 Jan 2025 02:04:21 +0800
X-Gm-Features: AbW1kva_HaeU94BgMzk8wjGVCSTLTBCvP-IQDFPdmdAUBnX-Mo6NysWTr9V3u8s
Message-ID: <CAFmV8Ndxkf-mq918CAs336q1rY8cuaS-PgPaQjXrEP70=ONUyA@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp: fill the one wscale sized window to trigger zero
 window advertising
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:34=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 20, 2025 at 1:30=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gma=
il.com> wrote:
> >
> > On Sat, Jan 18, 2025 at 3:29=E2=80=AFAM Zhongqiu Duan <dzq.aishenghu0@g=
mail.com> wrote:
> > >
> > > If the rcvbuf of a slow receiver is full, the packet will be dropped
> > > because tcp_try_rmem_schedule() cannot schedule more memory for it.
> > > Usually the scaled window size is not MSS aligned. If the receiver
> > > advertised a one wscale sized window is in (MSS, 2*MSS), and GSO/TSO =
is
> > > disabled, we need at least two packets to fill it. But the receiver w=
ill
> > > not ACK the first one, and also do not offer a zero window since we n=
ever
> > > shrink the offered window.
> > > The sender waits for the ACK because the send window is not enough fo=
r
> > > another MSS sized packet, tcp_snd_wnd_test() will return false, and
> > > starts the TLP and then the retransmission timer for the first packet
> > > until it is ACKed.
> > > It may take a long time to resume transmission from retransmission af=
ter
> > > the receiver clears the rcvbuf, depends on the times of retransmissio=
ns.
> > >
> > > This issue should be rare today as GSO/TSO is a common technology,
> > > especially after 0a6b2a1dc2a2 ("tcp: switch to GSO being always on") =
or
> > > commit d0d598ca86bd ("net: remove sk_route_forced_caps").
> > > We can reproduce it by reverting commit 0a6b2a1dc2a2 and disabling hw
> > > GSO/TSO from nic using ethtool (a). Or enabling MD5SIG (b).
> > >
> > > Force split a large packet and send it to fill the window so that the
> > > receiver can offer a zero window if he want.
> > >
> > > Reproduce:
> > >
> > > 1. Set a large number for net.core.rmem_max on the RECV side to provi=
de
> > >    a large wscale value of 11, which will provide a 2048 window large=
r
> > >    than the normal MSS 1448.
> > >    Set a slightly lower value for net.ipv4.tcp_rmem on the RECV side =
to
> > >    quickly trigger the problem. (optional)
> > >
> > >    sysctl net.core.rmem_max=3D67108864
> > >    sysctl net.ipv4.tcp_rmem=3D"4096 131072 262144"
> > >
> > > 2. (a) Build customized kernel with 0a6b2a1dc2a2 reverted and disabli=
ng
> > >    the GSO/TSO of nic on the SEND side.
> > >    (b) Or setup the xfrm tunnel with esp proto and aead rfc4106(gcm(a=
es))
> > >    algo. (Namespace and veth is okay, helper xfrm.sh is at the end.)
> >
> > Sorry, I mixed up some things in the test environment. So the xfrm setu=
p
> > is completely unnecessary in this reproduce. Just preparing an MD5SIG
> > enabled tcp tool is enough for method (b).
> >
> > It's easy to reproduce in distros, what we should do is make a slightly
> > large wscale and make sure that the GSO is disabled in sk_setup_caps().
>
> Please provide a packetdrill test.
>
> I am sorry, I am seeing too many suspect reports these days, with
> vague descriptions.

I just found a new option net.ipv4.tcp_shrink_window introduced by commit
b650d953cd39 ("tcp: enforce receive buffer memory limits by allowing the
tcp window to shrink").

My problem is one of the case described in their blog about this commit.
After enabling it, my problem disappears.

Very thanks,
Zhongqiu

