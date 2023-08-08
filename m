Return-Path: <netdev+bounces-25477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F4774385
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2727828179A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052E1BB57;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF9171DA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C822729
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:36:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKvLr5sMKzrSBy;
	Tue,  8 Aug 2023 21:35:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 21:36:11 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] mlxsw: spectrum_switchdev: Use is_zero_ether_addr() instead of ether_addr_equal()
Date: Tue, 8 Aug 2023 21:35:28 +0800
Message-ID: <20230808133528.4083501-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use is_zero_ether_addr() instead of ether_addr_equal()
to check if the ethernet address is all zeros.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 5376d4af5f91..efacb057d1d4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3549,7 +3549,6 @@ mlxsw_sp_switchdev_vxlan_fdb_add(struct mlxsw_sp *mlxsw_sp,
 	struct switchdev_notifier_vxlan_fdb_info *vxlan_fdb_info;
 	struct mlxsw_sp_bridge_device *bridge_device;
 	struct net_device *dev = switchdev_work->dev;
-	u8 all_zeros_mac[ETH_ALEN] = { 0 };
 	enum mlxsw_sp_l3proto proto;
 	union mlxsw_sp_l3addr addr;
 	struct net_device *br_dev;
@@ -3571,7 +3570,7 @@ mlxsw_sp_switchdev_vxlan_fdb_add(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_switchdev_vxlan_addr_convert(&vxlan_fdb_info->remote_ip,
 					      &proto, &addr);
 
-	if (ether_addr_equal(vxlan_fdb_info->eth_addr, all_zeros_mac)) {
+	if (is_zero_ether_addr(vxlan_fdb_info->eth_addr)) {
 		err = mlxsw_sp_nve_flood_ip_add(mlxsw_sp, fid, proto, &addr);
 		if (err) {
 			mlxsw_sp_fid_put(fid);
@@ -3623,7 +3622,6 @@ mlxsw_sp_switchdev_vxlan_fdb_del(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_bridge_device *bridge_device;
 	struct net_device *dev = switchdev_work->dev;
 	struct net_device *br_dev = netdev_master_upper_dev_get(dev);
-	u8 all_zeros_mac[ETH_ALEN] = { 0 };
 	enum mlxsw_sp_l3proto proto;
 	union mlxsw_sp_l3addr addr;
 	struct mlxsw_sp_fid *fid;
@@ -3644,7 +3642,7 @@ mlxsw_sp_switchdev_vxlan_fdb_del(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_switchdev_vxlan_addr_convert(&vxlan_fdb_info->remote_ip,
 					      &proto, &addr);
 
-	if (ether_addr_equal(vxlan_fdb_info->eth_addr, all_zeros_mac)) {
+	if (is_zero_ether_addr(vxlan_fdb_info->eth_addr)) {
 		mlxsw_sp_nve_flood_ip_del(mlxsw_sp, fid, proto, &addr);
 		mlxsw_sp_fid_put(fid);
 		return;
-- 
2.34.1


