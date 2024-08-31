Return-Path: <netdev+bounces-123968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248EA967088
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6521F22C9C
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988031531F2;
	Sat, 31 Aug 2024 09:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10614D449
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097339; cv=none; b=r5/wChocsnPOhi70khuflon4IU6N7/x3rC3Qndi5RRQE19Xklx9FVstGDnd3GKUY29IMQJFWzbyYMVbm4Bhi7L7Z5DlG6MZjhHQ/7kxjHDKz8Nuq1W1CIGxOos2oyX8wY7oVWwum2zAhLHaVtsXjTGEAuJC22BL3hIC3cynbVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097339; c=relaxed/simple;
	bh=Iya46xS/QNAaIogwRcJg3m+FNEl26l1PzcBpZtA1OKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtT989MvTV9jPBnCjI4jGeI/iU3W5lmGnwCiRlXNaas3hHr6WLOgcNFFrJGT18K9lH6671p6j5DD8lYznCQyIXgofkoF4DdO/V7plmdFX7S5DneEsAlX1hm9Z6EufRBEfgHpNYDwTnfNBMj8bFcoXW0lzrsjiyrXWWB6HJPgPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwqmR52jTz2CpJn;
	Sat, 31 Aug 2024 17:41:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D26691401E9;
	Sat, 31 Aug 2024 17:42:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:42:14 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <3chas3@gmail.com>, <linux-atm-general@lists.sourceforge.net>
CC: <netdev@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] atm: nicstar: Use str_enabled_disabled() helper
Date: Sat, 31 Aug 2024 17:50:26 +0800
Message-ID: <20240831095026.4159093-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use str_enabled_disabled() helper instead of open
coding the same.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/atm/nicstar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
index 27153d6bc781..7b89a8191872 100644
--- a/drivers/atm/nicstar.c
+++ b/drivers/atm/nicstar.c
@@ -1559,7 +1559,7 @@ static void ns_close(struct atm_vcc *vcc)
 		     card->rsq.base, card->rsq.next,
 		     card->rsq.last, readl(card->membase + RSQT));
 		printk("Empty free buffer queue interrupt %s \n",
-		       card->efbie ? "enabled" : "disabled");
+		       str_enabled_disabled(card->efbie));
 		printk("SBCNT = %d  count = %d   LBCNT = %d count = %d \n",
 		       ns_stat_sfbqc_get(stat), card->sbpool.count,
 		       ns_stat_lfbqc_get(stat), card->lbpool.count);
-- 
2.34.1


