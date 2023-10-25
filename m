Return-Path: <netdev+bounces-44240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F180D7D738F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AFC1C20DBB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23B2AB45;
	Wed, 25 Oct 2023 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1RM13Qh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F528E02
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:50:06 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D5184
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:50:04 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4587f9051e3so63324137.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698259803; x=1698864603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm53H7aU/mcJWOt/z6nKTIWjPlkZSt2CcKbsqKaUiDs=;
        b=v1RM13Qhe2aHe5Xtj1s1yUDQxAivqNsW/+N3J+MFkJPm0OSN2oEL/MvbqSZ6Gg+WjT
         0atQAVkwoWWbItFyFxu4yezYvlT5pRueLS5rqsiOLcc/xbPM8CL1eIP3fmQUVsnMkZJi
         cVok6UiIxrO0/ez0i5+jw/YgOJUEodfbWTB/FWQa8dw2c0KhO39411RchZFoCWT8U5r8
         VswiblqGJ9pwm89h0THMgjLY2wLF1awyTUw6255ew660n8GOJwhYPw1SODvP4LubmvVS
         l+lKoq7G3GOA11ogcI1rtMngznBA4VPOXFLmpM1I/AJXu349lYkcsyQ+jguGqngOxQIE
         MejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259803; x=1698864603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm53H7aU/mcJWOt/z6nKTIWjPlkZSt2CcKbsqKaUiDs=;
        b=blfD+l90IVKRBScQo0QIs4Z65tTOOJxPUquUleKJTRSBt0yeHPv9wr28WQlAkFB1uf
         qo7/Un/O0ZtuubGaIrC8FhjQMSP5YwvvSmpu8fov+shsRDgz4ibkcGzTh2OZSbfNg/TN
         Hug0i9bzyoq/Oo2hl1iX8krfzyDWfuWyMjwCgd6nPMJEPJYs2e0Ou+YDqDfYOJK16SSG
         u3+Zt57zvh4a3vtkAdUIkIz8aXnXeBCbOYeVrJTnOeDfPUHf2x6ButMgDqedpNak8v91
         uvWJ19UzpgqDEalBo4LkjIjdemqcOX7Lzft5zDjjMa+UF3bwpz6drzh4MC4biHxSsfBx
         RB3A==
X-Gm-Message-State: AOJu0YynNoewX9xL57TgNNnym2mxoFuk8qo9C61TXE01vtXEvitXCWPL
	Oq1JQKmX8x99+AVxTDRx0WYMTZxmUSaV4DEeSSaNHA==
X-Google-Smtp-Source: AGHT+IHFCOLsOIFil9ODDxD5olbxG7zYd6BUsy8ve7QBENMyherdwjSvGTUeQ8KYDce2wk3ZKM9i4cbNeSPVG2niIhg=
X-Received: by 2002:a67:ca16:0:b0:457:82be:6782 with SMTP id
 z22-20020a67ca16000000b0045782be6782mr15458735vsk.9.1698259802840; Wed, 25
 Oct 2023 11:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024160220.3973311-1-kuba@kernel.org> <20231024160220.3973311-5-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-5-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Oct 2023 11:49:52 -0700
Message-ID: <CAHS8izMXN9_6ehT6jejyY4cxe5UOjLFk93V2LtdHVc75S-77GQ@mail.gmail.com>
Subject: Re: [PATCH net-next 04/15] net: page_pool: id the page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 9:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> To give ourselves the flexibility of creating netlink commands
> and ability to refer to page pool instances in uAPIs create
> IDs for page pools.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  include/net/page_pool/types.h |  4 ++++
>  net/core/Makefile             |  2 +-
>  net/core/page_pool.c          | 21 +++++++++++++++-----
>  net/core/page_pool_priv.h     |  9 +++++++++
>  net/core/page_pool_user.c     | 36 +++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
>  create mode 100644 net/core/page_pool_priv.h
>  create mode 100644 net/core/page_pool_user.c
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index e1bb92c192de..c19f0df3bf0b 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -187,6 +187,10 @@ struct page_pool {
>
>         /* Slow/Control-path information follows */
>         struct page_pool_params_slow slow;
> +       /* User-facing fields, protected by page_pools_lock */
> +       struct {
> +               u32 id;
> +       } user;
>  };
>
>  struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 0cb734cbc24b..821aec06abf1 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -18,7 +18,7 @@ obj-y              +=3D dev.o dev_addr_lists.o dst.o ne=
tevent.o \
>  obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists_test.o
>
>  obj-y +=3D net-sysfs.o
> -obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o
> +obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) +=3D net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) +=3D pktgen.o
>  obj-$(CONFIG_NETPOLL) +=3D netpoll.o
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4aed4809b5b4..b3b484fbacae 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -23,6 +23,8 @@
>
>  #include <trace/events/page_pool.h>
>
> +#include "page_pool_priv.h"
> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>
> @@ -260,13 +262,21 @@ struct page_pool *page_pool_create(const struct pag=
e_pool_params *params)
>                 return ERR_PTR(-ENOMEM);
>
>         err =3D page_pool_init(pool, params);
> -       if (err < 0) {
> -               pr_warn("%s() gave up with errno %d\n", __func__, err);
> -               kfree(pool);
> -               return ERR_PTR(err);
> -       }
> +       if (err < 0)
> +               goto err_free;
> +
> +       err =3D page_pool_list(pool);
> +       if (err)
> +               goto err_uninit;
>
>         return pool;
> +
> +err_uninit:
> +       page_pool_uninit(pool);
> +err_free:
> +       pr_warn("%s() gave up with errno %d\n", __func__, err);
> +       kfree(pool);
> +       return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(page_pool_create);
>
> @@ -829,6 +839,7 @@ static void __page_pool_destroy(struct page_pool *poo=
l)
>         if (pool->disconnect)
>                 pool->disconnect(pool);
>
> +       page_pool_unlist(pool);
>         page_pool_uninit(pool);
>         kfree(pool);
>  }
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> new file mode 100644
> index 000000000000..c17ea092b4ab
> --- /dev/null
> +++ b/net/core/page_pool_priv.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __PAGE_POOL_PRIV_H
> +#define __PAGE_POOL_PRIV_H
> +
> +int page_pool_list(struct page_pool *pool);
> +void page_pool_unlist(struct page_pool *pool);
> +
> +#endif
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> new file mode 100644
> index 000000000000..630d1eeecf2a
> --- /dev/null
> +++ b/net/core/page_pool_user.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mutex.h>
> +#include <linux/xarray.h>
> +#include <net/page_pool/types.h>
> +
> +#include "page_pool_priv.h"
> +
> +static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
> +static DEFINE_MUTEX(page_pools_lock);
> +
> +int page_pool_list(struct page_pool *pool)
> +{
> +       static u32 id_alloc_next;
> +       int err;
> +
> +       mutex_lock(&page_pools_lock);
> +       err =3D xa_alloc_cyclic(&page_pools, &pool->user.id, pool, xa_lim=
it_32b,
> +                             &id_alloc_next, GFP_KERNEL);
> +       if (err < 0)
> +               goto err_unlock;
> +
> +       mutex_unlock(&page_pools_lock);
> +       return 0;
> +
> +err_unlock:
> +       mutex_unlock(&page_pools_lock);
> +       return err;
> +}
> +
> +void page_pool_unlist(struct page_pool *pool)
> +{
> +       mutex_lock(&page_pools_lock);
> +       xa_erase(&page_pools, pool->user.id);
> +       mutex_unlock(&page_pools_lock);
> +}
> --
> 2.41.0
>


--=20
Thanks,
Mina

