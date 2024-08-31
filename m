Return-Path: <netdev+bounces-123970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC796709B
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AF41F238C6
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122D17DFE7;
	Sat, 31 Aug 2024 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526B176AD0;
	Sat, 31 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097830; cv=none; b=FOlylB7H12BSL9q6lIDJOOe7mSzSqabgRQxNF0E8kqeGt7SypDJ03nBGzCSUPx0P+E+Cl1QBu3n3v4RP6vT1ocX/t1W96s662YVlaeH9ruieaCY8E2AyIQDcXk6L8oQHjXvZ9rJybObGzMwBosPErXfbarmlBHmnWtkK3zBcAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097830; c=relaxed/simple;
	bh=dvDnNfvlrmikGC1g3M2IDw79MLn4ccZWUJEaVJ87jq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8y6SnE9ZRrGmeGsMwgkF4FpNFXYjCkoIH34QIik+kVHAAIfJKfcU7nR/ihddmrZ34oe9c3BRYPkTAGgyCCU7yFZIbJKcVIxyLbVzPc3YPkA5KwZdCnFXGT/lsjsds9GPzRoAihS6D9tjOFdKqgDAbnQOA8qs+3c4O5fm91/ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwqxB6N7fzyQxV;
	Sat, 31 Aug 2024 17:49:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 439BD1800CF;
	Sat, 31 Aug 2024 17:50:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:50:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Date: Sat, 31 Aug 2024 17:58:38 +0800
Message-ID: <20240831095840.4173362-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831095840.4173362-1-lihongbo22@huawei.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
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

Use str_disabled_enabled() helper instead of open
coding the same.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 6fe5e8f7017c..29647704bda8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3178,7 +3178,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 		/* [unimplemented] */
 		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
-			   arg ? "disabled" : "enabled");
+			   str_disabled_enabled(arg));
 		break;
 
 	case TUNSETPERSIST:
-- 
2.34.1


