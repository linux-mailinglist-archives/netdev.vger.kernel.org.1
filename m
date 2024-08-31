Return-Path: <netdev+bounces-123972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A712D96709D
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34602B22497
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76D17E015;
	Sat, 31 Aug 2024 09:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70D178381;
	Sat, 31 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097832; cv=none; b=G+a3mgDTr6Bg2eAlB+hY1KoD7Fnx9Ss7WH09ZqX/LBpwWBSagE2N3tVGU3HcNuNanZstYCjq9KylZ02jFLzxT1PMrmduaiTkkmR/qK4bvgRY9tdRrO7rG//GISLYnTRVhSfvvXbatS4ZRzRt2wLPvBsfKK9oLnTrhEbKGDQxluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097832; c=relaxed/simple;
	bh=mdDMrlLBsuu4XFK1sszaYnYvrYYq6Nt1llkaa/8V4pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG1aA96oCgxSud1xBosxCKICZeQ/vNm1g6FlckYbeF45i/WU190eaIJeYuTdQf5t2cwxGOYQaUC9Kz2DvuRP1eSLfSs+6giv4upZOpcI8TkLPGuorhr4HR4vnOcmlnhgasQmpJVWGUXG+nm2LqFrUSTucIerDuryl0O443Nn/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwqxC0Vg7zyQxW;
	Sat, 31 Aug 2024 17:49:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D07D18006C;
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
Subject: [PATCH -next 3/4] mm: page_alloc: Make use of str_off_on helper
Date: Sat, 31 Aug 2024 17:58:39 +0800
Message-ID: <20240831095840.4173362-4-lihongbo22@huawei.com>
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

The helper str_off_on is introduced to reback "off/on"
string literal. We can use str_off_on() helper instead
of open coding the same.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 04a90dfbce09..8adda0b67253 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5517,10 +5517,9 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 		page_group_by_mobility_disabled = 1;
 	else
 		page_group_by_mobility_disabled = 0;
-
 	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
 		nr_online_nodes,
-		page_group_by_mobility_disabled ? "off" : "on",
+		str_off_on(page_group_by_mobility_disabled),
 		vm_total_pages);
 #ifdef CONFIG_NUMA
 	pr_info("Policy zone: %s\n", zone_names[policy_zone]);
-- 
2.34.1


