Return-Path: <netdev+bounces-152873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964349F620A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3751E170EAD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2C199249;
	Wed, 18 Dec 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WPXcafRv"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048E156669;
	Wed, 18 Dec 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514981; cv=none; b=ICnL2OzTrVIth1tTEDNiDYXOGaSqysq3l2XUgjvoRSAj7+YcQOEecNyKfJjy4Snp1HTnw4lMte7+3voKVFydrgk5e7L5CV2Y2a+HgjQfGe1R1k3JxO0SMcWNkIuJDyllJtKYZpQQANR0yGoqANQyydLA8FdFaS09GMi1P2xqiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514981; c=relaxed/simple;
	bh=rbo1DQAN7buGcGf5jPOK1SWvqzrcD+/1CJg/+G9BnZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcd2xV4GffFPF6GaUK7SYnQNfrYr+DBGTFPHCEXNL3KQik4VausUfXE5N//nxk+JPKHPkFexzvT6BUJohUGyjlMniEYhEsfFzehvJDk6ayKFry0rOJ/kn8Kh0535V8Hyu+ZkhtPkVcNpoRsXxsugYvpYpwgCirOMLrMJ+GgB9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WPXcafRv; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZuNnhLS3yD9s2KTGU0WWfFQqhE9/htSzJff44nlek4Y=; b=WPXcafRvtkgtu/2SMcAa6LWbS/
	tDZ2nD2fl1wFGUC6+EDFNEviL9o1eC0TUdcgb8156W6xeUTt1YD0lohesLyMHDKR48+V0XQqyQX++
	AzbweJr9wMyS2itwyLzoe0UawmyrXYvc/LX2zh0vYG9tGX53SQtu1AgGzwkpOvdX3ocW2xwBu60Xm
	CQ3Y72KDivd5mZXVNgekE1Ri58HvB0HskGmX7BJooe1sgRLj0UK3IZiXi4bgHe/CvoaiN3yOziFJJ
	2h6XVSm/6MQLZ7GTN/SJRpszHoTdS6kNW/nBKvk8xT9ZEJQWAZopiNSJshz3x68jCrvdfO8ho4PiT
	x1OYfXXA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tNqMk-0028gV-2E;
	Wed, 18 Dec 2024 17:42:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 18 Dec 2024 17:42:35 +0800
Date: Wed, 18 Dec 2024 17:42:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] xfrm: Rewrite key length conversion to avoid overflows
Message-ID: <Z2KZC71JZ0QnrhfU@gondor.apana.org.au>
References: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
 <Z2FompbNt6NBEoln@gondor.apana.org.au>
 <053456e5-56e7-478b-b73e-96b7c2098d07@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053456e5-56e7-478b-b73e-96b7c2098d07@stanley.mountain>

On Tue, Dec 17, 2024 at 03:32:31PM +0300, Dan Carpenter wrote:
>
> That seems like basic algebra but we have a long history of getting
> integer overflow checks wrong so these days I like to just use
> INT_MAX where ever I can.  I wanted to use USHRT_MAX. We aren't allowed
> to use more than USHRT_MAX bytes, but maybe we're allowed USHRT_MAX
> bits, so I didn't do that.

There is no reason for this to overflow if we rewrite it do do
the division carefully.  Something like this:

Steffen, this raises a new question: Can normal users create socket
policies of arbtirarily long key lengths? If so we probably should
look into limiting the key length to a sane value.  Of course, given
namespaces we probably should do that in any case.

---8<---
Rewrite the IPsec conversion from bit-length to byte-length so that
large values do not overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
index c7338ac6a5bb..eb7bb196d75d 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
@@ -165,7 +165,7 @@ static int ch_ipsec_setauthsize(struct xfrm_state *x,
 static int ch_ipsec_setkey(struct xfrm_state *x,
 			   struct ipsec_sa_entry *sa_entry)
 {
-	int keylen = (x->aead->alg_key_len + 7) / 8;
+	int keylen = xfrm_kblen2klen(x->aead->alg_key_len);
 	unsigned char *key = x->aead->alg_key;
 	int ck_size, key_ctx_size = 0;
 	unsigned char ghash_h[AEAD_H_SIZE];
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ca92e518be76..24c96a4497b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -323,7 +323,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	memset(attrs, 0, sizeof(*attrs));
 
 	/* key */
-	crypto_data_len = (x->aead->alg_key_len + 7) / 8;
+	crypto_data_len = xfrm_kblen2klen(x->aead->alg_key_len);
 	key_len = crypto_data_len - 4; /* 4 bytes salt at end */
 
 	memcpy(aes_gcm->aes_key, x->aead->alg_key, key_len);
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
index 515069d5637b..2660236eb07f 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/ipsec.c
@@ -365,7 +365,7 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 	}
 
 	if (x->aalg) {
-		key_len = DIV_ROUND_UP(x->aalg->alg_key_len, BITS_PER_BYTE);
+		key_len = xfrm_kblen2klen(x->aalg->alg_key_len);
 		if (key_len > sizeof(cfg->auth_key)) {
 			NL_SET_ERR_MSG_MOD(extack, "Insufficient space for offloaded auth key");
 			return -EINVAL;
@@ -458,7 +458,7 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 		int key_offset = 0;
 		int salt_len = 4;
 
-		key_len = DIV_ROUND_UP(x->aead->alg_key_len, BITS_PER_BYTE);
+		key_len = xfrm_kblen2klen(x->aead->alg_key_len);
 		key_len -= salt_len;
 
 		if (key_len > sizeof(cfg->ciph_key)) {
@@ -485,7 +485,7 @@ static int nfp_net_xfrm_add_state(struct xfrm_state *x,
 	}
 
 	if (x->ealg) {
-		key_len = DIV_ROUND_UP(x->ealg->alg_key_len, BITS_PER_BYTE);
+		key_len = xfrm_kblen2klen(x->ealg->alg_key_len);
 
 		if (key_len > sizeof(cfg->ciph_key)) {
 			NL_SET_ERR_MSG_MOD(extack, "ealg: Insufficient space for offloaded key");
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 32c09e85a64c..1ce897a9476b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1912,19 +1912,24 @@ static inline int xfrm_acquire_is_on(struct net *net)
 }
 #endif
 
+static inline unsigned int xfrm_kblen2klen(unsigned int klen_in_bits)
+{
+	return klen_in_bits / 8 + !!(klen_in_bits & 7);
+}
+
 static inline unsigned int aead_len(struct xfrm_algo_aead *alg)
 {
-	return sizeof(*alg) + ((alg->alg_key_len + 7) / 8);
+	return sizeof(*alg) + xfrm_kblen2klen(alg->alg_key_len);
 }
 
 static inline unsigned int xfrm_alg_len(const struct xfrm_algo *alg)
 {
-	return sizeof(*alg) + ((alg->alg_key_len + 7) / 8);
+	return sizeof(*alg) + xfrm_kblen2klen(alg->alg_key_len);
 }
 
 static inline unsigned int xfrm_alg_auth_len(const struct xfrm_algo_auth *alg)
 {
-	return sizeof(*alg) + ((alg->alg_key_len + 7) / 8);
+	return sizeof(*alg) + xfrm_kblen2klen(alg->alg_key_len);
 }
 
 static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 64aec3dff8ec..efea16f28b8d 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -496,7 +496,7 @@ static int ah_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
 	ahp->ahash = ahash;
 	if (crypto_ahash_setkey(ahash, x->aalg->alg_key,
-				(x->aalg->alg_key_len + 7) / 8)) {
+				xfrm_kblen2klen(x->aalg->alg_key_len))) {
 		NL_SET_ERR_MSG(extack, "Kernel was unable to initialize cryptographic operations");
 		goto error;
 	}
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index f3281312eb5e..6dcbaf75c8b6 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1028,7 +1028,7 @@ static int esp_init_aead(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	x->data = aead;
 
 	err = crypto_aead_setkey(aead, x->aead->alg_key,
-				 (x->aead->alg_key_len + 7) / 8);
+				 xfrm_kblen2klen(x->aead->alg_key_len));
 	if (err)
 		goto error;
 
@@ -1088,8 +1088,9 @@ static int esp_init_authenc(struct xfrm_state *x,
 
 	x->data = aead;
 
-	keylen = (x->aalg ? (x->aalg->alg_key_len + 7) / 8 : 0) +
-		 (x->ealg->alg_key_len + 7) / 8 + RTA_SPACE(sizeof(*param));
+	keylen = x->aalg ? xfrm_kblen2klen(x->aalg->alg_key_len) : 0;
+	keylen += xfrm_kblen2klen(x->ealg->alg_key_len);
+	keylen += RTA_SPACE(sizeof(*param));
 	err = -ENOMEM;
 	key = kmalloc(keylen, GFP_KERNEL);
 	if (!key)
@@ -1105,8 +1106,8 @@ static int esp_init_authenc(struct xfrm_state *x,
 	if (x->aalg) {
 		struct xfrm_algo_desc *aalg_desc;
 
-		memcpy(p, x->aalg->alg_key, (x->aalg->alg_key_len + 7) / 8);
-		p += (x->aalg->alg_key_len + 7) / 8;
+		memcpy(p, x->aalg->alg_key, xfrm_kblen2klen(x->aalg->alg_key_len));
+		p += xfrm_kblen2klen(x->aalg->alg_key_len);
 
 		aalg_desc = xfrm_aalg_get_byname(x->aalg->alg_name, 0);
 		BUG_ON(!aalg_desc);
@@ -1126,8 +1127,8 @@ static int esp_init_authenc(struct xfrm_state *x,
 		}
 	}
 
-	param->enckeylen = cpu_to_be32((x->ealg->alg_key_len + 7) / 8);
-	memcpy(p, x->ealg->alg_key, (x->ealg->alg_key_len + 7) / 8);
+	param->enckeylen = cpu_to_be32(xfrm_kblen2klen(x->ealg->alg_key_len));
+	memcpy(p, x->ealg->alg_key, xfrm_kblen2klen(x->ealg->alg_key_len));
 
 	err = crypto_aead_setkey(aead, key, keylen);
 
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index eb474f0987ae..edf46ba35823 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -691,7 +691,7 @@ static int ah6_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
 	ahp->ahash = ahash;
 	if (crypto_ahash_setkey(ahash, x->aalg->alg_key,
-			       (x->aalg->alg_key_len + 7) / 8)) {
+				xfrm_kblen2klen(x->aalg->alg_key_len))) {
 		NL_SET_ERR_MSG(extack, "Kernel was unable to initialize cryptographic operations");
 		goto error;
 	}
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b2400c226a32..1cd8c4f71d33 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -1065,7 +1065,7 @@ static int esp_init_aead(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	x->data = aead;
 
 	err = crypto_aead_setkey(aead, x->aead->alg_key,
-				 (x->aead->alg_key_len + 7) / 8);
+				 xfrm_kblen2klen(x->aead->alg_key_len));
 	if (err)
 		goto error;
 
@@ -1125,8 +1125,9 @@ static int esp_init_authenc(struct xfrm_state *x,
 
 	x->data = aead;
 
-	keylen = (x->aalg ? (x->aalg->alg_key_len + 7) / 8 : 0) +
-		 (x->ealg->alg_key_len + 7) / 8 + RTA_SPACE(sizeof(*param));
+	keylen = (x->aalg ? xfrm_kblen2klen(x->aalg->alg_key_len) : 0);
+	keylen += xfrm_kblen2klen(x->ealg->alg_key_len);
+	keylen += RTA_SPACE(sizeof(*param));
 	err = -ENOMEM;
 	key = kmalloc(keylen, GFP_KERNEL);
 	if (!key)
@@ -1142,8 +1143,8 @@ static int esp_init_authenc(struct xfrm_state *x,
 	if (x->aalg) {
 		struct xfrm_algo_desc *aalg_desc;
 
-		memcpy(p, x->aalg->alg_key, (x->aalg->alg_key_len + 7) / 8);
-		p += (x->aalg->alg_key_len + 7) / 8;
+		memcpy(p, x->aalg->alg_key, xfrm_kblen2klen(x->aalg->alg_key_len));
+		p += xfrm_kblen2klen(x->aalg->alg_key_len);
 
 		aalg_desc = xfrm_aalg_get_byname(x->aalg->alg_name, 0);
 		BUG_ON(!aalg_desc);
@@ -1163,8 +1164,8 @@ static int esp_init_authenc(struct xfrm_state *x,
 		}
 	}
 
-	param->enckeylen = cpu_to_be32((x->ealg->alg_key_len + 7) / 8);
-	memcpy(p, x->ealg->alg_key, (x->ealg->alg_key_len + 7) / 8);
+	param->enckeylen = cpu_to_be32(xfrm_kblen2klen(x->ealg->alg_key_len));
+	memcpy(p, x->ealg->alg_key, xfrm_kblen2klen(x->ealg->alg_key_len));
 
 	err = crypto_aead_setkey(aead, key, keylen);
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..2d0b11780263 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -803,13 +803,11 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 
 	if (add_keys) {
 		if (x->aalg && x->aalg->alg_key_len) {
-			auth_key_size =
-				PFKEY_ALIGN8((x->aalg->alg_key_len + 7) / 8);
+			auth_key_size = PFKEY_ALIGN8(xfrm_kblen2klen(x->aalg->alg_key_len));
 			size += sizeof(struct sadb_key) + auth_key_size;
 		}
 		if (x->ealg && x->ealg->alg_key_len) {
-			encrypt_key_size =
-				PFKEY_ALIGN8((x->ealg->alg_key_len+7) / 8);
+			encrypt_key_size = PFKEY_ALIGN8(xfrm_kblen2klen(x->ealg->alg_key_len));
 			size += sizeof(struct sadb_key) + encrypt_key_size;
 		}
 	}
@@ -967,7 +965,8 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_exttype = SADB_EXT_KEY_AUTH;
 		key->sadb_key_bits = x->aalg->alg_key_len;
 		key->sadb_key_reserved = 0;
-		memcpy(key + 1, x->aalg->alg_key, (x->aalg->alg_key_len+7)/8);
+		memcpy(key + 1, x->aalg->alg_key,
+		       xfrm_kblen2klen(x->aalg->alg_key_len));
 	}
 	/* encrypt key */
 	if (add_keys && encrypt_key_size) {
@@ -978,7 +977,7 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_bits = x->ealg->alg_key_len;
 		key->sadb_key_reserved = 0;
 		memcpy(key + 1, x->ealg->alg_key,
-		       (x->ealg->alg_key_len+7)/8);
+		       xfrm_kblen2klen(x->ealg->alg_key_len));
 	}
 
 	/* sa */
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b2876e09328b..8d98bf7c7ad1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -532,6 +532,7 @@ static int attach_auth(struct xfrm_algo_auth **algpp, u8 *props,
 	struct xfrm_algo *ualg;
 	struct xfrm_algo_auth *p;
 	struct xfrm_algo_desc *algo;
+	unsigned int klen;
 
 	if (!rta)
 		return 0;
@@ -545,14 +546,15 @@ static int attach_auth(struct xfrm_algo_auth **algpp, u8 *props,
 	}
 	*props = algo->desc.sadb_alg_id;
 
-	p = kmalloc(sizeof(*p) + (ualg->alg_key_len + 7) / 8, GFP_KERNEL);
+	klen = xfrm_kblen2klen(ualg->alg_key_len);
+	p = kmalloc(sizeof(*p) + klen, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
 	strcpy(p->alg_name, algo->name);
 	p->alg_key_len = ualg->alg_key_len;
 	p->alg_trunc_len = algo->uinfo.auth.icv_truncbits;
-	memcpy(p->alg_key, ualg->alg_key, (ualg->alg_key_len + 7) / 8);
+	memcpy(p->alg_key, ualg->alg_key, klen);
 
 	*algpp = p;
 	return 0;
@@ -1089,23 +1091,22 @@ static bool xfrm_redact(void)
 
 static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 {
+	unsigned int klen = xfrm_kblen2klen(auth->alg_key_len);
 	struct xfrm_algo *algo;
 	struct xfrm_algo_auth *ap;
 	struct nlattr *nla;
 	bool redact_secret = xfrm_redact();
 
-	nla = nla_reserve(skb, XFRMA_ALG_AUTH,
-			  sizeof(*algo) + (auth->alg_key_len + 7) / 8);
+	nla = nla_reserve(skb, XFRMA_ALG_AUTH, sizeof(*algo) + klen);
 	if (!nla)
 		return -EMSGSIZE;
 	algo = nla_data(nla);
 	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
 
-	if (redact_secret && auth->alg_key_len)
-		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);
+	if (redact_secret)
+		memset(algo->alg_key, 0, klen);
 	else
-		memcpy(algo->alg_key, auth->alg_key,
-		       (auth->alg_key_len + 7) / 8);
+		memcpy(algo->alg_key, auth->alg_key, klen);
 	algo->alg_key_len = auth->alg_key_len;
 
 	nla = nla_reserve(skb, XFRMA_ALG_AUTH_TRUNC, xfrm_alg_auth_len(auth));
@@ -1115,16 +1116,16 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(ap->alg_name));
 	ap->alg_key_len = auth->alg_key_len;
 	ap->alg_trunc_len = auth->alg_trunc_len;
-	if (redact_secret && auth->alg_key_len)
-		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
+	if (redact_secret)
+		memset(ap->alg_key, 0, klen);
 	else
-		memcpy(ap->alg_key, auth->alg_key,
-		       (auth->alg_key_len + 7) / 8);
+		memcpy(ap->alg_key, auth->alg_key, klen);
 	return 0;
 }
 
 static int copy_to_user_aead(struct xfrm_algo_aead *aead, struct sk_buff *skb)
 {
+	unsigned int klen = xfrm_kblen2klen(aead->alg_key_len);
 	struct nlattr *nla = nla_reserve(skb, XFRMA_ALG_AEAD, aead_len(aead));
 	struct xfrm_algo_aead *ap;
 	bool redact_secret = xfrm_redact();
@@ -1137,16 +1138,16 @@ static int copy_to_user_aead(struct xfrm_algo_aead *aead, struct sk_buff *skb)
 	ap->alg_key_len = aead->alg_key_len;
 	ap->alg_icv_len = aead->alg_icv_len;
 
-	if (redact_secret && aead->alg_key_len)
-		memset(ap->alg_key, 0, (aead->alg_key_len + 7) / 8);
+	if (redact_secret)
+		memset(ap->alg_key, 0, klen);
 	else
-		memcpy(ap->alg_key, aead->alg_key,
-		       (aead->alg_key_len + 7) / 8);
+		memcpy(ap->alg_key, aead->alg_key, klen);
 	return 0;
 }
 
 static int copy_to_user_ealg(struct xfrm_algo *ealg, struct sk_buff *skb)
 {
+	unsigned int klen = xfrm_kblen2klen(ealg->alg_key_len);
 	struct xfrm_algo *ap;
 	bool redact_secret = xfrm_redact();
 	struct nlattr *nla = nla_reserve(skb, XFRMA_ALG_CRYPT,
@@ -1158,11 +1159,10 @@ static int copy_to_user_ealg(struct xfrm_algo *ealg, struct sk_buff *skb)
 	strscpy_pad(ap->alg_name, ealg->alg_name, sizeof(ap->alg_name));
 	ap->alg_key_len = ealg->alg_key_len;
 
-	if (redact_secret && ealg->alg_key_len)
-		memset(ap->alg_key, 0, (ealg->alg_key_len + 7) / 8);
+	if (redact_secret)
+		memset(ap->alg_key, 0, klen);
 	else
-		memcpy(ap->alg_key, ealg->alg_key,
-		       (ealg->alg_key_len + 7) / 8);
+		memcpy(ap->alg_key, ealg->alg_key, klen);
 
 	return 0;
 }
@@ -3509,7 +3509,7 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 		l += nla_total_size(aead_len(x->aead));
 	if (x->aalg) {
 		l += nla_total_size(sizeof(struct xfrm_algo) +
-				    (x->aalg->alg_key_len + 7) / 8);
+				    xfrm_kblen2klen(x->aalg->alg_key_len));
 		l += nla_total_size(xfrm_alg_auth_len(x->aalg));
 	}
 	if (x->ealg)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

