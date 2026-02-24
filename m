Return-Path: <netdev+bounces-260532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLLwGn+mnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:24:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73961879A8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3998318D224
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F533A0E98;
	Tue, 24 Feb 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ef0hkez6"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95163A0B27;
	Tue, 24 Feb 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938983; cv=none; b=c66oGa16hYpgY60vLE1c1oPLc25fm91QnS4lBVPbJg2U6uTjRo9X9Qz8koGj9b702BZukjEpHrEEzYHRgZOXvboTZQex062LydhFyWh+EWwqHYWCvG4XrDH0TUwvGH33wdXbGzwXesN6WCi/And8Z1hWRlcF2RktH5esSHlLoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938983; c=relaxed/simple;
	bh=1n1JFFSsnJ4S0SjSrsCZmNziMLFcd8MY4OQGEhWmRuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/k9GLZmMgcpFyI3GRhSVBHQdQMD5YGDJpb/ujEHQWXnz20LyF+qO+v4ADpUHm3UN4zaqsKHyWdkPG7X+ZcaAUAkiwsQ4gZ+TlH+4aF6FOH62E6Xc0EKJeMHM8jGjt7LtH3XEwlfY2kyRLXAMh9D5F1LALH6WSUKMyvzpCNAPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ef0hkez6; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4F86HGpzEnxmd8j3S0gmeUC3XNn6PZTHj4EFCv9toUw=;
	b=ef0hkez6a1gy02L+gtcgxjijoW7ohbwhjAy+CCbH2Xj0X0XAxLT8GK8jqZx0Gq7YrmCZVb+F4
	5xOSubBZ75RKVC0QAN+SwNPunKeYBCjdLGcTGXEa8gHgr83QUDVggUEW0gpeOaDkpVi5Mfj7POa
	K1dMwOsjnM+R5xQyr8Z4gYg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fKylx6cnXz1T4gn;
	Tue, 24 Feb 2026 21:11:25 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C9C92016A;
	Tue, 24 Feb 2026 21:16:16 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:15 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 08/15] hinic3: Add PF/VF capability parsing and parameter validation
Date: Tue, 24 Feb 2026 21:15:45 +0800
Message-ID: <d9c36fd38cdb5e139edc2af2aa2c123c80d73660.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260532-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:mid,h-partners.com:email,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: E73961879A8
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 53 ++++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  8 +++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 7827c1f626db..77534320c6a1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -17,6 +17,17 @@ static void hinic3_parse_pub_res_cap(struct hinic3_hwdev *hwdev,
 {
 	cap->port_id = dev_cap->port_id;
 	cap->supp_svcs_bitmap = dev_cap->svc_cap_en;
+
+	cap->cos_valid_bitmap = dev_cap->valid_cos_bitmap;
+	cap->port_cos_valid_bitmap = dev_cap->port_cos_valid_bitmap;
+
+	if (type != HINIC3_FUNC_TYPE_VF)
+		cap->max_vf = dev_cap->max_vf;
+	else
+		cap->max_vf = 0;
+
+	dev_dbg(hwdev->dev, "Port_id: 0x%x, cos_bitmap: 0x%x, Max_vf: 0x%x\n",
+		cap->port_id, cap->cos_valid_bitmap, cap->max_vf);
 }
 
 static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
@@ -28,6 +39,23 @@ static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
 
 	nic_svc_cap->max_sqs = min(dev_cap->nic_max_sq_id + 1,
 				   HINIC3_CFG_MAX_QP);
+
+	nic_svc_cap->max_rqs = dev_cap->nic_max_rq_id + 1;
+	nic_svc_cap->default_num_queues = dev_cap->nic_default_num_queues;
+
+	dev_dbg(hwdev->dev, "L2nic resource capbility, max_sqs: 0x%x, max_rqs: 0x%x\n",
+		nic_svc_cap->max_sqs, nic_svc_cap->max_rqs);
+
+	/* Check parameters from firmware */
+	if (nic_svc_cap->max_sqs > HINIC3_CFG_MAX_QP ||
+	    nic_svc_cap->max_rqs > HINIC3_CFG_MAX_QP) {
+		dev_dbg(hwdev->dev,
+			"Number of qp exceeds limit[1-%d]: sq: %u, rq: %u\n",
+			HINIC3_CFG_MAX_QP, nic_svc_cap->max_sqs,
+			nic_svc_cap->max_rqs);
+		nic_svc_cap->max_sqs = HINIC3_CFG_MAX_QP;
+		nic_svc_cap->max_rqs = HINIC3_CFG_MAX_QP;
+	}
 }
 
 static void hinic3_parse_dev_cap(struct hinic3_hwdev *hwdev,
@@ -69,6 +97,29 @@ static int get_cap_from_fw(struct hinic3_hwdev *hwdev,
 	return 0;
 }
 
+static int hinic3_get_dev_cap(struct hinic3_hwdev *hwdev)
+{
+	enum hinic3_func_type type = HINIC3_FUNC_TYPE(hwdev);
+	int err;
+
+	switch (type) {
+	case HINIC3_FUNC_TYPE_PF:
+	case HINIC3_FUNC_TYPE_VF:
+		err = get_cap_from_fw(hwdev, type);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to get PF capability\n");
+			return err;
+		}
+		break;
+	default:
+		dev_err(hwdev->dev, "Unsupported PCI Function type: %d\n",
+			type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
@@ -216,7 +267,7 @@ void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
 
 int hinic3_init_capability(struct hinic3_hwdev *hwdev)
 {
-	return get_cap_from_fw(hwdev, HINIC3_FUNC_TYPE_VF);
+	return hinic3_get_dev_cap(hwdev);
 }
 
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index 58806199bf54..361c0b6a70f0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -26,6 +26,8 @@ struct hinic3_irq_info {
 
 struct hinic3_nic_service_cap {
 	u16 max_sqs;
+	u16 max_rqs;
+	u16 default_num_queues;
 };
 
 /* Device capabilities */
@@ -34,6 +36,12 @@ struct hinic3_dev_cap {
 	u16                           supp_svcs_bitmap;
 	/* Physical port */
 	u8                            port_id;
+
+	u8                            cos_valid_bitmap;
+	u8                            port_cos_valid_bitmap;
+	/* max number of VFs that PF supports */
+	u16                           max_vf;
+
 	struct hinic3_nic_service_cap nic_svc_cap;
 };
 
-- 
2.43.0


