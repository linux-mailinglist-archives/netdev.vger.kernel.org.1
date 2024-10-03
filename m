Return-Path: <netdev+bounces-131553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A3898ED50
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA521C2106D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AF14D2BD;
	Thu,  3 Oct 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2D/+aTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0213D8AC
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952567; cv=none; b=gdhqPixheH0UbAukDZr1aAnGGw8YFRAinSAyL1rjw+/QU5wwLyhBYM9F6f0zAePl40V18R9mYVUZUoNty/6OAsPPGGr1q/viVnjcE2TeH9rGW6fdmpjpbh8027hh8i+Ymo9w49lXCL2qcO1KqXtO9Jo46NuVudFH4Ghcp28nl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952567; c=relaxed/simple;
	bh=3B3JzNZAfi5oRa/gLf8WBI4lsvhGHx8kdwtFNE8PC2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raSHXg0X49On/otsAgK0YI0LEW5X4sJOdG9KNlsDhWRSIYTpYIFDeK/rgFu/eAe8b4yG3yQ8ZIDzg5NeNifogDVqwY4hFfqs8HJJrmMQHkKjsGMwDo5ocjjUAmvwV96XBopZiNDh22paNi1GNv2GHhbEpaHQ9vILClrWuOQZPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2D/+aTZ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so2885445ab.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727952565; x=1728557365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU5moT1hCLAni+ARltOokuJyMXP++EKDZHE+VG4ma0k=;
        b=D2D/+aTZm7mgREqZCNeXtgUjl8BOEX0wQOJb0gewaQIeVGKT8/zvYYpw0mtPOqKPy0
         XIiAdWKryRXUEfKhFKXH1+eVZEMT4dINoxkWKYsq0vj93ZzotCXyyclVp94T8JTxNfAT
         ZJ7QAA5rNknpFx7kB5rwm+zjyyFR02Z4qybTuKl+ZDhqs/lz3uOPtvBKoxNezodtDkSt
         2vQ100oXn2ZuygrjpXQs8dwe2s5pYB/bIHgx/Q2GEXAqncgH2iPwk7kzWlB0bKpk69sm
         8V5KR7dat60/WXQ4Sr6scETkf30xkPgzXR9B5mMo2Dj7+wD3LIY3tqigQiUwIhZDWwgH
         jokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952565; x=1728557365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU5moT1hCLAni+ARltOokuJyMXP++EKDZHE+VG4ma0k=;
        b=D4JPw6o40zpSoy7btOuNDQOOJZNSpq3NwNvgqbDN0OozKKex/iYEeaGYVjQp4n+4Pe
         1LXi/iECFrBu2aG6It0kpCIQ80g8MyfxgWM+SdCqzsqd6BLBA0IuIw3tIXwRT3TnPVHk
         cWTxgYjnqYUVUwkkmYG5SILG+sgHZjmc/cj1+juQsY9C2z8LJAG5ph3t0jMRVqNaqahr
         +QBINnLUC4mB4w1tU3ZbA3tqoqO1md1eJjyaUh82wimf2kVHNG1KAh/v7lAIinBG4KiX
         3GFboWi/kL+0OlL00Deu+fDr/g2WFlmTN1MKYSHpPkRc8fzeN1pdUG92sxZaP7vOPBms
         7oBA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/76O3QDMrYzVPf2pngYMhKTNZBZXj53Nn5iENAop76Jn6SQ70wsRGcYUQA7CLOLxFIigeC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTE3enFrKk5iaPGod1x2DTMe36E4Ci8hr6J+UqfyS33bIBwetp
	G9c0NsRFLOvHzECJYR3o+obFl80A+/hdb4MYxkQiYCSE1Cz71EDg5ADgAoEe4kk92WIdjKVe3kd
	sgpHd56LUlx/cBNSKyQ28EkoDuvY=
X-Google-Smtp-Source: AGHT+IEG3Ewg7tA8IzKmQzfznhq68WxqiK4jIBXrZLXH3CCm2qV5iq1JZulvEpPuS+cpmniCEotl1aZpRvmzf+njTF0=
X-Received: by 2002:a05:6e02:1543:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a3659445bcmr58255125ab.16.1727952564852; Thu, 03 Oct 2024
 03:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com> <20241002173042.917928-4-edumazet@google.com>
 <CAL+tcoDNTLoOc9yZsCGu-tt7SqgbJf=hdfkaW_isjR7Cntc5AA@mail.gmail.com> <CANn89i+8myPgn61bn7DBqcnK5kXX2XvPo2oc2TfzntPUkeqQ6w@mail.gmail.com>
In-Reply-To: <CANn89i+8myPgn61bn7DBqcnK5kXX2XvPo2oc2TfzntPUkeqQ6w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Oct 2024 19:48:48 +0900
Message-ID: <CAL+tcoC_H+w5ExeL-9jbmkNHLRYEhR=+H9sV+X7VpYOsvaxdOw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: add a fast path in tcp_delack_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Oct 3, 2024 at 1:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > Hello Eric,
> >
>         !READ_ONCE(tcp_sk(sk)->compressed_ack))
> >
> > I wonder what the use of single READ_ONCE() is here without a
> > WRITE_ONCE() pair? It cannot guarantee that the result of reading
> > compressed_ack is accurate. What if we use without this READ_ONCE()
> > here?
>
> Have you read the changelog and comments about this 'accuracy' thing ?

My initial question was about how only READ_ONCE works without adding
corresponding WRITE_ONCE here. Sorry that I didn't totally understand
it.

Sure, I did read them. But I did miss to understand one line "before
acquiring the socket spinlock reduces acquisition time and chances of
contention", which is perhaps the reason.

>
> If you do not use the READ_ONCE() here, only concern is KCSAN might
> trigger a splat.
>
> The WRITE_ONCE() for a single byte is not needed, no tearing is possible.

Yes, I got it. The writers of this field before this patch are all
protected under the socket lock.

Thanks for your explanation.

Thanks,
Jason

