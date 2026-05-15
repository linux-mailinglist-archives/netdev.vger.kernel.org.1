Return-Path: <netdev+bounces-288463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNjNEZmUB2pR9gIAu9opvQ
	(envelope-from <netdev+bounces-288463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 444615586E6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4C45303297B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08D4405C4B;
	Fri, 15 May 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ec4S7W82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87F405C34
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880547; cv=none; b=TGG2ZdPUS8HJcFMiwG/jJLPXDTx/XbaRnCgkXAbCa3I9KSlPtAJTEz0pW9XbwP/picUXY0GktQARcCXmXB7AWDev+Xh3AOH3sXbn2fiU2oZwjX5fGw5SocLIg7EI3bMJ5Pvnt8MKasvDv9J1BGDDBYGtxtNSYyVVLN/jqkBuEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880547; c=relaxed/simple;
	bh=Cu/5s/7s96dZXg23bjsa7plrjjsARSoG0H95mDo9fFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9LjxDfc3X8ZvYK4rS6A91ZZxLT2SiSuw7rzMNKvX+Z6PZgM+Sxtn+vM6e1fBIrnSGdHgD/swzfvXJLj707Ghc0vNbh6Wz8MRl12S9ynxHOrWLM4iJFbgBfCpS1iuJTS4IpMaQIRUXUPBmiHE8vKTI0mdZDy+R12QEZiFhKR+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ec4S7W82; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-439b2aad735so181219fac.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778880544; x=1779485344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTBPiNE712N9VMc7PulDt7Sh2IjIh2GhnRtrWNhpN6U=;
        b=Ec4S7W82hodtApfVJ1pdL+0NfxYd0OaGHwm79VAxhLShSZrGyxWda1V/+qmtOMAxuG
         2XgLC4vqAVVeHqybj0sS9JQ9KiarV3fFedAdQ2x6bqOVwZiTRMoVnM+khnMSkj/h03+G
         WrfwkKZNvXslBmPgxecxNoKWOv2psGFgMwPMIkahVFDm/idM4HoUqpYpEYT45KXkHh/d
         kaaxHTjVHumzrfbsA1ONKJXBEuYUKQ/MFHmgSxTb4W9iiEusQv80a+bDhYcT6noIW5io
         IYamRa1pr33EsjkkWtgLEz9iEhct9bzNorxYx4LpKlIuuOsck4a2ayvTgHtRX2EJYShP
         RRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880544; x=1779485344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OTBPiNE712N9VMc7PulDt7Sh2IjIh2GhnRtrWNhpN6U=;
        b=Y+MQgBqSaBYcyPkeZatqRZGK9klRUHi/PYPsevcBmi3x+V60p75tzGvrVTO2nwqNNh
         E8IKsoUX4GQuOhqrdZy1fM0DmSOj2wcUJSSoXOi2eoTxitAALOe7G9iPLyR/ZpSTfIyW
         j4N/Q5J4iGgZYjWsOMY2N22ZLSumO3vHqYjTKck2SVaILG4x0n+jIRv1fAke7t/plDLQ
         oTS7rHa6cdsSZ2AsSsaAt1eYxRdjzKay4uy6rbZXffzZ5gzkPePAfnIn78iMhnisVwdk
         TRLXH2m2AsUFDBP5FUeFgyOb7s7LpONbDxlXf9ExTB+6d1/F4aih8+QlkRlj7an3e6ZA
         FUEA==
X-Gm-Message-State: AOJu0Yy8hDvEbGzeLv85XYmXDZ5af4pN2qVel2aNKYyKJNjyICLPd7jd
	PT/K88s596aqe6JFYaUvAJSx+95roPBWfnd6GcQ0arf8KUm0aaquQlfDNs5CGqY39U1S2tvoFqZ
	mTlm/zU8IRE3Xg+CsyGNO9xYKC6u5bHuGpKrEdmdQrB5JHSQCcAEEsrYM64DY6tYSAF2O48UADy
	SRdMKO9o8UFUi54CYb/2tff9vDPhQwXUvqC9XdLuPV0p6gv68=
X-Gm-Gg: Acq92OFMnuYXNXNH9lAXsP1l0I9SGttE9aw3D0BY7rgmLLVqizwjbnlJSGWwbn07pL4
	tV4Kky7hR6Qno9LuZxunNADI9jteOU0o1VXBSJpieLwjgS6Jljb/6FXOSHf8D4FWlQQvm1q+QT2
	Dx4xnxmu3jRhv3Oas9yjsqmxoyCTXg3u0yrzjoCcVkz5zkwjmyNHlUPUpYTMJsnOY2a1jvhTIK4
	V0NTCfH1iiVNP8AtKjI9J4Wds8nb7AK9fdOMlaBudtm5cW4LsbwugnrdwBKZTcNwQurXp4804hK
	Oqexsea6hfDnF+rPP8Pz5iHqxYFrmXBJs/iRfTlk2LkA+ifrGVQrmF9lhC0HMYcfxj5HsBShnyU
	nUeiZVjE66kiBfe5tzDnNlGYPBqWYUlULieipqaogT0nCHt939hDplNiYyyftCvDGpSU58RiKRA
	Ill6WZypVaVcm2kwT+tXuIKH1JinDlheTjTE+T6HvspDAVnUWJLmHCEl45yB8QRcK85Uxb
X-Received: by 2002:a05:6820:c8c:b0:694:a1d1:f363 with SMTP id 006d021491bc7-69c942db637mr3748109eaf.15.1778880544030;
        Fri, 15 May 2026 14:29:04 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm1608987eaf.4.2026.05.15.14.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:29:03 -0700 (PDT)
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
Subject: [PATCH v14 7/9] tls: device: add RX KeyUpdate support
Date: Fri, 15 May 2026 15:27:13 -0600
Message-Id: <20260515212715.3151307-8-rjethwani@purestorage.com>
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
X-Rspamd-Queue-Id: 444615586E6
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
	TAGGED_FROM(0.00)[bounces-288463-lists,netdev=lfdr.de];
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

For mixed records skb->decrypted flags can be wrong (NIC clears
them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
those flags, decrements old_rec_seq to reuse the nonce, and
retries once (gated by old_key_reencrypted).

The new key's tls_dev_add is deferred until the old key is fully
consumed: tls_set_device_offload_rx() sets dev_add_pending while
old_aead_recv is retained, and tls_device_deferred_dev_add()
installs the new key once copied_seq crosses old_nic_boundary.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 RX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h         |  10 ++
 include/uapi/linux/snmp.h |   2 +
 net/tls/tls.h             |  19 ++-
 net/tls/tls_device.c      | 311 +++++++++++++++++++++++++++++++++++---
 net/tls/tls_main.c        |  46 +++---
 net/tls/tls_proc.c        |   2 +
 net/tls/tls_sw.c          |  35 +++++
 7 files changed, 376 insertions(+), 49 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index c1085873ee01..214bd60a4a55 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -344,6 +344,16 @@ struct tls_offload_context_rx {
 	u8 resync_nh_reset:1;
 	/* CORE_NEXT_HINT-only member, but use the hole here */
 	u8 resync_nh_do_now:1;
+	/* retry reencrypt of mixed record during rekey */
+	u8 old_key_reencrypted:1;
+	/* tls_dev_add deferred until old key is freed */
+	u8 dev_add_pending:1;
+	struct {
+		struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
+		char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
+		char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
+		u32 old_nic_boundary; /* TCP seq: NIC switched to next key */
+	} rekey;
 	union {
 		/* TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ */
 		struct {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 2a8930d67ba1..f84989140c9a 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -370,7 +370,9 @@ enum
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
 	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSRXREKEYFALLBACK,		/* TlsRxRekeyFallback */
 	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
+	LINUX_MIB_TLSRXREKEYINPROGRESS,		/* TlsRxRekeyInProgress */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 52b3a771c0ce..829ef26150a1 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -240,8 +240,10 @@ void tls_device_cleanup(void);
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
@@ -257,13 +259,16 @@ tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
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
@@ -303,6 +308,16 @@ static inline bool tls_bigint_increment(unsigned char *seq, int len)
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
index c435b3450872..1c58cbd55ffb 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -179,6 +179,82 @@ static void tls_device_commit_start_marker(struct sock *sk,
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
@@ -887,6 +963,8 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		return;
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
 		return;
+	if (unlikely(test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags)))
+		return;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -1076,13 +1154,56 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -1092,10 +1213,59 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
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
+		/* Retry path: mixed record first-pass XOR-undo produced
+		 * EBADMSG because per-fragment decrypted flags don't
+		 * reflect which fragments were actually XOR'd (NIC auth
+		 * failure clearing flags). Toggle decrypted flag and re-XOR,
+		 * decrement rekey.old_rec_seq to reuse the same nonce.
+		 */
+		if (ctx->old_key_reencrypted) {
+			struct sk_buff *frag_iter;
+
+			skb->decrypted = !skb->decrypted;
+			skb_walk_frags(skb, frag_iter)
+				frag_iter->decrypted = !frag_iter->decrypted;
+
+			tls_bigint_decrement(ctx->rekey.old_rec_seq,
+					     tls_ctx->prot_info.rec_seq_size);
+			return tls_device_reencrypt_old_key(sk, ctx,
+							   sw_ctx, tls_ctx);
+		}
+
+		if (before_nic_boundary) {
+			if (is_encrypted) {
+				tls_bigint_increment(ctx->rekey.old_rec_seq,
+						     tls_ctx->prot_info.rec_seq_size);
+				return 0;
+			}
+			/* For mixed records, first old key rencrypt and if
+			 * SW AEAD fails then retry with decrypted flags toggled
+			 */
+			if (!is_decrypted)
+				ctx->old_key_reencrypted = 1;
+			return tls_device_reencrypt_old_key(sk, ctx,
+							   sw_ctx, tls_ctx);
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
@@ -1552,13 +1722,30 @@ int tls_set_device_offload(struct sock *sk,
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
@@ -1584,29 +1771,85 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
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
+				memcpy(context->rekey.old_iv, ctx->rx.iv,
+				       sizeof(context->rekey.old_iv));
+				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
+				       sizeof(context->rekey.old_rec_seq));
+				context->rekey.old_nic_boundary = rcv_nxt;
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
@@ -1615,10 +1858,13 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 
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
@@ -1629,6 +1875,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 void tls_device_offload_cleanup_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx;
 	struct net_device *netdev;
 
 	down_read(&device_offload_lock);
@@ -1637,8 +1884,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1648,6 +1896,19 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
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
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+	}
+
 	tls_sw_release_resources_rx(sk);
 }
 
@@ -1705,9 +1966,11 @@ static int tls_device_down(struct net_device *netdev)
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
index 2548ad2b2219..aec51cd6296a 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -740,37 +740,37 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
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
index 363dc7bfccdd..433a2e1028a9 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -28,7 +28,9 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
 	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK),
 	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
+	SNMP_MIB_ITEM("TlsRxRekeyInProgress", LINUX_MIB_TLSRXREKEYINPROGRESS),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index dc05fb96c0cd..854b225edd8e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1811,6 +1811,7 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
+		tls_device_rx_del_key(sk, ctx);
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
@@ -1818,6 +1819,36 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
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
@@ -1829,6 +1860,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
+
+	if (tls_ctx->rx_conf == TLS_HW)
+		err = tls_rx_rekey_retry(sk, msg, tls_ctx, darg, err);
+
 	if (err < 0)
 		return err;
 
-- 
2.25.1


