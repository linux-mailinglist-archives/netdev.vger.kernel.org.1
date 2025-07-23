Return-Path: <netdev+bounces-209532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C6B0FBAC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C767175AEF
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10352472A6;
	Wed, 23 Jul 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8nraARj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01424247287
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302943; cv=none; b=BYJkUMB0MTujKGx/cffEGYKGYc6O7nHnEf0hfdQXWJRY01mBI6fIDTWKHJhygWxutSMRhOZHgV/di9xKaCasyNI4B1DnhDqOR+BVcA7cno2WwHZ11oFvdprf6ffINCIp5jgLcvpl7NRUhNpaNgotfk5ngm0G5/C5RpI6y6lDEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302943; c=relaxed/simple;
	bh=3bdYpreJbaqjQWw6Ofklo9RY+tTmwjJVHjMy8TPB3Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYH31GbOaD4acOQIipQj8m7RmWNZt+uypFEWTVeiDFieHx+Xjl5uTetrgNUGkkJlLx5xp+CO0uaB8R3BIaOXzMwiYs+mastaMXO2vLxxW61OicOuPln5X9Xamv2oCh/9CNQPu8tarvlclTgFbgDzf/Fy9gn3WNQuk3DmZ1JkGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8nraARj; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e23e9aeefso2744977b3.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302941; x=1753907741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UrDOFQ6TB8n7tw0GnD5eCWuLU74MiDaxwNCvqqcQfI=;
        b=a8nraARjPEM2I1gyx289kX7k0WhboOgvILJy3l8KUOxpB1oJvskTIMFstO7GHsF7nG
         ot32k5rpI1Ep6eD56YiYQWYft27DDEluSPakuGfgMAEtrKjUzKl1iADDRj323aWNWSmF
         S5808WrNoHL+Q8PQ6zi2O6udRNgO0Cl9F+0WuQGA3ZNAj7rkQkwbX9n9I+3WgnphLPMD
         CDI3qy77LyYIU5sYJohVTTSmz6xxHeyfe2mBBe0oxbb3stysQJVOKWR3QYZxSiigvl1i
         IbFofzfexD2xjr1tJpmThxsczgLoMVwAbXXUXJDtcCnOESu9QGne2qZ2eVb5uz9eoFvw
         CfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302941; x=1753907741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UrDOFQ6TB8n7tw0GnD5eCWuLU74MiDaxwNCvqqcQfI=;
        b=e3K1w2nCM4vr9z7NBM+tcnOuKLJaYSv1n6oweVZqBCCutHsliR6PFADuu2CRYMnQrJ
         v8h719QJlSXRW/bPZ0zpiNqbIrMK1QxRxw9wy0Q6p5eUygmK5/X7itonzvC7FgHKdRdT
         tAaWD4icFiLbH0sBFD+b2PEbKYIhgz94cusHKa2TyC2NjkpLjjB39E4VnjXqHdCTsNjd
         Sd3qsB5K9plVrRQLvhML4rrwLH2bpQGMMcd40nS9tAYGgVB01q4C71KV2ihzTZg/Ihls
         jGVHVXWg76kmrJE/sef+aevnoTBNTWbO8aB4JVkoa2UI48RhJifvd6RCOERHtgl+5uYZ
         Ha3A==
X-Forwarded-Encrypted: i=1; AJvYcCUpypRdcTJV3+U6oeHPjcfKfnVzMQLQh3Es+Pou1zg3IPzYAsIud+jef75GydRrO0JdKAlv2lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvUwe//yM4vSrGIe2C7i5makDgE7VSrxmmFtxBLfGNJGjrOaD
	983/2asHfou8OVfIyz1V/zPaXCDIvctRD5n5mVNs0BeCN7wJ1XlmUZWT
X-Gm-Gg: ASbGncvGmmirsh3HatMofXHZwlgISFeBmTTOhvkDYUEpX/4mgrjBDhzi7DTe0RZv+Ik
	WUzAXYIau9Fg5hK8eas6ZqZJOkz40YXsxvhytaTYtrHxnNF4gz1DLIi2KKKpWBfnBCY8Yc1zBLp
	9+huq38wqxG95qE3HRU5bZLgr9UWh8vMtKJ1xzP6ikWOJD66teMHsWjqJfgrb+HhiAX5hewzxsA
	xQh2xbQv0iavFpBTw62BXiz18cAMCnhw5RBhz1cwaQI7dheOq58HqiVUmXucVowBJafpY6en9Ev
	ox+T/TG2pikK8pNnUhYXNX9uhSFmgF6L2z7Ba9fvl8YvlhgOJNlGBnvbvGF9oa38masr0W26gFb
	M4izao++jZSXEo7l2cHM=
X-Google-Smtp-Source: AGHT+IE0BpE/mlVFHovjW85wOa40fvZ2wOSNfrQoDsGQj4HdwtHmi8Kdf6erlrR6M25Agor5rXCaaw==
X-Received: by 2002:a05:690c:748a:b0:710:edf9:d92e with SMTP id 00721157ae682-719b4344079mr50381797b3.33.1753302941005;
        Wed, 23 Jul 2025 13:35:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310a6aasm31914027b3.6.2025.07.23.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:40 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 23 Jul 2025 13:34:48 -0700
Message-ID: <20250723203454.519540-38-daniel.zahka@gmail.com>
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


