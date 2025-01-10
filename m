Return-Path: <netdev+bounces-156995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31502A08A20
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D9D1887952
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68190207DFD;
	Fri, 10 Jan 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MjWBKejD"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CA207DED;
	Fri, 10 Jan 2025 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497766; cv=none; b=DA4XBEBR40uEhRqWWTJXcWgGxTQJjrmRFRExHGJtntXuBKdID04j3og0L3G7Yyup8+XNERtsD8wBrRLxT8XT1GIxhOZZ3bhnBQ0Rtz3GM8e7ZQjbTNSBUnW34Z+uy+9A3ViIWbrYeiRdW7P75pvqE7Iex7lVIkQPUyi/+DEaUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497766; c=relaxed/simple;
	bh=rx4Uq2BfjafEnCrTfg6HnTRGc55+ethKsRrBHrnlnBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKxOQilrwgoZzuLJfjB5bkpUSOgv4WRP58gglyF9gzXv00+vS8YCVYv+oE42uDQpk94jbPUZUYeKFwe0EAy0ZBG3OAnWUjej2qjLrpEPYPA+IHKr/fM5xWOOwy+YvLFq6AstdwkSRcTv31A5/sWNNnGONjf+p1xq1lZA2w7WpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MjWBKejD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50A8T0853390410
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Jan 2025 02:29:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736497740;
	bh=ksMxIna2SYfvVoK6NlK93Su5ZIo00BAOeJb0FMLTUt0=;
	h=From:To:CC:Subject:Date;
	b=MjWBKejDOVQI7xUmJ3Ww28SS1uSe96O+/URvW/VseL39W4IeUgCnE+bYI3rN6B2Z/
	 5LaRAgoW7YNjHiB03FBSYH4scRoxsVio1j2JgsQYRaeUHlE7rWoqdNdmd2TkuL9wk8
	 9j9Tf3a/CMXyI292+PgRi4JRR90hV3bGYVw8dFmU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50A8T0li023404;
	Fri, 10 Jan 2025 02:29:00 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Jan 2025 02:28:59 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Jan 2025 02:28:59 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50A8Sx4Y012643;
	Fri, 10 Jan 2025 02:28:59 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 50A8SvEo021265;
	Fri, 10 Jan 2025 02:28:57 -0600
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
Subject: [PATCH net-next v4 0/4] Add Multicast Filtering support for VLAN interface
Date: Fri, 10 Jan 2025 13:58:48 +0530
Message-ID: <20250110082852.3899027-1-danishanwar@ti.com>
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

Patch 1/4 - Adds support for VLAN in dual EMAC mode
Patch 2/4 - Adds MC filtering support for VLAN in dual EMAC mode
Patch 3/4 - Create and export hsr_get_port_ndev() in hsr_device.c
Patch 4/4 - Adds MC filtering support for VLAN in HSR mode

Changes from v3 to v4:
*) Added RB tag of Roger Quadros <rogerq@kernel.org> to patch 1/4 and addressed
his comment on the same patch.
*) Created a separate patch (Patch 4) for hsr core changes in Patch [3] as
suggested by Roger Quadros <rogerq@kernel.org>.
*) Added details on why __hw_addr_sync_multiple() is used and exported instead
of using __hw_addr_sync() in the commit message of Patch 2/4 as suggested by
Paolo Abeni <pabeni@redhat.com>
*) Added details on why __hw_addr_sync_dev() is used on the local list instead
of using __dev_mc_sync() on the vdev, in the commit message of Patch 2/4 as
suggested by Paolo Abeni <pabeni@redhat.com>

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
[3] https://lore.kernel.org/all/31bb8a3e-5a1c-4c94-8c33-c0dfd6d643fb@kernel.org/
v1 https://lore.kernel.org/all/20241216100044.577489-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20241223092557.2077526-1-danishanwar@ti.com/
v3 https://lore.kernel.org/all/20250103092033.1533374-1-danishanwar@ti.com/


MD Danish Anwar (4):
  net: ti: icssg-prueth: Add VLAN support in EMAC mode
  net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC
    mode
  net: hsr: Create and export hsr_get_port_ndev()
  net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN
    in HSR mode

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 175 ++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +
 include/linux/if_hsr.h                       |  17 ++
 include/linux/netdevice.h                    |   3 +
 net/core/dev_addr_lists.c                    |   7 +-
 net/hsr/hsr_device.c                         |  13 ++
 net/hsr/hsr_main.h                           |   9 -
 7 files changed, 173 insertions(+), 59 deletions(-)


base-commit: 25cc469d6d344f5772e9fb6a5cf9d82a690afe68
-- 
2.34.1


