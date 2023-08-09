Return-Path: <netdev+bounces-26018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B077673E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A993B281D6E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CB1E51A;
	Wed,  9 Aug 2023 18:27:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59371DDF3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299EDC433B7;
	Wed,  9 Aug 2023 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605619;
	bh=7o1I3xoHf7DOFz1YcS0rEGtT8o9FBkN3r5UsDcKZsaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNhHJU3M0FuDzycrQiYV7FA/U9fyPbMs6JIa0e9igZLwT6cQfKWNa/DIdMpoaLZCn
	 u2v1Y/hwz1TVYGO1umc9vXxXWVDQmI2YvQnXDXLpf2YtOgpZIeZg2D8vhfqnY4jMXk
	 qBW0fsh1y3+hevOekPGNsp6EUAUPbOiUPApmQd82SH1AI6iDK8WUfBy8d4xHSbWwH+
	 pS1iFO0hjy79NUuwCvU/dotKjN5OYrBjmFE2JLJlRhauNiwaEI3yrSjSPTPMEe518E
	 D1O7UI5sEVvyqok4Y9LG/r0IDEvO3ooYF5r66rcrYk6zkjHGUkMicmTWiCUoLKsRFa
	 GKyk4s7i1HZ1A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org
Subject: [PATCH net-next 08/10] netdev-genl: use struct genl_info for reply construction
Date: Wed,  9 Aug 2023 11:26:46 -0700
Message-ID: <20230809182648.1816537-9-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
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
 net/core/netdev-genl.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 797c813c7c77..8e4e78bbd71a 100644
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
 
@@ -41,6 +41,7 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 static void
 netdev_genl_dev_notify(struct net_device *netdev, int cmd)
 {
+	GENL_INFO_NTF(info, &netdev_nl_family, cmd);
 	struct sk_buff *ntf;
 
 	if (!genl_has_listeners(&netdev_nl_family, dev_net(netdev),
@@ -51,7 +52,7 @@ netdev_genl_dev_notify(struct net_device *netdev, int cmd)
 	if (!ntf)
 		return;
 
-	if (netdev_nl_dev_fill(netdev, ntf, 0, 0, 0, cmd)) {
+	if (netdev_nl_dev_fill(netdev, ntf, &info)) {
 		nlmsg_free(ntf);
 		return;
 	}
@@ -80,8 +81,7 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
 	if (netdev)
-		err = netdev_nl_dev_fill(netdev, rsp, info->snd_portid,
-					 info->snd_seq, 0, info->genlhdr->cmd);
+		err = netdev_nl_dev_fill(netdev, rsp, info);
 	else
 		err = -ENODEV;
 
@@ -105,10 +105,7 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
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


