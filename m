Return-Path: <netdev+bounces-216620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6BEB34B56
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8220C1B219B3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A910286898;
	Mon, 25 Aug 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCij0Z+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7B2868BD
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152097; cv=none; b=XUCKrqrfEFAEHP2lOngLgTLsEIy0Rp1Ol+/DAFoHEdQJw5hCAR5MUjhxewh95hqYM7GHedFgX8cVw5yyX5FNq8ffd/v9eKil1huirkOTdOd4LB3q5UD0ZEAj2cdCPkYzCPCX6PdYbcY067CceU3VkeVpSkDx3FTASMzBZ2hPkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152097; c=relaxed/simple;
	bh=WhQM7iVgNtQoinyBq2uWQjoAcrkWKxNaixiVZs3LZAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7mJyC5HDEQyUVcPUY40B/puYchzrj9QgevHSDDpL+Ot2gXsIfOeAnPcNnCmHARXuxV/HwY6+KK2ccaKu3JqkU48eya4v1AzK1krDMDrYmPXu3OvN/5HtzZPtLvVCy/WJFPY67nsXc4mhxBPU0k2CLstgs8YhJvFsuxuKzBWDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCij0Z+l; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60528734so38218307b3.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152092; x=1756756892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=fCij0Z+l9T/VhXJXNQ5vBHHh8G0Ak4xvrJ+FLAxNNlVV41rzZ/MxDyqaZeGWfANkOv
         0E/EazuqWw2WNwILN8qAxNL60EElEKgxt7ZXGOB9eociDNOC1/0Oxe8hB5hwMVLSIbPi
         Vw5xqVUC//Dsh4e9y8h6saOBVIQeAsW/ISsOzUwPd3wBNc7DaP1KE3XmgFibTVXPTN5j
         MZYT9DZLqYooX9hnyOBBjCEoq9IrgYFpOFqMaoL51XpKMoDpnucZ27IuO9aWkbf0Tx6U
         2YwjPAAix86sgYoewDVLGk2xN97yNWVIGawbMG8uNiAgNB8b8Z2tqFE6hUu66H9wo/Ir
         n1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152092; x=1756756892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YenFgEwOsmPgXCrTnR+tjEIJluRZoFaPQmj09FvgwBk=;
        b=VM/UDeEXkEg4zrke3qeugrrid/gFr6xEiEnjPo7LF5Kct+RZHZ07zIZnU+MwrzAsh3
         pD4uuh4k5oE1gFaskMSS8ialXcqgTR9hstKDDDPVzfjy3uq8Vw5aLxiXJ52a2LSTv20Y
         UllMs4K978nKFhXjC9KJaL/DSCrA1mhtFE7S3iK4JHDn5RB4Ag/4xghKpOOadFuJr2Vc
         LmEM8Lx/qCcLOh7VVnsGeUhM/22dkU8haQ//HqgR2R7Ni4JGM+/hT8C3X0Nv7rsljuyX
         kJidBKCW3CzNp5cLfljRJrB96lBNNAQUuImhUBwJs5rGnjm+IEMQJY+XajabYQqj6C83
         dH0A==
X-Forwarded-Encrypted: i=1; AJvYcCW11oJbvAg6WVTqv7kjGIySlu9MWN0un3lusiKX/cS6voNkHbOkNjn2Mf62HJwZiGSFN5BHTzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlaT2A7W3ZeiuGNl9nhgQbXT/K0qxpz0Xjilqnpqtp0SiTGkXb
	/ogjMKU4QDPjCtb+6tOFQgu29maQFOTQxL+/0UpqgNpOBxp42+dd4NaF
X-Gm-Gg: ASbGncuIDIzjCNN5RaIYolhI3/zheEGCJheu+XzYXdAJscrhM7tkR1kcdyMm9X81Rca
	YfI7bKA8cDp9+JwsHNiZUptp/4l2v+/swlkCIFCsehGOGCHChxPwPMTif3wroOouS7RbQLcOpvh
	Xy8yB2OEtxux37q2dCJLISOmWPzS/8MQvPkDeoBrongDeFOVK/jP/F5ZuU4qZGLiZSdsuYI06oT
	FgocZ+XM38sbs9w4tf+Hej01oEhWKzmtz+v94lYgDdwphbK7mnoz1RlNi8TQK7BdV5h/5fNlJHC
	kbFw726lU1uaC7S6YucDApTCj3dxlmnKXY3OoJLm1Uy5bvlBapVFT+gYKSUDIEpAQHY7ydnUMV3
	M/xlOnteQaF+9CKD3Pg4=
X-Google-Smtp-Source: AGHT+IHTdnmSg846K10T0Ee0/9GKgyWP4fM0zpQMccbtd0fYf7zOTXHHS8uUJzW2Md72X2QXyWIZeA==
X-Received: by 2002:a05:690c:6001:b0:721:1fda:e328 with SMTP id 00721157ae682-7211fdb5f33mr25329297b3.49.1756152091767;
        Mon, 25 Aug 2025 13:01:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1703249sm19470017b3.15.2025.08.25.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:31 -0700 (PDT)
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
Subject: [PATCH net-next v8 13/19] psp: provide encapsulation helper for drivers
Date: Mon, 25 Aug 2025 13:01:01 -0700
Message-ID: <20250825200112.1750547-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
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


