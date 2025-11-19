Return-Path: <netdev+bounces-239871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426CC6D567
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 281304FD1C4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879E32BF46;
	Wed, 19 Nov 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9X7kMoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC92EF673
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539307; cv=none; b=PLnldH+7RipDq3lwg9J0VcwQ8cF3MeC12gD+VMGbs9OcDYa9L3kLJcjW3pP2wtO83d3yM2Epp/24NeEzYjlAUuUNUqbJxjNb8DoGgjY3QfSCu/JuTvmRwZeI2av3weJSYwJDmNZTa+yvZKkljZ8ahyYrcakI3WlxOC5MEoK6vFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539307; c=relaxed/simple;
	bh=0TBmqklw31qv0EXQ3EZ3FDM8CQDT/8C2HPHLN9YEjTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK2poO4b539LnsVtVDDuoxIRnqOYneJ0N4TaI98hVTBS9vUvYIh200iGHdeF0wlsBjd2wuONmTyzQvysyOwDUvnt3xRgzuxPN3P4XX8o+UsMCBXsYcpQjcAH57YfRxTXxRzrUumYKdSV2Bqpyi3zuvkv5uh/LYSM1+4jwQ162Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9X7kMoX; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64107188baeso5866491d50.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763539305; x=1764144105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSI3tSrrDT6dXrt+GLht/ivtiT+nZxBQRKJRVnXP9Y=;
        b=s9X7kMoXEJG03SbHYxpygI56QwcI5VSbQ8AQqs82A929fiq450IldR3qQGqjXIIp0B
         ljn1GGDqpHoUdZNoXo33xtT6mvcKOag/rbnBHWlgAzfUIU9fNlGbimjmbn7ItUWS/WQR
         lvN+tXJSov63CdJbWrBvV3Ee8lQOzBJAQFi6zp1O3TLVEYKgVGp50Z0vMKc8wfYj2bfB
         HrYicaYKQ00pmWSKCpuvcbZoXE+21yGMQHDMIkcuMPksbEpTrbLuSH6oglI8mJxmaZYC
         tqy2B/e5Qxd49k8Xhr3XlR/vvsov/VD4h/nvfJdsWhHOVOWKCxQDSY5rs4PDW0iJgfYd
         412Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539305; x=1764144105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJSI3tSrrDT6dXrt+GLht/ivtiT+nZxBQRKJRVnXP9Y=;
        b=Y3nS0huKdYQAtJGhCZ5K5uvvA4r3upJZ6NrGZWAQ/Yep/fIFG9MMG1HNndvjC/53MN
         VXyFP8eo42poMNgthB5BowwYaM1sS7YU9wJs+GgKMmYh7wYpHfPfbjTIGYXTj4uxf33V
         LczNnLgPCUWcYk02SJBeLlYGBM5MSevs1k1CzU94HGc8Av961uUQPHqYpc9G33jrHWcS
         9GZIHhADz8YROKdp9n7QNyqjBfg+H1aeUsFeIwzn0sj5sF9JsF30rW9v5UB/ojGRJkb1
         94UK2XCIdRIwb/oanJtsq39K0yB9E+LeQdDujsqClbT3MGBbxGUsAIoM1E9+JHMB+oep
         Kh9w==
X-Forwarded-Encrypted: i=1; AJvYcCUYLyKn2jpmOkVATCOFvq4qPcuQ7sdGVQnYebFH/hBH3yLkvXyBg3NJtEnNa4SJMhHwbfp9QpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjTO0D7gQR0E9c1hMX2R40+xXnOwQI2syYU6UAouekXk11No64
	kvzrLvQOw9c2WEHQF8yecBmdmgglWlc8qGlPASbSoPUyrMD0i+gmZuGZKSKKhOqp6QSoB0YVL95
	30VT7445GvHkSv5GiaZbA4jgawLWs2wFKEcm/dcHa
X-Gm-Gg: ASbGncuc2VZ4KjehnDUOOX3ywjMXOMez2RNSvuY8Iq0Xu90MQOKD4YhI/4NZKTfWg5K
	Dq6yn0jeixydMyXgwPCZzW+3OZ/68/FZfjnzsVjp2nTiuQBhU6bFDz0M9ex9cjEeXTphBcIFVE9
	vnJf6TACKEuj0i7zGbxY2zlouUXz9QsMOJiJbVON5Tk2B7+73qvQ4M+y83F5Q3sDdZuG+syHUFR
	Qc9FxcPES6o9Ao4FnDWhVSnoZFy65QtVW9LMvHT44mjowZUMJGfcGNYUUf7D7e9yRnU
X-Google-Smtp-Source: AGHT+IFEIHqm8JhwXf+uwrqNBH0++IUaL+fUnAxcHl+f+UoA+rgPimpPmEfG/0j4dY6YqgSwTSCZh3raJtqz/3rCLj8=
X-Received: by 2002:a53:c055:0:20b0:63f:a856:5f5a with SMTP id
 956f58d0204a3-641e74a366bmr13781155d50.1.1763539304787; Wed, 19 Nov 2025
 00:01:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
 <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com> <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
In-Reply-To: <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Nov 2025 00:01:33 -0800
X-Gm-Features: AWmQ_bnP9Rz2OMxO7JHyhjafzjXsjJ-iaAqsbfsLTZSt57wF95O4OSRa99sVCPA
Message-ID: <CANn89iJfnWSn-1hghtJEaZ5u8_+9B7eCTZ07U9GnGh6UxS8rJw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Nov 18, 2025 at 1:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > Hi,
> >
> > On 11/17/25 2:28 PM, Eric Dumazet wrote:
> > > This is a follow up of commit aa251c84636c ("tcp: fix too slow
> > > tcp_rcvbuf_grow() action") which brought again the issue that I tried
> > > to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> > >
> > > We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0=
d
> > > ("tcp: increase tcp_rmem[2] to 32 MB")
> > >
> > > Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> > > too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> > > force NIC driver to not recycle pages from the page pool, and also
> > > can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> > > are usually slower than senders.
> > >
> > > Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1=
 ms)
> > > If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshol=
d
> > > ratio to control sk_rcvbuf inflation.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > I gave this series a spin in my test-bed: 2 quite old hosts b2b
> > connected via 100Gbps links. RTT is < 100us. Doing bulk/iperf3 tcp
> > transfers, with irq and user-space processes pinned.
> >
> > The average tput for 30s connections does not change measurably: ~23Gbp=
s
> > per connection. WRT the receiver buffer, in 30 runs prior to this patch
> > I see:
> >
> > min 1901769, max 4322922 avg 2900036
> >
> > On top of this series:
> >
> > min 1078047 max 3967327 avg 2465665.
> >
> > So I do see smaller buffers on average, but I'm not sure I'm hitting th=
e
> >  reference scenario (notably the lowest value here is considerably
> > higher than the theoretical minimum rcvwin required to handle the given
> > B/W).
> >
> > Should I go for longer (or shorter) connections?
>
> 23 Gbps seems small ?
>
> I would perhaps use 8 senders, and force all receivers on one cpu (cpu
> 4 in the following run)
>
> for i in {1..8}
> do
>  netperf -H host -T,4 -l 100 &
> done
>
> This would I think show what can happen when receivers can not keep up.

I will add a Tested: section with some numbers in V2.

And switch to tcp_rcvbuf_low_rtt name as Neal suggested.

