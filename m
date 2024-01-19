Return-Path: <netdev+bounces-64299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1E8322D1
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 01:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D980F28659E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 00:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD9881F;
	Fri, 19 Jan 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifAsirEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C4186F
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625942; cv=none; b=PHTFA0LdbIP5U2WQbGHMT8nSZftiSQ+w4yODPypKefn83qVJW4TqIpaP18Q5ohelA9CF1Htd228voauZdgGQVppnbuxSPVemV3NV+Vr49QiUwAjErUgKGAc7Q8IQjE/DrALKk2a5f2+q7GVJvGIJMi6brTa7KI+m07dj8EfLVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625942; c=relaxed/simple;
	bh=3BeKc4SCXRveorNYrcJGve/izTc2hF2tMBlpbV19lyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQOF7CWL5n5huoAXc+Rnpb81T6oZndS7d2k+pq1UMHrrj2kdKhgGFzLwpQm6ZpBDCWEJCQZKs1CKfnVDVZuSIkSndGjjJMMXbsPRBkH52ak4lNO2jra0M7vFi0W1MpOY0YmELJmywT+3qyosflHFBSGGS6BbcMlPmRYG6trYYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifAsirEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A7C433F1;
	Fri, 19 Jan 2024 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705625942;
	bh=3BeKc4SCXRveorNYrcJGve/izTc2hF2tMBlpbV19lyw=;
	h=From:To:Cc:Subject:Date:From;
	b=ifAsirEhd7AirahsW6jOcbNUQM9+TrVWELCY+2phtP6tcpKAygkoTiM/qZnc+R+0u
	 HD4/wIojQRcx2lQQoR6WMHU8TXOHmS6XnhSfeUBcFTV+rfryQ14cdQSUb0cP4xL1ps
	 HZ84xiu2P2AksMDBXicwsJWbi7uKPNZCllamCHgF7P7O9OUuReWJQp5V9C9AMrVDE6
	 jJ3LXzgDxFYHs4pueh7QWqQxL1CbHFBvaxQVrxBw0+/oFppsdoxmuZQQFkT82upB1H
	 D4p413B6ch9N1MKM/SUxukr3JZhUNoU9JWpoJmOoZ6CSsBDUu5DgiUZjTItWnlINP5
	 VWiG65Tx5pG2A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?=D0=9C=D0=B0=D1=80=D0=BA=20=D0=9A=D0=BE=D1=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3?= <socketpair@gmail.com>,
	daniel@iogearbox.net,
	jiri@resnulli.us,
	lucien.xin@gmail.com,
	johannes.berg@intel.com
Subject: [PATCH net] net: fix removing a namespace with conflicting altnames
Date: Thu, 18 Jan 2024 16:58:59 -0800
Message-ID: <20240119005859.3274782-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mark reports a BUG() when a net namespace is removed.

    kernel BUG at net/core/dev.c:11520!

Physical interfaces moved outside of init_net get "refunded"
to init_net when that namespace disappears. The main interface
name may get overwritten in the process if it would have
conflicted. We need to also discard all conflicting altnames.
Recent fixes addressed ensuring that altnames get moved
with the main interface, which surfaced this problem.

Reported-by: Марк Коренберг <socketpair@gmail.com>
Link: https://lore.kernel.org/all/CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTvcGp=SAEavtDg@mail.gmail.com/
Fixes: 7663d522099e ("net: check for altname conflicts when changing netdev's netns")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel@iogearbox.net
CC: jiri@resnulli.us
CC: lucien.xin@gmail.com
CC: johannes.berg@intel.com

I'll follow up with a conversion to RCU freeing in -next.
---
 net/core/dev.c | 9 +++++++++
 net/core/dev.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f01a9b858347..cb2dab0feee0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11551,6 +11551,7 @@ static struct pernet_operations __net_initdata netdev_net_ops = {
 
 static void __net_exit default_device_exit_net(struct net *net)
 {
+	struct netdev_name_node *name_node, *tmp;
 	struct net_device *dev, *aux;
 	/*
 	 * Push all migratable network devices back to the
@@ -11573,6 +11574,14 @@ static void __net_exit default_device_exit_net(struct net *net)
 		snprintf(fb_name, IFNAMSIZ, "dev%d", dev->ifindex);
 		if (netdev_name_in_use(&init_net, fb_name))
 			snprintf(fb_name, IFNAMSIZ, "dev%%d");
+
+		netdev_for_each_altname_safe(dev, name_node, tmp)
+			if (netdev_name_in_use(&init_net, name_node->name)) {
+				netdev_name_node_del(name_node);
+				synchronize_rcu();
+				__netdev_name_node_alt_destroy(name_node);
+			}
+
 		err = dev_change_net_namespace(dev, &init_net, fb_name);
 		if (err) {
 			pr_emerg("%s: failed to move %s to init_net: %d\n",
diff --git a/net/core/dev.h b/net/core/dev.h
index cf93e188785b..7480b4c84298 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -63,6 +63,9 @@ int dev_change_name(struct net_device *dev, const char *newname);
 
 #define netdev_for_each_altname(dev, namenode)				\
 	list_for_each_entry((namenode), &(dev)->name_node->list, list)
+#define netdev_for_each_altname_safe(dev, namenode, next)		\
+	list_for_each_entry_safe((namenode), (next), &(dev)->name_node->list, \
+				 list)
 
 int netdev_name_node_alt_create(struct net_device *dev, const char *name);
 int netdev_name_node_alt_destroy(struct net_device *dev, const char *name);
-- 
2.43.0


