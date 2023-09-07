Return-Path: <netdev+bounces-32387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B390797394
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0A1C20B04
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BD11CBD;
	Thu,  7 Sep 2023 15:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFEE8BEE
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:28:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2311FF3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694100422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9rvVTHxHPu3jCEmZFnxNYmQ4533N1br4tWGmYhjmcAM=;
	b=JUx7Z+f1e9jePk800ER+gN1n4SnsljQ41h1GeZvHkbmmyWLGt8wXLM1ZaIVHeehIp5MeFs
	gllXNkdLB3AwDlT+D1ZRLoYSMiZSkbEkFPdk6qB3FQbjgr4xaV/oVWBJFmL9sVDqXPT1ug
	SjUX5d75gshKQSBEvg7AarqnhCk9xm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-nXPTVc1lMa6f_E6D82BHYw-1; Thu, 07 Sep 2023 11:05:14 -0400
X-MC-Unique: nXPTVc1lMa6f_E6D82BHYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8735393F408;
	Thu,  7 Sep 2023 15:02:53 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.225.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B614463F6C;
	Thu,  7 Sep 2023 15:02:51 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	mschmidt@redhat.com,
	ivecera@redhat.com,
	ahmed.zaki@intel.com,
	horms@kernel.org
Subject: [PATCH net v2 1/2] iavf: add iavf_schedule_aq_request() helper
Date: Thu,  7 Sep 2023 17:02:50 +0200
Message-ID: <20230907150251.224931-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add helper for set iavf aq request AVF_FLAG_AQ_* and immediately
schedule watchdog_task. Helper will be used in cases where it is
necessary to run aq requests asap

Signed-off-by: Petr Oros <poros@redhat.com>
Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h         |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 85fba85fbb232b..e110ba3461857b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -521,7 +521,7 @@ void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
-void iavf_schedule_request_stats(struct iavf_adapter *adapter);
+void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags);
 void iavf_schedule_finish_config(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index a34303ad057d00..90397293525f71 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -362,7 +362,7 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
 	unsigned int i;
 
 	/* Explicitly request stats refresh */
-	iavf_schedule_request_stats(adapter);
+	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_REQUEST_STATS);
 
 	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7b300c86ceda73..86d472dfdbc10c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -314,15 +314,13 @@ void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
 }
 
 /**
- * iavf_schedule_request_stats - Set the flags and schedule statistics request
+ * iavf_schedule_aq_request - Set the flags and schedule aq request
  * @adapter: board private structure
- *
- * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task() will explicitly
- * request and refresh ethtool stats
+ * @flags: requested aq flags
  **/
-void iavf_schedule_request_stats(struct iavf_adapter *adapter)
+void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags)
 {
-	adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
+	adapter->aq_required |= flags;
 	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 }
 
-- 
2.42.0


