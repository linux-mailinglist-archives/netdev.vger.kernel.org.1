Return-Path: <netdev+bounces-121512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90595D7BE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AF11C2338E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319B195808;
	Fri, 23 Aug 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HpBBrliA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5351953BD
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444182; cv=none; b=cCI5xI69pFpI27japtmBxN4fMtMQ75oHkTf5SsF6cgwNz6wCOQHM1KgJHsy+mhnbXTggz1uruTXc6lAhf9idvi6VkIFScQKoE9GZzR6ogqJ2/7Oa6U8OD9cbfifhyMOegFx03/QY42I2IQNRdlrcgzeQo/zx9721LPDLNFCibhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444182; c=relaxed/simple;
	bh=VTXkwMEyBGBbqcXgjhNII4kl2hwTBqwNmhUpw2+QMfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tcu2Fo+6LPb6cvyfekiwSK9ngVrs7jGzNScKFvDZTL8J0/wbUguCkqfT7MXQvOExlPg5X2BmeDhmmPH3sN5s2x5PHN1kKQzrQ2hb4T0oHJRqR/fC2EMLDMv+PQU3EuHCSp8pSuRaWxpDngBdso5pFPg0EJWGCial3GoOL3RJ+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HpBBrliA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7141feed424so2183069b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444180; x=1725048980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm7+d4JJAYctB22ym4m4D39UpYANdtXQAcOqQ/0hocU=;
        b=HpBBrliAJKIJ4KHyKhOBqkNp1tiUhpj5a8PsW3IBho4ndwDR1TD4O7OcmUhXAdEp1w
         NmrSfEwjrxVpLj0EeFl1pV2wYpHhrtaNa9Wfh/FiQ9ITMtnJgF9p7pYHrsXC2wTwUWqu
         howhfA4o61cty8DeYC/CVO1AJpNc66/FxBL9prmBG4mKZxkI0y8zDxzdcgv2XBQ7m2eM
         hsU8ZLn9UQ2cHY/hR78ByylX1lvzA5Y55POkuOaI0UBBKnTHjlddypAliKKo2j4K4oQj
         xHpk+w44eNVTGu6Gicc2n2V/6+nIRrWztwmfekL38ijbOrC/VfOhZ2GgDCv9Gt8dI4m1
         3vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444180; x=1725048980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm7+d4JJAYctB22ym4m4D39UpYANdtXQAcOqQ/0hocU=;
        b=Qk9o494EQWh48BugjyGP8x+7FUWryI6lda5rsQfGZDwmAv02h120BFOn0jClAlbpKg
         USvhpExSTL238mWUJVL2c/H9AqsVdqmRdfqQimbtzsAgZhP6KWmEUlhFuRTLSxbhmU+0
         ID/ujcSWs9kwKS5Vft+8P1ybEHst2QMngwN4lZHV4Bs27AkYSiEBwz6bHknFMRyxxl10
         wz2Jl2PvTmI0W2TQJ2RhbsOpzW9vSRIzTPL8l10oY0xYzIl4WQ7bNunKk3ZlXlRGN4/d
         zGkLUYpq3vISkXpQPISNwBJiSna8aNRLfr5QriRv+YNQDMf1sZshOkqOgStkvEyYg+G8
         Xnnw==
X-Forwarded-Encrypted: i=1; AJvYcCWJsSUiQaAKeLmZDYnU8NcMafwniMfrxZ4Botp6h93VcL6q5dJC/OBZo840ZUx3fBhw0ob37iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrv24QRkX4a8dzvnmYfL3sHDP4Ue79vKjIbDutlCiDzZgaT+X/
	cj2GG8Tj8CODossFx4lW/eqgbzFqjXxq4a1ij/3JGgWWc2GtG2GEsGtNVP/fTg==
X-Google-Smtp-Source: AGHT+IF7owriLrYMdFjfQDYLMH/t7kgGcA9P5zP5Slyj2tYEDsvigyoDHLugUgi60oHAYEpZaD4fFw==
X-Received: by 2002:a05:6a00:3e02:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-71445d5a51fmr4664170b3a.13.1724444180443;
        Fri, 23 Aug 2024 13:16:20 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:19 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/13] flow_dissector: Parse Geneve in UDP
Date: Fri, 23 Aug 2024 13:15:53 -0700
Message-Id: <20240823201557.1794985-10-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse Geneve in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index dd126e72f880..1deb9c3a75aa 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -11,6 +11,7 @@
 #include <net/fou.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/geneve.h>
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
@@ -797,6 +798,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_geneve(const struct sk_buff *skb,
+			  struct flow_dissector *flow_dissector,
+			  void *target_container, const void *data,
+			  __be16 *p_proto, int *p_nhoff, int hlen,
+			  unsigned int flags)
+{
+	struct genevehdr *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->ver != 0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_proto = hdr->proto_type;
+	*p_nhoff += sizeof(struct genevehdr) + (hdr->opt_len * 4);
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -989,6 +1013,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 					       p_proto, &nhoff, hlen, flags,
 					       encap_type == UDP_ENCAP_VXLAN_GPE);
 		break;
+	case UDP_ENCAP_GENEVE:
+		ret = __skb_flow_dissect_geneve(skb, flow_dissector,
+						target_container, data,
+						p_proto, &nhoff, hlen, flags);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


