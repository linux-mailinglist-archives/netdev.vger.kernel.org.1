Return-Path: <netdev+bounces-76385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B9286D8C7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756A7281BBE
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F066383A5;
	Fri,  1 Mar 2024 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG6U2EVu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAD38385
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256693; cv=none; b=hi5PSM6Df3HnvMcAx809aIZLr39TQ7GbeprUoiN9yBZC8ZbwdfpB3t1tJqTjQHpfYwOWcozYlhhojjnJLK+g5hMQFAabxx0Nq7bY8v/KuOaqp4uAixXYa6WMQkBz9Z1FR93vqAoSmNctRylq6vacwwPFOL4pEa6CiD/C65rNy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256693; c=relaxed/simple;
	bh=ZE8kCGROixQFjmDHzXFrlZmJHoUUpZVn2UngoaJrBPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goVojvExNEOrntlOP9tVTQJ84QuDJqlXPgl+eVT0gPwlGFcF8QSGtkNLPaXURSzqasVmJ1tQDglEvki5RW1Bn3I79rJLSxVh8c89LBfJA1BnisRxZGckFpTZ7rbP7CFesxIahxfORK7YttXfk7kEd1XjZc9JUZYSU7Mvi5m438c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG6U2EVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247F0C433F1;
	Fri,  1 Mar 2024 01:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256692;
	bh=ZE8kCGROixQFjmDHzXFrlZmJHoUUpZVn2UngoaJrBPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jG6U2EVutgrtvB4HHcYy8bB8Uq/TjVjCAE5Zk7hJeDMKT5tUWF7L6bfhnCF2QgsBT
	 naae5FeG7Br1YHXRgLbAkWqEzOry4yfdHdau/Qyy5RnlSdhQm2gEeK7y01MnFv3QLo
	 o6vPkxxpGhq0TVWigsrfazJpk0hp6blvVCkCwMrjiSUpyxcVDCfc0ijrpj18KV3pmi
	 Wg0zomNodEgVn1eTS0RMTg/dj+/HnaxQs8JDIk84cVLGUElX9cB+psPC2YXpL3KLnT
	 hXAHou+bGpSzWyVHGLx1g8rRAyQxyHQpGfna3ywRearvw0O9OoheyOF/O1MWWV30q0
	 0IHp3VNmLFebQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	idosch@nvidia.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	hawk@kernel.org
Subject: [PATCH net-next 2/3] netdev: let netlink core handle -EMSGSIZE errors
Date: Thu, 29 Feb 2024 17:28:44 -0800
Message-ID: <20240301012845.2951053-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301012845.2951053-1-kuba@kernel.org>
References: <20240301012845.2951053-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous change added -EMSGSIZE handling to af_netlink, we don't
have to hide these errors any longer.

Theoretically the error handling changes from:
 if (err == -EMSGSIZE)
to
 if (err == -EMSGSIZE && skb->len)

everywhere, but in practice it doesn't matter.
All messages fit into NLMSG_GOODSIZE, so overflow of an empty
skb cannot happen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: amritha.nambiar@intel.com
CC: sridhar.samudrala@intel.com
CC: hawk@kernel.org
---
 net/core/netdev-genl.c    | 15 +++------------
 net/core/page_pool_user.c |  2 --
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd98936da3ae..918b109e0cf4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -152,10 +152,7 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int
@@ -287,10 +284,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int
@@ -463,10 +457,7 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rtnl_unlock();
 
-	if (err != -EMSGSIZE)
-		return err;
-
-	return skb->len;
+	return err;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 278294aca66a..3a3277ba167b 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -103,8 +103,6 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	mutex_unlock(&page_pools_lock);
 	rtnl_unlock();
 
-	if (skb->len && err == -EMSGSIZE)
-		return skb->len;
 	return err;
 }
 
-- 
2.43.2


