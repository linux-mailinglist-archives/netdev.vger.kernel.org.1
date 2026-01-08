Return-Path: <netdev+bounces-248266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D236D062B6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DBEC3010ABF
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C6330D58;
	Thu,  8 Jan 2026 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+nl6nbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA1330B3F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905607; cv=none; b=QQLtgBspvRZjdozskpj1aOh3kY0U0x9JNPCqvlT0qDXjOdlIRTCr9ayDZPevTGubbUOkKf6tawDWr7U43tD1Pg82q9R579WDg6DOoa6HiJiXN31+3a++PJSDlx8wBpT8R+OaSmsjfz+r3dta/Zsc+HvOHKgLfq9RdkyqCr/qtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905607; c=relaxed/simple;
	bh=fgATqevtP3BM94zxoNaA4simYmqtdH2O6vZFv5ELDsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoV7oVnxiwRwOp3sJosnxa36eHb6kOWkl/bdCy/QcbikJaom6WOBZ8VnR8hSssbad+etQ+/bJVpJQwpACgwSe1shm2PYA0zKQlUY7h/4eyDl6skUHYR+4nhydUkDJWVpHHNNu8iLDgEZXLN6F3CYTqsGB22l/yhX/OJe6btD4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+nl6nbR; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446fcddf2fso3861295d50.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767905605; x=1768510405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G7wPuVfMUEu+XU77xIHXJuSU5P9IBRqFiZrRft7fD4=;
        b=w+nl6nbRebUTEMJKer3iHAJb6oBB8pRb/ag0oE2ZJjSusxGrqJ2C8CScZLAe9Aa7uG
         vx9XD8RnpA3HNcHC5900TW5vKKcHqeQS04fV+ldhNeiZMFCSeg388tihjlGBBwzx2Qfs
         6TXd1VnIEGvoQ6G5REEuxOqc/PQnK6XmoaWai+3DSZUSIrk/93ujMGYItl7744d1C+Mn
         fcOxXVhhOcFJV5PFfONdtRbMTyQ273P+z7G2xuWuAWtpiI4JypNJ7FqnseS8g5v/041y
         d/L3cYKGV96cIAM2Xt/Ch9bhSzmmOYj2zmQm8QoycVa+USzGORXr2R7m8i+vZAExAoEu
         tCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767905605; x=1768510405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9G7wPuVfMUEu+XU77xIHXJuSU5P9IBRqFiZrRft7fD4=;
        b=PRLkJTO8/qV6Ii12pw4f8EAqr5I3+FgzVAlSjWmnHEiLVUm6bf5LNJCgQmdewG0/G2
         KV2BX4vzCGDiEE0OMdqTGBUDPdr0I9LXlUdoOeR2z8RM4fAC8OOr7FBmpeDzJ4+XWRsb
         x2okMOBOovcG5vuuExqYrtSGubboMIECEk1aP5DYf1I2ZyLfGgkV/zhqeyuL9YBqAacu
         WqpLfxxU2hs++OPhLRj+2AkEk2VuQ/+32OojCKow62K5BAtDDXOZyFpyNE2weB0Vxa6l
         J5Musl8PIzK6CqzyYePs89//KMoq+T2jgWPFHCeuujL8fZ9BeY6s1lAy/1hgFqjUalA3
         ttzA==
X-Forwarded-Encrypted: i=1; AJvYcCWURoUDZ2ugK1wNvrbryzUUOTU4hVdun6sKHC5yHPqmBSDF8bwaVzkTRD1AMkDWtgRAO1CwnO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZb4a9/sOYXjIdf1YvT2PN0/H/dVbR4OX/ckrT7KwN38mhAPuP
	leszW/bMnB1/AO9EXRQjJlySgzFmM2XXycuqP3dnKEzSACG8iu3etso4DL1MYGsISZbaJMxTx47
	0R2ljmkaZ2bQg5BF+GeScKIkXkp90bOnNCRDoaSqp
X-Gm-Gg: AY/fxX6pAtitMcG01LlvMQX/QFk8Am3NBb8Nuk/EPIW5VdNfRafZMntsjGxCp4Zywg1
	2OrVz6laBCnZezLiLjER7YdjzFOMFlTYbi3Xwwri9XswfL97Cg2dHefmwzTzKqBEJbvrO7CF93n
	wIuCWnaLeM1/2njpLTzV43ZDwMcLNnL5w5KGMSfZTw5/GKvgKbZHOBQZDvNGk2W7oR1jVBfNprd
	RN6H0U9M7IBu5MY8JbcwRD4tMwY1AajRMoPaoEJH6K4d2bgdVdKZ2fzZAOC/aoCUf39adsGQZ8t
	GOAkBswV
X-Google-Smtp-Source: AGHT+IFfsXLIOQoowsK4hd0ehUg1Ov8vdpWioepVx3d4dhbTTVXSJg1Tj9/T3e3FGQHetVwrMtOEOfIKvteUHmVMjjg=
X-Received: by 2002:a05:690e:1c1d:b0:646:bb17:1515 with SMTP id
 956f58d0204a3-64716abe6afmr6611764d50.19.1767905604924; Thu, 08 Jan 2026
 12:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
 <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com> <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
In-Reply-To: <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Thu, 8 Jan 2026 12:53:09 -0800
X-Gm-Features: AQt7F2paXYKlCmGeTnuQcEGigGANcGPgcSVsAVj8JM63TEpsjULC0t9r9-C1EyU
Message-ID: <CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, 
	Sagi Shahar <sagis@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 8:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Jan 8, 2026 at 4:36=E2=80=AFPM Ankit Garg <nktgrg@google.com> wro=
te:
> >
> > On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > > > This series fixes a kernel panic in the GVE driver caused by
> > > > out-of-bounds array access when the network stack provides an inval=
id
> > > > TX queue index.
> > >
> > > Do you know how? I seem to recall we had such issues due to bugs
> > > in the qdisc layer, most of which were fixed.
> > >
> > > Fixing this at the source, if possible, would be far preferable
> > > to sprinkling this condition to all the drivers.
> > That matches our observation=E2=80=94we have encountered this panic on =
older
> > kernels (specifically Rocky Linux 8) but have not been able to
> > reproduce it on recent upstream kernels.
>
> What is the kernel version used in Rocky Linux 8 ?
>
The kernel version where we observed this is 4.18.0 (full version
4.18.0-553.81.1+2.1.el8_10_ciq)

> Note that the test against real_num_tx_queues is done before reaching
> the Qdisc layer.
>
> It might help to give a stack trace of a panic.
>
Crash happens in the sch_direct_xmit path per the trace.

I wonder if sch_direct_xmit is acting as an optimization to bypass the
queueing layer, and if that is somehow bypassing the queue index
checks you mentioned?

I'll try to dig a bit deeper into that specific flow, but here is the
trace in the meantime:

Call Trace:
? __warn+0x94/0xe0
? gve_tx+0xa9f/0xc30 [gve]
? gve_tx+0xa9f/0xc30 [gve]
? report_bug+0xb1/0xe0
? do_error_trap+0x9e/0xd0
? do_invalid_op+0x36/0x40
? gve_tx+0xa9f/0xc30 [gve]
? invalid_op+0x14/0x20
? gve_tx+0xa9f/0xc30 [gve]
? netif_skb_features+0xcf/0x2a0
dev_hard_start_xmit+0xd7/0x240
sch_direct_xmit+0x9f/0x370
__dev_queue_xmit+0xa04/0xc50
ip_finish_output2+0x26d/0x430
? __ip_finish_output+0xdf/0x1d0
ip_output+0x70/0xf0
__ip_queue_xmit+0x165/0x400
__tcp_transmit_skb+0xa6b/0xb90
tcp_connect+0xae3/0xd40
tcp_v4_connect+0x476/0x4f0
__inet_stream_connect+0xda/0x380
> >
> > Could you point us to the specific qdisc fixes you recall? We'd like
> > to verify if the issue we are seeing on the older kernel is indeed one
> > of those known/fixed bugs.
> >
> > If it turns out this is fully resolved in the core network stack
> > upstream, we can drop this patch for the mainline driver. However, if
> > there is ambiguity, do you think there is value in keeping this check
> > to prevent the driver from crashing on invalid input?
>
> We already have many costly checks, and netdev_core_pick_tx() should
> already prevent such panic.
>
> >
> > Thanks,
> > Ankit Garg

