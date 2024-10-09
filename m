Return-Path: <netdev+bounces-133551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134C99636D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D421F2391F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541BE152196;
	Wed,  9 Oct 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjxlqVue"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CD18E779
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463104; cv=none; b=k/+IO9HEzulvRjBo+MHhrpMEoSP4jdqQOzctFJGIS7szv23wnSLSxEvEPwBamsBMpcQPWJe9XlbR2Nf0BK4nSgspuWO8tqBfTWXzzwZNQJ8vaJH7tFk90bdrYe6/O45WkiAAViY5xc/pCFV9guD5lZ51+UMJ3yXO4LIK62L8kEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463104; c=relaxed/simple;
	bh=j+VCbR/KiPKDGLB6duXvKzwDAwEJ7m2zrLvdpz2kZb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr8L90eR7ixlc1y3SvHtg/T/UsphR9dngm2RMcluig3ibyr/wQu/CDG8HdWhJe1MviHymKPW+jUwBR+6bhxdVzHl8ye0WMj+nkLiw/TDaJE9wyd+24Jn2SxspRzfOMDggz69PUUS/E2bTWah6F+Ues3mgC8+NjoO6WIAPQCW4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjxlqVue; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728463102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ4XyKRMzVRAPh09Ypw2QkYDvdqyB5dqjRwvTDPzI5M=;
	b=OjxlqVueFFV7IJ33AUsgKUvRq5Ew/iCPLUGmxfBrivJRZtRKr6Pnq1MeQLgIiaaF2Mqt6y
	wEUVEHhoD7tSyfxen62Q/5fw0Zv7tOjc/jnwx1NKyWWGmd+fvvyAHOmT31o+cEjzaFgPDq
	EM0HepY1zLsX5c38KW3by+YXhAnUENU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-WqXxK8JlMqGSsmGi9hV7AQ-1; Wed, 09 Oct 2024 04:38:20 -0400
X-MC-Unique: WqXxK8JlMqGSsmGi9hV7AQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7acdd745756so1285479085a.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 01:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463100; x=1729067900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ4XyKRMzVRAPh09Ypw2QkYDvdqyB5dqjRwvTDPzI5M=;
        b=uKvXdSuxRPzJLU6mPc2mbPz4ASkprQohbyZnw+GKDQlUzKOdpWsAuuxiuC3cqs1Bsw
         KavH98IEF1F0hd1R6F+oS4k7Enc/pSBaI2PyX1xeB8YN2T14KvmLpM2VyIw0CIArx91d
         ZN3j5+S2Xr8QvAh6B1sOLm34vuHkv/zv+eItrnuStRG4eygkh9IekEjKKS3QBpPz1sL9
         Fgz2Ih9HQqCO4tsJR/ykAMfblIBG1vnieazfR2NutvR+tBnIQHRtN3WHkWPV7sXUVKrn
         p6QeIYygnYBbCoCzIyfVR01tPE/AMbs0bnjH8JTOw2mie0v5IqHi1VjRyVV7aucQKTKB
         vh+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFSr+gRtNgVVN0XAmVLYo/IBJoGcVRDTzpOEVHDncn80N/5yegp+5SOOhxg3W0xIzwRQPdBQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+9ipAbrj2gtXEB9Ab0ERFt7SXOtQHRQVK7tXQ2BPuCT1+vW3
	QGDJv85jT1m72bX/iU11r+RcfW6TQ0Kl3A7J7aGMb35v2uSWAXXRfQMdUBq3ZWnjI3f3/RNV4Lr
	+BB5fETx0mrI1T8RwZBjFRN0dZjNxJNIuWbBvqI0YbXd5WTRROJoQwg==
X-Received: by 2002:a05:620a:191e:b0:7ae:5c5b:a3ee with SMTP id af79cd13be357-7b07954eaf1mr214939485a.30.1728463099847;
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEohpGdz3FQCfvuYPGv1Kgp6VmjNVq/mWsuKLRVQIwcRgXug1EQeuW78e0HsYLtO7HnORD33g==
X-Received: by 2002:a05:620a:191e:b0:7ae:5c5b:a3ee with SMTP id af79cd13be357-7b07954eaf1mr214929685a.30.1728463099420;
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615aa2sm439643585a.14.2024.10.09.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:38:19 -0700 (PDT)
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
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [RFC PATCH 11/13] wifi: qtnfmac: use always-managed version of pcim_intx()
Date: Wed,  9 Oct 2024 10:35:17 +0200
Message-ID: <20241009083519.10088-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241009083519.10088-1-pstanner@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
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

qtnfmac enables its PCI-Device with pcim_enable_device(). Thus, it needs the
always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
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
2.46.1


