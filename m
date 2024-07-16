Return-Path: <netdev+bounces-111696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9535F9321AE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83C91C216B5
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B44D8B8;
	Tue, 16 Jul 2024 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc/FJWY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3F2EAEA
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117528; cv=none; b=eaa5Btg4uiZHn8C1jPOunz/soZ1gFZDI74LUTyInhJtac9Wirb8TY3kN6yz2SDdtP7gToN12j5BwrYiBXU1DSqIqzZRQClv8QNHl1zYgSYNRfw9h7JWG4szZuBAkJeMVhHjnCpSficDM7EOfh7m43ixzxNY8ACHhgVqfp3MGbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117528; c=relaxed/simple;
	bh=kHfEAAEG4WCofPeO6MjqbQgR3QoC9KpFPw/aLaRPOLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWVOZf5FNnXzB6jOysFLiSVhnj+HQHpIYAXJy8fUzmN/5f9le/66HlBxNcJnONs7jBjyq4VNxwrEpgsCiPNPPDn/7UWQzjMKTX8NQgUaofmzPU7zwnknO/lVEkXR6U8wiaz9z+DA0ut+Clg7aLhbSLu0XKlv7a9LDVoNxbZmUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc/FJWY2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so9258695a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721117525; x=1721722325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHfEAAEG4WCofPeO6MjqbQgR3QoC9KpFPw/aLaRPOLQ=;
        b=jc/FJWY2dIoiA1W9/P7nDKh4f3T/HDCfK2ydMSLHWk4XjpWtwtf9C1eNQASEIgJ9Xw
         Enk9Kbz4OAsDInAUDf2adak3AxkgjKXjADCvdyI9OOJbWb4Vvlo6R7SBsMaAdBsAvrj+
         979huCb2pH5WaOIvHohQ4QTELyXayBWbbt8qqupK+Qz/mcTqsc4GFgABHaf5PKD/SssG
         PCSFhAw6asCGr+PtkylDLclDiYxefTIomeKdjTWvCeFFQZCBSRP/kL/jR1ZHPbbJ8EMp
         Xp/+oZCaLt99n3gBv/9bqgauxbJcxob8dkl8ewXdrRy25ZAH+lOxuWT9gPbfGexvuF/D
         siOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721117525; x=1721722325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHfEAAEG4WCofPeO6MjqbQgR3QoC9KpFPw/aLaRPOLQ=;
        b=lE1yXEjYgcbGnOOhY/RNCSUqyXJoI/8jd6wL9pnDpEpNmuv9erVh1uGN9R8PKokcjs
         TPM3PYCEM0oeErQh6D7ug7hQw6K919JclXHCm4vSxOK0VU0XIBTEP7ZVMWmOXp/NnJoE
         VDBBLGK+zJoAMZc4zna1y/JIDTzoKbxcJi/9tyZ3g904tYEGMkGvojeszH8FoQytyJNh
         Xet08WMH8R5pkjLFbZMDUSz7WkwPNZ/7ZKJbKl8TVBCt9IZq8o9djXztEwpNiIxlmruB
         fVIWa66nDf5tP7B8UmVlUrFLmqXdq+Hn+gt/b5vNN8QbX4e2N8NGikwbZfbkA/EBKYzA
         CBgg==
X-Forwarded-Encrypted: i=1; AJvYcCUtW8dJUHebEXVPaB3bfBH3ABWtBftKKsDXLMTMuF3WDiswEZHIiC5l+fNA4xw7L2k3p1QRtEvHRUnXUuwpNdBZWZ20OBKw
X-Gm-Message-State: AOJu0Yxerq/A6tkg0KWsK3T1L91Vb50chXcBwT002DEJ1E0WnmsivrDT
	BZOU8+zuWXgEW5nDeiAoKldvsupt/yYLRy49NRX7GxjDdLm8J82WpySQBRMPWsBgfxTd8GzDYmI
	OdVs04GzSeEQdqdDKycYAkvoDEc6ALgJL
X-Google-Smtp-Source: AGHT+IEuutJqrWg/YFWeKP1UQCexS9ft81TPjH8jV+BOn01B8AcKB6Y1bz5iosBcyZCJLyncg/4+mTwQdpu+xFCImpc=
X-Received: by 2002:a50:8e4f:0:b0:57d:5442:a709 with SMTP id
 4fb4d7f45d1cf-59f076a2869mr1162034a12.0.1721117525196; Tue, 16 Jul 2024
 01:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com>
 <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
 <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com>
 <CANn89iK7hDCGQsGiX5rD6S29u1u8k5za-SOBaxY59S=C+BgaKA@mail.gmail.com> <CAL+tcoAuQFHf_NPNF6ogK8dTZu0V0kts=KyNqfWHJxHWShc3Hw@mail.gmail.com>
In-Reply-To: <CAL+tcoAuQFHf_NPNF6ogK8dTZu0V0kts=KyNqfWHJxHWShc3Hw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Jul 2024 16:11:27 +0800
Message-ID: <CAL+tcoDJGqZh7UcQdemPQ4h_5OEoN3cpvn5F=NEbhMX8TNPNcA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:14=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Tue, Jul 16, 2024 at 2:57=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jul 15, 2024 at 11:42=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Mon, Jul 15, 2024 at 10:40=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > As we all know, the algorithm of rto is exponential backoff as RF=
C
> > > > > defined long time ago.
> > > >
> > > > This is weak sentence. Please provide RFC numbers instead.
> > >
> > > RFC 6298. I will update it.
> > >
> > > >
> > > > > After several rounds of repeatedly transmitting
> > > > > a lost skb, the expiry of rto timer could reach above 1 second wi=
thin
> > > > > the upper bound (120s).
> > > >
> > > > This is confusing. What do you mean exactly ?
> > >
> > > I will rewrite this part. What I was trying to say is that waiting
> > > more than 1 second is not very friendly to some applications,
> > > especially the expiry time can reach 120 seconds which is too long.
> >
> > Says who ? I think this needs IETF approval.
>
> Did you get me wrong? I mean this rto_max is the same as rto_min_us,
> which can be tuned by users.
>
> >
> > >
> > > >
> > > > >
> > > > > Waiting more than one second to retransmit for some latency-sensi=
tive
> > > > > application is a little bit unacceptable nowadays, so I decided t=
o
> > > > > introduce a sysctl knob to allow users to tune it. Still, the max=
imum
> > > > > value is 120 seconds.
> > > >
> > > > I do not think this sysctl needs usec resolution.
> > >
> > > Are you suggesting using jiffies is enough? But I have two reasons:
> > > 1) Keep the consistency with rto_min_us
> > > 2) If rto_min_us can be set to a very small value, why not rto_max?
> >
> > rto_max is usually 3 order of magnitude higher than rto_min
> >
> > For HZ=3D100, using jiffies for rto_min would not allow rto_min < 10 ms=
.
> > Some of us use 5 msec rto_min.
> >
> > jiffies is plain enough for rto_max.
>
> I got it. Thanks.
>
> >
> >
> > >
> > > What do you think?
> >
> > I think you missed many many details really.
> >
> > Look at all TCP_RTO_MAX instances in net/ipv4/tcp_timer.c and ask
> > yourself how many things
> > will break if we allow a sysctl value with 1 second for rto_max.
>
> I'm not modifying the TCP_RTO_MAX value which is tooooo complicated.
> Instead, I'm trying to control the maximum expiry time in the
> ICSK_TIME_RETRANS timer. So it's only involved in three cases:
> 1) syn retrans
> 2) synack retrans
> 3) data retrans

To be clearer, my initial goal is to accelerate the speed of
retransmitting data. There is a simpler way to implement it only in
tcp_retransmit_timer().

