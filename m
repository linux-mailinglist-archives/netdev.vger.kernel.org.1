Return-Path: <netdev+bounces-100807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 456178FC1AE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A101F25D43
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8961FE9;
	Wed,  5 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3faQiGw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136E2AE75;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554032; cv=none; b=kfwJjn+32IinvQ64Lm7zXvvAe9KdCa0F0zlFrZAzUmbcqcq2NGtwho7pEheG0FMCQw3k5wahAM0RMUpPABLDmbA9iaJYsyKJSXZsRjehOm2GwzoKC/6nQw+ztMNIE5k3RGLTCl8wuKiQpLRI5IWq4GQuvM7iTJrMB3SqclFPlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554032; c=relaxed/simple;
	bh=m1ODjAZVIal9y8K9wO0qbhWp8y4HHguHQ1q4lW0dScU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8qm7c5pspmskBB0306WvtnvX+FrWRjxgQH8+WK3Wo0PUwVCJpJkYkoutC0ZNDkzZHLKpxLd1ljNtBadcCezQcksvZxNKs+HWcXipHSmb3qM6JqDey/Mh0dcoLgXiCvepiGzcss5ufAF1dnPT713N8yn1onpulYRcy7YC9WXzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3faQiGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B081CC32782;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717554031;
	bh=m1ODjAZVIal9y8K9wO0qbhWp8y4HHguHQ1q4lW0dScU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n3faQiGwgBW/++s6SMprvsUfOdVMYwc/ZAuQ5oMO5TKxNnmV3PGuM6Dd1nofOA+VR
	 o9IBkYTQ21HGzfKm/yIjt79MSDcXaF3/bO1wROzNlkoYWgbk2NYm9z6UdZmgSsFpb+
	 vwfOSD0+IIvMtxI3H3CnnXXgjAEDIZ5q7ZP8yCanOF8V9lnXM+aOE/tahuZkTZedC7
	 0amDLozA2JpA+92yA1W9NcqVXCc4kz8i9ZO55Dyn+lV3PttecroOL1Fvf7zqo8nUsZ
	 Zny+XyEJgDrkJWmRQTalJfT4c77JxQS9CYgY1DpmTBRBiCncqBF15nf2i1Xan9R/mm
	 mRbluyojS31GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1AC27C55;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 05 Jun 2024 03:20:03 +0100
Subject: [PATCH net-next v2 2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-tcp_ao-tracepoints-v2-2-e91e161282ef@gmail.com>
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717554029; l=1228;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=3r0GUti1sbRL2DmiJwhtJuQ4wZfREpceQasirqqFZEo=;
 b=MEGR6XCVzVRWO/uGY5lE2aO868zcFl5U76lbEK0RzyZW3Ds+SdZ8SO9E1SK8p+ck86QnEfIv1JSp
 6oENjJQOAZIOsCK5WtyCVIf3NGYWHwz9qU3i43r2ztS/0lUlSzxz
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It's going to be used more in TCP-AO tracepoints.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp_ao.h | 5 +++++
 net/ipv4/tcp_ao.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..6501ed1dfa1e 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -19,6 +19,11 @@ struct tcp_ao_hdr {
 	u8	rnext_keyid;
 };
 
+static inline u8 tcp_ao_hdr_maclen(const struct tcp_ao_hdr *aoh)
+{
+	return aoh->length - sizeof(struct tcp_ao_hdr);
+}
+
 struct tcp_ao_counters {
 	atomic64_t	pkt_good;
 	atomic64_t	pkt_bad;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 781b67a52571..7c9e90e531e3 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -884,8 +884,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		   const struct tcp_ao_hdr *aoh, struct tcp_ao_key *key,
 		   u8 *traffic_key, u8 *phash, u32 sne, int l3index)
 {
-	u8 maclen = aoh->length - sizeof(struct tcp_ao_hdr);
 	const struct tcphdr *th = tcp_hdr(skb);
+	u8 maclen = tcp_ao_hdr_maclen(aoh);
 	void *hash_buf = NULL;
 
 	if (maclen != tcp_ao_maclen(key)) {

-- 
2.42.0



