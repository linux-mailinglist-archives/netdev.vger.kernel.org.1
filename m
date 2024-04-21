Return-Path: <netdev+bounces-89887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAE8AC0FC
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 21:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA941C2088D
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B113FE2E;
	Sun, 21 Apr 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGLGpp3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945C2A1A6
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728313; cv=none; b=L2o8UBBuTcytB7pQrBn2Nk/91W7ZenWz9Z8c4nRA8xO/rrJzh+MjYmarJMD+L0+2RHtNq405zvSUBUngSxe/94R/4Is9UJy5OKBy6lNDveDf4hA7npMAEvdLNePxO7UA4h7RbxzQjb6+LS0GIOujZWiVNVQJ9mZIpYyTpFEpaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728313; c=relaxed/simple;
	bh=NQ6jGcuJeh/p/1L3JgZ7DNU+1Z6CWWrISyazrIPTAcc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k7lontVs0rW2Rp74+t1+pu30sM0td+bQeJneGdn+ww+2ps0MSp/6fbdQY8VhZecceXiB89q92C1lfDL/YrHJuy+YAA1ASNbDjnHwjS2Y2r5zglxoGZviHetDh6gvY0aGlbaq2xkz0/B1GM6zNKp+8yGXPYKrF5EFiZSM6wmFW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGLGpp3j; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so7699166276.2
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713728310; x=1714333110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+SDkMfwULRoZeQrUX2iv0BBJGBbsaFvsR3oFiKSjB4=;
        b=bGLGpp3joZK7lCxrUorDp7c4xyxE0UD0NpdTlPSP+G1HqhKJPZdS5d4xV0QZ2tNP3X
         JgSNa2E0N239q1N4tqR0a9lqAuqsVsBjoovoRSGTXDr8M/xgDEYZjgD+0l01LlK9EIku
         fPfI9SZDXRYZDpXEssIHM8h+Skx2f6518HInfErzoB47KJFasRl5OGcTSIN+xwnYHgfr
         vHux1SNcSewBKzi72uoOfAvv8fItdugu0KoGbdGNGnrL6dAogKhXz5E7sV3PSvov8wop
         qmsT20yykvlnN32YNZSIYOt+qUf1znvpNRBVN44P7j15HO/XEvxdCLTvGy5BWD9XVxQr
         nDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713728310; x=1714333110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+SDkMfwULRoZeQrUX2iv0BBJGBbsaFvsR3oFiKSjB4=;
        b=faRmsDcE8DA/LQxAg9fp6m9iFUbJ7OGXOsmIKzmk18E9Wmj+e0B6yxRkfZk++I5kkX
         74hmNjgyn40dkdtIDVjzXGEevEnztfTNXYdW7m4pEwsr8drc1avQX0tbqaFguGzck5Gl
         OG/ReIPM6WL0SDd3fKGd3Dlj7zpu+fAsIK/93e3k1OEi6fViks/a3eng85HBFmIc+uaA
         13Gs2wkuh5q08yszSQqWfgo6vjpQ+eSN8Jkhj+aEwB51NJOGQ25xBucz7Klg25llmurO
         1ps8nylrtmlMoMfCpE+XxBqiJSoWiX2deyMAp7zrRfsZ40+RGlgpflj2sevVTWyEmvdX
         g/8w==
X-Gm-Message-State: AOJu0YwVHimH/c9KisL0SMTX5QiEVmEA+LVAo6JsaFGErHgqkAkYq6Ap
	H65R0re19WALymcqtE19f83Hemd3wMy42neGX08xqfH+pvWowtn4M+tgujAVSCBGjS3KwvMJJCH
	9JNnpEfRuow==
X-Google-Smtp-Source: AGHT+IHL2C5MoyxhTwKcYbvzD7oOcmK2st6QSqadSAT5HJwQyi578v50yeaUVlRt+geimqSc549RQ7Ldb7a5iw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100e:b0:de4:c2d4:e14f with SMTP
 id w14-20020a056902100e00b00de4c2d4e14fmr2528790ybt.11.1713728310568; Sun, 21
 Apr 2024 12:38:30 -0700 (PDT)
Date: Sun, 21 Apr 2024 19:38:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240421193828.1966195-1-edumazet@google.com>
Subject: [PATCH net] net: usb: ax88179_178a: stop lying about skb->truesize
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, shironeko <shironeko@tesaguri.club>, 
	Jose Alonso <joalonsof@gmail.com>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some usb drivers try to set small skb->truesize and break
core networking stacks.

In this patch, I removed one of the skb->truesize overide.

I also replaced one skb_clone() by an allocation of a fresh
and small skb, to get minimally sized skbs, like we did
in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
in rx path")

Fixes: f8ebb3ac881b ("net: usb: ax88179_178a: Fix packet receiving")
Reported-by: shironeko <shironeko@tesaguri.club>
Closes: https://lore.kernel.org/netdev/c110f41a0d2776b525930f213ca9715c@tesaguri.club/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jose Alonso <joalonsof@gmail.com>
Cc: linux-usb@vger.kernel.org
---
 drivers/net/usb/ax88179_178a.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 752f821a19901f313a1aca51fe332539ce82385b..df9d767cb524241848c744504d6e2999efc42ed5 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1456,21 +1456,16 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			/* Skip IP alignment pseudo header */
 			skb_pull(skb, 2);
 
-			skb->truesize = SKB_TRUESIZE(pkt_len_plus_padd);
 			ax88179_rx_checksum(skb, pkt_hdr);
 			return 1;
 		}
 
-		ax_skb = skb_clone(skb, GFP_ATOMIC);
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 		if (!ax_skb)
 			return 0;
-		skb_trim(ax_skb, pkt_len);
+		skb_put(ax_skb, pkt_len);
+		memcpy(ax_skb->data, skb->data + 2, pkt_len);
 
-		/* Skip IP alignment pseudo header */
-		skb_pull(ax_skb, 2);
-
-		skb->truesize = pkt_len_plus_padd +
-				SKB_DATA_ALIGN(sizeof(struct sk_buff));
 		ax88179_rx_checksum(ax_skb, pkt_hdr);
 		usbnet_skb_return(dev, ax_skb);
 
-- 
2.44.0.769.g3c40516874-goog


