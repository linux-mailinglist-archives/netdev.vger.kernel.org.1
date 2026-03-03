Return-Path: <netdev+bounces-263073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB8GFsicpmlqRwAAu9opvQ
	(envelope-from <netdev+bounces-263073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8B1EAD48
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F209301807F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5CB386C0A;
	Tue,  3 Mar 2026 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coStkyXU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844637DE9F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526784; cv=none; b=qEPevPX4EqmFGhXuA+OhLTTDIcDPz1wiXSucHD9dEFQHDiCFJeTv7F4x5WLtZQqN9ahfP8FJGNkQ2NivuON606jUL0dKDiScFp/Hl5TSZQNZPNphvTsd2mnrbF9grD9DB76OJhdOisFsRfGrJUZ4hksqp3BvpEpwkncS0iBLSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526784; c=relaxed/simple;
	bh=Bx2oluKaQg8IiGfBDRHcXdAKnAVrVyWYMDE+lcLVQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lorg2y7rxlWvjKap5huUzpAxDLT/ZCW9m6yHLU57TO6bSVBOzzaF5y3jseFQIoAfFc9mHJ4eKR8Hd+fi4kGOgrXxtrpQtIWvgI+CLGmnYavklWjMuMAkEdfJrZ7o1+yBtqLZM437GAuPfIuHhWf5rxO2VQEO/+tzijFlh4RghKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coStkyXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772526782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glADp/JIS4TJcz+MBCi7FTlkuaPyLmUD5xZRESbtyjI=;
	b=coStkyXUFqZBLJMuq0wRpk8xU+n2fvE2xaBTB3XvDG6p7lv1nCDiUYbD+yyY9bKxSoQR32
	W/v5m1aoJTXNdBiwOls34m4luh712UkTRD+468N6GLoVBQ5V7gAPEGw0B6GpPw/mVr+ZNG
	cU+tNnxfa0Ep/FC0kmGQVeoWCZM9aHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-ebjl_ZFgMVyNXMMzWGNLzQ-1; Tue,
 03 Mar 2026 03:32:58 -0500
X-MC-Unique: ebjl_ZFgMVyNXMMzWGNLzQ-1
X-Mimecast-MFC-AGG-ID: ebjl_ZFgMVyNXMMzWGNLzQ_1772526775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A294B19560B7;
	Tue,  3 Mar 2026 08:32:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 242391956053;
	Tue,  3 Mar 2026 08:32:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lucien.xin@gmail.com
Cc: hepengtao@xiaomi.com,
	kuba@kernel.org,
	jlayton@kernel.org,
	metze@samba.org,
	davem@davemloft.net,
	kernel-tls-handshake@lists.linux.dev,
	horms@kernel.org,
	hare@suse.de,
	aahringo@redhat.com,
	tfanelli@redhat.com,
	mail@johnericson.me,
	andrew.gospodarek@broadcom.com,
	linkinjeon@kernel.org,
	dhowells@redhat.com,
	matttbe@kernel.org,
	xiyou.wangcong@gmail.com,
	dreibh@simula.no,
	jbaron@akamai.com,
	quic@lists.linux.dev,
	pc@manguebit.com,
	marc@fiuczynski.com,
	edumazet@google.com,
	pabeni@redhat.com,
	alibuda@linux.alibaba.com,
	steved@redhat.com,
	illiliti@protonmail.com,
	tom@talpey.com,
	marcelo.leitner@gmail.com,
	sd@queasysnail.net,
	linux-cifs@vger.kernel.org,
	netdev@vger.kernel.org,
	mbuhl@openbsd.org,
	smfrench@gmail.com,
	chuck.lever@oracle.com,
	daniel@haxx.se
Subject: Re: [net-next,v10,11/15] quic: add crypto key derivation and installation
Date: Tue,  3 Mar 2026 09:32:33 +0100
Message-ID: <20260303083233.34650-1-pabeni@redhat.com>
In-Reply-To: <323138c6deed2652a09aa38dfbe322642b6ad150.1771986861.git.lucien.xin@gmail.com>
References: <323138c6deed2652a09aa38dfbe322642b6ad150.1771986861.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 59B8B1EAD48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263073-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
quic: add crypto key derivation and installation

This patch introduces 'quic_crypto', a component responsible for QUIC
encryption key derivation and installation across the various key
levels: Initial, Handshake, 0-RTT (Early), and 1-RTT (Application).
It provides helpers to derive and install initial secrets, set traffic
secrets and install the corresponding keys, and perform key updates to
enable forward secrecy.

> diff --git a/net/quic/Makefile b/net/quic/Makefile
> index 9d8e18297911..58bb18f7926d 100644
> --- a/net/quic/Makefile
> +++ b/net/quic/Makefile
> @@ -6,4 +6,4 @@
>  obj-$(CONFIG_IP_QUIC) += quic.o
>
>  quic-y := common.o family.o protocol.o socket.o stream.o connid.o path.o \
> -	  cong.o pnspace.o
> +	  cong.o pnspace.o crypto.o
> diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> new file mode 100644
> index 000000000000..a9de418e604e
> --- /dev/null
> +++ b/net/quic/crypto.c

[ ... ]

> +/* Initial Secrets. */
> +int quic_crypto_initial_keys_install(struct quic_crypto *crypto, struct quic_conn_id *conn_id,
> +				     u32 version, bool is_serv)
> +{
> +	u8 secret[TLS_CIPHER_AES_GCM_128_SECRET_SIZE];
> +	struct quic_data salt, s, k, l, dcid, z = {};
> +	struct quic_crypto_secret srt = {};
> +	char *tl, *rl, *sal;
> +	int err;
> +
> +	if (is_serv) {
> +		rl = "client in";
> +		tl = "server in";
> +	} else {
> +		tl = "client in";
> +		rl = "server in";
> +	}
> +	sal = QUIC_INITIAL_SALT_V1;
> +	if (version == QUIC_VERSION_V2)
> +		sal = QUIC_INITIAL_SALT_V2;
> +	quic_data(&salt, sal, QUIC_INITIAL_SALT_LEN);
> +	quic_data(&dcid, conn_id->data, conn_id->len);
> +	quic_data(&s, secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> +	err = quic_crypto_hkdf_extract(crypto->secret_tfm, &salt, &dcid, &s);

Is crypto->secret_tfm guaranteed to be initialized at this point?

Looking at the function flow, this line uses crypto->secret_tfm before
quic_crypto_set_secret() below gets a chance to initialize the cipher:

quic_crypto_initial_keys_install() {
	err = quic_crypto_hkdf_extract(crypto->secret_tfm, ...); /* line 490 */
	...
	err = quic_crypto_set_secret(crypto, &srt, version, 0);  /* line 497 */
}

If quic_crypto_set_cipher() hasn't been called on this struct quic_crypto
yet, crypto->secret_tfm is NULL.

This contrasts with quic_crypto_set_secret(), which has lazy initialization:

quic_crypto_set_secret() {
	if (!crypto->cipher) {
		err = quic_crypto_set_cipher(crypto, srt->type, flag);
		if (err)
			return err;
	}
	...
}

Without this initialization, quic_crypto_hkdf_extract() flows through
hkdf_extract() -> crypto_shash_setkey(NULL, ...), causing a NULL pointer
dereference.

Would it make sense to call quic_crypto_set_cipher() before using
secret_tfm, or to reorder the function so quic_crypto_set_secret() is
called first?

> +	if (err)
> +		goto out;
> +
> +	quic_data(&l, tl, strlen(tl));
> +	quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> +	srt.type = TLS_CIPHER_AES_GCM_128;
> +	srt.send = 1;
> +	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &k);
> +	if (err)
> +		goto out;
> +	err = quic_crypto_set_secret(crypto, &srt, version, 0);
> +	if (err)
> +		goto out;
> +
> +	quic_data(&l, rl, strlen(rl));
> +	quic_data(&k, srt.secret, TLS_CIPHER_AES_GCM_128_SECRET_SIZE);
> +	srt.type = TLS_CIPHER_AES_GCM_128;
> +	srt.send = 0;
> +	err = quic_crypto_hkdf_expand(crypto->secret_tfm, &s, &l, &z, &k);
> +	if (err)
> +		goto out;
> +	err = quic_crypto_set_secret(crypto, &srt, version, 0);
> +out:
> +	memzero_explicit(secret, sizeof(secret));
> +	memzero_explicit(&srt, sizeof(srt));
> +	return err;
> +}

[ ... ]

> +/* Derive and install transmission (TX) packet protection keys for the current key phase.
> + * This involves generating AEAD encryption key, IV, and optionally header protection key.
> + */
> +static int quic_crypto_tx_keys_derive_and_install(struct quic_crypto *crypto)
> +{
> +	struct quic_data srt = {}, k, iv, hp_k = {}, *hp = NULL;
> +	u8 tx_key[QUIC_KEY_LEN], tx_hp_key[QUIC_KEY_LEN] = {};
> +	int err, phase = crypto->key_phase;
> +	u32 keylen, ivlen = QUIC_IV_LEN;
> +
> +	keylen = crypto->cipher->keylen;
> +	quic_data(&srt, crypto->tx_secret, crypto->cipher->secretlen);
> +	quic_data(&k, tx_key, keylen);
> +	quic_data(&iv, crypto->tx_iv[phase], ivlen);
> +	/* Only derive header protection key when not in key update. */
> +	if (!crypto->key_pending)
> +		hp = quic_data(&hp_k, tx_hp_key, keylen);
> +	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
> +	if (err)
> +		goto out;
> +	err = crypto_aead_setauthsize(crypto->tx_tfm[phase], QUIC_TAG_LEN);
> +	if (err)
> +		goto out;
> +	err = crypto_aead_setkey(crypto->tx_tfm[phase], tx_key, keylen);
> +	if (err)
> +		goto out;
> +	if (hp) {
> +		err = crypto_skcipher_setkey(crypto->tx_hp_tfm, tx_hp_key, keylen);
> +		if (err)
> +			goto out;
> +	}
> +	pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.data, iv.data, tx_hp_key);
> +out:
> +	memzero_explicit(tx_key, sizeof(tx_key));
> +	memzero_explicit(tx_hp_key, sizeof(tx_hp_key));
> +	return err;
> +}
> +
> +/* Derive and install reception (RX) packet protection keys for the current key phase.
> + * This installs AEAD decryption key, IV, and optionally header protection key.
> + */
> +static int quic_crypto_rx_keys_derive_and_install(struct quic_crypto *crypto)
> +{
> +	struct quic_data srt = {}, k, iv, hp_k = {}, *hp = NULL;
> +	u8 rx_key[QUIC_KEY_LEN], rx_hp_key[QUIC_KEY_LEN] = {};
> +	int err, phase = crypto->key_phase;
> +	u32 keylen, ivlen = QUIC_IV_LEN;
> +
> +	keylen = crypto->cipher->keylen;
> +	quic_data(&srt, crypto->rx_secret, crypto->cipher->secretlen);
> +	quic_data(&k, rx_key, keylen);
> +	quic_data(&iv, crypto->rx_iv[phase], ivlen);
> +	/* Only derive header protection key when not in key update. */
> +	if (!crypto->key_pending)
> +		hp = quic_data(&hp_k, rx_hp_key, keylen);
> +	err = quic_crypto_keys_derive(crypto->secret_tfm, &srt, &k, &iv, hp, crypto->version);
> +	if (err)
> +		goto out;
> +	err = crypto_aead_setauthsize(crypto->rx_tfm[phase], QUIC_TAG_LEN);
> +	if (err)
> +		goto out;
> +	err = crypto_aead_setkey(crypto->rx_tfm[phase], rx_key, keylen);
> +	if (err)
> +		goto out;
> +	if (hp) {
> +		err = crypto_skcipher_setkey(crypto->rx_hp_tfm, rx_hp_key, keylen);
> +		if (err)
> +			goto out;
> +	}
> +	pr_debug("%s: k: %16phN, iv: %12phN, hp_k:%16phN\n", __func__, k.data, iv.data, rx_hp_key);
> +out:
> +	memzero_explicit(rx_key, sizeof(rx_key));
> +	memzero_explicit(rx_hp_key, sizeof(rx_hp_key));
> +	return err;
> +}

This isn't a bug, but these two functions are nearly identical.

quic_crypto_tx_keys_derive_and_install() and
quic_crypto_rx_keys_derive_and_install() share the same structure: derive
keys via quic_crypto_keys_derive(), set AEAD auth size and key,
conditionally set the HP skcipher key, pr_debug, and memzero_explicit the
temporaries.

The only differences are the member names accessed (tx_secret vs
rx_secret, tx_iv vs rx_iv, tx_tfm vs rx_tfm, tx_hp_tfm vs rx_hp_tfm).

Could these be unified into a single static helper that takes
direction-specific pointers as parameters?

This would eliminate the duplication and reduce the risk of the two
copies diverging in future maintenance.

[ ... ]


