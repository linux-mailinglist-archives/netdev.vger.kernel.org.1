Return-Path: <netdev+bounces-299684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ne5ALpWbMGp/VAUAu9opvQ
	(envelope-from <netdev+bounces-299684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEE68AFD1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=faLrCcF7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299684-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94552311A1D3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F845276049;
	Tue, 16 Jun 2026 00:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17FDF59
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570065; cv=none; b=rrHfCxbw+jMA/GwcEC1tatCT5a16II+7n51G+3BsIxl7i2RYOWW3pY8ZheFVID6YicR+hDggNHx7k+4VMfZwR4sBOp+iWtrW3HRtctpy0AUWkrr5zTz8NELVl+LaeoGMMOqtT2rJjOGyid6+vQ/opOhRKIApbVfy4S4XdM2ynTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570065; c=relaxed/simple;
	bh=aY8xn1ZK/MAimDg6/PX3B9LVgXQNUUeznYM37qg3c7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqIVBw6dM4J3IKWhqpmQyVSTU8XGbOr5WhTQS+D97W1X2nshc+1enkduXs+MeaMuBLyQJn1q4m/rydRF271FHePy7SVFHS1ZUaF8MkTOKCeBqbAEivMgJhrDQEppjz21Rk0rI5Ddcm6oKDr4YRsjeUz+REvBbRS8A2rZj/iMeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faLrCcF7; arc=none smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176ca6bab1so45548721cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570063; x=1782174863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52m6IQ7AlTbQvy6czYmDGwVADQkx7UZsBBaNoscqguQ=;
        b=faLrCcF7B+enlP9VDV33vjvuRzoxjXNQ/v5josXzFRD7AVVfw61tGKEBhgkeI2ndzT
         QzvxBb7Oca8EBmaEa/32rY+Tyo8XfL4cip2hdJHVM03lH01mWaTWPE0W+aJJnnj2DUpS
         Chsh9/970fMQDsuUEPC3DhJwYnshBe63fwdBuCwCLEfBMa4a8Tf0HrZH5PwMQX12wlTH
         QDX0NU/tW+XGIMbQB9h0Noefh6dxO3kubYXuYv07B03q+Y9Voa0SV1gRP0sYMLuu70Hh
         9sxSfwBL0mwMAKrmfPLAFqpHmqb1clziZYEP+0/J5cuKG+Tnf8WbIDV+2/sxN1sIQhfh
         3Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570063; x=1782174863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52m6IQ7AlTbQvy6czYmDGwVADQkx7UZsBBaNoscqguQ=;
        b=X3IpuzitXe68EkntJqGdHh1+0EdMDr6gKUezxGdhp1/+f5ReY0VjoogTnMCQ+wv1JJ
         8BRcpGoulA+qwcjhg8IvSMYgbswSLL8X2E2O4IwilNMwX6fn3HRWlY8cKYwHO+xafF8S
         ppDNoZOli2ca+6BSodut98c/afgBSQjvJRcPR6Ts6wvip6YtZtFj1nCu3gIfeUR+7Z1j
         kd87pLaX/XurCp2pWvTukGKrQgA9zNTH/e1q0QsTQuZL2lCvnOzJ/c7GnHfA9YCDiGmf
         T0mHYxhOSbL4/uN1HVKypMKfUvGmPLAB4rB0cipT/lEbxsnJBGkvmAX5RqZIvZLKPEpK
         LAiA==
X-Gm-Message-State: AOJu0Yyd+913mOIMUi/L/vE3yKZ5T4SKvCku89NE/RBvkLO8IPVqgQvb
	Wiw6lRhM7neOG7/b72E6cDeV7ND3ZcWMuyMaw2As+t/pr2RQz1hAffflELZ5i41m
X-Gm-Gg: Acq92OH2siegALCp2WFCGuU84deWxj7iF2r0L2m/rkNec3nYP9tJGtw8yPvuG7faGhD
	hn5xCloLatvF0LFAhpYnyt2onPLDK18vvA+UIxF+HXQoKMzrHYR9JHWC07q1f/Exp3Y4Z/waFtE
	KDOjp058iVVUDlOiIl6q5A9bj/nJMf5V99fVqUGp8zi8ravKUpFVj4YO6TlCCjqHmghrzyt644y
	yR/5vDzvQ/umAHQXGKWqaX8X3w4luCaY0zOXB0oH+AcHo+6dkbldsvGRFbUXl0EgcbbDNsnELYv
	04o5o+Zv/7JJd5/67dDizHGeQQj4K0LMuv4y4A9BhYZVoaj8PDApwT/bMqKpoTojOJO2lTPbXGV
	gqkH1g3fRG2yuJzNSA1ROo6NIJEtQMdWwrvMisZr0Rz4E//1NiiCvscTFLnsecy8Al6r7F2l00U
	T61wGIkvh8CZk8TJXGdFu6f5G233hnCnyyGBUep1tCAemM6PYk37+zxZ7rYzikDz58jlwyZ1a57
	NGtdlsaL1GdpUi/JzXZfPmLaNmFv5d8K0sWIvIgi1azoqmPn+7i9HAZLKHkKJ623NJoZsG4aGPg
X-Received: by 2002:ac8:598e:0:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5198e039256mr23476631cf.28.1781570062692;
        Mon, 15 Jun 2026 17:34:22 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f132178csm16794326d6.7.2026.06.15.17.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:34:21 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net 2/2] sctp: add INIT verification after cookie unpacking
Date: Mon, 15 Jun 2026 20:33:34 -0400
Message-ID: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1781570014.git.lucien.xin@gmail.com>
References: <cover.1781570014.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299684-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21EEE68AFD1

In SCTP handshake, the INIT chunk is initially processed by the server
and embedded into the cookie carried in INIT-ACK. The client then
returns this cookie via COOKIE-ECHO, where the server unpacks it and
reconstructs the original INIT chunk.

When cookie authentication is enabled, the cookie contents are protected
against tampering, so reusing the unpacked INIT without re-verification
is safe.

However, when cookie authentication is disabled, the reconstructed INIT
can no longer be trusted. In this case, the INIT must be explicitly
validated after unpacking to avoid processing potentially tampered data.

Add sctp_verify_init() checks after cookie unpacking in COOKIE-ECHO
processing paths (sctp_sf_do_5_1D_ce() and sctp_sf_do_5_2_4_dupcook())
when cookie_auth_enable is disabled. On failure, the association is
freed and an ABORT is generated via sctp_abort_on_init_err().

Also update sctp_verify_init() to validate parameter bounds against the
actual peer_init length rather than chunk->chunk_end, since peer_init
may not span the full chunk buffer in COOKIE-ECHO.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c |  2 +-
 net/sctp/sm_statefuns.c  | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 41958b8e59fd..21b9eb1c02e9 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2298,7 +2298,7 @@ int sctp_verify_init(struct net *net, const struct sctp_endpoint *ep,
 	 * VIOLATION error.  We build the ERROR chunk here and let the normal
 	 * error handling code build and send the packet.
 	 */
-	if (param.v != (void *)chunk->chunk_end)
+	if (param.v != (void *)peer_init + ntohs(peer_init->chunk_hdr.length))
 		return sctp_process_inv_paramlength(asoc, param.p, chunk, errp);
 
 	/* The only missing mandatory param possible today is
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 544f308ee527..a11a18678279 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -647,10 +647,10 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 					 struct sctp_cmd_seq *commands)
 {
 	struct sctp_ulpevent *ev, *ai_ev = NULL, *auth_ev = NULL;
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
 	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
-	struct sctp_chunk *err_chk_p;
 	struct sctp_chunk *repl;
 	struct sock *sk;
 	int error = 0;
@@ -725,6 +725,17 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 		}
 	}
 
+	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
+	if (!sctp_sk(sk)->cookie_auth_enable &&
+	    !sctp_verify_init(net, ep, asoc, peer_init->chunk_hdr.type,
+			      peer_init, chunk, &err_chk_p)) {
+		sctp_association_free(new_asoc);
+		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+					      commands, err_chk_p);
+	}
+	if (err_chk_p)
+		sctp_chunk_free(err_chk_p);
+
 	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
 		sctp_association_free(new_asoc);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -738,7 +749,6 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	/* This is a brand-new association, so these are not yet side
 	 * effects--it is safe to run them here.
 	 */
-	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
 	if (!sctp_process_init(new_asoc, chunk,
 			       &chunk->subh.cookie_hdr->c.peer_addr,
 			       peer_init, GFP_ATOMIC))
@@ -2128,10 +2138,11 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 					void *arg,
 					struct sctp_cmd_seq *commands)
 {
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
+	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
 	enum sctp_disposition retval;
-	struct sctp_chunk *err_chk_p;
 	int error = 0;
 	char action;
 
@@ -2200,6 +2211,18 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	switch (action) {
 	case 'A': /* Association restart. */
 	case 'B': /* Collision case B. */
+		peer_init = (struct sctp_init_chunk *)
+				(chunk->subh.cookie_hdr + 1);
+		if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
+		    !sctp_verify_init(net, ep, asoc, peer_init->chunk_hdr.type,
+				      peer_init, chunk, &err_chk_p)) {
+			sctp_association_free(new_asoc);
+			return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+						      commands, err_chk_p);
+		}
+		if (err_chk_p)
+			sctp_chunk_free(err_chk_p);
+		fallthrough;
 	case 'D': /* Collision case D. */
 		/* Update socket peer label if first association. */
 		if (security_sctp_assoc_request((struct sctp_association *)asoc,
-- 
2.47.1


