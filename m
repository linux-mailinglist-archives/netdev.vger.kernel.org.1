Return-Path: <netdev+bounces-136116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29739A0608
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C1F1C23527
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31532076A4;
	Wed, 16 Oct 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Qt4bSe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06212206E9C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072171; cv=none; b=t9O5VACnr9MKVWurbc+9WY8ojFY4bZM+RAN3VTd1PuVH/wVwbXBl9TO/zYUYVC0o1dbf4PxtEn4NjKC/8kYeH567tEEgpn6lEutawF6Wyib7cr3nzo5FWznEzZw7I+5bPWTFp+87LskYspNBxPbomO+eQOFSs0utzbLGVmOBpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072171; c=relaxed/simple;
	bh=+7VXObVbimU6RXAVe8MLDd0WB1BZiq/LjoM6c454k1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnJuHotd+ZLj0rsn4PyHrPow03XzaCzg/jCLvPUvEnMrZUK5Bze/Uj21yGTxT/TOpj2BvPaoIZAWqPvw31vz1GSg1v7OabUtmOSavZUyk6yv9MgzX0/UgTo5zkmISLXCxn3UGTVsjhTlbiWd3/PCZvaFdjS//ezKlr17C2XejO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3Qt4bSe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtS5zdbiO/gsUv0EMgDDobhsGGQ7SjCkZAyLsDHRQIY=;
	b=K3Qt4bSeAmGh+oYPvOE03HinLJ5FhMVPVIRofuQLGx1KFMLLMlbb8T2SYJSoSDZaJ3dD22
	FQm8DA20CSMqP0aQHa3J2wIYhSB7y2t8U7NFUkhns82Nmp3fGJjq0k4V47drwy7SzBO0QR
	qiqmvFj6rFREzPpEgqq19+IsI0ffwLY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-9cmUtcM-N0KQ8or-ZhaCEA-1; Wed, 16 Oct 2024 05:49:22 -0400
X-MC-Unique: 9cmUtcM-N0KQ8or-ZhaCEA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d49887a2cso386593f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072161; x=1729676961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtS5zdbiO/gsUv0EMgDDobhsGGQ7SjCkZAyLsDHRQIY=;
        b=poctUe9ZEw/2WZ2eR1O3mIyv2DgXBk/I1SKk2MnHYiNFY15XU5weiMe4rX1NvzoiOd
         xtStvJltOegNxvPc5dPd6r7cHqJ7I9DK4DCgFwpu2I26L/RNNF5HSoVdLV6QCQb7eic0
         L+fQTpvyLWTrQJWKcDY90WNNs0tUpo4/ZVvWP1vYe1VSd+aJ7K6gNcQ2mgwwpiT0s6WN
         2KYwCDM+Qj3nlDPKcBgSOb+7GVEuUAvkWHDbxbJxFvAnXuvqgoxCfzi5yL0UhyIgM04C
         pwwZtWCtsjjRSA8vqmMu2qgNf43GSqkCb1PxoVXKsmJxeWscMJkTafRLpsFf/TGXf+0G
         9ARg==
X-Forwarded-Encrypted: i=1; AJvYcCU4XAQq4+eFaWhRrm+j5aBPROXA921rU7BMgJ8Zr0uO/Ykl/RYYYRXior8339ekg3BpryXbMrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznK1uYRCaAnAgTSbz1Xv+8/zxdmOSe4jprzs0nEHvdNP4EZPIu
	2amTvkfjtrrqA2pfOBIUXcs04x2JIks37LTMY3mdQPflinooTm+za9Cxeri4vXtNiSrZ/CuEAHG
	046Lb7ioZoazmABgfnqGUH/LCeWqmiaUp9NS6QeQTdDhwq3DotrwYfA==
X-Received: by 2002:adf:f751:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d86285f99mr2815649f8f.11.1729072161042;
        Wed, 16 Oct 2024 02:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaiw/v72XpyvrLMQueXB69KM2bCaEPDc1zEe4UONM9jeIbxwKmu8+nYGsv9DDcnBz2ZvwW7g==
X-Received: by 2002:adf:f751:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d86285f99mr2815611f8f.11.1729072160611;
        Wed, 16 Oct 2024 02:49:20 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
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
Subject: [PATCH v8 2/6] PCI: Deprecate pcim_iounmap_regions()
Date: Wed, 16 Oct 2024 11:49:05 +0200
Message-ID: <20241016094911.24818-4-pstanner@redhat.com>
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

pcim_ionumap_region() has recently been made a public function and does
not have the disadvantage of having to deal with the legacy iomap table,
as pcim_iounmap_regions() does.

Deprecate pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 7b12e2a3469c..a486bce18e0d 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1016,11 +1016,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
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
-- 
2.47.0


