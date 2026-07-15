Return-Path: <netdev+bounces-307666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LeXKHhghV2q5FgEAu9opvQ
	(envelope-from <netdev+bounces-307666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:56:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62975AC75
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:56:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rMMAatdQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307666-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 078F8302F42C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6B3B6359;
	Wed, 15 Jul 2026 05:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F2288B8
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:55:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094946; cv=none; b=p/84nNAydPc1K6ESFnyy1kagZBL0FlHD6hJGnYmHtfiFn8wAkA0WDBsgH+hG6k54EV0cH8i0c6X68+WYiYQZd9eQsKm3F/AyO6rzllYXFaPJrz913WJ5Z/Don6CnloI2NIR9091N1EF85kphYM/EGfNFxyH5VAAtQrTBe6fhfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094946; c=relaxed/simple;
	bh=53XfI/KkF0mmY5A9JJmrFjOmjJhgDNUEArjHoTmn+MQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ExyUbB/GHfcxCy6VXEWDon8SYjSkcMsqP5SbYEvyo9HH7IsPa5nDbpY/31rDmadA6lksotZWw7jBW7zFttQ8zz58rPM+SmgM+XHY26RnbqP0iZGxT8i0Hp8vBjWyo9206cZTLlVSSMUDzFcL2TnNICnH69cigsJpJwO9cILd418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMMAatdQ; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8efe7db1c42so87979816d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784094943; x=1784699743; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1DRXJ9qvEDCtJ8qta/t+BdzBvjJWf+O4Oh/glnl8ig=;
        b=rMMAatdQCi/HPCgt1GIGMFM/XPsWYRh2aPa2UVywsBtmsHhUG7bpCNvzz200QRfxAh
         qF5tp+NNgCVIhdJA6FfbfzH89Ex1Mn7+AdtBntHzGrVj98miUTG/MKD1T9nYVfi6CN3k
         TIHJes6wm7a2FKX9l/ujeDWtfsAT9Oo78jH02cWadceOa9arCABZXuMQ+sKU+D5YdHt0
         poCBELuMK2MH+KTFcnc9OuEfbmlD6swc7jsVja8fv5GxfNaz9zrKiYQte6h6rgLH/HdW
         Ewppg9iyy67447csgcJzPFzAY5rVoOhCAPpwwV1uDduXLS59wWi0fXSFp2S3xgc8U0G+
         VDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094943; x=1784699743;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1DRXJ9qvEDCtJ8qta/t+BdzBvjJWf+O4Oh/glnl8ig=;
        b=CVmU6zqCUKoTsgc2VYRMAx4pFjOP3a4XZ6io+UI1/Zk30/7OcwDnNiy6fYd8IOg3Zy
         EgHXQ+CtWhP8CwZMwMo8s3NqXhl79pWrbQR13bpeqYGqqm7iiAex3wQlD7GwJHzdPLbl
         ns16jmRaJpeDxv9epgZSR6OkQEMFUmAQ71mRTIX94H91U8R1KvjOjL/r8+LaXDKo74wp
         qE3qSUEC7+bRTaYeSTZ77gvDAZmF1Z2rLHMUygEFGM8NE2R+McM9N7hrQfXJcul8JFS5
         6p0joXBzxCAiWtKNI6Bzho6wjK23ustdFHWRCWKXOiKR4pfhm+v6IVvePOKoSzyyzTIP
         Rtdg==
X-Forwarded-Encrypted: i=1; AHgh+RqeoP4z4F8KajSpwcJeiUS8Hz6V+R3IBTCfnX3pDTekaiJ99hXwYBvgAZvfAf77Cgack0N0gJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWx7sBx0RiNUXEa78L1u5smYVX7EhOvSaed1ey0fY5l62GpKZ
	uNhHSYK1K8tQzT6zXwP0KwM0c/O8e/vn3ONaEJnxfijcl14roEagP1xshW2fmZW5ohGUhb0b5OI
	lBnnrqBe+8EwPcA==
X-Received: from qvop1.prod.google.com ([2002:a0c:fac1:0:b0:8dd:6cbd:afab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:800a:b0:907:5516:3d61 with SMTP id 6a1803df08f44-90755163e96mr34199166d6.21.1784094943070;
 Tue, 14 Jul 2026 22:55:43 -0700 (PDT)
Date: Wed, 15 Jul 2026 05:55:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715055541.1147542-1-edumazet@google.com>
Subject: [PATCH net] ppp: annotate concurrent dev->stats accesses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307666-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D62975AC75

dev->stats fields can be updated concurrently from multiple CPUs
without synchronization.

Use DEV_STATS_INC() for stats increments and DEV_STATS_READ()
when reading dev->stats in ppp_get_stats64() and ppp_get_stats()
to avoid data races.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/ppp_generic.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 717c1d3aa95380da64eb5ae6fc1da6e4dfaa9d87..ef54e0a0462a175bb989db8dda895e9ae755965f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1482,7 +1482,7 @@ ppp_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
  outf:
 	kfree_skb(skb);
-	++dev->stats.tx_dropped;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -1532,11 +1532,11 @@ ppp_net_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 static void
 ppp_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
 {
-	stats64->rx_errors        = dev->stats.rx_errors;
-	stats64->tx_errors        = dev->stats.tx_errors;
-	stats64->rx_dropped       = dev->stats.rx_dropped;
-	stats64->tx_dropped       = dev->stats.tx_dropped;
-	stats64->rx_length_errors = dev->stats.rx_length_errors;
+	stats64->rx_errors        = DEV_STATS_READ(dev, rx_errors);
+	stats64->tx_errors        = DEV_STATS_READ(dev, tx_errors);
+	stats64->rx_dropped       = DEV_STATS_READ(dev, rx_dropped);
+	stats64->tx_dropped       = DEV_STATS_READ(dev, tx_dropped);
+	stats64->rx_length_errors = DEV_STATS_READ(dev, rx_length_errors);
 	dev_fetch_sw_netstats(stats64, dev->tstats);
 }
 
@@ -1889,7 +1889,7 @@ ppp_prepare_tx_skb(struct ppp *ppp, struct sk_buff **pskb)
 
  drop:
 	kfree_skb(skb);
-	++ppp->dev->stats.tx_errors;
+	DEV_STATS_INC(ppp->dev, tx_errors);
 	return 1;
 }
 
@@ -2156,7 +2156,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
  err_linearize:
 	if (ppp->debug & 1)
 		netdev_err(ppp->dev, "PPP: no memory (fragment)\n");
-	++ppp->dev->stats.tx_errors;
+	DEV_STATS_INC(ppp->dev, tx_errors);
 	++ppp->nxseq;
 	return 1;	/* abandon the frame */
 }
@@ -2329,7 +2329,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 	if (!ppp_decompress_proto(skb)) {
 		kfree_skb(skb);
 		if (ppp) {
-			++ppp->dev->stats.rx_length_errors;
+			DEV_STATS_INC(ppp->dev, rx_length_errors);
 			ppp_receive_error(ppp);
 		}
 		goto done;
@@ -2391,7 +2391,7 @@ ppp_receive_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 static void
 ppp_receive_error(struct ppp *ppp)
 {
-	++ppp->dev->stats.rx_errors;
+	DEV_STATS_INC(ppp->dev, rx_errors);
 	if (ppp->vj)
 		slhc_toss(ppp->vj);
 }
@@ -2658,7 +2658,7 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 	 */
 	if (seq_before(seq, ppp->nextseq)) {
 		kfree_skb(skb);
-		++ppp->dev->stats.rx_dropped;
+		DEV_STATS_INC(ppp->dev, rx_dropped);
 		ppp_receive_error(ppp);
 		return;
 	}
@@ -2694,7 +2694,7 @@ ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 		if (pskb_may_pull(skb, 2))
 			ppp_receive_nonmp_frame(ppp, skb);
 		else {
-			++ppp->dev->stats.rx_length_errors;
+			DEV_STATS_INC(ppp->dev, rx_length_errors);
 			kfree_skb(skb);
 			ppp_receive_error(ppp);
 		}
@@ -2800,7 +2800,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 		if (lost == 0 && (PPP_MP_CB(p)->BEbits & E) &&
 		    (PPP_MP_CB(head)->BEbits & B)) {
 			if (len > ppp->mrru + 2) {
-				++ppp->dev->stats.rx_length_errors;
+				DEV_STATS_INC(ppp->dev, rx_length_errors);
 				netdev_printk(KERN_DEBUG, ppp->dev,
 					      "PPP: reconstructed packet"
 					      " is too long (%d)\n", len);
@@ -2855,7 +2855,7 @@ ppp_mp_reconstruct(struct ppp *ppp)
 					      "  missed pkts %u..%u\n",
 					      ppp->nextseq,
 					      PPP_MP_CB(head)->sequence-1);
-			++ppp->dev->stats.rx_dropped;
+			DEV_STATS_INC(ppp->dev, rx_dropped);
 			ppp_receive_error(ppp);
 		}
 
@@ -3322,8 +3322,8 @@ ppp_get_stats(struct ppp *ppp, struct ppp_stats *st)
 		st->p.ppp_opackets += tx_packets;
 		st->p.ppp_obytes += tx_bytes;
 	}
-	st->p.ppp_ierrors = ppp->dev->stats.rx_errors;
-	st->p.ppp_oerrors = ppp->dev->stats.tx_errors;
+	st->p.ppp_ierrors = DEV_STATS_READ(ppp->dev, rx_errors);
+	st->p.ppp_oerrors = DEV_STATS_READ(ppp->dev, tx_errors);
 	if (!vj)
 		return;
 	st->vj.vjs_packets = vj->sls_o_compressed + vj->sls_o_uncompressed;
-- 
2.55.0.141.g00534a21ce-goog


