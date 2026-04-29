Return-Path: <netdev+bounces-282529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sClADq2G8mkcsQEAu9opvQ
	(envelope-from <netdev+bounces-282529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D501E49B0FA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DBF53034A24
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6344B695;
	Wed, 29 Apr 2026 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/pDyVPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A944B680;
	Wed, 29 Apr 2026 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501805; cv=none; b=edE14XcNndEpuDeqVUCwHSDVIHmormvvVdJPBvvWhiX2TPrNKpY8bdqpIp7zg1YDCzyfE0TTDi8lL44iCyhWrf5dqFYsJyom3z7bYVkW2NAmevUM0JIbXx0gGPo42ZMk8XdJbKU/obMFVa1+LmOsz7DblVNakc9q01hBSyfImGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501805; c=relaxed/simple;
	bh=7dPIquiWgk4g+n2Mh9f7Poao7/BtIQeMGoOwUrrp2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLOeouNh9ZHiiVVxese2ssCD5ZJigUiVKYF/vjhlBRF//s4G7Ps725ebGZ9ic7QLpy5WPO5F7LExi+gAJthkBiPJwEFZGvtS7PG20+8Jrc8qNpWZ5eemPKwO9TFwTK4khuH4AkadzKPB/rIl604GTsHYebKsvJv7wkZOxxyAfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/pDyVPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E8C2BCB3;
	Wed, 29 Apr 2026 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501805;
	bh=7dPIquiWgk4g+n2Mh9f7Poao7/BtIQeMGoOwUrrp2cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/pDyVPfuZ05RWeK4O9/2Pt10FSG5CNh6+jFPJr+lUvvpkcXjZ2+pS85Rb2KkYi3L
	 TvcKRcv4ECiB0y7nOw1c6NCLHQHtWJj7RmVK+hvfJQ9Cl8mSZSR1n7WCWcXwT6qBEY
	 m2NYkn3JtbP1b86Ey2ciIqB6PoqGrCtcf98sg4pD3NiBjtqh75HzpuDeuZp/sUhrPP
	 ZHDgc052EkkLpw8IjzRrDqOoXRwn3xWnuN2zstNi9qKc6sSuxEHP7wP9UdLT/VL+87
	 Dh91Uri9tizbJSVgrseGMxb/tLXdpkmNVaAiLRaMlbzLr624wWhPI8Sf3AfdN7MoA2
	 21PP2E5UOeqUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?=E9=92=B1=E4=B8=80=E9=93=AD?= <yimingqian591@gmail.com>,
	daniel@iogearbox.net,
	jonathan.lemon@gmail.com
Subject: [PATCH net 4/7] net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
Date: Wed, 29 Apr 2026 15:29:41 -0700
Message-ID: <20260429222944.2139041-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D501E49B0FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282529-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When an sk_msg scatterlist ring wraps (sg.end < sg.start),
tls_push_record() chains the tail portion of the ring to the head
using sg_chain(). The entry count passed to sg_chain() determines
where the chain pointer is written: at prv[prv_nents - 1].

The current code uses MAX_SKB_FRAGS (17) as the ring size:

    sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
             MAX_SKB_FRAGS - msg_pl->sg.start + 1,
             msg_pl->sg.data);

This places the chain pointer at data[start + (MAX_SKB_FRAGS - start
+ 1) - 1] = data[MAX_SKB_FRAGS] = data[17]. However, since commit
031097d9e079 ("bpf: sk_msg, zap ingress queue on psock down") expanded
the ring from MAX_MSG_FRAGS to NR_MSG_FRAG_IDS (18) positions,
data[17] is a valid ring slot that can hold live scatterlist entries.
The chain pointer must land at data[NR_MSG_FRAG_IDS] (index 18), the
reserved chaining slot.

Every other wrapped-ring arithmetic operation in the sk_msg subsystem
(sk_msg_iter_dist, sk_msg_iter_var_next, sk_msg_iter_var_prev,
bpf_msg_pull_data) correctly uses NR_MSG_FRAG_IDS as the ring modulus.
This sg_chain call is the sole remaining use of MAX_SKB_FRAGS for
ring-modulus arithmetic and was introduced after the ring expansion.

Reported-by: 钱一铭 <yimingqian591@gmail.com>
Fixes: 9aaaa56845a0 ("bpf: Sockmap/tls, skmsg can have wrapped skmsg that needs extra chaining")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: daniel@iogearbox.net
CC: jonathan.lemon@gmail.com
CC: bpf@vger.kernel.org
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 906a1998c630..600e13effaab 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -802,7 +802,7 @@ static int tls_push_record(struct sock *sk, int flags,
 
 	if (msg_pl->sg.end < msg_pl->sg.start) {
 		sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
-			 MAX_SKB_FRAGS - msg_pl->sg.start + 1,
+			 NR_MSG_FRAG_IDS - msg_pl->sg.start + 1,
 			 msg_pl->sg.data);
 	}
 
-- 
2.54.0


