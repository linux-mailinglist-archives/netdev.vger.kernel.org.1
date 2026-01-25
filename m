Return-Path: <netdev+bounces-253176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNDYMTcqdmnjMgEAu9opvQ
	(envelope-from <netdev+bounces-253176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 15:35:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA88102C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0A7300461C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB781F3BAC;
	Sun, 25 Jan 2026 14:35:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5661EEAB
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351732; cv=none; b=NAXGHrHRDQsYlcgjqrD/x9hNKWw0tqpsPsw8VlvRjNxq7i7vdHHvK0A5VX0o6Fma6u0PIXf35BfS9zzCVlHFpQHorSfUk6nhOMwI97HwI4hEJzQ8npBTLF3s6MCqg4nr5Oj8LwciKtQDszICR8qSktMxoDHLc2SFYVQJhDa26NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351732; c=relaxed/simple;
	bh=eofHMbx37Qy+jH9e1IIxuSMExyjULMFWzPDvesK+EOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYV93LP4kwuhXGYImadPcCjVuMqBP/7fNKPTHKNjaSc1fePwj+3FAmFPgVL7lwGr20q3c2Mn7xzCxW8l6Wmv9Pqj0kwx/OesuPl37jhk6m9ll8JEPvMvAa/krutEx5G8FvgzQ6vSPYGb9AlCDSUb5js2FYip8lTjaP0UEbcMZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60PEZSf1059785;
	Sun, 25 Jan 2026 23:35:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60PEZSuL059782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 25 Jan 2026 23:35:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
Date: Sun, 25 Jan 2026 23:35:28 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering slave
To: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
 <20260125121551.GA83275@shredder>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260125121551.GA83275@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-253176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 97DA88102C
X-Rspamd-Action: no action

syzbot is reporting

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
  ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_hold include/linux/netdevice.h:4429 [inline]
       inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
       inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
       netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
       netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
       dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
       team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
       team_del_slave drivers/net/team/team_core.c:1936 [inline]
       team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
       call_netdevice_notifiers net/core/dev.c:2295 [inline]
       __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
       do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894

problem. Ido Schimmel found steps to reproduce

  ip link add name team1 type team
  ip link add name dummy1 mtu 1499 master team1 type dummy
  ip netns add ns1
  ip link set dev dummy1 netns ns1
  ip -n ns1 link del dev dummy1

and also found that the same issue was fixed in the bond driver in
commit f51048c3e07b ("bonding: avoid NETDEV_CHANGEMTU event when
unregistering slave").

Let's do similar thing for the team driver, with commit ad7c7b2172c3 ("net:
hold netdev instance lock during sysfs operations") and commit 303a8487a657
("net: s/__dev_set_mtu/__netif_set_mtu/") also applied.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/net/team/team_core.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c08a5c1bd6e4..0af2e5aa84fb 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1292,7 +1292,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 static void __team_port_change_port_removed(struct team_port *port);
 
-static int team_port_del(struct team *team, struct net_device *port_dev)
+static int team_port_del(struct team *team, struct net_device *port_dev, bool unregister)
 {
 	struct net_device *dev = team->dev;
 	struct team_port *port;
@@ -1330,7 +1330,13 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	__team_port_change_port_removed(port);
 
 	team_port_set_orig_dev_addr(port);
-	dev_set_mtu(port_dev, port->orig.mtu);
+	if (unregister) {
+		netdev_lock_ops(port_dev);
+		__netif_set_mtu(port_dev, port->orig.mtu);
+		netdev_unlock_ops(port_dev);
+	} else {
+		dev_set_mtu(port_dev, port->orig.mtu);
+	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
 	netdev_compute_master_upper_features(team->dev, true);
@@ -1634,7 +1640,7 @@ static void team_uninit(struct net_device *dev)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
-		team_port_del(team, port->dev);
+		team_port_del(team, port->dev, false);
 
 	__team_change_mode(team, NULL); /* cleanup */
 	__team_options_unregister(team, team_options, ARRAY_SIZE(team_options));
@@ -1933,7 +1939,16 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	ASSERT_RTNL();
 
-	return team_port_del(team, port_dev);
+	return team_port_del(team, port_dev, false);
+}
+
+static int team_del_slave_on_unregister(struct net_device *dev, struct net_device *port_dev)
+{
+	struct team *team = netdev_priv(dev);
+
+	ASSERT_RTNL();
+
+	return team_port_del(team, port_dev, true);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2926,7 +2941,7 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
-		team_del_slave(port->team->dev, dev);
+		team_del_slave_on_unregister(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
-- 
2.47.3



