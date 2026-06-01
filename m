Return-Path: <netdev+bounces-293564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFpwEggjHWrKVwkAu9opvQ
	(envelope-from <netdev+bounces-293564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781261A009
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F008A3008096
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B083446A6;
	Mon,  1 Jun 2026 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WZQPCeDq"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDB3290A6;
	Mon,  1 Jun 2026 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294404; cv=none; b=flaxgoRfrxtd+JyU6xZk1YlRnFoLXzsUjRcgp6EDe9Uf31ULS54rVz0XjJt1cBlWfb5vSkKEWLdQYuitdVRme8vozJGOvBUMhlaaJjq/0A+sDKwIF7tVlzNGiRk1QoLDboLO7Fb4y9332o4YMXBB5yTLyhA6oIeLZTbq7x/nvLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294404; c=relaxed/simple;
	bh=yg0SHVRDvuAaBxVxXS7yftljL4B1huuVZ750zjjsmzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onNLKGoW+xDCCM65w8cYbbR3N0NLjYDT9ctSYygOC/F3Ezq8o1tbgIgd9aHu0ART8JLyT+Pk722mfxSa5zJezEAaKbdHGYwiO17jOQAO9LPhrLsCy1OPp282u8l2daSW3MUs8MOiTzmD3pjTKaYqka3pcfqYefiVDGxvBE/dr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WZQPCeDq; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780294400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7C8isCQQzcwceT9SG9tVWtjO5jS/K0LM337SWkbqAlk=;
	b=WZQPCeDqMreUz2Nbt4i/GGPFlTR+txOwzPmZSuYTUbeST4rxy3YR3STtxG3sTsP/8SBi/+
	pSv29YpP/MSjL4lkamrwUHukhsCPwzlrwUNdwEiePAnemm8UY3pglxRVKN4Fqzn4XyR/BQ
	4caxFomPeA6rOG3tAVI9qIADHGEwJwI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] macvlan: fix use-after-free of macvlan_port in macvlan_fill_info()
Date: Mon,  1 Jun 2026 14:13:03 +0800
Message-ID: <20260601061304.344248-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293564-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 2781261A009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This issue was reported by our internal syzkaller [1].

rtnl_link_ops->macvlan_fill_info() reads and dereferences
'port = vlan->port'.

However, when we delete the underlying physical device of a
macvlan (e.g., eth0), we traverse all child macvlan devices and call
ndo_uninit -> macvlan_uninit.

Each child goes through ndo_uninit -> macvlan_uninit, which
synchronously kfree()s the shared port once the last child is gone, but
does not clear vlan->port. The child netdevice itself is NOT freed here:
its free_netdev() is deferred to netdev_run_todo(), and a concurrent
rtnl_getlink() additionally holds a reference via netdev_hold(). So the
netdevice stays alive with a now-dangling vlan->port, which
macvlan_fill_info() later dereferences -> use-after-free.

Here, we set vlan->port = NULL after kfree(port), and then add a NULL check
in macvlan_fill_info(). Both kfree(port) and vlan->port = NULL are atomic
under the protection of the rtnl lock, so this is safe.

In macvlan_fill_info(), if port does not exist, we should simply ignore it
and not goto nla_put_failure; otherwise, it would trigger WARN_ON_ONCE(1)
in rtnl_getlink().

vlan->port has no concurrent reader either (all under rtnl_lock, the
lockless xmit path is quiesced before macvlan_uninit()), so no
READ_ONCE()/WRITE_ONCE() is needed.

Before the blamed commit, rtnl_getlink() ran __dev_get_by_index() and
rtnl_fill_ifinfo() entirely under rtnl_lock, so it could not race with
macvlan_uninit().

[1]:
'''
BUG: KASAN: slab-use-after-free in macvlan_fill_info drivers/net/macvlan.c:1740

Call Trace:
 <TASK>
 macvlan_fill_info+0x681/0x750 drivers/net/macvlan.c:1740
 rtnl_link_info_fill net/core/rtnetlink.c:905 [inline]
 rtnl_link_fill net/core/rtnetlink.c:926 [inline]
 rtnl_fill_ifinfo.isra.0+0x2ba7/0x4d70 net/core/rtnetlink.c:2185
 rtnl_getlink+0x9b7/0xfc0 net/core/rtnetlink.c:4280
 rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
 netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
 rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]

Allocated by task 5163:
 macvlan_port_create drivers/net/macvlan.c:1260 [inline]
 macvlan_common_newlink+0x45a/0x1ab0 drivers/net/macvlan.c:1498
 macvlan_newlink+0x2a/0x40 drivers/net/macvlan.c:1596
 rtnl_newlink_create net/core/rtnetlink.c:3905 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4036 [inline]
 rtnl_newlink+0xd38/0x2360 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
 netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
 rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]

Freed by task 5166:
 macvlan_port_destroy+0x3c5/0x630 drivers/net/macvlan.c:1319
 macvlan_uninit+0xf5/0x140 drivers/net/macvlan.c:977
 unregister_netdevice_many_notify+0x108f/0x2140 net/core/dev.c:12454
 unregister_netdevice_many+0x1e/0x30 net/core/dev.c:12496
 macvlan_device_event+0x477/0x880 drivers/net/macvlan.c:1856
 notifier_call_chain+0xb7/0x330 kernel/notifier.c:85
 raw_notifier_call_chain+0x32/0x50 kernel/notifier.c:453
 call_netdevice_notifiers_info+0xa7/0x100 net/core/dev.c:2249
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 unregister_netdevice_many_notify+0xde2/0x2140 net/core/dev.c:12435
 rtnl_delete_link net/core/rtnetlink.c:3593 [inline]
 rtnl_dellink+0x3db/0xaf0 net/core/rtnetlink.c:3635
 rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
 netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
 rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]
'''

Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/macvlan.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836b..4ff3a4de972e 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -975,6 +975,8 @@ static void macvlan_uninit(struct net_device *dev)
 	port->count -= 1;
 	if (!port->count)
 		macvlan_port_destroy(port->dev);
+
+	vlan->port = NULL;
 }
 
 static void macvlan_dev_get_stats64(struct net_device *dev,
@@ -1736,12 +1738,14 @@ static int macvlan_fill_info(struct sk_buff *skb,
 	}
 	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_len_req))
 		goto nla_put_failure;
-	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
-			READ_ONCE(port->bc_queue_len_used)))
-		goto nla_put_failure;
-	if (port->bc_cutoff != 1 &&
-	    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
-		goto nla_put_failure;
+	if (port) {
+		if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
+				READ_ONCE(port->bc_queue_len_used)))
+			goto nla_put_failure;
+		if (port->bc_cutoff != 1 &&
+		    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
+			goto nla_put_failure;
+	}
 	return 0;
 
 nla_put_failure:
-- 
2.43.0


