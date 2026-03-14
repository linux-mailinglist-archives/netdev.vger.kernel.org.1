Return-Path: <netdev+bounces-267674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC9TC/n+tGkzvQAAu9opvQ
	(envelope-from <netdev+bounces-267674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 07:23:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C865B28BDD6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 07:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCD9D304708D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7E23B61E;
	Sat, 14 Mar 2026 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFwM3cJl"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51921CA03
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773469418; cv=none; b=UWIEfMnf6sIdqx77H8fB7GecX6jxH+Gy395zP3o6o7lJA1efhmmQdXuIuqCiwzkCcgX3nhryZbtpv6moCgRibVo6lO/os14wdjRv/NMQE5Z6EauB/ctbqldULnSKjeiqGQZKFtxLcmBb88ul8P9MaBJzpAMJAjD+dC9RcTBkfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773469418; c=relaxed/simple;
	bh=z8ggBXCnKyeM8/nxN9COAnO7JW4lhQmunXgN/aTEJRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKkhclFdWCsC93GYUXtNbTNEwJuRx6t5phJ6PwN/mp4V4/2SlFZxUpGXqcxd56OM41c2hJ8UIm/jHaT3nIdqvTmlEpsdLjfs7f6jb5AwgW7DECA7K/OkTg2/tRugYYYVyDmO3QwDYDeoRyNA3QWeCiMmHjxxHDrrJ3BGfGSBJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFwM3cJl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773469404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rN0YCEA2H6O9klHLUSiaeCgZiVK/Hz2n18NE0Kmx08c=;
	b=ZFwM3cJl7dkbIJXibvL/bfbKaat2rkCDnDOHpzNB3PK1p4lOS5y6CikTpXgSJCf48F3nMQ
	jeW3l4d3NRLFkdGwcPMLW0gbfb1tebxLhH4U8e7qVn4q19RffogLy9VPip1wshnsZRZg92
	+DWyApF2iKKLDghaYm11oEWqVhYT074=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] team: fix header_ops type confusion with non-Ethernet ports
Date: Sat, 14 Mar 2026 14:23:05 +0800
Message-ID: <20260314062306.212765-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267674-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: C865B28BDD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Similar to commit 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()"),
team has the same class of header_ops type confusion.

For non-Ethernet ports, team_setup_by_port() copies port_dev->header_ops
directly. When the team device later calls dev_hard_header()/dev_parse_header(),
these callbacks can run with the team net_device instead of the real lower
device, so netdev_priv(dev) is interpreted as the wrong private type and
can crash.

Fix this by introducing team header_ops wrappers for create/parse, selecting
a team port under RCU, and calling the lower device callbacks with port->dev,
so each callback always sees the correct net_device context.

Reproducer:
set -euxo pipefail
for d in t0 b0 g0 d0; do
ip link del "$d" 2>/dev/null || true
done

modprobe bonding || true
modprobe team || true
modprobe ip_gre || true
modprobe dummy || true
ip link add d0 type dummy
ip addr add 10.10.10.1/24 dev d0
ip link set d0 up
ip link add g0 type gre local 10.10.10.1
ip link add b0 type bond mode active-backup
ip link add t0 type team
ip link set g0 master b0
ip link set b0 master t0
ip link set g0 up
ip link set b0 up
ip link set t0 up

Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69b46af7.050a0220.36eb34.000e.GAE@google.com/T/
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/team/team_core.c | 61 +++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index b7282f5c9632..737bff5bf5ae 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2058,6 +2058,65 @@ static const struct ethtool_ops team_ethtool_ops = {
  * rt netlink interface
  ***********************/
 
+/* Caller must hold rcu_read_lock(). */
+static struct team_port *team_header_port_get_rcu(struct team *team, bool txable)
+{
+	struct team_port *port;
+
+	list_for_each_entry_rcu(port, &team->port_list, list) {
+		if (!txable || team_port_txable(port))
+			return port;
+	}
+
+	return NULL;
+}
+
+static int team_header_create(struct sk_buff *skb, struct net_device *team_dev,
+			      unsigned short type, const void *daddr,
+			      const void *saddr, unsigned int len)
+{
+	struct team *team = netdev_priv(team_dev);
+	const struct header_ops *port_ops;
+	struct team_port *port;
+	int ret = 0;
+
+	rcu_read_lock();
+	port = team_header_port_get_rcu(team, true);
+	if (port) {
+		port_ops = READ_ONCE(port->dev->header_ops);
+		if (port_ops && port_ops->create)
+			ret = port_ops->create(skb, port->dev,
+					       type, daddr, saddr, len);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static int team_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+{
+	struct team *team = netdev_priv(skb->dev);
+	const struct header_ops *port_ops;
+	struct team_port *port;
+	int ret = 0;
+
+	rcu_read_lock();
+	port = team_header_port_get_rcu(team, true);
+	if (!port)
+		port = team_header_port_get_rcu(team, false);
+	if (port) {
+		port_ops = READ_ONCE(port->dev->header_ops);
+		if (port_ops && port_ops->parse)
+			ret = port_ops->parse(skb, haddr);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+static const struct header_ops team_header_ops = {
+	.create		= team_header_create,
+	.parse		= team_header_parse,
+};
+
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
@@ -2066,7 +2125,7 @@ static void team_setup_by_port(struct net_device *dev,
 	if (port_dev->type == ARPHRD_ETHER)
 		dev->header_ops	= team->header_ops_cache;
 	else
-		dev->header_ops	= port_dev->header_ops;
+		dev->header_ops	= port_dev->header_ops ? &team_header_ops : NULL;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
-- 
2.43.0


