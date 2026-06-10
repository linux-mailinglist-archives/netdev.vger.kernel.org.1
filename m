Return-Path: <netdev+bounces-297593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /TJtKiY7KWrVSgMAu9opvQ
	(envelope-from <netdev+bounces-297593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F956668393
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:23:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=Kx3DhUUK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297593-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297593-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 036E1304C05D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116B3EDE48;
	Wed, 10 Jun 2026 10:18:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D48E3EDABA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:18:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086736; cv=none; b=QLS+Cpp4keB5vENP8VO/rGsRpjqGSvd9ZKzIX7ysnUeL22s2EZLLPxI6pzSh7UOQ71HJjCUlvYbGl92YjrL3KVbYDfnb2WH4kKqNEKgyblJkydBy8anlD4hCifT7SXTZS84rYYNxhzzlsyG7b4lYi3mE8pKZwPmKlScsF8KHd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086736; c=relaxed/simple;
	bh=Ic9CEGREOD5y9X3l20lpqUpOb9jCx8JtdNqVvsEVd8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QdjnUbe/vLmVjtnVi4yLf3cX0iSiodZhCAeJgGopb9ZXOp+gMfdcoafdkuL4O03ezTa2s8fQPorIAh66zyqlXYo+Flhpg06/4/yDGHo/5PMviZmAp3qag/cAAo/zNbkciW4/bc3mGgNZaHZ81aB5MDDz212dI7JOtfjeouxpO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Kx3DhUUK; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175b6c4e19so68956081cf.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781086734; x=1781691534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPIESdLDZGUXa6Ogop7LK04l+zl3x/dImkvKUuXByAA=;
        b=Kx3DhUUKxN/t46QDz5xOZLD+6QbFSTufpk1CEKNfZY+ecKvHnuqw9p/UR5CE4WxDN/
         a8Iq32yMYPrm9JsDZ25K8cSe09QaE6qjQq2TMM2c39AwA5P/mEermaEk8B1SjZRatVY0
         6v4HPQtiTfpkI1M1A0qAlO9g1BBRkGJAgxm58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781086734; x=1781691534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPIESdLDZGUXa6Ogop7LK04l+zl3x/dImkvKUuXByAA=;
        b=RWMYJOtsBohmuYBfgAI/X8K15ZiFKAkR1hj7gpGSLQuOgt6swnzflIXTgJfJksJKB8
         2dniIMA+6h4LMpPiRyhczS5gCbV3NINB7PGlQ5G5gtXxgjLUjzDX20sbUsiqu0sLlMg5
         EkahGqLkZMruwQuZA5DvFU60k3TidmSFvxT1U7BmcOYBy8/SuUqh+BiRjuT8rhS1A0/4
         jcfYM4k3rlG/dr3kkh8Ujj7cooeCoxbhdFg0iv+znM1oBKuj7RuB/2zAAKPgw9fbYkfA
         LHVdh8jTP+EDsuhRlSjeE1YtM9sZdQSEWBBYInchEPqmfU2by/E7ceVbfGQ8+elkWRnJ
         46dw==
X-Gm-Message-State: AOJu0Yw/iDZp1lgJXDu+3jyFjcIp2jy9BO6Qv5bzufT+/7LMPq/H5aw3
	o424NfN8wMUIdSG1dIPH+lSQ0corzNJZIgloFs/318jyOq1/xeoLEoOJ+S4LjNffIgXlt4Qxu+X
	vGLTvxw==
X-Gm-Gg: Acq92OFbWkDx3C8PjqgOCX7n4Jwl6Mmwkl0gcUom+rRBQ/lSP1Ckp2IujRxjHs1N4+f
	+g4xP9T2+o9OFi8FNhB4KDjsKGPPTzIVhENoiiGLLPvTWTeqL/O7AKbZ7SzNAOy0g4Ngq0/y6TT
	pfYYd2/oSx/TwOYakWXJrUaeYxn1AkfX/8dAVlhr3gPJg7AoVVNwa5iZ8GuwNnkRUDerJQvueBz
	qauzMSbjRV4H3j1VY76e5+gimRvnQKewbIC/x1jNl8kFy1l1LCEIn3zDd7gOXAB3dYUyaT64OYA
	k0YiWNyRxWV6jgkDr6FNRBPFD7JdIQ5QWxKORn0V227yzoTDks2Ixb02MsudleMMSL4gfdr5hXX
	eMVko2T8DVyGMwLNVBmLtwGiPbBWmwTw7j2VCruEb9TfxF72KCLUF79g4XYXhUcZ/kXp+vGa8zs
	jT4Lk6/BE3cRJFWQ97D+b2k0UG+5m3iHP3WHxILA==
X-Received: by 2002:a05:622a:58c8:b0:516:d66e:7b1f with SMTP id d75a77b69052e-51795c6b5ecmr354207001cf.31.1781086733907;
        Wed, 10 Jun 2026 03:18:53 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2682f8sm230139796d6.43.2026.06.10.03.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:18:53 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	kylebot@openai.com,
	stable@vger.kernel.org,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: cls_flow: Dont  expose folded kernel pointers
Date: Wed, 10 Jun 2026 06:18:39 -0400
Message-Id: <20260610101839.14135-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297593-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:victor@mojatatu.com,m:kylebot@openai.com,m:stable@vger.kernel.org,m:security@kernel.org,m:jhs@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime,vger.kernel.org:from_smtp,openai.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F956668393

The flow classifier falls back to addr_fold() for fields that are missing
from packet headers. In map mode, userspace controls mask, xor, rshift,
addend and divisor, and can observe the resulting classid through class
statistics. This allows a tc classifier in a user/network namespace to
recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().

Align with standard kernel practices for pointer hashing and replace the
XOR folding with a keyed siphash (which is cryptographically secure)

Fixes: e5dfb815181f ("[NET_SCHED]: Add flow classifier")
Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_flow.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index ab364e4e4686..356c68ebc389 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -21,6 +21,7 @@
 #include <net/inet_sock.h>
 
 #include <net/pkt_cls.h>
+#include <linux/siphash.h>
 #include <net/ip.h>
 #include <net/route.h>
 #include <net/flow_dissector.h>
@@ -57,11 +58,15 @@ struct flow_filter {
 	struct rcu_work		rwork;
 };
 
+static siphash_aligned_key_t flow_keys_secret __read_mostly;
+
 static inline u32 addr_fold(void *addr)
 {
-	unsigned long a = (unsigned long)addr;
-
-	return (a & 0xFFFFFFFF) ^ (BITS_PER_LONG > 32 ? a >> 32 : 0);
+#ifdef CONFIG_64BIT
+	return (u32)siphash_1u64((u64)addr, &flow_keys_secret);
+#else
+	return (u32)siphash_1u32((u32)addr, &flow_keys_secret);
+#endif
 }
 
 static u32 flow_get_src(const struct sk_buff *skb, const struct flow_keys *flow)
@@ -596,6 +601,7 @@ static int flow_init(struct tcf_proto *tp)
 		return -ENOBUFS;
 	INIT_LIST_HEAD(&head->filters);
 	rcu_assign_pointer(tp->root, head);
+	net_get_random_once(&flow_keys_secret, sizeof(flow_keys_secret));
 	return 0;
 }
 
-- 
2.34.1


