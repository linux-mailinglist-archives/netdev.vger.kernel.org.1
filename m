Return-Path: <netdev+bounces-24744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA59177182A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 04:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0F31C206FD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EB64F;
	Mon,  7 Aug 2023 02:10:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B07392
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 02:10:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA61701
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:10:04 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK07k3SCDz1Z1XX;
	Mon,  7 Aug 2023 10:07:14 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:10:01 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <adobriyan@gmail.com>
Subject: [PATCH net-next] ipv6: exthdrs: Replace opencoded swap() implementation
Date: Mon, 7 Aug 2023 10:09:47 +0800
Message-ID: <20230807020947.1991716-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get a coccinelle warning as follows:
net/ipv6/exthdrs.c:800:29-30: WARNING opportunity for swap()

Use swap() to replace opencoded implementation.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 net/ipv6/exthdrs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index f4bfccae003c..4952ae792450 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -648,7 +648,6 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct inet6_dev *idev = __in6_dev_get(skb->dev);
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct in6_addr *addr = NULL;
-	struct in6_addr daddr;
 	int n, i;
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
@@ -796,9 +795,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	daddr = *addr;
-	*addr = ipv6_hdr(skb)->daddr;
-	ipv6_hdr(skb)->daddr = daddr;
+	swap(*addr, ipv6_hdr(skb)->daddr);
 
 	ip6_route_input(skb);
 	if (skb_dst(skb)->error) {
-- 
2.25.1


