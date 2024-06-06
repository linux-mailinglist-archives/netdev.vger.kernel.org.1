Return-Path: <netdev+bounces-101585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE98FF820
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E016C280EEF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4D713F42E;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGEvQTPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02671B25;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716374; cv=none; b=qaRRP46Cvf7buSwKkf1JjkoqNY3ROEU44gddN4MloIz8ih19YAgGudKEOzRx9Cm2HFJeSEABWFbAJm2Bxo9hmpxaOKfAggqBad2xl8uYvrHcUaBIP/H2rVTEnifJK+Fo9C43NFwrSwA/DcQLck8qzpDkvsyS40Wp08LWmYPxIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716374; c=relaxed/simple;
	bh=Suh6vh4De8t6noECYiiHMgjNhg4kfPCiUIe38Nj49cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOzuDoI7RLINLjy0pZ6MgLOQSoAGWwOOhh1xELDuu0n95Gwpp9ZiQNQ/RjilYdHsV36xWwEHoNRxNWSBUDTysCFVQFK1zv0wQFSkQEW34lwj8watuVPQXJ6wyv7fQ7jLpyUhQfqZT5ku1Yg5ENlD/i+bipjiGyCe9ERN5TsdI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGEvQTPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE21C4AF0B;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717716374;
	bh=Suh6vh4De8t6noECYiiHMgjNhg4kfPCiUIe38Nj49cM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tGEvQTPoLV6gWNn1aKKeJevVNz87ihB9WYyQPbCloAsCd/Yi6mTYkzPvgZBcjMv1K
	 mkUruXaSCdZry4cnDIYkFSujYfWu4BOVbiz8qL/ha25LrUSVGGTw3f6g0/5+D0CBvI
	 er9aAQcLLgXrfIioXm0sfRJ+UAe62D7o1v/FMGr3fV1O45QrHeOccj5x2mLCnaNw8U
	 TVAgMUAu1/2o6Rc5G/k4uEa7VXkv8XoInip4CHvZXZfD7JY7QY+9PLog+qVm1Ilu5d
	 arsRlyo0wvpKmdGOfNTmgIU4wq6s+QAP4F75KD3LlYBQpNJxcaECf1krsNSzjRlMcB
	 G+oCpZDnWV9Hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F5C27C5E;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 07 Jun 2024 00:25:56 +0100
Subject: [PATCH net-next v4 2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-tcp_ao-tracepoints-v4-2-88dc245c1f39@gmail.com>
References: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
In-Reply-To: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717716372; l=1277;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=8zWgzne0He/W4ZZY8QmdH5dUQ9sOzaX2Zm9ECgB6gSs=;
 b=gFzS11h+sf3CTMo5EpzoNFS1QqejFHgMpocvav2A9GSNoVQyR2NEZ4YwuvWVHsUEEQZXItSUVXcJ
 oart4dY2C8lHNuQ54A2TS5PWolgQTOTp7jcIgmAmzAphEjwE2B3+
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

It's going to be used more in TCP-AO tracepoints.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp_ao.h | 5 +++++
 net/ipv4/tcp_ao.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 5d8e9ed2c005..198e02004ad2 100644
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
index 37c42b63ff99..50ae43c92829 100644
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



