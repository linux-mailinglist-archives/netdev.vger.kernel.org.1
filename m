Return-Path: <netdev+bounces-135080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12899C223
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016B4281667
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526D156220;
	Mon, 14 Oct 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr7H/Cvw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5715278E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892426; cv=none; b=fwovvhMlVXOWghl0nFPIrxPVcAubqy3GXPgzEqOYipY/Mo+B3ybTqBKyVPwy87NokK166X7CB5rUV1ymH7z3Lp6mIrM5z3CnY/vPcFYqR5jgBx+/HNNd25KHDXykt/8CiM/VmM79eb/J05mDXINUq7Z9iA6FqGV2+y6/3SMf17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892426; c=relaxed/simple;
	bh=yzjQRsYbPqQgU1+oVL1O83MZ0bHUaj1hK69Y+ToXG5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuOrXo61Pgf80/aYGgr97N3fj5WTH7IBeBl1Ka0uhwXiOiQ+4BKw6xAiytlZ00VGPqJM1q/Kinl9W2enR5rM2FneOPU3J7P/kHlReYcfcAzrKgP//5N6s0pRKyFuiNV/AJSYlDWKu4PSto8FKaFVQHfQhB2ZgBAsn1zjdJ6mcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nr7H/Cvw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpYBp0Glw6qhc5uIPnL78eLKbUhbnbbx8B94lLKnhns=;
	b=Nr7H/CvwrrXgdme6+Iw8Ztz929vVjOkg83vRNLR3v/RP4hnPX8rsA1J+dNjX8Cm+z2b82F
	VQApmIlWBZl5pTXVxNuNKbUjVYlr7H7YwZMQqxPiSJ+24xnLsPAYTEFe2VrYLPF0yxOZ3Z
	MHCgReNh9koSPN+FwLI9N6Q3MfBDCyM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-nLWW1U8NPbOq7jTLwGptbg-1; Mon, 14 Oct 2024 03:53:42 -0400
X-MC-Unique: nLWW1U8NPbOq7jTLwGptbg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99ef476aadso142222866b.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892421; x=1729497221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpYBp0Glw6qhc5uIPnL78eLKbUhbnbbx8B94lLKnhns=;
        b=irU63jzflSN+1nbpUIgt1XFAXXixZbYtVKpX1kwg1E66xAUZJiA7Ssv2SzVUcIdaZj
         ag5BIyOwMWbypoFvL4cSo2PmllsKCOqKxuqHeUE8jOdAC80HAR9jnJTJ1WRz+jS6FCkC
         u9uQ8iG/8ivsU3DfM3jn8OTqpC51RiZr8avugS/qOpt0Wo0oVewtJFIymhneFxgnhP+8
         GWlQLMsLep3GfoyMHlYqTgImWHD3eCIlFPeqkammIngb9p+oVejLyyy7H/OSASc3rdkS
         l9tunaCxisC4GLL9S1+xGqpDpbc+RZgvGblDDQkkRQGvQMNwi2WbpM1trY5+Ni3ejG+D
         XjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWs7e57KZaDpl0ESZM2fSDcsE3p7uO4bZW7pEKd47t+DO+hH0o0NLR9KuLWVWAPJQ7bqrDpB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYtnaRACHw/M7nIrrzgoVkgfNISZMJD9KpDG8JNy6O/m4s+Ky
	z10xN3uAPp+duvGRGxCGhL8p54HmGUS5nHJOS6MoMyZzHMfMcuFiSp1qfjiJUcFGWI4jI1wnS8F
	nRYkF4Zx0sQbLNd0oikSFozuaQvTDfPBbE15QJnpOzdoHJ04BMGFBNA==
X-Received: by 2002:a17:907:2d89:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9a0f84ffdcmr212769466b.36.1728892420877;
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFMGKWuGwtwW80fKcIghkLSWdQ8q9LlEyh0IA4xEx8zcoRTf66/z6edKXc8FjbNEyk6SOApg==
X-Received: by 2002:a17:907:2d89:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9a0f84ffdcmr212766766b.36.1728892420454;
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
Date: Mon, 14 Oct 2024 09:53:25 +0200
Message-ID: <20241014075329.10400-5-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.2


