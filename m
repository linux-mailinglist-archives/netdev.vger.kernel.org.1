Return-Path: <netdev+bounces-249590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA3D1B642
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC987300814F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887F329E7E;
	Tue, 13 Jan 2026 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="Q+Svfd9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+R/Y9B0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714D318BBD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339663; cv=none; b=l24zN5/IeNRKS1qU0+fIaxpy0Y/J8MzXIzmsdu9WoGap5ymvYUD+WoHB0UXZtdDVOAT4iGhNtAXFKGfirH5C3va9N3EgTBJE30dwXwrElu5vnqb/dUswXTUFhwtqFBZ4NTNS4c1LkNzUpmRxVJK3yZvIOe1HHlJMPPGjTam54KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339663; c=relaxed/simple;
	bh=i6h5jjBarw9dfN02UfIPJ5z0DSucgYLg+nFd+HstG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt0zcA9PySJFGsBH+k1z4rItBfOCw/9YSK/yeAtFfqxVHTqFkU592mcMZhiuGTFkLi4vycl9CDTJe9Y0qj0dnMJdx+eir4/76v64JXxUbs6cY/cTr2nVMB/RL5H9L62OsTcCchDVFB+FVpz+iF6wVk/yb9EFkyswierqPeg9Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=Q+Svfd9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+R/Y9B0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 53A0BEC01A7;
	Tue, 13 Jan 2026 16:27:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 16:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768339660; x=
	1768426060; bh=ORhbrN8RFG1N0IRz38eAYWtJEmzF6Z3oTSYR5Ihrnu8=; b=Q
	+Svfd9c5acOEMvuHPKe+P95TaQFCuvU0Phm7NTVrglrmA7a57bVUaHq/o01xIpS6
	cRKXFEZVQroFNUSDtyTRS5C31Y6FG1+/3kyC2YrdJm7qBMYce+0GhPUMLZhyzaLp
	odpuQ13cVyj1f3vN4kFerp/DDPxnmtZV7XJa51RR/HlRcafSsC4xen9m8hcuGbhN
	FFYZuDKgxTQxPsF6hYCmM6iCfh/Q4y3fn/VmOkvW13s9YNky379ac/5R5TL+IiG+
	91D3EZuf9UB05ItWIC6BTDmLqE5U5t8aXq0BGhe6J0MOL6gzKjPIMB0wk4FI1PCI
	Pun/Jrzc5ITwpCBUQ9IkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768339660; x=1768426060; bh=O
	RhbrN8RFG1N0IRz38eAYWtJEmzF6Z3oTSYR5Ihrnu8=; b=B+R/Y9B0TfDYzCcij
	QcnOjrPbyGG1HRUivOOfgwqyPqvf51I7FvtPiBHbzZAlAblD3VA+LUsZ5OIbn+Km
	O5zAjfh48FccLKv5aqQ/FUwjwuFaJnpvuwroLPXUp1gJsFyBTaCx2zxqZd3wXVHp
	WLKj8jdugQrGrkub9JY3CITr4IJzV/vRZ5p5BTrAEwhMgEme0AYxo1/2yWO7RNiU
	VLW7XyZ0AghEOE5N251O55a+x6mspgE8t8wps7zRe/yHfrA7ibcZOj19anBDSG2H
	gQynxUVg9ZEBF4HasvSxwxSENPES1895GV2MWwRYfTJOmNpYCPNOWWx3rqByq2ZC
	i+pJg==
X-ME-Sender: <xms:y7hmafvGsVpzuAvW9eeOECVXQnJ2UupMbg5NmxNOq2m5YPi46mn36g>
    <xme:y7hmaW25RcIy-78DwiJmCS2CQef8zVrfawuETsRBJPWe0eePi4Of-nhlKkWPyFgdR
    T_S6z7l1v4WLdGySyI3tWRxv34QzQpALtedDVnzpa9sc3yvE5M8Lw>
X-ME-Received: <xmr:y7hmafACtE_1dBIncfasgWv6qm5lz_ZZFG4s1BzoI-ka2jHswoxrqjgEXj7s_GDsXKIMf4fw1Kp5PITXd8kolJJm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:y7hmacB_9uSMI1NuW8hbXRNscWRaE9hPRA-Hj62a-cB3EGPcxfDr_g>
    <xmx:zLhmaYnvpNENbO5TQC-oKgr8X3oT1RNj7w9WDs4UmqzbyQlbNIzMlw>
    <xmx:zLhmaUhfZSBYRYeDsvlSctEJK7OZL6jm7V7p-vUZKCIae6zBoJP8oA>
    <xmx:zLhmaagkEp_Q2Re1px7ienNb27SaKXagL_F7aw1ziVMa_W_crCHVTg>
    <xmx:zLhmaUQFW9ZW9N0ZQdiX9JuR1urIc259XFnbiZfInz9JDvCc6AfyTa1l>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:27:39 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v2 01/11] net/ipv6: Introduce payload_len helpers
Date: Tue, 13 Jan 2026 23:26:45 +0200
Message-ID: <20260113212655.116122-2-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113212655.116122-1-alice.kernel@fastmail.im>
References: <20260113212655.116122-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

The next commits will transition away from using the hop-by-hop
extension header to encode packet length for BIG TCP. Add wrappers
around ip6->payload_len that return the actual value if it's non-zero,
and calculate it from skb->len if payload_len is set to zero (and a
symmetrical setter).

The new helpers are used wherever the surrounding code supports the
hop-by-hop jumbo header for BIG TCP IPv6, or the corresponding IPv4 code
uses skb_ip_totlen (e.g., in include/net/netfilter/nf_tables_ipv6.h).

No behavioral change in this commit.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 include/linux/ipv6.h                       | 20 ++++++++++++++++++++
 include/net/ipv6.h                         |  2 --
 include/net/netfilter/nf_tables_ipv6.h     |  4 ++--
 net/bridge/br_netfilter_ipv6.c             |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c |  4 ++--
 net/ipv6/ip6_input.c                       |  2 +-
 net/ipv6/ip6_offload.c                     |  7 +++----
 net/ipv6/output_core.c                     |  7 +------
 net/netfilter/ipvs/ip_vs_xmit.c            |  2 +-
 net/netfilter/nf_conntrack_ovs.c           |  2 +-
 net/netfilter/nf_log_syslog.c              |  2 +-
 net/sched/sch_cake.c                       |  2 +-
 12 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b79..9dd05743de36 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -126,6 +126,26 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
 	       skb_network_header_len(skb);
 }
 
+static inline unsigned int ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
+{
+	u32 len = ntohs(ip6->payload_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+	       len : skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);
+}
+
+static inline unsigned int skb_ipv6_payload_len(const struct sk_buff *skb)
+{
+	return ipv6_payload_len(skb, ipv6_hdr(skb));
+}
+
+#define IPV6_MAXPLEN		65535
+
+static inline void ipv6_set_payload_len(struct ipv6hdr *ip6, unsigned int len)
+{
+	ip6->payload_len = len <= IPV6_MAXPLEN ? htons(len) : 0;
+}
+
 /* 
    This structure contains results of exthdrs parsing
    as offsets from skb->nh.
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065..f65bcef57d80 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -25,8 +25,6 @@ struct ip_tunnel_info;
 
 #define SIN6_LEN_RFC2133	24
 
-#define IPV6_MAXPLEN		65535
-
 /*
  *	NextHeader field of IPv6 header
  */
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index a0633eeaec97..c53ac00bb974 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -42,7 +42,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		return -1;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
@@ -86,7 +86,7 @@ static inline int nft_set_pktinfo_ipv6_ingress(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	if (pkt_len + sizeof(*ip6h) > pkt->skb->len) {
 		idev = __in6_dev_get(nft_in(pkt));
 		__IP6_INC_STATS(nft_net(pkt), idev, IPSTATS_MIB_INTRUNCATEDPKTS);
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index e0421eaa3abc..76ce70b4e7f3 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -58,7 +58,7 @@ int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 	if (hdr->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 	if (hdr->nexthdr == NEXTHDR_HOP && nf_ip6_check_hbh_len(skb, &pkt_len))
 		goto drop;
 
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..e3fd414906a0 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -230,7 +230,7 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	if (hdr->version != 6)
 		return -1;
 
-	len = ntohs(hdr->payload_len) + sizeof(struct ipv6hdr) + nhoff;
+	len = ipv6_payload_len(skb, hdr) + sizeof(struct ipv6hdr) + nhoff;
 	if (skb->len < len)
 		return -1;
 
@@ -270,7 +270,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NF_ACCEPT;
 
-		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
 		if (pskb_trim_rcsum(skb, len))
 			return NF_ACCEPT;
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 168ec07e31cc..2bcb981c91aa 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -262,7 +262,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	skb->transport_header = skb->network_header + sizeof(*hdr);
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 
 	/* pkt_len may be zero if Jumbo payload option is present */
 	if (pkt_len || hdr->nexthdr != NEXTHDR_HOP) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a..6762ce7909c8 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -372,12 +372,11 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
 
 		iph->nexthdr = NEXTHDR_HOP;
-		iph->payload_len = 0;
-	} else {
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		iph->payload_len = htons(payload_len);
 	}
 
+	iph = (struct ipv6hdr *)(skb->data + nhoff);
+	ipv6_set_payload_len(iph, payload_len);
+
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 1c9b283a4132..cba1684a3f30 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -125,12 +125,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	int len;
-
-	len = skb->len - sizeof(struct ipv6hdr);
-	if (len > IPV6_MAXPLEN)
-		len = 0;
-	ipv6_hdr(skb)->payload_len = htons(len);
+	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
 	/* if egress device is enslaved to an L3 master device pass the
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 64c697212578..f861d116cc33 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -949,7 +949,7 @@ ip_vs_prepare_tunneled_skb(struct sk_buff *skb, int skb_af,
 		*next_protocol = IPPROTO_IPV6;
 		if (payload_len)
 			*payload_len =
-				ntohs(old_ipv6h->payload_len) +
+				ipv6_payload_len(skb, old_ipv6h) +
 				sizeof(*old_ipv6h);
 		old_dsfield = ipv6_get_dsfield(old_ipv6h);
 		*ttl = old_ipv6h->hop_limit;
diff --git a/net/netfilter/nf_conntrack_ovs.c b/net/netfilter/nf_conntrack_ovs.c
index 068e9489e1c2..a6988eeb1579 100644
--- a/net/netfilter/nf_conntrack_ovs.c
+++ b/net/netfilter/nf_conntrack_ovs.c
@@ -121,7 +121,7 @@ int nf_ct_skb_network_trim(struct sk_buff *skb, int family)
 		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
-		len = ntohs(ipv6_hdr(skb)->payload_len);
+		len = skb_ipv6_payload_len(skb);
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP) {
 			int err = nf_ip6_check_hbh_len(skb, &len);
 
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 86d5fc5d28e3..41503847d9d7 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -561,7 +561,7 @@ dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
 	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
-		       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
+		       ipv6_payload_len(skb, ih) + sizeof(struct ipv6hdr),
 		       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
 		       ih->hop_limit,
 		       (ntohl(*(__be32 *)ih) & 0x000fffff));
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index e30ef7f8ee68..8e3135eb2ea9 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1278,7 +1278,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    ipv6_addr_cmp(&ipv6h_check->daddr, &ipv6h->daddr))
 				continue;
 
-			seglen = ntohs(ipv6h_check->payload_len);
+			seglen = ipv6_payload_len(skb, ipv6h_check);
 		} else {
 			WARN_ON(1);  /* shouldn't happen */
 			continue;
-- 
2.52.0


