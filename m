Return-Path: <netdev+bounces-136117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B95BA9A060A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AD6B20A19
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF872076B1;
	Wed, 16 Oct 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOoe6sUt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A03206E99
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072172; cv=none; b=XBwWzOb37aATASvEJIfTAVeMd+McyjROYjqYZe7J6nR4PQaIKszVD3DlsLskiuGK3WixIftpd+Z6bx5P1WA8FzQt24nH2+LPYrHxfeyHS2h2Q5HfGlskmCCd7ctRU2B/Ksj4GAkDnjEhXFo2Bwm3nDGfbsXU+jHzVLZgX6sEdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072172; c=relaxed/simple;
	bh=IPYwte1jdHAl0RXA+w3cBwPZngFH1bdGCu0keKv5zz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4oh7K+dAVJ4kcRsNT9kKKD1Zbl1/fuaMIGpRd1bQXDUf5mDKalV1E9pJncTGnsTYi2ifJRe+ykcqxkKuKm+VZJVcxCdydtjRczpXefEbzM5UK1hXhIGlZQ/waByMoot5KAcX95j2N+lTcR8WpciDnnCeozRsqG1ywAGZNSc5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOoe6sUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYrvd5koRqIGUA/KmbRFK2qg2itve32eBCe6OW52Vvs=;
	b=JOoe6sUtuABye/dsEGIQM4Nblq94QdJlqXf753UiClibnr40GuMNzxcAJ8DR+usCXJFUws
	qwj9V3lTLrVkFPUMr+vuwtTm0E0lFnrqjVXU6WLENsO+clZHBH/tfBNDZh6Qk47a5S7HyG
	rcX2NgQnleRiI/bdOophpA86O4j+goQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Sfz54dpxOFO86q4BrtOS9w-1; Wed, 16 Oct 2024 05:49:27 -0400
X-MC-Unique: Sfz54dpxOFO86q4BrtOS9w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43117b2a901so54372175e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072166; x=1729676966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYrvd5koRqIGUA/KmbRFK2qg2itve32eBCe6OW52Vvs=;
        b=E3x2dBthXbyvKdEykWhtYrX2GXkIdVlzqS6Wpm3upmN/A02lmsuvC1466kffMp++mM
         4d+uZ0YhXhiNPHXFuN2klXKsw9wvjZ6n1psDlnE270WtnaQ+JX1Fo2BJWb4Q5OY4HaE1
         Qyf8teE66dc2dmSM89l9GhilSls3D3mRb75hN2hmXsYfVIjyx7otQE20xKYxjyVyj4KO
         BU+GQTtz99UcbbUD1S6DuggeJJv3KMdIu2kw/OTzeNTjGZz2rUjSJTtS+AzhqTEnbFiG
         i4s7inu9taMJVxaQQbRuELAc0h3j8ZEOMZ0jM35Nwa1y6EckbRlby1XUeWDd2g8a3Nrd
         /hIw==
X-Forwarded-Encrypted: i=1; AJvYcCWG23yXOa6EGdn+098YuoCS3zuPjS1vuQvmy3g2RSVDG2gMjgbAaF6+zVMDuqUyZDIgKXeIlhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zB/v2+vGhXHLJDhthu/OHUiKkPGgL9e0zaDLO/SeZp7hcV+N
	MCxQWI6FUVUssYSIWLd3IaeGmr5l/QAndGGjPojj/LmnLI0S9yl6NG0kmOivz/9F4Xq7STDwPdB
	f0kdhn5DeBtObWtXw7WlZNEpyymrKSF76ZiwkjeGB+4lq6ghn3pRdOg==
X-Received: by 2002:a05:600c:19c6:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43152a3db6amr13401255e9.0.1729072165710;
        Wed, 16 Oct 2024 02:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAkaJZ2lSkUiW+EXBvu4lsvkJ7W5vgIpbgoPIk0XAjxqd5XGQFT0XY1/aB9+8xJFuJprrz9Q==
X-Received: by 2002:a05:600c:19c6:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43152a3db6amr13400915e9.0.1729072165229;
        Wed, 16 Oct 2024 02:49:25 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:24 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 5/6] gpio: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 11:49:08 +0200
Message-ID: <20241016094911.24818-7-pstanner@redhat.com>
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

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..cd20604f26de 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,25 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(priv->reg_base),
+				"I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.47.0


