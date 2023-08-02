Return-Path: <netdev+bounces-23581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25D76C90D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA840281CE3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1018568D;
	Wed,  2 Aug 2023 09:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65A46139
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:10:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876A273C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:10:27 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG5hM2VFZzNmhR;
	Wed,  2 Aug 2023 17:06:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:10:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:10:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yangyingliang@huawei.com>
Subject: [PATCH net-next] ice: use list_for_each_entry() helper
Date: Wed, 2 Aug 2023 17:07:39 +0800
Message-ID: <20230802090739.3266122-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert list_for_each() to list_for_each_entry() where applicable.
No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 36b7044717e8..a68974c1aa38 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -129,11 +129,9 @@ ice_lag_find_hw_by_lport(struct ice_lag *lag, u8 lport)
 	struct ice_lag_netdev_list *entry;
 	struct net_device *tmp_netdev;
 	struct ice_netdev_priv *np;
-	struct list_head *tmp;
 	struct ice_hw *hw;
 
-	list_for_each(tmp, lag->netdev_head) {
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+	list_for_each_entry(entry, lag->netdev_head, node) {
 		tmp_netdev = entry->netdev;
 		if (!tmp_netdev || !netif_is_ice(tmp_netdev))
 			continue;
@@ -1535,11 +1533,9 @@ static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 	struct ice_lag_netdev_list *entry;
 	struct ice_netdev_priv *np;
 	struct net_device *netdev;
-	struct list_head *tmp;
 	struct ice_pf *pf;
 
-	list_for_each(tmp, lag->netdev_head) {
-		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+	list_for_each_entry(entry, lag->netdev_head, node) {
 		netdev = entry->netdev;
 		np = netdev_priv(netdev);
 		pf = np->vsi->back;
-- 
2.25.1


