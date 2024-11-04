Return-Path: <netdev+bounces-141428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74EC9BADEC
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1552A1C215DB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C419DF8B;
	Mon,  4 Nov 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRJXQAXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C4165F04;
	Mon,  4 Nov 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708496; cv=none; b=gYOQPk05vYcjxYQfWuAh2C55CVR4KPg4VMqXTLQSaVzO7t6riwDtxqgJlKwJK/kl7PzqCbR2gxd0uyl+BGmxdfBtpeLYXgkJqoVu5HGpgUNlxvJO02aeLkGZ+6g32AsrObdTudbvbuib1GX14TnGK+BwJdIT5mlxR3HJPNnA2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708496; c=relaxed/simple;
	bh=Uo6h7Rc21fEod+/+f108Uoio6Mmq+r3xbgnntl6Rrz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wr6jF593968DmpRHONn/7yqmoUyN24PIpMirkyOdCt1WG1e+YA9vaADjVYWyrTvTJHn9sKTr81GQ0qt3m/wWHtXz8Apg7y+2DXOZp8rJZH3acbltYLUqsrqg/F0BkCj2GH6mOD/Zn8nA6/HySKAmLuI6PiUf1anCGJsnhUSMueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRJXQAXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B584C4CECE;
	Mon,  4 Nov 2024 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730708494;
	bh=Uo6h7Rc21fEod+/+f108Uoio6Mmq+r3xbgnntl6Rrz0=;
	h=From:To:Cc:Subject:Date:From;
	b=jRJXQAXX1XKUiToBETTNS2k7JcMMk2yFiG2PVdgKsiXPy1yZQWXAxhWvHj94JUrHR
	 LMj6P8+4Ky/9nL/aXLUqRE5FDJoOY0SlfPKWf3io50m4eg8E+3BMokCrfLKmlQgwob
	 47MbHKApiUSYLlxfE56blPt7cx9EB84eMHtFRSsLCjp8/U4Ppl/0GtMFoQXvCLKLYg
	 rLzZ/lRDnALZu4/4fP5ZYDh+bP33b08lUPKoJkV9/BpjK2lPJ1/60axykwUVbkMXXM
	 2K/Wjda1SnbAj7EYu2U36rC7moJJrOvAyrBwiASXQzz/zidK1MV99Rz9R0t0UxeVLU
	 wIr1lFyvDoIYQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Date: Mon,  4 Nov 2024 09:21:21 +0100
Message-Id: <20241104082129.3142694-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The hns3 driver started filling iommu_iotlb_gather structures itself,
which requires CONFIG_IOMMU_SUPPORT is enabled:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function 'hns3_dma_map_sync':
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:14: error: 'struct iommu_iotlb_gather' has no member named 'start'
  395 |  iotlb_gather.start = iova;
      |              ^
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:14: error: 'struct iommu_iotlb_gather' has no member named 'end'
  396 |  iotlb_gather.end = iova + granule - 1;
      |              ^
drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:14: error: 'struct iommu_iotlb_gather' has no member named 'pgsize'
  397 |  iotlb_gather.pgsize = granule;
      |              ^

Add a Kconfig dependency to make it build in random configurations.

Cc: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Fixes: f2c14899caba ("net: hns3: add sync command to sync io-pgtable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I noticed that no other driver does this, so it would be good to
have a confirmation from the iommu maintainers that this is how
the interface and the dependency is intended to be used.
---
 drivers/net/ethernet/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 65302c41bfb1..790efc8d2de6 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -91,6 +91,7 @@ config HNS_ENET
 config HNS3
 	tristate "Hisilicon Network Subsystem Support HNS3 (Framework)"
 	depends on PCI
+	depends on IOMMU_SUPPORT
 	select NET_DEVLINK
 	select PAGE_POOL
 	help
-- 
2.39.5


