Return-Path: <netdev+bounces-287085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKPYC/cGA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:54:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6A51EE73
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94144302E8E7
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B744963C9;
	Tue, 12 May 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Wqo68ZF6"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA33AC0FD;
	Tue, 12 May 2026 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582920; cv=none; b=Z1Gq1HFA2J+oesGLK/3xg/RdNkut/ZpX7V1/iAEs+rLNtGpjwRWrehwDBuqnoF9Qaao/f8fuO4zDbdW1m0byEFczVONSjWU4Vz0GYXSSgrJXzlndpm8VogsoDAbbO7yiKtjWWJ+phJpeMXlgM7rN+jATVrkOwBhCO8Md6qmCgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582920; c=relaxed/simple;
	bh=cLO+HVbzM/630mHJi4qoFZSolx/5RGQx4SlxSfx1DMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaavbjYsiCYnl/FI9V355ARyyph8kszrPkH9w5XUpSUxW/wdA33XU8Re2esWfO6hIwGJuHxS4CIvPj9Nfqep0+OBb2qc08NbPj5ctg/weV2DRUpwt6cXiI3BZnn++pdEZQvHO6z91dWhoH9XbZ5urHVfDsG9XOwO3bA4OPnP0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Wqo68ZF6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NzIMdK4kCc1Qj9zvLOEZvz2a+qMp6//MJYzsoIv7p4Q=; b=Wqo68ZF6IBcHxPrQDJ7Zh3G7x1
	GfSMimyfvPyBKFFfOIikexKomtxiJHsCNbGnzWqHjHJvZswjr6Xd9kZL9uit/n/S2gf9jkoFVfGPq
	1yxy2ECfQKsQQJHYw1iZO791h/9ozMIceo6fWvOAB8QCqSMv6xq7o2jVu004QIv0Kwx+KqtxjbxQb
	+9Up3yhEGnWVvl1hVnI8JQWxGU3S0Ex3jaUF3qDZzKb2S7gCKcL4pkeXniZDrpoxTf86Jpzc8lyFJ
	zSD/z2m5MrAFVz+fQ71HX1YSKm31TjdWyyBw0i0dzBFmz/999u7qw+R5fIq4Nm0TMvdi0Oxpquj19
	/thmn8mQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfD-002K1w-0Q;
	Tue, 12 May 2026 10:48:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:37 -0700
Subject: [PATCH net-next v2 4/9] netconsole: move push_ipv4() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-4-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; i=leitao@debian.org;
 h=from:subject:message-id; bh=cLO+HVbzM/630mHJi4qoFZSolx/5RGQx4SlxSfx1DMg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrtJFMo64itpwYoOPT/42kQwswYfQRDOn+Z
 5Tofoph/meJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bcLzD/4zBgdB9CzslQqLOISaprRg99F0EAL2qEHrpwemgRnxIor1ZdZtuXTVcxf/WBhTTXjg4SW
 btSuOX7FpZGhcuzIIhsW2qw6FBNIBGLEI49H+FpJ+ld4d83T/exDTSKBTFOT4h7oi0hCOHPeCeW
 tlByO6IdMXe8lPc70MnT9aw7i/soJYkAVqZCwVW8VO3WuPVoQm4+ERqWYlApBPB/Nb5ZcWpuqGP
 YyHeEZLN8GzZA4w9pqqmJA7l30OgnyLDLZ/ioqNZktf3YRQC+n8k7Tpwh/AZFMPQQNZ8MJ3R1Rt
 DfVNszxAs/6SPY2Z2SZizm2DYHzZmptvjR6ytoaDMEU2hmw2X0PTH8mw01JGOpS9vZFTs4huvUg
 a/iyp4EnpIhJHlm5Ri7xUcqfssk78NS9Ig8Xt3PI9GucFUr1cyeAp5WZw+WNwFBEf7wbe+tLqin
 +F8R7W6idmafXIvmx4+HNL1ep4ijo7eVdtB34QKq19qMmP8JeTd5LHrVGbzIvC2/DdMOpWxoqLZ
 Zcmeh9fMfBs3x1GYokfLpVqgfMTOmEAAuQKyXjNgSffmO9+omaxapTJuz1IIy37lgz9zC0I/mMX
 6uSzxvczHWibsrdF/GSAMw2h5jDSOGCCSAIOxCtN1JA5FPqaEGtUm8qcPP35U54UU9YShyx0Cjv
 p7so/1nJjLa5YDw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 2CC6A51EE73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287085-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


