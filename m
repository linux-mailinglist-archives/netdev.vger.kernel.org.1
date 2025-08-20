Return-Path: <netdev+bounces-215235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB4B2DB19
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5057F5C7606
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0CA3054ED;
	Wed, 20 Aug 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDf5NKlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF23054CC
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689504; cv=none; b=VlW//KoCkzdT1z3QVpTWnASImtgT8a4uQD+KGoQ/B2zRXVyb1Sn1pHdBD61rcN/AabaTALl+r0BfKKXFL9tIGeppj3z7By9WerNvdlUkhqQ/QDQ/Px+/QrVPmm6z/7Cqa6iIciF6FPKPAkSLb8ZOrJwmRaYZuxppSyBgmXVT9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689504; c=relaxed/simple;
	bh=QJXQlXMQtc7697yuRontgX6xpHqEo/+owih5wyGE7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4Xigu6tBoj6/AmdE49SpbFjjWtb85NV+4CJnblIMuWdooSm06BSZUhyuC+Hp9cA1tK2Tbm7Y2fVesWK6y1dLqeVriJ5i1X3OMZwH3iooF+5g2G3+QwsUrJZcXX+zTdvLg+TEldSRUmAwhejTTZz3H4yMocEwoYjqkVCmpYYs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDf5NKlj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e94fe8c509aso304472276.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689502; x=1756294302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=ZDf5NKljbHWGGWQVjVNrErEyRZCpAm3A9LV0PR0JjNZWpQvG7JczPCI4vOlJXka4xZ
         vn78ygxLKBGmWrhLJv2EdqjMrM4cWFHQThSz0HgA++Pcp+puEOm9EJcpElypcewbWDlN
         aQSItxvN92PbIxeHAPD7qqw0IQwroYEh0IreerC8h1shTCuT4KDixOoyhFa2zXlKI0u/
         QcFLWO0wVpD+HNCeZ9IIY4alpP0Rue0oitEueVGZ26rkmWJWbUnntybPGfn1GGvZ67s2
         cptRp8m04nmy/PoLJq3NNKjXttzjfeOagOlOeAYKhrQuAEygW5tQQChN8gmde+89kf+i
         ph1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689502; x=1756294302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=CI3OwwrGdsStq0R3KIxawWM8y08RArS3WWfvadI3iIsd6hzjeIO0IZqWnmM/9wqPJj
         0XetL4mo1ZjNq/wkkARoq8wGL8F1clc6sP5OSBCyiw1S/fyrFUBiUIssIAVXu0r6nSkB
         UpgILVZYaBcengoFNwlqzuYDBuFAnaoNpAqANg+EcsAS2O276G5rUKYAAF0ktJaIi7ix
         KNkdt2dnnIbGREWe+BOGaH9Ou/cPCKjEnNil4V/OthBuu0jyS2K90woVSmFcPU7pibC2
         Nq7L+zxQCkp9s14xfJCiXpC+5G2TOwGm4EIS6eSvA5TOFWmWJiIvoGDl7jn0l787aAi8
         9vBw==
X-Forwarded-Encrypted: i=1; AJvYcCVgdUuaCWMG/9me34DjBRTYIMbvp5hi9r4Zic/ikS37jNihV3bORuA8+zpd883j4fUWMZNQQIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyghp0KOUCu/Cp76m3BwPBKTeoRyNFJnAmmpIAvHq7UAzcSw4rY
	Hh0iabtUYHzsA1lj4egn8O6iwsZkk7hDVU1ma1CZSNNO4B77w6F3mEO3
X-Gm-Gg: ASbGnctqhHNeAxbvS6lY9iMF94s7KXFyvymr7qEyRQ7vzfzrY5wZoMXQQGAOwizprho
	KKodTLnIx9bdgc5nL9zjcrn/aNzR5Sj/V1rMYFFLetHSdk7LAlb1kfKcsRaZVaxvIiSygQwlgd7
	1eiKKR/sTB5/k0pRA+mC2pK++3kirkfGt/OHtY8YEC90B0oe0lKe0vF0V+scWknmP71U4TWvtHz
	pOvlJ1/a483Dqz49EepPOcd4eF0/SLYxoFpCs1nJ+jk5aB2U5OzQPOHyXE2emOUZteef9CX4NRA
	h66DUstfqXytPe/ZWuD3LKf/8b9cj+E/1eFx6Shxm75ZJ8mfWwMWX0GvRp5oWCh/y7trACWFszZ
	K7FTZOHiws8aGxzlF2cGp
X-Google-Smtp-Source: AGHT+IG+iNAvYKff0cSxZyyVbYiIJ5cSYXyT4m3BPYHKoMwZMnVfVWSsFRJOM1st3KUT7DZ2ryBuKg==
X-Received: by 2002:a05:6902:1143:b0:e91:75b6:9439 with SMTP id 3f1490d57ef6-e94e7750017mr5612400276.16.1755689501327;
        Wed, 20 Aug 2025 04:31:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93456fa756sm3843768276.30.2025.08.20.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:40 -0700 (PDT)
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
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 20 Aug 2025 04:31:15 -0700
Message-ID: <20250820113120.992829-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
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
index e8c2201814d5..1075e236dcc1 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -19,6 +19,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
 			 __be32 spi, u8 ver, __be16 sport);
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 40eb0b396b0e..a2e79a245571 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -215,6 +215,59 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
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
2.47.3


