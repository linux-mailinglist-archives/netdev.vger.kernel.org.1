Return-Path: <netdev+bounces-94298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D08BF0B5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87DC1F2277F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699286131;
	Tue,  7 May 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muTyqvL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFA85C5E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122825; cv=none; b=ROWfMfiwlmqYBu7tbmnpVoWUiqi6DW/8DP/1b16ir4OrWG5r9Ab3nYVfMzK9G8vedo8VbiOUJ35YIdtmelddIYZm+PJ33M6tjibJ7des4qzb0ZDrvYkLLrnW6KS05u2dSFX6+xuu2EaY5Tvqo7sIauIDGD5NfpfD8A7aFuJ6pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122825; c=relaxed/simple;
	bh=s/dVkIkUpEFDuGji+Sn4Br+tvktQk5DrZvLWBha5wH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WxgJmHtvPnKIGWpJiPrc2X6DA+qkdowmgFerZhJU2RyjaW2JXhXBGk1DUlq36Nz2iHM/mMjR2Hr/Fpo5PcNU3u4NAWQ6Y2NSxFfJJ1XfM2DUv1KWq2s39+OXD8xXedniVvsYTYn4Vf8wbWcn/960Q5Uk3Iq7umzF4/7NXhCzw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muTyqvL6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60321ce6cso6993239276.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122823; x=1715727623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RjaB4t+jqoB/u9GU06wWmu2KYLJOP55f0UnNOqajSk=;
        b=muTyqvL6RLEpAHD4vpHiQxrYLa3LXGTrHJl0wpumFspI36Mbuqo6awNPevPlKqXmkd
         cjz/LvyIKMBsyNRq1TevwuNJ9rMJCVV9hdQXH2RzQEJN5aSGnX15DkKlqGbd8n237+Ns
         xqC0wigxGJJ7Q2u5tVM51h7HeCcJsjCLeuNlPDQN1YNweYPxiwArNbNjculIO+3a4xaJ
         2U6cY8SzsVQTBZkIiSVYr1liDRXakuM2/oJhO8L5jwJGrpNXyCyfNmPnIBO7kkX7GVe5
         NFKxu8s1Gn/NNqYOkyvTaWOAzms1H+B9GNveqRYl+YPTOYF4cdY6gZMP5P+lGLpK+1sg
         MOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122823; x=1715727623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RjaB4t+jqoB/u9GU06wWmu2KYLJOP55f0UnNOqajSk=;
        b=jRCW3UaDVmzD22S8LugAER7FbL9qAUYP7DBL6mE/O4BErASEIqsJT12FPZyy2L0vCb
         dqbngiFcVq705GN8ZuVuxjDW4IOPSTL+ZXPDMOPCvKdQB8w/CHMrVw67VZZHYCkI77wK
         U+83rIErS5YCJXJIgYGkW8EOZcXu+qjC4oisEr+iigrf8UtUqkoHVvr7lT2T5HGCcyQu
         z2sjOAdjWwcm0GAnrslJna6yrZjYQcsRzepCIooec3NrqqgepJ1xV09sWKNCcj0vh2br
         /LcE5skebNfguR+93rVCos2YbQJOlwSbW3TNrrbAn2WPiFi1TlYaF/ENWLky7cv4QLek
         UwSQ==
X-Gm-Message-State: AOJu0YzKwh1+3bAkIb6WmZSGTWUtPUaf4Ym6r12H6lFUhQkD/dtgWPGU
	BrZeJzTzphrDXRIHc8dKPEtB4j8MNEd9enZq/FhFuSC6umgid34+ub2IZYEpBeXSm1kAz7WmVVB
	FqliXgVzyQZb6upBclr27ZU4R4ODTt9J0KhdSxfZm1AkmF+whqraoyW3z4INJxA5JXqHzjCY8CN
	TijK/ZUG1iZvFWFypToA2upFlTEYLbfoSOXtPrh9l5xFiDCOzN
X-Google-Smtp-Source: AGHT+IHeHwpUsMz3naPYvRlDkGuNZZCEn9CqAnc0Smm5DESeStqFj91Zn/11qRtNpmoue13EExJCmpgR2BPwxrE=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:1881:b0:de5:250a:f1e7 with SMTP
 id 3f1490d57ef6-debb9e397e4mr313067276.8.1715122822767; Tue, 07 May 2024
 16:00:22 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:41 +0000
In-Reply-To: <20240507225945.1408516-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-2-ziweixiao@google.com>
Subject: [PATCH net-next 1/5] gve: Add adminq mutex lock
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We were depending on the rtnl_lock to make sure there is only one adminq
command running at a time. But some commands may take too long to hold
the rtnl_lock, such as the upcoming flow steering operations. For such
situations, it can temporarily drop the rtnl_lock, and replace it for
these operations with a new adminq lock, which can ensure the adminq
command execution to be thread-safe.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 22 +++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ae1e21c9b0a5..ca7fce17f2c0 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -724,6 +724,7 @@ struct gve_priv {
 	union gve_adminq_command *adminq;
 	dma_addr_t adminq_bus_addr;
 	struct dma_pool *adminq_pool;
+	struct mutex adminq_lock; /* Protects adminq command execution */
 	u32 adminq_mask; /* masks prod_cnt to adminq size */
 	u32 adminq_prod_cnt; /* free-running count of AQ cmds executed */
 	u32 adminq_cmd_fail; /* free-running count of AQ cmds failed */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3df8243680d9..2c3ec5c3b114 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -284,6 +284,7 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 			    &priv->reg_bar0->adminq_base_address_lo);
 		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK, &priv->reg_bar0->driver_status);
 	}
+	mutex_init(&priv->adminq_lock);
 	gve_set_admin_queue_ok(priv);
 	return 0;
 }
@@ -511,28 +512,29 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- * The caller is also responsible for making sure there are no commands
- * waiting to be executed.
- */
 static int gve_adminq_execute_cmd(struct gve_priv *priv,
 				  union gve_adminq_command *cmd_orig)
 {
 	u32 tail, head;
 	int err;
 
+	mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
-	if (tail != head)
-		// This is not a valid path
-		return -EINVAL;
+	if (tail != head) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto out;
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 /* The device specifies that the management vector can either be the first irq
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


