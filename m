Return-Path: <netdev+bounces-238632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E8C5C4A2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78E5F35D8EF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D5A304BC4;
	Fri, 14 Nov 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FbZP16Pt"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6253054E3;
	Fri, 14 Nov 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112201; cv=none; b=KKvomB9AvIl3Ibj3TpoubuBZmG1FS+OVnY9sJSpuZb43HSS4ZVKnSqI/XSJIt1yLQxYPGvu1nbYZq9g1YTRUTj+cSOOgPaX9Bc/2ri+FDh6A8FHAqDWnhg67WZT4qhu6n0NnrhUgO7LueQG17iN3Zaz2eSjib5okmDsvSKBwdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112201; c=relaxed/simple;
	bh=02JACI8FokD8IjUOLkvhVP7QsTbd71GDiXXwbKy8118=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjp9hnG/cCdpJHQC1S8OsIejQ2UmA1r5kxBPVRIzlJH8IL9HmaW7HZCuJmMproBTf0aMRvqDSDQ5UXaSfwOfqtOZ/ASeQUJ04l5EteoNzDwvJpvtEcmYe902SUpKvbE6lS9JN+4PfNVoKS6inwPtDyrE6GPTiGkZ+0pb1quLlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FbZP16Pt; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iGGQ7mxPtW5hd+Yq2LPWPfwjve6EOZAzATPlOWzbIbU=;
	b=FbZP16Ptk1OSxHUcR+LTc4IxaKPl2XIcnXGHPae3MhGUFshF4u1ed9NU9fDXsQT8JFJC/BO2m
	wXakauB9JAcoNhlQcaQHylojQTG1RITKblCC6cxbsto/+Kvtke96NWX0G1z/Fm32kUbct9fggYN
	wi8pODi+Ox8RhIw4bvV2G4U=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d7BTp1mm6zKm4R;
	Fri, 14 Nov 2025 17:21:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 88C00140275;
	Fri, 14 Nov 2025 17:23:15 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Nov 2025 17:23:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 0/3] net: hibmcge: Add tracepoint and pagepool for hibmcge driver
Date: Fri, 14 Nov 2025 17:22:19 +0800
Message-ID: <20251114092222.2071583-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

In this patch set:
1: add tracepoint for rx descriptor
2: double the rx queue depth to reduce packet drop
3: add pagepool for rx

Jijie Shao (2):
  net: hibmcge: reduce packet drop under stress testing
  net: hibmcge: support pagepool for rx

Tao Lan (1):
  net: hibmcge: Add tracepoint function to print some fields of rx_desc

 drivers/net/ethernet/hisilicon/Kconfig        |   1 +
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  23 +-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   7 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   4 +
 .../ethernet/hisilicon/hibmcge/hbg_trace.h    |  84 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 211 ++++++++++++++++--
 8 files changed, 310 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h

-- 
2.33.0


