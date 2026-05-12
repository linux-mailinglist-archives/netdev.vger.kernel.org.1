Return-Path: <netdev+bounces-287083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL1aOZoFA2owzwEAu9opvQ
	(envelope-from <netdev+bounces-287083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5A51ED6E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5021301E1CF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0A38E8BD;
	Tue, 12 May 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AW5y2Kh2"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2B384CDA;
	Tue, 12 May 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582918; cv=none; b=JjfEODs76tiGF905j1E6ZaVMsKtmk1PVNqQIEzXVPl9syk4K+l3bpDCjaFnCY9Hf21z3abOncl6dOJ6ByzDMifKWCaUGvI+r2t6op4UIXA6dLWxyMihddA5RX6mZukbue8vynTBfTnWIPyZMHO264aNVu1ZfH65uhBkeMYJdlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582918; c=relaxed/simple;
	bh=g51YoIxKxK7pAG4HD08tG6mrbm89uoSU90lVR64Mqdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqpulSXT5cOVyp6HzrQpyCUu9CmCqLWhwIhezp8zHk2Wym/1gmOC8SSKqCR5Fi9dSzsMyGf9GXW4wTepNYr/rU3+RVhFlTKvZ2iYq14zk/w9j0LpIA8ikeIvPzFbTmBqVfhvPLo4ocL/FSZlCkQb/ymbOaQhIz/abzCplmbofsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AW5y2Kh2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=kCBhypCSxo5qvVndamNwauiU6sS5fgJGsBY2nx0+uIo=; b=AW5y2Kh2IaYC+A6DSyviRzZMO3
	W7p92ht908R5ydBqA0xXKpRaF+kQK484HPWZd/aOwVT32AUEGYJNTCvlFKywPI8MNS9+v6ATr6rmt
	yW+o1ok4Yk5trqA1tqfphXKK2XMd5AEdTIf3DHLFruX4osev+IPnna28FwuAFTfcaKr0MnaAPicQB
	x2khFbcgtdXfLHMN9cHrMtNDINGcTCEyYPM46zRABeSybOyCYGb+KPhNlHdH3tEhCCcBMt4/W3LZH
	e3Sej7Yi36kduAxqpS23yaEnevu7YfFLlhbhLBXD4eHRkZqDCWsMm9cWe+5X1E4qm1tfdTVE3R507
	Pv+iA2fQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkf4-002K1P-1q;
	Tue, 12 May 2026 10:48:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:35 -0700
Subject: [PATCH net-next v2 2/9] netconsole: move netpoll_send_udp() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-2-1191d14ad66d@debian.org>
References: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
In-Reply-To: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=leitao@debian.org;
 h=from:subject:message-id; bh=g51YoIxKxK7pAG4HD08tG6mrbm89uoSU90lVR64Mqdc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrauihravVKRdjFaNJKJIeaP4MpTlNA9JNb
 GULtmiD+1yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bYwUD/9NwN0txHpu9FdmhlUxzm0uB1+C9D0Hwi77e0oBJ4fSI8/tmhilh7MHk8Ww61hzh8jtKQA
 6H/wkq/F6dqhH3j8a9Ipaz520wAo8j/kOB+aTQtOVAvPQ/UP9fwR8guHT9h5Lx01unF5gSGbtx0
 WXZcPTxrbg4ZFpSp76cgf5+KeB/8E0caRAC0T1OFvxiW/Q8cHXVxGBB+Cv/++iYW5zxSbggHNjv
 FQerag6bTL8nkPYpJovDEQkfJTrkjFqi8JGRC8T9FrmLdrRrV8fbBvgtQDYSAiHO+65FF/DBZQv
 rD9x0fX6DMhS4C7uTyOI7pHc7ylTR1p36rVkprsEJVz2iqx3VgB3C1Ta21mtq7s4mQqNTl4U0JE
 aEk6Q9QIPKJ1tpjHWO5Yy6oP4Fu82AuGID0JSZwILbaugfL/Yvex9g/BAZTbAAP2k9kMjVbngcq
 bVn+zblHyXexEg8n4QukzW65MtLby8Pj/Tv0S6s6ntF1xsMWxacMUDFM7XDK/MWyf1qstqHvUic
 +q+icc5UVsd04efQfpsSVg4TvCm/ANDmYAdIkxL+jXgfljE+ovenJ2Z30Li0QhlI84dr7Ram9ls
 TPkan98zY6gBYKaq4t8AFkAkHqk+Njapwx52/Qy6aSpwapPizd/5c+ti0ZdF9deBvccDxUsiD0t
 dFbN/ciwGaaR/kQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 8BF5A51ED6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287083-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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


