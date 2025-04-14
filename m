Return-Path: <netdev+bounces-182253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C6A8854C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3568616D9E2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5972472AD;
	Mon, 14 Apr 2025 14:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AB24729F
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639944; cv=none; b=Wdk4TSfYjWCXsGAoKSYVuZPnw5spS5hK0sMn6oMvF+7LZ+S4LSvWeWYWgqPYNORkM0iozgTbOzbvXhstGYuai88tqdMT5l5f7roLSYhoQ/iZ7vzBLU+GgyFaL+o+Au95SdLQoPllsh1zRuUfFs/AK31HL6ld0Wy8qkdV4jyXm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639944; c=relaxed/simple;
	bh=1DgyAT3tWzK0LxGOLLReZBXlb/HAR9bt0vst1lwBMOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQyWMhuWosTilYkcuqdfQTNdkk7uqnGauoHkCkY+gSMvy37Vi1FWN1+E1soDsQRErDOGk8xFOu1xI3ZksSugPjbswmZOlx/SjZ8T+xyrDLtreyTZ26Kx6VRsVpifG7H8KFDuTP+HVn0+LM+BzOJES+xR0lTQ35ZCoUwh1qNexxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-03 (Coremail) with SMTP id rQCowAC3XDmyF_1n_ULaCA--.40596S2;
	Mon, 14 Apr 2025 22:12:04 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: krzk@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH]nfc: replace improper check device_is_registered() in nfc_se_io()
Date: Mon, 14 Apr 2025 22:11:43 +0800
Message-ID: <20250414141143.1904-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3XDmyF_1n_ULaCA--.40596S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW3Kry7tFyfCrWDGF1xXwb_yoWkWrbEv3
	4vv3ykGrn5Xr1rXw43Cr48Z3WfZwsIgrWfZr1xJF4kWa45XF4DWrWkX3y3ZF12ga42yF9x
	Ar1rKrWfGryagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiCQ8MEmf829fWNQAAss

A patch similar to commit da5c0f119203 ("nfc: replace improper check device_is_registered() in netlink related functions")

The nfc_se_io() function in the NFC subsystem suffers from a race 
condition similar to previously reported issues in other netlink-related 
functions. The function checks device status using device_is_registered(),
but this check can race with device unregistration despite being protected
by device_lock.

This patch also uses bool variable dev->shutting_down instead of
device_is_registered() to judge whether the nfc device is registered,
which is well synchronized.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 net/nfc/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 6a40b8d0350d..6de0f5a18a87 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1426,7 +1426,7 @@ static int nfc_se_io(struct nfc_dev *dev, u32 se_idx,
 
 	device_lock(&dev->dev);
 
-	if (!device_is_registered(&dev->dev)) {
+	if (dev->shutting_down) {
 		rc = -ENODEV;
 		goto error;
 	}
-- 
2.34.1


