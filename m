Return-Path: <netdev+bounces-228644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C015BD09E2
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0072C3B9E3A
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0F19E7D1;
	Sun, 12 Oct 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/m2BuRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE430A48
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294108; cv=none; b=Cr4E1dmV/ewRJxyAIU6SkAeX5z7/rWHpz6jlRwxSz6sLljtsxuN1IJ77XzZblipMxIUzE4HWpjBB6JvhYmGAYUDBf0fiZIdlRnHTyO4nz+hXEH6rlPcQ/Ue1vP1MJj1+/AFqfN991fLChKWiv8rGyRA1JXOn/bqb8qdWhOtGHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294108; c=relaxed/simple;
	bh=tVXCJNSN4qXwm+AI0XQtCMX/FL5Db1se2HnfJQVKilI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkPMRa/ed+CTw+e7ZJBE7qMMYx5tt2+I+Di2ih7avMLdImMr7E6Oz5ww3te1MdsVknI4kAJ7TMyuoINwnBV7zrxC5O+tUta4hFpnYQZhI4I8VuHFxYN4pI1Pd9yme4ORhvu4LZ17XlOGtYktTdOtWJprfk9ukIT8MfYIp+jBLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/m2BuRN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-79a7d439efbso42205136d6.0
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760294103; x=1760898903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dP3hlk3FcZtZ8kT2leFI6IU2sbVpMYVzstpK7vWNDA=;
        b=z/m2BuRNy8uAhygdXLpZugxg8tz1tIAvVkd5Olbx4i1Ot4XtRXooiK1K+e3JNteDIo
         DYUZYGq2R4fWNpSqSEsICuhh2vWM2oItwekApKUSYocomF4otPUp/H5jeYuCdZAjfQfv
         8zOCnxV1IqrE/s68PNI62uZxqjHj478Y1R94Nh7XTSqbA4/zTvm7P4Klqddwzi04A1Rr
         l5Rqu7X/RjyaVp9HRpiKfB+S3BC353rp1PoxrUSYaoI2VfHVCV7pzGP7d+DKowCz0TcT
         YKucD/xxyYHE6c1RcfoMIsYn28Ijd/lOC7egYe0qW9tDmB9bi/GCHBIb1NHTnlKPk+1O
         2zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294103; x=1760898903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dP3hlk3FcZtZ8kT2leFI6IU2sbVpMYVzstpK7vWNDA=;
        b=DTcjrr1peOOdTQzLQUZqFryJiXzaEHFvHMAIiZUP2hwygw/4zKdWKfTJMElEJ2OQfc
         3YMp1nXBHHB5vMDF+bLZFYkWftEHBOzUGBi6RBBYaWQz58S0w9GeFN9uON5YKwUKLFZn
         szS8ODynZgGhABwOKpxXpJKuM/KQvuORbtR5V3y9JyE/iHsHzrCyv/GRtDD6iXgTVtql
         9Ak36KzI066mltC87m1I6KU9ckaMj+LysV04GpFPFK/qtRUn0gFbWN6crT7CgK5ebm9V
         i6w9UIb64nNDHcrTfyM4gSaLJToslVeW/s4Ut8jlGu2e9HsfNsrp/jNkcwl9gnADT9Xd
         cJSw==
X-Forwarded-Encrypted: i=1; AJvYcCVKjIY5TswcSWYkX5gIqG52z5Ai3mwS4/2UN0bnyfF8rlF5gDLmzqv3K0M6jVgDkF+Ya+FOUm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUoS3QH94VVEsAYVgfa1WXMhPgZo2+qNmV8rY3q7dBekuVUXf
	iPYQYpPnCGIldGdQ5bNQlRwjZy/PZ9iuI3jVIKzNBUlrtVc6rIdxMxQN/WCBPufgTm7P33akdQt
	xyB5LNZTeBuQZlUhAwiHmaVr0SO4eWx/9WFyKzmjK
X-Gm-Gg: ASbGncsskwKFArBrmns8bOVT7680GhnJUVCgw8G0LArHN0Kd6TS14RrRSHUxgQmRs5I
	ujW/wExrbwk0zQ1oqR65HKJ74MWlX+QojNv+BnAQLZkeEOVKTntiQ0q5pwzKTckK+67nmdDK5wX
	NhQiw1bjDrQHiK9lw24NFki63cCktLNrCmkj2NcH/2CjPij1NlQiVGkMzYRCVZGOdYXlBkCYT2p
	ZpSBbLdlTWnzDyXSwgosvc72tPfwbE=
X-Google-Smtp-Source: AGHT+IHx0U9DCU2xBJhw3vokN2ag/hlsdXcQe6HeTTDUNIErHolT1dw2VBzSRqmzOD7m614nc8flisq97sXkbPyR1Pw=
X-Received: by 2002:a05:622a:1f89:b0:4d9:6065:2783 with SMTP id
 d75a77b69052e-4e6eace6e52mr308317421cf.22.1760294103246; Sun, 12 Oct 2025
 11:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-3-edumazet@google.com>
 <CAM0EoM=4FyGjjXdT=3f8FE18o+b2=_TZEbaure63MrU96szzAQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=4FyGjjXdT=3f8FE18o+b2=_TZEbaure63MrU96szzAQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 12 Oct 2025 11:34:51 -0700
X-Gm-Features: AS18NWCvQEu5jSpANwRBTWtwKthVJMQFCYiCnrhjKMqfPDG9zafgdqhCv1af4HE
Message-ID: <CANn89iLfM=sg4L16Fqj2o9VO59n_sn1u9acYr4Fe5P4bHBqE5Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] net/sched: act_mirred: add loop detection
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 8:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Oct 6, 2025 at 3:31=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > We want to revert commit 0f022d32c3ec ("net/sched: Fix mirred deadlock
> > on device recursion") because it adds code in the fast path, even when
> > act_mirred is not used.
> >
> > Use an additional device pointers array in struct netdev_xmit
> > and implement loop detection in tcf_mirred_is_act_redirect().
>
> Patch series looks good!
> This has the potential of (later on) fixing issue that are currently
> broken after the TTL bits were taken away.
> Small suggestion, the commit message was a bit confusing to me. How about=
:
>
> Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device
> recursion") it adds code in the fast path, even when act_mirred is not
> used. We revert in the next patch.
>
> Prepare by adding an additional device pointers array in struct
> netdev_xmit and implement loop detection in
> tcf_mirred_is_act_redirect().
>
> Please give us time to run tests on this set!

SGTM, I will send when net-next reopens, with an amended changelog

    net/sched: act_mirred: add loop detection

     Commit 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursi=
on")
    added code in the fast path, even when act_mirred is not used.

    Prepare its revert by implementing loop detection in act_mirred.

    Adds an array of device pointers in struct netdev_xmit.

    tcf_mirred_is_act_redirect() can detect if the array
    already contains the target device.

