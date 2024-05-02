Return-Path: <netdev+bounces-93080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AD8B9F7E
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FDF1C22041
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBC17107A;
	Thu,  2 May 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWnc30oH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0F16FF43
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670874; cv=none; b=aTAtHbT8Gm6hBX2Y9xAKcC6YBPeGOuld91znNCHoL+/y0/brskPK0hVJQIVYn2ZjCGmwE+lzjrfW/TOBlrS7vy8KLt9vb1opJeG+FPrfJEG5Iyfl5YZ7cHkUJLokO1KgYB1e/ja3Q54UPF7a0yIaKb/nthNcdvs21h38l4wm+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670874; c=relaxed/simple;
	bh=jay4G7cjrjrt7EHVlR33IA585zbfNms2q1822Ba0SE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlOmYUgfiO+G3KjBqon9Ml1vlbgyoLAMdwIFCXlAMWjB7rrwU8Aq1pTbIMbGsI05h/amVY12OGhr/TBdyGw8dC/n6ZA15NMh9MenWo+5z/yYhTt0TriHKqFMAPK38w1Q3hVaRfw6AFl72oecdnSPYfxadCzDtASRIaAWlCZ37ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWnc30oH; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479ffac091dso2353921137.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714670871; x=1715275671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sQ8vpCjGZxB3Jot2X1o/iv7e2VhhTVF/FBtkCZAsU8=;
        b=AWnc30oHr+k44SGLGZ0yHqxNxGzGYheOwFA8YErgSueMkD5pldqhHxE82Y3D1TNTxk
         qSwxVGJqXyv0nCx0O79CRNgaG8rKVKFEzKci2uf0r1lzgaH7QsgPf92L45a4rSn2vxlE
         rTzoandpKOAjIfmCUoswLenEqLhu08V89i/3n8ujpP+9hd8JpAdTrCpoKErAE1h7nxDZ
         1fIOkX5j0pKlzQQz1UcvBUrgfDKj2Nk++R82GZHIsxpF19S+XAEInJKyS/S0bxMl3y5n
         O5mvwIJBmcEm6WxnLGu1tS1PA3VHL5/3TrqRXVHbh5HppTx7FJs3LcWFBzl7V44kjt3E
         vPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670871; x=1715275671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sQ8vpCjGZxB3Jot2X1o/iv7e2VhhTVF/FBtkCZAsU8=;
        b=H4XPPewwbTVsTqBaSC8GuhXIxY1Jw5hzyAI8uWxCwCJXqE98TKkAFw4R77fOZu9bAM
         hWdZC8pPKldrCxml3duykNN0XJuPIE45elv+0t3YR+mheF6FCP6n2xPbrBMiHYhLh6aS
         dDa+HBIVTEvnvGNjtmDY0pJZ6S6ktTg0MfySh7G8ht9oyTH1GZ8diNg7wDba85vqITnn
         gwp6gDGwt+ubpODO8/AFIZhXwYsXZCdSnGYAEmEhsbqXYvjYmaXCsVNfTtL5d5XjkDrM
         sNL/LDdX6fQzKHj3ARIUxwrxn4HfKbBL6RpIdxvVCfu10ge65e/R8yBiLlaZlV4c9xra
         LL5w==
X-Gm-Message-State: AOJu0Yxysa3pX+CRBf9HLUIDneEsEPrKUGuo1Geg2pFWZ5PPQenqX3NW
	1sHgiIcRIXYEv/9LhHSbRPMgxNkmBouOz0VAgrh4hNw15wRvFFTH2+UP33yEsSehJIVpr7vybCP
	5OoNjVuonVi2z1z77OJjQgvLubol0uD61Frc9
X-Google-Smtp-Source: AGHT+IELwv5L6G44k9UCwFmB+9veK1ltICURPyb+222cgHIFq4bIjW3RhYJbH/aqsjTf42/i5H9IVZHlqXhIDuD0ncg=
X-Received: by 2002:a05:6102:80a:b0:47c:e94:50aa with SMTP id
 g10-20020a056102080a00b0047c0e9450aamr366396vsb.18.1714670871149; Thu, 02 May
 2024 10:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502045410.3524155-1-dw@davidwei.uk> <20240502045410.3524155-4-dw@davidwei.uk>
In-Reply-To: <20240502045410.3524155-4-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 10:27:37 -0700
Message-ID: <CAHS8izOALLb+g7CiGt0MRHOG-GZv16eDNZJSD-JQcm7FK3rGrw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Adrian Alvarado <adrian.alvarado@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 9:54=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
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

The function looks good to me. It's very similar to what we are doing with =
GVE.

> +EXPORT_SYMBOL_GPL(netdev_rx_queue_restart);

I would still prefer not to export this, unless necessary, and it
seems it's not at the moment (we only need to call it from core net
and core io uring which doesn't need an export).

Unexporting later, as far as my primitive understanding goes, is maybe
tricky because it may break out of tree drivers that decided to call
this. I don't feel strongly about unexporting, but someone else may.

--=20
Thanks,
Mina

