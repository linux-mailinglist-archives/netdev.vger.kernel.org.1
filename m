Return-Path: <netdev+bounces-285835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHccOqXl/WkMkgAAu9opvQ
	(envelope-from <netdev+bounces-285835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 718464F7189
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41721305F552
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0DE3E5ED5;
	Fri,  8 May 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RhlfMm0u"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D23E5589;
	Fri,  8 May 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246994; cv=none; b=Ri4vZJ1a9Dv4z9U/+kAA7+BJQNrR9icaK4hbAkVrkRz243038uFsV/WVhrc++tB3u/rcf5cUUZazkBsEzC7NiEOJVwLs3mZGXz3RxKAKYAOHuvsYXq3fckcMV/ou+2TcrB8jo/NKjCSQuKexGjP7Le8bTMyBJtZnX1/MX0L1bEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246994; c=relaxed/simple;
	bh=mxUAmZ420X85haUIzTp19glhWGQdZTf/bXmydQ7s+/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/D4TQn3GEFYBfhDKvfBjoOd1fDG8Qz/DAt6uIfYR95YKEZtDdqUNgVjM6iCfk9r97nSWw9UOE6H3xIabkwA2wwY5vvFg8xB9Tc+geOHnjbCsyngcoVgajoUKsDKNC8hOLHPJOMCJL6vxdnBGWyvCu7QlWMsZf1UdfkBrG90ikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RhlfMm0u; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=LesysH0/MXvQZiIFUdo6p+9o+QMWkku83rRBrC3W1pg=; b=RhlfMm0uOCKkvOpCILnqgV8Bbv
	m2UUM3qq7WFq9VyaRlvciAOCfw5IM0HLjsDgafAXXN6YggVVNBFPxPGBGGa6jcAKLEwQJZBVT8s0u
	aYRzvYWYfvPBitZpAgP5lw/1YVCTMmxBGE8Ufrj9p5sqzqNDKnnM0UhjC9Zlxp2vsDM2Zz31bCR9L
	rG6CQ9JnoxMeX3H1yzK7U03zjsySnvQGNp6vrDzR7dQheFvLFzSXkKnS7qHm6P5gypBX9IPbTX5B2
	mXVnUaUDsX1QCIfzbKeSbtirkndMYkcwIWga8oXdzBx6UnsiPtMeTb0bPaD6LgVxhJxHs6mT4GJ4l
	tp0ZcGJw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLH0-005Ayz-2u;
	Fri, 08 May 2026 13:29:47 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:29:17 -0700
Subject: [PATCH net-next 3/8] netconsole: move push_ipv6() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-netconsole_split-v1-3-0f660e62841f@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=leitao@debian.org;
 h=from:subject:message-id; bh=mxUAmZ420X85haUIzTp19glhWGQdZTf/bXmydQ7s+/8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4Sj28l3gQeS6EGFweWHhdthXrAwdqrZ8rM
 2Da4DKgWmqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bcywD/48hwqcRSAhB9mE3htbyt0jL9IZqtjYlmtwhnNwBZSLoq6hjkknfKet4Q69RkeNMk7ARwQ
 G90JbQpUHHuvzAYW7kw3b86GDpKORoP73axVgcjqFitCSNAJsZNudkvRilmZ0X1op/AFYUxlFuK
 I3l0ll7gfO3N3ub34ce6l131eIW61//pZJA6j39cLUEpO6pB0Do9Bgdm/cAxCIc0f3aaaszblLg
 PLiYM6C4xMgx6RJqZX0W/49UfuSi05L7PbguldWLF9YE/e5f3IJuijKIVVfhNJCTZ/gscNrvngT
 HQ5BqRQ8WqvpRefv31SAxcEOIasFuVToPLo+/R4OrzwnGywl296ICnrH1R5izL0ppA2o5WPvCiu
 X6nt57I6rl72bdrK3jiX0uwCrgaxjm7rKhTe/7JjK8grYVW2bCKbbzrcbd5xC8KdDnRsxBGT6as
 PZpuAgvslGt2FeC+HuwxSDeAjbRQ2Rp7kATPqQRkDSvOfPBIyE28rnNPT6d1ysy8w/rHlOeKDEF
 MBzg3F15gTwjw617E7jNGrBqeeefmUs14bg1qWoR9zueVnV8bHKKjNhg3DdscGDuygz8AUjqEwe
 OqgVmoDVMrql1pClJqQhPfji0wfpPdapzXJHiPf8d1TA12zVGQU41XmXJ5VLokCjG/GEbKNiw+Z
 U+zQx/SZtF5PHow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 718464F7189
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
	TAGGED_FROM(0.00)[bounces-285835-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


