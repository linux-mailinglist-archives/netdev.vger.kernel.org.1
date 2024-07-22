Return-Path: <netdev+bounces-112367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D0938A04
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8981F2180E
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E101B977;
	Mon, 22 Jul 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J03Bh/ve"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5D18AF9
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633281; cv=none; b=B1gqDlPkb25ZUNjrBKY8imMYoNVvZ4GdmOaIRYrEWTd/86aNWB/7yCs/I+Eo/6PwUt49ZWYWDgrdLnT0yc8T66oxcIS/DvjIv11JL4Q7YC1ip4eRB2NdBdLayYYwpn1RL0nm96g95axncfO25Oq+K/GTbAV/i9GKEOV+5eqBw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633281; c=relaxed/simple;
	bh=Nm/iP+Ef8w5C1p1oN7/SGXtY7xU8KLhZVOqrCxwRuHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKZStlLqUHsHtKvRK4H+fTirfl2sJ9xf31br3m6xkdPPSLWl3ZwPa6m3XqDa7uAWOIrT7jb4I71J3bVOtuolpo+EIrbSfTVH2OBSo9hAqK4WglODXOW0arQ/yvDJ2aor7ugp4d1SYEznq84iECJKu20RYXzIT7YME7W9Edg3VGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J03Bh/ve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
	b=J03Bh/veIK7PW9otfrbARIh2V1ijXM7ug2umUkuUT2pI2lX6OyWzJjp00ctkWFp8oOddBu
	3wV/DD1RlgHReUZ7W1TyTOOzUyNqeo1Ayv6usthtftL/2Izem9rDm1H/gzzTcYsaHmlp3g
	wTRWuRZHtldwUgCzwPDF61AU2pcs5SE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-zAXuhv3rPYKhiBoO07vuQw-1; Mon, 22 Jul 2024 03:27:57 -0400
X-MC-Unique: zAXuhv3rPYKhiBoO07vuQw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso3317778a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 00:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633274; x=1722238074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
        b=vAjp1B8kjWcb6EF1jnMf1i31YmI1Tm4/v5tH6kDtZTSbu9cHxIvPmuuT1w3AvqTRSy
         VDNw5Af+ZOpAIMhuzzSizxPvAFwqZCkGRM7lNvziFrHENBLvoeJKbFVWDsEvIjOYn9M9
         2Du9SE0lvsZ/mceG8qTUi76W8jJSB9w0SgI0r/vrI5dUV/+i+oysxnobFzgkIWpMIKOq
         ArsyTqDMV7dL5U92D3UKRFukg3z2QK5R239Lir4C8hQhw/cFojcqNKA9GZgWzKmBv9oe
         iIUnkzg8VBalrDUfUiEf5MaO8RIb8AsB3I+oDV+PttzXv3UDwUT9JOa8j57ihEs/jBt4
         oV5Q==
X-Gm-Message-State: AOJu0YwR9U151C2p8WZ1SQzv0N04QQcrVsKErohtJK8Iu5enbd9mmHSw
	gjBcbN37F/ltI8PNauapnJDfROPveBeQyXDyTlK/BQ5UZMwzpCmcsCpo9tDi++bdz+h45zk/sfH
	wM1DtKlUj4/ICgeLZ1bHBnVu2YAWA94ggwsQo2a1XhrxtozCgWSTgxJerYwGmMy1FSEW75mtv4r
	mNOl8DGP7K1vua4GlqgVjkAqN5NFVz
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c4285689f6mr3925556637.19.1721633273709;
        Mon, 22 Jul 2024 00:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxIPcCd1WW98vl8lXbLzkIH0a8Q+ehSVLCBNp9CRt+/VuFx/jMBlf8mhAQqthIef6gJKjwps/aEk4qySfjQO4=
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id
 adf61e73a8af0-1c4285689f6mr3925519637.19.1721633273096; Mon, 22 Jul 2024
 00:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:27:42 +0800
Message-ID: <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## About virtio premapped mode
>
> The current configuration sets the virtqueue (vq) to premapped mode,
> implying that all buffers submitted to this queue must be mapped ahead
> of time. This presents a challenge for the virtnet send queue (sq): the
> virtnet driver would be required to keep track of dma information for vq
> size * 17, which can be substantial. However, if the premapped mode were
> applied on a per-buffer basis, the complexity would be greatly reduced.
> With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> skb buffers could remain unmapped.
>
> We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> indicates that the driver has performed DMA mapping in advance, allowing
> the Virtio core to directly utilize sg_dma_address(sg) without
> conducting any internal DMA mapping. Additionally, DMA unmap operations
> for this buffer will be bypassed.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> Please review.
>
> Thanks.
>
> Xuan Zhuo (13):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: split: harden dma unmap for indirect
>   virtio_ring: packed: harden dma unmap for indirect
>   virtio_ring: perform premapped operations based on per-buffer
>   virtio-net: rq submits premapped buffer per buffer
>   virtio_ring: remove API virtqueue_set_dma_premapped
>   virtio_net: refactor the xmit type
>   virtio_net: xsk: bind/unbind xsk for tx
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: xsk: tx: support xmit xsk buffer
>   virtio_net: xsk: tx: handle the transmitted xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
>
>  drivers/net/virtio_net.c     | 363 ++++++++++++++++++++++++++++-------
>  drivers/virtio/virtio_ring.c | 302 ++++++++++++-----------------
>  include/linux/virtio.h       |   2 -
>  3 files changed, 421 insertions(+), 246 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

Hi Xuan:

I wonder why this series is tagged as "RFC"?

Thanks


