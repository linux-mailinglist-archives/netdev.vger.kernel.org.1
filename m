Return-Path: <netdev+bounces-197128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01FAD79B9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C13D170C7A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E92BE7C7;
	Thu, 12 Jun 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE7hGABC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0B2BEC21
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749752600; cv=none; b=N7ZOvMa0A46WvrBaC50iVszjQjPqNmmROoUmB2NuqaWCZDrnnfuJ0pFoLmjsoAUdL3Qapz42fsyzEUE5+/P8YLP5f6E48Mg1Psqry2NqfJQ+ffKYs8z4iJP38wj40v4N+ob7GYnZg6PbBzyY6Pwm8ArZLEyW3jhwwDb+3xQ6st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749752600; c=relaxed/simple;
	bh=Q5HgL/aMK5uUSILA27ANV0tdnpNtrWa5D0IMBAsM6/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgbkdkTY6TYDaKpUQmyVspLq8+A2e4PufEM1d2S/d4OFBx9qmungoIyflqdd6EcEvMW01ZS3RyVvAFYywme9JP+yAGJt0DCceUrnumSXxdlZPunVUQDcizsWYay3bd52mOVlu3WpAUW/w4vO6yzzE8EHfJy9KeZXXiP9oKcbAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE7hGABC; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47e9fea29easo55311cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749752598; x=1750357398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEc3qmoPo+sax3JOYFEsLKd3AyaC3SN+m/UpYMZqLaQ=;
        b=qE7hGABCPXH6UyZgCkmVo2WUTpPpuwTVdKUiY2NcgX7bzgBEvOh+I/8iAtslrHfopr
         4RHHcgLE+AHfJ1k0OA3JY3JjpefRjeFANAM3t5rpg1iEHe5WAU25q0/YXJT/zjWom06y
         XOy3E261CPgsrMlICOhtDfUtocrsrk9vJQ3pTHSCEHxibZhLcyFQJ2dbjASbPWu2HRma
         9bgODD6TmlVwpWDaV1URvgOTmH0uol7+TCZGDD5UeSd1QIcUmzQvdaZblNNTjzahMGHA
         HW+J9x1jtm82BJlZ7Rp01SEpVQLnG6gurOFn4ysFSiL5p+FQ6yAFvl5roIzKA5aKb+XU
         aENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749752598; x=1750357398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEc3qmoPo+sax3JOYFEsLKd3AyaC3SN+m/UpYMZqLaQ=;
        b=R66W7tWmz8IHGkV4lAYMPPHJ8vkD/+5p3sTJ3Ins9rUpThMIxQftQ4g1JvNurnQGuV
         Ba3jbN5zQRX0dYJHA9qesyGChDmiYdkvm62mNk+TXkSfXn6Udz0Tcf7d9+PRuvordO3m
         YZ7Bk55d4ejs1GRhANe9J4Gw6GKrfESjvSFrCLH8Bh1dCePRERfEGt2cQlR5sJJUDuy2
         ycYOJSZH7/h1SQIoCYLrke7UntssyiwRbYp6QBAdOY4m9RhiSmdXAAbU/ql4Gb/feZLz
         wcWBmzYRccbr02zP4mT6awC6Et9wRNgJHkxSywOjLPrKzhrbLi+o6tDNwF4J8mt0DYW/
         8mhg==
X-Gm-Message-State: AOJu0YxAmORYvr2hgQjc21O6WTuJeC9VhtAEkyA1NxoFISygFFkV0ZbY
	J3x45ASIgEPD1Q1C6G/yDFCPnJC3b7sBOXx+OMVLJEN/44X/fHiSzL5ERpIt9/+AsDGfh4AK5/s
	phZkHVrt+pEpM2IfBNtJu4J8DCetVknrRoWqTx37b
X-Gm-Gg: ASbGncsyYW+taLXfHo84zhb2uNC9yCI62B9HAcVLP5le6reSRneFUd8MrU0+k8Fivku
	v1qw4lXYi9fVy5Qf/iTuqMozZVexZHKXbzKLoEs5zJ49PwoyZO+1R8xfLyZMcOZfNKIi+PWVLJv
	hN5B2195mSm1jXzTuy324TArv/TQTrHRMa+JRR5wSWPiM7lCx7wT2BnCF680fY6H0tANF25+K1b
	GnH
X-Google-Smtp-Source: AGHT+IFGmpSqo0JAVAzSlpzikJEA9w2uZWbRcN0hM2jAyLRHHvYfcGWjId0uiUvuSouN26fWzVJGv1QuBi51AKbb50w=
X-Received: by 2002:ac8:5d4c:0:b0:4a4:3099:60fe with SMTP id
 d75a77b69052e-4a72fdb3839mr464581cf.21.1749752597658; Thu, 12 Jun 2025
 11:23:17 -0700 (PDT)
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
 <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com> <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
In-Reply-To: <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 12 Jun 2025 14:23:01 -0400
X-Gm-Features: AX0GCFvtTFvq_C_3RttyrbwMHhHpWyUOvTxid1pNHiC1S7ZOhRDH1_iNIaQxfwI
Message-ID: <CADVnQyma3X8SFor8LgGL5_58G7TqH7-hgXeHSeHC+SKdH5CQkg@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:15=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> > >
> > > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > > >
> > > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > > >
> > > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists=
.ewheeler.net> wrote:
> > > > > >
> > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@l=
ists.ewheeler.net> wrote:
> > > > > > > >
> > > > > > > > Hello Neal,
> > > > > > > >
> > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS=
-2026T-6RFT+
> > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear=
 GS728TXS at
> > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performan=
ce with
> > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP w=
ith devices
> > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > >
> > > > > > > > Interestingly, the problem only presents itself when transm=
itting
> > > > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch ->=
 1GbE  -> device
> > > > > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch ->=
 10GbE -> Linux v6.6.85
> > > > > > > >
> > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > >
> > > > > > > >         tcp: fix to allow timestamp undo if no retransmits =
were sent
> > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b8=
82aadad69bb9e
> > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a33=
7a8fb1591d45f
>
> Hi Eric,
>
> Do you have cycles to test a proposed fix patch developed by our team?
>
> The attached patch should apply (with "git am") for any recent kernel
> that has the "tcp: fix to allow timestamp undo if no retransmits were
> sent" patch it is fixing. So you should be able to test it on top of
> the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> easier.
>
> If you have cycles to rerun your iperf test, with  tcpdump, nstat, and
> ss instrumentation, that would be fantastic!
>
> The patch passes our internal packetdrill test suite, including new
> tests for this issue (based on the packetdrill scripts posted earlier
> in this thread.
>
> But it would be fantastic to directly confirm that this fixes your issue.

Hi Eric (Wheeler),

Just checking: would you be able to test that patch (from my previous
message) in your environment?

If not, given that the patch fixes our packetdrill reproducers, we can
send the patch to the list as-is without that testing.

Thanks,
neal

