Return-Path: <netdev+bounces-282509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHFWF7F88ml5rwEAu9opvQ
	(envelope-from <netdev+bounces-282509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB0149AB43
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4862301E9A9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247A330315;
	Wed, 29 Apr 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG1scb4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD349286430;
	Wed, 29 Apr 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499304; cv=none; b=VTwZ8Cir7hUOrkboHoaBnnPm4fig5C+Gb2yTJsj/iMb17fYk8/Ip3+DESTJtAwFm1eFyxygllmVzT7W8QC7fkZhE9VqgpK8ObOI4oQu7JXorspUptf4MJdcNoTO+daAZGX6dUDGW97A4RlOnOgVXaZjVc2RBn6pAUKg8VqLpj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499304; c=relaxed/simple;
	bh=t4pkqGON4nD++3u6hAd/ElWtzpL4u2/3cwe/YFanTdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dw6BI3KU6OQM1w1YFHA5z3DgNIQ9j5ameFd93xw8sRpmPDT//25XTdUjmtBkiDeJ7P1fhISZeALlEmIfn2gKmJYLNZuwAJzE3ayqIFPDIqlA53M4OH4TUbOUgiXDlFZykfQFdYSVK6uUo5LyA8b8TYpTKexUoLNdG7NunSWuVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG1scb4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CDFC2BCC6;
	Wed, 29 Apr 2026 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499304;
	bh=t4pkqGON4nD++3u6hAd/ElWtzpL4u2/3cwe/YFanTdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dG1scb4E3wfx/dnPfqY7FJW0lVXPNcLAo4OABAjvWoGCUTzq6enVavhuq4KaWmt62
	 1VXX7bzUNX/h/BAr5Xtje4R/2LOrSgbjkndOy+BHFtVdSEBJAWOWcJ1g4Ydxzw7svm
	 JBmoxUaPNQkRMLkhfBrg/F24AXp5As6mAossZGlBEm/3Mr62HJ9nPSUrkQdOwgaWCD
	 eygKvCatFpl9t7BVLXoykpZ8UaPnLjdoLofBvfGTAtmC5GApAbDWZWxxDH18kfsKh1
	 IxeB8t6R36GDvPG6FOYFrA9relmc06BKEsJznucRp4GLL4c20IUsyGs3O1FiPl/hAl
	 D1omO3eLLpvQw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 17:48:08 -0400
Subject: [PATCH net-next v9 1/5] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-tls-read-sock-v9-1-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=CRhXiryFyz2536APjm4atj6FyAXBKfyB1ZlpD9OzZ54=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8nymCYRTe5Zc3tlsdV29aLl1Qj7EyAm7YIKBP
 PS+EP2UDN2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJ8pgAKCRAzarMzb2Z/
 l7d8D/0Re/eoarhzGSALMaVNEKJW541cRGubWLTdRJR/rRXu6Uj+MwAYVYo4YSpzyqdYW2FdKdX
 XYEcmTWI4RJnb6wm3SE9Se0ocubi8PRnxKhrEDzRXGTWMnRL9weTVl3IevbbLQabG53pev2bF02
 rAYs4OqHR2oAy4sG9NKPzrDcySrXyQQqVgY/ZYZlhoGzROor/M4g+0QetbYCMBRP1tzKTu4o6Y0
 y1SCOiwRqIjb+jdnqhGlgLJ4w2If6uzteIzj27ivXKsAJw89D4fT1QoUXk7j04h39OWo+X68ELu
 KJPSo92QUo/+IycoZZUaP9UKQ9R5AAKyESoy9qLbDpvSCrdOrj29fDRZOA5VUvKw8vsSahvkmDn
 fpUxChDA8eJE6e3+xXR0/iAHDWYcmOdUkf6T3RZOEnQGSMBuSKRUwadlaGT99ibosakz/b/8Mxw
 5YOPDlMLe1eQUdpzATR+QxtufdW3gL3Qdfy6kgoZUUS2/JDujUHrz4ooWaqofQBy/7yhemKdUgE
 G/Vi3KEFVkgJSsG7FafGM4Jkc7pEkCQhDOFk7Ki8Bn7oPpohxKcO8ywFkiCXnxWI8Fyh5mhGw0S
 P5nPxM5qPTQ04yQh9beniMNnhiluZDxILHe7Hw7lOTv+/nFvWgITEHER7mF/T/iFERyK/rvC3wN
 yNsDiiC5ewreaMA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: CFB0149AB43
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
	TAGGED_FROM(0.00)[bounces-282509-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


