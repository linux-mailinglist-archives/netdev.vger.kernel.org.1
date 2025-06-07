Return-Path: <netdev+bounces-195523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52018AD0F01
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 21:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746923ADA0E
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4601FF1B5;
	Sat,  7 Jun 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OB6KrMou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A3288DB
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749323610; cv=none; b=ScI1KM8NT6bma8ZdsU3+QBxR7RQ8mLZyso08y/MgxNxN3fv3B9/nIcgbir2IKlsmf9pe0BC28NEbjlQeDBvSWrAoM7VAA9W2vK4pLa0fAkBqibLP9GDVBTPsth8p8JgxoIF3PtItGe89V+lruOP4jv6obaK7OYVvQ47zldDod5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749323610; c=relaxed/simple;
	bh=ucVeN00yYF8QwAS+WpOpfGeEJJtW0A7StStMQCP6c0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9YJIef8PoCHk4NkHdOkVd+fMVGj6lrfPffjtMz6xO4NYZSsbE36CkRYPPtrIvsp+hs5ryEGXfzE4kNg8gsGUlCuB9xc1LWe5SSq4GzVLGcKEZDEeookLGZ+6zGBoubpRShIckX5yXjWL1Vo3OnMfYN9cG4utZayF6vBXBAB444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OB6KrMou; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58197794eso141221cf.1
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749323608; x=1749928408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjRNnjGqUx6sUUt9swMVq+6Yhii3RhQRJvCq9MqqPYI=;
        b=OB6KrMouZPi/cZ5wAxP092OoYXt5MzkFWPwnW/NzzCjqYBSUT2Zyd3PXkdTnj7KA0Q
         cY3nPopqgQCxkkhpngWLt/Yoj3Abi023ZNr8gLXuBGaWjzRlMr7K8aLvZdkGXF5u23Si
         3e/cDC2lbYF2XE5LdjVq/kOdi96GPB6daU6+cBjuKX8Ppzzdhe5HyXKiEOe0RbFJ245J
         hMGVWJw/FX3Ux8ln8Qh8nh5vFC/GVGVCwOtJUfC6I2CFX8Jgv0JHooWRLUnKZsUma4Nl
         1ke3JIpddxGxZsC/6jFymTTvC4Rhzlr1Vyfji0shMDzy1l1mhA3spoAwSEK+f9m03ZEB
         E66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749323608; x=1749928408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjRNnjGqUx6sUUt9swMVq+6Yhii3RhQRJvCq9MqqPYI=;
        b=XS/Fz6zWoaq1fFYR+cjYapY3POG2h5V+EvQ2/5EGM0XkqiEZqutfX+4uLpHmsvCOnk
         qkNWf4aw/P29D6E/47/Q48qL0tWVaHYYvucMsVKaOEQdKfUEuAEqtWatHrvV2B77U6eX
         e9tJZmNRZe97JirJTPavMnZDrCNSebtckl/HVSrFUlPnaW/M9TWLxW9t+4zRykDJX+1J
         VgxTck5i3osTxkIsi4dBbHLAr4Sm9RkDVsEyPpDOzZMkDIC87RsnW8Ethvm+UCIZoVXj
         RgspItWIdqcFzsD2EMhm6Fymwdc5XWfC/3OhBkJJrsqOxJYZClyfFx0rMI1ES2l1I8VB
         lpQw==
X-Gm-Message-State: AOJu0YwG2bvFjfdQEyukPQz/yDuzZal1DNbsPr6ghk260M5tnVJnN4pm
	SEYcAPxddaRjwZ9qVBalqhB9jc3nho2m81o55n/gfWRrEUBhkyoBekIEAt0d905fxHfIrJLSIkL
	Wmf8XKxBoMOtER1y1fIAcV1WZXpP/IJdecnFB7YLG
X-Gm-Gg: ASbGncun3UwKurQ9rUHd6n3NG1uAc9CEFwETfoPptkwyTXzIt1UpML3rgt+m78YrNRa
	52z7zkbnhkqc0YvaYsLUif9FoBm4KjKwJ8yseyiFuUGkKTs7MkTV+HEhEjtZYC9Ala/BUGW18l3
	BB5ZkYsWiGadOtP3zBqk2PWFiwfoC3KUfuM1u/H8cDNl9eTemdb6t8t2Pa+A4skTQ+aHmrlkek7
	ekrtFPRDJ4GnWI=
X-Google-Smtp-Source: AGHT+IEveUinRUZr2znoskos5hbUB9s7/uORq0qsBDIt3jhbSrAkwf05Z/dVhxz2jxEMy3Hjc2My/h6eJsJRQnePDqo=
X-Received: by 2002:a05:622a:11c5:b0:4a4:ead0:92c4 with SMTP id
 d75a77b69052e-4a6f06bbd37mr2116771cf.5.1749323607442; Sat, 07 Jun 2025
 12:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
 <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com> <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net>
In-Reply-To: <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 7 Jun 2025 15:13:11 -0400
X-Gm-Features: AX0GCFuoAJXg2P4UGuND9xOmfco1L7_7rIuHEX_Yg0EIBmyDv5d_WhGhLsNDT2A
Message-ID: <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@lists.ewheeler.=
net> wrote:
>
> On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netdev@lists.ewhee=
ler.net> wrote:
> > >
> > > Hello Neal,
> > >
> > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RF=
T+
> > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS =
at
> > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > existing devices on 1Gbit ports was <60Mbit; however, TCP with device=
s
> > > across the switch on 10Gbit ports runs at full 10GbE.
> > >
> > > Interestingly, the problem only presents itself when transmitting
> > > from Linux; receive traffic (to Linux) performs just fine:
> > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switch -> 1GbE  -> =
device
> > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switch -> 10GbE -> =
Linux v6.6.85
> > >
> > > Through bisection, we found this first-bad commit:
> > >
> > >         tcp: fix to allow timestamp undo if no retransmits were sent
> > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69b=
b9e
> > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d=
45f
> > >
> >
> > Thank you for your detailed report and your offer to run some more test=
s!
> >
> > I don't have any good theories yet. It is striking that the apparent
> > retransmit rate is more than 100x higher in your "Before Revert" case
> > than in your "After Revert" case. It seems like something very odd is
> > going on. :-)
>
> good point, I wonder what that might imply...
>
> > If you could re-run tests while gathering more information, and share
> > that information, that would be very useful.
> >
> > What would be very useful would be the following information, for both
> > (a) Before Revert, and (b) After Revert kernels:
> >
> > # as root, before the test starts, start instrumentation
> > # and leave it running in the background; something like:
> > (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/ss.t=
xt &
> > nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  >
> > /tmp/nstat.txt &
> > tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &
> >
> > # then run the test
> >
> > # then kill the instrumentation loops running in the background:
> > kill %1 %2 %3
>
> Sure, here they are:
>
>         https://www.linuxglobal.com/out/for-neal/

Hi Eric,

Many thanks for the traces! These traces clearly show the buggy
behavior. The problem is an interaction between the non-SACK behavior
on these connections (due to the non-Linux "device" not supporting
SACK) and the undo logic. The problem is that, for non-SACK
connections, tcp_is_non_sack_preventing_reopen() holds steady in
CA_Recovery or CA_Loss at the end of a loss recovery episode but
clears tp->retrans_stamp to 0. So that upon the next ACK the "tcp: fix
to allow timestamp undo if no retransmits were sent" sees the
tp->retrans_stamp at 0 and erroneously concludes that no data was
retransmitted, and erroneously performs an undo of the cwnd reduction,
restoring cwnd immediately to the value it had before loss recovery.
This causes an immediate build-up of queues and another immediate loss
recovery episode. Thus the higher retransmit rate in the buggy
scenario.

I will work on a packetdrill reproducer, test a fix, and post a patch
for testing. I think the simplest fix would be to have
tcp_packet_delayed(), when tp->retrans_stamp is zero, check for the
(tp->snd_una =3D=3D tp->high_seq && tcp_is_reno(tp)) condition and not
allow tcp_packet_delayed() to return true in that case. That should be
a precise fix for this scenario and does not risk changing behavior
for the much more common case of loss recovery with SACK support.

Eric, would you be willing to test a simple bug fix patch for this?

Thanks!

neal

