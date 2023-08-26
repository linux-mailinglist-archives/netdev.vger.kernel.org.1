Return-Path: <netdev+bounces-30851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E0789351
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23861C210AC
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B0644;
	Sat, 26 Aug 2023 02:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9D393
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:19:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E272682;
	Fri, 25 Aug 2023 19:19:40 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXgR63Xc0zNmZJ;
	Sat, 26 Aug 2023 10:16:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 10:19:37 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3] selftests: bonding: create directly devices in the target namespaces
Date: Sat, 26 Aug 2023 10:23:30 +0800
Message-ID: <20230826022330.3474899-1-shaozhengchao@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If failed to set link1_1 to netns client, we should delete link1_1 in the
cleanup path. But if set link1_1 to netns client successfully, delete
link1_1 will report warning. So it will be safer creating directly the
devices in the target namespaces.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v3: create the eth0 in the namespace
v2: create directly devices in the target namespaces
---
 .../drivers/net/bonding/bond-arp-interval-causes-panic.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 7b2d421f09cf..4917dbb35a44 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
@@ -22,14 +22,12 @@ server_ip4=192.168.1.254
 echo 180 >/proc/sys/kernel/panic
 
 # build namespaces
-ip link add dev link1_1 type veth peer name link1_2
-
 ip netns add "server"
-ip link set dev link1_2 netns server up name eth0
+ip netns add "client"
+ip -n client link add eth0 type veth peer name eth0 netns server
+ip netns exec server ip link set dev eth0 up
 ip netns exec server ip addr add ${server_ip4}/24 dev eth0
 
-ip netns add "client"
-ip link set dev link1_1 netns client down name eth0
 ip netns exec client ip link add dev bond0 down type bond mode 1 \
 	miimon 100 all_slaves_active 1
 ip netns exec client ip link set dev eth0 down master bond0
-- 
2.34.1


