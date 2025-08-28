Return-Path: <netdev+bounces-217917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0076AB3A658
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B716501A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E3334725;
	Thu, 28 Aug 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDWxmRNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4E32C324
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398613; cv=none; b=Cfhu3O4dr7sRzyJKs8o32omBa0RfhxOlbpzzq8mELmDdA1j1LY61EtIDhr4j6mZ4ETr4b3YyzuptIT1FJuAAKNcZv+jVhhd0Alk8EHy/Nj85BiSKiWaWLvkI8WPJNYI0g7Umq4iuOP3JAdlgiL22iPXmgY10CDkjwutzLPQFWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398613; c=relaxed/simple;
	bh=WhQM7iVgNtQoinyBq2uWQjoAcrkWKxNaixiVZs3LZAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA55GAySwH2o59wXgeHESIZWBZJJAxqTwqhThQDT8ZY1UVZqlbPgvymvNEKXcPejCDABoc0/c2Xl53d7Damz0DAsf1+lNMZ3ADNrMSAprTnp7c6J1mYu8ccd4MbP3M0fY6qbw4hya+klPUB2Cew9pAE+zqtvfRwZv/1//bDy2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDWxmRNx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72199d5a30aso2356067b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398611; x=1757003411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=PDWxmRNxxpCt30PtPDlGuULL3VTkUDO8ZDYP07CplqRNocoIYBkcTsYYASdGp4XXdd
         Op30hWI1b7qiuub5UnooKMSRPTEYLAOTnTlzymT/wiu3alXDf/X2YiN2+m/IQBb/wM7r
         6rLukx8OvuaHoUqTwp7eJ4vdmwuNoV+PbIcG6W7YpxOGiczqwgKOPR6s8vBfhBzjKw9L
         z0lMhTeG//Cs7F6hcearmJDWOl2ZNQHAf+6NjIK6ad/mV/rKXbydDKm32SuK3zYg7VJB
         KN4nehXpMVwpOIggE4L29j45PIw+JYnO7KHAnKm5y66AFTBFVfU4LRukYtbb4+X1tGjb
         bP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398611; x=1757003411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=Z8T9NdjdOH8mhvDUU6BFbtSjuj/xG+BDUUm3Wy1cbmb9AWNQNLxxPQbur2iFXhyNcH
         JZ5WHCY/DsUvEkWJlvAqvbh+Zxgsy4V4yv0q1WpwKrGcd0kHuB/3R9CUo5OKQ6aitxE8
         dRuJbrvDaifgEiccMY1uxe9kUrCknXOKtICMIE7MjLFsGG9GwvmYjAqc7iJN8BjAX+RJ
         v5KrGrW6iTDuXIWTxdNrlQ8o24MHEezPMd51r46VXn5MOqLcGsJd1U8lFaNOlCFOfaTl
         k2jsqbff9zA7cyehB6zEjPleAxPbHIQqgHfmdTTFgnFme+PhrWIN+TSVFndADg2if9wL
         dFrA==
X-Forwarded-Encrypted: i=1; AJvYcCVHFz68Xx5EeDNY6psWhtvSBrOS85hI0B2g4SEm3Lsk/kht2xRZZbD67RYmVDYU5lYonqzyrQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNvDc+bmZBudzRaCH6lBkDUIklOxO8cK91ezZ69IkQhJ3riTM
	92GxtwCnaAwJj0qhj25gO5Yyk2dHJjwIRw+5FawVHc/uPVErRZPzzk1k
X-Gm-Gg: ASbGncv4zsai6BhWkrI9jcA5iW1J3AUs5/eeSIMfWaP5z3MRsppNVt41BH6ZIn8QJ8b
	lHSDQW4KBuKmPIC+0zyI92S13G3i8bYHSeqAasMIQtbvnESsBhQBhwFcKSG9+q7ZeMRdWhvcLxb
	Vj1/pqHzfl6Sh4H11d628/NPnkw4rkzlb38k4Tn1EsgcUA8U0G2rvbyG2N9dohSZQdu5upqLTv4
	/iGb8iY+XQcZx9YNwacVJBvYUrOmqlp+fjnjFPt9+ZWyM1ecRtpMIj9tV2mto1LUmhNZDTpnKJb
	VUK07w9h4wzISKQe/vFhxi1LOaGdrj+ovM4KNHj8seeQrzJerShucecPjB1h9H5vWyOO7QdXQbb
	KPHtItEg/wxFDKGLUj7ZE
X-Google-Smtp-Source: AGHT+IHIOzE+x34YRD29DY0hYMDGwglePfrpNpZuIWVJA5Ky3CBBXoeaflOcBKwd4juVtwKnTE8hJQ==
X-Received: by 2002:a05:690c:3604:b0:720:8ff:58e5 with SMTP id 00721157ae682-72008ff5aa6mr175171157b3.40.1756398610239;
        Thu, 28 Aug 2025 09:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce6138d6sm394477b3.72.2025.08.28.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:09 -0700 (PDT)
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
Subject: [PATCH net-next v10 13/19] psp: provide encapsulation helper for drivers
Date: Thu, 28 Aug 2025 09:29:39 -0700
Message-ID: <20250828162953.2707727-14-daniel.zahka@gmail.com>
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

Create a new function psp_encapsulate(), which takes a TCP packet and
PSP encapsulates it according to the "Transport Mode Packet Format"
section of the PSP Architecture Specification.

psp_encapsulate() does not push a PSP trailer onto the skb. Only IPv6
is supported. Virtualization cookie is not included.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v4:
    - rename psp_encapsulate() to psp_dev_encapsulate()
    v3:
    - patch introduced

 include/net/psp/functions.h |  2 ++
 include/net/psp/types.h     |  2 ++
 net/psp/psp_main.c          | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 958c50dad34d..e8c2201814d5 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -17,6 +17,8 @@ struct psp_dev *
 psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
+bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
+			 __be32 spi, u8 ver, __be16 sport);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index ec218747ced0..d9688e66cf09 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -20,6 +20,8 @@ struct psphdr {
 	__be64	vc[]; /* optional */
 };
 
+#define PSP_ENCAP_HLEN (sizeof(struct udphdr) + sizeof(struct psphdr))
+
 #define PSP_SPI_KEY_ID		GENMASK(30, 0)
 #define PSP_SPI_KEY_PHASE	BIT(31)
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 98ad8c85b58e..40eb0b396b0e 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/xarray.h>
 #include <net/net_namespace.h>
 #include <net/psp.h>
+#include <net/udp.h>
 
 #include "psp.h"
 #include "psp-nl-gen.h"
@@ -158,6 +160,61 @@ unsigned int psp_key_size(u32 version)
 }
 EXPORT_SYMBOL(psp_key_size);
 
+static void psp_write_headers(struct net *net, struct sk_buff *skb,
+			      __be32 spi, u8 ver, unsigned int udp_len,
+			      __be16 sport)
+{
+	struct udphdr *uh = udp_hdr(skb);
+	struct psphdr *psph = (struct psphdr *)(uh + 1);
+
+	uh->dest = htons(PSP_DEFAULT_UDP_PORT);
+	uh->source = udp_flow_src_port(net, skb, 0, 0, false);
+	uh->check = 0;
+	uh->len = htons(udp_len);
+
+	psph->nexthdr = IPPROTO_TCP;
+	psph->hdrlen = PSP_HDRLEN_NOOPT;
+	psph->crypt_offset = 0;
+	psph->verfl = FIELD_PREP(PSPHDR_VERFL_VERSION, ver) |
+		      FIELD_PREP(PSPHDR_VERFL_ONE, 1);
+	psph->spi = spi;
+	memset(&psph->iv, 0, sizeof(psph->iv));
+}
+
+/* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and filling
+ * them in.
+ */
+bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb,
+			 __be32 spi, u8 ver, __be16 sport)
+{
+	u32 network_len = skb_network_header_len(skb);
+	u32 ethr_len = skb_mac_header_len(skb);
+	u32 bufflen = ethr_len + network_len;
+	struct ipv6hdr *ip6;
+
+	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
+		return false;
+
+	skb_push(skb, PSP_ENCAP_HLEN);
+	skb->mac_header		-= PSP_ENCAP_HLEN;
+	skb->network_header	-= PSP_ENCAP_HLEN;
+	skb->transport_header	-= PSP_ENCAP_HLEN;
+	memmove(skb->data, skb->data + PSP_ENCAP_HLEN, bufflen);
+
+	ip6 = ipv6_hdr(skb);
+	skb_set_inner_ipproto(skb, IPPROTO_TCP);
+	ip6->nexthdr = IPPROTO_UDP;
+	be16_add_cpu(&ip6->payload_len, PSP_ENCAP_HLEN);
+
+	skb_set_inner_transport_header(skb, skb_transport_offset(skb) + PSP_ENCAP_HLEN);
+	skb->encapsulation = 1;
+	psp_write_headers(net, skb, spi, ver,
+			  skb->len - skb_transport_offset(skb), sport);
+
+	return true;
+}
+EXPORT_SYMBOL(psp_dev_encapsulate);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
-- 
2.47.3


