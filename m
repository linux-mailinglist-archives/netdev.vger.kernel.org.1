Return-Path: <netdev+bounces-216624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB1B34B59
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514811B24E7E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23E3009F4;
	Mon, 25 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAbfeFur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875162FF64C
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152100; cv=none; b=piECcP8nUdInhdCRkkL+MZAdyuxfVp405O3kXvFR8OPE3gZBVJBS8zpkznAq+yNQtxqXC1W51afZmzqiu0nRK4SiWuzWqbiKpmLNheNgzmjGyYqGLbMr5YZZ881YiUlbuU14dUCzQ6/kw+Ev361irHZ+Bq8ZdFoTN/u76BGGDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152100; c=relaxed/simple;
	bh=QJXQlXMQtc7697yuRontgX6xpHqEo/+owih5wyGE7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFH99wr79wn+MYoTHrJ+VcDkvakZCaVOOwVa/3Mf+k3MqWqeKrB58JepxSEVsL5O+M/W9FHevQIs4f8OiupUWwJ9gIDc2jhaPr3ZIIt5wRC4LkyC+/ozwZXBPblGm2KZ4xhqx6NJNxc3GMlyEzsbiNlW1M49EXtDAGA205wsltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAbfeFur; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d71bcab6fso37129807b3.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152097; x=1756756897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=SAbfeFurBwLSozS0H2e8Su6HZ9q6djp3Yx8YJSAdrIr5A/xHE1FrNiIhB0D3yI9Qsa
         bxmsB1VY643RPZ0UOZd9tGOA1HzhxgHTLA8RpZP45G202/8O4a9VL3lVJOf3SiyheEI9
         OXQ+1FeTfoXqUOWGodGMxgTqCKackVFCcJ5bc9F+id8pOQiUpfLWO/MYtyX1mlqXFgCc
         yD3+fb9+o8yoYs9GS7b8jLJjC66nK6gEDghCNgjeGlY5xAZYRegXfvMGoYdST1S33kxi
         vHazXubUtzUF/12J+M9ifsyrWuOxoC22f0egD4tWpVYBzR83p7gKpmdu5DBwx44qQm8E
         o1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152097; x=1756756897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=Xqynp+X7L/57/xPPSxyMvi+6S+iltDoZXS3y7QwDXWZilpM183pj0n2B2JGYHlpBuc
         Wg61Tt5mkW1kO/JFxC6jgWMksOBTit180mLkVuIQBUH1qHC+LrpEL7n/Fc7xZmi1bLtV
         L16Ih/iaQKSOHqFqUZTQXPaB00lhC/hatu0QB0qEJfg5LNqeHD5iiHq1zHgH8Yrj7iVD
         1mCfmgqGzq0i0sJbjWMmMQbMvNyJWrlo5WUeEohAaUE5jfYy3B405FeK8Ekfzd6c7uWH
         htTA7VAx7k+DyTMlAFlz9I37e6R8ueSoZMDXSaWNodRna4qdMFlL4MHzybpTnakQ9inR
         HLIg==
X-Forwarded-Encrypted: i=1; AJvYcCXHCpjtRQm47GynlH2vyPnP3P7fyLV2fdl/9RSpCWuoz7p0q6+1LHbK8koOXU1rZ5e14DkKzYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQ2xtNFXCbgd6ienD4jPxlQ67Kd3MU/8lIK7c/kKesTv0uI6B
	I8oH85YVqygrpxbsjP/87bFoNqAf2n1xeeU/7aWccfJMu8njF8FnFjab
X-Gm-Gg: ASbGnctF6NdIik4x5c8eZefsqvxLxMIeCANN8dXXhTpDMa9QIfJTL59JZ2pRE1QoEEO
	DVPDxGsR8Yy1leH+yTNwPr6kJi3qK657hrmk4euQr7BZpL507dqr1b0gUlvq8D9ClvlQR/CmbIb
	DojgLQnvMWVxF/wEXV5vp+n+9zmMo5ebjCh3HE3vNWZMQkhw6zjYVo96qVgL+nk/5dABs5Do9yy
	ogg4qIRtgC3gMawHTFpkZpyMmdA3oYn3t5bWWtC1DOhrr530pymmhJK1nbACk4nN6OkDRjoR5Ra
	Lt81VNvYGUjpv7MyPQvipF61NiICfwJRZ8y2JA/NLrg3KylXuiCbUx+age5GOlMY9458RJejDlg
	zOILns7HVzfQuHb6j7tU=
X-Google-Smtp-Source: AGHT+IHx6KjVOOZH0tx87h1Z9bjmW//oPdwj+ZmPqY1atYg0r1cVk+P7dgdM744VggHrwjhqO1NkHw==
X-Received: by 2002:a05:690c:6004:b0:720:9db:5ba0 with SMTP id 00721157ae682-72009db5feamr73053917b3.21.1756152097457;
        Mon, 25 Aug 2025 13:01:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18faa72sm19353507b3.76.2025.08.25.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:36 -0700 (PDT)
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
Subject: [PATCH net-next v8 17/19] psp: provide decapsulation and receive helper for drivers
Date: Mon, 25 Aug 2025 13:01:05 -0700
Message-ID: <20250825200112.1750547-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
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


