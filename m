Return-Path: <netdev+bounces-232787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C79C08E34
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 11:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1281A61722
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BF2D5927;
	Sat, 25 Oct 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="msKRhHp7"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F918EB0;
	Sat, 25 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383045; cv=none; b=AV/cV4Y0kTGWqflpVt63IjHk9n9B7TiKeIYSsnmRMcbAR6rR0rpN5X8RQk6mxluJPl5JCkopTyV31ho/fMU12orktIfyFKD0muEwWGwoDnA0aLC8bTsi7IrQz86uZ9TjuswPQK+a3fHcyOikSyZE5feBuKKwl6mvIhWySIxYkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383045; c=relaxed/simple;
	bh=JX54dqkVcettB79jeo61PXjr1tMDPM5+8OlJj2sQzYw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ssay4wz0k0KQ33U2Puao/GzlNAwb9jY+Vb+mPc4Vj2fW+px7TILxf/oOZWxnLE4G2kTuohO+d4RezWvOo27gwhXvg7FLBtVgwANYjQXbrLJ/rOMwquHsdo723lWfvjAv7L93Yqzhj6UwbI/XzdEFHTM97J9bYYiyotVORQ1oHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=msKRhHp7; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1Vku7UM5vEHO2L1MY81GnHcBlnb5iKV3pBcw9CkFwpA=;
	b=msKRhHp7q8CZ2UjkJ1TKFbxNbX1W8SEWwxXQ0EMvwrUSI554r9jVSej0rGOqKHrBECihdK/HZ
	dZdI9bP3W3ADSkY1L9QJGo0CCA4Q3RR7oGLUz5Jhic3YB6BWi2E9RcaWBsJkYlp8ub/Y7T8ncyU
	hfe14Mkwqg+0632HPSVVr7Q=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctv272ZF3zKm4k;
	Sat, 25 Oct 2025 17:03:27 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id A74AE1A016C;
	Sat, 25 Oct 2025 17:03:53 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 25 Oct
 2025 17:03:52 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>
Subject: [PATCH net-next] net: ipv4: Remove extern udp_v4_early_demux()/tcp_v4_early_demux() in .c files
Date: Sat, 25 Oct 2025 17:26:37 +0800
Message-ID: <20251025092637.1020960-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Function udp_v4_early_demux() was already declared in 'include/net/udp.h',
no need to keep the extern in 'ip_input.c', which may produce the
following checkpatch warning:

  WARNING: externs should be avoided in .c files
  #45: FILE: net/ipv4/ip_input.c:322:
  +enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);

Replace it by including 'net/udp.h'. Do the same for tcp_v4_early_demux().

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/ipv4/ip_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 273578579a6b..19d3141dad1f 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -141,6 +141,8 @@
 #include <linux/mroute.h>
 #include <linux/netlink.h>
 #include <net/dst_metadata.h>
+#include <net/udp.h>
+#include <net/tcp.h>
 
 /*
  *	Process Router Attention IP option (RFC 2113)
@@ -317,8 +319,6 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 	       ip_hdr(hint)->tos == iph->tos;
 }
 
-int tcp_v4_early_demux(struct sk_buff *skb);
-enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);
 static int ip_rcv_finish_core(struct net *net,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
-- 
2.34.1


