Return-Path: <netdev+bounces-190499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA2AB716A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1488E189424B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D51A2391;
	Wed, 14 May 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8rWrjeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919217B425
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240326; cv=none; b=MzH91f9uS1l8+bufZN/8jVV/KRj7zmJPhjD5g3c54Xxhx8e14DkWoZhOez7rWUwFMlP44nWXnhPFtTfNDVYH8ax2jqAAZ6iN+RaDknbTuR7tI/SohfTlGjmJvWHyhoAfrIuBl6oCsRnUFV0RD+NM13ERAxXpGC9tC/evO1OeIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240326; c=relaxed/simple;
	bh=MkJloExGLPZM55CcE9GmTKrKSxjBD/Zl7DrjDKpIm6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lusatl0B6/9/l9K94GHwCVXrt+OfcGnYtbUrscMawtyk5id2kWgxsvoEwq/PU021lwZc1uHAP+3MRQFQqRSmE/mqKj5pAsGOQuFT7pT4kCAvMYYI4m1no2pCK3TyJo+2MYg0wRcFjg/fF6n6aA8hO8yh89LtFqmnBEln3ZQAmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8rWrjeS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231a2d139bfso855ad.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747240321; x=1747845121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYLNDhzlqYvr4WBGNfCHvOBer6U7XjrDuvSh0xUcSFU=;
        b=W8rWrjeS0QTQE/YTEUeULRxN+/WWPyJKvYdQmtUc0Zd3O+HmEY3MJnhySIXRGhyyIR
         8TFSh1OsULzeiaDcB+qzV4C7/96PDwe2sCH82QSk+fuazg3srUZRhBZg1TZngWfCplt4
         hPJ5LVDqZDuRspPPXqELE869nRPsEJaG5MrIIYHCERvF2bSHZHJDmBL+NoQvavmaCrVf
         nJG+gwae5n5R36TabYvfogUfEnzPeyjvZ8BQV1Eh+OdOUcPxiCgKNVSh5L2/xwfZUYok
         YE8nIbIogoZwa3ISXhWYNzQo20EHhrqCl1GjcC5o/m04s8M9cPIz+c0x18hCXb51G9gm
         kOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240321; x=1747845121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYLNDhzlqYvr4WBGNfCHvOBer6U7XjrDuvSh0xUcSFU=;
        b=TwwafIHqymPel+IsIER5/XOQvQO5hwo8ZjZ27JOsFU5FaNDXoX4yKHbMKlkZUNARoV
         Wot0Hwnqim/kzdfwSjLlOlNu0yB66EGPEUyCDuOdtn7EIiI8WCe6dC9dSSQnR9MDLsge
         3QRZ+pwfv+ew+mhPsQq965ANujVvJBjwKtX5pXTHDiltdmQ0EKu5At5at5QXIJ/lO0Pg
         VzARjG4B28hFh1lYwbZExJ+vxHH211rkuUhbyoLnTMSzv8c7RBozvbhZQPjkqb+IxLF9
         Pk18b9095PhpZyQORYbWiK0j8yyqNQkt4zQpYZa/8+UEXivo5BqyG4IHKd6saUMeJlB+
         B7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVG0fLWrbgb+lfvequRASjMiYnRicRvQvmgpK56g6dnCWwCV1J/gx4hjD9f6t4oEa7VDJ7oMns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCP6ms6kkht3S2HjxnuOxelxr53+I0/7aloQ4f4+z5V1K1Os6l
	ADKScl+ngvMcTX8cx5p1tTEInEoPGYkfhHWzduTZQw5/y1NCM3eek6YOoFwHc4ursD9VaI/dUoW
	abEbYv555Yt8ccAJkf9LJwJVtraj+jj29L+6UJO6k
X-Gm-Gg: ASbGncvFrXcuDsOoiO6SI8iWXwRKFyNj4G17xk+9Y/nTjEXfxzPuI6vnv+rEvXJAq+/
	HUYo8mM8jrWj8f67B6ZZ35OjoJ6PWfY6gLb1uP/OP0CTa91bsEJOBP4B49LEr/V5lTFOIQa6lYE
	ocjK0t1Z+FAYqR3m81zl/vBIktK1xJtYWY4DIqQmIktw6GqACUhu8Czj0Sg/ah0otV
X-Google-Smtp-Source: AGHT+IFVgAadMVWjrAXQj5YD57JLze8MTV9iyqXUvgbZ3MNh2OFF0FMEcNVK1q9IjPOFPYVx6r70d3XWASsMgBHqDhQ=
X-Received: by 2002:a17:902:f708:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-23198fb5195mr3918585ad.0.1747240320505; Wed, 14 May 2025
 09:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513002631.3155191-1-skhawaja@google.com> <20250513170844.03ef5752@kernel.org>
In-Reply-To: <20250513170844.03ef5752@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 14 May 2025 09:31:49 -0700
X-Gm-Features: AX0GCFs6OIpFcOZ52lrYgPvy4eJfb2SKHtkAFezPPPFxnrlVRe1hHysT755IPo8
Message-ID: <CAAywjhRtK007cSQMMdmw9dYrzDohjFsr-b6r-gXhK_K-RahJLA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stop napi kthreads when THREADED napi is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	jdamato@fastly.com, mkarsten@uwaterloo.ca, weiwan@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 5:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 13 May 2025 00:26:31 +0000 Samiullah Khawaja wrote:
> > @@ -7463,6 +7482,15 @@ static int napi_thread_wait(struct napi_struct *=
napi)
> >                       return 0;
> >               }
> >
> > +             /* Since the SCHED_THREADED is not set so we do not own t=
his
> > +              * napi and it is safe to stop here if we are asked to. C=
hecking
> > +              * the SCHED_THREADED before stopping here makes sure tha=
t this
> > +              * napi was not schedule again while napi threaded was be=
ing
> > +              * disabled.
> > +              */
>
> Not sure if this works:
>
>           CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config=
)
>
>   ____napi_schedule()
>     if (test_bit(NAPI_STATE_THREADED))
>
>                                                          clear_bit(NAPI_S=
TATE_THREADED)
>                                                          kthread_stop(thr=
ead)
>
>                               if (test_bit(NAPI_STATE_SCHED_THREADED))
>                                    ..
>                               if (kthread_should_stop())
>                                    exit
>
>        set_bit(NAPI_STATE_SCHED_THREADED)
Thanks for pointing this out. I didn't consider this, I'll sort it out.
>        wake_up_process(thread);
>
>
>
> > +             if (kthread_should_stop())
> > +                     break;
> > +
> >               schedule();
> >               set_current_state(TASK_INTERRUPTIBLE);

