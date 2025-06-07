Return-Path: <netdev+bounces-195531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C7AD1063
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 00:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE8B188D19B
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88ED214232;
	Sat,  7 Jun 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNB3G6ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760F36D
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749336886; cv=none; b=hsCYA5ZmjXqBnu2N9l5BktRRHdRabcH6YQnFm+/YQwDFyjf6fbhHrspOkA41NcMvtiIXq7y8b0wdKSaU2wliXx0DqDmZFT/zF2HxT0KAa3d1ufDnec7ZVb222smU6Gl6zlQKB9A3YVXUXk2WSQ1CzuGafM5Bmcj1VChvbsm7d8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749336886; c=relaxed/simple;
	bh=7WOcccr9IyC+c6DVwnEW5uCgZ8z6eThtO+G6ngMNkfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlQTz9l5jnmmNDKcyHSBH7zFv4IAPFBwRWP3XFDUz2ym4LkHf8tn6gTou87byhv1+ImX4D6/wvFa++M5cdRV1iSwoMicgxezf9hmq5CmzJi0gKtPpRPPhmg6xOYGuzDbjLABl//wYIuOdTjAgAsLDXiR/QtILfLa6VEXKuOEr+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNB3G6ci; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47e9fea29easo265811cf.1
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749336884; x=1749941684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obiBbCyfPQC9ccxBTuewlFZZfQndcQDm3tzN06rJRdg=;
        b=fNB3G6ci6nk2Pi+MkXuQIl9MQ60CVtSnL80SDKWp/67Rwu74Sf+lDXxjv+xo6JlfJg
         Elh1UcMnS7H+nlbJ+N/aqIcqYZ/XVOcVx4fpJ6uQm7wJFZUpQ1igO1Ajvp0o1k79OP+1
         1wMVhMLXpGvar7+xh6jMdntsd4aq3N3GhfvAbFo0m/zKFAmvskxmY0+csjww20KMLNr5
         n8anuajOZAznwh1wJH4QC6HYA2h3Yvc8gXIonFhEvDkpxHIKQ6tLsLlYXtuH6DMEC0Op
         2i1D3pts9HNR5ZAZ85FUBSP7gwggulkX6UZQKeEiK+vcwh1UlJUtJKVcVX2GQaHTBsuo
         4cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749336884; x=1749941684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obiBbCyfPQC9ccxBTuewlFZZfQndcQDm3tzN06rJRdg=;
        b=VZ+EF+PYQsZzD5brgMsw/vVbRz+E23Q2gn9VGlNFA/127sxYMqyzT18c3jDtV7oU1C
         vsrOAlSRVEiuzxK6s6vDDebM/g/Tk/sgif7/RKimiGNn0jfHBqw0xifdp0goaNmcaaFi
         bLXana2rR/17QP/ozN8FM1WWsWo9Jmvn2lpOpSTHRCoRY+KbNTf2rYiq6Q6UjOMjMnjM
         66wkBJyeFGM77NGnXgFHVEBvznHd3OQ+WlWvXik501rQ9XaAQOmOJAGWyMNQ9XrTdYL2
         lkmljxYubqEU9zb2jS8GAMthkPlQSkkuXOHksgDJLAHsuza0CKGbFJ8Ugn4+l1ktk39Z
         dphw==
X-Gm-Message-State: AOJu0YxFwuquP6rTi+IDjiYyDUl0j4GgJCAfujqvljWmUf8a4UKKlqgJ
	Da8VL9Q5QOixBa07B70H/6EqP5kuUMKeJfOSy3kVTf/KRqsCkeFHDPByrGsUtJbjgt4LNSizVDe
	d9zF6w8XX80NMW+zy8EI4hhBtxC8srWBWYXkEdhSmfiOnLyfen+9cNo/S6Ec=
X-Gm-Gg: ASbGncsbrrVnLmt7XjktrBz+TRDGj+zv5wjDLoOqIgzwU1M/ien6aMI9Cf5bfpIRot2
	BE3vaWUWvT3o7WNYBihO55NKSbaIpiAYCz/EWUWbbtDUCsuDGAf8nQO8/mxgal0Z68Hbvd5UV2y
	MFqVkQXC7pTTIlns+7i0USjWbqo/srGRr95BE5iBYnlAk78BvY0dxEFoiF3feduRDLs4tG9kkNL
	frt
X-Google-Smtp-Source: AGHT+IFNYe1Uf/UjNQ3gaO8WTPv3tlDJZTBcBol76dfdCrOhAgUp9WVOWvFhuE+TATdBncfgfKIUVCom9PZQFwAivLw=
X-Received: by 2002:ac8:4244:0:b0:4a6:f577:19bc with SMTP id
 d75a77b69052e-4a6f5771a68mr880321cf.18.1749336883718; Sat, 07 Jun 2025
 15:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
 <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
 <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
In-Reply-To: <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 7 Jun 2025 18:54:27 -0400
X-Gm-Features: AX0GCFvvBuVZbHit5RbfjNJKmepT6_snqdy2KoWwtzQ7PMGM3K7mr5CFe90EKvs
Message-ID: <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists.ewheele=
r.net> wrote:
> >
> > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lists.ewh=
eeler.net> wrote:
> > > >
> > > > Hello Neal,
> > > >
> > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6=
RFT+
> > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TX=
S at
> > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with devi=
ces
> > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > >
> > > > Interestingly, the problem only presents itself when transmitting
> > > > from Linux; receive traffic (to Linux) performs just fine:
> > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1GbE  -=
> device
> > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 10GbE -=
> Linux v6.6.85
> > > >
> > > > Through bisection, we found this first-bad commit:
> > > >
> > > >         tcp: fix to allow timestamp undo if no retransmits were sen=
t
> > > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad6=
9bb9e
> > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb159=
1d45f
> > > >
> > >
> > > Thank you for your detailed report and your offer to run some more te=
sts!
> > >
> > > I don't have any good theories yet. It is striking that the apparent
> > > retransmit rate is more than 100x higher in your "Before Revert" case
> > > than in your "After Revert" case. It seems like something very odd is
> > > going on. :-)
> >
> > good point, I wonder what that might imply...
> >
> > > If you could re-run tests while gathering more information, and share
> > > that information, that would be very useful.
> > >
> > > What would be very useful would be the following information, for bot=
h
> > > (a) Before Revert, and (b) After Revert kernels:
> > >
> > > # as root, before the test starts, start instrumentation
> > > # and leave it running in the background; something like:
> > > (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/ss=
.txt &
> > > nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  >
> > > /tmp/nstat.txt &
> > > tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &
> > >
> > > # then run the test
> > >
> > > # then kill the instrumentation loops running in the background:
> > > kill %1 %2 %3
> >
> > Sure, here they are:
> >
> >         https://www.linuxglobal.com/out/for-neal/
>
> Hi Eric,
>
> Many thanks for the traces! These traces clearly show the buggy
> behavior. The problem is an interaction between the non-SACK behavior
> on these connections (due to the non-Linux "device" not supporting
> SACK) and the undo logic. The problem is that, for non-SACK
> connections, tcp_is_non_sack_preventing_reopen() holds steady in
> CA_Recovery or CA_Loss at the end of a loss recovery episode but
> clears tp->retrans_stamp to 0. So that upon the next ACK the "tcp: fix
> to allow timestamp undo if no retransmits were sent" sees the
> tp->retrans_stamp at 0 and erroneously concludes that no data was
> retransmitted, and erroneously performs an undo of the cwnd reduction,
> restoring cwnd immediately to the value it had before loss recovery.
> This causes an immediate build-up of queues and another immediate loss
> recovery episode. Thus the higher retransmit rate in the buggy
> scenario.
>
> I will work on a packetdrill reproducer, test a fix, and post a patch
> for testing. I think the simplest fix would be to have
> tcp_packet_delayed(), when tp->retrans_stamp is zero, check for the
> (tp->snd_una =3D=3D tp->high_seq && tcp_is_reno(tp)) condition and not
> allow tcp_packet_delayed() to return true in that case. That should be
> a precise fix for this scenario and does not risk changing behavior
> for the much more common case of loss recovery with SACK support.

Indeed, I'm able to reproduce this issue with erroneous undo events on
non-SACK connections at the end of loss recovery with the attached
packetdrill script.

When you run that script on a kernel with the "tcp: fix to allow
timestamp undo if no retransmits were sent" patch, we see:

+ nstat shows an erroneous TcpExtTCPFullUndo event

+ the loss recovery reduces cwnd from the initial 10 to the correct 7
(from CUBIC) but then the erroneous undo event restores the pre-loss
cwnd of 10 and leads to a final cwnd value of 11

I will test a patch with the proposed fix and report back.

neal

