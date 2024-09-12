Return-Path: <netdev+bounces-127609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BE975DCE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C61E2852FA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8AE195;
	Thu, 12 Sep 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHfC/RhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55F163
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099508; cv=none; b=jWOEMLnT7E2+LPPdajK2zpE/qPAQT1sYZObnqQcktLMkLUoQaDq49mXW3OGQHu0Y7Bt3K5w9E8JjJBA5MUDToHXOPYt6RpRnqKooco1PnTbktS+jjK9UE5zL2WAhz7MWdo+v2+xIYK9CLuSYj2gakurzjsqpogB5El/ngzanLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099508; c=relaxed/simple;
	bh=fb5HhodrvahbNd+/a9bOcwI02aQwPzwG4giOeBlQJNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMNLNB9BYfMikazzlstxP9Ro+eO6DBKCS6FjpM2BMV8E49cQm5T2CKnORrlO3kumPL7TPW+3Ph8X1Yo6WYjDD8Yhrw5ONkecH/YunWB/kaOnbpazqDE0cEWWsJhD/DEQfPmchpfPMi5UIwgTfE6sNUpudpqdpE5PwYx3tE2xrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHfC/RhR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso245093a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 17:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726099505; x=1726704305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWHm2/YRe6ZFjyL9mJn8tR0Am6Xy5LelW6H+bBRiW14=;
        b=PHfC/RhRiTu8VTsw5J3/Q8n/WyRPtBi9eLh6UZ4AxSXdlt2EKEY0Dieqf2cFSIQ6PT
         boG2v8bwNBFzTh7+DiyCZId5jJfnOxzUAcAkyz9mlR0MugnzvkveFGmoRXhjsc3qfEOW
         MqZvgjeyK3rF8hd7FjsLgSS53PRxMl68LIwIod9whBIyJcShdMo/0ml9tMq6Qw01puoo
         fdWPv1I9gAhg8zgazCsa7OuY+NbKafX4ueK6GTsRFaXy4jjpid/oWJU56YhZhNayCUKa
         PNgZYg7PusnkJRf95CiqUPgnChbOpMj5JvAGkrS0OyKGjdEZIpe6On594oOf1fXHC/jv
         qFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726099505; x=1726704305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWHm2/YRe6ZFjyL9mJn8tR0Am6Xy5LelW6H+bBRiW14=;
        b=X6jYmR6hdbSdfuGQAzqsKi4rBWsfh0WQ1dOVeefEkM60xXOrSJVIgZhq3xY8qAnIwT
         3nMosbqhIZ2/iyu6c1poMe9GgJADhD8Nm+fFwsTbpMVG4oOJCsS8AuaY+mABSk9lNZDD
         wXJX4WYHBcw8FxID1kEfuSQriSDRHt+cVsS8pVAi21HAsrnAB3k/LFxonKjShg5NzH/K
         dZfc4drk5U5vNMga+BL6rx4cto/HwZjQq5XO9aRJU5R6bQdS5BBmY2fhLQ5fZnYtpTor
         bZXeSP1cqDv3Ezfjdm0N13I4rGfjxjvRDPLK6aOewNXoH35dXqpiE0St5lk9WCtxzhW4
         cucA==
X-Gm-Message-State: AOJu0YwyWslMv0l436EvrlGYjBMyaBTLcY1MvZBPjACHbo+aX+0FZP4Y
	K1T5KHeEM5RxCHygsulRXa6jt/lF/5nO4OQYP3oBzvM/dAWRUo7fCAtns9Xf
X-Google-Smtp-Source: AGHT+IHUNmudFXtAo76lMwQXaTJpL0Rn/tUuU7KUctg8dJl94RViZuh+/1N3IAyZsN/do6fO3Jc4aQ==
X-Received: by 2002:a17:90b:5248:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2db9ffbfb66mr1144535a91.10.1726099505316;
        Wed, 11 Sep 2024 17:05:05 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:e0b7:fd3e:eec5:95ea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db041a2cb8sm9190728a91.20.2024.09.11.17.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 17:05:04 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>
Subject: [Patch net] smc: use RCU version of lower netdev searching
Date: Wed, 11 Sep 2024 17:04:46 -0700
Message-Id: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
RCU version, which are netdev_walk_all_lower_dev_rcu() and
netdev_next_lower_dev_rcu(). Switching to the RCU version would
eliminate the need for RTL lock, thus could amend the deadlock
complaints from syzbot. And it could also potentially speed up its
callers like smc_connect().

Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/smc/smc_core.c |  6 +++---
 net/smc/smc_pnet.c | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b95828d9976..574039b7d456 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1850,9 +1850,9 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 	}
 
 	priv.data = (void *)&ini->vlan_id;
-	rtnl_lock();
-	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
-	rtnl_unlock();
+	rcu_read_lock();
+	netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv);
+	rcu_read_unlock();
 
 out_rel:
 	dst_release(dst);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2adb92b8c469..b8ee6da08638 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -29,7 +29,6 @@
 #include "smc_ism.h"
 #include "smc_core.h"
 
-static struct net_device *__pnet_find_base_ndev(struct net_device *ndev);
 static struct net_device *pnet_find_base_ndev(struct net_device *ndev);
 
 static const struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
@@ -791,7 +790,7 @@ static void smc_pnet_add_base_pnetid(struct net *net, struct net_device *dev,
 {
 	struct net_device *base_dev;
 
-	base_dev = __pnet_find_base_ndev(dev);
+	base_dev = pnet_find_base_ndev(dev);
 	if (base_dev->flags & IFF_UP &&
 	    !smc_pnetid_by_dev_port(base_dev->dev.parent, base_dev->dev_port,
 				    ndev_pnetid)) {
@@ -857,7 +856,7 @@ static int smc_pnet_netdev_event(struct notifier_block *this,
 		smc_pnet_add_base_pnetid(net, event_dev, ndev_pnetid);
 		return NOTIFY_OK;
 	case NETDEV_DOWN:
-		event_dev = __pnet_find_base_ndev(event_dev);
+		event_dev = pnet_find_base_ndev(event_dev);
 		if (!smc_pnetid_by_dev_port(event_dev->dev.parent,
 					    event_dev->dev_port, ndev_pnetid)) {
 			/* remove from PNETIDs list */
@@ -925,7 +924,6 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
 {
 	int i, nest_lvl;
 
-	ASSERT_RTNL();
 	nest_lvl = ndev->lower_level;
 	for (i = 0; i < nest_lvl; i++) {
 		struct list_head *lower = &ndev->adj_list.lower;
@@ -933,7 +931,9 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
 		if (list_empty(lower))
 			break;
 		lower = lower->next;
-		ndev = netdev_lower_get_next(ndev, &lower);
+		ndev = netdev_next_lower_dev_rcu(ndev, &lower);
+		if (!ndev)
+			break;
 	}
 	return ndev;
 }
@@ -945,9 +945,9 @@ static struct net_device *__pnet_find_base_ndev(struct net_device *ndev)
  */
 static struct net_device *pnet_find_base_ndev(struct net_device *ndev)
 {
-	rtnl_lock();
+	rcu_read_lock();
 	ndev = __pnet_find_base_ndev(ndev);
-	rtnl_unlock();
+	rcu_read_unlock();
 	return ndev;
 }
 
-- 
2.34.1


