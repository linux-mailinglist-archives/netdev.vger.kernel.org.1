Return-Path: <netdev+bounces-74270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC8860AB3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A623B224C6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86739125DD;
	Fri, 23 Feb 2024 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3KiNF2+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240C111B5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669050; cv=none; b=E3GjVRVBxYKDz8vlmpiIESswZBel0aqx3lN2L4mV0U2loqHP1bjTIOQexugbdDhfZsmFn4kaCWOEBDpiZujsWfq/qSnrF68WT/zNLdFDWK5er/i0kEIAUmp9isC+s1o9BekIx9X5dcfauzG2lfs3Imy2kdGzBDCJZsbcd11qYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669050; c=relaxed/simple;
	bh=hCc9kfG3fizGgPgmdpClFKjoPRwjceJwvl8VPjdByMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE7pI7xKXygmNhub4PnYWdPwQxi81+xKutu9jVOvrbLlyGAjSx2aIDJE5KSGyI9CAiY+/DuL/ng/7vgt2xETxUL/P2HPO+Or5eRfM43cat/RIDzKHE+BHlWVE30q5xShA8P+9qH4UB06EOZ9DY3vtIW1B1GLkFkIM5lyIRuvfno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3KiNF2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708669046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBnxjcZte0s2OKjIGIRhh7IFZ830goa5+vVUZQ5r/JI=;
	b=G3KiNF2+Hkr+NIQX+tUP1CRVOMDQuWJ/gVR0b0YPW2+bhYh/VECD6GelPBSUWelQ45V0YR
	YGIdU+v/TFBf4p4Rhn/gF0PHFyIscskdEve/Qj5mUZ/aNXgz4d3MgKMF4qHcR0XKt4G+kR
	kkdwFoAkbO7l979s5r17piUz5i9z7rM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-orBkvCLUME-xTMIz0jRnFA-1; Fri, 23 Feb 2024 01:17:24 -0500
X-MC-Unique: orBkvCLUME-xTMIz0jRnFA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d19ac07c5so258005f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708669044; x=1709273844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBnxjcZte0s2OKjIGIRhh7IFZ830goa5+vVUZQ5r/JI=;
        b=i6HF/aqZ+2H3HHvHD6KbBQbDUq4V/mlNS5jvLiH4J5Jvc5vtKf8zJFnFVgOD7RIaue
         v1GVNBf/MoZZ5KT/VOl1ASrcD/GslEfkM070IffzLqwfQnWPahtbTTaZtD4LcU3SerCP
         m6F5mh/TwxPolChAki2tXmIdV1NLzIMCP+Fjp2v3FP8dyP3weAQjBRxM7chHcGRR21yx
         zxg1cXskF8VXiBPsk2+srBkmqI/y5IybsmEjCWXyS5B2TrXOxi1F70NYPJjL/EeaSyzY
         2UxmgO5VXUgYKoFqkjDpxYDB3Zysd3VCvlHKdUDJhNi3jJhmErNE3VrSBMQ2Vsu5K/iF
         f7yA==
X-Forwarded-Encrypted: i=1; AJvYcCW4aHEll1BAp7QqLP9b2lres4uly2+zln/gHfzlMKbpz13fzFnKki8fZNxv1bkRWcgwC5c/l25wXFSGnsFfO67QyH5Pr+5z
X-Gm-Message-State: AOJu0Ywuh+tUuJMVyBcVc5W71kiULHMs1JPRStZMqYV4Mh+BQPxUMg44
	AxAZKWoyvB9zmSh/n+2KKwC9YjaMeBk0OmJ7IFDn6ektKkQ6HD9b9MqXP4V+kRlT7Z/iX4FacO6
	JOqs7fsMXDln5zw0FqvSUw60nF370m0p9kvOLMbVjmWoaCbEMrtOPtQ==
X-Received: by 2002:a5d:56c8:0:b0:33d:157d:a7ad with SMTP id m8-20020a5d56c8000000b0033d157da7admr777468wrw.40.1708669043847;
        Thu, 22 Feb 2024 22:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVKDZZEwUcJIP7Avgmc2vr49V1+/ON8riI60u8BDNJ0hulyyOwnRcCKT7Cy9K6Xle99vWjdw==
X-Received: by 2002:a5d:56c8:0:b0:33d:157d:a7ad with SMTP id m8-20020a5d56c8000000b0033d157da7admr777452wrw.40.1708669043422;
        Thu, 22 Feb 2024 22:17:23 -0800 (PST)
Received: from redhat.com ([147.235.213.72])
        by smtp.gmail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm1494453wrb.80.2024.02.22.22.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:17:22 -0800 (PST)
Date: Fri, 23 Feb 2024 01:17:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v1 00/19] virtio: drivers maintain dma info for
 premapped vq
Message-ID: <20240223011631-mutt-send-email-mst@kernel.org>
References: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240202093951.120283-1-xuanzhuo@linux.alibaba.com>

On Fri, Feb 02, 2024 at 05:39:32PM +0800, Xuan Zhuo wrote:
> As discussed:
> http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com
> 
> If the virtio is premapped mode, the driver should manage the dma info by self.
> So the virtio core should not store the dma info.
> So we can release the memory used to store the dma info.
> 
> But if the desc_extra has not dma info, we face a new question,
> it is hard to get the dma info of the desc with indirect flag.
> For split mode, that is easy from desc, but for the packed mode,
> it is hard to get the dma info from the desc. And for hardening
> the dma unmap is saft, we should store the dma info of indirect
> descs.
> 
> So I introduce the "structure the indirect desc table" to
> allocate space to store dma info with the desc table.
> 
> On the other side, we mix the descs with indirect flag
> with other descs together to share the unmap api. That
> is complex. I found if we we distinguish the descs with
> VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> 
> Because of the dma array is allocated in the find_vqs(),
> so I introduce a new parameter to find_vqs().
> 
> Please review.
> 
> Thanks

this needs a rebase - conflicts with e.g.
commit e3fe8d28c67bf6c291e920c6d04fa22afa14e6e4
Author: Zhu Yanjun <yanjun.zhu@linux.dev>
Date:   Thu Jan 4 10:09:02 2024 +0800

    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings
    
    Fix the warnings when building virtio_net driver.
    

thanks!


> v1:
>     1. rename transport_vq_config to vq_transport_config
>     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_FRGAS +2)
>     3. introduce virtqueue_dma_map_sg_attrs
>     4. separate vring_create_virtqueue to an independent commit
> 
> Xuan Zhuo (19):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: packed: remove double check of the unmap ops
>   virtio_ring: packed: structure the indirect desc table
>   virtio_ring: split: remove double check of the unmap ops
>   virtio_ring: split: structure the indirect desc table
>   virtio_ring: no store dma info when unmap is not needed
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: reuse the parameter struct of find_vqs()
>   virtio: find_vqs: add new parameter premapped
>   virtio_ring: export premapped to driver by struct virtqueue
>   virtio_net: set premapped mode by find_vqs()
>   virtio_ring: remove api of setting vq premapped
>   virtio_ring: introduce dma map api for page
>   virtio_ring: introduce virtqueue_dma_map_sg_attrs
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: sq support premapped mode
> 
>  arch/um/drivers/virtio_uml.c             |  31 +-
>  drivers/net/virtio_net.c                 | 291 +++++++---
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
>  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
>  drivers/s390/virtio/virtio_ccw.c         |  33 +-
>  drivers/virtio/virtio_mmio.c             |  30 +-
>  drivers/virtio/virtio_pci_common.c       |  59 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  24 +-
>  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----------
>  drivers/virtio/virtio_vdpa.c             |  45 +-
>  include/linux/virtio.h                   |  13 +-
>  include/linux/virtio_config.h            |  48 +-
>  include/linux/virtio_ring.h              |  82 +--
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 +-
>  17 files changed, 848 insertions(+), 618 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


