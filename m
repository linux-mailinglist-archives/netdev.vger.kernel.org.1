Return-Path: <netdev+bounces-120435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AAD9595BF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 09:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CE128404B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48718BC3E;
	Wed, 21 Aug 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVes4Cqk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD402188A3C
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224765; cv=none; b=LnQoOmEszwQTiZGKfNHRiEDRTJkn6JAmC0c5xLKxaDHCA1juEeHtpU/SShFefca9DDTSf+mU4x97ce2JFK0rbyyQHOVeECCm7j/5sti9FnzFRyzg0Q2mlDdIamamjaEvKNRz3EqQfRtfAt+IGkcXvpu0YlicC0x32ExQdDGavhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224765; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qghXgPlqFrilB9tUlHTuWaWroEX2DsDD0DNgusja0RQKc/QEkJVG1DI7KClQ/AEy0AToeX8dNO/+nHrvZtmKWQ+9XC6cjZHNUbrI/9KKvNp9GH+gdE6yNO8qH/krn/TcyzwIlld8Jxx1srukX4eGnehHxrmg7ixSZuqkGm+oRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVes4Cqk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=NVes4Cqkil6a+XbyDVCLr2zUTtopT97cN6EKiUaawi2sRFqa3elI2sjUosoVlwC/R97/+d
	AcsB0em+FhZcplS0yp41zgW3rOp36ENWb3SfAktYy2i11ZEOvJqrYPl5UINHvzSEZeuq08
	fvDf6dxOHwQoZKNDrtk7zEDkMdCwBlA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-MIKiiK2JMQCgbfTDSJ7NPw-1; Wed, 21 Aug 2024 03:19:21 -0400
X-MC-Unique: MIKiiK2JMQCgbfTDSJ7NPw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1dbbe6d6fso715109085a.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 00:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224761; x=1724829561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=RXbEsQJp7Z0GP6wgstvk9wSCJ+XpWwzI9eCjZN6T3CgMqwtjGmJvP3M3k1lA9xDx2L
         jv8TujtHYd9VwJNEhKa34Ga6uuznlgHN5Ld/SSF5OweQQxu9H7xOLM5fFlf0Lk5oFW2p
         fmHEZeBvWOnH1qeH8JOwvjpd6OMNnJdcFb1X+cRaKnLc8TMmRhrDL9BXMUC/BLpoouHk
         gZtT4lGbDcW0Uk3Y5wv9UQA8+BycqW6o7E7wURkOO73vxi59ISjC4Qc1uiT+pZIjjNtS
         sp9jcIx6fTizYMtxSCoK4RghfygNaVVRmdGTLMK2Ph2KrHZv6cFf2UuZ0z2pyIM37OQk
         sBuw==
X-Forwarded-Encrypted: i=1; AJvYcCVmk0boK5sIM6h0y6w+ZwVJTBbh5CInHjnt13IKriQCJMBgXvYh6HY17RVWoxriygTftBqlhiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEU9SdFcxhHDNfnMTegAhEQWy3xnkyaZg4/Lf+GHis+Sby+Yg
	VRYQLYfsTBujPzaWgFdp1Kx/8g9LiLU+WfzGGmRNAmOXesBIppVnNoXZJFzTJW/99kZikk7CgNi
	E3mSkfvUTx5lkmbrCa+W1xBgVycjl8ayErncxoZ4ytqvsjQvOH5DKWQ==
X-Received: by 2002:a05:620a:1a23:b0:79c:130:452b with SMTP id af79cd13be357-7a6740bf833mr201730585a.47.1724224760990;
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlHEduRbx+7oLWq2FWdoqLifqFviA1Dz0/eZWADNmQ+nKTULVnIfuczZLElQLlBGhubXgMag==
X-Received: by 2002:a05:620a:1a23:b0:79c:130:452b with SMTP id af79cd13be357-7a6740bf833mr201726085a.47.1724224760509;
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
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
	Keith Busch <kbusch@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/9] gpio: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:37 +0200
Message-ID: <20240821071842.8591-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
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
2.46.0


