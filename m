Return-Path: <netdev+bounces-122471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAE96175C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EA71F2488F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E01D3199;
	Tue, 27 Aug 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+U4Vk49"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E111D2F47
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784987; cv=none; b=bc0r7oU7ZFJ/gb4hIfm4P4MjoYwC2LWz4HgDzjGs3USLAe7GfFlYr9ccq1Aoqkz045UrQCCwdD4u8uy79rNdFQUP7CDBYX6RZGabrkVwomobhAYEkJ0laqoGMsDO8QIeXPCo/2HSylMyVR0v/xMJxxU72Xjp8He31vVev36pqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784987; c=relaxed/simple;
	bh=CJHmsoWvlhgXbuGyDeTcSmbhobZOpm0m1tO85FGkGME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVPeUm+7JvwSkCOJErgaUXyx8WLJriKRO/efeU+HrEwqm2/HHSObGWmoupMl3gTCFyIW1HdZzcCYqvKLgRjRV6m4gHhiRFZ7NUBOy6mH1+v7L/vsQKDnraFU9h1oj4/CDW/sP6q1vcKdGX0/59XS0mZPyZeu4FnjvzDKpm2msOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+U4Vk49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBx2d3MnnHRZ9pOfuC8799OJBEwqZxT6CHHpA17gZJs=;
	b=N+U4Vk49KH/5FxOedg6lIqU6ZdJ3jBljkx/caoXKzG1fTLdXgFAKMwy+va5YFWbjg0Snp7
	ZRnrV62Ax2/xiVTFi4Ox8cXX97qg5cNQL+5L2OaZJcGQdLU1OxcgolrcKoYdRIqUjJu+yu
	kZy6dOW2TDLbMIq24zLFxwgHlswOuc0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-jfwGDjw3NY25u5wqVhXa6A-1; Tue, 27 Aug 2024 14:56:23 -0400
X-MC-Unique: jfwGDjw3NY25u5wqVhXa6A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5becb612a13so5347076a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784982; x=1725389782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBx2d3MnnHRZ9pOfuC8799OJBEwqZxT6CHHpA17gZJs=;
        b=Uo62dEmNqaBYFJgDd7XcnlSoitw/R/mMYvChBDisZexyQws1h+NG+YELnWIjssKnZG
         yC8ujFS5uVeTpwyQCtElcLNsoTwjwUVBHYoO7KvqinXUVrFGHPfwRxtTV5DQuuQxCA0f
         M4WTGEo6OqGzEgMn8fdc/MQstPO227sXsB3w3MZo1EavMC/JXFrwOspOyjmQbEcBnDjz
         T7YqNLhUNJ5DLqpQabnDVFf0BGG0Xz0SBtyqyCb3V7XRNKbwxTGza/sPjSbf5rks0iJS
         9c+De93gbyv6vV2iBAus1ELARsY0SQNHLdknRu39yyZX/VqePDYNc3iT3JA97HyJb7QR
         I73A==
X-Forwarded-Encrypted: i=1; AJvYcCUTZRg8XEja75Xuc7bNUqqrhVTe1rxix2+aSWGU9CJfJMD4qvWeWdLld4DMwZNIiXiMdll6EEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj6TbhP/pcO29/jG5hVWoSn2Z19uSI5lBxXWvIDYiAUB39VQYR
	PGa38Xj/yuiSev4D4L6msfNf4IUuRU+QG7ZZZdVecz/UtwqpoOlkjQJRmXuoiigt5ucZSZ+GGDy
	kHdf5LsFhybnG6RR3nYeH5SootSr4i2/copl0D1d50YNuNYC2dMI6aw==
X-Received: by 2002:a17:906:c105:b0:a7a:9ca6:531 with SMTP id a640c23a62f3a-a86a516e4c0mr1224711266b.4.1724784982089;
        Tue, 27 Aug 2024 11:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+d3rlFWbvjaoHkp2NX+cFJBCozxT1sW8jPrYEKKHdJTUQoIyOjTNPbzyIkmF6NcfILE9xNg==
X-Received: by 2002:a17:906:c105:b0:a7a:9ca6:531 with SMTP id a640c23a62f3a-a86a516e4c0mr1224709366b.4.1724784981629;
        Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
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
Subject: [PATCH v4 1/7] PCI: Deprecate pcim_iounmap_regions()
Date: Tue, 27 Aug 2024 20:56:06 +0200
Message-ID: <20240827185616.45094-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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

Mark pcim_iounmap_regions() as deprecated.

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


