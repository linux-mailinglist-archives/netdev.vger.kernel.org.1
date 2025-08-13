Return-Path: <netdev+bounces-213337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEDB249EC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E39D7A5A16
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF22E54AF;
	Wed, 13 Aug 2025 12:56:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6A2D738C;
	Wed, 13 Aug 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089806; cv=none; b=CCRGTh5m8AXtuMLRk66C0psBHlI8i/2j8AlFBO2H6uvUr/ltctYRvz05mo/OzpLCFwCEdxeZhBGxfNMHWIvXfm4zO5mBj9OEHwas0fuKMlCW/IiLTjOvLvm/YudCaQUA7b74raVPhbgSHUF2RS9GnDZPZ8C+wkPnInPK9aUZ8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089806; c=relaxed/simple;
	bh=2LTFjlXwNsaG96B0in79Z3KYwfr3m33dRjlI8GNgG8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHdrVTFSSz7DezIuEooia/WdbXw8Lk1x3nY/XJEh0Jm0L1y4+bNHU58Na2L6rgfESUBm00fQvX6vZWg4S2+kDy14vcgIDgGL1wb7fIGOOg/NyFebIHP7nkB665PDxZt2vw4Ztau90W8t5BkDFtsoNnxyywx1hrXaWObbsOHAv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c27bn6RxBz2Dc1d;
	Wed, 13 Aug 2025 20:53:57 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C4BBC180044;
	Wed, 13 Aug 2025 20:56:37 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 20:56:36 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/sched: Use TC_RTAB_SIZE instead of magic number
Date: Wed, 13 Aug 2025 20:55:26 +0800
Message-ID: <20250813125526.853895-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Replace magic number with TC_RTAB_SIZE to make it more informative.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/sched/sch_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index d7c767b861a4..1e058b46d3e1 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -431,7 +431,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
-		    !memcmp(&rtab->data, nla_data(tab), 1024)) {
+		    !memcmp(&rtab->data, nla_data(tab), TC_RTAB_SIZE)) {
 			rtab->refcnt++;
 			return rtab;
 		}
@@ -441,7 +441,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
-		memcpy(rtab->data, nla_data(tab), 1024);
+		memcpy(rtab->data, nla_data(tab), TC_RTAB_SIZE);
 		if (r->linklayer == TC_LINKLAYER_UNAWARE)
 			r->linklayer = __detect_linklayer(r, rtab->data);
 		rtab->next = qdisc_rtab_list;
-- 
2.33.0


