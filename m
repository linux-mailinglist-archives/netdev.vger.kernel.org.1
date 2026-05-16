Return-Path: <netdev+bounces-288600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MTJBBQ3CGpregMAu9opvQ
	(envelope-from <netdev+bounces-288600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF455AE52
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 944C130072BB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6E3B27FF;
	Sat, 16 May 2026 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrlkujY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C130569C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778923274; cv=none; b=ZlJ2QuA3cESrYXVzyFUA2d/BdXsQ/AbAR8f1Vw4tocL/Rv+EKhDWgrI3++d6Afr+BsB18382QqhIZdlFBQBOyagpMn7qfzbEFRcYPIC8B6CnhFH41b8QGPrRlC4K7Log4PzrGqghqjRlsGBb6kOcxZrxIIL1MtwgxDbuXnptqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778923274; c=relaxed/simple;
	bh=KAUlGD8pSig8F/TMVTIQTYyK/3cCqbvCbas5cgepJ88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W22UHTe6mh++LXNY/0pjfuIS2Y8pMEn+4tgQ+CMOQlfOTwEagtFtv0ANig6FeyZG6bEcb+cBOR1jbjboqPFM/q1axSDRd41I8xUfmZ1a0HlzaajwCrMgYrN0VK/hgiY6UmN2SLcFSQfXyLXEfyxVOZAw+RZEBOnbsNAkwLa4zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrlkujY/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so4092305e9.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778923271; x=1779528071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsM1ZInrpVl3tD5s22jHiK6J6f9Ei6rwWy0sa4bRtVI=;
        b=UrlkujY/649GU335uxJdvWEzWu5UNZz8ih/iGr3InHP78iLCY/S4+V4nFbsWVA5kk3
         B4e7KkbheQgd9n8MUQx7cUw0ChPkaSLXBz9Cp65KtiQSo/vvc0EhuZjyk+Bv/VrhjbFL
         ix6DbFQwstZMDa16ZDiqdVTjbGTDQIQweBTNYBH9wE9o9HkiAmnMyjR4Rf7ZB+J5RyVA
         6zj0Uaje4Zfpacn85fki5doAOyrqIbCVIerloj5lSbZPvnYWMpQfpdkaj6qBzRhmrvPH
         0rQqmwmZJ39shfUdvLJ7YNQDO7e/5aTsLZbU9SQw9fmZUqz4Vp/wy3KQy3857N7ZTFsB
         ZXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778923271; x=1779528071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsM1ZInrpVl3tD5s22jHiK6J6f9Ei6rwWy0sa4bRtVI=;
        b=Mcp44i6Olmv8XkEwSpK4VtNG6xnl1qfVRhlrD+CL9OFlfO0OqluEymAGdS43Ijx13l
         IbAb5wemzP8/g1c+0NbIprb6IpaqlLAQiJLC1zbmXtjw8x085JPrfwTJ+r63YWM0bfnG
         Ig8SFR9+5htY7tI6bQKW7JZaoZTSA8Ze82EmFEcp9CkPO85BgvZav/+Q9aibGH7Nc1v3
         Tf6wjNcxWVKtdn29Lp1H798hDK8Rjp0tjo1xB+YRGAswc1C3LbQXfmQN03BjH6BT4oQP
         0kmWZTUTRwhd9HLtBdeEaq2gbUyUMMm0JRhqPbQ3l1+8wNGW2LPYF5bnxO9IQ3x7phBj
         AjUA==
X-Gm-Message-State: AOJu0YwJE10Si6aVhPGTmSE19gg4fgYzkQJqamPM+s1wwE+PagfQ92MR
	OvTOv+Y3OD3mJrAhfFsHpNtzbzxoJcygJcxVehpts3W67HpZqwWCOYfpHBsR9VW4
X-Gm-Gg: Acq92OETjyIXqpE2/QxBoYNgd/mnkk/+PDu993lAmI3KLRRkW347HyCJyXlK+/djIJi
	NZkkkEPqRMIgyO/h9KKMxouD+0NLQxw+xXFRFMYzEfAAHExLszzjK0+fIE5xOAoZ/+RqeUXFSKc
	H9pjHl5RiDAlgtzCzwnALsG5C1l3qC5Cbj0Jpzzhy7G5DCdlMh9BowLF/eMLajlviEFzqK0zmaF
	8pnkYYAefsXkFElKtFhvTvwF47OK44fC1ZNU3Of2RZ56D1SMuJodjUYdq+/ArdyzSVrSIBwUWXH
	n1/K4BmosNCKSOEMPIpFsoMAThPyQyqe/kx2w2qOsccwP89kFDVfeGYXSTY9tR2OlYgsLxif2Ub
	JX/AjMDT3lgL0YRKrBQXHHIHkeeDfsOR37Mgzqf1DzVRF7Bk9GbJdH4npS4JlZdQuBHY4deCVkp
	hv8GeAdn8iH0iuJyBpuJI20a3ibQY8j8w3rA9kNXTijcjcAyqz9x7OPKqSRVY0eSso036G/HzNW
	O6+BNA=
X-Received: by 2002:a05:600c:34c7:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48fe60ecd93mr110985485e9.12.1778923270781;
        Sat, 16 May 2026 02:21:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:b184:4b99:e746:532b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm189536735e9.1.2026.05.16.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 02:21:10 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	e521588 <alessandro.schino@sbb.ch>,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Sat, 16 May 2026 11:20:01 +0200
Message-ID: <20260516092001.679-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2ABF455AE52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,vger.kernel.org,sbb.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-288600-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sbb.ch:email]
X-Rspamd-Action: no action

From: e521588 <alessandro.schino@sbb.ch>

In esp_output_tail(), when esp->inplace is false, the old skb page frags
are replaced with a new page from the xfrm page_frag cache. The source
scatterlist (sg) is built from the old frags before the replacement, and
esp_ssg_unref() is responsible for releasing the old page references
after the crypto operation completes.

However, if the second skb_to_sgvec() call (which builds the destination
scatterlist from the new page) fails, the code jumps to error_free which
only calls kfree(tmp). The old page frag references captured in the
source scatterlist are never released:

  1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
  2. nr_frags is set to 1 and frag[0] is replaced with the new page
  3. Second skb_to_sgvec() fails -> goto error_free
  4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
  5. kfree_skb() only releases frag[0] (the new page), not the old ones

Fix this by introducing esp_ssg_unref_frags(), a variant of
esp_ssg_unref() that unconditionally unrefs the source scatterlist
frags without checking req->src and req->dst, since those fields are
not yet initialized at this point. The new function is called before
the goto error_free when the second skb_to_sgvec() fails, at which
point the source scatterlist in tmp is fully populated.

The same issue exists in both esp4 and esp6 as the code is identical.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")

Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
 net/ipv4/esp4.c | 22 +++++++++++++++++++++-
 net/ipv6/esp6.c | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 5c4b162c1bb5..bc5245c6a29a 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -119,6 +119,26 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 				       skb->pp_recycle);
 }
 
+static void esp_ssg_unref_frags(struct xfrm_state *x, void *tmp,
+                                struct sk_buff *skb)
+{
+	struct crypto_aead *aead = x->data;
+	int extralen = 0;
+	u8 *iv;
+	struct aead_request *req;
+	struct scatterlist *sg;
+
+	if (x->props.flags & XFRM_STATE_ESN)
+		extralen += sizeof(struct esp_output_extra);
+
+	iv = esp_tmp_iv(aead, tmp, extralen);
+	req = esp_tmp_req(aead, iv);
+
+	for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+		skb_page_unref(page_to_netmem(sg_page(sg)),
+			       skb->pp_recycle);
+}
+
 #ifdef CONFIG_INET_ESPINTCP
 static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 {
@@ -570,7 +590,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
 		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb);
+			esp_ssg_unref_frags(x, tmp, skb);
 			goto error_free;
 		}
 	}
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9166e1da3615..9bb7242543d8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -136,6 +136,26 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 				       skb->pp_recycle);
 }
 
+static void esp_ssg_unref_frags(struct xfrm_state *x, void *tmp,
+                                struct sk_buff *skb)
+{
+	struct crypto_aead *aead = x->data;
+	int extralen = 0;
+	u8 *iv;
+	struct aead_request *req;
+	struct scatterlist *sg;
+
+	if (x->props.flags & XFRM_STATE_ESN)
+		extralen += sizeof(struct esp_output_extra);
+
+	iv = esp_tmp_iv(aead, tmp, extralen);
+	req = esp_tmp_req(aead, iv);
+
+	for (sg = sg_next(req->src); sg; sg = sg_next(sg))
+		skb_page_unref(page_to_netmem(sg_page(sg)),
+			       skb->pp_recycle);
+}
+
 #ifdef CONFIG_INET6_ESPINTCP
 static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 {
@@ -601,7 +621,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
 		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb);
+			esp_ssg_unref_frags(x, tmp, skb);
 			goto error_free;
 		}
 	}
-- 
2.41.0.windows.3


