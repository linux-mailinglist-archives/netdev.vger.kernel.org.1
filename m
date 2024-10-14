Return-Path: <netdev+bounces-135081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C599C22C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E791E282014
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307A157A59;
	Mon, 14 Oct 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gwsgqb4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247CD156F4A
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892429; cv=none; b=EXxFfZcxeYQD/MmKkKG2et5E3whuHYbuBlegW4dMdLdzU2Ei3p+Gj5UrVaHXJ8b/KAG18WUCIVX7OfbJB85aeNwqmzKU20HhX4ky76m6QX1QbI4APs60QH7WMs0fGN3IPtu9zncn+DisIB6X5THqQ9Lk5yUaLRnExk7K8X/5llQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892429; c=relaxed/simple;
	bh=nDMOGSQ2XtB3JrRu0EJ9o56SNXK6RwOh++m09iUxd1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nljPThOozQcwLSiBn5eqCQI7t5sjDl2E5PDzUaa0K/U0/NsZKeqhmDj69+SpvF7faT+bzlmhq+ZZQ11uMaF4UOXoN/qgWEYA5LOiXxOn9JygqV9RILC8i4eFH0wvp8+CnJ47jvCp1pgmwrimll02DArGEqf6d4IA+uhfOUUPWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gwsgqb4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OVHqbDsKjJZaqCqMxaVmR0wTbzvoxMvtns9x4ea75c=;
	b=Gwsgqb4nDIrbtnB88/i3W7+ePdbPwNHFH6zL9+VSLAb25UzaUy30oZNG/QGf3nXNOB6t2K
	MViewNuFdLF/6M/WWUFQoZw6yrl5BiOq1jPxUrwXloc6zWToR7rPHZ9lWHBrGdhRkDwbfW
	/T8BzP+5S8XjCEOuudsgxMcpFpTsZqg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-LHN5YDnmNj2C8nF14TROrg-1; Mon, 14 Oct 2024 03:53:43 -0400
X-MC-Unique: LHN5YDnmNj2C8nF14TROrg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso6385166b.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892422; x=1729497222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OVHqbDsKjJZaqCqMxaVmR0wTbzvoxMvtns9x4ea75c=;
        b=uxLm21T0AEwGEFQK8FrVeeO/M6Fc27jNvH3LUA1K+Wf+MJpCdfTbO14qpEnZtKkmyU
         AeE33i2cIuMpVab6U7lLPHNNmyXRZcBOD0Pkc6ezH1QbnLmb+ITDSbHIGF2jz/Ucu8gI
         3Ke+StL31CKef4tQooKpinxnStka4oNxY6T69wMghSotZmq9zzOtJ4Y41nfMiba6pnz5
         CwEtgt0PcqX3lu8hAXr0UFJwkPJNOhrbZzuHJBQOXTVGfe2qtXW7UaAM/gF3tdamyA5R
         XUwJirmkzplGs07IcLNi2CvLga1VIveRQ+wTrwGD6nsCa0wdft5WrdB7XxKaZAy4VRCQ
         AaWA==
X-Forwarded-Encrypted: i=1; AJvYcCXRShN2aHrgIRY9/VOiRJuRJG18nGQQkIhjZXUbiGmjhFn9xcGajMiZosMQ9AJAEFoZyg5aqos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hsH1QLRtjlLwC/JPaTpU72hvWK9E8ULgFYeOWo7un/82S6Tz
	3yHXNXCax4aJ7IIK0Abef+SoF5udzBECjRKjd0nWnXMEblLiJp4OKnJ+B4HIR3gcCPZ/sTb6J0T
	vBOEMz2PGfOI0YJvU1g0GYnOGrVgeCkRFFw7xXIqrOYxzfo/BMEguhw==
X-Received: by 2002:a17:907:3a96:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9a183abb4emr54362166b.40.1728892422212;
        Mon, 14 Oct 2024 00:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8RdNLydaZorD0CCxm2b4SOOSEXdTQ49hlT5/qPmabsGXJC6XJB2cZBBIAjLdsQqSMvFgt4Q==
X-Received: by 2002:a17:907:3a96:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9a183abb4emr54360066b.40.1728892421849;
        Mon, 14 Oct 2024 00:53:41 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:41 -0700 (PDT)
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
Subject: [PATCH v7 5/5] ethernet: cavium: Replace deprecated PCI functions
Date: Mon, 14 Oct 2024 09:53:26 +0200
Message-ID: <20241014075329.10400-6-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..984f0dd7b62e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.2


