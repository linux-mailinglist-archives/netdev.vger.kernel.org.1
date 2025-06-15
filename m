Return-Path: <netdev+bounces-197893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17430ADA342
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2097A4881
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1926057B;
	Sun, 15 Jun 2025 20:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A002F189F56
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750017977; cv=none; b=ZP3IkMTd5968QOLmLtM+5Jn+SQLK9KorNJvuMS8X8vOeqeaUDf8CUC50pGlDAyo11rfWFlL3FV0hCCXmkeyc3zg2u03tVjvREddt6WnETNcACeVIvWGGUDMi5OzmowfPMnXQdpiUPZqiKYXnVm6QoGw66i4ZgX18KEaTEfn8Kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750017977; c=relaxed/simple;
	bh=zeAJ25YDks9MdjPScwT5YU3TjSQqzTzZRE9qybtsQLk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L6//7e1BfFWRLjFLCpJfCZEsbIThLVxHYROEojKnBLwtC32QBhuBYZ+1GSVFswibnUPMBI95D7jymH9TQrxTGPC7svZZBHtdJlwwvt4YeH+lf1Yyf4Xr5XySaZs18qrcCu3Rg9f9oxr1r20dNMSYDzvbZ4kiRxOQMixeHhylrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id DF1AC41;
	Sun, 15 Jun 2025 13:00:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id L1_huhcQxvLK; Sun, 15 Jun 2025 13:00:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6927784;
	Sun, 15 Jun 2025 13:00:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6927784
Date: Sun, 15 Jun 2025 13:00:44 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
    stable@kernel.org
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
In-Reply-To: <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
Message-ID: <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net>
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net> <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com> <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com> <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com> <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com>
 <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1509259382-1750017645=:21862"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1509259382-1750017645=:21862
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jun 2025, Neal Cardwell wrote:
> On Mon, Jun 9, 2025 at 1:45 PM Neal Cardwell <ncardwell@google.com> wrote:
> >
> > On Sat, Jun 7, 2025 at 7:26 PM Neal Cardwell <ncardwell@google.com> wrote:
> > >
> > > On Sat, Jun 7, 2025 at 6:54 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > >
> > > > On Sat, Jun 7, 2025 at 3:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > >
> > > > > On Fri, Jun 6, 2025 at 6:34 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > >
> > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > On Thu, Jun 5, 2025 at 9:33 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > >
> > > > > > > > Hello Neal,
> > > > > > > >
> > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > >
> > > > > > > > Interestingly, the problem only presents itself when transmitting
> > > > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > > > >         ~60Mbit: Linux v6.6.85 =TX=> 10GbE -> switch -> 1GbE  -> device
> > > > > > > >          ~1Gbit: device        =TX=>  1GbE -> switch -> 10GbE -> Linux v6.6.85
> > > > > > > >
> > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > >
> > > > > > > >         tcp: fix to allow timestamp undo if no retransmits were sent
> > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
> > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
> 
> Hi Eric,
> 
> Do you have cycles to test a proposed fix patch developed by our team?

Sorry for the radio silence, I just got back in town so I can do that 
later this week.  

> The attached patch should apply (with "git am") for any recent kernel
> that has the "tcp: fix to allow timestamp undo if no retransmits were
> sent" patch it is fixing. So you should be able to test it on top of
> the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> easier.

I can tested on top of 6.6-stable but I have to put a production system 
into standby in order to do that, so I will report back when I can, 
possibly as late as Friday 6/20 because the office is closed that day and 
I can work on it.
 
> If you have cycles to rerun your iperf test, with  tcpdump, nstat, and
> ss instrumentation, that would be fantastic!

will do 
 
> The patch passes our internal packetdrill test suite, including new
> tests for this issue (based on the packetdrill scripts posted earlier
> in this thread.

Awesome thank you for all of the effort to fix this!

-Eric

> 
> But it would be fantastic to directly confirm that this fixes your issue.
> 
> Thanks!
> neal
> 
--8323328-1509259382-1750017645=:21862--

