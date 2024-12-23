Return-Path: <netdev+bounces-154019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E79FAD21
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4649218850A7
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215B198A25;
	Mon, 23 Dec 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OyXSi7ZL"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECB848C;
	Mon, 23 Dec 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734949835; cv=none; b=mlN9zFNJfF2WP4SVwVpQ3jRz+2QcDSixbOYYiNZ7+HHIrp+sLGqNYxuE8Kia3/RhJWQnNG4MuusesTjw61/hui+LGlUo2ez0UZ1xVwbzmHaFMjnXforep8pFplruJxsPuzSCTVZtM0k/+StU6q3558EcXZDphcZneGvWj93WOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734949835; c=relaxed/simple;
	bh=kDm1sAt+O4kHBSJCuBBHzHsCJBF8U8ikxo6OzXtBvg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Miv4S8GWVfcUmXVFHMIFJ2LHmr/3ViOvOYQen4SeV1LtRbGhOEOXGMjpxLy3c/M+ceJjzZpl2z90reLsXK0R76qfYOrtKLq4VxpQHlSm/Nd8rLN+b0YPaE2/YG2gwyOF/zuOZ0jNFhN09yZl3VHu+QgpcswRHDyYSQPKS3hkkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OyXSi7ZL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Q1ue102780;
	Mon, 23 Dec 2024 03:26:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734945961;
	bh=9bpx0lCCmv5pmkfeEr0posXIsEvx66W2A+erLgVfVs8=;
	h=From:To:CC:Subject:Date;
	b=OyXSi7ZLnNnJ/ooqUOaDgBg7tqDnHc3fX7pJptEXxCaRSlDb3AH6Ii36cgIMCXbDE
	 xrVPGMaQ+b+vkVPC3LPljCJunH3YwmMw/tq49YOOOZiNSchIz2cLgFNn0gfh1vd25q
	 5Z9anWQ3XjQZnh0tM9dKpZfIV3iAtpVJXXngMvGE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9Q1Db013408
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Dec 2024 03:26:01 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 03:26:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 03:26:00 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Q0o1127786;
	Mon, 23 Dec 2024 03:26:00 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BN9PxKk006688;
	Mon, 23 Dec 2024 03:25:59 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <wojciech.drewek@intel.com>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 0/3] Add Multicast Filtering support for VLAN interface
Date: Mon, 23 Dec 2024 14:55:54 +0530
Message-ID: <20241223092557.2077526-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds Multicast filtering support for VLAN interfaces in dual
EMAC and HSR offload mode for ICSSG driver.

Patch 1/3 - Adds support for VLAN in dual EMAC mode
Patch 2/3 - Adds MC filtering support for VLAN in dual EMAC mode
Patch 3/3 - Adds MC filtering support for VLAN in HSR mode

Changes from v1 to v2:
*) Changed netdev_err to netdev_dbg in emac_ndo_vlan_rx_del_vid() in patch 1/3
as suggested by Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
*) Dropped patch [1] from previous version as the patch created issue [2].
Will send out a separate patch to set HSR=m in arch/arm64/configs/defconfig.
Once the defconfig patch gets merged, I will add `depends on HSR` in Kconfig
for TI_ICSSG_PRUETH as suggested by Larysa Zaremba <larysa.zaremba@intel.com>

[1] https://lore.kernel.org/all/20241216100044.577489-2-danishanwar@ti.com/
[2] https://lore.kernel.org/all/202412210336.BmgcX3Td-lkp@intel.com/#t
v1 https://lore.kernel.org/all/20241216100044.577489-1-danishanwar@ti.com/

MD Danish Anwar (3):
  net: ti: icssg-prueth: Add VLAN support in EMAC mode
  net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC
    mode
  net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN
    in HSR mode

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 175 ++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +
 include/linux/if_hsr.h                       |  18 ++
 include/linux/netdevice.h                    |   3 +
 net/core/dev_addr_lists.c                    |   7 +-
 net/hsr/hsr_device.c                         |  13 ++
 net/hsr/hsr_main.h                           |   9 -
 7 files changed, 174 insertions(+), 59 deletions(-)


base-commit: ae418e95dd930df6543107521c5ce55e379a9530
-- 
2.34.1


