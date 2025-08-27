Return-Path: <netdev+bounces-217364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D05B3871F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82D7188C82E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4835334D;
	Wed, 27 Aug 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSz30i8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26F3314A9
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310043; cv=none; b=c3V/GmPCYzVq57Szvm9TiTFXTlU3+tOTQA+lYy8CyUHwuseh9puzfsBc2Jn/3kN6gAOtUdKprOaIg8BDh3z/y5laQoTM5lnmZ/jRF+1n3DkYwmavo0HYvCFoQFqNSIMTKFynQR7QNTMLbqLcyridHv/iXhfWW9OaSB/o5agmi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310043; c=relaxed/simple;
	bh=QJXQlXMQtc7697yuRontgX6xpHqEo/+owih5wyGE7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqJNEjuyejxNwtb9L9RoTy//mhzjLycfZFFCp8B/Eai4/aP9lge4bMCcPRihxnYp6dNy0F8Py28kQY/G1SIIITdqeZ6G2Vam4bNmIluwnXX2kBSv/z2KICtXoY9V2BOj9a/XNHnpvZmP5m7zBWojPtOBLcHMaD0+vjhSXNZyBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSz30i8F; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e96f401c478so616837276.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310041; x=1756914841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=KSz30i8Frdfb/mS1cW6TZfh7fVgaE5XaVR7TWO/0qVDZIdda8768du3BQAJuSw/lyU
         5p8LGMWBSeUgprkk4RZSAxoAllIxYeJSK4NjajcOdiWWiqEg2ZtjQ9sJxrl+IhuMPWuG
         SirFznyrqcNilNZDE0wgwJv2Q1gAifa+joe3uLZhmwok5xN4H+OREUBEeZJGdhxeZGVP
         WAbmmodXx6U6gRiyrZIJHTwUCP9tVIfDqI49KNLpg235P49jx295w4Gr2M1F3oqfHx51
         ILiCg2Od2KIt5EmZKrE+C/awmnw3Ejlx242dHJC+tmCJmR1QLyhiRcMuxaqXXOM+qDY8
         9vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310041; x=1756914841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PRig1kLxU/AtNaCmh+qK3P9/4BBv4caazgCMc7Z2tI=;
        b=etrt6HiUNj9nPLKJroDPL6QUXyM2tQ3SRorqDswEgWK8xszigyPtW6DMM2SKU2YrCg
         uoj/BWwUoSU3xdVp+GB4R5pXysXcbpBI3rALhgsc21/i6SY4HU/8/Dabi7LzM9nqKrTa
         aO/jJuJlCVYAFq7hCQ1XRyEYxoxs0zlnOQEADvPW/PwJ7zLFxcr0plmWQnnJmVEOsThx
         h/tS5MRJsQjW1WjunNa35CwGfW/TyeDascfTCNGIhAGT+GdJ/DqnGONDFJEN5j26vC3m
         Ef2YJxOcJko/2o4986NMoYD+6zek3R412aum7bgtEEoQbZFc7b30ThMp029nknzJzMLx
         NxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgPvOJZHuQ3oekcW+XuC46+7WcJq6BHH2uD7U5G3iS7tk78D6yCGtWsWJ8DGZaG1fQXq0oJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQfEaLEBKqQZa6zXg7Ul/jG3/p9e574myUzDYw1tWXWMjMJaA
	NbBrJs4u/poLcKjnyOfvzzV2BAIbE9ggAGfmPnoJs8AR4APGlK2Oj9Ih
X-Gm-Gg: ASbGncsFNSoldgcPDnWyFpueoJxGyUbH/NDPzj8e2Dc+xWcXefJCNSJSO20bxx8p4yi
	JT0828VwCEyhwmcowrksT0zOK11akFzzIIK4zg9FD58A4u2Xn/g1K5AatgFZ4cLIdPCirF1QUz/
	T+2hKxyhpvdFAJzsY2HmE/DbNYhd6HX13xighahDbwwlASfpKLnRvpTqWlR8DQTyJpMJ3hAYV0w
	wU0gztDzXlQDfgaKcayyeExm0Q7q0xG9Jf4QAuj58+o0I2HAkU8+lB0NBcbVDEy5k3nFPTNe+i9
	aIYAS06+gtpUiSOgYaroaZdlG0Qd19IBXCwFgoeTfTH3wAec7us53yU9SIrbbfaLffTKx4Y2ICE
	jnkF2HmKoVE0bF5GXxVF9
X-Google-Smtp-Source: AGHT+IEq206p8F2uGwDeZwxKXRAUlYLPbp4FjV/53yJ+juIVl7Tt66xCAtzYRokIGnmCbHwyGawDQA==
X-Received: by 2002:a05:6902:1505:b0:e92:fb21:7d0 with SMTP id 3f1490d57ef6-e951c2d8977mr18468370276.46.1756310041034;
        Wed, 27 Aug 2025 08:54:01 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95e48d78aesm2825101276.34.2025.08.27.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:54:00 -0700 (PDT)
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
Subject: [PATCH net-next v9 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 27 Aug 2025 08:53:34 -0700
Message-ID: <20250827155340.2738246-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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


