Return-Path: <netdev+bounces-159406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC49A1570C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60163A9C32
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB11DF267;
	Fri, 17 Jan 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3Kh2MXx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9D1DF247
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139011; cv=none; b=hYmLoX5VBfiZkj/RnHo9Lqo9wH/5fAJWajMFkVwcE1AIkdGQktvNdZQQYKek3LdQQyy7rHtjw8MmeZ0sLyAF62kd7TcTYp6zFUVBxUE3ERlT39mV9kTRwKaVB8qJdAx2XwbSiOGdMQwyBaT5cQehlRhETCy3LeHjwimdtvVV6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139011; c=relaxed/simple;
	bh=9A3OUMamznf/+qYBw/6TAVDcwyCQr5xJZlVM4PcZTqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgHvoApolDrbvDvJ8g7slBLBrq8Ytr2Z6eVPw0cYlOACNDX7MyDEBr9j6n7kTO1//vHZOzB+ePCpC28s6FU04AS86n80KsGfv6iaeJ6lvgc0Eazdf7JXq4qwl44qANxmhLW0q1p+qU8dwXwf3dJCzpB8eQrOgEqfV/HjFTWGzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3Kh2MXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737139008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXWp1vvjwfTmEyG84br1Rzu5hNRYPyfl1lqo6p7XsRs=;
	b=Y3Kh2MXxElp/ZZDAjNnZn6Y1yOD4FpkWUovMKy5o16/uaQKxu3RykKJq3jxvzncGrp3bm2
	2SQFXtDIs1xmWwxWK5/ropFuows9Qe/iCXQPeYqnG1s88k4ObNwcAaJyKude6h0MX6sLq0
	aRl2DK5X4P0fSBJTON2FrGW9oC5WArw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-DoHzStYGOnqQVAGfQCPRDQ-1; Fri,
 17 Jan 2025 13:36:43 -0500
X-MC-Unique: DoHzStYGOnqQVAGfQCPRDQ-1
X-Mimecast-MFC-AGG-ID: DoHzStYGOnqQVAGfQCPRDQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9B81955D81;
	Fri, 17 Jan 2025 18:36:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFA2F195608A;
	Fri, 17 Jan 2025 18:36:35 +0000 (UTC)
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
Subject: [RFC PATCH 09/24] crypto/krb5: Provide infrastructure and key derivation
Date: Fri, 17 Jan 2025 18:35:18 +0000
Message-ID: <20250117183538.881618-10-dhowells@redhat.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
References: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Provide key derivation interface functions and a helper to implement the
PRF+ function from rfc4402.

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
 crypto/krb5/Makefile   |   1 +
 crypto/krb5/internal.h |  10 +++
 crypto/krb5/krb5_kdf.c | 145 +++++++++++++++++++++++++++++++++++++++++
 include/crypto/krb5.h  |  10 +++
 4 files changed, 166 insertions(+)
 create mode 100644 crypto/krb5/krb5_kdf.c

diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index c450d0754772..8c2050af8fed 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -4,6 +4,7 @@
 #
 
 krb5-y += \
+	krb5_kdf.o \
 	krb5_api.o
 
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index b542d24e5fa5..50abda5169c7 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -120,3 +120,13 @@ struct crypto_aead *krb5_prepare_encryption(const struct krb5_enctype *krb5,
 struct crypto_shash *krb5_prepare_checksum(const struct krb5_enctype *krb5,
 					   const struct krb5_buffer *Kc,
 					   gfp_t gfp);
+
+/*
+ * krb5_kdf.c
+ */
+int krb5_derive_Kc(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
+int krb5_derive_Ke(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
+int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp);
diff --git a/crypto/krb5/krb5_kdf.c b/crypto/krb5/krb5_kdf.c
new file mode 100644
index 000000000000..6699e5469d1b
--- /dev/null
+++ b/crypto/krb5/krb5_kdf.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Kerberos key derivation.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+#include "internal.h"
+
+/**
+ * crypto_krb5_calc_PRFplus - Calculate PRF+ [RFC4402]
+ * @krb5: The encryption type to use
+ * @K: The protocol key for the pseudo-random function
+ * @L: The length of the output
+ * @S: The input octet string
+ * @result: Result buffer, sized to krb5->prf_len
+ * @gfp: Allocation restrictions
+ *
+ * Calculate the kerberos pseudo-random function, PRF+() by the following
+ * method:
+ *
+ *      PRF+(K, L, S) = truncate(L, T1 || T2 || .. || Tn)
+ *      Tn = PRF(K, n || S)
+ *      [rfc4402 sec 2]
+ */
+int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
+			     const struct krb5_buffer *K,
+			     unsigned int L,
+			     const struct krb5_buffer *S,
+			     struct krb5_buffer *result,
+			     gfp_t gfp)
+{
+	struct krb5_buffer T_series, Tn, n_S;
+	void *buffer;
+	int ret, n = 1;
+
+	Tn.len = krb5->prf_len;
+	T_series.len = 0;
+	n_S.len = 4 + S->len;
+
+	buffer = kzalloc(round16(L + Tn.len) + round16(n_S.len), gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	T_series.data = buffer;
+	n_S.data = buffer + round16(L + Tn.len);
+	memcpy(n_S.data + 4, S->data, S->len);
+
+	while (T_series.len < L) {
+		*(__be32 *)(n_S.data) = htonl(n);
+		Tn.data = T_series.data + Tn.len * (n - 1);
+		ret = krb5->profile->calc_PRF(krb5, K, &n_S, &Tn, gfp);
+		if (ret < 0)
+			goto err;
+		T_series.len += Tn.len;
+		n++;
+	}
+
+	/* Truncate to L */
+	memcpy(result->data, T_series.data, L);
+	ret = 0;
+
+err:
+	kfree_sensitive(buffer);
+	return ret;
+}
+EXPORT_SYMBOL(crypto_krb5_calc_PRFplus);
+
+/**
+ * krb5_derive_Kc - Derive key Kc and install into a hash
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Kc checksumming key.  The key is stored into the
+ * prepared buffer.
+ */
+int krb5_derive_Kc(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_CHECKSUM;
+
+	key->len = krb5->Kc_len;
+	return krb5->profile->calc_Kc(krb5, TK, &usage_constant, key, gfp);
+}
+
+/**
+ * krb5_derive_Ke - Derive key Ke and install into an skcipher
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Ke encryption key.  The key is stored into the prepared
+ * buffer.
+ */
+int krb5_derive_Ke(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_ENCRYPTION;
+
+	key->len = krb5->Ke_len;
+	return krb5->profile->calc_Ke(krb5, TK, &usage_constant, key, gfp);
+}
+
+/**
+ * krb5_derive_Ki - Derive key Ki and install into a hash
+ * @krb5: The encryption type to use
+ * @TK: The base key
+ * @usage: The key usage number
+ * @key: Prepped buffer to store the key into
+ * @gfp: Allocation restrictions
+ *
+ * Derive the Kerberos Ki integrity checksum key.  The key is stored into the
+ * prepared buffer.
+ */
+int krb5_derive_Ki(const struct krb5_enctype *krb5, const struct krb5_buffer *TK,
+		   u32 usage, struct krb5_buffer *key, gfp_t gfp)
+{
+	u8 buf[5] __aligned(CRYPTO_MINALIGN);
+	struct krb5_buffer usage_constant = { .len = 5, .data = buf };
+
+	*(__be32 *)buf = cpu_to_be32(usage);
+	buf[4] = KEY_USAGE_SEED_INTEGRITY;
+
+	key->len = krb5->Ki_len;
+	return krb5->profile->calc_Ki(krb5, TK, &usage_constant, key, gfp);
+}
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index 4919e135b2ca..a24d9ee53675 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -139,6 +139,16 @@ int crypto_krb5_verify_mic(const struct krb5_enctype *krb5,
 			   struct scatterlist *sg, unsigned int nr_sg,
 			   size_t *_offset, size_t *_len);
 
+/*
+ * krb5_kdf.c
+ */
+int crypto_krb5_calc_PRFplus(const struct krb5_enctype *krb5,
+			     const struct krb5_buffer *K,
+			     unsigned int L,
+			     const struct krb5_buffer *S,
+			     struct krb5_buffer *result,
+			     gfp_t gfp);
+
 /*
  * krb5enc.c
  */


