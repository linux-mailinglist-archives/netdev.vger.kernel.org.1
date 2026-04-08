Return-Path: <netdev+bounces-276257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JvwAoTF1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:03:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC353B6740
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB878308710C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712A636E482;
	Wed,  8 Apr 2026 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rrdytvFu"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CB36CDF3;
	Wed,  8 Apr 2026 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617079; cv=none; b=Olh4WH3QIGeyB+ZhdhNbAJvfKI6WEdmIXlxewzEOB1hwMgFBg2WeIoVrMhriiyU6EhitwfmqmJlXdIsOMUKici7/P2J+D2Y980y1AvUwFDSXzzgQYoWO7ll01RdxhXGVnJ9ARIS6u8+AGO4UzMx2OKl4yRrwvu8OR8tqCzOJBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617079; c=relaxed/simple;
	bh=p4i2QJPlni67Wht2BfsVNm5Qr0eJy+8CZ3lldvWBXso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f9CFeQX9X6qT/SUPW5/VT67ET/BvaoBI7BODwe/EJovG+B2jUsWYng1zcVs2NlcpV0YTgQLOp1JmkP2uuCjBJSccj8ZLpZGCZ0/l54PeMZQdqocRKjMPCK9hB7ce2sfkkZ50uL0oYl5OIo2wKmPnolalJtLDdaJtqwrvAT9wKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rrdytvFu; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kRTQx1v/zW6yoSKlcxN0BockCXbNYg1F0bgr8EIO/8s=;
	b=rrdytvFuR5sr5uCusnI2GFI2ds0ekFjQu1NVJwgwhU7M7ryY9K0MYLPoNXCg+V+MCbcqGCO2r
	VBm7y6f0Er+WP4BJlEA5Liiq0aXmacV3cBQWxSQVEOPBGDqrbzcXgxJZBi9hnH51EpoKK9ALhjz
	LfQgYuFrTV2tkDAUywbkLcM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fr6yq3pS2z12LKF;
	Wed,  8 Apr 2026 10:51:31 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AEF0F40561;
	Wed,  8 Apr 2026 10:57:53 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Apr
 2026 10:57:52 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next] ipv6: sit: remove redundant ret = 0 assignment
Date: Wed, 8 Apr 2026 11:20:51 +0800
Message-ID: <20260408032051.3096449-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yuehaibing@huawei.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 9AC353B6740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable ret is assigned a value at all places where it is used;
There is no need to assign a value when it is initially defined.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: Remove redundant init during definition instead of init before copy_to_user
---
 net/ipv6/sit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ef2e5111fb3a..201347b4e127 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -309,7 +309,7 @@ static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __u
 	struct ip_tunnel_prl kprl, *kp;
 	struct ip_tunnel_prl_entry *prl;
 	unsigned int cmax, c = 0, ca, len;
-	int ret = 0;
+	int ret;
 
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev)
 		return -EINVAL;
-- 
2.34.1


