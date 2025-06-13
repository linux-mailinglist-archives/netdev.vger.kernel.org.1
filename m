Return-Path: <netdev+bounces-197640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25EAD96D1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AE24A0EC0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1F253B71;
	Fri, 13 Jun 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAWJYYGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07E24A041
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848561; cv=none; b=GZy4Hzi4Fr8SlXEloQg/2Oo7zDECfUyFESU/hGlpOsP71KwYqhaS5CXltXdCMoYJLU8WnZkXAdhPjZWGxU2DRCga1JSgIJp/IE4qQXCIZr0EN/Da/e1Ehso3+5gOpaEjJh2KFaoT22kIe8dz2g2YD3tOQgQ5iFBFu8E7Ev51ANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848561; c=relaxed/simple;
	bh=Zbqyz8tzqM5fsGC3He4F5cD1SBNdUuG40Li35leQA/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSY7SQhjIkWLPI/gelLK6zyPK6VjJYM/QX8MQS02GdzuBYC9taYLlCVs211UQvoMl7rQe7OFsdwCaP4bykyZ3r8z1JynMDpLoF7t2khI3WmIs11e/LAzkGpAinKFJGE2uf/EmiNyxCVFEnxcBLtxDmUgNxnHDMok4A/ryquKHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAWJYYGr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58197794eso15711cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749848559; x=1750453359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjbM9cF25KXGnn6qxVrTsghFLkTaxiPsvyXuW5XtyJo=;
        b=KAWJYYGr8jd+oU6QJ/HI2IsvLhsMZv+LIDfCcz7CnSIABpmU79bRGcdxV3xcN1l/r0
         vI/YJhsJhecNfs6ltu9JXwVRAlFYNYDNmTlhJ86E5ed/vW9g7Hazy36EDxJQnZrlrMNH
         CCx4hq4gK8RTihOjoGPdgfPhmNLP8SURhYR2YvMcpCqgCqlXPDi4b6mdtIVn/TM/3Fdy
         R5QkHG7X14HOrhcILBVelSjSUX+6+FhyLNYGBjRDSiLN92Xg3+ThLhIJ+cqjekx5I+xz
         N0ZFxt9Qgd99CcdQPh++qk3Lq5zyX9kvuXNFTEa6ZfGb0ox62ZNUg2OaUnJd3VN6AC/9
         6Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848559; x=1750453359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjbM9cF25KXGnn6qxVrTsghFLkTaxiPsvyXuW5XtyJo=;
        b=LVhhVrOyCBVf1r1aP8UQmt7ZyapigqIluEOyZtpcdw0K704HdxKrRI6cU5H+cwW+u4
         ddb3SpnzXWlnYhN5Qe3+XbNmDlqq8qRC8z/qWle6BTDlh1cXYrk2dQbGTB6bobzVxG+u
         0+ALJ8mChbZDc8a8YBTZrdEaSRHRa7HE3fPs4pyatqYavGfhMcI93BANWnEU3uR4b6wN
         6OOnU3m9ipWQI1Ubuw7fbCbjJC6QjHAJRU6yWWAofkcySxoHOIGi/ppH5m96GBg/mK9I
         jmFSetmoWEpAjZVNNh+5Do0eNc4cEHI97OhG6udGcA23KPtWDstmebHmBM3XjK5OfYa0
         AaAQ==
X-Gm-Message-State: AOJu0YzB1mZWzyh2MXCTvrTuZHikhRqQhF/vSoGk6R3v2YajSQ5qfJs/
	r9zLIWp8gmQLqmVm6w/FgrJPx5whGpX2n8P7+1yX5xuE89UfF51bx9al32LsW6wwHyAITJzRVmg
	rjwBrOlmdq2cLAxHLXjH6l+7YycS8cFp4uXGa+9NTY9cauRMSacC3b264Nzc=
X-Gm-Gg: ASbGncsQu35Pe04TbA5Fuy1t8xTACorHVvCKDZpWuoHmCQ5oWcpa6iF/xU4hdB1Fqoy
	yPEvBYiQ0ZYZMuH5Srv0X69aij++1+4H1oH4hOCaHjvUSsgL5DnnbRFQ5HIyOvjf9ZEOmLVrtqG
	DTZoir1r3xX2TTUgPz57KiTbGhyhllExWJEY8ybDFMl4v9LPp/w0yva9yyYoqExb2qiFtxUMFE3
	Otlc1agI41xTTE=
X-Google-Smtp-Source: AGHT+IHqM4QSgzgPIC4N92Y6Q+MDqRpYDHhIklv1cFV90ZCgVU6c7b+8Arj0fpPEN8z8ahY4pOWXx9qH93GBDT+Z9aI=
X-Received: by 2002:ac8:57ce:0:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4a73dad76a0mr303301cf.15.1749848558263; Fri, 13 Jun 2025
 14:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
 <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
 <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com>
 <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com>
 <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com>
 <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com> <CADVnQyma3X8SFor8LgGL5_58G7TqH7-hgXeHSeHC+SKdH5CQkg@mail.gmail.com>
In-Reply-To: <CADVnQyma3X8SFor8LgGL5_58G7TqH7-hgXeHSeHC+SKdH5CQkg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 13 Jun 2025 17:02:21 -0400
X-Gm-Features: AX0GCFt2Sli-b-KtgrjUAcp3VG9jJ2S14afewl6fOJzmg--3Rm2ORpU_cGUHMcQ
Message-ID: <CADVnQymyjoCnO5S8C33X6=2WjZ-2Rcbrz1LXJ+kkP4OwFSS=jQ@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:23=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Tue, Jun 10, 2025 at 1:15=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> > >
> > > On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > > >
> > > > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > > >
> > > > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lis=
ts.ewheeler.net> wrote:
> > > > > > >
> > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev=
@lists.ewheeler.net> wrote:
> > > > > > > > >
> > > > > > > > > Hello Neal,
> > > > > > > > >
> > > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro S=
YS-2026T-6RFT+
> > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netge=
ar GS728TXS at
> > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP perform=
ance with
> > > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP=
 with devices
> > > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > > >
> > > > > > > > > Interestingly, the problem only presents itself when tran=
smitting
> > > > > > > > > from Linux; receive traffic (to Linux) performs just fine=
:
> > > > > > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch =
-> 1GbE  -> device
> > > > > > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch =
-> 10GbE -> Linux v6.6.85
> > > > > > > > >
> > > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > > >
> > > > > > > > >         tcp: fix to allow timestamp undo if no retransmit=
s were sent
> > > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5=
b882aadad69bb9e
> > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a=
337a8fb1591d45f
> >
> > Hi Eric,
> >
> > Do you have cycles to test a proposed fix patch developed by our team?
> >
> > The attached patch should apply (with "git am") for any recent kernel
> > that has the "tcp: fix to allow timestamp undo if no retransmits were
> > sent" patch it is fixing. So you should be able to test it on top of
> > the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> > easier.
> >
> > If you have cycles to rerun your iperf test, with  tcpdump, nstat, and
> > ss instrumentation, that would be fantastic!
> >
> > The patch passes our internal packetdrill test suite, including new
> > tests for this issue (based on the packetdrill scripts posted earlier
> > in this thread.
> >
> > But it would be fantastic to directly confirm that this fixes your issu=
e.
>
> Hi Eric (Wheeler),
>
> Just checking: would you be able to test that patch (from my previous
> message) in your environment?
>
> If not, given that the patch fixes our packetdrill reproducers, we can
> send the patch to the list as-is without that testing.

Update on this thread; I sent the patch to the netdev list:

[PATCH net] tcp: fix tcp_packet_delayed() for
tcp_is_non_sack_preventing_reopen() behavior

https://lore.kernel.org/netdev/20250613193056.1585351-1-ncardwell.sw@gmail.=
com/

best,
neal

