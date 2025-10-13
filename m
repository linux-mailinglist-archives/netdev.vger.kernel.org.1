Return-Path: <netdev+bounces-228689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599ABD24F4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C023B81F4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC82FDC59;
	Mon, 13 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANefejdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6662FDC2C
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348027; cv=none; b=WIjDgbaiO2QIjpylXP8WP0KGgv7curF0SiV/Rdrdigj2TUuxI3emvMsGsYO4mN6BBxmhyFpkmqtpi1vVoFsIfKCANrj8+KZbPqWIH2LKNoZh5yT+U9AXA/496uMDD3bJYQDzx0pILmfb7HVM12h9XoBCc3TWwFVoqLS0oPb4X6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348027; c=relaxed/simple;
	bh=9DfoxQJO2xJdFt9Mmf7Swcpylkh6JlpBRuqdrDcOp4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaBJ52TCseqpiTTvhnllWrVNw2rghhD08/T+WtRfwOMZb6AFcO2FbvJvzWtW5l8QC2L52lzLT2KHWCI1AwWT5hLoApOzI+7JOLngpJwbD1iOWqQDQlxwg/VvLKt/DB0gvqMINAIYMBM/stcPCILIQ8aFas5hPR71j7e3lBVWLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANefejdq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-856cbf74c4aso762254185a.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760348024; x=1760952824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ7E9I2AomebPDIZzI3EMZz00eN4aqCee4UAWJRNu1A=;
        b=ANefejdqat2QtEHi6hx8n2+iY0MXV2m7dB1FZ4ljse+K2iemFw4cBmsbCT66F4cBdu
         UZ666Z9QD1PQ9uEkjbAE2OVuJRx+q9622ujzWBWWmLuYzOEjKKHWDaVIMcv69Dnt+hPa
         TeK+9R1a1datx6Tjobwl03K9C8DQMZISyMXqDwPIw85xHGLyJaOP/BJd6MwgH93UmAfR
         haVIDoxxAD0r9UrD9VIrFXX1NJzm4Xm+9YK3h/XJJeYgdnEZ2ymv3GrujEjotbE85vBG
         5YjCmEGWtVKlGO4Avt7Au4tPnBWhbOS8qcSGdkxZJ5XnfWkZ4FdUoa+lGMEp96+/qUmy
         7fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348024; x=1760952824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ7E9I2AomebPDIZzI3EMZz00eN4aqCee4UAWJRNu1A=;
        b=QxpQ0N08EHn8N3AVQo5w4O1f3bghmGgBVNFvoMrbGyOJkuNRz8dJuJwSHzDE7D86dP
         INsZ9Zs8/DTt+bj1w7cSsHMefih1D8KlrGbGgMaVrzg/5YGm7tQB+5wcmQW3NvrFVanK
         +wj8lO+0AMN+etGftUmEgY6I2c4YnvhgLWMWQDrU6PNbpqFWoJwrIs8ZNwzvynKbiIFM
         vwI3/fiM51apWMmBPtdv9pyYhb9JrrDcJnbUPI8yegooKR6ooMYB8j8OBSR2t9ZEJIrg
         agB+OIEII1k2/8r+OvuW9CjVrq8zWr+yvvbJI75ITWOUaZ6e0nHrFbu5CK41vr3HrJ5/
         oa/A==
X-Forwarded-Encrypted: i=1; AJvYcCUvnnHGiivZIL+l4ZZUKsjcMmmioA9AEENYlH2ZHT03g1yx0vrW4hq6IKpQTvMEm4L0vQMfVaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjB06NrhL/u21ejFz7+PbUrGHCpk3ScYU9zEcrGQWSMvnLnFyq
	z6JeWETmAE8vOxOcI6eAX9904SJE2FCzuBegKjr4pTMMwOxutLVOEtYdWEacHKEfOGfRt4xWKB7
	LG8yIW9As/eOVS6KS2cQrFM66BR2fZVIrDB+3PGwK
X-Gm-Gg: ASbGnct3VhErMix2KqpOL0NHNK3jpGifSaN5KYoZCr+qX3/6fWXqUbfvEMCQQhBK5I8
	YaUiAxf/fxuvon/5lK17yVg2qWvBS2+HEtVmpK9VycWpwsEzyiyN8bequqV/N8yJHkaR+m0evZE
	UD9i4J1mr8NDs1XoZ/r71O2jMfYxAZ8iwjuCu+gPUnF7kmbksCMLKaO2nUTLdqDR44Ye6Py2ui4
	bFyh4xsoDEIffjNvdJvgkggf9LjBt2/
X-Google-Smtp-Source: AGHT+IEXAF/3loRo+AY7OW01hb6wl5Y374NWVq0vRymMmOOZun5ZSuc7xBrm8ivo7AJb1w3mhR90RrvuhFKjJNJ9UU4=
X-Received: by 2002:ac8:5a50:0:b0:4b7:a7b6:eafc with SMTP id
 d75a77b69052e-4e6eacceb49mr288599751cf.13.1760348024085; Mon, 13 Oct 2025
 02:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-5-edumazet@google.com>
 <aOzD6T6dzZNq06Lj@horms.kernel.org>
In-Reply-To: <aOzD6T6dzZNq06Lj@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 02:33:33 -0700
X-Gm-Features: AS18NWAn3ftgPiHpFFoxmN4syQl4_dJ6y8tVsw3K94Lpfv0V3kYHCoqTBFd5xdk
Message-ID: <CANn89iKmatLmXVnBDR0gRd5DfDEeMYbEcgWdH-+n6TGnZja-Mw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 4/4] net: allow busy connected flows to
 switch tx queues
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 2:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
 Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Very nice :)

Yep ;)

>
> > ---
> >  include/net/sock.h | 40 +++++++++++++++++++---------------------
> >  net/core/dev.c     | 27 +++++++++++++++++++++++++--
> >  2 files changed, 44 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 2794bc5c565424491a064049d3d76c3fb7ba1ed8..61f92bb03e00d7167cccfe7=
0da16174f2b40f6de 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -485,6 +485,7 @@ struct sock {
> >       unsigned long           sk_pacing_rate; /* bytes per second */
> >       atomic_t                sk_zckey;
> >       atomic_t                sk_tskey;
> > +     unsigned long           sk_tx_queue_mapping_jiffies;
>
> nit: please add sk_tx_queue_mapping_jiffies to Kernel doc

Will do this, thank you !

