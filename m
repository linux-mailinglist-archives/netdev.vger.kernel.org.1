Return-Path: <netdev+bounces-195359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ABCACFDE2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE81891D16
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABFB201013;
	Fri,  6 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gXkqoXsS"
X-Original-To: netdev@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171E13B2A4
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196954; cv=none; b=JpFgN94H3/Uw0YJEPohG5gXsi6/aHRdy1F+6vi48gLxbXPJAsOnVpCQREZWEI0MpSIw56K4V5nBR0rXYKTnRlkuK8ue8Vla79OsKb17C80i9E4oyZcW8H/9WIKz8NE1vv/7ZSB7KIKpXfIun5e4sajPOPjpb3endINBJSCe62Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196954; c=relaxed/simple;
	bh=1gX2KIgXByEMwfkvgREMkqeEVeGpFpVraXwpk5/BFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtHXfm4pOLrLCIXlZSWh1cIqD2ydTZ7aPgpuT47gOEBn7cv5drT+sUf2uHIsj+AL7dXevG5qT9jeKr1zOSyX8srxlQbcZBpMP4cJjuW18gPuy7Olb3uWXoGjl43tzwh9QJAqf+mT+v8iNmcvzPJA6qLeG/fyhwRp66cc/oWBbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gXkqoXsS; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 0C22B64244
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 10:55:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:73a9:0:640:b740:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id BA2CE60B8E;
	Fri,  6 Jun 2025 10:55:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ftY6Ws0LkSw0-MQk9tEXk;
	Fri, 06 Jun 2025 10:55:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749196542; bh=6fbJmaNapAHHCEMmmtla5RZHUnzHwpkWoAyGJLFjBDE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gXkqoXsS7QIOvK3cz3v7YULFWUkuiy1U49FupRe8wpDVHJKhjpGv4CCR6Woi5dx0k
	 N/AgYWhopg57e3sbmPE2cWculCiFfBS8xJsuy1Q3s0zdjFZ1Gs16SuCgVIk2KgSFM3
	 kr0YuvS0rbHADZ4sskzXsFRPyS/GC+BeR4a/cPYM=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] net: core: avoid extra pskb_expand_head() when adjusting headroom
Date: Fri,  6 Jun 2025 10:55:17 +0300
Message-ID: <20250606075517.1383732-1-dmantipov@yandex.ru>
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
v2: pass 'skb_tailroom(...)' to 'skb_copy_expand(...)' since
the latter expects the final size rather than an increment
---
 net/core/skbuff.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..afd346c842e4 100644
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
+				       skb_tailroom(skb), GFP_ATOMIC);
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


