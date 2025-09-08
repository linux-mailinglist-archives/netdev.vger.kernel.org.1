Return-Path: <netdev+bounces-220731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A89B4864F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD02173ACA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7F2E3B08;
	Mon,  8 Sep 2025 08:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26822DE71C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318622; cv=none; b=QaRwlO/RVYhtrxeltOq8G//fcKexQ6OeoFhP0SwhTSxgFvt16X0y1p2BLEl9dVLO89820WEz4+m1UexNMEhEqqv4Cn/WW+nGDk93g8bxVuenHFJHpCicCRVKwGI0YRUkheN8m3dtItDhrHdaCPsbD8AjXOwpaJ29AotH/B3qh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318622; c=relaxed/simple;
	bh=SHtMnHY635FUmnuZ4z+S+8dfcHeV6E9ScMhkxW623bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAF/SmyYWg2vjUtLc/14rNHkYxnW8atu18Z/HTmFy+iiM3FmoR/DxUQn23K+1IEYkGMCP++VSV+d/iMYYv/DyAMZX9tybBsOwhzHQ/y7JJzmGQug/Ae3ZsrIOerNrVCDh2qkOOnD3JqBX/LYIhWX+WkATRmZW7yAKTRECW2mPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowAC3WBLPjb5oI_ucAQ--.9601S2;
	Mon, 08 Sep 2025 16:03:28 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] net: ipv4: Potential null pointer dereference in cipso_v4_parsetag_enum
Date: Mon,  8 Sep 2025 16:03:15 +0800
Message-ID: <20250908080315.174-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3WBLPjb5oI_ucAQ--.9601S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF47Ar15KF4UJr1xuF47twb_yoW8Jr15pw
	1Syr10kF13tr18tFWkX3WruasIva1jyrW7GFW2v3W3C3s8tr129FyfKF1YgF45AFZ7ArWU
	JF1jvr1Yy3yDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfU1iiSDUUUU
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBwkTEmi+dJNqXAAAsI

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

This patch is similar to eead1c2ea250("netlabel: cope with NULL catmap").

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
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


