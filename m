Return-Path: <netdev+bounces-241988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C379C8B66B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2CA0353713
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD5283FC4;
	Wed, 26 Nov 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZfwOjn3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9E279DAB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180862; cv=none; b=j2/t3/BCz+zb7iSl3PwPx2imvpDOu2KUBOdr2fIEcKAaRFY/JPMFZr0ErRQQEm/KosDVPqJXGxJkM6Pzv5A/r4qCxiYwLDj2qBuLBmKZyIAlmo4l5FOyT+0tEqXGKljaV7WnpcQCvtujEvdeKrSMyPeCdTkohqJTQ7cxhBs0AtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180862; c=relaxed/simple;
	bh=6eaAFk95uE3apRPfmJ3jcBZESNLPAO1NrPt+u75s4/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcYSpRPEegHDFJqcQ0/S/0apCv2Xftc5dM9sP2uqh/3E5Ak2m6gwbA8AxWtDI8WRa41ZQitiEfz57xSQdIf3Mm60bGX9Ioy8vffeB92HHknteQ8o5wO/AdyF3GYzBmfFQL00RUrz38mA4ZeemTUy1QT7J4SLPKcIMrofJUYpuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZfwOjn3p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso761929b3a.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764180860; x=1764785660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72LuU7ta7Aao0bybNJB/kR8raweXeM71oaQ1/aRxCi0=;
        b=ZfwOjn3p5jvoAXy11yiTxTPUj8ODs+iftD7yThcRpDcWX4K4sL3JpXqkQXHOblPuj/
         XXiVf4+GpJ7IvGTA+x5GodxikhoMeoGntKfYtd9tn72dSZAxTSwqT3+qBnrNmfd6d1/3
         JEKVqITxP0RmrtENQumd8B6297V7tkmkiVkSK0lhJ7J4CCUGVOhxC9UPv4SyrHI3wXv9
         kptT5oPCsN3eUr/HORmtwS1Zns10zbrvCKgNcl66RqBjgt1szc0ir6++7ZcB4x/8ZkD/
         YfpfcPr9RA3wCPEHm7Jsng7Bze6WA1i2bRACOi2u6xl4fjE2p7KD/ReGLCwhLJ1wqZSQ
         GeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180860; x=1764785660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72LuU7ta7Aao0bybNJB/kR8raweXeM71oaQ1/aRxCi0=;
        b=f+rspkuluOPqx5lqdKN0UJzByCZQvVEz4LM3WhvBx7QOs/irRNiApcB0Mnf1/K1GIa
         kQR0XVIJ/VRLRqn37HO5DuvkwFkbe5p2PGBPEib8PMlRVJsuRcmrMBVRkUSWwoydU9JW
         vHon0YgXCTA4B2ZeOykl8SyjxguMMDw2Qjs8L1kQzVUedHp2Kp5cxfXXWhYbAn0LS/Ik
         Kqplb0GZc9PshE8XzWX7jq9tyXFFkbdVyi9mzJioyjMj3kSbrnCzVpwZnOIAMCB6LLF/
         OHEqw6GpW2MOtOuqDblC659KLmjtDI20HY6HpXAYmaJrPjLxBDH6xRWUydZ1jAVQPWQi
         V/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqGqpBGGRkNRj/cV1mMpgDwkYZSFmP+4VXjYYTWdSXVl7vMm1q4EJvDMaD1xO+Ksda622p8NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJwYugfnPyn4l5hxF0Rg85SoIby/1W8sDHAGuDKCX1WYif8d+
	LrHYyeEjOScXt6v+hszpb+MiUIi+m9CeqaB70g4GM6kHgbpoB/6kAnK95sANHzq6ATQr6FPIbl/
	pMFOd2LKR/nyftMa+XYf5HPsne8MHhx2xnWQwt7Dr
X-Gm-Gg: ASbGncs9rrraSjkfwmXbPAyG/xpgAViz5EFhMCRw4io3sk++YEq6yXdBbl8eTm3xZyP
	kAJfrjvXsqdwbbyWc1IDtUZyg5Mls8JWBvYSs5tttEgowDdqHbcu52sPP/wAVsSNn3rwL+vU1mW
	IVOFruOK5tzpx0MrjGAbnb3Uz7Gsiee/W+B9oP9PMKfUf3yLORYCuDgISaTWMiYTSpy2QWmeKdj
	c4KLcw4Zg5YHhoOwVNxtdxbHFvryIxyyC0DB3mDPHACcM2oTEbIYZ6YiQlSuNU09rwixh3DQcV+
	cok=
X-Google-Smtp-Source: AGHT+IHvj6oGHedWuPB02gf5TE+xhM8X1UyqLAcP16nb2SIEtSDd36iLIJvykAbISBjVvYnE5+xryHBKbu0S6CgT2MA=
X-Received: by 2002:a17:90b:33c2:b0:340:68ee:ae5e with SMTP id
 98e67ed59e1d1-347331a7cbfmr19181747a91.4.1764180859980; Wed, 26 Nov 2025
 10:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
 <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com> <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
In-Reply-To: <CANn89iJiapfb3OULLv8FxQET4e-c7Kei_wyx2EYb7Wt_0qaAtw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Nov 2025 13:14:07 -0500
X-Gm-Features: AWmQ_bmxgL8C_Z4FF9B657ZU7EtGDTBCE6sS6T6HUqJJo_B7Qfit7nC3FTKGg6Y
Message-ID: <CAM0EoMm4UZ9cM6zOTH+uT1kwyMdgEsP2BPR3C+d_-nmbXfrYyQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:41=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Nov 26, 2025 at 8:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Tue, Nov 25, 2025 at 11:20=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Mon, Nov 24, 2025 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, 24 Nov 2025 15:08:24 -0500 Jamal Hadi Salim wrote:
> > > > > When doing multiport mirroring we dont detect infinite loops.
> > > > >
> > > > > Example (see the first accompanying tdc test):
> > > > > packet showing up on port0 ingress mirred redirect --> port1 egre=
ss
> > > > > packet showing up on port1 egress mirred redirect --> port0 ingre=
ss
> > > > >
> > > > > Example 2 (see the second accompanying tdc test)
> > > > > port0 egress --> port1 ingress --> port0 egress
> > > > >
> > > > > Fix this by remembering the source dev where mirred ran as oppose=
d to
> > > > > destination/target dev
> > > > >
> > > > > Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
> > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > >
> > > > Hm, this breaks net/fib_tests.sh:
> > > >
> > > > # 23.80 [+0.00] IPv4 rp_filter tests
> > > > # 25.63 [+1.84]     TEST: rp_filter passes local packets           =
                     [FAIL]
> > > > # 26.65 [+1.02]     TEST: rp_filter passes loopback packets        =
                     [FAIL]
> > > >
> > > > https://netdev-3.bots.linux.dev/vmksft-net/results/400301/10-fib-te=
sts-sh/stdout
> > > >
> > > > Not making a statement on whether the fix itself is acceptable
> > > > but if it is we gotta fix that test too..
> > >
> > > Sigh. I will look into it later.
> > > Note: Fixing this (and the netem loop issue) would have been trivial
> > > if we had those two skb ttl fields that were taken away.
> > > The human hours spent trying to detect and prevent infinite loops!
> > >
> >
> > Ok, I spent time on this and frankly cant find a way to fix the
> > infinite loop that avoids adding _a lot more_ complexity.
> > We need loop state to be associated with the skb. I will restore the
> > two skb bits and test. From inspection, i see one bit free but i may
> > be able to steal a bit from somewhere. I will post an RFC and at
> > minimal that will start a discussion and maybe someone will come up
> > with a better way of solving this.
> >
> > Eric, there's another issue as well involving example
> > port0:egress->port0:egress  - I have a patch but will post it later
> > after some testing.
>
> Adding bits for mirred in skb would be quite unfortunate.
> Argument of 'we have available space, let's use/waste it' is not very app=
ealing.
>
> Do we really need to accept more than one mirred ?
>
> What is a legitimate/realistic use for MIRRED_NEST_LIMIT =3D=3D 4 ?

It's the multiport redirection, particularly to ingress. When it get
redirected to ingress it will get queued and then transitioned back.
xmit struct wont catch this as a recursion, so MIRRED_NEST_LIMIT will
not help you.
Example (see the first accompanying tdc test):
packet showing up on port0:ingress mirred redirect --> port1:egress
packet showing up on port1:egress mirred redirect --> port0:ingress

cheers,
jamal

