Return-Path: <netdev+bounces-195357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D597CACFDB3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650F2189A5D5
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6428466C;
	Fri,  6 Jun 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Wx8myK16"
X-Original-To: netdev@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8324EABC
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196068; cv=none; b=tANAwpc7CyH7YA0s52uV1nDOcNTAMU5YVcBcfSaM1rPe0sW/Uyp4BJw41NQy2M+CXr2sR+9Hm8PUfGmLwfFI42JTnnD7sh7euyPZ2BOm6MB/9uqfoy0kZ66oosU8iAemafyrAVpquf3deUIDTJ6zvSJ8mlKIIdkz/z+kGXt0CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196068; c=relaxed/simple;
	bh=OvapX4HQacQWD92oMRx3oG8iPYYITLHqOc2Uea8osUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAFxDi/n+MziwJhduFo/dXlfC6/oyn2TO3XNOpPP0GZxHedHt5OIG13Rlx67mB6BEA9i0N0cAa912fOsjXbOaOV2YtvLZOSbnMxJX2q4hju+hT5ut4mzv1McM+1tYOWTpIqTWA6171xa+3kORz809n/fVE0EdafMxKx/UtAWD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Wx8myK16; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 8C4CE6449C
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 10:41:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c122:0:640:3648:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 8669560AE7;
	Fri,  6 Jun 2025 10:41:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7fYNPgtLhiE0-ersqVpof;
	Fri, 06 Jun 2025 10:41:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749195668; bh=0wEmroOvWMBIWLDeBD0L00+hat/6YvzauWs7GjtLPnQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Wx8myK16xE2Nb/W62Gwp5RQv2Ja33SbxH4+oqkskHezO24lv4Woph5Xc1XTijP3Sq
	 5wg0XAYRuKtQxvFRTBhu23ttr55yF2//dmd3zYZx6+NJ0F0ygCJwIxcS39F4u+XB6/
	 dI9Y3UNP7tD+2GniW7woa22Ns2w9gHZYB6PIH2r0=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: core: avoid extra pskb_expand_head() when adjusting headroom
Date: Fri,  6 Jun 2025 10:41:04 +0300
Message-ID: <20250606074105.1382899-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'skb_realloc_headroom()' and 'skb_expand_head()', using 'skb_clone()'
with following 'pskb_expand_head()' looks suboptimal, and it's expected to
be a bit faster to do 'skb_copy_expand()' with desired headroom instead.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/core/skbuff.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..3ed540cba5a3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2316,14 +2316,10 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom)
 
 	if (delta <= 0)
 		skb2 = pskb_copy(skb, GFP_ATOMIC);
-	else {
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		if (skb2 && pskb_expand_head(skb2, SKB_DATA_ALIGN(delta), 0,
-					     GFP_ATOMIC)) {
-			kfree_skb(skb2);
-			skb2 = NULL;
-		}
-	}
+	else
+		skb2 = skb_copy_expand(skb, (skb_headroom(skb) +
+					     SKB_DATA_ALIGN(delta)),
+				       0, GFP_ATOMIC);
 	return skb2;
 }
 EXPORT_SYMBOL(skb_realloc_headroom);
@@ -2400,8 +2396,10 @@ struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom)
 	delta = SKB_DATA_ALIGN(delta);
 	/* pskb_expand_head() might crash, if skb is shared. */
 	if (skb_shared(skb) || !is_skb_wmem(skb)) {
-		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+		struct sk_buff *nskb;
 
+		nskb = skb_copy_expand(skb, skb_headroom(skb) + delta,
+				       skb_tailroom(skb), GFP_ATOMIC);
 		if (unlikely(!nskb))
 			goto fail;
 
@@ -2409,8 +2407,7 @@ struct sk_buff *skb_expand_head(struct sk_buff *skb, unsigned int headroom)
 			skb_set_owner_w(nskb, sk);
 		consume_skb(skb);
 		skb = nskb;
-	}
-	if (pskb_expand_head(skb, delta, 0, GFP_ATOMIC))
+	} else if (pskb_expand_head(skb, delta, 0, GFP_ATOMIC))
 		goto fail;
 
 	if (sk && is_skb_wmem(skb)) {
-- 
2.49.0


