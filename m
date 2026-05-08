Return-Path: <netdev+bounces-285834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGGJCMrl/WkNkgAAu9opvQ
	(envelope-from <netdev+bounces-285834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A134F71A8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 633EB306233C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BC3E8686;
	Fri,  8 May 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZSas3fhX"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB313E9585;
	Fri,  8 May 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246992; cv=none; b=B7sM9zKLbGWbI7+W60zrTxXEe6EVe7lbQm5R5u2WxmWcF6VI2lf6NEuL4e9B77SXNUWnXCo+qLGWS8BWJR3VyUlIkUgduj+neHyJh9W4vmmKzMjld3Gws3hcpE4P8XfobfySVW8rr3Z75Y/Luw2ytfPp1VevFNeg/OLlzoopT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246992; c=relaxed/simple;
	bh=07fpaNueP6L3dRf3qAgX/iGIbF3PMuZyCj3Rbbal+1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO0Owcm5FWQsKjO7knw3tHjw4Zk89DBg8vDLZViTkZxx9fv/e6fyUPjSQdZnrWBnqnogAjEyJGaGuRQeLivShpfHBQvJDssZOi2xCTLGaj0jE2SVp5ujyga0nSY+/pJe1zBcWSmTiHMo3nvujqRFPJBqoN0b0dwko9Ywz8soWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZSas3fhX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=yVdjh0Hy07tpCUlFlB396VlkTSHh7UpPORhLbR9du7k=; b=ZSas3fhXG908aNMP6bmMS53MwG
	YbdgOkq80Fe+LvYNBJI3JUGTpmMxplgeHe8L1pVXfMGFi4hbIRwmP+2+2I1KzK7sxS9/68GUKsGb8
	qbJUfeQySPHB6JT4WnjTQ4gs/ViMqvM7JoCG15uMBWq/+P6px+6dbX7HmnWGk/lYRKNOlr/Ukc4ON
	7heVUAf72POGUs6TM54RCA1bMbS4loX1P7JWw4bwD28bhqam9t7dkHPvlgD4yhRNKT9YyFtdh8mwm
	RXAlI7myLxLrfSh0xwbBIOXcak6zem2nrlte6UA2Og5nAKhoM9Etr4WdoIu8q/xNBQSlajz7dfsRy
	bEkbHWCA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLGr-005AyM-2q;
	Fri, 08 May 2026 13:29:38 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:15 -0700
Subject: [PATCH net-next 1/8] netpoll: expose UDP packet builder helpers
 for netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-1-0f660e62841f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=leitao@debian.org;
 h=from:subject:message-id; bh=07fpaNueP6L3dRf3qAgX/iGIbF3PMuZyCj3Rbbal+1s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU47sGMolPJNBSSBobjrnMcdaXOpGp7LLDl5
 +sPwMIo+cSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bcBbD/9gdHWhs269033hwtj66YQM6yjYXRhfDJkgzKujiEUP92Z2xBUsdUNYPj9gTOgxRxTsrkw
 +uSvCUusHbuBemnYUvvOD+noWtrivHHBkFGafpGIBXa7RZF1MThVyFLYkLH9YOVMfM9upNAn7YK
 nOXVyLY2XYIdzNF5Pfsltlsp54eg1piNfzUxP0C489ucTniPx2u84LgKloj4+7s9792fxCFNiJ8
 eYxrH2aMnAMW84wtYvDlXiPeAXaUQY53FAXFynVPbSSmEmXYx2k30h/U3zZ/2nUopDVufhw86U7
 OiiZOR2Iq9g2lKt7l6ZqDJIFe/otEvKbV6txf3EYpcYKZ6OhM465y0BtWE+Z5GIxk9THjomakYL
 4yn2L2EIln/XcVHmWy17hgRVABNz8WduGZYtGeppNA4xi6JllKswhmicX8Tru3g/dMKtqAqPaXu
 8t7fJGbCTOjmkoMbAAdVVRCGU7XqrPJXGLyJ7hlOAp8TrlhwNiyttrVmhtZFzM4BqiZcyYZleBZ
 Ded7Y/KMDy51l52+v6nfa8jVS/DeLx70oy4fyw3mpDvCHWOxLGhCNKIeL/jwuZUl17XCgPHYoL9
 Zxnrd2oiQbgMgwyScnnwiUhZeFSaYB1k4mR6mYHBEBJaQ7t8CwUnql+EB2stERfJKt3mahB4rhe
 tQWv+hkiNDykARw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 83A134F71A8
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
	TAGGED_FROM(0.00)[bounces-285834-lists,netdev=lfdr.de];
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

Promote each from file-static to EXPORT_SYMBOL_GPL and forward-
declare them in include/linux/netpoll.h so netconsole can call
them once netpoll_send_udp() moves out.

These exports are kept until the end of the series, when
al of them move into netconsole.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  6 ++++++
 net/core/netpoll.c      | 20 +++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f22eec4660405..e68c80b329411 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,6 +74,12 @@ void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
+void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len);
+void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len);
+void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
+void push_eth(struct netpoll *np, struct sk_buff *skb);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 84faace50ac28..41305056c56ff 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -268,7 +268,7 @@ static void zap_completion_queue(void)
 	put_cpu_var(softnet_data);
 }
 
-static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {
 	int count = 0;
 	struct sk_buff *skb;
@@ -294,6 +294,7 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	skb_reserve(skb, reserve);
 	return skb;
 }
+EXPORT_SYMBOL_GPL(find_skb);
 
 static int netpoll_owner_active(struct net_device *dev)
 {
@@ -369,8 +370,8 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	return ret;
 }
 
-static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-				 int len)
+void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
+			  int len)
 {
 	struct udphdr *udph;
 	int udp_len;
@@ -393,6 +394,7 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 	if (udph->check == 0)
 		udph->check = CSUM_MANGLED_0;
 }
+EXPORT_SYMBOL_GPL(netpoll_udp_checksum);
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
@@ -411,7 +413,7 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct ipv6hdr *ip6h;
 
@@ -433,8 +435,9 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 
 	skb->protocol = htons(ETH_P_IPV6);
 }
+EXPORT_SYMBOL_GPL(push_ipv6);
 
-static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	static atomic_t ip_ident;
 	struct iphdr *iph;
@@ -460,8 +463,9 @@ static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
 	skb->protocol = htons(ETH_P_IP);
 }
+EXPORT_SYMBOL_GPL(push_ipv4);
 
-static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;
 	int udp_len;
@@ -478,8 +482,9 @@ static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
 
 	netpoll_udp_checksum(np, skb, len);
 }
+EXPORT_SYMBOL_GPL(push_udp);
 
-static void push_eth(struct netpoll *np, struct sk_buff *skb)
+void push_eth(struct netpoll *np, struct sk_buff *skb)
 {
 	struct ethhdr *eth;
 
@@ -492,6 +497,7 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 	else
 		eth->h_proto = htons(ETH_P_IP);
 }
+EXPORT_SYMBOL_GPL(push_eth);
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {

-- 
2.53.0-Meta


