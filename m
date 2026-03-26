Return-Path: <netdev+bounces-272080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HOmMLo7xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:59:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEEF3366C3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D99E3098408
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C23128CA;
	Thu, 26 Mar 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnHBdaBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71883002B3;
	Thu, 26 Mar 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533070; cv=none; b=XVNPA4WnGhOLguDK+LQaoookK6Hi/UhVMudnZNuZP8zv21hD6Eac5EkZFIBA3bFBbW9sdowiYrvIyvs0GxpLCrULAysBHC4CK65+mbs23nwLqstN/rO55umS7IOTVJnB7pcVVjwvoS35R1aUadZFsiO5E+Ypx1mygUcTi77t8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533070; c=relaxed/simple;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjUBH9JpUrSzaQNk7m5NrxBV0koGY41D9LDPRlSSgo/0LUUBiGUKWdcyPUbVBwTCRVkOpQERrEYx0y8UNyLLgk6/KvnTye64hkpz7wKUw40MD0w8CIj+tv+HlOaZim/jg21ZEvvZQr6setslFCvoIrKyYzchATBetv2eQ2wYKjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnHBdaBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3213CC2BCB0;
	Thu, 26 Mar 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533069;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JnHBdaBxZGPk76fxaGJW06w2nFvnERXBhnEvvGIfOnhbnyGseEVq0X4xDI5M473jN
	 Duna2JC8QwDoRkdVIcOFzLc9A1N+AAg10jXNsT4/DUzR/5miJEJT/v8ppsc0idnzm6
	 MwUsS6tuUSPfs8rcHWHYSg1OdLbWXRPXCnfqj9ozqJJbM3txqnUwuWcwtjwK5Uu2+W
	 jQUNE2wFw68uVDl/ExND/anRvyrD72R9YUYHDBVFVLLeYyVUqAQagz509KSefBRzTo
	 W6cGB/YCtNx7Yu+7QKifzlWWZMhwfGJ1cLA7VBQpT5gpZ8wOO5mZTG6WS7LkLVaOZm
	 1/199VG/O1hEw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 26 Mar 2026 09:50:49 -0400
Subject: [PATCH net-next v6 4/6] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tls-read-sock-v6-4-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yQMMtVVxvd+7sxHpan6dTvbldeUZSeQCrtyDydMeLBA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnJPCQNWcXbRKOqL71CPGki9sDCWet/+yZzq
 30fslJI5emJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5yQAKCRAzarMzb2Z/
 l5zxD/9YYY4ZcucsOyuo0+cP3iRddfZmDdHLoWfRyTp0w9yygCAH4j+FCTjaLkTSeMYfH/wYhXU
 LgCb+sKGUjxV6Z8uBnF3rJyhTVD5NI+C8om1+jv5MU9H5O/gT4GQPjXXYSDruLU5ufw6+CsyIFg
 bNw8aMSO1d9RummCh2nnZm8MAW69QmkMm8Ga/Wgyr7GedDIKkK2iN+Kk6ho8Q5+LsRcbPLQInDF
 vlNZ09hshx0PxrMcrvNBfBhCNrotOGVaZlA+p8rB5OZb/F41e7l0F5C8tUFL6LSdtt+sLkS5jLe
 ZB2y88RWTY3qux4hq8+zs9MZ5mZHsJV9EU/4WylkV1bDS0zE/Aamb5xHbWDXerVDD9T7sjlqWx5
 mcfK8mZPKzkOO5/QKQ4Rtw5/k6A+RhAjMFTG5CHrmHuZT1MrdVpjZKNQsC6IsKZdBJgGIsfrkB7
 O21yKZvcrWfN5HMu1ebh3ocGWiV3h4iQgrnWsftoqlJYlsY6vZiwo8Ahy07vReLfhD4o0/B2hQY
 oqlgEHY0J4fp70I/bHE/YMBtgDPqma0CLjPEBv0FpQgSjBO4xRKJuqf4AkbNhi0fOuUjScjFmnz
 xSYTQrXrT2sVhSEQDkbo8Q7JdqNoHGtA/dbdg++GX2KVaAxc3mye50vxNByvsbsL6DvQszpa0Sz
 vvJqdLUn/U0pAtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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
	TAGGED_FROM(0.00)[bounces-272080-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 3FEEF3366C3
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


