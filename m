Return-Path: <netdev+bounces-149647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE299E69BE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C798018843CB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5311EE016;
	Fri,  6 Dec 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYdv6+RM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76D1EE010
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476112; cv=none; b=YbLh9QMj1O1sEwh9lea1xmZUOg/OZbpeh0o29DOVNLluatItUiYIV+tBYzMBg+ZMSwfI02woSGIMqNgx8NX4JKjA48cB3KODnWILrEcwUACYBlKvEwxX8AvXGo3ZmrFguZSc5zLrLxAlu+fRjB7oSbnsOEtIl1QeVhZKnToMiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476112; c=relaxed/simple;
	bh=8D1FCiF5ScjUWo9a2l+03DqFTxP7SSjo5gQ0jNFHVe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHca44Z6RTnlFF6GW8uQPz2edTL3qeMNEo1iI2xaxaTuQ8lsMNQGk5WqwjM6LYGCoRCtxQQLjifL0rEUT+I1D3UOhln9r6SI6qr8WsUKanHDc3tJWto8ZqvE0dBl24pGscX+1bg9mTsGdR7D7rRaXVQV8o7u19kF9NZfN9aMZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYdv6+RM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6413fc7c5so31411866b.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733476109; x=1734080909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D1FCiF5ScjUWo9a2l+03DqFTxP7SSjo5gQ0jNFHVe0=;
        b=fYdv6+RM73dNLjUTNXIBnUCpXFi5xnnKNZi5gzZ28DhaExOUg/GHlqI0i6ZD9VKLG0
         wDvIFGbF1z/XlaM34+nRN5ODVtJR5j5DYvYpNhXCdIzpmPn9voHPongsyZyrOkYcgPz0
         KtyrvUWJcxoqtDzKZk2du9P4BKmDwANeXx1qMHkr/ckrdt93YpzBSY8TmC+qdLGJc4Kg
         273WpYvmwC8uhcPbcGpHBG0XUIBBQoD9PLapXQskTPiefMD6wmT4kr8luWSkyU9I3qNG
         uoqBPEI8huy0clTbWMIcBKYbIiNZjp/QcADNidEnPv6PfpgdsrMUpKACPSWlKVemv6oq
         ODWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476109; x=1734080909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D1FCiF5ScjUWo9a2l+03DqFTxP7SSjo5gQ0jNFHVe0=;
        b=CsH6abN7vo9D8vzWkZ/ySHSdS4t9wVAGDXnDX7e/5wZMqqJsLe1DZ1gvP/HZs1qNcX
         VI9pjaFCUkfDBKfR4yLLWX1eXaHHd5+x82gBDNODjZ6Tyh3C2lTT68li7XsRfNI3nvct
         p7xZiB3HsVatht1Ov0Dyd7jp8FpJhdEQH01W5SJa2tLF+rIYi8UVa9fUlhjMvZC/cFmt
         0a9iMTlK828MbOBYeCUVfNYzIRRrYITfpTitbjjbfrb9pXW0qxh3uR+4EPaJx+AxQMJ+
         R7XAD262vwL0JK5BrsajQnaAtQ6kDMjp7MRsSOB9E0cR5z7pZv3+kvxRhbYyzMd8sIfM
         hEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZYkyb1CPZRl2ziEd8o6G5ysPK+olINAzEfZ5KtuAA4zNDnr8VmXUnBg8IrUL7cRJorYxiNHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHcZnGhetHp5XUGn1RKdoGvo4LbrUECRpRCvlCL5csvrcqTha
	OtH/uckxSpZwbFVC0+hwdQ3DHyfAWJ9BD5+c38+0OlFA0cogF9kDAiGGjnz2S92tzrFFTrFXA1N
	OLgfX+yiMdwsWVooRItMgo/NWDvZ95rASqhw5
X-Gm-Gg: ASbGnctllKScX0rpgxMrV0ynsmAvBfn4z1UNR6mgFLd+1dSyfukeNjLRGhczWPI81ZV
	PFzjajdX3buuThD34adIfmNa57CaBoJc=
X-Google-Smtp-Source: AGHT+IEz+qiODAXrlpg+dyKqxVS3eEMlJ3X6Zxc9LcI6JbgLnpRG7Tdbrv58IFLwYTn2PXgsE5B0SUMqCiXnKaAgQhk=
X-Received: by 2002:a05:6402:2683:b0:5d0:e73c:b80a with SMTP id
 4fb4d7f45d1cf-5d3be742b4cmr5479064a12.33.1733476108782; Fri, 06 Dec 2024
 01:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <Z1KRaD78T3FMffuX@perf> <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
 <Z1K9WVykZbo6u7uG@perf>
In-Reply-To: <Z1K9WVykZbo6u7uG@perf>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 10:08:17 +0100
Message-ID: <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joonki.min@samsung.com, 
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:58=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> On Fri, Dec 06, 2024 at 09:35:32AM +0100, Eric Dumazet wrote:
> > On Fri, Dec 6, 2024 at 6:50=E2=80=AFAM Youngmin Nam <youngmin.nam@samsu=
ng.com> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > > > On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM Youngmin Nam <youngmin.nam@s=
amsung.com> wrote:
> > > > >
> > > > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > > > I have not seen these warnings firing. Neal, have you seen =
this in the past ?
> > > > > > >
> > > > > > > I can't recall seeing these warnings over the past 5 years or=
 so, and
> > > > > > > (from checking our monitoring) they don't seem to be firing i=
n our
> > > > > > > fleet recently.
> > > > > >
> > > > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > > > Could be that one of our workloads is pinned to 5.12.
> > > > > > Youngmin, what's the newest kernel you can repro this on?
> > > > > >
> > > > > Hi Jakub.
> > > > > Thank you for taking an interest in this issue.
> > > > >
> > > > > We've seen this issue since 5.15 kernel.
> > > > > Now, we can see this on 6.6 kernel which is the newest kernel we =
are running.
> > > >
> > > > The fact that we are processing ACK packets after the write queue h=
as
> > > > been purged would be a serious bug.
> > > >
> > > > Thus the WARN() makes sense to us.
> > > >
> > > > It would be easy to build a packetdrill test. Please do so, then we
> > > > can fix the root cause.
> > > >
> > > > Thank you !
> > > >
> > >
> > > Hi Eric.
> > >
> > > Unfortunately, we are not familiar with the Packetdrill test.
> > > Refering to the official website on Github, I tried to install it on =
my device.
> > >
> > > Here is what I did on my local machine.
> > >
> > > $ mkdir packetdrill
> > > $ cd packetdrill
> > > $ git clone https://protect2.fireeye.com/v1/url?k=3D746d28f3-15e63dd6=
-746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=3D1&e=3Dca164227-d8ec-4d3c-bd27-a=
f2d38964105&u=3Dhttps%3A%2F%2Fgithub.com%2Fgoogle%2Fpacketdrill.git .
> > > $ cd gtests/net/packetdrill/
> > > $./configure
> > > $ make CC=3D/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_=
64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
> > >
> > > $ adb root
> > > $ adb push packetdrill /data/
> > > $ adb shell
> > >
> > > And here is what I did on my device
> > >
> > > erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v=
 -L -l tcp/
> > > /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
> > >
> > > I'm not sure if this procedure is correct.
> > > Could you help us run the Packetdrill on an Android device ?
> >
> > packetdrill can run anywhere, for instance on your laptop, no need to
> > compile / install it on Android
> >
> > Then you can run single test like
> >
> > # packetdrill gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt
> >
>
> You mean.. To test an Android device, we need to run packetdrill on lapto=
p, right ?
>
> Laptop(run packetdrill script) <--------------------------> Android devic=
e
>
> By the way, how can we test the Android device (DUT) from packetdrill whi=
ch is running on Laptop?
> I hope you understand that I am aksing this question because we are not f=
amiliar with the packetdrill.
> Thanks.

packetdrill does not need to run on a physical DUT, it uses a software
stack : TCP and tun device.

You have a kernel tree, compile it and run a VM, like virtme-ng

vng -bv

We use this to run kernel selftests in which we started adding
packetdrill tests (in recent kernel tree)

./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per=
-4pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-w=
in-update.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-=
per-2pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
./tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-lim=
ited-9-packets-out.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per=
-2pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
./tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-lim=
ited.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
./tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per=
-1pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-i=
dle.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per=
-2pkt-send-5pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per=
-2pkt-send-6pkt.pkt
./tools/testing/selftests/net/packetdrill/tcp_md5_md5-only-on-client-ack.pk=
t
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_old.pk=
t
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_syn_challenge=
_ack.pkt
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_inexact_rst.p=
kt
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_synack_reuse.=
pkt
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_rst_invalid.p=
kt
./tools/testing/selftests/net/netfilter/packetdrill/conntrack_ack_loss_stal=
l.pkt

