Return-Path: <netdev+bounces-135836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E299F617
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4934D1F26C1E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C31F5833;
	Tue, 15 Oct 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMUi8Dti"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0501DD0C1
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018309; cv=none; b=GNX9Rx7i8hqbU5w24SkmWwbWrPxLCpNdlq2Vxpiaueq3vaeHZfQVciWBiFZQFppupW5y9c+bQrmM6PdgGrSZLRdOEjPvEmMRMZb0kK4/HXZwS+zk6zbRQoIBJmfzmG2OeccuP75bRyP2zMRgrCQiUChs0QYz34+a6+yRPNs30/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018309; c=relaxed/simple;
	bh=1E3Wc2PJtRAaUOY99NG1G0bwDF3Rsad6VUjYO+8q0lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbcBfH7vjsAOLePWF1UwsgSUx9PWhbq9otmLyUYNUQ0Yky/ANtxsxHxaDxXSgMTOdn+X5klX47gly/8fMbGJm3fqq6K/F/l5uFfAt5ICnVmCZ0+7YMLmP+t/d1Ie02nCBeYjQEGL3uYfdEYh9TGBM0fszMX0HSM+3N+Dp8/DfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMUi8Dti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU/PZdKXdnBqqSwxJC6QaxHUkhQ/Rh93i2Z0bgmQYHg=;
	b=XMUi8Dtiwd/zb6YBekauGXPnsQhDU1hGcJ0Pl9JIzNVV9FqEAY5ijVdhFX8yGLIAq0cEaH
	ORoZx9vuaUISGTbVHQjvTJdqVcdJekCTKNCkFsYzmQkN7xAlJY6Gte8OMHH4lxBC0gkqLu
	05wsZ4bFo4f6RZNibT1oR2JiBc8fGnY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-MBMC8MVRMoCBawDwU2npBg-1; Tue, 15 Oct 2024 14:51:45 -0400
X-MC-Unique: MBMC8MVRMoCBawDwU2npBg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c95ec24f1bso1290984a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018304; x=1729623104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU/PZdKXdnBqqSwxJC6QaxHUkhQ/Rh93i2Z0bgmQYHg=;
        b=D6FUirqnd4G+Mrp9/V03Be8mtcDFJSTz6UlU6T04vEO4NDVLEdjQcbOfX9W3nUf/yE
         8jigbBmkLewrXl2GZ8YR2k3wXquCmDPfCjedshYCFfkCUpG0NqsU0IGZjKUiCY4LcAHI
         DJxVMGsi4sHhp8a+D8KeY16297jDSblRaeCalEI1J7nDm/3HyLva9afxo8PEtqYGOks0
         jVgM8KJQFdv29C4lALlhLlmmdSaErlHbRctCbL67r9Iah5fKdR3gXpd12I8RWIUQIJ58
         YXnyqIwCrI/rDfBz36jvUuShjhbu1PH3YLT4sc93l/fStm/CFrZ2av8767Fg0j4WGdwz
         eBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWhEsoTtKXHhy5UCVA+BjcScOLCIpcfsQOmt1rewWDWri+RLVDzFY0KULU86wmVOH8zGo9iI4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQpiX/8s/dE0WBQiZg2XGYOvIs7GEXP9CF7D1QBfB+F921iRf
	NgtX9i/WFZ0Nh8hRzNrF1lECq79FZhph4sMenWBGP6nnX/ozg8cw+hQlmeun9z8RysUc5D+IGGI
	nH2R3GVCCCQ6jcXxvINW9m5lv8I49JOQdcE6T58/Tf6yAYu5OJiaufQ==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c95ac09876mr18284560a12.3.1729018303818;
        Tue, 15 Oct 2024 11:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZgBAdLrLu4wVCTKTVra2bi/zOy1A/yhu7xkqftgD6kovhQdMFl3ZjsIezqx0bvqyWUCvsqg==
X-Received: by 2002:a05:6402:26d1:b0:5c5:da5e:68e with SMTP id 4fb4d7f45d1cf-5c95ac09876mr18284485a12.3.1729018303219;
        Tue, 15 Oct 2024 11:51:43 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:42 -0700 (PDT)
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
	linux-sound@vger.kernel.org
Subject: [PATCH 01/13] PCI: Prepare removing devres from pci_intx()
Date: Tue, 15 Oct 2024 20:51:11 +0200
Message-ID: <20241015185124.64726-2-pstanner@redhat.com>
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

pci_intx() is a hybrid function which sometimes performs devres
operations, depending on whether pcim_enable_device() has been used to
enable the pci_dev. This sometimes-managed nature of the function is
problematic. Notably, it causes the function to allocate under some
circumstances which makes it unusable from interrupt context.

To, ultimately, remove the hybrid nature from pci_intx(), it is first
necessary to provide an always-managed and a never-managed version
of that function. Then, all callers of pci_intx() can be ported to the
version they need, depending whether they use pci_enable_device() or
pcim_enable_device().

An always-managed function exists, namely pcim_intx(), for which
__pcim_intx(), a never-managed version of pci_intx() had been
implemented.

Make __pcim_intx() a public function under the name
pci_intx_unmanaged(). Make pcim_intx() a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 24 +++---------------------
 drivers/pci/pci.c    | 28 ++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..d32827a1f2f4 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,31 +411,12 @@ static inline bool mask_contains_bar(int mask, int bar)
 	return mask & BIT(bar);
 }
 
-/*
- * This is a copy of pci_intx() used to bypass the problem of recursive
- * function calls due to the hybrid nature of pci_intx().
- */
-static void __pcim_intx(struct pci_dev *pdev, int enable)
-{
-	u16 pci_command, new;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new = pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new != pci_command)
-		pci_write_config_word(pdev, PCI_COMMAND, new);
-}
-
 static void pcim_intx_restore(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcim_intx_devres *res = data;
 
-	__pcim_intx(pdev, res->orig_intx);
+	pci_intx_unmanaged(pdev, res->orig_intx);
 }
 
 static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
@@ -472,10 +453,11 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 		return -ENOMEM;
 
 	res->orig_intx = !enable;
-	__pcim_intx(pdev, enable);
+	pci_intx_unmanaged(pdev, enable);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pcim_intx);
 
 static void pcim_disable_device(void *pdev_raw)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..d7fd0772a885 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4476,6 +4476,34 @@ void pci_disable_parity(struct pci_dev *dev)
 	}
 }
 
+/**
+ * pci_intx - enables/disables PCI INTx for device dev, unmanaged version
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Enables/disables PCI INTx for device @pdev
+ *
+ * This function behavios identically to pci_intx(), but is never managed with
+ * devres.
+ */
+void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
+{
+	u16 pci_command, new;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new == pci_command)
+		return;
+
+	pci_write_config_word(pdev, PCI_COMMAND, new);
+}
+EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
+
 /**
  * pci_intx - enables/disables PCI INTx for device dev
  * @pdev: the PCI device to operate on
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..6b8cde76d564 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1353,6 +1353,7 @@ int __must_check pcim_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_disable_parity(struct pci_dev *dev);
+void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
 void pci_intx(struct pci_dev *dev, int enable);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
@@ -2293,6 +2294,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_intx(struct pci_dev *pdev, int enabled);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0


