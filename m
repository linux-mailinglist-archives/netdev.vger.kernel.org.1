Return-Path: <netdev+bounces-76871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011C86F3B4
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 06:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4D283E9D
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940CC8F47;
	Sun,  3 Mar 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC7DaTyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED288C0A
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443460; cv=none; b=l5OXXXNZc4NXoYlspYS94wwkSZTFAPx14uizQi12N1+hef7Mi3150SEajjRNYxBh8vYZT8iWFwrUDqi+gJtlUCz73I1+mq110LgHzat8xoW5nej4Gx6FPMnhEJ7za3eW7Mg7R1428vUdxh9urQ4d9kVDSFcl2QMBBQdLLHhTEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443460; c=relaxed/simple;
	bh=I9rPy07t15ADD7d3TzEKsPQ9bCltTHRKg9dMINIHAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpxGOLqrmdB9KHpJ2X7klGJCupa5otpigJqheJTww8jg9csntXtHV3rgtXHt168lzZQK8tGgEEFD5QRsRm2iPxqZVIjVdrsWw0awJ5VEz58isjx4COx17yFIhB1bo2ASJxbOwSa7m0a2UZu/QfpSdzBhV/ndsXfGvHFViMzJ1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC7DaTyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB5CC43394;
	Sun,  3 Mar 2024 05:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443459;
	bh=I9rPy07t15ADD7d3TzEKsPQ9bCltTHRKg9dMINIHAm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kC7DaTyg6Fy857O+r815BXryi0szUrNrQeVuPyP+IHp3rD1J7LhrYTnLoDwVehaiN
	 U46TeryAhidAEZLm7VvRlWhESm6tuJExO3eeVlEpFMfRLYyuEGLaHuG/mjggKfF3fl
	 DOBH1zvA0itET2No4mG84nPHk5qEmOzs2QoYQdEPiZKO9qPbB8mIcD0H8K4OIDfVo3
	 hnhV9r4HWJJg7p25kbG03QFLli89/O12bhFoHyZS15HlxKE4LNKSl0pJX/g66XJsRf
	 Dj04m3ZJi29IKfJ31yD/hO/VE572xW4eWe8Owk5ph3Flv4EJQ2FYb0XsWjG0+qYlAS
	 9x/cLa4c3opgQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	idosch@idosch.org,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org,
	Jakub Kicinski <kuba@kernel.org>,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	hawk@kernel.org
Subject: [PATCH net-next v2 2/3] netdev: let netlink core handle -EMSGSIZE errors
Date: Sat,  2 Mar 2024 21:24:07 -0800
Message-ID: <20240303052408.310064-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303052408.310064-1-kuba@kernel.org>
References: <20240303052408.310064-1-kuba@kernel.org>
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

Reviewed-by: Eric Dumazet <edumazet@google.com>
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
2.44.0


