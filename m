Return-Path: <netdev+bounces-227346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E599DBACCB5
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F2448109A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725452FB0B3;
	Tue, 30 Sep 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MIE7i7nf"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58382FB0A3;
	Tue, 30 Sep 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234610; cv=none; b=sECYMtOqz/6Qa5hRst1xKQGwuV+mh8iMlZEEV2UIaKJhDh/mXLVIq7gHMsu57jUYD7oXmEnwwjLrYm3iYSU7OFUipQ+ddP98Xwbrdstr5jwkFFVqaBoGVbvpzXJziRCFPiIlfGbqBgzYrOdWTfE2BG9VosYYiF1KoatkeGn7OvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234610; c=relaxed/simple;
	bh=PFkJkDiegzHcMl8oxZ1uoDqOWC+vLht85C30PJmvFqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jA4Ft7FDPyE8xdgq78MbG/ZP6HMGhH7DCx49XokO5RNDlVp2Jw8IU3lkvkZ7nUG6NDuCmrFEt+vB+fqvo9D3tge50qZy/H9wp72771gd/lvb7mc9Hygvd2Uy95aKjbparE//CNrdEf+3bBoIwFJrcrf5KrZEfefsygSMbeHQOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MIE7i7nf; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58UCGMc72911951;
	Tue, 30 Sep 2025 07:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759234582;
	bh=FvXw5gf1FTJcHDUr+9qLaj7NX8ubdoIWyGKeOiODosk=;
	h=From:To:CC:Subject:Date;
	b=MIE7i7nfgPz/HFll/CT4WhrKWQIIqIVNe/GYHwG6zwD1kt4i3SGdFXdCval7jiXS4
	 R3FB9drFRpdbkfAlX8COBkkyNYc38I4QVRb1N+4M92AYUEO0lFQ/9WYRBEVF7p10/a
	 LQK71qsZeKnVy4ltUbq3UPPBONbg6ZZi9NRKxHUY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58UCGMD33905823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 30 Sep 2025 07:16:22 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 30
 Sep 2025 07:16:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Sep 2025 07:16:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58UCGLsD3150256;
	Tue, 30 Sep 2025 07:16:21 -0500
From: Nishanth Menon <nm@ti.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/3] soc: ti: Fix crash in error path when DMA channel open fails
Date: Tue, 30 Sep 2025 07:16:06 -0500
Message-ID: <20250930121609.158419-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

This is a respin of V1 of the series, to address a crash seen in
kernelci.org automated testing[1].

Changes in V2:
- Took Simon's suggestion in refactoring code to make
  knav_dma_open_channel return NULL and fix the callers accordingly.

Since the series does have inter-dependencies, I suggest the full series
could either go via net tree OR via SoC tree (if net maintainers dont
mind acking it). Personally, I have no issues of getting it via the net
tree.

I dropped the fixes tag here, any better suggestion to hit stable will
be nice to know, since the code is refactored a bit here.

V1: https://lore.kernel.org/all/20250926150853.2907028-1-nm@ti.com/

[1] https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
Nishanth Menon (3):
  net: ethernet: ti: netcp: Handle both ERR_PTR and NULL from
    knav_dma_open_channel
  soc: ti: knav_dma: Make knav_dma_open_channel return NULL on error
  net: ethernet: ti: Remove IS_ERR_OR_NULL checks for
    knav_dma_open_channel

 drivers/net/ethernet/ti/netcp_core.c | 10 +++++-----
 drivers/soc/ti/knav_dma.c            | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.47.0


