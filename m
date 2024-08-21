Return-Path: <netdev+bounces-120727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5416F95A67A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B74E1F236D4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE9179970;
	Wed, 21 Aug 2024 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZMrt+iOp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEF175D42
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275366; cv=none; b=Y6umTNPsBgq83e7EEpTCx+rBPBtOffpfzjxIEtkVTFNQXDzPv1djluJ4ib9uAaGlz+2MH92RZsvpQyxdav+Qpw5kNCuJyyKLyp48Lgju6uVbEKxdzOy5ls3E0FRg+2+5lxlpV4zM51UJnqfGqGafDKj7WoXf/htShhVTMHQ7n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275366; c=relaxed/simple;
	bh=3DQ6ma+A0vozs1hkgO1gvkZQH5fte0StjfazO0usrP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzD/Q/iZGYlug6kJieUOyOwf92cITcTS8WqaoQWM/ohsR2xGIoKPyn2NBMfrTT6qqfqnLC3Xlau46kghq35kV0RLtwwc1PIcgIAVvg6hiyKuRvVBuYafuNkgmV1sN+Iqmz6pBKz5ZrbCPCqUn52E7oDQ5HjnecvbrKEtZrwZlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZMrt+iOp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202318c4f45so1347965ad.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275364; x=1724880164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbIFJgKehoO9POmGcrLBdJ/KQY3W1THGNVCwYfkYyqM=;
        b=ZMrt+iOp5XuoRBMtHFQ9sA5oV46e/szC+1pXUCRkdLiCVO2mM9r0JNxK+grYboJWYp
         wxBs+uVRUa1evkmgkZOVTQRt9TYXqw/PJAdrpYbd7DgpXRlkqQNu3Yh7B29kF7iMWDqx
         7xX6OSIv3nFn+ZcXVmPYTsc8bVG64+Npo0FGE6QAjRJFK58jNhScBnJ/6enpiu86oZjt
         Le0ioxv5L8Oz/uyDUX6vJ7BfbnT/GRC5VYzabuV6EgCR1zqgwsnmN73x5l6PusPVu62A
         aqusj/MXxN+mj30uxbr50Qb/CBpbd6P8PkKlyllXaxWMY40vO54CQZcZx55+v2PLwnw/
         NPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275364; x=1724880164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbIFJgKehoO9POmGcrLBdJ/KQY3W1THGNVCwYfkYyqM=;
        b=ml53OVtU6NuHdqnQl+SscoL9PH6h9UqOBbHc1N2Cf9zgqVXHqFvS520e1dtnVnbbx0
         N2tqUQU7SmBtZ4MMpOniK8xk64ZlUk1tb7WBBjqjMjXmFcjKEkClKgbLhy58tsV1AXep
         7vLwBOcSuTEZ/OEYk1gE9LcomDGX60PNYomA/jZF6S55ube5Z4vICTjooqKp4t+ZsD3b
         DN0j8K0xmj/mBKs2IeZIJekE2I38Z/vaO4B7atSReEI0JlQnQHqSPYlFbTlQFWTpB+7A
         xj601QxoTDI3hm4erBoRu99n1TyWzeQENPvWVKd/pnHEG1jbXvRfVFiObEZQfUIOiZDp
         GGXA==
X-Forwarded-Encrypted: i=1; AJvYcCUQl8mLocW8ZQEdsO6Xs0YOdADUwaGPYEnh1kyuOLob2woDO9qsHcmJQqJvVIGZ6ZwBPiDy0k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURkpfyexWlcJgym2W9J6akGvnKpwV92oHyk1LnMUQKpMnykPb
	3xLssLxwbRe80WaZ1ExVadiCSRSYSNjazs4K/xBnajVJmqIJGAuBYFgFLSXrLw==
X-Google-Smtp-Source: AGHT+IGwSVnK7q6SuO38MSPyha4ii0vvvaQXbLIGY6HjnfJ2m0fAubFdbHN2hqrAUze6yJuOf2sK8Q==
X-Received: by 2002:a17:902:ea0f:b0:202:3a49:acec with SMTP id d9443c01a7336-20367bfe058mr46354995ad.11.1724275364344;
        Wed, 21 Aug 2024 14:22:44 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:43 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/13] flow_dissector: Parse vxlan in UDP
Date: Wed, 21 Aug 2024 14:22:05 -0700
Message-Id: <20240821212212.1795357-7-tom@herbertland.com>
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

Parse vxlan in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index a5b1b1badc67..452178cf0b59 100644
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
@@ -756,6 +758,44 @@ __skb_flow_dissect_gre(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_vxlan(const struct sk_buff *skb,
+			 struct flow_dissector *flow_dissector,
+			 void *target_container, const void *data,
+			 __be16 *p_proto, int *p_nhoff, int hlen,
+			 unsigned int flags, bool is_gpe)
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
+	if (is_gpe) {
+		struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+		if (!gpe->np_applied || gpe->version != 0 || gpe->oam_flag)
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
@@ -916,6 +956,13 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_VXLAN:
+	case UDP_ENCAP_VXLAN_GPE:
+		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
+					       target_container, data,
+					       p_proto, &nhoff, hlen, flags,
+					       encap_type == UDP_ENCAP_VXLAN_GPE);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


