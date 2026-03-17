Return-Path: <netdev+bounces-268549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB72KxEwuWkYuAEAu9opvQ
	(envelope-from <netdev+bounces-268549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:42:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD592A826B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B59B3071C37
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33E3A7F4E;
	Tue, 17 Mar 2026 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cTU7LoI9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1C3A872E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744043; cv=none; b=KRTb5XPbtavZVAjwTrCbjPss/V9N27fcV3w+7cSrJ32qXxd5jwE0V9tMCunnahPuwcGqDxhwAxNaKaoh3afbBSwzeDJrG0LXvyg7/HbhaSqOzMBQLYok1zjFhtRdKE7KyoGx1RqhPwouauuduVYruYboMdoTw59nab98OSAZ2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744043; c=relaxed/simple;
	bh=AFP9NZ/vqopfXgtkXW92y3xf2b8sr19klfhl7CQ56Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAnEPk6KXKQURRfXo1k0Ox4GcN++07TK9XO+9numPHsSq9GsGLAVwEQ/ABy02gHa9KUx4tnEyXwITmrlItJsMsSURvvqFWYejyN8fIJuOLnhmWX7M8H9iu6Mrm2iY7rlq6syhifkauHF3dUJ7KnWUv20/yZlKWqxshs4mo5YejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cTU7LoI9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b45bb7548so1362179f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744039; x=1774348839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=cTU7LoI9Dd0wZCRQWPUIhStCG3wHn8ANv8kL3CrmhPwQuWVF+c50PxoLpoQQj2PWoj
         fZUqREbarjFNr0iG7fSU6aIzNc90QN7v7QyczSyElFc6g+iP+Wj3psEP9ddQ5RtA1Zd5
         hXjbXb3ytq54Ww8FNkCw7KymZJsMxGTYDuzywK49X5hHxB3C4p/t6gdY3LSgD9vjKsQ1
         ModvpQJ03uKbT5RQZqISgHliUEv2q6QWbwfbE/UvAB28WDbM+49Vme8fsmQbR8t9JuTT
         qOevc4PdEPYbb4McfxitZ379bD2uhCDwSZPB0vfez4vQBp2Jv3NnmzviqcBj4N5nePzB
         GIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744039; x=1774348839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPEi0ax5mTDuEvjQZIR/MRm1RUNDHNmjGN20GR2EhTI=;
        b=DE0hrg3CuYYqQ20NbueioDZxd3AtcM7+Ncaww53bgAnIse9WvJdnqJnfAQcm3qYV6u
         WvTTiAZslXYoklIRv5PyNmvgKXMKwC27i/7NHNLuKyL7CMMpfQu5nWnUPX1ldy1kxMMF
         UwVrUjcSznqQnWxoeIO99zBDe1Y+C+GYXI0YlzXI1NZL4Q+yYQReuZ4G2Drj5001vgJ7
         lpGPKRD/O8bFwgKcNnP0eJZv0peeAYyDF1+hqU6GiBDi9qPjwKmPhUhQEWHUc5Y8b1dK
         o+eBZ3J4Wt8amHK/AJnQTiXt2S+KE6m2/66JBBy+m+Aw2gGN+hv/TBDbvNqtnXbYirvq
         lKAg==
X-Gm-Message-State: AOJu0Yzm/LP/4ZXErGcSnTd6ESqh6owCd5Weealqs2ZOepLY09DQZCx/
	h4mKn82vtqObGvvDrLGwdEBnQ9A3yhg9vE4j3XlSVu5EtWX5I39nW1wgHiMBhnU23fNNSxtNa4K
	kFVE/d541hPPZ5d5iXRgrvFK/+tuiV3agT5/k6PSErCQuCNVEbIg4wiYkMi2B/ZAn
X-Gm-Gg: ATEYQzzllKZp7Mb/zP9R6VnqveRb9qNu/cqnW77q+3i3bUtTktOnGtJ1xJw/AAHvn0+
	nPd54PaKJZSMUtpaZAaOaICoLXZCG6jZLEZt4upKkrwqmCvfqBNtuFvR/9ENICRIzx431fzAbQF
	oePTtXuV+IjgHBHSo4jW33+bA0jQeWseLQvXl+mTBYmBSUQlYkdLN2uIzVy4GQ1lSycD4o89Ni1
	n7FnKlQOf7sBVEdlvHThBUTlkufyGnx+rZ5pdaHDKei7XP386wmSVp6PRx1eqEIxubs41TFDQh1
	ThNLpm4HKPaBWQIFsNBaeNCMBGnj3SM/CBEifvocthum8TRaVIbXWiq7X0PmBHgN8A6WeQ5mQl4
	lr3IuO9JXyVNRjrAPH+Zie7DT688LQHG8TbnREnKwnxrqsIfzzSgAmWaiKUsb/dG6RAG2aUvZFQ
	Z3ByLu94gLD2NSpdCWe7UYhnbPq0gEa6N01jM=
X-Received: by 2002:a5d:6703:0:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-43b41362828mr11105464f8f.38.1773744039122;
        Tue, 17 Mar 2026 03:40:39 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:38 -0700 (PDT)
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
Date: Tue, 17 Mar 2026 11:40:23 +0100
Message-ID: <20260317104023.192548-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268549-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mandelbit.com:email,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: 3BD592A826B
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


