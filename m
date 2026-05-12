Return-Path: <netdev+bounces-287087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK1CATIGA2owzwEAu9opvQ
	(envelope-from <netdev+bounces-287087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:51:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542E51EE09
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39168304BF0D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76FA38E8BD;
	Tue, 12 May 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OGRBkqWm"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427238E8B4;
	Tue, 12 May 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582929; cv=none; b=kA21Kqida9gCAFYq3sDICgrJQPevyUf8VyiyPuqJ9Oedu8ozrKw00JsgmKWyVmdOIqossm87Fg9ZL3iZkw2v1R1xO813yySEzBll8lWPnhXQFRUl6ZToSYHaGX7Feut46JfFLuvFskSafA5mcKRrLYi17s1iXAth93CKhNScLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582929; c=relaxed/simple;
	bh=mRwKfnxxfVXe6omB8CCXs7tkRoeFLNGdpMOH91sc03k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sd3hHwcr7aDYUotu6Tjn7xcVDXQ+wFaVVZcoFpLLPMyqaYewhIp7lrmk0BiRAajQXUQ3+S/eQMHy82uSWm2gMaLPNsE8/iFJxgjEHWNe4Bbvwlb9yhNGSuU3BMU4H4a2ZzmGBPLNIE3QARcgbstqQl+AVpUZORHpicZ2LJCaGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OGRBkqWm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=RGd1zeSSfhBs2Ow87ossMBrvi4URY2nN5utaSeWk84g=; b=OGRBkqWm1VH0jxBdXjyn49srY8
	hiSD3DgLiIYEVCdKB+dc7CEC4wWGK819kDfyx//zGaCcFK1DyzhyA+KKEmvdFJTiD0+JeVDP/KCOr
	8eI2CDbofBTOHTlCuUF2zzDeiKuohMKGVuMShOb2fLTxlz11nsN6S4qDvItYfiUOzYI4bKNjtr6ky
	up3t0y8ty6e49JaBsuXYv7BXSWXHB3FV38jRzOW2GV0OYMLuztah7F9HGhJe7UoJf1MECxDGOTLw2
	NoYOdPaJlpQjBOtsVWGZFJACH/Zy7iVKxN6/GfrwEQcK/Fikp6jG7t5jHXAqOK+7p0Cz/6XP3i6uY
	x+9in2fQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkfL-002K2c-38;
	Tue, 12 May 2026 10:48:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 12 May 2026 03:46:39 -0700
Subject: [PATCH net-next v2 6/9] netconsole: move push_udp() from netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-netconsole_split-v2-6-1191d14ad66d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=leitao@debian.org;
 h=from:subject:message-id; bh=mRwKfnxxfVXe6omB8CCXs7tkRoeFLNGdpMOH91sc03k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVrjtgU/GPTiNfPOt4Uv4Tv1YTxYcPq9jmsQ
 dTBN5NO0aeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bb7OD/0Y0Hthcw1FeX6IwWu1Ewf/bUSH1Kpo50wNiMow7aeUIAFaZOzjucWMcu76KFnP31aaOf4
 yV7oith897zKBIwWYskSpXhTVBXhsZW85/5QibFB8SuFoW9Pl1rku4EfX7dn8N/O/9xvZR09L2t
 O1aSCPqUi5mkOLJZLjsrHXsTLj7cKwmnIDH9irtNe/jxEeloXP4qGlBVH7n67QF+4B2/2otbDAJ
 qcNVPv/fgtwRBnDPHWPA52Mb3fg+jWYVMbuR5QsIrsaAM4czTJl6vmDxvJ/ZEG2G3qCl7uXp1+D
 6ygOQ415ldRaOOjsYkr64qtlPYchL8EyjyCKJARkrJcqKelefqtyBu8aHzuuvBDk7f2+wXYMehw
 KqxRvkYNxzjJ2po/RoSqtvGA5xqMY+wiyPkpY9JlRsdpqpsXyCLYwSqLIENARLM3/uc3KkExYID
 Y28BTxdCykXovN4RvvhpDKYEVgXOcPIQ1inBLA+1Q19QzGPm76A6szDcYIf1VPf7XuDvlZ2BW/H
 JhgFlzyVetByw91q/mrA8FGGeVtBQQymLIzrkwJcLTjOXsIdCtJZm4Ng+UUCiz4MN8fcUiXKsuu
 olQJs3kHIRF0khzx3+ef8rPjQY1in95ME/y2EuPK9f6Fbz4hTMIoVLmXkvZGXeFyzwLfXKoJYYk
 LWuAOx/7P7Q3xDg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 8542E51EE09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287087-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

push_udp() builds the UDP header (and triggers the checksum) for
netconsole's UDP packets. Move it into drivers/net/netconsole.c as
a file-static helper; drop its EXPORT_SYMBOL_GPL and remove the
prototype from include/linux/netpoll.h.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 18 ++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 19 -------------------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bcedc161b13ec..e8d96e482fe05 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1652,6 +1652,24 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+
+	skb_push(skb, sizeof(struct udphdr));
+	skb_reset_transport_header(skb);
+
+	udph = udp_hdr(skb);
+	udph->source = htons(np->local_port);
+	udph->dest = htons(np->remote_port);
+	udph->len = htons(udp_len);
+
+	netpoll_udp_checksum(np, skb, len);
+}
+
 static void push_eth(struct netpoll *np, struct sk_buff *skb)
 {
 	struct ethhdr *eth;
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 11eb95b3248e2..03a49953a3d8a 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,7 +75,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb, int len);
-void push_udp(struct netpoll *np, struct sk_buff *skb, int len);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 12165667705f3..96c65625f4cbb 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -412,25 +412,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netpoll_send_skb);
 
-void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
-{
-	struct udphdr *udph;
-	int udp_len;
-
-	udp_len = len + sizeof(struct udphdr);
-
-	skb_push(skb, sizeof(struct udphdr));
-	skb_reset_transport_header(skb);
-
-	udph = udp_hdr(skb);
-	udph->source = htons(np->local_port);
-	udph->dest = htons(np->remote_port);
-	udph->len = htons(udp_len);
-
-	netpoll_udp_checksum(np, skb, len);
-}
-EXPORT_SYMBOL_GPL(push_udp);
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;

-- 
2.53.0-Meta


