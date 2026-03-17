Return-Path: <netdev+bounces-268644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM68InxvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:13:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691B2ACC08
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67025319E224
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5C3EBF3B;
	Tue, 17 Mar 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB1GlEcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462A3EBF2F;
	Tue, 17 Mar 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759887; cv=none; b=mWYPkpokSRRhfSStUCu93Iv4e1Z5Ox+tF17F7a1BM+hAy1m+g8yEFKOPbn/yYlRoq7t0KWOg91qCYnOFNxtBTn4zTuT1C22W1BE8Em8hfFrIPuqCT34ToPu5AI+fKwrqyDuhN00TsXw664FnlhWw8TuZSufyw4465358GumtMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759887; c=relaxed/simple;
	bh=JWtjh4+cdElJ7unPNOnu3KFOg/jqroPna1WCpqJCjKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhXuoTcieo05RkWGiLPUy2SNFof8Q6vgKfDLRLCq1RxdaIZEinLGbnij0l2Ly4Rt+hW3DpjefDZOVmuSNxf3VYKvTEt1wsqjDwvoCTKAJcAQiF/D3nxojsEI+iSPz0u/ueJhiTK5Fdwk8K63FTYs1KkO3svSkywOLGOSXjtmq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB1GlEcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD782C2BCAF;
	Tue, 17 Mar 2026 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759887;
	bh=JWtjh4+cdElJ7unPNOnu3KFOg/jqroPna1WCpqJCjKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mB1GlEcOsKdDYkl6ev9WSrAH3psRGDIHvv8bLhY9f8nv7/WlxQ66fP2AM6tv4SW1P
	 xJQIfXVyfXRBMU7aX8nOfkdIMjMgef2Te+SO9fhMcybRqegMaCHQLL6Pn6WIDjFCEz
	 PeCK5rNC/XFF3iy5Drr2u81tmqmovN9FEx7/a+Gl3E3f83Q+3GcW8aS0rVu/htkfg6
	 I07jWbowEiHmzeBQdbJ2NzDbQ1YZPShTH7EGhHtz/D1w1LUy39VCi2WVQ2Yno4sDuT
	 0jcc+wwMC0sIrOje8mFIKurxEZuqIW4zmZxW0cu1ekeSzx2+pnrWe2L7H9tQFeY/Ws
	 GTGVMkcTmRmPw==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:17 -0400
Subject: [PATCH PATCH net-next v4 4/8] tls: Factor tls_strp_msg_release()
 from tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-4-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Fdn1LkdSx4Wpg++8M8voi9DhohpzepZCgQ+gLF5v+48=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KsGGYnadDsD2yH3kcjUiE2IYGOu3BxvBRZ
 3fqWfD2QryJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 l60RD/wIbBuBkwgp23/WPaCtPqcgjzRh+Viig9DXn8t/QtmS1b5NIxiFzmAPnjmLfvhf3p9SXaw
 WKcolKuo7JbZz4CJ9wjq05f49wGPqTmt1QJG5arxN6W+T2nsrLKBWq8K/Y8EyxHJ/qp5O1BfaCZ
 fcx1dUKE3K3plLrmLU7b0BNhQTSMBb5mQIKSQdnI3ITfbr83X3ayxe5mu6ErbRKoXzd/R55JR+O
 6jc3043gEDphf+kwq9tadi+tOKowb4TjUu5eAezefHObZlh5DGD1xrScJeqQfBads02c0fdbmTs
 9Y7Y7KKNgPteGMIbE48ScGFdP2P7Argo9+Nam1b+XBJXrWyuKigDCdxVtOZHKN5WGc6v6MSPPkk
 JkmrwEKwykn2Ul4BkCHwGT8eU4LsVvbYMnsVQZE7lgbYlGZ9Cy5/qW7RT8E5gFqQYJMVqU1KdQN
 +8ymWE5gYQaUuR8FsZ+Fp2Eczfk7+378rVs+JEjChx8ZNanPele0L0iF97UjxeDAeT2FmUTZ3/j
 NT0x0QfkUL/mOrHN9nDL8mpj/Wa0hKWg7VkK+YCUru1CYyEFlne/4oNsiizTQ+EdVloPptqqpBT
 h976Hbh81whubR7WSupor0EGFhfK0uuoV4fzOukBneKLA+2LIKbr4I6gxIXzTLgAkOZZwg4liws
 hVqu7iW9jfggRwA==
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
	TAGGED_FROM(0.00)[bounces-268644-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,oracle.com:email,oracle.com:mid,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3691B2ACC08
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
index e8f81a006520027110962655f7b69a5ca58d7fb6..a97f1acef31d3a4ad1442c20c6914a9f5198a1e0 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,6 +193,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_release(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e5158c7518385aa0579528520d63f..a7648ebde162b1bd944f53d44c89cd7da4cef082 100644
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
2.53.0


