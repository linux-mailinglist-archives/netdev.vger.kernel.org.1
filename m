Return-Path: <netdev+bounces-105793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D935912D5D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46091F24606
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993917C222;
	Fri, 21 Jun 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS/eZZj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE017C21E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995233; cv=none; b=PIxQwOu3T6zEOVS/n/06pY3E5NjzQrvSzj2Onsq7Xk2HRJ14eBAQF8DPd/I5g8TNaUkOwVcEKPqrcQsHlSgerOS5XGAQRvXZ7eH3H+JH1fDDHkQqHCRt4PlaAbFV1gVgZL4aRu6d2+pQ2m9541Ts+D4TCrr0F+OHRxlIa+kI+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995233; c=relaxed/simple;
	bh=B6wWmVi8kcrXu726jCPPXrr1syt8wFPlSjG9yS2c6po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmF8nRGGW1SG8RJj1+KNhPghrlroMEJWU7TZJrLmy2B1kmgX0goDCr3W76mMcEROMHo+gP85k7mOMYwcNGSxsfZVAZYeDWGmbmrDyi4LF8TzwpFl6E0+rkfx63zCDGwTQlRyqKmd5JbDN7Qu0WzjNhukPXMzzyic/oWlAGokjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS/eZZj6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-704090c11easo1858535b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995230; x=1719600030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7Qm0uXfQVJ0pL26mcNJNw6zIMxofNWokQ38AnTAGFg=;
        b=mS/eZZj6IGidDOP75zlAasgQ0569x+Q4TyW6XfM7SsObHo/fRZ/J2M20/JYzNUJb08
         KqzuRS2flEvx2SuRej7idigzIlwKgPf3GEbHt2656zcKxSZqXBw5IFOOrFRWNBLYjP+7
         MsNMFuRQJ9GHJIPWSa3ka184dclCmZu1FKG+doVRvEli69KTySaUGAC0DyyuULGPNT4S
         sxIlLFj5UUqM+KfLE2aUUZtdo9mlOu7NE+5tQr5nTCzmNnDADNwPXJd5S1GmdRVDKcTa
         D9kD6cLHUfbn+dhu8M3npKcE0wnSgYnhX99UYHDXPjxIyfCjXVHzODYkElItmtUFOuQU
         VUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995230; x=1719600030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7Qm0uXfQVJ0pL26mcNJNw6zIMxofNWokQ38AnTAGFg=;
        b=vUyZGo55MGzpwpX6Ju69XE6oOc7vQ4bOV78zXVqKKBVbtQ5FGDDkpyZW8JYkOib///
         Ri5DnJRc5kIgu4s6tEl3J2SRpEDKvlJpnmZ6LlgbM2hB2bjTm1W0UgJyB8zMczbJPUDA
         oZXEmEjun+/kayeDkF50Ru/pDib32u+Fgi4VWsomfDgqDzRw8K71+RPHfYYLnCdgIPcI
         5IAH/g+JKHuPFuFx/Skm6xJ8bYIENeHPq1Y4mewyWgbsVTHcOReyKrdcRl4NQdE27enf
         sj2UV5DFG7ovFz5AQejBcgpM7Pr4OgxY9CejbgJK/h7XJPa2wMVCbkg5LtssF+OP8kmw
         eH7g==
X-Gm-Message-State: AOJu0YwkbAgi16ITz2W9iQdk0po4ZjTOt+NGHlYgOOqPyisRwbnq4C/j
	y5t0YOzsNujVVqkAf/qT/hReolBmCvU61QpHv4t+TSQJZ/PPaabiRpO41A==
X-Google-Smtp-Source: AGHT+IEFZNQPSmWZLq2S3bT4tcmq2MihdJiAnnYemDqOgE4tXcNCXu6OS16+8NLVnunOAiweJZR0yQ==
X-Received: by 2002:a05:6a20:c412:b0:1b5:d172:91ef with SMTP id adf61e73a8af0-1bcbb450ed9mr9254675637.5.1718995230394;
        Fri, 21 Jun 2024 11:40:30 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:29 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 12/15] net: ibmvnic: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:44 -0700
Message-Id: <20240621183947.4105278-13-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621183947.4105278-1-allen.lkml@gmail.com>
References: <20240621183947.4105278-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the ibmvnic driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 24 ++++++++++++------------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5e9a93bdb518..2e817a560c3a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2725,7 +2725,7 @@ static const char *reset_reason_to_string(enum ibmvnic_reset_reason reason)
 /*
  * Initialize the init_done completion and return code values. We
  * can get a transport event just after registering the CRQ and the
- * tasklet will use this to communicate the transport event. To ensure
+ * bh work will use this to communicate the transport event. To ensure
  * we don't miss the notification/error, initialize these _before_
  * regisering the CRQ.
  */
@@ -4429,7 +4429,7 @@ static void send_request_cap(struct ibmvnic_adapter *adapter, int retry)
 	int cap_reqs;
 
 	/* We send out 6 or 7 REQUEST_CAPABILITY CRQs below (depending on
-	 * the PROMISC flag). Initialize this count upfront. When the tasklet
+	 * the PROMISC flag). Initialize this count upfront. When the bh work
 	 * receives a response to all of these, it will send the next protocol
 	 * message (QUERY_IP_OFFLOAD).
 	 */
@@ -4965,7 +4965,7 @@ static void send_query_cap(struct ibmvnic_adapter *adapter)
 	int cap_reqs;
 
 	/* We send out 25 QUERY_CAPABILITY CRQs below.  Initialize this count
-	 * upfront. When the tasklet receives a response to all of these, it
+	 * upfront. When the bh work receives a response to all of these, it
 	 * can send out the next protocol messaage (REQUEST_CAPABILITY).
 	 */
 	cap_reqs = 25;
@@ -5477,7 +5477,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
-	 * because only ibmvnic_tasklet tests/clears this.
+	 * because only ibmvnic_bh_work tests/clears this.
 	 */
 	if (!adapter->login_pending) {
 		netdev_warn(netdev, "Ignoring unexpected login response\n");
@@ -6063,13 +6063,13 @@ static irqreturn_t ibmvnic_interrupt(int irq, void *instance)
 {
 	struct ibmvnic_adapter *adapter = instance;
 
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 	return IRQ_HANDLED;
 }
 
-static void ibmvnic_tasklet(struct tasklet_struct *t)
+static void ibmvnic_bh_work(struct work_struct *work)
 {
-	struct ibmvnic_adapter *adapter = from_tasklet(adapter, t, tasklet);
+	struct ibmvnic_adapter *adapter = from_work(adapter, work, bh_work);
 	struct ibmvnic_crq_queue *queue = &adapter->crq;
 	union ibmvnic_crq *crq;
 	unsigned long flags;
@@ -6150,7 +6150,7 @@ static void release_crq_queue(struct ibmvnic_adapter *adapter)
 
 	netdev_dbg(adapter->netdev, "Releasing CRQ\n");
 	free_irq(vdev->irq, adapter);
-	tasklet_kill(&adapter->tasklet);
+	cancel_work_sync(&adapter->bh_work);
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
@@ -6201,7 +6201,7 @@ static int init_crq_queue(struct ibmvnic_adapter *adapter)
 
 	retrc = 0;
 
-	tasklet_setup(&adapter->tasklet, (void *)ibmvnic_tasklet);
+	INIT_WORK(&adapter->bh_work, (void *)ibmvnic_bh_work);
 
 	netdev_dbg(adapter->netdev, "registering irq 0x%x\n", vdev->irq);
 	snprintf(crq->name, sizeof(crq->name), "ibmvnic-%x",
@@ -6223,12 +6223,12 @@ static int init_crq_queue(struct ibmvnic_adapter *adapter)
 	spin_lock_init(&crq->lock);
 
 	/* process any CRQs that were queued before we enabled interrupts */
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 
 	return retrc;
 
 req_irq_failed:
-	tasklet_kill(&adapter->tasklet);
+	cancel_work_sync(&adapter->bh_work);
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
@@ -6621,7 +6621,7 @@ static int ibmvnic_resume(struct device *dev)
 	if (adapter->state != VNIC_OPEN)
 		return 0;
 
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 94ac36b1408b..b65b210a8059 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1036,7 +1036,7 @@ struct ibmvnic_adapter {
 	u32 cur_rx_buf_sz;
 	u32 prev_rx_buf_sz;
 
-	struct tasklet_struct tasklet;
+	struct work_struct bh_work;
 	enum vnic_state state;
 	/* Used for serialization of state field. When taking both state
 	 * and rwi locks, take state lock first.
-- 
2.34.1


