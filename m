Return-Path: <netdev+bounces-119815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D29B957138
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B818CB25A0F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68318A6AD;
	Mon, 19 Aug 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX1impfo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3F18A6A1
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086385; cv=none; b=YpbVISp4F/3ZDtsgejBTsWz6byWcImNT/x8at3V3OHYJvllxS2Pg6X4rkva+N4hlG/JcpO8F7G6n+afjp5gvfMZC4qucwLKVdmGF8CgWZEs7IUGfDo82UZlZ1qGPFGR4ApL5e7TwpmyLEtq7i5NZKLqkYqPlXHVi3WdNpNguTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086385; c=relaxed/simple;
	bh=SgQa/apEnyQVxi5RGIOMYDsJA8zmcu1/aNTE/QznKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7mjGULXC4bC7+VlyDpHcSLGMiDJPXK2wshUgu2sToxtGHxhkK50Cvud8IS7VXGNhWDvunKeeFX3hL609FVrZcx5lpYXnxxgVhrXAN2rTw3+bx13IvXw9SU5UvGlZcf5ykn3kI2VuLvrENgk77cpxIJ0Tp+rOYe5Dc0okUc5WF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bX1impfo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
	b=bX1impfoTJfuOtEA1bl4nQjb8tW1/N8+RyzQyT4ZBWsame3LYDmYsXHowCSy6WqZh93Xbv
	oAKHUqLOcWv99zOc83w3ORKI7bRVnSXoxpKBlHCouxcswhZyKTrDzVAOeYYLK4m4v7u1P5
	xjI1SNPvD+2l7P3D3GGH7CIn+1zaUP0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-fdCkR0eIMmaIYkPtsuD-Gg-1; Mon, 19 Aug 2024 12:53:02 -0400
X-MC-Unique: fdCkR0eIMmaIYkPtsuD-Gg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1db58059eso6059685a.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086382; x=1724691182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
        b=tQFpBF6Pi/2GSWOTnYLpjLOXf+gmeYtbmUvBrNssGXKkZ20YHLJKix67mi+R+flXLT
         9ZCCuCxW0yfYiDEmckoYnkWfO1LUGU0ZmUdCvPxDGyFf0bjkhnKemud9/lBn9mJUs+CV
         bBkCAK/NsVarBMPvZWWiaxNACb2FUMpS7ppYj/ew4gFOJMh8blyq4wuhnmjEe6ZIHEKR
         Iml6flrVqD85eVYQgINs9AVUwY5eGyJ9+0TxE1C9RffVDOyyHFnjjtDTtkC+MR0l8iur
         zXfZZP3DTlP/SJypeM1GZBZcURrbt+VilYGAy8Tw6k0Pij/85o/CSOMqpIWeEJSaTVAl
         P/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+39RQ91LZVn65QYFnOhOlTW7i/BwkU5mbDmUgM3E7W81ZZmJmx3PxULA417IqrihCPGY7GHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyAegpePlG6HAW+Ifc/sZ2+41grK96zjsS6yWpzqHXq569Hcq
	KJfa6dHrIjq9jcFBYjkDf3ifkUGJ2swD6QmSKzwG/mAMJxITSkf3AFUElhGGQMoo5hL0BwxzORm
	bgAVVvFe+HMrgIbEsjfjxBF6+59deKS37YBnH3xY5gkPAuExSLTWRyA==
X-Received: by 2002:a05:620a:17a6:b0:7a4:ee81:b81 with SMTP id af79cd13be357-7a5069097d7mr907155385a.2.1724086381788;
        Mon, 19 Aug 2024 09:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6gYVZPDs45ylp2PC1pdcluR4bdODQrU3S0OZZmC5BxWlFh+hxwevOPD/dWhGJl7MG9Gdkw==
X-Received: by 2002:a05:620a:17a6:b0:7a4:ee81:b81 with SMTP id af79cd13be357-7a5069097d7mr907153385a.2.1724086381333;
        Mon, 19 Aug 2024 09:53:01 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:53:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 6/9] ethernet: cavium: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:46 +0200
Message-ID: <20240819165148.58201-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with the function pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..1849c62cde1d 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,11 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
-	if (err)
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	if (IS_ERR(clock->reg_base)) {
+		err = PTR_ERR(clock->reg_base);
 		goto error_free;
-
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	}
 
 	spin_lock_init(&clock->spin_lock);
 
@@ -292,7 +292,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


