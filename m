Return-Path: <netdev+bounces-210851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2C8B151C9
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BD2170482
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60E22D9E3;
	Tue, 29 Jul 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KG6LmSSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769A221F02
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808487; cv=none; b=MhkspMQ1/pfbWHi11cNeKQ8FVP8xlYaTnnMqy6uSn3yXKp1SUPL+9Z/tRLv8y123r90Wui35CcYE4xJAslLECDGe09Bej58/xcqGXKMlcPQHc/UR/QYCZWtuJrR9WJ/LymsocULK2qOox4KZa4Nz7FVi5de0ikz2zpARdJwkmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808487; c=relaxed/simple;
	bh=uLae6rGolk8xBHVpk0k+TCgO/RkNYprItl9+NHm0eIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHI5QGH5D4+D/GIz4IlFqQSmVvYL/OEEw1QTEJkxjSy/Tw0qhqud1xZHqXAF9P9i05nABSHJjiYZFkc19n9aFLpBGwFdPCeI4SmAviQV3S2LWSspBoQj6Jgn30adPRh1xckkQFgcpvVACYAKJqrhSjKfGhlHddcVahz+fULWzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KG6LmSSD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240718d5920so8345ad.1
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753808483; x=1754413283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLae6rGolk8xBHVpk0k+TCgO/RkNYprItl9+NHm0eIk=;
        b=KG6LmSSDK+hyjnUs94SNNlRHnC3C9nxsijQy+ZHHQOa8scN8IdSMeh04YHwIGKLy/X
         WNl84sAa64cRHuD3AHk+C3e4Ysmvhs0/SfQnXasKoNav81aGPpM7kKYkOFPoS7eoRka8
         e+6kaJM3komxWXxdjrOlZYxPNw2W1ZGRAXF0e7pktkK4Jy49vBFWxSA+9GGAcvUYgJdt
         7p0RKs0L+1Mcsvnc7+uQbXKUZ346DK4Qh+Kh3NDRxzqSUEoOGdXi8U3fR+a3HGzlaFmL
         SYOLjVNXw7GR5dElTzge/E9Gqq29JCyN8lMjW7a1iTkaW5IHglK7pfRrxiISxCBZXkBg
         sGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753808483; x=1754413283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLae6rGolk8xBHVpk0k+TCgO/RkNYprItl9+NHm0eIk=;
        b=sZ69I4fDyASJHwVTPg0X3XgxbDoaml4FylKc32EmzPGbESIniox+vX8Eh9N1/sva56
         Zd+gj9YSl8kjDolA4OXaDxF6MyJPxyfZxtkJnOBj7tRpzpY9t+OOmtqp419Vuf02ly2I
         SiC1NarLm6vL9iIb27OEKs+yuhJkILm8XBcQoI8m+ns4ZzUgNsyYNlWQ7LUukpqEV1BW
         zMHZAQghaIfN9qfkePZri6TSSeeUqQetHsAe/YXdsZvoYC/66Ah24l07qaRgkrVFYx/8
         9a2dlJ7T3PhGmCaVukPWqyPATXFacXxRUqKMH7xNgeXJiQd1yBpa1EsGZikcDtTmr89C
         BUBg==
X-Forwarded-Encrypted: i=1; AJvYcCUBhWa9pJkSXkkYsCuhv3zHU7UnSquTbSrAO8e1ZcVQ9+G0+kdkeDJioqB4SvJKRRGwMdLYOZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMMnBSuF08azDdzJLjVk9XULHUG8L+2ttHMLByq+m7sK5ulOh
	nEbRo74HObHrDWIDi24xMgpkh7RvruQx1n2UYQHd27czAYKSmxmPIQqQPYB76TZc13Wh2UWyG2t
	ILkkI1lqGVANguG8FKb31tu6TpiEKf8CWx8ar+X4U
X-Gm-Gg: ASbGnctZgjD8pZB1lOYbcpj332KNHlTMN9NNSpMXB17Nr8xSKsKR34duZjG5FQCeULE
	SEyil7oS09/bkGsdtCuy1F8j8ew87C2eGXmuibIQuNwUXaU5yIEfEZNjEzvEve08D2GcB4Z/0+7
	CdtCfHvx4NYN//UqCEq4DdeBV9POM64u5Evb7AO9wB+Sn54D6yxVaEvqTdUDvxzMQPC8LAMvluh
	tWfZcWPrxhATFxBANl1KloWqr26fkgL4KT9xw==
X-Google-Smtp-Source: AGHT+IH/aIePrtO3DxKPZfMv5xT5hgN2m1/8dW+fivE+rpVDY5hycH/CbbQptXJfzcn/03b0x58bdoKkBVaXd0RCIyo=
X-Received: by 2002:a17:903:41c1:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-2406789c4c3mr4393805ad.8.1753808482526; Tue, 29 Jul 2025
 10:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <aIevvoYj7BcURD3F@mini-arch>
 <df74d6e8-41cc-4840-8aca-ad7e57d387ce@gmail.com> <aIfb1Zd3CSAM14nX@mini-arch>
 <0dbb74c0-fcd6-498f-8e1e-3a222985d443@gmail.com> <aIf0bXkt4bvA-0lC@mini-arch>
 <CAHS8izPLxAQn7vK1xy+T2e+rhYnp7uX9RimEojMqNVpihPw4Rg@mail.gmail.com> <aIj5nuJJy1FVqbjC@mini-arch>
In-Reply-To: <aIj5nuJJy1FVqbjC@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 29 Jul 2025 10:01:09 -0700
X-Gm-Features: Ac12FXy8tZ7XbjPhzDO9LU7INNX5RkKHJldwZGYBjM7YamieRaoD_r2_UGXNfKQ
Message-ID: <CAHS8izOh=ix30qQYDofSPG8byGDf1CDKKAdHU2WCovTMUe3oaw@mail.gmail.com>
Subject: Re: [RFC v1 00/22] Large rx buffer support for zcrx
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:41=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 07/28, Mina Almasry wrote:
> > On Mon, Jul 28, 2025 at 3:06=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 07/28, Pavel Begunkov wrote:
> > > > On 7/28/25 21:21, Stanislav Fomichev wrote:
> > > > > On 07/28, Pavel Begunkov wrote:
> > > > > > On 7/28/25 18:13, Stanislav Fomichev wrote:
> > > > ...>>> Supporting big buffers is the right direction, but I have th=
e same
> > > > > > > feedback:
> > > > > >
> > > > > > Let me actually check the feedback for the queue config RFC...
> > > > > >
> > > > > > it would be nice to fit a cohesive story for the devmem as well=
.
> > > > > >
> > > > > > Only the last patch is zcrx specific, the rest is agnostic,
> > > > > > devmem can absolutely reuse that. I don't think there are any
> > > > > > issues wiring up devmem?
> > > > >
> > > > > Right, but the patch number 2 exposes per-queue rx-buf-len which
> > > > > I'm not sure is the right fit for devmem, see below. If all you
> > > >
> > > > I guess you're talking about uapi setting it, because as an
> > > > internal per queue parameter IMHO it does make sense for devmem.
> > > >
> > > > > care is exposing it via io_uring, maybe don't expose it from netl=
ink for
> > > >
> > > > Sure, I can remove the set operation.
> > > >
> > > > > now? Although I'm not sure I understand why you're also passing
> > > > > this per-queue value via io_uring. Can you not inherit it from th=
e
> > > > > queue config?
> > > >
> > > > It's not a great option. It complicates user space with netlink.
> > > > And there are convenience configuration features in the future
> > > > that requires io_uring to parse memory first. E.g. instead of
> > > > user specifying a particular size, it can say "choose the largest
> > > > length under 32K that the backing memory allows".
> > >
> > > Don't you already need a bunch of netlink to setup rss and flow
> > > steering? And if we end up adding queue api, you'll have to call that
> > > one over netlink also.
> > >
> >
> > I'm thinking one thing that could work is extending bind-rx with an
> > optional rx-buf-len arg, which in the code translates into devmem
> > using the new net_mp_open_rxq variant which not only restarts the
> > queue but also sets the size. From there the implementation should be
> > fairly straightforward in devmem. devmem currently rejects any pp for
> > which pp.order !=3D 0. It would need to start accepting that and
> > forwarding the order to the gen_pool doing the allocations, etc.
>
> Right, that's the logical alternative, to put that rx-buf-len on the
> binding to control the size of the niovs. But then what do we do with
> the queue's rx-buf-len? bnxt patch in the series does
> page_pool_dev_alloc_frag(..., bp->rx_page_size). bp->rx_page_size comes
> from netlink. Does it need to be inherited from the pp in the devmem
> case somehow?

I need to review the series closely, but the only thing that makes
sense to me off the bat is that the rx-buf-len option sets the
rx-buf-len of the queue as if you called the queue-set API in a
separate call (and the unbind would reset the value to default).

--=20
Thanks,
Mina

