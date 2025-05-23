Return-Path: <netdev+bounces-193121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D16AC2923
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CFF4A6AAA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F617298C37;
	Fri, 23 May 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roTzoKLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E41297A45
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023121; cv=none; b=ottwcNmXCAfEgno1t5QCXRE6BMN1OQdEI7R/AXFKKXWijVR2PLDgZuz8Xz5YMjrhR72K1kHztzTqrVWTwt0jWnLhXFIY37Q6wQ7wrHA7kS6Qf5M4yZDtmEeGVPqmfXhO4fXq2DeN/cPZ63fdZHdr3stUwsndXc7f2IMAlPJTvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023121; c=relaxed/simple;
	bh=yYUi1udmfUYcJ5YKVRKseXClYrhNKbYP3F+XpHNtIHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6ouLzgMDjXIDrTiXdDcx2CpFw0ZICUFHEbFaZkof6/LB2Q5FhaVQm9djAwqRoQ1qZiv1QTfiF5TbuHogfDXoYtS0bShPdDYG72xYEEZ55mSkjccmxTZmE9ROwtt1uOb+gp+5cL8IyLbzvAdk2TyE3V6+Ed9TBjNIjMUojDJ4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roTzoKLv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231ba6da557so18955ad.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748023119; x=1748627919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MyXWu6zLRMWPH6yHtJnpQrGvuPbRE3t03DXROyNghU=;
        b=roTzoKLv/gm1v6/kWWqvdHmTclgVlQ8sdIfGcvud2iKzJisAuFpgYguGRNoW+Rt7HO
         vGPxQudwoWpOlLxRCjqG3Xq/s7DzrMVTSkUq4LpGTxx6uRAKH6NTLzV/aK2R5NY9Lntm
         xD97LMueOW+TauoAYhqm+y7AbqeOraExpmFRgl3J6fnxLruzxonfBmshbaszpMbeqcQH
         Tv4y3Gq5/vqi6qwWTGfDiJqbmyVRy7oG5FqF+C4PyXedMZsUtBg9ghf0L/uwUl1P7RGF
         c8AR+196rw9aYb9aM9T/Pk0O+KvHMLbH9S6HyHhWXGBXeretaxIDmUU11r0EEbGsLDw6
         Pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023119; x=1748627919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MyXWu6zLRMWPH6yHtJnpQrGvuPbRE3t03DXROyNghU=;
        b=ZnHRFbOwLJ1wJMF2i2jdAnyTgqNXBWuS150G05/MZQFZa878rN1I2lLL4xSrX+8MN8
         vZviVZ6iUXzx6WZWzWlAgFDr7D6t3EjFggS4r2HMtpu5+4RioQXjjkuyvTUV8Z8uDqTe
         JggApJN47kGRZIsPZME3Pf1pGJknV147UQ2fA2B3sBfVWCjGtIUS/9qPkQb5JC2GF2S3
         8pJsg2zjrly8TjABgbQUVu7dsaIV6FP4HKKNasm3zm/pnmSCqw7j/M4USAbLxpKOKA8S
         A1tg8qnLvm62on6s7IVJ+z18lL7xYki4peCrK6AuXgcg6Q7Yu/dCQa1dQjXgJxXyV5EU
         MmFg==
X-Forwarded-Encrypted: i=1; AJvYcCVeXBKQPJX2VzKyvsTPgHeDapnr8KQnxmDzraNwRwTMZIkbKw2nsYLlaasvz51ZqV8KKYznuK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXVQvdUee6d3IB94oPD8Se+kqUt6FRbKyD0QkP/RcxK3LyRnm
	T452yInrXUUsjBujwxFGrhOSvIrreUD8k0Dakhw0iHnyn3AZU3RtSV2gGzzd9uKXLFlN/UWUITB
	+pRghEfPVrMSZHkmcUKtTbpEtjs5R6+5m74H5TU8j
X-Gm-Gg: ASbGnctmOj7juuX3LfymuNaj09oux3L0w41yV/rkrPgSii5s44yf+gOzX7v0/HRJaLd
	VuMsGIVl0ve2WzK263yw9F6yoKP7V/CC26boh0UNzGglD8pbvTmKTWhgoIdkbxfK6JfC6tPC3Zu
	bFfauTd5jmMVzLQd2OUTs5GX/s4i7wRiQZhxEFuLUM6zjLhRsYl0Q8YvVTAq8qKuk2MLBPUmRy8
	Q==
X-Google-Smtp-Source: AGHT+IEGY8dDXdk00hKfZkhUxriQXpiPPCR5IyFq/kqB79PhLQHBbOU2os91yMCjpc3IjFgm69TOwCQHLx4ADvLhU5w=
X-Received: by 2002:a17:903:2f85:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-233f345f871mr2976175ad.27.1748023118552; Fri, 23 May 2025
 10:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-9-git-send-email-tariqt@nvidia.com> <CAHS8izNeKdsys4VCEW5F1gDoK7dPJZ6fAew3700TwmH3=tT_ag@mail.gmail.com>
 <aC-5N9GuwbP73vV7@x130>
In-Reply-To: <aC-5N9GuwbP73vV7@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:58:23 -0700
X-Gm-Features: AX0GCFtIQeUuZYzja1a1q1Km_umu-mPBIVJSyoxOHOUHS4AXUOAmnwmC0suSjaI
Message-ID: <CAHS8izNgY3APhLZWjYwEWyq3g=JiCBWFUcnY4nrXpntnp8zKhw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 08/11] net/mlx5e: Convert over to netmem
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 4:54=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> w=
rote:
> >>  static inline void
> >>  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
> >> -                     struct page *page, dma_addr_t addr,
> >> +                     netmem_ref netmem, dma_addr_t addr,
> >>                       int offset_from, int dma_offset, u32 headlen)
> >>  {
> >> -       const void *from =3D page_address(page) + offset_from;
> >> +       const void *from =3D netmem_address(netmem) + offset_from;
> >
> >I think this needs a check that netmem_address !=3D NULL and safe error
> >handling in case it is? If the netmem is unreadable, netmem_address
> >will return NULL, and because you add offset_from to it, you can't
> >NULL check from as well.
> >
>
> Nope, this code path is not for GRO_HW, it is always safe to assume this =
is
> not iov_netmem.
>

OK, thanks for checking. It may be worth it to add
DEBUG_NET_WARN_ON_ONCE(netmem_address(netmem)); in these places where
you're assuming the netmem is readable and has a valid address. It
would be a very subtle bug later on if someone moves the code or
something and suddenly you have unreadable netmem being funnelled
through these code paths. But up to you.

--=20
Thanks,
Mina

