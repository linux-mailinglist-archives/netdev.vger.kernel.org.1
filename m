Return-Path: <netdev+bounces-121511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB695D7BD
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B40A1C23148
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156B91953A3;
	Fri, 23 Aug 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="JjKmibSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB194C9D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444181; cv=none; b=VuTLP8VzMVLaF3PBF6TAYyD1Dp0RR39hh4FRfSX9gMPocD86IaC8YuXeoPitRr9z5OFWhcV/oqFTtWyc5I3I9aUUlvgSd75cAYPS9P6k6q+XaZ6nhiYitIT4Tz3BkNK8Aw5+tR2RqWoaAMtRI9kmqiacv6nDnPVXkWgCbu05ihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444181; c=relaxed/simple;
	bh=VOdMMqBJT5gfV//2Em8zA2+MB+y0Dz6omzqKA4vn7kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvbrdNgt68pZIUQmlR3gyK7dARbMcxNf7VbkLohcfuee7u7Wh2igao87RBiHs/FOSR10RHKnMomi1i6/tz8L2bGRT+8KSD845u5kAyyLbM0TA7nFn9kHsKUEbZ5OvDas+fPfgu14ycg5jGO879dgVohr/kXBZEJf77yrpLrhaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=JjKmibSu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714186ce2f2so2057810b3a.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444179; x=1725048979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY8Ll53JZEM5OHYIrpL5YbN30bPKt3HuE+whQGMJljk=;
        b=JjKmibSuDJ+v+mS+zIVPxlxsWdd2t/ohdA0nz/HHNPVTH1uJUL8iL4dHNme37vOhbL
         LAMUquEvl9MEquHowUZW4z0wvVdK47kubGf1TvQx7nEFzLlpdoR25cffXD1QHArhBF7y
         0PcbLL+QDl4M5iv3vt4ERcefxPpmyX//1YogaP5WbKV9vYu02tbNpXlLZ5tMUr3vxax4
         W8twhFsGUEf6drPQ1IdBpbwgiU6oqQvyFYwgXtLG8XmdUYLg16n8+qLXTQOB+L5DaJ5U
         dPGy9rT0iCPeNpD7Y2cY/sQcib81KqvGXMUG23uL8DCiyQFN7sfUveHA4UF+z6n9rJI8
         +f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444179; x=1725048979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY8Ll53JZEM5OHYIrpL5YbN30bPKt3HuE+whQGMJljk=;
        b=Lt1tMX9OeAAul82bKiP/JTgCnsMm/PGpsHZYa2EYujlKRxajeIApC4oxm59OzvnBuR
         28n5nTPW5D9eddfkn+OIVIXuXzaMUqBL6IgpKVeytpMNTYqJl2iL5MyPgyiJg+PmorVk
         wwVmsW6Y81W6tXcmmT6D3FOOGg+Jjq2RpVZWLanL3Ur6KAQET6Sc0RHDT9ehuJ1bfppt
         bg8NRkXJcAA5Jo162fqptckJ2j59Jma7ecl0GZYjGUoQKWX1J3aj3ejuXlkNnFRr2u31
         mdDKmRBOe7QwjIBOdIzVBDKLPkska98f76ACKifQ1Y4pCnegScxKFGT8kxI2TwYa60VA
         pLAw==
X-Forwarded-Encrypted: i=1; AJvYcCXNqiSLJwS7y2MozFZQAyMkarwuygHlfsWJRMwHgDuqZn9HRUBRqJRCTwb9Togi+hNqteR7dOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKwvqWiu7XgUOZZxpRZU+qTbkQNcMp7MgYo/IEG5vo+CR7XBV
	Zj2ZQcM+1hygCEjbPrHYldVKRNXX8B3f6AfC1cIzGGONthWCg2kO8AiEsNSQTg==
X-Google-Smtp-Source: AGHT+IG2J15abxunlLT7l/suTZjDnmu9e+evc6hS5JzKfeAVBLH6qu9rI2SvmLtMUjk5xAHZRwL+Dw==
X-Received: by 2002:aa7:88c2:0:b0:714:340c:b9ee with SMTP id d2e1a72fcca58-7144573659dmr4377631b3a.1.1724444178728;
        Fri, 23 Aug 2024 13:16:18 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:18 -0700 (PDT)
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
Subject: [PATCH net-next v4 08/13] flow_dissector: Parse ESP, L2TP, and SCTP in UDP
Date: Fri, 23 Aug 2024 13:15:52 -0700
Message-Id: <20240823201557.1794985-9-tom@herbertland.com>
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

These don't have an encapsulation header so it's fairly easy to
support them

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e8760c1182b1..dd126e72f880 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -965,10 +965,23 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 	ret = FLOW_DISSECT_RET_OUT_GOOD;
 
 	switch (encap_type) {
+	case UDP_ENCAP_ESPINUDP_NON_IKE:
+	case UDP_ENCAP_ESPINUDP:
+		*p_ip_proto = IPPROTO_ESP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
+	case UDP_ENCAP_L2TPINUDP:
+		*p_ip_proto = IPPROTO_L2TP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_FOU:
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_SCTP:
+		*p_ip_proto = IPPROTO_SCTP;
+		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
+		break;
 	case UDP_ENCAP_VXLAN:
 	case UDP_ENCAP_VXLAN_GPE:
 		ret = __skb_flow_dissect_vxlan(skb, flow_dissector,
-- 
2.34.1


