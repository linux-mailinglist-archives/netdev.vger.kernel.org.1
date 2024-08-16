Return-Path: <netdev+bounces-119084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC85953FDA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682B31C220EB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA413EA64;
	Fri, 16 Aug 2024 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXnO2Jtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B82C1BA
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777018; cv=none; b=LSuWvp++i7cr07U/CoREvxOFynzD3+/r2RFaqTpRqUQnE0jU07nvyhW+cSYEagt8T+tLe5BBLbzKNu/WOphGmfE+SgbRU0Gf5senq0/xk/32rVp1QqXuMUtiZ/zpCfQmJkhjEuz8u7qT5H7SGj+bxWi3PwrBi+h6WCooXMnpGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777018; c=relaxed/simple;
	bh=FD82T5tQ151GCxbgwydPgLXNhOZ7ocA86R5kZSVrrwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9R7FL3xmJXyXM3TLg3g7jrLnKRq3Y9MpTW0vJJ+bqq0DubpoI9OQoUEmjWqP62+a42fviRrqgimDdqc0s9OM2B9KD3CLMy5QmWCfMXKEhrXf7sBDfw/2p0TzqrahKOy9otSkjJ3bkLkrE/ySDaCx7yYj1c6UIW651RuwYZX/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXnO2Jtm; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-81f9339e534so59172239f.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723777016; x=1724381816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OlAAD0IdvertvNPCQITbNP7E/1Bvc5tt4g9y5C9gKE=;
        b=EXnO2JtmN8T3EOF+Gi3MppAI5611EeSX9O84T06NgG/+ZU/8nfObKLNpl32ebMTQu3
         ZFqOWkZFeaRN5fvBKXNzKxwE/8mFqvozILy3s1jJsIF5CBSvx8Cato+iElzqsTFd6SXN
         zGaR6j9dTqKnnzAJkpVPLhhhKzj0W083LZPSF0wWbH8JxoEuor/IQ0XKb2FURm7pvNJr
         +5wKAlAiFnn4qosXG0U25w/Ny+FJaRh7w+5RnYD/2C6RlP+DjsjomKzCvdDK2Legts0f
         xWpV9E9Qc3VdSPSI9OUZ2y1n76ppgD/yo9pyrIQ2BgnDdKDyhffvUgYPRH7LyMbTWvdw
         0Zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723777016; x=1724381816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OlAAD0IdvertvNPCQITbNP7E/1Bvc5tt4g9y5C9gKE=;
        b=qrgF9DqfQaW25H1pSsW1UsFV9cHitnmB7OUUnFuxWMPz/59fXU2nq4kpBerwSnTogf
         s2TH0L/sEKryzlY1gMEsx5c7IZ5Lnxdvekfllx+Uj/CNsaq+vEBxaHU+/C0XaIgYT5+h
         FGk7DVvHIyBAJ/brfYohaGijShLOXq9os1zHwj4MObqqQ36amEwVIGLeQGMOysaQngP7
         bC/n70Gu/TEHt4fyRvWsSrvGTJhSAR2erNHoNLPqExcv0fkVbvxXfTocx33gnGEDQL0z
         xP/Ta+dTw5I/UgMOSwG3BhOgeiaIk0xmRJpylwqJJFx47UtAuLrs46bHx9rWPKiE6mDQ
         qGUw==
X-Forwarded-Encrypted: i=1; AJvYcCVqv/xDg2HfFWoaa7E2GVG3mcFtxNPPNYScObuPWzIDRaW0nXT09bwyJynLJd0ju9/9oBzyTZA2kMRZCewhD7TPSChjHhKG
X-Gm-Message-State: AOJu0YzvajDBG729yyuz2t31SNCjFpJBm4+H5pC0QI7LN9DCDCIrywBl
	a9mfNGst32zxUkyzBUDOp7mPRagEdZqsOrSadtztZArKDx9VtKdXycpGYwOkqzun0+sODsF7q5X
	83NfhMgHf6KZ13tJtzrM53o8nc6M=
X-Google-Smtp-Source: AGHT+IGHLURz0UFe+RFJH/6i3ib3Vnl95nO34sYD7b3vu6TwE4w7jmW0m5I3svZE9ZA5qW62W2Mo/GIc2D8ZwfAvuy0=
X-Received: by 2002:a05:6e02:1c04:b0:39b:c08:3d22 with SMTP id
 e9e14a558f8ab-39d26cf8c35mr24272835ab.15.1723777016133; Thu, 15 Aug 2024
 19:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815220437.69511-1-kuniyu@amazon.com>
In-Reply-To: <20240815220437.69511-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 Aug 2024 10:56:19 +0800
Message-ID: <CAL+tcoCc7Nm7KgaJxYr4arRxnB+62WrTSoSD79i5X-mkHBiO6g@mail.gmail.com>
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tom Herbert <tom@herbertland.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

On Fri, Aug 16, 2024 at 6:05=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported UAF in kcm_release(). [0]
>
> The scenario is
>
>   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
>
>   2. Thread A resumes building skb from kcm->seq_skb but is blocked
>      by sk_stream_wait_memory()
>
>   3. Thread B calls sendmsg() concurrently, finishes building kcm->seq_sk=
b
>      and puts the skb to the write queue
>
>   4. Thread A faces an error and finally frees skb that is already in the
>      write queue
>
>   5. kcm_release() does double-free the skb in the write queue
>
> When a thread is building a MSG_MORE skb, another thread must not touch i=
t.

Thanks for the analysis.

Since the empty skb (without payload) could cause such race and
double-free issue, I wonder if we can clear the empty skb before
waiting for memory, like what already implemented in
tcp_recvmsg_locked():

commit 72bf4f1767f0386970dc04726dc5bc2e3991dc19
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Oct 19 11:24:57 2023 +0000

    net: do not leave an empty skb in write queue

    Under memory stress conditions, tcp_sendmsg_locked()
    might call sk_stream_wait_memory(), thus releasing the socket lock.

    If a fresh skb has been allocated prior to this,
    we should not leave it in the write queue otherwise
    tcp_write_xmit() could panic.

I'm not pretty sure if I understand correctly.

Thanks,
Jason

