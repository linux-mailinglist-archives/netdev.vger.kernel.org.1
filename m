Return-Path: <netdev+bounces-194556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676BACA99C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 08:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F423BA8BD
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3AC199FAF;
	Mon,  2 Jun 2025 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Gjmizt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD32C325A;
	Mon,  2 Jun 2025 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748847514; cv=none; b=OFZKBocjyG1jO0hrfJAf1GaGOXCCdmB5fe6M8pR3OM1mTgKVzf2ukTEbPoXi4ZctgMs1q7UCf9jt3M6rno74NgxKUallD0IjpvAfoWy1odecGx1GbbW0cxuaw4mtkLekEKOeLfuhuswzGBHjnjZYn4fNY7ThkM/URMy5JrhQEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748847514; c=relaxed/simple;
	bh=36YoGRNVVTqpXdGCUTjghs0ma3vWVTdWGftyJMsNuiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpdUvPL1vYdRaiswkBnF86GZJRG+U61PY+awXXB++nuTnl6f/LwHU6YK7uqtMAAFAIXDpZ5sP8wsJfQkERTg3GkcPvi1tcumeDcWiHdDvAQn5Mc+qJmjRodOumMx5mIM0OhXsEjF+moopEqy9Xiq6Qd2KIIiwA4qVrGt5Y6Qhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4Gjmizt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6049431b409so7257852a12.3;
        Sun, 01 Jun 2025 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748847511; x=1749452311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDcrKrGhdz3qpwk0ZQcPaE8P0Ivco4wK8bocZrfj2PY=;
        b=m4Gjmizt02MdzUVyRe1KDu+MZmxCKfe0W5mR6AejWlKG84fKk88Dbj3rXpiPGlhjOR
         Za9Sm1cudx7D51yGwlUdiKfc9f4J7xHZLuT32S2ZOQL9VS0C8yo9kFpeOduNT5xOo7ED
         JCxguzG8JQmUkk43A1K9rO2tVbfUCccgg7KDCeZ0PdwBUng9aRpl/G8tY0MrJ9rqX1Wc
         HrFgicsq78BfDP+y6BpTLTBVtpiBqijO7LHXJpH0JmU16EHlZHdbP5vwdJh90gZmFICj
         w2dKVhkYaJF+U5xYxGl/Y7jgaxLQ2nmJ7PlPL1YRy8OM4a1HfiHG6hDDeoPPE57fQOQr
         foAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748847511; x=1749452311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDcrKrGhdz3qpwk0ZQcPaE8P0Ivco4wK8bocZrfj2PY=;
        b=B5RpfqfEoc3B5unKMCzCR/5kvu7vPd2eJNTpR2cnk2nMrDXK+6peKYOg4vbgImLDvR
         ud/1qjwl8zJwlxvQlHQd5WHEH8GSyri1msi9sqGX+heVJUOsFxoUrxEq7R6taaQYU2lv
         tNcQuAL9mbsDn972rVyv+8mzXmjWwkwN2iFc03FTaiT0I4qLdhXFN/dIkjx67vDoGl5d
         2Zk3u5Itr9ABE+NnZRZREFXbvZ3ReUlq9r5l3ExdZXCc/ral9TUQSe++0x4OkAD9ixOl
         MPekNop5RC/6v5Rg5vqiBGmXuOVBQI3/L8kLiBAK1LRF6+pjz6sm0ljwkLBug5ky+ngp
         izxw==
X-Gm-Message-State: AOJu0YxbIPFAiXkgtXDDkxS478uj6Vs1L0X023bHC5zAb+5tDsWO934/
	PxwNVrr/XvTFD987yuWFy9ndHUGTmI3jK/pAiHnKPSbnlpC7/AMH75wbRzYXYMFK
X-Gm-Gg: ASbGncv9CqWym9VyMeOlquqfhBl0yHm0QLB6UKLTyc3N5zv+4sD/imuilvBtrpFOTPP
	DdVyY7+r0hl7EvRL/Jst15rbktu0iomYQzzhKUOolAq5aTcGIrIz5u0+SWqW+RgfSVT44jg3BII
	0l9ETmociKKl3E2K9zq5IwAhj8dnDi7mqtLvUs/YC5fuae8vg3nOd9sQfT+C2VuDcPUoCIWcJIP
	DBDqEq7Q9zVciQuu0YeOlEG+oA3k6nkRYezASIRBEvPDCnTr2GGI7OJNTEq4ULimsjnk8wnn08h
	Xy4Cl817mluIJBXM8M+7P84AG8aO4jBcVR1tBDYyWQTnOol5r923lewfRvxesbCUZ9nIRCDn/Da
	Nlb71JRLvehHzziT3EZJkOR0Q03OZF2tcq3i8hNY5tA==
X-Google-Smtp-Source: AGHT+IGNoi54i4X/skqBuDa2DtRQofGmlFtwkcYu8Dg4w9xQajNkPpbKysRLfQjSv52hKlUH+6Gafg==
X-Received: by 2002:a17:906:6a15:b0:ad5:6337:ba42 with SMTP id a640c23a62f3a-adb49513121mr564975766b.46.1748847510642;
        Sun, 01 Jun 2025 23:58:30 -0700 (PDT)
Received: from rafal-Predator-PHN16-71.NAT.wroclaw_krzyki_2.vectranet.pl ([89.151.25.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de8fsm760817866b.66.2025.06.01.23.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:58:30 -0700 (PDT)
From: Rafal Bilkowski <rafalbilkowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alex.aring@gmail.com,
	rafalbilkowski@gmail.com
Subject: [PATCH] ipv6: ndisc: fix potential out-of-bounds read in ndisc_router_discovery()
Date: Mon,  2 Jun 2025 08:58:26 +0200
Message-ID: <20250602065826.168402-1-rafalbilkowski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a length check at the start of ndisc_router_discovery()
to prevent a potential out-of-bounds read if a short packet is received.
Without this check, the function may dereference memory outside the
buffer.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
---
 net/ipv6/ndisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8d853971f2f6..bdaac5a195d6 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1235,6 +1235,10 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
 
 static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 {
+	// Check if the buffer contains enough data for the struct ra_msg
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct ra_msg)))
+		return SKB_DROP_REASON_PKT_TOO_SMALL;
+
 	struct ra_msg *ra_msg = (struct ra_msg *)skb_transport_header(skb);
 	bool send_ifinfo_notify = false;
 	struct neighbour *neigh = NULL;
-- 
2.43.0


