Return-Path: <netdev+bounces-286857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMmxFeBlAmqhsQEAu9opvQ
	(envelope-from <netdev+bounces-286857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A9517479
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D04AD3045ED1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4251361DD0;
	Mon, 11 May 2026 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQGC1lzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F3361666;
	Mon, 11 May 2026 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541975; cv=none; b=XUiSdW5Wp5XPtAc+T8qg40e06M6wzzMnzrYI8vHIQObsLP8KRTE8ovNYI3rsYO56n8EHR8uTdJt2oAeYycCswKUbbf7tzSBmS02sNNDQiqT/wLmMBXa/Mr6kPwPoDc60cS7I7mI227RdIwN8Yfx7ul9MwetjjtdG+F6DVSGBKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541975; c=relaxed/simple;
	bh=Kg+xEcA0TGYQcIeGAllHaehuy4Yq5hHBJdhNOtSKH44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ob4rl0BOGAi5ttOiZqnHRcaKl/p41Xu4BSqUiEJvIcFPM9YM5M6z/A9ur8/s0J4QStFDKmX9eNnSbJe0jx6Kewj3Kv2Jd5lnDCRIo/RoSXQKE5NgTwm5qFl6JN/DbZbhZJQp190AWfM55zwDrgiG5jip99JjkqMfKFGG4caX4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQGC1lzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F2CC2BCF7;
	Mon, 11 May 2026 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541975;
	bh=Kg+xEcA0TGYQcIeGAllHaehuy4Yq5hHBJdhNOtSKH44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQGC1lzXXym9l2ou7/zCoSB3kk0TYoAsv9DXPZPOi25MS33GZxWDWV3nekF9z8Rvd
	 F+6eNW4oaIgogh1TnqIrjbqYLJKx9YvfbaBxBXm6tTotFWR5+XeJhCEvyWM/2qRx/B
	 bUh+0RPPsdfNfuHW1rFdJiuwLO3I24pK5tnf26vd1cxP7N+8jG7tBVosCxJcqQZHBM
	 G1QnZPkv3P2SClaSplQcGIDCL0z8ONYBqS03rlR49B9tC15ZacFjTnfmy1lOc27q17
	 iVqmu/rhuR26NiaRfr3Wq0IxrUHLT5HhIgIdsDJV7wtcnuLyibcCpQ6sGCwkMTa7/W
	 pvqwdz7Nx2eXg==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:55 -0400
Subject: [PATCH net-next v10 4/7] tls: Factor tls_strp_msg_consume() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-4-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UYhHqnWH9kQZYtWnKB2aE3v0ZLqy4/Gg4/JzoO3PYbI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWSDugm5W4983Naha227ePBld8WYSwQVjuHv
 r90lDlaxRSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkgAKCRAzarMzb2Z/
 l0sKEACPja2Z3zmOmi7/Y6MQUWMPYa8LkGwjyIL8CDHJof/QPKdJ5grTror6I1jxXfR3pnlaGKp
 BdLXUw1ZJ6JCCa9ll1wVxn2lnFTBuvkZc0x9B0s5G4c1xFerT+mIGbKuWd0Ojf9DjKB64pcbSkW
 tN7pTaG7cVuYh0kmISzFk5ByKZzeIstttO1W/OBlOaT1SxpB61K4HCY3SXM5SogYJs1MLeBTrhJ
 yWeA4jrrLvc7L8ALtor7sKRIZppTpi3XRxxaX9lKYuAuQRkYBqyMubnJMR4/s8wqeBz1CZmqSHy
 rmfHkUjdrdZEjUhrmcWFG4hyUfC60eRa6xsq3No2+79atidElGc7KHusFBEHkShFapi5AKP7SwR
 dPQNhBX78n/GfSdUtgAzrjc1xU/OQMOgSkXbwFd03cxQxRTlspnUOpjYIVX4dAeuc58tDLFUmok
 FVz7vlzZyPzqLNYMG9ktNseoGhu9ObedNAj9O/x1HTsUWReC9REjG9WffcSC1FZA+675g9IoQ9k
 6OLGUlW8EoS6zIjDoAnO8n9x63Nawmux9uXCDu0BmOTXPPE8TuW2f/jAwFaH/uz2Xz5B+6H4vHS
 gfX6Hx0RDHIdEFAv6vgCrNy1/mTzCrJXOk3Wd7Ma3Ie/PZf8vWC8lue229mnvWt0WmjaU9nWPKR
 jSpb51x6MR904sQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: C43A9517479
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-286857-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). A subsequent
patch needs to release a record without immediately triggering
that check, so the release step is separated into
tls_strp_msg_consume(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..cb0091e03f41 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -194,6 +194,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_consume(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c72e88317627..e7aaee6efe6e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -581,7 +581,12 @@ static void tls_strp_work(struct work_struct *w)
 	release_sock(strp->sk);
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
+/* Release the current record without triggering a check for the
+ * next record. Callers must invoke tls_strp_check_rcv() before
+ * releasing the socket lock, or queued data will stall until the
+ * next tls_strp_data_ready() event.
+ */
+void tls_strp_msg_consume(struct tls_strparser *strp)
 {
 	WARN_ON(!strp->stm.full_len);
 
@@ -592,7 +597,11 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 
 	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
+}
 
+void tls_strp_msg_done(struct tls_strparser *strp)
+{
+	tls_strp_msg_consume(strp);
 	tls_strp_check_rcv(strp);
 }
 

-- 
2.54.0


