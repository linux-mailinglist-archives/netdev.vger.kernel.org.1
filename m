Return-Path: <netdev+bounces-76275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BF86D1CD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627C3286C2A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47013C9DC;
	Thu, 29 Feb 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keR6634A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C113C9D5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230411; cv=none; b=BpWfNQauTKxtPyaqUQn6f/g0osvxVaMi7qCYUn2D3v+EkX+LFKHBPJq+cdQCHD49ARZbwhSyes+GFY1Sc0nBBtAm6cFbPbX3yFv31ctpz0lGnUV31i2xjZsv9ak3QWkw2tR4CLJXES9rgzWNe4IN1IX5o5kApet7V2WB5bx6NN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230411; c=relaxed/simple;
	bh=6LuIrMK63u1XjMOExqofQ4YN3yylqQqDI9Pe0zXc8cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvQCKsV1byGni/3MYpd+ngkKKNk6Pp+9ZKAxlXEu2W/FpIjHjYnUPDeKAvjCnLqQwVf07tCwpO8Sh6D7Om73LVzgMusPIiZGuY9TDcLj7b0R6y4HdVPezgu8yE9V0nFBbaT1Y12zmjNI9eDKzh64gxaBF25Y1zq5W/jkV52q4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=keR6634A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so13695691fa.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709230408; x=1709835208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pklDDrq+hQtqDnYXx11dhdGZOOt0eAVwVlZXU7PP1e8=;
        b=keR6634A9RdjnF7vB0jSv5H9ZdO+1qmbke+ih1pXfkz0Rd9l1kcQPAIZaEiyzSzH4y
         x7sTxrQIuFq0X1bC3jJArRFNgtYVo25i+1+SJZR+PbFAxIxxjYdUZc4/hWATvhPDS+mm
         o/tIdpmCunCcNB3635OmzTD2J1c4/WeqioZTN9HoDm2e41nSWt3iGLg3UWMCKZrMR9x6
         fkMap5EWDl8nBXv9CYB+zcaWSJEgfrkU0Vot4eSM8jOSqBRXXr6/OrZCVMiFQQwqDsZ2
         aMYeHqaEFosu5hiXjXlMK2UBEw/kDRss4Hy24zjBXaQubZdLaiD4RWS2m5umucFqCgW/
         owrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230408; x=1709835208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pklDDrq+hQtqDnYXx11dhdGZOOt0eAVwVlZXU7PP1e8=;
        b=b59QGbDitSFTIYf4D9zpQ+ijNk8tBYyFiakIcsI5PA6KbuqvIPLOby1LvDk+EzxMRV
         iRZfcFEp8HRaDREyCBo958qiaPq8grYSSVObbfHcxwyDJ3oPAxIbKSB47ykQhzco4jO0
         uXq4LRVKiRMYU5o4LliGJwGKNZ5cHNvqDZJakN9aLxEjJXFkoRYSqfLH4sj5mD4dkRRd
         cDlhKcqr+mesBl1qyPYsZ6+7x43a58VQHydxcMIW9vaF1qsm8nhxcaWhN9dnV41sTaKd
         UhURbelTsPdkRyUMpu1++MhJRkueYmyVohEZNoEx5wS8KR4gmlHpoW2y3fV+9V82Gfo3
         YmvA==
X-Forwarded-Encrypted: i=1; AJvYcCX4YdlF0IWCOd0dacbRytPK8QI8/WYk8NUphsy9cuYBjKLBa7KhCaPc0vGu5MUBE0MlW/q6/k/UPSU2AscI7MvPV1/ZqHRk
X-Gm-Message-State: AOJu0YybQkWAaf5+a+70iHW5ucWQ+pZhBo24bPnJ68vAV5rMImfXgN5H
	RPahGN4BaUsVd4xJqaKiwdGn3xJm0MUl/b64z4AOs/FX9q1uykcNzWuERMojdcU1aXE1KsHTXq1
	fqHdW8I//lqBE8tBwMLDAPnkD2mweT/9e0kxsgA==
X-Google-Smtp-Source: AGHT+IF2/L7EC4NHYQMgoW1+ZE+8opHnVo8BNmmehinwX9UwEymox0+oHVp/KsCI2M63INN9xY/zVP0BZ4fO/cEGFhs=
X-Received: by 2002:a05:6512:3e6:b0:512:9857:34f3 with SMTP id
 n6-20020a05651203e600b00512985734f3mr1927130lfq.39.1709230407712; Thu, 29 Feb
 2024 10:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220210342.40267-1-toke@redhat.com> <20240220210342.40267-5-toke@redhat.com>
In-Reply-To: <20240220210342.40267-5-toke@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Feb 2024 20:12:50 +0200
Message-ID: <CAC_iWj+zz8ZYg8GgaNNFUMrdNb4T0wS3=ZBtQsNKrEHyR1H9tA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] page pool: Remove init_callback parameter
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 23:03, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>
> The only user of the init_callback parameter to page pool was the
> BPF_TEST_RUN code. Since that has now been moved to use a different
> scheme, we can get rid of the init callback entirely.
>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  include/net/page_pool/types.h | 4 ----
>  net/core/page_pool.c          | 4 ----
>  2 files changed, 8 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 3828396ae60c..2f5975ab2cd0 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -69,9 +69,6 @@ struct page_pool_params {
>         );
>         struct_group_tagged(page_pool_params_slow, slow,
>                 struct net_device *netdev;
> -/* private: used by test code only */
> -               void (*init_callback)(struct page *page, void *arg);
> -               void *init_arg;
>         );
>  };
>
> @@ -129,7 +126,6 @@ struct page_pool {
>         struct page_pool_params_fast p;
>
>         int cpuid;
> -       bool has_init_callback;
>
>         long frag_users;
>         struct page *frag_page;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 89c835fcf094..fd054b6f773a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -217,8 +217,6 @@ static int page_pool_init(struct page_pool *pool,
>                  */
>         }
>
> -       pool->has_init_callback =3D !!pool->slow.init_callback;
> -
>  #ifdef CONFIG_PAGE_POOL_STATS
>         pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_sta=
ts);
>         if (!pool->recycle_stats)
> @@ -428,8 +426,6 @@ static void page_pool_set_pp_info(struct page_pool *p=
ool,
>          * the overhead is negligible.
>          */
>         page_pool_fragment_page(page, 1);
> -       if (pool->has_init_callback)
> -               pool->slow.init_callback(page, pool->slow.init_arg);
>  }
>
>  static void page_pool_clear_pp_info(struct page *page)
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

