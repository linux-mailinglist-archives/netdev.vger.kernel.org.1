Return-Path: <netdev+bounces-143756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C29C3FDE
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9006285BF7
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722A19E97B;
	Mon, 11 Nov 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fj2HyuxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B619E960
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333089; cv=none; b=bLQ/RhN6fbFtYjAPH4W4v97gh7vs57uGnbVKdvbPthoe639toglFtTR93jJp8kDvlpCS5yhtN3jR9ZK6sfQb5bQxDsYze943rjwAjqj/8QN1/vc91xOS7oMsMAAQPkU/c5zvdnwTX/7NjairX3jWFIuizl1zHjNsdadcn8Q/d58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333089; c=relaxed/simple;
	bh=Czawgg0eHQCiBa/n9H4yWNVg6iyINBKzS2rt+c5jO0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r1eyIbtIZtXINBtPUBc7Yk6e35BzO+tupMgqbrTKHbiiUblW1QbZPfPD0Ldd73zMo4uYruzaQFFy7bZNunPKWrQ3PF4+Ld1OhjYAI+XHei0xTBJPuNIKyObVZWHh5wkREI4kendPA3WLGzBPPt+yw2yix3ILIMc2COmXEfQwwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fj2HyuxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731333086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SDgcf2zjsNemccSJG3/V1OaS/z5L3BgNHfGxAIvuYes=;
	b=Fj2HyuxVpTOTDiOZPipEQbR/Pc/77JoLVSW3rDJjYqBpN5Wppwyq/DT2pPJq5ZM3z7SUP9
	Il1orSi9GctydGtyjFjEbI5kzE4l9+oIJtdWYUTcCfKGMkauDs0Gy4sOYRJOFcaru2z9bk
	EjZk5gIe9AFdzjTctTDNu/wbkrvXWCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-_QClRrKdPgymhe14tf9jVQ-1; Mon, 11 Nov 2024 08:51:24 -0500
X-MC-Unique: _QClRrKdPgymhe14tf9jVQ-1
X-Mimecast-MFC-AGG-ID: _QClRrKdPgymhe14tf9jVQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43157e3521dso32237935e9.1
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 05:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333083; x=1731937883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDgcf2zjsNemccSJG3/V1OaS/z5L3BgNHfGxAIvuYes=;
        b=GQGgOF+OoPLMaMBuqW4RF259V8hweRFkPhS0NogifD906D3SlXnncUrdmVgIVP8LtO
         JAS/VBkGt865I8mT4hGp2QEHIqHE7pG3JSGq0mOzuZ0ATCnMIuVUEWd4L4k5avHqkGRJ
         D++GHI8TnFZEAcu9nmh8QQQrX5NOOcrLes7LiZQgfr2A72hWbLhVLhIPOD5BA91TABNL
         ZmoXVlir3hB2ij3/h7CoePp5anwEgLPwPMPOa1GAzQ99HOr/FA9Ug4JzTOkjabjZQj0p
         751XijlJpbuWZo9fxGj//ZzLfrPKFqgttEYZs5yztPyudfTVVhacitxkoA5pn+oO56e8
         C6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTWpkgyYfOHy3y4Jp5i6JqopHKwJXuLLzX0zeWSK5zuQoWGBT1hCMsbN7MKQ9wypuQL8L7oFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHaR96liMniHLV0K4BnYO7KkDwH/O9c/24+MX0lfR2Kj9FtvG
	uIgsuGJL/ONlJXkNQbt/C8faiyQWTvC7MbncCwMMy6hyEg4zQvUHf1CPUcbXOOJ44t7dvXOBTTs
	Rbd+Ke710QOzNhNyjYNro6kYQdCXqDydRqaU/NBHaIbyTJLVaucmi9Q==
X-Received: by 2002:a05:600c:524d:b0:431:5465:807b with SMTP id 5b1f17b1804b1-432b751dcc3mr97623575e9.32.1731333083664;
        Mon, 11 Nov 2024 05:51:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdl1MVOk6cXvoplWf4kpAyP0Q0PfmfJirwFRy6M9tNvfOSuKn0TM0JJ3TMSOe/6ZyakDUOBA==
X-Received: by 2002:a05:600c:524d:b0:431:5465:807b with SMTP id 5b1f17b1804b1-432b751dcc3mr97611965e9.32.1731333055694;
        Mon, 11 Nov 2024 05:50:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:7c39:766b:279:9fac:c5c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bc468d94sm68340235e9.0.2024.11.11.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:50:54 -0800 (PST)
Date: Mon, 11 Nov 2024 08:50:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com, christophe.jaillet@wanadoo.fr,
	cvam0000@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com,
	feliu@nvidia.com, gregkh@linuxfoundation.org, jasowang@redhat.com,
	jiri@nvidia.com, lege.wang@jaguarmicro.com, lingshan.zhu@kernel.org,
	mst@redhat.com, pstanner@redhat.com, qwerty@theori.io,
	v4bel@theori.io, yuancan@huawei.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20241111085050-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 83e445e64f48bdae3f25013e788fcf592f142576:

  vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)

----------------------------------------------------------------
virtio: bugfixes

Several small bugfixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dragos Tatulea (1):
      vdpa/mlx5: Fix error path during device add

Feng Liu (1):
      virtio_pci: Fix admin vq cleanup by using correct info pointer

Hyunwoo Kim (1):
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Philipp Stanner (1):
      vdpa: solidrun: Fix UB bug with devres

Shivam Chaudhary (1):
      Fix typo in vringh_test.c

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

 drivers/vdpa/ifcvf/ifcvf_base.c         |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c       | 21 +++++----------------
 drivers/vdpa/solidrun/snet_main.c       | 14 ++++++++++----
 drivers/vdpa/virtio_pci/vp_vdpa.c       | 10 +++++++---
 drivers/virtio/virtio_pci_common.c      | 24 ++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h      |  1 +
 drivers/virtio/virtio_pci_modern.c      | 12 +-----------
 net/vmw_vsock/virtio_transport_common.c |  1 +
 tools/virtio/vringh_test.c              |  2 +-
 9 files changed, 45 insertions(+), 42 deletions(-)


