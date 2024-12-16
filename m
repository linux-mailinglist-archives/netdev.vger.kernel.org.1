Return-Path: <netdev+bounces-152138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B49F2DA5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431FE160280
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DD201110;
	Mon, 16 Dec 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JpVUHUmn"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4D1C54BE;
	Mon, 16 Dec 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343290; cv=none; b=dP1zXzg42Nja9bfsqknAUTW1Rvie+UEGEUmAtMIQPxnTkomEWM7T65Kad3uH7t/puB6O3/ggIhQXeFZ06x7Q+by8Q9gOylR+MWRmDC0bhfbpyVV7cnpxGd1fC5wSkIjFTRNxtEpBDrGtsHMHx3DOwgu95LUJZfN35ZiF09ebmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343290; c=relaxed/simple;
	bh=TCwJ29ju5tL+FHYY8Nq9Gg+HqzrMbbf/UWp8sBfoneI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyNQiCoNMwgkYJs5tbtRNgS80BgIlBVvux8uN921Va8qp/1kLxM2iU7x63gOuA5PbDb9wn/H3fy6xsIQ1v06l9YrxTO2lX1LRtxfyOZ/B9nMh4Y/ICoUk4B6gqr2rXGeAocUiUc2FCidiRXwjG8y75tq+jYepHYv9e8f4vqx2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JpVUHUmn; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGA0ttb3459834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 04:00:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734343256;
	bh=FM+sFYYI3tmGu4yC2JB04a6Mv0fiDAJYTqw7+y8rEa8=;
	h=From:To:CC:Subject:Date;
	b=JpVUHUmncbTgTioMByyUBFTroeUoXkgK47p+wDCIeY8w/TuGWw08H00sZ7q83Frxa
	 4lhI0Zfl3wjSii8tA5FecphH2lVQL5FqvKGXKPO1Ji91alH4Uh8QMbqNI+WWwK/Hsh
	 W+di/8d4l/jkz0xDh0MxctI9mMBKBOAlqyA9ObnY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGA0tXN058748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 04:00:55 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 04:00:55 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 04:00:55 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA0tSl079558;
	Mon, 16 Dec 2024 04:00:55 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BGA0sde000609;
	Mon, 16 Dec 2024 04:00:55 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>,
        <schnelle@linux.ibm.com>, <vladimir.oltean@nxp.com>,
        <horms@kernel.org>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 0/4] Add Multicast Filtering support for VLAN interface
Date: Mon, 16 Dec 2024 15:30:40 +0530
Message-ID: <20241216100044.577489-1-danishanwar@ti.com>
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

Patch 1/4 - Selects symbol HSR for TI_ICSSG_PRUETH. Changes NET_SWITCHDEV
from 'depends on' to 'select' as keeping it as 'depends on' results in
below error

  *** Default configuration is based on 'defconfig'
  error: recursive dependency detected!
    symbol NET_DSA depends on HSR
    symbol HSR is selected by TI_ICSSG_PRUETH
    symbol TI_ICSSG_PRUETH depends on NET_SWITCHDEV
    symbol NET_SWITCHDEV is selected by NET_DSA
  For a resolution refer to Documentation/kbuild/kconfig-language.rst
  subsection "Kconfig recursive dependency limitations"

Patch 2/4 - Adds support for VLAN in dual EMAC mode
Patch 3/4 - Adds MC filtering support for VLAN in dual EMAC mode
Patch 4/4 - Adds MC filtering support for VLAN in HSR mode

MD Danish Anwar (4):
  net: ti: Kconfig: Select HSR for ICSSG Driver
  net: ti: icssg-prueth: Add VLAN support in EMAC mode
  net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC
    mode
  net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN
    in HSR mode

 drivers/net/ethernet/ti/Kconfig              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 170 ++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +
 include/linux/if_hsr.h                       |  16 ++
 include/linux/netdevice.h                    |   3 +
 net/core/dev_addr_lists.c                    |   7 +-
 net/hsr/hsr_device.c                         |  12 ++
 net/hsr/hsr_main.h                           |   9 -
 8 files changed, 168 insertions(+), 60 deletions(-)


base-commit: 92c932b9946c1e082406aa0515916adb3e662e24
-- 
2.34.1


