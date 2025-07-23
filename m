Return-Path: <netdev+bounces-209508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F019B0FB9F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C53A1FDD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90823C4F2;
	Wed, 23 Jul 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvAPjvCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5C23BD01
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302913; cv=none; b=ULDWJ9fuLdQeZalif+c2MUGE1RuOlZiruw/l9vMHnX8h4wzhL3BZnSkyBaLW/jdbaeoav7mRLPl1dvvtcsBr96O1k/KILvkJr/7yK+OMsAW13VXBGZMoD1Nrjt4Ut8IHswIQ3MZWcqzFJqemS69V9KA92pafAY1VRXwnIT1yBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302913; c=relaxed/simple;
	bh=Wd7S220sdAw/h24Lm0mCePZrgeTuVkKxnWPvMZETiu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITlf+8suEqTl0s8oA9sHNg9+5uhBEO6x5M5s7tkQD7lqNVOfmbphxIjuiJRV7IYESWXeyQAsQgmfvr9py7/N9HXQfoaljnKlyXDaKx13UKNkvwT/lFJC72AvqPGitAdJ3s83Fw60wc8EZCaCYntKaBNa9x7zbEE4CSPFaW/zQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvAPjvCz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-719728a1811so4005047b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302911; x=1753907711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=ZvAPjvCzpnmBqNecArrEr40kgDhP0xcyRh0l7BYZb3QoDU6nZ9k3F+9uU2UxJOtOjv
         LPseD/7wMny4ObfzAGKgNRbFbdifrdS10Og1KCuMOupHo1tv7mAm80QHP33KaebjlMG1
         nDac7IddUkrU2WcLgOrY7pFYgWOkduzUcgbf6PmZrb7CU2habkN9fo47mcmn34BKAMFu
         0ckxe2E6sNtATpp7woisQcerNW9tVrnP6vW9/0MupIdORer9zNr9edPuOHAL8tUBjzrE
         cSmA0auS0ALvuCiJlYDiaaJ1QNVodVE8jB5S4+gWo/yMFqLZLMlwylIv5Xq8yWIMeT69
         QMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302911; x=1753907711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDKLXCcQs4xR929dsufnBOaUP+B3n4UL+TWCnX5tRKI=;
        b=wIk+/eizq92W/76Fx90DpuXGJ32136LYdJvIl2Af2ragiXSNhD8kP97UpYuJ/HkUU9
         Zq6RRF5ovUEEiejrKF5UTYckf5IJqqq3rIeCws+mMHXaZr5fGvQyQXEjqzIqiUR2s0Xj
         LPvgiFF5OBKCzraLkDhoC2/V4u/RJJKN6hjvscoJVIdBKHwG3tnQwxNWsqRWmir2xo6+
         8H1gwZJ8NbufnEPQNN2AvO+iyuimbk+wNZiHZviFoeKzU7TomQvHYMFYnV3vuCN/0K1o
         S5hH9Ot5C9zPoXSIY+HLoOfP5lsBYAxfvW+CE1GS6tMYY0/SJYCDF1JfuOJ4XSzKoJlS
         NYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjHLpxYm1C/j68UHKAp9A4nYUaTlS11v8rJaRe/SSt5qgmLkRlCyLNA6RjcQKGBGmUCm0oeKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8fDp3iHPmxj4uDsLCRj43+H7yZqnN6HEE6QsJ3hs9wcmM3bM
	FV0gCaaHMNxvhyNLY58R3XAG40ySFugj/ETtPQlMRXLpQf087rDeKl+c
X-Gm-Gg: ASbGncvOjTUd/k98Ap8SHDPOrm6+zRgSG5bkNyYrPMfwsc/ZXU/rnY3okLl0ItLZbDZ
	Jkuu5BxszFQoqrPU6u7fQbToRT3muYLCeB6pHpML7cVVyodcYCaamoz3RGBbbvPCoxv0cPADWuC
	lG26qLlIbnhHUBE4RvE3p65O2RHRGq5rmGs3sT8Pk24yUY05/e+kTZeSoN/OJSrlUs4YGkUdw9/
	Uvflj7HdNHjcgLS8ZlS16XSXNLF+ieSsyrkTPTxYPEip/OAJQpRKOAAXNEUIo9qPkIF8TbUbQA7
	qRxMzTM1I3LxI7VsnhPCducFATjHsEQLnta/ME26LkS4ict1Rf+jCrM54wfIbobPrvWom5TgGkr
	5l1GHhX47CQ0rY2dV/Arz
X-Google-Smtp-Source: AGHT+IEaw0l39nE6VXUSUTK+tVVYr5cwELRMk2t7RCqdo/WRqb95UmTDtP6WGj6dgFNHJVaIkc4/Cw==
X-Received: by 2002:a05:690c:74c7:b0:70e:7706:824e with SMTP id 00721157ae682-719b4145796mr62998967b3.6.1753302910960;
        Wed, 23 Jul 2025 13:35:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm32251047b3.72.2025.07.23.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:10 -0700 (PDT)
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
Subject: [PATCH net-next v5 13/19] psp: provide encapsulation helper for drivers
Date: Wed, 23 Jul 2025 13:34:24 -0700
Message-ID: <20250723203454.519540-14-daniel.zahka@gmail.com>
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


