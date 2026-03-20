Return-Path: <netdev+bounces-270120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM7THMXfvWk1DAMAu9opvQ
	(envelope-from <netdev+bounces-270120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9102E26FA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D76663033BD3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347783C8737;
	Fri, 20 Mar 2026 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AcHiagt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45C3D8137
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051122; cv=none; b=IkDbR+93jPN4LuoNJs1ne09MejXL6eOghozbNwTk7vCFy0utJfdphbWm1Mc5J22uv5WgOqWq2JBPna6LP63zxikowyv63QppJIn6RrY3ib2if3/UZ1zGXCYkvfjARKfxmnabtK/ZjxbRmho7EHDeRoTmKmoxTACT6fg/0znYRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051122; c=relaxed/simple;
	bh=DuF7LPP1Ic5ncaUNXG+3GiFvkMSQDGPW5laMmA0vwkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtSJJ09koPEPoujcLip91TO/ybmvEMI3y76m5D24D+Up3WOHxiiiRPzMJfY9yjTqVVB1xClz2Q03Gh/hizOMSDHiFr9LX8Hl32g242lx8gPJOwYb89mpvDBufD7bXogznR20uOpqoYu8kASSL02+An4rm75KGzzF4D701D9H5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AcHiagt5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso20173145e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774051108; x=1774655908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRZfXtq50tFtpSOj16Mr4aRCUSIBwaxmVKm9QNgp0ZY=;
        b=AcHiagt5GtCz6DFUKifIpzv6mUn1UluM38oao2I/oueoFo9nOEsZoe/FLOwunGv5p5
         Y5SVxYPvmH36JI8aY8SbKdDgMVV5mpWfeorNddf3jl1CKSMQFeZP7JUtUIbVFGgjPvzp
         jrBs8YZnsGsQYj3ckXARkUoqSqbiNAFxwHJxU9rjdyIUKIfKk2Hy7h/fKlW6hWVGb2nJ
         70BM4HYDzzjRk1tJSD3gSgT+RfkEkZb69vHo2ED0dUpYV5mpqp8lTVRDdMGBYSFiuaTY
         6YlavJVBl5iYlE21Ftz7Q0M/XVRmUVhkh3xumLl9resC2b/KBU3bP7wHYZJBz/hubK3M
         DinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051108; x=1774655908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRZfXtq50tFtpSOj16Mr4aRCUSIBwaxmVKm9QNgp0ZY=;
        b=D6NS6z8v1DIl0yXfr2XG/KOWmyYIPS2k4d83y5PlCV+5SzxPyS49MkmI/GGlHiN3Cv
         3nZq6HMb5shYXrpnUHNNyLmv86GbG5vG6emqAjpaeHPvspOGTX2SavKgNGx5h+84WbqZ
         jqX8xBLC34WTw+CEbKlzrfUcBdNNiM4OJTmdM5DpueqZPuD/Q/shuGUv7NjXUs2F1++3
         xmAK242/d4NI5N5xpTsVL/KSjmFtV1AyCOjDeNK5j1r3fpaqneRGaDiK6EWd63y2HjHC
         y+QjAnZvr0Y/7NuOFDBDPVzHfuVDQbxppu2RAkOPoe/YM4zMP4sAJcNNPi39Z2qVa3Qf
         dWQA==
X-Gm-Message-State: AOJu0Yz5cAqg+j6UEmzpwWw00WWTD8eWGlhl96quRX0nzFFSHABVyaXK
	CmBBNbKtEpOJXYow7iB2IgYA5JEDl8IHHXJEPYz0+78frzz2bxO3n9w+usMiNyUsi+d5xFHJI8S
	KlgarjFOdJsP0W6CdS/PX4pMimzN4q9W+xe9/Zv1CRUYvA/o1bxLpBJPk87Gr7lWYdR7vDKMTSQ
	CeBll86aZwGZ60Mf00MSahfOks521aM/pP84n7Uy33OWDlAtY=
X-Gm-Gg: ATEYQzx+qlDBSCyv/hJWb0ojqkCFx5rd54LJCQEkDmmoh7TCXfEgpaG7JOzdUgIR7nG
	iloBUfKmnAYKIa38qCL/0YWavEBPJpGEcV7uBUgv/cobOmRi+AulEEBoWGT4iavB1p/YKwS7DDv
	ajBz2Iyxzeig+TmK6Upzc1DwwPkiQjvnCXBWdu7zVdKRFKlbg2lCCaffsRWnF7ns1277aLghPI8
	fVHwN1C44xr8UDgm3D0jVKerFuteFzxJljw77J5o/eo00Lkabw6WqNXI8geQ/+KiFzxCfHvqKlC
	Y21ztAtQNjzSpIQeUirCHXxVPietRANSyskeorX2TsxdoXDnV3eyY5N/QowTqkv0rrO56DDOLm4
	c/56SbVodu1NKp233WazBsEjwUJY1VK00+gzsUGnHPpR18ZtBN4WuI9QhtSJlmaAX6uxJ8AnMNx
	RPDYo9xMcyv/keq7gWBZSySEFM3bB4HyVTM5zM4bPMToBfzERT4qIU07lwHYRmxhXwn51RBKc9B
	pE=
X-Received: by 2002:a05:600c:c167:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-486fedc9a52mr68548345e9.13.1774051108216;
        Fri, 20 Mar 2026 16:58:28 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486fe87c815sm28704635e9.7.2026.03.20.16.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:58:27 -0700 (PDT)
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
Subject: [PATCH v9 5/6] tls: add hardware offload key update support
Date: Fri, 20 Mar 2026 17:57:05 -0600
Message-Id: <20260320235706.636531-6-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260320235706.636531-1-rjethwani@purestorage.com>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-270120-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid]
X-Rspamd-Queue-Id: 3F9102E26FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add TLS KeyUpdate (rekey) support for hardware offload connections.

When tls_dev_add() fails during hardware rekey, the connection
gracefully degrades to software encryption/decryption while
maintaining TLS_HW configuration.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 key update cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h             |  79 ++++--
 include/uapi/linux/snmp.h     |   2 +
 net/tls/tls.h                 |  14 +-
 net/tls/tls_device.c          | 492 +++++++++++++++++++++++++++++-----
 net/tls/tls_device_fallback.c |  24 ++
 net/tls/tls_main.c            |  92 ++++---
 net/tls/tls_proc.c            |   2 +
 net/tls/tls_sw.c              |  28 +-
 8 files changed, 594 insertions(+), 139 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..4855cd7f1747 100644
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
@@ -165,6 +181,11 @@ struct tls_offload_context_tx {
 	void (*sk_destruct)(struct sock *sk);
 	struct work_struct destruct_work;
 	struct tls_context *ctx;
+
+	struct tls_sw_context_tx rekey_sw;	/* SW context for new key */
+	struct cipher_context rekey_tx;		/* IV, rec_seq for new key */
+	union tls_crypto_context rekey_crypto_send; /* Crypto for new key */
+
 	/* The TLS layer reserves room for driver specific state
 	 * Currently the belief is that there is not enough
 	 * driver specific state to justify another layer of indirection
@@ -189,22 +210,21 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
-};
-
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
+	/* Flag for TX HW context deleted during failed rekey.
+	 * Prevents double tls_dev_del in cleanup paths.
+	 */
+	TLS_TX_DEV_CLOSED = 3,
+	/* TX rekey is pending, waiting for old-key data to be ACKed.
+	 * While set, new data uses SW path with new key, HW keeps old key
+	 * for retransmissions.
+	 */
+	TLS_TX_REKEY_PENDING = 4,
+	/* All old-key data has been ACKed, ready to install new key in HW. */
+	TLS_TX_REKEY_READY = 5,
+	/* HW rekey failed, permanently stay in SW encrypt mode.
+	 * Prevents tls_tcp_clean_acked from re-setting TLS_TX_REKEY_READY.
+	 */
+	TLS_TX_REKEY_FAILED = 6,
 };
 
 struct tls_prot_info {
@@ -253,6 +273,18 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	/* TCP sequence number boundary for pending rekey.
+	 * Packets with seq < this use old key, >= use new key.
+	 */
+	u32 rekey_boundary_seq;
+
+	/* TCP sequence number where SW-encrypted region ends */
+	u32 rekey_complete_seq;
+
+	/* Pointers to rekey contexts for SW encryption with new key */
+	struct tls_sw_context_tx *rekey_sw_ctx;
+	struct cipher_context *rekey_cipher_ctx;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
@@ -385,9 +417,21 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 		const struct tls_context *tls_ctx)
 {
+	if (unlikely(tls_ctx->rekey_sw_ctx))
+		return tls_ctx->rekey_sw_ctx;
+
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
+static inline struct cipher_context *tls_tx_cipher_ctx(
+		const struct tls_context *tls_ctx)
+{
+	if (unlikely(tls_ctx->rekey_cipher_ctx))
+		return tls_ctx->rekey_cipher_ctx;
+
+	return (struct cipher_context *)&tls_ctx->tx;
+}
+
 static inline struct tls_offload_context_tx *
 tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 {
@@ -500,6 +544,9 @@ struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
 #ifdef CONFIG_TLS_DEVICE
 void tls_device_sk_destruct(struct sock *sk);
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq);
+struct sk_buff *
+tls_validate_xmit_skb_rekey(struct sock *sk, struct net_device *dev,
+			    struct sk_buff *skb);
 
 static inline bool tls_is_sk_rx_device_offloaded(struct sock *sk)
 {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..39fa48821faa 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -369,6 +369,8 @@ enum
 	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
+	LINUX_MIB_TLSTXREKEYHWFAIL,             /* TlsTxRekeyHwFail */
+	LINUX_MIB_TLSRXREKEYHWFAIL,		/* TlsRxRekeyHwFail */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 56eba13261d4..98f94a610f23 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,6 +157,9 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
+void tls_tx_work_handler(struct work_struct *work);
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
@@ -233,9 +236,11 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk);
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *crypto_info);
 void tls_device_offload_cleanup_rx(struct sock *sk);
 void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq);
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx);
@@ -244,7 +249,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
@@ -252,7 +257,8 @@ tls_set_device_offload(struct sock *sk)
 static inline void tls_device_free_resources_tx(struct sock *sk) {}
 
 static inline int
-tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			  struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cd26873e9063..ab6ef7742121 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -79,7 +79,9 @@ static void tls_device_tx_del_task(struct work_struct *work)
 	netdev = rcu_dereference_protected(ctx->netdev,
 					   !refcount_read(&ctx->refcount));
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
 	dev_put(netdev);
 	ctx->netdev = NULL;
 	tls_device_free_ctx(ctx);
@@ -159,6 +161,221 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
 	offload_ctx->retransmit_hint = NULL;
 }
 
+static bool tls_has_unacked_records(struct tls_offload_context_tx *offload_ctx)
+{
+	struct tls_record_info *info;
+	bool has_unacked = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	list_for_each_entry(info, &offload_ctx->records_list, list) {
+		if (!tls_record_is_start_marker(info)) {
+			has_unacked = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	return has_unacked;
+}
+
+static int tls_device_init_rekey_sw(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_offload_context_tx *offload_ctx,
+				    struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_sw_context_tx *sw_ctx = &offload_ctx->rekey_sw;
+	const struct tls_cipher_desc *cipher_desc;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	memset(sw_ctx, 0, sizeof(*sw_ctx));
+	tls_sw_ctx_tx_init(sk, sw_ctx);
+
+	sw_ctx->aead_send = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
+	if (IS_ERR(sw_ctx->aead_send)) {
+		rc = PTR_ERR(sw_ctx->aead_send);
+		sw_ctx->aead_send = NULL;
+		return rc;
+	}
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	rc = crypto_aead_setkey(sw_ctx->aead_send, key, cipher_desc->key);
+	if (rc)
+		goto free_aead;
+
+	rc = crypto_aead_setauthsize(sw_ctx->aead_send, cipher_desc->tag);
+	if (rc)
+		goto free_aead;
+
+	return 0;
+
+free_aead:
+	crypto_free_aead(sw_ctx->aead_send);
+	sw_ctx->aead_send = NULL;
+	return rc;
+}
+
+static int tls_device_start_rekey(struct sock *sk,
+				  struct tls_context *ctx,
+				  struct tls_offload_context_tx *offload_ctx,
+				  struct tls_crypto_info *new_crypto_info)
+{
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	const struct tls_cipher_desc *cipher_desc;
+	char *key, *iv, *rec_seq, *salt;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	iv = crypto_info_iv(new_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(new_crypto_info, cipher_desc);
+	salt = crypto_info_salt(new_crypto_info, cipher_desc);
+
+	if (rekey_pending || rekey_failed) {
+		rc = crypto_aead_setkey(offload_ctx->rekey_sw.aead_send,
+					key, cipher_desc->key);
+		if (rc)
+			return rc;
+
+		memcpy(offload_ctx->rekey_tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey_tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey_tx.rec_seq, rec_seq,
+		       cipher_desc->rec_seq);
+
+		if (rekey_failed) {
+			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+			clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+		}
+	} else {
+		rc = tls_device_init_rekey_sw(sk, ctx, offload_ctx,
+					      new_crypto_info);
+		if (rc)
+			return rc;
+
+		memcpy(offload_ctx->rekey_tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey_tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey_tx.rec_seq, rec_seq,
+		       cipher_desc->rec_seq);
+
+		WRITE_ONCE(ctx->rekey_complete_seq, 0);
+		WRITE_ONCE(ctx->rekey_boundary_seq, tcp_sk(sk)->write_seq);
+
+		ctx->rekey_sw_ctx = &offload_ctx->rekey_sw;
+		ctx->rekey_cipher_ctx = &offload_ctx->rekey_tx;
+
+		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+
+		/* Ensure rekey context is visible before TX path sees
+		 * new callback
+		 */
+		smp_store_release(&sk->sk_validate_xmit_skb,
+				  tls_validate_xmit_skb_rekey);
+	}
+
+	unsafe_memcpy(&offload_ctx->rekey_crypto_send.info, new_crypto_info,
+		      cipher_desc->crypto_info,
+		      /* checked in do_tls_setsockopt_conf */);
+	memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+	return 0;
+}
+
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	const struct tls_cipher_desc *cipher_desc;
+	struct net_device *netdev;
+	unsigned long flags;
+	__be64 rcd_sn;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(offload_ctx->rekey_crypto_send.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	down_read(&device_offload_lock);
+
+	netdev = rcu_dereference_protected(ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (!netdev) {
+		rc = -ENODEV;
+		goto release_lock;
+	}
+
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
+		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+	}
+
+	memcpy(crypto_info_rec_seq(&offload_ctx->rekey_crypto_send.info, cipher_desc),
+	       offload_ctx->rekey_tx.rec_seq, cipher_desc->rec_seq);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
+					     &offload_ctx->rekey_crypto_send.info,
+					     tcp_sk(sk)->write_seq);
+
+release_lock:
+	up_read(&device_offload_lock);
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	memcpy(&rcd_sn, offload_ctx->rekey_tx.rec_seq, sizeof(rcd_sn));
+	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	memcpy(ctx->tx.iv, offload_ctx->rekey_tx.iv,
+	       cipher_desc->salt + cipher_desc->iv);
+	memcpy(ctx->tx.rec_seq, offload_ctx->rekey_tx.rec_seq,
+	       cipher_desc->rec_seq);
+	unsafe_memcpy(&ctx->crypto_send.info,
+		      &offload_ctx->rekey_crypto_send.info,
+		      cipher_desc->crypto_info,
+		      /* checked during rekey setup */);
+
+	if (rc)
+		goto rekey_fail;
+
+	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+
+	key = crypto_info_key(&offload_ctx->rekey_crypto_send.info, cipher_desc);
+	rc = crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key);
+	if (rc)
+		goto rekey_fail;
+
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+
+	/* following this assignment tls_is_skb_tx_device_offloaded
+	 * will return true and the context might be accessed
+	 * by the netdev's xmit function.
+	 */
+	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+
+	tls_sw_release_resources_tx(sk);
+	ctx->rekey_sw_ctx = NULL;
+	ctx->rekey_cipher_ctx = NULL;
+
+	return 0;
+
+rekey_fail:
+	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYHWFAIL);
+
+	return 0;
+}
+
 static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -187,6 +404,32 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 	}
 
 	ctx->unacked_record_sn += deleted_records;
+
+	/* Track ACKs to determine when HW rekey can complete:
+	 * complete_seq captures write_seq when old-key data is ACKed,
+	 * REKEY_READY is set once all pending data (including any new) is
+	 * ACKed.
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
+	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		u32 boundary_seq = READ_ONCE(tls_ctx->rekey_boundary_seq);
+		u32 complete_seq = READ_ONCE(tls_ctx->rekey_complete_seq);
+
+		if (!before(acked_seq, boundary_seq) && complete_seq == 0) {
+			complete_seq = tcp_sk(sk)->write_seq;
+			WRITE_ONCE(tls_ctx->rekey_complete_seq, complete_seq);
+		}
+
+		if (complete_seq != 0) {
+			u32 current_write_seq = tcp_sk(sk)->write_seq;
+
+			if (before(complete_seq, current_write_seq))
+				WRITE_ONCE(tls_ctx->rekey_complete_seq, current_write_seq);
+			else if (!before(acked_seq, complete_seq))
+				set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
+		}
+	}
+
 	spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
@@ -218,6 +461,9 @@ void tls_device_free_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 
 	tls_free_partial_record(sk, tls_ctx);
+
+	if (unlikely(tls_ctx->rekey_sw_ctx))
+		tls_sw_release_resources_tx(sk);
 }
 
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq)
@@ -589,6 +835,22 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out;
 	}
 
+	/* Complete the rekey if READY is set. This means all old-key
+	 * records have been ACKed and no new data is in flight, so we
+	 * can safely switch from SW to HW offload with the new key.
+	 */
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
+		tls_device_complete_rekey(sk, tls_ctx);
+
+	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
+	 * failed (FAILED).
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
+	    test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		rc = tls_sw_sendmsg_locked(sk, msg, size);
+		goto out;
+	}
+
 	rc = tls_push_data(sk, &msg->msg_iter, size, msg->msg_flags,
 			   record_type);
 
@@ -1068,57 +1330,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
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
@@ -1159,8 +1395,10 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	ctx->priv_ctx_tx = offload_ctx;
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send.info,
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk,
+					     TLS_OFFLOAD_CTX_DIR_TX,
+					     crypto_info,
 					     tcp_sk(sk)->write_seq);
 	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
 				     tcp_sk(sk)->write_seq, rec_seq, rc);
@@ -1175,7 +1413,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1188,18 +1425,112 @@ int tls_set_device_offload(struct sock *sk)
 	ctx->priv_ctx_tx = NULL;
 free_marker_record:
 	kfree(start_marker_record);
+	return rc;
+}
+
+static int tls_set_device_offload_rekey(struct sock *sk,
+					struct tls_context *ctx,
+					struct net_device *netdev,
+					struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool has_unacked = false;
+	int rc;
+
+	if (!rekey_pending)
+		has_unacked = tls_has_unacked_records(offload_ctx);
+
+	down_read(&device_offload_lock);
+
+	rc = tls_device_start_rekey(sk, ctx, offload_ctx, new_crypto_info);
+	if (rc) {
+		up_read(&device_offload_lock);
+		return rc;
+	}
+
+	up_read(&device_offload_lock);
+
+	if (!rekey_pending && !has_unacked &&
+	    ctx->rekey_boundary_seq == tcp_sk(sk)->write_seq)
+		rc = tls_device_complete_rekey(sk, ctx);
+
+	return rc;
+}
+
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
+	struct net_device *netdev;
+	struct tls_context *ctx;
+	int rc;
+
+	ctx = tls_get_ctx(sk);
+
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->tx_conf != TLS_HW)
+		return -EINVAL;
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
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable) {
+		rc = -EINVAL;
+		goto release_netdev;
+	}
+
+	if (new_crypto_info)
+		rc = tls_set_device_offload_rekey(sk, ctx, netdev,
+						  src_crypto_info);
+	else
+		rc = tls_set_device_offload_initial(sk, ctx, netdev,
+						    src_crypto_info,
+						    cipher_desc);
+
 release_netdev:
 	dev_put(netdev);
 	return rc;
 }
 
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *new_crypto_info)
 {
-	struct tls12_crypto_info_aes_gcm_128 *info;
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
 	struct tls_offload_context_rx *context;
 	struct net_device *netdev;
+	char *rec_seq;
 	int rc = 0;
 
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->rx_conf != TLS_HW)
+		return -EINVAL;
+
+	crypto_info = &ctx->crypto_recv.info;
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable)
+		return -EINVAL;
+
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
@@ -1225,29 +1556,50 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto release_lock;
 	}
 
-	context = kzalloc_obj(*context);
-	if (!context) {
-		rc = -ENOMEM;
-		goto release_lock;
+	if (!new_crypto_info) {
+		context = kzalloc_obj(*context);
+		if (!context) {
+			rc = -ENOMEM;
+			goto release_lock;
+		}
+		context->resync_nh_reset = 1;
+		ctx->priv_ctx_rx = context;
 	}
-	context->resync_nh_reset = 1;
 
-	ctx->priv_ctx_rx = context;
-	rc = tls_sw_ctx_init(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
 	if (rc)
 		goto release_ctx;
 
+	if (new_crypto_info && !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
+
 	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_RX,
-					     &ctx->crypto_recv.info,
+					     src_crypto_info,
 					     tcp_sk(sk)->copied_seq);
-	info = (void *)&ctx->crypto_recv.info;
+
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
-				     tcp_sk(sk)->copied_seq, info->rec_seq, rc);
-	if (rc)
-		goto free_sw_resources;
+				     tcp_sk(sk)->copied_seq, rec_seq, rc);
+	if (rc) {
+		if (new_crypto_info) {
+			set_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYHWFAIL);
+		} else {
+			goto free_sw_resources;
+		}
+	} else {
+		if (new_crypto_info) {
+			clear_bit(TLS_RX_DEV_DEGRADED, &ctx->flags);
+			clear_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
+
+		tls_device_attach(ctx, sk, netdev);
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
-	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1256,10 +1608,13 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 
 free_sw_resources:
 	up_read(&device_offload_lock);
-	tls_sw_free_resources_rx(sk);
+	tls_sw_release_resources_rx(sk);
 	down_read(&device_offload_lock);
 release_ctx:
-	ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		kfree(ctx->priv_ctx_rx);
+		ctx->priv_ctx_rx = NULL;
+	}
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
@@ -1278,8 +1633,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1319,7 +1675,10 @@ static int tls_device_down(struct net_device *netdev)
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (!test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) &&
+		    !test_bit(TLS_TX_REKEY_FAILED, &ctx->flags))
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
@@ -1336,13 +1695,18 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (ctx->tx_conf == TLS_HW &&
+		    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
+			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+		}
 		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 99d5590d20b0..40a0ddde2fce 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -438,6 +438,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
 	return tls_sw_fallback(sk, skb);
 }
 
+struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
+					    struct net_device *dev,
+					    struct sk_buff *skb)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
+	u32 boundary_seq;
+
+	if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
+		return skb;
+
+	/* If this packet is at or after the rekey boundary, it's already
+	 * SW-encrypted with the new key, pass through unchanged
+	 */
+	boundary_seq = READ_ONCE(tls_ctx->rekey_boundary_seq);
+	if (!before(tcp_seq, boundary_seq))
+		return skb;
+
+	/* Packet before boundary means retransmit of old data,
+	 * use SW fallback with the old key
+	 */
+	return tls_sw_fallback(sk, skb);
+}
+
 struct sk_buff *tls_encrypt_skb(struct sk_buff *skb)
 {
 	return tls_sw_fallback(skb->sk, skb);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd04857fa0ab..ab701f166b57 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -371,6 +371,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 
 	if (ctx->tx_conf == TLS_SW)
 		tls_sw_cancel_work_tx(ctx);
+	else if (ctx->tx_conf == TLS_HW && ctx->rekey_sw_ctx)
+		tls_sw_cancel_work_tx(ctx);
 
 	lock_sock(sk);
 	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
@@ -711,64 +713,68 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		if (update && ctx->tx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		if (!update) {
-			rc = tls_set_device_offload(sk);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 1, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->tx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			rc = tls_set_sw_offload(sk, 1,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
 	} else {
-		if (update && ctx->rx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		if (!update) {
-			rc = tls_set_device_offload_rx(sk, ctx);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload_rx(sk, ctx,
+					       update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
-				tls_sw_strparser_arm(sk, ctx);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 0, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->rx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
-			tls_sw_strparser_arm(sk, ctx);
+			rc = tls_set_sw_offload(sk, 0,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
+		if (!update)
+			tls_sw_strparser_arm(sk, ctx);
 	}
 
-out:
 	if (tx)
 		ctx->tx_conf = conf;
 	else
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 4012c4372d4c..5599af306aab 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -27,6 +27,8 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
+	SNMP_MIB_ITEM("TlsTxRekeyHwFail", LINUX_MIB_TLSTXREKEYHWFAIL),
+	SNMP_MIB_ITEM("TlsRxRekeyHwFail", LINUX_MIB_TLSRXREKEYHWFAIL),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 424e0a11bcf4..4a4cf838bd0d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -554,11 +554,11 @@ static int tls_do_encryption(struct sock *sk,
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
@@ -599,7 +599,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Unhook the record from context if encryption is not failure */
 	ctx->open_rec = NULL;
-	tls_advance_record_sn(sk, prot, &tls_ctx->tx);
+	tls_advance_record_sn(sk, prot, tls_tx_cipher_ctx(tls_ctx));
 	return rc;
 }
 
@@ -806,7 +806,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
 	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
@@ -1022,8 +1022,7 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 	return 0;
 }
 
-static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-				 size_t size)
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2621,7 +2620,7 @@ void tls_sw_free_resources_rx(struct sock *sk)
 }
 
 /* The work handler to transmitt the encrypted records in tx_list */
-static void tx_work_handler(struct work_struct *work)
+void tls_tx_work_handler(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct tx_work *tx_work = container_of(delayed_work,
@@ -2654,6 +2653,15 @@ static void tx_work_handler(struct work_struct *work)
 	}
 }
 
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
+{
+	crypto_init_wait(&sw_ctx->async_wait);
+	atomic_set(&sw_ctx->encrypt_pending, 1);
+	INIT_LIST_HEAD(&sw_ctx->tx_list);
+	INIT_DELAYED_WORK(&sw_ctx->tx_work.work, tls_tx_work_handler);
+	sw_ctx->tx_work.sk = sk;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
@@ -2705,11 +2713,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
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
-- 
2.25.1


