Return-Path: <netdev+bounces-225393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7529CB935AC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ADF3B082F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D6286413;
	Mon, 22 Sep 2025 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXXs/9P2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279483A14
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575592; cv=none; b=WmX0CbFZPq9DSoeDapQwRyL/XecAXkAHmtT9t5+V+43LTdqIS8zKbvMDMwmUIIOSeycAjhrLL4xKDZMl9insg7t/sADD2I3ZGyKmipHqCpVS1suRQb59D+ofPmGLZlBwtUxKGfhCs0AdSRxJu8rYxeke9qydLM1gdhWipxyl96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575592; c=relaxed/simple;
	bh=5nYmtllGAhnb0awO7jb0e2Q28ODUSeoaxn4f2xlaPSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma2JT6RJDHmbp4vv4EMoQfWyhniXDJH+oJyuIzdD2jYE2lmHxQ7k1e8Rm1vxw86Xn733u8EZkO3cOkxaHjdFRQ39aU0kKOv23pPtxIgbG60X0JayJ8j3CVaaTkOntTnainQzo4SnXR9+Yk4HTJwZIdLxFOeJoo4DHtED+iCe4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXXs/9P2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so48090371cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758575588; x=1759180388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEsovu3oZESlhX5Jz4J0hLzBSRyfD9rtZS172hR4u5c=;
        b=jXXs/9P2HkMHJI1yo8hz1UjOO1Q2SsxOsf0GDbBVkZI6ypOWkmfaP0RzIxLYVFU+Yn
         f4XX5qxG18WPKv46CyytcPsWKpWOvnNvLc18kwL64v+NQpDtNBGHVQT2X8i0adigHSY9
         FNfhs946dYZ64a10iuwzvjMYuzgvMI1qSS8gyq/Ibf5jhZFxLqahAqRzmQ/LtpikTyHl
         VjObsHmO8K0bjgxRlzbYygjoFs9mNG+49U/mn+LYy8dbpaUyDhCx7ztomqfNb2wxfNN2
         uesvmdga0Wh9i1YuyVUUjOz47vOgjFa3DAUNgYojEPUxOenohp/rROXnSmY7Z9obIYxw
         m/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575588; x=1759180388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEsovu3oZESlhX5Jz4J0hLzBSRyfD9rtZS172hR4u5c=;
        b=J9oSjywEEHV9iTNh1qmHOstdmjcgpru3XYX9BpKSJdxva9tpW7ncS4BQ0b4zJZenj0
         WHM9yzH04fuAvKuxCxbDaSl08pC9U+rsN7GAgTze+JPeSoGwWQ/ZdvWXSs0ISbVYrplf
         e+lBj78b6dJ9Tloar7xh1bXMIyka5lIjUgbRgjahY5zHhZqwWQVWFcg9mg1Xoe0fAR21
         x+7MMHnQfY3rF/nO5J3Uqe3XeCJ5lGjDOmKxbQ1ESIaESHsixYB8u/eNC1EY1OqcfxdE
         cKFZgieG0Bl6uWRXsY6fG7Ex3aptSzt6/OtYmv64cB2T+g4A4fWYGgyOhzNw24cY22Wq
         63JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCsciXry+qZZ7eW0i4mdghdQbsBVhwKAHH6Xy1tF/QF1fXyEsv+gikCj1fals3uZiVoiAakWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkojw21nlhEOtlbA1YqleRrSM2F2rLTr9M+gmkIK/uSUBxtXNW
	ENqM+6cQWV0FXvPQF5GT3JzRmH36hZ3I/iEO3F570uC24Xxm5sFouZJrCQAsa3xpBgs7RXIKLBn
	I4XcPmuLpCIgdLx5cWhZU90+ll+/JdlkIxYXDRUQfRxSV2zgH7C2yst/UlYY=
X-Gm-Gg: ASbGnct3tbC9awK5AVzRlF2ytDtD75xBbMk0yhNcvoYTd32do3sdAEszAgorBXYkYOQ
	/i1PcWuA3hH+u8H9N0Ne/UCThcDQqKlaUe0jv9rc25izFOjLT0BeMYJmCOgskSzBAKnIvdqeo3P
	O7htiMuqcp6q+loeQDo67rG5ZlEbCfR/ULuM9ywxKVXMV0QrFZS0dDZtYpjrOWe39RyUATOfUcE
	EKh3NQ=
X-Google-Smtp-Source: AGHT+IFOkInq54LGgN9MBihJi22pHNNfcp/jaI8lGmqg1owNQ9Fe2LgHA1i2G81dAprInLWEJoUWSLD05co99TykTR8=
X-Received: by 2002:a05:622a:f:b0:4b7:b1cb:5bd8 with SMTP id
 d75a77b69052e-4d372a3a633mr3487491cf.73.1758575588247; Mon, 22 Sep 2025
 14:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922194819.182809-1-d-tatianin@yandex-team.ru> <20250922194819.182809-2-d-tatianin@yandex-team.ru>
In-Reply-To: <20250922194819.182809-2-d-tatianin@yandex-team.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 14:12:57 -0700
X-Gm-Features: AS18NWBPo_cBZCPlO-PBo6K89_XzA7B4cPtbYpYgjXD_e43PNvxeaVox88UED2g
Message-ID: <CANn89i+GoVZLcdHxuf33HpmgyPNKxGqEjXGpi=XiB-QOsAG52A@mail.gmail.com>
Subject: Re: [PATCH 1/3] netfilter/x_tables: go back to using vmalloc for xt_table_info
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 12:48=E2=80=AFPM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> This code previously always used vmalloc for anything above
> PAGE_ALLOC_COSTLY_ORDER, but this logic was changed in
> commit eacd86ca3b036 ("net/netfilter/x_tables.c: use kvmalloc() in xt_all=
oc_table_info()").
>
> The commit that changed it did so because "xt_alloc_table_info()
> basically opencodes kvmalloc()", which is not actually what it was
> doing. kvmalloc() does not attempt to go directly to vmalloc if the
> order the caller is trying to allocate is "expensive", instead it only
> uses vmalloc as a fallback in case the buddy allocator is not able to
> fullfill the request.
>
> The difference between the two is actually huge in case the system is
> under memory pressure and has no free pages of a large order. Before the
> change to kvmalloc we wouldn't even try going to the buddy allocator for
> large orders, but now we would force it to try to find a page of the
> required order by waking up kswapd/kcompactd and dropping reclaimable mem=
ory
> for no reason at all to satisfy our huge order allocation that could easi=
ly
> exist within vmalloc'ed memory instead.

This would hint at an issue with kvmalloc(), why not fixing it, instead
of trying to fix all its users ?

There was a time where PAGE_ALLOC_COSTLY_ORDER was used.



>
> Revert the change to always call vmalloc, since this code doesn't really
> benefit from contiguous physical memory, and the size it allocates is
> directly dictated by the userspace-passed table buffer thus allowing it t=
o
> torture the buddy allocator by carefully crafting a huge table that fits
> right at the maximum available memory order on the system.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  net/netfilter/x_tables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index 90b7630421c4..c98f4b05d79d 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -1190,7 +1190,7 @@ struct xt_table_info *xt_alloc_table_info(unsigned =
int size)
>         if (sz < sizeof(*info) || sz >=3D XT_MAX_TABLE_SIZE)
>                 return NULL;
>
> -       info =3D kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> +       info =3D __vmalloc(sz, GFP_KERNEL_ACCOUNT);
>         if (!info)
>                 return NULL;
>
> @@ -1210,7 +1210,7 @@ void xt_free_table_info(struct xt_table_info *info)
>                 kvfree(info->jumpstack);
>         }
>
> -       kvfree(info);
> +       vfree(info);
>  }
>  EXPORT_SYMBOL(xt_free_table_info);
>
> --
> 2.34.1
>

