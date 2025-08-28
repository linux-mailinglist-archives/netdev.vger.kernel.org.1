Return-Path: <netdev+bounces-217922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F1B3A65A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE77189C34F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA3338F2E;
	Thu, 28 Aug 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moGlryzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154A3375AA
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398620; cv=none; b=XkVfG8Mjx8/jgVuohT/uQ+vFTYb+ivBbMtvnl4U6VsWRAP7nTdPsoYNNl7vlKrfjWFuIpy9jwbXKwEOI2+Lhio502JD7uVsoSV1lX/mjjQ8kS5JouQslzo2CeEYZ91M+DDgmW6KZzjApStC/1ad1RoGVPTutcgZ2a4dFHxuSoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398620; c=relaxed/simple;
	bh=QJXQlXMQtc7697yuRontgX6xpHqEo/+owih5wyGE7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTu2GfAjaJV3Ne797QPBfn5sWMvxRuCn79giZx6TsgzWz8GGTUq0YbalPatmgoABdvylajj+RGWoeYXO3khzGPm+msVkojKq/3i7xb+IsLzgDyCBWS6J+d4v/NORaifmN7lDCyZiNkuURX93iTaIjVI8rhQb2LzpBYaJUbShR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moGlryzg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e970f3c06b5so313744276.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398617; x=1757003417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=moGlryzg8q6zIKweyRgBCT0EA4SgiV3shgvZHWwQy+1vrLTS94CfGatijfqaS9lLwe
         +qMOStROUBCPg1YmMtkfEgwrwzuNzVKiuq27Ov5GQSI143KHVnS1G2IqpNPN2dot8R5U
         GlGturjEeL20U8zFxsm73y9pr18m1XBBw2AgmQbbPT/WiSecD4c7FokOzBoQ/gnm5h/Y
         9ISD06gOgmqzDBPxv5ujuDZ+aLsVGyYDcDJtq00ccqdw5q28xHOp+C2AXBEna2U12jhW
         431OPDVFikpxien7I6pJxFk7A8HbxvPmXMYbzW84Eio4GCAK20Pzc5FjW9M60IgIV8CO
         rRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398617; x=1757003417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=lOgzVfTeMp35W8cGaTdz0HAiud6DstJtvWVGrWLb96FU/QBzlM1M/ehNpj0lftseyC
         eatxfLhRV7IzXJNDNxzuPzjKgFA/kSOuhIPqZjiFaAiJ0ep9ET/JJQd4+ghQbX4cm0v2
         MD+YU3I6R5yJVuZu4Enf/O3pf7Bxa8TsVmbQ7M3+8ekMCcOygxDG9kCV8B9LM/5UQcnL
         xKFY2Ei07/uUAxRbQ/jevtaPgQqTW5a5wtR083gYyRQV+4zTQKhNsY8A8KnmuJgd0fSI
         LgcN3cxLWWBjK/kmAG90DNY3FENh17rMuq+rkFzEB6W3bXIfbFljl0PMjqKNZwcmTxoX
         7fcw==
X-Forwarded-Encrypted: i=1; AJvYcCUBDJI0LKaRz62CN5YbCCEfavYRxloFUjjEofGF3Ac4bZggHAv3mmKQsamy5gUFTcaGl7XynFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzohFCIyJFXIFnSSYFYwYF0uTs6eozv6Kf7u76fQBFaTc2fEKE5
	dQnwzXG0hKdzg0P30h5wNx2/hvgq4cjUl3VdkEjhENj+hhq1nepFSVfn
X-Gm-Gg: ASbGncuerH7ua+iAjWC/i8BKJZ7JS4wzblXf8rgA3AhRylh2aCQgr7boQfHDHvxpn6K
	gJmSfOsW6rCSIF1HMAbcxaiyiIykOrg6BExLl7iJeqoU7ISgGgnuyOvf2P7CjNBCA2adEIJfob1
	7ayG3UTA87dU62STq9yChCYNJQHH0V1ML3XINHncCZGLQWKpIvN8HiLCArjuyN+uyYIxj4Nqwa4
	SuutuTycyElONeNS0qy1HKFJ8ZEAVBUcyF/Sr7ZiJ2NzwDX9kTTwyLOj5D5TkH15ujqQItU6ezL
	ASaH60RHCoJglC4qbLJAlAGy4Sf5TBdrLFtdhqWD8VkiAez9e6Yf4nU97D6mtlcScMU+8Fo71g5
	olVsy1Eof6gz+rovv2mWK
X-Google-Smtp-Source: AGHT+IEzNDGkdFNJciYXaNQoIWYXHSUv3p61hL+/GgHd0+7Y8Qpe5OpT9T1pUGq1YVVa9Kr1MhHuyQ==
X-Received: by 2002:a05:6902:33c5:b0:e93:36f3:5720 with SMTP id 3f1490d57ef6-e951c3c4649mr23642029276.29.1756398615436;
        Thu, 28 Aug 2025 09:30:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c2591ddsm5129445276.5.2025.08.28.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:15 -0700 (PDT)
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
Subject: [PATCH net-next v10 17/19] psp: provide decapsulation and receive helper for drivers
Date: Thu, 28 Aug 2025 09:29:43 -0700
Message-ID: <20250828162953.2707727-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
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


