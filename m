Return-Path: <netdev+bounces-191561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08CABC255
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D26C18924BA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE428540F;
	Mon, 19 May 2025 15:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687626B093;
	Mon, 19 May 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668269; cv=none; b=owyRqwArXAcKL4UynhPKWc/arWiuGJ+tpebdfjWBbHbDuQ8pC0F2johHU4CZEh5rZGHbAVQ8Y5jTAST+B38kesnBmhS1PDpb97M7OTk7RKlSUfaIPFtTJyTcy5GjImi5tpoIhq1Qe7zn+pz8lcEo77t0CB3cWQ5qcNxE++mEHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668269; c=relaxed/simple;
	bh=00J/mLo+IrM88P4etHzFofObO9aswcuOd778AuTnGSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMjnqOB99Ykdp/Qc5xEO18eYbF+VQrB7uLdf/IS9g3orTLM8uwtBE5G5tobBEN+4o3yqEgiWBj0Z6DYhEMU1JnI8WMg0lim+3DdABEzXfYikgU/5MixUERoGCiiu7vGMj274B/NmZsUuWBOSqqpkztt0vS2A/QelfA7kSXi9aok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABn1MMZTStokbplAQ--.53700S2;
	Mon, 19 May 2025 23:24:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] net: cavium: thunder: Add log for verification fail in bgx_poll_for_link()
Date: Mon, 19 May 2025 23:23:48 +0800
Message-ID: <20250519152348.2839-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABn1MMZTStokbplAQ--.53700S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4xZryrWw1kKr13ZFyfCrg_yoW8GFWxpa
	17tasI9F97Aw1Uu3Wvvws8CrZ8WaykKF93AFW5Cwn3uF17try5ZrWDG3yayFsFqrW8KFWY
	qF1jv3s7CF98Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1TqcUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgHA2grSfIIhQAAs1

The bgx_poll_for_link() calls bgx_poll_reg() but does not handle the
return value. The link setting is not verified if the polling operation
times out. It helps to debug if the link polling fails.

Add a time out error log for bgx_poll_reg().

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 608cc6af5af1..eadc58de35ac 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1007,8 +1007,9 @@ static void bgx_poll_for_link(struct work_struct *work)
 	/* Receive link is latching low. Force it high and verify it */
 	bgx_reg_modify(lmac->bgx, lmac->lmacid,
 		       BGX_SPUX_STATUS1, SPU_STATUS1_RCV_LNK);
-	bgx_poll_reg(lmac->bgx, lmac->lmacid, BGX_SPUX_STATUS1,
-		     SPU_STATUS1_RCV_LNK, false);
+	if (bgx_poll_reg(lmac->bgx, lmac->lmacid, BGX_SPUX_STATUS1,
+			 SPU_STATUS1_RCV_LNK, false))
+		dev_err(lmac->bgx->pdev->dev, "BXG verification fail with time out.\n");
 
 	spu_link = bgx_reg_read(lmac->bgx, lmac->lmacid, BGX_SPUX_STATUS1);
 	smu_link = bgx_reg_read(lmac->bgx, lmac->lmacid, BGX_SMUX_RX_CTL);
-- 
2.42.0.windows.2


