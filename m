Return-Path: <netdev+bounces-276721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEu0CizO1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6193C4376
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149E03098291
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA803A5E64;
	Wed,  8 Apr 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egtbCO5z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADB38E5CE;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=riE8ypYeBg9lvjy2DJp516MFWBFHzTY2EBXT1RXlRPb2L/scnfKn1kxAukX1ZUC1TFwDNfN+K/5c0WntUjKIi/roLdCxU+nataw/dsKoBPsSsxO7MuqrMW7PvpE699uoGPLmqol3arWgbbiiH8PX3+p9ScU+RfBmktC8X6POeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=VneR4pbgcqIN6sbPwlCfN6IcWDCyTCfy1kooH0Z8SEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADM2rwysBt+/esqSdIpvNEQbfzdYIyTCzlHZtIzqf3Ta3Y31VA+JOkQOEJQp3UMQQdwOQaY2AQuUHpcF1kkLG2inc6y39ms+cZNkV4ABaujjaiQUMXJdoyUJjZEDVzwQZ7WaeuI1AEutRnLQ3+ZOBX58d6NSvt7qfpiCoOgqLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egtbCO5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D1FC2BCB3;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=VneR4pbgcqIN6sbPwlCfN6IcWDCyTCfy1kooH0Z8SEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=egtbCO5zPF1jrXVR1eWvexRck8sPeR936+OBVm1qiX3LBga8A6HpkoRedbg0V6swH
	 2pk2gdRCaY/v7ubKv2/AnmUYnfj72XQw1gjtwYVEBJvO8L9oCSWR5iLwoB0QSOoSKj
	 rHTc1uy2Ea4wXcVWTXkw6ooK8LGx4XDQJInaew0KNwI0v96hotOBbD1WhNxL9LjJAv
	 81oUzheP5M24tYExFRNmpOoLRLvTViNHk9zf2pHX/kR58TFwYJNbfbKDPHJySkmztY
	 q7Bra6l8Vvy5fdmpTdgPcaOZgNXiYHWOZjWOqhDheAHg0ECRpUijGYDARk1LOOan4e
	 vUnApUy1w5YAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F010FC450;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:07 +0200
Subject: [PATCH net-next 6/7] tcp: use tcp_set_window_clamp() for
 SO_RCVLOWAT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-6-76a6f212e153@gmail.com>
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
In-Reply-To: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=840;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=YX2cO/5mpSzXQomZxTf4zIIjeQiySv9/NccTLoZ6hE8=;
 b=uSmFS+H0UrO5bmZ2d6kTWUrR2F8Q2onjHcSAGM7MOr6umiI6WvCeOqE2IJI50FZMizn6xiGkZ
 E2/EnAMitWpCzHEVQcKmizcdmqtu+KYw6DBcEy5uYFSSNGs3IsH4T6T
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276721-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D6193C4376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

Setting the SO_RCVLOWAT socket option may raise the receive window
clamp. Currently this is done by assigning to window_clamp directly.

Use the tcp_set_window_clamp() helper instead, so that raising the
clamp is subject to the same constraints and rcv_ssthresh adjustments
as TCP_WINDOW_CLAMP.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd03c99f793ae..567027bc86b3f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1853,7 +1853,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 		WRITE_ONCE(sk->sk_rcvbuf, space);
 
 		if (tp->window_clamp && tp->window_clamp < val)
-			WRITE_ONCE(tp->window_clamp, val);
+			tcp_set_window_clamp(sk, val);
 	}
 	return 0;
 }

-- 
2.53.0



