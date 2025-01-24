Return-Path: <netdev+bounces-160851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E773A1BDB5
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B5616783B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7A1DB140;
	Fri, 24 Jan 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/ohFZl8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD51BFE10
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752440; cv=none; b=jS6xIlqgqyswFDSQDWd956o5BAo9N+fYfj8nvMHKe4ggB+TPjrYDE1f0qnTa7VFPwimOjIQwqzyu7xqAW6+SpouJOHLvUS3cLk5UjjMZPWVTY437cSrR64B2mWpjdsF3dR48YuaTvR0xffc/kUKxgueJpnoC1ZMU9YSBmDbPRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752440; c=relaxed/simple;
	bh=NvfHr00aSc6I0bmziBtJ7im3yipPykgOC0co9Z50OFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Ft41rCX8cWTAPJE0Z0ADiyaGBMvXjwpZZK8mhhiOgBd7Qn0wJUSnHVL3bkNG7n1U5ffgRmGBYhqL3v457Mk3NgVT0WlJDbF0rA2PjDLzA5A/11dUOdssa0Jm4DoVTqfrGv0Gw8wDtZygT2JIxGMMps4ztqpjzmlLns2PD0V0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/ohFZl8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215740b7fb8so34065ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737752437; x=1738357237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4RhiyWIlpgw424T2u9N5su0ja76zrTPD9zqkUmKKRE=;
        b=q/ohFZl8IagjNkbOkOzwulNaoVJqNG0zVbTFEIk+yPoM0pua8y6dhEAkupakDlEgWj
         SSJgPxD6HA5fCsaAOMbLdYuA2WHuQcYbAIIl8WgwnthPIahqpOKvrAQcVN8OALGhurv3
         ZIie5EP91/mUh5dK61X8P3rdwJkwGpz97Y35hdW1VcIzOasOXY9Hrkl7wI1rpJdDaroF
         WbDw9Abtx/jsqy2JvQ22d1wqllnY532e8ZPMMl61Euh8NGUKB7FK8/TCCFELxyND678v
         jS4opcCiTXmTl3AIf1+20OMCZZKjNHLSO5OCjwJMZ46f0qa4lgMdmQ1Qdb2ainmkuIHb
         6GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737752437; x=1738357237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4RhiyWIlpgw424T2u9N5su0ja76zrTPD9zqkUmKKRE=;
        b=uh8NJaRxyuD7Z+Jr5lnJBXxtApElXk94gpXnTY1vat/IM0PIVWUeU3CzDKhuDxyRDr
         UZm9/EIgv2o5yerVkw/JosOfOJHykoN0s2czr/aMA6cWrfYO8GuwO5VMBvu2POtmrJ3e
         6RKMaFSndzbNu65VHRISd9gcXzeF59oAaDWFNLFqTcAHv5r6CIytwnsOBD9JwItjx9zW
         6mxtPbhV4Rok+i0jov/ZVbCzgtiSWili1A7r/CKlKkuoZbANBUaoWAN2YXvl2tJKUXjh
         xVEsQtA3y3vdkWJIGW5ZWKtsE7bWjjnv946pHPYzrrjJGUBQ04F5mlfxr1ha9wjcXbQb
         XVQg==
X-Forwarded-Encrypted: i=1; AJvYcCWA3dMAk1sTukMIEp5xcgMiLSg59OybcaLl24BeKRXdoCt39YKulJRtD1GrzDN0W6i0sla3Rys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rEe41x8jdRZkz51LG0SLfbfWwLaz1kmOPXvhajTnRom/3pdy
	G9jpZm4E6KFlSZda34cEbSBksa5cdOOReQEiYL2OeSP3OWi3S9u+UdqMdWPq9LS6ThOG2OxTgXs
	UlhSMGdMASiNRRNHDHk7+hhDDyzmnZyJ8xzrp
X-Gm-Gg: ASbGnctCGugSjSqPOC+lZn3r9qilGp7cKLE58qQEuBZLjndWnVUYP0gWCDDvAJN+dhd
	8R8xmk8ZRVamxXqjayPW6DDatnTqlCgYnGHL4cW60/l2ShlA+MiFkKxQFEEsqIGpswuQaIMHFA3
	Vw1YTMul3zM/VhZiyj
X-Google-Smtp-Source: AGHT+IFsqKhQ7vF1hLCIyXxXTaVjpE246ch3/P3mJ5X7+uLwbHjv4whrt3otT4GHPlnN9hA/6ss9yNC7E2Edex0j2PQ=
X-Received: by 2002:a17:902:eb83:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-21daf41d424mr354945ad.15.1737752437233; Fri, 24 Jan 2025
 13:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123231620.1086401-1-kuba@kernel.org>
In-Reply-To: <20250123231620.1086401-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jan 2025 13:00:24 -0800
X-Gm-Features: AWEUYZkmC9h0u1WGaFlnF2_uiVRDVKtFf48DmsMdYapzJhQYStrY65J_VCoRBLM
Message-ID: <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Page ppol tried to cache the NAPI ID in page pool info to avoid

Page pool

> having a dependency on the life cycle of the NAPI instance.
> Since commit under Fixes the NAPI ID is not populated until
> napi_enable() and there's a good chance that page pool is
> created before NAPI gets enabled.
>
> Protect the NAPI pointer with the existing page pool mutex,
> the reading path already holds it. napi_id itself we need

The reading paths in page_pool.c don't hold the lock, no? Only the
reading paths in page_pool_user.c seem to do.

I could not immediately wrap my head around why pool->p.napi can be
accessed in page_pool_napi_local with no lock, but needs to be
protected in the code in page_pool_user.c. It seems
READ_ONCE/WRITE_ONCE protection is good enough to make sure
page_pool_napi_local doesn't race with
page_pool_disable_direct_recycling in a way that can crash (the
reading code either sees a valid pointer or NULL). Why is that not
good enough to also synchronize the accesses between
page_pool_disable_direct_recycling and page_pool_nl_fill? I.e., drop
the locking?

Is there some guarantee the napi won't change/get freed while
page_pool_local is running, but can change while page_pool_nl_fill is
running?

> to READ_ONCE(), it's protected by netdev_lock() which are
> not holding in page pool.
>
> Before this patch napi IDs were missing for mlx5:
>
>  # ./cli.py --spec netlink/specs/netdev.yaml --dump page-pool-get
>
>  [{'id': 144, 'ifindex': 2, 'inflight': 3072, 'inflight-mem': 12582912},
>   {'id': 143, 'ifindex': 2, 'inflight': 5568, 'inflight-mem': 22806528},
>   {'id': 142, 'ifindex': 2, 'inflight': 5120, 'inflight-mem': 20971520},
>   {'id': 141, 'ifindex': 2, 'inflight': 4992, 'inflight-mem': 20447232},
>   ...
>
> After:
>
>  [{'id': 144, 'ifindex': 2, 'inflight': 3072, 'inflight-mem': 12582912,
>    'napi-id': 565},
>   {'id': 143, 'ifindex': 2, 'inflight': 4224, 'inflight-mem': 17301504,
>    'napi-id': 525},
>   {'id': 142, 'ifindex': 2, 'inflight': 4288, 'inflight-mem': 17563648,
>    'napi-id': 524},
>   ...
>
> Fixes: 86e25f40aa1e ("net: napi: Add napi_config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: asml.silence@gmail.com
> CC: almasrymina@google.com
> CC: kaiyuanz@google.com
> CC: willemb@google.com
> CC: mkarsten@uwaterloo.ca
> CC: jdamato@fastly.com
> ---
>  include/net/page_pool/types.h |  1 -
>  net/core/page_pool_priv.h     |  2 ++
>  net/core/dev.c                |  2 +-
>  net/core/page_pool.c          |  2 ++
>  net/core/page_pool_user.c     | 15 +++++++++------
>  5 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index ed4cd114180a..7f405672b089 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -237,7 +237,6 @@ struct page_pool {
>         struct {
>                 struct hlist_node list;
>                 u64 detach_time;
> -               u32 napi_id;
>                 u32 id;
>         } user;
>  };
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index 57439787b9c2..2fb06d5f6d55 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -7,6 +7,8 @@
>
>  #include "netmem_priv.h"
>
> +extern struct mutex page_pools_lock;
> +
>  s32 page_pool_inflight(const struct page_pool *pool, bool strict);
>
>  int page_pool_list(struct page_pool *pool);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index afa2282f2604..07b2bb1ce64f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6708,7 +6708,7 @@ void napi_resume_irqs(unsigned int napi_id)
>  static void __napi_hash_add_with_id(struct napi_struct *napi,
>                                     unsigned int napi_id)
>  {
> -       napi->napi_id =3D napi_id;
> +       WRITE_ONCE(napi->napi_id, napi_id);
>         hlist_add_head_rcu(&napi->napi_hash_node,
>                            &napi_hash[napi->napi_id % HASH_SIZE(napi_hash=
)]);
>  }
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3de752c5178..ed0f89373259 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1147,7 +1147,9 @@ void page_pool_disable_direct_recycling(struct page=
_pool *pool)
>         WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
>         WARN_ON(READ_ONCE(pool->p.napi->list_owner) !=3D -1);
>
> +       mutex_lock(&page_pools_lock);
>         WRITE_ONCE(pool->p.napi, NULL);
> +       mutex_unlock(&page_pools_lock);
>  }
>  EXPORT_SYMBOL(page_pool_disable_direct_recycling);
>
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index 48335766c1bf..6677e0c2e256 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -3,6 +3,7 @@
>  #include <linux/mutex.h>
>  #include <linux/netdevice.h>
>  #include <linux/xarray.h>
> +#include <net/busy_poll.h>
>  #include <net/net_debug.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
> @@ -14,10 +15,11 @@
>  #include "netdev-genl-gen.h"
>
>  static DEFINE_XARRAY_FLAGS(page_pools, XA_FLAGS_ALLOC1);
> -/* Protects: page_pools, netdevice->page_pools, pool->slow.netdev, pool-=
>user.
> +/* Protects: page_pools, netdevice->page_pools, pool->p.napi, pool->slow=
.netdev,
> + *     pool->user.
>   * Ordering: inside rtnl_lock
>   */
> -static DEFINE_MUTEX(page_pools_lock);
> +DEFINE_MUTEX(page_pools_lock);
>
>  /* Page pools are only reachable from user space (via netlink) if they a=
re
>   * linked to a netdev at creation time. Following page pool "visibility"
> @@ -216,6 +218,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct p=
age_pool *pool,
>  {
>         struct net_devmem_dmabuf_binding *binding =3D pool->mp_priv;
>         size_t inflight, refsz;
> +       unsigned int napi_id;
>         void *hdr;
>
>         hdr =3D genlmsg_iput(rsp, info);
> @@ -229,8 +232,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct =
page_pool *pool,
>             nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
>                         pool->slow.netdev->ifindex))
>                 goto err_cancel;
> -       if (pool->user.napi_id &&
> -           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, pool->user.napi=
_id))
> +
> +       napi_id =3D pool->p.napi ? READ_ONCE(pool->p.napi->napi_id) : 0;

Flowing up on above, I wonder if this can be similar to the code in
page_pool_napi_local to work without the mutex protection:

napi =3D READ_ONCE(pool->p.napi);
if (napi)
   napi_id =3D READ_ONCE(napi->napi_id);

> +       if (napi_id >=3D MIN_NAPI_ID &&

I think this check is added to filter out 0? Nit: I would check for 0
here, since any non zero napi_id should come from the napi->napi_id,
which should be valid, but not a necessary change.

> +           nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
>                 goto err_cancel;
>
>         inflight =3D page_pool_inflight(pool, false);
> @@ -319,8 +324,6 @@ int page_pool_list(struct page_pool *pool)
>         if (pool->slow.netdev) {
>                 hlist_add_head(&pool->user.list,
>                                &pool->slow.netdev->page_pools);
> -               pool->user.napi_id =3D pool->p.napi ? pool->p.napi->napi_=
id : 0;
> -
>                 netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_ADD_=
NTF);
>         }
>
> --
> 2.48.1
>

--=20
Thanks,
Mina

