Return-Path: <netdev+bounces-173767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DDA5B98E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA91892568
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813B1EB9E5;
	Tue, 11 Mar 2025 07:07:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079E211C;
	Tue, 11 Mar 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676842; cv=none; b=N3dZvgssU+EFQ1ees1q1DU1iU3bYrrdZ16bs8RPR4V79GJIhEH4CSMJGjBRO8zRdHneRu6drtM/KetvuuHtd8iHxQXQGFDK9jaIuoXYFPdwnQA8oHhk8WVt2Vi24sw75yJCSnwnnKt6VQvGIfH1E0+k00RxvbJcv5i5g5/DENaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676842; c=relaxed/simple;
	bh=Ka379f0/6s/M3atDYph3GBaEV81zpHg1C3QkbmiSllw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmTmvcHqhnJo2L2/IdVk/LMk2FrqpJ8FHXiTghtIrSeSqPaCHQM/dbyeVaw3G0IUwkoEgaoQbWFSuVgntmcED26yQBYLX18p5si5WV1ARV4TddQD0USiEPkHFkAD8dUX2fsRWtPhQFTXKEc1xn0rOVyKoawYK4Ss02vXN1VhUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADHzKAT4c9nYajXEw--.3654S2;
	Tue, 11 Mar 2025 15:07:00 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] qed: remove cast to pointers passed to kfree
Date: Tue, 11 Mar 2025 15:06:24 +0800
Message-Id: <20250311070624.1037787-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHzKAT4c9nYajXEw--.3654S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4rWF4fKrWrJry5tFyUtrb_yoW3uFXEkr
	1jvr4fuF4UJryakw43trsrZ34vvF1qvw1fW3W29FW3X3yDXa1DAr17Zry8XFWUW347CF9r
	J3srJrW8Aw10kjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbp6wtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary casts to pointer types passed to kfree.
Issue detected by coccinelle:
@@
type t1;
expression *e;
@@

-kfree((t1 *)e);
+kfree(e);

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index f915c423fe70..886061d7351a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -454,7 +454,7 @@ int qed_fill_dev_info(struct qed_dev *cdev,
 
 static void qed_free_cdev(struct qed_dev *cdev)
 {
-	kfree((void *)cdev);
+	kfree(cdev);
 }
 
 static struct qed_dev *qed_alloc_cdev(struct pci_dev *pdev)
-- 
2.25.1


