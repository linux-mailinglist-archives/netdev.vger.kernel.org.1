Return-Path: <netdev+bounces-27513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116977C2C4
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EC61C209EF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707401078F;
	Mon, 14 Aug 2023 21:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF671094B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7323AC43391;
	Mon, 14 Aug 2023 21:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049652;
	bh=2ZZ+zUVNaZynuIWvNSKOShsAJsNtNDVDxUyi952CB8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1YCi2U5ckONFLoYJ8BCoc2mKJnSVsxJw9EbFDt8p647LlQI9mjuVFv5yERhWnzlP
	 jc7zwSQBahYTb9ixxFdzFHHl+vBVdJ8Vwls60xW7fHjQB+tANr634yxeSNVQyX7jKl
	 lARS/q8ojSnnjhT6K7cCdgRO7q1K50uqUu+/c1rb4Gu3Z/xkl34B5P4OFehWjLJF4G
	 2KPsQx7K2GbjmSb00zUCAge5+253+kEgEPcinvXovU/gJDXfhzyz+KFCMPgWfW7M9h
	 gULbZTsiCeqXxjTWN1I8HDmDkgkdkFgqktkwYVk0l6hVIXAAGhQKXe4AKZDl44bIh/
	 +i9EfiPeEnl6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	lorenzo@kernel.org
Subject: [PATCH net-next v3 08/10] netdev-genl: use struct genl_info for reply construction
Date: Mon, 14 Aug 2023 14:47:21 -0700
Message-ID: <20230814214723.2924989-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214723.2924989-1-kuba@kernel.org>
References: <20230814214723.2924989-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the just added APIs to make the code simpler.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: lorenzo@kernel.org
---
 net/core/netdev-genl.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 797c813c7c77..c1aea8b756b6 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -10,11 +10,11 @@
 
 static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
-		   u32 portid, u32 seq, int flags, u32 cmd)
+		   const struct genl_info *info)
 {
 	void *hdr;
 
-	hdr = genlmsg_put(rsp, portid, seq, &netdev_nl_family, flags, cmd);
+	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
 		return -EMSGSIZE;
 
@@ -41,17 +41,20 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 static void
 netdev_genl_dev_notify(struct net_device *netdev, int cmd)
 {
+	struct genl_info info;
 	struct sk_buff *ntf;
 
 	if (!genl_has_listeners(&netdev_nl_family, dev_net(netdev),
 				NETDEV_NLGRP_MGMT))
 		return;
 
+	genl_info_init_ntf(&info, &netdev_nl_family, cmd);
+
 	ntf = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!ntf)
 		return;
 
-	if (netdev_nl_dev_fill(netdev, ntf, 0, 0, 0, cmd)) {
+	if (netdev_nl_dev_fill(netdev, ntf, &info)) {
 		nlmsg_free(ntf);
 		return;
 	}
@@ -80,8 +83,7 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
 	if (netdev)
-		err = netdev_nl_dev_fill(netdev, rsp, info->snd_portid,
-					 info->snd_seq, 0, info->genlhdr->cmd);
+		err = netdev_nl_dev_fill(netdev, rsp, info);
 	else
 		err = -ENODEV;
 
@@ -105,10 +107,7 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	for_each_netdev_dump(net, netdev, cb->args[0]) {
-		err = netdev_nl_dev_fill(netdev, skb,
-					 NETLINK_CB(cb->skb).portid,
-					 cb->nlh->nlmsg_seq, 0,
-					 NETDEV_CMD_DEV_GET);
+		err = netdev_nl_dev_fill(netdev, skb, genl_info_dump(cb));
 		if (err < 0)
 			break;
 	}
-- 
2.41.0


