Return-Path: <netdev+bounces-222154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB799B534B6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2A178E60
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFE27F747;
	Thu, 11 Sep 2025 13:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367332F75F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599161; cv=none; b=uaLJmgWeT0mDx2qTSAhhhAYwwwpuMGUckG6cEnvaaBDQUOIu6Y6pwke/pyLb9txTWccJ82ImNINH3KWf3bp9kVZyRxfWZnhsx/STzEbqHzFLhDXi86Ex2Kt5NHpbcV0vp7V3GHhIdw80HyCk4E2VhXws1P8l+J6mshEiKUjLuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599161; c=relaxed/simple;
	bh=gRzV4fmdRXA8i7jgr4vVQE/sGvvfSWU7H6sVJrN1T14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nP/Y/4nqMDxR905IKYA82GrtHZ1CmTkxhSpH6Y8D3NhDN9G9dKfsp9XURIs8GMRBn8iogLnGzF9QqHD976XjgdAChU5EWXazMAnkIZ+1OwV6SVos+tfbUvCrlHCKnJP93T6IFnO1PLHK6h9FcVFe8et2liuFio4cmwzl4YAMYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-01 (Coremail) with SMTP id qwCowABnvZ+t1cJol8dKAg--.6282S2;
	Thu, 11 Sep 2025 21:59:10 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: kuba@kernel.org
Cc: horms@kernel.org,
	chenyufeng@iie.ac.cn,
	netdev@vger.kernel.org
Subject: [PATCH v2] net: ipv4: Potential null pointer dereference in cipso_v4_parsetag_enum
Date: Thu, 11 Sep 2025 21:58:58 +0800
Message-ID: <20250911135858.1203-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnvZ+t1cJol8dKAg--.6282S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rGw43WF43Zr4xGr13CFg_yoW8GFW7pw
	1SvryFkFnxtr18tFWDX3Wru3s2va1jyrW7Gry2q3WfC398Jr1a9FyxKFyY9FW5AFZ7AFWU
	XF1jvr1Yv3yDZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry8
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU838nUUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAgCEmjCjVfiTgAAsI

While parsing CIPSO enumerated tags, secattr->flags is set to 
NETLBL_SECATTR_MLS_CAT even if secattr->attr.mls.cat is NULL.
If subsequent code attempts to access secattr->attr.mls.cat, 
it may lead to a null pointer dereference, causing a system crash.

To address this issue, we add a check to ensure that before setting
the NETLBL_SECATTR_MLS_CAT flag, secattr->attr.mls.cat is not NULL.

fixed code:
```
if (secattr->attr.mls.cat)
    secattr->flags |= NETLBL_SECATTR_MLS_CAT;
```

This patch is similar to commit eead1c2ea250 ("netlabel: cope with NULL 
catmap").

Fixes: 4b8feff251da ("netlabel: fix the horribly broken catmap functions")
Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
Changes in v2:
- Add the Fixes tags

 net/ipv4/cipso_ipv4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 740af8541d2f..2190333d78cb 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1339,8 +1339,8 @@ static int cipso_v4_parsetag_enum(const struct cipso_v4_doi *doi_def,
 			netlbl_catmap_free(secattr->attr.mls.cat);
 			return ret_val;
 		}
-
-		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
+		if (secattr->attr.mls.cat)
+			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
 	}
 
 	return 0;
-- 
2.34.1


