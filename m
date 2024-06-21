Return-Path: <netdev+bounces-105791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5A912D5B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D714B1C23A97
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC717C20E;
	Fri, 21 Jun 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGIk1YAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084617B426
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995229; cv=none; b=gYmhAxqRD6y8DqycJI8fJESvKolh3OJFBWyyGAhNrVKdPlJ9c6dbRzoWzM7yrmVecofj4dNmSowDelI8Z4ZlNv7GxfZ2uYPRxlYAOD1BPgqAPrOGxwSUfG72CfO2AyZwQYPpjRkjyTL/5dDmel89xzkuM5RIYdjsrDyqPTL5C3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995229; c=relaxed/simple;
	bh=zSy815pDO1WbtvQlDxRmFtHqhoClMQgl+qNaM0qSTdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkbKJtPaxynnnruPhnNyzwAltd5THQ774+Go7nvF7+Vy2mansj1mlRbKOmEU/RFMpoUfn/lPBaG2Jye1gGqZ+WwF3DabERRFS2dniIh8bCbRopXvI2cy63iii/kS054QbTYKVyYy5grttzcJybYtTaDs7YLVSEZfFCqp3Gq6go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGIk1YAk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70436ac8882so1913648b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995226; x=1719600026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx2TLXT5aNJZ79dehWaykAutPRc+hLUEunig8hxU8YM=;
        b=bGIk1YAkZzbKYV7KG/1EQNgegsb5F3HY9tf8zvLEU/Cdjt9FBwis+48CS+rGE6lie8
         s1LxU05AL2bSLWwOgCjfGiVySP8nK/5RkaGFZi6FudRUugT8y1ViC9L/z+fJ1yTd7AML
         vgE/qIr75ilkfTFC/HK4DkBrBvwZGkgqbOK816GSIjqzcvoCSAD1nUOUDFLkNbtOJVH/
         22+KxIVeLh8T+HWtM+OKxo5WbflXJ/otL6PrfsqArk76GFjj/tLjA5mYRa6CKqAqlDaU
         RIju1afkupie/lmE/Hn7IdGJu0N0Bkui0RIhg3PggGSeMY/JiYPEjAefYCe4L96NJ7Sk
         i54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995226; x=1719600026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx2TLXT5aNJZ79dehWaykAutPRc+hLUEunig8hxU8YM=;
        b=cq79b4jojpRkpgzQQi5xrCTc6F1Wm0e8pdUgKfekg5rKK5UIgOoBO6bSH9RfRa+JvS
         4vDX08IAZ2sd0o514Sh6N35Fep4E3uZkEH5La5B4v2y3nEvCTLRlITkr+UeIIYwGHqgR
         I4/rpKZxnFR4FevueRqoxNnMqDjMbYZ9/DJ9WvyUJZMZYb66QRvwpSXy9gHhbdkMcuda
         eg+0f1v4Fep1KvSfHbwyHkSeDPP2VqbLgxX7jhTP7yk+9yf6J71wVuOGO46kByWwVArU
         HwBwVUaWWuuVBKuUdPNyDG2MS8AJP3VORfhwXIUiysdayVYiPw0gsF0SUn9jWInyvbLY
         iGmw==
X-Gm-Message-State: AOJu0YyfApOiqL9Pmp192yA4D9k41hkKhImr3MFMuy2uZ7DbANPF7uB0
	NQyV+RJQ2Sg3bQIWjNNXE+KXka3h5sxPSdbTBOTjiBL9X4692PPVdI6aNA==
X-Google-Smtp-Source: AGHT+IGS7t9wNQLyV+7FXGDTZslsX2uER6uqiuFdfgv+Eua7d6yJ/19eVx6zsj+FnKxGABErAOcvTg==
X-Received: by 2002:a05:6a20:6d89:b0:1b5:ae2c:c727 with SMTP id adf61e73a8af0-1bcbb3f6bd2mr8473766637.20.1718995226112;
        Fri, 21 Jun 2024 11:40:26 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:25 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 10/15] net: hinic: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:42 -0700
Message-Id: <20240621183947.4105278-11-allen.lkml@gmail.com>
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
APIs throughout the huawei hinic driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c   |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c    | 17 ++++++++---------
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h    |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
index d39eec9c62bf..f54feae40ef8 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
@@ -344,7 +344,7 @@ static int cmdq_sync_cmd_direct_resp(struct hinic_cmdq *cmdq,
 	struct hinic_hw_wqe *hw_wqe;
 	struct completion done;
 
-	/* Keep doorbell index correct. bh - for tasklet(ceq). */
+	/* Keep doorbell index correct. For bh_work(ceq). */
 	spin_lock_bh(&cmdq->cmdq_lock);
 
 	/* WQE_SIZE = WQEBB_SIZE, we will get the wq element and not shadow*/
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
index 045c47786a04..381ced8f3c93 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
@@ -368,12 +368,12 @@ static void eq_irq_work(struct work_struct *work)
 }
 
 /**
- * ceq_tasklet - the tasklet of the EQ that received the event
- * @t: the tasklet struct pointer
+ * ceq_bh_work - the bh_work of the EQ that received the event
+ * @work: the work struct pointer
  **/
-static void ceq_tasklet(struct tasklet_struct *t)
+static void ceq_bh_work(struct work_struct *work)
 {
-	struct hinic_eq *ceq = from_tasklet(ceq, t, ceq_tasklet);
+	struct hinic_eq *ceq = from_work(ceq, work, ceq_bh_work);
 
 	eq_irq_handler(ceq);
 }
@@ -413,7 +413,7 @@ static irqreturn_t ceq_interrupt(int irq, void *data)
 	/* clear resend timer cnt register */
 	hinic_msix_attr_cnt_clear(ceq->hwif, ceq->msix_entry.entry);
 
-	tasklet_schedule(&ceq->ceq_tasklet);
+	queue_work(system_bh_wq, &ceq->ceq_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -782,7 +782,7 @@ static int init_eq(struct hinic_eq *eq, struct hinic_hwif *hwif,
 
 		INIT_WORK(&aeq_work->work, eq_irq_work);
 	} else if (type == HINIC_CEQ) {
-		tasklet_setup(&eq->ceq_tasklet, ceq_tasklet);
+		INIT_WORK(&eq->ceq_bh_work, ceq_bh_work);
 	}
 
 	/* set the attributes of the msix entry */
@@ -833,7 +833,7 @@ static void remove_eq(struct hinic_eq *eq)
 		hinic_hwif_write_reg(eq->hwif,
 				     HINIC_CSR_AEQ_CTRL_1_ADDR(eq->q_id), 0);
 	} else if (eq->type == HINIC_CEQ) {
-		tasklet_kill(&eq->ceq_tasklet);
+		cancel_work_sync(&eq->ceq_bh_work);
 		/* clear ceq_len to avoid hw access host memory */
 		hinic_hwif_write_reg(eq->hwif,
 				     HINIC_CSR_CEQ_CTRL_1_ADDR(eq->q_id), 0);
@@ -968,9 +968,8 @@ void hinic_dump_ceq_info(struct hinic_hwdev *hwdev)
 		ci = hinic_hwif_read_reg(hwdev->hwif, addr);
 		addr = EQ_PROD_IDX_REG_ADDR(eq);
 		pi = hinic_hwif_read_reg(hwdev->hwif, addr);
-		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, tasklet_state: 0x%lx, wrap: %d, ceqe: 0x%x\n",
+		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, wrap: %d, ceqe: 0x%x\n",
 			q_id, ci, eq->cons_idx, pi,
-			eq->ceq_tasklet.state,
 			eq->wrapped, be32_to_cpu(*(__be32 *)(GET_CURR_CEQ_ELEM(eq))));
 	}
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
index 2f3222174fc7..8fed3155f15c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
@@ -193,7 +193,7 @@ struct hinic_eq {
 
 	struct hinic_eq_work    aeq_work;
 
-	struct tasklet_struct   ceq_tasklet;
+	struct work_struct	ceq_bh_work;
 };
 
 struct hinic_hw_event_cb {
-- 
2.34.1


