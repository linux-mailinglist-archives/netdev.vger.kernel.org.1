Return-Path: <netdev+bounces-215231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B486B2DB24
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B90A04897
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF16305068;
	Wed, 20 Aug 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg4Joyx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F232E7F1E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689501; cv=none; b=b8gJSwSPTmBWN690IdpzdA0wKQ/Gz/rYfSDpJ+pjBrkd8284tVlZwsRWkk0/sPxu8JKGXScDiEyyqMbV4BNyOsPTbn9rZxIEi7zjnofS03iTTo+mOUJECTeW8HCYwx4elb3SicuuSdKhzguy4ezUX1bnT2lUnzzyx3oGX3nWpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689501; c=relaxed/simple;
	bh=WhQM7iVgNtQoinyBq2uWQjoAcrkWKxNaixiVZs3LZAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFVP9Sx5kPueFsZlmM6Xa8fg6gsRrzZrMKm4g3uMU6bgq9efGXSurpqSG0/fIu1b0JF9KKwB5kfoog24mjdnDktFh+Z0s2PQuFT5BAdQ4c4rNhKjUYYiQ1iZdWg9DVZQR0GPBox6LKN3hwWPg2GQGwl1ze7peShKlLHDcMpKKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg4Joyx1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60504db9so52342987b3.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689497; x=1756294297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=dg4Joyx1+0ABaIaOAOMvax1Mewa6FSnpRcBt+UgO3qibUiOcvw7VtaRJdd/aKhq7bu
         ealG6mopSBWi4tJQIEjMMbwszMnqPR7ge9ZOXuzQ9B5pmjF8Oldb6c9pNFebO7vmc2Lr
         DJ5xyE6UZf5+pcYNJJzL9TP07euSyTvG2w+vJrUUjEjkIawdGvqf0nMMM4vda2OeAtrn
         vgWdHOEJw8O/tw/41ixdhyj39/VZZ8k4Nk8x1AQObg1AOpW8zjqJZLsbiDM3RHr1zDdn
         s+Vrzcnj4pkFg8I/cO0e/LZ0jvxp+2fTjK9rJdj+HGbzlS7BrFJPCZcMqkNkGhDLM1xY
         R5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689497; x=1756294297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=T1yLSWYLo3+2bE8lFJTmKFsK3yX2XauRuhSGqPSsTmDMmUgDJH3vvzgsXtG2XBHkyf
         ucr0+7iDtRKzRzQeMkvgt6bOxYmNpwRyTxgqTAyU/0ZOUPxFxSiOkLeUi9GMlJJqeiiJ
         TC5RjZCAk64doKCipZ8BrzkxGNY0ESt+WT//CHuEcqoH4JfW/YtIBGcJpEBbdxf1xOY3
         wq9JI1j5XqkLtupRcqt08+DwDUFIqjhyenWf7RakAmI9bls9r5LPrHWZcIDpaEUDTAf7
         fpGCrNAUwFMkVyYDpDKo5PRdfjw2tVKeQ+Uu2njVR0pHjOPLaiEIYj/n3jhI0zEOHOd8
         FlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3F79aj+CIkffcBDqYPeMmbmAW+ZxHnD+wx+HW33d6xRIZ2wUq7N6hM5YgF1b0EVjJ4aJ8xpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgBX4+4KaqQ11SyVmpL/WhJQT3FPsYc8dTu55+y629WHDKfh7
	h1Riawe/naGgFTAnQevVgwvZN23tc6A4Y6tARW2qKicJylUOdSqbnYMR
X-Gm-Gg: ASbGncuA0Lm55SIhlD2gtUranSmv5F5D94b5g07NAWAlDbsdCTUPcRQyXRe/hXJC4Zf
	ft6JaYP5h2q9jR35iYHzayItECQKTYwF1XFZNdgoRqM4NcH+1O9R3nciQCF900FfWnKAwDNXEAX
	6uOmhmCH0xiBfCZpdX4qeWg7sfOA/FEhz3yeZHpQPSFogrC/a58Uz4UML5PMOcKle9TY1CgADeU
	2Eh/xjOYD/95hIVTsHRGe8CQdvdAUXd0eoqXhWsqixOx+IGYaCaRsHoUhaFHB/Q/+o7R+hT/gtP
	rKSOvfW+vdz56IAWYiB0e73CiUa0csECOGhdT6cPDMh1NMtauDtivpR5gWWNmyywdw1CHjrpHbG
	EDLQYki/y/MVvTIzaHU4=
X-Google-Smtp-Source: AGHT+IGkq47cYJxRKXhJcinKp2eKhMG5SUcoSJ68b9CvIoljwgycstrU2sido79oF8HJG+16q+7alA==
X-Received: by 2002:a05:690c:890:b0:71c:1de5:5db4 with SMTP id 00721157ae682-71fb31d1199mr27844527b3.30.1755689496719;
        Wed, 20 Aug 2025 04:31:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm35694297b3.59.2025.08.20.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:36 -0700 (PDT)
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
Subject: [PATCH net-next v7 13/19] psp: provide encapsulation helper for drivers
Date: Wed, 20 Aug 2025 04:31:11 -0700
Message-ID: <20250820113120.992829-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
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


