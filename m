Return-Path: <netdev+bounces-272079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOD8MUI6xWkP8gQAu9opvQ
	(envelope-from <netdev+bounces-272079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:53:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370E33650C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9755530575AD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165230FC33;
	Thu, 26 Mar 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQR3JDRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A52FFF8B;
	Thu, 26 Mar 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533069; cv=none; b=OgRK7iNrAimjnmEemZB5kHZRi7vjeL/TwTo1c2iwVcfYV7yresmXA2NOxPCYHHwkwEVYeEYdJFp0GVJlxtix+2HwzZejOjZX9bEDyWATVWkTiJwP9OB/YVcn7rQVxDH6Jdf8MJi31rK2m8sJzK0/US8fz5Y+SWFwzmD9s4e5BD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533069; c=relaxed/simple;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oeAqpN5eKS7a6mTa0VV/vMilK+PtLEmpG4+OQJnA+lZ8t6jD+ihXjvj3MDQqsNxfRNlyHrAGY1992sdVuJ0g4m5uogY8bkvKCSri1M6cO0TOvAjinko9FPUEJstzgfZse/NZNqsSXL+fws0yPl7Cmf6hPzApYK6V1E9OVpHoiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQR3JDRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ACDC19424;
	Thu, 26 Mar 2026 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533069;
	bh=ADsowbatqb/2SsLJ3HQ7L93bqVYsEjgbcxdwOPOvHEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uQR3JDRPLT1Va38AKYO2LIHo7jtTWDM68Cgj4NzFVyyP1KgpQ+pZy4ptVfnHTysmF
	 jvYCl7KbZBeGaQio2BKPvI1iu4a5rg3seAZ78shc+ymLMxlmUT5R6R81NbNkbGdS8T
	 L4XfK12egFaFCgiR5md2XH9/5pAWIfyToV2tsazEB2w/OTyQy7wR8BWMg7CDsmTPJl
	 /YtgUsrfdqcFcmMAct5i5iFxkQaqZOpq/gqEzJ/2M0m2dlZ8HTUBg+M1wzd2GOZooc
	 TS6N6mvK2cXK+mk6Z/3zEKMBd54tr58n//BpP6jXBDetadmpLk27rrZUNw1Y5hbURV
	 AU48aJ/Wn+Fmg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:48 -0400
Subject: [PATCH net-next v6 3/6] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-3-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=C6Eyt3fovBhxmJhtF8FQJ86E45z3fVSEaLjEsfKU3NA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnJvgyjqAU9umDOLawyqIAPE9V59xSLtry1/
 0QG5WcN/nSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5yQAKCRAzarMzb2Z/
 l0j2D/9RYJL6VRSwTeioycFcaRiX+gtVfDGiQAeliMZOpQCv2PkDxBQNamVkQbb55t3E8aT9eyD
 FwEdtTiU1jk7homrwxE7jWpMvah/CRWkmlkVIxvGW9UNHWfHLJxaRXH1raxLK/VW63q5TpTH1+w
 gV1+xQ0rCZHaE2HIRJh8FyjA4g3JG9DRnD6aSdtnv0phYlMNMMpjDJZ3QqQ+6JsSIy2pQAzJVtq
 WLY7o7XL6tVA9inZF86Ja5i7/PshaYiBcDDSuS6ySx6Bxhkoj1HFusIWx3qbU4z2Qf6+OJTztlv
 kGxO8cSjRAPpqh3mvfoOgKJnmCSVle0S03PAjAjwvw35l8JO1attBKSvoVkahXX1wXdaJH7OV6P
 VclLuo+9k1GB//qMPBgwVjjnOUqn6IGY3l9NhjLQYxRR4h1BAQBkFSvEPFo21G4HgS54JoqofzQ
 kZSx9LpDjR2Wfziv71SFeOtThpl6ZiPhWGK2PnOikpX3E81nlrUmTHPI38nQ316UsjXYTwnmn0K
 Zo+CEV6ROn3k00KVjANBaPeFBuchikX2Ikn9CgefVwZoA+9hyUjG5HenR8MRIESs1u8+E7Dy8k5
 YZGeJvH91O1VFMUVX9jXuDZUPzHY3Qf/t9SDnvCwx/mdP/CengECGKbaKj5shWQOHRjqXQ72pLp
 XfZyDlMLFhVpHRg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272079-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 9370E33650C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 5626fdd4ea0a..5fdd43a55f1e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2356,7 +2356,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2405,10 +2405,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


