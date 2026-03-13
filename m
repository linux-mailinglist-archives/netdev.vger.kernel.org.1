Return-Path: <netdev+bounces-267323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DW4DC/Ds2mEagAAu9opvQ
	(envelope-from <netdev+bounces-267323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2927F163
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E50A303B82E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4E0375AD9;
	Fri, 13 Mar 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yO8Abm9A"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9A374E74;
	Fri, 13 Mar 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388485; cv=none; b=LBRTQaQome5qRerB7mGWaef1ZJNVp0yq45Bd9azbkBLbxlDU+fJboXG6nkuBqve+DPimHWYnpTKm0RQkJAneLsntiatVaIiq2fFc9lkgw0aazOslXBSnkJ6fezsT9xRaliQ0l3qhmrdFoE7g5MKysiNLJNXvl7GAY0JjThZSTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388485; c=relaxed/simple;
	bh=yO9C2RLv95ulbAN5ed3eGCZMWBDCXNQGpqgwo+38sw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HosCWPwGFGAzOQLVZGezqcBGrG1CQABNJLmRfDeyJZsDDuQahbgi0XU2u3GjTENuz6WlbCN6Me2oeF7Nv6qX6bHud9YmrCflIfS6lNz+FbBNyyrPmMNZo2uMQah7W9Sk3I7iJL99bVqvWahzVuSsW05f09TW+BQ/CfF7+wOxJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yO8Abm9A; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jfUZnJ4KtdHpPCGY9cJFcmBAOCwmguRa9XcAdVY4QSo=;
	b=yO8Abm9ATSZKKMOH13FNuL3epNg8NuwSkXeCPyFFHv9YlFa6L5/W3EepIPMZcWHFN53eHuY8D
	a3vq6dcqNJaQmBTH7zAhct76k6wsZxH0ISUlXB7Cz6N4monh2Kc9qwtYQz89a+zn/OJ/anJrk4B
	A2o5nzt5lfWYZnBHvuKzgfI=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fXGp40Tk8znTWC;
	Fri, 13 Mar 2026 15:49:00 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B03B640565;
	Fri, 13 Mar 2026 15:54:34 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Mar 2026 15:54:33 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v01 5/7] hinic3: Add MTU size validation
Date: Fri, 13 Mar 2026 15:54:12 +0800
Message-ID: <53eb2c11ed4ccd93787352ef48ca56d6d51a150a.1773387649.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1773387649.git.zhuyikai1@h-partners.com>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267323-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,h-partners.com:email,h-partners.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 1EE2927F163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Check whether the MTU size is within a reasonable range.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index e7aa54b0e465..aed95fdeccda 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -246,6 +246,19 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 	struct l2nic_func_tbl_cfg func_tbl_cfg = {};
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
 
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
+		dev_err(hwdev->dev,
+			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
+			new_mtu, HINIC3_MIN_MTU_SIZE);
+		return -EINVAL;
+	}
+
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
+			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
 	func_tbl_cfg.mtu = new_mtu;
 
 	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),
-- 
2.43.0


