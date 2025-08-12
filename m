Return-Path: <netdev+bounces-212691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03195B219D2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A846231C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6B2DBF5E;
	Tue, 12 Aug 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0LRAlAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF02D838C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958633; cv=none; b=Adtur5kvbhLoThLqWrPCIdNJ/ZcKxEh9BECZDsMsqd+UFPqdKaLjCpYaXHqQagZ/D56ljoArBJrWAW8m+vV6yZaqnie8CSp+awX+aF8wcd9Ze1SGOBpdqIF6pxNb9ze3zg0Skejy2rEV8GmUSDSlqmMmWyY2Tbz43sJZMlz8T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958633; c=relaxed/simple;
	bh=H1aJvlxUlAFmAlQct6oBf81u5xPJoNdX0Mul6YMKhOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0gCZGyK+8Je+XT/V6IK/ikS2wplpX8iVYTIXuQqgdt68FsomvEVQxFoP67pBBYjanjCg4JflqySEYoOiqtCCQw8HWRywd1pKNU8HilSFVeY6B9NIGgd7SH69aPW4Qp6uribnTensnV31Mi1J+wEq2G2ZZ+tjw45fGaklWMzeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0LRAlAy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71c075c3873so11462007b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958631; x=1755563431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNZfxIUXFZVoKf7MpOHfZ+xpEAluycI8bwS+pd5Rk04=;
        b=R0LRAlAyMRzKX4pA+9/RWq1VSFfQsH6gw2MXJy8ruLMc1B+IyuT3tnWC32biyAAf24
         wV4vgt/VZTYKnCtBhT1LeoGMp6Ct4av5aNB+QhLkeJ67N6QuXyjc6OZTvWRLQguuPBoi
         UawsvM1isEUEoUvOw5xfXcfSjQ1W55bqgmCrzEBfUnbfEpM11z/agU3jBV05tIu/lImz
         UOe+MAwlc1nIvwoLcVzpW3t2mxcLaSbhEI6jXE3CxsxrQsNVNnYyvwKx5JMHlRjRvXdX
         l4gxbkiMorcCrQOnY8W+teuy9JV/pD0sIF8oAlWa5wucgUetj13Hke/V7nSq+bGIRojq
         jW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958631; x=1755563431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNZfxIUXFZVoKf7MpOHfZ+xpEAluycI8bwS+pd5Rk04=;
        b=DvDINoD+YaKwF1DMGp9oHu85admT1FWpf04xpU5W8p2ap0VmcWvIEY/mlY80K4lWtk
         jEtEY1Fh95+7b7BhhceMcIFSyuzDYaNOMjcvFWDlcTTMh9z6aOChiP3v9GWnkWqDKXVO
         h3xzMH5nDsIWA+nv3IWdu96hBwPEgnRVK1LcmgMNhaLdutGEkeacxTABj8hwpI0vIvA7
         C4bIgWDPXPFQBhgKO6rOhwp/uRFmXIH2l9Huf/77tq2T3vGmdQaee93TbI+RXdJiNlw/
         iJVAxgCZhY/T8EcbVy1121R2izOnYZex8qxJEtabUDd92zhPB3oPy1+WFI4fLIWtRtVy
         6zlw==
X-Forwarded-Encrypted: i=1; AJvYcCXFRTgsdWz/DdHX50aLbvez8oc312f8nXyGptr1aMVq4Vr8mYTpNXQTxJDmkwv4ITAZM0RtHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9yKKR/JbH955Nl8uu82YWOXPAqw7PWy3PVCDiHmwrb9xtiVf
	SLC1xdG8A3+Z8PcL15LO1uip+ZzlP7dDLVpgP4XNyQk/bTPDRvHxMIwiKFo8ng==
X-Gm-Gg: ASbGncuhdaG+kWKFd0FT1S+xPpU7kSAOnaeT3ryxE7e3jKKp9vmlYqFGuAHUgO2SAcE
	Xh8GIv7EW9rpe8B8ja6kwVFqlW3HiPGvTPTzezQ9hc1cQf95GRmNMAERM8RyoflFwuJdlCgQVnn
	rxoOi5LNxysqp/YtFSTH2tz8V6UciCaA4/2UzIRzUMHeltm23CMVdmTrPQb01P709Q+WuWKHhUM
	NhGja2D430QQFb/kr3HkofSYuh+riSad3EcuXde4dGuJO2Jw2ewWg5ZqpxguBHXq/8uIajtnYGR
	Rs9Twc3uWHH9DRvVUk0jVoeHOnHI76+/Vd0jVCaUGOa5/FazNlXzJUTA2J4/BKoafo7eJdIsosD
	DFQ5/0+c42WKTe+C0AlpIK0W4LD5y4ng=
X-Google-Smtp-Source: AGHT+IGgvCGsU3oaCBPTG3KpaL47OhyM8YAFTL4VgHRHmba6y/nBQeqxiNervMpF6v52HpwbtrCjqQ==
X-Received: by 2002:a05:690c:6501:b0:71c:1de5:5da5 with SMTP id 00721157ae682-71c1de5fb14mr82488917b3.38.1754958630981;
        Mon, 11 Aug 2025 17:30:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9ad2sm73171007b3.3.2025.08.11.17.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:30 -0700 (PDT)
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
Subject: [PATCH net-next v6 17/19] psp: provide decapsulation and receive helper for drivers
Date: Mon, 11 Aug 2025 17:30:04 -0700
Message-ID: <20250812003009.2455540-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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
2.47.3


