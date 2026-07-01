Return-Path: <netdev+bounces-303556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3NfsFlfhRGow2goAu9opvQ
	(envelope-from <netdev+bounces-303556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE02B6EBB2C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Q3e2utce;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303556-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D010300C7D6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154D3F54BD;
	Wed,  1 Jul 2026 09:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9925DB1A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:43:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899025; cv=none; b=UCz0UUmM669rjRsaIlKCjmg8A+XyLvFVebTiNjGMUZkVhXpIBPIs8Iv6gWxe4pMQJaObIJHhGSNqhCtOv4hCRztkNBtbhd5x83LtD/f1ULARYlyW8ic+9NKJy31PWVz8bozFh5mDsS4skXvn6p8IVVKMVdRGG/oYdIPy9xCnWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899025; c=relaxed/simple;
	bh=/ZFqgEpqPJl0/2Gz2wUTSAi11FKTQhS89w4PS+CgYuA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s5P637DaF0byhUqPZCRPPQJgZk2UGuuJDaDQHhLvb22lhR3IuAdXE3tkNLt04X5Ok3NyuiTi1XazhraED3Z3Dm/M8AmtKEjPD4ylnrZg+rBXls9tTaULUQUxQC30+OPvsP++J+b/Tpg94FgPX+wLJA9AL+Xl/Yz/w+ycVHzj2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3e2utce; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51bec738909so3259091cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782899023; x=1783503823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jp5jqF9wVzylwh6iunfzS2i/3F7kyPZLMIR3V6y7MlA=;
        b=Q3e2utcejHm4KahF7coKWnqIRaCBijZloMR9qBKfGYazlEVr+CpI7hSh6VjCg9uima
         /8bjgqUYNvhw1DSpv0VKl84ZMbuh1Suz0dETVUU0JkDBn6cQtiAz3h31lOwTRUTN6kq9
         b7ckXxlj5XKKAQsH4IloihqVI9mNJQMEXaOWKpEKObn/fxo/IuBiebHR9D0SEHxCsc4c
         SXaRb3oFV530ZJoYSIL/tR46m1WLlsz7tYQ0stmsxTj6bgeZUiKCa/+VL5L7MxYyjD0b
         0wIDQZhoSSlP2/OXNA1ZvNZ7eu6bx+iU/+r4lhOuLER6U+fT2mdL7/Nst8/gNHa2Fo2p
         F8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899023; x=1783503823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp5jqF9wVzylwh6iunfzS2i/3F7kyPZLMIR3V6y7MlA=;
        b=T5JL9zi+PWizZuCmNJIOw+QH4tThMLIQm3L0XI6zIAzZqX26AxLuTVrjF9gN5RPDzA
         FI1tRBDPh22IFIdM+fvtGt7qLjLrl3MN52WPOictU10smDIEL0Fs8Vyys5TvME94wjQB
         1A+I6rTp+beDIDHU8Uuizd2zDUIEIbktYi5TJ826h79T8tI+VUYQj9kY5ieLQIBZfZIT
         KLzEZ86CU2vZJCZD7B0FPTdKf0f7thBXBMQLWtaeyEnzBww+bidST0liucp6UUb2ivqZ
         4cvTwZny+kOGZsz0fNA1t7TcVjAnchy0xR76iYWiI+DI4KwwFqT7peVJRuh6UdQGm/qh
         DEZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xBZYdkig3ZguKX8oiBXjdNs6+upQQ5MEtM0uW+CLDdyG77OVzGP2YTM47OFlvzqQI7COBdy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw37FQR9b6KS2jN+pTtcyT4yLGIeJQHNgTm0ROY234oGbfK4b
	frykiPLjirhyDwJzXMQMJ+pV7Zfmw6UM2xUVTSVFxEd7S7jxDG/dWdcR/znKcDNSFJqH0EZF3NQ
	aEimGFfnwmhuyqw==
X-Received: from qtam28-n2.prod.google.com ([2002:a05:622a:e11c:20b0:51c:3cc:e861])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d:b0:517:7d9a:a88 with SMTP id d75a77b69052e-51c26b15a58mr9117621cf.37.1782899022358;
 Wed, 01 Jul 2026 02:43:42 -0700 (PDT)
Date: Wed,  1 Jul 2026 09:43:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701094341.3218199-1-edumazet@google.com>
Subject: [PATCH net-next] macsec: no longer rely on RTNL in macsec_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303556-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:ericdumazet@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,queasysnail.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE02B6EBB2C

Add READ_ONCE()/WRITE_ONCE() annotations on fields that can be
changed concurrently in macsec_changelink() and macsec_update_offload():

- secy->key_len
- secy->xpn
- tx_sc->encoding_sa
- tx_sc->encrypt
- secy->protect_frames
- tx_sc->send_sci
- tx_sc->end_station
- tx_sc->scb
- secy->replay_protect
- secy->validate_frames
- secy->replay_window
- macsec->offload

This allows macsec_fill_info() to run locklessly without RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/macsec.c | 78 +++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a92415cf51f12eab15b4c7925a25704d..1a968596ca45b8deb028b86207a501dbf3116f0f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2636,7 +2636,7 @@ static int macsec_update_offload(struct net_device *dev,
 		vlan_drop_rx_ctag_filter_info(dev);
 		vlan_drop_rx_stag_filter_info(dev);
 	}
-	macsec->offload = offload;
+	WRITE_ONCE(macsec->offload, offload);
 	/* Add VLAN filters when enabling offload. */
 	if (prev_offload == MACSEC_OFFLOAD_OFF) {
 		ret = vlan_get_rx_ctag_filter_info(dev);
@@ -2666,7 +2666,7 @@ static int macsec_update_offload(struct net_device *dev,
 	return 0;
 
 rollback_offload:
-	macsec->offload = prev_offload;
+	WRITE_ONCE(macsec->offload, prev_offload);
 	macsec_offload(ops->mdo_del_secy, &ctx);
 
 	return ret;
@@ -3875,52 +3875,53 @@ static int macsec_changelink_common(struct net_device *dev,
 
 	if (data[IFLA_MACSEC_ENCODING_SA]) {
 		struct macsec_tx_sa *tx_sa;
+		u8 encoding_sa = nla_get_u8(data[IFLA_MACSEC_ENCODING_SA]);
 
-		tx_sc->encoding_sa = nla_get_u8(data[IFLA_MACSEC_ENCODING_SA]);
-		tx_sa = rtnl_dereference(tx_sc->sa[tx_sc->encoding_sa]);
+		WRITE_ONCE(tx_sc->encoding_sa, encoding_sa);
+		tx_sa = rtnl_dereference(tx_sc->sa[encoding_sa]);
 
 		secy->operational = tx_sa && tx_sa->active;
 	}
 
 	if (data[IFLA_MACSEC_ENCRYPT])
-		tx_sc->encrypt = !!nla_get_u8(data[IFLA_MACSEC_ENCRYPT]);
+		WRITE_ONCE(tx_sc->encrypt, !!nla_get_u8(data[IFLA_MACSEC_ENCRYPT]));
 
 	if (data[IFLA_MACSEC_PROTECT])
-		secy->protect_frames = !!nla_get_u8(data[IFLA_MACSEC_PROTECT]);
+		WRITE_ONCE(secy->protect_frames, !!nla_get_u8(data[IFLA_MACSEC_PROTECT]));
 
 	if (data[IFLA_MACSEC_INC_SCI])
-		tx_sc->send_sci = !!nla_get_u8(data[IFLA_MACSEC_INC_SCI]);
+		WRITE_ONCE(tx_sc->send_sci, !!nla_get_u8(data[IFLA_MACSEC_INC_SCI]));
 
 	if (data[IFLA_MACSEC_ES])
-		tx_sc->end_station = !!nla_get_u8(data[IFLA_MACSEC_ES]);
+		WRITE_ONCE(tx_sc->end_station, !!nla_get_u8(data[IFLA_MACSEC_ES]));
 
 	if (data[IFLA_MACSEC_SCB])
-		tx_sc->scb = !!nla_get_u8(data[IFLA_MACSEC_SCB]);
+		WRITE_ONCE(tx_sc->scb, !!nla_get_u8(data[IFLA_MACSEC_SCB]));
 
 	if (data[IFLA_MACSEC_REPLAY_PROTECT])
-		secy->replay_protect = !!nla_get_u8(data[IFLA_MACSEC_REPLAY_PROTECT]);
+		WRITE_ONCE(secy->replay_protect, !!nla_get_u8(data[IFLA_MACSEC_REPLAY_PROTECT]));
 
 	if (data[IFLA_MACSEC_VALIDATION])
-		secy->validate_frames = nla_get_u8(data[IFLA_MACSEC_VALIDATION]);
+		WRITE_ONCE(secy->validate_frames, nla_get_u8(data[IFLA_MACSEC_VALIDATION]));
 
 	if (data[IFLA_MACSEC_CIPHER_SUITE]) {
 		switch (nla_get_u64(data[IFLA_MACSEC_CIPHER_SUITE])) {
 		case MACSEC_CIPHER_ID_GCM_AES_128:
 		case MACSEC_DEFAULT_CIPHER_ID:
-			secy->key_len = MACSEC_GCM_AES_128_SAK_LEN;
-			secy->xpn = false;
+			WRITE_ONCE(secy->key_len, MACSEC_GCM_AES_128_SAK_LEN);
+			WRITE_ONCE(secy->xpn, false);
 			break;
 		case MACSEC_CIPHER_ID_GCM_AES_256:
-			secy->key_len = MACSEC_GCM_AES_256_SAK_LEN;
-			secy->xpn = false;
+			WRITE_ONCE(secy->key_len, MACSEC_GCM_AES_256_SAK_LEN);
+			WRITE_ONCE(secy->xpn, false);
 			break;
 		case MACSEC_CIPHER_ID_GCM_AES_XPN_128:
-			secy->key_len = MACSEC_GCM_AES_128_SAK_LEN;
-			secy->xpn = true;
+			WRITE_ONCE(secy->key_len, MACSEC_GCM_AES_128_SAK_LEN);
+			WRITE_ONCE(secy->xpn, true);
 			break;
 		case MACSEC_CIPHER_ID_GCM_AES_XPN_256:
-			secy->key_len = MACSEC_GCM_AES_256_SAK_LEN;
-			secy->xpn = true;
+			WRITE_ONCE(secy->key_len, MACSEC_GCM_AES_256_SAK_LEN);
+			WRITE_ONCE(secy->xpn, true);
 			break;
 		default:
 			return -EINVAL;
@@ -3928,13 +3929,14 @@ static int macsec_changelink_common(struct net_device *dev,
 	}
 
 	if (data[IFLA_MACSEC_WINDOW]) {
-		secy->replay_window = nla_get_u32(data[IFLA_MACSEC_WINDOW]);
+		u32 replay_window = nla_get_u32(data[IFLA_MACSEC_WINDOW]);
 
 		/* IEEE 802.1AEbw-2013 10.7.8 - maximum replay window
 		 * for XPN cipher suites */
 		if (secy->xpn &&
-		    secy->replay_window > MACSEC_XPN_MAX_REPLAY_WINDOW)
+		    replay_window > MACSEC_XPN_MAX_REPLAY_WINDOW)
 			return -EINVAL;
+		WRITE_ONCE(secy->replay_window, replay_window);
 	}
 
 	return 0;
@@ -4382,21 +4384,21 @@ static size_t macsec_get_size(const struct net_device *dev)
 static int macsec_fill_info(struct sk_buff *skb,
 			    const struct net_device *dev)
 {
-	struct macsec_tx_sc *tx_sc;
-	struct macsec_dev *macsec;
-	struct macsec_secy *secy;
+	const struct macsec_tx_sc *tx_sc;
+	const struct macsec_dev *macsec;
+	const struct macsec_secy *secy;
 	u64 csid;
 
 	macsec = macsec_priv(dev);
 	secy = &macsec->secy;
 	tx_sc = &secy->tx_sc;
 
-	switch (secy->key_len) {
+	switch (READ_ONCE(secy->key_len)) {
 	case MACSEC_GCM_AES_128_SAK_LEN:
-		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_128 : MACSEC_DEFAULT_CIPHER_ID;
+		csid = READ_ONCE(secy->xpn) ? MACSEC_CIPHER_ID_GCM_AES_XPN_128 : MACSEC_DEFAULT_CIPHER_ID;
 		break;
 	case MACSEC_GCM_AES_256_SAK_LEN:
-		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
+		csid = READ_ONCE(secy->xpn) ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
 		break;
 	default:
 		goto nla_put_failure;
@@ -4407,20 +4409,20 @@ static int macsec_fill_info(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_MACSEC_ICV_LEN, secy->icv_len) ||
 	    nla_put_u64_64bit(skb, IFLA_MACSEC_CIPHER_SUITE,
 			      csid, IFLA_MACSEC_PAD) ||
-	    nla_put_u8(skb, IFLA_MACSEC_ENCODING_SA, tx_sc->encoding_sa) ||
-	    nla_put_u8(skb, IFLA_MACSEC_ENCRYPT, tx_sc->encrypt) ||
-	    nla_put_u8(skb, IFLA_MACSEC_PROTECT, secy->protect_frames) ||
-	    nla_put_u8(skb, IFLA_MACSEC_INC_SCI, tx_sc->send_sci) ||
-	    nla_put_u8(skb, IFLA_MACSEC_ES, tx_sc->end_station) ||
-	    nla_put_u8(skb, IFLA_MACSEC_SCB, tx_sc->scb) ||
-	    nla_put_u8(skb, IFLA_MACSEC_REPLAY_PROTECT, secy->replay_protect) ||
-	    nla_put_u8(skb, IFLA_MACSEC_VALIDATION, secy->validate_frames) ||
-	    nla_put_u8(skb, IFLA_MACSEC_OFFLOAD, macsec->offload) ||
+	    nla_put_u8(skb, IFLA_MACSEC_ENCODING_SA, READ_ONCE(tx_sc->encoding_sa)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_ENCRYPT, READ_ONCE(tx_sc->encrypt)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_PROTECT, READ_ONCE(secy->protect_frames)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_INC_SCI, READ_ONCE(tx_sc->send_sci)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_ES, READ_ONCE(tx_sc->end_station)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_SCB, READ_ONCE(tx_sc->scb)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_REPLAY_PROTECT, READ_ONCE(secy->replay_protect)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_VALIDATION, READ_ONCE(secy->validate_frames)) ||
+	    nla_put_u8(skb, IFLA_MACSEC_OFFLOAD, READ_ONCE(macsec->offload)) ||
 	    0)
 		goto nla_put_failure;
 
-	if (secy->replay_protect) {
-		if (nla_put_u32(skb, IFLA_MACSEC_WINDOW, secy->replay_window))
+	if (READ_ONCE(secy->replay_protect)) {
+		if (nla_put_u32(skb, IFLA_MACSEC_WINDOW, READ_ONCE(secy->replay_window)))
 			goto nla_put_failure;
 	}
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


