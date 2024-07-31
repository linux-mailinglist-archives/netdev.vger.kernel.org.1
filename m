Return-Path: <netdev+bounces-114642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1189434F0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61861F22EB8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423391BE242;
	Wed, 31 Jul 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="avsmUrIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829891DFE4
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446643; cv=none; b=rHvykBqhFtetR4EGifF6fvGjc+VHLbcoE7/3GuP1Stxp3VRrhXMShpplMUqpfiOtxVfIRPDh7SlILOsGBZqlPQrtZt+AXRLGsXqs9VgLStbBo1cMWZ27KRFYsw7c4ZhvbG5dpPsJEMOfVOlQFnHZZxflnHJ6hNKb9jDgYze2f/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446643; c=relaxed/simple;
	bh=n51CI8cK5wiEvOfTCSLy5pPWmLpsIxNMT5nP6x2nZO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBuP9WNXubpWxTrLkxil/XWi7SXLVVXC2pexPjv0RDT8eguGfIkZoKNVOSIP3km2LLONqelCylXwGWnrDQdatUsZ8PzgRYbDn9iEpfnpjYoB0uD8AY+w9Y6Zzio/fxYfToZBN/kHPzvBjBZafJ248IT/Pq9p4ZFCZ6f1CbJiAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=avsmUrIc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso4401626b3a.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446641; x=1723051441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0SX612ERSBxho7BUn2WEmD8uBOhjYomrMitKQTE+JU=;
        b=avsmUrIcAjdknyz5NgIqwc4f2/+wxOoI9aMQcvHmLuosSeIO+fg7Ud7KxESjcYnuOC
         /pAI0SjEYeQeFraSBffNBgyIb9ShyY61GjELggkvanM/Er0MpEdNsZbiRENt//cXUwLv
         z+x25lZhCOpwif7bHnLfVc7QD8HuiZ6WXvLoL9KuYwcvEOBX6zimrzp7/lSHhpJ77Umc
         Tk2eRXLSSNKZrFJESw308qMHm62rNADkVZjwW8zFbXNA+8410CLylRSbGUrvEJINbkqa
         iy4RN0tqfVB/FicUZxCw6ipBBsheTRZeq5JfkWwh9wgW6JXZ5plWDbwV3dSEoZ3xCOgN
         lZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446641; x=1723051441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0SX612ERSBxho7BUn2WEmD8uBOhjYomrMitKQTE+JU=;
        b=m9XDFacKVtMOWcYloHz0kUEk0RfmUU10GA2ZaQwtSCUUcDvsM7LDfG3U6eaVICAWGr
         yBs9YTvnY7vBQsP52n7a4Jp/oJ83Ni7dCJNf4DLH/UIz6sAEaGEUvyb8FZqoI/jTZCXT
         6UrJ6nQkaED9ajJP+GtI3piRjKGR47mhZwqM2cN3zSGwATL6PXUGOVwI5nbDhtqPbTcA
         Rh9+ioK7ksWCKP/0D8B4Zlu5n366iNtJPpNzUuTf3+pz/772XrIjzGMfeBvMlXRRUJVv
         4iXh20t+Qh0PgFJc4J2ClIbfhbH9E7PZ1iNnoxgQ6KMw0kLE/Nsx1O3b+WVEGGYCsgGW
         D4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVzMdLAw1Eb+v2nWo9i+lawn+QmQczxSmtTsSn0Kdz784wskzZ0O54rUzQVS4Z2nKKQ19xGk2yZoH/1OJuDog4MZS8g61Yh
X-Gm-Message-State: AOJu0YxJv98xB6HU1mwfFmV1ahNoo9b2+UTbRGpXoLsMGMPvsWqJphIk
	striG6CzubiahAcIKhut4PpH024ygsRUArFJfj/A9yLfzKFcyDDs/cjCuu2Tcg==
X-Google-Smtp-Source: AGHT+IFiW3hw86EkTuRM/PR9zTUoY0DhF03AmrMzsNEIVGvkZovEzhGfAQR0AdCxxEAgbWASmQ9jNA==
X-Received: by 2002:a05:6a00:94a2:b0:706:b10c:548a with SMTP id d2e1a72fcca58-70eced8bad2mr13785947b3a.22.1722446640730;
        Wed, 31 Jul 2024 10:24:00 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:00 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 07/12] flow_dissector: Parse vxlan in UDP
Date: Wed, 31 Jul 2024 10:23:27 -0700
Message-Id: <20240731172332.683815-8-tom@herbertland.com>
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

Parse vxlan in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 006db3b893d0..6ad45b09dda4 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -13,7 +13,9 @@
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
+#include <net/tun_proto.h>
 #include <net/udp.h>
+#include <net/vxlan.h>
 #include <linux/igmp.h>
 #include <linux/icmp.h>
 #include <linux/sctp.h>
@@ -756,6 +758,55 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_vxlan(const struct sk_buff *skb,
+			 struct flow_dissector *flow_dissector,
+			 void *target_container, const void *data,
+			 __be16 *p_proto, int *p_nhoff, int hlen,
+			 unsigned int flags)
+{
+	struct vxlanhdr *hdr, _hdr;
+	__be16 protocol;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	/* VNI flag always required to be set */
+	if (!(hdr->vx_flags & VXLAN_HF_VNI))
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->vx_flags & VXLAN_F_GPE) {
+		struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+		/* Need to have Next Protocol set for interfaces in GPE mode. */
+		if (!gpe->np_applied)
+			return FLOW_DISSECT_RET_OUT_BAD;
+
+		/* The initial version is 0 */
+		if (gpe->version != 0)
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		/* "When the O bit is set to 1, the packet is an OAM packet and
+		 * OAM so ignore
+		 */
+		if (gpe->oam_flag)
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		protocol = tun_p_to_eth_p(gpe->next_protocol);
+		if (!protocol)
+			return FLOW_DISSECT_RET_OUT_GOOD;
+	} else {
+		protocol = htons(ETH_P_TEB);
+	}
+
+	*p_nhoff += sizeof(struct vxlanhdr);
+	*p_proto = protocol;
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -893,6 +944,12 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_VXLAN:
+	case UDP_ENCAP_VXLAN_GPE:
+		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
+					       target_container, data,
+					       p_proto, &nhoff, hlen, flags);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


