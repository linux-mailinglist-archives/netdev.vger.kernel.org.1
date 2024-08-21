Return-Path: <netdev+bounces-120731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4795A67E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348352835F0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C117A582;
	Wed, 21 Aug 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="G7he8TZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE3178397
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275372; cv=none; b=fmdy7AG//iLLnPM6hMTGE5M3i5/3kr9nFLvYnAxcSdEvCQbER3Xw1sbNTEDAx7cIpWi/qmck9gcnuQMvhoqLQ6SJIOUBtcEGzTy4+ZQ43qN47OKEgY/V+5I86new4dEpo3H+g9HMQQJtRWQyy0DpQ+Cv9TdsGqDNxPSTj5ZoYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275372; c=relaxed/simple;
	bh=16IlvVKdZAjsDfMtf+vKADK8YbecS7XOAKwSjOwZ10U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFBqAOTtcNtD4TtadVHGmLM8OW4qPzMT8p3I5EAO+QnNB/AMHvYbzcUKtcrlGQ8qP6jLQ/lznE2WIi6QstV42eO3hst44wAhte0Pw1/q6706OwuqpxJYnTey33FrobyKKs64sN2M73zvaD/gIpPY73v8+XAGBXY9VzQDP/WC8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=G7he8TZE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201df0b2df4so992545ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275370; x=1724880170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhwiS23I0RwoQrtwCYtC0yWnRBVOuvRQOlXGuZ9qIvw=;
        b=G7he8TZELlvvWDZqKm8AZiYMC9P+xtKfZIu59QrRtLcCTUvFYOvHzebL67OadtTiNd
         XddhWuv8TiLIRX8H5CJ5wdAIkKLBDmo5LkCbOecd0qr6XNR/ykTMRhr5PVIPrFNCH9GR
         UZ+oUyUaPcS5KRQyA+e/a+BkZ50qpsHJn82X6QP6Ot0tDGBcRzAk/awW93e1SCV+PL2c
         iD+Lq/VAzCAZZnqWN+FKuFiVrTpOG9AGvII03+B5zSqbojgkd0vGxt1WOecaSwkr8Wkz
         a/FW8evESf/lYOYgYSfLG9BtrrignIWlbrOEVfwVqAsD2E0cvAP3YloUHLBTxreHzYM4
         9R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275370; x=1724880170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhwiS23I0RwoQrtwCYtC0yWnRBVOuvRQOlXGuZ9qIvw=;
        b=BRD0+eZKB/pNa7QcqAsRUwfyRSSoj7xk28eCulyOAEhd4MRzy2LAYtZMGyu0GmGIbo
         cjg9WLnyqFWc4WGk0o8yaQBMSCr+F6tSP5CBhaUS4rOlYwDQLljBGjydjoXu09x7o1CB
         TQQk73eUCg7jWRwXc46gT/DpXCjpgImymTfnjJbNj/7mN+7EQcwJ0RdUbAK7ImmvDPlB
         /x79Tghz12XFYT5ggJl+jum85gcUTj/R6DvCJ5wKr+YViq9bkX9Rn5Ozpl/m5Ugt51NU
         g4yG9CI8SnTC732PDdJmit1Rdrddpd0t9EnuOEnEy4+i30J2soyFjsSc+nasm1sR6TsH
         J2rg==
X-Forwarded-Encrypted: i=1; AJvYcCVxPkvistuaWHY8o5z8u2jPHNxIqIkDRhqrrOPEXQhjCrM7PRMaxYq6AqPzYwoNdSkV/mIMg9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiSXch6+ThzDFq9y3DTysQ6ckfL/taf5f4y6mzKJtytKUfW00
	LQYifo6ro0iNmAxhSiS8MxLD6Rl0n9uOfkwC4pWCiubdLONX9nSvVzCC5C7bCw==
X-Google-Smtp-Source: AGHT+IGigd48/gWOW8zpTOltpfP0Hf16lKGKliL1Meslv7DbvM2+k9b3SA36hE0kDuSRCQNx4qbi6Q==
X-Received: by 2002:a17:902:db05:b0:202:43fa:52f9 with SMTP id d9443c01a7336-2036806f2cemr39493155ad.29.1724275370477;
        Wed, 21 Aug 2024 14:22:50 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:50 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 10/13] flow_dissector: Parse GUE in UDP
Date: Wed, 21 Aug 2024 14:22:09 -0700
Message-Id: <20240821212212.1795357-11-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse both version 0 and 1 of GUE encapsulated in UDP. Add helper
function __skb_direct_ip_dissect to convert an IP header to
IPPROTO_IPIP or IPPROTO_IPV6 (by looking just at the version
number)

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 307d4bb20e99..0a8398068756 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -821,6 +821,61 @@ __skb_flow_dissect_geneve(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static __u8
+__skb_direct_ip_dissect(void *hdr)
+{
+	/* Direct encapsulation of IPv4 or IPv6 */
+
+	switch (((struct iphdr *)hdr)->version) {
+	case 4:
+		return IPPROTO_IPIP;
+	case 6:
+		return IPPROTO_IPV6;
+	default:
+		return 0;
+	}
+}
+
+static enum flow_dissect_ret
+__skb_flow_dissect_gue(const struct sk_buff *skb,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       __u8 *p_ip_proto, int *p_nhoff,
+		       int hlen, unsigned int flags)
+{
+	struct guehdr *hdr, _hdr;
+	__u8 proto;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	switch (hdr->version) {
+	case 0:
+		if (unlikely(hdr->control))
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		*p_nhoff += sizeof(struct guehdr) + (hdr->hlen << 2);
+		*p_ip_proto = hdr->proto_ctype;
+
+		break;
+	case 1:
+		/* Direct encapsulation of IPv4 or IPv6 */
+
+		proto = __skb_direct_ip_dissect(hdr);
+		if (proto) {
+			*p_ip_proto = proto;
+			break;
+		}
+		fallthrough;
+	default:
+		return FLOW_DISSECT_RET_OUT_GOOD;
+	}
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -1000,6 +1055,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_GUE:
+		ret = __skb_flow_dissect_gue(skb, flow_dissector,
+					     target_container, data,
+					     p_ip_proto, p_nhoff, hlen, flags);
+		break;
 	case UDP_ENCAP_SCTP:
 		*p_ip_proto = IPPROTO_SCTP;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
-- 
2.34.1


