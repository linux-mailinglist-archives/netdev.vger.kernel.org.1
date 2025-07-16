Return-Path: <netdev+bounces-207501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8194B07888
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E850167B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F026E6F4;
	Wed, 16 Jul 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwGMupE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF82F5466
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677190; cv=none; b=Mgm0b5shlAyxWEj+vrKskcRqKxf1EbRi9Dq5KxncWiukoDNtzDPVrG7SN1R4eFlkN3iwhCEkRLxvWlaE7+7HNDwEL9LhwygwCk2x2Gg68+HB0X72r8wOyrnmwPCnjDwHHCrDX986c3A0oSC/4UEMrpICLkKopjDqfzodNt60Bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677190; c=relaxed/simple;
	bh=3bdYpreJbaqjQWw6Ofklo9RY+tTmwjJVHjMy8TPB3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBts/wVKlpakYXOVvJF4vICdZd+Q+LCcbDKVs87J50lKbwyWMLWffyTntun38XzTJ2QQjpPSflYg7ZvqvSbmixysCcHYUikQjljobzNNOiLYu+pT74sbKEoMclc0Yl6R64R3KeBYfRjyJjjCnkkkRAsJ3ImFkl+lxSStHHeXFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwGMupE9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8bb69cdb90so1935087276.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677187; x=1753281987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UrDOFQ6TB8n7tw0GnD5eCWuLU74MiDaxwNCvqqcQfI=;
        b=VwGMupE9H7lsHJ0kY2vXcmK/FwlWlyby1Kk/s4E6SbpX5dZJVd6AMmwBVZaqcKVn7u
         TKsgspOEYKJoAO8M0hYSgneQLDNAyfKB50rp2I9T/uJtC/jjen0OHVRt2gcMoYbnMSOQ
         3NutEBAvUacBdcClw8OtD7rdU8su4HxnC2gwkthhq+NXdCeY0yF4b/bbgOq9u5R1HU33
         Majf1PJIprAvaer2F2nQDPtczbBD+jttwvLE18NQq9pLibvvsV4mfQrPk0sqrseE1+3w
         /rgab8EpTSfvw5iSQ6u6sGnSMHaecYzDBvAYX23jeaidWrsgKhpbW0larul402RTMTdw
         6yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677187; x=1753281987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UrDOFQ6TB8n7tw0GnD5eCWuLU74MiDaxwNCvqqcQfI=;
        b=YOQ1f2ywp96GTrEgAra5CbypfgZ1boQw0GEadhn4878o4aNKrBs7RTs0QToQuEwEeg
         5/ayz/Vz1Rc4sVwbEnKEp8VnB1q9xZx5ebiMbNokAfwkTDMzTXIjl4jjL3MIs6pUvHj8
         j2FSsXA/+DIPT/onJYzKbQNIRM+dPSNjgwxKnXWIF2UfTIsMIlaWtafO3lRy6SMxAn0U
         +pgnMAy9jXzkRKRqKnAdEeMClzoLHsm/wYO5aopZ5lHt89Y/u+Z05Zn2tdXP+NR4Dru5
         T8O+WIKKlwbw14yuetvudBgyIqBH9x8J0Rth124wbEaz8i4qIdfGhLRDDnMbBpUm3GQL
         Vh3g==
X-Forwarded-Encrypted: i=1; AJvYcCWAemadPfj7HOF8g3EONox29BwfFKXdVObBjIPBHYCrciOxNgn3jZKTUwJwVr1T+BbkuUDyrWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/8CTFKYPH6nk2RqV9fu/PNKkBsiPcjNRGD4s6ffXWJOK4AF2
	9UTwWvJWkYW7bVazZ5VJdgQD9aW/vHfILyqAsR/VL15UJPV10aPnDMDA
X-Gm-Gg: ASbGncu5Y/8sKppUu4vW28i+qTRSdmagl5nssxVrVHZvdQ6O7vhCi3SqCw8Oy2uzqzd
	fqd54334VcxLrAI0hP0eryY/tti/YpaplQbBt/+VdcC4YaANTT0iJeIzz2jKXdgP/G3PKmd2jE4
	2WcWKo3qLGR5G4kY7l0+jrO0vqp9rougtBtjKiGuolbHkL+jhyScTYgRsDjUmFl3ChEoOwvVNJY
	PTm+1rbFVHVxP35aSrLTO75ZfqpSAlWj+2hsWSYfj2WJAn1liMP3W/qNcMTcIu4HhSDJwnuttn3
	S90UCYy8qi12BJlxJxT+sdAtQucOezPKQ0qo/jeMCr8+p9iQGFVlGQKMajXHUfgWwuxShTET66T
	lljj9NzoASu8d5LzuJhI=
X-Google-Smtp-Source: AGHT+IFRq5dBa4CC5UOGsr0x/lj9Tr52E2gSqHsIluTCeTljz67tX5uup+8HflZZeNXiG6ACnuS94w==
X-Received: by 2002:a05:690c:f92:b0:70d:fe74:1800 with SMTP id 00721157ae682-718370b28a7mr41836397b3.15.1752677187406;
        Wed, 16 Jul 2025 07:46:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61e97fdsm29466587b3.89.2025.07.16.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:26 -0700 (PDT)
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
Subject: [PATCH net-next v4 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 16 Jul 2025 07:45:38 -0700
Message-ID: <20250716144551.3646755-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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


