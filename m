Return-Path: <netdev+bounces-178208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DFA7578C
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CBB168D14
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF11DF240;
	Sat, 29 Mar 2025 18:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07531DED5E
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274645; cv=none; b=Hu3jMmgEWcqS56C3WpJmJyinfeKMytfauTo46KPBe0PyuDAPDcO0yl0ZA72MXM3T5Xthn0r4gz72UVG8mylciEa2W61Rnmmp+aDrymFQmBQFisvZncNOjI+NnQhg9ohenB4P6hvHJ+9HWPqslqMTdh44MxY2R0DoOOOPVBHJIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274645; c=relaxed/simple;
	bh=CUR5I3UpwjbNO0hNnmCCSuAoAxW+HdofdbYjgHwMqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEwzfEb4bWdVHjdfj6XnZ5OOHsUHZo3yM2of8d9FC0NSYxygQbeBKa7IBDLHF82IuRVfApx1gwrfS91R3Zn8tBeG88OElD8aZ6iRPCLJk37zyXRbJQN5WynSaSH019FIPENG3qrDmJwA4hk/eMivEv3BjjRBwbwyZzCTsq2svVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso66948245ad.2
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274642; x=1743879442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knTGk9lxkObf5m8zJBEYc+FoI0axfDUQp9+wJSH7C6k=;
        b=LVEIevd5uCoLcz76EkeLWP5vbsaJXgjcHmFjxhynApgz7K3xi7hrNXLbp/toUnM0dx
         LEr3SVwRAl5wdttC6Mcbrpvdcnl/Jn2k02nYBG8ENs3k5YDB1oyIsmsU4zlDKv9WKpIq
         2CancnQ59hxEqs+LwYO6WOax4LFRiYmSwaWM2xn0eNRk7HtVKZ5MyGNgrdl4oFoxEAuH
         W7jJtGTP8FD0nOuKX+BK4j4kgHcaGhLAJ+28nNISOvrnmArYLGnAHs5imcYNlQxa6Vwv
         fxI2CANTrTSjoQYZr7mCehKEYa/OxpAqAZdNFTZn7cKy4WwtaQIDpoOPhDGfSZgTOxEU
         f6ow==
X-Gm-Message-State: AOJu0YwMfomQlC9g1qUnpInmnqlyH9lsIjt3x/+5TCyn9p7b2sPni7Nx
	AJ5up8erkvoZ2wll8x9jg7ZxnAoziCoH9q5knxXODgXJA2TMxf476tPU0E0=
X-Gm-Gg: ASbGnctkAN/RzxmvG5TB1cB6nWMwjAzkC9yBOIbmWhNR7tcqEzuxKNbFvixb2dw6IBh
	TYKpKDtzJ3Gt6qyS3Mw5A282wVstCeS2IHbVjnNNg6VMNFij0Gem/8hMMUmJb12QMU2XcrfcFEv
	Z9eAGAYv7NYT4GvYpKuJ9Bd7E2qajtyjcUmEfyrEu+XM7A2fm6pivxifjP6GQvMDVhvGG7lsELb
	49aPGD5DyVKg7seULeh0HSgcj+6QqOiMy93w6p9q8kRIE8JgfnXVBf3sAvwgtca+Q640RtAg06f
	NaGBgDU0e0PKBDpEbc09wAKg2TsL+0S6yABy9AspHB8rdYBE2P2e9cM=
X-Google-Smtp-Source: AGHT+IELjhLlUzQzXrQ97Lyu6+EGgRh0OBZnFwQlHp9mv+GaeiUIcTjvdYzNvm+KerxL2tq6EM2BFw==
X-Received: by 2002:a17:903:1a0b:b0:224:1eaa:5de1 with SMTP id d9443c01a7336-2292f95f318mr51390875ad.18.1743274642342;
        Sat, 29 Mar 2025 11:57:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cf860sm39453695ad.115.2025.03.29.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:21 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Sat, 29 Mar 2025 11:57:04 -0700
Message-ID: <20250329185704.676589-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
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


