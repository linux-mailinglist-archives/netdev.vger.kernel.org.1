Return-Path: <netdev+bounces-271059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOKHLW2MwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF1308E98
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD1431B6887
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D03F9F5D;
	Tue, 24 Mar 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwl42/G2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13E3F99D7;
	Tue, 24 Mar 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356843; cv=none; b=n58zPRS53z9FFnSsCbYG0rDtMI0RXyCJVLlIqs2UWCM/okxRXcaY+GItfBcX7Gy7OrqrAiz/svhBSQb02Mz6gH5ycgr9PHzkE/eD0UK4qZeVAZPEqdvHQt8tv3NOEV4MYSLRfEpcY5VV0CDcQUcIabZNE7NXd9hNVnHppGkcHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356843; c=relaxed/simple;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0BiexiJPaDxkcX6/FxKna/zihHZsRNEzckX2trr0qyB1B1aHbs7AxzW8fiw2g2pJEEiU9n0R4GHL7Lf03it21eILJKZw9FOnYZYoLBSQtZeSYDlwmZcDPznq3GhifmJ9gSMowXLCoeK7r5hdM4GWUr0WvHdKaAZqY9kkl1e8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwl42/G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A74C19424;
	Tue, 24 Mar 2026 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356843;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iwl42/G2yajORFMAc62lsg92jNvSGHddhkoMP97DSUipAK3VQ6k9aQ2e9zteSb617
	 B2ojBSver8ZWo9uSuZFQVD/E0EkWzPV4c5qD95YdVCUyZAFt0DGS7rNYqdMaBhv05c
	 hkUqDaiS2F3f9klO7z2uyCeXe5t6jeTpDpasA7BBFuK0LxAv+5ZyEfBNLdEeLsvjtR
	 93V1fGDGgHrH77Kl6u+VzolpJIirT2nLHCFY6uEbbJ0GVgWxqsToxCdYjEfz1b/Uh0
	 gXxxbjWzpDmdNgBrre+g/H64Cc00GowRi4GTntfB3vfpxXREia59GylaA42GCjzSIP
	 UfRGrvkLl4KTQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 24 Mar 2026 08:53:26 -0400
Subject: [PATCH net-next v5 4/6] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-tls-read-sock-v5-4-5408befe5774@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yQMMtVVxvd+7sxHpan6dTvbldeUZSeQCrtyDydMeLBA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolnWc1o2sHufsP0YoHbfWnZWDCpRtIM8UvIB
 Fet+uqRpXuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJZwAKCRAzarMzb2Z/
 l14+D/9dKxaA0Zk7gGBaT/3wQokNZ18bLoqwg3lwo+l0fT5zRUpheoxpdg+RhyVH5ZD4wJ7pj77
 ng+lGbFiK5m9HM0Nhes/j6AlD0pGVkRMj/mDcYXc/5KhO6wYGnO+ZSIlCvvMiyMmmcH7OD66Pyb
 II30uK8NpRWzCdtSYO01kpPiEwlPmO6iPV64ybToL9ME9mSVYhWleOg9Afc726dOe5bfzuhNZxU
 uHXa9Glw6nM9bAW071prE4OdLhMCe2PfW9WUJWy8D5ojFtMc2JJ8doBbGIkd858yXpSkVeuK3I0
 Nyl3rp4nIfqkMQkikW+s4Gex2Vay8b/Dk2LARg8mvj+7As30QRrbtK/XIYI8qD6NyXUv7wK/YX2
 ZLhGKRlsLajyTJUYPIiMma9lW3Vdgwwq5i8b4T0Fn0SXpFxgSR6tL0oLFF7dE5HOvrqEAriUOXG
 1lbWDa5y/OhX5aiqst+dKRNhOosXdwmXqL8GkMIewOvEtLcIGc5SeP1YlYYjzzxlVZaKzu3gYhV
 +g6hSEN6w1hoUocy9ZoycTN3VgyJrMTH9RclHdR8pjFZQ1sygar+HTQmHSPv8e2+OATPRMjgy48
 g246VYtE/izEQ053cNcJCeUNQZXP1zXdigLagO13MDdFQcK/+24GFicJ1l86HZ+ig1CbyR4JbNN
 e+Na7Q2zVvd9mhg==
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
	TAGGED_FROM(0.00)[bounces-271059-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,wdc.com:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 5DDF1308E98
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
2.53.0


