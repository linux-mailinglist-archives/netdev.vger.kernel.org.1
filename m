Return-Path: <netdev+bounces-149012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C79E3C9D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C208D16036C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C811F756F;
	Wed,  4 Dec 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/X7kzKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227661BD014
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322129; cv=none; b=JDgBRrcmarJoK+j4vjp5ZgNKbUrFh4joA1w4lS9j9G2om762XFmSCDhN5GwM+s4OFNEXojI0rOzwOK9TTtPqGxPBDljolOnABzCuvT0bE+fmfSpP/KdnaQBaOTyfFWte2lDV8tsB2ufxsXbcbfWA4zSLwTqo7a1+8h1bB7fWbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322129; c=relaxed/simple;
	bh=jZFPdtuKM/4MGujdMzoVO7WTjmvayBrMQSDKHpFSMK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vcp/A3YuN1+mFOK1v8QnuVO0gMXuzFvOxj/HepOokMxQMCFgHquCqwxHPqjFGdPTwBrlpY7ib9uidS/RKDftQ1InYhQq5+YsE2z+hRle01Te51mLfLEMRVRYuwsjWCEFAWGaVOGAXmTsuWWKBmNyX2w4Tfdb47r6+NW3OGxKyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/X7kzKN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46687f60b73so227321cf.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733322127; x=1733926927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZFPdtuKM/4MGujdMzoVO7WTjmvayBrMQSDKHpFSMK0=;
        b=f/X7kzKNo1W5XUY0QV1eRYLg75v5F/nl5WWqiHuFZ1G9XuvOw7ajwuDeoXY+OQCiSJ
         wwELstnqpIFG1IN5DsM1rukinUuyD9K94Dc6RWw3nwnEP0BYmA9IBd8fAKA0VvkqxdfQ
         N2K857WyJhGiVZYYfq2hmsP2r9q+xFSqPUlIJ0+lDOpRdmKQSAt7wNHAVSRNkPcayrSI
         7972oSYalDh626i9yg5m2a3JLAOPPuOTt3lCQP2r4XM2g4PB6FdStr+P08/g3SbBKDT9
         I5hcU0rVuRZaHWvuLwjmh/7kV1P96xLKBCY3uixhQQxFND6lg/iSxqX8NrS+sOtFIaOC
         dESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322127; x=1733926927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZFPdtuKM/4MGujdMzoVO7WTjmvayBrMQSDKHpFSMK0=;
        b=oogA0yO9YvF6PJrP0BLLBaPRXuiJepYmMkCDdGY6Bkjjr4HihFaCC8nkYL1Vihan9c
         U7UHXgCOw+71pNaAOaVmC02r7biKfwWDxnJOcuFnZwykQLN3zTbbzl6K1KMMk2FVbPFD
         DznGOpFPvDuB8VXCs7wapFQxVIrCOckPJsaHp9SH7Pn6n+crIPRPLLlRkj7q90kh8/ii
         vAJ6na/Amf21zpfOQImLcaumNGSyWkKDVrMmtxWUu20WIqf0VmjdEVQmD24wmoksc8cn
         m/VzchOSN6cFAcTwYjuEJONP9+XJ4kWbHEcPBL8hY8VB4EcGMqO1nNmTcYdIN3GGDonA
         gwgg==
X-Forwarded-Encrypted: i=1; AJvYcCWJMNv5HSs0D9wmGUFdfYBC01Fhg/YLBhQTb5eFL6CdidYaBh8LIs/4bCEJEIQ8V03/sHT0HwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3gT9zP6WzP3/DXFICbO6GvZH1tewdtutHUsRauKL7HZrHGsYE
	7Wgw+BTdr0xduBil0iv/pWfmWin236V5yg0MuE7i9qy8zGzzs7U4rVztkGvhc120UDFxSJ77bRP
	bwAlCgaq4vJQtUN+xfTEXi8xTGbwoe9R3JMuz
X-Gm-Gg: ASbGncvoGhXU8ifGSoJH5BGkCdyMKIB5ycEPkZHa15Ou5f0Dy4C4y3HwhFPPu5/o8lL
	uzy0o01yR4WLIFMhpOUlOq9/hQf7VpGHNQwbK4iN4vSzbXp+I/QEQ54TOpzAUTG8L
X-Google-Smtp-Source: AGHT+IEpQhE7D5Vey9wUDnuOEEvDJ2gnQubvBzk/ZoMblukjuUumP/CvUjMEuRtoZLBwjzXpYGjqRO+eWikphM5x5+E=
X-Received: by 2002:a05:622a:124e:b0:466:8c7c:3663 with SMTP id
 d75a77b69052e-4671b68fa81mr2911711cf.5.1733322126557; Wed, 04 Dec 2024
 06:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com> <009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
In-Reply-To: <009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 4 Dec 2024 09:21:50 -0500
Message-ID: <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: "Dujeong.lee" <dujeong.lee@samsung.com>
Cc: Eric Dumazet <edumazet@google.com>, Youngmin Nam <youngmin.nam@samsung.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com, 
	yiwang.cai@samsung.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com, 
	sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:48=E2=80=AFAM Dujeong.lee <dujeong.lee@samsung.com=
> wrote:
>
> On Wed, Dec 4, 2024 at 4:14 PM Eric Dumazet wrote:
> > To: Youngmin Nam <youngmin.nam@samsung.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>; Neal Cardwell <ncardwell@google.c=
om>;
> > davem@davemloft.net; dsahern@kernel.org; pabeni@redhat.com;
> > horms@kernel.org; dujeong.lee@samsung.com; guo88.liu@samsung.com;
> > yiwang.cai@samsung.com; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; joonki.min@samsung.com; hajun.sung@samsung.com;
> > d7271.choe@samsung.com; sw.ju@samsung.com
> > Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
> >
> > On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM Youngmin Nam <youngmin.nam@samsu=
ng.com>
> > wrote:
> > >
> > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > I have not seen these warnings firing. Neal, have you seen this=
 in
> > the past ?
> > > > >
> > > > > I can't recall seeing these warnings over the past 5 years or so,
> > > > > and (from checking our monitoring) they don't seem to be firing i=
n
> > > > > our fleet recently.
> > > >
> > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > Could be that one of our workloads is pinned to 5.12.
> > > > Youngmin, what's the newest kernel you can repro this on?
> > > >
> > > Hi Jakub.
> > > Thank you for taking an interest in this issue.
> > >
> > > We've seen this issue since 5.15 kernel.
> > > Now, we can see this on 6.6 kernel which is the newest kernel we are
> > running.
> >
> > The fact that we are processing ACK packets after the write queue has b=
een
> > purged would be a serious bug.
> >
> > Thus the WARN() makes sense to us.
> >
> > It would be easy to build a packetdrill test. Please do so, then we can
> > fix the root cause.
> >
> > Thank you !
>
>
> Please let me share some more details and clarifications on the issue fro=
m ramdump snapshot locally secured.
>
> 1) This issue has been reported from Android-T linux kernel when we enabl=
ed panic_on_warn for the first time.
> Reproduction rate is not high and can be seen in any test cases with publ=
ic internet connection.
>
> 2) Analysis from ramdump (which is not available at the moment).
> 2-A) From ramdump, I was able to find below values.
> tp->packets_out =3D 0
> tp->retrans_out =3D 1
> tp->max_packets_out =3D 1
> tp->max_packets_Seq =3D 1575830358
> tp->snd_ssthresh =3D 5
> tp->snd_cwnd =3D 1
> tp->prior_cwnd =3D 10
> tp->wite_seq =3D 1575830359
> tp->pushed_seq =3D 1575830358
> tp->lost_out =3D 1
> tp->sacked_out =3D 0

Thanks for all the details! If the ramdump becomes available again at
some point, would it be possible to pull out the following values as
well:

tp->mss_cache
inet_csk(sk)->icsk_pmtu_cookie
inet_csk(sk)->icsk_ca_state

Thanks,
neal

