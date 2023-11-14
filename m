Return-Path: <netdev+bounces-47861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A57EB96F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06581F2588D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6C10F7;
	Tue, 14 Nov 2023 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOi/hZzm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086533070
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:35:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E3DF
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700001329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WJDlbKUfQP9B8xSvbtng6SeSLwGz931vpn2DrplDtEM=;
	b=WOi/hZzm1aIpJRcJyhgbxurmLYt2JDLqz51lsShah1gT559VkkmJ21wIPqrOz4odhxbx42
	5QEt+STZHdR38jLO4tj7+xs/Odgz+yHl8GmkAxUBNn7Dl/42oy8SfFAu5FWrorioQxMDF8
	kqoJ+4aW1ox3TS79x/egl9UNxsxyGEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ruqsAX9qNpGJAh4smGLHfw-1; Tue, 14 Nov 2023 17:35:25 -0500
X-MC-Unique: ruqsAX9qNpGJAh4smGLHfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40B49811E7B;
	Tue, 14 Nov 2023 22:35:25 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.224.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B421936EE;
	Tue, 14 Nov 2023 22:35:23 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	wojciech.drewek@intel.com
Subject: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use iavf_schedule_aq_request() helper
Date: Tue, 14 Nov 2023 23:35:22 +0100
Message-ID: <20231114223522.2110214-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Use the iavf_schedule_aq_request() helper when we need to
schedule a watchdog task immediately. No functional change.

Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: rebased on net-next
---
drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 10 +++-------
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 15 +++++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6f236d1a6444e8..6b3d3e54b8b772 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1445,10 +1445,9 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	iavf_fdir_list_add_fltr(adapter, fltr);
 	adapter->fdir_active_fltr++;
 	fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
 
 ret:
 	if (err && fltr)
@@ -1479,7 +1478,6 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fltr) {
 		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
 			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		} else {
 			err = -EBUSY;
 		}
@@ -1489,7 +1487,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
 	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
 
 	return err;
 }
@@ -1658,7 +1656,6 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 			rss_old->hash_flds = hash_flds;
 			memcpy(&rss_old->cfg_msg, &rss_new->cfg_msg,
 			       sizeof(rss_new->cfg_msg));
-			adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 		} else {
 			err = -EEXIST;
 		}
@@ -1668,12 +1665,11 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 		rss_new->packet_hdrs = hdrs;
 		rss_new->hash_flds = hash_flds;
 		list_add_tail(&rss_new->list, &adapter->adv_rss_list_head);
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 	}
 	spin_unlock_bh(&adapter->adv_rss_lock);
 
 	if (!err)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_ADV_RSS_CFG);
 
 	mutex_unlock(&adapter->crit_lock);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c862ebcd2e392e..1a9c78d9f5d56c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1059,13 +1059,12 @@ static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
 	 */
 	new_f->is_primary = true;
 	new_f->add = true;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
 	ether_addr_copy(hw->mac.addr, new_mac);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	/* schedule the watchdog task to immediately process the request */
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_MAC_FILTER);
 	return 0;
 }
 
@@ -1284,8 +1283,7 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
 
 	iavf_napi_enable_all(adapter);
 
-	adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_QUEUES;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ENABLE_QUEUES);
 }
 
 /**
@@ -1439,8 +1437,7 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
 	}
 
-	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DISABLE_QUEUES);
 }
 
 /**
@@ -2337,10 +2334,8 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
 		}
 	}
 
-	if (aq_required) {
-		adapter->aq_required |= aq_required;
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
-	}
+	if (aq_required)
+		iavf_schedule_aq_request(adapter, aq_required);
 }
 
 /**
-- 
2.42.1


