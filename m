Return-Path: <netdev+bounces-151188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2E9ED419
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0841888DE8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182871FF1DF;
	Wed, 11 Dec 2024 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YggdufoW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FD1FF1AC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939633; cv=none; b=V98Y11IyRdFTl0Mwi2T4fTkwah0iLKlBto2QJ9TXIfv1LmGOMi2PmIUKzk3H6TEbDF9K85txB92FXqJzoWRyW+g4GGRtHyhNaJlMvPkpqTYnD4dSPyCGBEpqz6VrIot7cgRXPp9nevCPZTYg7nBZ5uRzQ9YjXBFyY256oOCtTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939633; c=relaxed/simple;
	bh=C8j9naSGtmANXLxB6gTQA/l/WydQAfl5PDcPUGnaCfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqjJeBTE8CHA0gQRJNz8k0MsUWJFqXXg5aiJdRayF6XtJnYYi3E8J9ZOLjEZWFcX1HeDfGDS6ZFWYCsPbQLPLPf1phuNQf718y5eZViou4+b6vXHgRHRkE5T1GnWlsRtHp2+zzSPDwepb92P58RdXHrnCXfFc/O+4VmJGW7k6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YggdufoW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4674c22c4afso2991cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733939630; x=1734544430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A63aMunO9nsMaAYz7w2GO3I55GNNyAuGNNFIOi4q+as=;
        b=YggdufoWx3nmKDo849Xjgr088T+2j50F00EMTYmeju6l2giDErdLiXmCG61M2gmFyK
         PP3xawPmxYCzOxTYhKILZs77v2pM2K0H/aT1KPYF7BY2e/J8PmrY9EZxBiWEY0VQwQAJ
         5oLkQ8CJ40X2GxPYPtNFP3FYwuH8LDNmSoA4xBnop9gxNP+JUTdwPrhMnPEX+b49E+7c
         YtgmdxVMpntUSsh42nOvEhGeKvvAFtK/iusPlQS7+Bt8NeuCYVxAerhYQ2eC6PXPkApO
         IfDtOjo/kad1rxmGsgkDG3WLKaPxQ7ztzMk1NdYko4/4JejfF3pCQp6AHIOVaQUj+pkM
         171g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939630; x=1734544430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A63aMunO9nsMaAYz7w2GO3I55GNNyAuGNNFIOi4q+as=;
        b=BYLsmX5PJjasAYf/89A5kmI+QiMH2o6WNGasy6yPmNN7uD/ionr61yIOFDZxaNILmY
         Ajk8YBUtQZ94FKx0X6jhIvFqnUSAmWwX86lXbzVw5NnOsQUOxyt+ttylpAAmOd8fV1fr
         nig+7VycGGnxV1hPZYndzuC3JQQxLDrdDGSnK7DgcE8rvVadCpaxoBqyojNyaasaQb8x
         Ag47nGVuU225c/MxlrGEARh9vDvuepLbSAcy/9vUa3taii/HT1USwzH6NfwmGjNEJ57T
         98ly3k+qDdgzti7qld+JOf7V7HtwUc0VGyBJQve/Ins4HaN8ZRbS2w2G6etyXkw9S2HN
         uVtA==
X-Gm-Message-State: AOJu0YzIObv9ijs1p+jJyJBkRjznPJAB4bphUdEl3+30snS8erbFsbHp
	6ZaY39dn4RRlcEStr9Sy4m/Wmj4MPDQiEB7Kn0JZtY04halc0ku5zS//y6pwUYqxu6PwAhZjNny
	5aClfc4W5KhO2UzbtHfMbHDTqAFkWXNU0r2yW052SABhBhiL0zW3R
X-Gm-Gg: ASbGncu0aV+OAFDqQfXWUqJDGFVZQcuuphuQYz4kgCPhZWCUz5Kl6OoUUvU/T8bQO4o
	PgTkEC7syXRh66IL+Xbvf51wEn3sWHB7yoj0=
X-Google-Smtp-Source: AGHT+IGBmAiSVzIqqNUuw+Enc5v64pgEhWaYhT/F/17Ts5J82I57JPNQTfvnFZoXyG+FMm9QZemzOrYEl15oPcAFmio=
X-Received: by 2002:a05:622a:4acd:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-46795cc07a5mr547161cf.12.1733939628703; Wed, 11 Dec 2024
 09:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
 <20241209172308.1212819-6-almasrymina@google.com> <20241210195513.116337b9@kernel.org>
In-Reply-To: <20241210195513.116337b9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Dec 2024 09:53:36 -0800
Message-ID: <CAHS8izOHfWPGaAF0Ri6sN5SVbvD9k_u2-_WmHJHcwu4HDEXj-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: Document memory provider driver support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Dec 2024 17:23:08 +0000 Mina Almasry wrote:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Memory providers
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +Intro
> > +=3D=3D=3D=3D=3D
> > +
> > +Device memory TCP, and likely more upcoming features, are reliant in m=
emory
> > +provider support in the driver.
>
> Are "memory providers" something driver authors care about?
> I'd go with netmem naming in all driver facing APIs.
> Or perhaps say placing data into unreable buffers?
>

Sure, I can center the docs around netmem rather than 'memory providers'.

> > +Driver support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1. The driver must support page_pool. The driver must not do its own r=
ecycling
> > +   on top of page_pool.
>
> I like the rule, but is there a specific reason driver can't do its own
> recycling?
>

Drivers doing their own recycling is not currently supported, AFAICT.
Adding support for it in the future and maintaining it is doable, but
a headache. I also noticed with IDPF you're nacking drivers doing
their own recycling anyway, so I thought why not just declare all such
use cases as not supported to make the whole thing much simpler.
Drivers can deprecate their recycling while adding support for netmem
which brings them in line with what you're enforcing for new drivers
anyway.

The specific reason: currently drivers will get_page pp pages to hold
on to them to do their own recycling, right? We don't even have a
get_netmem equivalent. We could add one (and for the TX path, which is
coming along, I do add one), but even then, the pp needs to detect
elevated references on net_iovs to exclude them from pp recycling. The
mp also needs to understand/keep track of elevated refcounts and make
sure the page is returned to it when the elevated refcounts from the
driver are dropped.

--=20
Thanks,
Mina

