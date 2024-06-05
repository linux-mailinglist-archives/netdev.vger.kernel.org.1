Return-Path: <netdev+bounces-100822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D38FC27B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D62AB21983
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 03:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3176CDB1;
	Wed,  5 Jun 2024 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GrqcoXaD"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97315FB9A;
	Wed,  5 Jun 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559809; cv=none; b=iRPft7EaKgipoy11WIVO7TPmldkX6wMdLHSwI0huNQv2Jwdlzy9Nb3hyAWpg9hCy59Y74EQ94FdWhplL/36L6niw9Sy3Zuh31GAiJqqd8TiPVzTrZLnUg6e+d8irJsNY6fl7+pXn8/XsmG4NOwtMTtg6hUaRl/hjjT8GBNTvkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559809; c=relaxed/simple;
	bh=hk2D7uwshbmL4rDfcux+sm8te1C9QlmOzV5aEvO5Nm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5/QHd5VHY1Ow9LRbj+nqF4icnGba8tMuTVA4TdD2eHIhMDI7E06th5L+1W4pQgMBQfsKwChf17oKthjIpHUjW34wm6OC6R+SNTtJcVfTzDYzKXVRiVCM9VjDDRh40Va/sxfhQyOwzR0VZHbo3fwZbU53lZkie6V7LY8a9vzeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GrqcoXaD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4553uKoi130041;
	Tue, 4 Jun 2024 22:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717559781;
	bh=CUnhddB1rjYEYRpo+VZpm5Fj/lCuN3+PrpS8Kuc0p0E=;
	h=From:To:CC:Subject:Date;
	b=GrqcoXaDNPWsiZKW4PrHPHvHGB4F6MJagIrw1lX14DCpsaeFxd0yU9X4gsHgDy0Ai
	 4+rmHgC2VeNu8IXBWlz25poO3kdZGTxwOBAiQx/2xl9fQTbJ/2WGWmtRwms7KHTSTl
	 37PFyZujUgzSc/gPAiMBjZOcJ6CY5Uvjx4Ty83/E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4553uKMA113620
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 22:56:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 22:56:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 22:56:20 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4553uK7t121579;
	Tue, 4 Jun 2024 22:56:20 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4553uJFf017369;
	Tue, 4 Jun 2024 22:56:20 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH net-next] net: ethernet: ti: Makefile: Add icssg_queues.o in TI_ICSSG_PRUETH_SR1
Date: Wed, 5 Jun 2024 09:26:17 +0530
Message-ID: <20240605035617.2189393-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

icssg_config.c uses some APIs that are defined in icssg_queue.c.
TI_ICSSG_PRUETH_SR1 uses icssg_config.o but not icssg_queues.o as a
result the below build error is seen

ERROR: modpost: "icssg_queue_pop"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
ERROR: modpost: "icssg_queue_push"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!

Fix this by adding icssg_queues.o in TI_ICSSG_PRUETH_SR1

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405182038.ncf1mL7Z-lkp@intel.com/
Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Thorsten Leemhuis <linux@leemhuis.info>

NOTE: This is only applicable on net-next but not on net as the patch that
introduced this dependency is part of net-next.

 drivers/net/ethernet/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 59cd20a38267..79464ad6f1e8 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o \
 		      icssg/icssg_common.o \
 		      icssg/icssg_classifier.o \
+		      icssg/icssg_queues.o \
 		      icssg/icssg_config.o \
 		      icssg/icssg_mii_cfg.o \
 		      icssg/icssg_stats.o \

base-commit: cd0057ad75116bacf16fea82e48c1db642971136
-- 
2.34.1


