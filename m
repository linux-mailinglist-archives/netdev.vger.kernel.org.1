Return-Path: <netdev+bounces-191233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29EABA73E
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB169E5ADA
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79135979;
	Sat, 17 May 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEzI7JSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857882110E
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440688; cv=none; b=cm5R69vTeEEMYLTDhe2lxWr1Ip00Iz+tf6wrIxFF/0bpL54Zla2uTmS7Y1EVx4pHtDTgYjFl3A+dmSHPlPpDoxhv3G1wBo+xSS/jaAOEJnR4ha8hyyNKgiU94KekGCDLxBNY/ecjpVKJL3ytUaeMFifU7GxRPvY69fLLCMF8dqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440688; c=relaxed/simple;
	bh=pUkIgWxELqN/4Z0VIMy/NGCk7J2R96jLJthyFq/VFPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gZTNFxAMqAR8sbBfDXMELjAC8IozhfQoBZBHo1n50tgc0eZa+5Wi3SERbazYet9WrQeJDoAUtCRoDVUzm3b8jY/at4GB3kfoJKFJ/xFfEQApX4YlLsuF7le8jYz9IDGhGiZA0Pf/XPlkFwon/4FTBjgmoOiNeQ3KQcupTBgMSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEzI7JSL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso1371740a12.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440686; x=1748045486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke631uMsz4FxTcxejSllZpYccC7Ldi0GA+ipIAqVNM0=;
        b=cEzI7JSLKiRJkPb75ISEfM7Dm3d/rAu+twMeC4kNH/R7gR4ODX/0MtuGfrNSkt2HMy
         R+FuhDSAExAn2EdUDEwFUB1urd7m6xjqOeB+L1KL1M3gx67xCyP+RJE9IPnXA9RmmDiu
         PIsBmFdSCebVDzmeKdeDNjfb53aqlmJzFsv2/4sb8zOkGsZy/VkbSpcjgTzJlfWNR40O
         LToJm5EjgnqOLBbXVJo5iAwj3GvuhL78+wWPnwSNdh92eUbunCb5k9E+QV1MPDNFWMaP
         uAt4E4vGsv5E/sr36Qbpkue9WQ76E+3tV+PyVTUmToLRbovjFM91foaJX/rc9y3LxotV
         /X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440686; x=1748045486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke631uMsz4FxTcxejSllZpYccC7Ldi0GA+ipIAqVNM0=;
        b=SR3lH4zE0U9QdB+0Tt6bIwLdVmd9tvL0y1Xc2CIUWIshzD7RU4u1k0oa9SRTdK+snI
         6aUF+b4snGqHO4y5SpaL6DEO9skTnsPKlfT6d3jjl5xayo53lR9Dv07S/SvXhianMkaW
         eeffY6cDe3jU/VTEb+coMAaHmR6AFMTGKAUoRpORpx2IOyk7T3zcAkIk6CbSDAZcPiAp
         1rjT4QDRMmlcTi+j6OdJpwK29xTVV2OvGgNIVzWXI59E3hlxtXtOih9pmz6e/L+h6mB2
         PVZBPcytCQ/4r7RawIk4oD/HWCGTQToi7cMyytP9etD8ZjgFShRN3LbaPzaM0WK2MKWL
         62XA==
X-Gm-Message-State: AOJu0Yyllj5+7fKjT+p7OyZhLDwzxH/YjU/djUiwuKx+o1BZS/CP2xjx
	e0aOql8DP9Z77KSOmiGwD5nQQNIHFupiPYyhnaqgoiBYRVeSxHO9l56uGwBbp5iyClRPeSFh+f3
	7GFZDrZE9Pr6i2fdECiyC5A1VpOgEp1tQn64DrrwqNsdfv62dszItIiKsb7egta1QExmRB+nTl0
	lZtAC+WzaIVA+94rVMSa53slKU7t6460Bt9Rrz95pft4SqAsS2AMyjYLKgCCatTy8=
X-Google-Smtp-Source: AGHT+IFFSeP+EFxGhCUTGTd+z6GhHDOBz2BS1L+sJdSr1pZDWHaN+JTOOP/U5x0hxRX4rjtNCSnPqqlfSkZGB7horA==
X-Received: from pfvf8.prod.google.com ([2002:a05:6a00:1ac8:b0:741:cbad:dafb])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9b:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-2170cb051b7mr6690239637.2.1747440685556;
 Fri, 16 May 2025 17:11:25 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:06 +0000
In-Reply-To: <20250517001110.183077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-5-hramamurthy@google.com>
Subject: [PATCH net-next v2 4/8] gve: Add adminq lock for queues creation and destruction
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
2.49.0.1112.g889b7c5bd8-goog


