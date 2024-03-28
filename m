Return-Path: <netdev+bounces-83115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E19890DDC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 23:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018C4B214A3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F4548EB;
	Thu, 28 Mar 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjvVCqp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559484EB5C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666431; cv=none; b=ZJJ5in8eFbCRE0RkJibolhPRQHNQctomSK/es0+RBOrDsVxRoUw2qGyGHldLiPnHghkR7CYAns1nLT9tLX064J+G9g63Y2rdUJVtaa2nvOJ64FKkdpKXxN0mqVEE/WiogmTHh7lPCXluYFheGO1anbQO8NuZpwsriJtu95HqOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666431; c=relaxed/simple;
	bh=m2sHr69UQ23/+yNNagVCVSd+tL9gNcumuplvgXMM3eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTFag5MzTXrx3Z3juj6KBCgaNHvDouFmu3KSBKdPSWjvZkXtNUtx8hvNnrJ4p64pDoqrLTqTXffISDPq9Mcw5U8n0JS1r2D+oBEHesuUDi9FKloR39/9Qxh42e5X4mqybxXKDgJoboLaimWlboXLz1xE2KsO0Dfi5YaiaTfjGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjvVCqp+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1834834a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711666428; x=1712271228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEbIDW7kbPaE87dBPORDU/rsnpNPLPoHlh1VVnWn9NA=;
        b=GjvVCqp+UrkJj/Q1BkHxcMX1d1B0WrYzJZU4b12Im5rjUMSk/I1e59Gl2QrWEdObM3
         WVc/EDOfGYTRdrVD47dbkVYM7MuIf37jur8eZgPmL+8hG7PgTYwfXzifmBWzk8lveWAu
         pL0hI0UrIrSW/nh8lmgfAbsXzygVZWxD4TtHdgZcC4pdTnUigPdjglq+uAMNxGA2jvri
         K6tZOk2oF/XSN3H5BV90vwHs0JQbplddepfes2CCS4QTGh07WMaBJrLApLTdwTjGhLPZ
         EGKKa3bVP2Cb8BAMFjmMMbQTMCoCKjcFvd0keKtBzIICixLNsRrR6gCAEJa8cbc6+Mid
         zDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711666428; x=1712271228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEbIDW7kbPaE87dBPORDU/rsnpNPLPoHlh1VVnWn9NA=;
        b=urr+gtmgasa9kiuyp3ybt9gVqOAiqi4feNKQ4TcgurLvcUEf0yG0RxEDuEkYWM3iRl
         KertgzomL0Yca7+sIBeXwa1HYqgEOcGKr6Xbq+1iNrI8S912COiLLh2W5qrn0RrbePLY
         9lKy8YRe8tVLrt9nnzR5NyxvL74GrJE9O5cWs3n881+eqZUOqh6Wo8OocO44OrC3YzyD
         iy2FUvh1/+N1AElSUJFAGIssLX2TzPEnJ/CspMv9lkUggwsMBVUXKDNVJP2SztQ59geh
         NsvWSOAKopY8cOm7XAAjE2vQbVj2lTHYyBk4y5jGEvq2TGAnuw9iC7CoNFVqqElzHNsw
         uYpA==
X-Forwarded-Encrypted: i=1; AJvYcCUnF34eyHInTFoFq+AcDPmk7o28man7qdy/QuJE9mdAaRG7/36xE9M7L6fMdFevb52nlrb2u6QSF6wYLLkIxjhGpw1efROm
X-Gm-Message-State: AOJu0YyTcgBc7tZh9aepMPwuLhuKM/LYM2kDK/Wcfh0/im6neQvJ8R0U
	KdeE1MQE0nCy3B4b01oo4aWC3QOctntIFIidBw4GoMs1l9X6NcDLVH8WHD2SpT4N8n+NUhBuisO
	khwnMbJgR6lr/TrclFlkkXZH+4lPdLW5nNQhP
X-Google-Smtp-Source: AGHT+IHSOF7Jz1HlwWi9ZnZS4sDGFwM0sUVO6wKPz80s3bzKUakcomIa558eS7Mlmg+NfUj6hjAXDu38td4y54TNQ6s=
X-Received: by 2002:a05:6402:254a:b0:56b:e089:56ed with SMTP id
 l10-20020a056402254a00b0056be08956edmr540944edb.39.1711666427673; Thu, 28 Mar
 2024 15:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-3-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-3-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:53:35 -0700
Message-ID: <CAFhGd8rCzhqK18KLtLVLWyWHtQzJsHCkkkQQyLbmw83K6ExKkw@mail.gmail.com>
Subject: Re: [PATCH 2/9] libceph: avoid clang out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Milind Changire <mchangir@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 points out that on 64-bit architectures, a u32
> is never larger than constant based on SIZE_MAX:
>
> net/ceph/osdmap.c:1425:10: error: result of comparison of constant 461168=
6018427387891 with expression of type 'u32' (aka 'unsigned int') is always =
false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ceph/osdmap.c:1608:10: error: result of comparison of constant 230584=
3009213693945 with expression of type 'u32' (aka 'unsigned int') is always =
false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>             ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The code is correct anyway, so just shut up that warning.

OK.

>
> Fixes: 6f428df47dae ("libceph: pg_upmap[_items] infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/ceph/snap.c    | 2 +-
>  net/ceph/osdmap.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index c65f2b202b2b..521507ea8260 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -374,7 +374,7 @@ static int build_snap_context(struct ceph_mds_client =
*mdsc,
>
>         /* alloc new snap context */
>         err =3D -ENOMEM;
> -       if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
> +       if ((size_t)num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
>                 goto fail;
>         snapc =3D ceph_create_snap_context(num, GFP_NOFS);
>         if (!snapc)
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 295098873861..8e7cb2fde6f1 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1438,7 +1438,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(voi=
d **p, void *end,
>         ceph_decode_32_safe(p, end, len, e_inval);
>         if (len =3D=3D 0 && incremental)
>                 return NULL;    /* new_pg_temp: [] to remove */
> -       if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>                 return ERR_PTR(-EINVAL);
>
>         ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> @@ -1621,7 +1621,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_it=
ems(void **p, void *end,
>         u32 len, i;
>
>         ceph_decode_32_safe(p, end, len, e_inval);
> -       if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>                 return ERR_PTR(-EINVAL);
>
>         ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
> --
> 2.39.2
>

