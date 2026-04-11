Return-Path: <netdev+bounces-277650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJO3BdrC2WlxswgAu9opvQ
	(envelope-from <netdev+bounces-277650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:41:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA63DE3EB
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32ACE3067B1C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC952D7DEF;
	Sat, 11 Apr 2026 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pH/huACQ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06861287263;
	Sat, 11 Apr 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775878660; cv=none; b=WbUcc+tSQXzmbUc+CVfsctyy6hIOtEmCSJEuGdCGKrc8wtZoIe7a+UzRgJ/aK5ukUSGApy8wwOPhrLzk7PQHk0LcmHmfOoXpj8FJk4tg7sqWIKYSs8TjZvn/81+EAX66Cx9ue8u3AKhNy5IPXdvNnVrbW2Z+Fe387U66dM7/6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775878660; c=relaxed/simple;
	bh=mRsw4yg57Q6ywfOJ/40ogGktdOc2/LSEMVQVjf6srbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHsBlpvNouhZyBKrWG0UvpJJUGY/tU/czXcFYnF8C0lSRKlO8f1qUcNGypdlbo+Ty1lsEd2hUlPlhNl0/BTxJ1a/UfKPagtJHDSn3CmFbOAkwq5MpjTpnJ5+/QseNOBzsMz82Aj2I8CY8ZZmeyMYcUJa+1oqle2/T7YPBXN4v+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pH/huACQ; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zswjPgmHBAeT8X9mAqPt/DlL+9nCsIWBSzHJ+IOHRHQ=;
	b=pH/huACQL3vJf6vHAagclEPRy3ceEyDh+9QvWWUe6W8DcDF7yOvftiVm4SFhMd3KlqamOq5ja
	/ido0TTLuCyA6lxvyTOEteDa+TCnlfkv5ENYTuw41VHgEZ/+rN+h6IZ9FRuGsAC4HQSW9x8JTTf
	lG0ofKCjE3cqq2mUgawGmmM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fszjG2v5Lzcb3c;
	Sat, 11 Apr 2026 11:31:14 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BB8D94048F;
	Sat, 11 Apr 2026 11:37:36 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 11 Apr 2026 11:37:35 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v05 5/6] hinic3: Configure netdev->watchdog_timeo to set nic tx timeout
Date: Sat, 11 Apr 2026 11:37:03 +0800
Message-ID: <214abe684f39bc4d4f1b753fcfb79eb4d3631529.1775711066.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1775711066.git.zhuyikai1@h-partners.com>
References: <cover.1775711066.git.zhuyikai1@h-partners.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-277650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,h-partners.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:email,h-partners.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 6DCA63DE3EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Configure netdev watchdog timeout to improve transmission reliability.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 3b470978714a..7e09b4b2da9f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -33,6 +33,8 @@
 #define HINIC3_RX_PENDING_LIMIT_LOW   2
 #define HINIC3_RX_PENDING_LIMIT_HIGH  8
 
+#define HINIC3_WATCHDOG_TIMEOUT       5
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -246,6 +248,8 @@ static void hinic3_assign_netdev_ops(struct net_device *netdev)
 {
 	hinic3_set_netdev_ops(netdev);
 	hinic3_set_ethtool_ops(netdev);
+
+	netdev->watchdog_timeo = HINIC3_WATCHDOG_TIMEOUT * HZ;
 }
 
 static void netdev_feature_init(struct net_device *netdev)
-- 
2.43.0


