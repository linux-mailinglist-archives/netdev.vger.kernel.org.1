Return-Path: <netdev+bounces-156548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458EAA06EBF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B26E167992
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91914214A6F;
	Thu,  9 Jan 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="AZIWWRr8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A6214A65
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406856; cv=none; b=r2J6QSjh9H5NGiGkkk0BL9ioQf1URzxM2Q+Q79dY+IzRokLYOSua2R3RBHRe7YJG+vgG/rF5Nr/Njz0BSVSc3wk6fRE+TWn+SWPXI43A8WrELovpB4DZpyNdGg1Tjz8RN6e5qv3lA9SQBoX3RhXS/ePSLWkfM6RssVWeaATU1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406856; c=relaxed/simple;
	bh=1TNAX81EP2NvwqtjhU4qtoa/QvcfDKP8cdLmXM5RmEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=WZCOrjUBXTydCkb27YXagHt2rxO6821CovbW8Z+63dURKx0v5FlnFWr78DS4qPXtcjNJexzH2zdTRuifWAwab0EJDj0qrjwUVNjD+sXnD+yq11M2xmIJADOHiOIGaFRlnaUxGZmuaRnp2CJ5lqydQBXb2bcfkchwabSSFoiUVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=AZIWWRr8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2156e078563so7360505ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736406854; x=1737011654; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u44TfuF4b66FsV08yQ0tUx1xEQu600SrekVmHrVz4Q=;
        b=AZIWWRr8sC4ZoRQ/6CH21kIEgLdJFTih+uOjPlX5z/0iXGYWDELKF8R/M9AT8VeUHP
         i9Qppdr/WpURwm0bEoLu0Muk/KAjZMmi0tkBlicewYp8As5QJpVBe5Ahch3anuGqoj9K
         ugXyXmMPWEiRd9q2MEjyEmTwckB1xtrhp6taPkvV2Ua6sC5ZZnRHaTfbozzlf/XPgmKx
         oWoCk23hi+Pdgac8KjcqfT/+0ymmeORa4xk1GD8/6H58Jx6PK7YM4Zmtxj+mDvvYs+tY
         rotfxdIybbwCp+k7bmkRrezLW2prBMNLAbuEM0KJDmOF/5qV59r5YI1NHp4jd6ud/TQh
         FsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736406854; x=1737011654;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u44TfuF4b66FsV08yQ0tUx1xEQu600SrekVmHrVz4Q=;
        b=ttN4/KuKoJhyaX9bBJaSR/hf00iAco56r3y424/1oAhbkANpUIIx5LHckYiIFY7/Ks
         O7cfMkBQvyHLz85wKKBAwmFOF2DAxmPDcT6o4+rOufCioqgB0oGrQFH/dTBWnoMfuwlM
         +Lkprsn5MgpD2Z6UEA9D5DBdXemfD8bdDaXaZuZrQkPS6UT0blqrZin6e1A0BR0Soj6s
         wU4wPRIAK2chMRYfRiSP2+eOa2OqwoGeBdqVQQFo55+Rb72NsdXr4SEO6s4Pnh/RsiZR
         6g/txOr87qQZuL8YQ3UOziMez1FuWVWWyzjfuSzSbh1V+OeangSgInM/m3/ort+3ZodC
         Kxrg==
X-Forwarded-Encrypted: i=1; AJvYcCUrUYveWk45yZxgmzl6Hfs60Q0dAcXJ0pIvfIZfirjZaGXXwRX8oKVEd4Ad/d9Q1OfR/XlwrKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0fT1VOX/E9Mg1mX4F51wM3i4oLnVbIA6YrERknZxK7A27C/d
	zJBSDmKXR/OJEWfS3IPpgU053q+RBXj02nB8x/Kz8zTCd3Y5E/cRfCl0IM+yrUQ=
X-Gm-Gg: ASbGnctL2NAGP3VKqi7QGb2ue4CZllYRVMFk5S6pSB60Ktde9MYrUcUlC8ZM0kNRDt+
	Tm5umAQ2BztkjE8f16kJEF5ds0y3yxXoVilC8LaGqF7rImNyNbSKc8VTQhDywT2Ekb2iJMs9bHJ
	5iZ4HyB5/gEH9HaRQjHHbKH5ABRl2bALuJTl2nRJsN7W7xU4UvWOSNGvF38mZz4NW5JrwwPuNnL
	qRznmVM8UyIN/WvQYQDVo73MkCO5/2D7gqgg4QDyKk1SToprOkZ6J3bdZY=
X-Google-Smtp-Source: AGHT+IGQHw/pFPM7Y3PGxXg9GDfX/8EmNWzm8K64ShGCkEBkRaUarZlr1VPbMp2xbl4BT3Qn47tHew==
X-Received: by 2002:a05:6a20:3d8b:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e88d114f9bmr9397267637.21.1736406854193;
        Wed, 08 Jan 2025 23:14:14 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad84eb50sm36483803b3a.90.2025.01.08.23.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:14:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 16:13:39 +0900
Subject: [PATCH v6 1/6] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rss-v6-1-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
In-Reply-To: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 02a9f4dc594d..3b25ca75710b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -9,6 +9,194 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_hash {
+	u32 value;
+	u16 report;
+};
+
+struct virtio_net_toeplitz_state {
+	u32 hash;
+	const u32 *key;
+};
+
+#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
+
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
+
+static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
+{
+	while (len >= sizeof(*input)) {
+		*input = be32_to_cpu((__force __be32)*input);
+		input++;
+		len -= sizeof(*input);
+	}
+}
+
+static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
+					    const __be32 *input, size_t len)
+{
+	while (len >= sizeof(*input)) {
+		for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
+			u32 i = ffs(map);
+
+			state->hash ^= state->key[0] << (32 - i) |
+				       (u32)((u64)state->key[1] >> i);
+		}
+
+		state->key++;
+		input++;
+		len -= sizeof(*input);
+	}
+}
+
+static inline u8 virtio_net_hash_key_length(u32 types)
+{
+	size_t len = 0;
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	return len + 4;
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 const struct flow_keys_basic *keys)
+{
+	switch (keys->basic.n_proto) {
+	case cpu_to_be16(ETH_P_IP):
+		if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
+			if (keys->basic.ip_proto == IPPROTO_TCP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
+				return VIRTIO_NET_HASH_REPORT_TCPv4;
+
+			if (keys->basic.ip_proto == IPPROTO_UDP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
+				return VIRTIO_NET_HASH_REPORT_UDPv4;
+		}
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			return VIRTIO_NET_HASH_REPORT_IPv4;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	case cpu_to_be16(ETH_P_IPV6):
+		if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
+			if (keys->basic.ip_proto == IPPROTO_TCP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
+				return VIRTIO_NET_HASH_REPORT_TCPv6;
+
+			if (keys->basic.ip_proto == IPPROTO_UDP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
+				return VIRTIO_NET_HASH_REPORT_UDPv6;
+		}
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
+			return VIRTIO_NET_HASH_REPORT_IPv6;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	default:
+		return VIRTIO_NET_HASH_REPORT_NONE;
+	}
+}
+
+static inline void virtio_net_hash_rss(const struct sk_buff *skb,
+				       u32 types, const u32 *key,
+				       struct virtio_net_hash *hash)
+{
+	struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
+	struct flow_keys flow;
+	struct flow_keys_basic flow_basic;
+	u16 report;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	flow_basic = (struct flow_keys_basic) {
+		.control = flow.control,
+		.basic = flow.basic
+	};
+
+	report = virtio_net_hash_report(types, &flow_basic);
+
+	switch (report) {
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	default:
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
2.47.1


