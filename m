Return-Path: <netdev+bounces-279647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCUzBZmV5WnrlgEAu9opvQ
	(envelope-from <netdev+bounces-279647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F94266D5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61103300BD9D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC237EFE1;
	Mon, 20 Apr 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZXfd27q"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EE379EEF
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653712; cv=none; b=o8tHZHV4/AtA8fSk6U56pYBPsgYmtCBLk7TA8SCoMRh9HCPg16JFln/ed36SGM8j0LO5eiXUrdsVGxQmFGfhjKp9mFzacHh52AkZUgXr/Fqve+ROMtis7SAU/plWXAQs6HFPNwuSbm7DD5jYmClKUW/KN0A/1WjkQIQ06HUb96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653712; c=relaxed/simple;
	bh=w3BdPvi/Jz4+gcnHj6clAvv6EsW4nU1EWAOTj9aOP1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTyVnQFQCeUnQcqbZYDsQBMaXw0mlo952GwQW1mqeF+q9jXTsHUgDgBDC7xAOIAzFrCHJSLNfKBGszpUpFlWdZjkBojlv/Y+8nL1Ui+kyJ2jYxbDsaUXr5N1nCTdfOzvo8Ajqczusj3i/7r9j5L5LOMVCVmpcj9faBZB7iX73PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZXfd27q; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776653708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCtCvf3ayKtZjSmTn8PWNgrzYbPuvCHKcbiDdI520S4=;
	b=IZXfd27qlXE3Xb7O2r6HT7h5fCetFMQImJ4hR5HFlw3q/ZOv6QR6+emOVqIGpXFiGFlRog
	8+7iuDRR4pwlha8/ZhZsUMN9s9ksFDfwxx9J5yRnkFUHllrNAKpR3m5ntb36sV/ms5SxIZ
	aDfuUVEw+6gW6GNxJfl3umm5115GeBw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] tcp: send a challenge ACK on SEG.ACK > SND.NXT
Date: Mon, 20 Apr 2026 10:54:08 +0800
Message-ID: <20260420025428.101192-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260420025428.101192-1-jiayuan.chen@linux.dev>
References: <20260420025428.101192-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279647-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E4F94266D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 5961 Section 5.2 validates an incoming segment's ACK value
against the range [SND.UNA - MAX.SND.WND, SND.NXT] and states:

  "All incoming segments whose ACK value doesn't satisfy the above
   condition MUST be discarded and an ACK sent back."

Commit 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack
Mitigation") opted Linux into this mitigation and implements the
challenge ACK on the lower side (SEG.ACK < SND.UNA - MAX.SND.WND),
but the symmetric upper side (SEG.ACK > SND.NXT) still takes the
pre-RFC-5961 path and silently returns
SKB_DROP_REASON_TCP_ACK_UNSENT_DATA, even though RFC 793 Section 3.9
(now RFC 9293 Section 3.10.7.4) has always required:

  "If the ACK acknowledges something not yet sent (SEG.ACK > SND.NXT)
   then send an ACK, drop the segment, and return."

Complete the mitigation by sending a challenge ACK on that branch,
reusing the existing tcp_send_challenge_ack() path which already
enforces the per-socket RFC 5961 Section 7 rate limit via
__tcp_oow_rate_limited().  FLAG_NO_CHALLENGE_ACK is honoured for
symmetry with the lower-edge case.

Fixes: 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack Mitigation")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
I'm not sure if 'blamed commit' is appropriate, because I think
it's due to missing parts of the implementation, or it might be
directly targeted to net-next.
---
 net/ipv4/tcp_input.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 021f745747c5..c2b6f05acdfa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4284,11 +4284,15 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		goto old_ack;
 	}
 
-	/* If the ack includes data we haven't sent yet, discard
-	 * this segment (RFC793 Section 3.9).
+	/* If the ack includes data we haven't sent yet, drop the
+	 * segment.  RFC 793 Section 3.9 and RFC 5961 Section 5.2
+	 * require us to send an ACK back in that case.
 	 */
-	if (after(ack, tp->snd_nxt))
+	if (after(ack, tp->snd_nxt)) {
+		if (!(flag & FLAG_NO_CHALLENGE_ACK))
+			tcp_send_challenge_ack(sk, false);
 		return -SKB_DROP_REASON_TCP_ACK_UNSENT_DATA;
+	}
 
 	if (after(ack, prior_snd_una)) {
 		flag |= FLAG_SND_UNA_ADVANCED;
-- 
2.43.0


