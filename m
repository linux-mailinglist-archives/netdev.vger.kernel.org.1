Return-Path: <netdev+bounces-201355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFBAE9208
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10047176FFE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5432BD598;
	Wed, 25 Jun 2025 23:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FB1DB958
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893323; cv=none; b=bynqkVyEZPofdMLh+7ZQSY8RFhGfyA7c8Vmob9FhkZgvahAeAeBQ9JdwCWEGwo8tU+6I1wIyUYZXADc7ItzIi/eWZzRYhMHvGtnTjBdWpD9ZZe3E2do2yRXRSdLM0B0jUyeMvmnFLZD0Yvj8a1/bv0Rfua3XXnwI1VAA39TNm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893323; c=relaxed/simple;
	bh=LrOXdLjoAIESqU7TKPyQT80aiYS+kVo1QLK1NKi4MiU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wf6I7Ox6iWXqUMroYgvNM2KcwOelriDkTO9mTCSRX/oMxlhl7g0Juq7RKnOgLVpxVx5pgi4PG+6aIZbr+0vECzME1Krs/1/fu1P7gRpzk58w/I+PO5YrOAuIqA2IlwatXAPrPdr42L4Ft11NROTYUbHmTcAodJklTiZVTacgojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id C8BBA8A;
	Wed, 25 Jun 2025 16:15:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WHNxGZ_UdHU0; Wed, 25 Jun 2025 16:15:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6D7E541;
	Wed, 25 Jun 2025 16:15:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6D7E541
Date: Wed, 25 Jun 2025 16:15:19 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
    stable@kernel.org
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
In-Reply-To: <CADVnQy=mrWeWWTV9YpTaH7G9QvW-qOd_VH5B4=vTxR6rZKwe4A@mail.gmail.com>
Message-ID: <294fe4ea-eb6c-3dc3-9c5-66f69514bc94@ewheeler.net>
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net> <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com> <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com> <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com> <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com> <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
 <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net> <a8579544-a9de-63ae-61ed-283c872289a@ewheeler.net> <CADVnQymCso04zj8N0DYP9EkhTwXqtbsCu1xLxAUC60rSd09Rkw@mail.gmail.com> <452b3c16-b994-a627-c737-99358be8b030@ewheeler.net> <9c82e38f-8253-3e41-a5f-dfbb261165ca@ewheeler.net>
 <CADVnQy=mrWeWWTV9YpTaH7G9QvW-qOd_VH5B4=vTxR6rZKwe4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-979129657-1750893319=:5615"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-979129657-1750893319=:5615
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 25 Jun 2025, Neal Cardwell wrote:
> On Wed, Jun 25, 2025 at 3:17 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> >
> > On Wed, 18 Jun 2025, Eric Wheeler wrote:
> > > On Mon, 16 Jun 2025, Neal Cardwell wrote:
> > > > On Mon, Jun 16, 2025 at 4:14 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > On Sun, 15 Jun 2025, Eric Wheeler wrote:
> > > > > > On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > > > > > > On Mon, Jun 9, 2025 at 1:45 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > > > On Sat, Jun 7, 2025 at 7:26 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > > > > On Sat, Jun 7, 2025 at 6:54 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > > > > > On Sat, Jun 7, 2025 at 3:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > > > > > > On Fri, Jun 6, 2025 at 6:34 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > > > > > > On Thu, Jun 5, 2025 at 9:33 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> > > > > > > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> > > > > > > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > > > > > > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> > > > > > > > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >         tcp: fix to allow timestamp undo if no retransmits were sent
> > > > > > > > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
> > > > > > > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
> > > > > > >
> > > > > >
> > > > > > > The attached patch should apply (with "git am") for any recent kernel
> > > > > > > that has the "tcp: fix to allow timestamp undo if no retransmits were
> > > > > > > sent" patch it is fixing. So you should be able to test it on top of
> > > > > > > the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> > > > > > > easier.
> > > > >
> > > > > Definitely better, but performance is ~15% slower vs reverting, and the
> > > > > retransmit counts are still higher than the other.  In the two sections
> > > > > below you can see the difference between after the fix and after the
> > > > > revert.
> > > > >
> > > >
> > > > Would you have cycles to run the "after-fix" and "after-revert-6.6.93"
> > > > cases multiple times, so we can get a sense of what is signal and what
> > > > is noise? Perhaps 20 or 50 trials for each approach?
> > >
> > > I ran 50 tests after revert and compare that to after the fix using both
> > > average and geometric mean, and it still appears to be slightly slower
> > > then with the revert alone:
> > >
> > >       # after-revert-6.6.93
> > >       Arithmetic Mean: 843.64 Mbits/sec
> > >       Geometric Mean: 841.95 Mbits/sec
> > >
> > >       # after-tcp-fix-6.6.93
> > >       Arithmetic Mean: 823.00 Mbits/sec
> > >       Geometric Mean: 819.38 Mbits/sec
> > >
> >
> > Re-sending this question in case this message got lost:
> >
> > > Do you think that this is an actual performance regression, or just a
> > > sample set that is not big enough to work out the averages?
> > >
> > > Here is the data collected for each of the 50 tests:
> > >       - https://www.linuxglobal.com/out/for-neal/after-revert-6.6.93.tar.gz
> > >       - https://www.linuxglobal.com/out/for-neal/after-tcp-fix-6.6.93.tar.gz
> 
> Hi Eric,
> 
> Many thanks for this great data!
> 
> I have been looking at this data. It's quite interesting.
> 
> Looking at the CDF of throughputs for the "revert" cases vs the "fix"
> cases (attached) it does look like for the 70-th percentile and below
> (the 70% of most unlucky cases), the "fix" cases have a throughput
> that is lower, and IMHO this looks outside the realm of what we would
> expect from noise.
> 
> However, when I look at the traces, I don't see any reason why the
> "fix" cases would be systematically slower. In particular, the "fix"
> and "revert" cases are only changing a function used for "undo"
> decisions, but for both the "fix" or "revert" cases, there are no
> "undo" events, and I don't see cases with spurious retransmissions
> where there should have been "undo" events and yet there were not.
> 
> Visually inspecting the traces, the dominant determinant of
> performance seems to be how many RTO events there were. For example,
> the worst case for the "fix" trials has 16 RTOs, whereas the worst
> case for the "revert" trials has 13 RTOs. And the number of RTO events
> per trial looks random; I see similar qualitative patterns between
> "fix" and "revert" cases, and don't see any reason why there are more
> RTOs in the "fix" cases than the "revert" cases. All the RTOs seem to
> be due to pre-existing (longstanding) performance problems in non-SACK
> loss recovery.
> 
> One way to proceed would be for me to offer some performance fixes for
> the RTOs, so we can get rid of the RTOs, which are the biggest source
> of performance variation. That should greatly reduce noise, and
> perhaps make it easier to see if there is any real difference between
> "fix" and "revert" cases.
> 
> We could compare the following two kernels, with another 50 tests for
> each of two kernels:
> 
> + (a) 6.6.93 + {2 patches to fix RTOs} + "revert"
> + (b) 6.6.93 + {2 patches to fix RTOs} + "fix"
> 
> where:
> 
> "revert" =  revert e37ab7373696 ("tcp: fix to allow timestamp undo if
> no retransmits were sent")
> "fix" = apply d0fa59897e04 ("tcp: fix tcp_packet_delayed() for
> tcp_is_non_sack_preventing_reopen() behavior"
> 
> This would have the side benefit of testing some performance
> improvements for non-SACK connections.
> 
> Are you up for that? :-)


Sure, if you have some patch ideas in mind, I'm all for getting patches 
merged improve performance.  

BTW, what causes a non-SACK connection?  The RX side is a near-idle Linux 
6.8 host default sysctl settings.


--
Eric Wheeler


> 
> Best regards,
> neal
> 
--8323328-979129657-1750893319=:5615--

