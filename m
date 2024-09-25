Return-Path: <netdev+bounces-129677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6460985797
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0729282211
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235341494DC;
	Wed, 25 Sep 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVcm2MKB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32584962B
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262353; cv=none; b=uQds1xtolVjxmsv9md3s5/QTJIHT7RhEwg7ho7ry7sSnXPHY9R+xXnS9olO1GvFJQF0fl1zzg0tU6N7oONRZTedxFqyr6aIhPl1BrNauC441NLqKfCq/1uAHVmWTqFH2mvuKysV9sI1P0zT98FDyuCwNaD4m4K+/hFKHeKADNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262353; c=relaxed/simple;
	bh=Sqkc7COafVaLxQmdycBqaTIn4GumFYjZAn2h85fxp/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh7sdWF0TGmQtiMzAKYz1WK3UNQfYiMnGoIDAUHwCbRQrreHqkZguvDEJeGfQFFii6Nk+1UepZ4f+1p7iP9trWCpDZrqjTxWSMMMbIkQC07D/2gxVgxHatHsx+dhZsS8L2CSmnw+H1kxrXKnYuhmz6V2jbLnE3ZjlFBAyPHqpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVcm2MKB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727262349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LM+n56GH7KXiVYxjlnpXafBN650KcAqdINciF2Xu3w=;
	b=DVcm2MKBeu9j+PPgsyUHPuvHXWlIKnU8gxBNpzcxlhj9y8ZR876nlEEvwJ79chQT0Xt12E
	UZ7gZBC11y5iOfPut/hMhA9MsEjWxjsCvB2K19e1dFCFTjk9gHnROf/n87Kk9yOZuLucZC
	mbPESShi6JyNftoWvKEBP5YZtdWGUIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-HjXAhv4kOGWWZ1xQpvy_BA-1; Wed, 25 Sep 2024 07:05:48 -0400
X-MC-Unique: HjXAhv4kOGWWZ1xQpvy_BA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37ccc21ceb1so90439f8f.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 04:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262347; x=1727867147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LM+n56GH7KXiVYxjlnpXafBN650KcAqdINciF2Xu3w=;
        b=V+1oOoEsyZHugciw04rR3Yil51zxhm/5FdRyuQBLbVGscihQXJ5QlD5PvCxayiyvoZ
         k5UMAsmkI9LB9EUfd22O6NdVOGLwU9CG7Hj2w0NL1DSr2m/3bEv50xfV4P5BHesKktGz
         H3SAKZEoPGdlOKool6GFoc3GIjvgRmEMDA4DqP+/EmwPglJx7/dgpj3JEBlMA+zB1PNr
         vyE9CZ8RNqBfXoFqUfvPLuh5CQDwO55Ee9CwwWf9UzhF3q4K9laWBs4eeKW9AwVBJTF5
         9SO2VV+7NcQwD0jxaM//1e8b4Iy/ZsBeXvwdHHMs/qz9QLmyL/M866rvfpJhwqM77+bU
         ilyA==
X-Forwarded-Encrypted: i=1; AJvYcCXAUJLkQs6af7IjsYM+vRYYUkySKMmvrP5UU4TNAGKi8ZSo1+CEo4g/XSt589O+g6fCABMrhQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZyCOK6goNFI+3Pf6i/0u/lDhuIAk99jXKKExD2+ZfYvOqmkn
	8y6CmGGJNFKeDOWISzwIm3Ja99uf14IvO4i95miCgsRlNkzt0Upp3SXrLzqzqKNx+qFzgiRQT0z
	FFRtzDg0+g4UrS6sMiXmGEiZJ72hu92eS5T90X4u/ZUCE55VtjS6PAQ==
X-Received: by 2002:a5d:5d83:0:b0:37c:cbbb:10c with SMTP id ffacd0b85a97d-37ccbbb02bdmr443653f8f.52.1727262347213;
        Wed, 25 Sep 2024 04:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyxK9W0yQxQwL6c10VX2K+N65TxtVt2ovya9Ro/obn2l6EIadff65SJpEzepj3XEwoB84y/w==
X-Received: by 2002:a5d:5d83:0:b0:37c:cbbb:10c with SMTP id ffacd0b85a97d-37ccbbb02bdmr443620f8f.52.1727262346651;
        Wed, 25 Sep 2024 04:05:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cc9d0decesm699449f8f.80.2024.09.25.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:05:43 -0700 (PDT)
Date: Wed, 25 Sep 2024 07:05:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, dtatulea@nvidia.com, eperezma@redhat.com,
	jasowang@redhat.com, leiyang@redhat.com, leonro@nvidia.com,
	lihongbo22@huawei.com, luigi.leonardi@outlook.com, lulu@redhat.com,
	marco.pinn95@gmail.com, mgurtovoy@nvidia.com,
	pankaj.gupta.linux@gmail.com, philipchen@chromium.org,
	pizhenwei@bytedance.com, sgarzare@redhat.com, yuehaibing@huawei.com,
	zhujun2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20240925070508-mutt-send-email-mst@kernel.org>
References: <20240924165046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924165046-mutt-send-email-mst@kernel.org>

On Tue, Sep 24, 2024 at 04:50:46PM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
> 
>   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1bc6f4910ae955971097f3f2ae0e7e63fa4250ae:
> 
>   vsock/virtio: avoid queuing packets when intermediate queue is empty (2024-09-12 02:54:10 -0400)

Ouch. Pls ignore, will fix and resend.

> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> Several new features here:
> 
> 	virtio-balloon supports new stats
> 
> 	vdpa supports setting mac address
> 
> 	vdpa/mlx5 suspend/resume as well as MKEY ops are now faster
> 
> 	virtio_fs supports new sysfs entries for queue info
> 
> 	virtio/vsock performance has been improved
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Cindy Lu (3):
>       vdpa: support set mac address from vdpa tool
>       vdpa_sim_net: Add the support of set mac address
>       vdpa/mlx5: Add the support of set mac address
> 
> Dragos Tatulea (18):
>       vdpa/mlx5: Fix invalid mr resource destroy
>       net/mlx5: Support throttled commands from async API
>       vdpa/mlx5: Introduce error logging function
>       vdpa/mlx5: Introduce async fw command wrapper
>       vdpa/mlx5: Use async API for vq query command
>       vdpa/mlx5: Use async API for vq modify commands
>       vdpa/mlx5: Parallelize device suspend
>       vdpa/mlx5: Parallelize device resume
>       vdpa/mlx5: Keep notifiers during suspend but ignore
>       vdpa/mlx5: Small improvement for change_num_qps()
>       vdpa/mlx5: Parallelize VQ suspend/resume for CVQ MQ command
>       vdpa/mlx5: Create direct MKEYs in parallel
>       vdpa/mlx5: Delete direct MKEYs in parallel
>       vdpa/mlx5: Rename function
>       vdpa/mlx5: Extract mr members in own resource struct
>       vdpa/mlx5: Rename mr_mtx -> lock
>       vdpa/mlx5: Introduce init/destroy for MR resources
>       vdpa/mlx5: Postpone MR deletion
> 
> Hongbo Li (1):
>       fw_cfg: Constify struct kobj_type
> 
> Jason Wang (1):
>       vhost_vdpa: assign irq bypass producer token correctly
> 
> Lei Yang leiyang@redhat.com (1):
>       ack! vdpa/mlx5: Parallelize device suspend/resume


Ouch. Pls ignore, will fix and resend.

> 
> Luigi Leonardi (1):
>       vsock/virtio: avoid queuing packets when intermediate queue is empty
> 
> Marco Pinna (1):
>       vsock/virtio: refactor virtio_transport_send_pkt_work
> 
> Max Gurtovoy (2):
>       virtio_fs: introduce virtio_fs_put_locked helper
>       virtio_fs: add sysfs entries for queue information
> 
> Philip Chen (1):
>       virtio_pmem: Check device status before requesting flush
> 
> Stefano Garzarella (1):
>       MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
> 
> Yue Haibing (1):
>       vdpa: Remove unused declarations
> 
> Zhu Jun (1):
>       tools/virtio:Fix the wrong format specifier
> 
> zhenwei pi (3):
>       virtio_balloon: introduce oom-kill invocations
>       virtio_balloon: introduce memory allocation stall counter
>       virtio_balloon: introduce memory scan/reclaim info
> 
>  MAINTAINERS                                   |   1 +
>  drivers/firmware/qemu_fw_cfg.c                |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/nvdimm/nd_virtio.c                    |   9 +
>  drivers/vdpa/ifcvf/ifcvf_base.h               |   3 -
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  47 ++-
>  drivers/vdpa/mlx5/core/mr.c                   | 291 +++++++++++++---
>  drivers/vdpa/mlx5/core/resources.c            |  76 +++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 477 +++++++++++++++++---------
>  drivers/vdpa/pds/cmds.h                       |   1 -
>  drivers/vdpa/vdpa.c                           |  79 +++++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c          |  21 +-
>  drivers/vhost/vdpa.c                          |  16 +-
>  drivers/virtio/virtio_balloon.c               |  18 +
>  fs/fuse/virtio_fs.c                           | 164 ++++++++-
>  include/linux/vdpa.h                          |   9 +
>  include/uapi/linux/vdpa.h                     |   1 +
>  include/uapi/linux/virtio_balloon.h           |  16 +-
>  net/vmw_vsock/virtio_transport.c              | 144 +++++---
>  tools/virtio/ringtest/main.c                  |   2 +-
>  20 files changed, 1098 insertions(+), 300 deletions(-)


