Return-Path: <netdev+bounces-229506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7ABDCE3F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E94819A835F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AEC313E3D;
	Wed, 15 Oct 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="omNIYx1M"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2D3168E2;
	Wed, 15 Oct 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512570; cv=none; b=sB+fZ1XjeJwDu057FaV/9y6BjzBnTYh49Ylp6sxWHDkCKeigXahBPzQfMprQdi4rkv26JgErbBMZRIMhnrvLYdxbKxFjZrbb2NeGI8Z2+cAk2xrDAYOew7Rb0WdDgogPxUxiu0T1429TgimMhZeksMzGnBJ1G8bY8A5YaI0GTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512570; c=relaxed/simple;
	bh=owUdRXlFRin02Mqb8JtyWl9MraOHDq/iucGgHkwWdKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m97L0fgq/SG5TmyNZAz9pBzKZ6wLsPQ+JNoR9v/PfJwU64mymBBp42VjXCSLImRK7vgnP2HoCPBcAYCvFL5mSOdtdcHxO9ZbNc+4drooMVhTq1BZyt+mW6/3VDae5mlsJpXLq5XmGWINAIRiW72iPWqQADwDqafIUqSrekS7bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=omNIYx1M; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OwcubPtsXRGzCm2ickXmmh52pil1Qbgo3mKU4igvCPI=;
	b=omNIYx1Mmolg0FpfnIWlJ6NBmHLJ1UAjJMNhFt4gXzlfJV7wPYK7kXFoL5ljzZeNnDHU93BtO
	zmpSd/vR0viHBkm/BkXMo7IIztSfTpJdUU0+jJ77vQFthZkFhEnsOZgCY6CoEViBlUNboRc3LtR
	sp9vQiFBBDQDWTzEVA4DNMQ=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cmj6T6F1hzmV6g;
	Wed, 15 Oct 2025 15:15:45 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 13D8F1A0188;
	Wed, 15 Oct 2025 15:16:06 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:16:04 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v01 8/9] hinic3: Remove redundant defensive code
Date: Wed, 15 Oct 2025 15:15:34 +0800
Message-ID: <bb755d2d892a2a1c81d161c4f2f66e7f82154aba.1760502478.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1760502478.git.zhuyikai1@h-partners.com>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

According to comment of patch 03, check codes that were merged and
remove redundant defensive codes.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 59045b231ebe..6e2981488175 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -19,16 +19,10 @@
 int hinic3_alloc_txqs(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 	u16 q_id, num_txqs = nic_dev->max_qps;
 	struct pci_dev *pdev = nic_dev->pdev;
 	struct hinic3_txq *txq;
 
-	if (!num_txqs) {
-		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
-		return -EINVAL;
-	}
-
 	nic_dev->txqs = kcalloc(num_txqs, sizeof(*nic_dev->txqs),  GFP_KERNEL);
 	if (!nic_dev->txqs)
 		return -ENOMEM;
-- 
2.43.0


