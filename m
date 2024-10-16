Return-Path: <netdev+bounces-136115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF39A05FF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95061281586
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A80206E9B;
	Wed, 16 Oct 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB5/4qKi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A9206074
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072169; cv=none; b=PXbdaMnNxBrljUiQUCWz37LbddQqBuzFrTBREsG+HwAcnL0m5MUDVMETPVWqRMmEgJ9Ilpo3X/ni9YTz6BV2W3jIrJJRRjrZpfV2LfjqkKO9wDAlHA5A1iIpXMFqkPqp69EkwBO6HAZkIWvv15vOFyYdQ5ONIhiS94tzgrOZp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072169; c=relaxed/simple;
	bh=AIDTKBNi6INPgWrqEoX/M1WCIYgi7NbFsk/YqCNjmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ist8j0m8/J+4GMbjJRgxpoPIVvDhrLzRY9JJ/bEK5nkCBuT937peB0BO3tzQVLEYn7mq6xionPg6HjzE2KvSI8B7RAQv6lbRQAT85AtTx9zUAMbXVzNk4U8h7J3VBnPoKW5cz8gOF2v0ZGPEmtVy27gCgiTQ2pBTqDTX4cMhGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB5/4qKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wzWvQZgtWYEM1IVY+pxRBRf1z1HRk5bBfpP9Hkr1wM=;
	b=MB5/4qKi2MsNHpWMGPWE0nI/RS1VBh7XLeDgDVUU8Tdq1m3blhrnbnj7WL7AUSoBC0y5Wj
	ML6gqyV4+FInGWEelaO3iyPaOBuOAg9lbnAYjrHbhRit0lHsXXtNSztxZfPDzeEL2MCBfH
	+8Lans7bBCB0C3hz+c/i1bzZOiZJbdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-b2BvrmcHMMixrb60FCUS6w-1; Wed, 16 Oct 2024 05:49:25 -0400
X-MC-Unique: b2BvrmcHMMixrb60FCUS6w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431285dd196so25879275e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072164; x=1729676964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wzWvQZgtWYEM1IVY+pxRBRf1z1HRk5bBfpP9Hkr1wM=;
        b=A0GInykQ2ERtSYn1MUczLV29YyZhgLXAU4V7HuVUe2ljY6t+zaCOUZeRqVRxOt0f4h
         rs1iGQgNHqORTcxfeuN5bRVAHK/jNnL5TxEPpYtev3nhOa067Ql8FzFVmL8sQtR1KINJ
         7uYMXdumgjY9qTS1nhszpPPdzI1xMVg3fY2lTSWGi2KFJZNWebO8nvy7sxOR2GFP13ue
         +sG1ddoh4RL6f8jE1R74hsB/BTie1scsE/+TKZfjJ8RrmuLWQ1bquPoc/WCjfJ/RTH/7
         7CFOs5S34xtXgwxGprazvRBHglebpTKlFfo22jEC6ksIXGEqOducgA43FM04CnPoN3c+
         L8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhKfxrUGjyK8Lh/RZEgetC844WHkKpmQen1pmcPQzb6pw6a9pZG1UHHmNvP6Rkcihac0E+mHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1WHMc7yaWhFuGTwWsovk++1PcE2iNDrtQZRDmFePu07/uSGN
	qNAK9zMNTJspbDAPNVG9TVDAWWjdAqoIH0z+jPKvFO2Ssw7EWK7nBl07GrBMOsZ95zXLhd3PHbj
	30almnbCXCgkg+u4PqD1UJdrt0BuT5Yrf9gNBhuNq9Y2DQxNpgv7Jjw==
X-Received: by 2002:a05:600c:5122:b0:42c:b22e:fc2e with SMTP id 5b1f17b1804b1-4311dede4efmr150405655e9.15.1729072164380;
        Wed, 16 Oct 2024 02:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7fGzU9EW+z54YfNFr1pxyVsd7IutBOseOI3u2H3FWr96L1yS4FiMaLxnWP3CY/3VpM3y6Lw==
X-Received: by 2002:a05:600c:5122:b0:42c:b22e:fc2e with SMTP id 5b1f17b1804b1-4311dede4efmr150405425e9.15.1729072163927;
        Wed, 16 Oct 2024 02:49:23 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:23 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
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
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 4/6] block: mtip32xx: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 11:49:07 +0200
Message-ID: <20241016094911.24818-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 223faa9d5ffd..a10a87609310 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2701,7 +2701,9 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap(dd->pdev, MTIP_ABAR, 0);
+	if (!dd->mmio)
+		return -ENOMEM;
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3707,14 +3709,14 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = pcim_enable_device(pdev);
 	if (rv < 0) {
 		dev_err(&pdev->dev, "Unable to enable device\n");
-		goto iomap_err;
+		goto setmask_err;
 	}
 
-	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	/* Request BAR5. */
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
+		dev_err(&pdev->dev, "Unable to request regions\n");
+		goto setmask_err;
 	}
 
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -3834,9 +3836,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
-iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
 	return rv;
@@ -3910,7 +3909,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.47.0


