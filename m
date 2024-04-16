Return-Path: <netdev+bounces-88224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149E8A6614
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79661C21212
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EF612837B;
	Tue, 16 Apr 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Y67s8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445453B78D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256089; cv=none; b=KMAzvwrgChRicBUfxCWUuw8QCf50mJKgikQ+Tjrz774rvBcPPoqO/Nuz6kpVc3/ll+xFj55Lpc7OK9ocIr4qA0ZuTkoEGLoNYUR1xaurVTtdzU+/5/376sTkK+9/kH1FikdQIyqW0A8jR4ncgGi9wsAZWoLDqSxMy32L6g2SbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256089; c=relaxed/simple;
	bh=LSQgaKo3zSo2OKX2H5NSXCKesru2UxcFGx0yEKxgHNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH5ar7MGi3RyBN+scHX9EhPzNob/dtCZh4Me/coIuqxJRgTm62iVTsgxyGmQyGg7l8tu9PHjkkn5EsMjWrma6lsZAMwmmEUETCeVnXvvpuKGom4JNlRZkM3TvShFjeB0R4Rznam8cvluK7rR9mlh/5bsODBRwC/JPzZffAqnyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Y67s8X; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46de423039so278760566b.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713256084; x=1713860884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+ru9+o5to7lMi3IghDKB2ArnFLsjZ/4sMwOmVBAEs8=;
        b=P8Y67s8X3i/gAn+c1mSmyVBnIoP7+PT8Z0+bBUEjqHG5moUKnoIpjoOAIy1rUiqPMx
         c4jbLKjHah9gJPDPQBenxXkSaVuUH+a4W5+fPPXnH6wgRn2pv3ib80zqsp4qnLuNnj0X
         94opGD1CBpkkKuKQFr8wIQ79BG6+8U/MO7vcPRfpAscMVX7QI81Ims5fnqk3gnOyLgJN
         B82VEN/nj8XEMj0/grzaVd/hHPrtKg6fLWHuSo8xiaW2ZgiMnlhbI9vxfpW0TtwEkXWw
         n7oUiev5F40rqzhRjfSyOHxvpx172jbmQDbGjYbftLcMEnTJs55zAp7WpZ1fWgQGSyR7
         02qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256084; x=1713860884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+ru9+o5to7lMi3IghDKB2ArnFLsjZ/4sMwOmVBAEs8=;
        b=mMhsc808uudl1ST2Iv1+PgLDmYiJTzypY3CvCZIevT1LrGxnOReUyU3K/W7pFSeC17
         gxAbkOBOIZ6mIsonmGlslDSBsuswaC3nUmDt/xdz5fKPeEA6x+sWXeD/D8FxTnAVtU9Q
         xcB/Qo3xMloVH7yMmqw6nXVz4u7JrBwJEpVHtIzJoGVc6h3ZJNg1BzfFZR6Ke8cg567F
         8TjYy4dQ3x0mqC41FcRhHmQtFq3hK4+qtJu9HS26BbP9AwyIv4Ey8n8Z8O/n0fCHarh3
         nCqjpwDSrXRTKWj3/czlAdJtcVTd0iSdqVgIMllJZUxYuFXgumLbs5LCrxFXfU68jXz+
         xWJg==
X-Forwarded-Encrypted: i=1; AJvYcCW0EYnccLBI+yYr8WNyuQnxhU0fqAYTfV/bWc+CPGGhy/85/qbRI4cn+My1oUyOniP1AVdhAlzn4VhtnkSoMYKBY6NKdaef
X-Gm-Message-State: AOJu0YyvTZ1QPCWEjNUt+m7I45DtEWakoGhsZWrDu1NwCayenCdsaFvr
	NgPPX4fx+r5e4vxVocoxHAYiBsh41yx+ab9oZ76FpdPzrbS2wS9d6q9agAtJDAkAWA5VxX1LVVQ
	r50UdRRffcuPKyXu7mrnz4ySKZIZI/vwJ
X-Google-Smtp-Source: AGHT+IE9qKbZfvuCwUNj6/uaLhFRNzBVWXxKt2l3pIoyrkMsYkFfVgRm2zv+DBpOtEuXgxnwzObBuL1oEK2x1uWEw6w=
X-Received: by 2002:a05:651c:102d:b0:2d8:2d0a:7b9b with SMTP id
 w13-20020a05651c102d00b002d82d0a7b9bmr9844589ljm.14.1713256063849; Tue, 16
 Apr 2024 01:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-4-kerneljasonxing@gmail.com> <2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com>
In-Reply-To: <2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 16:27:06 +0800
Message-ID: <CAL+tcoA+vtTKLQGMrbS5Y0-Wmq4M0BAzojWKrT7KA6Ju_Eh0bw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/6] rstreason: prepare for active reset
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 744c87b6d5a4..ba0a252c113f 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -412,7 +412,7 @@ void mptcp_subflow_reset(struct sock *ssk)
> >       /* must hold: tcp_done() could drop last reference on parent */
> >       sock_hold(sk);
> >
> > -     tcp_send_active_reset(ssk, GFP_ATOMIC);
> > +     tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIE=
D);
>
> I'm sorry for the late feedback.

Thanks for the review, Paolo :)

>
> Some of the caller can set subflow->reset_reason, so probably something
> alike the following:
>
>         tcp_send_active_reset(ssk, GFP_ATOMIC,
>                               subflow->reset_reason?: SK_RST_REASON_NOT_S=
PECIFIED);
>
>
> would work - with an helper even better.
>
> Could be a follow-up patch.

I see. I can add this as a separate patch when I submit soon with your
suggested-by tag because I also want to make every patch clean and
simple.

Thanks,
Jason

>
> Thanks,
>
> Paolo
>

