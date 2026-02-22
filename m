Return-Path: <netdev+bounces-259855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HH5VDhuImmlIcQMAu9opvQ
	(envelope-from <netdev+bounces-259855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1B16E7A9
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550CE3012EB9
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 04:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5AF86341;
	Sun, 22 Feb 2026 04:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B39125A9
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771735063; cv=none; b=Y/1Q9HGZfuTayR8JQglfj4PNV5f77vY5Um7BvOIm/Um7jRH4kOSr9rXksc+ftOHY78Fgp4cz6U0B/+HevS5hnECyYR6ROULUP8vPSI4SgSXId0PC24EFDQRbmxNGlFlDWPL2YkRC70I85NYDXY/txNrjEprNJ0oxskgrGi1We3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771735063; c=relaxed/simple;
	bh=SLfbcvQ602PxUw1dJz+WGZkjkHuTX6EO8Q2guq34LAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqB/dhSzDrdZBdZdyJXGUelH70UFNGya4SlQRq0QuhzO0GZYScTILqoYnYreA05MDcLvXkAYhr/UaY8sZN44iJC6Sc4kOhzOd5/TkWwYz0VtgplsPivWFuFFdzAQZ4ByoLxOyz0FGoj5Gr0+fJfMxy5K9U8mpf5zU+1loU0oD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1771734850t5c5fe7c6
X-QQ-Originating-IP: neTXEFuZGIOSrJdn3TKsPBTbkSR7wXHxasOILaW0mlo=
Received: from MacBook-Pro-022.xiaojukeji.com ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Feb 2026 12:34:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11151303749412042546
EX-QQ-RecipientCnt: 12
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
Date: Sun, 22 Feb 2026 12:33:56 +0800
Message-Id: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NUTz4BkILuKLP4kyli7JsCZWtF4n205yTurFJcUHvuazgLP25/Pwf5sZ
	Ewv4v46Z0pQiKreSgHMlbyySr3/gND8fqifg9SdARSKyEYJhB2sZxz4zbye7Q+W2gxeR3/a
	uhLnELXjwW6npqiLpP2YkTlW53679/2tQuTVQG20H+Ly0Y55tn8tLQzhoGMDrybNCTTXO+x
	a6P78Z7QpfYxzT7qosgGCzKpWhkXkgwdxErcWN7qn7jKcO+pt7tO0rgSNwZaOjYvTTts2+i
	D11W+Ey4lEfwsUD0iSrqUb6lM+3pNH1nqm3Jpjo//boK3mMQfWE7/WQ+VRvGgmViZ2YrnV6
	X1+UsrE2QP6fGDkrQlUnUsbdvw7SxUifDWD0ogvBowMFt8v1axHkQ3XhHvCiwsmvetOF4V9
	hbcPxbI4bd8Gr6baFmlnzaLRp1zcGe3qhD5omaaK8DLlLTz0TE8vYOXPF9Bnufy+AkF4ROe
	7S4/LIFvIt+L3s1Pl+GX2pOCsjJyNB/uvPlUiPgKwnqZeakOKXM6mswb0coybYkh4tCsObN
	WESqW2JFO1SgD9oEF8CzN19eQfDyCxcJLFQSyoG+oaMRhf9/sHJ5+BZ4MOj0jHVxVmcc4Am
	Uovn+CjRagikDoD/4bYdtASikL5HZ1V9s+svRabdNrichB5xJ6aXLq+S4Ir0BAHdN2FbOhE
	DF+HogKsHkU5kTWPCNqiEHu//hbIM4Dlg02pL219YMtB5aVNaI40+N24RIVElBFQefro4Ax
	tTF0paWsXSvcDU9sq1W9htIlCFUvd1PLdY1x+3kNTVW2+uwpfPavrCXZEndUEsL9FL6cuZq
	5sV81d6JtsTBLELrFtTGql7Zyx/T8PoT+swIZiud2IOVa7rh2g1uoO5ds7WukrPC0/0a6YC
	TDHNUAsejw9HT8TSO16YDOhFWdey7asTnjIYZptTt1yDDSEyGCL9zC3ILKTwfnlIl9rBwF6
	rJprZn5ogEDFxpCyYAlFcRCKmdmVLWfeoRS39kfcU3n+zgwlBCJEyEnHugB33yUv62YdFDg
	aXEEr6a7jkO6tdYFtk
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bamaicloud.com];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-259855-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: 21D1B16E7A9
X-Rspamd-Action: no action

Network device statistics retrieved via procfs, sysfs, and netlink
represent the combined total of core_stats + driver, hardware statistics.

However, in some scenarios, when monitoring netdev metrics, it is valuable
to clearly distinguish whether the values originate from the networking
stack's core statistics or from the driver, hardware layer. This helps
improve debugging and addressing issues.

Approaches were considered:
- commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc()").
  This allows tracking increments to core_stats and helps identify specific
  causes of changes, but not provide the total counters.
- extending rtnl_link_stats64 with new core_xxx fields.
  This would likely confuse or break existing userspace applications relying
  on this struct.
- adding a tracepoint inside dev_get_stats().
  This implementation is not simple or straightforward enough.

The solution in this patch is therefore to introduce a new dedicated function
for collecting core statistics and mark it noinline. This approach is simple,
clean, and maintainable to obtain driver, hardware statistics separately when needed.

Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/dev.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..ab8de140b128 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11824,6 +11824,29 @@ noinline void netdev_core_stats_inc(struct net_device *dev, u32 offset)
 }
 EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
 
+static noinline struct rtnl_link_stats64 *
+netdev_fetch_core_stats(struct net_device *dev, struct rtnl_link_stats64 *storage)
+{
+	const struct net_device_core_stats __percpu *p;
+	const struct net_device_core_stats *core_stats;
+	int i;
+
+	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+	p = READ_ONCE(dev->core_stats);
+	if (!p)
+		return storage;
+
+	for_each_possible_cpu(i) {
+		core_stats = per_cpu_ptr(p, i);
+		storage->rx_dropped += READ_ONCE(core_stats->rx_dropped);
+		storage->tx_dropped += READ_ONCE(core_stats->tx_dropped);
+		storage->rx_nohandler += READ_ONCE(core_stats->rx_nohandler);
+		storage->rx_otherhost_dropped += READ_ONCE(core_stats->rx_otherhost_dropped);
+	}
+
+	return storage;
+}
+
 /**
  *	dev_get_stats	- get network device statistics
  *	@dev: device to get statistics from
@@ -11838,7 +11861,6 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 					struct rtnl_link_stats64 *storage)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-	const struct net_device_core_stats __percpu *p;
 
 	/*
 	 * IPv{4,6} and udp tunnels share common stat helpers and use
@@ -11867,21 +11889,7 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 		netdev_stats_to_stats64(storage, &dev->stats);
 	}
 
-	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
-	p = READ_ONCE(dev->core_stats);
-	if (p) {
-		const struct net_device_core_stats *core_stats;
-		int i;
-
-		for_each_possible_cpu(i) {
-			core_stats = per_cpu_ptr(p, i);
-			storage->rx_dropped += READ_ONCE(core_stats->rx_dropped);
-			storage->tx_dropped += READ_ONCE(core_stats->tx_dropped);
-			storage->rx_nohandler += READ_ONCE(core_stats->rx_nohandler);
-			storage->rx_otherhost_dropped += READ_ONCE(core_stats->rx_otherhost_dropped);
-		}
-	}
-	return storage;
+	return netdev_fetch_core_stats(dev, storage);
 }
 EXPORT_SYMBOL(dev_get_stats);
 
-- 
2.34.1


