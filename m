Return-Path: <netdev+bounces-150766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4839EB739
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744101653D9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243972309B9;
	Tue, 10 Dec 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCdpW0n9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA291AA7A3
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849759; cv=none; b=S4PQKAXui63y/Ec6xCuwZF1OsxtwYTqO+5OdhHBX2YBdm+tl02PM94V4/T4IDEskl4AIyOYcOGSoTCa/CVz4drVEV5u5Pkpd5kDFpWtRZgXkwla7VWbf8E3f8QUDQe5X2+gmuthmMOTy4D+0NRmD0dJgESOzaJzYR2VYyg7kBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849759; c=relaxed/simple;
	bh=/LxO6WPdDUxZ8Hgbs/2Wun67rLijCC4KxC688SOw/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDMeVvHnvAGergSkTflFA9nNuOQQTmavMIS5oNmR6ZkJF+IkZTU4xnNWuhZydaZQDbmupfsdUcJyArKAcT0LdBQVxAg/EbEf+JYk3cbnwNkyVTIQeHDgNQRQhVPWryR/yJ8G7eWiFV6xYZKqmGkl1prmmRCMOm1YZGPi9AvnZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCdpW0n9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4674c22c4afso314341cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733849756; x=1734454556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7tKKwXbpN1GVUNkR1kL9d2a06AChiLqalDl9Gjh9wY=;
        b=bCdpW0n9vVjAxr6pBDxPiP7Rujahlqk0UlGIR+0SOOJeD4/3Ppru/PrTXepERW5UjR
         qMBy4pqyc2C+9V/MAo4pt+ZlVPBv1HEZLWdkibpLImtP6U8LmD1qahjI9lJmsPEtdf3L
         7Qes0S9fKJdFatQp1VQW1CgDk3Px8VeXyEBoEwdv2bnFvfY1dfSAlM+NlhlHbKzd1+1p
         BDbLoLZY3JGtBx8QhLkCOasOVXkQKAK9aUPFXQEpf1iFQoeW0NqOYRk6vb9DPPUYgt8u
         MnimGIKCPCI+37uTq1muMRUXzSZbR6m1qub5tH+Z4C05Mtdref04XQ7bSWBou+hAvw7/
         ReSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849756; x=1734454556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7tKKwXbpN1GVUNkR1kL9d2a06AChiLqalDl9Gjh9wY=;
        b=kOhLhYpIMJqmXOzHI2moPJgNpEGmpOnd0K3MSASp1i+z3w/HSYBz60Njwjr/0yr0CH
         ynHdjsPiUcgJgsqZKtOJLzlNPatSI0i066GhaGqM9Vyos+jDazE6Fbdd847fpq4b++Y1
         ynbw5vEwsSGPG+xTynQwCWkvwiAMWESpISPBT5GnyWqo4LcR1S5JQiAqXt6ix1DzjQCv
         pN4SOGlBlQ4JfYodevVABuEnLg/8q8SpZKV0CYVywyy3nTIW3PNc1EMmsEKS0o4ssNf3
         mY6KiGarySyUWvfOjFAUvUvqUujVFtOTzzgD5apgIg5EggFg5ndM5OHURBWFUcv5C7c7
         TWFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIfliJ8RGGefa1nqVHrYoAJgLuuOyfWZFwq1/8B6N0H4Kkhoq05jtzkQmy/JdzFyjse8eMfDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi5XFU+0LE+cIGYplOjcWLTUBuDdl2lzK3P+WAY/kLj1mt5d9
	yHN+PCiUsxJFTnhv5qTgp1SPY1liycEUEvs5NHgFK4kbphQs06CK4OaauUIp+e4e6Kd4zATPpMd
	G4rSV1AlKA/nZJTphfad+3PNiBXPOlwXtXB6z
X-Gm-Gg: ASbGncvusabZ105qAOeAfql6ft+3YJUIcabB6AFxLQOdJaC5uywLLPqdQmcofG5a9+j
	erI71MKTjiOfREKUqR6iNwAGrp1XWU27DUu4=
X-Google-Smtp-Source: AGHT+IHlPKeiLD6rlP5LINUtZzJpapiZf38wS5NZhgH5AdGxy6cSCKvr6QshYKht0RWFh9n5cZ+ju+NxtKL7siLDKnQ=
X-Received: by 2002:a05:622a:1e08:b0:467:5fea:d4c4 with SMTP id
 d75a77b69052e-467776c91b4mr3272711cf.27.1733849756351; Tue, 10 Dec 2024
 08:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204172204.4180482-1-dw@davidwei.uk> <20241204172204.4180482-12-dw@davidwei.uk>
 <20241209200156.3aaa5e24@kernel.org>
In-Reply-To: <20241209200156.3aaa5e24@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 10 Dec 2024 08:55:44 -0800
Message-ID: <CAHS8izMSD5+cbidwRukv55wG2b1VsiCD176gvk6_CFy8_wiAsw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 11/17] io_uring/zcrx: implement zerocopy
 receive pp memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  4 Dec 2024 09:21:50 -0800 David Wei wrote:
> > Then, either the buffer is dropped and returns back to the page pool
> > into the ->freelist via io_pp_zc_release_netmem, in which case the page
> > pool will match hold_cnt for us with ->pages_state_release_cnt. Or more
> > likely the buffer will go through the network/protocol stacks and end u=
p
> > in the corresponding socket's receive queue. From there the user can ge=
t
> > it via an new io_uring request implemented in following patches. As
> > mentioned above, before giving a buffer to the user we bump the refcoun=
t
> > by IO_ZC_RX_UREF.
> >
> > Once the user is done with the buffer processing, it must return it bac=
k
> > via the refill queue, from where our ->alloc_netmems implementation can
> > grab it, check references, put IO_ZC_RX_UREF, and recycle the buffer if
> > there are no more users left. As we place such buffers right back into
> > the page pools fast cache and they didn't go through the normal pp
> > release path, they are still considered "allocated" and no pp hold_cnt
> > is required. For the same reason we dma sync buffers for the device
> > in io_zc_add_pp_cache().
>
> Can you say more about the IO_ZC_RX_UREF bias? net_iov is not the page
> struct, we can add more fields. In fact we have 8B of padding in it
> that can be allocated without growing the struct. So why play with
> biases? You can add a 32b atomic counter for how many refs have been
> handed out to the user.

Great idea IMO. I would prefer niov->pp_frag_ref to remain reserved
for pp refs used by dereferencing paths shared with pages and devmem
like napi_pp_put_page. Using an empty field in net_iov would alleviate
that concern.

I think I suggested something similar on v7, although maybe I
suggested putting it in an io_uring specific struct that hangs off the
net_iov to keep anything memory type specific outside of net_iov, but
a new field in net_iov is fine IMO.

--=20
Thanks,
Mina

