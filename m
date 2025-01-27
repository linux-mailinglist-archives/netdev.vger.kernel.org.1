Return-Path: <netdev+bounces-161091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFFA1D460
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6043A163546
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569B1FCFE5;
	Mon, 27 Jan 2025 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS8WERqf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE1179BF
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973640; cv=none; b=YKq8FCqd1Kf1rkUHk+m0sCfMnwLuDoINC1Q3BNWT/YTpJUmSiihP0pPjYEVp3RWZUZopuDGpwHOrlREWcij/GQf3xbHCFxGFUmYCDCVwJcVHczNdhcwqAcVGjzT5jRaK+zzzrhnEyFWfEyo5W35WkaRQ/nI7tFuFaGHysDYIelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973640; c=relaxed/simple;
	bh=xiLh/LF5vdzL4TJiPHNiVASmoamkmOzEKMquzhhAkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwmLV/ootFy/UGS6tBSpBIyfCNR6bNw683uHjy0FCFyc9rC66hZGtIuYa0leV3XU6IWhiuV531D8bG9mtM3BQhD6iMjbhOdKFSn8NZi430KL/O3BJzOZMTP2f4+Pdzv+7Ro+qzRmmPngDDidg64cKqlpkVVAW7+Ac2dcc06QevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS8WERqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737973637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPQF6s94+SLLK6q09hcYNsrxkJ7FIGbSw5VTIudV5Rs=;
	b=IS8WERqf9rrlyIsxYw4i791gEC2mepTAbeRqUBs8VxpLJISo/QUxeKoir788IuQhyR2uGE
	9HjjuJhM6tElZKzoVfrnkBgA4caOuymapVoLSPbSeKOLSnZuF6wJ/SxNSYzM8MsP+0jBsO
	/XhLRSipohxk4rp7t2MzFxIA0ryCbE4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-b8OYTB4NPuuG6PaYVlzgGw-1; Mon, 27 Jan 2025 05:27:16 -0500
X-MC-Unique: b8OYTB4NPuuG6PaYVlzgGw-1
X-Mimecast-MFC-AGG-ID: b8OYTB4NPuuG6PaYVlzgGw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361f371908so29110995e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973635; x=1738578435;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPQF6s94+SLLK6q09hcYNsrxkJ7FIGbSw5VTIudV5Rs=;
        b=gNvwOzLTQb3VZlfyo5mQpGxweoqtqkYHk2IG7qo0dDSZjDlJAoQeq/mMBPIyMGaom0
         GkMR0eXoxrNrESG5ZWHLwO0Clgmolbyc63RqtB4uEzemiTCkw2Gj0oKtBBAobuhbkCui
         hLKFHEB/CG62dBhiretTwFSy1jJXMqjjAELkX7sk4yVONLkiugcrbHKtsOdeMRe4WqjR
         CdB4j+0adAsPQ7d+n8h8WvD4yoeS6TFu8rdzo1PJ3jtdlcJ+vRt6dZFEpYVbNmTcTTd9
         GLZcHlq25uoGBKOUcVtBg45aMSgQeLfnd//vbtxvlUQdWFdZFwRJJ/1Ap8giKTfjdFj4
         v77g==
X-Forwarded-Encrypted: i=1; AJvYcCUa2cnyRTTGvLeonqPRFtpbTluxELChXH9KyaVyJ3d1zkps2bpgtD3Qe+7hka8N8uSHOWUMk9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lQuZ3298Fh1rwuftmSOMWTAXsXpaCN58che1/GYe37u4Zmhk
	0i8gjPrevmS5D8ogTO6yxLoTQn1bPfv/ulgnanGuHJ2z9xni+BrtXSPpyRbU89Fn0L9gtiOxVzJ
	IxP2CcRMt7ehbAts+Fiasr9urokvYVZMQ+yT/sXH7as4KxNqFqZpcxA==
X-Gm-Gg: ASbGncsP+wDI8yXhVsmvGH6odbKiXybfqvJKS7LV7TW2klwSmHD50KtXPElBkTk0Z/u
	BEAuAesj2w5Hmtt+Ez9xYqB1I1bRvFZAcDlt82G5eDpJL857YwJt+8BSIEzlQbREGluTTUEdyep
	p0t6vAaMhf6S+xfZCFYl8+B2aK4MVxsrHeGukUo/YD+5LZlDphPW+R8gfmqNAbIFbzamBHb442Y
	FkCxJ5l1tGQwUry3KJh16DUn3ByDVJOrVWT4K+1h9vtfLGlIJlBUIzh8bhOI0c8L72fMxZviEUx
	O1excUaJ40SAsgEG
X-Received: by 2002:a05:600c:ccc:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-4389141c1e5mr308044035e9.20.1737973634950;
        Mon, 27 Jan 2025 02:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/vOIlh8NUolnxEhhezqtFrfya33PW0mZ2/xkcVF+l0sldXD54BuiD9icmtPhfhQPA+ua5zA==
X-Received: by 2002:a05:600c:ccc:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-4389141c1e5mr308043805e9.20.1737973634567;
        Mon, 27 Jan 2025 02:27:14 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501721sm125050985e9.9.2025.01.27.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:27:13 -0800 (PST)
Date: Mon, 27 Jan 2025 11:27:12 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
Message-ID: <20250127112712.50bb6341@elisabeth>
In-Reply-To: <CANn89iJ4u5QBfhc1LC6ipmmmiEG0bCWhRG1obm3=05A_BsPt4w@mail.gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
	<CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
	<afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
	<c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
	<CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
	<e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
	<20250127110121.1f53b27d@elisabeth>
	<CANn89iJ4u5QBfhc1LC6ipmmmiEG0bCWhRG1obm3=05A_BsPt4w@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 11:06:07 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 27, 2025 at 11:01=E2=80=AFAM Stefano Brivio <sbrivio@redhat.c=
om> wrote:
> >
> > On Fri, 24 Jan 2025 12:40:16 -0500
> > Jon Maloy <jmaloy@redhat.com> wrote:
> > =20
> > > I can certainly clear tp->pred_flags and post it again, maybe with
> > > an improved and shortened log. Would that be acceptable? =20
> >
> > Talking about an improved log, what strikes me the most of the whole
> > problem is:
> >
> > $ tshark -r iperf3_jon_zero_window.pcap -td -Y 'frame.number in { 1064 =
.. 1068 }'
> >  1064   0.004416 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 3448=
2 =E2=86=92 5201 [ACK] Seq=3D1611679466 Ack=3D1 Win=3D36864 Len=3D65480
> >  1065   0.007334 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 3448=
2 =E2=86=92 5201 [ACK] Seq=3D1611744946 Ack=3D1 Win=3D36864 Len=3D65480
> >  1066   0.005104 192.168.122.1 =E2=86=92 192.168.122.198 TCP 56382 [TCP=
 Window Full] 34482 =E2=86=92 5201 [ACK] Seq=3D1611810426 Ack=3D1 Win=3D368=
64 Len=3D56328
> >  1067   0.015226 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 [TCP Ze=
roWindow] 5201 =E2=86=92 34482 [ACK] Seq=3D1 Ack=3D1611090146 Win=3D0 Len=
=3D0
> >  1068   6.298138 fe80::44b3:f5ff:fe86:c529 =E2=86=92 ff02::2      ICMPv=
6 70 Router Solicitation from 46:b3:f5:86:c5:29
> >
> > ...and then the silence, 192.168.122.198 never announces that its
> > window is not zero, so the peer gives up 15 seconds later:
> >
> > $ tshark -r iperf3_jon_zero_window_cut.pcap -td -Y 'frame.number in { 1=
069 .. 1070 }'
> >  1069   8.709313 192.168.122.1 =E2=86=92 192.168.122.198 TCP 55 34466 =
=E2=86=92 5201 [ACK] Seq=3D166 Ack=3D5 Win=3D36864 Len=3D1
> >  1070   0.008943 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 5201 =
=E2=86=92 34482 [FIN, ACK] Seq=3D1 Ack=3D1611090146 Win=3D778240 Len=3D0
> >
> > Data in frame #1069 is iperf3 ending the test.
> >
> > This didn't happen before e2142825c120 ("net: tcp: send zero-window
> > ACK when no memory") so it's a relatively recent (17 months) regression.
> >
> > It actually looks pretty simple (and rather serious) to me.
>=20
> With all that, it should be pretty easy to cook a packetdrill test, right=
 ?

Not really :( because to reproduce this exact condition you need to
somehow get the right amount of memory pressure so that you can
actually establish a connection, start the transfer, and then exhaust
the receive buffer at the right moment.

And packetdrill doesn't do that. Sure, it would be great if it did, and
it's probably a nice feature to implement... given enough time. Given
less time, I guess fixing regressions has a higher priority.

One could perhaps tweak sk->sk_rcvbuf as you suggested but that just
artificially reproduces one part of it. It's not a really fitting test.
For example: when would you increase it back?

> packetdrill tests are part of tools/testing/selftests/net/ already, we
> are not asking for something unreasonable.

I would agree, in general, except that I don't see a way to craft a
test like this with packetdrill. At least not trivially with the
current feature set.

On top of that, this is not a new feature, it's a fix for a regression
(that was introduced without adding any test, of course). And the fix
itself was definitely tested, just not with packetdrill.

Requesting that tests are 1. automated and 2. written with a specific
tool is something I can quite understand for general convenience, but
I don't think it always makes sense.

Especially as this fix has been blocked for about 9 months now because
of the fact that automating a test for it is quite hard.

--=20
Stefano


