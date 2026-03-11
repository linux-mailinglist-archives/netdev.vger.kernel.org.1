Return-Path: <netdev+bounces-266387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMkSMp21sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E130259B44
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00EBD309B23B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EA320CAA;
	Wed, 11 Mar 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOm6cOg1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3550317161;
	Wed, 11 Mar 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188402; cv=none; b=nYuwaPW5+f6lJDeWah8qkXr3q8clZePYzIcE4ws/IJCj8pKtfmDe4zile+koxX8dWdSJzuOHa7K1LE+VzStC3PfG4ZEAnG4vt8/wOIxaWUrBQW/q7K8rh89Y3LDm1eB0lcRLhJx/mUUoDcmVIvnZRRGVgwkLv6QAbiVQp5Ftd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188402; c=relaxed/simple;
	bh=78oJo2JmKzBr6Bl7B58mYl3fBcmHzgJm0VGXULlhPgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTmHWxU3oinTJA7quyfjNmBUZIucUrzP1h+hHAXfAeF92f1gflLDCT9cK8gKkPSWkjDNNfWkHv28ddbANXTYDQ4qo69sTgNehV+sy/Pb73aCccZu0RYQqFSKS6sXbXJnoo2HnLJ5q1kURQ4X63FQgBw7btJZYU/7tHVF2ZuN03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOm6cOg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A681BC2BC9E;
	Wed, 11 Mar 2026 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188402;
	bh=78oJo2JmKzBr6Bl7B58mYl3fBcmHzgJm0VGXULlhPgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOm6cOg1HXCuyuZcJxxrSIqT15aY2IqIa4rSpi33iakZLcaBJH80TngBdt/YLyCdE
	 SvLDBHconZY6YaOT8Boi4AVGiTPEKtkP6g1O2ubMFDJXTYoiM5quBIwMDCTLfQPbIL
	 ZJcN9Qr+Myan1c8dN6a4v8CCqHMRNyveeWsmNZB150UubVIVZ1mtF0L6fUOzBbrHnv
	 rs8u/HvmvK8l7FIV6awp0uMw9n2Wqn1/yqm8IV6Bw3AJLxTDvRty3U4+A4JvlsW+Oa
	 V/stePc7tra0u8VvprlL+mLLqu8kS2VfeYCHQvktuEDvaoK6l56BNUmwGR9ZKB4m4t
	 eHxSp/TCcbrzQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/8] tls: Fix dangling skb pointer in tls_sw_read_sock()
Date: Tue, 10 Mar 2026 20:19:47 -0400
Message-ID: <20260311001952.57059-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E130259B44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266387-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,wdc.com:email,suse.de:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of its
lifetime; Annex J.2 classifies the use of such a value as undefined
behavior. In tls_sw_read_sock(), consume_skb(skb) in the
fully-consumed path frees the skb, but the "do { } while (skb)"
loop condition then evaluates that freed pointer. Although the
value is never dereferenced -- the loop either continues and
overwrites skb, or exits -- any future change that adds a
dereference between consume_skb() and the loop condition would
produce a silent use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 81e0e8aaa6f9..e5d0447cbba6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2373,7 +2373,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2422,10 +2422,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 				goto read_sock_requeue;
 		} else {
 			consume_skb(skb);
+			skb = NULL;
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);
-- 
2.53.0


