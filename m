Return-Path: <netdev+bounces-129663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A73985454
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DB9281776
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3315747D;
	Wed, 25 Sep 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGxqW7+s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCB154BF5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249941; cv=none; b=FMxRMYEnW1gZdKuUBtKTO5BAg/4Sv8mTc1ZxNrUxf16zioRA5+C/owtgXWEC9jouOm0v7gDfKvvj35M2EPNvj/98uCPNkPECyWQlgkWIZjGOrekBcEAAbAq71j13xslxkMDq6X8ZodTv4Kos+3qlG6FB5kOWE60VYvS+oJstTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249941; c=relaxed/simple;
	bh=hA2NN7kzc70Me5M2AjVJID4so0HqKPa/tbvMgUFH6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjVoyGinAkNDK/VZ6JWuv/jEaE8pq+zZSui2sfl2GSx4qhPq4hu9GTVTCz5j/oWVfOkr4wE58o4Fy/cKoAaGih5X9coQcPVGI0ipOfPQQLY4lzeNS0o/hTmkQfi6P2oR8hnsDGaxvHDhAxScmjriFlYYtYKJOGc9QYQU+VsUEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGxqW7+s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727249939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k5IxqMkt8qD5qrDFPPLWnZIAs2xArm/m3qqUsZKT8ng=;
	b=JGxqW7+sXYM+Cn1Yi3IOBnJ6fCtRE/3fY3q1Rtxj7XYtN4uL6hxaplx0Pn73Ry/boDTcmF
	8ulnqG5HE4r2NHF32pvlmOEOFEeh5ttMY4L3sjxnllhiebi84Dphi0ZAy5EDKylIB5njKb
	aoC9+H5agN4TzIBrw2hhLrC7z2RWLOA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-1VpRXOWvOlu7gOkORggzVQ-1; Wed, 25 Sep 2024 03:38:57 -0400
X-MC-Unique: 1VpRXOWvOlu7gOkORggzVQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d21b5cb5fso385677166b.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 00:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249936; x=1727854736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5IxqMkt8qD5qrDFPPLWnZIAs2xArm/m3qqUsZKT8ng=;
        b=i3qkG4pL0kxfGc3C+6BaNpLH226jY470dg18n5KmZ9056KbcSltCKWO9350YVRQcc2
         WWCIWZc/GuqZxaFj0r+EaQ/bvdWE79rjB2zhezOIlDiGWq/xjb8/Z76m7SLFPnNTFXou
         Fkbou93Sm6naW4di9/G/W5MDAg4zAgFVoyGHeMTZfmSSEuSmeIBXnQdus+KLGHyxxkaE
         D4vrxFcM6w5ajOdUuXY7NqkTPoj4pmRcqE/ls2hqmZjkBXxudCq+m5bgOZghmhMMLXV6
         umjcHqtYFTm2A/gpQpFdLVBcrnBqUoHkkhRRy/ORQ0TfK4tM4Pi1bZLTFc+NH4uY301c
         EfcA==
X-Forwarded-Encrypted: i=1; AJvYcCWUw/XpmwXyr3jDAQKVduqwH4jF3IaTXhS77agXCWW2kvXWOiyqXEjBNdrFpyMT4iFYhpzMCyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSg1Zj9Ao4DdKOWIFgqvDv/b4frzT2CsPVpKE2JmxZfgBjBVB2
	uUwkMOt0m3CdIZelBWbqj5A+GaKsiRSOiH3+7TWQwvskAXMlyVHVZwutTfmvZPk2Yq2q9rZzZxa
	NBYKceg6L4PUoXk6UqLrQE7o0RqyEgNjC1jaPvlcDF7x9RiXmxPvRkA==
X-Received: by 2002:a17:907:2ce5:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a93a066f942mr170021766b.54.1727249936542;
        Wed, 25 Sep 2024 00:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXFFtVfLBhqbQGBA31zqKMXEIhRN2UiES5o0Cy7oKF+caZsB3g/KGz5JFCowqi/0EgISF3lg==
X-Received: by 2002:a17:907:2ce5:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a93a066f942mr170015966b.54.1727249935830;
        Wed, 25 Sep 2024 00:38:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393134b3esm176178266b.198.2024.09.25.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:38:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:38:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com, jasowang@redhat.com, 
	leiyang@redhat.com, leonro@nvidia.com, lihongbo22@huawei.com, 
	luigi.leonardi@outlook.com, lulu@redhat.com, marco.pinn95@gmail.com, mgurtovoy@nvidia.com, 
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org, pizhenwei@bytedance.com, 
	yuehaibing@huawei.com, zhujun2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <fqvpau7doh7lf7mytane7n5yww7w2lrc4y6pyshainrl52rfyl@xi6kk7hbwyhc>
References: <20240924165046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240924165046-mutt-send-email-mst@kernel.org>

On Tue, Sep 24, 2024 at 04:50:46PM GMT, Michael S. Tsirkin wrote:
>The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
>
>  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
>
>are available in the Git repository at:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>
>for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:
>
>  vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)
>
>----------------------------------------------------------------
>virtio: features, fixes, cleanups
>
>Several new features here:
>
>	virtio-balloon supports new stats
>
>	vdpa supports setting mac address
>
>	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster
>
>	virtio_fs supports new sysfs entries for queue info
>
>	virtio/vsock performance has been improved
>
>Fixes, cleanups all over the place.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>----------------------------------------------------------------
>Cindy Lu (3):
>      vdpa: support set mac address from vdpa tool
>      vdpa_sim_net: Add the support of set mac address
>      vdpa/mlx5: Add the support of set mac address
>
>Dragos Tatulea (18):
>      vdpa/mlx5: Fix invalid mr resource destroy
>      net/mlx5: Support throttled commands from async API
>      vdpa/mlx5: Introduce error logging function
>      vdpa/mlx5: Introduce async fw command wrapper
>      vdpa/mlx5: Use async API for vq query command
>      vdpa/mlx5: Use async API for vq modify commands
>      vdpa/mlx5: Parallelize device suspend
>      vdpa/mlx5: Parallelize device resume
>      vdpa/mlx5: Keep notifiers during suspend but ignore
>      vdpa/mlx5: Small improvement for change_num_qps()
>      vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
>      vdpa/mlx5: Create direct MKEYs in parallel
>      vdpa/mlx5: Delete direct MKEYs in parallel
>      vdpa/mlx5: Rename function
>      vdpa/mlx5: Extract mr members in own resource struct
>      vdpa/mlx5: Rename mr_mtx -> lock
>      vdpa/mlx5: Introduce init/destroy for MR resources
>      vdpa/mlx5: Postpone MR deletion
>
>Hongbo Li (1):
>      fw_cfg: Constify struct kobj_type
>
>Jason Wang (1):
>      vhost_vdpa: assign irq bypass producer token correctly
>
>Lei Yang leiyang@redhat.com (1):
>      ack! vdpa/mlx5: Parallelize device suspend/resume
        ^
This commit (fbb072d2d19133222e202ea7c267cfc1f6bd83b0) looked strange
from the title, indeed inside it looks empty, so maybe the intent was to
"squash" it with the previous commit acba6a443aa4 ("vdpa/mlx5:
Parallelize VQ suspend/resume for CVQ MQ command") to bring back the
Tested-by, right?

Thanks,
Stefano

>
>Luigi Leonardi (1):
>      vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>Marco Pinna (1):
>      vsock/virtio: refactor virtio_transport_send_pkt_work
>
>Max Gurtovoy (2):
>      virtio_fs: introduce virtio_fs_put_locked helper
>      virtio_fs: add sysfs entries for queue information
>
>Philip Chen (1):
>      virtio_pmem: Check device status before requesting flush
>
>Stefano Garzarella (1):
>      MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
>
>Yue Haibing (1):
>      vdpa: Remove unused declarations
>
>Zhu Jun (1):
>      tools/virtio:Fix the wrong format specifier
>
>zhenwei pi (3):
>      virtio_balloon: introduce oom-kill invocations
>      virtio_balloon: introduce memory allocation stall counter
>      virtio_balloon: introduce memory scan/reclaim info
>
> MAINTAINERS                                   |   1 +
> drivers/firmware/qemu_fw_cfg.c                |   2 +-
> drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
> drivers/nvdimm/nd_virtio.c                    |   9 +
> drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
> drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
> drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
> drivers/vdpa/mlx5/core/resources.c            |  76 +++-
> drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
> drivers/vdpa/pds/cmds.h                       |   1 -
> drivers/vdpa/vdpa.c                           |  79 +++++
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
> drivers/vhost/vdpa.c                          |  16 +-
> drivers/virtio/virtio_balloon.c               |  18 +
> fs/fuse/virtio_fs.c                           | 164 ++++++++-
> include/linux/vdpa.h                          |   9 +
> include/uapi/linux/vdpa.h                     |   1 +
> include/uapi/linux/virtio_balloon.h           |  16 +-
> net/vmw_vsock/virtio_transport.c              | 144 +++++---
> tools/virtio/ringtest/main.c                  |   2 +-
> 20 files changed, 1098 insertions(+), 300 deletions(-)
>


