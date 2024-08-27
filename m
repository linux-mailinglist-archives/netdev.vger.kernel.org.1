Return-Path: <netdev+bounces-122472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF696175F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E228464B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037CE1D2F48;
	Tue, 27 Aug 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bolFp/oA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502B1CDA32
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784987; cv=none; b=VIEDKJPB3Frss78L38tzXYxB6AZRrJovj9gV4g4o8zDg0lKQhZ2Je4rzApJXMdqDQajFK9hsxZKJk0CrYKb/YdId8ynJO/8dJVvDqfx23EYi5NKOqxJb9pRaZyR+hUMxp3/cn9zj2WXG9CtNra7PDOkQY1gG9MbH7EP2vbEr3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784987; c=relaxed/simple;
	bh=LrbzScSKoeO/OuSMvPnyas9t8iaLv9wwkOs1i5Fx+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LchMtguHCXrSUVi3/s99qBSjlH4mBJT+03JjSUakkyd1XfxwXxbELZJGxJ1uwtaJHIkOfHHrw50nF1JIT2S1kvIZ+iWohXkqV8eOv5dv4J5ig6cetuzN+h8mTEQZBenjxvh/fyAGv73Ah+2qctdmBU5JUPlh6rcjOsxnQOdF1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bolFp/oA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
	b=bolFp/oAgk4vl6+yqXqgt4wr3hsltBzUj430YnuCVYZEIPF0WIv6JcT4sxKT/IPiDkrHwg
	STz1Yw7Usq18sa3c7du7aYSRSQJ0pHEvaFUEEM9z0SKl+PT12x9/WWPC0YV4KjoR/80DRG
	KWbDxZ4A4ah4guiK5dc1eCPiAShO09c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-nAl_08ceMe-aaxhmUqnhgg-1; Tue, 27 Aug 2024 14:56:21 -0400
X-MC-Unique: nAl_08ceMe-aaxhmUqnhgg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8677df5ba1so543518466b.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784981; x=1725389781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
        b=Ne70pdab9pCsqybHzf2olW1bAVnCpy+/ovGjIaUtBQ0gCl6lA36YJVzXdRv88ffVl2
         yxsQcdC96BoVTxibEFUYQyuxnWL93MTdxXavwF2uEIE2EbyQK/XfOCnEwUId6DCNV1iQ
         NOym9Ut4ImH4uBk/T3etGW10leStYSdudcGSXvsFUQFqAOzEytyRwo2xuRVUbKWcv9VV
         e+vKgwQrQbh0OyjtNwUmHD/qPYfqTBnpBoryMfMDMDstEY4BkMbHpwOqFvg3HJNCgZ3o
         4Z2tkl0MKYtqnMhYWqFY8csPl7RNwFLUkO7ErqJePNbbg+7yz+jWlLr/g+50quSmP8Zw
         MWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWvHN3WUAzcfr6pLee2TAdA7jnC1/mcUxC1UMNjQLnTEEjB56RsskNmzdW393M4YgPPQ5QPls8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xaDojbTC7GEsqKvYTX8v6r1RLWw4+S08LKfb9VKG/TkUu+z0
	VDuEpmNZ/dGTiIcppypbHd1tHjj+YnCRMxO0TktkMFPQWyjRowvens6Qi7FUax1DzX0K060N2B2
	LsNw3D1c+HAq5NNMN1vmGGIVy6YpuTQ6L6mLErGm7Ymv8iZQYQYLR5Q==
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297768666b.14.1724784980676;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSbDGP3VLJBbRBOwu9OD/wZex1BvcaPqE7Ybh9WpNR4VoxlhFHT2FFoNIIJFNO/012/OwV3Q==
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297764166b.14.1724784980100;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:19 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/7] PCI: Remove pcim_iounmap_regions()
Date: Tue, 27 Aug 2024 20:56:05 +0200
Message-ID: <20240827185616.45094-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OK, so unfortunately it seems very challenging to reconcile the merge
conflict pointed up by Serge between net-next and pci-devres regarding
"ethernet: stmicro": A patch that applies to the net-next tree does not
apply anymore to pci-devres (and vice versa).

So I actually think that it would be best if we just drop the portation
of "ethernet: stmicro" for now and port it as the last user in v6.13.

That should then be trivial.

Changes in v4:
  - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
    net-next, and making it apply to that prevents it from being
    applyable to PCI ._. (Serge, me)
  - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
    stimicro" as the last user for now. Perform the deprecation in the
    series' first patch. Remove the Reviewed-by's givin so far to that
    patch.
  - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
  - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet" instead of
    "snet"). (Christophe)
  - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
  - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
  - Apply Reviewed-by's from Andy and Xu Yilun.

Changes in v3:
  - fpga/dfl-pci.c: remove now surplus wrapper around
    pcim_iomap_region(). (Andy)
  - block: mtip32xx: remove now surplus label. (Andy)
  - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
    occurs. (Andy, Christophe)
  - Some minor wording improvements in commit messages. (Me)

Changes in v2:
  - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
    patch, put stable kernel on CC. (Christophe, Andy).
  - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
  - Consequently, drop patch "PCI: Make pcim_release_region() a public
    function", since there's no user anymore. (obsoletes the squash
    requested by Damien).
  - vdap/solidrun:
    • make 'i' an 'unsigned short' (Andy, me)
    • Use 'continue' to simplify loop (Andy)
    • Remove leftover blank line
  - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)


Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (7):
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  vdpa: solidrun: Fix UB bug with devres
  vdap: solidrun: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c             | 16 +++--
 drivers/fpga/dfl-pci.c                        | 16 ++---
 drivers/gpio/gpio-merrifield.c                | 14 ++---
 .../net/ethernet/cavium/common/cavium_ptp.c   |  6 +-
 drivers/pci/devres.c                          |  8 ++-
 drivers/vdpa/solidrun/snet_main.c             | 59 ++++++++-----------
 include/linux/pci.h                           |  1 +
 7 files changed, 51 insertions(+), 69 deletions(-)

-- 
2.46.0


