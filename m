Return-Path: <netdev+bounces-26583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D8778436
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA547281C37
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E31ADD7;
	Thu, 10 Aug 2023 23:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BB21D35
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DB2C433B6;
	Thu, 10 Aug 2023 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710734;
	bh=X1S7XDts/uA2XJ0ukmj8msO6XWpPxRJifvhKsuTtW18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEWsQr0KMvojeLBsNLD9DPMqoJSmnLuU7HzIeVzONHoQhfO1ALRazOKgaCBoFcIpl
	 52fp/k3uUANbO7lyQFXJMNDwCwUYfrq6xwkY/BW9QcIwr6Rci+PpxkSD7nUgLDf9VI
	 zPtgeQpg/9yqvRGFbTceXP/DnpJQyFVq2K48ILxW/gmTpaEdyFhbkujRvQiraOwN8l
	 obBb0k2ujo3hHgk0C7OIjNDIsXgOLUr0Qg2bYm4wlry4z71xFb5Lsovo1NiHk6lxur
	 Lu6rpA0pXF9P/JjsV2NUIZzKf20WCMgtpr33CCw2C2o9vLqZ9HAVnoPbfPe9ENGP8o
	 m2LZJ+8UBNtPg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org
Subject: [PATCH net-next v2 08/10] netdev-genl: use struct genl_info for reply construction
Date: Thu, 10 Aug 2023 16:38:43 -0700
Message-ID: <20230810233845.2318049-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810233845.2318049-1-kuba@kernel.org>
References: <20230810233845.2318049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the just added APIs to make the code simpler.

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


