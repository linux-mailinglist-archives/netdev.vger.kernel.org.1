Return-Path: <netdev+bounces-152498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C489F44CA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303E6188CAF4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9D14E2DA;
	Tue, 17 Dec 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ctd/wGCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189D653
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419280; cv=none; b=kaVVkoPuqEnDAoEYFlS8qs/W2vU3kWS2n+MFzMNSHUO7f5etpYxaR+PUQDnZcYWTCyRNsu/YmepqYXKLRkZDirkQ9QNhtlC6Ke2ELgrQkiUFxiHWEV3v5myOv3Zg0ikXNhifCjHjMetLKJePF/VzaizNSIjwQRfIa/98DPqptkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419280; c=relaxed/simple;
	bh=x8DJIc4HZKyTjb1Jaf7mTjx2v1srTynTBBc2iTuHLUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guRVuwDJHvCZPOVBBXAXT/aexVouSJXAblagPJkxEgznxAMwoQMl1tenGILG/ynmnW3x6OjVJp1RucXupVtLoAVgEEY5TamO4UD2BHPrA+ynG50UlxUN7DUR8mYwJwFKpZD41AN6FQDa5jUJgf42ni9qR7Bq3hj31EuhNOoAa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ctd/wGCz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so669718066b.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 23:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734419277; x=1735024077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8DJIc4HZKyTjb1Jaf7mTjx2v1srTynTBBc2iTuHLUM=;
        b=Ctd/wGCzdsA3NRf4z2ExlNninbtaSyJKZfLzWr9At5zBhKTKyuQJvV2uPAXauOTR5q
         axb4ZqoYmGUXaGPCt/oHOe7oZcihs238bFxQcgZCslrnhFVpah8m9CFmv+BkIS509vnu
         Vgmm6JMVUQtPzLxkv9smUsergWyIkCQP+Xo7o80SjbtouZ/UzyWHfjX/l1oIpTgLQS1M
         CLulcaStYVkQ+lwhonnvckMD44XvviUz54XTR72yErxEajsPfgkiWt3fvjHXr4qijdRJ
         CT2YjDfpO8JY61DAeFd30W12bdkJEkwfswvTU0LpL3qqMZkKZ18nkYXNh+XdIiK2nhcx
         lmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734419277; x=1735024077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8DJIc4HZKyTjb1Jaf7mTjx2v1srTynTBBc2iTuHLUM=;
        b=s4umjPUgT7zKlIeJZ1lBeTl6ktV89lS/fpvFUyWgTrVDQ5Iw/jT89fke9LHMBPc1Vw
         p+NpIHhdlgMQsMEY1bpNVZ8CU7etTv6iz980M3+gzRYu/K7oPlPjZ7dfFnsQnEvCCi7q
         pRqy6OlVnCGjd4RPRLyEzlR0j/ckkyze3Xp3hOt8LGUkbM8zHLNOdNAYPg3snEFB56i6
         bGr6aI45QjpMtg8FKTmXa6JeeE9grgED3D2BIMnuqQuP2q5rDQpq/5IX3VxyVp/aZ73C
         q1LIwZNft6mW3XG8Zl5wiFWJwfxncq6pDSBg33EkgS5W2ckRvvp4NJhNt0MP6CcY69up
         PCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXGYy4+O8NfLLHD5Q+g0aElw1tS80FHRGGViLmnZsIyb3eMwDsIV41nFSuNtkoqTEjUHNBrFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zU6fugUByZEGzR9mi3X4TTrPLB36apfowZnFajJX7bHn54cX
	cdh1q/ow1NGikkzV5ex2i/2bfJ850v9ypZ/knJ4uBm1Buh+nx/c5RONQELcltrzFF6P03AWZbh8
	54cVDWGYcrg0WIkttRt8K5ezCJXPEM2x4kvP0
X-Gm-Gg: ASbGncuLO5RsIbDxEbrmaSfGOpNxnCRt14eoIihCjI5vbx0/9pywhe0fW0P0/zFJJjM
	nn62WoINsuN/IwxiGQq5ExVjtBf93GmYQsDm/NOsiLk4/GOERPKllmWB64Q2uUIrPRVKVNYLQ
X-Google-Smtp-Source: AGHT+IEEouVtHycl9+wFlFMhBNERaKEgp6X7BoBalfPdj7aCY1D0JMZ6nN6dWvLoCJrjNlfi681FXiQP0VInpulBh48=
X-Received: by 2002:a05:6402:40d4:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d63c405fbbmr39600399a12.28.1734419277294; Mon, 16 Dec 2024
 23:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217063124.3766605-1-yuyanghuang@google.com>
In-Reply-To: <20241217063124.3766605-1-yuyanghuang@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 08:07:46 +0100
Message-ID: <CANn89iJsO=FppY=qx6Mo5CUP6v5QgeR-c4StSGmCoQ3kcZ-bEg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: support dumping IPv4 multicast addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.

Hi Yuyang

Have you tested your patch with LOCKDEP enabled ?

CONFIG_PROVE_LOCKING=3Dy

I think this should splat, considering your use of for_each_pmc_rtnl()
in a section where rtnl is not held.

Please make sure to use RCU variant only in the dump operation.

