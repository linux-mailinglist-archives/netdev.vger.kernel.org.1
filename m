Return-Path: <netdev+bounces-23619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1976CBF0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65A01C21263
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C116FCF;
	Wed,  2 Aug 2023 11:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3863C0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 11:43:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7848F2695
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 04:43:28 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG94w4Br2zNmkw;
	Wed,  2 Aug 2023 19:40:00 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 19:43:25 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
	<tglx@linutronix.de>, <vadim.fedorenko@linux.dev>, <idosch@idosch.org>,
	<kaber@trash.net>, <netdev@vger.kernel.org>
Subject: [PATCH net v2] bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
Date: Wed, 2 Aug 2023 19:43:20 +0800
Message-ID: <20230802114320.4156068-1-william.xuanziyang@huawei.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BUG_ON(!vlan_info) is triggered in unregister_vlan_dev() with
following testcase:

  # ip netns add ns1
  # ip netns exec ns1 ip link add bond0 type bond mode 0
  # ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
  # ip netns exec ns1 ip link set bond_slave_1 master bond0
  # ip netns exec ns1 ip link add link bond_slave_1 name vlan10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link add link bond0 name bond0_vlan10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link set bond_slave_1 nomaster
  # ip netns del ns1

The logical analysis of the problem is as follows:

1. create ETH_P_8021AD protocol vlan10 for bond_slave_1:
register_vlan_dev()
  vlan_vid_add()
    vlan_info_alloc()
    __vlan_vid_add() // add [ETH_P_8021AD, 10] vid to bond_slave_1

2. create ETH_P_8021AD protocol bond0_vlan10 for bond0:
register_vlan_dev()
  vlan_vid_add()
    __vlan_vid_add()
      vlan_add_rx_filter_info()
          if (!vlan_hw_filter_capable(dev, proto)) // condition established because bond0 without NETIF_F_HW_VLAN_STAG_FILTER
              return 0;

          if (netif_device_present(dev))
              return dev->netdev_ops->ndo_vlan_rx_add_vid(dev, proto, vid); // will be never called
              // The slaves of bond0 will not refer to the [ETH_P_8021AD, 10] vid.

3. detach bond_slave_1 from bond0:
__bond_release_one()
  vlan_vids_del_by_dev()
    list_for_each_entry(vid_info, &vlan_info->vid_list, list)
        vlan_vid_del(dev, vid_info->proto, vid_info->vid);
        // bond_slave_1 [ETH_P_8021AD, 10] vid will be deleted.
        // bond_slave_1->vlan_info will be assigned NULL.

4. delete vlan10 during delete ns1:
default_device_exit_batch()
  dev->rtnl_link_ops->dellink() // unregister_vlan_dev() for vlan10
    vlan_info = rtnl_dereference(real_dev->vlan_info); // real_dev of vlan10 is bond_slave_1
	BUG_ON(!vlan_info); // bond_slave_1->vlan_info is NULL now, bug is triggered!!!

Add S-VLAN tag related features support to bond driver. So the bond driver
will always propagate the VLAN info to its slaves.

Fixes: 8ad227ff89a7 ("net: vlan: add 802.1ad support")
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
v2:
  - Do not add vlan_hw_filter_capable() check in vlan_vids_del_by_dev().
  - Add S-VLAN tag related features support to bond driver to fix the bug.
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 484c9e3e5e82..447b06ea4fc9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5901,7 +5901,9 @@ void bond_setup(struct net_device *bond_dev)
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
-				NETIF_F_HW_VLAN_CTAG_FILTER;
+				NETIF_F_HW_VLAN_CTAG_FILTER |
+				NETIF_F_HW_VLAN_STAG_RX |
+				NETIF_F_HW_VLAN_STAG_FILTER;
 
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	bond_dev->features |= bond_dev->hw_features;
-- 
2.25.1


