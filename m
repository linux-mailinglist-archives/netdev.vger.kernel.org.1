Return-Path: <netdev+bounces-262014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDxkNz0xomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:05:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1881BF4FE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C25831AE1C8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67277258EFF;
	Sat, 28 Feb 2026 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JunLJ0hv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8E23EA9B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236834; cv=none; b=C2llxtHUZtOPyvKaeCMAwgsfvbxckeb8yZsGy053QDgZr8I0cD4VyhHHKYz+gFAgSp0B4A4M1OMUkwuP0gFioX4R511m+xIurBHlKyUm32nS/580eSBw+oLlUErzKGh4Q1MkDxfxsI9MKqAanfEicptCW4lbwifJhEfVt8FqVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236834; c=relaxed/simple;
	bh=AFP9NZ/vqopfXgtkXW92y3xf2b8sr19klfhl7CQ56Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coIR+9TmDFIKfjsUfUsoSteU9p3ZTtEYMRINms4x5pR9pBr7gDEgVuaD9+VdMfc1hUmLKKd2TtndZfXy8WIe3Ohmr9J74SeucVUrqvGi+EOrG3PmBFDMEvfpqWKiBQaqif8jPlnhb8hve5Er+wZYX3BX6ng11+HCiehCaTZd3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JunLJ0hv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48372efa020so20665105e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236830; x=1772841630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=JunLJ0hvIedYtrBwdHkr1Cc1b/y7SRFbKrmqXnuuUM/Pxc6i31Q+WlcJOC1F3VqNqy
         N0hGt4mxhwftNL/0tBRtQZKqf677CDaZpNV3xu9+CRNaJimbMxj3BIV2bW2fLKOwS/N0
         6lIOENg2ZqSTTocbCMaLESYf+GMTo3WW25kjWt4nMsA0kQo7WGH63ovVRK6rUVQ8xtHG
         mdOnn5tMUMNF/Ve3fg4295TFF64/tpRQqjN+ANnePtNrH2ZWTqYiOUpIs5HxPzmT0k1G
         ZZY/QxuoPOUHivsBky8c6kkhEt9K9qFCmrH3KY3534KVeLaW80uPpeHF+A/lTe7+kBPT
         h9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236830; x=1772841630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=BLPNZuM5/r5njr/GpRXEsljBR/4iAIHkBsQE/1e4XeWiIFYN+kieGIqgwdIH5O6Nfy
         ZdG+zvXLX4kAX4Zy3jSCjo3CTLAQAQDUYGVQBcpt6Sro2EGdPxeGCWHFRgwNVbaD/l/o
         9krB+ESBy/stXOnrnLGcXli00abc1EHOuacCS4wuxqi6Tr4L9pS/AbMtk5Z29L7n9Fqs
         Nk7IxGzTgjyS/KQyDatcjXFr1kDz8K6iBUmfUlA01M4pvDAIDKv9L7ty3yNeXZuV4QYx
         1d5xkgNIR4v23DFjYjyXou7N64x+mYQd3EEXhokc2iNepH5LUpPhBKDSf7T+zCQf4Y1G
         8RlQ==
X-Gm-Message-State: AOJu0Yw/E/vtE+EPzVL46HIQpbWFUJVy5mfH5Z4bBeB1B6MmfKWbISGv
	rMrUoHrXdlU/K+bIuH4Y6bAPuRbnIRvKpFnkTfjZWDTAUysDuTBeOBg2KQMGdg88r73BYV5DU/z
	KaBCEwHqyPFRIVWec0x6u8gPHBCoDNViQ6XLVp/5s+blsF+NXO8ajBkBmLGaeUwkH
X-Gm-Gg: ATEYQzzPv89ZeKhBatQD9aXS3KmbO+g5oHPwceyuE5OkIYrviY7gsZffc3/Ik3ko0v4
	II8DCC4++oNrBnc3dYQSBRE7j0CYezfbjn8Te4OSoxz+2TxiFPImlZAxRkpu3OApvFROaVq3hdr
	V9em2qcTbULxP/gkL55wmUYVuTXA2PGsD3WXG/pQp8oOwSHUDbXv+dZ3yrksDwc0tlw2chuP07n
	2H5t2LgqjE6Wd4hzlIlw/x97lLOreYv2kUyeE6cR8Ax6Q8+x+rO7hifpopSK8kxwEXgETqc8yEy
	6IFeHJaBh1icqUCEadS4tG9tlAmszwkyo9Gk1DR5PkfZfFT3/FN/2uz/4MA5leL0mDCDqHhkjLM
	y0W7wMN4prMMwxDKtv/9qgnmlpV53jGJx8AN5cIXCyzhBvjwM7n78aGx2Kj+hMp9i+tEdXCq2i3
	EOAD0smpnjPlq0/tDCZO7UJntgmfzYsd/thvaW
X-Received: by 2002:a05:600c:40cf:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-483ca84a984mr43364095e9.21.1772236830340;
        Fri, 27 Feb 2026 16:00:30 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:29 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 9/9] ovpn: consolidate crypto allocations in one chunk
Date: Sat, 28 Feb 2026 00:59:55 +0100
Message-ID: <20260227235955.660-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262014-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,mandelbit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 3D1881BF4FE
X-Rspamd-Action: no action

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


