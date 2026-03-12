Return-Path: <netdev+bounces-266834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHZ3G14bsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDDC26C015
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 230FE302630D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712A375F64;
	Thu, 12 Mar 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5eIAnJZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419C32E692;
	Thu, 12 Mar 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280091; cv=none; b=lYq8xL0wcveIXcPAZOGFAdDjGgU5orykWuLyuQRh0LmOZzXle9j/xwfI6m7yym3UVGHdjFOulVrDU11Y+Vox76gJ8XOyV7vrsCTxwLKse/X7LTfKmBrAycfmEyCauMY4+JfpIViE2seF3aeaw6S3+QQgs2GgnuCmdj2GRSiM2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280091; c=relaxed/simple;
	bh=cKOwbORO9EjYDXyYLsSTxKCmSo8R9shImZCnKJyIC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKudp44cEOe9Y5/g82G3QoXw9UhInpmnlq1YKlCZN1ywhfXt54eysJDsrsdJN2XdN9xZzGL+Zmv0/23G+ltxo9dQOWPZO2qwdzO+keVgsHSSk7suSUJh/BpXjKgA/+8u4UoD8LiMdKlowDVANngj5VMgAQRN1abFXZ4aQyM2//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5eIAnJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311EBC4CEF7;
	Thu, 12 Mar 2026 01:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280090;
	bh=cKOwbORO9EjYDXyYLsSTxKCmSo8R9shImZCnKJyIC0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5eIAnJZ/u21/AdzM1kwKmGoo14KZ+5Z8WTQY5YKurnrg+jw36kR7SU3HUAkf543L
	 iBvz1Z6ajpcFRaubtN6iOTfRasOUtZkz3qrgAxajU1rcx9aLeZP6zayV03vHjVdXC0
	 sEqs2VbyUZlmF5MKmM8HqohIi/1EL63oj2cqZqX9YEm0OHoMvJ2jv3LrNX49za8zSa
	 2tl11za+xZQpqDi6JF3XzQZAxPHutE4eBPRLRuf89RM3VTc9WgFQvBoVY+3JTW83Cw
	 kYTiHcO530IYGS3lZUO/Lvu0YWzQ1kGUsXozYgwLbkBJVpU8IpTdxm9JqZOjy9JOoj
	 lNskKtOF2yoKA==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/8] tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
Date: Wed, 11 Mar 2026 21:48:00 -0400
Message-ID: <20260312014804.5083-5-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266834-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,wdc.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EEDDC26C015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). Batch
processing requires releasing a record without immediately
triggering that check, so the release step is separated into
tls_strp_msg_release(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index e8f81a006520..a97f1acef31d 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,6 +193,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_release(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..a7648ebde162 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -581,7 +581,16 @@ static void tls_strp_work(struct work_struct *w)
 	release_sock(strp->sk);
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
+/**
+ * tls_strp_msg_release - release the current strparser message
+ * @strp: TLS stream parser instance
+ *
+ * Release the current record without triggering a check for the
+ * next record. Callers must invoke tls_strp_check_rcv() before
+ * releasing the socket lock, or queued data will stall until
+ * the next tls_strp_data_ready() event.
+ */
+void tls_strp_msg_release(struct tls_strparser *strp)
 {
 	WARN_ON(!strp->stm.full_len);
 
@@ -592,7 +601,11 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 
 	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
+}
 
+void tls_strp_msg_done(struct tls_strparser *strp)
+{
+	tls_strp_msg_release(strp);
 	tls_strp_check_rcv(strp);
 }
 
-- 
2.52.0


