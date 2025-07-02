Return-Path: <netdev+bounces-203458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50784AF5FA6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A328C52158A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D785309A4D;
	Wed,  2 Jul 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLWC9yWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDC30112F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476426; cv=none; b=uQa7EYuGulIWYo6s9D82DX6bBCynUELbzcviVtPtYIl6Fsxr/7UnSyO519UrqREiRdFF20Z3NOoceOQKmZAlog/M+eZXEAmsFVbq5H+3Qt1fzcfuNCRa72Zsq9WD5DrAZ9YJZDnQlpM8zUxbg1cCLOW9XQfNr0IU5/o1CjIcTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476426; c=relaxed/simple;
	bh=7TZuKSYprhUvVIv6A4N3DjoEOGB7kMsYRwDpbRnCemU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7wR0zPS+m+yQ+i6qiy4O6kfX+NySn5MOO5+j+vOHHGavke3II2l0NL1JckwwA4bAuBK4LFyW53glaeNrT8Y3RbPCYP4bMb8tbR3SM2RxNgAX0DK8SNrt/VBk0eUVxOzcJN/uzNVgUrUdAKV2Lrl3mVVt8rTzIeYxajwd/kx47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLWC9yWl; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e5d953c0bso80074757b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476422; x=1752081222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TXrPdWWt2YmZDp0JMUoP4I/kX2LQ6C8FxraH/kPvVo=;
        b=fLWC9yWl8SE4mC5xdBGb/IZQid1AsS/SmTnDCZX6H+Ko60pW2Rbs4pmwb7c5hwa29O
         baMGZowDgbjQYsAR7rhqLCVevNj1JvRRPus7eteQ+9Zm+M3JJK2wqdZgF3aomut1LPLl
         NOpNQjhN59SRFswA9OqKeNciC9DyzMFmspHDY15ki3ubRQQwDCPu2f/i88XjqdsoA9wx
         r1AHd8hqyLAv1GlvnP2Jn6ThjuD+pSrlEbLdpiBE8DXiWqd7msZgnV0qADADfAC623Tl
         txK99Lq+1Wzm95Ku05p2bP0S9T34wcO1n94xc6LRrhxWWNrUqm4vfP+mDikiYSB9V6Oe
         2NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476422; x=1752081222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TXrPdWWt2YmZDp0JMUoP4I/kX2LQ6C8FxraH/kPvVo=;
        b=n40drv0TH+L/l/M+v682NM+s7sd6Fp6mdhdWLuIVj0klKU71EGDw3MilJr/EYtqdq5
         Jenfik9Y+X9ybcNtfZ4SDZNXaU3nxiVlENdxnnL5syVMXPXDyu/w4pMrZ1OczSQwzkiz
         +UmApT1WJYXMock/YuqYH+OaxEVpuLs2ahS3phPEmpzu1oFyqE05wuEtyzyym056RvLR
         qvDgHQdF+U62dDMIA8MXfTjp5wQLsNRaaIH4bXsjfU7qnxBqezPA52y36HxMXdG0RlPz
         j0GoXRYAvS/2s/TxopdCoz8YPmvVZFlaYKFloTKW5cdRie8rR43a2dXwopJNXdQZxuFp
         5dYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNqfN4UwfpWpk3PnXqICDonQwN/4AVvld7Ah8p1KW5IMKyao8KM+kHB7SZtBBsongQGcHVi/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXulaLoxcLK622mtavWUdocY8LFXq1mSqTjS0DmHB5LiO82zhI
	8YJtEJVWw2F4r7WnQxeqNtQn55JPhlW+WKajj9wKRDOc+77Ahd93nxeZ
X-Gm-Gg: ASbGncti4KKtvbgCt4bIh0m/PJKhQd+0wOTDvlUlc1iLl1z1N/38x2INg8OOJ1Md6VG
	oGdnGZPcxLScMznu9K87+NYhdVkmFKJcrdlfvE9M5IxfF07unnfvRnV272A0Yre6VkNEfrrZlUb
	0JQJeiaM9v7rXKNKPbyXtMzSKNaS7gv9lHc/anK/p049Ig9syigOzr7CcTJUZsHgV2aSYwLIE0i
	jRgCTXXwrNnRaz0cO9LIED5AG9BAByDw80xqpbiPR1sRA1xaj594iHXw4JmKVjY2S3nLvQmlLhr
	hCoEvvtTAe44ncVXiAuIsfafjGxCPu/6gd2a3ruGO1gpJmGugHPonop7jVK6
X-Google-Smtp-Source: AGHT+IH0rdsxPmGqfzjAvgy6lEsXRHi/trraAP5MgUw6FZYZwpKmmGCX5oQWwbKL2cBP/hK8CxiC/Q==
X-Received: by 2002:a05:690c:3382:b0:6fb:1f78:d9ee with SMTP id 00721157ae682-71658fe47eemr6106887b3.15.1751476422552;
        Wed, 02 Jul 2025 10:13:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c16d6fsm25691557b3.51.2025.07.02.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:41 -0700 (PDT)
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
Subject: [PATCH v3 13/19] psp: provide encapsulation helper for drivers
Date: Wed,  2 Jul 2025 10:13:18 -0700
Message-ID: <20250702171326.3265825-14-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - patch introduced

 include/net/psp/functions.h |  2 ++
 include/net/psp/types.h     |  2 ++
 net/psp/psp_main.c          | 57 +++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 1b414692504b..afb4f5929eec 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -16,6 +16,8 @@ struct psp_dev *
 psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
+bool psp_encapsulate(struct net *net, struct sk_buff *skb,
+		     __be32 spi, u8 ver, __be16 sport);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 383a1afab46d..fb8a31cbaae7 100644
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
index 99facb158abb..8229a004ba6e 100644
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
@@ -138,6 +140,61 @@ void psp_dev_unregister(struct psp_dev *psd)
 }
 EXPORT_SYMBOL(psp_dev_unregister);
 
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
+bool psp_encapsulate(struct net *net, struct sk_buff *skb,
+		     __be32 spi, u8 ver, __be16 sport)
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
+EXPORT_SYMBOL(psp_encapsulate);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
-- 
2.47.1


