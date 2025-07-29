Return-Path: <netdev+bounces-210881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F5B1536A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 21:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B067165146
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503812192E3;
	Tue, 29 Jul 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pb2PKjmC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DED290F
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817467; cv=none; b=Updl1fVRQXmcgFdYGVWdaHdL2OmZxE5WcOHALWhWT29tekYZObKMQi/fUWaY+eDBJ00XF3eE66vGzAJAT67SKCTI/LntyiGKsltYnI1hYFFSlg2vDZL5/4hkL5c4BbMzy9mV0RVYo9njlib1PgHZJAslsVeZvjd/hfb5yD+YCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817467; c=relaxed/simple;
	bh=8BW/XhGVRyJy5P94uYNmy7oG5Gigwhjd0j1Kf1xbDOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjvjtepVDIX9+pk5SXBJDLGeJBoZ/n1qlW9DRiDU+tXE/32q73jC+fbdualXR0WjLL5vWYs7mdnvdjJOQ41u1yKhrVqGd9RukVWa+z5qaC+vOiYN1tdTKY3S9eYQFpz2L4E9uF92UPmzKHPFKrlh+6htHLuk3rFmp2ODAib3j40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pb2PKjmC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24070ef9e2eso40905ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817460; x=1754422260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvurJVmHevwBs2FBPNRizy6l0AopuTe0JJHakQymHus=;
        b=pb2PKjmCt55JLt4bG4MZ5Hs3D08K+eSvYPQ375UfZHMjrx8zB0yESuUu34lYvG21PP
         UljBNPqBd1O/FW95xqvEVP5NjSYNiJVlHSdDz6sROMeTcecRcP/SZn30hS1JLKEz4xR+
         3GfKTalRXF5Q8OnionTuCDBdxpQ501wiMRNd3Q3eSlO+VUu7HnvFg6DfYCq1FN4boI79
         SonPLWgW3PK/ynLPhLUMCTBPPEw1EvvCtM3SByI90LIMd7WMQ4/OUe8Xx8HLhhogl+2F
         WbmNKQK1f9d6z2Ogk3aCKbszQOOePNQ6HsbV9W/gKGXOuLJyI0i6rd8h5C4EZNnt3TV5
         FD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817460; x=1754422260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvurJVmHevwBs2FBPNRizy6l0AopuTe0JJHakQymHus=;
        b=IIc2Y4XFcwcTFBa/PfgDMfXr5BYizJbq4804xkcp0MEWYvOIYFQRxIF53fGctpFjBY
         jJs+TgJRLtMEH5wr0MdJRhXfu/wNfPUHjIsxIlA0V7q47y6apn5E1N/R1dSPE/gfr3LP
         jL79od1dGTs/VV+dkYyOnnCTTRv3q58Y7KDAokTvmGyAwRobo+So5/yVOAXxJf8Vilwd
         6sviaZKF9hLOSjnxB67iKGB0wDwnLUpiruuWELY8fzjuE/IjgznahzaOw2HMaUL32UWt
         3Lx13AEgjJWRClHkwChP9dnFsEiic6VkHrAg1wUP6qPdolbDL+pZWJHm9U2w4OwVU1ho
         eYpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA5/m/xw49bAGL5L5QoS+B9ryaJxJ4tPuvaHNwXM4IAguRQMjGbDtQ2DrgED44rA1NfC43sU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIarVfQyWdliHd/E71p4ng8RXiiB+pb2yhsIS6DbkSMLSOHMNC
	ABuDEC5LRpCwIFqZiiu4U38jZpRaYG2hdI/nL9uZ06eFPmruf5/Qi574ScvZ1mEYo8/Q6wRVV4z
	ScvTwAaD4gDXuS2FApwpwYpvc1qnRz8qq2YAKdD+Ka7IaEv9ni1yWT1AM
X-Gm-Gg: ASbGncsDXydd5laoYbmYrmT6tPDT3odo6auZty82etTbpwa2FZPPya2jOE9OrptsrYw
	obvPdSJsmpGNBBf2mG/C8zPF6cgfrQ0KXa9+cqzSMu+aMkJ27m020Q2fCFl3zoKNSJdoq5mcNj6
	PWpzlu8yBPgHh1md6bRxSlKfiJAV/4Hf4GPC+OZKrkJMopn+BlA768OzJliCd3mi+BeFQiXuQGJ
	x2+H15zOC85Absh8U1arJemrTMtn3h2Yp83sQ==
X-Google-Smtp-Source: AGHT+IEdDfAAsG36gvApuFeLc/KUUUhgTrAgzqzZbfc4v6S4nWFF2igcOdkAUqcm3yZM5KJO47FoROH/RnWwdRpfMGA=
X-Received: by 2002:a17:902:d54e:b0:240:2963:f794 with SMTP id
 d9443c01a7336-24099f74fa6mr849645ad.6.1753817460243; Tue, 29 Jul 2025
 12:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233608.111860-1-skhawaja@google.com> <20250722183647.1fd15767@kernel.org>
 <CAAywjhQN4Re3+64=qiukq1Q2wtLBj2pesaDSsvojK4tDAGHegw@mail.gmail.com> <20250723075605.16ec3756@kernel.org>
In-Reply-To: <20250723075605.16ec3756@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 29 Jul 2025 12:30:48 -0700
X-Gm-Features: Ac12FXz6Ve5o9FFPd1TZPUOKd1A11jnAgN1-r4nsGUy691iEMbhuGaatngst7ZA
Message-ID: <CAAywjhS1_oXvF21nyZiNstahxR7dkkPPPPS8PrwTC8fxPos5aA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Restore napi threaded state only when it is enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	netdev@vger.kernel.org, Joe Damato <joe@dama.to>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 7:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 19:36:31 -0700 Samiullah Khawaja wrote:
> > On Tue, Jul 22, 2025 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Mon, 21 Jul 2025 23:36:08 +0000 Samiullah Khawaja wrote:
> > > > Commit 2677010e7793 ("Add support to set NAPI threaded for individu=
al
> > > > NAPI") added support to enable/disable threaded napi using netlink.=
 This
> > > > also extended the napi config save/restore functionality to set the=
 napi
> > > > threaded state. This breaks the netdev reset when threaded napi is
> > >
> > > "This breaks the netdev reset" is very vague.
> > Basically on netdev reset inside napi_enable when it calls
> > napi_restore_config it tries to stop the NAPI kthread. Since during
> > napi_enable, the NAPI has STATE_SCHED set on it, the stop_kthread gets
> > stuck waiting for the STATE_SCHED to be unset. It should not be
> > destroying the kthread since threaded is enabled at device level. But
> > I think your point below is valid, we should probably set
> > napi->config->threaded in netif_set_threaded.
> >
> > I should add this to the commit message.
>
> Ah, I see! The impermanence of the DISABLED bit strikes again :(
>
> > > > enabled at device level as the napi_restore_config tries to stop th=
e
> > > > kthreads as napi->config->thread is false when threaded is enabled =
at
> > > > device level.
> > >
> > > My reading of the commit message is that the WARN triggers, but
> > > looking at the code I think you mean that we fail to update the
> > > config when we set at the device level?
> > >
> > > > The napi_restore_config should only restore the napi threaded state=
 when
> > > > threaded is enabled at NAPI level.
> > > >
> > > > The issue can be reproduced on virtio-net device using qemu. To
> > > > reproduce the issue run following,
> > > >
> > > >   echo 1 > /sys/class/net/threaded
> > > >   ethtool -L eth0 combined 1
> > >
> > > Maybe we should add that as a test under tools/testing/drivers/net -
> > > it will run against netdevsim but also all drivers we test which
> > > currently means virtio and fbnic, but hopefully soon more. Up to you.
> > +1
> >
> > I do want to add a test for it. I was thinking of extending
> > nl_netdev.py but that doesn't seem suitable as it only looks at the
> > state. I will look at the driver directory. Should I send a test with
> > this fix or should I send that later after the next reopen?
>
> We recommend sending the patch and the fix in one series, but up to you.
>
> > > I'm not sure I agree with the semantics, tho. IIUC you're basically
> > > making the code prefer threaded option. If user enables threading
> > > for the device, then disables it for a NAPI - reconfiguration will
> > > lose the fact that specific NAPI instance was supposed to have thread=
ing
> > > disabled. Why not update napi->config in netif_set_threaded() instead=
?
I will do this.
> > I think this discrepancy is orthogonal to the stopping of threads in
> > restore. This is because the napi_enable is calling restore_config and
> > then setting the STATE_THREADED bit on napis based on dev->threaded.
> > Even if restore unsets the THREADED bit (which would have already been
> > unset during napi_disable), it will be set again based on
> > dev->threaded.
Looking at this again, it seems the current mechanism should be fine
as if the napi thread was disabled for a napi then the kthread
associated with it will be destroyed also. This means that the
STATE_THREADED will not be enabled for it. I will set the threaded
config for each napi in netif_set_threaded.
> >
> > I think napi_restore_config should be called after setting up STATE bit=
s?
This is not needed.
>
> Yes, I think that would work. In fact I think it makes more sense in
> the first place to "list" the NAPI in the hash table accessible by user
> space only after it's actually enabled.
>
> I'd also be tempted to move some of the config restoration to
> netif_napi_add(), so that we don't start the thread just to stop it.
> But we'd need it in both places, IIRC netlink only holds the instance
> lock, so theoretically the config may change between "add" and "enable"
> :(
>
> cc: Joe, who's probably offline, but note his non-Fastly address

