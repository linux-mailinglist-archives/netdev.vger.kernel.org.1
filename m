Return-Path: <netdev+bounces-199253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFBEADF929
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5668D3B8B5F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B7239561;
	Wed, 18 Jun 2025 22:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C821A452
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284203; cv=none; b=XPst7vxBGgHdz6t83C6brJbRMZz1DrcVYsp/vyA0gxjEpKg7Higww64lmxjeuUBC0/80774hKBLplP1auu9APmPRDXAf2BfHSxtMW6J7KMqsIQD6X5B1lgtOKeW6YkPRSuNpc87isEglLISP4vTgd0/R+/CXeU3Z9CATlVNgl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284203; c=relaxed/simple;
	bh=Ifwvi8dIvMiZN9RBQ1iHgerYGgCFf+NSHsY0DsDmx18=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZpOp9dayQct3i7unfh4zIJRyZ1mZyFilzRbtH+mbbCnsph5ygUl7jSvzJgGKLXkdL3VBEKCt/AomT3ExKlUsCD8c+bRFq7iJyhWZgKASi6UzqZBqYtWeszT6m1k9VwnUnnkZXOUzYIRFaFlIaHJcxMm6IBPFJ16rIsG00SxN+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3F2678A;
	Wed, 18 Jun 2025 15:03:15 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DSeB3lR9Hvwy; Wed, 18 Jun 2025 15:03:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6963445;
	Wed, 18 Jun 2025 15:03:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6963445
Date: Wed, 18 Jun 2025 15:03:09 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
    stable@kernel.org
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
In-Reply-To: <CADVnQymCso04zj8N0DYP9EkhTwXqtbsCu1xLxAUC60rSd09Rkw@mail.gmail.com>
Message-ID: <452b3c16-b994-a627-c737-99358be8b030@ewheeler.net>
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net> <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com> <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com> <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com> <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com> <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
 <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net> <a8579544-a9de-63ae-61ed-283c872289a@ewheeler.net> <CADVnQymCso04zj8N0DYP9EkhTwXqtbsCu1xLxAUC60rSd09Rkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1413097006-1750284193=:12017"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1413097006-1750284193=:12017
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 16 Jun 2025, Neal Cardwell wrote:

> On Mon, Jun 16, 2025 at 4:14 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> >
> > On Sun, 15 Jun 2025, Eric Wheeler wrote:
> > > On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > > > On Mon, Jun 9, 2025 at 1:45 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > >
> > > > > On Sat, Jun 7, 2025 at 7:26 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > >
> > > > > > On Sat, Jun 7, 2025 at 6:54 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > >
> > > > > > > On Sat, Jun 7, 2025 at 3:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 6, 2025 at 6:34 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > > > On Thu, Jun 5, 2025 at 9:33 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello Neal,
> > > > > > > > > > >
> > > > > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> > > > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> > > > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > > > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> > > > > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > > > > >
> > > > > > > > > > > Interestingly, the problem only presents itself when transmitting
> > > > > > > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > > > > > > >         ~60Mbit: Linux v6.6.85 =TX=> 10GbE -> switch -> 1GbE  -> device
> > > > > > > > > > >          ~1Gbit: device        =TX=>  1GbE -> switch -> 10GbE -> Linux v6.6.85
> > > > > > > > > > >
> > > > > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > > > > >
> > > > > > > > > > >         tcp: fix to allow timestamp undo if no retransmits were sent
> > > > > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
> > > > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
> > > >
> > >
> > > > The attached patch should apply (with "git am") for any recent kernel
> > > > that has the "tcp: fix to allow timestamp undo if no retransmits were
> > > > sent" patch it is fixing. So you should be able to test it on top of
> > > > the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> > > > easier.
> >
> > Definitely better, but performance is ~15% slower vs reverting, and the
> > retransmit counts are still higher than the other.  In the two sections
> > below you can see the difference between after the fix and after the
> > revert.
> >
> > Here is the output:
> >
> > ## After fixing with your patch:
> >         - - - - - - - - - - - - - - - - - - - - - - - - -
> >         [ ID] Interval           Transfer     Bitrate         Retr
> >         [  5]   0.00-10.00  sec   946 MBytes   794 Mbits/sec  771               sender <<<
> >         [  5]   0.00-10.04  sec   944 MBytes   789 Mbits/sec                  receiver <<<
> >
> > ## After Revert
> >         - - - - - - - - - - - - - - - - - - - - - - - - -
> >         [ ID] Interval           Transfer     Bitrate         Retr
> >         [  5]   0.00-10.00  sec  1.11 GBytes   950 Mbits/sec   55             sender
> >         [  5]   0.00-10.04  sec  1.10 GBytes   945 Mbits/sec                  receiver
> 
> Thanks for the test data!
> 
> Looking at the traces, there are no undo events, and no spurious loss
> recovery events that I can see. So I don't see how the fix patch,
> which changes undo behavior, would be relevant to the performance in
> the test. It looks to me like the "after-fix" test just got unlucky
> with packet losses, and because the receiver does not have SACK
> support, any bad luck can easily turn into very poor performance, with
> 200ms timeouts during fast recovery.
> 
> Would you have cycles to run the "after-fix" and "after-revert-6.6.93"
> cases multiple times, so we can get a sense of what is signal and what
> is noise? Perhaps 20 or 50 trials for each approach?
 
I ran 50 tests after revert and compare that to after the fix using both
average and geometric mean, and it still appears to be slightly slower
then with the revert alone:

	# after-revert-6.6.93    
	Arithmetic Mean: 843.64 Mbits/sec
	Geometric Mean: 841.95 Mbits/sec

	# after-tcp-fix-6.6.93    
	Arithmetic Mean: 823.00 Mbits/sec
	Geometric Mean: 819.38 Mbits/sec

Do you think that this is an actual performance regression, or just a
sample set that is not big enough to work out the averages?

Here is the data collected for each of the 50 tests:
	- https://www.linuxglobal.com/out/for-neal/after-revert-6.6.93.tar.gz
	- https://www.linuxglobal.com/out/for-neal/after-tcp-fix-6.6.93.tar.gz


--
Eric Wheeler


> Thanks!
> neal
> 
--8323328-1413097006-1750284193=:12017--

