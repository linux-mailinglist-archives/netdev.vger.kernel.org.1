Return-Path: <netdev+bounces-209528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991CB0FBB3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672217BB45D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB31246794;
	Wed, 23 Jul 2025 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD8JWzqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FF1E51EA
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302938; cv=none; b=A1KqNeyRIXck1zzPhx29SVoLO20XJn7qJPC3eH0mP/eIH2rLPoq3NLymSBUQD32IhFa6dS9R7joEu14FaRN68lIv5gtPb28jLtQwx4kikEiW8tfDmYUpNy71cJPBaZTACGwVzwQvtQj48s/lEeygeO5Nkki7RR7HZgVvly8jz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302938; c=relaxed/simple;
	bh=Wd7S220sdAw/h24Lm0mCePZrgeTuVkKxnWPvMZETiu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSgKL0aB2ujXgwiTzYYud0nkl2sVLiGRjNnm8uAE9rVZlFZBQReaE8aDVbZCdnWnXJZS/QuqQl2TPXwluF5ZSaM7SNIhCcfVDx0wY4ikMqeU7/j4xSv8cQkNDnxFXnsEVNgYwM1fqbccdf7ldk270d0O+n0x6fucXFJp5EcMc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD8JWzqQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-712be7e034cso3923957b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302936; x=1753907736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=iD8JWzqQKG8kb/8IcZNDtivyZjy6pLQXSnBggCuR1bzQuWHkc9gi4AEFPrjHUcV4oX
         PtlRHZmaYH0DQiKSCHmCRKLcI4E5ymxaeRMQzHirx/l5uaQ4GzZjyAsZggA1Rzo2MDMH
         gLEzpBjfJcaRboJyvEJBEeLHC/JtfmhKNDb88OTKnMP5SZzo3tTzQFOyq/73AA8vriCG
         E/7LJ7R12es3AgUxx7Sk1spapPuOdlw3kAA8Jnq8ViaJdGeB69wKnq5esmZjRRalLoD7
         Juk6tX4I0t9ATF8r4M4spLUm37neyTtqQRHkmp3B4b6cM8uUsDig/Ds4uzNMMDM0TlI2
         7Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302936; x=1753907736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=BbqTjEtfb9TG6cl2uQIz1Ud75PWrOn/h7S1UTaZQHoUjiqhzVJBiVz+5U+S4GyuOJ0
         gMWa7hotn4AKpmQpVd0vCY8q0vBP7o5FZS6X6cDz+mf/Bo/9qvfREzpU3UFxDHjY+Km1
         NZzFnai8uNgIUUpcnaN836CyM5uhs3qgM7y94mrwp9Iq7tqF0gfg3fNZak3b7eYllErI
         sT7fQ2WRMmIo3jexKPP+ouqU5hR9JtAcgGIk4Fg15YP+aRrzrrt5x5/ygKYyKWTPsXc7
         7mNlkn59UYoD4u7JdVqAF1/dWG29as7BrAv3ID4oG1+22h8xdXDzj4osL0sYWxepoqbY
         /2dg==
X-Forwarded-Encrypted: i=1; AJvYcCW9wW2JDKEp5/EMIOMXug1kktLtaicbBg1/VINja4BSsKOU9DMUS910LPUc3bhPhRXhatHnFpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjJ4XQbI6GZxd/avThxoT4X6OMSqagOaUXslUTHw5V7NUSkxD
	yh2Hl64PDprCGFmoFLSpyUUFDkkNLaCou2HKU0BY09pgsb3cUxUaAVxc
X-Gm-Gg: ASbGncvoS0gacuqoVDJfHdvNPORTrzrtacTilZ8QeQdEPXEoQVwwSvbeyPriV5q3j38
	Dce4qlV5WWBREqc+7QITpobpyHbbjwYQoC069P40kpD3ndLO9lhOSsw7fNaCCMTmdNSlgxKfFuu
	yBwOkj0I2DEuyR0nZ6jpIRt4yJhu71ojmWry+QUzg/YoBShx6j6gTKcDd9X+n7bFm5YRRcXNom4
	1dLgf/lzb9whEIGn33A9D52HIEOV64wLRy6HPaoEyfB16drpU7D8a8g4Eo3G1MnjttOlR8KM3WO
	EWHeQ3Bulqu3oPpFbZAAmTINY81x426NjJpCbswumb4dMqemaoatpS1wgMQabD5ll1WKFk4Yhxe
	okzO9F3iUZ5Vhu40s5NVP
X-Google-Smtp-Source: AGHT+IH6wmf6wk3NzAfp5+woZHoevNo5aYTpLIKlcv/BEmf1zXkOy79JQ4dwrEq/pdSmuQhbad9beA==
X-Received: by 2002:a05:690c:6913:b0:719:61b8:ffee with SMTP id 00721157ae682-719b4133d6emr56060957b3.4.1753302935639;
        Wed, 23 Jul 2025 13:35:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953140caasm30831467b3.37.2025.07.23.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:34 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 13/19] psp: provide encapsulation helper for drivers
Date: Wed, 23 Jul 2025 13:34:44 -0700
Message-ID: <20250723203454.519540-34-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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


