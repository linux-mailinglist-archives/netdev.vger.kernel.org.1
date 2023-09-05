Return-Path: <netdev+bounces-32094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848E792329
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76583280F11
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55412D51F;
	Tue,  5 Sep 2023 13:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D05664
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:52:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CE197
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 06:52:33 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rg6KX0K2ZztSPR;
	Tue,  5 Sep 2023 21:48:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 5 Sep
 2023 21:52:29 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hadi@cyberus.ca>,
	<netdev@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH net] net: ipv4: fix one memleak in __inet_del_ifa()
Date: Tue, 5 Sep 2023 21:55:54 +0800
Message-ID: <20230905135554.1958156-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I got the below warning when do fuzzing test:
unregister_netdevice: waiting for bond0 to become free. Usage count = 2

It can be repoduced via:

ip link add bond0 type bond
sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
ip addr add 4.117.174.103/0 scope 0x40 dev bond0
ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
ip addr del 4.117.174.103/0 scope 0x40 dev bond0
ip link delete bond0 type bond

In this reproduction test case, an incorrect 'last_prim' is found in
__inet_del_ifa(), as a result, the secondary address(0.0.0.4/0 scope 0x40)
is lost. The memory of the secondary address is leaked and the reference of
in_device and net_device is leaked.

Fix this problem by modifying the PROMOTE_SECONDANCE behavior as follows:
1. Traverse in_dev->ifa_list to search for the actual 'last_prim'.
2. When last_prim is empty, move 'promote' to the in_dev->ifa_list header.

Fixes: 0ff60a45678e ("[IPV4]: Fix secondary IP addresses after promotion")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/ipv4/devinet.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9cf64ee47dd2..99278f4b58e0 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -355,14 +355,13 @@ static void __inet_del_ifa(struct in_device *in_dev,
 {
 	struct in_ifaddr *promote = NULL;
 	struct in_ifaddr *ifa, *ifa1;
-	struct in_ifaddr *last_prim;
+	struct in_ifaddr *last_prim = NULL;
 	struct in_ifaddr *prev_prom = NULL;
 	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
 
 	ASSERT_RTNL();
 
 	ifa1 = rtnl_dereference(*ifap);
-	last_prim = rtnl_dereference(in_dev->ifa_list);
 	if (in_dev->dead)
 		goto no_promotions;
 
@@ -371,7 +370,16 @@ static void __inet_del_ifa(struct in_device *in_dev,
 	 **/
 
 	if (!(ifa1->ifa_flags & IFA_F_SECONDARY)) {
-		struct in_ifaddr __rcu **ifap1 = &ifa1->ifa_next;
+		struct in_ifaddr __rcu **ifap1 = &in_dev->ifa_list;
+
+		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
+			if (ifa1 == ifa)
+				break;
+			last_prim = ifa;
+			ifap1 = &ifa->ifa_next;
+		}
+
+		ifap1 = &ifa1->ifa_next;
 
 		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
@@ -440,9 +448,15 @@ static void __inet_del_ifa(struct in_device *in_dev,
 
 			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
 
-			last_sec = rtnl_dereference(last_prim->ifa_next);
-			rcu_assign_pointer(promote->ifa_next, last_sec);
-			rcu_assign_pointer(last_prim->ifa_next, promote);
+			if (last_prim) {
+				last_sec = rtnl_dereference(last_prim->ifa_next);
+				rcu_assign_pointer(promote->ifa_next, last_sec);
+				rcu_assign_pointer(last_prim->ifa_next, promote);
+			} else {
+				rcu_assign_pointer(promote->ifa_next,
+						   rtnl_dereference(in_dev->ifa_list));
+				rcu_assign_pointer(in_dev->ifa_list, promote);
+			}
 		}
 
 		promote->ifa_flags &= ~IFA_F_SECONDARY;
-- 
2.34.1


