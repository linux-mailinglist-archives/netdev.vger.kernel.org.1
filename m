Return-Path: <netdev+bounces-288462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L9NDICUB2pU9AIAu9opvQ
	(envelope-from <netdev+bounces-288462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:47:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8465586D0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D26AC3030B9A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E929405C43;
	Fri, 15 May 2026 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="a+6z+LlD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9F405C34
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880543; cv=none; b=au+4rqyIdzYqPYbkf/Jj3p4t/2DqEZ0g1NMm+SE4SEEx9O13uo0lhihxx8KH9oUIDBcVMK9864/QyCQl76i7fCBOvkUDVbNlSIr76cJ+J+/Sgm+g0FcLPL3P+N966XNj9ChrrG8h1HEO/8H0RXXd8R2xEYQcSFEO2Mv//2vmJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880543; c=relaxed/simple;
	bh=dGa0Z+kPp73wWy52B+Zh3YregWCyvQn709F0ZQDQl4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsLF8GNpz8obOojDEY3J6TIQSdA2t0YzJY8Tgpy6OkVLqctOXbW5OUArhTfez8Nm9H6TQN/0za3KaG221A+A19+LtYmtkrB5HU8+Mwbx25EtMkmzKZI3PD3pasD2l4FJeJJ+xgwXOkpzQTNacrUvfxoAdPstNcC56IGWZNSAhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=a+6z+LlD; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-439c00ed7e0so322558fac.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880541; x=1779485341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlRQqr0/v4e53arkzP/wTDqkRJdMqlAa2hoOLpatXRs=;
        b=a+6z+LlD1QznYG8Pcu+WNRQQrexidrOKWoQtAB398MvGZKrUmmAQ1sYLtU8z37Ah+D
         +YqVireW1kH6b1lQEkG4DYaeSVVtK9NVjHWQFa8oc5RDOWhYjeVuzWFRd5mIdR9nVoQY
         C0+3SQ93RSieBoIrFDA5qp0S64hMsKx5az8DnTmEPm/zlFZyaZivDvSJWwZI+el6wnUW
         7b3QbsGmVkZfmFzrvI/3EpxIR+Yxqk0qJBOlbwR4XhjgMT2MuBfMJTnPNjFwwX1yiEgO
         qL5DOgdlLdSr4/49piqblaSCPowr1ILFXuQP2IiY7l5CqDKxu5ne3Ejan6DIWZjXXgPU
         SjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880541; x=1779485341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlRQqr0/v4e53arkzP/wTDqkRJdMqlAa2hoOLpatXRs=;
        b=eFvY6WV6MTL1uUBt9SIHfjN59QsK9tr+WyCOFHjuZsu/ISvpeZqVV0SaKIh/4tyBB2
         GeATwF+iN3RyV9nasF3Z1t41eb8S4d3qxaB7ZjZ0fb3O2HlXbZnFSeoH5QqIdAf7Ohgp
         Oxv5iahxFLlJQ2PZmRPrMC1sww/HbEoqBlGJMF3tbQ4uapsQADIv9Te63vlWobzAh2HC
         rQWIV/tCzRmL1lfXNH1PnbdwdWCSpNcEx3luBgMxx1kAT65yFOwYuOLXJNhuXolAWHKZ
         1I0W5dP+S0w3HtyVlsE56lllBID75mnUPwXBPA4JFjNxviqoJkSvTEbxekrn04t0vv1K
         jSbg==
X-Gm-Message-State: AOJu0YzkOjZrXLkmeK11N8Yf/Hyikz2w7DZMeL7vEHr41YoHitOFnv9F
	tZhXogblhylyEtmaBUjyAYyWLDEp6y1tOy1GffLS7eqT7+y/l6wKquDdh5tEbBAzHGGMC7EITEh
	/0WiNO/pTguKB7B1w3R+uEKvvZc3e6HAxn9lg282pv2GT22nTJOldly3LlcpUPa89IhernD7XJq
	mVcVzlH1Amti+XxryaHj/PHfrKBgvoOWAa4fUPI0jsLERxIII=
X-Gm-Gg: Acq92OGUi3rVKB0QohU1YOcR5ynPeuLAD9q4vutViNlmye8mK54zwSzeniU4wl7tZ45
	GdfapJrjx225rx4Z/ASvFtu+BeBu4nNfzADT3kNQATawlbQp/uGjfJuLU4fnQpc0naXu5uzrZaf
	7UZki2QltQ6OfUE/+sRh/ec2aYr5ulA7NRbCdJB4QotKXSJN/ndBESga6Dxd5n5YYKmG2V1ykcR
	5xJNwxEoeToBVevZFka4FZJ2bxdwMXIU3LPNmFyR+khWdQ671UQsowWUSF8VFr1LiOZ4lhFRewR
	dHYj7aM3UCkYLTVX/+hUMp2vZqwHjGBchkET8gVdurYI4RLgTNPSICyiDcdiv2TIItMVvKlAcZB
	flBbxnzmUAIhhlNwxuWW8VTX/dquo6sCIECH6i6NrHEm06B94jww5V4DvJvKrdxt4+nv+bnoQXy
	ctp4759UgCrC041h6TQXlKNvJzoAaGtI9q234XKBzgoyrKdAPTzGSpbCb3Jp3b/oFloQaJ
X-Received: by 2002:a05:6820:1625:b0:694:9d3d:e040 with SMTP id 006d021491bc7-69c94367940mr3596549eaf.31.1778880540367;
        Fri, 15 May 2026 14:29:00 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:29:00 -0700 (PDT)
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
Subject: [PATCH v14 6/9] tls: device: add TX KeyUpdate support
Date: Fri, 15 May 2026 15:27:12 -0600
Message-Id: <20260515212715.3151307-7-rjethwani@purestorage.com>
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
X-Rspamd-Queue-Id: 3C8465586D0
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
	TAGGED_FROM(0.00)[bounces-288462-lists,netdev=lfdr.de];
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

The NIC key cannot be replaced while HW-offloaded records
are still unacked. tls_device_start_rekey() installs a temporary SW
context with the new key and redirects sendmsg through
tls_sw_sendmsg_locked. If no records are pending,
tls_device_complete_rekey() runs inline during setsockopt; otherwise
tls_tcp_clean_acked sets REKEY_READY once all old-key records are ACKed
and the next sendmsg completes the rekey, flushing SW records and
reinstalling HW offload at the current write_seq. A KeyUpdate
arriving while one is pending re-keys the SW AEAD in place; if the
HW reinstall fails the socket stays in SW mode (REKEY_FAILED).

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 TX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h             |  42 ++++
 include/uapi/linux/snmp.h     |   2 +
 net/tls/tls.h                 |   7 +-
 net/tls/tls_device.c          | 352 +++++++++++++++++++++++++++++++++-
 net/tls/tls_device_fallback.c |  24 +++
 net/tls/tls_main.c            |  42 ++--
 net/tls/tls_proc.c            |   2 +
 net/tls/tls_sw.c              |  20 +-
 8 files changed, 457 insertions(+), 34 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 2512a3799b21..c1085873ee01 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -181,6 +181,13 @@ struct tls_offload_context_tx {
 	void (*sk_destruct)(struct sock *sk);
 	struct work_struct destruct_work;
 	struct tls_context *ctx;
+
+	struct {
+		struct tls_sw_context_tx sw;	/* SW context for new key */
+		struct cipher_context tx;	/* IV, rec_seq for new key */
+		union tls_crypto_context crypto_send; /* Crypto for new key */
+	} rekey;
+
 	/* The TLS layer reserves room for driver specific state
 	 * Currently the belief is that there is not enough
 	 * driver specific state to justify another layer of indirection
@@ -205,6 +212,21 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
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
@@ -253,6 +275,17 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	struct {
+		/* TCP sequence number boundary for pending rekey.
+		 * Packets with seq < this use old key, >= use new key.
+		 */
+		u32 boundary_seq;
+
+		/* Pointers to rekey contexts for SW encryption with new key */
+		struct tls_sw_context_tx *sw_ctx;
+		struct cipher_context *cipher_ctx;
+	} rekey;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
@@ -385,12 +418,18 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 		const struct tls_context *tls_ctx)
 {
+	if (unlikely(tls_ctx->rekey.sw_ctx))
+		return tls_ctx->rekey.sw_ctx;
+
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
 static inline struct cipher_context *tls_tx_cipher_ctx(
 		const struct tls_context *tls_ctx)
 {
+	if (unlikely(tls_ctx->rekey.cipher_ctx))
+		return tls_ctx->rekey.cipher_ctx;
+
 	return (struct cipher_context *)&tls_ctx->tx;
 }
 
@@ -506,6 +545,9 @@ struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
 #ifdef CONFIG_TLS_DEVICE
 void tls_device_sk_destruct(struct sock *sk);
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq);
+struct sk_buff *
+tls_validate_xmit_skb_rekey(struct sock *sk, struct net_device *dev,
+			    struct sk_buff *skb);
 
 static inline bool tls_is_sk_rx_device_offloaded(struct sock *sk)
 {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..2a8930d67ba1 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -369,6 +369,8 @@ enum
 	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
+	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index cd992fc161e5..52b3a771c0ce 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,7 +157,9 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
@@ -235,7 +237,8 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk);
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
 int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
 void tls_device_offload_cleanup_rx(struct sock *sk);
@@ -246,7 +249,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 7a98d2f6cbd3..c435b3450872 100644
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
@@ -161,10 +163,14 @@ static void tls_device_commit_start_marker(struct sock *sk,
 					struct tls_offload_context_tx *offload_ctx,
 					struct tls_record_info *start_marker_record)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
 	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
 	start_marker_record->len = 0;
 	start_marker_record->num_frags = 0;
 	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
 
 	/* TLS offload is greatly simplified if we don't send
 	 * SKBs where only part of the payload needs to be encrypted.
@@ -194,6 +200,24 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
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
 static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -222,6 +246,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 	}
 
 	ctx->unacked_record_sn += deleted_records;
+
+	/* Once all old-key HW records are ACKed, set REKEY_READY to
+	 * let sendmsg know it can finish the rekey and switch back
+	 * to HW offload.
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
+	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
+
+		if (!before(acked_seq, boundary_seq))
+			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
+	}
+
 	spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
@@ -253,6 +290,14 @@ void tls_device_free_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 
 	tls_free_partial_record(sk, tls_ctx);
+
+	if (unlikely(tls_ctx->rekey.sw_ctx))
+		tls_sw_release_resources_tx(sk);
+
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	}
 }
 
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq)
@@ -462,6 +507,9 @@ static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
 	return 0;
 }
 
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred);
+
 static int tls_push_data(struct sock *sk,
 			 struct iov_iter *iter,
 			 size_t size, int flags,
@@ -624,6 +672,19 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out;
 	}
 
+	/* Old-key records all ACKed; switch back to HW. */
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
+		tls_device_complete_rekey(sk, tls_ctx, true);
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
 
@@ -1103,6 +1164,260 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
+static int tls_device_init_rekey_sw(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_offload_context_tx *offload_ctx,
+				    struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_sw_context_tx *sw_ctx = &offload_ctx->rekey.sw;
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
+		rc = crypto_aead_setkey(offload_ctx->rekey.sw.aead_send,
+					key, cipher_desc->key);
+		if (rc)
+			return rc;
+
+		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
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
+		memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
+		memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
+		       cipher_desc->iv);
+		memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
+		       cipher_desc->rec_seq);
+
+		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
+
+		/* Prevent a partial record straddling the SW/HW boundary. */
+		tcp_write_collapse_fence(sk);
+
+		ctx->rekey.sw_ctx = &offload_ctx->rekey.sw;
+		ctx->rekey.cipher_ctx = &offload_ctx->rekey.tx;
+
+		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+
+		/* Switch to rekey validator; new sends won't use HW offload */
+		smp_store_release(&sk->sk_validate_xmit_skb,
+				  tls_validate_xmit_skb_rekey);
+	}
+
+	unsafe_memcpy(&offload_ctx->rekey.crypto_send.info, new_crypto_info,
+		      cipher_desc->crypto_info,
+		      /* checked in do_tls_setsockopt_conf */);
+	memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+	return 0;
+}
+
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	struct tls_record_info *start_marker_record;
+	const struct tls_cipher_desc *cipher_desc;
+	struct net_device *netdev;
+	unsigned long flags;
+	__be64 rcd_sn;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(offload_ctx->rekey.crypto_send.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = tls_sw_drain_tx(sk, ctx);
+	if (rc)
+		return rc;
+
+	start_marker_record = kmalloc_obj(*start_marker_record);
+	if (!start_marker_record)
+		return -ENOMEM;
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
+	memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, cipher_desc),
+	       offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
+
+	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
+				   tcp_sk(sk)->write_seq);
+
+release_lock:
+	up_read(&device_offload_lock);
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
+	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
+	       cipher_desc->salt + cipher_desc->iv);
+	memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
+	       cipher_desc->rec_seq);
+	unsafe_memcpy(&ctx->crypto_send.info,
+		      &offload_ctx->rekey.crypto_send.info,
+		      cipher_desc->crypto_info,
+		      /* checked during rekey setup */);
+
+	if (rc)
+		goto rekey_fail;
+
+	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+
+	key = crypto_info_key(&offload_ctx->rekey.crypto_send.info, cipher_desc);
+	rc = crypto_aead_setkey(offload_ctx->aead_send, key, cipher_desc->key);
+	if (rc)
+		goto rekey_fail;
+
+	/* Start marker: the NIC passes through everything before
+	 * write_seq unencrypted (already SW-encrypted during rekey),
+	 * same as during initial offload setup.
+	 */
+	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
+
+	/* PENDING before READY: prevents clean_acked from
+	 * re-setting REKEY_READY after we clear it.
+	 */
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	smp_mb__after_atomic();
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+
+	/* Switch back to HW offload validator */
+	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+
+	crypto_free_aead(tls_sw_ctx_tx(ctx)->aead_send);
+	ctx->rekey.sw_ctx = NULL;
+	ctx->rekey.cipher_ctx = NULL;
+
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+	return 0;
+
+rekey_fail:
+	kfree(start_marker_record);
+	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
+
+	return 0;
+}
+
+static int tls_set_device_offload_rekey(struct sock *sk,
+					struct tls_context *ctx,
+					struct net_device *netdev,
+					struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	bool defer = true;
+	int rc;
+
+	if (!rekey_pending && !rekey_failed)
+		defer = tls_has_unacked_records(offload_ctx);
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
+	if (defer) {
+		if (!rekey_pending)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRESS);
+		else
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+		return 0;
+	}
+
+	return tls_device_complete_rekey(sk, ctx, false);
+}
+
 static int tls_set_device_offload_initial(struct sock *sk,
 					  struct tls_context *ctx,
 					  struct net_device *netdev,
@@ -1187,18 +1502,23 @@ static int tls_set_device_offload_initial(struct sock *sk,
 	return rc;
 }
 
-int tls_set_device_offload(struct sock *sk)
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *new_crypto_info)
 {
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
 	struct net_device *netdev;
 	struct tls_context *ctx;
 	int rc;
 
 	ctx = tls_get_ctx(sk);
 
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->tx_conf != TLS_HW)
+		return -EINVAL;
 
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
@@ -1212,14 +1532,20 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
 	if (!cipher_desc || !cipher_desc->offloadable) {
 		rc = -EINVAL;
 		goto release_netdev;
 	}
 
-	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
-					    cipher_desc);
+	if (new_crypto_info)
+		rc = tls_set_device_offload_rekey(sk, ctx, netdev,
+						  src_crypto_info);
+	else
+		rc = tls_set_device_offload_initial(sk, ctx, netdev,
+						    src_crypto_info,
+						    cipher_desc);
 
 release_netdev:
 	dev_put(netdev);
@@ -1352,7 +1678,10 @@ static int tls_device_down(struct net_device *netdev)
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
@@ -1369,9 +1698,12 @@ static int tls_device_down(struct net_device *netdev)
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
 		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 1110f7ac6bcb..64ac4ef4012b 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
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
+	boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
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
index fd04857fa0ab..2548ad2b2219 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -371,6 +371,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 
 	if (ctx->tx_conf == TLS_SW)
 		tls_sw_cancel_work_tx(ctx);
+	else if (ctx->tx_conf == TLS_HW && ctx->rekey.sw_ctx)
+		tls_sw_cancel_work_tx(ctx);
 
 	lock_sock(sk);
 	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
@@ -711,32 +713,32 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
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
+			if (!update) {
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
 		if (update && ctx->rx_conf == TLS_HW) {
 			rc = -EOPNOTSUPP;
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 4012c4372d4c..363dc7bfccdd 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -27,6 +27,8 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
+	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 434d68cbbd20..dc05fb96c0cd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1043,8 +1043,7 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 	return 0;
 }
 
-static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-				 size_t size)
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2686,6 +2685,23 @@ void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
 	sw_ctx->tx_work.sk = sk;
 }
 
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx)
+{
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	int rc;
+
+	if (tls_is_pending_open_record(ctx))
+		tls_sw_push_pending_record(sk, 0);
+	tls_encrypt_async_wait(sw_ctx);
+	rc = tls_tx_records(sk, -1);
+	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
+	    tls_is_pending_open_record(ctx))
+		return rc < 0 ? rc : -EAGAIN;
+
+	cancel_delayed_work_sync(&sw_ctx->tx_work.work);
+	return 0;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
-- 
2.25.1


