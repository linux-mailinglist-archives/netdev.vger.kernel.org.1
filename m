Return-Path: <netdev+bounces-307384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u7S1BU/uVWoPwQAAu9opvQ
	(envelope-from <netdev+bounces-307384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:07:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD977522E9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=CLA7hdnV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307384-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307384-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D34E3045083
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA353F4859;
	Tue, 14 Jul 2026 08:07:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F373EC2EF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:07:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016432; cv=none; b=L66sc/+7T+JZyLKhbcFgv4+qTvZuG2Kzty/GiGEJKXcsQkmta5Pl84KMPBZqz5ligsH7RNnRFMd9Qs9pgEod3CuHXctQ0qUnuukscjc0ah8UdDX8vw6EQ/vO4/26HijQVWVxosVWB1zO+BKiSTsYR/CJMoPqWy/Inc9pNsfssDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016432; c=relaxed/simple;
	bh=6kdBpx1k6n9p70P4rJHoWKJrXBC5GpU4ZYVT1bFuGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZ/hxF6b7aD/qRapZ4gBz5fyIhbyqFK7vGKheZJT/DdQ4GMZ23QcEeAkxFSfwzSGmhy9GUwAay5k6BtojRkKZsuiSFUaK4GkoEYYwv0yEcBZlup9b0QdLJAPkMtybG+unvdM6LkuMJZQTxqYlCDv9zZFGwf1M9/JeJe0JTduemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLA7hdnV; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784016416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a6nIlwR0KFfATEht8COx1N7vKEIx9+CkRnNYFhKRWYs=;
	b=CLA7hdnV+GaiVdwynuwAEqtyl5Ft3lZ1vBPRX25X0NaZXjOS694Q60lFkx42xRGinys+Mw
	VwkGAwDZI3+aeQCn6iy1GmPhID+YYD1oKtEn3qticjnvPLlf/rfg5/BaOqev/sai+zu6V4
	zGuPJvQKcJxVvXH8CmrdtzNZURsLGXg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Acs <acsjakub@amazon.de>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: hsr: clean up the slave VLAN filters when deleting a port
Date: Tue, 14 Jul 2026 16:06:36 +0800
Message-ID: <20260714080640.149654-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,nabladev.com,suse.de,gmail.com,amazon.de,nxp.com,ti.com,resnulli.us,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307384-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:lukma@nabladev.com,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:acsjakub@amazon.de,m:xiaoliang.yang_1@nxp.com,m:danishanwar@ti.com,m:m-karicheri2@ti.com,m:jiri@resnulli.us,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DD977522E9

Our internal syzkaller reported this warning:

  netdevsim netdevsim10 eth0: entered promiscuous mode
  netdevsim netdevsim10 eth1: entered promiscuous mode
  netdevsim netdevsim10 eth1 (unregistering): left promiscuous mode
  ------------[ cut here ]------------
  WARNING: drivers/net/netdevsim/netdev.c:1208 at nsim_destroy+0x276/0x6e0, CPU#3: 1/46
  Modules linked in:
  CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:1 Not tainted 7.2.0-rc2+ #286 PREEMPT
  Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: netns cleanup_net
  RIP: 0010:nsim_destroy (drivers/net/netdevsim/netdev.c:1031 drivers/net/netdevsim/netdev.c:1201)
  RSP: 0018:ffffc90000337898 EFLAGS: 00010293
  RAX: 0000000000000001 RBX: ffff8881036c8b00 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc900003378f0 R08: 0000000000000000 R09: 0000000000000000
  R10: ffffffffad4186a8 R11: ffffffffad41c3db R12: ffff8881036c9268
  R13: dffffc0000000000 R14: ffffed10206d9164 R15: 0000000000000001
  FS:  0000000000000000(0000) GS:ffff888160866000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000055bcf1a2e0c4 CR3: 0000000105376003 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
  <TASK>
  __nsim_dev_port_del (drivers/net/netdevsim/dev.c:1547)
  nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:1561 drivers/net/netdevsim/dev.c:1785)
  nsim_dev_reload_down (drivers/net/netdevsim/dev.c:1038)
  devlink_reload (net/devlink/dev.c:462)
  devlink_pernet_pre_exit (net/devlink/core.c:578)
  ops_undo_list (net/core/net_namespace.c:161 net/core/net_namespace.c:235)
  cleanup_net (net/core/net_namespace.c:706)
  process_one_work (kernel/workqueue.c:3322)
  worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  </TASK>
  ---[ end trace 0000000000000000 ]---
  netdevsim netdevsim10 eth0 (unregistering): left promiscuous mode

vlan_vids_add_by_dev() is what passes the VID filter info down to the real
device. A virtual device does no filtering itself, so it has to push the
VIDs down to its slaves. HSR already does this correctly on the add side:
hsr_ndo_vlan_rx_add_vid() calls vlan_vid_add() on each slave.

We just never clean the slaves up on delete. hsr_del_port() drops the port
and leaves the VIDs sitting on the slave, so the filter entries leak.
netdevsim keeps a bitmap of the VIDs it was told to filter and checks that
it is empty when the netdev goes away, which is what trips the warning
above.

So do the cleanup in hsr_del_port(). We follow hsr_ndo_vlan_rx_add_vid()
here: it only pushes the VIDs to HSR_PT_SLAVE_A and HSR_PT_SLAVE_B, so the
del side only touches those two as well.

Reproducer:
ip netns add ns0
ip netns exec ns0 sh -c 'echo "10 2" > /sys/bus/netdevsim/new_device'
ip netns exec ns0 ip link add hsr0 type hsr slave1 eth0 slave2 eth1
ip netns exec ns0 ip link add link hsr0 name hsr0.1 type vlan id 1
ip netns del ns0

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/hsr/hsr_slave.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f..b1baefb65c7a 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -237,6 +237,13 @@ void hsr_del_port(struct hsr_port *port)
 	list_del_rcu(&port->port_list);
 
 	if (port != master) {
+		/* Drop the VLAN ids that hsr_ndo_vlan_rx_add_vid() pushed down
+		 * to this slave. Only slave ports get them, see there.
+		 */
+		if (port->type == HSR_PT_SLAVE_A ||
+		    port->type == HSR_PT_SLAVE_B)
+			vlan_vids_del_by_dev(port->dev, master->dev);
+
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
-- 
2.43.0


