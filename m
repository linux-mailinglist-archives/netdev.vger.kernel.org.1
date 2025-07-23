Return-Path: <netdev+bounces-209512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCDB0FBA0
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22A31C83108
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0B423ED5B;
	Wed, 23 Jul 2025 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8K/dRvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CA23D29A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302918; cv=none; b=cMvbxCAzGCbhTPqFLjSfzBgoXrlf7KR8iZVL/TfXGNbyX2Em/v7Z+gsJSFzpdbXhn3lmRan1dEgKwJZwqGIkwklAuCEsM4TuYaYgGx19aEvGpzAnoPXHy9EHN3wjJPEIekG3IdsHvPyPYXdaw7gBw4KOTBiJZJ6dKK8PNGWgPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302918; c=relaxed/simple;
	bh=+WKEnQMuzKlpzIGOHjx7jcBsroGAlmWpTS16SBSY+eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7iDIXVcGHDEwffnTgpN7dO+2FSJcb3aRncuLw0s/i8Zs5OI8S/XEL4rcu3uNPGcgOwaq2ZKbzI4z29Z1zh5C9x/MmXn9IBP8NGUpK1gzbJOeOqi87NKbC0aaY7Ycs/bZzuMkKpoO6PuNmVYSCEVjThmi9W2Y54Qlf5dn+BNIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8K/dRvL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-718409593b9so3883367b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302916; x=1753907716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7PC/NIXvg/5AsJc5yg7j4nmNukukKFPxHigbadjPYE=;
        b=M8K/dRvLC59wFQ4dlDEHbCG/N81x5D6s9IzZZ9FQ2qCIKEAfx1sh4Y2VXZ8Bj1tBV7
         6hCTPpMDwRbH8FlXcPb7NWs4ki/mXFyLYdGDN73T5pOu6DIRUR1UF0IWZEnRLuNfCqvz
         eri2G0hSGSq0ipAEVC+1i01lNrpqWk54jzMmsz+3NZ89jgbl6dRtQFjbsp/hOa+vgVL0
         onIrPNi0R4gli8ObFhk+oxKwgGR+ERNeR6kN0gjp7d1meZznZ479+tdg+4EzEO3qtpSQ
         fu8SIs/CNAtF0GCi9Z5xYMJH9yhjkojfNb8xPDLzCF1WZmm729VCwQqe7BZDn7n6L1n4
         NQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302916; x=1753907716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7PC/NIXvg/5AsJc5yg7j4nmNukukKFPxHigbadjPYE=;
        b=LjXu7Az4VXEoFHhaykQQ9uUexcBKhOGStqA4Gl6ejAEZBS03lSbvNsEIxFrMVfUhcw
         PzdcJHi0GOava6ivNMAmzgDXNKA6m8xmvncPIAc2JZ0Dd8uib6E6tPclC6/Jy200sWCo
         Rx48X8co55nxSaD4zZD3wAy65+laYHU/EsOuU044+qCujTCbgsXXd80+oSmbPyG+ZvXB
         bLX2ujNZWoMiX31xy/RLykPWLUCH2kNtlpmVNNabwD76Me90qdjbfbYlN1M7jpSHTX/X
         4lEH4DT6jDhTsQ55H/VXCNWMxf10Qfkq069aZlYbZI+GsJWpJfhBAsanzyCabGxwP6UO
         Iv+g==
X-Forwarded-Encrypted: i=1; AJvYcCWQrooXw56Jjzg8hG3PFvi775wU4aF+SZL4nNqTHG451h3S8uA8ZfHxNz4sWZoW1HydhFJilRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iVe8UqoDoe63f3T62yCJ6LbNKIHbHms5baTMg8XL8Ob8ZwVM
	3IqS/oCU0QG4TFcB33vi25mPGj3taJC6wVrfen8E3hK+TrFP68k8hWib
X-Gm-Gg: ASbGncv0wQ0n1a+F2UR1ur/3n4+/arDDMQ+sFm4Uhr9wzxqb0ox9mXtoGWXntNHvHsd
	d3PtNXn6Xr7yvQyqhnxuy2lmgD0cXpEE2HfszhqqSpU2KxhPPGcPFA80UznpRqqdJPjgbwgA7AD
	iHpqoZb0YZ7pD3mSK+avCJsMo7dO6E6GcH8dhz8OScQ11KxqEuZXKu7SU7NKRPsqPhoa3wT6CxE
	eXOvABYKuuJfQoxvOFCnVFc9gI/Ai+SGI9fBUux7Go7oKKmr62WRjdPY5eVMz9feA8C4gx8sVMI
	Pl9HleC4Y3QGHsJjmjvARiWHFUNknd4mJTA2xOvl+LQkMab5olOQrejNxocgjBunKenYIq2tSwx
	6uXBucXlMLHqbO55veJ31
X-Google-Smtp-Source: AGHT+IFhBmk19HTw8vwhGA2WWQFmDEU0DcAHZvxfBu0Q4Olm3I2h93VKSLFdEzc4TGFOS0yY+7QO0A==
X-Received: by 2002:a05:690c:748a:b0:710:edf9:d92e with SMTP id 00721157ae682-719b4344079mr50366847b3.33.1753302915818;
        Wed, 23 Jul 2025 13:35:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7ea6sm31181917b3.53.2025.07.23.13.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:15 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 23 Jul 2025 13:34:28 -0700
Message-ID: <20250723203454.519540-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Create psp_rcv(), which drivers can call to psp decapsulate and attach
a psp_skb_ext to an skb.

psp_rcv() only supports what the PSP architecture specification refers
to as "transport mode" packets, where the L3 header is IPv6. psp_rcv()
also assumes that a psp trailer is present and should be pulled from
the skb.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v4:
    - rename psp_rcv() to psp_dev_rcv()
    - add strip_icv param psp_dev_rcv() to make trailer stripping optional
    v3:
    - patch introduced

 include/net/psp/functions.h |  1 +
 net/psp/psp_main.c          | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 460af903a35a..3afb48e23f47 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -18,6 +18,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
 			 __be32 spi, u8 ver, __be16 sport);
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 434ff6dac18f..437cd3c7f9eb 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -210,6 +210,59 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(psp_dev_encapsulate);
 
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies.
+ */
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
+{
+	const struct psphdr *psph;
+	int depth = 0, end_depth;
+	struct psp_skb_ext *pse;
+	struct ipv6hdr *ipv6h;
+	struct ethhdr *eth;
+	int encap_bytes;
+	__be16 proto;
+
+	eth = (struct ethhdr *)(skb->data);
+	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
+	if (proto != htons(ETH_P_IPV6))
+		return -EINVAL;
+
+	ipv6h = (struct ipv6hdr *)(skb->data + depth);
+	depth += sizeof(*ipv6h);
+	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);
+
+	if (unlikely(end_depth > skb_headlen(skb)))
+		return -EINVAL;
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
+	psph = (const struct psphdr *)(skb->data + depth + sizeof(struct udphdr));
+	pse->spi = psph->spi;
+	pse->dev_id = dev_id;
+	pse->generation = generation;
+	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	ipv6h->nexthdr = psph->nexthdr;
+
+	encap_bytes = PSP_ENCAP_HLEN;
+	encap_bytes += strip_icv ? PSP_TRL_SIZE : 0;
+	ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap_bytes);
+
+	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, depth);
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
2.47.1


