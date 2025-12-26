Return-Path: <netdev+bounces-246087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFFDCDEC46
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 15:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 186583005B80
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24863188CC9;
	Fri, 26 Dec 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KowFihcT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMALdV4z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30E2AD20
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766759775; cv=none; b=AG9aUS1Qd2ws0QxZfpng3b8xqMeNHNqDS+eeWRwe9hJdq+HhcF+YOyWdE3hYAz3zHYMHymGOEcZuvyFqrp9PVlZXUIAAbV4LPZh2BTAl5GLcKor1cVYgkw2n8qfGF8QwwIeyWMOfaXQYM1ZfUOrqQgEuFvqD0w57qMq7Ynhkxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766759775; c=relaxed/simple;
	bh=d9E0S3a7Rqh638zbPGkOJvQRUJi3fvoEyv3EnW3OnN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IfwLZipZ/P5ZUfstvoyZesieUgTm9ZHe6VUq93WLYc6NnCqMy4uWWCYUnyu2v+ELMJY2/vBQ/ZJykiA60jVg9piG/i26TbqWZ6F8LebH3L1b/NE1cFGhKvALF3WHrB8wts3bGjEDMtTA+MeM0JASKzup04BSDTpi3hDK0P+Lz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KowFihcT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMALdV4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766759772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aM7UCYg0YYsybtoWO8yD5ljh1de1V9SkAU1INn7RR+w=;
	b=KowFihcTxz2A36nAnd4z3Tv9ZZ4JIb5BuC6eP/7oLy5x9ne8XMHrLVnb5o+fcVaj+ihQfo
	kVqFMMulFV9pqdI8RwnCBuDP77/LIj/S1xBp/fqUlABSEnbICjM1PlKUKKMR264/V9cy18
	mWFIh3h4IuLsyPkecLPMIS4NIZ/2OPA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-D5bOf0CDNLyeyy6lpJ1H4Q-1; Fri, 26 Dec 2025 09:36:10 -0500
X-MC-Unique: D5bOf0CDNLyeyy6lpJ1H4Q-1
X-Mimecast-MFC-AGG-ID: D5bOf0CDNLyeyy6lpJ1H4Q_1766759770
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432488a0ce8so5919944f8f.2
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766759769; x=1767364569; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aM7UCYg0YYsybtoWO8yD5ljh1de1V9SkAU1INn7RR+w=;
        b=PMALdV4z1JbBbAPPflmtzjdvYcZvPxFiMOnR5DFxOYHakMPOhPFsu+4uoyAEhbNjhT
         2PvAdpcEPbfqxzkbRvtCwtI6VFgVbZKzWlhiKnYYjgPr7UmoqykCl2o77YGd+I2HQMjd
         19FeJLITgdumYonYk4hw+qQ1CB1X7n0DzcDnj1mEaWHAnJJwEYIraaTtc3tpSaD7HLxH
         qumSQAgX0jRjPV79pcC/7nDzODsq4FMKn0eze1jgtet37Gta4811Z9XBMDlUBiAwJwXs
         B7bGoBvOra6RvuTV8BgMw9Xjbqz4cYHeUsSXxRlvdwlTm5zWQ7iY8ttqb8+3yk4WTnVp
         7lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766759769; x=1767364569;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aM7UCYg0YYsybtoWO8yD5ljh1de1V9SkAU1INn7RR+w=;
        b=HexqHDOuUGQwx5ylGaO8XbJCad/TJS41UkIeu/+KPgNY66K7wDPXuB0RLEPa3rWvAB
         mVGerYJ9sH3whTi0paZIDvShZlQqyrJKNpvSiosb3uWTdYIbmhMNwRtbdVZ0hNmpjB9y
         lxm8I2IgHbp3AUZnTH/yar9Z1/EKmD45Tx7L+gTtFYKoSQoftAyZUGaXwXbD4rGIge3h
         dKrmGsG2df04DiCtK3abIRMfiWD2X4FALOung+elWE1kgkv2sTPaTD71Ov/qnl1NTPD5
         jxe8AokzzmIjBcHsaP9wui4601tfaLZxYMvVGxL4OlmF1UnupnoAqmbu75ztSUBwMuNF
         D9vA==
X-Forwarded-Encrypted: i=1; AJvYcCVSk4Wm2NQ9UMY1pxA59Y+Bg30W7IEocKdUGiMeNNz2z3wQnW7QMt7iuCIKRV1lzNFbdbwJMe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1Oj12FyP+vb6SxxE1p/KMMilRnlamQUZAS65CrQEjB+GP0Jy
	7+WE+kIxuPjZW1x60om2uqlpKwlh1p97vlF+KXci9kvE57a3uDomaz3hkbebwpkFgsWwtjJp87K
	sbD52AEel0wh5XHUYY8PFRDLUkvU20Hm50XwQQJ98aAzjv1qZxQn83gwMpg==
X-Gm-Gg: AY/fxX5srtzZkwhTC5thCy6IE//BTxqkiFJG+SFLPn70FNej81UEuqIvJ1gy8bp/yuI
	RSH7jqX98AYf8X4mo5cXEbErZCocdqbM/I0uD+u1AdNeCS7fQXffno4yywrfrSbhQGMVXtdiAIy
	VC5h2zeL2Moekq6nrbsuJBahgDyLPUs/yNWjHIF/FtNFy4sDt6PUnyLBsiHs6P/w5QR+Rsd0Mw7
	l9zlPhtf6bs9nWuV6WDhTzxqvosiczksPv/rzQqMeLsiHSciMw3LVnPvqdoNpj84FwrGEktEZSO
	Lq54OoV3PPXJtK1mUGXw057/Z1PazRG4AZHgIHfdsh/Y+Px7rizUDRmex+Iw63FKQvvdCDfNHdk
	Opt2kG6gox1/nUNo5r/Xza2W81j0zwhc37A==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr25656357f8f.58.1766759769356;
        Fri, 26 Dec 2025 06:36:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Ues0XID2D7Q3Cetsq2JyqnGEmS98rxaQOa4ee9lE0/h9FUcNthZgz/uYJCKJdZKFGsTz4A==
X-Received: by 2002:a05:6000:2403:b0:431:35a:4a7d with SMTP id ffacd0b85a97d-4324e708fe3mr25656311f8f.58.1766759768817;
        Fri, 26 Dec 2025 06:36:08 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08efsm46051829f8f.29.2025.12.26.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 06:36:08 -0800 (PST)
Date: Fri, 26 Dec 2025 09:36:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20251226093606-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d8ee3cfdc89b75dc059dc21c27bef2c1440f67eb:

  vhost/vsock: improve RCU read sections around vhost_vsock_get() (2025-12-24 08:02:57 -0500)

----------------------------------------------------------------
virtio,vhost: fixes

Just a bunch of fixes, mostly trivial ones in tools/virtio

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (14):
      tools/virtio: fix up compiler.h stub
      virtio: make it self-contained
      tools/virtio: use kernel's virtio.h
      tools/virtio: add struct module forward declaration
      tools/virtio: stub DMA mapping functions
      tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
      tools/virtio: add ucopysize.h stub
      tools/virtio: pass KCFLAGS to module build
      tools/virtio: add struct cpumask to cpumask.h
      tools/virtio: stub might_sleep and synchronize_rcu
      tools/virtio: switch to kernel's virtio_config.h
      virtio_features: make it self-contained
      tools/virtio: fix up oot build
      tools/virtio: add device, device_driver stubs

Stefano Garzarella (1):
      vhost/vsock: improve RCU read sections around vhost_vsock_get()

 drivers/vhost/vsock.c              |  15 ++++--
 include/linux/virtio.h             |   2 +
 include/linux/virtio_features.h    |   2 +
 tools/virtio/Makefile              |   8 +--
 tools/virtio/linux/compiler.h      |   6 +++
 tools/virtio/linux/cpumask.h       |   4 ++
 tools/virtio/linux/device.h        |   8 +++
 tools/virtio/linux/dma-mapping.h   |   4 ++
 tools/virtio/linux/kernel.h        |  16 ++++++
 tools/virtio/linux/module.h        |   2 +
 tools/virtio/linux/ucopysize.h     |  21 ++++++++
 tools/virtio/linux/virtio.h        |  73 +-------------------------
 tools/virtio/linux/virtio_config.h | 102 +------------------------------------
 tools/virtio/oot-stubs.h           |  10 ++++
 14 files changed, 93 insertions(+), 180 deletions(-)
 create mode 100644 tools/virtio/linux/ucopysize.h
 create mode 100644 tools/virtio/oot-stubs.h


