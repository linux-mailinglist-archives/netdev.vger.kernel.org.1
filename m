Return-Path: <netdev+bounces-282465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MPgDQBK8mnNpQEAu9opvQ
	(envelope-from <netdev+bounces-282465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:12:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593E498D33
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58C5630089A7
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB741324C;
	Wed, 29 Apr 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TO2z9Z92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779831BCAE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486329; cv=none; b=ICntuaJcA1ePHX64cVFRPCUjcAKVCpc/qtsiOzIIBPg40zzAjhsXcfRoWgIoT2hwDWAORL2eicRyIxxaU9FWqJ8P+T1KcuhQB5yY6eZQsJVo6iM85xsJtsDAV37vLjfp5h4IeruHJ5ioQV+40KYbPrA2SPALf0Zy+16Gk5m2reM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486329; c=relaxed/simple;
	bh=KOiK92HfoTjMzOeQbpk17lAQ6hFmKXnRErGIovtQnp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpkasJiXz5B3aIijalMXJqSdHP7jE3xP0ype3HpFwyP6RHEQyc6kmiy+v7pcHk7l3Vr1pQ0Th2z88tEx3ZDRqgNPa8APFdynrxH6IbViT2vxjOZYFXWF65tZgs7MdUyCr1RcBByH+kLULO1ATkvNu4mdlBs6U3nh8SrXp9HbbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TO2z9Z92; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so386645e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486324; x=1778091124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/ZmappDFdXWrA44N89p9cpPfcK/TGqgCEpqUhIMhXs=;
        b=TO2z9Z92q+QFZJUuclTyn+k1MozT0a1bZiWd4NdJ3oG6zpjBmCh3cSRx9uikWbpVuR
         tqXOqqMvetVT1uNGwoapTm3R2Z4DdptWxI4bEVjCsTb7Us5sCvae0cul9eBFJL8ZoxFk
         jMadqgt4LWn14h+sC/8lQW7ZZ3fY5vWzwQY+KxT8BLxvvhltBN62WHOCf/3LWvUuX6iS
         wdnvSsEZ5pSAQO3VeHqu65Ms3RQ58QBYNhCoKj/8ifkdW01RCaNdpwcG9sQOeDPO2qPG
         0OC8E6z4Z0MJtVwgz7lYsIzvQCP+L3x7NZHByH0giZAe7B5/b2iB4P6eZ6mAWxV1TLzG
         wUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486324; x=1778091124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/ZmappDFdXWrA44N89p9cpPfcK/TGqgCEpqUhIMhXs=;
        b=nUO3Lf047Z3LY8vSuIuyRHFesxH8NVqtX5w5e1QEhbbSk5bxsbKlHr4OdratL84hWc
         D89rFXpXfEtJOGDhzC9fnRXzR1q/9/I4T23+UGRlsNgUMMvNuDoa4TDtN0rL078fwN0s
         k/dUo3v2sqTP6einR7bQ/M7HCmzCnv+5/9mwgscOZH8DCqdd/OoemDOJC711hF1FA6mR
         YhlcImq9G67lsFj15pi+Gz/nIvsblqVp8QGmwDj3o45CoBKhsCx4OVEMqlGZ7rnncUg3
         ia62AAyHBVqbMKNiuEYawnAxrpwhYgVaOhuZWfmzkOcNLIcu7IfPMxtFceVs4NyflnT6
         1pWg==
X-Gm-Message-State: AOJu0Yz5Kol1BwFsocFJOlhLpWWBL/dkdTAZDfdIx9Nx0nZeIm2gEtuR
	Le7gLVFjPW/kpTO8HuglonKSw8JINTsxvRX3xUXOp7V/BJ8u2xbwRFlo8RXRlHYFY7CtnxtJVav
	qWtJO5RtARPOEjnONqQBxHvK9gPp5gmiue0E7esV7mNauE8vla2wtHoa7bA+mXmLfz8hae4N4e3
	wVqAB6YERX/K4hJx+GmUMXIWng5EtHYwANHjDuT1LeN4RE4QY=
X-Gm-Gg: AeBDiesKpI0UdzF6DvaQ66engXqJz4yyZP1iHaHZfWRL2y916C5N1Fl01t5Chyvr1CY
	El+kgmyMxUVwpVst0lFk3YwCKWirPJhrcu8F+w1Z5Kb5AW0VLQPP11vOsfjhvPf+6MVejUmXEux
	syiUOcPrmA00qAz1CWBOzgyDDC7hOSne5ewLLnPTw9Gzp+FY7iUq4tznXQdbHhJmS1BkMj55b6w
	yrgOL84F0yMyQMI4+P0PSBR6yXwtOySLOmqKzek7egFB84xDrIWU07yqKJDjPCLoA8MqddfB0xg
	M0tAw7gHCTtbvcti8DQekMrSLdBw33b+LAwLY2t9udAIcfOECqCedLQYg4Laq/qTkuWSzrDELb5
	ALJAmfKvHp2FX6peJ6f3XwnbGaSNrLjkOwD2vmJ25fl1mZmCL3N8Pe4BjVaI6r/ED0edMsylfsU
	2us9LkMnAbvD/v0vrqZ/nE8Pq+FTuGD4WtCcGMs4Id7aineRYRqw9cD1BUkl1NVeZ+SUQ=
X-Received: by 2002:a05:600c:a013:b0:48a:563c:c8e0 with SMTP id 5b1f17b1804b1-48a77ad5a89mr142338405e9.1.1777486323795;
        Wed, 29 Apr 2026 11:12:03 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:12:03 -0700 (PDT)
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
Subject: [PATCH v13 5/6] tls: add hardware offload key update support
Date: Wed, 29 Apr 2026 12:10:15 -0600
Message-Id: <20260429181016.3164935-6-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429181016.3164935-1-rjethwani@purestorage.com>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1593E498D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282465-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]

On TX, the NIC key cannot be replaced while HW-offloaded records
are still unacked. tls_dev_start_rekey() installs a temporary SW
context with the new key and redirects sendmsg through
tls_sw_sendmsg_locked. If no records are pending,
tls_dev_complete_rekey() runs inline during setsockopt; otherwise
clean_acked sets REKEY_READY once all old-key records are ACKed
and the next sendmsg completes the rekey, flushing SW records and
reinstalling HW offload at the current write_seq. A KeyUpdate
arriving while one is pending re-keys the SW AEAD in place; if the
HW reinstall fails the socket stays in SW mode (REKEY_FAILED).

On RX, the NIC may have already decrypted in-flight records with
the old key before the peer's KeyUpdate is parsed, so the old
AEAD, IV and rec_seq are retained on tls_offload_context_rx.
tls_check_pending_rekey() invokes tls_device_rx_del_key() to drop
the NIC key; otherwise post-KeyUpdate records (carrying new-key
wire encryption) would be XOR'd with the retired key.
tls_device_decrypted() classifies records by old_nic_boundary:

  - after the boundary: new-key record; drop the old key.
  - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
  - before, (partially) decrypted: reencrypt with the old key so SW
    AEAD can decrypt with the new key.

For mixed records skb->decrypted flags can be wrong (NIC clears
them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
those flags, decrements old_rec_seq to reuse the nonce, and
retries once (gated by old_key_reencrypted).

The new key's tls_dev_add is deferred until the old key is fully
consumed: tls_set_device_offload_rx() sets dev_add_pending while
old_aead_recv is retained, and tls_device_deferred_dev_add()
installs the new key once copied_seq crosses old_nic_boundary.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 TX and RX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h             |  84 +++-
 include/uapi/linux/snmp.h     |   2 +
 net/tls/tls.h                 |  29 +-
 net/tls/tls_device.c          | 753 +++++++++++++++++++++++++++++++---
 net/tls/tls_device_fallback.c |  24 ++
 net/tls/tls_main.c            |  92 +++--
 net/tls/tls_proc.c            |   2 +
 net/tls/tls_sw.c              |  76 +++-
 net/tls/trace.h               |  79 ++++
 9 files changed, 992 insertions(+), 149 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ebd2550280ae..6891aa6b484c 100644
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
@@ -253,6 +273,15 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	/* TCP sequence number boundary for pending rekey.
+	 * Packets with seq < this use old key, >= use new key.
+	 */
+	u32 rekey_boundary_seq;
+
+	/* Pointers to rekey contexts for SW encryption with new key */
+	struct tls_sw_context_tx *rekey_sw_ctx;
+	struct cipher_context *rekey_cipher_ctx;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
@@ -311,6 +340,14 @@ struct tls_offload_context_rx {
 	u8 resync_nh_reset:1;
 	/* CORE_NEXT_HINT-only member, but use the hole here */
 	u8 resync_nh_do_now:1;
+	/* retry reencrypt of mixed record during rekey */
+	u8 old_key_reencrypted:1;
+	/* tls_dev_add deferred until old key is freed */
+	u8 dev_add_pending:1;
+	struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
+	char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
+	char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
+	u32 old_nic_boundary; /* TCP seq: NIC switched to next key */
 	union {
 		/* TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ */
 		struct {
@@ -385,9 +422,21 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
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
@@ -500,6 +549,9 @@ struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
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
index a65cf9bab190..03d558e80f9a 100644
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
@@ -176,6 +179,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_device_splice_eof(struct socket *sock);
 int tls_tx_records(struct sock *sk, int flags);
+int tls_sw_push_pending_record(struct sock *sk, int flags);
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx);
 
 void tls_sw_write_space(struct sock *sk, struct tls_context *ctx);
 void tls_device_write_space(struct sock *sk, struct tls_context *ctx);
@@ -233,10 +238,13 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
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
+void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx);
 void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq);
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx);
 #else
@@ -244,7 +252,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
@@ -252,13 +260,16 @@ tls_set_device_offload(struct sock *sk)
 static inline void tls_device_free_resources_tx(struct sock *sk) {}
 
 static inline int
-tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			  struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline void tls_device_offload_cleanup_rx(struct sock *sk) {}
 static inline void
+tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx) {}
+static inline void
 tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq) {}
 
 static inline int
@@ -298,6 +309,16 @@ static inline bool tls_bigint_increment(unsigned char *seq, int len)
 	return (i == -1);
 }
 
+static inline void tls_bigint_decrement(unsigned char *seq, int len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		if (seq[i]-- != 0)
+			break;
+	}
+}
+
 static inline void tls_bigint_subtract(unsigned char *seq, int  n)
 {
 	u64 rcd_sn;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cd26873e9063..51f1cc783336 100644
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
@@ -159,6 +161,262 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
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
+		WRITE_ONCE(ctx->rekey_boundary_seq, tcp_sk(sk)->write_seq);
+
+		/* Prevent a partial record straddling the SW/HW boundary. */
+		tcp_write_collapse_fence(sk);
+
+		ctx->rekey_sw_ctx = &offload_ctx->rekey_sw;
+		ctx->rekey_cipher_ctx = &offload_ctx->rekey_tx;
+
+		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+
+		/* Switch to rekey validator; new sends won't use HW offload */
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
+	struct tls_record_info *start_marker_record;
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
+	/* Flush all pending SW data before switching back to HW:
+	 * 1. Close any open_rec left by MSG_MORE and encrypt it.
+	 * 2. Wait for async crypto completions.
+	 * 3. Push all ready records into TCP.
+	 * If the send buffer is full, bail out and retry next sendmsg.
+	 */
+	if (tls_is_pending_open_record(ctx))
+		tls_sw_push_pending_record(sk, 0);
+	tls_encrypt_async_wait(tls_sw_ctx_tx(ctx));
+	rc = tls_tx_records(sk, -1);
+	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
+	    tls_is_pending_open_record(ctx))
+		return rc < 0 ? rc : -EAGAIN;
+
+	cancel_delayed_work_sync(&offload_ctx->rekey_sw.tx_work.work);
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
+	memcpy(crypto_info_rec_seq(&offload_ctx->rekey_crypto_send.info, cipher_desc),
+	       offload_ctx->rekey_tx.rec_seq, cipher_desc->rec_seq);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
+					     &offload_ctx->rekey_crypto_send.info,
+					     tcp_sk(sk)->write_seq);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
+				     tcp_sk(sk)->write_seq,
+				     offload_ctx->rekey_tx.rec_seq, rc);
+
+release_lock:
+	up_read(&device_offload_lock);
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	memcpy(&rcd_sn, offload_ctx->rekey_tx.rec_seq, sizeof(rcd_sn));
+	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
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
+	/* Start marker: the NIC passes through everything before
+	 * write_seq unencrypted (already SW-encrypted during rekey),
+	 * same as during initial offload setup.
+	 */
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
+	start_marker_record->len = 0;
+	start_marker_record->num_frags = 0;
+	list_add_tail_rcu(&start_marker_record->list,
+			  &offload_ctx->records_list);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	/* Prevent a partial record straddling the SW/HW boundary. */
+	tcp_write_collapse_fence(sk);
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
+	ctx->rekey_sw_ctx = NULL;
+	ctx->rekey_cipher_ctx = NULL;
+
+	return 0;
+
+rekey_fail:
+	kfree(start_marker_record);
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
@@ -187,6 +445,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 	}
 
 	ctx->unacked_record_sn += deleted_records;
+
+	/* Once all old-key HW records are ACKed, set REKEY_READY to
+	 * let sendmsg know it can finish the rekey and switch back
+	 * to HW offload.
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
+	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		u32 boundary_seq = READ_ONCE(tls_ctx->rekey_boundary_seq);
+
+		if (!before(acked_seq, boundary_seq))
+			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
+	}
+
 	spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
@@ -218,6 +489,9 @@ void tls_device_free_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 
 	tls_free_partial_record(sk, tls_ctx);
+
+	if (unlikely(tls_ctx->rekey_sw_ctx))
+		tls_sw_release_resources_tx(sk);
 }
 
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq)
@@ -589,6 +863,19 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out;
 	}
 
+	/* Old-key records all ACKed; switch back to HW. */
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
 
@@ -791,6 +1078,8 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		return;
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
 		return;
+	if (unlikely(test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags)))
+		return;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -980,13 +1269,144 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	return err;
 }
 
+/*
+ * temporarily swap in the old key, run
+ * tls_device_reencrypt(), then restore the current key.
+ */
+static int tls_old_key_reencrypt(struct sock *sk,
+				 struct tls_offload_context_rx *ctx,
+				 struct tls_sw_context_rx *sw_ctx,
+				 struct tls_context *tls_ctx)
+{
+	struct crypto_aead *saved_aead = sw_ctx->aead_recv;
+	char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
+	int ret;
+
+	memcpy(saved_iv, tls_ctx->rx.iv, sizeof(saved_iv));
+	memcpy(saved_rec_seq, tls_ctx->rx.rec_seq, sizeof(saved_rec_seq));
+
+	sw_ctx->aead_recv = ctx->old_aead_recv;
+	memcpy(tls_ctx->rx.iv, ctx->old_iv, sizeof(ctx->old_iv));
+	memcpy(tls_ctx->rx.rec_seq, ctx->old_rec_seq,
+	       sizeof(ctx->old_rec_seq));
+
+	ret = tls_device_reencrypt(sk, tls_ctx);
+
+	memcpy(ctx->old_rec_seq, tls_ctx->rx.rec_seq,
+	       sizeof(ctx->old_rec_seq));
+
+	sw_ctx->aead_recv = saved_aead;
+	memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
+	memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq));
+
+	return ret;
+}
+
+/* Undo old-key XOR so SW AEAD can decrypt with the new key. */
+static int tls_device_reencrypt_old_key(struct sock *sk,
+					struct tls_offload_context_rx *ctx,
+					struct tls_sw_context_rx *sw_ctx,
+					struct tls_context *tls_ctx)
+{
+	int ret;
+
+	ret = tls_old_key_reencrypt(sk, ctx, sw_ctx, tls_ctx);
+	if (ret)
+		return ret;
+
+	tls_bigint_increment(ctx->old_rec_seq,
+			     tls_ctx->prot_info.rec_seq_size);
+	ctx->resync_nh_reset = 1;
+
+	return 0;
+}
+
+/* Tear down NIC offload on peer KeyUpdate so post-KU records
+ * (new-key wire encryption) are not NIC-XOR'd with the retired key.
+ * NIC stays keyless until tls_set_device_offload_rx installs the new key.
+ */
+void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
+{
+	struct net_device *netdev;
+
+	if (ctx->rx_conf != TLS_HW)
+		return;
+	if (test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		return;
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (!netdev) {
+		up_read(&device_offload_lock);
+		return;
+	}
+
+	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+	synchronize_net();
+	netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+					TLS_OFFLOAD_CTX_DIR_RX);
+	up_read(&device_offload_lock);
+}
+
+static int tls_device_dev_add(struct sock *sk, struct tls_context *tls_ctx,
+			      struct net_device *netdev,
+			      struct tls_crypto_info *crypto_info,
+			      u32 cur_seq, bool is_rekey)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	char *rec_seq;
+	int rc;
+
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk,
+					     TLS_OFFLOAD_CTX_DIR_RX,
+					     crypto_info, cur_seq);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
+				     cur_seq, rec_seq, rc);
+	if (!rc) {
+		clear_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		clear_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+	} else if (is_rekey) {
+		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYHWFAIL);
+	}
+	return rc;
+}
+
+static void tls_device_deferred_dev_add(struct sock *sk,
+					struct tls_context *tls_ctx,
+					struct tls_offload_context_rx *ctx)
+{
+	struct net_device *netdev;
+
+	ctx->dev_add_pending = 0;
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(tls_ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (netdev)
+		tls_device_dev_add(sk, tls_ctx, netdev,
+				   &tls_ctx->crypto_recv.info,
+				   tcp_sk(sk)->copied_seq, true);
+	up_read(&device_offload_lock);
+}
+
+
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_offload_context_rx *ctx = tls_offload_ctx_rx(tls_ctx);
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_buff *skb = tls_strp_msg(sw_ctx);
+	u32 copied_seq = tcp_sk(sk)->copied_seq;
 	struct strp_msg *rxm = strp_msg(skb);
 	int is_decrypted, is_encrypted;
+	u32 rec_start_seq;
 
 	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
 		is_decrypted = skb->decrypted;
@@ -996,10 +1416,67 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		is_encrypted = 0;
 	}
 
-	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
+	rec_start_seq = sw_ctx->strp.copy_mode
+		? copied_seq - rxm->full_len
+		: copied_seq;
+
+	trace_tls_device_decrypted(sk, rec_start_seq,
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
+	if (unlikely(ctx->old_aead_recv)) {
+		bool before_nic_boundary =
+			before(rec_start_seq, ctx->old_nic_boundary);
+
+		/* Retry path: mixed record first-pass XOR-undo produced
+		 * EBADMSG because per-fragment decrypted flags don't
+		 * reflect which fragments were actually XOR'd (NIC auth
+		 * failure clearing flags). Toggle decrypted flag and re-XOR,
+		 * decrement old_rec_seq to reuse the same nonce.
+		 */
+		if (ctx->old_key_reencrypted) {
+			struct sk_buff *frag_iter;
+
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->old_nic_boundary,
+							 true);
+			skb->decrypted = !skb->decrypted;
+			skb_walk_frags(skb, frag_iter)
+				frag_iter->decrypted = !frag_iter->decrypted;
+
+			tls_bigint_decrement(ctx->old_rec_seq,
+					     tls_ctx->prot_info.rec_seq_size);
+			return tls_device_reencrypt_old_key(sk, ctx,
+							   sw_ctx, tls_ctx);
+		}
+
+		if (before_nic_boundary) {
+			if (is_encrypted) {
+				tls_bigint_increment(ctx->old_rec_seq,
+						     tls_ctx->prot_info.rec_seq_size);
+				return 0;
+			}
+			/* For mixed records, first old key rencrypt and if
+			 * SW AEAD fails then retry with decrypted flags toggled
+			 */
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->old_nic_boundary,
+							 false);
+			if (!is_decrypted)
+				ctx->old_key_reencrypted = 1;
+			return tls_device_reencrypt_old_key(sk, ctx,
+							   sw_ctx, tls_ctx);
+		}
+
+		trace_tls_device_rekey_done(sk, rec_start_seq,
+					    ctx->old_nic_boundary);
+		crypto_free_aead(ctx->old_aead_recv);
+		ctx->old_aead_recv = NULL;
+
+		if (ctx->dev_add_pending)
+			tls_device_deferred_dev_add(sk, tls_ctx, ctx);
+	}
+
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
 		if (likely(is_encrypted || is_decrypted))
 			return is_decrypted;
@@ -1068,57 +1545,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
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
@@ -1159,8 +1610,10 @@ int tls_set_device_offload(struct sock *sk)
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
@@ -1175,7 +1628,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1188,18 +1640,112 @@ int tls_set_device_offload(struct sock *sk)
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
+	if (!defer)
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
+	u32 copied_seq = tcp_sk(sk)->copied_seq;
 	struct tls_offload_context_rx *context;
 	struct net_device *netdev;
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
@@ -1225,29 +1771,82 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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
+		ctx->priv_ctx_rx = context;
+	} else {
+		context = tls_offload_ctx_rx(ctx);
 	}
 	context->resync_nh_reset = 1;
 
-	ctx->priv_ctx_rx = context;
-	rc = tls_sw_ctx_init(sk, 0, NULL);
+	if (new_crypto_info) {
+		struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
+
+		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+			synchronize_net();
+			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+							TLS_OFFLOAD_CTX_DIR_RX);
+		}
+
+		if (context->old_aead_recv &&
+		    before(copied_seq, context->old_nic_boundary)) {
+			/* Previous rekey still draining. Keep old_aead_recv,
+			 * it is the only key that can undo the NIC-XOR on queued
+			 * records. sw_ctx->aead_recv may be re-setkey'd by
+			 * tls_sw_ctx_init(); that intermediate key was never on
+			 * the NIC and its wire era is drained, so it is needed
+			 * for neither undo nor AEAD. Defer dev_add; the new key
+			 * is installed once copied_seq crosses old_nic_boundary.
+			 */
+			context->dev_add_pending = 1;
+		} else {
+			u32 rcv_nxt;
+
+			if (context->old_aead_recv) {
+				crypto_free_aead(context->old_aead_recv);
+				context->old_aead_recv = NULL;
+			}
+
+			/* flush the backlog so rcv_nxt is accurate */
+			__sk_flush_backlog(sk);
+			rcv_nxt = tcp_sk(sk)->rcv_nxt;
+
+			if (before(copied_seq, rcv_nxt)) {
+				context->old_aead_recv = sw_ctx->aead_recv;
+				sw_ctx->aead_recv = NULL;
+				memcpy(context->old_iv, ctx->rx.iv,
+				       sizeof(context->old_iv));
+				memcpy(context->old_rec_seq, ctx->rx.rec_seq,
+				       sizeof(context->old_rec_seq));
+				context->old_nic_boundary = rcv_nxt;
+				context->dev_add_pending = 1;
+			}
+			trace_tls_device_rekey_start(sk, copied_seq, rcv_nxt,
+						    before(copied_seq, rcv_nxt));
+		}
+	}
+
+	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
 	if (rc)
 		goto release_ctx;
 
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_RX,
-					     &ctx->crypto_recv.info,
-					     tcp_sk(sk)->copied_seq);
-	info = (void *)&ctx->crypto_recv.info;
-	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
-				     tcp_sk(sk)->copied_seq, info->rec_seq, rc);
-	if (rc)
-		goto free_sw_resources;
+	if (!context->dev_add_pending) {
+		rc = tls_device_dev_add(sk, ctx, netdev, src_crypto_info,
+					copied_seq, !!new_crypto_info);
+		if (!new_crypto_info) {
+			if (rc)
+				goto free_sw_resources;
+			tls_device_attach(ctx, sk, netdev);
+		}
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
-	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1256,10 +1855,13 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 
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
@@ -1270,6 +1872,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 void tls_device_offload_cleanup_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx;
 	struct net_device *netdev;
 
 	down_read(&device_offload_lock);
@@ -1278,8 +1881,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1289,6 +1893,13 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	}
 out:
 	up_read(&device_offload_lock);
+
+	rx_ctx = tls_offload_ctx_rx(tls_ctx);
+	if (rx_ctx && rx_ctx->old_aead_recv) {
+		crypto_free_aead(rx_ctx->old_aead_recv);
+		rx_ctx->old_aead_recv = NULL;
+	}
+
 	tls_sw_release_resources_rx(sk);
 }
 
@@ -1319,7 +1930,10 @@ static int tls_device_down(struct net_device *netdev)
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
@@ -1336,13 +1950,18 @@ static int tls_device_down(struct net_device *netdev)
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
index 1110f7ac6bcb..5be425a32c82 100644
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
index 1412b3dcce4c..fc60e8c0f24c 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -522,7 +522,7 @@ static void tls_encrypt_done(void *data, int err)
 		complete(&ctx->async_wait.completion);
 }
 
-static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
 {
 	if (!atomic_dec_and_test(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
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
 
@@ -817,7 +817,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
 	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
@@ -982,7 +982,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	return err;
 }
 
-static int tls_sw_push_pending_record(struct sock *sk, int flags)
+int tls_sw_push_pending_record(struct sock *sk, int flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
@@ -1033,8 +1033,7 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 	return 0;
 }
 
-static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-				 size_t size)
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -1802,6 +1801,8 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
+		/* Stop NIC from XOR-ing post-KU records with the retired key */
+		tls_device_rx_del_key(sk, ctx);
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
@@ -1809,6 +1810,36 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	return 0;
 }
 
+static int tls_rx_rekey_retry(struct sock *sk, struct msghdr *msg,
+			      struct tls_context *tls_ctx,
+			      struct tls_decrypt_arg *darg, int err)
+{
+	struct tls_offload_context_rx *rx_ctx = tls_offload_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
+
+	if (!rx_ctx->old_key_reencrypted)
+		return err;
+
+	if (err == -EBADMSG) {
+		if (darg->zc) {
+			struct tls_sw_context_rx *sw_ctx =
+				tls_sw_ctx_rx(tls_ctx);
+			struct strp_msg *rxm;
+
+			rxm = strp_msg(tls_strp_msg(sw_ctx));
+			iov_iter_revert(&msg->msg_iter,
+					rxm->full_len - prot->overhead_size);
+		}
+
+		err = tls_decrypt_device(sk, msg, tls_ctx, darg);
+		if (!err)
+			err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
+	}
+
+	rx_ctx->old_key_reencrypted = 0;
+	return err;
+}
+
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1820,6 +1851,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
+
+	if (tls_ctx->rx_conf == TLS_HW)
+		err = tls_rx_rekey_retry(sk, msg, tls_ctx, darg, err);
+
 	if (err < 0)
 		return err;
 
@@ -2630,7 +2665,7 @@ void tls_sw_free_resources_rx(struct sock *sk)
 }
 
 /* The work handler to transmitt the encrypted records in tx_list */
-static void tx_work_handler(struct work_struct *work)
+void tls_tx_work_handler(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct tx_work *tx_work = container_of(delayed_work,
@@ -2663,6 +2698,15 @@ static void tx_work_handler(struct work_struct *work)
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
@@ -2714,11 +2758,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
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
@@ -2861,11 +2901,9 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	if (!new_crypto_info) {
-		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-		if (rc)
-			goto free_aead;
-	}
+	rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+	if (rc)
+		goto free_aead;
 
 	if (!tx && !new_crypto_info) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
diff --git a/net/tls/trace.h b/net/tls/trace.h
index 2d8ce4ff3265..56fcf95c5aaf 100644
--- a/net/tls/trace.h
+++ b/net/tls/trace.h
@@ -192,6 +192,85 @@ TRACE_EVENT(tls_device_tx_resync_send,
 	)
 );
 
+TRACE_EVENT(tls_device_rekey_start,
+
+	TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
+		 bool inflight),
+
+	TP_ARGS(sk, copied_seq, nic_boundary, inflight),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		copied_seq	)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		inflight	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->copied_seq = copied_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->inflight = inflight;
+	),
+
+	TP_printk(
+		"sk=%p copied_seq=%u nic_boundary=%u inflight=%d",
+		__entry->sk, __entry->copied_seq, __entry->nic_boundary,
+		__entry->inflight
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_reencrypt,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary, bool retry),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary, retry),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		retry		)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->retry = retry;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u retry=%d",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary,
+		__entry->retry
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_done,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
 #endif /* _TLS_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1


