Return-Path: <netdev+bounces-212687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69822B219CF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316254286AB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80452D77E1;
	Tue, 12 Aug 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnIhKQME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3C1F936
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958628; cv=none; b=q6vpSqORmdzCt6g7fDKjP4cEN7moiLLTJ5WxdwXUCqSuGmOlBnlmCm8aWTlJmmbjOAndXeRt1Vuy3Jkl6Y7uIFT8CIfksSJ6M9eeF9w+7nMQEydxrmmU9zA1qIo70hppOiwjFfVx2EO/4JSwv31i4sLO41bXdlD94TlZc0wz9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958628; c=relaxed/simple;
	bh=2fH4oDjMLo5RfI/5DaASJ4ftN6Vc69Mad4MPRF1pEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8Sh+ZuE86QLizZbyW2eL4P/e59uA/9jBaYxBLcUayruYLWXgYiIA759tT8t9CxrE5bf79I3AHFwznyuHuY3GzwBuYDW1VUU3Y/0/zp2N6EX0bD/9I+7S1vC5jwSEzG68EzPTNmwD/07a4vK41cVakpbXWNnlY1DFms2EEiVI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnIhKQME; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71bfdf75cd2so21914447b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958626; x=1755563426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHclVgtmKWsjY4tv+R4efQqohHOqMEvOR3np+AUA8zQ=;
        b=MnIhKQMEnN563LrWn+aJjh13nGw6XOjlORPvj7fHP7/apV8RqLiYseAAgm3FooTPKo
         dVUxByK7dDJA8j6jDDW09OCy6qi32PhPrd/rwHm9ZooAxgv9nuaBrPCZUBEpyMCLdG3O
         NrlV1vOlZoy6/pyR3qDWoSLJUlKZ1Wsp+VGnnkIG928Gjwr+oObIC/NW3/vOCkgd2Bfy
         0nlG4E0aTMKA3sOFT2T1FEvG5efFExjAmqbvSKHO4Zf3+4QMDkO0rdjrMs6LfD+9nJkW
         nDuBXaIJoYjPJzn/wAD1FSCEREzK5LIIlJ0mRdt7i3J52ecKUDovcDHrflX7Nle7BkM4
         pLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958626; x=1755563426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHclVgtmKWsjY4tv+R4efQqohHOqMEvOR3np+AUA8zQ=;
        b=Cl6b1XcERT5ODjyN/5qprb5CC53WSYpC597uEEbFiQu0Mcb5tVVEd/cpCmR+3B6B2k
         3vGWX8SxmuOGWAzHzoIkzESb5HrQn8ENlPpjK1OhZbhD3CWMZp27xzEa3NLwfDqYYwZq
         J2r/YT+blbRDCaAYMa5RDOqRNZiNNMhNucDrKpodS9R6kea+xAxx3jwqpou8Nl1wzPcV
         QQ77QMNwM5y1Tx4p30Gp16AWSzhtgK5TmE53DuomDq6HI6Tmnim4KSBvNDn3NUPfIz+W
         XBUdK9uOE46mN5BkoKsugJyE3YmLHBD2nop0APh+tC3xSKju5GWFx28HSVmP3DVhfCYF
         E6cg==
X-Forwarded-Encrypted: i=1; AJvYcCWBrjeyVzoZ22/c0q55OwovCCiIH5oQ6Az20Ond26T7WlQU+eV7aWHLCrTWyF4/1iy50BCNEDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXytPbYUPUH/0hHX7lk9rA0m+hqT8+LU/0Vc7KZP+bYfEPriJh
	93KETdTxFboo09IdsIQx2TERqfS5iNhs/cj5fDcJ6idkHHju96zmdXZc
X-Gm-Gg: ASbGncuJ8/oTVZOgddTgwCcho368sY3wOnOFFaNDiIIk+GMrYUR+wjvaSyDDwpriRm3
	0GJvG1e+zcJTP3MlJC4RufHIvjHZsGrDKY9csV2llCfoZ4jZ52ZX1pLmf6jLfBA3LJGy5ouu+0I
	B4rZmizTlOTRlD/ISh1pH7hCoRM51jn+arzMx8P1KtD9seO6CPFWzaOTriq+tKaRVJ6YysFaReO
	fjF/JQnR9hG922dybO64mmQluVx2esCEN7oYHsFhLXpfjyMyprvJMY4i8gGJS7qNMHeykxuWIZs
	I5VgJo9HjkzSdRAVneWdsbntdhwVnx8yOxHWWcVMQF6EEBSiF1VjM4hyJJ9AbuKko2RdCi97Ag6
	6HBpABLy7W7phHWjm2X9j
X-Google-Smtp-Source: AGHT+IGQnJ0neyDq2+0OIGGAOIpq3aalD6pIjkXxOHpTvPcD1rxRXXoaX6qed/HmhJ41+nniqMZWXA==
X-Received: by 2002:a05:690c:4442:b0:71a:30c4:43da with SMTP id 00721157ae682-71c42f5100amr19651117b3.13.1754958625991;
        Mon, 11 Aug 2025 17:30:25 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bf4f92b25sm23907337b3.39.2025.08.11.17.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:25 -0700 (PDT)
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
Subject: [PATCH net-next v6 13/19] psp: provide encapsulation helper for drivers
Date: Mon, 11 Aug 2025 17:30:00 -0700
Message-ID: <20250812003009.2455540-14-daniel.zahka@gmail.com>
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
index 0fdfe6f65f87..434ff6dac18f 100644
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
@@ -153,6 +155,61 @@ unsigned int psp_key_size(u32 version)
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


