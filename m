Return-Path: <netdev+bounces-286856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEjuEs1lAmqhsQEAu9opvQ
	(envelope-from <netdev+bounces-286856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:27:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB551746B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AE830421EB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1E361DD0;
	Mon, 11 May 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBRBma9w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCE356748;
	Mon, 11 May 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541974; cv=none; b=aS5QO8+24izR9q1toT+lwGMV9mTWaMil6WMQKx/jVkPBXyBH9qAhYNwYlZ3vXFKiPefVWEDPawSDFpJNbPfd4lhyLhfnNWCXGvNRIOkigw/MpiOavlOg/kzSxfZbwR6KdfrCSimERTJjdhDtgXxmIi4NQXEKLt4nAVWXaCtiVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541974; c=relaxed/simple;
	bh=mMEchIw1sg8FQha7b0ebJ/ZvXER8p5mvvqTHTAGdEMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLGv0yqj4frLcztaPFoEs+TR/lmbv+c4litC3EZOpjEkJi0qFBT0pe8ef5OU6V3YOsfGVaH7QpLU5ehUYZQVMId2Gfl9Wxp1OhwVIsI/8LKuE5Wf3GfXIgKwnSA6sX91m3mpwEYd4UoWhVo7SSFQbpSgYkwyKt9jEW6YXYnbgro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBRBma9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6489AC2BCB0;
	Mon, 11 May 2026 23:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541974;
	bh=mMEchIw1sg8FQha7b0ebJ/ZvXER8p5mvvqTHTAGdEMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LBRBma9wCUxdw3RT8GNSwOM3pfjXVwhI0dcGHyFN3hcv+Bj/zGuu7eV3Z7otED5Xb
	 VFE+Xd8EJ51qAv9l2kVPEoNgunUh1LvllIeEhOgLyPdGfjWRhLeSZ9lkM5R8/fjtGR
	 MyjGFalpc63ntpYgKodjeMjs2q3KYT+W7loPGGcYgHs6FoGleuVHILBDW8SFmcGUFN
	 6KLklfc9q1uq1fyNSgFQykdfVh5gGm1ZRKuqkNZmG12mlsaCYzhgPMPKYL9FuRcOAr
	 kmKd4TBAvVoEjIAN3ff0eoUD5p9JRaLvwO917dXCacwkVQ76v6MLKZb41BPeStWzaB
	 BCi2v6MS+UGtA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:54 -0400
Subject: [PATCH net-next v10 3/7] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=nnrGbcyHhL/PzIVBGiVit4TtyqKii8z8A/aHs9wU+Qc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWRRUw7qrQZPxEKWV8mBCjEVlrodB3zb0eqQ
 WVArvXzVduJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkQAKCRAzarMzb2Z/
 l3t9EAC38LAsDyHip0EfL3mIwocPMlywEDDg+gP9r9sHr1+hMsKNTUfdtS90EGiRmcAi8uGTe35
 FU7YXCn6/he5j2YUKMTF0dYkVYzsJI2fLEu+w56UGyQNNEOqQznwEdqMJHZF1iy0GSUu7+BHx7p
 AQ7lIvWJZnW5yfdF389FkR81+xpgK9ghdcGA7BvmC30vnTYMs6z9pnd9iGQSHyV+8sZceoOSHOR
 4B72+iktKwh6FKeYf/7F6pCbErFUvwM4xZDM7QIQspKtQp2t9l7QGfICMUsq2nRP//kcD+4LWR9
 eS3IQldERBQrxKG2/hNIRiEaBJqdtVZRTRq373zkB+pWx4IDNSunI7GjZtQdkwGmN70SuXb/54I
 JvvrCKlx87OM2Dt1ews6b2b9BPr6ih4Ay+SQramJtXCGqu1vxDwIMU8S0rLm8u77zqgbCOX3KGI
 3VH4lXqTqINrTfflwa7i2x3EVzxAIQYdpJGIPZgnYZ4LA656H6zAUNiCoIK31i8/m8fWSFwSOl1
 vQ0NpHB4TV6mSfojvcjCqXghlowOf+lEXBIRJbAIYJW500tovklKFY0l5AiR2aGPYsvVgYD0U81
 MnaRiVTg+D54VuI6o6iI6XiI3wCLABfj0dPSvtuXvQoZAQm7k/r5boFtlk0ONoKQJkocTlxsyMi
 hZTyieYEqAXv+fw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 9EAB551746B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286856-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

When read_actor() accepts only part of a record but desc->count
is still non-zero, the receive loop currently falls through to
the next iteration without freeing or requeuing the partially
consumed skb. The next iteration overwrites skb, leaking the
remainder of the current record and silently dropping stream
data.

__tcp_read_sock() handles the same case by leaving the unread
bytes available for the next iteration to re-present, though
its mechanism (sequence-number re-lookup) differs from the TLS
path's explicit queue management. Adopt the same loop-level
behavior here: update rxm->offset and rxm->full_len, requeue
the skb to the head of rx_list, and continue. The next
iteration pops the same skb and re-presents the unread bytes
to read_actor().

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 559bef05fee4..40cb0a92d88a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2411,13 +2411,13 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		if (used < rxm->full_len) {
 			rxm->offset += used;
 			rxm->full_len -= used;
-			if (!desc->count)
-				goto read_sock_requeue;
-		} else {
-			consume_skb(skb);
-			if (!desc->count)
-				break;
+			__skb_queue_head(&ctx->rx_list, skb);
+			skb = NULL;
+			continue;
 		}
+		consume_skb(skb);
+		if (!desc->count)
+			break;
 	}
 
 read_sock_end:

-- 
2.54.0


