Return-Path: <netdev+bounces-217311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A6B384D3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AFE1BA6016
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F02350D44;
	Wed, 27 Aug 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GelA+7pP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176533CE90
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304490; cv=none; b=msw00RXNMIEBT8FTh7XGsM7IcXe+ECV0RZHXPJ3hcRPoXZ3nDxUS9vzBlW3Bx8n6atJuxHvhieLjYFEuWc/j/Pew73SrRtEDQxEQ5jspDBvs994LyTIWBnK+lninwjzrPHSg9fHYHNSf7ypx99Ab3OolnfAdFLo/hsHiZ8/BzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304490; c=relaxed/simple;
	bh=HHk2BSgl9+A5isTV0Es7jKwwEf6+byROFUjgpG/p04U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QQzIO7M5nFRQtEvE3yMMjm/NCVL+e/ZGukQ6ci7JclrgfL6hWKABQgOHX/Thfhs5wwnbsfpS+d2ezhlUpUYN2V6L2NrkFEY22PM4TmQVngwZvc3PisX/I+VxBvajr1yYUxKWuj0atdY+XJyvvK447WwtewZZYunOLxQtnDwRZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GelA+7pP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756304481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
	b=GelA+7pPnMW7SxuDPMTt3rK7sbBuDTFbOH503MbCdYt9472gmkkKNs19CEydlR2laeXweg
	aPaI4NMQuBAg+XB9jJOik77Zez9M+qIJnO4q4HCZSrh4ABmVn6aYQPNUVCHcci/sDMLHNw
	GOApqMFImHVFBLz8kKNKwY/hh0HMqZE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-_s5kHCHMMVSve-DJn9_IjA-1; Wed, 27 Aug 2025 10:20:30 -0400
X-MC-Unique: _s5kHCHMMVSve-DJn9_IjA-1
X-Mimecast-MFC-AGG-ID: _s5kHCHMMVSve-DJn9_IjA_1756304410
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso35074785e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304410; x=1756909210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
        b=eEJQ+B1lQx2MJ62ULVDIWiFL4/Sgo23LGgXBvk+wH68jQdX99qeDkUp/Uh9IyHikUq
         CjP+iw5NkUVJmqFsC17N2U6bUfqS+SmZsL8ay9+y+EoBhIFQJrq6E5eOQ9NmJPmma0hN
         Xee7368PBqwXXdE6SJYchbKqcRFz/6g0BzhTpq5RjIbLaDnS4bYV6eqcVJYr1IYCY7NZ
         0W34b22PjZri19IDDQcr4k0ctTKFt9zEznZ0aSLp+B+4mvI9nuHftgcL7xdMACswy20D
         P+Few2/CVDerVJEIRfEMGDCDVVZQCHp/UCGy4XyWKpg2Bp99vtacsjz4NMvuyYDX93X3
         QSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJZm36lw77QCfEBh+wRQirnBDhuMIxJ2gTGYBcPFjS17WyUghdMjgZf3SpodP3AlenPNfO3S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIunHI00CjKZTFHq3obEpiQu31f2Rq7X9bQ1h0kEta2aVHTUZp
	ijcb5iAyIctbHQAuYOhqtVHWqlbcWyKpDL0d78fZKIdAd8PkcBrBVeIAIEDaTcmSq3p+h+NtlHU
	HcarL50UV3EVdX1NctOyU+gvazNX4KiIMjL5osXETdt3nhas6eFyqvWfQuA==
X-Gm-Gg: ASbGncv0FnHJy3ydR/U2bVwjxLy7oesKhyYsFbSx3a2qY7ov9MxXRSVtmCFBTJgDFw7
	LZCjgDivCo6YA4o7+1yQh0FTtO3mNB7xkbMKx+vQfYqh6Dh9sm+J7eMLV0oTczSDrwr8ThYLemT
	PlGdOwOXt/PMdMjJbmvtrVL6CCi1YTwHPYL63KR/f1U9h8HftbngTj+EwNdlXPaO66wRrF/07Gz
	vhqt1Vp4JNakvFMFJ3xireNthhgGvyhJ8F0QxkGSlzz00JlpbEwEC8lswmqoigiiOdjSAmWyAE7
	pNdRVCyYsB72d3MtE7x2qvEyitHShtM=
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068755e9.10.1756304409987;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKNOtqoYfcFfl5BN6DYFKW7ddCHHcODDT/GXLs1RNGvAT7ubO6RW2Y1yIY5L1Dbp0HoJT5Q==
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068355e9.10.1756304409549;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm32582585e9.19.2025.08.27.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arbn@yandex-team.com, igor.torrente@collabora.com,
	junnan01.wu@samsung.com, kniv@yandex-team.ru, leiyang@redhat.com,
	liming.wu@jaguarmicro.com, mst@redhat.com, namhyung@kernel.org,
	stable@vger.kernel.org, ying01.gao@samsung.com,
	ying123.xu@samsung.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20250827102004-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 45d8ef6322b8a828d3b1e2cfb8893e2ff882cb23:

  virtio_net: adjust the execution order of function `virtnet_close` during freeze (2025-08-26 03:38:20 -0400)

----------------------------------------------------------------
virtio,vhost: fixes

More small fixes. Most notably this fixes a messed up ioctl #,
and a regression in shmem affecting drm users.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Junnan Wu (1):
      virtio_net: adjust the execution order of function `virtnet_close` during freeze

Liming Wu (1):
      virtio_pci: Fix misleading comment for queue vector

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Ying Gao (1):
      virtio_input: Improve freeze handling

 drivers/net/virtio_net.c               | 7 ++++---
 drivers/vhost/net.c                    | 9 +++++++--
 drivers/virtio/virtio_input.c          | 4 ++++
 drivers/virtio/virtio_pci_legacy_dev.c | 4 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 include/linux/virtio_config.h          | 2 --
 include/uapi/linux/vhost.h             | 4 ++--
 7 files changed, 21 insertions(+), 13 deletions(-)


