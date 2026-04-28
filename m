Return-Path: <netdev+bounces-281881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EX5KE7B8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CA486C19
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2609E339F233
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07946AECF;
	Tue, 28 Apr 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRIsB/xh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F340242E;
	Tue, 28 Apr 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383069; cv=none; b=M4bHwlM8jwyxdxJRjGCQpV6qp0w209v14Rf7H4FB8AH6sIkNIJdLYevMdK/xzDhWLqZHUB5Ll3Oihb8P1uBrnV6Tn8ijkfYAJHWJCJ8d2hP3E+Bk4uKQEKf7tQgGAavoMHoGEGtz0eZZil3if15/VjXumt03vujOR7pxDzlhVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383069; c=relaxed/simple;
	bh=t4pkqGON4nD++3u6hAd/ElWtzpL4u2/3cwe/YFanTdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pk4zzdCrl8220/ixnRL0NH8WGn0/BYbFjxIgvGIGXj7sVDO4/qNGGtJSHmG6zpmHx9bYEzN6VueYuuHfX+j4xqAwRvGLJUuxmv0oG54K87WBqZhNSLjZc4/pts8ZkLq9xo5I0M4JTHlO0TpcTWTLzqcadwpObV9PEtC4aYw0WYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRIsB/xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811B3C2BCB7;
	Tue, 28 Apr 2026 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383069;
	bh=t4pkqGON4nD++3u6hAd/ElWtzpL4u2/3cwe/YFanTdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PRIsB/xh4aO/VaSEEFDR+es8gJi0QRN63yFc/AfL6+S56zEiG+wB2dWREUL4dc/jo
	 ru8TuU1m36rwgfHEIklYogWJtwAdUPEnguQCeKRIodExcuUU0U2XLVXxZvnkjyRmY6
	 gLRFDGGD8jGGR8lzFByQui17u2+C2N4UTtemZMMLRT0y2j51LDXvEC04cpsrmrPX56
	 YgRCsDpF+1X6vSGWc8GUuqo6tz73x2N2973nXNKd/zKpa+jwyQ1f/3ef8JHCLVfML2
	 gIc+ocZOoLof0Nx8HuCmZzxnu5mYMIF2xglyTMO2icTpETn72cl2H3d2v4h7bOByl5
	 j6Kmd8hTYgEiw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 28 Apr 2026 09:30:46 -0400
Subject: [PATCH net-next v8 1/5] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tls-read-sock-v8-1-85f96c7df24c@oracle.com>
References: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
In-Reply-To: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=CRhXiryFyz2536APjm4atj6FyAXBKfyB1ZlpD9OzZ54=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8LabRKvH0tRAuB3MMsKuwL6t3thWlwqNg2WTp
 0p4G1OXL6uJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2mwAKCRAzarMzb2Z/
 l2k9D/9ZNFiHEdOX/V2GZyS4DpbAWRLrul3YqmTTmDwPecW+237w/eK/VRW8m6JZ7u+sQlfRKpD
 j1kzIbnMPbB1C4HP5r9xB+BAz6j4UREjM8zXe751XIXXvjnjNFG1OTCC1+g7bwQCy6IHmBWymzR
 iUSIXr5HSl6LPaX9JyMotaG8BuIDSt8EDmRbJqANIfKZXqoB35HrDn5oUjCIRnu2OvBWqxddDlx
 s/R1T2FNAW3vH7W1Sx5Q9JNm7LuShStWinrY3Jua4j2IRWE8riv7xGW1ndPW+htdX+B3V9XC+bF
 +K4CNsCutF91c56xOKyJ+4Lg2HesWB6ZgCi0jvwpVib3Xc5Y1x5CqKJVO8exKDs76ZlK7FQSlKj
 Lwean3H61O6XKITbhldoYKaZjNLsA85jxY2f1c0lJhLmvs18kLImKUOvMd72QImFQEevUAy8emt
 CkqyL7T7xkgUVRzM7TlR8fcv1PCkURawcqYSp+XYUtZ7gRlEjzBC0WsR9x+DcftNlMsGLHgNqBa
 8u9A5vfqtU7WleNo8YlW0/+D8FdoeXcF7Yj3PzaWeSOMsXApxnuamAyc1sqRUpL/t5sWkYcsKrD
 tZBsSccFpcARlI5uuhNLWnMlMm2RRhklZe/NpYX57GaZXvotrwfOfOc6YodByqV8DjLitUzhrm+
 Ie2R2iIDVSY5h8w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 485CA486C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281881-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,queasysnail.net:email,suse.de:email]

From: Chuck Lever <chuck.lever@oracle.com>

recvmsg, read_sock, and splice_read each open-code a
tls_err_abort() call after tls_rx_one_record() fails. Move
the abort into tls_rx_one_record() so each receive path
shares a single decrypt-and-abort sequence.

A tls_check_pending_rekey() failure after successful
decryption no longer triggers tls_err_abort(). That path
fires only when skb_copy_bits() fails on a valid skb,
which is not a realistic scenario.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 94d2ae0daa8c..244ac8ed4b01 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1809,6 +1809,9 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+/* Decrypt and return one TLS record. On decrypt failure the connection is
+ * aborted (sk_err set) before returning a negative errno.
+ */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1820,8 +1823,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
-	if (err < 0)
+	if (err < 0) {
+		tls_err_abort(sk, -EBADMSG);
 		return err;
+	}
 
 	rxm = strp_msg(darg->skb);
 	rxm->offset += prot->prepend_size;
@@ -2132,10 +2137,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2294,10 +2297,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2380,10 +2381,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,

-- 
2.53.0


