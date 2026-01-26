Return-Path: <netdev+bounces-253304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMbfLby+dmkYVgEAu9opvQ
	(envelope-from <netdev+bounces-253304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370983473
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3A73006158
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 01:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563D22370A;
	Mon, 26 Jan 2026 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pFH6JFXL"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258841D8DFB;
	Mon, 26 Jan 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769389601; cv=none; b=sglKkuZqHfGHAcj/IPxvdQvrBaC8FwvrJ3B36ZulA6gJrdNMWIYkZtFgO9fL0hfp7nWslf/YMWXIzphNzRSNoOMLZK4qpa9yusEtv1CcEGa4rpMpS13vnuzwMZ2tmENPv3r3K9OERKEtf0bXqPY98IjT7idM7hGRzumTUPAWT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769389601; c=relaxed/simple;
	bh=EABVssCM123G7jWb1K2EzG7DAOvkk0hnvjBy1LCXY/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFyiYkFtxuWq63kpdzur5ms2wahwOvO1oAVgXRPxhm8ML/jMqdOgY+RpkOpNg3KTpUAujTRIQthqftwOdPLpvzo27TRkrUXSeHi7i+3EhuHw1GE238eTnXLaDtSV/+XnEq7kQguUWcZBhLgyOV7UVA7VKOOP6y01yqHypKK9VxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pFH6JFXL; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RyoonJga84J5TYM1qUcca+lnnVeYd8lqRPR77Y61Dr4=;
	b=pFH6JFXLbQyoXthbYVtnz8XH05nCtt8/a74b8NqgOmA90cMyIz71b1r684czZpqvGBTqii1gw
	EwJT6JaTFJUWUDxgaSf1e1NybnJQos/F8513ZI0oGkqz2qtv4KwI2v6VtbBasEwh68HEcD/2BUk
	07caBsoVuxLI1MLC5DEUvhk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dzqyx1ZZfz1cypq;
	Mon, 26 Jan 2026 09:03:05 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C35D40563;
	Mon, 26 Jan 2026 09:06:31 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 09:06:29 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v02 3/4] hinic3: Use array_size instead of multiplying
Date: Mon, 26 Jan 2026 09:03:33 +0800
Message-ID: <a68f989c1ee8ae1c505be156ba0b7ac35aca64ef.1769142701.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1769142701.git.zhuyikai1@h-partners.com>
References: <cover.1769142701.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253304-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 1370983473
X-Rspamd-Action: no action

According to comment of patch 03, check codes that were merged and
use array_size instead of multiplying.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index b6cc7bb7bb0c..44abccf9cb29 100644
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


