Return-Path: <netdev+bounces-150169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790149E95F3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01982164F1B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C23595A;
	Mon,  9 Dec 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhfNqc7M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DC22ACF4
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749611; cv=none; b=mBTdSGKWcpwkoPd1nN7J+BMVQYlBx7rne05CezvP1Kxb+YKgYjLYKe1ICEdSDA+yqnCmEhr42X5s/1ZhIh/t5q27umqmCWPmatFHFcEYoN1I1e5cUBOEmg+gVWv9WqBeKgNEXBiTQy+NX/t79ypO5tpJwQKE3z+Zz7iYKImtK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749611; c=relaxed/simple;
	bh=Uqm9vlD4EuHqqogtqTHA9FO+0cpdFzd1I9e7PeN+AqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfJm3mp/Kx020iWKHyVyyeF1NJ+z/ZlppSwQuG4NGDGFXUF4myI+R4eg1PbmRIk77/JWEkGnSV1KJbNzwmUICv3ZQomn5n4SNWA/Pj4FgfwquJaiXpAgS4MyJj2xRKRLh5tiMr6W3TPziSCu/dzUSeV3dxhqy/JcUqxzLPVpqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhfNqc7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
	b=dhfNqc7MJp4Uc0kHPYA9qUjR4xgS1Hd3vKJIWKN6aghVP4R7xf6g7hGxyJMOoeFrrmsKXU
	P+7a3W+dSR7ZpLQxEtJyaPnrHRXY30Kvcjub39t7WIoE4JycY0eS773IkBIZaREM0bCXUR
	r9Runukywn7xoZjecnY2SWuHzTJHVg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1fDcuyZsMWyMzaQ4wXGduA-1; Mon, 09 Dec 2024 08:06:47 -0500
X-MC-Unique: 1fDcuyZsMWyMzaQ4wXGduA-1
X-Mimecast-MFC-AGG-ID: 1fDcuyZsMWyMzaQ4wXGduA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e03f54d0so1754209f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749606; x=1734354406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
        b=Cj9JXtd9Tg35L0X5kDoZJoSQcCXZxu2kG3u2EfvKOl7xBOxLLXpjAbtK4oHnpo31MG
         ZsiHPOyPgjjE/95bsN6hBF6NcsezZncfPgzQ6s74cKZm4qwosxRSWvnP+071uzO9NI5j
         cz05+MgNNQvBV9dskwCc5EaTLr7aanz37NvjqvvX1hNJL+qJY3MYlMDIeDLwLpR4pIwx
         F+xpsL37foakWUiZg4YhKYHT9AnN+aeX2/bjOVGNUakRcWb19RI99uGIe6BOu7AylTTj
         0O5WixJtnGNkRRObq8OKYB29vbAzLmOLhl3glJ6rqtMJiSSvpMVZxiSb8Xzfj9SQC3UC
         BlZA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3pw2pldF015H7HwegDPh5jpVW/xBrTDGfB95DVrHGLwvIQ1hheyqoEMZkHoEqhQebkUme1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkJnTeC7KXDCRJGD5LxfTkLeZa8zAx4LerS/4MqCt4P160sUY
	HiYWz2vRv3VtX+pB1zPyD+B6JQ343chGJisOCkIB/NlX40qfiFHqmQBdClQuVEGPQGMxg3Ei519
	TMZw4xyoN8Oqq76t1ptPQTQVKor3QptiG+6yeWmUYlKqQtm0a5fyqKQ==
X-Gm-Gg: ASbGncufl0sogaH3XvwMA+hCiOO7ZGpdSWG9SM5cTEmsZLpWPTy5MwAnLlxndjXmy0l
	B7UV3TRxIPm1IqDWHUHNkTr2f3LcXHEYCySP2lXAHffv8jwWuBwqjK9H2tGPeRnKCizI3WnGoYE
	VGEh4YLbWOl0zUzmoJGaX+sVQF/CzU1UeT+ivzeti9fg4+RRg9T5h3BokZxg7LIFXXcPl0wN/IZ
	jEV5jD/w/rJD+uH6U9PYzeI2a5RKEHfwg1CEYxtXatcNDCdiBBwMPL3P/3Ahe3zu7q8Et5MU6uQ
	GXligMyI
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451300f8f.13.1733749605732;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3aZqcp+qWXyKCP+s6A/eeOG43m5kb4cM7P1FP5MJVsW/bqky4A5d7q1L7C7R7quzo+4CpVg==
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451253f8f.13.1733749605217;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:44 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 00/11] Remove implicit devres from pci_intx()
Date: Mon,  9 Dec 2024 14:06:22 +0100
Message-ID: <20241209130632.132074-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Driver-Maintainers: Your driver might be touched by patch "Remove
devres from pci_intx()". You might want to take a look.

Changes in v3:
  - Add Thomas' RB.

Changes in v2:
  - Drop pci_intx() deprecation patch.
  - ata: Add RB from Sergey and Niklas.
  - wifi: Add AB by Kalle.
  - Drop INTx deprecation patch
  - Drop ALSA / hda_intel patch because pci_intx() was removed from
    there in the meantime.

Changes since the RFC [1]:
  - Add a patch deprecating pci{m}_intx(). (Heiner, Andy, Me)
  - Add Acked-by's already given.
  - Export pcim_intx() as a GPL function. (Alex)
  - Drop patch for rts5280, since this driver will be removed quite
    soon. (Philipp Hortmann, Greg)
  - Use early-return in pci_intx_unmanaged() and pci_intx(). (Andy)

Hi all,

this series removes a problematic feature from pci_intx(). That function
sometimes implicitly uses devres for automatic cleanup. We should get
rid of this implicit behavior.

To do so, a pci_intx() version that is always-managed, and one that is
never-managed are provided. Then, all pci_intx() users are ported to the
version they need. Afterwards, pci_intx() can be cleaned up and the
users of the never-managed version be ported back to pci_intx().

This way we'd get this PCI API consistent again.

Patch "Remove devres from pci_intx()" obviously reverts the previous
patches that made drivers use pci_intx_unmanaged(). But this way it's
easier to review and approve. It also makes sure that each checked out
commit should provide correct behavior, not just the entire series as a
whole.

Merge plan for this is to enter through the PCI tree.

[1] https://lore.kernel.org/all/20241009083519.10088-1-pstanner@redhat.com/


Regards,
P.

Philipp Stanner (11):
  PCI: Prepare removing devres from pci_intx()
  drivers/xen: Use never-managed version of pci_intx()
  net/ethernet: Use never-managed version of pci_intx()
  net/ntb: Use never-managed version of pci_intx()
  misc: Use never-managed version of pci_intx()
  vfio/pci: Use never-managed version of pci_intx()
  PCI: MSI: Use never-managed version of pci_intx()
  ata: Use always-managed version of pci_intx()
  wifi: qtnfmac: use always-managed version of pcim_intx()
  HID: amd_sfh: Use always-managed version of pcim_intx()
  Remove devres from pci_intx()

 drivers/ata/ahci.c                            |  2 +-
 drivers/ata/ata_piix.c                        |  2 +-
 drivers/ata/pata_rdc.c                        |  2 +-
 drivers/ata/sata_sil24.c                      |  2 +-
 drivers/ata/sata_sis.c                        |  2 +-
 drivers/ata/sata_uli.c                        |  2 +-
 drivers/ata/sata_vsc.c                        |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  2 +-
 drivers/pci/devres.c                          | 24 +++----------------
 drivers/pci/pci.c                             | 16 +++----------
 include/linux/pci.h                           |  1 +
 13 files changed, 18 insertions(+), 45 deletions(-)

-- 
2.47.1


