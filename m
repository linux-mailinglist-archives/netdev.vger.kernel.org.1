Return-Path: <netdev+bounces-154943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE7DA006C7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B0D1884630
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEB1D5149;
	Fri,  3 Jan 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KlcVJOAa"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D61D47BC;
	Fri,  3 Jan 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896074; cv=none; b=nsEMuDD5At99AO82RAImv46X+NAQYk+AkfCFwJA8dr6i1y11JKBHtEgckEX4CoyozqqKRblcejkfhphLJyTZTNAwqZW27jcOJg7dK7dJnD0LnbFMlikC95m84i0AK+BzHq5RQ/Q/YIK4M1KvZ1Xw8PPzCnx+ytSk69X2OCFUSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896074; c=relaxed/simple;
	bh=eG9AlDlZ6O6d3G4sBfN3KWoE8sN4sD0tjGg1sIPtQlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6xrn2WgY/ctBv0bMfMrkv203bhRmGKUK8pBXHmp5cIpWPf9dhoMxMIkY/4InnvKm2GB95PkSG4q6/83v40bu3OgjYv3HNFWNkgVr3RedJzmo3bSjF321HkBxdlf1G6WZc8nG0AcaP77WiOAjWdUtgwycyoXZqwbe/5GCorcymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KlcVJOAa; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5039Kc6H2301473
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 03:20:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1735896038;
	bh=gA61Qgd412YVnbWRnsA8Xz+iZMRyWVXVVtbVH2xqtkA=;
	h=From:To:CC:Subject:Date;
	b=KlcVJOAaKpfdGiGRYON3Cgv1SSVJLX/XGLJodR2ax+zpccgD2cIm6DJ4Mxxhhgpk/
	 BIA+Td8iZAVcOryDUQFSfpNN+Q6Zpa4dd9rrnW+eKLmvttCUKDqGx/GlIoIUOmZ684
	 GCaCO8J9RyKa77W3eJYUoYZKBbj7vK9mjaT+9aig=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5039KcwK004083
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jan 2025 03:20:38 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Jan 2025 03:20:38 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Jan 2025 03:20:37 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5039KcAL069359;
	Fri, 3 Jan 2025 03:20:38 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 5039Kard016890;
	Fri, 3 Jan 2025 03:20:37 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Jeongjun Park <aha310510@gmail.com>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>,
        Lukasz Majewski <lukma@denx.de>, Meghana
 Malladi <m-malladi@ti.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>,
        Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: [PATCH net-next v3 0/3] Add Multicast Filtering support for VLAN interface
Date: Fri, 3 Jan 2025 14:50:30 +0530
Message-ID: <20250103092033.1533374-1-danishanwar@ti.com>
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

Changes from v2 to v3:
*) Rebased on latest net-next and re-spun the series as net-next is now open.
*) No functional change.

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
v2 https://lore.kernel.org/all/20241223092557.2077526-1-danishanwar@ti.com/

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


base-commit: 94c16fd4df9089931f674fb9aaec41ea20b0fd7a
-- 
2.34.1


