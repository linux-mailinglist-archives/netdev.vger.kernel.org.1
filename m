Return-Path: <netdev+bounces-178347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35DA76ABE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C523188438B
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC392222CD;
	Mon, 31 Mar 2025 15:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11F2222C4
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433583; cv=none; b=anUiNdV3RU2yupWtckeCZNC6oww/ai1lAwRPDyr5V2/yBysClTxYmoT/SefTtiqzCQpXQ14Euf8V9OkY7OXaGXVElxtZw6YbF2jRBRAamDKWiAuJ6AcH4zZ6YG3TLzEJgODYXUvubSnCIL6MNUH/Zg7qLmO0ZvLZx1ltUZIYbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433583; c=relaxed/simple;
	bh=CUR5I3UpwjbNO0hNnmCCSuAoAxW+HdofdbYjgHwMqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG+lJgUHvjJ8kou0red5vYVQfr96LDLlfOyHFdhiqO+k2Lq+vQWUveL1kL7becp1cKjmJzclfD2nbLEgZkDZfbkkPSXnIQ0e/1p4mFaGQ6cih7Ef8/pT9kNqJdW6Bx+C1zeIT9YCKGKSFkR23auUVcIc2xDuOIefo/nebZrUCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso82917655ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433581; x=1744038381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knTGk9lxkObf5m8zJBEYc+FoI0axfDUQp9+wJSH7C6k=;
        b=uwZzNPaiuGJ28idfEhdTr7HWv/WWUwVfN5VZg2pMzbmEaeTE/k+SnzTh+EkiKp1boH
         EBc6/E6MDhj6cHCz0LKoi+JkOmbSodNxqxo9UE13MPTu0LY4CH2fFC1UZQ3AZPRqSMU2
         kJiFmPoXCJ0yeBQJDp88wPchFx/UJt/w3Mk4c6RCup+ZxM5sJif+CkWPj1PhsdpgevrJ
         ZUbaOM5xo3CPKUL7y1KZd8WqiK+upjNtO6HvR4SWz2Gp1YDJmxwNOUNLFQR4EW5mJUCb
         rktgTLcJYSAhyDaljwO+74HuNSkY6jDfdVChLDYa7KVrisGEVeiJvtW2HMDRrSBp+7sO
         vyug==
X-Gm-Message-State: AOJu0YyccbCbQq7hY7QVOM6qMZe5jdTT1F7Qgb5kcNByF83GVfcD2M9l
	N/n1ksWh2FCzn4lE3ZJPz9jq6XT5X6AE3e2UetxoJ1O/zSjIF1E2BM9l
X-Gm-Gg: ASbGncus8ev1RYsxbxepqOuOOTyZ/bT77x/Is4kyOP1yAoNfmYnWr5TEn6hG3/05XXY
	4W+vhZ5iqQCBkeZ3viE12R+PQ43MsJJWv8kji4rXZXAPEKwsQ3D32TC56ZXBTdx58mFB4fp12bR
	j5ewSDXohKcLHqietNueGfJWLa3DW01l+7cwTIWmt+pW60Lybrjy85uiktjXjRNg5H8Vi2pViYy
	YqAPtE9RcRO9mYlmfA5HkC7QtoNakMXHFF3kdKPPLrt8d1eWRNmpy7FOb5DccRyJo3TPvn7Trek
	S7Xqxw6dv3Fsj9yekqRBY+7dIfW0wSXld294WVX4gfuM
X-Google-Smtp-Source: AGHT+IHOliYcGEM1yeelfVNMGvLe62fnCfpFru2B/c1wuq4EYQTooKUdgiQELzB4UXi9t4awYWCIAQ==
X-Received: by 2002:a17:902:d485:b0:223:fb95:b019 with SMTP id d9443c01a7336-22921d4fc97mr183423905ad.24.1743433580926;
        Mon, 31 Mar 2025 08:06:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1dd285sm70173665ad.169.2025.03.31.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:20 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Mon, 31 Mar 2025 08:06:03 -0700
Message-ID: <20250331150603.1906635-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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


