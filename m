Return-Path: <netdev+bounces-215151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F2FB2D436
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB151C22C65
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5D2C21C3;
	Wed, 20 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="X3nLlQvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A4253355
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672342; cv=none; b=C/EN/nk8tMWlz291MYLUhKswGCH6L1Sy7Pl7PWPsHSe0T/Muc+XexdfZ6YRx6qa+Honcc4tQCIPmD4ItUmz9ZZgQIrJgfu4kyBxA4OReCo9Ks7hrLJGj4fZRN9k/JNb6qjfci6YTA9T3US4E3wKDw3RqgAu6T6n8B3Ps7RVYKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672342; c=relaxed/simple;
	bh=LTulMa5DzzgXFRwCbA8eqiueWXac+4TukenysHIxSeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW53Q07eOVK/z0duNGj/jrxg5ZNsANRHoM7MuB6HND3tkES//XA1+P+ofNiiqGjYSwn4m9dzmlqKTrx2pVN6bx+Kq5Y/y0++nE7moP+0uwkCZgyy3IeQ6qxjDoRhZQYgGDMAcrQR5JMFbGcHuGAVaQRR6UQGAfZGPAEfQkjuvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=X3nLlQvF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e66dbaso4285185a91.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755672340; x=1756277140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GIOgGi2jTMp7v09lKAxmABqYcMeuVEyv+PG69CHHZo=;
        b=X3nLlQvFWqrnE3n5IvhTiNch4vbSPK45EYfXjZnDM30QJ+DQcRRufeZCoy8K7qfo88
         gTXW4JOjQxk8S6avbdqjG3m4MNn06dnRMR50/jWBqpBlvTHgk2jkjoAS3nlE9RIL+tCa
         UMEc/VEqsrs5Uw/P66ehvBFk8y26RkzCJkpcIJKNXNOBBPfzYIFVXFtbKdGAztcEGttU
         HrUydWykY7kIfVgVfcdAZbMNrpvFc8Qaq14k9xWlNqxrVW0TVCkLc5p/UKvScLrGg7SD
         m05IaCgz42QrVN9TxbOhMsI8Ka3eLAUHUP214QBX2fxasz6EtnyMPjKYhvENknFwMeXb
         1tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672340; x=1756277140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GIOgGi2jTMp7v09lKAxmABqYcMeuVEyv+PG69CHHZo=;
        b=B8LzMswcGpv+imtbNRSX7h034OUbUZOX7aoEgM5yTSkDHNNVKXxv92C16NHirqRRUz
         HJXnmk7qG0ATueBkBtm7SZzSeq0bGwfAw2SlWr9CFzjz0wnuwpSO2TEatajgj4GuQRuq
         tEgJRQlG0TCgycGKvQUrrSJCTrB4j+ZPftZoiXwgbZ9F1RIJBhn7YcQJcJcvYLA0z723
         +zjX7HppmwNcQv+qRq+/xyJQ4PXUkiqhw/936BVw9eqOoY5uY3twaTho1E7+RlVnxvUo
         ck8EzYII1dltKfZIvIp8mtyHDp2jvBgYKSDONpvYej8OdXV7NV1frF+OtNFwBGq2IWg8
         g8aw==
X-Forwarded-Encrypted: i=1; AJvYcCUWVHyqSj6xn1ROW1GzGcyvrpevmAtxSAQeBexdyNym7exeaO0eIJPI+yVXnTshy/QcgOc6lZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTmwEUiNMskOi+GhFBmKTZ+OmZ2fWTqcRg8Ajo/aIp0vY+Jod
	j/611oufMZgINgetke6BzHOE6zhHH9DqwdLOQZV2r7JbLY8AVdjbvDZz1cSGW5qtmLMke+p8wlt
	QvYOJ14K4IPvvhbt0YuaSSjex1rpZXv2p+Gd7ejp8
X-Gm-Gg: ASbGnctRq0/5yCCFyLkjLUdYBUKooSQXyBcMxmlr4/kqkdOctcrE00F49f8NN1lj4zf
	EOlsnkD7W9sdbpAi2Z4NI9bs9wDHBmHV70ka7wJ5ENxofBIE9P1dyMArd+ObMbYz/2fdogbLLxx
	eYuXJMKVeo0GbSWIBCb48twsPtO0DAoC8MZPqRkJyJHQWM8KH71HasDbdBkGh875Y0ozE3WGerS
	/M9/x/0gQEEbnKM
X-Google-Smtp-Source: AGHT+IEDERn0WICGs2a8Kah+93iHICYYCy1ydZIzCJ9Yr3/+Mq9XL1oBmswjXnt5iJUMbq0tBuuTmgt9TYnYSV9cy6k=
X-Received: by 2002:a17:90a:e70c:b0:312:e731:5a6b with SMTP id
 98e67ed59e1d1-324e147375bmr2009084a91.32.1755672339752; Tue, 19 Aug 2025
 23:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819033601.579821-1-will@willsroot.io> <871pp7k82y.fsf@toke.dk>
In-Reply-To: <871pp7k82y.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 Aug 2025 02:45:28 -0400
X-Gm-Features: Ac12FXxVXwHmUJSemVja_qARLGER9n0WQ12wwfJspc-KE09huXzM7bzq_H15PCA
Message-ID: <CAM0EoMk60U8VV_dqiuXsE+AWQHAoiFKSc4FfBgVSJs1sWp+B5w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net/sched: Make cake_enqueue return
 NET_XMIT_CN when past buffer_limit
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, dave.taht@gmail.com, 
	xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, 
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, cake@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:51=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> William Liu <will@willsroot.io> writes:
>
> > The following setup can trigger a WARNING in htb_activate due to
> > the condition: !cl->leaf.q->q.qlen
> >
> > tc qdisc del dev lo root
> > tc qdisc add dev lo root handle 1: htb default 1
> > tc class add dev lo parent 1: classid 1:1 \
> >        htb rate 64bit
> > tc qdisc add dev lo parent 1:1 handle f: \
> >        cake memlimit 1b
> > ping -I lo -f -c1 -s64 -W0.001 127.0.0.1
> >
> > This is because the low memlimit leads to a low buffer_limit, which
> > causes packet dropping. However, cake_enqueue still returns
> > NET_XMIT_SUCCESS, causing htb_enqueue to call htb_activate with an
> > empty child qdisc. We should return NET_XMIT_CN when packets are
> > dropped from the same tin and flow.
> >
> > I do not believe return value of NET_XMIT_CN is necessary for packet
> > drops in the case of ack filtering, as that is meant to optimize
> > performance, not to signal congestion.
> >
> > Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cak=
e) qdisc")
> > Signed-off-by: William Liu <will@willsroot.io>
> > Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
>

