Return-Path: <netdev+bounces-264621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM0CK+A4qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716D21A846
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B13F303FAAA
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0EB2C237C;
	Fri,  6 Mar 2026 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rcj8e1sD"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A21E5207
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763353; cv=none; b=inx4zsrbbsyHAOQ5TSoMypzhw5FGhtyFh5/HZa+FmM+ym5iFEwSdxxjxMAohu9NmKTlavty/w36WgR1RTzNaiOtnKTYw8g+quwy1ryzhLyXGaZ8G21jHzV0ygNElKRTttcmD6gPl+NEjjmMbOQm+56i2xDOwCd/JVMkz0WJwA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763353; c=relaxed/simple;
	bh=3wOu9Lrzu/ayX/TbWhI4zK8rhNGMK5S6VLgroC74RnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPAZyOnBzKZoizMT8RErKCGh4TeOKYd/knF2Se4VOTzr8VE5O0h2U1vbITaNR5la6GY4DWMVFekL1E5BzTei1eQuiNp8bNsT22s1IPmspJC9TBuGReXi4gXbYTZ9wYN356X+kKMcCUH7xWg0HLHXMpoNBfBI7lhLneHMTwNQZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rcj8e1sD; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772763340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kmjbKIvizcW4KJUTP3aVBJ823MlE9mFeFXUyN2+VY/w=;
	b=Rcj8e1sDS06/EHLSYqu8IYd7TGD4X4hAkENTGkB69mU6n8pKW3CuZsYEm1aPqdCep9cyNA
	a1x/eZwgEs9mPKulquPstxnjpdSyv3KhJr018lQgINwaF0XgTHfkWNZAJLaTuuJKGWq7gg
	+7dhnlweeYbKmYIqDA67t0ApvX0A8oY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	jv@jvosburgh.net
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] bonding: fix type confusion in bond_setup_by_slave()
Date: Fri,  6 Mar 2026 10:15:07 +0800
Message-ID: <20260306021508.222062-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1716D21A846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264621-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,jvosburgh.net:email]
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

When a non-Ethernet device (e.g. GRE tunnel) is enslaved to a bond,
bond_setup_by_slave() directly copies the slave's header_ops to the
bond device:

    bond_dev->header_ops = slave_dev->header_ops;

This causes a type confusion when dev_hard_header() is later called
on the bond device. Functions like ipgre_header(), ip6gre_header(),all use
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

Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

---
v1 :
Remove wrong commit message
Add Reviewed-by tag.
https://lore.kernel.org/netdev/20260228095854.391093-1-jiayuan.chen@linux.dev/
---
 drivers/net/bonding/bond_main.c | 47 ++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0ccf928eecde..737484883fd5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1509,6 +1509,50 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
+static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
+			      unsigned short type, const void *daddr,
+			      const void *saddr, unsigned int len)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	const struct header_ops *slave_ops;
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave) {
+		slave_ops = READ_ONCE(slave->dev->header_ops);
+		if (slave_ops && slave_ops->create)
+			ret = slave_ops->create(skb, slave->dev,
+						type, daddr, saddr, len);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+{
+	struct bonding *bond = netdev_priv(skb->dev);
+	const struct header_ops *slave_ops;
+	struct slave *slave;
+	int ret = 0;
+
+	rcu_read_lock();
+	slave = rcu_dereference(bond->curr_active_slave);
+	if (slave) {
+		slave_ops = READ_ONCE(slave->dev->header_ops);
+		if (slave_ops && slave_ops->parse)
+			ret = slave_ops->parse(skb, haddr);
+	}
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
@@ -1516,7 +1560,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
 
 	dev_close(bond_dev);
 
-	bond_dev->header_ops	    = slave_dev->header_ops;
+	bond_dev->header_ops	    = slave_dev->header_ops ?
+				      &bond_header_ops : NULL;
 
 	bond_dev->type		    = slave_dev->type;
 	bond_dev->hard_header_len   = slave_dev->hard_header_len;
-- 
2.43.0


