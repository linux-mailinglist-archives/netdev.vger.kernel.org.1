Return-Path: <netdev+bounces-29333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57747782ABE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C3B280D5E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A950747B;
	Mon, 21 Aug 2023 13:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191905258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:42:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24BBC
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:42:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTtrQ549VzLpNv;
	Mon, 21 Aug 2023 21:39:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 21:42:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next] ethernet/intel: Use list_for_each_entry() helper
Date: Mon, 21 Aug 2023 21:42:29 +0800
Message-ID: <20230821134229.3132692-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert list_for_each() to list_for_each_entry() where applicable.

No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c      | 7 ++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9f63a10c6f80..bf9c2f6a1164 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7850,7 +7850,6 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
-	struct list_head *pos;
 	struct vf_mac_filter *entry = NULL;
 	int ret = 0;
 
@@ -7871,8 +7870,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	switch (info) {
 	case E1000_VF_MAC_FILTER_CLR:
 		/* remove all unicast MAC filters related to the current VF */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -7882,8 +7880,7 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 		break;
 	case E1000_VF_MAC_FILTER_ADD:
 		/* try to find empty slot in the list */
-		list_for_each(pos, &adapter->vf_macs.l) {
-			entry = list_entry(pos, struct vf_mac_filter, l);
+		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
 			if (entry->free)
 				break;
 		}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 29cc60988071..4c6e2a485d8e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -639,12 +639,10 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
 	struct vf_macvlans *entry;
-	struct list_head *pos;
 	int retval = 0;
 
 	if (index <= 1) {
-		list_for_each(pos, &adapter->vf_mvs.l) {
-			entry = list_entry(pos, struct vf_macvlans, l);
+		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 			if (entry->vf == vf) {
 				entry->vf = -1;
 				entry->free = true;
@@ -664,8 +662,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 
 	entry = NULL;
 
-	list_for_each(pos, &adapter->vf_mvs.l) {
-		entry = list_entry(pos, struct vf_macvlans, l);
+	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
 		if (entry->free)
 			break;
 	}
-- 
2.34.1


