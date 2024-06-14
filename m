Return-Path: <netdev+bounces-103514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E734190863E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8417228D6B5
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3E1836DE;
	Fri, 14 Jun 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmV1WZxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2F18412E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353518; cv=none; b=eEAaUHtNFmtsJwQrM1+eZc5d5DiTxGvVoTIQMZRWM75lhPt7olCXkhjbCPSDzljruO85F0FOfl2hJU8E2lt6cxhg2NzVBIUnEM6pr7pk1RgB/tD5y74z++ccVAYSHFaGVK5hWDlER8SlejqnBzYhHwURZUtZvOhPZZZYWJSs0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353518; c=relaxed/simple;
	bh=j0ige63tNDeqkoRgKmbWXdcRg6UtCz60XQwalweLsTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onYANkdvqX7d0SQvLtcYs/jv+a5Y+v+mA7GrBgqJSGV3pmVzZiOLJdcM9MyW15KPzYn0ie1lOXVb7jPJww6uvKyyIiONc6XvbzDmNLqQhTGKEsju9i7busJoQeptLwRgjmZ7YKM98BZO/zdV6DflatWUWlxEDuMALCk3W0PB4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmV1WZxj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso11465a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718353515; x=1718958315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0ige63tNDeqkoRgKmbWXdcRg6UtCz60XQwalweLsTs=;
        b=VmV1WZxjNXUEiKt6lkuZ5YCbS2wbhyChvKmRJUBLDsbu5uHOjNnufoCot66pgjmGxN
         UGXnc1K7qomgfHy7c6Zd+1UGAoMUiglQ3sQFMgGSurGzUZ282S7AuJb+90E4FGO9gQBf
         ejtE3jLJRknmMYNsAKAWktOrGQ8U6os13KSi1TnSEbnUJeBo8jq2/NAoKvg3vdbhhDZm
         yWgnCfHQRisfS0ctmn9MBD/c9gkvdQ7bDHHofyoEqMFf7Cd/RdvejB2VvMbIZIer3VCG
         dAN0wtcDBy8KOK8oi1BbhUqo13qE1iO0IcDE7QA5oThNS+XMZdBlBB/Q++2uBoq3KtqT
         RhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353515; x=1718958315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0ige63tNDeqkoRgKmbWXdcRg6UtCz60XQwalweLsTs=;
        b=iLcVAT1dWf+gFZ6wxtLpjDC12OHySm20xk9oYgFx86OyWXROoN4L989aXyWM162x8R
         naCLaZthfSft18RKH/4s+jnbLA3laSvk+bYHf9xpNMUOv96sJ5DB/5EZquGByPkZoXjw
         0IPzY19s+Z5ZkhBOsHZ74uyg9K41v9FOQqx2P3Smp/6FOUTI8U3vfcxFoH+Zf5lV7rvY
         JEuwAz0bN0q9NesyPgB3SGS8iMxZ6Bdy5GxgcJ8N/ywkNv1bG02MUBZR+D5VLalo8/2b
         OjwxZZeAc4X7jt5WkJrUdsaevdzeK2Sb87EfroatbKY9+eQUcWrP9CZzfQRYJfOzZFOm
         SHhg==
X-Forwarded-Encrypted: i=1; AJvYcCXtCfPmBRLeAjTmuc3kq7lqqV1xOpTTy1kMgu44s31Awn9Stm7DlGtoFQxfRCENurCvUkLNvgqiwo4cZaZ5CMhXmx5cTbC4
X-Gm-Message-State: AOJu0YwC8/LoOfCtmo2SRqKhZgkqaH0rFVMiD8VbIkbKI0ZZpIQEKnWF
	+GhPWss1JPKEe44SoVbyveVJOqtTUTmwUO5CP9y4CFqiPJXhntsGeQXDuMwk9IoDCjGoQMOfOR5
	rXMMAKDMhgLtqMLDudYBCxTHvsGwT7+bnxzXP
X-Google-Smtp-Source: AGHT+IHEli08KGm2a1wLSdujkI4kay45Ih8tszllA5JMQp9Khg4YDNeDtlFB5NALarfIqWIzcXOczTzBfWurJz45COo=
X-Received: by 2002:a05:6402:27c6:b0:57c:b799:2527 with SMTP id
 4fb4d7f45d1cf-57cc0afaa4cmr90302a12.7.1718353515061; Fri, 14 Jun 2024
 01:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611045830.67640-1-lulie@linux.alibaba.com> <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
In-Reply-To: <c4ae602bd44e6b6ad739e1e17c444ca75587435e.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 10:25:01 +0200
Message-ID: <CANn89iK88gJG2PsEnXWmN=kPydVqbNGZeLQ69p+Ho+60FWzaSw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Add tracepoint for rxtstamp coalescing
To: Paolo Abeni <pabeni@redhat.com>, Mike Maloney <maloney@google.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, xuanzhuo@linux.alibaba.com, 
	dust.li@linux.alibaba.com, Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Tue, 2024-06-11 at 12:58 +0800, Philo Lu wrote:
> > During tcp coalescence, rx timestamps of the former skb ("to" in
> > tcp_try_coalesce), will be lost. This may lead to inaccurate
> > timestamping results if skbs come out of order.
> >
> > Here is an example.
> > Assume a message consists of 3 skbs, namely A, B, and C. And these skbs
> > are processed by tcp in the following order:
> > A -(1us)-> C -(1ms)-> B
>
> IMHO the above order makes the changelog confusing
>
> > If C is coalesced to B, the final rx timestamps of the message will be
> > those of C. That is, the timestamps show that we received the message
> > when C came (including hardware and software). However, we actually
> > received it 1ms later (when B came).
> >
> > With the added tracepoint, we can recognize such cases and report them
> > if we want.
>
> We really need very good reasons to add new tracepoints to TCP. I'm
> unsure if the above example match such requirement. The reported
> timestamp actually matches the first byte in the aggregate segment,
> inferring anything more is IMHO stretching too far the API semantic.
>

Note the current behavior was a conscious choice, see
commit 98aaa913b4ed2503244 ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE
to TCP recvmsg")
for the rationale.

Perhaps another application would need to add a new timestamp to report
both the oldest and newest timestamps.

Or add a socket flag to prevent coalescing for applications needing
precise timestamps.

Willem might know better about this.

I agree the tracepoint seems not needed. What about solving the issue inste=
ad ?

