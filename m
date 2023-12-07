Return-Path: <netdev+bounces-54803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1528084DA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5CB1C21C62
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291743456B;
	Thu,  7 Dec 2023 09:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03979FA;
	Thu,  7 Dec 2023 01:40:59 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.66.146])
	by mail-app2 (Coremail) with SMTP id by_KCgCHj08pknFlatRXAA--.45476S4;
	Thu, 07 Dec 2023 17:36:49 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yuval Mintz <Yuval.Mintz@qlogic.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] qed: Fix a potential use-after-free in qed_cxt_tables_alloc
Date: Thu,  7 Dec 2023 17:36:06 +0800
Message-Id: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgCHj08pknFlatRXAA--.45476S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1fuw1fWFykCFyxtF1kZrb_yoW8tw1fpr
	4xJFy2vF40qwn8Xa1kuw1rtFy5Zay7KFy7Gry0kw4ruFn8XFn7X3W7Aa4ruw1xur98JF45
	tFWjkFnagw1qkFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwCBmVwRZREWwAAsR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

qed_ilt_shadow_alloc() will call qed_ilt_shadow_free() to
free p_hwfn->p_cxt_mngr->ilt_shadow on error. However,
qed_cxt_tables_alloc() accesses the freed pointer on failure
of qed_ilt_shadow_alloc() through calling qed_cxt_mngr_free(),
which may lead to use-after-free. Fix this issue by setting
p_hwfn->p_cxt_mngr->ilt_shadow to NULL in qed_ilt_shadow_free().

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: -Change the bug type from double-free to use-after-free.
    -Move the null check against p_mngr->ilt_shadow to the beginning
     of the function qed_ilt_shadow_free().
    -When kcalloc() fails in qed_ilt_shadow_alloc(), just return
     because there is nothing to free.
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 65e20693c549..911e0c0d3563 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -921,9 +921,12 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
 	struct qed_cxt_mngr *p_mngr = p_hwfn->p_cxt_mngr;
 	u32 ilt_size, i;
 
+	if (!p_mngr->ilt_shadow)
+		return;
+
 	ilt_size = qed_cxt_ilt_shadow_size(p_cli);
 
-	for (i = 0; p_mngr->ilt_shadow && i < ilt_size; i++) {
+	for (i = 0; i < ilt_size; i++) {
 		struct phys_mem_desc *p_dma = &p_mngr->ilt_shadow[i];
 
 		if (p_dma->virt_addr)
@@ -933,6 +936,7 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
 		p_dma->virt_addr = NULL;
 	}
 	kfree(p_mngr->ilt_shadow);
+	p_hwfn->p_cxt_mngr->ilt_shadow = NULL;
 }
 
 static int qed_ilt_blk_alloc(struct qed_hwfn *p_hwfn,
@@ -995,10 +999,8 @@ static int qed_ilt_shadow_alloc(struct qed_hwfn *p_hwfn)
 	size = qed_cxt_ilt_shadow_size(clients);
 	p_mngr->ilt_shadow = kcalloc(size, sizeof(struct phys_mem_desc),
 				     GFP_KERNEL);
-	if (!p_mngr->ilt_shadow) {
-		rc = -ENOMEM;
-		goto ilt_shadow_fail;
-	}
+	if (!p_mngr->ilt_shadow)
+		return -ENOMEM;
 
 	DP_VERBOSE(p_hwfn, QED_MSG_ILT,
 		   "Allocated 0x%x bytes for ilt shadow\n",
-- 
2.17.1


