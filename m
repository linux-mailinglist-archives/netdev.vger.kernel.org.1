Return-Path: <netdev+bounces-243311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A85C9CDDF
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C34E334E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8402F1FEA;
	Tue,  2 Dec 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWxYWLL+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X69a2Sp+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B02C2340
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706051; cv=none; b=oC/WQjUY+G6OtNWtsvSC15x8QyrwSXhyKO1HMY+HmSjAp03/aOgRV+0gjf/KMD+irMjaAUEmKdNQKZmO4p4dz/90YBAG065kJOsbUchhT9YsAVWhC97Pcd+eqZz0HOebhr+4TOsOeZ/lyiu0+P5BbSIb5+WVFu45TxlQuBNKUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706051; c=relaxed/simple;
	bh=oPYqW5SQfExXpPRUP0ZxO9mJN6N4rIx6CnioC/GrhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hFiGR3hz+RTBlfRBFeklsa2wAYZHVWMlfMUf32v3bMINR0oe4j9ta6B1MHROsTkpmx+TP6Idpf5JS055BTPExbXorAmqNvMY03a2Oi5tt0FyhiYWnr5uN11NcIkPPfhwUzZUtE24oSiRYkT9t2CAkOKYl/uLXJvgsngcYPiOh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWxYWLL+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X69a2Sp+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764706047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=4LOaJkYRfgWql4tAMEDx+EG8hV3Vr+6Q+ye5vso+PWc=;
	b=TWxYWLL+CLUcNzM/lAwjJpOXYLs7YSJP/B/rR0KWMnvMV1ROpoGmZJh1cVNZhMie4ObUSS
	eCr/MpplFb+6M/E/Vjjq02rP55xOI1FyInK2kZ6Ek9MJ09Obna6xunJNhjEnBt4UpBgeCM
	xdDk5w21fzGlHtLstHhjhxe3v2nyZhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-VZ3piPSkNqKVXX72GSh5RQ-1; Tue, 02 Dec 2025 15:07:26 -0500
X-MC-Unique: VZ3piPSkNqKVXX72GSh5RQ-1
X-Mimecast-MFC-AGG-ID: VZ3piPSkNqKVXX72GSh5RQ_1764706045
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so44959725e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 12:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764706045; x=1765310845; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4LOaJkYRfgWql4tAMEDx+EG8hV3Vr+6Q+ye5vso+PWc=;
        b=X69a2Sp+YZaT9W5G2v72MxhvkoX+kumNUKmGbmL1VqTnA1i80gTWCWptP/mZN0hyD+
         hvQt2VzJwZ8l3jBlegL/jzJJ9JNkmuDSfop5GLkBe95guxychNITLYR8h2LREnK8rnRz
         IuUJ/wE4gJg4dYWl5856fT38ZMGy9SdKnpvcZK2z+xPJ7YtHAjM4iDdemzDLZz+kC/4U
         ctltbKg3jw2d2Qk6WGf28KZsjGp11QfZEIpQ8xouxTEe/XIYT5Ct6ivlkZF4bcR3UrqH
         WFzqKPvMRtrX2FFammA61qNyKqqM9VVHzYqUHVBGfNpnckHTNv/oS4PVjRpZb8YqtMyJ
         euAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706045; x=1765310845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LOaJkYRfgWql4tAMEDx+EG8hV3Vr+6Q+ye5vso+PWc=;
        b=VP0UXFyLiOG4+9UeDaAaFjX/IDUgDm7WdIPEK67La0PvA3cPni798X65S/wremoS49
         ZaN7rs3LbmATgVXLR5znNsqQR+8CJp4coNw+N+4H3ySwqbxQh54Nr8jeTjtogpusDP+v
         36Hx2D6RXuI4Qk+6OiG7i7DfuDcFgn19HY9hGhMt3VXLtTkj76wvrkjLiR4cPBxIaw2x
         7e7nClqPhEZBhnQ5AkDRbevU4j4O6tBIOwl95y/z0ZHBwQ3wGnDZuVZ/OgRDARBRUFV8
         yG+eMah6BK+Hx1TvHGLxmRfaSAg+/XwvqIgeSYqVpN1D+DFIZvvUIMJxxBn0AeyXfAOS
         sTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0+bXUxce7kzvXSWw826EQ+FcLLqm6uMOg25u2iimJKpwmsBummG27yXY0bI2pJFK0P8JM1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpoRSrXfdykrs8cU1XfohG5cqgs0Qxfhgg31x8C0Rimu5pyHO
	/S8gc5vnmwZRnxjlwCKFc0ZD4AF1YINnkJabjigWxRdCxsQP3b/zasKzrSppdhFE7QcxogbW4Ht
	4w93IKdXFu2leR4amzW3VcWuq9mAsICZZbPb5fABvUNbGFP0YG6TPPw7j2Q==
X-Gm-Gg: ASbGncsPy7LjFoB0MvopoPkvuUe++YEAjeCbrHgv/bll8HIw9zDlTGsslI4YqWIBXiA
	cN3YeLY3/ufkEpC0aBObpWnY0gfz2ASzP0qiozUEcIjDDvbMP9zIv35hxUST8Hoy2H3Y67wpmQZ
	nW77d0AZVuY4GJJdchtuLs/kEudaY971zH4JP7n+yLMhdW+/NhoiPTrdzoUBj0kMbAOiJ1bQuf9
	0ZS20Xq8TquxBdPFo3kHAYSJ/1Nr+RHmSuIu74fAFBLxkp3m7zu0vrFZTJ+M7C7nQNGYX5otQM4
	UVbDjzOEwjPQK9ZhKYghRbIzA72bqM35oKK6AqTrM5ED+QHCRNGSHba+lB5PVvUdMbRHXogI17l
	zmDhFpk9d1yDntpYpLHgI6zwqw2a31YjQ
X-Received: by 2002:a05:600c:5249:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-4792a4aac08mr9281285e9.29.1764706045302;
        Tue, 02 Dec 2025 12:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/agkXQ9hhx2CuGFlZ3EgTBLncuqp3bFvjDrGsXOBisReyUeJGrkEIqlYMZDfX1+cLbK1Uhw==
X-Received: by 2002:a05:600c:5249:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-4792a4aac08mr9280895e9.29.1764706044801;
        Tue, 02 Dec 2025 12:07:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a8c5fdesm5614095e9.10.2025.12.02.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 12:07:24 -0800 (PST)
Date: Tue, 2 Dec 2025 15:07:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, alok.a.tiwari@oracle.com,
	jasowang@redhat.com, kriish.sharma2006@gmail.com,
	linmq006@gmail.com, marco.crivellari@suse.com,
	michael.christie@oracle.com, mst@redhat.com, pabeni@redhat.com,
	stable@vger.kernel.org, yishaih@nvidia.com
Subject: [GIT PULL] virtio,vhost: fixes, cleanups
Message-ID: <20251202150721-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

get_user/put_user change didn't spend time in next and
seems a bit too risky to rush. I'm keeping it in my tree
and we'll get it in the next cycle.


The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 205dd7a5d6ad6f4c8e8fcd3c3b95a7c0e7067fee:

  virtio_pci: drop kernel.h (2025-11-30 18:02:43 -0500)

----------------------------------------------------------------
virtio,vhost: fixes, cleanups

Just a bunch of fixes and cleanups, mostly very simple. Several
features are merged through net-next this time around.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (3):
      virtio_vdpa: fix misleading return in void function
      vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
      vdpa/pds: use %pe for ERR_PTR() in event handler registration

Kriish Sharma (1):
      virtio: fix kernel-doc for mapping/free_coherent functions

Marco Crivellari (2):
      virtio_balloon: add WQ_PERCPU to alloc_workqueue users
      vduse: add WQ_PERCPU to alloc_workqueue users

Miaoqian Lin (1):
      virtio: vdpa: Fix reference count leak in octep_sriov_enable()

Michael S. Tsirkin (11):
      virtio: fix typo in virtio_device_ready() comment
      virtio: fix whitespace in virtio_config_ops
      virtio: fix grammar in virtio_queue_info docs
      virtio: fix grammar in virtio_map_ops docs
      virtio: standardize Returns documentation style
      virtio: fix virtqueue_set_affinity() docs
      virtio: fix map ops comment
      virtio: clean up features qword/dword terms
      vhost/test: add test specific macro for features
      vhost: switch to arrays of feature bits
      virtio_pci: drop kernel.h

Mike Christie (1):
      vhost: Fix kthread worker cgroup failure handling

 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  1 +
 drivers/vdpa/pds/vdpa_dev.c              |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
 drivers/vhost/net.c                      | 29 +++++++++++-----------
 drivers/vhost/scsi.c                     |  9 ++++---
 drivers/vhost/test.c                     | 10 ++++++--
 drivers/vhost/vhost.c                    |  4 ++-
 drivers/vhost/vhost.h                    | 42 ++++++++++++++++++++++++++------
 drivers/vhost/vsock.c                    | 10 +++++---
 drivers/virtio/virtio.c                  | 12 ++++-----
 drivers/virtio/virtio_balloon.c          |  3 ++-
 drivers/virtio/virtio_debug.c            | 10 ++++----
 drivers/virtio/virtio_pci_modern_dev.c   |  6 ++---
 drivers/virtio/virtio_ring.c             |  7 +++---
 drivers/virtio/virtio_vdpa.c             |  2 +-
 include/linux/virtio.h                   |  2 +-
 include/linux/virtio_config.h            | 24 +++++++++---------
 include/linux/virtio_features.h          | 29 +++++++++++-----------
 include/linux/virtio_pci_modern.h        |  8 +++---
 include/uapi/linux/virtio_pci.h          |  2 +-
 21 files changed, 131 insertions(+), 86 deletions(-)


