Return-Path: <netdev+bounces-231182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBCBF6010
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 551CB4E3AB6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE772F1FED;
	Tue, 21 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v6iYrH0B"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE925B30E;
	Tue, 21 Oct 2025 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045831; cv=none; b=CfgjggsG8KjtVHwRTuj8/YLuGJ3KPWYtvKpxS4dIwddQYfWtfmDUQxBaGLpB3YTNF6Vw9Hpvl0NFLJYN8Ke/tgCoVWyGjWkTqV9eYZ7ptj2+96PNVDOYvhc1rTx0cZhkaaaBpOk3ZMiKPy7/yaMEk0wK8uD05FTUP46LPK+8xW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045831; c=relaxed/simple;
	bh=LZOx7abQiuTJ2qmXAglTLWqFv6inrVG8VRcijwz0x6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gAtPsm0GyhScrUT4ggkK9dsGBm74M3Xg3Ls5BGnr5h24VlC+D/FuepDWXrti+E+yp4uKk2D26+lUEJ3kjO7rM0IGCyB54DQo69LUn0U02/c+eEoyvxEfApRuPmisMGXkDitYJUzPnDZ+zsnfSfbdyvaSDftpsXqFn5/tsMJPoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v6iYrH0B; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eCMwmjCDLEiontfRIrDuCY5MuaVbN1CY3lXLHJf+Vdc=;
	b=v6iYrH0BIAjS0yW5LRbNldf2jT+/PkIf5GRMINo+op0TakcK3dE5XA+pyMUgvV1wQnPP5YIk1
	n1JW16R9LoZe1qrDFoB7IaRvrkoEAhLTdHsAjPMj9PuYwd4xmOoKGUTi4LmZt3jDnzb7OSUEwV+
	jNiDygU7C0xfifFP8Bj1wXw=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4crVJW3SxdzpTKV;
	Tue, 21 Oct 2025 19:22:35 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 819C6140156;
	Tue, 21 Oct 2025 19:23:40 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 19:23:39 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <xmei5@asu.edu>,
	<yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/sched: Remove unused inline helper qdisc_from_priv()
Date: Tue, 21 Oct 2025 19:46:26 +0800
Message-ID: <20251021114626.3148894-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit fb38306ceb9e ("net/sched: Retire ATM qdisc"), this is
not used and can be removed.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/pkt_sched.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 8a75c73fc555..c660ac871083 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -25,11 +25,6 @@ struct qdisc_walker {
 		 const struct Qdisc * : (const void *)&q->privdata,	\
 		 struct Qdisc * : (void *)&q->privdata)
 
-static inline struct Qdisc *qdisc_from_priv(void *priv)
-{
-	return container_of(priv, struct Qdisc, privdata);
-}
-
 /* 
    Timer resolution MUST BE < 10% of min_schedulable_packet_size/bandwidth
    
-- 
2.34.1


