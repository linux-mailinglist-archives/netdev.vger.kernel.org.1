Return-Path: <netdev+bounces-159405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E608EA15704
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B33E1882F8E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F891AA1DA;
	Fri, 17 Jan 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPrkCV/j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7711AA1C1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139003; cv=none; b=tqXCBKR3ICWv4AzTCRToQhgN2J/fnlNDSvXWjuDIg7MWr0eYt6k/6Nmp2jlWCCdp1VodcpSLxoPsgryWdq0ZuVhr57j159IWo3hWw3BFqxwzL488aO1JIcb7IoWh7rXryqCV3lX36heMlItKi86X+fvrxdiRtJZ/rDaZQJxvNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139003; c=relaxed/simple;
	bh=2x+uH/OBiPZrbTwSNjvlGUfqz+0cO1RFGukVf7ieGeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvvQviTrzfSqPOUdV07qFzKb/DZ4QZrTzhBzE9hOv2FRYT/9DFK67nRFDvGrIJeJLgGOuRDnSJGU8d/Pj8kB6F2Mk0wWzHH/BE0ZcurMhIWYQB5iFFvMLZUggqaetnccSw1kEuYYgwjz6oYMm6moBG024NHyPgvcyxWAPS6PqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPrkCV/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YdZKkAJTbkV6+q41EVpA6T2mU4du83xKSuI3GcUqqg=;
	b=ZPrkCV/jXAEblt/A1/8G9qKtHIjJeKhWQ6WPTPWs06x6PsuhLGfDdcmn7Kb4gZM9IAEjvH
	jlQnDX8uoRfXCIBZ/VH7WbN+9TC9X3Sxpr7p+EdN4coEFuc/vtYwhl8GEcI3XXAA7p4QvX
	AGA6fqmoQGutEQo+rWMNjvi3NP/wz7E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ybE6WTC3O4Wf5Df-n8Dopw-1; Fri,
 17 Jan 2025 13:36:36 -0500
X-MC-Unique: ybE6WTC3O4Wf5Df-n8Dopw-1
X-Mimecast-MFC-AGG-ID: ybE6WTC3O4Wf5Df-n8Dopw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 408511956083;
	Fri, 17 Jan 2025 18:36:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B685030001BE;
	Fri, 17 Jan 2025 18:36:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/24] crypto/krb5: Add an API to perform requests
Date: Fri, 17 Jan 2025 18:35:17 +0000
Message-ID: <20250117183538.881618-9-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add an API by which users of the krb5 crypto library can perform crypto
requests, such as encrypt, decrypt, get_mic and verify_mic.  These
functions take the previously prepared crypto objects to work on.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/krb5/krb5_api.c | 141 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h  |  21 ++++++
 2 files changed, 162 insertions(+)

diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index f7f2528b3895..8fc3a1b9d4ad 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -292,3 +292,144 @@ struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_checksum);
+
+/**
+ * crypto_krb5_encrypt - Apply Kerberos encryption and integrity.
+ * @krb5: The encoding to use.
+ * @aead: The keyed crypto object to use.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @sg_len: The size of the buffer.
+ * @data_offset: The offset of the data in the @sg buffer.
+ * @data_len: The length of the data.
+ * @preconfounded: True if the confounder is already inserted.
+ *
+ * Using the specified Kerberos encoding, insert a confounder and padding as
+ * needed, encrypt this and the data in place and insert an integrity checksum
+ * into the buffer.
+ *
+ * The buffer must include space for the confounder, the checksum and any
+ * padding required.  The caller can preinsert the confounder into the buffer
+ * (for testing, for example).
+ *
+ * The resulting secured blob may be less than the size of the buffer.
+ *
+ * Returns the size of the secure blob if successful, -ENOMEM on an allocation
+ * failure, -EFAULT if there is insufficient space, -EMSGSIZE if the confounder
+ * is too short or the data is misaligned.  Other errors may also be returned
+ * from the crypto layer.
+ */
+ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
+			    struct crypto_aead *aead,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len,
+			    bool preconfounded)
+{
+	if (WARN_ON(data_offset > sg_len ||
+		    data_len > sg_len ||
+		    data_offset > sg_len - data_len))
+		return -EMSGSIZE;
+	return krb5->profile->encrypt(krb5, aead, sg, nr_sg, sg_len,
+				      data_offset, data_len, preconfounded);
+}
+EXPORT_SYMBOL(crypto_krb5_encrypt);
+
+/**
+ * crypto_krb5_decrypt - Validate and remove Kerberos encryption and integrity.
+ * @krb5: The encoding to use.
+ * @aead: The keyed crypto object to use.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @_offset: Offset of the secure blob in the buffer; updated to data offset.
+ * @_len: The length of the secure blob; updated to data length.
+ *
+ * Using the specified Kerberos encoding, check and remove the integrity
+ * checksum and decrypt the secure region, stripping off the confounder.
+ *
+ * If successful, @_offset and @_len are updated to outline the region in which
+ * the data plus the trailing padding are stored.  The caller is responsible
+ * for working out how much padding there is and removing it.
+ *
+ * Returns the 0 if successful, -ENOMEM on an allocation failure; sets
+ * *_error_code and returns -EPROTO if the data cannot be parsed, or -EBADMSG
+ * if the integrity checksum doesn't match).  Other errors may also be returned
+ * from the crypto layer.
+ */
+int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
+			struct crypto_aead *aead,
+			struct scatterlist *sg, unsigned int nr_sg,
+			size_t *_offset, size_t *_len)
+{
+	return krb5->profile->decrypt(krb5, aead, sg, nr_sg, _offset, _len);
+}
+EXPORT_SYMBOL(crypto_krb5_decrypt);
+
+/**
+ * crypto_krb5_get_mic - Apply Kerberos integrity checksum.
+ * @krb5: The encoding to use.
+ * @shash: The keyed hash to use.
+ * @metadata: Metadata to add into the hash before adding the data.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @sg_len: The size of the buffer.
+ * @data_offset: The offset of the data in the @sg buffer.
+ * @data_len: The length of the data.
+ *
+ * Using the specified Kerberos encoding, calculate and insert an integrity
+ * checksum into the buffer.
+ *
+ * The buffer must include space for the checksum at the front.
+ *
+ * Returns the size of the secure blob if successful, -ENOMEM on an allocation
+ * failure, -EFAULT if there is insufficient space, -EMSGSIZE if the gap for
+ * the checksum is too short.  Other errors may also be returned from the
+ * crypto layer.
+ */
+ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
+			    struct crypto_shash *shash,
+			    const struct krb5_buffer *metadata,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len)
+{
+	if (WARN_ON(data_offset > sg_len ||
+		    data_len > sg_len ||
+		    data_offset > sg_len - data_len))
+		return -EMSGSIZE;
+	return krb5->profile->get_mic(krb5, shash, metadata, sg, nr_sg, sg_len,
+				      data_offset, data_len);
+}
+EXPORT_SYMBOL(crypto_krb5_get_mic);
+
+/**
+ * crypto_krb5_verify_mic - Validate and remove Kerberos integrity checksum.
+ * @krb5: The encoding to use.
+ * @shash: The keyed hash to use.
+ * @metadata: Metadata to add into the hash before adding the data.
+ * @sg: Scatterlist defining the crypto buffer.
+ * @nr_sg: The number of elements in @sg.
+ * @_offset: Offset of the secure blob in the buffer; updated to data offset.
+ * @_len: The length of the secure blob; updated to data length.
+ *
+ * Using the specified Kerberos encoding, check and remove the integrity
+ * checksum.
+ *
+ * If successful, @_offset and @_len are updated to outline the region in which
+ * the data is stored.
+ *
+ * Returns the 0 if successful, -ENOMEM on an allocation failure; sets
+ * *_error_code and returns -EPROTO if the data cannot be parsed, or -EBADMSG
+ * if the checksum doesn't match).  Other errors may also be returned from the
+ * crypto layer.
+ */
+int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
+			   struct crypto_shash *shash,
+			   const struct krb5_buffer *metadata,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t *_offset, size_t *_len)
+{
+	return krb5->profile->verify_mic(krb5, shash, metadata, sg, nr_sg,
+					 _offset, _len);
+}
+EXPORT_SYMBOL(crypto_krb5_verify_mic);
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 5ff052e2c157..4919e135b2ca 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -117,6 +117,27 @@ struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *kr
 struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb5,
 						  const struct krb5_buffer *TK,
 						  u32 usage, gfp_t gfp);
+ssize_t crypto_krb5_encrypt(const struct krb5_enctype *krb5,
+			    struct crypto_aead *aead,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len,
+			    bool preconfounded);
+int crypto_krb5_decrypt(const struct krb5_enctype *krb5,
+			struct crypto_aead *aead,
+			struct scatterlist *sg, unsigned int nr_sg,
+			size_t *_offset, size_t *_len);
+ssize_t crypto_krb5_get_mic(const struct krb5_enctype *krb5,
+			    struct crypto_shash *shash,
+			    const struct krb5_buffer *metadata,
+			    struct scatterlist *sg, unsigned int nr_sg,
+			    size_t sg_len,
+			    size_t data_offset, size_t data_len);
+int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
+			   struct crypto_shash *shash,
+			   const struct krb5_buffer *metadata,
+			   struct scatterlist *sg, unsigned int nr_sg,
+			   size_t *_offset, size_t *_len);
 
 /*
  * krb5enc.c


