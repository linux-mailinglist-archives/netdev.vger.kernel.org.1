Return-Path: <netdev+bounces-150183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B71B9E9669
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD02188832D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE691ACEA5;
	Mon,  9 Dec 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJZ0eTZ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BA1B4235
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749663; cv=none; b=EjJpe5jr/zRCavBD1xNdwpHoTyOH5b9vlvHr7gicLk2Cu5odYTgB23QgET+C+6lc2/78hHoOzaQ2i6rN8Yc/N8breTVazyAxQlG/d0R1Zre7iwrXEMXen7v3nPRyGPon2uB9H+DbWXvNQ9GhOkhDGD3qfXlNhxk1gVCoWpSGBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749663; c=relaxed/simple;
	bh=mRkzqov/CYtFiWjgkuQOlRqwmB3d1pt6U/jB6t5Syi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO5b1M/VUIY3orKTQzyGdNGjKOHmgR4dJg9mYsTli6rTZujmwfPKETFZIOFV9j0caMyhT5xPKL6/udjYh0fgDUe7WcUY6bvkb6ypDwyAnLJe3XbRmFv2/tUFcBWPSSdaloXQKv2CX4K9zRDXco+/N8N7kI64c5jJ6qgCexNt+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJZ0eTZ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
	b=FJZ0eTZ9Zd6aV+uTuygzdR6JdizyMXa9ZDR2JU1YdtXOX2lGMwRpp77szcgf6ghB9ikH2z
	LxXwQH2Hb+XyxkfzHMKK0z6b0Q7Bm/nz95ktyI3BCjAgx3dkkwgGyGNxxQB7WS4tIPOq0p
	gbYuRXeNcCGEQ/EuurbHDqLNGJKkVuU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-7oN4fsSIM3akI2kVMCNAmA-1; Mon, 09 Dec 2024 08:06:54 -0500
X-MC-Unique: 7oN4fsSIM3akI2kVMCNAmA-1
X-Mimecast-MFC-AGG-ID: 7oN4fsSIM3akI2kVMCNAmA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e1339790so2818319f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749613; x=1734354413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
        b=eSOfot31Cle42M5QVFO3QGG9GJIlHK1O0lPY9pGrTl0zW5UpF0pLFyeZaDQsBKNsjr
         wDu4IuWt4iwj9Kum75awuJO8R+k2kRani9f8wn78vE/qYec2Vt9oX7HqBhjYxOexJUgm
         zolfW1KVags7hSWkc5OdHIeIdvgQ/fX78cti9mMIS3j83Q8ap7A4uuNrcW79EdIHT/t5
         byvlgDFPI6n47rfDRNXtuCb0c6RKnKL0FZ6F0oHCz1pMvz3e6HFtxUOYNyVFcXXWWpcy
         a0JstdjbSL6fvG+x57BeU5uYPRlJ1Rdm8IszhP3BI89bd3weGTRjerHOHO64ZzezY1oG
         Tlow==
X-Forwarded-Encrypted: i=1; AJvYcCVT/bHs5JlO/9hbEMuPIkQCxxJ9GJBHlkmb0+rjJAX5F5treTZkLlLj/DFBfUp1Oac+w4HyJCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhN1RHAoppnqfeOxvkm2F7YvZnhm3deiS26DssaNnLCPAI2aVI
	pgxWp2uTuw9Ocl2TrjL690ezHmZJ+euBnZWy1o8NDmudIv74sJ4nIDE0vMqZ3ddBN9tUVQzFN4c
	RCmCe4z/AMRh83X4ZYKBGPqZHplRWSnx3BhdvKijDmDs/hGiJzwpEXg==
X-Gm-Gg: ASbGncvA4iwGmQe4t8CD362W8oTFG1cxX0QnpHCS3p40egr49L4Et5ULEopbq0xoDbJ
	xxbae3J37qG+KuIcBhKnuivT3XtbE1q7KdqbXQ8VswT3SLwvoKDZzMkYWpuTarH53B4eDnEu46n
	mE8uBshQgRxejK9McVRoxn+xqcW6GkTktZmgOOxdqTFoYKX+nBRaUgz5FYU9fmG/lgy9kpXlvOM
	uItgyokNqCWjqAdP1w1Zc3qog4XhVPmMDeQoDSElwU0lzWGKN/vgoAg9A+wfmjl0Xa469dLI8tr
	+4XdFR4C
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188118f8f.54.1733749613291;
        Mon, 09 Dec 2024 05:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj1wppsmKOkdvfdKSfuff+I9JjxqlZHOEEdHEk5K3zylRh/0qa/2JfnJnGp4etqXepLTEqow==
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188043f8f.54.1733749612866;
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
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
Subject: [PATCH v3 03/11] net/ethernet: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:25 +0100
Message-ID: <20241209130632.132074-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
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

broadcom/bnx2x and brocade/bna enable their PCI-Device with
pci_enable_device(). Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/net/ethernet/brocade/bna/bnad.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..2ae63d6e6792 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1669,7 +1669,7 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	REG_WR(bp, IGU_REG_PF_CONFIGURATION, val);
 
 	if (val & IGU_PF_CONF_INT_LINE_EN)
-		pci_intx(bp->pdev, true);
+		pci_intx_unmanaged(bp->pdev, true);
 
 	barrier();
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ece6f3b48327..2b37462d406e 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2669,7 +2669,7 @@ bnad_enable_msix(struct bnad *bnad)
 		}
 	}
 
-	pci_intx(bnad->pcidev, 0);
+	pci_intx_unmanaged(bnad->pcidev, 0);
 
 	return;
 
-- 
2.47.1


