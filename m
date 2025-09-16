Return-Path: <netdev+bounces-223287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA3B588E6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA8094E24F2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAB1DE8BE;
	Tue, 16 Sep 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGyCYAan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81B1DE2DC
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981178; cv=none; b=YOZtRRF2CpYYopXZiMDwg986DFZOhdEpVuzpkgpqUgH7o6bf5KQ0eWa4azcLcZzkTqnhmffJ/ci7JTdR0B5TEm4ddnCdlM9YA6ohQIGZIqBwi6MGlWVTADMvW84Vs2jau3xL5L3J/rl56JmvV4gJ6o1OiV4mYiaSVEOkCXrWNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981178; c=relaxed/simple;
	bh=G/FGrXfnncUA1ibv5tS2tnijhIAyW9uSfwNNWAijpzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJxSXLGtlkad2+54yLaxNrnE78UexdTCG7vxz1cQMvnCAqmI2orlhTkWT8pySUXYl3Aw9k0o2ULqSMRrVVOMoZC8tNIdrxkkAd3e/vb5ILPI5KWhPriz67sJ/ty/aZ9DufKEIq39a5leRDyd+1dCC7Qnn1bnoZlXhjjlXeyvCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGyCYAan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD68C4CEFC;
	Tue, 16 Sep 2025 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981177;
	bh=G/FGrXfnncUA1ibv5tS2tnijhIAyW9uSfwNNWAijpzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGyCYAanjDmO/8pa/GIoN1ocPOfq+GDaz5werqF8XuqbSIN8mGrVVCi0Ow8QRungG
	 tPmg9uqFThMz5LwajaHGhpGa//FHm3jSuksnOat5v5XnJC23NC510o2e82LrdGlT8g
	 7OdYRFVvru3w29iRd2kbWZd3A1W1BjV++DOP+7f96PLtzBH7NoGNi5ksp/97YfC/Gc
	 FZC/++yrX5pd+VDlRb2lDNUtpJ5QLV5vkE9Vx19JWEFwCU7oNd1HXOZxb1Jw4bEWAm
	 cCla9RhevMyPQ6DQLO2S/Gz5Jb8B9l+3c/HdH4OB/N4JTq2qZ6jCNwCF+qP49LAVW6
	 AgYQnIA5WO1sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Raed Salem <raeds@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 17/19] psp: provide decapsulation and receive helper for drivers
Date: Mon, 15 Sep 2025 17:05:57 -0700
Message-ID: <20250916000559.1320151-18-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Create psp_dev_rcv(), which drivers can call to psp decapsulate and attach
a psp_skb_ext to an skb.

psp_dev_rcv() only supports what the PSP architecture specification
refers to as "transport mode" packets, where the L3 header is either
IPv6 or IPv4.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v11:
    - support ipv4 in psp_dev_rcv()
    - check for psp-udp header in psp_dev_rcv()
    - check psbk_may_pull() in psp_dev_rcv()
    v4:
    - rename psp_rcv() to psp_dev_rcv()
    - add strip_icv param psp_dev_rcv() to make trailer stripping optional
    v3:
    - patch introduced
---
 include/net/psp/functions.h |  1 +
 net/psp/psp_main.c          | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 0a539e1b39f4..91ba06733321 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -19,6 +19,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 			 u8 ver, __be16 sport);
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index e026880fa1a2..b4b756f87382 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -223,6 +223,94 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 }
 EXPORT_SYMBOL(psp_dev_encapsulate);
 
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies. The caller should
+ * ensure that skb->data is pointing to the mac header, and that skb->mac_len
+ * is set.
+ */
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
+{
+	int l2_hlen = 0, l3_hlen, encap;
+	struct psp_skb_ext *pse;
+	struct psphdr *psph;
+	struct ethhdr *eth;
+	struct udphdr *uh;
+	__be16 proto;
+	bool is_udp;
+
+	eth = (struct ethhdr *)skb->data;
+	proto = __vlan_get_protocol(skb, eth->h_proto, &l2_hlen);
+	if (proto == htons(ETH_P_IP))
+		l3_hlen = sizeof(struct iphdr);
+	else if (proto == htons(ETH_P_IPV6))
+		l3_hlen = sizeof(struct ipv6hdr);
+	else
+		return -EINVAL;
+
+	if (unlikely(!pskb_may_pull(skb, l2_hlen + l3_hlen + PSP_ENCAP_HLEN)))
+		return -EINVAL;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
+
+		is_udp = iph->protocol == IPPROTO_UDP;
+		l3_hlen = iph->ihl * 4;
+		if (l3_hlen != sizeof(struct iphdr) &&
+		    !pskb_may_pull(skb, l2_hlen + l3_hlen + PSP_ENCAP_HLEN))
+			return -EINVAL;
+	} else {
+		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
+
+		is_udp = ipv6h->nexthdr == IPPROTO_UDP;
+	}
+
+	if (unlikely(!is_udp))
+		return -EINVAL;
+
+	uh = (struct udphdr *)(skb->data + l2_hlen + l3_hlen);
+	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
+		return -EINVAL;
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+	pse->spi = psph->spi;
+	pse->dev_id = dev_id;
+	pse->generation = generation;
+	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	encap = PSP_ENCAP_HLEN;
+	encap += strip_icv ? PSP_TRL_SIZE : 0;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
+
+		iph->protocol = psph->nexthdr;
+		iph->tot_len = htons(ntohs(iph->tot_len) - encap);
+		iph->check = 0;
+		iph->check = ip_fast_csum((u8 *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
+
+		ipv6h->nexthdr = psph->nexthdr;
+		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
+	}
+
+	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, PSP_ENCAP_HLEN);
+
+	if (strip_icv)
+		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
+
+	return 0;
+}
+EXPORT_SYMBOL(psp_dev_rcv);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
-- 
2.51.0


