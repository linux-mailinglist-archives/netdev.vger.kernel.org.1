Return-Path: <netdev+bounces-237075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFECC44617
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 20:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF78188CE82
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED2253F07;
	Sun,  9 Nov 2025 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYJfKU2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE7246332
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716288; cv=none; b=cFg0WTldslRTbCI8IeUUu34i2knqoVxsoGMScbBCj3KtvjhlsuGrfwXd5+lDh4relfN+id8irf0y5hloOyxWlZy4nbWoKLpwTYHOb4KDo4wIfdIsec071BpJFceAuaw+qJTDzYOscTW5MIYaWCAqCHLyxSumw19Xlssz96o05HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716288; c=relaxed/simple;
	bh=fRAY5x0iiQZzMBRRTadDlTASkzjWZctbJeB0EhamTXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKyNlq4zuw0CEZcVNc9s0H/PvkJlKAu8SgF/ITorQgZjkCnNhNeqhjn389xZlkc9GgUDvNQvSm7aTQ57TkiaBNZZPb9UyvPtMNEdUcnJJg9mGAJ/bauek+Gf3IQ3GOt1Jcf+Oo1Jhs/DskfpcWcTdsHtg2Ty2llTqMXWxRoigr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYJfKU2C; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d402422c2so475729466b.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716285; x=1763321085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0KTE+6UkuOljHxLPaa5JqpVN6oPc7OyA2U67mp05fg=;
        b=mYJfKU2C18mrD/WINpTw7+BHH4XYBs4jC1ShcN3aoslG8Il/aackok7+RXr2V+NmT1
         ReOhu4LeJ7iOaHKo3eDOyRJWRlyddtdJcCWaN+iyDMq0SOLdU6OYbKJioPGjl7w0JoTn
         AzCxzoiTM16dxs1WtiwEYTULnJP5YrOF+x7BNDOTxOyDm7YvUNBBdGLqCqIfemTT5pYB
         rd7fErMhFgykBDZoUAzcKMRkWZF1Uu8Qn9Dqd2qQZQ+H7GgedTGB7FNVbPYwtC6DWwr+
         XhNyOz+TMlg4BGltS4kksW0e5a+LEcZSJ9YLrWcwHQtbdnTHsCER6s8d/MZ2uNcZQN++
         EAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716285; x=1763321085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0KTE+6UkuOljHxLPaa5JqpVN6oPc7OyA2U67mp05fg=;
        b=suzahvJ2+u2Plo7IW+DcuCguJcUj66lxlSH5ppmH18U+cNVd6Go63sXFbm/RaLgl8O
         BgyXKP4l9l9KDfdRUoacZ0mbm+gszBEz2Q07wM/vp8Eoc8/vwazNaOtGX9skRd+WRfpi
         K+dEoyJ10aEaVIdQjdmaU86UEAHnp42PXyjSuhbA3Gi0PrH+BkNac96A1A6YzKcW5R71
         l1ecEVYnDG6RD1HD3q0vJg4tM7MLLMI43w9F2lWv2N9s9rpGYqV6iDJ90TXiZC3J/S2l
         0l3GJK+kNGsLS3ecgTVAHWTeixmPhZUfFA2NWt94RMtcsawaKY0++DT1dBsWQ1OK+8i8
         QPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrXOQIR63aiTTvL2tI05GNqx8lLT+r7MkV558TsuNnGuPI2udUmtSTJrI/bq2Fugno2gZS40s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1T/hc8Tc5faPuiYoSyyT1E8VSODO622XSIOPUCzSNcQV9f/gU
	GrReQ7UlFGgZcwXh5ZR304x06EGk0JXCq4f8RKjMBN/Jc5Q5pytkIkBa
X-Gm-Gg: ASbGncs8DTtrQQYogdeMoqa/gj5qC8LETRITPNX5R6c/zaT97AkXaDz47W48prZVuzP
	EYOS0q+03K4sSLk8VcHdUzGyofR/FLicQTKOOlnNQSXcIpfANrQ6UMLvJS71/zLmTW80HmxhJ/v
	Tbc93a9+O9acObSxzVUaEUXXxs7MbhG494AsOrGH0gNe2Iuf2Y4/6mLJoxYLrt4P2wNjxpIXG60
	U7aePdlYta2zINY6lH5m2U0m/BIp9/0g612ndQkfMhdsHCi8R6PyK67sHC0MpXgWI4X2q3yEB9Y
	F2oxNuTjgTdJ7HkftbeD/AI8wyfs3Rp0Nx0s7ZKAU2/51HPe17OX3tD3k4Jr4DKNZD9ymR3sKdk
	pVB0piwR3eR+hZsOQch6/ybMbNzjS0DLLTHVdRBdwjtodmaZY4ENvw1gvPvBOyJYCfKWUPBFfqy
	k2qsDnmjR8Ky6RlsAlJIms/0H9eerwIrqHxhk6g+v+muvkRc313/7ln36GOxG3COvHL2ZzDvleK
	g6aG+Uo/A==
X-Google-Smtp-Source: AGHT+IHbYcQWGeRNfv+qzW3Tth8V6nuyKNbZz2fBbPX/OXmNJmzUeDKE8mETFfHc/vJK3DShLlkrpg==
X-Received: by 2002:a17:907:869f:b0:b6d:5a24:f124 with SMTP id a640c23a62f3a-b72e03035d6mr502044166b.22.1762716285087;
        Sun, 09 Nov 2025 11:24:45 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:44 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v17 nf-next 4/4] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sun,  9 Nov 2025 20:24:27 +0100
Message-ID: <20251109192427.617142-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
References: <20251109192427.617142-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
and packets encapsulated in single 802.1q or 802.1ad.

When implementing the software bridge-fastpath and testing all possible
encapulations, there can be more encapsulations:

The packet could (also) be encapsulated in PPPoE, or the packet could be
encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
encapsulation.

nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
known from the conntrack-tuplehash. To access the header it uses
nft_thoff(), but for these packets it returns zero.

Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
offsets.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index d4d5eadaba9c..082b10e9e853 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
+				  const struct nf_hook_state *state,
+				  __be16 *proto)
+{
+	nft_set_pktinfo(pkt, skb, state);
+
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN)) {
+			*proto = 0;
+			return -1;
+		}
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN)) {
+			*proto = 0;
+			return -1;
+		}
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int
 nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
+	int offset;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	proto = eth_hdr(skb)->h_proto;
+
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt, 0);
+		nft_set_pktinfo_ipv4_validate(&pkt, offset);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt, 0);
+		nft_set_pktinfo_ipv6_validate(&pkt, offset);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.50.0


