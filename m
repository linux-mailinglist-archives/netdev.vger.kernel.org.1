Return-Path: <netdev+bounces-124090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE722967F56
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D88B2826C6
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F116EB76;
	Mon,  2 Sep 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2/ZVVec"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59635155A52
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258264; cv=none; b=gmdNsIgzV4dXrvIkUQFup8ZrL+sxsbsiEegALLku9mJNnTtx/HEIuc88Mu/VflnahFtINsY5+Xvgq+ClZ2ZMHMDzRCJ/CPCzUJwS4QFVnRD7e4OOc+wHavWcxIkW69UMoImeSkzovxHj+FitcSwcEE84J/Os88qjJAj4KTOBf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258264; c=relaxed/simple;
	bh=zJ+yRIWc0laMt+VA+WcNeC6inAbzeJDFegXsPKCx36w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGF7tcz0vkocSiGBEaTueWjPwVAf+8i4ZTOrqUxv+0OxV26YSs24+M8EYEXM/l29gJk8/Y/0jIifwrxIdFbTXcVK7TqY2yIJTfsnPgs9P509xrBvqgF8zL+sK08DrnQJZe5YogUMNRwSrq/fS4PcmRMyR6VF2F1vyhl+KMnb1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2/ZVVec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725258261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT8+L1vpUCD1XCsuz0jWN9YX0IbdjrEGcfF0kmNNelY=;
	b=F2/ZVVecpW+W2jnEHH48xfsDYdn7eyd/TdHFR9S8RrOIYE1SZXHUM/7K4RWIA2CI/+PJEI
	Ew0tQ0wRtj4a7Ot8b4kfcQVs+xhHTOiYHL0LnI1ucvqFtqmH5OWEpr6U1gFw5Tx9bhBKg1
	smEByYMTGEuz+6W0QBXcySGOJUPG8A0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-D97Lr-6xNdW3xCqcOv_Qew-1; Mon, 02 Sep 2024 02:24:20 -0400
X-MC-Unique: D97Lr-6xNdW3xCqcOv_Qew-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a80e9af094so613494185a.1
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 23:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258260; x=1725863060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GT8+L1vpUCD1XCsuz0jWN9YX0IbdjrEGcfF0kmNNelY=;
        b=QDPxyE9d1wrCyoc0gbARSDMj4r747GbOIvlrbt/Stn/QEhATykLBad4LKdqtyvDW2W
         xhVw5gMZnQdnmnziokazmwZd1/apxI0Q+ftqRBd6XKiMNKFMisg4xolPVUPf2N2MdNi6
         rxyqjugTTGvZtJhaM6NQWM1enErBAlvgMfIhYAk5sTbNokAMXOoA64ZOrwUWOoRK/hM5
         sFYhgmf/ufMGjPLvASN5fjnggSxpLVhSbmLYy3DsoaFLzgsHslNYzC+03/vd/uYniVvD
         E79DbLjuuCqPiuwTXYo5JTEmxd8uaVq1ET4MwpHwyQm4CTOlhGXhJ9N359BDuohvGSbN
         puKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIeAP4TcQfpksL4Hcyq17rkeGvHF7Ej3jaz0iZ3s5yW9e5Z+qCwt+odDPCy6nCSqdSttcQOe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqqMdg8VWXP1K3aYk3N4e5y0UWGuZYxjQ1Oinym3SNZZmVF8Q
	5rw5AB9VzN8S2kP8SkeRCvTOqztqv8qANLEqdVLGkGTvUJ7cAwRzfxr5xDl5U1A7jum+QIu0pZV
	CETDsPGdM0zQF89DpIXRpEo+Lcui2X/q5qGPzZmXx1lNHeGMQrdW1+w==
X-Received: by 2002:a05:620a:2496:b0:7a7:d6f2:95f8 with SMTP id af79cd13be357-7a804c2a640mr2635377685a.20.1725258259823;
        Sun, 01 Sep 2024 23:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPARd7pINvdoEXA5uo8VzOxTa9IKFSZH5cqNUIddKPjOvMCzbYleHUq9K0UZRMxU4dXhM3A==
X-Received: by 2002:a05:620a:2496:b0:7a7:d6f2:95f8 with SMTP id af79cd13be357-7a804c2a640mr2635375185a.20.1725258259468;
        Sun, 01 Sep 2024 23:24:19 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a34asm389211385a.84.2024.09.01.23.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:24:19 -0700 (PDT)
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
	John Garry <john.g.garry@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 1/5] PCI: Deprecate pcim_iounmap_regions()
Date: Mon,  2 Sep 2024 08:23:38 +0200
Message-ID: <20240902062342.10446-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902062342.10446-2-pstanner@redhat.com>
References: <20240902062342.10446-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Mark pcim_iomap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..5f6f889249b0 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
@@ -1013,11 +1014,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
 /**
- * pcim_iounmap_regions - Unmap and release PCI BARs
+ * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
  *
  * Unmap and release regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iounmap_region() instead.
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..9625d8a7b655 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2297,6 +2297,7 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0


