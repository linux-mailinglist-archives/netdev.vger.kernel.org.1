Return-Path: <netdev+bounces-291717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AufLY+sFWrgXgcAu9opvQ
	(envelope-from <netdev+bounces-291717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:22:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D275D760E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51BDA3012B0D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3A03FF887;
	Tue, 26 May 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+BDJpff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A13BB122;
	Tue, 26 May 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805309; cv=none; b=fkV1WlNWWVivOgjldROkfgZIghXQWpMY046oWiCX0Lma8ZhwUXEdc71l+ljfm1mTclUC8q6LPl5RhAGv3pKNTaxPrmCLSzX4jszZ7NpJoyQABLZLGRv9mbvXXvvkZYtYbQ7zk5L0Pq/jZ6mhiYgTj9xlzukMf8onQSXEGz62Bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805309; c=relaxed/simple;
	bh=DDlW1P8MjrM6h76UK+gp2GQSHuzmvblE8blhYIOwL20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbEmTpsxRZgO343Cwa2FNS8ebFDpFq4G6v0rr2LDfD1nAz5vuWU3PAF+Xhx201TmC0vSN2L3Xa0ExjscgKJukBRFvgp2SaQFZ/2ujYKRd4zqhJG/0f6UtmwAdgZKs/VM/1HADvru/W93MFJQ1GPI1WtHRR01uEjFVtgJKAZ0YXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+BDJpff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC11F00A3C;
	Tue, 26 May 2026 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805308;
	bh=mnPVx1Z+2wywGwqbdJ4+keydEMkk26OqcMVFiuCOtUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L+BDJpffceF9nqU3Cy+Pa/6x4h6RbPVAd/ib22Vpi9hil4ER5IsBeV5ZU0gSiHBxg
	 R7n+jHHHEbFFMxoPQD6dokCb4w2g1yyx5bBskFP7F3h6L2EACQoAlI/x7o8CRpLKbn
	 CYIPrRxMMMNGLkP8W3vFxdQtNCxv027238W0pSG/GeFFOJFlAWhRS/yogIsgjpRBy3
	 yQzL6eH9V1aVKW4dnrwand60RLkSJiMr2HBTa+MBlk8t85ZvjsuXUlMvxek9ji3/5c
	 ti8nJb3UBkKoVOidU3Yo4gEj0nxm12ZdNPPG/JyF/mUHEWQEf0hCg9O0wiTyUXujpm
	 klyEq1xjsG61A==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:32 -0400
Subject: [PATCH net-next v11 2/6] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-2-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UBx8pLWrSoV4P4G5OvzlkVwylaI9k2Avx7aI5XTi9EU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax4GoWwC2Qk074Wd4zwTyM7zHpzRHZm0dRWP
 twSkI4viOOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseAAKCRAzarMzb2Z/
 l4sbD/0YU2qhk4XUxDaqQhEQgMzuGVXG0GSgI5ZIgW+DAEHySHFx8NuXK09RprsXyEG21f5dFrL
 Jl3F2A8hfBm9jkSoUStgNxkBwE3BcZ7YDJySRaieXlcaJEdnSfVxdqZ0oai6FM8vgHTehuRKyCm
 whhVQHIGrnzoBX/wA4MbSnWGkIQTM4wdRRmH41wyU8IiZ5AQxba1547leZ7ZwGwS3DVkrZvA0XQ
 Rf5Nc3/iv/WF8PaHVNDJwwRtx8j0sRirEyufqg20dCIjOU8nKndKYQ/A+ITdpWc88uMRuBV7L+j
 PEXpOXFdNKbcvSKv60LCkrEWl2QNIC6HT1ocmG5FufsOq1T7rDlrsxNLZYj/l2HGhsZwry2psX4
 wYyyahfp3A1lLUtwEUhVSA8bHoSnAuhGS6NfWfYISs43yb5iIJMOVBd99uf4n130zI87su1K538
 qR5Ays/kPnHL3kj+VkLA6u53+1g4UpUa0s6kOq92Bb+j6PJfM2zcCBRf8A6xKYxsogVXbulBCA8
 YW0tbuzEavqPOWP17y5goTTPFIhHW4uRLb44dPU8LdyPLgztj04TENg/45RdFEdWEsfI/yGCtJ5
 lv96/byAdg6xVwrn7zKA6iGBwSUcHRFEVdev02EjI0gSiTNcGyou9puBk6kaUJFGdzFVnF8++VV
 BsvRLXxpJhXuFqQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291717-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:mid,oracle.com:email,grimberg.me:email]
X-Rspamd-Queue-Id: A3D275D760E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


