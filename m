Return-Path: <netdev+bounces-297699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RUb0NYRxKWriWwMAu9opvQ
	(envelope-from <netdev+bounces-297699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:15:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60E66A24E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=QNycPprK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297699-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 348FF306495B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070D40FD86;
	Wed, 10 Jun 2026 14:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9A40E8EC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100504; cv=none; b=p5LQgIfrItrY36iPE5YGUHeffLDnGMAfFbesMtKBqmWQr0HGLKbZuTAtDtpqursTfhPyLr2dd1ScR59mWigUhxknkqL/o11afBUe//+EA1knMh10/kZWGNpHMqb+v+kjNjoEK6h/3H2ESCX2m/cxAN2m37P2FebwNmfq9ql/rSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100504; c=relaxed/simple;
	bh=c512lAqmBE/g2psvsDpleQJf7mZdIZnrheqky+SybQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMKpC4G+iAYiwB+doFwifx/sEp6dxYI4L0cHBBjccSCzQbEVpxRYEyBoRuntiMPbqpefHHYK4HzPQFBdGqchgHPM15sYnrMeNURJTXWQKNSoFSlqLyvksYZkobh1R1OEXHjJf/CG3vjGVvOPwGbG0O3blCpjBt2GcaEptEqsS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QNycPprK; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 15F26207BB;
	Wed, 10 Jun 2026 16:08:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5JqTHq9fN4N; Wed, 10 Jun 2026 16:08:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4FADA207B0;
	Wed, 10 Jun 2026 16:08:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4FADA207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781100493;
	bh=lWr0oq7Pcu2uuNN0m3TDfyIk7khPZEWFRnMcpXPNZYw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QNycPprKwqUm0sd1WRCOC6xt+C++SUsysDxpBjknjt3jSmRYN9g5NbVSH/FRMivjT
	 EytpTLg/PZ94xm6GzSTKpHN7c6+xkDjVxkup6j2n73yyCGlk2PSwsxQOxnXDpj6P6+
	 QsGe8UkpmFYlquuXnjcd44biJBg+8phNey173EuS1qF55Q9IZZ4voYdNhg2T1X5Iw5
	 ei/kPQBWzhZcz/939X1mEcThXvz5YlFoKHmjtqfhaNEXbZY0sVxOFwoe+xcNHVzQcQ
	 gqFjazEwtN5DhpeReFX/aAIr1GEbb8Pvj1m1BLtNNw5rBhG68c/nk+zF1S8RQ/RZTJ
	 4herAQXXDjzew==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 16:08:12 +0200
Received: (nullmailer pid 2563209 invoked by uid 1000);
	Wed, 10 Jun 2026 14:08:07 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/6] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Wed, 10 Jun 2026 16:07:45 +0200
Message-ID: <20260610140800.2562818-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610140800.2562818-1-steffen.klassert@secunet.com>
References: <20260610140800.2562818-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297699-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C60E66A24E

From: Alessandro Schino <7991aleschino@gmail.com>

In esp_output_tail(), when esp->inplace is false, the old skb page frags
are replaced with a new page from the xfrm page_frag cache The source
scatterlist (sg) is built from the old frags before the replacement, and
esp_ssg_unref() is responsible for releasing the old page references
after the crypto operation completes

However, if the second skb_to_sgvec() call (which builds the destination
scatterlist from the new page) fails, the code jumps to error_free which
only calls kfree(tmp). The old page frag references captured in the
source scatterlist are never released:

  1 sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
  2 nr_frags is set to 1 and frag[0] is replaced with the new page
  3 Second skb_to_sgvec() fails -> goto error_free

Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
unconditionally unrefs the source scatterlist frags. Since req->src is
not yet initialized by aead_request_set_crypt() at the point of the
error, the source scatterlist is obtained directly via esp_req_sg()
Existing callers pass false to preserve the original behavior

The same issue exists in both esp4 and esp6 as the code is identical

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 17 +++++++++++------
 net/ipv6/esp6.c | 17 +++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 513c8215c947..dfc81ee969ae 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -113,10 +113,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET_ESPINTCP
@@ -220,7 +223,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -569,8 +572,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -602,7 +607,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 57481e423e59..296b57926abb 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -113,7 +113,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -130,10 +130,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (req->src != req->dst)
-		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
@@ -254,7 +257,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb);
+	esp_ssg_unref(x, tmp, skb, false);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -600,8 +603,10 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0))
+		if (unlikely(err < 0)) {
+			esp_ssg_unref(x, tmp, skb, true);
 			goto error_free;
+		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -634,7 +639,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb);
+		esp_ssg_unref(x, tmp, skb, false);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.43.0


