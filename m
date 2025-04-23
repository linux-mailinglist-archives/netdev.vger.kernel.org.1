Return-Path: <netdev+bounces-184985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154E5A97F75
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385283A8059
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121FE2673AB;
	Wed, 23 Apr 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxiEBmsJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB5266B62
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390569; cv=none; b=lffFFfjsfBk6i4oknMa90wF5PnJLBQUQdpsct0ugtEvipYrC3f/WUrukB9F8ObEMuBohYv2dG1TwYhm6rb3GfIg0Sxj0I3w1hViT1EjoIZB77fyYFWhf0QQ4YMxGQtMNMqViijB0yyRzvvvusHqQRn/MN6g7KScp/nexPpzcRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390569; c=relaxed/simple;
	bh=1z9o8ll4AHzFt/k/hmidvON8KqNqYeHpKakhn28WR60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bqFEafqRhHGpF44BQ0CJu43Cu8IVz/pHhg2hrkzltZE4/6Q3IK1bZDZ7MzpQ/SFzkkryptbUU/6FIr+1axmbDqeM76cvXqdCHB3z+Ga67A90hN7150Sy1qGBHXJPuevsP4zBld+8AdXNRqFyk76D7JLFaGb1bvKu/I7Y6eN9bGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxiEBmsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745390566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=A+IIFd1CyCLzYQbKkS9qdqGwkTTadepQIc+Dm7g0mP0=;
	b=DxiEBmsJNPum/5wfbykMzpBzzCHSpM95B9wrzU5YCTk52J7e+21iF44F6XZKMRb08/3Cqs
	JHFgVIZGE7cC5sJAoQ4Xb82yu1RMo7bj1SOVwgN7396nw6Abd7ZsYsa8dG54tZzFAbXFRQ
	R0rlEJydtE+T5lXsRdAgu91NMmMUhPQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-P97pTlgMMXW5M6c9pc5x4w-1; Wed, 23 Apr 2025 02:42:44 -0400
X-MC-Unique: P97pTlgMMXW5M6c9pc5x4w-1
X-Mimecast-MFC-AGG-ID: P97pTlgMMXW5M6c9pc5x4w_1745390563
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso241280f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390563; x=1745995363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+IIFd1CyCLzYQbKkS9qdqGwkTTadepQIc+Dm7g0mP0=;
        b=vfxah9q2Szlhgviao5VMAEmih6/29d/lAHi8daEWP1c/U/Rec5HIihJw40X9ODUukq
         Qw+f0uhGM15+ujeqeZLODJcpa43DTHa0h2gv3VxA/QPST7ajZ9GlkvhoqJOM20g0yA9t
         9TB8g2akisQki440M2n7RB+tkEmV9zv4wBP93BWgxnxv9sdcsznM6wFf428nl0o0JgOQ
         Jkp2+drudosUK6dLThctb4cf+iWEvjUgYjg+vyVngtAVg/yo8AqIT3ZuaC7rSiw0v+2o
         JYS/BLW9sFtkImv27C5GtQyaweE2pC8Bem/8dyhbTZzppOWptl8UljQwyB21rKE0ghyL
         MH0A==
X-Forwarded-Encrypted: i=1; AJvYcCWEhXS78dP397FexpDKyyzfBTFAAzZ0C51Xf76BUUTOKml2s1u9IzIqXUXSUxAHuyEk/7Vn/4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfbTYlOoLy+qDIXHJkBALurWYjRx4pmOdRYVSff6SfskLrd/J
	EufYRsbHsmGMd4KVBEfgR84gl/d5MGOh1HSwNP2z++nh9a2w2He0MMC+IZTEqtA8Myx8KdgLXo7
	2BiCScUW8akTks0zITKMMIVAfx05ZiqukyBF+mrIZmVa3/GdquMY3ug==
X-Gm-Gg: ASbGncsX+DDmaBuyz5DIHoT6k4IRWloMU8u/c9T2GAB1+RJP+x1AKnb5FUFddxnsAY3
	0Kp0Qdic241TMUa7UUn6Bwzhr9NyP3B2IEsp0gRJZlBSOyCuaCfKPP1NA2mrJRyzz1Y+S7ivnLD
	M2BPlQ/2ssrnrVTXVDeo/5M4vZa8+TCxZVkrXizODjoXh2QdE4BwjVhtpuit4KMUs1UdDH8krTp
	7Ghq9Cjl1zV5ZO/EfmhNRRFy6L5KK/Ae/qpVzthYi2gkTLo3RPzncuTbEpMpsHR9JDjXIDBSvH5
	pHHObA==
X-Received: by 2002:a5d:64a4:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3a06723c38cmr1327887f8f.8.1745390562732;
        Tue, 22 Apr 2025 23:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfqF3/DnXpz0jT/bVyus2YqORUpTFcY/LdcHG+U6sJT+ZpWhfo0iR0WXLgcAAw16VAtx6A4g==
X-Received: by 2002:a5d:64a4:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3a06723c38cmr1327865f8f.8.1745390562360;
        Tue, 22 Apr 2025 23:42:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4930f1sm17830202f8f.61.2025.04.22.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:42:41 -0700 (PDT)
Date: Wed, 23 Apr 2025 02:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	danielj@nvidia.com, dongli.zhang@oracle.com, eauger@redhat.com,
	eric.auger@redhat.com, jasowang@redhat.com, jfalempe@redhat.com,
	maxbr@linux.ibm.com, mst@redhat.com, pasic@linux.ibm.com,
	quic_zhonhan@quicinc.com, sgarzare@redhat.com,
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
Subject: [GIT PULL] virtio, vhost: fixes
Message-ID: <20250423024239-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 58465d86071b61415e25fb054201f61e83d21465:

  vhost-scsi: Fix vhost_scsi_send_status() (2025-04-18 10:08:11 -0400)

----------------------------------------------------------------
virtio, vhost: fixes

A small number of fixes.

virtgpu is exempt from reset shutdown fow now -
	 a more complete fix is in the works
spec compliance fixes in:
	virtio-pci cap commands
	vhost_scsi_send_bad_target
	virtio console resize
missing locking fix in vhost-scsi
virtio ring - a KCSAN false positive fix
VHOST_*_OWNER documentation fix

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Daniel Jurgens (1):
      virtio_pci: Use self group type for cap commands

Dongli Zhang (3):
      vhost-scsi: protect vq->log_used with vq->mutex
      vhost-scsi: Fix vhost_scsi_send_bad_target()
      vhost-scsi: Fix vhost_scsi_send_status()

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Maximilian Immanuel Brandtner (1):
      virtio_console: fix order of fields cols and rows

Michael S. Tsirkin (1):
      virtgpu: don't reset on shutdown

Stefano Garzarella (2):
      vhost: fix VHOST_*_OWNER documentation
      vhost_task: fix vhost_task_create() documentation

Zhongqiu Han (1):
      virtio_ring: Fix data race by tagging event_triggered as racy for KCSAN

 drivers/char/virtio_console.c        |  7 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.c |  9 +++++
 drivers/vhost/scsi.c                 | 74 +++++++++++++++++++++++++++---------
 drivers/virtio/virtio.c              |  6 +++
 drivers/virtio/virtio_pci_modern.c   |  4 +-
 drivers/virtio/virtio_ring.c         |  2 +-
 include/linux/virtio.h               |  3 ++
 include/uapi/linux/vhost.h           |  4 +-
 include/uapi/linux/virtio_pci.h      |  1 +
 kernel/vhost_task.c                  |  2 +-
 10 files changed, 85 insertions(+), 27 deletions(-)


