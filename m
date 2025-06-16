Return-Path: <netdev+bounces-198270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C7ADBBB6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0393AB2F0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD83214A6A;
	Mon, 16 Jun 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkSYIXdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E13A206F27
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108083; cv=none; b=HBJyeEbfatdMJhA4LhcroTo9Feh4NdZPlPEuY0B4m9sF2vT/h0yTDHuO61tQ2YCgwtB/rh/10oJof7OduYRI8jaS4kVxZ3NnklsUr8+WEhYawCWodPMjXplm0aSRvB2OFFmKuAOGrJ/QKbjLLLauBG2ZrCVUbTNbikE0mrUNgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108083; c=relaxed/simple;
	bh=RpMNtXxo8+gXkVEcZLhuvgzs2omPvRf1xcWXC9cTDUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlvJRF+qez6eijVcLNmZdkTklucRF9vKrNcn1Dm+xiMn61wRktUV1AsT5CS2Nf04HOyE1vtdAhhTKcHZZ/ec7s4cWYnhwmkXfTvaDq+COUVziH1K/m3WsDulhqG2WEqonboloWXsZ3GATqppFrZLhEu0SrK73hXfdIOACJEdmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkSYIXdY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a5ac8fae12so123581cf.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750108080; x=1750712880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZtyDOw/yRaEGYFnS6igeDvLRHKl14t0uNJNnQJct38=;
        b=BkSYIXdYKD3/ssDXt0LzqxwQQ3U0DFDPiUUmNFdOld6XSFehMSvU6tMTB6AmQlMvMC
         9QownOzt3rypoKHTUfkFDRGX4jH2x67EmE8jS0mwciRXA8/J5PTDYLwtbcy2Eh5wUsLA
         Ebf0qzzn8UnrgoRZ5BFndcFoDhCA7RD0fcOdhJSfFRGClpD65stgwLcAylfBB1JkQS3r
         050kRFaGWHRTihzLILcP89zHt/3+RVbnOY5EL7ChM7QMjW+ZaLOuFWFYw3WPubcgge6L
         A27lbrGV8p7DcZtbjvJtGvIZ9HVmZQTnH8B76ZlTTK3L3v4Na7DIP5ONGJhxoDRr3Z9b
         EWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108080; x=1750712880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZtyDOw/yRaEGYFnS6igeDvLRHKl14t0uNJNnQJct38=;
        b=nknZgOn2JumMDZNJxkQHAyA97W1dt732shiKT9q/nGEyW6Ntd0+aCoTyO5n5Py2k08
         UeBtpIt1UxNOPPF4rTJUnckJUp7WmbPcxr6B1gafGVTsbnY44qs7QMS0ApjcpH0eUcEu
         2ZqwY9jAyTCnHaiV9GvS7j0VwL3Ir2tIBXGJbjimmesceBaC9/IVFnbwrwJSgSJ5DOxJ
         mHJHt8haHYKfEpcdsC+qHyIcI1GDGD4XVPvNK9GnUaOZMCP3rVUEOmH/cxh76mhL46ZU
         PhQkI6y4hihYYHFAgNCjB+oblanaJDw55v5JzqnOZ+RCQZEqa6ZJGobsNGy6qNWI0P+3
         5mvQ==
X-Gm-Message-State: AOJu0Yx5tDZuyvi2BxsPuO/ih0LbiE4LsEPXTwgqt0fbv14ySjpvW26s
	uEukUTRJ3X38QDz0uMmh8vwbhk+wAt17MGtgWLIXEC/oFi2y3WxkLjgedzm9HB3bhzNWRw8RfOT
	pKsVJhJKk7h9b5KmHmjYkw7qzDphxjycWfYrHhQnf
X-Gm-Gg: ASbGncvvqYV2CtIhs03TmGGl1SGZs8XGOLbh65yUQDxF+XjqzhMAbX+if42yEjLg3BH
	2bt3qDFnpfxHau4ehvtnmdIHhFjGwoxAUz5Ddgb13v648DNhakPfylIlVE5Li8O831BGDbs3PCU
	3DAFT6GWNdgNR29yypmWxKvpd+fbztrHrLZB23bQNAHVQ=
X-Google-Smtp-Source: AGHT+IHy5MxnqwkjpL2M6GubDxe1LGv7aQaFr9pfiJBbimy4n5XZQ5nch2mEGPvspyxpuHkuMR4QnOutSLAl/18vhRQ=
X-Received: by 2002:ac8:5e4f:0:b0:494:b4dd:bee9 with SMTP id
 d75a77b69052e-4a73d78a8e2mr8410471cf.24.1750108079689; Mon, 16 Jun 2025
 14:07:59 -0700 (PDT)
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
In-Reply-To: <a8579544-a9de-63ae-61ed-283c872289a@ewheeler.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 16 Jun 2025 17:07:42 -0400
X-Gm-Features: AX0GCFsol73Cuo0PVdwvNtfdRGM8oUqAPFALPLEkdEEZlpek_c_Nl3GTNvsCg6w
Message-ID: <CADVnQymCso04zj8N0DYP9EkhTwXqtbsCu1xLxAUC60rSd09Rkw@mail.gmail.com>
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 4:14=E2=80=AFPM Eric Wheeler <netdev@lists.ewheeler=
.net> wrote:
>
> On Sun, 15 Jun 2025, Eric Wheeler wrote:
> > On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > > On Mon, Jun 9, 2025 at 1:45=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > > >
> > > > On Sat, Jun 7, 2025 at 7:26=E2=80=AFPM Neal Cardwell <ncardwell@goo=
gle.com> wrote:
> > > > >
> > > > > On Sat, Jun 7, 2025 at 6:54=E2=80=AFPM Neal Cardwell <ncardwell@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Sat, Jun 7, 2025 at 3:13=E2=80=AFPM Neal Cardwell <ncardwell=
@google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jun 6, 2025 at 6:34=E2=80=AFPM Eric Wheeler <netdev@l=
ists.ewheeler.net> wrote:
> > > > > > > >
> > > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > > On Thu, Jun 5, 2025 at 9:33=E2=80=AFPM Eric Wheeler <netd=
ev@lists.ewheeler.net> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello Neal,
> > > > > > > > > >
> > > > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro=
 SYS-2026T-6RFT+
> > > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Net=
gear GS728TXS at
> > > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP perfo=
rmance with
> > > > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, T=
CP with devices
> > > > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > > > >
> > > > > > > > > > Interestingly, the problem only presents itself when tr=
ansmitting
> > > > > > > > > > from Linux; receive traffic (to Linux) performs just fi=
ne:
> > > > > > > > > >         ~60Mbit: Linux v6.6.85 =3DTX=3D> 10GbE -> switc=
h -> 1GbE  -> device
> > > > > > > > > >          ~1Gbit: device        =3DTX=3D>  1GbE -> switc=
h -> 10GbE -> Linux v6.6.85
> > > > > > > > > >
> > > > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > > > >
> > > > > > > > > >         tcp: fix to allow timestamp undo if no retransm=
its were sent
> > > > > > > > > >                 upstream:       e37ab7373696e650d3b6262=
a5b882aadad69bb9e
> > > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e=
7a337a8fb1591d45f
> > >
> >
> > > The attached patch should apply (with "git am") for any recent kernel
> > > that has the "tcp: fix to allow timestamp undo if no retransmits were
> > > sent" patch it is fixing. So you should be able to test it on top of
> > > the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> > > easier.
>
> Definitely better, but performance is ~15% slower vs reverting, and the
> retransmit counts are still higher than the other.  In the two sections
> below you can see the difference between after the fix and after the
> revert.
>
> Here is the output:
>
> ## After fixing with your patch:
>         https://www.linuxglobal.com/out/for-neal/after-fix.tar.gz
>
>         WHEN=3Dafter-fix
>         (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tm=
p/$WHEN-ss.txt &
>         nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done) =
 > /tmp/$WHEN-nstat.txt &
>         tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 100=
0000 host 192.168.1.203 &
>         iperf3 -c 192.168.1.203
>         kill %1 %2 %3
>
>         [1] 2300
>         nstat: history is aged out, resetting
>         [2] 2304
>         [3] 2305
>         Connecting to host 192.168.1.203, port 5201
>         [  5] local 192.168.1.52 port 47730 connected to 192.168.1.203 po=
rt 5201
>         dropped privs to tcpdump
>         tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot =
length 116 bytes
>         [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>         [  5]   0.00-1.00   sec   115 MBytes   963 Mbits/sec   21    334 =
KBytes
>         [  5]   1.00-2.00   sec   113 MBytes   949 Mbits/sec    3    325 =
KBytes
>         [  5]   2.00-3.00   sec  41.8 MBytes   350 Mbits/sec  216   5.70 =
KBytes
>         [  5]   3.00-4.00   sec   113 MBytes   952 Mbits/sec   77    234 =
KBytes
>         [  5]   4.00-5.00   sec   110 MBytes   927 Mbits/sec    5    281 =
KBytes
>         [  5]   5.00-6.00   sec  69.5 MBytes   583 Mbits/sec  129    336 =
KBytes
>         [  5]   6.00-7.00   sec  66.8 MBytes   561 Mbits/sec  234    302 =
KBytes
>         [  5]   7.00-8.00   sec   113 MBytes   949 Mbits/sec    8    312 =
KBytes
>         [  5]   8.00-9.00   sec  89.9 MBytes   754 Mbits/sec   72    247 =
KBytes
>         [  5]   9.00-10.00  sec   113 MBytes   949 Mbits/sec    6    235 =
KBytes
>         - - - - - - - - - - - - - - - - - - - - - - - - -
>         [ ID] Interval           Transfer     Bitrate         Retr
>         [  5]   0.00-10.00  sec   946 MBytes   794 Mbits/sec  771        =
       sender <<<
>         [  5]   0.00-10.04  sec   944 MBytes   789 Mbits/sec             =
     receiver <<<
>
>         iperf Done.
>         145337 packets captured
>         146674 packets received by filter
>         0 packets dropped by kernel
>         [1]   Terminated              ( while true; do
>             date +%s.%N; ss -tenmoi; sleep 0.050;
>         done ) > /tmp/$WHEN-ss.txt
>         [root@hv2 ~]#
>         [2]-  Terminated              ( while true; do
>             date +%s.%N; nstat; sleep 0.050;
>         done ) > /tmp/$WHEN-nstat.txt
>         [3]+  Done                    tcpdump -i br0 -w /tmp/$WHEN-tcpdum=
p.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203
>
> ## After Revert
>         WHEN=3Dafter-revert-6.6.93
>         (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tm=
p/$WHEN-ss.txt &
>         nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done) =
 > /tmp/$WHEN-nstat.txt &
>         tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 100=
0000 host 192.168.1.203 &
>         iperf3 -c 192.168.1.203
>         kill %1 %2 %3
>         [1] 2088
>         nstat: history is aged out, resetting
>         [2] 2092
>         [3] 2093
>         Connecting to host 192.168.1.203, port 5201
>         dropped privs to tcpdump
>         tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot =
length 116 bytes
>         [  5] local 192.168.1.52 port 47256 connected to 192.168.1.203 po=
rt 5201
>         [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>         [  5]   0.00-1.00   sec   115 MBytes   962 Mbits/sec   13    324 =
KBytes
>         [  5]   1.00-2.00   sec   114 MBytes   953 Mbits/sec    3    325 =
KBytes
>         [  5]   2.00-3.00   sec   113 MBytes   947 Mbits/sec    4    321 =
KBytes
>         [  5]   3.00-4.00   sec   113 MBytes   950 Mbits/sec    3    321 =
KBytes
>         [  5]   4.00-5.00   sec   113 MBytes   946 Mbits/sec    5    322 =
KBytes
>         [  5]   5.00-6.00   sec   113 MBytes   950 Mbits/sec    8    321 =
KBytes
>         [  5]   6.00-7.00   sec   113 MBytes   948 Mbits/sec    5    312 =
KBytes
>         [  5]   7.00-8.00   sec   113 MBytes   952 Mbits/sec    3    301 =
KBytes
>         [  5]   8.00-9.00   sec   113 MBytes   945 Mbits/sec    7    301 =
KBytes
>         [  5]   9.00-10.00  sec   114 MBytes   953 Mbits/sec    4    302 =
KBytes
>         - - - - - - - - - - - - - - - - - - - - - - - - -
>         [ ID] Interval           Transfer     Bitrate         Retr
>         [  5]   0.00-10.00  sec  1.11 GBytes   950 Mbits/sec   55        =
     sender
>         [  5]   0.00-10.04  sec  1.10 GBytes   945 Mbits/sec             =
     receiver
>
>         iperf Done.
>         [root@hv2 ~]# 189249 packets captured
>         189450 packets received by filter
>         0 packets dropped by kernel

Thanks for the test data!

Looking at the traces, there are no undo events, and no spurious loss
recovery events that I can see. So I don't see how the fix patch,
which changes undo behavior, would be relevant to the performance in
the test. It looks to me like the "after-fix" test just got unlucky
with packet losses, and because the receiver does not have SACK
support, any bad luck can easily turn into very poor performance, with
200ms timeouts during fast recovery.

Would you have cycles to run the "after-fix" and "after-revert-6.6.93"
cases multiple times, so we can get a sense of what is signal and what
is noise? Perhaps 20 or 50 trials for each approach?

Thanks!
neal

