Return-Path: <netdev+bounces-262104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAM+F268omkS5QQAu9opvQ
	(envelope-from <netdev+bounces-262104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 10:59:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6301C1D80
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 10:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6AB4301082B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC3396D3D;
	Sat, 28 Feb 2026 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bGC8j4P3"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F530B52B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772272745; cv=none; b=YZsPxryGcMuTJOfpW1ESG0J3RKyqdhWfvYBA+7fe6fsTI09Iml/i56YNlPPMtem+rbO6AVScscWmv/l9UF3/Djg1HYEaxFqaE2PBEqNgSXBDHTgdIFHStQTCLTperZrf4FR2OXNOtUoxlR4WCHd3SZ3A2HVa93HzRva2mdUpskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772272745; c=relaxed/simple;
	bh=vzA8zR1Rh+kk+O4FiBrJEmzGGXXO8pwciJSamK8Q6Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+7KJ3K/EIa8pvhofjxqltInG/gruKFzRoU9ztbWBbRubPOZlavF/kFmJEnbajCZLAHIUeMl0zf+ycS1QcTclivmnzcu98M40YAbU8i554lYBUP+pmxjILXNgIHhy9w+XFknrtKMlbfZx1a4N0rOMC5dRA3wh4S24mlrkmjk1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bGC8j4P3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772272742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9SoY7jE9SE7Zgb1rvcveFmCGjxukP/v+XeXbzJ4pGBo=;
	b=bGC8j4P34b9hnKk1uWbVFDOf+X7U2BocHYpxzCF7GhpjhAJRhYBDrBlWL3oc998E0X2aYR
	bhxtfPNWxDy5zaN5Mnvxq71iBa4b+p/SlTG484U0kN/7lmLWp5uFKcajv25blPGH2f57Xz
	3Jqe68nTdth4NRYdwjsKeRPyImQCw/A=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@nicira.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] bonding: fix type confusion in bond_setup_by_slave()
Date: Sat, 28 Feb 2026 17:58:53 +0800
Message-ID: <20260228095854.391093-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262104-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 7F6301C1D80
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

kernel BUG at net/core/skbuff.c:2306!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:pskb_expand_head+0xa08/0xfe0 net/core/skbuff.c:2306
RSP: 0018:ffffc90004aff760 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807e3c8780 RCX: ffffffff89593e0e
RDX: ffff88807b7c4900 RSI: ffffffff89594747 RDI: ffff88807b7c4900
RBP: 0000000000000820 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000961a63e0 R11: 0000000000000000 R12: ffff88807e3c8780
R13: 00000000961a6560 R14: dffffc0000000000 R15: 00000000961a63e0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1a0ed8df0 CR3: 000000002d816000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ipgre_header+0xdd/0x540 net/ipv4/ip_gre.c:900
 dev_hard_header include/linux/netdevice.h:3439 [inline]
 packet_snd net/packet/af_packet.c:3028 [inline]
 packet_sendmsg+0x3ae5/0x53c0 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa54/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
 __sys_sendmsg+0x170/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1a0e6c1a9

When a device (e.g. GRE tunnel) is enslaved to a bond,
bond_setup_by_slave() directly copies the slave's header_ops to the
bond device:

    bond_dev->header_ops = slave_dev->header_ops;

This causes a type confusion when dev_hard_header() is later called
on the bond device. Functions like ipgre_header(), ip6gre_header(),
vlan_dev_hard_header(), and macvlan_hard_header() all use
netdev_priv(dev) to access their device-specific private data. When
called with the bond device, netdev_priv() returns the bond's private
data (struct bonding) instead of the expected type (e.g. struct
ip_tunnel), leading to garbage values being read and kernel crashes.

Fix this by introducing bond_header_ops with wrapper functions that
delegate to the active slave's header_ops using the slave's own
device. This ensures netdev_priv() in the slave's header functions
always receives the correct device.

The fix is placed in the bonding driver rather than individual device
drivers, as the root cause is bond blindly inheriting header_ops from
the slave without considering that these callbacks expect a specific
netdev_priv() layout.

The type confusion can be observed by adding a printk in
ipgre_header() and running the following commands:

    ip link add dummy0 type dummy
    ip addr add 10.0.0.1/24 dev dummy0
    ip link set dummy0 up
    ip link add gre1 type gre local 10.0.0.1
    ip link add bond1 type bond mode active-backup
    ip link set gre1 master bond1
    ip link set gre1 up
    ip link set bond1 up
    ip addr add fe80::1/64 dev bond1

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0ccf928eecde..e1d1e3b49cb9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1509,6 +1509,44 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
+			      unsigned short type, const void *daddr,
+			      const void *saddr, unsigned int len)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave && slave->dev->header_ops &&
+	    slave->dev->header_ops->create)
+		ret = slave->dev->header_ops->create(skb, slave->dev,
+						     type, daddr, saddr, len);
+	rcu_read_unlock();
+	return ret;
+}
+
+static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+{
+	struct bonding *bond = netdev_priv(skb->dev);
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave && slave->dev->header_ops &&
+	    slave->dev->header_ops->parse)
+		ret = slave->dev->header_ops->parse(skb, haddr);
+	rcu_read_unlock();
+	return ret;
+}
+
+static const struct header_ops bond_header_ops = {
+	.create	= bond_header_create,
+	.parse	= bond_header_parse,
+};
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -1516,7 +1554,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	dev_close(bond_dev);
 
-	bond_dev->header_ops	    = slave_dev->header_ops;
+	bond_dev->header_ops	    = slave_dev->header_ops ?
+				      &bond_header_ops : NULL;
 
 	bond_dev->type		    = slave_dev->type;
 	bond_dev->hard_header_len   = slave_dev->hard_header_len;
-- 
2.43.0


