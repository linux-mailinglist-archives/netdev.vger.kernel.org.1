Return-Path: <netdev+bounces-135077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F599C20E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EB9282E3B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC114F9D7;
	Mon, 14 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM1j4My3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760B14D2A3
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892421; cv=none; b=FViJv87peqAwWpDMms4n9/A/FjTAjRGhc9wftEVBE0qG5+PT4HPRdND8ACx2irBorriZZm5x131102lJFGrh/VU8f+BETPpHS6WGIgL+lpldK+5Sa1Yl3tIWTCQuR274CHiuAxaHobjyPTwveUfe0ENqoDBwxynqTdEh8YG97AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892421; c=relaxed/simple;
	bh=veogpasXu8DFoes2pWWrRajzT/Tb+yGbiuMWIlqIVQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGu3hslBiTaeYzeM7MZmE8wiSfYer/wlaHSbrydLsDNL9WOR9ny8X0HkEFzmqfJaIk6kbmLeHwjcREbFBPxXrdNPybBpROwpobKTg+BeVSXl+q4nxsaR9metzIkaSxBJno4NQw8FtAwHfEmE/h2q8/N9Szf4KT3vcHb/iqfVKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM1j4My3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7W6/l7rxCsNe9vQIzzAVccxaNC6ce1XTcoL6qo42AA=;
	b=LM1j4My3Q37KuKcEbKw93DpXVHPbpwTQtNshxpNiGIOMBIqQgxx6C/ma/EwTGEtYbdoA9U
	uttARD6aP+VrMF6dlF0qywEahqlMeIvV2Sdub01yRk3siQ8+blVRgovR5XDe4xvn6egGBa
	YyoHbCgueFv+S+UT+LRi/sajaEgFZ2w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-5LL_7PI-P8CP9Dq40b2QDQ-1; Mon, 14 Oct 2024 03:53:37 -0400
X-MC-Unique: 5LL_7PI-P8CP9Dq40b2QDQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99efe7369dso135402766b.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892416; x=1729497216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7W6/l7rxCsNe9vQIzzAVccxaNC6ce1XTcoL6qo42AA=;
        b=qynU1tbDkdgLZSBHZXmw+YF0VL3DZrzWlmocFk3Z6ZesAERog+e5hohTfiKEyZUvPi
         XpxFquM8A+j6CBOW1glBWvP7ZkeDpgM9jA6WDPIl7IzLCQVSzndbb1FIgVdpfVeJWoVj
         GPCjhVZyCeVaJiZJeQOJ3LjgoGQH/IEKS2sizaxgB89p8P/UTxYUSOQDfTn6UA7pIuuy
         nJOC5z7cQX18hB2pj1yt43ZKw6xGN/b3xkZj7emcc2HTkKfOrs/LNsTo2zB9Xxibg69R
         2p/0Y1OObT8JNTiuO12ka6l6cAjUN0xrFTH8zFfG2wz311ZuC37KEo9fTZxMPR0gTer+
         ro0g==
X-Forwarded-Encrypted: i=1; AJvYcCUrk4ymsqyYVy59sbTMEx6WXeLytr+xY0TueapV0qqHwqGQkn5JBWZjhwlC4o5gQtOS6awq33I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1x82DEqB9NP7qMlSns5MN45bvd02QzuJJIIqgr0/uPQKJznq
	s1gvBG79kbPnox6e2uZ478VWt3RiTlafZ4M+T0V8Dnybw74VnyOToq1xv/16ZFqI3MN/B0OAAxd
	ASBAsctMGqhaSDk1V3uqYxACM6CXtIYylTv9ibZHEKAjTfSHOcjfXqg==
X-Received: by 2002:a17:907:7ba9:b0:a99:4c71:704 with SMTP id a640c23a62f3a-a99b899df18mr956653066b.26.1728892416367;
        Mon, 14 Oct 2024 00:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcdlsL1TfE08opAxaZFL/GkS8KN4PCrsMz97DjWs5H+hxx58tt0LTAJvoIs9ET3WVAzpRpJg==
X-Received: by 2002:a17:907:7ba9:b0:a99:4c71:704 with SMTP id a640c23a62f3a-a99b899df18mr956650866b.26.1728892415932;
        Mon, 14 Oct 2024 00:53:35 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:35 -0700 (PDT)
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
	Al Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 1/5] PCI: Deprecate pcim_iounmap_regions()
Date: Mon, 14 Oct 2024 09:53:22 +0200
Message-ID: <20241014075329.10400-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014075329.10400-1-pstanner@redhat.com>
References: <20241014075329.10400-1-pstanner@redhat.com>
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
index b133967faef8..a486bce18e0d 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -784,6 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
@@ -1015,11 +1016,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
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
index 573b4c4c2be6..c4221aca20f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2296,6 +2296,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.46.2


