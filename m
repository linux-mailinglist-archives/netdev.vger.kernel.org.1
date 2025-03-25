Return-Path: <netdev+bounces-177629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF46A70C13
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712763AD068
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD382676E2;
	Tue, 25 Mar 2025 21:31:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A53A266B55
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938272; cv=none; b=F1agEXx7ECaz2tSQHE8s1Khm51tx3DbrlZxacpCqYtOQ3HXx1r4AsJyGqRZmT2S72H4B38B3aWK9vodWdxR7l+OENQKaqJCykMeWHBl8FWlyZmUUUwLGulE6M8Ei+4o6MStr74pKGHllK4hLu+njOuj4BPu+COmTimQvyn98oGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938272; c=relaxed/simple;
	bh=CUR5I3UpwjbNO0hNnmCCSuAoAxW+HdofdbYjgHwMqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHs3T+SF8TjStFcPuu8Af02o7gpO5BoW0jmvcnbmGx7i3sllnFvUC+rGlkfAaQzjkJTsjvyruUcqGjptT30bZdoyYwEv8Jkrn9sbQAc5dRMwE4JI7e4z4CP/I8vaUBUhvAd7PvylMmcSC43wd4brcxC+OsaWMFPCIup3aIhic6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227cf12df27so3945595ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938270; x=1743543070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knTGk9lxkObf5m8zJBEYc+FoI0axfDUQp9+wJSH7C6k=;
        b=U7PDakPclO3JNXcHdq7UwAyXbGp5zp8H/tjCaEb0xubS2LzXQlq9FCKH4LRrvYmryQ
         BRX0u5zoRUth2rlEHmu+YNJ16dW0yYS6BqYdWSQ6TKhiYKGpC+YTOi3yLbkP++Y1JEcN
         psG7pQp66W+x7HfrLOWpU29L58a1icWBM25vMK97nVZhjk43jG4IDZxjdlh4JAPsxIVm
         GflcqYy82FkpNzFZVc1zt5fpfGMueYHZzEgS+fFYQVO3VtYGjFTgC5W9gxOiwLZLoWw9
         yEPwXxno5NWaFR/OPnHMcdtRlYYyTMY20hJzour3kJ+jJUrvOxoJdeO7kOz2HW3Jovqy
         uSSw==
X-Gm-Message-State: AOJu0YxTkXFCnnxyshtpL1nAIxyR+kmCUwH9rEZC5fOLuvCrw5E/4SY7
	yDwqyLGpkkbirsvsHSATzGoL49yJJmTkjWokBgNU0O7wmyNQCZEPNtFsThQwzA==
X-Gm-Gg: ASbGncuJWMAy+NwtVoIiLS6PeH+cGUda5mf8dGK1mn0oU0ljiFcpfLiKOYIt0IxMevD
	WG/gTW15SToljSUiR1wBQhR77oFj26860ViW8sm6zJ78JZFSgx4g/s5e7WoanP8QUmH1ih42Ova
	fzi4K1YQCgxCtJnoMJBlcJDSv+PJb5yF1CB+Fw5XXT/dHRK3XNVS47lgFkIICOGQz7wPTrZGLC4
	VyBUxfFQRLmmzfNDjyWabD4g5X0y9pGGSXPJG33/4r8KsRfzVcRBRnI9rKF5OViLTe4NAkIQgwK
	M2CX22smwB0N4yGD6ZC0qJ03ZMGGDD+ICrS1bL52UIu6Cn1jb2kFrRk=
X-Google-Smtp-Source: AGHT+IE6OI7ZYUB+RyRqNOSHa6dcIorzBveqcHsTle4MLuY7jT5AFxe0+OyjKOH7Fp1j3gwplFjLUQ==
X-Received: by 2002:a17:903:1cb:b0:215:6c5f:d142 with SMTP id d9443c01a7336-227efb875admr16785655ad.20.1742938270019;
        Tue, 25 Mar 2025 14:31:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811da369sm95585925ad.170.2025.03.25.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:09 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 9/9] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Tue, 25 Mar 2025 14:30:56 -0700
Message-ID: <20250325213056.332902-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Netdev queue dump accesses: NAPI, memory providers, XSk pointers.
All three are "ops protected" now, switch to the op compat locking.
rtnl lock does not have to be taken for "ops locked" devices.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/netdev-genl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..39f52a311f07 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -481,18 +481,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
-	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	netdev = netdev_get_by_index_lock_ops_compat(genl_info_net(info),
+						     ifindex);
 	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-		netdev_unlock(netdev);
+		netdev_unlock_ops_compat(netdev);
 	} else {
 		err = -ENODEV;
 	}
 
-	rtnl_unlock();
-
 	if (err)
 		goto err_free_msg;
 
@@ -541,17 +538,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
-		netdev = netdev_get_by_index_lock(net, ifindex);
+		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
 		if (netdev) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
-			netdev_unlock(netdev);
+			netdev_unlock_ops_compat(netdev);
 		} else {
 			err = -ENODEV;
 		}
 	} else {
-		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_ops_compat_scoped(net, netdev,
+						       ctx->ifindex) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
@@ -559,7 +556,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->txq_idx = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.48.1


