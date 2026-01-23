Return-Path: <netdev+bounces-252734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI7uDnJEc2lEuQAAu9opvQ
	(envelope-from <netdev+bounces-252734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:50:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90914739DD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF9A303B4D0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E39369228;
	Fri, 23 Jan 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HibqRZPK"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E737107B;
	Fri, 23 Jan 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161779; cv=none; b=KM9VN0MD0l0sVMHiPBxiJsGknseQET0YWw/0uxNrUV+pd5TuXTpr82KcUM8jObH5xtCWg64Tcofk1D4aRonPtVR1LrXHj33lBwvWjrSyTsx9+grDlKcsGLl91Vo76/f5MXoSTQVZX2V/U0oJWBILau5qNtW80FDIeIRJznYy+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161779; c=relaxed/simple;
	bh=SANBt9v53PojYwzL+btlFGo8Mdg9ySZFodoga8LDcQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2j8mRSAtJ/5t2k8T1XQ364crenbElSKkBiUiIonDLv8a71NbiyUYMv9/ZYo7g4e0MlB36821Dce+OW3IGCOOuCyHGUTUHz0fpkjR7EjzBE7C85eQ7B131aXCcCvAFnIEC73M4yzd9f2rtfFiZS8qTSyY+lQvtkTwyXSIPjUMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HibqRZPK; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rb5sodHNkCxcuSWbt8wbfYNculT0E1eweZYwNIR0K6w=;
	b=HibqRZPK+SJhY/LsbbDloW8yXfBVc7bKecybbUqkPxL3UvSGiCPH04byZHqxZ585Zvev2jb+y
	ST9cAZkXoWx4CQ12Qqh4yZh7wop54wgkBTsCv/djWKXP15OoWZXjyCNUw5NYm3J3aackr1Gd12r
	A9ArOqFyagT12d9f4/XGjTY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dyCjc4yDdz1K9BX;
	Fri, 23 Jan 2026 17:45:56 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E08240363;
	Fri, 23 Jan 2026 17:49:19 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 23 Jan 2026 17:49:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 2/2] net: hns3: extend HCLGE_FD_AD_COUNTER_NUM to 8 bits
Date: Fri, 23 Jan 2026 17:47:56 +0800
Message-ID: <20260123094756.3718516-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260123094756.3718516-1-shaojijie@huawei.com>
References: <20260123094756.3718516-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252734-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90914739DD
X-Rspamd-Action: no action

Currently, HCLGE_FD_AD_COUNTER_NUM has only 7 bits and supports a
maximum of 127 counter_id. However, there are actually scenarios
where the counter_id exceeds 127.

This patch adds an additional bit to HCLGE_FD_AD_QID to ensure
that counter_id greater than 127 are supported.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 6 ++++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index bc333d8710ac..4ce92ddefcde 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -26,6 +26,7 @@ struct hclge_misc_vector {
 #define HCLGE_TQP_REG_OFFSET		0x80000
 #define HCLGE_TQP_REG_SIZE		0x200
 
+#define HCLGE_FD_COUNTER_MAX_SIZE_DEV_V2	128
 #define HCLGE_TQP_MAX_SIZE_DEV_V2	1024
 #define HCLGE_TQP_EXT_REG_OFFSET	0x100
 
@@ -730,8 +731,8 @@ struct hclge_fd_tcam_config_3_cmd {
 #define HCLGE_FD_AD_QID_L_S		2
 #define HCLGE_FD_AD_QID_L_M		GENMASK(11, 2)
 #define HCLGE_FD_AD_USE_COUNTER_B	12
-#define HCLGE_FD_AD_COUNTER_NUM_S	13
-#define HCLGE_FD_AD_COUNTER_NUM_M	GENMASK(19, 13)
+#define HCLGE_FD_AD_COUNTER_NUM_L_S	13
+#define HCLGE_FD_AD_COUNTER_NUM_L_M	GENMASK(19, 13)
 #define HCLGE_FD_AD_NXT_STEP_B		20
 #define HCLGE_FD_AD_NXT_KEY_S		21
 #define HCLGE_FD_AD_NXT_KEY_M		GENMASK(25, 21)
@@ -742,6 +743,7 @@ struct hclge_fd_tcam_config_3_cmd {
 #define HCLGE_FD_AD_TC_SIZE_S		17
 #define HCLGE_FD_AD_TC_SIZE_M		GENMASK(20, 17)
 #define HCLGE_FD_AD_QID_H_B		21
+#define HCLGE_FD_AD_COUNTER_NUM_H_B	26
 
 struct hclge_fd_ad_config_cmd {
 	u8 stage;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a90f1a91f997..edec994981c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5681,6 +5681,9 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 	}
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_QID_H_B,
 		      action->queue_id >= HCLGE_TQP_MAX_SIZE_DEV_V2 ? 1 : 0);
+	hnae3_set_bit(ad_data, HCLGE_FD_AD_COUNTER_NUM_H_B,
+		      action->counter_id >= HCLGE_FD_COUNTER_MAX_SIZE_DEV_V2 ?
+		      1 : 0);
 	ad_data <<= 32;
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DROP_B, action->drop_packet);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DIRECT_QID_B,
@@ -5688,8 +5691,8 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 	hnae3_set_field(ad_data, HCLGE_FD_AD_QID_L_M, HCLGE_FD_AD_QID_L_S,
 			action->queue_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_USE_COUNTER_B, action->use_counter);
-	hnae3_set_field(ad_data, HCLGE_FD_AD_COUNTER_NUM_M,
-			HCLGE_FD_AD_COUNTER_NUM_S, action->counter_id);
+	hnae3_set_field(ad_data, HCLGE_FD_AD_COUNTER_NUM_L_M,
+			HCLGE_FD_AD_COUNTER_NUM_L_S, action->counter_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_NXT_STEP_B, action->use_next_stage);
 	hnae3_set_field(ad_data, HCLGE_FD_AD_NXT_KEY_M, HCLGE_FD_AD_NXT_KEY_S,
 			action->next_input_key);
-- 
2.33.0


