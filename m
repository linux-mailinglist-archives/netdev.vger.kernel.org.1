Return-Path: <netdev+bounces-135846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941F99F678
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D952D1F238CB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91A2281FD;
	Tue, 15 Oct 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyzJ9r73"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7C227B9C
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018340; cv=none; b=DW1XWO5ZwZf5dwDwosjN8qEJZcDkWuyHezFFPUfa4IH1rwLKKn4HhIbtgloJhLmXPDh2Q3kQnMIGHOlBkGQsP85Bl6mbCnHLQLXyMTR7fYZiAifIBGyWh8u/e+57zJ2o3IE6jVmmMx1u7rlbDM06SOfWz3TW2T/R60qj/WXcjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018340; c=relaxed/simple;
	bh=aAbe7GmqFC4E4dG0vzWtJY0/IVRJ0ypsn5oCbly1PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcUpSDJXT9RogoRnYrHLFyQtQ7JGJ8BMtu8JUV6pPzCkOmot/FbKX4+ynOfc1QLTRVcTAoAKcFNr1ekqBVi7yY9OSyK4w7Bsb/FS58NYIaLKUZV6Yedm5iKmuaT8t5q+mp5Rbb9aNGjIgvbCSbpZG/QUve7hml4QGaqePMabyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyzJ9r73; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
	b=AyzJ9r73d5AXa+nOnllYHXJaszAnjtZwafE24E6XNz7vyTPqVThDPYyNv0vZtC1wdCesCG
	jDk7ctasL+9MKppdkB16RQxmfT6T2gkcF4jlsJGafGjaOHLFiI7a4PtJpewST7sNX6+XAT
	a7TPQeYTbbA2CLe20hJGPOiRu84Ycv0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-VmaadeLRP2eVEV_3iiqRHg-1; Tue, 15 Oct 2024 14:52:16 -0400
X-MC-Unique: VmaadeLRP2eVEV_3iiqRHg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a2ae49a32so81074566b.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018335; x=1729623135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
        b=ej1cK7BKT7hdjhECVifSu7QaqWJk3bXwu0TnAByktgl6bMjpUB4QHtJ2UZoVrdSvk0
         367f3EO88Ag2DECk6TNYxUcyqBXchb6d6heaAVcuKSn3UfKu3UgYC0Q9yvedukapjXXQ
         8fkf0frraw4/to1j3YNDomR3NZWujyP9i8Vft/797ikSlcBl6NaDMfsX8AWr2zZmI3dF
         sydncFTuFMBYqXGREmUBM5xd6Py0+dkZVPobPXeuvUNyH952h0Wap6QUFkp7Xs5dPWhN
         +3oDZKzpzXg8RELsaIp+uzXxYGheWwFQKSyI+3/dQvTuxPKZOBbFg4/iS9KW9VMC8d7K
         A5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5rWZUGmH8jJOEcD2LW0x8D5oZL6q6l1Fd5MhWLazsrMzGKZbtFVfGHwWPR2ehA34aKTCN9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxUFoxakpi6y/iGyLPnh8VpHumwBIfjJiQgUYVrZNYQ/7K61X3
	MlnfzF53U911jCNNCEEQ+8agtLhfu+Sp/RukSxvfHXSdhEq79vCA3rs0MUA/XW9gelyqk4ZJBes
	//zGluVQVRCaySW9bCnIfaScQTHTPRCOCbOKIsaEs0JZh58d+E45LqQ==
X-Received: by 2002:a17:907:3f9a:b0:a9a:597:8cca with SMTP id a640c23a62f3a-a9a05978db6mr977636466b.45.1729018335326;
        Tue, 15 Oct 2024 11:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtzFRtQHPl8Fct9iuZuGo9S3vsShVLZO8po30QG967TcviSYGZFyEBgz7XqihkkBKNzop8BQ==
X-Received: by 2002:a17:907:3f9a:b0:a9a:597:8cca with SMTP id a640c23a62f3a-a9a05978db6mr977631966b.45.1729018334888;
        Tue, 15 Oct 2024 11:52:14 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:52:14 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 11/13] HID: amd_sfh: Use always-managed version of pcim_intx()
Date: Tue, 15 Oct 2024 20:51:21 +0200
Message-ID: <20241015185124.64726-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

All users of amd_mp2_pci_remove(), where pci_intx() is used, call
pcim_enable_device(), which is why the driver needs the always-managed
version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 0c28ca349bcd..48cfd0c58241 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -122,7 +122,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 {
 	int rc;
 
-	pci_intx(privdata->pdev, true);
+	pcim_intx(privdata->pdev, true);
 
 	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
 			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
@@ -248,7 +248,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	struct amd_mp2_dev *mp2 = privdata;
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index db36d87d5634..ec9feb8e023b 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -289,7 +289,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	sfh_deinit_emp2();
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
-- 
2.47.0


