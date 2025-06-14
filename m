Return-Path: <netdev+bounces-197677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E1AD98EB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6181F17D750
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AB2CA9;
	Sat, 14 Jun 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxppQ7n+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2CE2AEE4
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859689; cv=none; b=Yyx39rS6Hx7cXesFSLcrM3TWc5zSJd0KR+3EmwT4zluo0V79s86M/AYd6IrX/TfvW0manoNseu/CnfiU3zKSocANOBjHlYRNWiEO0g6T16k0W8AJV4jcAyfMMOcCib0xt+1Vh2Vka3GnoIN9Fvelvz0ggCr+C0LZl5QDtHPisaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859689; c=relaxed/simple;
	bh=1znNIB3u16ieepj82rVPi9LAndQlC4ZRrWSXKxSRCb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPp1I3KUo49mlVYpcS0eQegL3IEqi5ob/yILV/Ho7O97qnYaI/03FkyaHTQ6qpt/+03j1iK4QpEHMEB3Zij92yjEa48kAJIIC7Sj33NTcUQc/qeQQdEQrYHhT44aqBuRqpHuWdsYnjJ+ocXWKdguBOH9UIlTH5glYr9Klke9Pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxppQ7n+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748764d84feso3495091b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859687; x=1750464487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1odHZAHpj6iymdK8bPN6NeFlgVHA1tN8g6qXmugLMo=;
        b=VxppQ7n+KPojAjsyBsVdggIwzBxxEalhkoKHbwOwLopjkUqIqwACqfKKjvBhb3N48V
         v1H4ub3I8HrqgGiW8Cp17FsSnZh8xShMAVRq+HapSgdwnbFfOTvABMX+GtnmeE60n+kF
         YCVwbJgvlGFg17fI4QefhBpI/RFqwt9M4DI+0r21QVxz9olObLZAiiEcgO7tT0jaPP5C
         nQaUYkR4sXR2ppbko4iDskVSmnQb7MD5MdE8xK4pCVNF5U33pfyNjkEzvxRyI1fR/lkr
         aXRp3UGtDK28e8Y55sFIl8y8VS21P6sSEX0qNdYAtPg+LB71KKv34FfA8c4hcxZtfmO+
         sItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859687; x=1750464487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1odHZAHpj6iymdK8bPN6NeFlgVHA1tN8g6qXmugLMo=;
        b=uRmnie8iERqgN6JeGFNZEC2hNCAxV5FE/t9dERQ26g4qb0kLxEBDYslmUsK/kSYiEH
         yGBSFRpsGKD3gT+e56dmvgEL2nSGoOo41BIJuvXpYtbXua4DYftFS18uuOb7lpY+u/1F
         Nky9lasPyU9zcdx9IV3Cje+QHdOMZKY4Y0nepRMShLopvLOHlJfqTeC7thDuCfMDjfqY
         wNOpFsHi18DsMu6EkZF5Mk9L0lQQ+jGikqAvrVyyo97CSA+thuKDCNnFgcoE0j4Qqn/P
         irbUvmrHwPrMtr1IBQI1aWxHgOWs3jrVhD8iJwOKXaMvlUm7S0+6zzL+q9QiFsztAKlU
         SO9g==
X-Gm-Message-State: AOJu0Yw71sskbZAzh34yVa/5DQGKXAqBT7vLwc6Q3gqbHbWwMbPkCD3d
	Rm1d9UEET3efOB++uskGCTh5XlAclati7J12Du2+RfGE79a8X8LpsgfFiLFNSPTEM4C4o5o2rgn
	RifQyW0AuAE1YoG4JF/iQA9cZBauu4o0BFBsF3ab0S5LlwJVJD6z5lYTpzaiyOznxuF4oWuJlpT
	cfLC8Qi2ECsZJqRtZ4Qti7w0wn5j2zHmXhSvzxSoQ7RTWczE6gXETCO9jL6THvkoM=
X-Google-Smtp-Source: AGHT+IH7ciQkm2gQh9f6uUBhI69AkVCgzEFU2c/bchRIarpXJlTId5swmE6bncuVJaYDXMQdZ2uwdNz56xJf5gmmNA==
X-Received: from pfhx39.prod.google.com ([2002:a05:6a00:18a7:b0:747:abae:78e8])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1acd:b0:740:6fa3:e429 with SMTP id d2e1a72fcca58-7489cfcb063mr1516682b3a.11.1749859687347;
 Fri, 13 Jun 2025 17:08:07 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:50 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-5-hramamurthy@google.com>
Subject: [PATCH net-next v5 4/8] gve: Add adminq lock for queues creation and destruction
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

Adminq commands for queues creation and destruction were not
consistently protected by the driver's adminq_lock. This was previously
benign as these operations were always initiated from contexts holding
kernel-level locks (e.g., rtnl_lock, netdev_lock), which provided
serialization.

Upcoming PTP aux_work will issue adminq commands directly from the
driver to read the NIC clock, without such kernel lock protection.
To prevent race conditions with this new PTP work, this patch ensures
the adminq_lock is held during queues creation and destruction.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v2:
 - Send this patch together with the rx timestamping patches to net-next
   instead of sending it to net (Jakub Kicinski)
 - Remove the unnecessary cleanup (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 47 +++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f57913a673b4..a0cc05a9eefc 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -463,6 +463,8 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 	int tail, head;
 	int i;
 
+	lockdep_assert_held(&priv->adminq_lock);
+
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
 
@@ -488,9 +490,6 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- */
 static int gve_adminq_issue_cmd(struct gve_priv *priv,
 				union gve_adminq_command *cmd_orig)
 {
@@ -498,6 +497,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	u32 opcode;
 	u32 tail;
 
+	lockdep_assert_held(&priv->adminq_lock);
+
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 
 	// Check if next command will overflow the buffer.
@@ -733,13 +734,19 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_que
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = start_id; i < start_id + num_queues; i++) {
 		err = gve_adminq_create_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
@@ -812,13 +819,19 @@ int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_create_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
@@ -844,13 +857,19 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = start_id; i < start_id + num_queues; i++) {
 		err = gve_adminq_destroy_tx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
@@ -885,13 +904,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	int err;
 	int i;
 
+	mutex_lock(&priv->adminq_lock);
+
 	for (i = 0; i < num_queues; i++) {
 		err = gve_adminq_destroy_rx_queue(priv, i);
 		if (err)
-			return err;
+			goto out;
 	}
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 static void gve_set_default_desc_cnt(struct gve_priv *priv,
-- 
2.50.0.rc1.591.g9c95f17f64-goog


