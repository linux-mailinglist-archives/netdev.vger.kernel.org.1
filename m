Return-Path: <netdev+bounces-288461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK0RLGOUB2pT9gIAu9opvQ
	(envelope-from <netdev+bounces-288461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A703A5586B1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8C70302E847
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC6405C42;
	Fri, 15 May 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OTumzCGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DF405C3D
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880537; cv=none; b=LJ/Pm+PWhvPunl222WcXB/4kWBSvx03pGiuGb4XSs4BnzgKrDHy5zr/9x/qP2VTXBVt4ZUAi+s5433HL7xDYdR6je6oVuVPtNrhYasPOmwr18hxxzOSqauGPIFFQ7BdCjV//CMnOPdIDHttg77B1VELLoA01joiSHjqhFpQtyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880537; c=relaxed/simple;
	bh=kv5q0v83BERnHf8RUYl5s4HJZEPKuJWh5FL8+H5YLiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sdf7eulw01rpcHxYFLW2OBIc8jXWM9cndo4p9338SEE8CYmQqGUgf/Q9bManjvIH3Ge/YqcKhR6THwx11bShkNOfWIp5kSqNOFIfslI8FbofWsAmyHE5h8aq3sYpu8Z9c3wkBXAGQMtk5SugLKKL0BSimZSNLa5SnWpaE7muukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OTumzCGJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbec19732eso381845a34.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880534; x=1779485334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCypKlOxSGAZFpmnShbdsjIbO+IGrpWpZMc8Hsvsi8o=;
        b=OTumzCGJaCiRgeH0JnuPjZTDy5ymzVPQxXpGLpU5LJl5ZQJhI1t98znGbGQ8bCil5m
         6mf0URBd8+/POPaewPePNInlctLnMRfdV3bWvKtxuHLs/zGz5uBal/LQ1RiXm2ozC6rh
         nTw3Nk6kLsmwPLElzfKBuT2/YWc5HAtiar4wJmm1sNVZ8euBi5u94pGG51apwWqgF85D
         N8Lp/jxF7c/8qbYhVXmG3fhYyrn87iKLSJVM6ImZEW3/jmakepxeynFTmfuGAkspib74
         StFsWAru+Rcr6UuQ6II7hiODIpuQfhXDkXesdZsSO+N6aysOFDY+nYv/WdxyIwiD11YH
         9LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880534; x=1779485334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCypKlOxSGAZFpmnShbdsjIbO+IGrpWpZMc8Hsvsi8o=;
        b=r8/5s0gNzpHi4JuEJVcVKIdOUQB0iHt1qIOIEFo7hQA5IwavUtuN0VwyTfPhf9cah2
         Hy7WnlKB0jOUfaLgtqGt1Oy9CVEHCLZUsC9B9tSbgCBOep/qv36coQR/sARM+DtiSlmd
         9PM3c66oVOnxP4IpYsED+CJCSHNkbx02rOdmep8qW8zxgkqKSpKGLRyjxeVYu1br4MnD
         VtU8g7u702qjGIhYgcdyIWaS15kNhuflqxfKHVwAlKhJElAFuLcEHAZyMjEgp8MqYe04
         GMCvcIPlkprGWRxw+WnA1E4TMKz7vVeQScrUnPnUyplJj3DU7huA6KGxEi0oZRHl1eiY
         T4Qg==
X-Gm-Message-State: AOJu0YyXc/B9Q+gUmOBZpKhaVvI3Lsq7nXKfajGd+3BfI/6GbeldXeKz
	pQNjkw3IyaQupItoTOk+J6urNfxKYYj9hwmCS2NwWrhXpC9m+h2H7/Qm449rQQQYUMtn3PdOx7Q
	U9XfL1NE3qEhHTb/wKF5O+wAz+TwPHBpBjlXDEcL/GRaV+Ic4XvgZ3S0WkW3NjMPVQN76OyOE6K
	DYKtSBJutba9tM178pADZsvGAQFuG2L11qI9D/5MBXdNRrD70=
X-Gm-Gg: Acq92OEwIJE8gHa+ZOAkt/lVRTvhg0FV6IFuauAxSYObt7lr6kSPU3AfyM2GjGUX84P
	FfAY9VB1xuO0THIHKPr3cObrctkbbmWVoi9j5b42yJRr3mKbptjatbbRWXHgB7ZJgSCvx1Vt9uW
	Hbkx3lMWn35LrMEIOcJE54EryxukgJLjF88xcKj9x1vQw7A293umreg/PEp2y31bm42Ye98CEFE
	TgTQhoUOs8JqSbJlo9XsaqIxAzmTBabBRWOEP+1abgYqEecwap11l58USeZJIW81zvtT51ZLHYf
	XhgJZE4bDFCYjRqKuOY+xf+QN4fmk+bJszfqxf57qfE2pObWbiefGeXLvBTZl1tUoUCMejkyti0
	RLeToBR2kFEC+Y5m+dUwdOidyMJ6TsYXH9+cjoNEPkbYHqhBpf960gPE9tlqviNrGTjGntYyDQ+
	s8vTAPOCuJ6d43H82+PsTwRFMvAeId9l9kiRGvFFiB7K+Pyk0yFmA0kgs/8agRE2ks3KHJ
X-Received: by 2002:a05:6820:818a:b0:696:1a85:586f with SMTP id 006d021491bc7-69c942daf07mr3908972eaf.18.1778880534235;
        Fri, 15 May 2026 14:28:54 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:28:53 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v14 5/9] tls: prep helpers and refactors for HW offload KeyUpdate
Date: Fri, 15 May 2026 15:27:11 -0600
Message-Id: <20260515212715.3151307-6-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A703A5586B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Action: no action

Preparatory refactors for TX and RX HW rekey support; no functional
change.

  - Hoist cipher_context / tls_crypto_context above
    tls_offload_context_tx so they can be embedded in offload
    contexts.

  - Add tls_tx_cipher_ctx() accessor and factor tls_sw_ctx_tx_init()
    so the TX path can redirect to a temporary SW context during
    rekey.

  - Split tls_set_device_offload() into a dispatcher and
    tls_set_device_offload_initial(); a _rekey() sibling follows.

  - Factor tls_device_dev_add_tx() and tls_device_commit_start_marker()
    so the rekey completion path can reuse them.

  - Move crypto_aead_setauthsize() into the !*aead block so a fresh
    AEAD is correctly configured when RX HW rekey allocates one.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  38 +++++++-----
 net/tls/tls.h        |   1 +
 net/tls/tls_device.c | 139 ++++++++++++++++++++++++++-----------------
 net/tls/tls_sw.c     |  33 +++++-----
 4 files changed, 127 insertions(+), 84 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..2512a3799b21 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -151,6 +151,22 @@ struct tls_record_info {
 	skb_frag_t frags[MAX_SKB_FRAGS];
 };
 
+struct cipher_context {
+	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
+};
+
+union tls_crypto_context {
+	struct tls_crypto_info info;
+	union {
+		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
+		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
+		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
+		struct tls12_crypto_info_sm4_gcm sm4_gcm;
+		struct tls12_crypto_info_sm4_ccm sm4_ccm;
+	};
+};
+
 #define TLS_DRIVER_STATE_SIZE_TX	16
 struct tls_offload_context_tx {
 	struct crypto_aead *aead_send;
@@ -191,22 +207,6 @@ enum tls_context_flags {
 	TLS_RX_DEV_CLOSED = 2,
 };
 
-struct cipher_context {
-	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
-	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
-};
-
-union tls_crypto_context {
-	struct tls_crypto_info info;
-	union {
-		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
-		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
-		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
-		struct tls12_crypto_info_sm4_gcm sm4_gcm;
-		struct tls12_crypto_info_sm4_ccm sm4_ccm;
-	};
-};
-
 struct tls_prot_info {
 	u16 version;
 	u16 cipher_type;
@@ -388,6 +388,12 @@ static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
+static inline struct cipher_context *tls_tx_cipher_ctx(
+		const struct tls_context *tls_ctx)
+{
+	return (struct cipher_context *)&tls_ctx->tx;
+}
+
 static inline struct tls_offload_context_tx *
 tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 44bedb0dfdda..cd992fc161e5 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,6 +157,7 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f22f8a550c82..7a98d2f6cbd3 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -138,6 +138,41 @@ static struct net_device *get_netdev_for_sock(struct sock *sk)
 	return lowest_dev;
 }
 
+static int tls_device_dev_add_tx(struct sock *sk, struct net_device *netdev,
+				 struct tls_crypto_info *crypto_info,
+				 u32 write_seq)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	char *rec_seq;
+	int rc;
+
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
+					     crypto_info, write_seq);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
+				     write_seq, rec_seq, rc);
+	return rc;
+}
+
+static void tls_device_commit_start_marker(struct sock *sk,
+					struct tls_offload_context_tx *offload_ctx,
+					struct tls_record_info *start_marker_record)
+{
+	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
+	start_marker_record->len = 0;
+	start_marker_record->num_frags = 0;
+	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+
+	/* TLS offload is greatly simplified if we don't send
+	 * SKBs where only part of the payload needs to be encrypted.
+	 * So mark the last skb in the write queue as end of record.
+	 */
+	tcp_write_collapse_fence(sk);
+}
+
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1068,57 +1103,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
-int tls_set_device_offload(struct sock *sk)
+static int tls_set_device_offload_initial(struct sock *sk,
+					  struct tls_context *ctx,
+					  struct net_device *netdev,
+					  struct tls_crypto_info *crypto_info,
+					  const struct tls_cipher_desc *cipher_desc)
 {
+	struct tls_prot_info *prot = &ctx->prot_info;
 	struct tls_record_info *start_marker_record;
 	struct tls_offload_context_tx *offload_ctx;
-	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
-	struct tls_prot_info *prot;
-	struct net_device *netdev;
-	struct tls_context *ctx;
 	char *iv, *rec_seq;
 	int rc;
 
-	ctx = tls_get_ctx(sk);
-	prot = &ctx->prot_info;
-
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
-
-	netdev = get_netdev_for_sock(sk);
-	if (!netdev) {
-		pr_err_ratelimited("%s: netdev not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
-
-	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-	if (!cipher_desc || !cipher_desc->offloadable) {
-		rc = -EINVAL;
-		goto release_netdev;
-	}
+	iv = crypto_info_iv(crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
 
 	rc = init_prot_info(prot, crypto_info, cipher_desc);
 	if (rc)
-		goto release_netdev;
-
-	iv = crypto_info_iv(crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+		return rc;
 
 	memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
 	memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
 
 	start_marker_record = kmalloc_obj(*start_marker_record);
-	if (!start_marker_record) {
-		rc = -ENOMEM;
-		goto release_netdev;
-	}
+	if (!start_marker_record)
+		return -ENOMEM;
 
 	offload_ctx = alloc_offload_ctx_tx(ctx);
 	if (!offload_ctx) {
@@ -1130,20 +1139,11 @@ int tls_set_device_offload(struct sock *sk)
 	if (rc)
 		goto free_offload_ctx;
 
-	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
-	start_marker_record->len = 0;
-	start_marker_record->num_frags = 0;
-	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
+	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
 
 	clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
 	ctx->push_pending_record = tls_device_push_pending_record;
 
-	/* TLS offload is greatly simplified if we don't send
-	 * SKBs where only part of the payload needs to be encrypted.
-	 * So mark the last skb in the write queue as end of record.
-	 */
-	tcp_write_collapse_fence(sk);
-
 	/* Avoid offloading if the device is down
 	 * We don't want to offload new flows after
 	 * the NETDEV_DOWN event
@@ -1159,11 +1159,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	ctx->priv_ctx_tx = offload_ctx;
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send.info,
-					     tcp_sk(sk)->write_seq);
-	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
-				     tcp_sk(sk)->write_seq, rec_seq, rc);
+	rc = tls_device_dev_add_tx(sk, netdev, crypto_info,
+				   tcp_sk(sk)->write_seq);
 	if (rc)
 		goto release_lock;
 
@@ -1175,7 +1172,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1188,6 +1184,43 @@ int tls_set_device_offload(struct sock *sk)
 	ctx->priv_ctx_tx = NULL;
 free_marker_record:
 	kfree(start_marker_record);
+	return rc;
+}
+
+int tls_set_device_offload(struct sock *sk)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	struct tls_crypto_info *crypto_info;
+	struct net_device *netdev;
+	struct tls_context *ctx;
+	int rc;
+
+	ctx = tls_get_ctx(sk);
+
+	if (ctx->priv_ctx_tx)
+		return -EEXIST;
+
+	netdev = get_netdev_for_sock(sk);
+	if (!netdev) {
+		pr_err_ratelimited("%s: netdev not found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
+		rc = -EOPNOTSUPP;
+		goto release_netdev;
+	}
+
+	crypto_info = &ctx->crypto_send.info;
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable) {
+		rc = -EINVAL;
+		goto release_netdev;
+	}
+
+	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
+					    cipher_desc);
+
 release_netdev:
 	dev_put(netdev);
 	return rc;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index dd8e88cc2a36..434d68cbbd20 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -555,11 +555,11 @@ static int tls_do_encryption(struct sock *sk,
 		break;
 	}
 
-	memcpy(&rec->iv_data[iv_offset], tls_ctx->tx.iv,
+	memcpy(&rec->iv_data[iv_offset], tls_tx_cipher_ctx(tls_ctx)->iv,
 	       prot->iv_size + prot->salt_size);
 
 	tls_xor_iv_with_seq(prot, rec->iv_data + iv_offset,
-			    tls_ctx->tx.rec_seq);
+			    tls_tx_cipher_ctx(tls_ctx)->rec_seq);
 
 	sge->offset += prot->prepend_size;
 	sge->length -= prot->prepend_size;
@@ -610,7 +610,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Unhook the record from context if encryption is not failure */
 	ctx->open_rec = NULL;
-	tls_advance_record_sn(sk, prot, &tls_ctx->tx);
+	tls_advance_record_sn(sk, prot, tls_tx_cipher_ctx(tls_ctx));
 	return rc;
 }
 
@@ -827,7 +827,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
 	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
@@ -2677,6 +2677,15 @@ static void tx_work_handler(struct work_struct *work)
 	}
 }
 
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
+{
+	crypto_init_wait(&sw_ctx->async_wait);
+	atomic_set(&sw_ctx->encrypt_pending, 1);
+	INIT_LIST_HEAD(&sw_ctx->tx_list);
+	INIT_DELAYED_WORK(&sw_ctx->tx_work.work, tx_work_handler);
+	sw_ctx->tx_work.sk = sk;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
@@ -2728,11 +2737,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
 		sw_ctx_tx = ctx->priv_ctx_tx;
 	}
 
-	crypto_init_wait(&sw_ctx_tx->async_wait);
-	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
-	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
-	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
-	sw_ctx_tx->tx_work.sk = sk;
+	tls_sw_ctx_tx_init(sk, sw_ctx_tx);
 
 	return sw_ctx_tx;
 }
@@ -2859,6 +2864,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			*aead = NULL;
 			goto free_priv;
 		}
+
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc)
+			goto free_aead;
 	}
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
@@ -2875,12 +2884,6 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	if (!new_crypto_info) {
-		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-		if (rc)
-			goto free_aead;
-	}
-
 	if (!tx && !new_crypto_info) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
 
-- 
2.25.1


