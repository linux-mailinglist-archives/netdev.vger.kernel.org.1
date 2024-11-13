Return-Path: <netdev+bounces-144406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51039C6FA3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6A28372E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92514213135;
	Wed, 13 Nov 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TME469YQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804552123D2
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501781; cv=none; b=lPw70NyrsJ55lFND3DxTIwCiE2FIl0SMorA5CbXyzMprtxkgDdgXVGcow49bIaoUFjvafY4cq2u10viZV0d+2bZcn3CQgPuQNg8KvaPQQXhhv3GRrJw/+T1zEV0TiPS37QOJH9t+qHxIs2+JpuaLmYP+DcU+6acggHPDFHh6lTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501781; c=relaxed/simple;
	bh=MBsD3LRvT8a2cfMDXV+fpnigYjcMu2XVeQIVlBba0hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zra/TYNvBFYxhU85cZ1g9sFvl14m8bp93ux6N4uEtPD42d2WcFrwE3N1we/fi5ShR9N1Lcx0f30BV13izmvZrXEZeR5Jqdj8JItp6Ws1kPr9zGQ1rkQuQkEP6LgtS8RIPVfqbN25miVBk3VWrDuGAzCO+lHlCnQjqY6KlkJ+lzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TME469YQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYummHyMeO18Vto9q2ZMMfeLT6TZU1cjZPgJKtQfrDY=;
	b=TME469YQNHzz28DG1OBcky1fy7eq4IfRfKZaVA3VW5Jw0s7YSp288FY/jBXaforAvMZfF1
	gFmCaaCBFRtgr09NPe2GY1fxibR0GDuqMJC9l+ZPjTE3O4V7udT4Gp0fGyPrRyL2ma20Qe
	ijPivFdxsFZRhaus+yW8MzUw6hk3Y/o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-gWPzZoluNaySf8z0sGOuuQ-1; Wed, 13 Nov 2024 07:42:52 -0500
X-MC-Unique: gWPzZoluNaySf8z0sGOuuQ-1
X-Mimecast-MFC-AGG-ID: gWPzZoluNaySf8z0sGOuuQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so3762429f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 04:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501771; x=1732106571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYummHyMeO18Vto9q2ZMMfeLT6TZU1cjZPgJKtQfrDY=;
        b=XacfMWEIu64hkpti3foEdA11Cptop+fKbP1xE/SRrzcxnBg2lipke72JeB7OFo2vXJ
         mKzCUBuxT+WD4ttHGvIWqSpb2kNyy3F9PY/b67tPfol02hYG1VUk/uh+iTnfkRAztkc5
         3J+kRAfsn7VrjhAzwGHwDdaMtoR1bFIfOQaUA42do93i5sFzF6UiVWfZDBz/VHB/u517
         GxPu5pBSwBJ/KeOjY+Sf8qBJLEluo5dZNX+clALJU5g5z+5V9gukzsTOEeUumBQpTlf3
         R9cSECN3FvvipovhUp48tB2hWJHuI0mapp9lAbuVgKetFw8VxpMltBOGsMWkVFS0OPPu
         cOaw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5DlMpiOvbMGB1XmiawSXTIJRjD1XrHefqQftwUmZFpwkI4LCH3f7YrtyLRQYD5ows/IW5+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDL23nUDhcrwfq31MiVmJlqVAkNaFzD3CuSU8uZA9PMSskTqv
	oYJkcVgUu8JtWdZc9DBexwfXRswjYguM8zb9L3qYX010msOTkaZabLkaArJxO/OWzywteirH5YO
	ZXrf4WyxxyepGU2sHTW/Uyka9VOKdBPFNOrT1PWLI6/UEevGtB1VJ7Q==
X-Received: by 2002:a05:6000:18af:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-381f1863104mr17590027f8f.2.1731501770814;
        Wed, 13 Nov 2024 04:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaBVI43qrL6OFk13wQNBZS22ld2QbZy7MjquOncWveKQvBM2tKSYuVKq3Lye0eFRQdag4y9Q==
X-Received: by 2002:a05:6000:18af:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-381f1863104mr17589974f8f.2.1731501770406;
        Wed, 13 Nov 2024 04:42:50 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:50 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 09/11] wifi: qtnfmac: use always-managed version of pcim_intx()
Date: Wed, 13 Nov 2024 13:41:57 +0100
Message-ID: <20241113124158.22863-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113124158.22863-2-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
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

qtnfmac enables its PCI-Device with pcim_enable_device(). Thus, it needs
the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f66eb43094d4..3adcfac2886f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -204,7 +204,7 @@ static void qtnf_pcie_init_irq(struct qtnf_pcie_bus_priv *priv, bool use_msi)
 
 	if (!priv->msi_enabled) {
 		pr_warn("legacy PCIE interrupts enabled\n");
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 }
 
-- 
2.47.0


