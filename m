Return-Path: <netdev+bounces-181898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B05A86D41
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8160A3AE091
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DE1DB95E;
	Sat, 12 Apr 2025 13:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DE1922E7
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463962; cv=none; b=TUBxpFyRMVLDvgtfBJXfpMvD1IML1Sm6ZZdm6f3EivPF7NZtSTY2rNseMDabqeKzxh19yvPwyqaAy4FJKKuZ9vohIhbZUXdDd5SevvtvffR4xFf/aN+mUHy1KwPz66rBiW2836ZpuzX2s6QIJhQV/LT315O0ejptvny7N1SHNPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463962; c=relaxed/simple;
	bh=6wqZnJQHNL9U2VEPe00x4sOYxVhQTUPjJ02/UOpBnl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4qoJCWWQ1lpZ05Dc2YY7FGi4g8/qK4K6Fy69GLATjBgPC41xdlLF6VuxwhcoVmMFFDMpehUuiUQT+meU4XVulGRme1F5JBzaIicjiJpl6kJpNlT/ApdGoGsipClqk2noG+VtsUTrGYmLCY9i1VSH9UBXjwLof+ClZav0Wi1YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZZYvQ4QX7z5vMq;
	Sat, 12 Apr 2025 21:15:30 +0800 (CST)
Received: from kwepemg200004.china.huawei.com (unknown [7.202.181.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 234E618006C;
	Sat, 12 Apr 2025 21:19:17 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200004.china.huawei.com
 (7.202.181.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 12 Apr
 2025 21:19:16 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: <idosch@idosch.org>
CC: <dsahern@kernel.org>, <hanhuihui5@huawei.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH] resume oif rule match l3mdev in fib_lookup
Date: Sat, 12 Apr 2025 21:19:10 +0800
Message-ID: <20250412131910.15559-1-hanhuihui5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <Z_V--XONvQZaFCJ8@shredder>
References: <Z_V--XONvQZaFCJ8@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200004.china.huawei.com (7.202.181.31)

flowi_oif will be reset if flowi_oif set to a l3mdev (e.g., VRF) device.
This causes the oif rule to fail to match the l3mdev device in fib_lookup.
Let's get back to previous behavior.

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Signed-off-by: hanhuihui hanhuihui5@huawei.com
---
 net/core/fib_rules.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 4bc64d9..3c2a2db 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -268,7 +268,7 @@ static int fib_rule_match(struct fib_rule *rule, struct fib_rules_ops *ops,
 		goto out;
 
 	oifindex = READ_ONCE(rule->oifindex);
-	if (oifindex && (oifindex != fl->flowi_oif))
+	if (oifindex && (oifindex != (fl->flowi_l3mdev ? : fl->flowi_oif)))
 		goto out;
 
 	if ((rule->mark ^ fl->flowi_mark) & rule->mark_mask)
-- 
2.27.0


