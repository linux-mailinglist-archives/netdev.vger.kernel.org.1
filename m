Return-Path: <netdev+bounces-124211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B93968892
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7772B1C22913
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6571DAC5A;
	Mon,  2 Sep 2024 13:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0119C540;
	Mon,  2 Sep 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282804; cv=none; b=A2QlAUWHoGso3CeT4xGnZzhUH+i/NJlZ8sLg56GBjisCVrtkLrcGnJkmMMldTqqQ6yKbF94/ZuZ0/OP5wVt8l1VYFi56IKsFP/lT9qT5/tstJ9hrHtzv4cwhPiwhCxil//Y3V3bUpG8oqk4/ENOyg+Hy+wChSlOnOTqITS0M3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282804; c=relaxed/simple;
	bh=9GI1DWpaagOFtvsyOr38vTOTTmla5Kn/bT86zpoufzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqbBONbcvntEmwggG0rwo3gOFWyMo7/iyuwYUsktdBYrYTJKWne9MSyz2Gy063LZU1F8wO+Uszs9Go3YpivrRSo1xiMGTDfHBM7Pzj+0391BIubR90NOosnwBidoscjKe7GeEQB0PqSlistKo2/d8x6LZFeqC8VdSaXIfpR6Zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wy8Fh2wbrz20nKm;
	Mon,  2 Sep 2024 21:08:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 60EEE1402CC;
	Mon,  2 Sep 2024 21:13:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 21:13:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <alexanderduyck@fb.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew@lunn.ch>,
	<kernel-team@meta.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] eth: fbnic: Fix modpost undefined error
Date: Mon, 2 Sep 2024 21:19:47 +0800
Message-ID: <20240902131947.3088456-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

When CONFIG_FBNIC=m, the following error occurs:

	ERROR: modpost: "priv_to_devlink" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "page_pool_create" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_info_serial_number_put" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "page_pool_alloc_pages" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_priv" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "page_pool_put_unrefed_page" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_unregister" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_alloc_ns" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_register" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
	ERROR: modpost: "devlink_free" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!

The driver now uses functions exported from a helper module
but fails to link when the helper is disabled, select them to fix them

Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/meta/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index c002ede36402..85519690b837 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -23,6 +23,8 @@ config FBNIC
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
+	select NET_DEVLINK
+	select PAGE_POOL
 	select PHYLINK
 	help
 	  This driver supports Meta Platforms Host Network Interface.
-- 
2.34.1


