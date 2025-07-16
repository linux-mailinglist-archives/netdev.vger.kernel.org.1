Return-Path: <netdev+bounces-207497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CEB07887
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586517BCABD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8BA2F4A11;
	Wed, 16 Jul 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJPg9xQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7582F4300
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677181; cv=none; b=ciNzAe50n5C9MmqIdPMskcVnsK6vzYAH8efevyTf/Do/C2mMcmzBL/XpDmNqXi6TnqBW/a7fw66weVU2YDFkb3ZqHBRHMn3J0AnhUmdndJfiFSARcZ1T4YmZ2jmVLRyJzlEKn2wM9eL/Q0uTycNkNlgadVWQPhX4QEqk7elNJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677181; c=relaxed/simple;
	bh=Wd7S220sdAw/h24Lm0mCePZrgeTuVkKxnWPvMZETiu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC8KDiwpoQT64jrJ0EvZ1SQ3sVgUAm3VQ+53mVvOA14suc3luTJ2B4x7d6O5aX7bzvrfNkuCoLuALuQXF4BycmK97V35OynmreTJ+Y+NZOPFLy58wDJZrNw+Ce2iXs3hDc8hiytfBq86oCfI/oteT15I2eie9VVvEHz47qSiwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJPg9xQ+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8bcfaaaacaso410848276.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677177; x=1753281977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=EJPg9xQ+3h3N2+XCvc9g5igvfVUTg36YMZ85FDAU/VBVBDqWxHLYzZreQv1UBrh2LR
         qMrCKGUwyQdPqMaVRyU3zf4b99JTK/Z6kzquqIkzx0w71WgQL6XQVziaCSDgrwcQVJsz
         fi6WfpGHffL5nHKP1Trz+5HRQrt9VPx+jE2YyIuABAfzNcjAfpb5w9qdQf64jUT11sOs
         sJ3Pz5JTZCNked4T8tSNuU6x1ZJ41jaR26axkNAOdzG0qbCCzZvzoE+oAVskYa8Ag56J
         3pVcOh5MiMHqbjzuC4aqbrgAeOyX82bIxXfyyQO48r0AvyDOQlXYP0djg2p7rpx54xtk
         ztcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677177; x=1753281977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=LZqqWHUJgHsV8P6rH5YxRb+yrIaKNVrR+syM+9M7ndOwn/kM80kmAR9GXWvOkFSYGE
         B3vQ//PlAO/5x7vDNKwTZsntDGBZS7OiZd51nSyp6nrNE9AI+1n2RZHyxo5kT/XLH/6L
         /m5oXf1eJS/v3xW6FqkuhR/KabSWQvR/RTQfV6q88lAwVWItJVqpLsyTx1w2zwphtFH+
         AEaAj50qp4PaNxdkqfPQXH7GNtxc+92+N2cVPzTwqVMHVj6kfGAcuGBaNZnh8dBAyOQN
         Qfh+ggYncP8+pxkkMqNseE0XzHFk+wuSCnY+6U0LG684xFWgnBoubTgGzBp97V02D78+
         rb0g==
X-Forwarded-Encrypted: i=1; AJvYcCV5BWY7Ggbebgz4pVYr6uYGO8yjMGD5UoXTNNL8oWOQX2k2vHm5J1iinGGs9WeZZ36QGRkNZ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLv83JrY9cldwmMmsROjDQwv86POZ/OaBjl9PXGZCwmfT4iWM
	BV/FJat99rq9swhMZ0C+mL77qV6XecmG045W4fm6K2O7zzUER8Fc32yz
X-Gm-Gg: ASbGncu9B85E0/vwwvpfrW99ZRh7ttyn3NvjJaheSgANkqg63vZkVC7RFwbZEtwF/CM
	d+bTTFx3pPwUE3u+qJ7fq7v4vWyiShqkqARHO/nfqTh8tEeP8onRiwxTdKgUgY+swq9Rx33rNKL
	QF41I0mODmN83BO2Z4g2b6E0BkXoHy90kdkwrM1bXJ70TMqcDT/c5o5S0fF0d1Wg4MIysC2reXD
	YQgpFBK4lwf0+oVuSlquskEIW1Yv8CgnKYLN2Me9SMrAlqvvTZNHJDvGGZV5ke02L9hRq8QR8qn
	YW+XXEZ6Z1+ad4SfVSsOCKpDcCJbfgaJBFzkXUzsKZr1jbs6AXfPkjg3SaaSjzk1figV1dxewFv
	58ktXPqWunouwhN0sVQsrVT9Tu5xZFaI=
X-Google-Smtp-Source: AGHT+IGSVtp15kWamj4VwwhaqXo/D0iHM89juz3R1iP8tzv0Vpef/jGAcsIj9bCsn4JJI55LSsZjMQ==
X-Received: by 2002:a05:690c:6504:b0:70f:6ec6:62b3 with SMTP id 00721157ae682-7183515bbd1mr52438897b3.26.1752677177392;
        Wed, 16 Jul 2025 07:46:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71816084317sm12588747b3.84.2025.07.16.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 13/19] psp: provide encapsulation helper for drivers
Date: Wed, 16 Jul 2025 07:45:34 -0700
Message-ID: <20250716144551.3646755-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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
index 17642c944620..460af903a35a 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -16,6 +16,8 @@ struct psp_dev *
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
2.47.1


