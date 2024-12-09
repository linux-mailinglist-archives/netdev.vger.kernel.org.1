Return-Path: <netdev+bounces-150177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2DC9E963B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88F01884EBC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0153231C90;
	Mon,  9 Dec 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxlPQiWp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89E234989
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749629; cv=none; b=gFjngEc5YwYNx6Wyv1xlBr8AlYGIP7eFaVtL4bfrUHgziU9JpwGAGiyHVAjlWt5qyz8XobnQVXEyCcJHCHghAR51UumWFppPwISAwgmcB5/JE8PJTpuFBWfp/4RSNG1rMt675S8elcGasILFcmIp2zaJncEAa+NQsCWamitul1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749629; c=relaxed/simple;
	bh=p0/gWxUTpmVAZUhoNYoMEndzzz2nBwZ50lbcwipiIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNrEKSdcmyYjxtOAMROkLLoN5f4yISeuzeNlWTtUO9BJiYL4Ft3qYnhcMGj1OkoB1/G6+t6v83MMIvPzT1abvme82xvo915VMwSukvzxzmMfsc4URWPFE17gIYa/G0imL7KkyFqaMw3T3qsqZi0vsFd9+17x2NlqIjZr7MN9ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxlPQiWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGrvh/xDUNx0Zym0wN3Xe7A7dJtO5ZhSWVvmuSF27ww=;
	b=DxlPQiWpe/5RCR4xkSqnzAWODBTlqsBuqj0qy5i56qxhknSICU1ZamIRNAMM9KdnujzDKt
	wl2XmvQTFUuwk92fbqesSeRvAuAZnGTMjxDYGWsJKOdEbEHGRw71K6cdaqVzDUeIorXYTx
	k2XQEKItSeOVJiIei8Mqu1QRxqD9rvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-lcOTIrjJMaCTY2rTp1QlMA-1; Mon, 09 Dec 2024 08:06:58 -0500
X-MC-Unique: lcOTIrjJMaCTY2rTp1QlMA-1
X-Mimecast-MFC-AGG-ID: lcOTIrjJMaCTY2rTp1QlMA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385ded5e92aso1674302f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749617; x=1734354417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGrvh/xDUNx0Zym0wN3Xe7A7dJtO5ZhSWVvmuSF27ww=;
        b=QRV68kCday5UHGqitYH1Lww+mDZtPiBmB14lgTUOgipxISCO/sKE52ce1jzYDgaXNq
         JtztWvLJLm6BHqvcaZpiDrtnSE0CynGCWPp/z4I6wVSLD7GYJuGvLwIOOJMHHzCRu1Vw
         EGDZ+GVkPVjFB6XEqXiuINCR/YjSXvc51vVP6otHmtAJ0BIpCfX0TjB/41FeXJrCuQmO
         7QetdcSTfDiTRPSSki6pm4QPxjeq3bLK8mqZZ9rcIkABiJRg0MW2ddGy4Dj3C+QY66HA
         /3sC7yPvZr1OtUfVBmTjKUpgEpumMrHBh1VCb0DvwNom1YBrNeofEc2r10rxrJ5ysKMm
         72zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwAItdz/SSJVmxsgiMFGoqsKdnxSeV/DTOQDGSZ4YSbd1QRtG2WJ5l638dGAk5QesGtd7BUL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNj/S5OmcK3Evx9a/334LIguxAI2zb1779xgWEcagWZrbbjMBo
	upHekCR2wo75syH+tzvS74/P8fOPuJ5DS2ziBwtxCOkUHXPaefFjTTFw6vc7M7eJH6aega1rcDF
	YY/3aqkM0KiN7D8Xv9A9qZYZ0hadpyBmz+xXrzDYclAV6VHrdFP6hGw==
X-Gm-Gg: ASbGncv00+7AyCIVFwzRZzenMcECHGoDPIHJYt6Bv1TGHY/GlxgDFrgwTq/VafvdQox
	/NpgvXMVaT79PLU3OJQS9yIeGflkN/Y/yZgGGM4gh6PtuCD4sd5GO9bbpReleRV2Jmcph2xpOOv
	MT2LBOEXL2rRtrEqrxrIUpTBWQG3Nw84T25fpGiNwTSoSyZU29wwhPdw43iWWA5isdZJOKpGT31
	MOgcsDnLhfA06W530UYlmwfLEQasxfwg3Ksd2o79UKDFx3tqLz+KilxDh6MusLKiT5mhr51PrM8
	ktv3V5Vq
X-Received: by 2002:a5d:47c9:0:b0:385:db11:badf with SMTP id ffacd0b85a97d-386453d6c46mr225653f8f.22.1733749617420;
        Mon, 09 Dec 2024 05:06:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+w+VXnhTGgYCQrqoxE7Q0eQycE2/xL59lBRJp9LXmIJ3oiAACyABfaofCQ1IoSgKVucKxLg==
X-Received: by 2002:a5d:47c9:0:b0:385:db11:badf with SMTP id ffacd0b85a97d-386453d6c46mr225568f8f.22.1733749616959;
        Mon, 09 Dec 2024 05:06:56 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:56 -0800 (PST)
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
Subject: [PATCH v3 05/11] misc: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:27 +0100
Message-ID: <20241209130632.132074-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

cardreader/rtsx_pcr.c and tifm_7xx1.c enable their PCI-Device with
pci_enable_device(). Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 2 +-
 drivers/misc/tifm_7xx1.c           | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index be3d4e0e50cc..e25e6d560dd7 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1057,7 +1057,7 @@ static int rtsx_pci_acquire_irq(struct rtsx_pcr *pcr)
 	}
 
 	pcr->irq = pcr->pci->irq;
-	pci_intx(pcr->pci, !pcr->msi_en);
+	pci_intx_unmanaged(pcr->pci, !pcr->msi_en);
 
 	return 0;
 }
diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index 1d54680d6ed2..5f9c7ccae8d2 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -327,7 +327,7 @@ static int tifm_7xx1_probe(struct pci_dev *dev,
 		goto err_out;
 	}
 
-	pci_intx(dev, 1);
+	pci_intx_unmanaged(dev, 1);
 
 	fm = tifm_alloc_adapter(dev->device == PCI_DEVICE_ID_TI_XX21_XX11_FM
 				? 4 : 2, &dev->dev);
@@ -368,7 +368,7 @@ static int tifm_7xx1_probe(struct pci_dev *dev,
 err_out_free:
 	tifm_free_adapter(fm);
 err_out_int:
-	pci_intx(dev, 0);
+	pci_intx_unmanaged(dev, 0);
 	pci_release_regions(dev);
 err_out:
 	if (!pci_dev_busy)
@@ -392,7 +392,7 @@ static void tifm_7xx1_remove(struct pci_dev *dev)
 		tifm_7xx1_sock_power_off(tifm_7xx1_sock_addr(fm->addr, cnt));
 
 	iounmap(fm->addr);
-	pci_intx(dev, 0);
+	pci_intx_unmanaged(dev, 0);
 	pci_release_regions(dev);
 
 	pci_disable_device(dev);
-- 
2.47.1


