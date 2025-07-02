Return-Path: <netdev+bounces-203462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9718AF5FAF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19C61C46836
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74727309A7E;
	Wed,  2 Jul 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btIytsqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFC301136
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476430; cv=none; b=PgT/oFXT68UpnSxnUE2iT96rH6Ouy6qZSH0Omrk3zah7JJBmpJyxRHRdhWMg1bbxFPXDOU23XUulIRp1pAw+08MAlf1ci6M7cv6czKi546IAFDMJPYph7KUFS2KRfVaWeFhzQWrbGA5DhZZxqF6PjB0sNx7eTxD1lWkBPBLqgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476430; c=relaxed/simple;
	bh=6qt9AZK9Vn1JNcsL+IRIEXUhBdTITmG4a7Dx303xy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNCnyZSgHxeuN+h3HVYrPg5NM2Lbk8r3uIpxzzvpBLKiIRsno+tnwqoWoCDDI7QVgv0F+wIxEr2LrnFFBLhGQFVS3bGp8eTJUdplpiTcAuZljh701oJbA9lg9qIxVgQtgzKoEMKZUlf5y3irmjwLEefwVowc3QnF7OwAjRyoXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btIytsqe; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e897c8ca777so1384904276.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476428; x=1752081228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPD9Mzu+WlHfnMpji3qMnfAZFYdGUHEh+1f1qXSxDRo=;
        b=btIytsqeoBb+GwoVLQWN9n1N6At2TqlSX0VUzuyy5qZPartqbQ5pUCq8DqIZVJC7TE
         n5FOXMKPAnd7nAuq+pYAG8ADAJUppfLBM8zICWr3kBq29tyu3QYgoxxqY7SheOywTnl4
         t4tGQ5fRq2LxhBPjsFDD99Sn+Y8GG8qI65bZ0m4ePMGtOse+Rq1eezhIcRpsyrUDkJ+u
         RD9Kz8nVjUKftHeSbJtsT0eRglau9++LxAhyVWFZGI1jDJf8vezNcBl8KvyKZ99fcieq
         yR/Sb5uK9xP9thKvIHZ6KCu1wb3N6IuO24HuvhSiYkrIn4oa2FMT2zotJSfLEsQ47NBD
         uCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476428; x=1752081228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPD9Mzu+WlHfnMpji3qMnfAZFYdGUHEh+1f1qXSxDRo=;
        b=RkIOBHsNW/Ay+MAKlD96L4ut7oTn2g/dgKteQtPYdvy/MzkhyeN4yz59E3n2WPpvPz
         LxlXlQM7nT1KwEEMz/ZFxpgwcDMXV+Niw+CJoGblkeCFJCW4FvRQ1fpnL9FEOBmlWBUU
         kjjjOWmkGFoaF16yqVsbPym4fmCxBC8mLtnMQMZ5WnwEw+zbzUXOk9Bg1ecRfvijYPYs
         PLe/m/y5c4QSDrwmqMi5EpHaLVVequVCZzoXnUdLddZNr080kOWCt8MG7Gat3BQqHdt2
         OI5Hz7YJHw/uvjXGKGNtTkHX56rEj5bQ+nmxyjtSZ32GjTibWkZ8k6+oeJM9uNvyHrrB
         Y4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoWe8j1R3AGpQQu8DCpZcSbZI7cuiiTSk/zlNDnAYS6OQs2VlVpFzJ7BajGA5ZNp/v/je9pv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDtfNxSyRbvEWKkRYNy+cLe3PVIa6zS49Zk38PT9BZlT8WX8C
	N9PZEli0FQXz0kOckHwcNa3MoV8LXOzfMoWaG13X88VKiP3zcV0htYzm
X-Gm-Gg: ASbGncs9VpacLUFQK7AvHOAEcy6VI0/II9ZrtAFMgNW+v+3iurkJuHka6zkcCByZ3Jg
	f24zpYmlTl1uuxViTJhE+Dt7hsR+AsuapWNJzrJhhPmqa57zbaXCFiDzmi2rj9/dab1KCQ5QujC
	jnu0Cs57ms7nuy6tICDv7Z6Ujkn+Wd9EKpeF+WsGdbiYpdeYec9ubnjfDoBXV9sttJS4QYRV8y7
	i7RP40fjdciEwfGyD886VYC3+j2l4lya1sdI8jMAE7apefHwg7dwl4PaBHltGdlgeqKZKekQGeD
	JDD0DUJu+thPF0iDqr/oZMuNOOMB6XKcgfV1RLkvbjrWxxELQLlfCw5nsBaA
X-Google-Smtp-Source: AGHT+IH13U3undWJJmcW1GmbZEqv+QnNGHkUhNM+DTb0SttQqaGJSTvr3ti3iu/sjjSj7/hyLF5pCQ==
X-Received: by 2002:a05:690c:b90:b0:714:583:6d05 with SMTP id 00721157ae682-7164d525662mr46802567b3.32.1751476427634;
        Wed, 02 Jul 2025 10:13:47 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-715206088dfsm21522627b3.45.2025.07.02.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:46 -0700 (PDT)
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
Subject: [PATCH v3 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed,  2 Jul 2025 10:13:22 -0700
Message-ID: <20250702171326.3265825-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - patch introduced

 include/net/psp/functions.h |  1 +
 net/psp/psp_main.c          | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index afb4f5929eec..8ecc396bcfff 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -18,6 +18,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_encapsulate(struct net *net, struct sk_buff *skb,
 		     __be32 spi, u8 ver, __be16 sport);
+int psp_rcv(struct sk_buff *skb, u16 dev_id, u8 generation);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 8229a004ba6e..ec60e06cdf69 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -195,6 +195,55 @@ bool psp_encapsulate(struct net *net, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(psp_encapsulate);
 
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies.
+ */
+int psp_rcv(struct sk_buff *skb, u16 dev_id, u8 generation)
+{
+	const struct psphdr *psph;
+	int depth = 0, end_depth;
+	struct psp_skb_ext *pse;
+	struct ipv6hdr *ipv6h;
+	struct ethhdr *eth;
+	__be16 proto;
+	u32 spi;
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
+	spi = ntohl(psph->spi);
+	pse->generation = generation;
+	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	ipv6h->nexthdr = psph->nexthdr;
+	ipv6h->payload_len =
+		htons(ntohs(ipv6h->payload_len) - PSP_ENCAP_HLEN - PSP_TRL_SIZE);
+
+	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, depth);
+	skb_pull(skb, PSP_ENCAP_HLEN);
+
+	return 0;
+}
+EXPORT_SYMBOL(psp_rcv);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
-- 
2.47.1


