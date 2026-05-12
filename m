Return-Path: <netdev+bounces-287090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOxMG54GA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E330A51EE4D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A1DC305DF65
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0E3B961B;
	Tue, 12 May 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="giBh91f7"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309A4C77CE;
	Tue, 12 May 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582944; cv=none; b=rza/ZrmjDnAphLK0w72MHHeMAqv1HRrpW84NwMAu4MBdbOhduz/4KvDUkwVGYU6fffCuN1IaIA1nQQkgDUa0pjCTz7bn3jV0iey256Kc8uet0TgXOoJ7a8BYN0VQuzdrZ7TXonYCIqK6eDUq97HZ6eXATRapu6r7xrXZ5yRaqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582944; c=relaxed/simple;
	bh=XQvzmY4vaSa4UD/90PLNRuFbhAlYqaPSI0Ghbpbvnc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kg4DQhnvQYGoB4h6roCMks+YxcbcdrFdegXt29z24P0Ru3BsJv9jDnuUtFLrXDP0JgkzbdoCQ3RWS621JpaCaTfg95xttAkzprwAwY9abVor1dcJcWsBpR9E4sW7ncKTi3xgfdwt1ZcGitwq641bRy7VdEDkneXQio8kvr3elqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=giBh91f7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Kfq/mwsfIihE3OBSsEqceJwCjhDjYN8um9ygjxIr+B4=; b=giBh91f74FjzNDZTEBZyX1AQP+
	igmgTkoIgD5QZEuwItXbptyGM+mfwdmtC9Wopxvm0IZIqQvrazWym6dd2cC+MX4bytt3W+8pxKCUN
	JZYD/kxmW6EVVB0uuaG43Jo9mCtOwcU0b9pYj37KM8NTszk3/a6M0LPfnsf4Tew80oafFehgTanlH
	8S600lBF0/OzcShyQ/HWSnDavT9XgzP4Krfcpmtm8/tNh52einsmKzU2bt//Ye0wZgvETADd7/FAx
	92U2raLjQSqenjPLJPn4jHHdWBV1jTJOLTpPzkfHaar4lkeLTOjJ0Pj38hX2NeHXc0ct/OaxAkHCC
	qfXSM+3Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfZ-002K90-21;
	Tue, 12 May 2026 10:48:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:42 -0700
Subject: [PATCH net-next v2 9/9] netconsole: move find_skb() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-9-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4547; i=leitao@debian.org;
 h=from:subject:message-id; bh=XQvzmY4vaSa4UD/90PLNRuFbhAlYqaPSI0Ghbpbvnc4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrTh8s6njfqDyP6OeEFSh0wbkzryFKmuS7k
 Dfj1EC8ch6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bfUoD/90KoY9HvtqUdjILi/IUfoQMLiquzA7Ipgk/ZnE8xiZUYAOPPbH+QdI8NjJBXfT+KnTFHk
 +yz0EJE1PbiJXcFkm0h0OhKUijALflsJHpka6XwXrX6KMxifltwyy7oV7FCxu08wLqCGbCqQqik
 j6r+r44uXjD/Fr1rRqx6B7RWS/06Hcxv2P72wmX7cZAb6xkj3HvnSNHI2FJVwLHHV6DtYH2pChX
 dwwprpRkETfdOeQTp3YBST9CUNQ4ESiTHEZTtr4rFSZ7B21GDsZ/j13hXzlHRgMjyqZgFxDEotC
 AK945ajZjpCVqV5qmTo2aVofBjWNwxCkhXY/6xMAZFjKDajKgJkYIWpRGXSXR6AS5mIhggC+d2V
 rnJH0UnknPLGczdrRhAdaYQJdo6k2Gzf85BtrMd67ru6tb4W8xV3lDfh0SwgQzUZZ2Jrss0Orqk
 yEj1n86C+Vn4sR6sfuhikaLtNCadDVyvb+iMq/VGl7VDQfpXeeAFP1N26XXaLyyoccHVPZlHl3m
 c1LWyeppHQV4XQh0PWIu8U+c1oXsdw0JGXYbXzcdTHebIJ6jY3HiZSwAliD0LRabvw4ZvGp+C1D
 Hg7uIWt1lSfJZdIUmHSnh+c1M28FKE4NbVgV0j9INwMyf4J4s7A0SmQxItM0u+1KhdOQEh5Hd86
 tJiQzr2Rdtfzscg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: E330A51EE4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287090-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

find_skb() is the netconsole-specific entry into the netpoll skb
pool: every other netpoll consumer (bonding, team, vlan, bridge,
macvlan, dsa) builds its own sk_buff and never touches the pool.
With netpoll_send_udp() (its only caller) now living in netconsole,
find_skb() can join it.

Move find_skb() into drivers/net/netconsole.c as a file-static
helper, drop EXPORT_SYMBOL_GPL(find_skb) and remove its prototype
from include/linux/netpoll.h. find_skb() drains TX completions via
netpoll_zap_completion_queue(), which is already exported in the
NETDEV_INTERNAL namespace, so netconsole picks up
MODULE_IMPORT_NS("NETDEV_INTERNAL") to consume it.

The skb pool's lifecycle (np->skb_pool, np->refill_wq, refill_skbs(),
refill_skbs_work_handler(), skb_pool_flush()) stays in netpoll: it
is initialised in __netpoll_setup() and torn down in
__netpoll_cleanup(), both of which remain netpoll's responsibility.
The refill work queued via schedule_work(&np->refill_wq) from the
moved find_skb() runs refill_skbs_work_handler() in netpoll without
any further plumbing.

This is pure code motion: the function body is unchanged and its
sole caller (netpoll_send_udp(), already moved by an earlier patch)
keeps invoking it the same way. Pre-existing concerns about
find_skb() running from NMI/printk context (zap_completion_queue()
re-entry, skb_pool spinlocks, GFP_ATOMIC allocation, fallback skb
sizing vs. MAX_SKB_SIZE, PREEMPT_RT semantics of __kfree_skb()) are
inherited as-is and are not addressed here; they predate this
series and are out of scope. Fixing them is left for follow-up
work.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 28 ----------------------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 48d2670bbdef5..d804d44af87c8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,6 +50,7 @@
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 #define MAX_PARAM_LENGTH		256
 #define MAX_EXTRADATA_ENTRY_LEN		256
@@ -1653,6 +1654,33 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+{
+	int count = 0;
+	struct sk_buff *skb;
+
+	netpoll_zap_completion_queue();
+repeat:
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb) {
+		skb = skb_dequeue(&np->skb_pool);
+		schedule_work(&np->refill_wq);
+	}
+
+	if (!skb) {
+		if (++count < 10) {
+			netpoll_poll_dev(np->dev);
+			goto repeat;
+		}
+		return NULL;
+	}
+
+	refcount_set(&skb->users, 1);
+	skb_reserve(skb, reserve);
+	return skb;
+}
+
 static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 				 int len)
 {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f986f7486cb8c..e4b8f1f91e54b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -73,7 +73,6 @@ void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e4cda0aa4d488..33ab3d827a427 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -265,34 +265,6 @@ void netpoll_zap_completion_queue(void)
 }
 EXPORT_SYMBOL_NS_GPL(netpoll_zap_completion_queue, "NETDEV_INTERNAL");
 
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
-{
-	int count = 0;
-	struct sk_buff *skb;
-
-	netpoll_zap_completion_queue();
-repeat:
-
-	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
-
-	if (!skb) {
-		if (++count < 10) {
-			netpoll_poll_dev(np->dev);
-			goto repeat;
-		}
-		return NULL;
-	}
-
-	refcount_set(&skb->users, 1);
-	skb_reserve(skb, reserve);
-	return skb;
-}
-EXPORT_SYMBOL_GPL(find_skb);
-
 static int netpoll_owner_active(struct net_device *dev)
 {
 	struct napi_struct *napi;

-- 
2.53.0-Meta


