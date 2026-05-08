Return-Path: <netdev+bounces-285832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAsHAr/l/WkNkgAAu9opvQ
	(envelope-from <netdev+bounces-285832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601404F719F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98D7305B0A7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5F3E92AC;
	Fri,  8 May 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rm8gwQoo"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05A3DCD80;
	Fri,  8 May 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246991; cv=none; b=GA0Wb4FiUNArsmWUX6iYntL70E/CVA9Crr+zoCSfhdb/h+3Gyt6hJtpHM0VfNBSlCRuyPfzv0sbFpiNlnAtrsRoZcVlZfAxL3o+TpKaPOudc532zxHN+qe/GNne/ZoOKFPsyV3gyaWVALWTHHakfeUu/iS/nrSKXPkDeKZBE47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246991; c=relaxed/simple;
	bh=g51YoIxKxK7pAG4HD08tG6mrbm89uoSU90lVR64Mqdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=El5MyPLJJR9UKqWfWMr0XSunfZeImhnE7ocKJeouvSVBq8KPm7Ba1eCnZZs442Bgj4/oGBffYsZuhZOxUqbTa8uq7OX6tUOQ6fnBq91SZlobG+7uboEKaZlL9MsQseX57UbaWETqpt63kGKdyNIgWyPZMjE4o9mHD9FdQGVuljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rm8gwQoo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=kCBhypCSxo5qvVndamNwauiU6sS5fgJGsBY2nx0+uIo=; b=rm8gwQooZ1XkDo2DyDI/TxM9BI
	QS0JQWP58PJoQpoL95rhDEyMI0o4egvbIuQeR2LEpR//BVzEQtI5HaI9jBZJJVSDZBb8fPGq2LMZt
	s8JQrKD6IwvaJdTN6GdfkI8fcFjCYykzhu7Nj4v5tu++cM+AJ2CvSff10Q7QSzLCgxpOD7B/n6ygd
	vJC6KLzhmQiej2OuHm8/zzDFsLwddIYFjnp6tOaZVxRgq7PLbWXnKFKmvF6HC6UXH5/QDDgem0m2q
	mVcQICGVuN9uZcizAap4IQ0/iCdxrhWm+Xwupr2y6pJlfjq8rogg2Xxi6HVv9nZKLhJ/ItDBNrEdr
	9x5XxayA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLGw-005Ayr-1T;
	Fri, 08 May 2026 13:29:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:16 -0700
Subject: [PATCH net-next 2/8] netconsole: move netpoll_send_udp() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-2-0f660e62841f@debian.org>
References: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
In-Reply-To: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=leitao@debian.org;
 h=from:subject:message-id; bh=g51YoIxKxK7pAG4HD08tG6mrbm89uoSU90lVR64Mqdc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4cIwx4IvWvPORIAEptPk1PDaGlPsd9KIew
 FOWaBfTbXiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bYlbEACEGwumathcAKqiKTcPm1ALRN8OfvAbSs7+Bhg5ywgm3AuPsm3k13mKCSOfcG9IHQoyU7s
 S0FLE8aNgtep40LZO1uKGYVHE3ZwrmrE/86mbsMn3RVGZ+bYi/+mq1HK0gYzPebrZtPLV6sIhkp
 uc6vzLH7LA4bxZWa6WyAOeMRvanQNIt7lU0TbgN94QGaq5ZZ28CvjajgNX5RoDyCk21pHhmjz6F
 zXOsOTXggbt7Ecj+lhL4sGAXJpLZzloiBioCqy26y65uMA4eiuOTzX5COEUaM4oTD0Wk+aE2EGI
 U11jQs0hYx0qCya7wpyhEYN8weE/jEGjhjD1DZmoY6EqClxm6mzqGZngLESIj1cKpQol/nWZ55g
 SKV4mGZqJQObqi444HJ5KJzFXocpArQy/MaiKgN+EDpe+Ycf/jlM9m3JUJvibgJ3v6e/tYheHaF
 yIxpFrSfxDbKYX5E5xuUzrt3ak34URRuwSfRLV67GPiZZaRnqLSDXKba8GSPxG20KFkSxMqeFtQ
 gi7vtVtn1DOrRwl1/GurdUkqfoOjXB+QMt2TQp5FnylPO8qc/wEvb6EkToN02QvBAf1nMI198ro
 qEAkKfL8wx1CdVQNG/FE23VNTl2RKyEswhMWAz6A13IoiY9h7ZXN34slF20uOFx6YaKBasBN3SH
 7YtXfTr8tHBClpQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 601404F719F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285832-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Move netpoll_send_udp() from net/core/netpoll.c into
drivers/net/netconsole.c as a static helper, drop EXPORT_SYMBOL(),
and remove the prototype from include/linux/netpoll.h.

netconsole was the only in-tree caller of this entry point. Every
other netpoll consumer (bonding, team, vlan, bridge, macvlan, dsa)
already builds its own sk_buff and hands it to netpoll_send_skb(),
so the netpoll send-side interface is now skb-only.

The helpers it depends on (find_skb(), push_ipv6(), push_ipv4(),
push_udp(), push_eth(), netpoll_udp_checksum()) were exposed in
the previous patches and stay in net/core/netpoll.c for now.
Subsequent patches move each of them into netconsole one at a time
and drop the corresponding EXPORT_SYMBOL_GPL.

Pull <linux/ip.h>, <linux/ipv6.h> and <linux/udp.h> into netconsole.c
so the moved code can name the header structures.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 37 -------------------------------------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 57dd6821a8aa9..56f310041ebda 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -32,6 +32,9 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
 #include <linux/netpoll.h>
 #include <linux/inet.h>
 #include <linux/configfs.h>
@@ -1648,6 +1651,41 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+{
+	int total_len, ip_len, udp_len;
+	struct sk_buff *skb;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		WARN_ON_ONCE(!irqs_disabled());
+
+	udp_len = len + sizeof(struct udphdr);
+	if (np->ipv6)
+		ip_len = udp_len + sizeof(struct ipv6hdr);
+	else
+		ip_len = udp_len + sizeof(struct iphdr);
+
+	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
+
+	skb = find_skb(np, total_len + np->dev->needed_tailroom,
+		       total_len - len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_copy_to_linear_data(skb, msg, len);
+	skb_put(skb, len);
+
+	push_udp(np, skb, len);
+	if (np->ipv6)
+		push_ipv6(np, skb, len);
+	else
+		push_ipv4(np, skb, len);
+	push_eth(np, skb);
+	skb->dev = np->dev;
+
+	return (int)netpoll_send_skb(np, skb);
+}
+
 /**
  * send_udp - Wrapper for netpoll_send_udp that counts errors
  * @nt: target to send message to
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e68c80b329411..57be72bb82dc9 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -67,7 +67,6 @@ static inline void netpoll_poll_disable(struct net_device *dev) { return; }
 static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
-int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 41305056c56ff..39209308efad0 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -499,43 +499,6 @@ void push_eth(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(push_eth);
 
-int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
-{
-	int total_len, ip_len, udp_len;
-	struct sk_buff *skb;
-
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		WARN_ON_ONCE(!irqs_disabled());
-
-	udp_len = len + sizeof(struct udphdr);
-	if (np->ipv6)
-		ip_len = udp_len + sizeof(struct ipv6hdr);
-	else
-		ip_len = udp_len + sizeof(struct iphdr);
-
-	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
-
-	skb = find_skb(np, total_len + np->dev->needed_tailroom,
-		       total_len - len);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_copy_to_linear_data(skb, msg, len);
-	skb_put(skb, len);
-
-	push_udp(np, skb, len);
-	if (np->ipv6)
-		push_ipv6(np, skb, len);
-	else
-		push_ipv4(np, skb, len);
-	push_eth(np, skb);
-	skb->dev = np->dev;
-
-	return (int)netpoll_send_skb(np, skb);
-}
-EXPORT_SYMBOL(netpoll_send_udp);
-
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;

-- 
2.53.0-Meta


