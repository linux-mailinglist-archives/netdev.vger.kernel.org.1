Return-Path: <netdev+bounces-92587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DF8B7F93
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD5D285A9D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532991836EE;
	Tue, 30 Apr 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TjF96+d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700181836EB
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500935; cv=none; b=iomfFVrrbMP9oi9Pufi8onsy1yhpnwkxoGI22ChplYOl+bSIfqoN0T6SKclH0bLoJleqE6GOwGgNLxmdQu7icva1GFVyUHXePguqRT5zMwjPjA3lHm06YCWp46CpIzQjLjgfjMtwULdHe2sR8aX4mdSBD6Nit40hl78rtP4jcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500935; c=relaxed/simple;
	bh=DPQMGdW46tciX3zutyIX+/03zTEjMY32xEED2p2Jrxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCiMjgnzqlpLrBIboBh6HSXz6V2H/6erHQmvfNfWM+NsrD5tw+kaDwEsiZhNrPPh0ntyCvY97Ixyj9BiWgPdXsKVriSqk4tTAssiBZr1RpXy9JFLXxRPC5INg8XgZ5tRW2jjWeMRrHWsZp2R298Z0x2tBnYC6iCinkb0g3aKTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TjF96+d; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51e75e7a276so860452e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714500931; x=1715105731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZGTcc+Fk67btXbMLIKmHmRTmR7PGgPP2K0p/VnexNk=;
        b=0TjF96+d6xblok7XboVjfVZS4VhxH934hYpq7Vg2IUMha4XMyAVmrkOwsboOQUOX6R
         OkoQ2efmmhZWOxVTOKWrOFP3u4MAp/K7HfszI4q1LwXiWos6ad21KKjFIjdAvr/kmyOJ
         mfX5v8ykHQZ58h8umYBptj7t0rLqSREm+iU6L4XiOOkC/quS49GMEg4Ji45JWtlVp2+y
         tXBN2hBrIk1zs8JlV1PJEt9/QGgFtNjdnSXHp0XWSLZnNsKJttpvDJPepdeSDmqjUEj+
         7zV8L1KMTBfIC7JbWQX1y98w4ra+5y/IwohrcNHi+pZauUn/irf7LgttTacvz+/LMA0V
         F/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500931; x=1715105731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZGTcc+Fk67btXbMLIKmHmRTmR7PGgPP2K0p/VnexNk=;
        b=apiYyTjE8xtCHgJyRilD6Br86SbwqVcaRDlcG1n12ILUS/7LDFIgvEi01eusULqb34
         SGkCluvq0nsjJyozgnm6uR71ilni2Fh3CDFg0/F81k8rqKjkC0jGf9rccFwGQmy0smW6
         veUbSeYayGy81XWvqISxtnUfI7sq9GSpHxqGmDxOFNptEZu8dO3J7hf091k/uyjwXDxT
         Wj8re3WlLzjctcSqCMmKuxIHJg6SMgYw9fdoL3SLCY0imBiBPxJKzNUj4wA1suWFokqe
         pFnIGyjo5skLSYm0HTMvaSka9qDmE99QElk+Sag+xrhQLsyF5zvHQZRrWlc1ofpOH/Is
         DOUg==
X-Gm-Message-State: AOJu0Yyuess0aKSsdQIMbkPEe96IF8MgiqVsSvqrHJhNwViscA5IBq50
	vijYCiQnttgVSoIjohBhIoCJ9ab21SD6DLW5Xrw1mdTRaorwm9H5hom1MNrd0dCBvFqLMxSzdgf
	6INpfiu+wXaj1uhAhyi7qIVrXpVnyzwfiLbcO
X-Google-Smtp-Source: AGHT+IGsb6mcZ4xNyP+iLLUorBwTEwrWtUOv9a9rzxd/MB+FAxYmk1gmd4QAxZVWWKGbuQEVd8jhER7KnfOCpR+zHy8=
X-Received: by 2002:ac2:5209:0:b0:51d:78b8:dfad with SMTP id
 a9-20020ac25209000000b0051d78b8dfadmr155274lfl.20.1714500931141; Tue, 30 Apr
 2024 11:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010732.666512-1-dw@davidwei.uk> <20240430010732.666512-4-dw@davidwei.uk>
In-Reply-To: <20240430010732.666512-4-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Apr 2024 11:15:19 -0700
Message-ID: <CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add netdev_rx_queue_restart()
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 6:07=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Mina Almasry <almasrymina@google.com>
>
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
> taken from Mina's work in [1] with a slight modification of taking
> rtnl_lock() during the queue stop and start ops.
>
> For bnxt specifically, if the firmware doesn't support
> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
> attempt to reset the whole device.
>
> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasr=
ymina@google.com/#t
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/net/netdev_rx_queue.h |  3 ++
>  net/core/Makefile             |  1 +
>  net/core/netdev_rx_queue.c    | 58 +++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 net/core/netdev_rx_queue.c
>
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.=
h
> index aa1716fb0e53..e78ca52d67fb 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue=
)
>         return index;
>  }
>  #endif
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +
>  #endif
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 21d6fbc7e884..f2aa63c167a3 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) +=3D dev_addr_lists=
_test.o
>
>  obj-y +=3D net-sysfs.o
>  obj-y +=3D hotdata.o
> +obj-y +=3D netdev_rx_queue.o
>  obj-$(CONFIG_PAGE_POOL) +=3D page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) +=3D net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) +=3D pktgen.o
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> new file mode 100644
> index 000000000000..9633fb36f6d1
> --- /dev/null
> +++ b/net/core/netdev_rx_queue.c
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/netdevice.h>
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq)
> +{
> +       void *new_mem;
> +       void *old_mem;
> +       int err;
> +
> +       if (!dev->queue_mgmt_ops->ndo_queue_stop ||
> +           !dev->queue_mgmt_ops->ndo_queue_mem_free ||
> +           !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
> +           !dev->queue_mgmt_ops->ndo_queue_start)
> +               return -EOPNOTSUPP;
> +
> +       new_mem =3D dev->queue_mgmt_ops->ndo_queue_mem_alloc(dev, rxq);
> +       if (!new_mem)
> +               return -ENOMEM;
> +
> +       rtnl_lock();

FWIW in my case this function is called from a netlink API which
already has rtnl_lock, so maybe a check of rtnl_is_locked is good here
rather than a relock.

> +       err =3D dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq, &old_mem);
> +       if (err)
> +               goto err_free_new_mem;
> +
> +       err =3D dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, new_mem);
> +       if (err)
> +               goto err_start_queue;
> +       rtnl_unlock();
> +
> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
> +
> +       return 0;
> +
> +err_start_queue:
> +       /* Restarting the queue with old_mem should be successful as we h=
aven't
> +        * changed any of the queue configuration, and there is not much =
we can
> +        * do to recover from a failure here.
> +        *
> +        * WARN if the we fail to recover the old rx queue, and at least =
free
> +        * old_mem so we don't also leak that.
> +        */
> +       if (dev->queue_mgmt_ops->ndo_queue_start(dev, rxq, old_mem)) {
> +               WARN(1,
> +                    "Failed to restart old queue in error path. RX queue=
 %d may be unhealthy.",
> +                    rxq);
> +               dev->queue_mgmt_ops->ndo_queue_mem_free(dev, &old_mem);
> +       }
> +
> +err_free_new_mem:
> +       dev->queue_mgmt_ops->ndo_queue_mem_free(dev, new_mem);
> +       rtnl_unlock();
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);

Does stuff outside of core need this? I don't think so, right? I think
you can drop EXPORT_SYMBOL_GPL.

At that point the compiler may complain about an unused function, I
think, so maybe  __attribute__((unused)) would help there.

I also think it's fine for this patch series to only add the ndos and
to leave it to the devmem series to introduce this function, but I'm
fine either way.

--=20
Thanks,
Mina

