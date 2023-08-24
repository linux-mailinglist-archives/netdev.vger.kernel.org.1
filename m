Return-Path: <netdev+bounces-30382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE77870DE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571791C20E34
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D9100C5;
	Thu, 24 Aug 2023 13:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF1118D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:53:23 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83DF19B5;
	Thu, 24 Aug 2023 06:53:21 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWkyq0LtwzrSM7;
	Thu, 24 Aug 2023 21:51:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 24 Aug
 2023 21:53:18 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2] selftests: bonding: create directly devices in the target namespaces
Date: Thu, 24 Aug 2023 21:57:15 +0800
Message-ID: <20230824135715.1131084-1-shaozhengchao@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2: create directly devices in the target namespaces
---
 .../drivers/net/bonding/bond-arp-interval-causes-panic.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
index 7b2d421f09cf..fe7c34f89fc7 100755
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
+ip link add dev eth0 netns client type veth peer name eth0 netns server
+ip netns exec server ip link set dev eth0 up
 ip netns exec server ip addr add ${server_ip4}/24 dev eth0
 
-ip netns add "client"
-ip link set dev link1_1 netns client down name eth0
 ip netns exec client ip link add dev bond0 down type bond mode 1 \
 	miimon 100 all_slaves_active 1
 ip netns exec client ip link set dev eth0 down master bond0
-- 
2.34.1


