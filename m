Return-Path: <netdev+bounces-114647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB09434F5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711CAB2242B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A31BE864;
	Wed, 31 Jul 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="UfWM2NpS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F81BD4E3
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446649; cv=none; b=Vi0cBB5T/1gqRn+tGfZRB6tYDVzjdkBIgVSahHlt/1JW4bm/WEg3+V541mXUJQD5+FIIiXj9QPq0diUgXZ9lhfQQq2s4wmZj4j8g+/q7rGzMbaiWRi+2EdnFgcciMvr6Zm6Y3ib+Nzl9RDpDh1WkNmXbNg6DLIOjgLzZ6CumhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446649; c=relaxed/simple;
	bh=Uaz0+6BevwyEXT/uG3eV6RgaEzEZq57aPBCVyG9WuNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6ebgX8xoxVFRJlKihmXf74Sq4ndkBgydsWhoQ3f5/ZJzmcz+Z96J/3+sMeVZ5RJ5zqn8S9vMZHlA8lMiUkzpOKfqtSu0NQYVFx3WvhwJBfMiNuk4sTrEUiORfI7XxDTqpwdIhihCuflWojQ9BrJUaeAPKb2mBVjgNeT77rbChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=UfWM2NpS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-710439ad77dso1572228b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446647; x=1723051447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTJAEyJOqHchmjcd+P/9wLzF9JPDrStciBj2jppQ1sU=;
        b=UfWM2NpShUE+jzgJm8cuqHLmK5ZD14TX21ZLUrAi/MQyPlkiMN1/w92rhFkCUaudkk
         Dz1zcHy+e4eCO4udeE6WMGjYMz3jTxDA7XWGNfB2T5qcbT7KyYH84ZQgPeR1EhQnRwuu
         s8UatHcvv2HBkP0eo18DXgXCEW2AnyA7eXwC8v41rSAaZDAatLqpX3a2ef7kWnatYn5g
         PTew06gXla2giUMo3W+fRrPDaKHl0mHUtIRU4srWP/WchEOJuujpsW2W2e7qFvGrZ+g9
         U26TJZctqV0mhYPNIOQKteRpodAspkFTsBJMBz3S/cAlSHCObbk84RwhOekP22rjMxOH
         +VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446647; x=1723051447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTJAEyJOqHchmjcd+P/9wLzF9JPDrStciBj2jppQ1sU=;
        b=CDJAH2k8uYvh75aEH8yWDVI+TYST9N1LMdbotot5vynI68YC7c+w4mG+hkcTZkpApx
         2fZ8cZax2SsiNHed3vsZ9W2dvkRWj4olx5YemIKbFFk/VygyUX+lAlokYda3huJhJL9B
         Npr51Q3/aS3+KXtkYKaFXvcS+JI5VpATpN6vL26lA88Z9pC9XZw0Jyaft4smIWXGnP+3
         GDnsJuyrTiRf6qoCCi9Nxx5530780dn03jcIX3L1wnDMZGjPD/HBJBEQ6MSexFagDFwa
         3ohh3QY+xiPlWIckwdW54FOZZzGac169eOVOP15sb6dVpAjuBx5H1HKCx2Bd3AVksGPO
         psxA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVKNpdHmjE3QuCkgw0/qoAflWtBd5hK5jVxUrvLePAuLkZtcZVxkuSR5RilTZDfWHuWY8H3WzbsEwIG7drcuPVDJOz29z
X-Gm-Message-State: AOJu0YwOmczJbNW2pd8APEcGZhXVV1dkeOKvlu1jbSSvP8Z5Zd61ah8F
	spO5jmwy3iP9/zj14LKcLQQkpna8UQ09zR8mQ+xgggn+jIXUzq5IYy/urH8Qyg==
X-Google-Smtp-Source: AGHT+IEiKUQazBv53K2DGK3kpSwuO9lOEkL2727kNBNa81juQ8UzfIPmwo1cYq8f/5QIdYEuULMBNQ==
X-Received: by 2002:a05:6a20:4309:b0:1c4:9e32:b26f with SMTP id adf61e73a8af0-1c68cef30c3mr102133637.8.1722446647480;
        Wed, 31 Jul 2024 10:24:07 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:07 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 12/12] flow_dissector: Parse gtp in UDP
Date: Wed, 31 Jul 2024 10:23:32 -0700
Message-Id: <20240731172332.683815-13-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse both version 0 and 1. Call __skb_direct_ip_dissect to determine
IP version of the encapsulated packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 87 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 7f0bf737c3db..af197ed560b8 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -9,6 +9,7 @@
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/fou.h>
+#include <net/gtp.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/geneve.h>
@@ -35,6 +36,7 @@
 #include <net/pkt_cls.h>
 #include <scsi/fc/fc_fcoe.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/gtp.h>
 #include <linux/bpf.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <net/netfilter/nf_conntrack_core.h>
@@ -887,6 +889,81 @@ __skb_flow_dissect_gue(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_gtp0(const struct sk_buff *skb,
+			struct flow_dissector *flow_dissector,
+			void *target_container, const void *data,
+			__u8 *p_ip_proto, int *p_nhoff, int hlen,
+			unsigned int flags)
+{
+	__u8 *ip_version, _ip_version, proto;
+	struct gtp0_header *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if ((hdr->flags >> 5) != GTP_V0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	ip_version = skb_header_pointer(skb, *p_nhoff + sizeof(_hdr),
+					sizeof(*ip_version),
+					&_ip_version);
+	if (!ip_version)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	proto = __skb_direct_ip_dissect(ip_version);
+	if (!proto)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_ip_proto = proto;
+	*p_nhoff += sizeof(struct gtp0_header);
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
+static enum flow_dissect_ret
+__skb_flow_dissect_gtp1u(const struct sk_buff *skb,
+			 struct flow_dissector *flow_dissector,
+			 void *target_container, const void *data,
+			 __u8 *p_ip_proto, int *p_nhoff, int hlen,
+			 unsigned int flags)
+{
+	__u8 *ip_version, _ip_version, proto;
+	struct gtp1_header *hdr, _hdr;
+	int hdrlen = sizeof(_hdr);
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if ((hdr->flags >> 5) != GTP_V1)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	if (hdr->type != GTP_TPDU)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	if (hdr->flags & GTP1_F_MASK)
+		hdrlen += 4;
+
+	ip_version = skb_header_pointer(skb, *p_nhoff + hdrlen,
+					sizeof(*ip_version),
+					&_ip_version);
+	if (!ip_version)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	proto = __skb_direct_ip_dissect(ip_version);
+	if (!proto)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_ip_proto = proto;
+	*p_nhoff += hdrlen;
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -1039,6 +1116,16 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 		*p_ip_proto = IPPROTO_L2TP;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_GTP0:
+		ret = __skb_flow_dissect_gtp0(skb, flow_dissector,
+					      target_container, data,
+					      p_ip_proto, &nhoff, hlen, flags);
+		break;
+	case UDP_ENCAP_GTP1U:
+		ret = __skb_flow_dissect_gtp1u(skb, flow_dissector,
+					       target_container, data,
+					       p_ip_proto, &nhoff, hlen, flags);
+		break;
 	case UDP_ENCAP_FOU:
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
-- 
2.34.1


