Return-Path: <netdev+bounces-182718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E150A89C20
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D746744223E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A829A3EC;
	Tue, 15 Apr 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EhaBT3b9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940829E048
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715878; cv=none; b=rvFHITPNp8pMtufPNfYmkdAYHVVkURcRxJ94VvV7MQBEdoHQWTXwVFu/HVrpGKtraaF5abFYu5FkQ95y8JcxYTVTvISUifGdEjNVXnOyvICGDict7RA44WejUVt04rQThe+0Ck48MHSCUShFrI6xn4zL/J75Ld6IXG3OmDvWTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715878; c=relaxed/simple;
	bh=SP9tKzz/2n8MbZ6ttiX409MBf+90esNv6MaFX8tCCDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr1B13VjvLwgChsoP6ABrs7ZJeP3QbpaoBntUVmOzfCnodVOebkHoBvwE8q/cDXID+Bo5SsAjWgrYiPHT6rm5XtqiJEMkCMDd2o6DztOFXa1A4ILnCOx6uL/7Tz91j8km7fh2KuFUSLxUPjtCpFOTwJYz31aBBXyqFbe1Ysl9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EhaBT3b9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso38600595e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715872; x=1745320672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dguwmznsu3oF510rWUYpOvHArpKkT0QOLCMzhXkpcXo=;
        b=EhaBT3b9fHvo6L/9GOEKqmlArI1AbIo3jw3sbqUBkZDMTaM+rEn7CrvPoLj7kBj2LD
         xGJYkoFuZipQeuIPmGcfDZ8otZpayzukq/BhQa2qfIT1uKJMTilrqKfdZQhA2ZxKxlfM
         m29vJoyxFQlPK0G2rXEaW5WhGDIQBhljJN9DxD9jwCO6e9WU60+fkfGTP4HXI1hY2Gz2
         pxtUnrka8tLMyDm5kLVHWX54M5KyHDYoiDpZxUJfLLccvTqsnDs9JbX4CWpZfd7CKqCS
         28uS25cAG06TIiR7rKiOtBX5RrolAXXYDaQXPiHaxnwoC8ZcEEgrni18/hbA3vM+Ptq8
         ZfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715872; x=1745320672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dguwmznsu3oF510rWUYpOvHArpKkT0QOLCMzhXkpcXo=;
        b=NvIOiYICm05qj9StezUsMZ27fcShKvHlFv2lNBLW+e0BK2rtnkOFBsFiZFUOqcbMtD
         k6hGAFpOT0C3ITS+ekRjOWtr4pH+iJdTa0iuk8QcVco36gyCFjJaR9u0N4YVr0q/029j
         yBnAE1bbLPYLYY6Ze+tRtnWS8I9F9ZatbbaFfxR10YizxlslwbXj+H+CoCf1kxPLY6AB
         ER+Q2MZznk2FCl82AS/rD2gHTbHauaTDwvVZfMh/Jw/2iNtwd2Swv8EeTqYxkE6B4l9q
         eVocosO36ptx/YxAw051SuGaBLxI7tYHn9WDwZi8ZmjBXJv+AbXCNS7DIkdj+vBFSZOE
         YnXA==
X-Gm-Message-State: AOJu0YwhtYM/fhvnIvoAGMWH+EvJRNkss/PoRg8C1DXQvHGNp9FzvHW9
	6wbNXKhMt48vdCG/4ncd7FHHW+I3/Ie/MjzqMYmMKdRALDHzigNdGryA8Wbp8Xum+4eCKSAki2W
	sXMpXL+z0UguPgzUKBru1UgEM5mz4IJ22pTropUXRe48Kxyk=
X-Gm-Gg: ASbGncv3uh7tC8pGW7Z1o677SHUDt1dYKy7SHKyU6yqA7SSuVcOvrbs0ot2gS1oMDcb
	6AZD2aX8kjOwwwoSrXGDgLZ9i79uAsLMuvKjkggWAiDfuqR/pHxnLpv7ii4QObbqUqv57gKqV5l
	g+vJJC7nVe8/UHDCAmtZjs1E5Q90Cx5rFC4lBd+LT70nYhWwSYmcpUV/vlZplMj6ZwyT4Rd+5Zv
	cBBw9Q43CTAyxcGC88SCdiO43U7PzZPlTHuqA9qmFZ+MlVS8Dg7ZZZPLndt3emwelxusd2L0ZCe
	w1b0KmULemLyj7/h3GZJ5zpZkxT1SGeUvZ1EMw==
X-Google-Smtp-Source: AGHT+IHg7ZRvaPfiaQYWTVfb5k0SNFDvgtfoDGkEI4Ju6tCfNshFLi+h+kdAVtff4IGRPe04HkT2OA==
X-Received: by 2002:a05:600c:3baa:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43f3a9b0285mr122942755e9.28.1744715871885;
        Tue, 15 Apr 2025 04:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:36 +0200
Subject: [PATCH net-next v26 19/23] ovpn: implement key add/get/del/swap
 via netlink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-19-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13973; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=SP9tKzz/2n8MbZ6ttiX409MBf+90esNv6MaFX8tCCDo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBC/5UkxcRUxGexOYrFXLj1jUerzGhXroZm3
 vIUCd7rGgmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQgAKCRALcOU6oDjV
 h3KbB/4tiL4Fh71TKMnTFFrvbKTgHyPH501UVe7UCq3LDL7nx3laqG9Eoti9d+WjDXNWWeMKz3u
 BqeOWsXlhKko3LOGccPG+y4hBsNi0bj0Hj1Aqb5rroNVdxMic9CtCaOtmB5tAA3w9m1fuqyO1qT
 r8TnJJPLbdP/2oaurof7r1zGBt0qisi4w1ncJyvvAOoMbyd808+6QnxmdIfSo6orgmFJjX0q94R
 VPZZhjYFEu8qa0JPWN7luoDsJ+fTtqHDIbDCotJC8It5JenjoFVCu66zkZOhzQT/wePFUvnAtSa
 lulqZ1JO9fNRoxhSf8ZS2dzpSZKHWcw5p6R2IZS467YSrHoS
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This change introduces the netlink commands needed to add, get, delete
and swap keys for a specific peer.

Userspace is expected to use these commands to create, inspect (non
sensitive data only), destroy and rotate session keys for a specific
peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/crypto.c      |  40 ++++++
 drivers/net/ovpn/crypto.h      |   4 +
 drivers/net/ovpn/crypto_aead.c |  17 +++
 drivers/net/ovpn/crypto_aead.h |   2 +
 drivers/net/ovpn/netlink.c     | 301 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 360 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 9544255c4588ad0bcccda5bdc83a4d8729458ff8..deeefffc098162b17ea53eb7a5de6b0f19a38022 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -146,3 +146,43 @@ void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
 
 	spin_unlock_bh(&cs->lock);
 }
+
+/**
+ * ovpn_crypto_config_get - populate keyconf object with non-sensible key data
+ * @cs: the crypto state to extract the key data from
+ * @slot: the specific slot to inspect
+ * @keyconf: the output object to populate
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
+			   enum ovpn_key_slot slot,
+			   struct ovpn_key_config *keyconf)
+{
+	struct ovpn_crypto_key_slot *ks;
+	int idx;
+
+	switch (slot) {
+	case OVPN_KEY_SLOT_PRIMARY:
+		idx = cs->primary_idx;
+		break;
+	case OVPN_KEY_SLOT_SECONDARY:
+		idx = !cs->primary_idx;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	ks = rcu_dereference(cs->slots[idx]);
+	if (!ks) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
+	keyconf->key_id = ks->key_id;
+	rcu_read_unlock();
+
+	return 0;
+}
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 5155791b87df7cccc76a011fa751686180074982..487d24a7d26635c9ca0fd66c75717502f60e7a0c 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -136,4 +136,8 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs);
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs);
 
+int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
+			   enum ovpn_key_slot slot,
+			   struct ovpn_key_config *keyconf);
+
 #endif /* _NET_OVPN_OVPNCRYPTO_H_ */
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 83ec18e4b9a4f7960bf789cee952ac11cb77083d..74ee639ac86880da9e22b88f182f5e0851cb2746 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -364,3 +364,20 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ovpn_aead_crypto_key_slot_destroy(ks);
 	return ERR_PTR(ret);
 }
+
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks)
+{
+	const char *alg_name;
+
+	if (!ks->encrypt)
+		return OVPN_CIPHER_ALG_NONE;
+
+	alg_name = crypto_tfm_alg_name(crypto_aead_tfm(ks->encrypt));
+
+	if (!strcmp(alg_name, ALG_NAME_AES))
+		return OVPN_CIPHER_ALG_AES_GCM;
+	else if (!strcmp(alg_name, ALG_NAME_CHACHAPOLY))
+		return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+	else
+		return OVPN_CIPHER_ALG_NONE;
+}
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 40c056558add3b9d17fda5c43eb858cb44c95945..65a2ff30789862bf52bbda389a995f8edff48e7e 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -24,4 +24,6 @@ struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
 void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
+enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
+
 #endif /* _NET_OVPN_OVPNAEAD_H_ */
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5653a588a47c6c94ff10e042f4f6d32bd8205e58..1f4220021df3a6e74d6e8946a58882bf5d66e444 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -17,6 +17,7 @@
 #include "netlink.h"
 #include "netlink-gen.h"
 #include "bind.h"
+#include "crypto.h"
 #include "peer.h"
 #include "socket.h"
 
@@ -790,24 +791,316 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
+			       enum ovpn_cipher_alg cipher,
+			       struct ovpn_key_direction *dir)
+{
+	struct nlattr *attrs[OVPN_A_KEYDIR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYDIR_MAX, key,
+			       ovpn_keydir_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		if (NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_CIPHER_KEY) ||
+		    NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_NONCE_TAIL))
+			return -EINVAL;
+
+		dir->cipher_key = nla_data(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+		dir->cipher_key_size = nla_len(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+
+		/* These algorithms require a 96bit nonce,
+		 * Construct it by combining 4-bytes packet id and
+		 * 8-bytes nonce-tail from userspace
+		 */
+		dir->nonce_tail = nla_data(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		dir->nonce_tail_size = nla_len(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(info->extack, "unsupported cipher");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ovpn_nl_key_new_doit - configure a new key for the specified peer
+ * @skb: incoming netlink message
+ * @info: genetlink metadata
+ *
+ * This function allows the user to install a new key in the peer crypto
+ * state.
+ * Each peer has two 'slots', namely 'primary' and 'secondary', where
+ * keys can be installed. The key in the 'primary' slot is used for
+ * encryption, while both keys can be used for decryption by matching the
+ * key ID carried in the incoming packet.
+ *
+ * The user is responsible for rotating keys when necessary. The user
+ * may fetch peer traffic statistics via netlink in order to better
+ * identify the right time to rotate keys.
+ * The renegotiation follows these steps:
+ * 1. a new key is computed by the user and is installed in the 'secondary'
+ *    slot
+ * 2. at user discretion (usually after a predetermined time) 'primary' and
+ *    'secondary' contents are swapped and the new key starts being used for
+ *    encryption, while the old key is kept around for decryption of late
+ *    packets.
+ *
+ * Return: 0 on success or a negative error code otherwise.
+ */
 int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_KEY_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_CIPHER_ALG) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_DECRYPT_DIR))
+		return -EINVAL;
+
+	pkr.slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+	pkr.key.key_id = nla_get_u32(attrs[OVPN_A_KEYCONF_KEY_ID]);
+	pkr.key.cipher_alg = nla_get_u32(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.encrypt);
+	if (ret < 0)
+		return ret;
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.decrypt);
+	if (ret < 0)
+		return ret;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to set key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ret = ovpn_crypto_state_reset(&peer->crypto, &pkr);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot install new key for peer %u",
+				       peer_id);
+		goto out;
+	}
+
+	netdev_dbg(ovpn->dev, "new key installed (id=%u) for peer %u\n",
+		   pkr.key.key_id, peer_id);
+out:
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
+			    u32 peer_id, enum ovpn_key_slot slot,
+			    const struct ovpn_key_config *keyconf)
+{
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq, &ovpn_nl_family,
+			  0, OVPN_CMD_KEY_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_KEYCONF);
+	if (!attr)
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_KEYCONF_PEER_ID, peer_id))
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
+	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
+	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
+		goto err;
+
+	nla_nest_end(skb, attr);
+	genlmsg_end(skb, hdr);
+
+	return 0;
+err:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
 }
 
 int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct ovpn_key_config keyconf = { 0 };
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	struct sk_buff *msg;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	ret = ovpn_crypto_config_get(&peer->crypto, slot, &keyconf);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot extract key from slot %u for peer %u",
+				       slot, peer_id);
+		goto err;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ovpn_nl_send_key(msg, info, peer->id, slot, &keyconf);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err;
+	}
+
+	ret = genlmsg_reply(msg, info);
+err:
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to swap keys for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slots_swap(&peer->crypto);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_priv *ovpn = info->user_ptr[0];
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       info->attrs[OVPN_A_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_PEER_ID))
+		return -EINVAL;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
+	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to delete key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slot_delete(&peer->crypto, slot);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 /**

-- 
2.49.0


