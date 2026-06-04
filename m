Return-Path: <netdev+bounces-295374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nf4IJ3+6IWrMMgEAu9opvQ
	(envelope-from <netdev+bounces-295374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC664263F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eTuD8hWr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295374-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295374-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A53DE3015C1A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED54CA26E;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172D4C9576;
	Thu,  4 Jun 2026 17:48:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595322; cv=none; b=F12M2GOhR4ChyFwxgvBIoJzwhuYBIGN1Xok1eYDuUjYulTOJTrrix7a4pGnO6j+6AsrjfPOJGn5IteXlrCrpUJa+szkV7/vp8d2Y+q43GyaLvv/HURlitnp5tuu34Px21iPdwzO2cdEv0y4gTi8+Nf6LeHRm97zSUhme6G552Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595322; c=relaxed/simple;
	bh=IIGnl9h1t7qbFho2hJsC6tMfztxINWE+iibKP4c35VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQKkUzJTF8k99RPcgKOIU9kTA2IdeSR+UbgGN2vs0rFxXYaeyIRY4h4xy3iF931xy77W0AB/vxScpINrl28JYnE5Dmh+Y1hsO2bj66SdJAUFdxYyB3ixG2wsXsvhBnXMWF6gzPUsUb3FQCJARqXAAx8bFnX5IYNJww8kyRq/Uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTuD8hWr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B01F00899;
	Thu,  4 Jun 2026 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595321;
	bh=XKUm+oVEKe6fc9yjnKiXAqCk2w589gW+8ic8kuggiT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eTuD8hWrVb8GhyTCHSP5SAap50OHBzJc7swnjYzew46TAg1ES2ksbuq1O9DoTGZOT
	 OBQZ5HMZl16zkDIgRFPBr8AYlC/pj2uruQscoVFlB0Ru+1BJDtn4n5u2q87FDmJmLX
	 NLoMTpzUCWWcegoFe9/CUVqKYwXK3kInk7OeKCNJQitz6/x+Y/4192ogCTN6Q2MkBU
	 O+EHGyJecK/j2oYmNkuBGMVKIMN0M+wDd7s7JevBeL2a+cnYBh7xXQ67mSobhoaCFr
	 xjT1FJ/rARRkkd7/+3e0Tea55wUPWQqtzXVhYT/ExPcjJS0AFVcmGrgIE14tSHdB1y
	 Ae4Q/Wc92OUHQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:25 -0400
Subject: [PATCH net-next v12 2/6] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-2-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=riEiX+xgY0GCqvFPlsBPjmYHP5ptL66TrOkrQlUZjJk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp3t6/1H4YhnpVXZdwQLEAnA6KzAp12dj0xe
 LoIEoRtJImJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l5LWD/9gbJ+pI2j3yHCVrSGGzRbTASe8WfLShxnHMCwFHxJXfZc8BXMSinNVRqvOqDYA0G37Qg5
 oV5ZuxS2B4CIJiquqZeMVU+NdPvEaQP3HtocXi3ZyIGRMsuDkSeuOt0Mg9zURm0w4Jsqs2Jh/CK
 C0udt65YQZVksem3Jf/GRUpHsQaTxRGzlEEUL31ArE8hXDPf4uLtnbgHNeeoIVo7N1dm+YCK7bU
 lkUlIBIedU51vy9tjL5iuIBQBlW5ZDvyS6YzEZEjNg8y6VEaHNUyRxPtJhsG0w3G1fqi1mr0r78
 2FUOOBL9msm80aXQzUykuGFUPvzVx5cPWDpN3n2C5f8izwXk/+CmzQYDQyy0z2XA/L/nNyCAMnr
 0qEshetme80VLaINURFMtvjXHaRKS5Yr6RM7eDdR7rqzot+AyVEp4PR2xPKjd7W5FNdludId4nX
 onZK2JoaUIc70LJJ4RK34TESdm6Cx7HiwgGK0USxj7jkMLw4JpD6OugslWX+wSK5Xa+cqV35q1d
 BU2yfOAVigp/BqRGM7LbifwMK7HBkhicocznoAHdjW5pcSnxtK9a862aRcvGbarQy6KCz7fw45S
 5cOTeNLp4HZVtHpFIZbrd1kIKa4KV0pJHy/EOkug1yb1sTp19vqbtBMkP2r11iJGON1fDcvftwx
 zQ6/lJ3GvV6XbbQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295374-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:sagi@grimberg.me,m:hare@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,grimberg.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CCC664263F

From: Chuck Lever <chuck.lever@oracle.com>

The tls_sw_read_sock() loop releases the current skb whether
read_actor() consumed the full record or only a prefix. When
the actor takes only part of the record and leaves desc->count
non-zero, the remainder is lost: skb is neither requeued nor
freed, and the next iteration overwrites it during dequeue or
tls_rx_rec_wait().

No mainline consumer reaches this path today. The only
in-tree TLS read_sock user is nvme/tcp, whose actor
nvme_tcp_recv_skb() loops until the input length is exhausted
and returns either the full length or a negative error.

The path becomes reachable with the upcoming NFSD svcsock
receive built on read_sock_cmsg. Its data actor,
svc_tcp_recv_actor(), parses an RPC fragment stream
incrementally and returns at fragment boundaries. When a TLS
record carries the tail of one RPC fragment plus the head of
the next, the actor returns fewer bytes than offered while
leaving desc->count non-zero, and without re-presentation the
trailing fragment header vanishes.

__tcp_read_sock() handles the equivalent case for plain TCP
by leaving the unread bytes available for the next iteration
to re-present, via sequence-number re-lookup. Adopt the same
loop-level behavior: when read_actor() consumes only part of
the record, update rxm->offset and rxm->full_len and requeue
the skb to the head of rx_list so the next iteration
re-presents the unread bytes. Switch the open-ended for-loop
to "while (desc->count)" so the partial- and full-consume
arms share a single exit check and read_actor() is not
re-invoked once desc->count is exhausted.

Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8e4e57721335..fd8d3c979368 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2383,7 +2383,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	for (;;) {
+	while (desc->count) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2430,12 +2430,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		if (used < rxm->full_len) {
 			rxm->offset += used;
 			rxm->full_len -= used;
-			if (!desc->count)
-				goto read_sock_requeue;
+			__skb_queue_head(&ctx->rx_list, skb);
 		} else {
 			consume_skb(skb);
-			if (!desc->count)
-				break;
 		}
 	}
 

-- 
2.54.0


