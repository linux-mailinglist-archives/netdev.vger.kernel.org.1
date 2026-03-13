Return-Path: <netdev+bounces-267602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNteGfl4tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 461FF289E82
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D82B302052D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A337F8AB;
	Fri, 13 Mar 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OsQB6JVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28C37F8A5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435127; cv=none; b=PK9xxyTBZH6Hjv8fk4TUB6TZjV8B0rqCdJ0rsRdapSlgqtgJgA66xchFgxiFTu3S4x6JmrvxKuBUbk/D6msKrXdsYbOnA34ky7MpcnStHJ/Ud6rBF0mHxh9oixrNfLux+DznwwFM08CaDm5di9g/rlEfd7lkuLLNVaTHYtH4UAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435127; c=relaxed/simple;
	bh=AFP9NZ/vqopfXgtkXW92y3xf2b8sr19klfhl7CQ56Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGTWgXqyfqnAd4146nZ0luOw6TRhbYXQRf/duYooYnBbNTEY/S7nZ/vMb0+2zpEtdzjtWHZe1ios292TK+uzYCPG+TJ3uRsuXNppto9T527CQ9W1xYvHdGQeJL6u2x8aIzcmXQjnNPhcZFtXWXj3p+Bh7fjlw2UvZxzbmTYhW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OsQB6JVr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439ac15f35fso2263450f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435120; x=1774039920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=OsQB6JVrlPcTJXd8d7g2y4/aKgET5B90LSx1WnqqciZbotPt03guwRXRsLwc98LmA7
         gJFRSjWS0SAaa9ck0zw27jSjDQyQ2ne65lu2IDSihI9u6rbmcQahf3BGHx5xb9lhjHbA
         lC1sn+egNPeNVXzJ+nbs4wI8CFhdm+l5i/7L5iP0T3dVQbvb82Gjuu2CCAviJ4cHP7LZ
         194tUxJZFt/aXj34JnHLq8SDkk72olou78GZYf1fDC8gIh2rA7G8fZGbz9SKOMW4C7+j
         3+b2Vz00mI9Wq02QyqxZlUahnoYUIoXn2foYM8TMgIqYVEMu+gKYefTiSbt6OiT1M1D1
         3Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435120; x=1774039920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=P16HX9gqXO+WiFYZ3izRlpb+RsQ/htVbvdSGpvtBd8gFTwzRl8yMjR5IxeKcFH7ZkI
         xItzapCYfVhD1zTdLm7KKyhNhQKQCbODZSreA2eTfAWuxJzLlI/4WBjVWC3Z/VUjQ5Ql
         ei5uTsrWEPn+JSEKiB7KI/ukAZPnXfkGqu2bLbGDqxGV9fvSQwxL8KuVilP4gmzbYduY
         ketLnxP4Qm0MBBh36d87VmrA+pxfK5A9SHMNUJODsl9gvLQwOfIfTQnt4N9cUbB0G6K7
         QKpe7NalFBXRJvfHEbdpXPda8G5HUb6bqoLWub3nW+joVnMyrifPXNtW/wnlkZhIHLkS
         RGMg==
X-Gm-Message-State: AOJu0YzZ4V7YfB7mgh9BhhmpB+T/YRvHe1kmTafD3beowHRUbkJXfOWA
	1zPeEVtcq96xI1D+ko8YxIa6j1e9k4nCG5qaIkn0PrdjsGUDJmj40iGFvhfIQpSPUXGmcfCPlAJ
	90pr4Kd+ZP32+GdFLwQXo7ITFyIc/fP9cZZ8K3uxNwUdP2ZQXvXWysQTfO5+KBzvl
X-Gm-Gg: ATEYQzwLPNX6wdMd7Ddb4BnFo/yKgimUgf8LAG31hoC11w8uUBA7MpFd8Hgve8F7WJ3
	/vJXX6GZMd8oRKu8vvyLpoh5DVhl0v8J97OabvnSL6tAQ43a9pOc3fMeqVDsLLfe2gU0yg/K4kz
	aMWA00fHiunVklRMi8V4iFC0vgxkuomThzwr4soNWIzgtGFy6XsuE2D4a48s9sxWphVFELBPc9M
	vxfXTPvMvI51OFHzal3xe9HC/Wny4Hsq5nF684KYrZctbM/FG1vTH1B4j3lGI5U7X2cfDVQH5QA
	Krf+JOXAu5Pxbh29RRjG9XtevIVtBtE2xZffcxNSf8iLUlE4tE1GP7P1p5XmmfWqbF6H6Uw/Lgc
	fdURfJAyN0ek62k38p+RdGSR6LgaQShIu5X3q3se5AAudilQeyFJhoB2RQU0qZIkVx5FU4LKXpg
	jk+pmMkSOcw2I4xvKjVbQM/i1xrO60QIUpnqIm
X-Received: by 2002:a05:6000:2288:b0:439:b79d:b9a5 with SMTP id ffacd0b85a97d-43a04dae73dmr9252950f8f.37.1773435120133;
        Fri, 13 Mar 2026 13:52:00 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 9/9] ovpn: consolidate crypto allocations in one chunk
Date: Fri, 13 Mar 2026 21:51:39 +0100
Message-ID: <20260313205139.2950-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
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
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267602-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 461FF289E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Currently ovpn uses three separate dynamically allocated structures to
set up cryptographic operations for both encryption and decryption. This
adds overhead to performance-critical paths and contribute to memory
fragmentation.

This commit consolidates those allocations into a single temporary blob,
similar to what esp_alloc_tmp() does.

The resulting performance gain is +7.7% and +4.3% for UDP when using AES
and ChaChaPoly respectively, and +4.3% for TCP.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/crypto_aead.c | 160 +++++++++++++++++++++++++--------
 drivers/net/ovpn/io.c          |   8 +-
 drivers/net/ovpn/skb.h         |  13 ++-
 3 files changed, 135 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 59848c41b7b2..8f07c418622b 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -36,6 +36,104 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
 		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
 }
 
+/**
+ * ovpn_aead_crypto_tmp_size - compute the size of a temporary object containing
+ *			       an AEAD request structure with extra space for SG
+ *			       and IV.
+ * @tfm: the AEAD cipher handle
+ * @nfrags: the number of fragments in the skb
+ *
+ * This function calculates the size of a contiguous memory block that includes
+ * the initialization vector (IV), the AEAD request, and an array of scatterlist
+ * entries. For alignment considerations, the IV is placed first, followed by
+ * the request, and then the scatterlist.
+ * Additional alignment is applied according to the requirements of the
+ * underlying structures.
+ *
+ * Return: the size of the temporary memory that needs to be allocated
+ */
+static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead *tfm,
+					      const unsigned int nfrags)
+{
+	unsigned int len = OVPN_NONCE_SIZE;
+
+	DEBUG_NET_WARN_ON_ONCE(crypto_aead_ivsize(tfm) != OVPN_NONCE_SIZE);
+
+	/* min size for a buffer of ivsize, aligned to alignmask */
+	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	/* round up to the next multiple of the crypto ctx alignment */
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+
+	/* reserve space for the AEAD request */
+	len += sizeof(struct aead_request) + crypto_aead_reqsize(tfm);
+	/* round up to the next multiple of the scatterlist alignment */
+	len = ALIGN(len, __alignof__(struct scatterlist));
+
+	/* add enough space for nfrags + 2 scatterlist entries */
+	len += array_size(sizeof(struct scatterlist), nfrags + 2);
+	return len;
+}
+
+/**
+ * ovpn_aead_crypto_tmp_iv - retrieve the pointer to the IV within a temporary
+ *			     buffer allocated using ovpn_aead_crypto_tmp_size
+ * @aead: the AEAD cipher handle
+ * @tmp: a pointer to the beginning of the temporary buffer
+ *
+ * This function retrieves a pointer to the initialization vector (IV) in the
+ * temporary buffer. If the AEAD cipher specifies an IV size, the pointer is
+ * adjusted using the AEAD's alignment mask to ensure proper alignment.
+ *
+ * Returns: a pointer to the IV within the temporary buffer
+ */
+static u8 *ovpn_aead_crypto_tmp_iv(struct crypto_aead *aead, void *tmp)
+{
+	return likely(crypto_aead_ivsize(aead)) ?
+		      PTR_ALIGN((u8 *)tmp, crypto_aead_alignmask(aead) + 1) :
+		      tmp;
+}
+
+/**
+ * ovpn_aead_crypto_tmp_req - retrieve the pointer to the AEAD request structure
+ *			      within a temporary buffer allocated using
+ *			      ovpn_aead_crypto_tmp_size
+ * @aead: the AEAD cipher handle
+ * @iv: a pointer to the initialization vector in the temporary buffer
+ *
+ * This function computes the location of the AEAD request structure that
+ * immediately follows the IV in the temporary buffer and it ensures the request
+ * is aligned to the crypto transform context alignment.
+ *
+ * Returns: a pointer to the AEAD request structure
+ */
+static struct aead_request *ovpn_aead_crypto_tmp_req(struct crypto_aead *aead,
+						     const u8 *iv)
+{
+	return (void *)PTR_ALIGN(iv + crypto_aead_ivsize(aead),
+				 crypto_tfm_ctx_alignment());
+}
+
+/**
+ * ovpn_aead_crypto_req_sg - locate the scatterlist following the AEAD request
+ *			     within a temporary buffer allocated using
+ *			     ovpn_aead_crypto_tmp_size
+ * @aead: the AEAD cipher handle
+ * @req: a pointer to the AEAD request structure in the temporary buffer
+ *
+ * This function computes the starting address of the scatterlist that is
+ * allocated immediately after the AEAD request structure. It aligns the pointer
+ * based on the alignment requirements of the scatterlist structure.
+ *
+ * Returns: a pointer to the scatterlist
+ */
+static struct scatterlist *ovpn_aead_crypto_req_sg(struct crypto_aead *aead,
+						   struct aead_request *req)
+{
+	return (void *)ALIGN((unsigned long)(req + 1) +
+			     crypto_aead_reqsize(aead),
+			     __alignof__(struct scatterlist));
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -45,6 +143,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct scatterlist *sg;
 	int nfrags, ret;
 	u32 pktid, op;
+	void *tmp;
 	u8 *iv;
 
 	ovpn_skb_cb(skb)->peer = peer;
@@ -71,13 +170,17 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
 		return -ENOSPC;
 
-	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
-	if (unlikely(!ovpn_skb_cb(skb)->sg))
+	/* allocate temporary memory for iv, sg and req */
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
+		      GFP_ATOMIC);
+	if (unlikely(!tmp))
 		return -ENOMEM;
 
-	sg = ovpn_skb_cb(skb)->sg;
+	ovpn_skb_cb(skb)->crypto_tmp = tmp;
+
+	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
+	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
+	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
@@ -105,13 +208,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* iv may be required by async crypto */
-	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
-	if (unlikely(!ovpn_skb_cb(skb)->iv))
-		return -ENOMEM;
-
-	iv = ovpn_skb_cb(skb)->iv;
-
 	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
 	 * nonce
 	 */
@@ -130,12 +226,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* AEAD Additional data */
 	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
 
-	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
-	if (unlikely(!req))
-		return -ENOMEM;
-
-	ovpn_skb_cb(skb)->req = req;
-
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->encrypt);
 	aead_request_set_callback(req, 0, ovpn_encrypt_post, skb);
@@ -156,6 +246,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
+	void *tmp;
 	u8 *iv;
 
 	payload_offset = OVPN_AAD_SIZE + tag_size;
@@ -184,13 +275,17 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
 		return -ENOSPC;
 
-	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
-	if (unlikely(!ovpn_skb_cb(skb)->sg))
+	/* allocate temporary memory for iv, sg and req */
+	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->decrypt, nfrags),
+		      GFP_ATOMIC);
+	if (unlikely(!tmp))
 		return -ENOMEM;
 
-	sg = ovpn_skb_cb(skb)->sg;
+	ovpn_skb_cb(skb)->crypto_tmp = tmp;
+
+	iv = ovpn_aead_crypto_tmp_iv(ks->decrypt, tmp);
+	req = ovpn_aead_crypto_tmp_req(ks->decrypt, iv);
+	sg = ovpn_aead_crypto_req_sg(ks->decrypt, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_OPCODE_SIZE+OVPN_NONCE_WIRE_SIZE),
@@ -213,24 +308,11 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* append auth_tag onto scatterlist */
 	sg_set_buf(sg + ret + 1, skb->data + OVPN_AAD_SIZE, tag_size);
 
-	/* iv may be required by async crypto */
-	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
-	if (unlikely(!ovpn_skb_cb(skb)->iv))
-		return -ENOMEM;
-
-	iv = ovpn_skb_cb(skb)->iv;
-
 	/* copy nonce into IV buffer */
 	memcpy(iv, skb->data + OVPN_OPCODE_SIZE, OVPN_NONCE_WIRE_SIZE);
 	memcpy(iv + OVPN_NONCE_WIRE_SIZE, ks->nonce_tail_recv,
 	       OVPN_NONCE_TAIL_SIZE);
 
-	req = aead_request_alloc(ks->decrypt, GFP_ATOMIC);
-	if (unlikely(!req))
-		return -ENOMEM;
-
-	ovpn_skb_cb(skb)->req = req;
-
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->decrypt);
 	aead_request_set_callback(req, 0, ovpn_decrypt_post, skb);
@@ -273,7 +355,11 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 		goto error;
 	}
 
-	/* basic AEAD assumption */
+	/* basic AEAD assumption
+	 * all current algorithms use OVPN_NONCE_SIZE.
+	 * ovpn_aead_crypto_tmp_size and ovpn_aead_encrypt/decrypt
+	 * expect this.
+	 */
 	if (crypto_aead_ivsize(aead) != OVPN_NONCE_SIZE) {
 		pr_err("%s IV size must be %d\n", title, OVPN_NONCE_SIZE);
 		ret = -EINVAL;
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 955c9a37e1f8..db43a1f8a07a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -119,9 +119,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	peer = ovpn_skb_cb(skb)->peer;
 
 	/* crypto is done, cleanup skb CB and its members */
-	kfree(ovpn_skb_cb(skb)->iv);
-	kfree(ovpn_skb_cb(skb)->sg);
-	aead_request_free(ovpn_skb_cb(skb)->req);
+	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret < 0))
 		goto drop;
@@ -248,9 +246,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	peer = ovpn_skb_cb(skb)->peer;
 
 	/* crypto is done, cleanup skb CB and its members */
-	kfree(ovpn_skb_cb(skb)->iv);
-	kfree(ovpn_skb_cb(skb)->sg);
-	aead_request_free(ovpn_skb_cb(skb)->req);
+	kfree(ovpn_skb_cb(skb)->crypto_tmp);
 
 	if (unlikely(ret == -ERANGE)) {
 		/* we ran out of IVs and we must kill the key as it can't be
diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
index 64430880f1da..4fb7ea025426 100644
--- a/drivers/net/ovpn/skb.h
+++ b/drivers/net/ovpn/skb.h
@@ -18,12 +18,19 @@
 #include <linux/socket.h>
 #include <linux/types.h>
 
+/**
+ * struct ovpn_cb - ovpn skb control block
+ * @peer: the peer this skb was received from/sent to
+ * @ks: the crypto key slot used to encrypt/decrypt this skb
+ * @crypto_tmp: pointer to temporary memory used for crypto operations
+ *		containing the IV, the scatter gather list and the aead request
+ * @payload_offset: offset in the skb where the payload starts
+ * @nosignal: whether this skb should be sent with the MSG_NOSIGNAL flag (TCP)
+ */
 struct ovpn_cb {
 	struct ovpn_peer *peer;
 	struct ovpn_crypto_key_slot *ks;
-	struct aead_request *req;
-	struct scatterlist *sg;
-	u8 *iv;
+	void *crypto_tmp;
 	unsigned int payload_offset;
 	bool nosignal;
 };
-- 
2.52.0


