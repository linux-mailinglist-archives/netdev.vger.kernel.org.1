Return-Path: <netdev+bounces-117743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E294F0F6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9276A1C22040
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E7187356;
	Mon, 12 Aug 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wdtHwJbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4118732C
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474635; cv=none; b=VEpg12gnf7uISmXsMFjMcocR3n1TvqvRvjf7/iLnKUJr5P6WvL+01HmzaV4Np4r2ZJ2ksjQYAxoItlBD0lwOxZLAdRcnRJCN2+mzHufSaPZVriu+W0+5sxLYwvWxXi4YQ5xUhMnCmCLC0tonzqijr3ZtjMuP/V9sfpQVMDxHj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474635; c=relaxed/simple;
	bh=qTGf9RDPSjjOFdWiZLiVw5Crk632AJNyAaTUhFpJaJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiivX3Ul9yWatgyOTITiCzsuwp9h4F97RBu04XuFGFrYJFitufL7OyVc2jAevhT2zIMcfoV5sE2twE7FEI6Zvu+j3IL/ZNbme5LFw+w/la0hilh+R6fAqgBL8Qa0ERmgRSfCQl9N6tFnzoNoMhpA/SIUpzDhBO4sZraQFoVrN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wdtHwJbU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fda7fa60a9so37001355ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474633; x=1724079433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv3Kiio+O9ZPFfr1NuylJH0Fc+893bNyrbJKgz9J96Y=;
        b=wdtHwJbU1ue0IyWc8TzxBlkAXwSPGZ0lXYXgaXV0ekmVh7rOF4aiwHMKYKn4K1EGxR
         vIno4Vbzu0oJqwWAYEsR7hs7B2vYFii2tQidKi1DUWQkOu6/JNXcEic++6Iy5zDZ548x
         QTuGY4VAtYtD5idIJUAeFo1lxF8/S/TbimUkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474633; x=1724079433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv3Kiio+O9ZPFfr1NuylJH0Fc+893bNyrbJKgz9J96Y=;
        b=Ng37I1tjc4DiUV7QE1Lv60Ntcs0fMF21m2Z432lh6lHwkc4xtdilOFkM1rVTC9tI9G
         dMbkX4yTrd+/dCSM1o/EVDIbvcTaXnhPUTnfpLEGTq1gUfoDunuSR7v+9K5OCQkkcpjg
         lfMt6wZzK7JVllHgT9WsNLWrAhwZjKWBbcdqREfc7e+Y4t7jhUAU6sv/QqfI6p9SNqpq
         jEqx8buNOZLg0p72MNxorTged3Uv0UfOrCQEWnqL6YxDcuodnkCeTWh58EhO2yCAeBbw
         ECXl1nhpcR+8BoYIEQjm4BgoMRiZ3xUPU7EEDMYK3xvrJoQ//qQiLGVh4pvLrKBwCN4N
         OGGQ==
X-Gm-Message-State: AOJu0YyRCY6Kf+71KAGkmqbMPSFshigosG28M3mFcx3Gx40ZAl74XJ2b
	CVTpLIaxDZ4V/SI8Jbu/Wt4+Al6a7HgaAKK0GCUapU6Cvn0BhCq3LqDcOq2QcYKmUJPJIQ5w1rl
	RI/w+3qJxY6rnoFf0x8uJRreo4h++Oc60R5/78AXI7uz/zh4FV521Y8GwTcE0u08ztBGkCow1bN
	am8SviCp5ZpNSOPlA3ACogZ/oDV1pAGtsW/wMw1A==
X-Google-Smtp-Source: AGHT+IFq7CVQngrprbj/jbujEv0pCxSX/9ljktjnxugPkA8tcIxxNL7KoLqZldHeiN0wb9s0yFwN0w==
X-Received: by 2002:a17:902:ea12:b0:1fb:8a0e:7730 with SMTP id d9443c01a7336-201ca1b12d6mr7854895ad.26.1723474633362;
        Mon, 12 Aug 2024 07:57:13 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 4/6] i40e: Use napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:25 +0000
Message-Id: <20240812145633.52911-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_affinity_no_change instead of i40e's internal implementation,
simplifying and centralizing the logic. To facilitate this, fix the type
of irq_num to be unsigned int.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d546567e0286..326bb7ffab26 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -955,7 +955,7 @@ struct i40e_q_vector {
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 	bool in_busy_poll;
-	int irq_num;		/* IRQ assigned to this q_vector */
+	unsigned int irq_num;	/* IRQ assigned to this q_vector */
 } ____cacheline_internodealigned_in_smp;
 
 /* lan device */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cbcfada7b357..a120fdd87c3e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4137,10 +4137,10 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 	int q_vectors = vsi->num_q_vectors;
 	struct i40e_pf *pf = vsi->back;
 	int base = vsi->base_vector;
+	unsigned int irq_num;
 	int rx_int_idx = 0;
 	int tx_int_idx = 0;
 	int vector, err;
-	int irq_num;
 	int cpu;
 
 	for (vector = 0; vector < q_vectors; vector++) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c006f716a3bd..8fc39cf4c5d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2810,8 +2810,6 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
-		int cpu_id = smp_processor_id();
-
 		/* It is possible that the interrupt affinity has changed but,
 		 * if the cpu is pegged at 100%, polling will never exit while
 		 * traffic continues and the interrupt will be stuck on this
@@ -2819,7 +2817,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		 * continue to poll, otherwise we must stop polling so the
 		 * interrupt can move to the correct cpu.
 		 */
-		if (!cpumask_test_cpu(cpu_id, &q_vector->affinity_mask)) {
+		if (!napi_affinity_no_change(q_vector->irq_num)) {
 			/* Tell napi that we are done polling */
 			napi_complete_done(napi, work_done);
 
-- 
2.25.1


