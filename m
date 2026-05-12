Return-Path: <netdev+bounces-287088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMg+Hk8GA2owzwEAu9opvQ
	(envelope-from <netdev+bounces-287088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40051EE3E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C196130523D3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4938E8D0;
	Tue, 12 May 2026 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KIvBg4YD"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD838E8B4;
	Tue, 12 May 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582934; cv=none; b=uhhZW5XolANOca05jrO6Q/kFQtDVOwkmatQYHTfXg/duwhf5AMLYUZYI6kYCCgq5RIR9I9us4YI79ZIl9NzP0l6AHj/hYZyw+uinne+rXCKrRkdNWLh1lw2tNCJolKIryUqEkNU7UVcAIHPjuYYIhlVgPNM1sg1xylzvqHhx5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582934; c=relaxed/simple;
	bh=o2la3FpojMCWYm5YdfXVmSJd8P30baL8VRsdI90OtzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auYqK7N7N5H9B+mW2VRxoEqVcpAofKskSZckfgrGyYhCIb6b5g+w+S7tIu21mUsfeZ838e/CPGNE6vkDQC0XebTGD6rxNuBsAZOANRoxtGPX5IHFVTf10CgSYNVBw4WhzavIW1yqpsvQTfNbtCrtNWNBm4fM8VO89WUHc+jAPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KIvBg4YD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=vayD2/eCHc4xdo2eyVn7CS6S0o4Ml1KGLPEIuGg6um8=; b=KIvBg4YDJaIT36hlPzHeyi9K+S
	IyAvEsMwexFgJRrZT+K42QnaGWMoJgOuQvoW8kC9HgMbgtrK9fKf3VNcdiJv+U35s6oBws+gpHY96
	9KOT7K3V2Y77Q07qskrE/BO2ILJ5NAgVu/9X1unA1GG4mt/NfBU4N6zPXLW7lX9DYfsxkMhl/hjlI
	OsX75g68bZHeb78fN3qJs/r9OmoEFLS1gkrTXzijwYHzuHe10e1rrqpCc1RWaRRr8quYPE40IFCSO
	uv0nTx1Mfcr6KZr2d/779FIuuYRe8FVDADhPh8wKBICC4FHpoV9rsKKhq8C8CuSg611HgCBLX8W6Z
	K2qlw1tA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfQ-002K2o-19;
	Tue, 12 May 2026 10:48:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:40 -0700
Subject: [PATCH net-next v2 7/9] netconsole: move netpoll_udp_checksum()
 from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-7-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4352; i=leitao@debian.org;
 h=from:subject:message-id; bh=o2la3FpojMCWYm5YdfXVmSJd8P30baL8VRsdI90OtzA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVriwQkx4DHrYbKGD8tZMJcizn0ha9IOjGPH
 sTDbUuihkyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bQBVEACuYRmTygv33yiq++pCN3A727REq2jhiSEmK7cGCU+foEb44Lxi5z30ga0gyUrFJ+LEKlQ
 Q0OnmFMdx1EJg9jEbnhP/igfNgo8N8fKwD7iCQ6c9Np1Gg/KEJAVvzuIrNbPED9u2Jkpn4ldLeB
 58P65a6qmNlTOG3k0SQzviXcWqjJEHNsyNa0cz9Qapn/Sukvh81jqQ/xumJiFxvg4C6mYmQUajr
 x5ctW3E3Rzbapo6DCfp9guZSHR04pupmlufEiQI5QnHEY+TE2d7cxKlRCH8QaY7dw8M9HG5dStN
 wjxGPm0ZV8VsElL7+yokQ/My189yhOrZdnNQ7n/Xa6ng14P/GRrbgyXDUI0Rx8yG78E9ptshJke
 szhLQDMkw9i5Hmry8COJcbkjdxiPZZacdUhEbi06EF0s2i5FkhRqGfvHZLqD5DSYHudwnEjbPJG
 DKL8DP0cxQ/3jeBmWbSlgLbzd0QPwBBpwQdNfErkZgFzhsEf7HGVVcCjMrzjyo2ZpTR9xsr7pF3
 UgIcUtryY8y4m7kDKdIOGR/5D84SjY707DV3GFRp2XDFbvKT9Lk9vN8rBL3IM4jqNn7MGVs9ayl
 UebAmh+JePKhAdSUC98/THJAFxfRZWNLpBFp5zPFV2Ibamur/zozMuM6DyEDtbc7mEUj++V0B+m
 6rZk6g3jPTtz9Gw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 2D40051EE3E
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
	TAGGED_FROM(0.00)[bounces-287088-lists,netdev=lfdr.de];
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

netpoll_udp_checksum() computes the UDP checksum for netconsole's
packets. Move it into drivers/net/netconsole.c as a file-static
helper; drop its EXPORT_SYMBOL_GPL and remove the prototype from
include/linux/netpoll.h.

This was the last csum_ipv6_magic() consumer in net/core/netpoll.c,
so drop the now-stale <net/ip6_checksum.h> include there. Pull it
into netconsole.c so the moved code keeps building.

It was also the last udp_hdr() consumer in net/core/netpoll.c. The
file no longer needs anything from <net/udp.h> (the UDP socket-layer
helpers); MAX_SKB_SIZE only needs struct udphdr, which is provided
by the lighter <linux/udp.h>. Swap the include accordingly.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 26 ++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 29 +----------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e8d96e482fe05..48d2670bbdef5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -38,6 +38,7 @@
 #include <linux/netpoll.h>
 #include <linux/inet.h>
 #include <linux/unaligned.h>
+#include <net/ip6_checksum.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/hex.h>
@@ -1652,6 +1653,31 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+				 int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+	udph = udp_hdr(skb);
+
+	/* check needs to be set, since it will be consumed in csum_partial */
+	udph->check = 0;
+	if (np->ipv6)
+		udph->check = csum_ipv6_magic(&np->local_ip.in6,
+					      &np->remote_ip.in6,
+					      udp_len, IPPROTO_UDP,
+					      csum_partial(udph, udp_len, 0));
+	else
+		udph->check = csum_tcpudp_magic(np->local_ip.ip,
+						np->remote_ip.ip,
+						udp_len, IPPROTO_UDP,
+						csum_partial(udph, udp_len, 0));
+	if (udph->check == 0)
+		udph->check = CSUM_MANGLED_0;
+}
+
 static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 03a49953a3d8a..1877d42ccbccf 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
-void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 96c65625f4cbb..c148b3b68cec9 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -29,11 +29,10 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <net/tcp.h>
-#include <net/udp.h>
 #include <net/addrconf.h>
 #include <net/ndisc.h>
-#include <net/ip6_checksum.h>
 #include <trace/events/napi.h>
 #include <linux/kconfig.h>
 
@@ -369,32 +368,6 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
-void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-			  int len)
-{
-	struct udphdr *udph;
-	int udp_len;
-
-	udp_len = len + sizeof(struct udphdr);
-	udph = udp_hdr(skb);
-
-	/* check needs to be set, since it will be consumed in csum_partial */
-	udph->check = 0;
-	if (np->ipv6)
-		udph->check = csum_ipv6_magic(&np->local_ip.in6,
-					      &np->remote_ip.in6,
-					      udp_len, IPPROTO_UDP,
-					      csum_partial(udph, udp_len, 0));
-	else
-		udph->check = csum_tcpudp_magic(np->local_ip.ip,
-						np->remote_ip.ip,
-						udp_len, IPPROTO_UDP,
-						csum_partial(udph, udp_len, 0));
-	if (udph->check == 0)
-		udph->check = CSUM_MANGLED_0;
-}
-EXPORT_SYMBOL_GPL(netpoll_udp_checksum);
-
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	unsigned long flags;

-- 
2.53.0-Meta


