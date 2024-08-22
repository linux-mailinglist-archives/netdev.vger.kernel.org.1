Return-Path: <netdev+bounces-121038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B57495B758
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6991C22F81
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78B1CDA0D;
	Thu, 22 Aug 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SupTUXPg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC41CCED9
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334494; cv=none; b=DAN+ZS1GcLbpZ17k+S/lrd5I65L/kWoKRsRa7EnrbKSJD4IjdU5KfsZEVaGC+5o4IU5T+7QRVB04WCdjRm3/59+bst+gkgPclcMic7WaYtN9pgj2BhhAMNNSoNpJqvTFyJRUqhStYXGLayoXwAitHgAZ7gBDqiTEk2/gooAGjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334494; c=relaxed/simple;
	bh=KDo5b7D9c2aKWVtFHnbLLIbe9frXqS/ZEDy0EgIaE/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfo3yCvoATaZgUOp5rEpdSDDstuQN2JhykffedGS6q3lt7MWkKoqt5h/VuZssvFqSdzt8ckXVry/oLT1y+PJvC7A9v+LI6lHE904SE1TWQFFan4L6lwubNkxi2rmxK0+oonr5krUz60thPs/RzdXJ99NqkO9nVlXizqSUH5eNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SupTUXPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRyCGGbXeIqtIB2NKAJconNCn7y+8lt1LzEGsFrZVag=;
	b=SupTUXPg5K6BnPlftYXgEZdrBOgv80uB8gZaRgB/ia6+QNoQsizGiGjn28Jx6vEBia0eCa
	ETBRH7BRrtnr9hNLFwvEoPAsevXQyFVFJds12IlsN63owBx1nU+ZqNkG1UNAVjAQ9Thius
	rR3VWm1TTZfVmQPyaEp2Dh+LRTOc2u4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-r2fDtDnxMbuMtLWoob8Ulg-1; Thu, 22 Aug 2024 09:48:10 -0400
X-MC-Unique: r2fDtDnxMbuMtLWoob8Ulg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so6324675e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334489; x=1724939289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRyCGGbXeIqtIB2NKAJconNCn7y+8lt1LzEGsFrZVag=;
        b=AB5f1EBd9Uqb7qfyt8EgDAhHPlt85S6T4RplRGwc4JzlqxwWU6ZFZIfZwLrghblgem
         /YIdSxu33+sz9KjZEHEe8/n6wAQynGk7GO4VhdQg4x+KDbUGRo4O/aXjsAr/vtVN4DvA
         sLTiJZ9R4jWcpaEthCWwPsn0waU8EskfVHUTKcHNpoMwicfI5RSEc1GH7D2nwBSfIfRW
         FNWAoT1zZB3OVKe0D82zJ2a5lCvt/t2zsJre7EKky+IYFg9ULaJPI0MhEMzz28DIBG/n
         QQB0X6hxPOXWm/pKOe7vAboPd2umIs2BgINqCgmUdMKiF5K7H34LiYIyPbktDEuo7x5N
         P0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfRmfJ8FwKdx/8FRtFq6QkAj8mF+YAP/wh45nmbnU7BqD/AJgfV5keUDCrMBuW0/3wqn3/IRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOxFuRY+AUlDzML9+T9/3pKMjeFlWZf71asSaGXmz00hweMze
	81uJSgwqm4rNX7u0PeSBjvt+xV1owjn3UfcLwsmPA/vXiEAmms5MuqCOg3duQCWZvCWKLHYN5Ym
	qwQ0FwjyR7nFTerGA5e6ZSNq1jzQMJAb4IyLtapdORflGkhFQQB2ckA==
X-Received: by 2002:a05:600c:1f94:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42ac564e9a2mr14095765e9.31.1724334489393;
        Thu, 22 Aug 2024 06:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEycROzO/HBKtY3F90/mam5y1MK/8INPkts2FEZk+sZD+ocdqE8maXCLum4hgY74c7bSFdk0Q==
X-Received: by 2002:a05:600c:1f94:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-42ac564e9a2mr14095275e9.31.1724334488951;
        Thu, 22 Aug 2024 06:48:08 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:08 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 7/9] vdpa: solidrun: Fix UB bug with devres
Date: Thu, 22 Aug 2024 15:47:39 +0200
Message-ID: <20240822134744.44919-8-pstanner@redhat.com>
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

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..67235f6190ef 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,12 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.46.0


