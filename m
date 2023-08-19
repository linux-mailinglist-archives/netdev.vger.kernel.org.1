Return-Path: <netdev+bounces-29009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A203781669
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C60281868
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1A5645;
	Sat, 19 Aug 2023 01:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DD634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4A0C433C8;
	Sat, 19 Aug 2023 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692408367;
	bh=flUmrtMNMG2DdNfuHUyFheL/epjSQBA2KZKs6pluv/c=;
	h=From:To:Cc:Subject:Date:From;
	b=Nz38tv38/DO875ePo3FPvIsza4X8ZQhTe9TobD2kG9yfYTjqk1gsGGK265/vr1aL2
	 fUY0tOj+WPVtnu0/xuhKjQcW3eot1gQs4lbBJO7KfCQpwIRGP3BmvR4r/rLXfc2PIg
	 zkX8OIGb9qUf90n2FqWHj5gNQ3OJXpML0WhWOrh0pxigUzU/XbNFysXXp0TqFJyaHv
	 0lbFjB1YIbv27Wr+xWsEJNxlWE6K78oq4kILii95y5glxBmGSl0nXzRz1dHaOojFKp
	 4KMdHWE4jlPxH0z3sKPZ63UAUvWI7Ehtba6bZgt2l4FkVW3PEBxEnkRQfHc1kTpqLo
	 nPwmNcpu039Qw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com,
	wg@grandegger.com,
	mkl@pengutronix.de,
	idosch@nvidia.com,
	lucien.xin@gmail.com,
	xemul@parallels.com,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org
Subject: [PATCH net] net: validate veth and vxcan peer ifindexes
Date: Fri, 18 Aug 2023 18:26:02 -0700
Message-ID: <20230819012602.239550-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth and vxcan need to make sure the ifindexes of the peer
are not negative, core does not validate this.

Using iproute2 with user-space-level checking removed:

Before:

  # ./ip link add index 10 type veth peer index -1
  # ip link show
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
  2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:74:b2:03 brd ff:ff:ff:ff:ff:ff
  10: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 8a:90:ff:57:6d:5d brd ff:ff:ff:ff:ff:ff
  -1: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether ae:ed:18:e6:fa:7f brd ff:ff:ff:ff:ff:ff

Now:

  $ ./ip link add index 10 type veth peer index -1
  Error: ifindex can't be negative.

This problem surfaced in net-next because an explicit WARN()
was added, the root cause is older.

Fixes: e6f8f1a739b6 ("veth: Allow to create peer link with given ifindex")
Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: wg@grandegger.com
CC: mkl@pengutronix.de
CC: idosch@nvidia.com
CC: lucien.xin@gmail.com
CC: xemul@parallels.com
CC: socketcan@hartkopp.net
CC: linux-can@vger.kernel.org
---
 drivers/net/can/vxcan.c |  7 +------
 drivers/net/veth.c      |  5 +----
 include/net/rtnetlink.h |  4 ++--
 net/core/rtnetlink.c    | 22 ++++++++++++++++++----
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 4068d962203d..98c669ad5141 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -192,12 +192,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 
 		nla_peer = data[VXCAN_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) +
-					  sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) -
-					  sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 509e901da41d..ef8eacb596f7 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1861,10 +1861,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 
 		nla_peer = data[VETH_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) + sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) - sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index d9076a7a430c..6506221c5fe3 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -190,8 +190,8 @@ int rtnl_delete_link(struct net_device *dev, u32 portid, const struct nlmsghdr *
 int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm,
 			u32 portid, const struct nlmsghdr *nlh);
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr);
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index aef25aa5cf1d..bcebdeb59163 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2268,13 +2268,27 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr)
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr)
 {
-	return nla_parse_deprecated(tb, IFLA_MAX, head, len, ifla_policy,
+	const struct ifinfomsg *ifmp;
+	const struct nlattr *attrs;
+	size_t len;
+
+	ifmp = nla_data(nla_peer);
+	attrs = nla_data(nla_peer) + sizeof(struct ifinfomsg);
+	len = nla_len(nla_peer) - sizeof(struct ifinfomsg);
+
+	if (ifmp->ifi_index < 0) {
+		NL_SET_ERR_MSG_ATTR(exterr, nla_peer,
+				    "ifindex can't be negative");
+		return -EINVAL;
+	}
+
+	return nla_parse_deprecated(tb, IFLA_MAX, attrs, len, ifla_policy,
 				    exterr);
 }
-EXPORT_SYMBOL(rtnl_nla_parse_ifla);
+EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 {
-- 
2.41.0


