Return-Path: <netdev+bounces-306377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f9erKtUKUGpmsQIAu9opvQ
	(envelope-from <netdev+bounces-306377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6373598A
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=AeSVFaTb;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306377-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306377-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E3443058A1A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129913E0223;
	Thu,  9 Jul 2026 20:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F73E0098
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630490; cv=none; b=k7BO3YVeSNc7j4xrX/1+NwUnCMTDsVmLITMsE0mEAYNcCILiTHASgv/S4eglPirxLOxvpcaqEmoGsYT7tFhktTzWMQBepttSl/E5co5WUeLQ9zU+ZOyswOTn4kfQSfnBxxiQ6kWwPOVjCuiHiMENhF6AVAm9rnXTyMeEIzCjOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630490; c=relaxed/simple;
	bh=eZaHFkWdJj7RigogA9vqDsKw2AeCf0fD1rPbzMWLHyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHhoQiT9PvivM1rsbbKrE0PuliMtOWjuLs6l9e1HIo3pyJowNixAmMvoRTwtoRcBvqrGx29SjrU6ZeqV//q76BmCNCRDohZlNHP018g6FyWVlU0vSPKmWG4CfoiM+BLftlKWODEF4AtK64G784hM7AzTMwE80ZJ74PMyRCK6JuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AeSVFaTb; arc=none smtp.client-ip=209.85.160.51
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cc65b0a7fso1185533fac.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630487; x=1784235287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRAcK1ZgKQozY7wFZDfow6cuDeo7DXib5Sg8tKog89U=;
        b=AeSVFaTbFQrGdlcPatqTGIhv6X44/rq8OsaJjH0HLJqZset+HDWzYCJtNqPo+EWtYk
         EGTZttkkTbOXK2XbHaHC/2k36Jlrew6ojW7zVWxIEnTveDlXqIIwqL8oPtFWgJ4OJDtk
         jBe1QeJxgq+Nn+SLMVZE0JNS34lf+dvQnys2XU5Q+/gYWfo5dqaPnX+IrrqhpENZPKH/
         x/39Gm9VQK46UHER3mpiJcBm23fy2Fy2tJw0P2+OyRuN1ZKeOYmHOacI7f3UVUIvwi0/
         MKy+M3pvimEgBbyv17eTOf1F3w5J/Er0q9KBkhLXTuG7ebnF4B1siIhTovwEd7SDwBvV
         miHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630487; x=1784235287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kRAcK1ZgKQozY7wFZDfow6cuDeo7DXib5Sg8tKog89U=;
        b=H1lljtIwPj9X77iup/qO95Ql0Zeh4hX2VccbSD+Z7ofg4iNc3ko+auyzHwJPuXEjBL
         6DSdOTHB+JCWMBSaO+9Ov7+8QTdPFWPfLCPB59DBcYFie+ZpeLRWh3TsYXChZZJrCWXn
         YRmqB3AGZjgSoqCljmJAxN8k5LmZX9K4OR3QswrcziEefLNviUvjQ6KGcXn47IJ/XRAP
         wiECEapZVQRYWTsA3r802t0vtkSRJOO76iuhc3Y7adEBRePlZHnijg4236x/9Oh2xfH+
         JgcR0q0oeZBbQCEmagcnBOPGgW++rJ66C+/4Wrrl5ssppJGSqSH0/MprOv4v9Jr4Hnib
         bYZQ==
X-Gm-Message-State: AOJu0Ywwv9JbM8laSL6aHIBYadE9z+yoWgCeKHlApySuZcnxNHHGGsYu
	VJz7cmqEsKSTWb81z43G386Lgh6jzK9C7Zbx/NMjPif7G6KQgU+EHFQRuc5W66u5t3aMTQ9tPkY
	Hs04PnPwQGHr9PbtUCYtdT2vqoHJ4MzIEeqTRuoVg5eqz3yaSS14JtZusB/+fEa+qRwyJRg/fHA
	SNZN+r4l6NHN9qTP9iyCtZCo55o/PRn0LD1lA9hOXUIOfjmfs=
X-Gm-Gg: AfdE7cmvY/xvws49bPxyMnZygJJNbR0Mj21yhp/GYZIeqKvqkdFBRDAtcWE0lVo1weV
	tmtFgXQPld9XNnpSYh6JO1KjuW+dcjBhXp4HIJz+vxkZIaKAUz3BAvXVN5LdUlPgbWWaPi5BTF+
	APP9q+5+x4DIb4NfgyjWwMKcq1CNk/77RC38S+WCZzGX4ZG+6q9RZUdqwvUP2aTo3tUaz4OIth4
	wHcnAGIZYtRm0Jzla006INVhMIn94qnEnHhv3JTxLsmKeqSUiYI3Bn1YKGFNCeK/htiGc+5zZWY
	+S9ZLyuV5iDxVPRw47mrBvu7CN4Kf2lspbBAW+glNqqVUgXDj+QKDl9JaM7vnRTcZG1xLONsSbp
	d3mnZggH4z7r7JGChLc2SC7D59vWZY7/U/v6kcUOVj5gxnHu8RCmrYRbuuZ3ihp1dG/QmPrhpSN
	0eVPG7wpWw9QcAD4vJeURCZZPTlxqXTaUF3IEx/arr0wYoPhuoBPNNB53vN4Vgm+4C8drMJ/BoN
	5vMFl6AhD+IdL4kEOSTGEF4gdDdGdHPpzYVQS3UXZbvotKUZrKEPxaC2jrWSjpyjpOCr8DTwuAF
	p+qkgXMOGFLcgrnyg2luBjvKs7IpxtzNA0o=
X-Received: by 2002:a05:6871:5b04:b0:430:16b5:909 with SMTP id 586e51a60fabf-451bbb4cdb4mr493363fac.15.1783630486430;
        Thu, 09 Jul 2026 13:54:46 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:46 -0700 (PDT)
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
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v15 7/9] tls: device: add RX KeyUpdate support
Date: Thu,  9 Jul 2026 14:53:23 -0600
Message-Id: <20260709205325.1591196-8-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709205325.1591196-1-rjethwani@purestorage.com>
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306377-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:andrew.gospodarek@broadcom.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EB6373598A

On RX, the NIC may have already decrypted in-flight records with
the old key before the peer's KeyUpdate is parsed, so the old
AEAD, IV and rec_seq are retained on tls_offload_context_rx.
tls_device_rx_del_key() is called from tls_check_pending_rekey()
when a KeyUpdate record is decoded; otherwise post-KeyUpdate records
(carrying new-key wire encryption) would be decrypted with the retired key.
tls_device_decrypted() classifies records by old_nic_boundary:

  - after the boundary: new-key record; drop the old key.
  - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
  - before, (partially) decrypted: reencrypt with the old key so SW
    AEAD can decrypt with the new key.

For mixed records the NIC may have cleared skb->decrypted on auth failure;
the optional tls_dev_rx_rekey_fixup callback re-asserts it,
then the record is reencrypted with the old key so the SW AEAD can
decrypt it with the new key.

The new key's tls_dev_add is deferred until the old key is fully
consumed: tls_set_device_offload_rx() sets dev_add_pending while
old_aead_recv is retained, and tls_device_deferred_dev_add_rx()
installs the new key once copied_seq crosses old_nic_boundary.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 RX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +
 include/net/tls.h                             |  10 +
 include/uapi/linux/snmp.h                     |   3 +
 net/tls/tls.h                                 |   9 +-
 net/tls/tls_device.c                          | 314 ++++++++++++++++--
 net/tls/tls_main.c                            |  46 +--
 net/tls/tls_proc.c                            |   3 +
 net/tls/tls_sw.c                              |   1 +
 8 files changed, 346 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index 337201f12895..71c9d3ca947d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -86,10 +86,20 @@ static int mlx5e_ktls_resync(struct net_device *netdev,
 	return 0;
 }
 
+static void mlx5e_ktls_rx_rekey_fixup(struct sk_buff *skb)
+{
+	struct sk_buff *frag_iter;
+
+	skb->decrypted = 1;
+	skb_walk_frags(skb, frag_iter)
+		frag_iter->decrypted = 1;
+}
+
 static const struct tlsdev_ops mlx5e_ktls_ops = {
 	.tls_dev_add = mlx5e_ktls_add,
 	.tls_dev_del = mlx5e_ktls_del,
 	.tls_dev_resync = mlx5e_ktls_resync,
+	.tls_dev_rx_rekey_fixup = mlx5e_ktls_rx_rekey_fixup,
 };
 
 bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
diff --git a/include/net/tls.h b/include/net/tls.h
index 2c6e314355fd..de04dfcf7a8c 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -320,6 +320,7 @@ struct tlsdev_ops {
 	int (*tls_dev_resync)(struct net_device *netdev,
 			      struct sock *sk, u32 seq, u8 *rcd_sn,
 			      enum tls_offload_ctx_dir direction);
+	void (*tls_dev_rx_rekey_fixup)(struct sk_buff *skb);
 };
 
 enum tls_offload_sync_type {
@@ -348,6 +349,15 @@ struct tls_offload_context_rx {
 	u8 resync_nh_reset:1;
 	/* CORE_NEXT_HINT-only member, but use the hole here */
 	u8 resync_nh_do_now:1;
+	/* tls_dev_add deferred until old key is freed */
+	u8 dev_add_pending:1;
+	struct {
+		struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
+		char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
+		char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
+		u32 old_nic_boundary; /* TCP seq: NIC switched to next key */
+		void (*rekey_fixup)(struct sk_buff *skb);
+	} rekey;
 	union {
 		/* TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ */
 		struct {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 119fbd49179c..284f879c92cc 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -370,8 +370,11 @@ enum
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
 	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSRXREKEYFALLBACK,		/* TlsRxRekeyFallback */
 	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
+	LINUX_MIB_TLSRXREKEYINPROGRESS,		/* TlsRxRekeyInProgress */
 	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
+	LINUX_MIB_TLSRXREKEYABORTED,		/* TlsRxRekeyAborted */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 6e8fafca42ca..0983b29dc46d 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -241,8 +241,10 @@ void tls_device_cleanup(void);
 int tls_set_device_offload(struct sock *sk,
 			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *crypto_info);
 void tls_device_offload_cleanup_rx(struct sock *sk);
+void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx);
 void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq);
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx);
 #else
@@ -258,13 +260,16 @@ tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
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
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ef837bbd9560..74583433b593 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -66,8 +66,14 @@ static void tls_device_free_ctx(struct tls_context *ctx)
 		kfree(offload_ctx);
 	}
 
-	if (ctx->rx_conf == TLS_HW)
-		kfree(tls_offload_ctx_rx(ctx));
+	if (ctx->rx_conf == TLS_HW) {
+		struct tls_offload_context_rx *offload_ctx =
+			tls_offload_ctx_rx(ctx);
+
+		memzero_explicit(&offload_ctx->rekey,
+				 sizeof(offload_ctx->rekey));
+		kfree(offload_ctx);
+	}
 
 	tls_ctx_free(NULL, ctx);
 }
@@ -185,6 +191,82 @@ static void tls_device_commit_start_marker(struct sock *sk,
 	tcp_write_collapse_fence(sk);
 }
 
+static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *tls_ctx,
+				 struct net_device *netdev,
+				 struct tls_crypto_info *crypto_info,
+				 u32 cur_seq, bool is_rekey)
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
+		if (is_rekey)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	} else if (is_rekey) {
+		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
+	}
+	return rc;
+}
+
+static void tls_device_deferred_dev_add_rx(struct sock *sk,
+					   struct tls_context *tls_ctx,
+					   struct tls_offload_context_rx *ctx)
+{
+	struct net_device *netdev;
+
+	ctx->dev_add_pending = 0;
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(tls_ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (netdev)
+		tls_device_dev_add_rx(sk, tls_ctx, netdev,
+				      &tls_ctx->crypto_recv.info,
+				      tcp_sk(sk)->copied_seq, true);
+	else
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
+	up_read(&device_offload_lock);
+	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+}
+
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
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -893,6 +975,8 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		return;
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
 		return;
+	if (unlikely(test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags)))
+		return;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -1082,13 +1166,56 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	return err;
 }
 
+/*
+ * Temporarily swap in the old key, run
+ * tls_device_reencrypt(), then restore the current key.
+ */
+static int tls_device_reencrypt_old_key(struct sock *sk,
+					struct tls_offload_context_rx *ctx,
+					struct tls_sw_context_rx *sw_ctx,
+					struct tls_context *tls_ctx)
+{
+	struct crypto_aead *saved_aead = sw_ctx->aead_recv;
+	char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
+	int ret;
+
+	memcpy(saved_iv, tls_ctx->rx.iv, sizeof(saved_iv));
+	memcpy(saved_rec_seq, tls_ctx->rx.rec_seq, sizeof(saved_rec_seq));
+
+	sw_ctx->aead_recv = ctx->rekey.old_aead_recv;
+	memcpy(tls_ctx->rx.iv, ctx->rekey.old_iv, sizeof(ctx->rekey.old_iv));
+	memcpy(tls_ctx->rx.rec_seq, ctx->rekey.old_rec_seq,
+	       sizeof(ctx->rekey.old_rec_seq));
+
+	ret = tls_device_reencrypt(sk, tls_ctx);
+
+	memcpy(ctx->rekey.old_rec_seq, tls_ctx->rx.rec_seq,
+	       sizeof(ctx->rekey.old_rec_seq));
+
+	sw_ctx->aead_recv = saved_aead;
+	memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
+	memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq));
+
+	if (ret)
+		return ret;
+
+	tls_bigint_increment(ctx->rekey.old_rec_seq,
+			     tls_ctx->prot_info.rec_seq_size);
+	ctx->resync_nh_reset = 1;
+
+	return 0;
+}
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
@@ -1098,10 +1225,42 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
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
 
+	if (unlikely(ctx->rekey.old_aead_recv)) {
+		bool before_nic_boundary =
+			before(rec_start_seq, ctx->rekey.old_nic_boundary);
+
+		if (before_nic_boundary) {
+			if (is_encrypted) {
+				tls_bigint_increment(ctx->rekey.old_rec_seq,
+						     tls_ctx->prot_info.rec_seq_size);
+				return 0;
+			}
+
+			/* rekey_fixup sets decrypted flags in case if NIC clears
+			 * decrypted flags on auth failure
+			 */
+			if (!is_decrypted && ctx->rekey.rekey_fixup)
+				ctx->rekey.rekey_fixup(skb);
+
+			return tls_device_reencrypt_old_key(sk, ctx,
+							    sw_ctx, tls_ctx);
+		}
+
+		crypto_free_aead(ctx->rekey.old_aead_recv);
+		ctx->rekey.old_aead_recv = NULL;
+
+		if (ctx->dev_add_pending)
+			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
+	}
+
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
 		if (likely(is_encrypted || is_decrypted))
 			return is_decrypted;
@@ -1580,13 +1739,31 @@ int tls_set_device_offload(struct sock *sk,
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
+	bool was_dev_add_pending;
+	bool moved_aead_recv = false;
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
@@ -1612,29 +1789,88 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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
+	was_dev_add_pending = context->dev_add_pending;
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
+		if (context->rekey.old_aead_recv &&
+		    before(copied_seq, context->rekey.old_nic_boundary)) {
+			/* Previous rekey still draining. Keep rekey.old_aead_recv,
+			 * it is the only key that can undo the NIC-XOR on queued
+			 * records. sw_ctx->aead_recv may be re-setkey'd by
+			 * tls_sw_ctx_init(); that intermediate key was never on
+			 * the NIC and its wire era is drained, so it is needed
+			 * for neither undo nor AEAD. Defer dev_add; the new key
+			 * is installed once copied_seq crosses rekey.old_nic_boundary.
+			 */
+			context->dev_add_pending = 1;
+		} else {
+			u32 rcv_nxt;
+
+			if (context->rekey.old_aead_recv) {
+				crypto_free_aead(context->rekey.old_aead_recv);
+				context->rekey.old_aead_recv = NULL;
+			}
+
+			/* flush the backlog so rcv_nxt is accurate */
+			__sk_flush_backlog(sk);
+			rcv_nxt = tcp_sk(sk)->rcv_nxt;
+
+			if (before(copied_seq, rcv_nxt)) {
+				context->rekey.old_aead_recv = sw_ctx->aead_recv;
+				sw_ctx->aead_recv = NULL;
+				moved_aead_recv = true;
+				memcpy(context->rekey.old_iv, ctx->rx.iv,
+				       sizeof(context->rekey.old_iv));
+				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
+				       sizeof(context->rekey.old_rec_seq));
+				context->rekey.old_nic_boundary = rcv_nxt;
+				context->rekey.rekey_fixup =
+					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;
+				context->dev_add_pending = 1;
+			}
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
+		rc = tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_info,
+					   copied_seq, !!new_crypto_info);
+		if (!new_crypto_info) {
+			if (rc)
+				goto free_sw_resources;
+			tls_device_attach(ctx, sk, netdev);
+		}
+	} else if (!was_dev_add_pending) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+	} else {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
-	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1646,7 +1882,18 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_sw_free_resources_rx(sk);
 	down_read(&device_offload_lock);
 release_ctx:
-	ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		ctx->priv_ctx_rx = NULL;
+	} else {
+		context->dev_add_pending = was_dev_add_pending;
+		if (moved_aead_recv) {
+			struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
+
+			crypto_free_aead(sw_ctx->aead_recv);
+			sw_ctx->aead_recv = context->rekey.old_aead_recv;
+			context->rekey.old_aead_recv = NULL;
+		}
+	}
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
@@ -1657,6 +1904,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 void tls_device_offload_cleanup_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx;
 	struct net_device *netdev;
 
 	down_read(&device_offload_lock);
@@ -1665,8 +1913,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1676,6 +1925,19 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	}
 out:
 	up_read(&device_offload_lock);
+
+	rx_ctx = tls_offload_ctx_rx(tls_ctx);
+	if (rx_ctx && rx_ctx->rekey.old_aead_recv) {
+		crypto_free_aead(rx_ctx->rekey.old_aead_recv);
+		rx_ctx->rekey.old_aead_recv = NULL;
+	}
+
+	if (rx_ctx && rx_ctx->dev_add_pending) {
+		rx_ctx->dev_add_pending = 0;
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYABORTED);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+	}
+
 	tls_sw_release_resources_rx(sk);
 }
 
@@ -1733,9 +1995,11 @@ static int tls_device_down(struct net_device *netdev)
 			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
 		}
 		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b51f9ea1ed6c..4519c8943ebf 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -757,37 +757,37 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			conf = TLS_SW;
 		}
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
+			if (!update) {
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
index adca8561c7da..ae2322481c71 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -28,8 +28,11 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
 	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK),
 	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
+	SNMP_MIB_ITEM("TlsRxRekeyInProgress", LINUX_MIB_TLSRXREKEYINPROGRESS),
 	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
+	SNMP_MIB_ITEM("TlsRxRekeyAborted", LINUX_MIB_TLSRXREKEYABORTED),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0364fae8a7e0..445517d8bc90 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1534,6 +1534,7 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
+		tls_device_rx_del_key(sk, ctx);
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
-- 
2.25.1


