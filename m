Return-Path: <netdev+bounces-204334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13724AFA191
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F97F487401
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF122D4C0;
	Sat,  5 Jul 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixw6LPG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A562264B3;
	Sat,  5 Jul 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744342; cv=none; b=o+LJytaV56mDsK7MEcYsIzqoUzJa5M2KyiLElNJBqhqPArgp71RVi0knPPaMHbEGMMeOCRAgebbCSyICseYSoX6uF97J6lfm9o5NRKhTMrMH8x4Ue/7ZCDWNEhCF46b3hiYerkl1O11ZSsdqkTMqvIPfC7jun6TlJjJOXuT6kzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744342; c=relaxed/simple;
	bh=uErXh4A93eXqs2i7UcbJfS1fWWfWN6Ca3LQ7FfOnKgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PivaoNwSYCrUUajW869thWXvvgmp+aM2UwxHFwtyY2gttmZUFJVALi+a9ygCnYniQqQ5sLxVgXpQe2cvaBRe1bd9lBjTWtlUc2uResoO4MVGlm1zmAEACQqp1kuJrz3u3swrwSeuD/u/2BRPAHO0hRG1iuhkPS0DTBSpIp4dyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixw6LPG+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fada2dd785so31236056d6.2;
        Sat, 05 Jul 2025 12:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744339; x=1752349139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPWO72PaiVsoHeBogeBW8O1NAyumqREs2K2SC8y0s6A=;
        b=Ixw6LPG+nkHarJ2/42A5R+tXo920019HP0+HQ9OxkIYeI3MAxfWBCxW3dkODQljSCD
         /m0YVjXTXCypcXEwPl8V4nf/YIe8rO/wp/+cirlN2OFH5h6xVSBKpp6Jy0CpgmUcYD/U
         k3FTwK0jAnj1VdPpDmDMU5Q6NTJLRzhjiZTAwpTmQq4Gnxbw/S3En8n+goqo1zhEDojy
         CK+REOVBPzGJapAK+Xv03//JHRimHgiQLThCUuhu1egqXBvmtQnTS/LBoUfFotgtXL6w
         yNWAwul1YYlH6/svrAjgbWgYEgZUXagsq1U4Rxon/BfyfuOTANwgR12XdE1BHy+lT4LG
         OX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744339; x=1752349139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPWO72PaiVsoHeBogeBW8O1NAyumqREs2K2SC8y0s6A=;
        b=APMHdXdb9I6T9Xc9lfIUS6FYyX3cQyUlHbHJwgllp7XR5VznXaaSxCK6FtqsFaW/7u
         TW7Kr2NMWX/LjBOKgNglXfmqupo9E3yA1lR904ruV7eqHWokMxg8oDStaM/wycZ9UCrm
         DE+gi5SPovWyeXktIal+1bDyYP4OIddbRgAgflIjBW/ryt0PnYzOrf/d4ZQICI4u/lH6
         SOAWcU4RJJoWqOVnXvdrOKXzSDRQNCIzu4bm2ulr5F91rgPVMQKp7GiCAV/drG5w9Z0r
         nnLLvGyY4FHrakJo4u8YO1KxXNrIgwYKKlwstyej+eg1DHW1rdcrguloffbq7y6pd449
         NIhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0wJmIxi9MzRj6MUCSJhg5jd8+xmL0FOHvogRnBJQ8MZ5SAxsGXjfbK0q67OwCU6piRNP0CD3I4nzv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90awDTRIHVzF1c793FCmK0Fo37RA0qsLAeW+Jw/FeqYwibbCt
	HqYvISwSUHTTCuKM8wcbJQfbY9lLUQfRiZTAe43HmxXg5qwMrVIUAluJ+bISuBzBGK4=
X-Gm-Gg: ASbGncus/zgxKMFBfbrsH2SY2/Avei1f47jw/Tiu4c+FfTnVnj1tDPjguaTikR3PD1Y
	7ulLiuPXB4F7HTZlkebgO4xb7pbxbeuraij4Ymq8o+KoKJ1a1qSTjW7vfZzy+7JVFhC87LNYEQV
	rqu3gcdkQZlwM2Ed7F4kjH8ZkNVWA2E3Jx/OyjhthiTLWD584y6kVI9Nkr8s2bTjzA7ur6Q7qVE
	OoD/AnH9y0KexKiOka8Iz3X5P9ObfLssSjCczIdxiKXXPet+N/uOnVABYOpHqbxoH2frhL1uS8L
	yzu0/DjbDfivzG/Z9YPGqZ6ottAajaQrlkWJ6PLU7g4Kp9V+qDWYKENAyaJYVPGdV3mpaTopGF/
	310I8IaLhK15d6AaptQLeXXjC2cI=
X-Google-Smtp-Source: AGHT+IH8/BokDCP9cd6WnwL4vMZGykAzZII/V6M62xoqxsJkIzgIzRs+/yGg8wvscrqaLAxpLUnXUw==
X-Received: by 2002:ad4:5963:0:b0:6fa:c246:c363 with SMTP id 6a1803df08f44-702c6d06bc5mr94226826d6.13.1751744338854;
        Sat, 05 Jul 2025 12:38:58 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d6019csm32999146d6.106.2025.07.05.12.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:38:58 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 11/15] quic: add crypto key derivation and installation
Date: Sat,  5 Jul 2025 15:31:50 -0400
Message-ID: <a28a11638c32b384b72b51b8aa1b2468568106ef.1751743914.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1751743914.git.lucien.xin@gmail.com>
References: <cover.1751743914.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces 'quic_crypto', a component responsible for QUIC
encryption key derivation and installation across the various key
levels: Initial, Handshake, 0-RTT (Early), and 1-RTT (Application).

It provides helpers to derive and install initial secrets, set traffic
secrets and install the corresponding keys, and perform key updates to
enable forward secrecy. Additionally, it implements stateless reset
token generation, used to support connection reset without state.

- quic_crypto_initial_keys_install(): Derive and install initial keys.

- quic_crypto_set_cipher(): Allocate all transforms based on the cipher
  type provided.

- quic_crypto_set_secret(): Set the traffic secret and install derived
  keys.

- quic_crypto_key_update(): Rekey and install new keys to the !phase
  side.

- quic_crypto_generate_stateless_reset_token(): Generate token for
  stateless reset.

These mechanisms are essential for establishing and maintaining secure
communication throughout the QUIC connection lifecycle.

Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
Signed-off-by: Moritz Buhl <mbuhl@openbsd.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/quic/Makefile   |   2 +-
 net/quic/crypto.c   | 545 ++++++++++++++++++++++++++++++++++++++++++++
 net/quic/crypto.h   |  73 ++++++
 net/quic/protocol.c |  12 +
 net/quic/protocol.h |   2 +
 net/quic/socket.c   |   2 +
 net/quic/socket.h   |   7 +
 7 files changed, 642 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/crypto.c
 create mode 100644 net/quic/crypto.h

diff --git a/net/quic/Makefile b/net/quic/Makefile
index 9d8e18297911..58bb18f7926d 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_IP_QUIC) += quic.o
 
 quic-y := common.o family.o protocol.o socket.o stream.o connid.o path.o \
-	  cong.o pnspace.o
+	  cong.o pnspace.o crypto.o
diff --git a/net/quic/crypto.c b/net/quic/crypto.c
new file mode 100644
index 000000000000..a90b686357f6
--- /dev/null
+++ b/net/quic/crypto.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include <crypto/skcipher.h>
+#include <linux/skbuff.h>
+#include <crypto/aead.h>
+#include <crypto/hkdf.h>
+#include <linux/quic.h>
+#include <net/tls.h>
+
+#include "common.h"
+#include "crypto.h"
+
+#define QUIC_RANDOM_DATA_LEN	32
+
+static u8 quic_random_data[QUIC_RANDOM_DATA_LEN] __read_mostly;
+
+/* HKDF-Extract. */
+static int quic_crypto_hkdf_extract(struct crypto_shash *tfm, struct quic_data *srt,
+				    struct quic_data *hash, struct quic_data *key)
+{
+	return hkdf_extract(tfm, hash->data, hash->len, srt->data, srt->len, key->data);
+}
+
+#define QUIC_MAX_INFO_LEN	256
+
+/* HKDF-Expand-Label. */
+static int quic_crypto_hkdf_expand(struct crypto_shash *tfm, struct quic_data *srt,
+				   struct quic_data *label, struct quic_data *hash,
+				   struct quic_data *key)
+{
+	u8 info[QUIC_MAX_INFO_LEN], *p = info;
+	u8 LABEL[] = "tls13 ";
+	u32 infolen;
+	int err;
+
+	/* rfc8446#section-7.1:
+	 *
+	 *  HKDF-Expand-Label(Secret, Label, Context, Length) =
+	 *       HKDF-Expand(Secret, HkdfLabel, Length)
+	 *
+	 *  Where HkdfLabel is specified as:
+	 *
+	 *  struct {
+	 *      uint16 length = Length;
+	 *      opaque label<7..255> = "tls13 " + Label;
+	 *      opaque context<0..255> = Context;
+	 *  } HkdfLabel;
+	 */
+	*p++ = (u8)(key->len / QUIC_MAX_INFO_LEN);
+	*p++ = (u8)(key->len % QUIC_MAX_INFO_LEN);
+	*p++ = (u8)(sizeof(LABEL) - 1 + label->len);
+	p = quic_put_data(p, LABEL, sizeof(LABEL) - 1);
+	p = quic_put_data(p, label->data, label->len);
+	if (hash) {
+		*p++ = (u8)hash->len;
+		p = quic_put_data(p, hash->data, hash->len);
+	} else {
+		*p++ = 0;
+	}
+	infolen = (u32)(p - info);
+
+	err = crypto_shash_setkey(tfm, srt->data, srt->len);
+	if (err)
+		return err;
+
+	return hkdf_expand(tfm, info, infolen, key->data, key->len);
+}
+
+#define KEY_LABEL_V1		"quic key"
+#define IV_LABEL_V1		"quic iv"
+#define HP_KEY_LABEL_V1		"quic hp"
+
+#define KU_LABEL_V1		"quic ku"
+
+/* rfc9369#section-3.3.2:
+ *
+ * The labels used in rfc9001 to derive packet protection keys, header protection keys, Retry
+ * Integrity Tag keys, and key updates change from "quic key" to "quicv2 key", from "quic iv"
+ * to "quicv2 iv", from "quic hp" to "quicv2 hp", and from "quic ku" to "quicv2 ku".
+ */
+#define KEY_LABEL_V2		"quicv2 key"
+#define IV_LABEL_V2		"quicv2 iv"
+#define HP_KEY_LABEL_V2		"quicv2 hp"
+
+#define KU_LABEL_V2		"quicv2 ku"
+
+/* Packet Protection Keys. */
+static int quic_crypto_keys_derive(struct crypto_shash *tfm, struct quic_data *s,
+				   struct quic_data *k, struct quic_data *i,
+				   struct quic_data *hp_k, u32 version)
+{
+	struct quic_data hp_k_l = {HP_KEY_LABEL_V1, strlen(HP_KEY_LABEL_V1)};
+	struct quic_data k_l = {KEY_LABEL_V1, strlen(KEY_LABEL_V1)};
+	struct quic_data i_l = {IV_LABEL_V1, strlen(IV_LABEL_V1)};
+	struct quic_data z = {};
+	int err;
+
+	/* rfc9001#section-5.1:
+	 *
+	 * The current encryption level secret and the label "quic key" are input to the
+	 * KDF to produce the AEAD key; the label "quic iv" is used to derive the
+	 * Initialization Vector (IV). The header protection key uses the "quic hp" label.
+	 * Using these labels provides key separation between QUIC and TLS.
+	 */
+	if (version == QUIC_VERSION_V2) {
+		quic_data(&hp_k_l, HP_KEY_LABEL_V2, strlen(HP_KEY_LABEL_V2));
+		quic_data(&k_l, KEY_LABEL_V2, strlen(KEY_LABEL_V2));
+		quic_data(&i_l, IV_LABEL_V2, strlen(IV_LABEL_V2));
+	}
+
+	err = quic_crypto_hkdf_expand(tfm, s, &k_l, &z, k);
+	if (err)
+		return err;
+	err = quic_crypto_hkdf_expand(tfm, s, &i_l, &z, i);
+	if (err)
+		return err;
+	/* Don't change hp key for key update. */
+	if (!hp_k)
+		return 0;
+
+	return quic_crypto_hkdf_expand(tfm, s, &hp_k_l, &z, hp_k);
+}
+
+/* Derive and install transmission (TX) packet protection keys for the current key phase.
+ * This involves generating AEAD encryption key, IV, and optionally header protection key.
+ */
+static int quic_crypto_tx_keys_derive_and_install(struct quic_crypto *crypto)
+{
+	struct quic_data srt = {}, k, iv, hp_k = {}, *hp = NULL;
+	u8 tx_key[QUIC_KEY_LEN], tx_hp_key[QUIC_KEY_LEN];
+	int err, phase = crypto->key_phase;
+	u32 keylen, ivlen = QUIC_IV_LEN;
+
+	keylen = crypto->cipher->keylen;
+	quic_data(&srt, crypto->tx_secret, crypto->cipher->secretlen);
+	quic_data(&k, tx_key, keylen);
+	quic_data(&iv, crypto->tx_iv[phase], ivlen);
+	/* Only derive header protection key when not in key update. */
+	if (!crypto->key_pending)
+		hp = quic_data(&hp_k, tx_hp_key, keylen);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(crypto->tx_tfm[phase], QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(crypto->tx_tfm[phase], tx_key, keylen);
+	if (err)
+		return err;
+	if (hp) {
+		err = crypto_skcipher_setkey(crypto->tx_hp_tfm, tx_hp_key, keylen);
+		if (err)
+			return err;
+	}
+	pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.data, iv.data, hp_k.data);
+	return 0;
+}
+
+/* Derive and install reception (RX) packet protection keys for the current key phase.
+ * This installs AEAD decryption key, IV, and optionally header protection key.
+ */
+static int quic_crypto_rx_keys_derive_and_install(struct quic_crypto *crypto)
+{
+	struct quic_data srt = {}, k, iv, hp_k = {}, *hp = NULL;
+	u8 rx_key[QUIC_KEY_LEN], rx_hp_key[QUIC_KEY_LEN];
+	int err, phase = crypto->key_phase;
+	u32 keylen, ivlen = QUIC_IV_LEN;
+
+	keylen = crypto->cipher->keylen;
+	quic_data(&srt, crypto->rx_secret, crypto->cipher->secretlen);
+	quic_data(&k, rx_key, keylen);
+	quic_data(&iv, crypto->rx_iv[phase], ivlen);
+	/* Only derive header protection key when not in key update. */
+	if (!crypto->key_pending)
+		hp = quic_data(&hp_k, rx_hp_key, keylen);
+	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
+	if (err)
+		return err;
+	err = crypto_aead_setauthsize(crypto->rx_tfm[phase], QUIC_TAG_LEN);
+	if (err)
+		return err;
+	err = crypto_aead_setkey(crypto->rx_tfm[phase], rx_key, keylen);
+	if (err)
+		return err;
+	if (hp) {
+		err = crypto_skcipher_setkey(crypto->rx_hp_tfm, rx_hp_key, keylen);
+		if (err)
+			return err;
+	}
+	pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.data, iv.data, hp_k.data);
+	return 0;
+}
+
+#define QUIC_CIPHER_MIN TLS_CIPHER_AES_GCM_128
+#define QUIC_CIPHER_MAX TLS_CIPHER_CHACHA20_POLY1305
+
+#define TLS_CIPHER_AES_GCM_128_SECRET_SIZE		32
+#define TLS_CIPHER_AES_GCM_256_SECRET_SIZE		48
+#define TLS_CIPHER_AES_CCM_128_SECRET_SIZE		32
+#define TLS_CIPHER_CHACHA20_POLY1305_SECRET_SIZE	32
+
+#define CIPHER_DESC(type, aead_name, skc_name, sha_name)[type - QUIC_CIPHER_MIN] = { \
+	.secretlen = type ## _SECRET_SIZE, \
+	.keylen = type ## _KEY_SIZE, \
+	.aead = aead_name, \
+	.skc = skc_name, \
+	.shash = sha_name, \
+}
+
+static struct quic_cipher ciphers[QUIC_CIPHER_MAX + 1 - QUIC_CIPHER_MIN] = {
+	CIPHER_DESC(TLS_CIPHER_AES_GCM_128, "gcm(aes)", "ecb(aes)", "hmac(sha256)"),
+	CIPHER_DESC(TLS_CIPHER_AES_GCM_256, "gcm(aes)", "ecb(aes)", "hmac(sha384)"),
+	CIPHER_DESC(TLS_CIPHER_AES_CCM_128, "ccm(aes)", "ecb(aes)", "hmac(sha256)"),
+	CIPHER_DESC(TLS_CIPHER_CHACHA20_POLY1305,
+		    "rfc7539(chacha20,poly1305)", "chacha20", "hmac(sha256)"),
+};
+
+int quic_crypto_set_cipher(struct quic_crypto *crypto, u32 type, u8 flag)
+{
+	struct quic_cipher *cipher;
+	int err = -EINVAL;
+	void *tfm;
+
+	if (type < QUIC_CIPHER_MIN || type > QUIC_CIPHER_MAX)
+		return -EINVAL;
+
+	cipher = &ciphers[type - QUIC_CIPHER_MIN];
+	tfm = crypto_alloc_shash(cipher->shash, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+	crypto->secret_tfm = tfm;
+
+	/* Request only synchronous crypto by specifying CRYPTO_ALG_ASYNC.  This
+	 * ensures tag generation does not rely on async callbacks.
+	 */
+	tfm = crypto_alloc_aead(cipher->aead, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tag_tfm = tfm;
+
+	/* Allocate AEAD and HP transform for each RX key phase. */
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->rx_tfm[0] = tfm;
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->rx_tfm[1] = tfm;
+	tfm = crypto_alloc_sync_skcipher(cipher->skc, 0, 0);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->rx_hp_tfm = tfm;
+
+	/* Allocate AEAD and HP transform for each TX key phase. */
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_tfm[0] = tfm;
+	tfm = crypto_alloc_aead(cipher->aead, 0, flag);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_tfm[1] = tfm;
+	tfm = crypto_alloc_sync_skcipher(cipher->skc, 0, 0);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		goto err;
+	}
+	crypto->tx_hp_tfm = tfm;
+
+	crypto->cipher = cipher;
+	crypto->cipher_type = type;
+	return 0;
+err:
+	quic_crypto_free(crypto);
+	return err;
+}
+
+int quic_crypto_set_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt,
+			   u32 version, u8 flag)
+{
+	int err;
+
+	/* If no cipher has been initialized yet, set it up. */
+	if (!crypto->cipher) {
+		err = quic_crypto_set_cipher(crypto, srt->type, flag);
+		if (err)
+			return err;
+	}
+
+	/* Handle RX path setup. */
+	if (!srt->send) {
+		crypto->version = version;
+		memcpy(crypto->rx_secret, srt->secret, crypto->cipher->secretlen);
+		err = quic_crypto_rx_keys_derive_and_install(crypto);
+		if (err)
+			return err;
+		crypto->recv_ready = 1;
+		return 0;
+	}
+
+	/* Handle TX path setup. */
+	crypto->version = version;
+	memcpy(crypto->tx_secret, srt->secret, crypto->cipher->secretlen);
+	err = quic_crypto_tx_keys_derive_and_install(crypto);
+	if (err)
+		return err;
+	crypto->send_ready = 1;
+	return 0;
+}
+
+int quic_crypto_get_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt)
+{
+	u8 *secret;
+
+	if (!crypto->cipher)
+		return -EINVAL;
+	srt->type = crypto->cipher_type;
+	secret = srt->send ? crypto->tx_secret : crypto->rx_secret;
+	memcpy(srt->secret, secret, crypto->cipher->secretlen);
+	return 0;
+}
+
+/* Initiating a Key Update. */
+int quic_crypto_key_update(struct quic_crypto *crypto)
+{
+	u8 tx_secret[QUIC_SECRET_LEN], rx_secret[QUIC_SECRET_LEN];
+	struct quic_data l = {KU_LABEL_V1, strlen(KU_LABEL_V1)};
+	struct quic_data z = {}, k, srt;
+	u32 secret_len;
+	int err;
+
+	if (crypto->key_pending || !crypto->recv_ready)
+		return -EINVAL;
+
+	/* rfc9001#section-6.1:
+	 *
+	 * Endpoints maintain separate read and write secrets for packet protection. An
+	 * endpoint initiates a key update by updating its packet protection write secret
+	 * and using that to protect new packets. The endpoint creates a new write secret
+	 * from the existing write secret. This uses the KDF function provided by TLS with
+	 * a label of "quic ku". The corresponding key and IV are created from that
+	 * secret. The header protection key is not updated.
+	 *
+	 * For example,to update write keys with TLS 1.3, HKDF-Expand-Label is used as:
+	 *   secret_<n+1> = HKDF-Expand-Label(secret_<n>, "quic ku",
+	 *                                    "", Hash.length)
+	 */
+	secret_len = crypto->cipher->secretlen;
+	if (crypto->version == QUIC_VERSION_V2)
+		quic_data(&l, KU_LABEL_V2, strlen(KU_LABEL_V2));
+
+	crypto->key_pending = 1;
+	memcpy(tx_secret, crypto->tx_secret, secret_len);
+	memcpy(rx_secret, crypto->rx_secret, secret_len);
+	crypto->key_phase = !crypto->key_phase;
+
+	quic_data(&srt, tx_secret, secret_len);
+	quic_data(&k, crypto->tx_secret, secret_len);
+	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &srt, &l, &z, &k);
+	if (err)
+		goto err;
+	err = quic_crypto_tx_keys_derive_and_install(crypto);
+	if (err)
+		goto err;
+
+	quic_data(&srt, rx_secret, secret_len);
+	quic_data(&k, crypto->rx_secret, secret_len);
+	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &srt, &l, &z, &k);
+	if (err)
+		goto err;
+	err = quic_crypto_rx_keys_derive_and_install(crypto);
+	if (err)
+		goto err;
+	return 0;
+err:
+	crypto->key_pending = 0;
+	memcpy(crypto->tx_secret, tx_secret, secret_len);
+	memcpy(crypto->rx_secret, rx_secret, secret_len);
+	crypto->key_phase = !crypto->key_phase;
+	return err;
+}
+
+void quic_crypto_free(struct quic_crypto *crypto)
+{
+	if (crypto->tag_tfm)
+		crypto_free_aead(crypto->tag_tfm);
+	if (crypto->rx_tfm[0])
+		crypto_free_aead(crypto->rx_tfm[0]);
+	if (crypto->rx_tfm[1])
+		crypto_free_aead(crypto->rx_tfm[1]);
+	if (crypto->tx_tfm[0])
+		crypto_free_aead(crypto->tx_tfm[0]);
+	if (crypto->tx_tfm[1])
+		crypto_free_aead(crypto->tx_tfm[1]);
+	if (crypto->secret_tfm)
+		crypto_free_shash(crypto->secret_tfm);
+	if (crypto->rx_hp_tfm)
+		crypto_free_skcipher(crypto->rx_hp_tfm);
+	if (crypto->tx_hp_tfm)
+		crypto_free_skcipher(crypto->tx_hp_tfm);
+
+	memset(crypto, 0, offsetof(struct quic_crypto, send_offset));
+}
+
+#define QUIC_INITIAL_SALT_V1    \
+	"\x38\x76\x2c\xf7\xf5\x59\x34\xb3\x4d\x17\x9a\xe6\xa4\xc8\x0c\xad\xcc\xbb\x7f\x0a"
+#define QUIC_INITIAL_SALT_V2    \
+	"\x0d\xed\xe3\xde\xf7\x00\xa6\xdb\x81\x93\x81\xbe\x6e\x26\x9d\xcb\xf9\xbd\x2e\xd9"
+
+#define QUIC_INITIAL_SALT_LEN	20
+
+/* Initial Secrets. */
+int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struct quic_conn_id *conn_id,
+				     u32 version, bool is_serv)
+{
+	u8 secret[TLS_CIPHER_AES_GCM_128_SECRET_SIZE];
+	struct quic_data salt, s, k, l, dcid, z = {};
+	struct quic_crypto_secret srt = {};
+	char *tl, *rl, *sal;
+	int err;
+
+	/* rfc9001#section-5.2:
+	 *
+	 * The secret used by clients to construct Initial packets uses the PRK and the
+	 * label "client in" as input to the HKDF-Expand-Label function from TLS [TLS13]
+	 * to produce a 32-byte secret. Packets constructed by the server use the same
+	 * process with the label "server in". The hash function for HKDF when deriving
+	 * initial secrets and keys is SHA-256 [SHA].
+	 *
+	 * This process in pseudocode is:
+	 *
+	 *   initial_salt = 0x38762cf7f55934b34d179ae6a4c80cadccbb7f0a
+	 *   initial_secret = HKDF-Extract(initial_salt,
+	 *                                 client_dst_connection_id)
+	 *
+	 *   client_initial_secret = HKDF-Expand-Label(initial_secret,
+	 *                                             "client in", "",
+	 *                                             Hash.length)
+	 *   server_initial_secret = HKDF-Expand-Label(initial_secret,
+	 *                                             "server in", "",
+	 *                                             Hash.length)
+	 */
+	if (is_serv) {
+		rl = "client in";
+		tl = "server in";
+	} else {
+		tl = "client in";
+		rl = "server in";
+	}
+	sal = QUIC_INITIAL_SALT_V1;
+	if (version == QUIC_VERSION_V2)
+		sal = QUIC_INITIAL_SALT_V2;
+	quic_data(&salt, sal, QUIC_INITIAL_SALT_LEN);
+	quic_data(&dcid, conn_id->data, conn_id->len);
+	quic_data(&s, secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
+	err = quic_crypto_hkdf_extract(crypto->secret_tfm, &salt, &dcid, &s);
+	if (err)
+		return err;
+
+	quic_data(&l, tl, strlen(tl));
+	quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	srt.send = 1;
+	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &k);
+	if (err)
+		return err;
+	/* Enforce synchronous crypto for Initial level by requesting algorithms marked with
+	 * CRYPTO_ALG_ASYNC to avoid async processing.
+	 */
+	err = quic_crypto_set_secret(crypto, &srt, version, CRYPTO_ALG_ASYNC);
+	if (err)
+		return err;
+
+	quic_data(&l, rl, strlen(rl));
+	quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
+	srt.type = TLS_CIPHER_AES_GCM_128;
+	srt.send = 0;
+	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &k);
+	if (err)
+		return err;
+	return quic_crypto_set_secret(crypto, &srt, version, CRYPTO_ALG_ASYNC);
+}
+
+/* Generate a derived key using HKDF-Extract and HKDF-Expand with a given label. */
+static int quic_crypto_generate_key(struct quic_crypto *crypto, void *data, u32 len,
+				    char *label, u8 *token, u32 key_len)
+{
+	struct crypto_shash *tfm = crypto->secret_tfm;
+	u8 secret[TLS_CIPHER_AES_GCM_128_SECRET_SIZE];
+	struct quic_data salt, s, l, k, z = {};
+	int err;
+
+	quic_data(&salt, data, len);
+	quic_data(&k, quic_random_data, QUIC_RANDOM_DATA_LEN);
+	quic_data(&s, secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
+	err = quic_crypto_hkdf_extract(tfm, &salt, &k, &s);
+	if (err)
+		return err;
+
+	quic_data(&l, label, strlen(label));
+	quic_data(&k, token, key_len);
+	return quic_crypto_hkdf_expand(tfm, &s, &l, &z, &k);
+}
+
+/* Derive a stateless reset token from connection-specific input. */
+int quic_crypto_generate_stateless_reset_token(struct quic_crypto *crypto, void *data,
+					       u32 len, u8 *key, u32 key_len)
+{
+	return quic_crypto_generate_key(crypto, data, len, "stateless_reset", key, key_len);
+}
+
+/* Derive a session ticket key using HKDF from connection-specific input. */
+int quic_crypto_generate_session_ticket_key(struct quic_crypto *crypto, void *data,
+					    u32 len, u8 *key, u32 key_len)
+{
+	return quic_crypto_generate_key(crypto, data, len, "session_ticket", key, key_len);
+}
+
+void quic_crypto_init(void)
+{
+	get_random_bytes(quic_random_data, QUIC_RANDOM_DATA_LEN);
+}
diff --git a/net/quic/crypto.h b/net/quic/crypto.h
new file mode 100644
index 000000000000..2bc960a8489e
--- /dev/null
+++ b/net/quic/crypto.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#define QUIC_TAG_LEN	16
+#define QUIC_IV_LEN	12
+#define QUIC_KEY_LEN	32
+#define QUIC_SECRET_LEN	48
+
+#define QUIC_TOKEN_FLAG_REGULAR		0
+#define QUIC_TOKEN_FLAG_RETRY		1
+#define QUIC_TOKEN_TIMEOUT_REGULAR	3000000
+#define QUIC_TOKEN_TIMEOUT_RETRY	600000000
+
+struct quic_cipher {
+	u32 secretlen;			/* Length of the traffic secret */
+	u32 keylen;			/* Length of the AEAD key */
+
+	char *shash;			/* Name of hash algorithm used for key derivation */
+	char *aead;			/* Name of AEAD algorithm used for payload en/decryption */
+	char *skc;			/* Name of cipher algorithm used for header protection */
+};
+
+struct quic_crypto {
+	struct crypto_skcipher *tx_hp_tfm;	/* Transform for TX header protection */
+	struct crypto_skcipher *rx_hp_tfm;	/* Transform for RX header protection */
+	struct crypto_shash *secret_tfm;	/* Transform for key derivation (HKDF) */
+	struct crypto_aead *tx_tfm[2];		/* AEAD transform for TX (key phase 0 and 1) */
+	struct crypto_aead *rx_tfm[2];		/* AEAD transform for RX (key phase 0 and 1) */
+	struct crypto_aead *tag_tfm;		/* AEAD transform used for Retry token validation */
+	struct quic_cipher *cipher;		/* Cipher information (selected cipher suite) */
+	u32 cipher_type;			/* Cipher suite (e.g., AES_GCM_128, etc.) */
+
+	u8 tx_secret[QUIC_SECRET_LEN];		/* TX secret derived or provided by user space */
+	u8 rx_secret[QUIC_SECRET_LEN];		/* RX secret derived or provided by user space */
+	u8 tx_iv[2][QUIC_IV_LEN];		/* IVs for TX (key phase 0 and 1) */
+	u8 rx_iv[2][QUIC_IV_LEN];		/* IVs for RX (key phase 0 and 1) */
+
+	u32 key_update_send_time;		/* Time when 1st packet was sent after key update */
+	u32 key_update_time;			/* Time to retain old keys after key update */
+	u32 version;				/* QUIC version in use */
+
+	u8 ticket_ready:1;			/* True if  a session ticket is ready to read */
+	u8 key_pending:1;			/* A key update is in progress */
+	u8 send_ready:1;			/* TX encryption context is initialized */
+	u8 recv_ready:1;			/* RX decryption context is initialized */
+	u8 key_phase:1;				/* Current key phase being used (0 or 1) */
+
+	u64 send_offset;	/* Number of handshake bytes sent by user at this level */
+	u64 recv_offset;	/* Number of handshake bytes read by user at this level */
+};
+
+int quic_crypto_set_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt,
+			   u32 version, u8 flag);
+int quic_crypto_get_secret(struct quic_crypto *crypto, struct quic_crypto_secret *srt);
+int quic_crypto_set_cipher(struct quic_crypto *crypto, u32 type, u8 flag);
+int quic_crypto_key_update(struct quic_crypto *crypto);
+
+int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struct quic_conn_id *conn_id,
+				     u32 version, bool is_serv);
+int quic_crypto_generate_session_ticket_key(struct quic_crypto *crypto, void *data,
+					    u32 len, u8 *key, u32 key_len);
+int quic_crypto_generate_stateless_reset_token(struct quic_crypto *crypto, void *data,
+					       u32 len, u8 *key, u32 key_len);
+
+void quic_crypto_free(struct quic_crypto *crypto);
+void quic_crypto_init(void);
diff --git a/net/quic/protocol.c b/net/quic/protocol.c
index 08eb3b81f62f..fb98ef10f852 100644
--- a/net/quic/protocol.c
+++ b/net/quic/protocol.c
@@ -258,9 +258,18 @@ static int __net_init quic_net_init(struct net *net)
 	if (!qn->stat)
 		return -ENOMEM;
 
+	err = quic_crypto_set_cipher(&qn->crypto, TLS_CIPHER_AES_GCM_128, CRYPTO_ALG_ASYNC);
+	if (err) {
+		free_percpu(qn->stat);
+		qn->stat = NULL;
+		return err;
+	}
+	spin_lock_init(&qn->lock);
+
 #ifdef CONFIG_PROC_FS
 	err = quic_net_proc_init(net);
 	if (err) {
+		quic_crypto_free(&qn->crypto);
 		free_percpu(qn->stat);
 		qn->stat = NULL;
 	}
@@ -275,6 +284,7 @@ static void __net_exit quic_net_exit(struct net *net)
 #ifdef CONFIG_PROC_FS
 	quic_net_proc_exit(net);
 #endif
+	quic_crypto_free(&qn->crypto);
 	free_percpu(qn->stat);
 	qn->stat = NULL;
 }
@@ -323,6 +333,8 @@ static __init int quic_init(void)
 	sysctl_quic_wmem[1] = 16 * 1024;
 	sysctl_quic_wmem[2] = max(64 * 1024, max_share);
 
+	quic_crypto_init();
+
 	err = percpu_counter_init(&quic_sockets_allocated, 0, GFP_KERNEL);
 	if (err)
 		goto err_percpu_counter;
diff --git a/net/quic/protocol.h b/net/quic/protocol.h
index 6e6c5a6fc3f8..1df926ef0a75 100644
--- a/net/quic/protocol.h
+++ b/net/quic/protocol.h
@@ -47,6 +47,8 @@ struct quic_net {
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_net;	/* procfs entry for dumping QUIC socket stats */
 #endif
+	struct quic_crypto crypto;	/* Context for decrypting Initial packets for ALPN */
+	spinlock_t lock;	/* Lock protecting crypto context for Initial packet decryption */
 };
 
 struct quic_net *quic_net(struct net *net);
diff --git a/net/quic/socket.c b/net/quic/socket.c
index 5c0173c9d6cc..8fb5fc2d7d98 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -73,6 +73,8 @@ static void quic_destroy_sock(struct sock *sk)
 
 	for (i = 0; i < QUIC_PNSPACE_MAX; i++)
 		quic_pnspace_free(quic_pnspace(sk, i));
+	for (i = 0; i < QUIC_CRYPTO_MAX; i++)
+		quic_crypto_free(quic_crypto(sk, i));
 
 	quic_path_free(sk, quic_paths(sk), 0);
 	quic_path_free(sk, quic_paths(sk), 1);
diff --git a/net/quic/socket.h b/net/quic/socket.h
index 1bee3b9f594a..a99f68097a54 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -19,6 +19,7 @@
 #include "family.h"
 #include "stream.h"
 #include "connid.h"
+#include "crypto.h"
 #include "path.h"
 #include "cong.h"
 
@@ -49,6 +50,7 @@ struct quic_sock {
 	struct quic_path_group		paths;
 	struct quic_cong		cong;
 	struct quic_pnspace		space[QUIC_PNSPACE_MAX];
+	struct quic_crypto		crypto[QUIC_CRYPTO_MAX];
 };
 
 struct quic6_sock {
@@ -121,6 +123,11 @@ static inline struct quic_pnspace *quic_pnspace(const struct sock *sk, u8 level)
 	return &quic_sk(sk)->space[level % QUIC_CRYPTO_EARLY];
 }
 
+static inline struct quic_crypto *quic_crypto(const struct sock *sk, u8 level)
+{
+	return &quic_sk(sk)->crypto[level];
+}
+
 static inline bool quic_is_establishing(struct sock *sk)
 {
 	return sk->sk_state == QUIC_SS_ESTABLISHING;
-- 
2.47.1


