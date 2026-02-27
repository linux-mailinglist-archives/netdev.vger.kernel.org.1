Return-Path: <netdev+bounces-261638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEdpFX7moGnDnwQAu9opvQ
	(envelope-from <netdev+bounces-261638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:34:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FB1B13D7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1B9300F5C0
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8D27707;
	Fri, 27 Feb 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuHjpDsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7CC2FD
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152443; cv=none; b=YPoSIkzlAkS9WJkb5MZTwtjPdwq7AG22o/sSoigNM8yYxfPDVTVPl0WwZ/Ee/T4XKm+bQCPg+czQLJ2XyqgaelHc7rYZeZ7DUVIMBZaApwujznlPLbnPMGkXqi60xaZ0o00USrW9U+JmtYkxMmqhEbL9pGQ95tCEE3nRhKRnpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152443; c=relaxed/simple;
	bh=FIiBOQWKDGXTvjBOcL3qT9M5UHfxgEf7pQHYa8sxS/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHi2x5AR5KEtvC7Dt9Vakf8ZNVObX+iaXG0kw+ti1Lf9k16RVT5ttxH9mo9QysdKek+ZNNFVlWgt9xO8Cl5qa0sfFSDcxNazxdMQW4Wh/3/nozX0vPHMUlOqaEhFnfYzWAoSyRDUhM4m77/A2AGsDtCPWpwcSI5Qy34mN5I/YO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuHjpDsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7318DC116C6;
	Fri, 27 Feb 2026 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772152442;
	bh=FIiBOQWKDGXTvjBOcL3qT9M5UHfxgEf7pQHYa8sxS/w=;
	h=From:To:Cc:Subject:Date:From;
	b=HuHjpDsXLKCzsAGnVMYcU9pjfpiYDdLpoOByCaNQzZykOwn89YO6UNNfrUZS5qktd
	 MZcf6vm6Z3lJKsYN0vZ3cLTyN+nO59JRn/qe3635CPLgNV0+94nJJ/IxTRKz6CTlBC
	 GG+ER0dv2dsK1LS1xQEyZojx9MKI6Ec2dKlLuOv7LE3acAaIKvjvkfgaF8fx1N9/TF
	 KrBCqLkV9vz8ZocO6PtnDOpLKP9xt/O9X/lPfc2S7YDR4KuYPdGu580MwoPlsiDzRu
	 KSQuCeMaQ1IQTFVkoyCiFsRn/uy56nvavWqlsJfZR3DH4aS7msuQRC6N68f0IKOIb3
	 1+jT00FCHvNsw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ncardwell@google.com,
	kuniyu@google.com
Subject: [PATCH net] tcp: give up on stronger sk_rcvbuf checks (for now)
Date: Thu, 26 Feb 2026 16:33:59 -0800
Message-ID: <20260227003359.2391017-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261638-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC4FB1B13D7
X-Rspamd-Action: no action

We hit another corner case which leads to TcpExtTCPRcvQDrop

Connections which send RPCs in the 20-80kB range over loopback
experience spurious drops. The exact conditions for most of
the drops I investigated are that:
 - socket exchanged >1MB of data so its not completely fresh
 - rcvbuf is around 128kB (default, hasn't grown)
 - there is ~60kB of data in rcvq
 - skb > 64kB arrives

The sum of skb->len (!) of both of the skbs (the one already
in rcvq and the arriving one) is larger than rwnd.
My suspicion is that this happens because __tcp_select_window()
rounds the rwnd up to (1 << wscale) if less than half of
the rwnd has been consumed.

Eric suggests that given the number of Fixes we already have
pointing to 1d2fbaad7cd8 it's probably time to give up on it,
until a bigger revamp of rmem management.

Also while we could risk tweaking the rwnd math, there are other
drops on workloads I investigated, after the commit in question,
not explained by this phenomenon.

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/20260225122355.585fd57b@kernel.org
Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ncardwell@google.com
CC: kuniyu@google.com
---
 net/ipv4/tcp_input.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1c6b8ca67918..77283bbe4bce 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5374,25 +5374,11 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
-/* Check if this incoming skb can be added to socket receive queues
- * while satisfying sk->sk_rcvbuf limit.
- *
- * In theory we should use skb->truesize, but this can cause problems
- * when applications use too small SO_RCVBUF values.
- * When LRO / hw gro is used, the socket might have a high tp->scaling_ratio,
- * allowing RWIN to be close to available space.
- * Whenever the receive queue gets full, we can receive a small packet
- * filling RWIN, but with a high skb->truesize, because most NIC use 4K page
- * plus sk_buff metadata even when receiving less than 1500 bytes of payload.
- *
- * Note that we use skb->len to decide to accept or drop this packet,
- * but sk->sk_rmem_alloc is the sum of all skb->truesize.
- */
 static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
 {
 	unsigned int rmem = atomic_read(&sk->sk_rmem_alloc);
 
-	return rmem + skb->len <= sk->sk_rcvbuf;
+	return rmem <= sk->sk_rcvbuf;
 }
 
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
-- 
2.53.0


