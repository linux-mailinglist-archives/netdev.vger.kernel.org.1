Return-Path: <netdev+bounces-294727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSTLLT8VIGpfvgAAu9opvQ
	(envelope-from <netdev+bounces-294727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:51:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A5637398
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lJmjFgXP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294727-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8649F300B9FE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FD46AF08;
	Wed,  3 Jun 2026 11:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68845107A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 11:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487139; cv=none; b=q/yL8XOk9BFZIJuc1rWM/18J6s0KdS2cHdSwRuUFTRSSdhuYNtbvp6IzaRnzeN2LVpiTQDh8dw7gUICrW2xGATsy86WXZxgkBggahwstkgMVPcRoKrmW9swpiEDqv6jveJh5SUrq/cTXTYWA+AZVa/XJhrq6sS9BzCs8wBY8IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487139; c=relaxed/simple;
	bh=gd5vDE0EgC5Y/TloUUjWllfVdY/CPpj1lgzm/vFa0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHNNe7b/FC4z9Jfk3pfja0UghAU/6mG/BQEi1ihui8Vv/q8NxwRrdKQlZS0MZ6Ws2yNJg4akI1/9NoCNPaJ1jvSKkL60RaGlOVhNDobVXzEWvzwAjlLmoGnsAMjf0+PAYtGzmpVE55SvIAk+BeWpzbUoYK8TR1zKWmVfGiXyCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJmjFgXP; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4908b92904fso72894825e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780487133; x=1781091933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8HLA5Iqrs8aKSaat9xrCrQaPXrAkc97UqyJ91X2+cQ=;
        b=lJmjFgXPFt6SsHWHSgMJdO6OfeQHCP9wMJzxZyrFmAtn0slT3pOYrMotcuPA45zV50
         dDo1Z7qwowvi0anooRf5D6f+NSvwbs9dBGg/pdWZIoX5bjBWVbG47+3ws0ofXSiB/iQW
         z5gtUVujeSIeF7zjI0DQ7fiXuWLWsjEdPbgvvX88VS9I5rxhh0gyT8G+RdWy+Sd+GF9c
         cjbHMwKTzlV0u5KnKpcI/6V9v6gVFll6SkkW4uYRyjk8onyTiwMdgfWmETXkv3Yps1qg
         Wuve5CenqaCpGIxF3BJ4LXMCgO4HWcH7Q2lNHFEUnI28jNn7Te3s0goILiAR0aUHKsiP
         mKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487133; x=1781091933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8HLA5Iqrs8aKSaat9xrCrQaPXrAkc97UqyJ91X2+cQ=;
        b=CF+idxfqPnqkys49t7d2nm/3mJADmEEmnKnY3/qab7ThUqtVuMetnNspBtl1EFmedZ
         jotdzBS7vrhHIzsnCI+4tMYOeumro8+QaX5xLiIce2RGV4pPQcrQn0uBLb0PAJVtj/9k
         CjpYOwfyN0rnCtUfL4CX55o8J4YcUopZOX6QpjmoyvnsqQCu0A73vVVpGBNQHFo9DPrM
         h+mrnxkiUDeYMnECAaeFvOUmKy52ZpFUSDW2kr9OA2tapYdTz1pFndd5lyOBiciHw36+
         Od7N2P10adQBGkqGG9FfxOdS4bghG8nYC9K0v9VH52XX9NVdgvYujF66031HUQV7QGii
         lbig==
X-Gm-Message-State: AOJu0Yx59IZJCBtX2QVOfGjNmBjALzbz9TfOm1uijLPdCsRF4+ht00e9
	q2/Vs0YI5rL35jJP+Eha1K+rUSNK5x9je7bxekvxtRrHU7IaGldwPaW581QF3pFn
X-Gm-Gg: Acq92OFy3ofPwbPefKe6+4NllpNQpOR4n3F3n0K3jqhp/OlkXnriULeT3Kq5bdvEIH6
	H/ErXJ1Qh8gfdvMlL19auBWseodWstRyziIdJhTD4d99Wn3QHfC4n6xItTy0uKROJDi+3X70dly
	i3IdRRNIiYz65SJlSNo1m4Z06rKAQ975NxUhSlAiF6X2eUO8vF6wjsQO20d017OhPFLw8+gaatU
	5ale/2kbARVDBnUlF1gWCQV3DIq92Qzxdmwy1zWqRgJG0aJBZ8TNgf17tWcmY3X2KsaX3aDmzit
	eyCNqqe+tDnC5ujcFxJ81f+W7tx19GCKMQqfP+jGX1Grb4OhwHeJ6rh8+37etXOWh6KFRU/lm41
	8GO/ULuJi5PhEi9/WaKVg+gIBoy3Fnb87CVmjOYrlbd+8FIeUONI7sBNPqmKoMY8MmrqSkVzCvp
	8y6pyxR1DCug/TUCEambVfyIISaUSQfH8uIdhOpfEUhVxIqmaw13mEp/w4nAtZrTUgpipwBM9KO
	4pgigQhCRoi3YrqLA==
X-Received: by 2002:a05:600c:4e0a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-490b5fd8a86mr52359605e9.15.1780487133034;
        Wed, 03 Jun 2026 04:45:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:827:3b28:500:30ab:2400:2a9c:6742])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b616d6a9sm54244165e9.7.2026.06.03.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:45:32 -0700 (PDT)
From: Alessandro Schino <7991aleschino@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Alessandro Schino <7991aleschino@gmail.com>
Subject: [PATCH ipsec v2] esp: fix page frag reference leak on skb_to_sgvec failure
Date: Wed,  3 Jun 2026 13:45:07 +0200
Message-ID: <20260603114507.1443-1-7991aleschino@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294727-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:7991aleschino@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F38A5637398

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

Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
unconditionally unrefs the source scatterlist frags. Since req->src is
not yet initialized by aead_request_set_crypt() at the point of the
error, the source scatterlist is obtained directly via esp_req_sg().
Existing callers pass false to preserve the original behavior.

The same issue exists in both esp4 and esp6 as the code is identical.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
---
v2: split the long line in esp_ssg_unref() to keep it under 100 columns

 net/ipv4/esp4.c | 7 +++++--
 net/ipv6/esp6.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2429c7845984..dfc81ee969ae 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -113,10 +113,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (already_unref || req->src != req->dst)
-		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 50af6ab9b8fc..296b57926abb 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -130,10 +130,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (already_unref || req->src != req->dst)
-		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
+	if (already_unref || req->src != req->dst) {
+		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
+
+		for (sg = sg_next(src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
+	}
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.41.0.windows.3


