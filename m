Return-Path: <netdev+bounces-235364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B941C2F4E4
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D65189CF2A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9422609D6;
	Tue,  4 Nov 2025 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsjFatOO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONNY8aAs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93018FDDE
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230799; cv=none; b=df+8NDjDj2sBMTZfh6DBO+A1ODFMbIDFpqSjzJ07Hc4+ztu97FfxN7OD3Kj+U8Gmh5/JxGI0vbgsbMVOTlSrgML+aY3SG1H344EV9sXRRvGhiQBbAMV38qNFvqyWPO+rRnhLwWDlff4ghvpieYgTLG4a4QOHa9GYma0AyDsOqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230799; c=relaxed/simple;
	bh=vE9KEonwANcOujfunwVmlyDZ1GfQBc7//BWjT3cXuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMmbXZHqBWYANvCBvkR9uii74+LQwwD8gJgg0dYyW4CryriwSyfqFLqumM4pjPJucz1Y7eQy5XmajipqZbsA7hJwNnZft4yQTyL6SJ6bCQBih1t79YO8xkc/DZJVQRne0GVCEyqbYjgo3aBhaDA5KYMNa8u30/ATZTWFtqbYXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsjFatOO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONNY8aAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiG51rXuLmyG8LWhp52Z/M1rfzevCJpa9Kp7AkZe9O4=;
	b=fsjFatOOzJz6sEsT2o7o/WQLxSlcR/Uulc2LLyyvyA055ZqIiezuCeC/WFQry9nh8Fk8GB
	689iaEJNapW7DTQwquv19yDV2su7SXnrDrEDgQyMoH9N1IHIsIlK69lTsGccGZLLg3zfl4
	VB0IbSEuxXCLCUiEigH6K485qzZq0Ao=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-BEkWJBqmPASfXxGq22wxgw-1; Mon, 03 Nov 2025 23:33:15 -0500
X-MC-Unique: BEkWJBqmPASfXxGq22wxgw-1
X-Mimecast-MFC-AGG-ID: BEkWJBqmPASfXxGq22wxgw_1762230794
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341661973daso1021486a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 20:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762230794; x=1762835594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiG51rXuLmyG8LWhp52Z/M1rfzevCJpa9Kp7AkZe9O4=;
        b=ONNY8aAscqxqGzwYxAxilem8VfN989pB1xxG8CY1DMBbzR9t3X2JClSZE/sQivf+Xd
         jwf7QlGBxDJ6UOatGJimhS9fReV3fSn29zHbWUSgFgZLfVFBsuMyphjXTHSOFBa4Euy6
         opxgmGeNV18bkfFLncYqc54FpLgeIJI5iqHm1v2egPC5cMDPHmVguINtaHU2UfQ3R2Kq
         wjlj4mx89Si7NkAsGOM6b98g6Gz+4ZK/L/NchTu6+pplonrbjxokm+YvqPhE/T7K23pE
         Rnk2tsoLAAoujdF1yd095ojBZur/D9LWrf7IUlcVO8DSASBOqJlcNOkzt+1ReL4fJLfN
         tosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230794; x=1762835594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiG51rXuLmyG8LWhp52Z/M1rfzevCJpa9Kp7AkZe9O4=;
        b=jQTsnkS5vaFh2uWbrZjMxeogk35lIjKPwQRAwFIRhvn4+rhK3eXh02wIrAr3h+MGpK
         DlMDDP2uC3cmUHuaLw+37LQboSOY2v5zBsYs51R2qdSTp2JkuqxfnaaPzd8dqTfhxgfr
         KHwTpHsVU4x4r07PngAQt7w7EAQu6U2LVeGVdZ9m0sXV+cbhQz/l2fL5/H7A8DK6+gxY
         dg9k+3qdkTqN6rqq/YdXw0WBhYGjZ8yJniFktI/OGF8cmK9r4Ms8jvJyBKQWX3nm7Gdx
         kCNqMuiTPOXesttgtEebV02O4TNhT8h6u+Mo3V1XY+SwtELFhMrOWccRwJm4Yqp6Ry0C
         S0xA==
X-Gm-Message-State: AOJu0YwzJAGnDLi1t8cY7H4QfN/nqlfbKFcZaNhzf7Bfb8v0M+ofHvsQ
	96gyGba1TjvSKeC2GA7SnV6duYn/AuredTy/tWkKxPyUcuLYqYrWfpjPgVf5CGvXlj+P+jpi64S
	HlieLHLPVzetP/glALsRb/UH5sLHDchDNeV3QnkJGzMZB9/0p1eD8+D2LIOi/A1q90i7OEY0Kep
	4i09Wu4hKQVyAtTlhIdsorPKfQjsfACXgh
X-Gm-Gg: ASbGncvbsQexVtYmReZNDntkRC+thFLkZeJy3Y2G9yvowRU9jS4JV6Is3EOXh8mV1cc
	O6SIOEgHEkWvMGmNFxss65rslUH7NYF0Q4q/DZv9Iro5gTuFF5o5Tj6Oguvr7YTw6mn93F0gA4J
	8bHQ8SC8lLldmCouJX0bhoFTZpJG/aIOxC/gVDhxpc3BXFbRD0Ui9FsYZ4
X-Received: by 2002:a17:90b:288f:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-34083055c46mr18888089a91.23.1762230794144;
        Mon, 03 Nov 2025 20:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJW09FJf6ZdAh9/nOFZPHtjYHSxEwk+JTA6Diybi4bptHFdsqJPCrVRooz78OZUmdONQyV1kajOu7/H8I4sGQ=
X-Received: by 2002:a17:90b:288f:b0:33b:b078:d6d3 with SMTP id
 98e67ed59e1d1-34083055c46mr18888056a91.23.1762230793728; Mon, 03 Nov 2025
 20:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-6-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-6-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:33:02 +0800
X-Gm-Features: AWmQ_blDvcYVW-zNs1zaTZY7ahVNF3tIMy2IOnLQk11qZPp1YwmGbJdhjSTajj8
Message-ID: <CACGkMEun2exfZEAwXCh1XHP-iQTTxcuBVtD9k5R9Zbkrrgsbfw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/12] virtio_net: Query and set flow filter caps
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> When probing a virtnet device, attempt to read the flow filter
> capabilities. In order to use the feature the caps must also
> be set. For now setting what was read is sufficient.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>
> ---
> v4:
>     - Validate the length in the selector caps
>     - Removed __free usage.
>     - Removed for(int.
> v5:
>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
> v6:
>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>     - Use new variable and validate ff_mask_size before set_cap. MST
> v7:
>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
> ---
>  drivers/net/virtio_net.c           | 185 +++++++++++++++++++++++++++++
>  include/linux/virtio_admin.h       |   1 +
>  include/uapi/linux/virtio_net_ff.h |  91 ++++++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..7d7390103b71 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,9 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <linux/virtio_admin.h>
> +#include <net/ipv6.h>
> +#include <net/ip.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -281,6 +284,14 @@ static const struct virtnet_stat_desc virtnet_stats_=
tx_speed_desc_qstat[] =3D {
>         VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_rat=
elimits),
>  };
>
> +struct virtnet_ff {
> +       struct virtio_device *vdev;
> +       bool ff_supported;
> +       struct virtio_net_ff_cap_data *ff_caps;
> +       struct virtio_net_ff_cap_mask_data *ff_mask;
> +       struct virtio_net_ff_actions *ff_actions;
> +};
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2
> @@ -493,6 +504,8 @@ struct virtnet_info {
>         struct failover *failover;
>
>         u64 device_stats_cap;
> +
> +       struct virtnet_ff ff;
>  };
>
>  struct padded_vnet_hdr {
> @@ -6758,6 +6771,167 @@ static const struct xdp_metadata_ops virtnet_xdp_=
metadata_ops =3D {
>         .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
>  };
>
> +static size_t get_mask_size(u16 type)
> +{
> +       switch (type) {
> +       case VIRTIO_NET_FF_MASK_TYPE_ETH:
> +               return sizeof(struct ethhdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +               return sizeof(struct iphdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV6:
> +               return sizeof(struct ipv6hdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_TCP:
> +               return sizeof(struct tcphdr);
> +       case VIRTIO_NET_FF_MASK_TYPE_UDP:
> +               return sizeof(struct udphdr);
> +       }
> +
> +       return 0;
> +}
> +
> +#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
> +
> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *=
vdev)
> +{
> +       size_t ff_mask_size =3D sizeof(struct virtio_net_ff_cap_mask_data=
) +
> +                             sizeof(struct virtio_net_ff_selector) *
> +                             VIRTIO_NET_FF_MASK_TYPE_MAX;
> +       struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
> +       struct virtio_net_ff_selector *sel;
> +       size_t real_ff_mask_size;
> +       int err;
> +       int i;
> +
> +       cap_id_list =3D kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
> +       if (!cap_id_list)
> +               return -ENOMEM;
> +
> +       err =3D virtio_admin_cap_id_list_query(vdev, cap_id_list);
> +       if (err)
> +               goto err_cap_list;
> +
> +       if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_RESOURCE_CAP) &&
> +             VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_SELECTOR_CAP) &&
> +             VIRTIO_CAP_IN_LIST(cap_id_list,
> +                                VIRTIO_NET_FF_ACTION_CAP))) {
> +               err =3D -EOPNOTSUPP;
> +               goto err_cap_list;
> +       }
> +
> +       ff->ff_caps =3D kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
> +       if (!ff->ff_caps)
> +               goto err_cap_list;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_RESOURCE_CAP,
> +                                  ff->ff_caps,
> +                                  sizeof(*ff->ff_caps));
> +
> +       if (err)
> +               goto err_ff;
> +
> +       /* VIRTIO_NET_FF_MASK_TYPE start at 1 */
> +       for (i =3D 1; i <=3D VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
> +               ff_mask_size +=3D get_mask_size(i);
> +
> +       ff->ff_mask =3D kzalloc(ff_mask_size, GFP_KERNEL);
> +       if (!ff->ff_mask)
> +               goto err_ff;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_SELECTOR_CAP,
> +                                  ff->ff_mask,
> +                                  ff_mask_size);
> +
> +       if (err)
> +               goto err_ff_mask;
> +
> +       ff->ff_actions =3D kzalloc(sizeof(*ff->ff_actions) +
> +                                       VIRTIO_NET_FF_ACTION_MAX,
> +                                       GFP_KERNEL);
> +       if (!ff->ff_actions)
> +               goto err_ff_mask;
> +
> +       err =3D virtio_admin_cap_get(vdev,
> +                                  VIRTIO_NET_FF_ACTION_CAP,
> +                                  ff->ff_actions,
> +                                  sizeof(*ff->ff_actions) + VIRTIO_NET_F=
F_ACTION_MAX);
> +
> +       if (err)
> +               goto err_ff_action;
> +
> +       err =3D virtio_admin_cap_set(vdev,
> +                                  VIRTIO_NET_FF_RESOURCE_CAP,
> +                                  ff->ff_caps,
> +                                  sizeof(*ff->ff_caps));
> +       if (err)
> +               goto err_ff_action;
> +
> +       real_ff_mask_size =3D sizeof(struct virtio_net_ff_cap_mask_data);
> +       sel =3D (void *)&ff->ff_mask->selectors[0];
> +
> +       for (i =3D 0; i < ff->ff_mask->count; i++) {
> +               if (sel->length > MAX_SEL_LEN) {
> +                       err =3D -EINVAL;
> +                       goto err_ff_action;
> +               }
> +               real_ff_mask_size +=3D sizeof(struct virtio_net_ff_select=
or) + sel->length;
> +               sel =3D (void *)sel + sizeof(*sel) + sel->length;
> +       }
> +
> +       if (real_ff_mask_size > ff_mask_size) {
> +               err =3D -EINVAL;
> +               goto err_ff_action;
> +       }
> +
> +       err =3D virtio_admin_cap_set(vdev,
> +                                  VIRTIO_NET_FF_SELECTOR_CAP,
> +                                  ff->ff_mask,
> +                                  ff_mask_size);

Should this be real_ff_mask_size?

Thanks


