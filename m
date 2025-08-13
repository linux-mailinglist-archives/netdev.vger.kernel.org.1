Return-Path: <netdev+bounces-213341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0CB24A11
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8BE722748
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DED32C0F67;
	Wed, 13 Aug 2025 13:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C7F50F;
	Wed, 13 Aug 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090029; cv=none; b=CmDJ3To1AXfr8i+11aOKkf8araqNC/0jo8V0K5B5YuzvrcIBl3fBZoYKOPucgHmbVKEvjmWNdvifEighb0IOjYgV2nVU9a0iLid88Su4DjKIIgOAi0zsK/RRDpIqvyKTtMD0R3iMr3CyQZVUofjAxyJl2u2OZAwiyguEiAF7vD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090029; c=relaxed/simple;
	bh=bSv9TzrCqcZ+O1xArhQCVlN66kWeUdaHS+HKQRHitV8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4cd3UYp5TtVd7J/1YHdZj4/OOL6HjKFVJs/5uKCKK5FTWzUU6NF6w7RmsacwiiR3sOpkrLkXQPH+POsSbLByIC57vSrHHVzvNDyKh0R14rJFPF/nvv0OzF5GPlOPUrHIWRtsU08x1rjcfYocEU4wldLQ4BzXt/QP7iiqGOeXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c27h71c10z2TT7y;
	Wed, 13 Aug 2025 20:57:43 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 943611401F2;
	Wed, 13 Aug 2025 21:00:23 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 21:00:22 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net/sched: act_api: Remove unnecessary nlmsg_trim()
Date: Wed, 13 Aug 2025 20:59:15 +0800
Message-ID: <20250813125915.854233-1-yuehaibing@huawei.com>
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

If tca_get_fill() fails, all callers free the skb immediately, no need to
trim it back to the previous size.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/sched/act_api.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9e468e463467..54c92d0755c9 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1649,7 +1649,7 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*t), flags);
 	if (!nlh)
-		goto out_nlmsg_trim;
+		goto out;
 	t = nlmsg_data(nlh);
 	t->tca_family = AF_UNSPEC;
 	t->tca__pad1 = 0;
@@ -1657,14 +1657,14 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 	if (extack && extack->_msg &&
 	    nla_put_string(skb, TCA_ROOT_EXT_WARN_MSG, extack->_msg))
-		goto out_nlmsg_trim;
+		goto out;
 
 	nest = nla_nest_start_noflag(skb, TCA_ACT_TAB);
 	if (!nest)
-		goto out_nlmsg_trim;
+		goto out;
 
 	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
-		goto out_nlmsg_trim;
+		goto out;
 
 	nla_nest_end(skb, nest);
 
@@ -1672,8 +1672,7 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 	return skb->len;
 
-out_nlmsg_trim:
-	nlmsg_trim(skb, b);
+out:
 	return -1;
 }
 
-- 
2.33.0


