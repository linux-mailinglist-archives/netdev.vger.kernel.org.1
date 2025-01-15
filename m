Return-Path: <netdev+bounces-158382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D2A11821
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A86F188AD76
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E022F83D;
	Wed, 15 Jan 2025 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBAsxA+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF022F3A0
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913222; cv=none; b=FJ9oYAXkzaOskcZNqfr1XGBz82QOBt41OuQieozifdfrok1DyUtf+wM8Us+Z/ifelIWQ7C8YgYzPI7cEnSa0miSH7+jJ2mYs9W7Rp4GTAB+RhOW99dqymiid1RqOF2jaFMZ9sTGwqSUI615zEj5dtwgPQ/gK5Zxef7BtRIlVUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913222; c=relaxed/simple;
	bh=rzT1dRW5dy8Gl8R8yjhI5yMch2GXNUo4fdukpwdqlEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr76NRmXbtCtVSB4sBc8nnir3bXVV0+R+Be2jJM+z3QWTWpNVk0AYBB/AGvgFNLkwkYvKKe9PkyfSkKN2NqmB+iKZg0uNMAR1thp7YpX8cu5vxm0MEgmGYHeSxINBvCVz1JHpWGMT1fnY7c7YhK5YQFeCmiojAy30SjscgrgyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBAsxA+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6792AC4CEE4;
	Wed, 15 Jan 2025 03:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913222;
	bh=rzT1dRW5dy8Gl8R8yjhI5yMch2GXNUo4fdukpwdqlEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBAsxA+h9LF/E9vF2O1pmXTG1MI/fc+QTIBcWK8z8QC2qiYmcGQsI3aUyywv5hRfu
	 17bkaH3Ba8wdzbZXMmX2kBqVk5EJq+t9vQxXZUBPzc+YgBCjsAjy/+An1bDxsW+MmC
	 QqAuVc1h1jn6zQcBv83VaPKTlh1SWzLzUdvr1cwTRYCrFcSCsSNk957O6iJ+4fQEJL
	 0lN0gOibJq3LAXpleVW3SejaGCtbtESd40fwrExiaQv8qC4iFg++/W1wb/KOCCXulv
	 otS1RIRqTN4JuFRMz9mdKimuRtIFfbv9+fWjgzHt8RW8pC/JaXdaHKdzmTcNI14m9A
	 HjcsSc1rorbrg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/11] netdev-genl: remove rtnl_lock protection from NAPI ops
Date: Tue, 14 Jan 2025 19:53:19 -0800
Message-ID: <20250115035319.559603-12-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NAPI lifetime, visibility and config are all fully under
netdev_lock protection now.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 810a446ab62c..715f85c6b62e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -229,8 +229,6 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
@@ -240,8 +238,6 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
-	rtnl_unlock();
-
 	if (err) {
 		goto err_free_msg;
 	} else if (!rsp->len) {
@@ -300,7 +296,6 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_NAPI_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
 		netdev = netdev_get_by_index_lock(net, ifindex);
 		if (netdev) {
@@ -317,7 +312,6 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->napi_id = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
@@ -358,8 +352,6 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
-	rtnl_lock();
-
 	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_set_config(napi, info);
@@ -369,8 +361,6 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
-	rtnl_unlock();
-
 	return err;
 }
 
-- 
2.48.0


