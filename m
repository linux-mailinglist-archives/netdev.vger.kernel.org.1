Return-Path: <netdev+bounces-150171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3879E95EE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A9281A82
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98784230D0D;
	Mon,  9 Dec 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx453FxX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97367230986
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749619; cv=none; b=E5XprvELKCbUpwfqY6xWmQB/UjAVn1CJmt9nyJNArttAvUjvBoQ/pBjEq2WUBTORTKlrz1PhzK90wn1CXKI4k2tOlPBlg6rxHmvRK4ApLgBM/+qNzXI+2K465US3jOVfGldEcNI5chOH8Ew01GAZhr6RQV+BWqrCy+jhStPn1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749619; c=relaxed/simple;
	bh=lb7GonT3+ZCBn5vd8Htudn5MDz8T66fffMcfmzxL9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeR8XosMsnEAnO6n5UtB26f8Y/rslapo/NvmPTp9KYJbG7I76y2jyQ+tgw/PcuTvQdExK0d7SZp06KVi3VTBYHQarWSBs7NrktmKoDfCpYB41xJoTbEqNDbVEESyqfqmzP/Jcc8LfRTDTaNB5k+P3+9cL0cndC/f/VXpioCN+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hx453FxX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
	b=Hx453FxXUCjSqOXeqztHsFtG9B5dT6a/KYkZYF8OzlPWaCil59GwaeHEP0jtzHhkR+X7vv
	mpEMuGuO3st1Zp4kcCgZzwSkBkAkemBKEznQwEJr0v0a7MEqWAU3Y9iIu1xRgI0Uu2f7/o
	hXAsL5zyxgH1DI70muh1YXsfOv6ihck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-D2FtceLBOKy0M6xRMJVNAg-1; Mon, 09 Dec 2024 08:06:52 -0500
X-MC-Unique: D2FtceLBOKy0M6xRMJVNAg-1
X-Mimecast-MFC-AGG-ID: D2FtceLBOKy0M6xRMJVNAg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385df115288so1806844f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749611; x=1734354411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
        b=fULHzXLATZcnM5ina34Hvp5wc5G/B+PjQki0CXWN4w6vApN/uIb0IaMbOWdoXbCOkr
         sw4iLmyaMnnZZWpSm4sXjWrgdhH9Q/BCe7ZLWfIupf693kX6W1rO4hERzUiKGliDoKmU
         5kkVYA5AqtNsSTcuUerXiLIcHHVSFi2HWaAp7Pd1aifQ1a8WuejMbn4hiu11MqczHyyz
         CrSllZGM62IFg+sJ/yJ1LPJt8AKpz31ClKwtDptispeaUM7qR2wWxw2WYmsXfKyGBeIQ
         XnifGKZv3ba81hrgBqiBfldKMMs2stQ2s/xUoFbJB3COM3nsAa/dfNstL/5JsfGq4BAC
         6Nig==
X-Forwarded-Encrypted: i=1; AJvYcCVPh0ZO+BwhAzorQgL96ynPssQA44XpuPUruhRiFL1vAQn/ne5JTTijVZ/iJPLtO1aL2gGMqVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39g0fTaB1+TzJmgBPHtbIPzruT90GKCgoYLDq2KUM/gaGGVdH
	iVkEXKS00vNUpwYpaxWfmg5ZL6Mgt1dCT079AhcCL4h8zBibgK2EaeI0W/RFJyVEMhwmAYj1o/B
	80jFBCoKCBxBWFJOeMIHvrWCkp1lSuZDGqcAinKJOQ06ugjAoJIau5Q==
X-Gm-Gg: ASbGnctmv2Ae55mK/MUHg5ril/g0CzGKsk5thrj1IlrcrrgsLAz7m+KZLQ5TNmvSd3T
	vO2uwuCknGhe5Gy8uMghUDAXy/6D7gLxJTANN5Y1JtOU4oTWQmJGVHWfFj/V/hX80sAdPM27skk
	+qsz4+Xd0i0IKYS5u8D7bHCq7Zg6/5apT5qMCq8Q5pLgd5PY86QRrTklARicezVDGuqyGdWvuZZ
	TPnpBZENun5X8cSkEmZmzO8aG5tE8eNfdXuHToONr0G/DxEjgQckloKzbNKamY+JivbJFQZVSHJ
	+HpOZOgH
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224906f8f.47.1733749611198;
        Mon, 09 Dec 2024 05:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYLGzMuES8pL8UNwc6rduiHNSssmgKFMI0arqDxmQvwrHwV9r5BJKNGyDbmmGP7hHm3hITRA==
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224791f8f.47.1733749609723;
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
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
Subject: [PATCH v3 02/11] drivers/xen: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:24 +0100
Message-ID: <20241209130632.132074-4-pstanner@redhat.com>
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

xen enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/conf_space_header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index fc0332645966..8d26d64232e8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -106,7 +106,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 	if (dev_data && dev_data->allow_interrupt_control &&
 	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
-		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
+		pci_intx_unmanaged(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.47.1


