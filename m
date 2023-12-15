Return-Path: <netdev+bounces-57757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CF814089
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162821F2290E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B62111D;
	Fri, 15 Dec 2023 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcGC7B4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF326AA1
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so185935a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702610250; x=1703215050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1VYA4INXlt0SPJVint/eQbAfS3nDnZ+FqgJPWNksd0=;
        b=bcGC7B4tsQOmzXo5XaaO/ENBv3tN8u3jgpSFPo/SEBcmcIWYH9h1sn70TNwhhTujae
         gWbERQ2jJ9+w+xrvhijb5aEj5JOA55HR2PCYSH5I/OXcz6ujy7fTO1hXL0XmCsDe61PV
         fp4Zq2QjSYswWwM2X10WnXpH0XyGUKXKvC9O5eHLNST88KPfPPfEXjgeCvQKR1PTeO5o
         XL8TwnT5yYNaT8XK9kn9S7V0bNEjrAp2xm553kyLNsz/lSvk7dsuKoH+OLR7gElj2EWd
         1rve48+OuNsVi9rXcc/YLoJZVGS9qCdfexXC3LAfpGOjZT3dlmLbiY4Ndk00y5QpEVAX
         P/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610250; x=1703215050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1VYA4INXlt0SPJVint/eQbAfS3nDnZ+FqgJPWNksd0=;
        b=a7wt4K0B03a4OOZiSbNeYNxZ51zgFG+f0xFh0wd5JBAw9j30aiPhPcgCx8Cxb0psaM
         7pMMjlFgnKSJk3cr+rAFkwM3y2ergP702dHqL9VAHBxoDZvy9Fu54Y0eU3lhrGQhJLsn
         9lCA2Q14uQxSHm+LImT/XSMnGudSnfiyTwDUBEaBrG76wXx10TWbu5AaFJEzzLQdIl27
         wNvtT+EamExwYX2ee9Dnf9blN0ZapJiBXa5Snz7rmprvxSTcvagUWZH+j4HurieHZ8ts
         L2YWhvyS6zZU039r+yoRuGR3QE0GqnLJOrm7e0RlWYTZH3tpAvUZ6RSjGIYgxc0afat/
         8bwA==
X-Gm-Message-State: AOJu0Yyx8uKcS9T7WkHZz30x06/U8RBo5aO4vOcx9LPX7Y7+nUv6yBtg
	hh3olE0ieyHq767p32Uqzj85p5xNfzk4UV13xZw=
X-Google-Smtp-Source: AGHT+IFuupZvm6wScZAQVS4ZJZ4A1bcWzvX88fnEYdpNQNv+hlttWU51PqZaQGpH0wxW4qSpzc3KLhkRGGD8Vd5tews=
X-Received: by 2002:a50:8dc5:0:b0:54c:4837:7589 with SMTP id
 s5-20020a508dc5000000b0054c48377589mr5433540edh.53.1702610250203; Thu, 14 Dec
 2023 19:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214042833.21316-1-liangchen.linux@gmail.com>
 <20231214042833.21316-2-liangchen.linux@gmail.com> <20231214190808.54a258df@kernel.org>
In-Reply-To: <20231214190808.54a258df@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 15 Dec 2023 11:17:17 +0800
Message-ID: <CAKhg4tL3acRiGDfMh0gdVKjiDCLmvGYZ+fkHq4g-+MBjD9UgZg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multiple
 user references of a fragment
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com, Mina Almasry <almarsymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 14 Dec 2023 12:28:31 +0800 Liang Chen wrote:
> > Subject: [PATCH net-next v10 2/4] page_pool: halve BIAS_MAX for multipl=
e user references of a fragment
>
> You do have to re-generate / re-number the patches to 1/3, 2/3, 3/3,
> otherwise patchwork thinks that there's patch 1/4 missing and doesn't
> kick off automation :)
> --

Sure. Thanks for the reminder!

> pw-bot: cr

