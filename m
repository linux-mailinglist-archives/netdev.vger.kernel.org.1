Return-Path: <netdev+bounces-221938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB51B52603
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C7E7B05BA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35761258EF9;
	Thu, 11 Sep 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GReKxtsM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68366221540
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555280; cv=none; b=qFEHiC07GOX36T0KVF+dbLvsPilwe4DTez+NzfklttL/3Q69iYs/px2Ra1Q/XK+AxB8KAbhmiL8hHfUtOgnCR4EFM9FEXCEM7FkvvY/M4fs+6QQ/Yx9BI1LQMRNHOG9wF6I675eNb7n1TtuwGd0ePDpYTUXjq77/fawvLcolmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555280; c=relaxed/simple;
	bh=mTYUv6iGXiGkNL3aquxE4pWoG8xRHVN6TZkadUeYABs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hotEHnhmTIqD4DpGZ7r48aG8lUUe9rvFkfFR5qpNb3vjBhzuFVLfeboJ6LMNhujxHFD+BpLTDjih+Gk1zDjeWJaDR9DTIZEmARbve2SiwU0If7rKQKEy07MKWulMzC6pyVNW14PEv/PPzXD4Gq9a37qsMXLyokrpvE3NoEFuv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GReKxtsM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso125840276.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555277; x=1758160077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZ2u60Qfm3Jvl+0zRc0XXhonWulKZA3HSXw7sEIVrs=;
        b=GReKxtsMufYh+vX0cju6apG0TmWlP1XpmJw3IcdlQ1Fr76XvqhLWjxDSCXRjHWwWnw
         ho5vAuSwwvNTF/AGAzgjxRSF4SxRjO7JkwsoVu+E9gUc+vI2GALZnri9kbh4P7e7knTG
         e8nV3XW7A0ZvycwYvWwyOyvuR2oRm9no/eG5OCmEkzWgDHlAzvx0monbzxZAY/jlCq+p
         ajzoNX0olkkgI5zuMljpjZCVr0e8Ad2xY3kGC0+n3QWrEZPBz349CqczVXMMHjyCzfry
         GN4sC5n+2KU6Ct08sI56JPI8WzdI+7Ipmrx9zaX+Kk+iOo2qgp7h1ikd5PDdLKjPDUZx
         T1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555277; x=1758160077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHZ2u60Qfm3Jvl+0zRc0XXhonWulKZA3HSXw7sEIVrs=;
        b=lhu4ruidq8VrU16DsDiHtPUWD/R6B1yuUw+ewgzpA6iLyDG/XV22bb4A8OmE1NpgeW
         1p7ogYKDwADTHlO1nHDJM+2UU6WUVKvCl1sAyEg5ovemYVHg/oQAnAGdAw9a73+ZVzSX
         JGldmbfVjL9JUpCY/Y/kjsbFutfrVpO3nuyl1TMMrLJeT5utmow37q+QD006mYQWI8KC
         HbpKgKQgNaSWCZeDKw+v8dWqPa2ZOHx8D+aEY7yDodzApHqU8aXy79DuAbyaKKebVyO8
         3JV6KXqDdUi+yO8AozTzrsF05iqqGnjh3b/m67GB2rnCTYo12Ef3nHvsXW3ffe3DENAz
         qBRg==
X-Forwarded-Encrypted: i=1; AJvYcCWjMcLN6LUC0cKQRwdRHeutS/Lbi8xWJ2HqHBuu5YMsky43z6b3DChMKbJ4Hifs1+R8hp1TcCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUNpFC0ZFcBM5rEnTKbyqXcVzAyL4Jo7AAwXFvHooTBWLO1ty
	yyCJT/jbiEvCpYjExRo4WQUlF/lwv8Ntofh77FdaT11E3+EdrT6zPEIF
X-Gm-Gg: ASbGncufmFDUFaXN8uRstrZ8UbXifh9YDOv/Yi6brq5+B7FHwikNKLrZs9aOndYpPH5
	TrNyapugzJq34tFAhG6/dP815XkMsc8FkD8ys7ToVQqY1ZNwb9zBGM/mWEXLMbGCZ3qSLcQrUOK
	CsnC/ajZ2Qh3izYQmL9pJ7Yq/oZyheN7e0P8tW9/C2jegz7K94gBiekZ5Mz85oNMhpVgVK0t8QF
	NxbuELdnh9d5yY+R9NeUb3svG/qr/sRHJNOhx0T1IhXQgjb4VRgnMQ22oN1dFjMseFZ+FbNUqx6
	vxL1ZlDD/iuLU07qqcCFcJN2rdAkNWFSDVRzQIDAU7FH/yCd8YX+mHJmO8hKlJT+NV5JLINVPGv
	CW2IgnnXyFoWx9UP8QEg0BOO/Ny7JPIQ=
X-Google-Smtp-Source: AGHT+IH2Qq+vJs691IP3gFVV4+yA/R8PodgaqDLDQyxccOAg+6ShJ4bHSGh5LMBsr/SfQv7E2MzGGQ==
X-Received: by 2002:a05:6902:5410:b0:e96:efc6:8392 with SMTP id 3f1490d57ef6-e9f67f9c65bmr13268301276.43.1757555277297;
        Wed, 10 Sep 2025 18:47:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cefe1c21sm71913276.7.2025.09.10.18.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:56 -0700 (PDT)
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
Subject: [PATCH net-next v11 13/19] psp: provide encapsulation helper for drivers
Date: Wed, 10 Sep 2025 18:47:21 -0700
Message-ID: <20250911014735.118695-14-daniel.zahka@gmail.com>
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
---

Notes:
    v11:
    - support IPv4 in psp_dev_encapsualate()
    v4:
    - rename psp_encapsulate() to psp_dev_encapsulate()
    v3:
    - patch introduced

 include/net/psp/functions.h |  2 ++
 include/net/psp/types.h     |  2 ++
 net/psp/psp_main.c          | 65 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

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
2.47.3


