Return-Path: <netdev+bounces-120733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F695A680
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65B5282835
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A4176FB8;
	Wed, 21 Aug 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="S+988jB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E7178397
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275375; cv=none; b=FME+iGxkKY9wVVtih2oMAFu7BQFEhymFfY5imlFc/nAn/7JiMhIFWIbZxXyu7XutRcnkb/NMNLxoCefaC66nxSqmG9NeXdVVqYzLEmt+k5qPzm9Q+ykjcA3CXfw9Iebbfsu5yZNtAVOt6MtBDR2CxIB0pYM1sHSDsrWMHoNRPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275375; c=relaxed/simple;
	bh=cnD8LFJn8TZDxIa1ysgrwltIkpK9d6Wl+nQo5Q/8h+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgcdKouLZXOfhfaObw/PHXd2St4XxP//Vtf0RZRhXXlogtkPJxnuT+EJSoIM7L/0ruk1G5eaWFq0gSqFcMxBQVd+4nw3H22uAEBibcuNSVfdhp4oyRCCelxr2XOjFUJGCKpO2TVNhVep2YIEGWpMdT6VYv+SLRXVWgYLnA8WjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=S+988jB7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20203988f37so1259495ad.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275373; x=1724880173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqM8G2cuLTbcCpe04KSh789Vdwo3Fc+lpjauFdgQsRk=;
        b=S+988jB7M+qnYSFzaLfxGbuc4EeRUTWbbA5RiCwlg5S+wHHwMSIWU9j4ZULrlaAr7N
         /MW0d6OnHeMbN0+SCT40uoroiV4vcc43uGiNvLp+A94AlqFhmuBINp3rr8LdGjqqxYLs
         J+vmxOFHLa3nHmcod2OCZ7BaT0jqcF63jJCxSynAfYYySz+qWFeDYttCXj9dffQK0+W4
         DdEJCeLQZQliJlUp12Y/sv+n5vIdBSCKrUxKdSa1Wf7NpabYkg6dsJy+iZfSK5iP4R4Q
         2XYOEwgYI6qq8VRInovLusLGNZp0YegGPLmH3dzHjB3JjBlKZiUZLNQF/7NK2iAJvGb8
         es4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275373; x=1724880173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqM8G2cuLTbcCpe04KSh789Vdwo3Fc+lpjauFdgQsRk=;
        b=U2qoXrbJF9sON1bjBO1p9ccmA8wzLrS/sZ07GBJClQ5aILX5rCX+ynmwiCT0ndnkej
         la68V2ZJ7BUStJyDN7eNNUEioRbzSICZlZhLGpUcBv1+T8tr7qNnypNrI0q26ZBI8ZL2
         jkR9xy0BwTGsvwViOerOGF3wmhvTRurYewKFBV5HQlslIZxIwdoG3Cz2jZYc97X+anFR
         FnaIlVzxpHz1yvYGaAjI1ZUXoz4RYzQRnB7+bGtMj4U71SVKQD0/h2LA6ng1N/AxY8It
         +OOyFPg1joo5pC8UuGRyrTjcAD/aMOU0TtnU9B7EPabK3jg2o8zKWihO+zygYMsUoeEI
         0nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlUA743MQbycccGQWgh/aauJBSHtxlabhGHcD/D5wUua+Dz/z73S+VK8UfYMv22cBtNblfF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRv6cM/cqGEdD4n1TZuLn2QWnRcXbtz86BHUxNXxf6S9XN9xtp
	iZafsy7F+l8tcx6TXDwk2C/ieqCiOFxPs+WnZIvCTNQa46PXWDsMn181G0308w==
X-Google-Smtp-Source: AGHT+IGd0OHwVtUb7Bjl/3ZGSS0VR72/7wzMBNFHhNhglBgtzUGgSWQwgkBa2wkcWZZHwY64V2D6tA==
X-Received: by 2002:a17:902:e846:b0:1fb:415d:81ab with SMTP id d9443c01a7336-20367e64085mr39375255ad.20.1724275373294;
        Wed, 21 Aug 2024 14:22:53 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:52 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/13] flow_dissector: Parse gtp in UDP
Date: Wed, 21 Aug 2024 14:22:11 -0700
Message-Id: <20240821212212.1795357-13-tom@herbertland.com>
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

Parse both version 0 and 1. Call __skb_direct_ip_dissect to determine
IP version of the encapsulated packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0a8398068756..ee80c2d2531c 100644
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
@@ -876,6 +878,91 @@ __skb_flow_dissect_gue(const struct sk_buff *skb,
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
+	/* Skip over GTP extension headers if they are present */
+	if (hdr->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	/* Exit if either NPDU or SEQ glags are set */
+	if (hdr->flags & GTP1_F_NPDU ||
+	    hdr->flags & GTP1_F_SEQ)
+		return FLOW_DISSECT_RET_OUT_GOOD;
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
@@ -1051,6 +1138,16 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
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


