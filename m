Return-Path: <netdev+bounces-223283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089ABB588E4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A16C2A0340
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472581A9FA1;
	Tue, 16 Sep 2025 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnfTSRLv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233831CD2C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981175; cv=none; b=b9IxlFLu2QpxhzzUWfJ7k/CCM27hoxSsxNkickBU7dS7Oxa0azLowehR+9S6DQRE3SMISx5CJIC3w4l4hzbYH+d0flunS0gq2LSOyIk+0SBLqKquDo6oGDcGFg+1VolXxyb31VwTk9nVFLOyEa3IsXgRRMw2nxzZnj5WGt1eb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981175; c=relaxed/simple;
	bh=Hhz7qk2rHspMAYXNAf6ndelJ4FS5D55YuGCcXmepCpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVt8vQVK3oCwkTJAGre7Tbv8KHewHq9rM0Q2HrR8Bogz5311QdfKJjGx2/ROV19DqRe/N2Ip7X7FRPFUprAq7RNODz3QvD1bwr8clUgXbXAcpPslIsGZhtURnXp8WeP1kNqkBMFzC1nuWurTCP/AT7svKTBU1aPugkwl5PCS3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnfTSRLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D8C4CEF9;
	Tue, 16 Sep 2025 00:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981175;
	bh=Hhz7qk2rHspMAYXNAf6ndelJ4FS5D55YuGCcXmepCpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnfTSRLv9OdX4GgRDKkYbRverg9GIJYy/5/sxZLNAhlW2QXAObRZN8BoU8v/8bBsF
	 uoISThuAYlEjI5lxtB0gREs3GcweDJ3Uze3oQadXKx2jBpw+Z6xncXW+NqkF8tZTyR
	 g4P3I4c3otMzR9I0QOV7hMhAhZEV113kgx6jnaB0q1D5Csi3eBFKV9IiPoF7Lym6gh
	 9RN5FSvcIOjX2MNvdRqwbvWTEAJgjMl1OsPxs/GtjKlCrMMfjXhvJZ0tqfRyaBvo6A
	 7SLK0ksPl/i/vS4waFhnLzix7hqbJK7TFpyTQQ/A+4sC8QzZ3Je71r8MYxYAxkBYUj
	 WCCVL7wn9TJiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Raed Salem <raeds@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 13/19] psp: provide encapsulation helper for drivers
Date: Mon, 15 Sep 2025 17:05:53 -0700
Message-ID: <20250916000559.1320151-14-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
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

psp_encapsulate() does not push a PSP trailer onto the skb. Both IPv6
and IPv4 are supported. Virtualization cookie is not included.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v11:
    - support IPv4 in psp_dev_encapsualate()
    v4:
    - rename psp_encapsulate() to psp_dev_encapsulate()
    v3:
    - patch introduced
---
 include/net/psp/types.h     |  2 ++
 include/net/psp/functions.h |  2 ++
 net/psp/psp_main.c          | 65 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

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
 
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 183a3c9216b7..0a539e1b39f4 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -17,6 +17,8 @@ struct psp_dev *
 psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
+bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
+			 u8 ver, __be16 sport);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 98ad8c85b58e..e026880fa1a2 100644
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
@@ -158,6 +160,69 @@ unsigned int psp_key_size(u32 version)
 }
 EXPORT_SYMBOL(psp_key_size);
 
+static void psp_write_headers(struct net *net, struct sk_buff *skb, __be32 spi,
+			      u8 ver, unsigned int udp_len, __be16 sport)
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
+bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
+			 u8 ver, __be16 sport)
+{
+	u32 network_len = skb_network_header_len(skb);
+	u32 ethr_len = skb_mac_header_len(skb);
+	u32 bufflen = ethr_len + network_len;
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
+	if (skb->protocol == htons(ETH_P_IP)) {
+		ip_hdr(skb)->protocol = IPPROTO_UDP;
+		be16_add_cpu(&ip_hdr(skb)->tot_len, PSP_ENCAP_HLEN);
+		ip_hdr(skb)->check = 0;
+		ip_hdr(skb)->check =
+			ip_fast_csum((u8 *)ip_hdr(skb), ip_hdr(skb)->ihl);
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		ipv6_hdr(skb)->nexthdr = IPPROTO_UDP;
+		be16_add_cpu(&ipv6_hdr(skb)->payload_len, PSP_ENCAP_HLEN);
+	} else {
+		return false;
+	}
+
+	skb_set_inner_ipproto(skb, IPPROTO_TCP);
+	skb_set_inner_transport_header(skb, skb_transport_offset(skb) +
+						    PSP_ENCAP_HLEN);
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
2.51.0


