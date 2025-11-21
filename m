Return-Path: <netdev+bounces-240604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B9C76C0B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED783583EB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24A266584;
	Fri, 21 Nov 2025 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eQ5Ar5Ow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB134257831
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684472; cv=none; b=OwpA7maId3KRnQs6RTmc2Ujm8urhqPDIwciVr7qb+ehTkOyFbvK0nszB+vgE9m/rl2FmmuMfv9UjqCUunWxLnelihHSMJEB1Y24UwZQ/4FRyY1HnOk/JxpeWUQJBO7V+TdXK/myYvIkuwKz0jaYdI3uAmGpc3Fptz0dRtrobPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684472; c=relaxed/simple;
	bh=X5zxuPHTS9XJQPgX9xsWnjzwaNdf/xe8Q7Bs0cq7l0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzVdGeaPMq+XMhyzjHq6+WqNio7+4SLNmA89sWKVF1I4iduOcHBsu5NfP4UdfEz6/UzysHn/po+FzDeZmYWcQzywDzwkUpZYVfUb2WDyTE55nwTsGXnCaLviAJHK/LgNFD1vvIX4RmW0zTbDfYrp+Qfb0g6Pdc9hmHLVnzs8a2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eQ5Ar5Ow; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so13123905e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684467; x=1764289267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV7Dfc38TlxJLrqfaMkPf8wEgW1vCEJBUQB4kk9disw=;
        b=eQ5Ar5Ow7SS2KPxcwMoQVKT6qXsinm2JQFUZUWxUsAaNP7uv3xNdHeE79Ia6Vx5vvF
         fY18eSADiUUwPyGlYc+/UQeI5hJuwdhH2EPJtMjl+Unruu7inW7oKzAvnEg7v0rrwZ4C
         xhiJDQ+f6o+8rMDfKokQRHWefeJ59clsrZtYOKpE1BfM4CEqOHE3Ss/i3nAe8YpjTIj5
         n5TcRdQJjhaQZdaT7wt75MSZ4Rk7U71kqlnVESX4aib/RPyIe/RCLxdaKXR4VIK63wpk
         cfNw1VHZ7oAvaG+1/AEbjm1SDkCzlv7k+6H1BFDULUjqqnBKaFwoKRYeTQFDUhA+EV12
         mP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684467; x=1764289267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mV7Dfc38TlxJLrqfaMkPf8wEgW1vCEJBUQB4kk9disw=;
        b=ZChe8K3UMqrzhdIBPHitm5bHfoDTyac95pHEVQgGut7QTq+vjXKa8qeY3wdMfWRXv1
         tu+8LygcixKfqNZe0oOz17fD14YgtFKtX32TCGMQYZppH6hIYnpRypTiRwjjHjb5ZpSS
         pa+1ttPUopy3aNxy84sCY7/AQZG9iJ/XL645OsB54a+ZZkpBWLbQFZzHl45ZKCLSJtas
         AkOBL+d3H5fSmHf1+WBALGjyPOwjw4NFsq9VbTLhi3+TPPch3hrDbdQMg7aFgMcdtIyH
         7rO6rXjoYfw85q1odX9CrGmVeRpjWaRBfNItYMVOERIiQ+NRHZhfIZ3g0WRZoG2cUTD+
         N2ig==
X-Gm-Message-State: AOJu0YxAXepFpxf0tFG2kywxyA6/SBXKdmObRIU7UeOnjSf+z+Nu9m42
	BDRPD52ZgjqCSQGHa1YTQlERZFMUHokJ5u6e4UVRj2TouAzfzkPCHohZwxkwGynnSIFQyy+KLQG
	k6HSZvw2XyQFdOMuuu1g54OIGcU1h3787/xhWCvb7F7CgFaRcPpOFRXiCxXz9zrhEFZg=
X-Gm-Gg: ASbGnctZHxp/lA43K6lEpI7pAJGscmY5pzaKEQrH4NKNUdSr6LS4XBaPI+ZG0s/psRa
	hAJAovc7CGXEmR/klV31+cVFTd2gS2TDvcdy4B1KGhnaH5tK1g2CjHCOyu0SM48PB/wbHDgKJ0+
	lRqHuZfjcfVEaZ2FGp8e2n8hoxy2ktKiB70J5Yde9tJQjDB8olXnPvWeCJm8XzZBt/zkdMiah8H
	FNCwX0ryBKUtw4RPAbaYEO06/KIukRWOgfCV8r1566a2oZcA8g5jh64K8tiMIngxiVKMfPWFk/o
	O4buMp+pGfLQ1auKnXjXBeKGwhjcdcuDfgo7XcFQ+dU/LwW62M6nwYfb0+l0dMH3c3csilv0HVh
	H9m6vSeNWd9YdEvd4IEUoUPmjolJbx8LtbMmFyBSeiSLy2xoJiiAgFixc6N9lBsySxXE5rPF9Cn
	7VJzz5BPFrOO4ZfYAM5FKdDgMB
X-Google-Smtp-Source: AGHT+IHR13kS9Xkl5lKqhOWSjFjHPOT387rdmCZYI2ka6CXMZys43BWJvlenRSGYCMl0pwJNT4YT/A==
X-Received: by 2002:a05:600c:c8f:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-477c01bc360mr4566355e9.17.1763684466857;
        Thu, 20 Nov 2025 16:21:06 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:05 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 09/13] ovpn: consolidate crypto allocations in one chunk
Date: Fri, 21 Nov 2025 01:20:40 +0100
Message-ID: <20251121002044.16071-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

Currently ovpn uses three separate dynamically allocated structures to
set up cryptographic operations for both encryption and decryption. This
adds overhead to performance-critical paths and contribute to memory
fragmentation.

This commit consolidates those allocations into a single temporary blob,
similar to what esp_alloc_tmp() does.

The resulting performance gain is +7.7% and +4.3% for UDP when using AES
and ChaChaPoly respectively, and +4.3% for TCP.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto_aead.c | 160 +++++++++++++++++++++++++--------
 drivers/net/ovpn/io.c          |   8 +-
 drivers/net/ovpn/skb.h         |  13 ++-
 3 files changed, 135 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index cb6cdf8ec317..cd723140c8d0 100644
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
+	DEBUG_NET_WARN_ON_ONCE(OVPN_NONCE_SIZE != crypto_aead_ivsize(tfm));
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
2.51.2


