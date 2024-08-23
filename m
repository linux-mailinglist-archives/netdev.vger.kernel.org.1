Return-Path: <netdev+bounces-121253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C489A95C5C4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DB5285627
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671F13BC2F;
	Fri, 23 Aug 2024 06:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A0139D00
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395528; cv=none; b=TVqV5u800FDqG48HOR4+66R+iJnuWtBCCCBuKaSJtzOLDZYRqE6ftDwmAwIQl/9/sbgSqcekrOH9sw6hCjEgJR2BLxsCuJ4quD/vTGr2NLWdJlpYFqFDP5y8DTVKV1BAbOptYb0P2eCZyio88BqXCHIVVLz1JWTpe7DFvcJuYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395528; c=relaxed/simple;
	bh=Ul9iJUX23pdklvWim5EAP6jDRbMEQ+YSQOKACCo8WGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQVvOq/rE4pgpzMxy6dttNsQl7BX1oMmibt2iUF99Kap0suoPJK2srgm1tWe4KjUiMsXpsZakT2iiiOkDvGK7G7Dtf69NIPf1LVfNKXwA1gmk3BkVmiKQHdVHoAzs4NrN0iYJvAdcMvvo3xH8IsAvxgna6JoMsO0EwoR1P0GJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqrCY0FgpzyQQS;
	Fri, 23 Aug 2024 14:44:41 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id ABE041800CD;
	Fri, 23 Aug 2024 14:45:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:45:22 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next 1/2] net/ncsi: Use str_up_down to simplify the code
Date: Fri, 23 Aug 2024 14:52:58 +0800
Message-ID: <20240823065259.3327201-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823065259.3327201-1-lihongbo22@huawei.com>
References: <20240823065259.3327201-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

As str_up_down is the common helper to reback "up/down"
string, we can replace the target with it to simplify
the code and fix the coccinelle warning.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ncsi/ncsi-manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..13b4d393fb2d 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1281,7 +1281,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 				netdev_dbg(ndp->ndev.dev,
 					   "NCSI: Channel %u added to queue (link %s)\n",
 					   nc->id,
-					   ncm->data[2] & 0x1 ? "up" : "down");
+					   str_up_down(ncm->data[2] & 0x1));
 			}
 
 			spin_unlock_irqrestore(&nc->lock, cflags);
-- 
2.34.1


