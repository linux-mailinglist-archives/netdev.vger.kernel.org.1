Return-Path: <netdev+bounces-285836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGXIEIDl/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E24F714E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EF0230058E8
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D63E3D98;
	Fri,  8 May 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ngtZBMWo"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1A3E558C;
	Fri,  8 May 2026 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247003; cv=none; b=tAeIDuOpACU6PPS5qlkMoExayfUe9a+teSzu9idu0QDil66D1t/0ZU7qGIp0eGsFdmowbwtPMes1w7VAjQpXOOS2ALWb1Kyj4KoUpD6l95govQKfva0NXXmYV5rGK89BkuKNU0iyjgy0Om/egtJTlMGl+I+xRAdcdEnSk1tKYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247003; c=relaxed/simple;
	bh=cLO+HVbzM/630mHJi4qoFZSolx/5RGQx4SlxSfx1DMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fC3mAzRSUbZcRfILZit8g5GLAaLMmSlQA5RQxag4xCINCJ261sw5IwFl2pvrD3d+hg/wDaNG5MEXu/qAGk5XtTkJFzN6Rb+Wb02xCTTE7f+YGg0pPaUXIvfkHneIOpYRZJ4xalwg8uX3TKi7s1jYFgL2pExxWDUjafSpkJCNECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ngtZBMWo; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NzIMdK4kCc1Qj9zvLOEZvz2a+qMp6//MJYzsoIv7p4Q=; b=ngtZBMWom30HGkjAZkxWnHDQas
	deGrEW7sntHh8FxLbdkVcXqHzWZv7WCaSPtVcJmMRBivyEC5a9HdvWQqqVzbK5bSG94mP897ZLHht
	BhZM+hEdC7mziIRWADDzjyNG2QFN9fmZewiop/2OTPGWQLmWSJq66lLaHVlKRluy28APThPjuvlxH
	LU9JCttJBqnuLPVM06wXjlFjIroCMEM5fO9e80U/6U5OHi8V3fwS1gkx2whm42w9K/3cgiJTtHk4n
	hp/p8aucbpDT68fQXmoJ74gYLDh9daGbHs11hOzz2PM7+b6ttqQJWVQ0Fk+cLsYaBld8tsmq0S8ku
	xV0nTTxw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLH5-005Az5-1K;
	Fri, 08 May 2026 13:29:51 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:18 -0700
Subject: [PATCH net-next 4/8] netconsole: move push_ipv4() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-4-0f660e62841f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; i=leitao@debian.org;
 h=from:subject:message-id; bh=cLO+HVbzM/630mHJi4qoFZSolx/5RGQx4SlxSfx1DMg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4IDpVsW4ak1nC20cT4i8r04XSioEqp/XPT
 ibyMK9SSzKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bcHHD/wN0XcvmygMg/HKxlEbdrs/XKGkEc4G64dySeOqjK8U6g+HRa0aiT6CvdrrnuuOXDzSfGb
 S8ClRT/y+3Ac7agPlqqB0Md2B46o9BsuxVgBBqJThqRY6LMcbodx9ETfBLdW4Tv8hyFcIoJchfw
 MOtpiEbRFz2AR3+Vu/d0uI8MRcb9HpzcypUt37eO9I9joPDXsyFy/uluQfi3I1odvWysgFSdWVq
 g1hTq0YogO7//Fu3r9ncy8oAWqU3Yyz3oJnHqYkY5UX7wZHhacP3sIdfoNj902wBpCNffsEP88C
 Gr8azVHAmAw3/IYRya7P4XZwa9Lxpg6yDCAm9LDi5kmNQVKYBmtFHSjLeOIdz9zuzcEXUOk7g6k
 qYJ0Qyd409YqL17Li4po4bhKW8pwH8OHxWMz0glVwHv0CoLOg3sJzKXA+cB8qbyK1ktIOfqNph2
 Izgtee+tqhP2WWFOwIZWVsIUKKb4JJHtxmmu3FuX21qYLnUR00eqzkqUriTkE/2pDO7lveDWod5
 CTzP9z+wt8MFOgWuOZW0uLUdQ7LelGBDyEytcpuVcNwDZGY7X8K/n4NETi/KVp/qWY7XSdGp7en
 /oibJRg3G/eoxqSnqP4hyKFo5zVnE+9FLFPlSXrncDNfNaUQPHk7px9cIv3CbATNe5GPgWQrXxI
 5LjiCan6qzasBMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 089E24F714E
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
	TAGGED_FROM(0.00)[bounces-285836-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

push_ipv4() builds the IPv4 header for netconsole's UDP packets.
Move it into drivers/net/netconsole.c as a file-static helper; drop
its EXPORT_SYMBOL_GPL and remove the prototype from
include/linux/netpoll.h.

put_unaligned() is no longer used in net/core/netpoll.c, so drop
the now-stale <linux/unaligned.h> include from there. Pull it into
netconsole.c so the moved code keeps building.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 29 -----------------------------
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f805ae95ce7b1..84f90b53a10f7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -37,6 +37,7 @@
 #include <linux/udp.h>
 #include <linux/netpoll.h>
 #include <linux/inet.h>
+#include <linux/unaligned.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/hex.h>
@@ -1651,6 +1652,33 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	static atomic_t ip_ident;
+	struct iphdr *iph;
+	int ip_len;
+
+	ip_len = len + sizeof(struct udphdr) + sizeof(struct iphdr);
+
+	skb_push(skb, sizeof(struct iphdr));
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+
+	/* iph->version = 4; iph->ihl = 5; */
+	*(unsigned char *)iph = 0x45;
+	iph->tos = 0;
+	put_unaligned(htons(ip_len), &iph->tot_len);
+	iph->id = htons(atomic_inc_return(&ip_ident));
+	iph->frag_off = 0;
+	iph->ttl = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->check = 0;
+	put_unaligned(np->local_ip.ip, &iph->saddr);
+	put_unaligned(np->remote_ip.ip, &iph->daddr);
+	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
+	skb->protocol = htons(ETH_P_IP);
+}
+
 static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct ipv6hdr *ip6h;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 7f57bd0eac66d..1fcde9c87b8c2 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,7 +75,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
-void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len);
 void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
 void push_eth(struct netpoll *np, struct sk_buff *skb);
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 6a10ca5eaa093..030424e43bfb4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -34,7 +34,6 @@
 #include <net/addrconf.h>
 #include <net/ndisc.h>
 #include <net/ip6_checksum.h>
-#include <linux/unaligned.h>
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
@@ -413,34 +412,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	static atomic_t ip_ident;
-	struct iphdr *iph;
-	int ip_len;
-
-	ip_len = len + sizeof(struct udphdr) + sizeof(struct iphdr);
-
-	skb_push(skb, sizeof(struct iphdr));
-	skb_reset_network_header(skb);
-	iph = ip_hdr(skb);
-
-	/* iph->version = 4; iph->ihl = 5; */
-	*(unsigned char *)iph = 0x45;
-	iph->tos = 0;
-	put_unaligned(htons(ip_len), &iph->tot_len);
-	iph->id = htons(atomic_inc_return(&ip_ident));
-	iph->frag_off = 0;
-	iph->ttl = 64;
-	iph->protocol = IPPROTO_UDP;
-	iph->check = 0;
-	put_unaligned(np->local_ip.ip, &iph->saddr);
-	put_unaligned(np->remote_ip.ip, &iph->daddr);
-	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
-	skb->protocol = htons(ETH_P_IP);
-}
-EXPORT_SYMBOL_GPL(push_ipv4);
-
 void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;

-- 
2.53.0-Meta


