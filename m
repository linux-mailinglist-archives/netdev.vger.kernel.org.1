Return-Path: <netdev+bounces-201313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C13AE8F57
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9FF4A7A70
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900B2E11CB;
	Wed, 25 Jun 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txm3JOnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD32E11AC
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882761; cv=none; b=tRQ9xsBtWB3kG3QNuXlLGHhTpvSjyXjwV2jsYkmW0wLN1tWOPXex8X9+FPBNX5zstqPQnbQ4DfPcC1PB4t7/woDWhx2BdV1m6uxWehInAjzaBIaDSHJtBXxLJ12IpGQGgzt/SKAUDtAiZukWblMVxI/yiKJhJNJTSyuU+xZJAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882761; c=relaxed/simple;
	bh=0L2esfmFiFhTB36iSBZLhJibGf8ftsMFwaLLFtGrWS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNmWQLYdGmYCTbWwJupDgIhC/U6cVaoiGkTnfH16kG9Fx/gU8dzVWUMDY7by5syCzNS+w0UFIUeFMkZe74d1uOVt3URk1UcwfHaxGzH+KdAZ3JFVsOkpCqfW1nkQ0W2b6YghGLTELErcrY996hUHyAyWsqA4nlY4w6N6a37rfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txm3JOnd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a58ef58a38so49321cf.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750882758; x=1751487558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOjZADZYVIxfoeWvcituSzSbyNQOSzJnbqNqtpCK0QQ=;
        b=txm3JOnd7/AGBo5s+ShFn8IFx94gq0ZAjkY7WX6Fl8hwxX5il2ieyzn9Hh5IzbQmgh
         RFFWglApr4reYxMZ50vAVY4QG3BHxepNIppT826xJazNWMxRVIXu2WfJNd9bAr6OaZgo
         +OldIf/lLSVoDR5VQANizgLTuZCpAV5XnSFiyZ3xaOs1WFGHQNlcsVRM4UW2fBoOuYyD
         i/14On8Sh8J/oDtP/88nIrcrkQ0hdfSuNGJnLzuUUBF222AKhYIEWQmusW4ZaAQYMrAf
         cPSPgZ/MxzmBRpgZ9SloTRi/vAjygDNk+PVQQmsNmRE8yQuja1qzUM/cYPHk23NOb35R
         zowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882758; x=1751487558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOjZADZYVIxfoeWvcituSzSbyNQOSzJnbqNqtpCK0QQ=;
        b=aWPZJDKqlPMkNxzrGnHK/LMgPFE7EMIOs/V/ruHuBizsu/MOkUvhVOgjnoqeXOaoUz
         R/2Ho/ypaY09yCSOfn2C4i5dDETQ60VcfGmgnizNJL+5s7dmPmQPjUpzx8RBvNIs2g9N
         +7BUIGTF1PEv41JA0OViTBIZWbAk/8UkUpXbH0MKwNpXRVIODdA3fhBZefx0oXP4oQr+
         mokhaAtbK/J5GGtuopQgZm3Wt8tBNISVsw3JmkHValfhrHBEtLhm4MdZ0t/bxO1/sRK7
         2DoL539oQPAxT/8iAkzG5x1LZtsGDYjuJOx2XAL/w251AKXeq41tSmTiSLt8/SV8zT+E
         YmFQ==
X-Gm-Message-State: AOJu0YyqqYN62iT44Q7zf6VYesZDQ81sQbH+fqGLukt8q7gAa1WhTZjB
	DA1LDEccGoQvPfVkOJmub8FVdFTCQmotNZFqYqXFv6r67s9oQFyi7opn09n/eFHE8yJZQqXF8CI
	a0BmWEb/Wia1XNbFgPVBPoObCCx0Y54+W7fNSqwI1
X-Gm-Gg: ASbGncto+PHMUmZ4ZuyFWLOyrk6jeNkMj92OjAbSPCVS1LSwnx2/W2Ywy2/z5mZkvQH
	YPbJ1JG35W+upidDU7strKWiu5SnPSVINwCjqj7zs4/x758/ijg1aAB8NQiuY0jkCxIFnBqrRtK
	k0x6g5kJoYAuQE4aWPvUpepzAxBRSDL8QiUAC4g+RdfNY=
X-Google-Smtp-Source: AGHT+IEyzIcZfwgqfQfi8x/hpFs7Vcm0PV1pO0AmS4XJd15BEKOB+LgueCp3NR+2TJrvlELAM/oAThqzMV31wLDpQpI=
X-Received: by 2002:ac8:578b:0:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4a7f3b491f7mr631771cf.9.1750882757876; Wed, 25 Jun 2025
 13:19:17 -0700 (PDT)
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
 <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
 <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net> <a8579544-a9de-63ae-61ed-283c872289a@ewheeler.net>
 <CADVnQymCso04zj8N0DYP9EkhTwXqtbsCu1xLxAUC60rSd09Rkw@mail.gmail.com>
 <452b3c16-b994-a627-c737-99358be8b030@ewheeler.net> <9c82e38f-8253-3e41-a5f-dfbb261165ca@ewheeler.net>
In-Reply-To: <9c82e38f-8253-3e41-a5f-dfbb261165ca@ewheeler.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 25 Jun 2025 16:19:01 -0400
X-Gm-Features: Ac12FXx0hhKAsfICNTwCWjhSQQvMvILqg0jmXeK6OS5U3XETWI6YBuwT625L-l4
Message-ID: <CADVnQy=mrWeWWTV9YpTaH7G9QvW-qOd_VH5B4=vTxR6rZKwe4A@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 3:17=E2=80=AFPM Eric Wheeler <netdev@lists.ewheeler=
.net> wrote:
>
> On Wed, 18 Jun 2025, Eric Wheeler wrote:
> > On Mon, 16 Jun 2025, Neal Cardwell wrote:
> > > On Mon, Jun 16, 2025 at 4:14=E2=80=AFPM Eric Wheeler <netdev@lists.ew=
heeler.net> wrote:
> > > > On Sun, 15 Jun 2025, Eric Wheeler wrote:
> > > > > On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > > > > > On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncardwell=
@google.com> wrote:
> > > > > > > On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwe=
ll@google.com> wrote:
> > > > > > > > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncard=
well@google.com> wrote:
> > > > > > > > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <nca=
rdwell@google.com> wrote:
> > > > > > > > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <ne=
tdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler=
 <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > > > After upgrading to Linux v6.6.85 on an older Supe=
rmicro SYS-2026T-6RFT+
> > > > > > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to=
 a Netgear GS728TXS at
> > > > > > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP=
 performance with
> > > > > > > > > > > > > existing devices on 1Gbit ports was <60Mbit; howe=
ver, TCP with devices
> > > > > > > > > > > > > across the switch on 10Gbit ports runs at full 10=
GbE.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Through bisection, we found this first-bad commit=
:
> > > > > > > > > > > > >
> > > > > > > > > > > > >         tcp: fix to allow timestamp undo if no re=
transmits were sent
> > > > > > > > > > > > >                 upstream:       e37ab7373696e650d=
3b6262a5b882aadad69bb9e
> > > > > > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb=
718b5e7a337a8fb1591d45f
> > > > > >
> > > > >
> > > > > > The attached patch should apply (with "git am") for any recent =
kernel
> > > > > > that has the "tcp: fix to allow timestamp undo if no retransmit=
s were
> > > > > > sent" patch it is fixing. So you should be able to test it on t=
op of
> > > > > > the 6.6 stable or 6.15 stable kernels you used earlier. Whichev=
er is
> > > > > > easier.
> > > >
> > > > Definitely better, but performance is ~15% slower vs reverting, and=
 the
> > > > retransmit counts are still higher than the other.  In the two sect=
ions
> > > > below you can see the difference between after the fix and after th=
e
> > > > revert.
> > > >
> > >
> > > Would you have cycles to run the "after-fix" and "after-revert-6.6.93=
"
> > > cases multiple times, so we can get a sense of what is signal and wha=
t
> > > is noise? Perhaps 20 or 50 trials for each approach?
> >
> > I ran 50 tests after revert and compare that to after the fix using bot=
h
> > average and geometric mean, and it still appears to be slightly slower
> > then with the revert alone:
> >
> >       # after-revert-6.6.93
> >       Arithmetic Mean: 843.64 Mbits/sec
> >       Geometric Mean: 841.95 Mbits/sec
> >
> >       # after-tcp-fix-6.6.93
> >       Arithmetic Mean: 823.00 Mbits/sec
> >       Geometric Mean: 819.38 Mbits/sec
> >
>
> Re-sending this question in case this message got lost:
>
> > Do you think that this is an actual performance regression, or just a
> > sample set that is not big enough to work out the averages?
> >
> > Here is the data collected for each of the 50 tests:
> >       - https://www.linuxglobal.com/out/for-neal/after-revert-6.6.93.ta=
r.gz
> >       - https://www.linuxglobal.com/out/for-neal/after-tcp-fix-6.6.93.t=
ar.gz

Hi Eric,

Many thanks for this great data!

I have been looking at this data. It's quite interesting.

Looking at the CDF of throughputs for the "revert" cases vs the "fix"
cases (attached) it does look like for the 70-th percentile and below
(the 70% of most unlucky cases), the "fix" cases have a throughput
that is lower, and IMHO this looks outside the realm of what we would
expect from noise.

However, when I look at the traces, I don't see any reason why the
"fix" cases would be systematically slower. In particular, the "fix"
and "revert" cases are only changing a function used for "undo"
decisions, but for both the "fix" or "revert" cases, there are no
"undo" events, and I don't see cases with spurious retransmissions
where there should have been "undo" events and yet there were not.

Visually inspecting the traces, the dominant determinant of
performance seems to be how many RTO events there were. For example,
the worst case for the "fix" trials has 16 RTOs, whereas the worst
case for the "revert" trials has 13 RTOs. And the number of RTO events
per trial looks random; I see similar qualitative patterns between
"fix" and "revert" cases, and don't see any reason why there are more
RTOs in the "fix" cases than the "revert" cases. All the RTOs seem to
be due to pre-existing (longstanding) performance problems in non-SACK
loss recovery.

One way to proceed would be for me to offer some performance fixes for
the RTOs, so we can get rid of the RTOs, which are the biggest source
of performance variation. That should greatly reduce noise, and
perhaps make it easier to see if there is any real difference between
"fix" and "revert" cases.

We could compare the following two kernels, with another 50 tests for
each of two kernels:

+ (a) 6.6.93 + {2 patches to fix RTOs} + "revert"
+ (b) 6.6.93 + {2 patches to fix RTOs} + "fix"

where:

"revert" =3D  revert e37ab7373696 ("tcp: fix to allow timestamp undo if
no retransmits were sent")
"fix" =3D apply d0fa59897e04 ("tcp: fix tcp_packet_delayed() for
tcp_is_non_sack_preventing_reopen() behavior"

This would have the side benefit of testing some performance
improvements for non-SACK connections.

Are you up for that? :-)

Best regards,
neal

