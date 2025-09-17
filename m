Return-Path: <netdev+bounces-223815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E12AB7C5F4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FDC1C05174
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8561D5ABA;
	Wed, 17 Sep 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0tUMvZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438E7082A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067819; cv=none; b=ALB/D7NHF9+IYZVQlBiNWbNK42L4zgs47TVfv9OuVN83nImTvh36NhS/F6X7P9sdaryoxAg620wd/Sw/MRzKluqEKp35wz/JJQDGa82HeaMPnR+BCkD7kEemvgd8rPqWGpbbhUxFu7hH/hNoCcIB/FAmOdM85+SKI3quNzF9nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067819; c=relaxed/simple;
	bh=nh+Jt2BZuwU9nJydOubi1FfHRgLwzJflWQ2qqHZ6n8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fY0ztXPhy9L+03WL4E2HhdEkgVfh9aDaOtILXT71L668XWXVPOQv8K/y2inFv4CP+l79dQY3Jrx18mxKQbNqD90VshLwxcrRJBsiEYdcaS9rpAXB0gCHAnKx+Aj7Cpp0VsXJOKzb7jiZXOSt4UKUUK4DzDbVRHOZYUtjMgCxMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0tUMvZj; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-61381743635so3346327d50.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067815; x=1758672615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fApwIF4D8JplyJ/cOuGEEuLjKMoHSUvrBQQ+Ym2esuo=;
        b=T0tUMvZjYkhO2yE0+bp0bjrgwnvnrbAk8D/UPX7eJUxH3ufIhJcVIp8t/us4DTUWRf
         AeMs5RZS0s53a2BZ9qCegOz2balIWvuuE2tS4azM2bsSq2SN+x7Fnrt/G5aSbq7X8aHU
         xR5XxnMKqbpZUZnMt/g6TOvneXZr2m+FLI4KkS7CDXUIqLZhOY5APubDkXvvL3MD3lxm
         YV93kf7jrzcAaoW6DPRZGohzlrbGjO5rwzGAfybmhMzdM8n0xgeyH/6kicld1TKxLQDd
         Bm4hpup2E+9w0doYAZkDOhQ4MRSGMb+JRaeqmV1VzZF/E2HnA4Jp/XAWRE22Slo6ajHK
         rB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067815; x=1758672615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fApwIF4D8JplyJ/cOuGEEuLjKMoHSUvrBQQ+Ym2esuo=;
        b=SuV7yZwDgpqIcL+OPCcLNw1HVWalzebryUbDUWAWYCUVylPw6+fhdDAKzpiWcQmyrQ
         T6VxG+fPt4Prs+1FsFj38N5pjagMXaE5rtyhsngHbLy3Hef81tqRgj35pSwIzKHuBZFC
         K6Ybh7s1raIh7b/MmrpiTZxWUyHFIKGEx/bQysLdX2QzZkofLlyQ4l/QeL26I+0nRJe5
         cZeHE/XazBRivQfrNM0CqxjHVS2i1WMmE/W/y+DgGZaT3qxdPd3FpTNJrJ9R8HJL/IeZ
         d9K1G4aSXEo8SZRJljg+VeRmkBv+UD4iQkuA+mlfL58GwEb1ESLHIrgEb4yA5r7X/kIk
         1sIA==
X-Forwarded-Encrypted: i=1; AJvYcCXbmSk3zHKmQUUJ90IkTbA3FzQOXwDQ/KfRghTjBYexwmYZvAl+bHmfgWL/mxk2EOa5S9A9xd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cVbDgaf2xfOsc+p4QR4XT1ctRzGFH8T5e/TAvVqg+kwciIvG
	fyfQKp5BUyeujjVVOAgka0hYwdpxBcvgE8Wses2CLD1QNrpb0IDSA+Zr
X-Gm-Gg: ASbGnctYjxjKKAl7EvfceqffXHj6FysDG9oe+Q/YFJsNHwdDOs9TK3GsCBcxFI6DyZC
	zQs3qr4L85PUfHakwOtTrTKKoT8JX9kTN92qhrc+EBLSh4LA1VfP7lPIkUZjBnoJg0km9JwAgXA
	69Vud2wH2pogzypusf4MwdZtGbYGHlJur1k9isbba2S95IsJKO5rxC1qx/ugFDcYNI1RZ762Uq4
	8SA+pFr/uAISXDuQLm6IPM7xCG52lEGP+eDhxK/NavggeFRrPiPT101ytufV0wxD9LlynvpNPE8
	7p5bGXl5+I+seTA1mtU8xnq+2S4xCCjE493EDuBvkHpEXbVv4PsFN0UtkLse6DsguaFru6FqN6R
	TtSyPxCbyiJcq8yovZTxe
X-Google-Smtp-Source: AGHT+IGNSGdgnGSrwwlf7i88buC616/QUiAbXnrwOTSghWlAV3OdSqGYYL1ekXSOSrem1wrH8An0jw==
X-Received: by 2002:a05:690e:124a:b0:62a:94fd:f2e with SMTP id 956f58d0204a3-633b068d117mr325958d50.21.1758067815423;
        Tue, 16 Sep 2025 17:10:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7335af1ea69sm23771177b3.34.2025.09.16.17.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:14 -0700 (PDT)
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
Subject: [PATCH net-next v13 17/19] psp: provide decapsulation and receive helper for drivers
Date: Tue, 16 Sep 2025 17:09:44 -0700
Message-ID: <20250917000954.859376-18-daniel.zahka@gmail.com>
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

Create psp_dev_rcv(), which drivers can call to psp decapsulate and attach
a psp_skb_ext to an skb.

psp_dev_rcv() only supports what the PSP architecture specification
refers to as "transport mode" packets, where the L3 header is either
IPv6 or IPv4.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v11:
    - support ipv4 in psp_dev_rcv()
    - check for psp-udp header in psp_dev_rcv()
    - check psbk_may_pull() in psp_dev_rcv()
    v4:
    - rename psp_rcv() to psp_dev_rcv()
    - add strip_icv param psp_dev_rcv() to make trailer stripping optional
    v3:
    - patch introduced

 include/net/psp/functions.h |  1 +
 net/psp/psp_main.c          | 88 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 0a539e1b39f4..91ba06733321 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -19,6 +19,7 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 			 u8 ver, __be16 sport);
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index e026880fa1a2..b4b756f87382 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -223,6 +223,94 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
 }
 EXPORT_SYMBOL(psp_dev_encapsulate);
 
+/* Receive handler for PSP packets.
+ *
+ * Presently it accepts only already-authenticated packets and does not
+ * support optional fields, such as virtualization cookies. The caller should
+ * ensure that skb->data is pointing to the mac header, and that skb->mac_len
+ * is set.
+ */
+int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
+{
+	int l2_hlen = 0, l3_hlen, encap;
+	struct psp_skb_ext *pse;
+	struct psphdr *psph;
+	struct ethhdr *eth;
+	struct udphdr *uh;
+	__be16 proto;
+	bool is_udp;
+
+	eth = (struct ethhdr *)skb->data;
+	proto = __vlan_get_protocol(skb, eth->h_proto, &l2_hlen);
+	if (proto == htons(ETH_P_IP))
+		l3_hlen = sizeof(struct iphdr);
+	else if (proto == htons(ETH_P_IPV6))
+		l3_hlen = sizeof(struct ipv6hdr);
+	else
+		return -EINVAL;
+
+	if (unlikely(!pskb_may_pull(skb, l2_hlen + l3_hlen + PSP_ENCAP_HLEN)))
+		return -EINVAL;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
+
+		is_udp = iph->protocol == IPPROTO_UDP;
+		l3_hlen = iph->ihl * 4;
+		if (l3_hlen != sizeof(struct iphdr) &&
+		    !pskb_may_pull(skb, l2_hlen + l3_hlen + PSP_ENCAP_HLEN))
+			return -EINVAL;
+	} else {
+		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
+
+		is_udp = ipv6h->nexthdr == IPPROTO_UDP;
+	}
+
+	if (unlikely(!is_udp))
+		return -EINVAL;
+
+	uh = (struct udphdr *)(skb->data + l2_hlen + l3_hlen);
+	if (unlikely(uh->dest != htons(PSP_DEFAULT_UDP_PORT)))
+		return -EINVAL;
+
+	pse = skb_ext_add(skb, SKB_EXT_PSP);
+	if (!pse)
+		return -EINVAL;
+
+	psph = (struct psphdr *)(skb->data + l2_hlen + l3_hlen +
+				 sizeof(struct udphdr));
+	pse->spi = psph->spi;
+	pse->dev_id = dev_id;
+	pse->generation = generation;
+	pse->version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
+
+	encap = PSP_ENCAP_HLEN;
+	encap += strip_icv ? PSP_TRL_SIZE : 0;
+
+	if (proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)(skb->data + l2_hlen);
+
+		iph->protocol = psph->nexthdr;
+		iph->tot_len = htons(ntohs(iph->tot_len) - encap);
+		iph->check = 0;
+		iph->check = ip_fast_csum((u8 *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + l2_hlen);
+
+		ipv6h->nexthdr = psph->nexthdr;
+		ipv6h->payload_len = htons(ntohs(ipv6h->payload_len) - encap);
+	}
+
+	memmove(skb->data + PSP_ENCAP_HLEN, skb->data, l2_hlen + l3_hlen);
+	skb_pull(skb, PSP_ENCAP_HLEN);
+
+	if (strip_icv)
+		pskb_trim(skb, skb->len - PSP_TRL_SIZE);
+
+	return 0;
+}
+EXPORT_SYMBOL(psp_dev_rcv);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
-- 
2.47.3


