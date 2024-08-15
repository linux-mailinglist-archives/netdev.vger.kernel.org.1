Return-Path: <netdev+bounces-119005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9F953CE4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC2E1C24E03
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE3155398;
	Thu, 15 Aug 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Fkp6Qkxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366315531A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758385; cv=none; b=CtSqta1hxBZRkvX84uaTXAqPUPH7aYu8rDDAIBtlLiZJvnlkMsQDEVIxwrJ7eMr0KQnNKcgVR5Dy8obpuQ2F2VP2lOOqV1gMfAQNar0ZhBvw3muyzYrGDDuyQFKgLMTq+cm+fvQDyBmQcERO3sAKLiwQdqDqEaOkAm5CNsY1ptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758385; c=relaxed/simple;
	bh=+L3PxYRN4rxWkDczdXPPa9GErwl/3ywUvrtMJG7ANdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWIZYM6JpCc43CWC1cNA1YSCSzZoGRKaYx8D7RDRUeDifbNFTcUZgQ4zyLNcHMKlpxEGbrVUmdzI9DwZ2+19kgFCWYg+I26uKTxiSRb64IsLMoIGJvmpjIll32U545s8cqjzin0YnRJNUjvP2GA0dppCfDzkg/ewhdFMSSqQzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Fkp6Qkxd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so949016a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758383; x=1724363183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzF9x4/T4xaT7sQe5OBeO8JW+tCEl/mAvMEK7IpsLHU=;
        b=Fkp6QkxdGgu/aSSMaSONVThH7+GFWPRwxWQN8dD5u/FsGoho5btGpoOcJzUluu9F89
         KWifFR+UA0mHfNI72+HQIwOIiMdCVHZFr++ig9oeoxjBYhs3DiuRzPblO75uef6dCbaR
         68QsF0BcByI8qT1//mzVddx8YV2PDRQYsw0vWGTLWpHKt02CUJCOvts2MGYxzI0NIQpH
         9l5Q+pjg4S4VRf+mKLhP79KLe2wEz2lZeyoQHS3xCk2RO5jS6UsoCKWEOBTW/PiWZD3p
         ONU2DqrNj0Wma8LHnxMag6E1cLM5xJELvyozKxpaWMF9Os/QFuPB+UCdknYmtWyhBP1t
         9cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758383; x=1724363183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzF9x4/T4xaT7sQe5OBeO8JW+tCEl/mAvMEK7IpsLHU=;
        b=MW6VlUrsEdvqkKb4qzsutiMrXbsYSGjjwAiCTXOvhi8t4U+dLYYwOsIZ9SnLlqyQhb
         u91oIHvcGRuP4J4ewzXmFqNouLFdBbDRLOL6bpIyaiP7Lj1UjvBSPnEeipyJqEqX5jWc
         y6h95xEwfKjnZ3mWztv7Uto7DG6gO/axd63ptuGLSyhWCKqSgjLlqt9e8mbVX+pgZMlt
         tCF3XLVGjW1W8syJoQo0oZ7Sf+WxEui3lBu+P9m1tXaphv/GoJruh+4OZJE5uKC+0ssp
         LKtDrnXmQ+dDrkes7A/nJSTZ+oVV0gkPHfVNdfyvWbVf1O7MrG2wZJ6i8LFRBFAefMin
         CLHw==
X-Forwarded-Encrypted: i=1; AJvYcCVByN7XT3b1idKxVzruhvI2BS0a41vOnW4QziZnsFR18RwGByoQ/LGT+myp+rdUE9GIM7b1wcKyZxXboXKMCHG0czM6gIew
X-Gm-Message-State: AOJu0Yy/U47YYyxFoRiDTH5Ef6+3LceSRcK11gIpT38Cb/TO/U/iyrzW
	DOI/xnaVUNOztP35iaPluwvcaAEHnx7U6QBwPpeh4jtMJaXTMcEwfnKcL9FtKQ==
X-Google-Smtp-Source: AGHT+IGWVozJbXq0RuQenJyd3tBKDVWG5VGoxzO0uh2q1sKPeo51rkAVwbJys4gLuRwJlciixfEhGg==
X-Received: by 2002:a17:90a:9e2:b0:2d3:b1ac:4bd3 with SMTP id 98e67ed59e1d1-2d3c3984d1dmr6665333a91.11.1723758382990;
        Thu, 15 Aug 2024 14:46:22 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:22 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 08/12] flow_dissector: Parse Geneve in UDP
Date: Thu, 15 Aug 2024 14:45:23 -0700
Message-Id: <20240815214527.2100137-9-tom@herbertland.com>
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

Parse Geneve in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 5878955c01a5..e2a0d67b2753 100644
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
@@ -808,6 +809,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
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
@@ -981,6 +1005,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 					       target_container, data,
 					       p_proto, &nhoff, hlen, flags);
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


