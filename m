Return-Path: <netdev+bounces-44692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9967D9432
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A1628229C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9FD168D1;
	Fri, 27 Oct 2023 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMaWqSW+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7888168CF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:51:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16549D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698400271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+J+pIKdzOxPew/Qi1A1+iGlEwJIRobC+pGNP7AL8MAg=;
	b=JMaWqSW+MchvU2WsNUk15dAISpsvDW60Aoi2priRhphRvOV7tyNYa6S0BWxryAyx7RWFJY
	xCeaGebRq9IGa1lgMjgogpHUjVFQ/I7pVfQkCI19HQeqT5xndUwuc4hLaK7WXw51TunbwW
	My7XGitRpbs5UMEdrfzs41wFSw3FAr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-qMx7CWhYOj-b3VPNPguuOg-1; Fri,
 27 Oct 2023 05:51:05 -0400
X-MC-Unique: qMx7CWhYOj-b3VPNPguuOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D95163822E92;
	Fri, 27 Oct 2023 09:51:04 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.225.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5CB40C6F79;
	Fri, 27 Oct 2023 09:51:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] iavf: use iavf_schedule_aq_request() helper
Date: Fri, 27 Oct 2023 11:51:02 +0200
Message-ID: <20231027095102.499914-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Use the iavf_schedule_aq_request() helper when we need to
schedule a watchdog task immediately. No functional change.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 10 +++-------
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 15 +++++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 90397293525f71..fc8d75a30602cd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1447,10 +1447,9 @@ static int iavf_add_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	iavf_fdir_list_add_fltr(adapter, fltr);
 	adapter->fdir_active_fltr++;
 	fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-	adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
-	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
 
 ret:
 	if (err && fltr)
@@ -1481,7 +1480,6 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	if (fltr) {
 		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
 			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
-			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		} else {
 			err = -EBUSY;
 		}
@@ -1491,7 +1489,7 @@ static int iavf_del_fdir_ethtool(struct iavf_adapter *adapter, struct ethtool_rx
 	spin_unlock_bh(&adapter->fdir_fltr_lock);
 
 	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
 
 	return err;
 }
@@ -1660,7 +1658,6 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
 			rss_old->hash_flds = hash_flds;
 			memcpy(&rss_old->cfg_msg, &rss_new->cfg_msg,
 			       sizeof(rss_new->cfg_msg));
-			adapter->aq_required |= IAVF_FLAG_AQ_ADD_ADV_RSS_CFG;
 		} else {
 			err = -EEXIST;
 		}
@@ -1670,12 +1667,11 @@ iavf_set_adv_rss_hash_opt(struct iavf_adapter *adapter,
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
index b3434dbc90d6fe..7217ba018f6bbf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1060,13 +1060,12 @@ static int iavf_replace_primary_mac(struct iavf_adapter *adapter,
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
 
@@ -1284,10 +1283,9 @@ static void iavf_up_complete(struct iavf_adapter *adapter)
 
 	iavf_napi_enable_all(adapter);
 
-	adapter->aq_required |= IAVF_FLAG_AQ_ENABLE_QUEUES;
 	if (CLIENT_ENABLED(adapter))
 		adapter->flags |= IAVF_FLAG_CLIENT_NEEDS_OPEN;
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
@@ -2340,10 +2337,8 @@ iavf_set_vlan_offload_features(struct iavf_adapter *adapter,
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
2.42.0


