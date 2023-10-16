Return-Path: <netdev+bounces-41449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AF7CB030
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5922814D6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF0C2AB51;
	Mon, 16 Oct 2023 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdZUo4np"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259930D05
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:49:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56E1A3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697474955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsaAtsNqKHzxOQZyp0txHeu88qGSbx/+1FTbXGjkIjM=;
	b=UdZUo4npquY6IuJ9q7Gr5kHuZiNtxOWj08RajtsywLPtJ6sNHbkFkuDyPZ4DcUAAPtxFvh
	PTjpBT9IOclKyNG+zcfsISNTv4phZ9VFgQo+44w8N63LxscN+ykyW8MuDPTm72WQWkF1a4
	ItMJjKW/5LzQxCamQD9HW09I3OnjM/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-6T0ki9mBM96gJy6kivoFMA-1; Mon, 16 Oct 2023 12:49:04 -0400
X-MC-Unique: 6T0ki9mBM96gJy6kivoFMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC0C11029F49;
	Mon, 16 Oct 2023 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68AC8492BEE;
	Mon, 16 Oct 2023 16:49:02 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 1/4] iavf: rely on netdev's own registered state
Date: Mon, 16 Oct 2023 18:48:46 +0200
Message-ID: <20231016164849.45691-2-mschmidt@redhat.com>
In-Reply-To: <20231016164849.45691-1-mschmidt@redhat.com>
References: <20231016164849.45691-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The information whether a netdev has been registered is already present
in the netdev itself. There's no need for a driver flag with the same
meaning.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 44daf335e8c5..f026d0670338 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -377,7 +377,6 @@ struct iavf_adapter {
 	unsigned long crit_section;
 
 	struct delayed_work watchdog_task;
-	bool netdev_registered;
 	bool link_up;
 	enum virtchnl_link_speed link_speed;
 	/* This is only populated if the VIRTCHNL_VF_CAP_ADV_LINK_SPEED is set
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f35d74566faa..d2f4648a6156 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2021,7 +2021,7 @@ static void iavf_finish_config(struct work_struct *work)
 	mutex_lock(&adapter->crit_lock);
 
 	if ((adapter->flags & IAVF_FLAG_SETUP_NETDEV_FEATURES) &&
-	    adapter->netdev_registered &&
+	    adapter->netdev->reg_state == NETREG_REGISTERED &&
 	    !test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
 		netdev_update_features(adapter->netdev);
 		adapter->flags &= ~IAVF_FLAG_SETUP_NETDEV_FEATURES;
@@ -2029,7 +2029,7 @@ static void iavf_finish_config(struct work_struct *work)
 
 	switch (adapter->state) {
 	case __IAVF_DOWN:
-		if (!adapter->netdev_registered) {
+		if (adapter->netdev->reg_state != NETREG_REGISTERED) {
 			err = register_netdevice(adapter->netdev);
 			if (err) {
 				dev_err(&adapter->pdev->dev, "Unable to register netdev (%d)\n",
@@ -2043,7 +2043,6 @@ static void iavf_finish_config(struct work_struct *work)
 						  __IAVF_INIT_CONFIG_ADAPTER);
 				goto out;
 			}
-			adapter->netdev_registered = true;
 		}
 
 		/* Set the real number of queues when reset occurs while
@@ -5173,10 +5172,8 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->finish_config);
 
 	rtnl_lock();
-	if (adapter->netdev_registered) {
+	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdevice(netdev);
-		adapter->netdev_registered = false;
-	}
 	rtnl_unlock();
 
 	if (CLIENT_ALLOWED(adapter)) {
-- 
2.41.0


