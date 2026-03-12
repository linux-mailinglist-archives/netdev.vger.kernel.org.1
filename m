Return-Path: <netdev+bounces-266832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHuNO1obsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A626C006
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2637730240B1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D9375F64;
	Thu, 12 Mar 2026 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqQU8XL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194873750DD;
	Thu, 12 Mar 2026 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280089; cv=none; b=k4gzuFqTRZ9Z+w3QnrcAidBzAhqTOPPuZN5HnXeV4hRlv4XmVoscHqye/iPP34OfrRB6oYc3+sAbOky/F9c0q5Q+riTnhulPIBgHq9LmSCsw88kFcgZ98cllmLwI/wd8+1eCXNL0d/RyALoecgYmOVIvFi/Ecdpsvfm6PWO0QW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280089; c=relaxed/simple;
	bh=2yZn9LbnQdKUG70itIf6L0orUl9KLjy8h2c6aydct/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBuiICK7KGFQN9qqb7WHgtR39kURQjbSupyVivdemL0w3vNJretCiy2LOg1bEnn88eQQWp3vNDtdh3pqAHwzj4yhyKRHp8d75DVG6gREy2rEsoPl0jQ+IM9JL8MH9vykdSKJcYywQHtH1R3nEDoorwv43v1Av/0eRjnHlubqrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqQU8XL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5154DC19425;
	Thu, 12 Mar 2026 01:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280089;
	bh=2yZn9LbnQdKUG70itIf6L0orUl9KLjy8h2c6aydct/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqQU8XL2yocX+avmR3reHbv4SQVlHRHqLjDfnogbnyT4YET+vhkRa48hnY6ewI/dY
	 s1Jxrp/0fG7IjQUqaiAZLxwv59RauDG/4SXYluyY/ez9eq6xzQdqaK+gSPrXeVqY0y
	 2Q+7upPvbFIn70/xDCqT1wAVkbzP/0wNeZXM7R6XSgddbc/musCc/XmB9Z9ExvJrmD
	 OAo1sUN4dr6OlBXHIhlSZezLjZ3F03X4+CgCV40ivp+PYxl8loy3CvCg21N9AI62R7
	 Ji5u7uNtBkW9DmeGP0uYjJwoky6iBQagO0XsB5KpmlJrjsMlF4aGFUfSyCKYXVPUVF
	 uCGtU7NU6fwCg==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 2/8] tls: Factor tls_rx_decrypt_record() helper
Date: Wed, 11 Mar 2026 21:47:58 -0400
Message-ID: <20260312014804.5083-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312014804.5083-1-cel@kernel.org>
References: <20260312014804.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266832-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Queue-Id: C03A626C006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

recvmsg, read_sock, and splice_read each open-code the
same sequence: zero-initialize the decrypt arguments, call
tls_rx_one_record(), and abort the connection on failure.

Extract tls_rx_decrypt_record() so each receive path shares
a single decrypt-and-abort primitive. Each call site still
initializes darg.inargs separately, since recvmsg sets zc
and async between the memset and the decrypt call.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index cedcc82669db..81e0e8aaa6f9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1832,6 +1832,17 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	return tls_check_pending_rekey(sk, tls_ctx, darg->skb);
 }
 
+/* Decrypt one record and abort the connection on failure. */
+static int tls_rx_decrypt_record(struct sock *sk, struct msghdr *msg,
+				 struct tls_decrypt_arg *darg)
+{
+	int err = tls_rx_one_record(sk, msg, darg);
+
+	if (err < 0)
+		tls_err_abort(sk, -EBADMSG);
+	return err;
+}
+
 int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 {
 	struct tls_decrypt_arg darg = { .zc = true, };
@@ -2132,11 +2143,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			darg.async = false;
 
-		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		err = tls_rx_decrypt_record(sk, msg, &darg);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2294,11 +2303,9 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		err = tls_rx_decrypt_record(sk, NULL, &darg);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2380,11 +2387,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
-			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			err = tls_rx_decrypt_record(sk, NULL, &darg);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,
-- 
2.52.0


