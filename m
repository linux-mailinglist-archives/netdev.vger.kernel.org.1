Return-Path: <netdev+bounces-95849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5528C3A76
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD94F281355
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5117145B1E;
	Mon, 13 May 2024 03:28:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACE145A11;
	Mon, 13 May 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570933; cv=none; b=NoIfI9dxL7oHS1/kmSKyjckUOn7vi4Lc3qvGd53GUKvQ+5RzAW/FAxdrZojDhUGBNaIpSkivR+zTrbKlol1RVGOfwM+S+M2uGrRji1tMUv2Tc0iXCEq9VeLUayA6QYw/nN2Xn/eoxVvCn3qiX8Ra77y+tVnXYfRH92OkbaR62Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570933; c=relaxed/simple;
	bh=Sc4lVwGwuwh8l0GV0drplYsEgllKtx/zFNNahESzNn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i83FHlG2ZcKTWjUiG+aNxfKlPE2PzxAhfdF9//mzwS18wRsGrk9fgXhQOUYwDm2InwfPItUiKKzc9hhebd8lz6hl3gEGr+bZ8Ee0ko5WdpNk1YStVwc92Jn/xERHQFYAr3PqMd/tOjjhJsluqf6HU/NimD7zaQ+VLBuzZNbboeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3fubciEFmiSW6Cg--.38107S2;
	Mon, 13 May 2024 11:28:29 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	jan.glaza@intel.com,
	przemyslaw.kitszel@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] dpll: fix return value check for kmemdup
Date: Mon, 13 May 2024 11:28:24 +0800
Message-Id: <20240513032824.2410459-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3fubciEFmiSW6Cg--.38107S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4kKr47Gw45tw48Ww4fGrg_yoW3KrcEk3
	48JrsrXry5G3Z8J3WYka93Wry2ywnrXrn5XryIqFWftayjvryDur4Ivrs8Gr1DXayUuF9r
	G3yxu3W8Cw4kCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The return value of kmemdup() is dst->freq_supported, not
src->freq_supported. Update the check accordingly.

Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index d0f6693ca142..32019dc33cca 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -449,7 +449,7 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
 					      freq_size, GFP_KERNEL);
-		if (!src->freq_supported)
+		if (!dst->freq_supported)
 			return -ENOMEM;
 	}
 	if (src->board_label) {
-- 
2.25.1


