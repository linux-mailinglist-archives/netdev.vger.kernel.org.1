Return-Path: <netdev+bounces-211358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5632B1825F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A13A7A10
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE583256C71;
	Fri,  1 Aug 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4i2HfIo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747A21B9DB
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054370; cv=none; b=BGHGAaWZvfZomVtfoHjxmnG6HEFsgAFZyqlga63JaHDDJoNOiZz9YLsE8UNcU3nV1jT/b1+vmwLq0O022PdYDYRkMp4LMgjUFeR3mXhJG01SnpiQsH1u201Hnj3kjIlHL2szjA27CV122WSlIKMScNYzsMuUS8Hwi1HSrZvJ37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054370; c=relaxed/simple;
	bh=9NerjbYLuoyk/RKlTefAdXQzfB6NwPQkXItsvzNMysk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYDQ6TltGzA2CZeJMzxiV8DmXNUgvBGtRmBJfcm9ghA6OWWTJ4y7bdKA/oaIcRMGdMDAQ3fLjMVY/gu2KLec3u3SFiALJJu+Ou6W9rQpwF+wQCAsPjdd6YdOfRfFcyAs5uQCXkTga6TdnrPMlWhWdM12Ps9HKh6H+CyzLDTpbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4i2HfIo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754054366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbLdGk22JzqbKEhu/iJYhhYYSjQLfdAdGKKqzGB0K4Q=;
	b=U4i2HfIoGVR0/5HlTaQYzCZ7oopzDvjfVRxrbMO8qMmkMI6KDYfrbpebum4lqE/+y7Zfil
	4vKK653OgWt9A33iLoaYZHAs8x0LaF7A5ttClnFqE5iHxJ3qfRsYRuHIvXAZnbvOAxnyLa
	0gzK0DnqSfiEx3IYbamU01McHB/I7AU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-CdEWaLVgNa6jNgSJMROKaA-1; Fri, 01 Aug 2025 09:19:25 -0400
X-MC-Unique: CdEWaLVgNa6jNgSJMROKaA-1
X-Mimecast-MFC-AGG-ID: CdEWaLVgNa6jNgSJMROKaA_1754054364
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so10904185e9.3
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054364; x=1754659164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbLdGk22JzqbKEhu/iJYhhYYSjQLfdAdGKKqzGB0K4Q=;
        b=ADg8qOK7k1v7xYcP7h+QUWUwyOUaJ1s9vVvQJWdrA/7EWKUf8LlYNAR0HPiHDOmXov
         t7id7wiYCmgNNCEF3xtdLNATLP5J2DRGlWWYz9ZT5rrv12+HLgkC7V/8fHiqUsxfzQIz
         kRvR4Iqist7Er6N8W2dyRsCDrxdY8iO8eRF0hk44jVoo5HOM/jMNt7VKOzlhvvs4Owmt
         1Q8v8A9jmDfLRJJNdyWEPkjYXOL7lqiOJweNW8uR4LjZ1VBAK4IHhAa/vwxxDoXyyWkN
         32v4hhppbO+XgQsl5+GswzbqsKZqg5e3YKnqEF2n9Ve1OFO5PaDkGoAE+hvX6Jos5mb/
         TtfA==
X-Forwarded-Encrypted: i=1; AJvYcCU6XFlxhd9FSUICll78SIsznRu5Oyx+5/Tv9nf2EDegqW7Ar5nAL15bFiR8rUkNkaCGfSEaej8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqEB95hacf+3H2wCX7p7Cq+PLFfmlhzKNypq2Hx41KRdp0bnE
	pRy/3FEAiDsJdK7Sxzqbz4+xSYUncFTAl0JnaUaA7KoeBq4gUh3DdflTSOgvxu/9BIzN0FeF1nt
	Y8q3yPZwYZMC9BXyBudwrQHGuGqq2wtRhdygtlW0J8ukBEmVWHMj7IPunNw==
X-Gm-Gg: ASbGnct9aYsB7QR0fkCEI3xrqpx8lR+XkGqEBHf0jcOg+mFQgCQYDTgprJyMYGd5bup
	cjJipTNr49PjZJxOo/ADvxLqaFLfGQ2NF/Rb9cq9rboiZkhSHvB30TSUFgD0r25NsT6gqy2eQ1p
	h6rxBeuogMdU3o9UQjH6te8XGIRS+grUQE9CR2K8V1zwe2KKtZs6D8J+A9M2xGqUILbLAHViIhg
	lL7oiiVJ1Chv4iPI/PSbGd58RjnVt8yi5YXpOghMhftke88QzeI5Frb/REaTEQW3hDcBI/psq+3
	FikClwUqcKBF2wJn0rFG9OWTSuINdO6/
X-Received: by 2002:a05:600c:3143:b0:458:b2c4:b3df with SMTP id 5b1f17b1804b1-458b2c4b55cmr7065045e9.33.1754054364126;
        Fri, 01 Aug 2025 06:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZq6SGlI97jjT0xUjwHMnLWo6+mq6NBKRj1ThNjjX/DhoWqBXT6UeApleX2c0S5DJT9fufQ==
X-Received: by 2002:a05:600c:3143:b0:458:b2c4:b3df with SMTP id 5b1f17b1804b1-458b2c4b55cmr7064765e9.33.1754054363595;
        Fri, 01 Aug 2025 06:19:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af917d20sm11817765e9.2.2025.08.01.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:19:23 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:19:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	acourbot@google.com, alok.a.tiwari@oracle.com,
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com,
	eric.auger@redhat.com, gnurou@gmail.com, jasowang@redhat.com,
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com,
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com,
	parav@nvidia.com, si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: Re: [GIT PULL] virtio, vhost: features, fixes
Message-ID: <20250801091454-mutt-send-email-mst@kernel.org>
References: <20250801070032-mutt-send-email-mst@kernel.org>
 <20250801090250-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801090250-mutt-send-email-mst@kernel.org>

On Fri, Aug 01, 2025 at 09:03:35AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 01, 2025 at 07:00:32AM -0400, Michael S. Tsirkin wrote:
> > The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:
> > 
> >   Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > for you to fetch changes up to c7991b44d7b44f9270dec63acd0b2965d29aab43:
> > 
> >   vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-07-17 08:33:09 -0400)
> 
> Oh no I am sorry! Please ignore, a bad commit snuck in there - it still
> needs maintainer approval, and I forgot.
> Will resend.
> 

Sent v2 now.
I wanted to apologize for this. I mistakenly put bad commits on the
branch called "master" and when looking at "git log" I did not notice
I was only looking at commits since "master" and not
"origin/master".

I should have reviewed the list of changes in the email before
sending, but as it's autogenerated as opposed the cover letter part
that I write myself, I was focusing on the latter and missed the
bad commits in the former. A less for me to remember to pay attention to that
part, as well.

Thanks!

> > ----------------------------------------------------------------
> > virtio, vhost: features, fixes
> > 
> > vhost can now support legacy threading
> > 	if enabled in Kconfig
> > vsock memory allocation strategies for
> > 	large buffers have been improved,
> > 	reducing pressure on kmalloc
> > vhost now supports the in-order feature
> > 	guest bits missed the merge window
> > 
> > fixes, cleanups all over the place
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Alexandre Courbot (1):
> >       media: add virtio-media driver
> > 
> > Alok Tiwari (4):
> >       virtio: Fix typo in register_virtio_device() doc comment
> >       vhost-scsi: Fix typos and formatting in comments and logs
> >       vhost: Fix typos
> >       vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit
> > 
> > Anders Roxell (1):
> >       vdpa: Fix IDR memory leak in VDUSE module exit
> > 
> > Cindy Lu (1):
> >       vhost: Reintroduce kthread API and add mode selection
> > 
> > Dr. David Alan Gilbert (2):
> >       vhost: vringh: Remove unused iotlb functions
> >       vhost: vringh: Remove unused functions
> > 
> > Dragos Tatulea (2):
> >       vdpa/mlx5: Fix needs_teardown flag calculation
> >       vdpa/mlx5: Fix release of uninitialized resources on error path
> > 
> > Gerd Hoffmann (1):
> >       drm/virtio: implement virtio_gpu_shutdown
> > 
> > Jason Wang (3):
> >       vhost: fail early when __vhost_add_used() fails
> >       vhost: basic in order support
> >       vhost_net: basic in_order support
> > 
> > Michael S. Tsirkin (6):
> >       virtio: document ENOSPC
> >       pci: report surprise removal event
> >       virtio: fix comments, readability
> >       virtio: pack config changed flags
> >       virtio: allow transports to suppress config change
> >       virtio: support device disconnect
> > 
> > Mike Christie (1):
> >       vhost-scsi: Fix log flooding with target does not exist errors
> > 
> > Pei Xiao (1):
> >       vhost: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))
> > 
> > Viresh Kumar (2):
> >       virtio-mmio: Remove virtqueue list from mmio device
> >       virtio-vdpa: Remove virtqueue list
> > 
> > WangYuli (1):
> >       virtio: virtio_dma_buf: fix missing parameter documentation
> > 
> > Will Deacon (9):
> >       vhost/vsock: Avoid allocating arbitrarily-sized SKBs
> >       vsock/virtio: Validate length in packet header before skb_put()
> >       vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
> >       vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
> >       vsock/virtio: Rename virtio_vsock_alloc_skb()
> >       vsock/virtio: Move SKB allocation lower-bound check to callers
> >       vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
> >       vsock/virtio: Rename virtio_vsock_skb_rx_put()
> >       vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> > 
> >  MAINTAINERS                                |    6 +
> >  drivers/gpu/drm/virtio/virtgpu_drv.c       |    8 +-
> >  drivers/media/Kconfig                      |   13 +
> >  drivers/media/Makefile                     |    2 +
> >  drivers/media/virtio/Makefile              |    9 +
> >  drivers/media/virtio/protocol.h            |  288 ++++++
> >  drivers/media/virtio/scatterlist_builder.c |  563 ++++++++++++
> >  drivers/media/virtio/scatterlist_builder.h |  111 +++
> >  drivers/media/virtio/session.h             |  109 +++
> >  drivers/media/virtio/virtio_media.h        |   93 ++
> >  drivers/media/virtio/virtio_media_driver.c |  959 ++++++++++++++++++++
> >  drivers/media/virtio/virtio_media_ioctls.c | 1297 ++++++++++++++++++++++++++++
> >  drivers/pci/pci.h                          |    6 +
> >  drivers/vdpa/mlx5/core/mr.c                |    3 +
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c          |   12 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c         |    1 +
> >  drivers/vhost/Kconfig                      |   18 +
> >  drivers/vhost/net.c                        |   88 +-
> >  drivers/vhost/scsi.c                       |   24 +-
> >  drivers/vhost/vhost.c                      |  377 +++++++-
> >  drivers/vhost/vhost.h                      |   30 +-
> >  drivers/vhost/vringh.c                     |  118 ---
> >  drivers/vhost/vsock.c                      |   15 +-
> >  drivers/virtio/virtio.c                    |   25 +-
> >  drivers/virtio/virtio_dma_buf.c            |    2 +
> >  drivers/virtio/virtio_mmio.c               |   52 +-
> >  drivers/virtio/virtio_pci_common.c         |   45 +
> >  drivers/virtio/virtio_pci_common.h         |    3 +
> >  drivers/virtio/virtio_pci_legacy.c         |    2 +
> >  drivers/virtio/virtio_pci_modern.c         |    2 +
> >  drivers/virtio/virtio_ring.c               |    4 +
> >  drivers/virtio/virtio_vdpa.c               |   44 +-
> >  include/linux/pci.h                        |   45 +
> >  include/linux/virtio.h                     |   13 +-
> >  include/linux/virtio_config.h              |   32 +
> >  include/linux/virtio_vsock.h               |   46 +-
> >  include/linux/vringh.h                     |   12 -
> >  include/uapi/linux/vhost.h                 |   29 +
> >  include/uapi/linux/virtio_ids.h            |    1 +
> >  kernel/vhost_task.c                        |    2 +-
> >  net/vmw_vsock/virtio_transport.c           |   20 +-
> >  net/vmw_vsock/virtio_transport_common.c    |    3 +-
> >  42 files changed, 4186 insertions(+), 346 deletions(-)
> >  create mode 100644 drivers/media/virtio/Makefile
> >  create mode 100644 drivers/media/virtio/protocol.h
> >  create mode 100644 drivers/media/virtio/scatterlist_builder.c
> >  create mode 100644 drivers/media/virtio/scatterlist_builder.h
> >  create mode 100644 drivers/media/virtio/session.h
> >  create mode 100644 drivers/media/virtio/virtio_media.h
> >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> >  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c


