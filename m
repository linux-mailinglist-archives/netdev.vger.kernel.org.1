Return-Path: <netdev+bounces-42509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E47CF0D8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E808B2110D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F6C8E7;
	Thu, 19 Oct 2023 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cam3HMtR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0E8F6B
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:14:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67112F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697699644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/E58SfVgh2tMBXaLp4Ka5VvQ2Ys2tWX2mDdsAUOQAo=;
	b=Cam3HMtRu5IQWi857+tlarl9Cmn2Cxsi0iYDTllGBnxyS11V7FeqLc4v0ov73DEMAcpug9
	sf7txdXmSgtibZLYuFr8lCgAqDZKvPTlbV7vjoTIRlW+GlQ5ZtMALDYZ3tWxp0W6VjIxYB
	AF5WFK1cn3vJkvLJ9YdNhXEMSFhVwKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-Skt814XLNyCLZgiVPIz0Pw-1; Thu, 19 Oct 2023 03:14:00 -0400
X-MC-Unique: Skt814XLNyCLZgiVPIz0Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A95E510201E0;
	Thu, 19 Oct 2023 07:13:58 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08ABF503B;
	Thu, 19 Oct 2023 07:13:56 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net] iavf: initialize waitqueues before starting watchdog_task
Date: Thu, 19 Oct 2023 09:13:46 +0200
Message-ID: <20231019071346.55949-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

It is not safe to initialize the waitqueues after queueing the
watchdog_task. It will be using them.

The chance of this causing a real problem is very small, because
there will be some sleeping before any of the waitqueues get used.
I got a crash only after inserting an artificial sleep in iavf_probe.

Queue the watchdog_task as the last step in iavf_probe. Add a comment to
prevent repeating the mistake.

Fixes: fe2647ab0c99 ("i40evf: prevent VF close returning before state transitions to DOWN")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6a2e6d64bc3a..5b5c0525aa13 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4982,8 +4982,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->finish_config, iavf_finish_config);
 	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
-	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
-			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	/* Setup the wait queue for indicating transition to down status */
 	init_waitqueue_head(&adapter->down_waitqueue);
@@ -4994,6 +4992,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Setup the wait queue for indicating virtchannel events */
 	init_waitqueue_head(&adapter->vc_waitqueue);
 
+	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
+			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
+	/* Initialization goes on in the work. Do not add more of it below. */
 	return 0;
 
 err_ioremap:
-- 
2.41.0


