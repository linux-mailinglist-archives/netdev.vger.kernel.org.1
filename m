Return-Path: <netdev+bounces-179075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AAA7A60E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1872F3B3105
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA02505B9;
	Thu,  3 Apr 2025 15:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2724CEE8;
	Thu,  3 Apr 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693222; cv=none; b=Gbm9okJ2vvAaxboSMgcC4+wiOzsGyKa6MM8csoc2S9f5Mc2MVeycxSBBbbu+1g8pReZBYlb7W4ccky7aREcHtlgirn8hS0Y+9Z3kDfmCwzK7+qA92bdIbprhLkYrPgo+d18G6cAFHuqxLSAxrUjXmKHt+huxkgnJGDM9w5aPENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693222; c=relaxed/simple;
	bh=un/yP+h+LeYZuQ7Wjp6XFrS+YwIZa0Esq1BEzijhXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1T5cvvLG/kbZrPoe1761GznAKm8gVoJyBdU9PESJJQ2szR9W2ISmqZQo8tfSxfOpLtf9rOfaEknGkLjuDKzWgAbJSWgc9P42wAFyg3WicX4r2YyiJ95KQgijAlHoSBrcRyOlaan35Ft1L7VULiuiPKOMde8bX4BvZJ3Lr5yBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [221.222.48.127])
	by APP-03 (Coremail) with SMTP id rQCowAC3Yj+Rpe5nyo6MBQ--.36169S2;
	Thu, 03 Apr 2025 23:13:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] octeontx2-pf:  Add error handling for cn10k_map_unmap_rq_policer().
Date: Thu,  3 Apr 2025 23:13:03 +0800
Message-ID: <20250403151303.2280-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3Yj+Rpe5nyo6MBQ--.36169S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrXF4DAF4Dur1rWw4DArb_yoW8Xry5pF
	40k347CwnrXrWrtFs7Ga40gr1Ygay8J3y7Ga4xA3yfZ393twnIvFn0yFy0vrn7GrWkuFy7
	tF15AFWrCF1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoBA2fuZ+y2MgAAsI

The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
for each queue in a for loop without checking for any errors. A proper
implementation can be found in cn10k_set_matchall_ipolicer_rate().

Check the return value of the cn10k_map_unmap_rq_policer() function during
each loop. Jump to unlock function and return the error code if the
funciton fails to unmap policer.

Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a15cc86635d6..ce58ad61198e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
 
 	/* Remove RQ's policer mapping */
 	for (qidx = 0; qidx < hw->rx_queues; qidx++)
-		cn10k_map_unmap_rq_policer(pfvf, qidx,
-					   hw->matchall_ipolicer, false);
+		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
+		if (rc)
+			goto out;
 
 	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
 
+out:
 	mutex_unlock(&pfvf->mbox.lock);
 	return rc;
 }
-- 
2.42.0.windows.2


