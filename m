Return-Path: <netdev+bounces-83159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E898911C8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C421C23D3E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736033CCD;
	Fri, 29 Mar 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRojzt/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990E383A0;
	Fri, 29 Mar 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680826; cv=none; b=U2YN3v2/9jXXpD4IfnqWCrw8QoKy8mMM1g+mBCA37W1Bv+DlcFH9nA5v257vXWisdM/0N7MYPpKEQSez+uXcpyA0E+ealRlKToGpNmIJgBktwC6hqyh4IKE+MphE2ZN5TeQVFhe6riq6WjLZE939LVtdG658ckjl6UGUoRxYozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680826; c=relaxed/simple;
	bh=kUjIkFCFW/37NpYec0q+bwZz21tGEn65Vrw7kiuiV1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSggdnxOlAi8EWQA47YVOhkgr1RvsN5mueOdiYC/xw7jRd2XkzN5HKXUwaRsgkfSdjYfrALxx3E0yIPy0Qw2FWoADl8qy0s7FuwFS7sKuC6FiZnrJLhqZ6hMtnzBt0BX95hovmxwb1B0SccpiTWahE91fq+QqaK8HnZF75dO5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRojzt/3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so193198566b.1;
        Thu, 28 Mar 2024 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711680823; x=1712285623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhlRRGgZggZFbFirfkGQtF+vt3z2xKrM8EkCG1f7FB8=;
        b=HRojzt/3pbKZLTvZ5CiLp8JV4sNieL444FZAAh8GrC0E0lmLQkje8QQg/jZDWltP2u
         kCQTXEInGDHm5NnwFdn8yOAiqLgRQ81uTyOd/kZsY+DXOtGE2UX6eP1J2Ska5lXGwtm1
         rAAq9+jDaJVA/nFhpZvrik4TuyrTGzkudonrETYtKA/v94Yn4RWrOvXm9P2a/mCyPi2E
         w/Njkrvh+XvSRnWGyPsuY64p7i52iWLuh9hCeYa7enOJCOJwiYrTWw3PsaCCdgHjiY+k
         45lKkxlmPXn8oXgSDNZPcJquvw6sotvNmaW2yLY0t7MzcmKIq1O23LTyvbmhfK6kllYa
         db+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711680823; x=1712285623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhlRRGgZggZFbFirfkGQtF+vt3z2xKrM8EkCG1f7FB8=;
        b=Tj2DxJFQ/mfEc5I6nxpD4LqX6fHSQeuZFQsDFKzy+gIj7AvHNiYr/e7I8/MfMq3jrS
         O1F2TlBstE/dWEV9Bn0cwqc8MMVhpz+TU3wNwfv4nav5vbJNCRflA/sFdae7WRS25I5j
         i+x549hTHNUpgADk5kB0cr7XdByJEI9JexPOGZaSJbW5A918+rrEhRirg2EQpdQMeZR4
         Anql+BoI5owMI7aMqDkNKmD45oe7/yxR0WyehrCmAn/9Y/5Em6RxAa1m/9reVfB92G5P
         Obe+Uu9LEFkkc8s5uh2iV3fqERPQqOl9IN+Ynn9CMYjm/xmUxXePeR5yFrShEVid2B5v
         oQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUOxCQ7Pyx49086NbCLENAtwo41BGCX6V4EqHwXmLdxLy7e4DDCvubH0mT6BhpHG00fnfU4a/EuO53eiDz754/JXRvvyoAXRNMmO3psn9JhIdiOrUbLSXAwqPXFuZaIoaarZJ/QB1U2PXtx
X-Gm-Message-State: AOJu0YyVQcLXCmYqH/lYmT5I26BN2gaFWZ7o4srxBAJjnHlJRhaYhKv3
	O09k+saKLNjvzD9o9Zuu6s908F/zR+05SKG8SmEWNrXToZy1eu8Lc1jXnaKXICdlgmNdqrwvVwm
	URMMZBoH+5MDMfW1SbebWiNW+uFs=
X-Google-Smtp-Source: AGHT+IFNIriTjX/aUzQr0QUTV8OQHanFdv0jbHjil/QXvQR69NfqcWNpTXaKD5EvAIy07KbpyH1HPtcQAbIsjWUjmMg=
X-Received: by 2002:a17:907:174b:b0:a4e:2543:29f1 with SMTP id
 lf11-20020a170907174b00b00a4e254329f1mr702944ejc.2.1711680822910; Thu, 28 Mar
 2024 19:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325062831.48675-1-kerneljasonxing@gmail.com>
 <20240325062831.48675-4-kerneljasonxing@gmail.com> <3186e70ecd98893710f829723f866ab92250ea74.camel@redhat.com>
 <20240328181530.0d9229cb@kernel.org>
In-Reply-To: <20240328181530.0d9229cb@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Mar 2024 10:53:06 +0800
Message-ID: <CAL+tcoCF=tndnFQdBK_7r5KssyaHs+nDf3qmDbPgy5wJFvTe+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tcp: add location into reset trace process
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, edumazet@google.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, rostedt@goodmis.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 9:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 26 Mar 2024 12:08:01 +0100 Paolo Abeni wrote:
> > > -   TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> > > +   TP_PROTO(
> > > +           const struct sock *sk,
> > > +           const struct sk_buff *skb,
> > > +           void *location),
> >
> > Very minor nit: the above lines should be aligned with the open
> > bracket.
>
> Yes, and a very odd way of breaking it up. Empty line after ( but
> ) not on a separate line.

After I blamed the history, maybe I should follow the format like
TRACE_EVENT(netfs_read)?

>
> > No need to repost just for this, but let's wait for Eric's feedback.
>
> Erring on the side of caution I'd read this:
> https://lore.kernel.org/all/CANn89iKK-qPhQ91Sq8rR_=3DKDWajnY2=3DEt2bUjDsg=
oQK4wxFOHw@mail.gmail.com/
> as lukewarm towards tp changes. Please repost if you think otherwise
> (with the formatting fixed)

Yes, I will repost it. I'm not introducing a controversial new tracepoint.

This patch is not only about whether we should use 'old-way' tracing
but about the tracepoint of this tcp reset that is not complete. Some
admins could use bpf to capture RST behaviours through hooking this
tracepoint which is not right currently apparently.

Besides, I simply tested the performance between using tracing and bpf
to monitor the fast path (like __tcp_transmit_skb()) on my loopback. I
saw at least 12% degradation with BPF used. So the advantage of trace
is obvious even though nowadays it is considered as an old school
method.

Thanks,
Jason

> --
> pw-bot: cr

