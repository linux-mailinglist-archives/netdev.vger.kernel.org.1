Return-Path: <netdev+bounces-130914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5498C07B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557B5285A2F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF561C9B68;
	Tue,  1 Oct 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d57OeVdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719E1C8FA5;
	Tue,  1 Oct 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793586; cv=none; b=DelInQ7s4X+KkpBVtOAORFA/ccQfuNlLacLWALORjfgoOe/j3yl+JPx0Sj1oKZGdM75ppqty5SBXrABCPHA6pH+S3flJSfAHXvDfjh/dm5i5ES9GjpFnbA5An5cvowEGyLJO/IAIwhwWW7+dPT67KlZMrud92BA9DXkvPK8TnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793586; c=relaxed/simple;
	bh=aZqwMZteR7QMz/wRPTbetbq34SO0/mVD6KSQT2WEIfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksusBcgTdfUgbEbc9ydUrJtB7nDa0EKEDKYpRVLYXgC21vTjOAGkmaY9urSxqkmb5Z87BiP5TefkxJaBMk90xRdpE4AXtB2EUISII+TWhLOKufPrn+vrQkvrEE209VZUTOGHJWbOphC4z2M0otr2JFhPzAbPSFn+sfTzJGYQiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d57OeVdQ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25cb262769so4963105276.0;
        Tue, 01 Oct 2024 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727793583; x=1728398383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBuDDJjMTwNoZ/uUYb6Kuh5UQKPFlv1w+SWIV9bVSRs=;
        b=d57OeVdQ1V9nDZFN/N1RomVzR3tVP+GVe7JNnMdPx6pz1vVgUyKd/hCbX0sfFR/j7R
         aUE7mhug3/282BXW8P8gW/GYcGPUShMJ55SfiMMB7GC9RU2vyT4K68freEoaoaakGq8Z
         vvviNJbv45SL0kY9YjYQrKKXv64wVyZbLa32xkBS8jaUS7L9ZeFfNyizNzsP1JCmR7rt
         2FYftmqiteVp+qHaBMwbnXTaUqEfPOnajXzLPjnccPRAuqOyy4WBNdzDzM0gAvskbAe7
         0qqLSsA9LKc4iVE8TLKso5dqcQQ37qaRNVRQGP+s8OLB6KgNoVCYwerSrO4Ft5Zae3AT
         oBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793583; x=1728398383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBuDDJjMTwNoZ/uUYb6Kuh5UQKPFlv1w+SWIV9bVSRs=;
        b=vLR2ny0cNYZdv25GgVMe6+8VyolTPba+qm3vPn2Vb+9dnuOp6VL1LyIMZU0ItSiXKK
         UfEvYXMuJt1RHlYeDYbjbBDvoG0dSwf04+Ppu1sv9Z6iZxT0FvCr+x9Rab7Crl1c5TBi
         YOmMPoiTgev8QwBfkxiQ3ZY4iNBhoEnoN4r/P5ePIgxjZWROrdqzmKIdlWUVoJQnJsKt
         1a0mk8PitLxbB8dfbxSxDwXJt9q10oXCwTW5RO0FpKOntLv6rrFx9pKWOCQWh6b9kzf9
         mPVsCHyF8dJLSHryfZL+EMicPUPhn2wqGZZY/eIFY3ZBzW44HQ+oS256j5GMZxuVLNsG
         4zuw==
X-Forwarded-Encrypted: i=1; AJvYcCU+k2COZOubrSrTFJsRIu5389ZIf2Ne0+G943a2i1bRjGOm2NHLKbHssDiTlflnZyQ4Pu/ftUvE@vger.kernel.org, AJvYcCVayALC4OG1sVpboxMaojqd68jTKLjYnag5DTWXXW2McLeFni8whLtl4saD/G/pg1m5lmMX7ogjKrWffCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn298BmYYuORoMkwx3Oc4DbNhzEJaaLUH05VpTGrMXySYdQOsD
	ctDIfkdmfpJXQs8yoDkkel5fjqWhYRsIGkQhnAa2ZFlIzgJEZYz7GxDVMQJW9BTIDToxWTXGRgR
	6uaW8/cAMqAB9WrOlkkv/PVXGraI=
X-Google-Smtp-Source: AGHT+IFadEIYV6WtVdOpKuszn9tjbmA+IBXrI6axwjkgwDl1cvy6Olk0OP1vlr4ZhS7TSYBrZ7zo7qoDZpicTLzdUvw=
X-Received: by 2002:a05:6902:983:b0:e22:60b0:7a73 with SMTP id
 3f1490d57ef6-e2604b75ba1mr11733299276.44.1727793583644; Tue, 01 Oct 2024
 07:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
 <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com>
 <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com> <CANn89iLC5SgSgCEJfu7npgK22h+U3zOJzAd1kv0drEOmF24a3A@mail.gmail.com>
 <68ee33a7-c60e-48b9-b362-c991bdcf675f@nokia.com>
In-Reply-To: <68ee33a7-c60e-48b9-b362-c991bdcf675f@nokia.com>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Tue, 1 Oct 2024 16:39:32 +0200
Message-ID: <CAHTyZGzSzNXALjdRSK-a=29vRn=rNgKY3VD0pyhsa1pY5M4-KA@mail.gmail.com>
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 1 oct. 2024 =C3=A0 16:36, Stefan Wiehler <stefan.wiehler@nokia.com>=
 a =C3=A9crit :
>
> > This could be a lockdep annotation error then, at least for
> > RT6_TABLE_DFLT, oh well.
>
> As you have already explained, we can ignore the ip6mr_vif_seq_start() er=
ror
> path, so the issue boils down to ip6mr_get_table() being called without
> entering a RCU read-side critical section from these 4 functions:
> ipmr_vif_seq_start(), ip6mr_ioctl(), ip6mr_compat_ioctl() and
> ip6mr_get_route(). It is my understanding that in none of these four case=
s the
> RTNL lock is held either; at least according to the RCU-lockdep splat we
> clearly see that this is not the case in ip6mr_ioctl()  =E2=80=93 but ple=
ase correct me
> if I'm wrong.
>
> > Note that net/ipv4/ipmr.c would have a similar issue.
>
> Yes, looks indeed like that :-/
>
> > Please split your patch in small units, their Fixes: tags are likely
> > different, and if some code breaks something,
> > fixing the issue will be easier.
> >
> > The changelog seemed to only address the first ip6mr_vif_seq_start() pa=
rt.
>
> If you prefer that I can split the change into 4 commits addressing each =
of the
> 4 functions mentioned before.

Yes please. Extending rcu_read_lock() sections needs inspection,
because we can not sleep there.

