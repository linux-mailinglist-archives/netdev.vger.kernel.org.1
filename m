Return-Path: <netdev+bounces-223812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C79B7C60A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E708189E827
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87291A262D;
	Wed, 17 Sep 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcM9j4u4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F581799F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067815; cv=none; b=FHtLv6ndmZ/AZsZ2305Y0p+qiMGHf1ddS/rk3TgolpnBtO4K0TBOuhaNVpOuvy6RsJzRsbL1zfJ28gxsAkw5shXJxP0hsAqeIQ2kYRGpCqjrIeErBqv4RLf91vvP9t+bAsl02oPnaey9UnyCoOt5LIAK1tKx+3KQyNM+lCjb57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067815; c=relaxed/simple;
	bh=mTYUv6iGXiGkNL3aquxE4pWoG8xRHVN6TZkadUeYABs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3qXokzw3ppyw1krYY/tiIvfOQwO70UZN1RQF4ttR6sXLc4kewHH4DEQx9pPutYGJL3D5KkhDpj4Jtgx3Xr9ECLT0LD+szsD5LoPy/kQtmc+EV2OYqKLuRvF/tJoBD4b217rUFxExmKKcv6jw3o/CAwm8SvLrAIn/T8lkOk5tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcM9j4u4; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea5c06bd2b2so84373276.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067811; x=1758672611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHZ2u60Qfm3Jvl+0zRc0XXhonWulKZA3HSXw7sEIVrs=;
        b=fcM9j4u4QG4qYJUi5SCBkcQTy6tIS4ra/V45WWQdGYe1dq7wsY8/Z8DDxLPtpynZGU
         X0x6YGvUZN27KX936puv8hm+GwMLH45yrvAaeEXw6YzxTc9y66ftF2OdFHdVt56bFaV+
         u+mzVDkg3+gLnh/QaBjA/aYa4T3JV6igdr15oac6haQo/XnIJybfbhvWw+wKJ9ufaaas
         bQfA1tVQR5a6379eGNDYZH+6wulZJDTtwnxvEbCV3hvGXUgPVQxyoJpkTpbR9oZd9H+/
         AO8lhLbtJq/xFF0AQDj/+EAGd1f89wNBEevXW/StGCHQZMB7NF7YErlGBTRXxXIIpJi2
         ta5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067811; x=1758672611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHZ2u60Qfm3Jvl+0zRc0XXhonWulKZA3HSXw7sEIVrs=;
        b=q4TikqbI4DY6WliDM7/UR+4DI/vU2QqM/CtHRf/v9pGNkK82whU3qjyD0bk8dqH1U9
         QIzylQDaDgNqCOI1UicvdQ7ujZ98JLOnTZeXZS2qdpo0QXSoCzbLbZ2B4aS5aUDs4V+Q
         cRAKQ5auHmLzUc1iB/Vw2upUo7E8ilxqwI6bO4pcTGIMkg/LksJp/pUDyWejYn6qSD1z
         lmyO5rMB48CNjOI2mWLQud6rvbcDdRjftQ1WxnGZGZJInU90Yry0LfiACjXIojlX3YWD
         TlL9z5aJNSL5Q+N/WNwwvhk43YRahQOnUa1v6eHnct5QL1a22ZiWPX/16MWHmYj7nhei
         Vy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBbjSVW0lzyJ2ySBURrugtLbykX54JtONNJw39a8aS4ATF6i0Z8doWFmb38c9GkFYGkhs7wxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYoNz4m8QDMUTV/Bhe5OG2z01lOPor27VssFLA9k4/XejPbfM
	X+UKXTuIv5SDiOjITbl0sKYESN4DkQcZjsOs6P5BAoj9IiCYu0xL+34p
X-Gm-Gg: ASbGnctF4ahXnRkwUTMmLlDkuEtwHdbc0E/xlzUBcmZfWEa76TTGJp1HzM1ubCftfjy
	t9yVDorLpavRx4UQRAz802Lskb7TgmRaPjrHtegcWTG73EoaYGet1t9le/n8Y27rjdVKhfq3k3F
	vec2S+VyqOZxvKDXaJOA8Oh/VgDnRoK73lwNzya13uBTOgF0jUtT5zhWTk5v2t1E3E3La14ESnd
	SykePJb+2uDKm6metzxVrN3W6CE17kABpWEVDf2AsTw3w9mqJ6bJZhnz3e8cXSOVy49sYLCQh0n
	3BcFoM17dEmBwRqKce/V+KjI0HB5bj/nZxJ/ypgpTq04/Pa8y1OpQGeQw3fJGrXJubsXQfN4k9O
	uDOX/9GU1SEYgJDByUge4
X-Google-Smtp-Source: AGHT+IG0NsfDOBMTb38CpiOvaFRl6DpP/gSG/Bn0EJGPjcX11cYl9ZXTbO2Rt9Q9kDBLYvzo+ySIoQ==
X-Received: by 2002:a53:c705:0:b0:600:f8c2:2264 with SMTP id 956f58d0204a3-633b062c615mr285788d50.7.1758067811083;
        Tue, 16 Sep 2025 17:10:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7335af1ea69sm23770777b3.34.2025.09.16.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:10 -0700 (PDT)
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
Subject: [PATCH net-next v13 13/19] psp: provide encapsulation helper for drivers
Date: Tue, 16 Sep 2025 17:09:40 -0700
Message-ID: <20250917000954.859376-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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


