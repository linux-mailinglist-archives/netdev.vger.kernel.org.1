Return-Path: <netdev+bounces-31822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3817906F0
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D5A1C2090F
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066D3C1E;
	Sat,  2 Sep 2023 09:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D1258F
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 09:20:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1AC8E
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 02:20:16 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd8R70MzJzNmsQ;
	Sat,  2 Sep 2023 17:16:35 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 2 Sep 2023 17:20:13 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <jiri@resnulli.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] team: fix null-ptr-deref when team device type is changed
Date: Sat, 2 Sep 2023 17:20:07 +0800
Message-ID: <20230902092007.3038132-1-william.xuanziyang@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get a null-ptr-deref bug as follows with reproducer [1].

BUG: kernel NULL pointer dereference, address: 0000000000000228
...
RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
...
Call Trace:
 <TASK>
 ? __die+0x24/0x70
 ? page_fault_oops+0x82/0x150
 ? exc_page_fault+0x69/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? vlan_dev_hard_header+0x35/0x140 [8021q]
 ? vlan_dev_hard_header+0x8e/0x140 [8021q]
 neigh_connected_output+0xb2/0x100
 ip6_finish_output2+0x1cb/0x520
 ? nf_hook_slow+0x43/0xc0
 ? ip6_mtu+0x46/0x80
 ip6_finish_output+0x2a/0xb0
 mld_sendpack+0x18f/0x250
 mld_ifc_work+0x39/0x160
 process_one_work+0x1e6/0x3f0
 worker_thread+0x4d/0x2f0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30

[1]
$ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
$ ip link add name t-dummy type dummy
$ ip link add link t-dummy name t-dummy.100 type vlan id 100
$ ip link add name t-nlmon type nlmon
$ ip link set t-nlmon master team0
$ ip link set t-nlmon nomaster
$ ip link set t-dummy up
$ ip link set team0 up
$ ip link set t-dummy.100 down
$ ip link set t-dummy.100 master team0

When enslave a vlan device to team device and team device type is changed
from non-ether to ether, header_ops of team device is changed to
vlan_header_ops. That is incorrect and will trigger null-ptr-deref
for vlan->real_dev in vlan_dev_hard_header() because team device is not
a vlan device.

Use ether_setup() for team device when its type is changed from non-ether
to ether to fix the bug.

Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/net/team/team.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d3dc22509ea5..560e04860aa7 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2127,14 +2127,19 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
-	dev->header_ops	= port_dev->header_ops;
-	dev->type = port_dev->type;
-	dev->hard_header_len = port_dev->hard_header_len;
-	dev->needed_headroom = port_dev->needed_headroom;
-	dev->addr_len = port_dev->addr_len;
-	dev->mtu = port_dev->mtu;
-	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
-	eth_hw_addr_inherit(dev, port_dev);
+	if (port_dev->type == ARPHRD_ETHER) {
+		ether_setup(dev);
+		eth_hw_addr_random(dev);
+	} else {
+		dev->header_ops	= port_dev->header_ops;
+		dev->type = port_dev->type;
+		dev->hard_header_len = port_dev->hard_header_len;
+		dev->needed_headroom = port_dev->needed_headroom;
+		dev->addr_len = port_dev->addr_len;
+		dev->mtu = port_dev->mtu;
+		memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
+		eth_hw_addr_inherit(dev, port_dev);
+	}
 
 	if (port_dev->flags & IFF_POINTOPOINT) {
 		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
-- 
2.25.1


