Return-Path: <netdev+bounces-41451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE17CB036
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156031C20C5E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A32E65A;
	Mon, 16 Oct 2023 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGKuxJN/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC330F9A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:49:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB71A1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697474960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5UG7QpK2CExO8hE1R9NRfCuMLFjlNpBB/2cVreBkEE=;
	b=aGKuxJN/YP4JES/wsrEg8vSS3gPI96ahlAvENPhZaOf10BQ0TkWH5F0IF4jootDfZIUUbQ
	ogi9VeVnKdAfZ9+sS6Iy37O5CWgyn+OjzVmnhRckFYESO3jcwVALkFoCHkqBB6Ng+Exl5m
	tv9iUkWbhUekKiAig7LNY2G+Xu7WV8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-hXG-C2H5M6eLR-_FswjZxg-1; Mon, 16 Oct 2023 12:49:07 -0400
X-MC-Unique: hXG-C2H5M6eLR-_FswjZxg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0F5681DA03;
	Mon, 16 Oct 2023 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95CDA492BEE;
	Mon, 16 Oct 2023 16:49:05 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 3/4] iavf: add a common function for undoing the interrupt scheme
Date: Mon, 16 Oct 2023 18:48:48 +0200
Message-ID: <20231016164849.45691-4-mschmidt@redhat.com>
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

Add a new function iavf_free_interrupt_scheme that does the inverse of
iavf_init_interrupt_scheme. Symmetry is nice. And there will be three
callers already.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 26 ++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6036a4582196..791517cafc3c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1954,6 +1954,17 @@ static int iavf_init_interrupt_scheme(struct iavf_adapter *adapter)
 	return err;
 }
 
+/**
+ * iavf_free_interrupt_scheme - Undo what iavf_init_interrupt_scheme does
+ * @adapter: board private structure
+ **/
+static void iavf_free_interrupt_scheme(struct iavf_adapter *adapter)
+{
+	iavf_free_q_vectors(adapter);
+	iavf_reset_interrupt_capability(adapter);
+	iavf_free_queues(adapter);
+}
+
 /**
  * iavf_free_rss - Free memory used by RSS structs
  * @adapter: board private structure
@@ -1982,11 +1993,9 @@ static int iavf_reinit_interrupt_scheme(struct iavf_adapter *adapter, bool runni
 	if (running)
 		iavf_free_traffic_irqs(adapter);
 	iavf_free_misc_irq(adapter);
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
-	iavf_free_queues(adapter);
+	iavf_free_interrupt_scheme(adapter);
 
-	err =  iavf_init_interrupt_scheme(adapter);
+	err = iavf_init_interrupt_scheme(adapter);
 	if (err)
 		goto err;
 
@@ -2973,9 +2982,7 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 
 	iavf_free_misc_irq(adapter);
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
-	iavf_free_queues(adapter);
+	iavf_free_interrupt_scheme(adapter);
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
@@ -5206,9 +5213,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_free_all_tx_resources(adapter);
 	iavf_free_all_rx_resources(adapter);
 	iavf_free_misc_irq(adapter);
-
-	iavf_reset_interrupt_capability(adapter);
-	iavf_free_q_vectors(adapter);
+	iavf_free_interrupt_scheme(adapter);
 
 	iavf_free_rss(adapter);
 
@@ -5224,7 +5229,6 @@ static void iavf_remove(struct pci_dev *pdev)
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-	iavf_free_queues(adapter);
 	kfree(adapter->vf_res);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
-- 
2.41.0


