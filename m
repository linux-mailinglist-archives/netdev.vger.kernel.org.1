Return-Path: <netdev+bounces-201593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ACDAEA06B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C743B71C8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB928983C;
	Thu, 26 Jun 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9Ldoqhm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2D2010EE
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947739; cv=none; b=oFAMEekRhBxCW3/yFK1Z0sVLu/3tfeGFqoavA+5mhBqTCBW0t+3MXsou3Y8FgGoeVKmNG4Cx0mvcWVGnOFj260Cds1iQpioJMjxQFptIvQ6Nf58g8ffJrSlV8Uv9Xmj+RHPwoA8qtfRtBtyRz5jOnU0VUx+pB8LQ0RyOZMpoxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947739; c=relaxed/simple;
	bh=H0Bi38PPk0vOtnIfzY/yasIxKSXTLlt+jTpyLku5jj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4GhnD3cRaKWExOLtzQf3Hrbm1l+EKt6Ine+IA/W/tmUsTpYLgU+wYgpeTw2MY36Wr+RnyWJqdvP9rmGtPboBf2XKnGInVVSQlvyRmWc8TP5vXdbiibtCS4xT/QYgmzqNpkt45Av/GiJtPlGy2In02nLeJ8it/yBYb8/WX2AlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9Ldoqhm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5ac8fae12so437671cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750947737; x=1751552537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+wGG38WXlXqwLcdmg8nGj7RY2byumzgwE5tCCCm4lA=;
        b=Z9Ldoqhms4H3F1bnMsmv9EadbCeEjkIn9RbpBDVo9OtZY0KGOC05ABcDyQ+9jOaSfq
         9Phbp9HfJahqiIUDmgt0rrdgWU4PlG7gf4rvIJZ27XlRDE2aoz/zuyutEcTIYViv3Hmo
         ULxMPs193lZsErSHOGoEb3RdgCc9UTlhuCwVDzyNc3DZcTR4GqA4lK6ZB3FdXQSUK1OB
         q+CmX+nJR3kgvfEJHmhbn3nHMZ1IrQzLCbQM591BTK6QmUzFXMhzTTKAWExpiYek/uiV
         CHX8sz+CDBJ+/3ZS1wDNV8r5N+I7barAqrjmRVmJ40PhOwnUSlsu1ki55EA3n9HFvphW
         y4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947737; x=1751552537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+wGG38WXlXqwLcdmg8nGj7RY2byumzgwE5tCCCm4lA=;
        b=edEHRsFymLDd46fkKzpvJFhKU+3r6QegVapEfUqg26Bp2+TJHy00a5H0xGv1qP8upp
         AcwOqwiBuSddfOE2JRcJK3WfLqvJgUWFTJVVoRs1LBMAl8GdRsADzCj49YHmota0Kqxl
         qyqp6cbCzHqvrwn4klB4iGsR+mOddl2gvl33fiAkPlph4dpZJhYPvIyapaDOxkUTQAqI
         jVK5PmmszVQe0JMafHqOiikhLeRZD8p/Eo040GJBcVb3G7N8h9A1ke8r0tvN4iPr4HLB
         PZdjweUMChb6cJoZ6fZjmTjbGKua1x0DRT7rBeWE6Gl4BQrgjuXiwfG1VcjpMTcKVsWo
         XvHA==
X-Gm-Message-State: AOJu0YyT9J636TnxStmqKI61WLiSULLCTOELm/3ECKe61ndeJXOYJAkT
	LGh/KLvBiJdg8rgE2//Nd5fRena3GCt/LAydAmlDNEZt5SR3q5cQ5BqQHMOcVb8hVISB0x9fB0a
	t9ygbIU4pPhe5s26tRqyO/fZIFT84hbBr/ypHEk7T
X-Gm-Gg: ASbGnctjU1oL9IhNEAs5DBY/+tWEfEKxPPuCV/F5iaHocTy3Is7d4L6Cd7t3bLIu0wE
	ipGcwAWDbN4b6VtCaM0wIxw3YpkJIqT4X7TomyC0NC+xCCQZqus7zNyLDYSe81MIn7yNmuYhdkM
	bwdOWsmueQQOtdmHs4WmME0hMsieGI6F/h2Z8u+Ye/N14=
X-Google-Smtp-Source: AGHT+IGWnr+V0ljfXEjBIb2zPL6KrGoYXuwsUUQU4+7kA/DDunIoYe0esROsXYwNL1HrTn5TwvpQ3hDFin5cQR62sYw=
X-Received: by 2002:a05:622a:7d0f:b0:4a7:71e2:f873 with SMTP id
 d75a77b69052e-4a7f3a01382mr3681011cf.22.1750947736308; Thu, 26 Jun 2025
 07:22:16 -0700 (PDT)
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
 <CADVnQy=mrWeWWTV9YpTaH7G9QvW-qOd_VH5B4=vTxR6rZKwe4A@mail.gmail.com> <294fe4ea-eb6c-3dc3-9c5-66f69514bc94@ewheeler.net>
In-Reply-To: <294fe4ea-eb6c-3dc3-9c5-66f69514bc94@ewheeler.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 26 Jun 2025 10:21:59 -0400
X-Gm-Features: Ac12FXxKlU7yxv_lMG_ltk3pCxTJqOOmy11Joia7AaNpOLnDunokT3ZaHkUSQEc
Message-ID: <CADVnQym2vbWXHSVhyc6-QZLg-ASJfM-SCzu1tRsyapD_ms9S_w@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:15=E2=80=AFPM Eric Wheeler <netdev@lists.ewheeler=
.net> wrote:
>
> On Wed, 25 Jun 2025, Neal Cardwell wrote:
> > On Wed, Jun 25, 2025 at 3:17=E2=80=AFPM Eric Wheeler <netdev@lists.ewhe=
eler.net> wrote:
> > >
> > > On Wed, 18 Jun 2025, Eric Wheeler wrote:
> > > > On Mon, 16 Jun 2025, Neal Cardwell wrote:
> > > > > On Mon, Jun 16, 2025 at 4:14=E2=80=AFPM Eric Wheeler <netdev@list=
s.ewheeler.net> wrote:
> > > > > > On Sun, 15 Jun 2025, Eric Wheeler wrote:
> > > > > > > On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > > > > > > > On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncard=
well@google.com> wrote:
> > > > > > > > > On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <nca=
rdwell@google.com> wrote:
> > > > > > > > > > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <n=
cardwell@google.com> wrote:
> > > > > > > > > > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell =
<ncardwell@google.com> wrote:
> > > > > > > > > > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler=
 <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > > > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Whe=
eler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > > > > > After upgrading to Linux v6.6.85 on an older =
Supermicro SYS-2026T-6RFT+
> > > > > > > > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linke=
d to a Netgear GS728TXS at
> > > > > > > > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found=
 TCP performance with
> > > > > > > > > > > > > > > existing devices on 1Gbit ports was <60Mbit; =
however, TCP with devices
> > > > > > > > > > > > > > > across the switch on 10Gbit ports runs at ful=
l 10GbE.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Through bisection, we found this first-bad co=
mmit:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >         tcp: fix to allow timestamp undo if n=
o retransmits were sent
> > > > > > > > > > > > > > >                 upstream:       e37ab7373696e=
650d3b6262a5b882aadad69bb9e
> > > > > > > > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6=
fdeb718b5e7a337a8fb1591d45f
> > > > > > > >
> > > > > > >
> > > > > > > > The attached patch should apply (with "git am") for any rec=
ent kernel
> > > > > > > > that has the "tcp: fix to allow timestamp undo if no retran=
smits were
> > > > > > > > sent" patch it is fixing. So you should be able to test it =
on top of
> > > > > > > > the 6.6 stable or 6.15 stable kernels you used earlier. Whi=
chever is
> > > > > > > > easier.
> > > > > >
> > > > > > Definitely better, but performance is ~15% slower vs reverting,=
 and the
> > > > > > retransmit counts are still higher than the other.  In the two =
sections
> > > > > > below you can see the difference between after the fix and afte=
r the
> > > > > > revert.
> > > > > >
> > > > >
> > > > > Would you have cycles to run the "after-fix" and "after-revert-6.=
6.93"
> > > > > cases multiple times, so we can get a sense of what is signal and=
 what
> > > > > is noise? Perhaps 20 or 50 trials for each approach?
> > > >
> > > > I ran 50 tests after revert and compare that to after the fix using=
 both
> > > > average and geometric mean, and it still appears to be slightly slo=
wer
> > > > then with the revert alone:
> > > >
> > > >       # after-revert-6.6.93
> > > >       Arithmetic Mean: 843.64 Mbits/sec
> > > >       Geometric Mean: 841.95 Mbits/sec
> > > >
> > > >       # after-tcp-fix-6.6.93
> > > >       Arithmetic Mean: 823.00 Mbits/sec
> > > >       Geometric Mean: 819.38 Mbits/sec
> > > >
> > >
> > > Re-sending this question in case this message got lost:
> > >
> > > > Do you think that this is an actual performance regression, or just=
 a
> > > > sample set that is not big enough to work out the averages?
> > > >
> > > > Here is the data collected for each of the 50 tests:
> > > >       - https://www.linuxglobal.com/out/for-neal/after-revert-6.6.9=
3.tar.gz
> > > >       - https://www.linuxglobal.com/out/for-neal/after-tcp-fix-6.6.=
93.tar.gz
> >
> > Hi Eric,
> >
> > Many thanks for this great data!
> >
> > I have been looking at this data. It's quite interesting.
> >
> > Looking at the CDF of throughputs for the "revert" cases vs the "fix"
> > cases (attached) it does look like for the 70-th percentile and below
> > (the 70% of most unlucky cases), the "fix" cases have a throughput
> > that is lower, and IMHO this looks outside the realm of what we would
> > expect from noise.
> >
> > However, when I look at the traces, I don't see any reason why the
> > "fix" cases would be systematically slower. In particular, the "fix"
> > and "revert" cases are only changing a function used for "undo"
> > decisions, but for both the "fix" or "revert" cases, there are no
> > "undo" events, and I don't see cases with spurious retransmissions
> > where there should have been "undo" events and yet there were not.
> >
> > Visually inspecting the traces, the dominant determinant of
> > performance seems to be how many RTO events there were. For example,
> > the worst case for the "fix" trials has 16 RTOs, whereas the worst
> > case for the "revert" trials has 13 RTOs. And the number of RTO events
> > per trial looks random; I see similar qualitative patterns between
> > "fix" and "revert" cases, and don't see any reason why there are more
> > RTOs in the "fix" cases than the "revert" cases. All the RTOs seem to
> > be due to pre-existing (longstanding) performance problems in non-SACK
> > loss recovery.
> >
> > One way to proceed would be for me to offer some performance fixes for
> > the RTOs, so we can get rid of the RTOs, which are the biggest source
> > of performance variation. That should greatly reduce noise, and
> > perhaps make it easier to see if there is any real difference between
> > "fix" and "revert" cases.
> >
> > We could compare the following two kernels, with another 50 tests for
> > each of two kernels:
> >
> > + (a) 6.6.93 + {2 patches to fix RTOs} + "revert"
> > + (b) 6.6.93 + {2 patches to fix RTOs} + "fix"
> >
> > where:
> >
> > "revert" =3D  revert e37ab7373696 ("tcp: fix to allow timestamp undo if
> > no retransmits were sent")
> > "fix" =3D apply d0fa59897e04 ("tcp: fix tcp_packet_delayed() for
> > tcp_is_non_sack_preventing_reopen() behavior"
> >
> > This would have the side benefit of testing some performance
> > improvements for non-SACK connections.
> >
> > Are you up for that? :-)
>
>
> Sure, if you have some patch ideas in mind, I'm all for getting patches
> merged improve performance.

Great! Thanks for being willing to do this! I will try to post some
patches ASAP.

> BTW, what causes a non-SACK connection?  The RX side is a near-idle Linux
> 6.8 host default sysctl settings.

Given the RX side is a Linux 6.8 host, the kernel should be supporting
TCP SACK due to kernel compile-time defaults (see the
"net->ipv4.sysctl_tcp_sack =3D 1;" in net/ipv4/tcp_ipv4.c.

Given that factor, off-hand, I can think of only a few reasons why the
RX side would not negotiate SACK support:

(1) Some script or software on the RX machine has disabled SACK via
"sysctl net.ipv4.tcp_sack=3D0" or equivalent, perhaps at boot time (this
is easy to check with "sysctl net.ipv4.tcp_sack").

(2) There is a middlebox on the path (doing firewalling or NAT, etc)
that disables SACK

(3) There is a firewall rule on some machine or router/switch that disables=
 SACK

Off-hand, I would think that (2) is the most likely case, since
intentionally disabling SACK via sysctl or firewall rule is
inadvisable and rare.

Any thoughts on which of these might be in play here?

Thanks,
neal

