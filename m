Return-Path: <netdev+bounces-229507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCFABDCE7B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FFE19C125F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBC3195EF;
	Wed, 15 Oct 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="doODz/HT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0D3148BD;
	Wed, 15 Oct 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512581; cv=none; b=jgJviRZ8pxlMYe9fqIQ2c3T8n0wUUT6Y7u/0cKV1F/bP1B/+ZjyM44gvHknCA4SGNpsK9bfcVrAaJqX8FPaiGhXkJbP8t4Ow4t7R7D+UfX5cWnFJq7v0LmpaHf6Pr3W7/h+qbQx0q1rlr/640W/h+JN3RaKpey0a7FP8czQQFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512581; c=relaxed/simple;
	bh=7B4kA3fus5v+g91BOuLJNjDaHG4KoAB4DZKCoUuuCSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpLaWYsT0apWmpx33K+3pGUn8q6RC3zIUbuGJJIuYu5iewQLZYMxwbkYKydzhtJJhFWSVnxalTEkLUngwXU7Bl1LA0LJReEuOAuPlmyyW/xlKX+RHM2qJHBIfRfefefkrLpkDMMna3xBxUEHePZtwi34gutwjtOQObHr0ZdiC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=doODz/HT; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lzLXlC5xc3e41jHYIE9zMc5uq6scn3dP/PpsZGE84cM=;
	b=doODz/HTPa5iCUomN6LhO2MlZVHaDA4f3rmfaCesWZGiFRK05pZPOwv9xggkc0AM85vG/Tcp6
	YUGE6Y3qMFo736AEqaaeliVjhH2Ne2tNLhW+WsSXcz4QVZRBjWYSfOGTi+H9voNwjanQz3sO2yr
	ov/0Ht0EVdNA0Dm+XG48jAo=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cmj6Z0dPyz1cyNt;
	Wed, 15 Oct 2025 15:15:50 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 467EF140277;
	Wed, 15 Oct 2025 15:16:10 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:16:08 +0800
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
Subject: [PATCH net-next v01 9/9] hinic3: Use array_size instead of multiplying
Date: Wed, 15 Oct 2025 15:15:35 +0800
Message-ID: <f61d407225486962ce37d9641f89b12c008711aa.1760502478.git.zhuyikai1@h-partners.com>
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
use array_size instead of multiplying.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 7bfd7967967d..5ab6f3e9fe06 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -23,7 +23,8 @@ static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 	feature_nego.func_id = hinic3_global_func_id(hwdev);
 	feature_nego.opcode = opcode;
 	if (opcode == MGMT_MSG_CMD_OP_SET)
-		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));
+		memcpy(feature_nego.s_feature, s_feature,
+		       array_size(size, sizeof(u64)));
 
 	mgmt_msg_params_init_default(&msg_params, &feature_nego,
 				     sizeof(feature_nego));
@@ -37,7 +38,8 @@ static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 	}
 
 	if (opcode == MGMT_MSG_CMD_OP_GET)
-		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));
+		memcpy(s_feature, feature_nego.s_feature,
+		       array_size(size, sizeof(u64)));
 
 	return 0;
 }
-- 
2.43.0


