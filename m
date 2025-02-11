Return-Path: <netdev+bounces-165213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0300A30FBF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EA27A2420
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE52512D5;
	Tue, 11 Feb 2025 15:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29A17C91;
	Tue, 11 Feb 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287666; cv=none; b=CR2aQAaRt+8VNSirbw1gWcMZ62loSa7xW2SnEGoaagvb75I1vreHmtYTfZ3L2V6Qer9phUsoWbrrQHIhz1qq7flk6SdBVVkstbPLyOjzAsve22QdVZ5QXiJbLwJK966WFI0/KXf4bpTXAp4mfEjt8yCIf/GSJX6k/DDWnFWXt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287666; c=relaxed/simple;
	bh=VZUbDlrQ3s6WtvfB0UR1f6/kID8Vo2XTjueXVKu71Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTG2lzRCeF91UKw+JHIsrhTFM7NCFgOzD4EfdIjFD1JlBliC/q0A47vuc0yie5jzu6aoR584KietNsU27Dqs/wpGDD1r8P9NNvWXDVlsE+Hb8KsBR1VvubPRCO9hvxkb935ioBONpkkXvP7BpBUBXc07HVgOJ1bmxAkQaAaSk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABHLjFTbKtn9EhyDA--.21905S2;
	Tue, 11 Feb 2025 23:27:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] tg3: Check return value of tg3_nvram_lock before resetting lock
Date: Tue, 11 Feb 2025 23:26:58 +0800
Message-ID: <20250211152658.1094-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHLjFTbKtn9EhyDA--.21905S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5Ww4fuF4xWr1DXFWfuFg_yoWkXFgEkF
	1IqryfK34rKr9Iyr4vkr4fA34I9FWkuryruFsFyrWa9ry7GFy5G3WDZFZxWrsrWrW0yasI
	kr9IqFW7Aw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUKA2erQQRu2wAAs8

The current code does not check the return value of tg3_nvram_lock before
resetting the lock count (tp->nvram_lock_cnt = 0). This is dangerous
because if tg3_nvram_lock fails, the lock state may be inconsistent,
leading to potential race conditions or undefined behavior.

This patch adds a check for the return value of tg3_nvram_lock. If the
function fails, the error is propagated to the caller, ensuring that
the lock state remains consistent.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 9cc8db10a8d6..851d19b3f43c 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -9160,7 +9160,9 @@ static int tg3_chip_reset(struct tg3 *tp)
 	if (!pci_device_is_present(tp->pdev))
 		return -ENODEV;
 
-	tg3_nvram_lock(tp);
+	err = tg3_nvram_lock(tp);
+	if (err)
+		return err;
 
 	tg3_ape_lock(tp, TG3_APE_LOCK_GRC);
 
-- 
2.42.0.windows.2


