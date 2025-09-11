Return-Path: <netdev+bounces-221942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33019B52608
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22FC1C83B9E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD9264F99;
	Thu, 11 Sep 2025 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsStRwol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524B25F963
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555285; cv=none; b=aIhHZfam+IkxEGbJlcRa+q8LQCYXkwd9XtsgNDMAFt+brHQ1VyRBhTCBFQ5vUQAqev3jGC0cRTYc5QVZYq36xI9ft7OwVm8hZ2P6tBFn9BSrHjvtIdsjt87w2+mizILDfzq/L4omg3QXeW+pEKtRXrkRBTzt9UGYGP6FK8lahUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555285; c=relaxed/simple;
	bh=nh+Jt2BZuwU9nJydOubi1FfHRgLwzJflWQ2qqHZ6n8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcojN9dN+wQ52cAtHoBbRnI5yangCZh/+cwCkEYnFayYl1sAp8Ji5FT7kttuWSy4R/tK5hkpQRuxSWEgdmswLV2qbmpHHvc3Q+nOc3abKX9oAmD1lQDe3Y6GPceRt6d2Ul33/8vyLRXWx322NpPemrzQGqx4tOY6+xWIUTYj+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsStRwol; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcab69so1706617b3.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555283; x=1758160083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fApwIF4D8JplyJ/cOuGEEuLjKMoHSUvrBQQ+Ym2esuo=;
        b=CsStRwolO/1y2TIW+tuOQpMNlo2w+ak7V/OWLi8+nFDZQZgflTbuCFOhhcMDhMelRu
         58TR3AA3oPbk+8MzLyMPhkCgwYN1EWmdC/I0eMK5QN0DTjvWGIdfZ4cYaVxvYSC5UJTQ
         0ZSQLjXyPlxqj7XSa3qrMHwuCfu6EvtRhDt7EajvGDp0u+y1EQ9+SCncHBtMScGjln8V
         EsP2HeS4kAdAUYPBTQDx1dxH1sIsMDBG/mTXO1OZtFs4sf8DSufW2GyLlvHrj1RkfGG3
         epXqeN3ZxtY18RSdsYdXTs8CFeDMxyibfYFa3rZI23ulXXHALPxxAFCfrqGvu7kiU7+I
         ZAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555283; x=1758160083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fApwIF4D8JplyJ/cOuGEEuLjKMoHSUvrBQQ+Ym2esuo=;
        b=bu1jABNPGAxrAzgy79aBCUZs7dyEUnnzJMTO/7QRmsQSqZ05GSOcAkhjuLI1KaQnkF
         KE/EMXhc0mbf5phq7cujaVKez/Ga6hj5mcqd3gRzsc6IRq+YRUnjV+mo1ZyjA2V1cOQt
         K0nzKEkGCfWEmkvCSE8Idpu4iGw70HC28qNkfCPYjvmQ6I0rhHDuToydjlIogiYfUcOY
         SWJXVJVmKNzRAffQYDf5TJd+eU8Jabb38dZ2vn6koPACjAkogHTl5v4V9i1/U3dZDkGi
         8kQ1iBUNLtpgWSSGqlanfNJUdPhs6eTsadCwO7ywmRXv89i6Diyaf0z4/+WOMrIzS0+e
         sKcw==
X-Forwarded-Encrypted: i=1; AJvYcCW8J7GBxaZf2CTH/1ssmus1Nt/TCmqsy2qKEPUUOZ9FtvLtCrOUoJ196B9pmiw6wluihKANjas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxadz4xPsmQTOTd9fz5EpEg9SL8TuakZkpFAcLZmEJ9CwIycpQ2
	Yv3ccnNPcGCEqN9TaPYFjYGg0B4UoBkckUGWE9b10Fhj+JSIzmCJWl26
X-Gm-Gg: ASbGnctw0WjWkLsqEa+6pUYgIMdfaBqkhqhp7cbkk18q6PZJaeuKzVUEcOfvDUqXsOB
	iLoPNB8yZ9lF14VtFBYs0ZooGeCu/jglCGmuqhonACmpZzFGDfpVdlZMtYP1+27RSB/LwccvAAQ
	zzczSoOAoiE+uCna0Y+Bdln/rwbnhc/Jz1q44KiIhdpqpH2asQH3ZxEBn5qhSDJSAmJodB5xu9p
	0cd5+cyPRGC9K3UbpBsAsRJ6zGEPF5Q1pe+mumm3ymrE3LjrMCK2+hZkCGN/Vqq62BY8qfvPe+e
	XpO1gVtx64WUhhxdpSM0Fszv042LirIsrPp3ov3eqlT5v0mLnQkKrDH+3fPigKeLxZ/X+/Kh+3o
	3v0en6TbZ89aZCiBOryyPD1cdfJHvuEk=
X-Google-Smtp-Source: AGHT+IEMBFxREzFNeKOel1SQ4aBnByJG/kHnkZOWGZWxK5ZpAB55Ke+YhnCkbxebpoEImLeygofOFw==
X-Received: by 2002:a05:690c:3392:b0:726:bba4:dd50 with SMTP id 00721157ae682-727f27dbf83mr136205137b3.8.1757555282963;
        Wed, 10 Sep 2025 18:48:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f769292d4sm380587b3.27.2025.09.10.18.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:48:02 -0700 (PDT)
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
Subject: [PATCH net-next v11 17/19] psp: provide decapsulation and receive helper for drivers
Date: Wed, 10 Sep 2025 18:47:25 -0700
Message-ID: <20250911014735.118695-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
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
2.47.3


