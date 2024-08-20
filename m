Return-Path: <netdev+bounces-119950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB51E957A9E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD31F23617
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61188A94F;
	Tue, 20 Aug 2024 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Orgs93pA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17628BE0
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115272; cv=none; b=saBERbafVXdMY9PGtFnTz8ql2GdB7IpbgRTAWqxUYULmJz6rbvgnWpS7VhwZwn+asOLVKFXSyOTncfvzUFRNLp0aLSBDvQCYOy8WLZxi2rqsAe9pSprlAMjHljeVpylTKkMKxVM4VcLQQHIegN9u4uzVyBDh/L6PDwEYeebxHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115272; c=relaxed/simple;
	bh=u+5KZK5nAA6lm6uXAgzbelSqD/iPDXqg92adfN9usGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOOdPRG2+zadMc2bu2Myi3/++EHnU41KOA7W4W+L1lgNQxOOh232FicYlXXHC8sqgXcwHgcK+AZC0BkjgaAipWp7qtiYvip25oq0WxigLr4G9UIwJ01ue01qKU1JlS7P87IRUCSQgji4hcLpBh0NaS1M6Pp4/6vSPGHkYFy4Y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Orgs93pA; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d46ae7863so5843745ab.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724115269; x=1724720069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+5KZK5nAA6lm6uXAgzbelSqD/iPDXqg92adfN9usGg=;
        b=Orgs93pAbZAZEsoRJXhb1NL3rlsrZ03YPSJ9beLiSl1wGH48UE/9O063ZXk2uDhvjK
         zdxr5YmPmpgLJ4ga1kdV8roCouR37K0Em3ORl4Y4XwwlCM8HXzZYvbjPRy1qIjqY7vzx
         FLh5Qh3mLEWw76kLyDkH8WBkJQt0QE0uCNmHZV/XuwiuFR704J7ORrVtRb1TqDQb/Pwe
         MUuz6wMsKudZLlRofWR/xZV1dPt72zLEThnNxCW8XR8xIywePxm0/aRTM1I7VQuVR+F7
         YkBw+GMpi+PW3C8VIwj/v2w6RocjXucZkpGoUQa+n/GbP8Lrx1D75sZqRhh2nCoK0sKE
         PFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115269; x=1724720069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+5KZK5nAA6lm6uXAgzbelSqD/iPDXqg92adfN9usGg=;
        b=C9tNauhH7H9MOATXsVcn1TUfmgRxsRUGb55tP97pTzI5H2MViJF0tYz4h8LcsMGmCO
         2T3cZ9+2nOSZ/bZmAStOm6ws4JMfjf1FmqN9tPMEVL2TAU6enASeJokEguKzAo+l8hOs
         MiRJbmfwzILr1VT6u5nv+Cw5B6TAulx4Qzpdlyhb3o9OVkQblyR4ZyhJkOe7un1iJ6zk
         wlzYTsUzcaSl86jpuEg2T/fQDnyj2hcrfqKZLxrvFzMtWKgNQy5DZr+z35wZvTWqjxUe
         lsa8tc1TPssAdWL8jbFzyqOJRmI4oXH+yupEXDGooQQsZmtiNRucWlQ3+k/KJuJl1baz
         DYuA==
X-Forwarded-Encrypted: i=1; AJvYcCU6s0tsZOujRyV9H3bugBDvYRlKX+NwJzsLEbNAnFZL7VtBhmXqG9NcPww/gu3shwu4j/5RIBcDfYfqsCVclTfr6L+2TWvr
X-Gm-Message-State: AOJu0Yx0Vn2B3nUmPiGNJWJkSncN/hYSPBhYteFiBnA82lB1/n7MkGtm
	Yf0pNv9GMCEHYUedC+q16OLnnwoF59ppvs44sMYc+NwY3Gq+t41lCm2AnIvBnjK+KoPxThMHij9
	bgMcss81wb9saRa47QKyM5vAUQzc=
X-Google-Smtp-Source: AGHT+IHLWDfmiygFJk6fTZuBAGGazX8AO1dCbpejO74nj2Y0VR8PlRjm0NoRXfExteHeuTW6e0Il2dK3JPPakVvyXPk=
X-Received: by 2002:a05:6e02:1c0c:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39d56e42e4fmr17431355ab.11.1724115269381; Mon, 19 Aug 2024
 17:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816153204.93787-1-kerneljasonxing@gmail.com> <CANn89iJZ8RwFX-iy-2HkE=xD8gnsJ26BO5j=o0460yUt7HiYcA@mail.gmail.com>
In-Reply-To: <CANn89iJZ8RwFX-iy-2HkE=xD8gnsJ26BO5j=o0460yUt7HiYcA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 08:53:53 +0800
Message-ID: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Mon, Aug 19, 2024 at 11:45=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Aug 16, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This is a follow-up patch to an eariler commit 207184853dbd ("tcp/dccp:
> > change source port selection at connect() time").
> >
> > This patch extends the use of IP_LOCAL_PORT_RANGE option, so that we
> > don't need to iterate every two ports which means only favouring odd
> > number like the old days before 2016, which can be good for some
> > users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
> > connect().
>
> Except that bind() with a port reservation is not as common as a connect(=
).
> This is highly discouraged.
>
> See IP_BIND_ADDRESS_NO_PORT
>
> Can you provide a real use case ?
>
> I really feel like you are trying to push patches 'just because you can'.=
..
>
> 'The old days' before 2016 were not very nice, we had P0 all the time
> because of port exhaustion.
> Since 2016 and IP_BIND_ADDRESS_NO_PORT I no longer have war rooms stories=
.

As you mentioned last night, the issues happening in connect() are
relatively more than in bind().

To be more concise, I would like to state 3 points to see if they are valid=
:
(1) Extending the option for bind() is the last puzzle of using an
older algorithm for some users. Since we have one in connect(), how
about adding it in bind() to provide for the people favouring the
older algorithm.
(2) This patch will not hurt any users like in Google as an example
which prefers odd/even port selection, which is, I admit, indeed more
advanced.
(3) This patch does not come out of thin air, but from some users who I con=
tact.
?

In my opinion, using and adjusting to the new algorithm needs some
changes in applications. For some old applications, they still need
more time to keep pace with a more workable solution.

After considering it a whole night, I would like to push this tiny
feature into the upstream kernel, I wonder if you can help me review
it? Thanks in advance, Eric.

Thanks,
Jason

