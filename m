Return-Path: <netdev+bounces-133540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA999630F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42371F265F7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7318FC9F;
	Wed,  9 Oct 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlcKQg3a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E674188A18
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463003; cv=none; b=reKAe4IIcpgmnHmJrTis8z+Y3UeiJw6bK9NkR7aPZX1nqmG6HetKGE14gdmcbjHeoaBSxveOVip3qczccIcL2TThwibbLzQsIS1iQHOEZdCYtQZFU+vugwJYIxrJUJMdttQckm+Rt9ID7nNplbVZLzjkytAsEqgXqdb+C4JJQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463003; c=relaxed/simple;
	bh=bwupmCthuGaQS+qMZ/7SrXy7Oyd/5BoNqSfbGXSX0bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUZY0BGik1pbBB2TvarWiZx19dcJFOqZYdqYRBdsd3GqeCSr0duIY9wUOUh+fUu4ofkuUazz7k2MWKAwoqai9baNLXTNyBlSecyASCtdMgk4JzZnb3qqxxLQGdd/sD/nTf6FOImORkfgP0NsHxGvfEaFxuPK6dpuwwI0d/hrSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlcKQg3a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mOyNV1blUkGi8SBN/l2nmGqTH8tAJ4tec1wRLOcI2Z8=;
	b=dlcKQg3a8m+Ov6dKMeyzaVgzv5GTg/ltRgXo6J2rEa/VbSXMTlOF36tYdo4ROEvCY6DTnH
	pmlsL6Ol4Q95DfEcPMvKsk4hgHB4hb+Tgt7AjwR3orCVzVmQqdlSbSC7oIE2Ll0ZJHFSiU
	A2cJiEeFaoC2Ro2OAOXoC43KMkpb6C4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-64qNZ35HOe-sB58Pm70Y1w-1; Wed, 09 Oct 2024 04:36:40 -0400
X-MC-Unique: 64qNZ35HOe-sB58Pm70Y1w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7acca6cbe87so1142925085a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 01:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462999; x=1729067799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOyNV1blUkGi8SBN/l2nmGqTH8tAJ4tec1wRLOcI2Z8=;
        b=jbfcZcmFikqOJO02l5JUcrpp34ZJ9UDMojPUQIuI3vL7dCqDMUaxFZbMaKoqeV7bK5
         mCUfO1dz1l4sN/gq2hCp3k1ectxKzMj/1TK+3rwapbeXMKexCTU3euRK6pDVeiMoO7ve
         F8nWsMcxeqTD/SX1JRWMkgzw0cavNvuam8pUlJLuhK+HyvpVxeLk2IRB+HcH1v4a717c
         fTf5qMrO9i3N0rADZJxoX8RXS7jaYURx72jQnZg8OX1uH7cJZ5xl7LgTDh2sjm1D2nOT
         ZXWmsnuKXitqcy73wSnVTG3B8ny4pUc2eNiGbDpRfkHU2ICqhUmmW0t1t2HVZckoUXgx
         ZFtA==
X-Forwarded-Encrypted: i=1; AJvYcCUqp6WevrcTKWdvZfLf6+3y/iAR1QNy0ewDwys+I1JdkiAaoujfO5RG180bGDZEf+Z18ztN1CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtf54fD2HTAXIsQSAz6kZE+OzvJ3aNzFmNtFCpwQt7G1WDsPK
	appuuVD1pgB8fZh1BrMsog7iyEuWHQdnz9MfybNnRoqhLAX1ZIApGpwnow+NzwXmnY/HQw8Zshz
	I2d+ARiliytHdbCW/HGewP71UXa+40gaL0yx3j51M7Wha+SocHa1Y3A==
X-Received: by 2002:a05:620a:29c7:b0:7a2:1db:e286 with SMTP id af79cd13be357-7b0874cd670mr234487885a.52.1728462999324;
        Wed, 09 Oct 2024 01:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU56nfNbRn4xRa9L06f5Bja7V/qokH03xrDBZWS39o5ckdxWurQft3H7j0iSjtDvnBZDt4+Q==
X-Received: by 2002:a05:620a:29c7:b0:7a2:1db:e286 with SMTP id af79cd13be357-7b0874cd670mr234479185a.52.1728462998841;
        Wed, 09 Oct 2024 01:36:38 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:36:38 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 00/13] Remove implicit devres from pci_intx()
Date: Wed,  9 Oct 2024 10:35:06 +0200
Message-ID: <20241009083519.10088-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this series removes a problematic feature from pci_intx(). That function
sometimes implicitly uses devres for automatic cleanup. We should get
rid of this implicit behavior.

To do so, a pci_intx() version that is always-managed, and one that is
never-managed are provided. Then, all pci_intx() users are ported to the
version they need. Afterwards, pci_intx() can be cleaned up and the
users of the never-managed version be ported back to pci_intx().

This way we'd get this PCI API consistent again.

The last patch obviously reverts the previous patches that made drivers
use pci_intx_unmanaged(). But this way it's easier to review and
approve. It also makes sure that each checked out commit should provide
correct behavior, not just the entire series as a whole.

Merge plan for this would be to enter through the PCI tree.

Please say so if you've got concerns with the general idea behind the
RFC.

Regards,
P.

Philipp Stanner (13):
  PCI: Prepare removing devres from pci_intx()
  ALSA: hda: hda_intel: Use always-managed version of pcim_intx()
  drivers/xen: Use never-managed version of pci_intx()
  net/ethernet: Use never-managed version of pci_intx()
  net/ntb: Use never-managed version of pci_intx()
  misc: Use never-managed version of pci_intx()
  vfio/pci: Use never-managed version of pci_intx()
  PCI: MSI: Use never-managed version of pci_intx()
  ata: Use always-managed version of pci_intx()
  staging: rts5280: Use always-managed version of pci_intx()
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
 drivers/pci/pci.c                             | 14 +----------
 drivers/staging/rts5208/rtsx.c                |  2 +-
 include/linux/pci.h                           |  1 +
 sound/pci/hda/hda_intel.c                     |  2 +-
 15 files changed, 18 insertions(+), 47 deletions(-)

-- 
2.46.1


