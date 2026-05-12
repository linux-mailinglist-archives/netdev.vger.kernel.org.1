Return-Path: <netdev+bounces-287084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMorJp8FA2owzwEAu9opvQ
	(envelope-from <netdev+bounces-287084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB751ED75
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36DAE3026266
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0838E8CA;
	Tue, 12 May 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hPx7PY0B"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E72F99B8;
	Tue, 12 May 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582918; cv=none; b=gUW2ARtx9nKcOKc1B6dU78VKhf+4YpHV9mWMWgV8LfiTPe0ToHkz5e48hT6XzU8XH/ZV8csttMTQmpbvohQr9PIpVzqMknaaj/r2XVlgkNG7IhxVCq1fNmGkqgc81SpYWS8CZqOGbR7wHmBmQMVKLC3kZoucMgfTC8iEgnQmYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582918; c=relaxed/simple;
	bh=mxUAmZ420X85haUIzTp19glhWGQdZTf/bXmydQ7s+/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pG0jIvvDqUZQ9QoAA3qalA18Tp8Gy9yKNNtTkn0CSfbVmTyuSPH01ZDiZt82TKnr9QTimUrcsZkC+SyPbJHPyhNDij39mcpt1KDXG7YhIS8H2fOnlJyyCSKmtlE87fTEKZWgoBy8/KU+2foFXCSzmcsH/1qvmc0HbJY/ZcyOVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hPx7PY0B; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=LesysH0/MXvQZiIFUdo6p+9o+QMWkku83rRBrC3W1pg=; b=hPx7PY0BxebRciZVujWrG+O1sK
	+48MnAoSLvQFj2KfqR8cMHccbHDFyYUo7RdyWur7nFUGYUNMROilgMTLx1VFdCKgUGblidx4EWVll
	ng7e9G0T3+h0h/++xMXlOOxTSTOvecOIZ+lx3cigKsXfjQHLHKROijIdj4x3o9MtMRTpuk3aeeoqa
	IqasY+uOrTkBggsix4/mjoFhz2M5eD3CR9Ho6XF2714BVIwujotavvmwVEwdUveJePeQFCEG86bBB
	tluJAvirlKWwhciY8jAAo2aHpQGClTErbV20j+9CYZOlHA62+qBErH1kil0RIEKyhktTX0d5GoLJY
	/l4ZxufQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkf8-002K1g-2v;
	Tue, 12 May 2026 10:48:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:36 -0700
Subject: [PATCH net-next v2 3/9] netconsole: move push_ipv6() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-3-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=leitao@debian.org;
 h=from:subject:message-id; bh=mxUAmZ420X85haUIzTp19glhWGQdZTf/bXmydQ7s+/8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrBwrxNSqorccZj9Dp1HkWwwLY42YsPJcOS
 FT+3Vk+vjWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bfmPEACv+FHlLksLvTMxFXgjiLrNFrGpumEDz+L12Exoo6CtizCmOmJgaiiwox3FjAP0LvYmXlt
 vnoJjyFXAz3l/pkg6TY/WHVFfwlvB9ZRi0KoRteoa23D65e2QSdIvJT9OGCaPU+lb2CQrMMzNL4
 TFScAedxuuAw+xha4evDm9Up0Z8myl7PRD2mwa52neb6YTakdwZ4CrxzCy3LH+gD+Fp+WiALdKf
 sF901VCk+wZxhZWUOdK8GLhf6sYkD716e64SxDSXmNYtkG+1Y6xkPV8aaLIG5DW0YM/WVJxQ+zB
 TxuswtB8qmhCP2tjEJGeblbPzdhzqdQCj4zQ8g4JnMV7mtu3D3pXWpkO967fYlaTUzY9SnP1SPZ
 IEsJe56eVMfm9fbzJwuyKTKGI8ULxAbptmnrz5z25Q+nlns0bpSdIi0Xa6yMtSuFXjce+Jg0Lf1
 6oK018KJsmCXgpQIVkw+Gsv7JLn34WnmLe4AVliheeB1561WyRC7MNFVUGEYSDc/gs1NqdSEy3g
 Kl1xZAxoQ6TBH8V/S7+kP/2uPZ6atSkJVx7mWUkh22sLdQNjbCMPCPD+fLSQ6Fu4TN3+fIfy6P5
 o5cBUMRnI+i/6mSMAPmAhWuMrJLAkDhr9DfzhFnSnRjNePBugszcLbC7QxA5PtlStxUeN5kIZBp
 Sz5XtW80MnMC4Ig==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 79EB751ED75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287084-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

push_ipv6() builds the IPv6 header for netconsole's UDP packets.
Its only caller, netpoll_send_udp(), now lives in netconsole, so
the helper can move there as a file-static function. Drop its
EXPORT_SYMBOL_GPL and remove the prototype from
include/linux/netpoll.h.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 23 +++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 24 ------------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 56f310041ebda..f805ae95ce7b1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1651,6 +1651,29 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct ipv6hdr *ip6h;
+
+	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_reset_network_header(skb);
+	ip6h = ipv6_hdr(skb);
+
+	/* ip6h->version = 6; ip6h->priority = 0; */
+	*(unsigned char *)ip6h = 0x60;
+	ip6h->flow_lbl[0] = 0;
+	ip6h->flow_lbl[1] = 0;
+	ip6h->flow_lbl[2] = 0;
+
+	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
+	ip6h->nexthdr = IPPROTO_UDP;
+	ip6h->hop_limit = 32;
+	ip6h->saddr = np->local_ip.in6;
+	ip6h->daddr = np->remote_ip.in6;
+
+	skb->protocol = htons(ETH_P_IPV6);
+}
+
 static int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 57be72bb82dc9..7f57bd0eac66d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,7 +75,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
-void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len);
 void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len);
 void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
 void push_eth(struct netpoll *np, struct sk_buff *skb);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 39209308efad0..6a10ca5eaa093 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -413,30 +413,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	struct ipv6hdr *ip6h;
-
-	skb_push(skb, sizeof(struct ipv6hdr));
-	skb_reset_network_header(skb);
-	ip6h = ipv6_hdr(skb);
-
-	/* ip6h->version = 6; ip6h->priority = 0; */
-	*(unsigned char *)ip6h = 0x60;
-	ip6h->flow_lbl[0] = 0;
-	ip6h->flow_lbl[1] = 0;
-	ip6h->flow_lbl[2] = 0;
-
-	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
-	ip6h->nexthdr = IPPROTO_UDP;
-	ip6h->hop_limit = 32;
-	ip6h->saddr = np->local_ip.in6;
-	ip6h->daddr = np->remote_ip.in6;
-
-	skb->protocol = htons(ETH_P_IPV6);
-}
-EXPORT_SYMBOL_GPL(push_ipv6);
-
 void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	static atomic_t ip_ident;

-- 
2.53.0-Meta


