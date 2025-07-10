Return-Path: <netdev+bounces-205892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F764B00B50
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258DE7A9597
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCF2FCE2F;
	Thu, 10 Jul 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qObU1zue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014F2EF9DE
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171987; cv=none; b=ixSiwHaVwFHukd1nbkJ45W3xoxEXcEM4i9glH1IFu43NWv0bP9Ocf44IPN1eFShfCzaFYmg6ZNTN3hdrzijLB+uUB729/t7HyAcRPcF4EcjtLqf28krrA4wzuKGeIIKDEO12WD95capR45O6AfEIZRaYyV2CKgJZgaDTx2Zt254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171987; c=relaxed/simple;
	bh=DQ/y57eCcvCivMqXieykxCIkDza/1dPM5uPabJRz16o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTYG3c2KwH48boDAZW0eTekYZkXudjVUVQHqPd7ObIVMUcONnaVbDCldwNZypyDabkSa5R41//aOn+SRNro8hue6jSqFqh3v3GtC6iSB5+3Slg0Jp8XKAZ4tylT071M8kXuKszlCt2q/ypofng6fLkhZ+xW2tnkwj1okYqzYS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qObU1zue; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so2115a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752171983; x=1752776783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=qObU1zuerGhbYWlfulILtsMApJEO572cb99Ey657M5ZIW5FJn9qSNnybTUmZwPXmoo
         6P1pcpOL17ZItstd3CjuuSqb+erRZa4J7rQHM4ORASF5f11JNxKu0xDSlD/J1YA71gHW
         fRONoNj2vmMzTagcuqJ8ulV5PLMfLTdVZdq9OlnKV82aY69cKtL9CZ7kzUANxH271wGA
         P/Hks07foD1XCHZENTyruReqQLmOfQkLM1ii2gdSVPyMb9nohjNE0lRXOR4A/JvkN58F
         LwP+GaUG6r4NOEEdxPUCvO054zG9vCYleh3rFncue61UmbDCdFOBqnJEfIScIY/iHIC5
         JcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171983; x=1752776783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpVeUDzlloshth7hyY4uUrRygX8GK+L0hY7EdHxCTWk=;
        b=FHUhHWpnaOD6vmzz1X4HJmVRHG+wNykdyQDN5QEmC6SoUEb/mzkc150luNtr2fVr3p
         DDPR9CsJ65a9G/FiO7b4uRmJMOpJvZHI4sd949dpwK8fxmYIsFPhVUnvRM/PX+DXs6D9
         zJrZNyRYi121YGKcT3c2izq4YCCzqdgEkGc0ie4JuDKkFjvnakpCkU5cb+w4z1Z+fFDB
         KZ2QQxTdiyii4iOKjwtydq79IBGTNkfemdom009hnJmSERxd/syQQP9sQpDIKJ2ZzOuD
         PDSSi0CoOpos4+EP+avamLE1olnNPne7POFhPaJN5zuBiSlkGhoecU9Nhn1Dq7Mx09QP
         fVpA==
X-Forwarded-Encrypted: i=1; AJvYcCXud8Z40Is+3y9Mw6Xus2sbRo1KOuHIegDD3fgihsvmBrR8BiqbUvoj3eagh4KWsUUGspMhd9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQGJxKTP2vk/LLAUGYEDWJNkQCwKgdAk/ygPBExzSF/vJDwOk
	reo9RvoMnW1cfKSb6FK1sbaAoEdvUGN140lqwJWACE6TR7eKQ6F29s6ujbg4Akk6JvcUxvL46hO
	O7MeKpYFbge3Yk3Nm3dAPQyy+EiYV3Mp1CCZYhBCJ
X-Gm-Gg: ASbGnctg+o3xEl8qpoCCe1vYogC9eASpsy2YyHL58tm0wFl/G2zRrSvnA1Z2xX5nkNs
	0cdJcZzpVUbNWbLWyoJYgL+Fp9jM65/9bJkBLcOuqXlJvHmKfM3W8f0JmbgngXS5dejAUNf+hpJ
	N0yj3D+Hz2b4sg3aHYRYqCClncrM5l7M5EFN7VPOoLhjwg1ZYM+I/7awhIm7c6cu99pxeL2zM=
X-Google-Smtp-Source: AGHT+IFt7W8JAheHiVqwt4ZBR3CQtXpumX/T7A5/rBmH2QebswkJBxnWs6YN36d9U3n7K42s+O7r2vNQ3sha7Qd9AVA=
X-Received: by 2002:a05:6402:24d3:b0:607:d206:7657 with SMTP id
 4fb4d7f45d1cf-611e687e614mr10195a12.2.1752171982710; Thu, 10 Jul 2025
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-8-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-8-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:05 -0700
X-Gm-Features: Ac12FXyyC8r-KEBOBjPhKMa8MrPinEu-RU7EeVBu--QTlNg-z0ciuFeVDRS6Ldc
Message-ID: <CAHS8izMo5QLb5CrrdfBnaG_1kWd=D7iQM+2vB0Gm-pbH9tmk1g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/8] netdevsim: use netmem descriptor and APIs
 for page pool
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
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in netdevsim code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 19 ++++++++++---------
>  drivers/net/netdevsim/netdevsim.h |  2 +-
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index e36d3e846c2d..ba19870524c5 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -812,7 +812,7 @@ nsim_pp_hold_read(struct file *file, char __user *dat=
a,
>         struct netdevsim *ns =3D file->private_data;
>         char buf[3] =3D "n\n";
>
> -       if (ns->page)
> +       if (ns->netmem)
>                 buf[0] =3D 'y';
>
>         return simple_read_from_buffer(data, count, ppos, buf, 2);
> @@ -832,18 +832,19 @@ nsim_pp_hold_write(struct file *file, const char __=
user *data,
>
>         rtnl_lock();
>         ret =3D count;
> -       if (val =3D=3D !!ns->page)
> +       if (val =3D=3D !!ns->netmem)
>                 goto exit;
>
>         if (!netif_running(ns->netdev) && val) {
>                 ret =3D -ENETDOWN;
>         } else if (val) {
> -               ns->page =3D page_pool_dev_alloc_pages(ns->rq[0]->page_po=
ol);
> -               if (!ns->page)
> +               ns->netmem =3D page_pool_alloc_netmems(ns->rq[0]->page_po=
ol,
> +                                                    GFP_ATOMIC | __GFP_N=
OWARN);

Add page_pool_dev_alloc_netmems helper.


--=20
Thanks,
Mina

