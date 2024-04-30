Return-Path: <netdev+bounces-92572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A18B7F5B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072A1280944
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AF18131F;
	Tue, 30 Apr 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuVcRjZb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D8180A78
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500031; cv=none; b=ON/AJdBv7+HGQoMf5m8jheI5WySBHOBjWe+5Bvp+NkyuX/Y6M0ArAszP8F4Dxr6ShX7XgPYXwyWTbrUunUK47+dVOyxiX5JO/DgAdGbyUZdfLOZNcn8YJDQ9fCVJqSlwpRFPZ6WIB6yJav8kdWXHlZesbtu6KgyfwjkwY3w7hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500031; c=relaxed/simple;
	bh=PKaXLqdcBYP1obljpBn3Qupzi/3+nQDBTiB2dTs9cGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXPHJwE1hnxIqMG5/Fq5EzhU/RgD0CTo2xdSuEDx8ALfv/RrM7MPwerVHq9Fm8ux0sG5Yh9jSbBY2D4tTMe6aBHYyx5wvAyldlGGhFzfNHkP3hq57VGYLw6gQrMl1V3oCg/zK0WnLNZC/50DKmday1hDB6t0DFPgpEQgwfJcaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuVcRjZb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso340860266b.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714500028; x=1715104828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F97KQ0WjwytfWefmKMXLDQVE4HjRWZjWl16VJz+CF4E=;
        b=XuVcRjZbNH8x9Bn6GO0fVBsySFI1MTYeSPbu5d6Y+vGqDnR0B0wzpLUSAe3jh4YY+0
         Z3/ql/rJUlI3uw+9p6w4fUPPB0dlJ/51hHwnQDnCwt7PxvO+1JS7paDi1b+4qvZoXAxy
         GselEq9dk4LldeiAZDWU/Vuv+Jmla5uoAkIUpFB45phWesSXivmD4RGu2cxJtAwof30B
         hJh0Mr7n9Ivhp1kHdO/CROK8YSUIjnDVFjn/1KwsRIc1KGHDCHx4cOW6uhUTPaa6ftRy
         2W40WgDYUnYUKea+YtOdkrUQldZtPYFtx3k3jA7an8+5rBP3QUnAote1+UvXAx6zeQhs
         LLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500028; x=1715104828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F97KQ0WjwytfWefmKMXLDQVE4HjRWZjWl16VJz+CF4E=;
        b=HmNIMEBta9IceEeRZSfPE7v8mxtj+xtmaYuCaOXUTECY2GXfU2obrbLbkV9u0O1M4z
         UL9I38PTF7zd5uDNKy5LTuKVNQigicSnj6xxeScBeItJPEp/hG3hh05zGYuvUyffKb2B
         28udUi3XKXHVJyxw45oShY7LnR0cV15pw60S/il9U5sifVHnN6GtL2ZI4j38WpCborY3
         /YkCGqGiawvdb1ttLAq3ERjr/GBOeeoJ/x84DhLsyBqspXFFPkrChuV2VvVqzawcP2+6
         FgYKcGTNyzlxBhuHuGCV9fzeNkcxBBSOT5nQ3xQfeo/sWVJb5uN4l4kYiybTvQTEXkJZ
         W3FQ==
X-Gm-Message-State: AOJu0YwJeEVWNVr1pTp9v4uw8k1SLgX7fKnnGe481eywOktecCLlfJni
	ubXTiX6bA+m3BAvCn6ldJywTjNlZKV3EDQmvWLm+U8QX4sQDy5KstAbIjrRBDdxB5R2+irqMX2M
	d0v2YZ6+KhL1EuXF0tQODi/rcjfe5S2jxhCE8
X-Google-Smtp-Source: AGHT+IHY0aOzpUqnDyZz9tS1/uC7KDfd2agzRHVysNMA4BSpjUo/l8sMWHaqC9NKVpu4x3F7NeYO25tSpxzvc+rJ5zs=
X-Received: by 2002:a17:906:4714:b0:a58:873a:6bde with SMTP id
 y20-20020a170906471400b00a58873a6bdemr330953ejq.44.1714500027993; Tue, 30 Apr
 2024 11:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010732.666512-1-dw@davidwei.uk> <20240430010732.666512-2-dw@davidwei.uk>
In-Reply-To: <20240430010732.666512-2-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Apr 2024 11:00:15 -0700
Message-ID: <CAHS8izOsZ+nWBRNGgWvT46GsX6BC+bWPkpQgRCb8WY-Bi26SZA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/3] queue_api: define queue api
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
> This API enables the net stack to reset the queues used for devmem TCP.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/linux/netdevice.h   |  3 +++
>  include/net/netdev_queues.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f849e7d110ed..6a58ec73c5e8 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1957,6 +1957,7 @@ enum netdev_reg_state {
>   *     @sysfs_rx_queue_group:  Space for optional per-rx queue attribute=
s
>   *     @rtnl_link_ops: Rtnl_link_ops
>   *     @stat_ops:      Optional ops for queue-aware statistics
> + *     @queue_mgmt_ops:        Optional ops for queue management
>   *
>   *     @gso_max_size:  Maximum size of generic segmentation offload
>   *     @tso_max_size:  Device (as in HW) limit on the max TSO request si=
ze
> @@ -2340,6 +2341,8 @@ struct net_device {
>
>         const struct netdev_stat_ops *stat_ops;
>
> +       const struct netdev_queue_mgmt_ops *queue_mgmt_ops;
> +
>         /* for setting kernel sock attribute on TCP connection setup */
>  #define GSO_MAX_SEGS           65535u
>  #define GSO_LEGACY_MAX_SIZE    65536u
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 1ec408585373..337df0860ae6 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -60,6 +60,33 @@ struct netdev_stat_ops {
>                                struct netdev_queue_stats_tx *tx);
>  };
>
> +/**
> + * struct netdev_queue_mgmt_ops - netdev ops for queue management
> + *
> + * @ndo_queue_mem_alloc: Allocate memory for an RX queue. The memory ret=
urned
> + *                      in the form of a void* can be passed to
> + *                      ndo_queue_mem_free() for freeing or to ndo_queue=
_start
> + *                      to create an RX queue with this memory.
> + *
> + * @ndo_queue_mem_free:        Free memory from an RX queue.
> + *
> + * @ndo_queue_start:   Start an RX queue at the specified index.
> + *
> + * @ndo_queue_stop:    Stop the RX queue at the specified index.
> + */
> +struct netdev_queue_mgmt_ops {
> +       void *                  (*ndo_queue_mem_alloc)(struct net_device =
*dev,
> +                                                      int idx);
> +       void                    (*ndo_queue_mem_free)(struct net_device *=
dev,
> +                                                     void *queue_mem);
> +       int                     (*ndo_queue_start)(struct net_device *dev=
,
> +                                                  int idx,
> +                                                  void *queue_mem);
> +       int                     (*ndo_queue_stop)(struct net_device *dev,
> +                                                 int idx,
> +                                                 void **out_queue_mem);
> +};

Sorry, I think we raced a bit, we updated our interface definition
based on your/Jakub's feedback to expose the size of the struct for
core to allocate, so it looks like this for us now:

+struct netdev_queue_mgmt_ops {
+       size_t                  ndo_queue_mem_size;
+       int                     (*ndo_queue_mem_alloc)(struct net_device *d=
ev,
+                                                      void *per_queue_mem,
+                                                      int idx);
+       void                    (*ndo_queue_mem_free)(struct net_device *de=
v,
+                                                     void *per_queue_mem);
+       int                     (*ndo_queue_start)(struct net_device *dev,
+                                                  void *per_queue_mem,
+                                                  int idx);
+       int                     (*ndo_queue_stop)(struct net_device *dev,
+                                                 void *per_queue_mem,
+                                                 int idx);
+};
+

The idea is that ndo_queue_mem_size is the size of the memory
per_queue_mem points to.

The rest of the functions are slightly modified to allow core to
allocate the memory and pass in the pointer for the driver to fill
in/us. I think Shailend is close to posting the patches, let us know
if you see any issues.

--=20
Thanks,
Mina

