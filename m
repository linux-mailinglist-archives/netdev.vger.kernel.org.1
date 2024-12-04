Return-Path: <netdev+bounces-148946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D249E392A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF636166FAB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E91AF0C1;
	Wed,  4 Dec 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjB7oVFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D291AC892
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312786; cv=none; b=bK4hdWXVWlJy3DDEJjPOYDfci4tjmFr8JpdAjRL91B8cu/CjGEhu1g2ijwPImZRMMKsB9oWFnp2ljFdUQhPQd+JDbuVW2T+JwcseAZfMb74TrU3Wkjq3FukGwhYD3t86Q7Gg92StzkoOb6d1nL9PzezcE9mUbDJc1PJPasRPYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312786; c=relaxed/simple;
	bh=tLzuj7jI0In6lkLDKCs8PLeJG/36uTxGBTe59rUT1tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sal2ecboYM3ZRdLwvvaOx7brR3Hv/7bX1n+RJYZ4tUL5Kbu7GQLHHVfo3LhS9kafDp7UY7hW6CLGq0vL0dMdhJ8kcq/PTo6IIYhe4k0utOCUFYxviWWHW786qxFqNT0lElq2fj6pV54/n92XSby0lI9OMCFgLJejbw3XuOqlpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjB7oVFn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so95599041fa.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733312783; x=1733917583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLzuj7jI0In6lkLDKCs8PLeJG/36uTxGBTe59rUT1tM=;
        b=XjB7oVFnXGYlDgqx6d4yyb2utVV4Y6sSdU9i1tl4RwgxmEePf4nPsSLhfnfYVrAa9K
         clwJhfCzp8+RCEukvHaX2sXdIp6+WcZ/v3XogtATJmg8UIwOGxMKuN49j5y9/7FD6YQo
         uClyUUTQ5ZJV/LEnf3h+JpuF+F4o53pdH5A5h/sotcbQzQcTcRekAbeipY7rXvF3wgX+
         sKpMQ0Z47xdFliND481z8qmD/+dA76OUNsLUWYzZgNd5E8k+KnaHrOPnGbCF10g21636
         3eDY+5xgFhPy48enwbgV1d6lFZY19QD7yEwhToXrajmL0IIl4MJPhHhGjhWW+yT8j71A
         iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733312783; x=1733917583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLzuj7jI0In6lkLDKCs8PLeJG/36uTxGBTe59rUT1tM=;
        b=quR5EiUikgP4RrQZrXLzeOJl8LEJPuVdDVcACWGvo6gATH+Yn1vSBV3bIhXy5G1UcE
         G2SpmNFYV+TsJo17vCj7ks9J+NlmlEF6cKoH/a4+6CIzf/Ap0vOSROoCCTS2fDsnlEnC
         ZulM+MQctiI9qnx1ikij7v2wtAeD/ZoACvfD9VW153CdCFkLvHPPIzHB2LtH8P7MHcrL
         +8/2reofaUnUlIopBbf7pjBisYJ93OQvjuSKsm2JduQ1dRNF8VRH9T8IbzLRp1NmZnti
         CN5mdwDoygkOZ925etowOqMWeLpdtm9eG5/FrJ2KCaQItDgscbSVK4eXhRyVT3vfCI/m
         ttQg==
X-Forwarded-Encrypted: i=1; AJvYcCUMioyIa8j2t7JdaFZsQX8+2fV0++EuatpDM3lzlbaS4ezNbQaSDF2a6bVxe1HNkjDo8/vMPPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0B77djrhtHe6Uz0PiHv9iVz4s1reYHwV1L0nrZ2JbU5xodr44
	YFASPPTS3rXGK0jaIwwOaSTFKJFpxtQm+/5yTXSOhVnMXxs2HT1muIN3f/YIMEHsDONvN2P8wDV
	6cVy+qfdrpIcVuZS3Sl3QqJelyf6aZEBZ7d6n
X-Gm-Gg: ASbGncs8WjCGg09DifxKiYSDGQAWKQaNCKIvVzXpsVK0mCRo1MCOwhR1CEcAlL6aZRd
	yywRadf+5Ddi1/LmYzx52DVJEJxBMKxaK
X-Google-Smtp-Source: AGHT+IGsROMlnEvaRPRfh9bYY21kAbwsNpu+ZR78zK1fxbhvKexY5nhSovqhk7yS+IZKve/TlJdig8MDDhYhBnTXjIM=
X-Received: by 2002:a05:651c:546:b0:2ff:d36a:2b31 with SMTP id
 38308e7fff4ca-30009c4649cmr53725771fa.6.1733312782913; Wed, 04 Dec 2024
 03:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203170933.2449307-1-edumazet@google.com> <20241203173718.owpsc6h2kmhdvhy4@skbuf>
 <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com> <20241204114121.hzqtiscwfdyvicym@skbuf>
In-Reply-To: <20241204114121.hzqtiscwfdyvicym@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 12:46:11 +0100
Message-ID: <CANn89i+hjGLeGd-wFi+CS=HkrvcHtTso74qJVFLk44cVqid92g@mail.gmail.com>
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 12:41=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> I meant: linkwatch runs periodically, via linkwatch_event(). Isn't there
> a chance that linkwatch_event() can run once, immediately after
> __rtnl_unlock() in netdev_run_todo(), while the netdev is in the
> NETREG_UNREGISTERING state? Won't that create problems for __dev_get_by_i=
ndex()
> too? I guess it depends on when the netns is torn down, which I couldn't =
find.

I think lweventlist_lock and dev->link_watch_list are supposed to
synchronize things.

linkwatch_sync_dev() only calls linkwatch_do_dev() if the device was
atomically unlinked from lweventlist

