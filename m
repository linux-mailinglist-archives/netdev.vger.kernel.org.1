Return-Path: <netdev+bounces-146390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D749A9D33BF
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4072835A4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59276165F0C;
	Wed, 20 Nov 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ke954XUX"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBB12E5B;
	Wed, 20 Nov 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085302; cv=none; b=jpSnZQqSLGD+FwZflfiScCfhfDLUngYCtQAkW2V6PMTJ3zEwHaUSdV3t0fax/hCqDf2/pR4pHvRGNYS9AazfnrH2gPBlp4I5yfruHxNyNAr0FF48GsDmNeKQPB5hlJnh94GFs8rjTfbwG6eREkqNGWX0+mS1eimEc4936rQlhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085302; c=relaxed/simple;
	bh=toOq20qVXZzub2JqslpVXaa5G6T1/Fn2No54S89QEQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzlKGsrYc7PATiC15fvfWeRPUkjNfqzXl9/OoLbxytcUOMpYeaZtFhQcB1rGzgCvr/T39gP9d1/eRkWM/o8U0bcmuonjQiPfY9n6vz/x/VTkHIVOhpHK+DWPCy927JOfnGxBEDU45N/F4gpARDNOPHTlnXAkAyow4d6/DEdAQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ke954XUX; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bmhQu
	nCpSSNOOQvTNauj7axcKMoPEb4r9c+M61pUEm0=; b=ke954XUXCBwoIJY01ZbPP
	CVA1smL1UXQJ/yJEvewmr+lrRDIVJA6FXweFajAj8cmMIa683V8La64tisCgZS4m
	7HI8FZCU16gaB+Hgg24YurKJ7SK0dafUSDNasqdnz8u+lmkuviamNY7/Zd7GXjTD
	TxKaT0ghXhyaLW/AFXvuSA=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD1j4hT1nTO3OIQ--.22522S5;
	Wed, 20 Nov 2024 14:47:24 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	pshelar@ovn.org,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH 1/4] sched/topology: convert call_rcu(free_ctx) to kfree_rcu()
Date: Wed, 20 Nov 2024 06:47:13 +0000
Message-Id: <20241120064716.3361211-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120064716.3361211-1-ranxiaokai627@163.com>
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD1j4hT1nTO3OIQ--.22522S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1fJFyDKFy7ZF1rtw1DZFb_yoW8XrW5pF
	WrGryUKw4vyws7J397Xr18CrWUur9rX34a9a4UCw4fAr9xJw1vvF1qvF1IqFyY9rWvkF4a
	vF1jy39Fga17trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtHUgUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRudTGc9e4T0vgAAsM

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

The rcu callback free_asym_cap_entry() simply calls kfree().
It's better to directly call kfree_rcu().

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/sched/topology.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..60ff3ba1d6ff 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1382,12 +1382,6 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 
 }
 
-static void free_asym_cap_entry(struct rcu_head *head)
-{
-	struct asym_cap_data *entry = container_of(head, struct asym_cap_data, rcu);
-	kfree(entry);
-}
-
 static inline void asym_cpu_capacity_update_data(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
@@ -1438,7 +1432,7 @@ static void asym_cpu_capacity_scan(void)
 	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
 		if (cpumask_empty(cpu_capacity_span(entry))) {
 			list_del_rcu(&entry->link);
-			call_rcu(&entry->rcu, free_asym_cap_entry);
+			kfree_rcu(entry, rcu);
 		}
 	}
 
@@ -1449,7 +1443,7 @@ static void asym_cpu_capacity_scan(void)
 	if (list_is_singular(&asym_cap_list)) {
 		entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
 		list_del_rcu(&entry->link);
-		call_rcu(&entry->rcu, free_asym_cap_entry);
+		kfree_rcu(entry, rcu);
 	}
 }
 
-- 
2.17.1



