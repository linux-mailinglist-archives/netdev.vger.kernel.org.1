Return-Path: <netdev+bounces-119002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165E953CE1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07FD1C24D7C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B54154C04;
	Thu, 15 Aug 2024 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="U8IXWGmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE1547FB
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758381; cv=none; b=P0rD1I82hDLdoso79mXG5JpeqvtTKuUAESyG+LUf04xpudI+mIlgQXUjOcrm9aQj2WDw5o5FKR5adfiyob/3cfkCOPnj74EhuLgguk8JIEL+PzKFO3kKZ64hPgRKIlrX86okteIcQ//A4uByrXsJ2nYQPUOmD2qJeMVbjAVhuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758381; c=relaxed/simple;
	bh=Eu0gvtwEP5vc+i4ivHb7XKBq1Gpt/bUuqZGjd4JylG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VT1nss6DGX6vPTW8jRIo+mfRhkAS2emEuvmtw+Z1rO7KkGbeBWLahJoRvcNvCHO6g4NijgR1+NAf/9iePjML8D3u+CSK/vjF+Zsl5xqMRVoZAoEmUWAt9JWqu83oieSqh7R5SyNwq7jrE5FxYsf29oDu31/qInDGriWBF+5lcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=U8IXWGmV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7163489149eso1074711a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758379; x=1724363179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qw9rlCyrxF1posPx7i5iOLRFflQN5d/XkK6SF1LsBY=;
        b=U8IXWGmVWyeJ02b0P613dEHDFZdx5b5kKjOWkMSSecrC1yULSR3tL+ulRmJF/TkrQK
         CEf/v8dUbAjVQnrn0i9uqhY5TYEdRUvqZJmFdn3YXqFVkWuy4ofcN11/eyueQ7uxNjCg
         CVxIGw1Y/LZqdxbFPPiWM0Jctjuj895V7eRy35p8502/c5LOMQwEU2C8GHLEBWPq/4ze
         3AUQAT2VeQeKxtGjst5JGcUnNVeBMjvs1C5T7s6dZotlkT6SQQ86RrhQLa1e8OPgstY/
         tb/tQlieB+nUSm71VGbJRwoRPSA8okLVsNFnnEr3950+C3Ht0qLbJopUHrkB2OfIcNmy
         siPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758379; x=1724363179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qw9rlCyrxF1posPx7i5iOLRFflQN5d/XkK6SF1LsBY=;
        b=vYQMTv/tXbF2ZUnwBbqC/wSoYOHO0Xd5wwYG9qioBBQdy+S/T6jlLApDFENzLYJwOF
         AXxStZxfzCazUoKRzAKb75m21qo3BJW4O7slHPKrIDEOMxM9TiGMPVr70oaylOGar36G
         OFUtGwXPfGDPkJdKZDlvUG1P4zSiP/vSpE+hszFgdJdoKUwJCVFhYSuwGLkKeG0Xy4qq
         y9OLO8wpf8CC9KFWWd3SL3V5BbItXegU+DS18qk0R+Ph49OffxMh1lvhtRxmMEzBMUDZ
         Nr5IMGYBGU18yRDfGCGZ5hHy2RixPcSDtN8a79CUE2NRmh6N3cDhJ71Ia7FCPfmGpDaI
         vvRA==
X-Forwarded-Encrypted: i=1; AJvYcCVUQNQMl93+0uhKvWa0NgjLHL3GD2k47MqXhwxG2PcN/EFwx+HsXZ9VBLLBqPz3WSKJcRAk6llrs6zacxGuAo+eA1SliqLq
X-Gm-Message-State: AOJu0YyA+hXhc/mLHjCh2D2bajNMiUPImazuemaZoIDC8n6DVS8Jm5cq
	WHJCjP7z/xQZtvkv+NZWddanuXuIz+V4pUtSBv8GVDyUFky51fTY8yIel+nOmQ==
X-Google-Smtp-Source: AGHT+IEhl2ouPCjcHl2h3n0KAgpV1jLfMjVxSxI+xtMi8Wucp0Z1O0PNZejOr4EF+S2YGLFEUxo3xw==
X-Received: by 2002:a17:90b:950:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2d3e00ef914mr1173296a91.34.1723758379099;
        Thu, 15 Aug 2024 14:46:19 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:18 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 05/12] flow_dissector: Parse vxlan in UDP
Date: Thu, 15 Aug 2024 14:45:20 -0700
Message-Id: <20240815214527.2100137-6-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
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
index 160801b83d54..57cfae4b5d2f 100644
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
@@ -900,6 +951,12 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
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


