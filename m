Return-Path: <netdev+bounces-271057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF5MAGSMwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85238308E72
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1092831B0C51
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCC3F9F40;
	Tue, 24 Mar 2026 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVwnLtZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7063E0C41;
	Tue, 24 Mar 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356842; cv=none; b=liC5dHo7tmM8ImgirmCPHg5+FAoinqJpj/qB9HCse3iw+NXUT80kpayun9zYlk7wBjm6hXsN67I5CIpn+d0zKwl+22Qip4yfDTaSanuvxNdVVOM6MHVK+hnHxrlEAJ84MjHy+OJQ7pBNoOfvOSEABFBibLKgPtFFJQWmb7okSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356842; c=relaxed/simple;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+efXq42Sy8ZyQI6UyTSVm7BQsTmzkQhIxKl6mE55SN5/hdUa8BnF2Ry9NiQsSfP5STw5f7cs1a/eUIKlMXsrZ53n0fELrTiUTqQVtRGsUQ01T+k7dMihHvmmpgD4dv9e1jjhVX/imBXGNLjnvO2nYT4hVH1EATyxL6bIHGViPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVwnLtZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E22C2BCB5;
	Tue, 24 Mar 2026 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356841;
	bh=MKqHx2DsVWgIqTTYLAkpvdX9hb59MkEI5VpTYdIILjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aVwnLtZas28mMnKhPdI4YRAHU7GCnE8pwzWltplcr8x0JyMjvQmm2wkt5HLIOvc7/
	 snll6rPagWq2SDGIy1v8r6l2abk3djfx8818kBRMX/+36q4CWBSBtviH8EXUxO3HiY
	 9puezIo//p+UWaQsIhfxJImDS4oI/uoO+VF7N0f38eRnLwchRejJy8sFIvMjcxm7PZ
	 KfQYRxqg1l6Y03EVH5LQ8d6PoUYslmKI0uL9kQJAhfGpSMMs4YPEGSkZ1vpKGIincT
	 mcUGOV4nKL8RsY+tzknS6q8PlfDMp+ig6SvT26njBa0PWfpS8Bz53Fgr3CYHtBbi7l
	 sUWxxcForcdIg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 24 Mar 2026 08:53:24 -0400
Subject: [PATCH net-next v5 2/6] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-tls-read-sock-v5-2-5408befe5774@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=8rkFUaZwGHp34oZtLBHCP2ihwiz9+QlviZCigfPoS+o=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolnLeeRcc//aH/wp1b8zTAKiutCGSMY5ksxJ
 n19jE2YH5SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJZwAKCRAzarMzb2Z/
 l2MzEACZfCSZ0sKObR7Cpx1E+bLhJ9tttG2bEDxYlDjiQ4TveztWwTd9yANI0sDu9wt3slKSdcH
 a3FDQrizl+flxYwJkGzQOsUBS4tlomaQCkcfdxcorO/RhMEGjz6JnC6YaohK+Fs1WRse4fSU5AW
 8ViI3po+opIK10yH2JJH7y873sdFSApSFOWJFl8mboSgaM93O/RSwzHj8Yk6QZnruhHRd7f2Cb6
 NOiPBp1N0zP6u5v54lG6RvKY3GOCSglXWFodr6Tii0UTpKCCANaUTLyxCUBxTIWen1DRqx/1cqZ
 Z05WSEt7oXQ7SNN2Bsw6PIO3otegJa/SXUi2rC4xa6MuXT73bO64zq4z8pjGsAy43G34BSVg7fA
 AmS1wiOO4JHnN0fgux7IMSr0azwNKXySyRoHCszZQMiVOFUS3RV8QOTvg4gK8bjrfdw8ZIE5oQT
 wOb7CU+uGi1/Pi/1xuoyyMXx6w6aVBFoIXp7APdgiyJC1pSEPcbQiEi1OD4Vv8yVEVdX4GNrM2e
 Z6/62Ey8YDfl8vlcydR7C7BrIudmdcBaF7EPUTOSY33+zc5DkT20Ldd4Px4rbVZNIGM7PTpGZWq
 qqG+KjCT4xk7S4I5XPAgNJ/jUejjO/VI99CpvgYI0CC5GARN8rTad20s2V+MvvHvubx7NLX5uls
 SAe0CXhX6l2MC0w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-271057-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,queasysnail.net:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 85238308E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 20f8fc84c5f5..5626fdd4ea0a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1799,6 +1799,9 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+/* Decrypt and return one TLS record. On decrypt failure the connection is
+ * aborted (sk_err set) before returning a negative errno.
+ */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1810,8 +1813,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
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
@@ -2122,10 +2127,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2284,10 +2287,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2370,10 +2371,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


