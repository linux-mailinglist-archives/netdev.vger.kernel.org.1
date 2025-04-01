Return-Path: <netdev+bounces-178660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA7A7808F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E647A3E8E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEB20FA9C;
	Tue,  1 Apr 2025 16:35:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00820FA96
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525312; cv=none; b=g1ONBMzXYvI1/pnl6suCsaZEnVtXoWFHJrtR4Kpxzf0xokJfqVbsXpt6gIwL0QgxTUyGJTNuYX/cgdVEjw33AQduaXoVI/vJLxxrtHDpbWh/JD04g4aZVb7GVH6qCCusPFDpFoh/fABnnxrwjurLtd6Vii/ZZbKtV3aCyX5C28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525312; c=relaxed/simple;
	bh=Kt1WIg4lIHQ0tNTX8utGNk0WuyC4wNiPq7D7wY3RHmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/EgN5sVFFYmgNOpwdSTTIvkGxyAZl4tp9DmWsV1FWebAQbahN+FlEBdnL2ibSSKRneaCLdI7N04PJ++jAX1c1OpMW5ftjR5Fq8hYJYxOFWsuEZlO77YBXUgnbt6TnUZ+7dU6MJoT3f25+4dXTh+GDRngPLtm6xMve7wM9cGYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30362ee1312so10169166a91.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525310; x=1744130110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5haY6mKBf1kNjqdrh+owzCUwoLwuFf5utGl4xuJ7TU=;
        b=V7tdhZCZqFeLx7twQKpkruS5Qs3VjWkw/zYF6tBg4Xc5SGGgz58HxbmV71zbWWs1wD
         Ml3ua6SsVWZbyvaY/OEJYJe4ya/YkSPEN2ufrYCkqcP0fcCpNknMexmIF6tb6IrwJ+1O
         7bWKw6/GGmAe3xsnH2jjDv7u5eqrpdvPZ0tt2FaTkulJ6Up207QTp4pEyBBdyeDl0GQX
         tymv/qXOlaikIgvbuaZ9lin974WUQTRQAnXHgGBcBoLfS4i2IaJzsl3AunP9c0DvVEKv
         +dGqqOz/9OFQwd+nxK9JyU1KMp/r3SMvwhkUUwus2C4j0e5ifAzfXNLlc1oMd9i3ly0Q
         ipeg==
X-Gm-Message-State: AOJu0YzMKlZ8TmIHTtGVr9BOChMAqq1D2siZetXpyJpzXCfAuCuK0nz1
	z9Q6WB96nz9JANqZy0sq7DvO9zP8/lI8OUl1N3rpNE85Gj08axLa95SvZrFiaA==
X-Gm-Gg: ASbGncsADG9OCy8NCTXjT8NBx/Zewpyq4esZzXAo3agu61gRl/r3w1FiWu60/mPYuF8
	82w4LiluWRpEqTn33livE3p2R26kGwxr7KPLJB30136Fur+UUIR6US2sS9KVN950JurQ2urvNCO
	+ptg5zet8+0ikVDk07y3znQBJTdBUR60tgMx/9afCDiWefnJ24wPVeTGyaULjLfn6ye7O7u6ikQ
	+aOxQeGCzcm+oQbnWnjA6GkeKyHv0cjyJPevsgqVyXUv0D2iCPUkxPiC9DNNVZzJh8swC/DcA9O
	7Dzih1T2t5Wb5oI/BbpxGYLFio/V2qHj4aMfLEmbOJtv
X-Google-Smtp-Source: AGHT+IEZBf4fKopGb+2H9NDULNg/MAMle5uTLdonr5HuauraSJ7D9psKEifdmrjcsmAZwm4vkHhvBg==
X-Received: by 2002:a17:90b:3b8a:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-305320b1043mr18395665a91.19.1743525309600;
        Tue, 01 Apr 2025 09:35:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30561cac698sm1163482a91.0.2025.04.01.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:09 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Tue,  1 Apr 2025 09:34:52 -0700
Message-ID: <20250401163452.622454-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
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
index 3afeaa8c5dc5..f9d7fe89644f 100644
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
2.49.0


