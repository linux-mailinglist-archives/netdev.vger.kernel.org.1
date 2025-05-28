Return-Path: <netdev+bounces-193846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7FAC6022
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F1D4A1537
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A61E573F;
	Wed, 28 May 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGgd2hZK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843431C7009
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403191; cv=none; b=Bh7SxZJXn+wpFmL4B/f2XNmGPCssjECvJf5+YzdNFiFySbdci0z4IGwLypK60vQPWAKeJhyVpH3d+cvKofZQ+tV8zhzy2YPU0D/+fExgZ6CO3PnRt8pGywS0iltvTBjSegi4ieCNp3Flan/bjGg08DuPkLXzQNU38HJccbJfw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403191; c=relaxed/simple;
	bh=4/HY1VdWL+M1HZdhEbLRc98xqnHDG1nzeo/Mnk034c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE44FovqZ4jkurepzNDFbtTQm/OoZlREjuWBlE+zMuASViwqC3VR274eVf251Jqrcj75YLFcepD4lG+FDMYY2RUeyv/ijqLqlcVlAX9egQSZwGSGcl4E/ENkos94Yk8XOsZpQK4kG1n5wERNnHHgSSdYfeJuasHwBpTvgqRW6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGgd2hZK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231ba6da557so83005ad.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748403189; x=1749007989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NvDGJ09/tu5lx6cy96XQEBcqTxbssUzneuCXvKiQ7w=;
        b=bGgd2hZK+mbqmMG1DxUvm5OUei+trsCojaOYx1FohQe+8kegpLYO/BoNUp7V9HYhsb
         IvRvjM7UGmWfarcs0WytcMj0ulQV43nvUKBW0fOrvtKzEZjw8k9pBRA/j8/tsQwX9lU9
         GoBg135/71C+tyg3fQq8BE9/V1UwnGWZqW0b2N/F9+NjQPYx0hz6mCf6P9GmLkUgXlAw
         5Y+vhCbIdm+wK3S4AcvnjqUGYf6dtRkLVETY4iEQ+QOoMcV+FWQ860+9opfRfTXVnC2V
         yrq3JH1IVn/a5HKs5qDPdcu2yU/4d4KdXUmHtIGoW+gd86IOlJmARc5IpHJVRA1BBssg
         eQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403189; x=1749007989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NvDGJ09/tu5lx6cy96XQEBcqTxbssUzneuCXvKiQ7w=;
        b=nEc386XgbcWcq1DccN+S+AKApB5rivZ75IHqBeDLtownho8sYk4IkfJFbb14GI15VP
         hLb/ZSnI5y1sLvNeSBq3eMoZmSW8uJ6Rm8c/dQokdyQWrVXCxjmIVE/SW3mvCCRh4/+T
         6zLoroHCF32tcu+HeB/j+psrtdHRsoOkB3EQ5FqDvkND6Cw7VTb7IvAJFbVt0ordZY8+
         vNlQ8W1E6iCwNqt9dDwcYceqbQEy2QpjbGeh2y6WNfF2uFMpV/G2I6rTMtHpi9NkRIIb
         yZCA7+9xGkhAjw5oOwAk9vM+7a6Ljq3Q1fo+GGYiBesGjwIp5cD83tG8OEcwlt7XVUDy
         5Zng==
X-Forwarded-Encrypted: i=1; AJvYcCUM7N2X3B4ysxyY1px/HcAT249khjBIumcznvW0Pi+GQjf5iELgyUxkpWnc528zicmC1LXKqaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQUdLVtc1KCd9EM570T0+e4QxThqVr1nRrV6V4ud2Mt+P2FXl
	sRROKo06bNstAI1ErNYRbRhkkS22QLdC1VT2VwzMHN4ZLuu8gy9mL1KyPb74E9WAJt67KtL2C/y
	8hMDYIGjBZ5wQIr2TxVsRcc7Iyv68DL11IcsRCHnp
X-Gm-Gg: ASbGncsZjsFiuE2N76XzmbX5MPBoWeTdRGPuAzMZFGk2BJpgwyIxp9baV148PNC8CpN
	RK8/97o9141361R/+4Q8NNsncfqA6Fd96xCvtvGd0HQelou/PpjfEedk0XJ2XkZ2e/A9qbLKv5h
	W/3Q7X549gf7W0I0cdkq0wUOqW2cHMO8b6TasEIwfwFAEY
X-Google-Smtp-Source: AGHT+IGOF0NG3MQmraD43lvm7RYkw+L1ZNMtg/526GYJO8l+kiYo1BH3IU9UVbT9cidKiq8Ig68hPh33Ie4D7QG4Asc=
X-Received: by 2002:a17:903:24d:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-234c5222e3cmr1866435ad.6.1748403188460; Tue, 27 May 2025
 20:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-17-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-17-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:32:55 -0700
X-Gm-Features: AX0GCFuJLqKeYzCNk8mzICLO0VU5BcZ2poUiBYEj8luKwtcPAu1yEtAEKuGm8qQ
Message-ID: <CAHS8izM-hfueYox9Eqti4OsoCafh=pDL2v-6BEJRyt4ay580hQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] mt76: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in mt76 code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

This patch looks fine to me... but this is converting 1 driver to
netmem. There are hundreds of other drivers in the tree. Are we
converting all of them to netmem...?

The motivating reason for existing drivers to use netmem is because
it's an abstract memory type that lets the driver support dma-buf
memory and io_uring memory:

https://www.kernel.org/doc/Documentation/networking/netmem.rst

This driver does not use the page_pool, doesn't support dma-buf
memory, or io_uring memory. Moving it to netmem I think will add
overhead due to the netmem_is_net_iov checks while providing no
tangible benefit AFAICT. Is your long term plan to convert all drivers
to netmem? That maybe thousands of lines of code that need to be
touched :(

> ---
>  drivers/net/wireless/mediatek/mt76/dma.c      |  6 ++---
>  drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++++-----
>  .../net/wireless/mediatek/mt76/sdio_txrx.c    | 24 +++++++++----------
>  drivers/net/wireless/mediatek/mt76/usb.c      | 10 ++++----
>  4 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index 35b4ec91979e..cceff435ec4a 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -820,10 +820,10 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76=
_queue *q, void *data,
>         int nr_frags =3D shinfo->nr_frags;
>
>         if (nr_frags < ARRAY_SIZE(shinfo->frags)) {
> -               struct page *page =3D virt_to_head_page(data);
> -               int offset =3D data - page_address(page) + q->buf_offset;
> +               netmem_ref netmem =3D netmem_compound_head(virt_to_netmem=
(data));

It may be worth adding virt_to_head_netmem helper instead of doing
these 2 calls together everywhere.

--=20
Thanks,
Mina

