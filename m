Return-Path: <netdev+bounces-121037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206095B74F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0429B1F2196D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5A1CCEE4;
	Thu, 22 Aug 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCSxrpT2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7FC1CCB45
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334492; cv=none; b=hgxZejXfRFkdX4NGeplA/rJU4b79VdybzHhjl58wNCydgzdZNIbYkpsLVJq4zhftVJ8evAr3alNhy2i5hgAbVJ5oPcKQh5eMnBX08Vyx2hohfimNEgzU3R85AGiivSHttnPEw+DnG0CaFDi20UEiax/qwsqJzlM3yXsmHQaMRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334492; c=relaxed/simple;
	bh=SgQa/apEnyQVxi5RGIOMYDsJA8zmcu1/aNTE/QznKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsa+qCiydNNuyLniPx80uZMwYHIJPmEx/qgvaDaE6TKiHmulP3ur4ZutUsKH3FwNEtsFv9Muywv9gAqbqTisuv4guwEMzFKalwm6kIqKzESIskVCoBKFExh87Z4OOHFLI3OWUabABV+EuUW4k4/EIaBnv2FryrcHdamL5nZhCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCSxrpT2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
	b=XCSxrpT2HPn8lSweHxx4GumT+UGHU8pcFAWKhL/ohUR7hgEIItBMA2DiqL4XaQu2i6vw5z
	FsYJTcQ5TtXcvFCtqTgXJCFNy5PI54skW3apHeDFD+ogexMA7oGpsXOuC8m/aj2xJJdvOR
	x/jfIqHXrT9jCGRDJeUwNKBZXg5qgUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-9c-ljBxhPO6JDySSun7DgQ-1; Thu, 22 Aug 2024 09:48:07 -0400
X-MC-Unique: 9c-ljBxhPO6JDySSun7DgQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428fb72245bso4640965e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334486; x=1724939286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
        b=ZKfWwABRowNjdQUWMq9sUfvmzPt3FnrRdEv04JiYz6XLh8BGXb6FMlxccHt8R8yj7k
         fJNBKcL5O26E/S/ogzRqHgaTN/Sje0U98sYGI0+byDhxvzSvANNvjqh/sVZUOQCkPPzM
         4S1MnLhVeC0a8v2En4f2JPkrV3i+68NuVo46pxXbNYE4HlkGSKY6s2+XzQUbNyFKoJQs
         6ZMNHgkJJcgu7uq2a6Jz+6Z5ycAxk3zN0bWG3IV/i6UlAAb0f+tGUZU7amPZunlA02qd
         eKix4W1EBwVHt/JAkHyQlYVh/kSDQ7o0DS3v2FVrYWKDLe3xkB1eLPYOyaGqSyTfroPM
         OpPw==
X-Forwarded-Encrypted: i=1; AJvYcCV+b995DafXb88PIoX+fh52nCx0Rui7/3xvSb3CyQzQnjNK5C+6yqrLD77OFLenW1csdTVrzMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nUyvswlXlppo5Avn1BVxuo44Bo8jNxw886M3y9ebyQwq2arC
	GEIwRoC6AgcK+wLCLcdw6WYyu7DE+EM1WenDCUPl9fgEeMPliG5JOAYZuY8gO/2ffx+GrBB8aOJ
	doYRz29Zt0XNEfKIDhWLUaqFyxUjtfqSytRx7vG14CToM0VxKQVK48g==
X-Received: by 2002:a05:600c:5112:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42ac3899e09mr16337255e9.1.1724334486185;
        Thu, 22 Aug 2024 06:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRSoYjY+fRaVMhy3JkraKLBSrGHIYEYva7zoKLHV+1g1iMr3Zs/N1D05tQ7XJx0t0ZIIxXpg==
X-Received: by 2002:a05:600c:5112:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42ac3899e09mr16336835e9.1.1724334485558;
        Thu, 22 Aug 2024 06:48:05 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:05 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
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
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
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
Subject: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:37 +0200
Message-ID: <20240822134744.44919-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822134744.44919-1-pstanner@redhat.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
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


