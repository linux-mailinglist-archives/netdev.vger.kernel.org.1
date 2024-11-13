Return-Path: <netdev+bounces-144399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9F9C6F5F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBF1F219B7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6D202F9E;
	Wed, 13 Nov 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGbp1b4a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1F2022E6
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501762; cv=none; b=qeby6CovCsjHxr5ETMvOWs+lYwnDjYm+gRn+nE9LdjxyUY2HYITZkE8tGuncxbVfEli5FWkFE6lUjx7nmqj9HzjgxXuPzLgpUiYd9H/FcIwO+aLuuFuPU/CfUcLRCLefHhW6HXHVIYb5acF2LpWs3jQTGQDPRvzyO/KPdJCAhSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501762; c=relaxed/simple;
	bh=aUCGLjcQl9VmrAUkFfZbWR6faxCWERPxZ3SRIvsnn3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SklpRhV7t/nlFBbF7MUUmS/3CGaoDPOf/NCGbWsR6n1x2X3XFgc6GRVXrH7LwxURUl9orgiUJmWGepsvDFSSeu0ARV0QHzGVZ8+M4oG82xTqsMJpmZiU6f/xhOCLXbcVAk0VvpNXqFVRE8yh1qreebDpYNXggv9UbkxX3VYE6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGbp1b4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZ3Ct+htOyFcNtVrHcgotVRsHQNuDZcXgRKY/qB2q+Y=;
	b=MGbp1b4aryyHuIOclsujcc+SFZCP2fTokwnW4qv0v4IovZcT0hWJ7ir4FUKZNrR4yi8FCM
	OFPlXZQ533ISngZgKXTdDyUB7ynqpvl1MReGzmbBGoriA4UguKrdeuLb333y0pW/rUROr6
	9fg/npPetSCxMnkidCL4/DchDGrZmPk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-RLBEYbLnMFGU_aM4OLz4iQ-1; Wed, 13 Nov 2024 07:42:38 -0500
X-MC-Unique: RLBEYbLnMFGU_aM4OLz4iQ-1
X-Mimecast-MFC-AGG-ID: RLBEYbLnMFGU_aM4OLz4iQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5016d21eso3774661f8f.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 04:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501757; x=1732106557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ3Ct+htOyFcNtVrHcgotVRsHQNuDZcXgRKY/qB2q+Y=;
        b=Fqh9uQBq7dYSngy06Pi9jGa7f/J5vMz7v2U1iNwJkWQWB0NL3e9eNPkx42NfCi84vs
         NtDw+oaSkSijwY+lw1jh0+l0hzTnzsOFFfO+G0Upb74GufxkTGBll99jJnG9CLP6o0Cy
         Yyib6lf70ADv6pEdg0BegbQaN+lIN4W0VUYUdbfCL1JuemkfVtK0FEP7JXZ4oRMD8pak
         9L/PxyAU5Or+GglUv4G5F5bmn1CJCkKiHa1lWP8CoIpQpgxvyocXl65Lh8GtwGi0umE8
         P28ja92R/FGQX/Lz1LvB/yilRmtEV3UfFJxR4kAxgHOOT4C28XVmxUj5rXRkhiYuBZw9
         Gy7g==
X-Forwarded-Encrypted: i=1; AJvYcCVNhspPKEpuWhKg/9/RtsonRGMNPblfIvG/F+gIFhnigxz0t8lJEibyt9/L81FIoRef/9kZ5HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInWfIi+WLc8V59BBc8Dii3gYLAjt7g1lKSRxmekHgC3Cb7QT4
	akg5t+lrxJ0kRaHmCox7eS3XDlL2lvjTqM2haPdViX8BMl/uwflcqKBRt5qTFsRIn1ALSQ0cHxP
	qmQ4I2yp3iR5Bi9xkqDo6vXaGYDVz2it07yjN8UVAFrzBId7B5dd+6A==
X-Received: by 2002:a5d:64c5:0:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-381f1883da1mr17924921f8f.44.1731501757431;
        Wed, 13 Nov 2024 04:42:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe7Ekl12tv+ThW/wGcJN/HoeLWpkbF0cAp2d3sxxoUKqIzhIJ/U/mQj+3PQSguFn+Xr9yXfw==
X-Received: by 2002:a5d:64c5:0:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-381f1883da1mr17924840f8f.44.1731501756841;
        Wed, 13 Nov 2024 04:42:36 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:36 -0800 (PST)
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
Subject: [PATCH v2 03/11] net/ethernet: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:51 +0100
Message-ID: <20241113124158.22863-5-pstanner@redhat.com>
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
2.47.0


