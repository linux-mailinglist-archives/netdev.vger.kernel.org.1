Return-Path: <netdev+bounces-186275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01072A9DCED
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 21:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7907B37FF
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFF21DD0F6;
	Sat, 26 Apr 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJAWkBcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C97F1C5486
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745695588; cv=none; b=nt81ozX1wtoQ3ZLAhKg2k1FwwM+peOwINlVMwzzbdrEkqIx4/3hZAvj0ojCVODtuV7iGiWRq4NjtKjMe2GdoY6gJzE08YOs+Q1x9CkT2gClZDuRf7KMeUlnHY5aBEuCIw2OdnbVsNCI3TqTV/7RvjMfEuSHwD30HZsB3VThwLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745695588; c=relaxed/simple;
	bh=1wnXQU1lKTpSSK0Bubie8n+Qb92Zl1+oUvRCoH6CX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qGAu0vt60v6IPhI2vQtgba6eBdQ1bh36Y530NWpo340gTHJh2RRN9KOWvA/rgZnrc5T/1ojeX03/ZJRzUx/GckNEsPN3LySI4bc2r5078pAhrdT8ADY1ghcqSo1vipA6/ZG6Hikeno0GpNQNLwir0IlPKEwNxTBUMrfoSFFUPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJAWkBcW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso4343802b3a.0
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745695586; x=1746300386; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3Z5+CeGeAg+Jz4PZ867FLXq5QWgjnVVuDUEmQd+3WM=;
        b=UJAWkBcWav+xI+L3N8uTXLKFfIy//+BTsgRbYw74CwiivzoDajAdtVINSg0oyZft6i
         ZQwx51bsTD67zz0P96gJGbJp/ChHbJMoOw1Bl55RpVVqhMeTFdwVhjnFWMOSShEzX0l4
         5EtX+G8rHsVqtXQgs1uwFLRy5DWNI08pvFE7YP2qPrW+mBgRJST864GQaYkH9b1lAQAF
         vLFSFiaC7ZXxxzeyXUyvIdiAlOHQH20wGhlE+hg+RCoFFq6jE8Dm9g/dPU746TdTV07I
         C8eWMSCZY67IErXYK96+Yiz4ELoVANfRPCd0vpkgtwDSbsuWVBPeJgOFoc67Ap5y5iMO
         /Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745695586; x=1746300386;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3Z5+CeGeAg+Jz4PZ867FLXq5QWgjnVVuDUEmQd+3WM=;
        b=b1YZkVmOVEVl9ukeV1Tcfpliz4GfLwBb/Q9fNVLoJuDxx6wpj0UPIvyP15JsYKTNr3
         ccswsI84Vzruo0GYxi8MQH5eimILvYlRgbFPNADjuspUo0nuOUjCgdtlRKELr2rkSzBr
         TRaFXR9HlyVsJWLifXMfx48jLbTRmaNyaVQn2UgKjSrlx1gpzZ/UEcjHHy5tZOXmoYbJ
         EarQr3aUxIsNWvCVOZRkQDWRS9H2FNHlxeCrOyPfRs0FvaAe+7mz8GS28U9pl+irCjfs
         zZeN4kq++jFBtZtfk7raCDW/WL9iu0bNd71sx4I8XNkY0H19UDQlFbu6GfjlQQaXQ/qf
         Bglw==
X-Gm-Message-State: AOJu0YyAxbrnD8elk1JDQ14vcmOQJ6dlItkqrIss8D1tf0ACuu1LGVz1
	fOw4D8UsM0S2tjBENwrqej7dUX5u/DHQONnMEB3M1zwdEzOAzH7qcNjN0NO3Y9/a/o3/luieZY2
	NJt67gKLQx+pbZDi7jh95oSl+HahIhyXK
X-Gm-Gg: ASbGncvMo5UHcuvx78DaP1rU0VlV68Viq8K/lY/g5RGJJu5dkgZH8uZcDoX/jt2l8WL
	AaNRfjzhCNqqSdfZtz+ovKViWiGIR0nqjdlTe7G+ivTjtI49USuO/3kXN4yBx21c18s/DO9dRVv
	A8UCJpvfcgzrK8q4iZ8Gyvmw==
X-Google-Smtp-Source: AGHT+IGqfgW71fljZnSoBtCk6cSWJ6v+5J+lQpG+WwCHGYuho8QCrM9FcGf/9a4SQnZOCfyzmn4fiTUXjZqQJMw9k4A=
X-Received: by 2002:a17:90b:3c87:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-309f7e00be9mr9210480a91.19.1745695585859; Sat, 26 Apr 2025
 12:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424183634.02c51156@kernel.org> <20250426192113.47012-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250426192113.47012-1-shankari.ak0208@gmail.com>
From: Shankari <shankari.ak0208@gmail.com>
Date: Sun, 27 Apr 2025 00:56:14 +0530
X-Gm-Features: ATxdqUHk3J3pCYN52Xb8WO22b0ZGgBhslyICNyiSHzmpYDI0CYxj83X9YnPjUnA
Message-ID: <CAPRMd3mRUi+ESqDy04c-r38JoSWxo8Ka0Et9gZbe+jRrL6G_nQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: rds: Replace strncpy with strscpy in connection setup
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacub,

I have implemented the changes in the v2 patch. Thanks for your review.

On Sun, Apr 27, 2025 at 12:51=E2=80=AFAM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> From: Shankari02 <shankari.ak0208@gmail.com>
>
> This patch replaces strncpy() with strscpy(), which is the preferred, saf=
er
> alternative for bounded string copying in the Linux kernel. strscpy() gua=
rantees
> null-termination as long as the destination buffer is non-zero in size an=
d provides
> a return value to detect truncation.
>
> Padding of the 'transport' field is not necessary because it is treated p=
urely
> as a null-terminated string and is not used for binary comparisons or dir=
ect
> memory operations that would rely on padding. Therefore, switching to str=
scpy()
> is safe and appropriate here.
>
> This change is made in accordance with the Linux kernel documentation, wh=
ich
> marks strncpy() as deprecated for bounded string operations:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
>
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
>  net/rds/connection.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c749c5525b40..fb2f14a1279a 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path=
 *cp, void *buffer)
>         cinfo->laddr =3D conn->c_laddr.s6_addr32[3];
>         cinfo->faddr =3D conn->c_faddr.s6_addr32[3];
>         cinfo->tos =3D conn->c_tos;
> -       strncpy(cinfo->transport, conn->c_trans->t_name,
> +       strscpy(cinfo->transport, conn->c_trans->t_name,
>                 sizeof(cinfo->transport));
>         cinfo->flags =3D 0;
>
> @@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_pat=
h *cp, void *buffer)
>         cinfo6->next_rx_seq =3D cp->cp_next_rx_seq;
>         cinfo6->laddr =3D conn->c_laddr;
>         cinfo6->faddr =3D conn->c_faddr;
> -       strncpy(cinfo6->transport, conn->c_trans->t_name,
> +       strscpy(cinfo6->transport, conn->c_trans->t_name,
>                 sizeof(cinfo6->transport));
>         cinfo6->flags =3D 0;
>
> --
> 2.34.1
>

