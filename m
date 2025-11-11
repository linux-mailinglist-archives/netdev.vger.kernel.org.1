Return-Path: <netdev+bounces-237752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D09C4FEC3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79A93B7EFD
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07408352FAC;
	Tue, 11 Nov 2025 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XlWk5bmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83016352F96
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897744; cv=none; b=Er1b6DJ19tirsCsNLaASHL92Cz0NUr4jy7ELUH0hF9RRtvRsm6xIhLSTBcqxpowlm+N2DtLHZDSi7fkIpiUpoiDUDNz1nN2c0xduqgINWn6fEW7KKCjrgKPcgRmkJlIoxoB5DdFeT8JXvV0+0OrxR93gxyv2NOF6paLxob8ptdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897744; c=relaxed/simple;
	bh=9n2AxIaov3CobXElX0XThJQX2B0VNt0R+Z+X75bo0ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XICl0mU7lz7Vx86zq7fk5bE7RBq/S8a3kbyhQDL1Mf6V4pKK++t7cgFIA48Oxn9Bz7OSdL4tLiO1MPQx00u9+zI3wzt7qIOoYapLSEDTsDVUiFiqt3wml0DazCHisFj1TLPWFQ1/EUGsyceouzvlf96iCj//omA0rEaUf1abGv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XlWk5bmK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b38de7940so54991f8f.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897740; x=1763502540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqlv54KOhoGjLhqkYyKMoJGiki/71WqaPG581NDAA64=;
        b=XlWk5bmKhqq5FjO2ZsDapOfp1+/D61IZDjrRBqAGTnZawpUj7BRgeN6vQYD4dr86iz
         wkB0mqGsW9aXOXaJRno7nCrplQGM71IKZvl48L1ky+yCbenZg8v4H+F4cYFNStiJrvwU
         3PTmVBH9LG0ctDQLwoNWluYznhcL00goGJ5IdlYdYMuzagRwgr8CcMNRxxcCJi5ulUjv
         7Jeyp97Nm4P9jDVnJRvtWBMx0O44YVmBYv5uvGuCF23ZLLg1+5PQN0wuhSo9TgacG9C0
         a3tmDgprEtlFjcbnhl04CKv9LNkuAH+6q7l3/dUwzJsoTmezrWAL08KXWNPHtILRaDpl
         KeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897740; x=1763502540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dqlv54KOhoGjLhqkYyKMoJGiki/71WqaPG581NDAA64=;
        b=OywH2Gf2E4yY3Add+JRalltzlBimVjl+rPPyrEY1oJyBDDPirgwiQ5zO16UthiaCK+
         UaRNPTYYwz/zFYXrWikgdfSabOWST+DI8NvopG/s3zQBrzgJSaesfuS32DEFNnlQlQIW
         9dRichG72gEJkGblefSSuEfNlDQmmWouMCX3M5UJYbYUOd8khDwKGiwuc6DFb0WEtyEl
         lKvCHPo+g00ETndhBoblLet/9OUhW/vK6NGspIQdDyimOzlvBxVV23TJBiJXBAesPA9B
         ljHTCNeQhaTEU9JIEpNYEaJJu8yVU48L85MC6oFMkV8QajjNDjvEL3iiYwqnODdQ3DGy
         5BvQ==
X-Gm-Message-State: AOJu0Yy9tVBCUlXmOjc6OoCa83MyzUymcEP3xTry0BQULPldzykiNlaq
	YpXez4Xoj7ndxeNYePBuXVo0M+/G2BuMrG6OfwudzCxPOaEQwA2evbjLB5pNzOKdRzVrmXKozqk
	zixyvb1PULD1i4XFAq4VLR79PuwCD0ZqMKwiGtstojWBTLu5gC70aRcdI+LF9M5y44Pk=
X-Gm-Gg: ASbGncvI6eFiABYJI1YdBn4JUL1ZUOYEPxYYl0S3xGGwsg+BHw2BUxROSuLbtZfOK6z
	BG6StjWCIY3wkKI1EihKXy/kZa0PHd8U9S8vk5cH89lgErL+RHY2FC5BK+YVMkAggC4UQBrRZ+1
	+DXva+gBVTB8R5xTsO4skZqz99GGjhyW2f1dHilf09xNTGgBIxKTtMOLI05f8CVT75r4Gvx8+iF
	I4ofEKs9tZRu9uiA4noqdYZTp67+Ndx3SHnYD9F58IbwCfKdSziJtOEzZyiZz5SKjowaeBmLnRG
	JMuCjy6phWkkJWBtdrxWaLtcFjSCGa89zS08Jt176KczBbAklS8YVwgwgJK6wHm4NIW8HIxCNgN
	eOWddpTn300O6MIyPKIC++jtME5h/SLhTZoStDihhdE+mnnRQzZeUGBeyxMNAMhXUbJQyVSOUzl
	YNSHWNydF8PF/mwA==
X-Google-Smtp-Source: AGHT+IHct3lRS7UKmX7/yspEv/1hpJqHsVt1RZfHP4JTYyF0+Ia5TaJBa93CxJgtFhileZyOoyslGQ==
X-Received: by 2002:a05:6000:615:b0:429:d4e1:cb81 with SMTP id ffacd0b85a97d-42b4bdd95c0mr623796f8f.62.1762897740483;
        Tue, 11 Nov 2025 13:49:00 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:49:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in one chunk
Date: Tue, 11 Nov 2025 22:47:39 +0100
Message-ID: <20251111214744.12479-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Currently ovpn uses three separate dynamically allocated structures to
set up cryptographic operations for both encryption and decryption. This
adds overhead to performance-critical paths and contribute to memory
fragmentation.

This commit consolidates those allocations into a single temporary blob,
similar to what esp_alloc_temp() does.

The resulting performance gain is +7.7% and +4.3% for UDP when using AES
and ChaChaPoly respectively, and +4.3% for TCP.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto_aead.c | 151 +++++++++++++++++++++++++--------
 drivers/net/ovpn/io.c          |   8 +-
 drivers/net/ovpn/skb.h         |  13 ++-
 3 files changed, 129 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index cb6cdf8ec317..9ace27fc130a 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -36,6 +36,105 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
 		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
 }
 
+/*
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
+	unsigned int len = crypto_aead_ivsize(tfm);
+
+	if (likely(len)) {
+		/* min size for a buffer of ivsize, aligned to alignmask */
+		len += crypto_aead_alignmask(tfm) &
+		       ~(crypto_tfm_ctx_alignment() - 1);
+		/* round up to the next multiple of the crypto context’s alignment */
+		len = ALIGN(len, crypto_tfm_ctx_alignment());
+	}
+
+	/* reserve space for the AEAD request */
+	len += sizeof(struct aead_request) + crypto_aead_reqsize(tfm);
+	/* round up to the next multiple of the struct scatterlist's alignment */
+	len = ALIGN(len, __alignof__(struct scatterlist));
+
+	/* adds enough space for nfrags + 2 scatterlist entries */
+	len += sizeof(struct scatterlist) * (nfrags + 2);
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
+static inline u8 *ovpn_aead_crypto_tmp_iv(struct crypto_aead *aead, void *tmp)
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
+static inline struct aead_request *
+ovpn_aead_crypto_tmp_req(struct crypto_aead *aead, const u8 *iv)
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
+static inline struct scatterlist *
+ovpn_aead_crypto_req_sg(struct crypto_aead *aead, struct aead_request *req)
+{
+	return (void *)ALIGN((unsigned long)(req + 1) +
+			     crypto_aead_reqsize(aead),
+			     __alignof__(struct scatterlist));
+}
+
 int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		      struct sk_buff *skb)
 {
@@ -45,6 +144,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct scatterlist *sg;
 	int nfrags, ret;
 	u32 pktid, op;
+	void *tmp;
 	u8 *iv;
 
 	ovpn_skb_cb(skb)->peer = peer;
@@ -71,13 +171,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
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
+	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
+	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
+	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
@@ -105,13 +207,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
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
@@ -130,11 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	/* AEAD Additional data */
 	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
 
-	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
-	if (unlikely(!req))
-		return -ENOMEM;
-
-	ovpn_skb_cb(skb)->req = req;
+	ovpn_skb_cb(skb)->crypto_tmp = tmp;
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->encrypt);
@@ -156,6 +247,7 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 	struct aead_request *req;
 	struct sk_buff *trailer;
 	struct scatterlist *sg;
+	void *tmp;
 	u8 *iv;
 
 	payload_offset = OVPN_AAD_SIZE + tag_size;
@@ -184,13 +276,15 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
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
+	iv = ovpn_aead_crypto_tmp_iv(ks->decrypt, tmp);
+	req = ovpn_aead_crypto_tmp_req(ks->decrypt, iv);
+	sg = ovpn_aead_crypto_req_sg(ks->decrypt, req);
 
 	/* sg table:
 	 * 0: op, wire nonce (AD, len=OVPN_OPCODE_SIZE+OVPN_NONCE_WIRE_SIZE),
@@ -213,23 +307,12 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
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
+	ovpn_skb_cb(skb)->crypto_tmp = tmp;
 
 	/* setup async crypto operation */
 	aead_request_set_tfm(req, ks->decrypt);
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3e9e7f8444b3..2721ee8268b2 100644
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
2.51.0


