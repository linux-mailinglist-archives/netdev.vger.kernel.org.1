Return-Path: <netdev+bounces-224464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12DB854E1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FDE166B32
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA013263F4A;
	Thu, 18 Sep 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBZy6d8W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7931F9F70
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206512; cv=none; b=QPUYw00lbz/WxyJwDFQ8BQ0fOf2VOahP5pNoZDl7Fn9r4g1F7zPg70Ctkk5Iq137zDqySHl6cHdIjuc+VqKQ90zMaaA9LH402NNTHEK8N8HjHogmUo0qrrI+1/mPRiwdq8s7vOro/i+0vo2wCERhXLO23+R5Dwt2fcyTqG496sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206512; c=relaxed/simple;
	bh=52mzwF50ZysPik2mfGb84bky8NEzJW1dDbmZc78Gl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QcbHgjLm4GpeLXT6/nx619GsuJ1dBg9SMYFuyx1BoEGSYzf3h/2aUUgQXfoRtuOqNnU1YA2sC9Dfxag62F5m5sgukUcZD8asE0lJuxmT37UldG4T5jv8fdHV5yYG528QE8ehTLq5uYtus9ct5PLq7j/ssIId0rBMjGs0zNn43x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBZy6d8W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758206510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
	b=jBZy6d8W3ydjMg2N5kOOKhaF+EDpSX3+9jH4nYUa0Ew/q1lKn5MrskSWICmWfWAu9Ik+M9
	XBC41ZfgxU0S8igzBJzLm3ME72j8wiCngt2wsQCkZxhzHDy6UExkskhPprBGupDmXf+urh
	zDD2FppRgnVeAROkiXIH2dS2GTgqaVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-e9yHRz7eOHevbniv419K3w-1; Thu, 18 Sep 2025 10:41:48 -0400
X-MC-Unique: e9yHRz7eOHevbniv419K3w-1
X-Mimecast-MFC-AGG-ID: e9yHRz7eOHevbniv419K3w_1758206508
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so6321335e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206507; x=1758811307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
        b=iuqLMvyjWKIM6GTSNUhTaXvFjPG+MHiUPDd0puG/OXZg8mkdFL8Bw6HIznhn64rQja
         0T0py5esz5r/YYon8cQQZQhajq6586Sf1mUJcxbxBqd3ELcGOSfycJUoHwTuyZU8Wv0Z
         KLK8f2lFqcsXNVg+YR5MA0OI/OBRuGKLyg5JD9iWrWfKDhqqXs71vkPLLpC2vDW+s5Nl
         9iPvVRKcwUCaeB4UFRIElavn7QbwMZkEEAXnLJYlUBvuGA72vUbzuM3hVJn15L3d6BtZ
         6Tz55oT9wkmFU+A/Woswzz7onqZ2JG14DbQBCO031zqr42TKa3SJXLpUWJ3aF0fbFz/f
         iMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXz8NwjRGVhcGHZ1tLr7P5Atai8sEqnK6OdUEmFnVxTTwRcGZ+0OysSh1sna7wWf82oQPtn8As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyi6qDjl1tCha4Fdru+2/AWnyJ+um4Ev+LU0Q/7pv0ioQrSU7L
	LrMdjS0G1Z/zVci9rQalWbQTrlWrs1isWONqS4fxfVCq7Lyhwop/t2jIEJ2tvoiaYIzIE2Pr4qS
	P2U8bO0kFK6RQ92bJST6aBo7yPfy10IReUu2xIt8z/i6O9IANIP4daUF+2A==
X-Gm-Gg: ASbGncumwmi0rd6WmuXR5dHMsuTyy0a5Mx8cCOxbVs54Of8NjEGqDmCER6pBpvj6MJJ
	b2pSp84ZuAlbP4dnuGDhYgvmKqpKx/d/pYMExnnxpys752KWjLW9g5EktQya9dewxcZ72r6HN5q
	+fYzvwZj6MOQTGI7Tb/2YNmev9fexx0gTPwGdJf+ongw0+/A92aiARZBtl+L9o7D55wzU1LI0Sa
	lD8Km9bh8VGeJvLefjSkTpHv5yd35EqdVLqEMjYDsbC8J7re3fgyqaTLuUFQlRc4T3Aj6NkMMuq
	tHWAUz8XwUz9cKQY0mKNEilParIhlLO2tjQ=
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947625e9.7.1758206507306;
        Thu, 18 Sep 2025 07:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6KtyNG51lUBBb+796Ksha+xJ3k91Ah4nN79uv8tPH32cwmgf4CIFGIqg2jBve/wowaCq5Rg==
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947335e9.7.1758206506772;
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm42562565e9.1.2025.09.18.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	mst@redhat.com, seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:

  virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this reverts a virtio console
change since we made it without considering compatibility
sufficiently.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Michael S. Tsirkin (1):
      Revert "virtio_console: fix order of fields cols and rows"

Sean Christopherson (3):
      vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
      vhost_task: Allow caller to omit handle_sigkill() callback
      KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks

zhang jiao (1):
      vhost: vringh: Modify the return value check

 arch/x86/kvm/mmu/mmu.c           |  7 +-----
 drivers/char/virtio_console.c    |  2 +-
 drivers/vhost/scsi.c             |  2 +-
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vringh.c           |  7 +++---
 include/linux/sched/vhost_task.h |  1 +
 include/linux/virtio_config.h    | 11 ++++----
 include/uapi/linux/vduse.h       |  2 +-
 kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
 9 files changed, 65 insertions(+), 23 deletions(-)


