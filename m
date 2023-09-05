Return-Path: <netdev+bounces-31996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC18B79204C
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 06:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789E128103C
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 04:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C275B65E;
	Tue,  5 Sep 2023 04:23:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38827E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 04:23:42 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF841B6
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 21:23:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7bb58517b8so1679889276.0
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693887820; x=1694492620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBWCzlSwf8dM4GHNasiEHTJIjOq7TJu9NtuD8yppqjA=;
        b=vXjQL7FmTPpsUIZRLnGiNeAY+iK5YEJu5BEkIJd9NX1Hx7ybWSF9n+RWg038XqvipI
         0Or686KabLf9aen2Q0V/XYpd8ip5Mb19b1YzeeFwRgmNmgANIJisII4KWafwbB0LFLpF
         m+YeMkOig2gPWd0CLOGLxo+QKEfjp9Lic7E5jS9jxm4eVb/2Fb5m/yo5VKpSeVLlvmS2
         ScEm+2HZwBZT4q1lOmylFlcmTd8xiijZ0DluPLEWBB0mIIRw00tN2TAQbl7veDWAtNk9
         et8QRsL1hrjSuOBFzpO0n927OKqgDyoqwSzT2kpH4OAVk5V+HECVM/UJrU0cSHYEZc+N
         uRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693887820; x=1694492620;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBWCzlSwf8dM4GHNasiEHTJIjOq7TJu9NtuD8yppqjA=;
        b=B5AQ7h4v/XKbCGDmsCCz1ybjwO2GHiW7LyebbcK4vVrTzLbrY9D55g0swceRp6PxAE
         DWcMirAXhoeYztOqfjEyO+EtU5/NdHPlmVMDiyaQPmi1nwhAFALZeGYfKDxsDcTi7Vac
         OE/J5Enbf+SC4UsAcSVbGYMgDHgEuuCs4J3hXXPaI911d9d5aZNkbQHQnDzUem8byh95
         o4O1aPo61c6wBpHwrqQ79v0fxVT1JaV3stzE59FT7EItPs25hTCRgGhJSCn/Slx3XV4U
         wxabeZ6CPrsCtEvH5ZwR2VBe+btkxKdjcKpcucIdVW9ZNLcEOYYEliPlx+qreKS4VQvM
         +64A==
X-Gm-Message-State: AOJu0YwMfqXH/eJ7MXougQd+lFgwDGGGEASaKhlh9Z3giR++4D/Qv2nw
	aqSfQrhgfbdfx1Yrg/1BGyDksou5IBelsQ==
X-Google-Smtp-Source: AGHT+IElhWYz556jeofxh5lkbvOxvTAZno8Kj960zxnExKDoZbfUQD1ckhtQGa/+oEL32P4K0iex9j0DksFWmg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1804:b0:d7a:c85c:725b with SMTP
 id cf4-20020a056902180400b00d7ac85c725bmr262418ybb.7.1693887820755; Mon, 04
 Sep 2023 21:23:40 -0700 (PDT)
Date: Tue,  5 Sep 2023 04:23:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905042338.1345307-1-edumazet@google.com>
Subject: [PATCH net] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@ACULAB.COM>, 
	Kyle Zeng <zengyhkyle@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a follow up of commit 915d975b2ffa ("net: deal with integer
overflows in kmalloc_reserve()") based on David Laight feedback.

Back in 2010, I failed to realize malicious users could set dev->mtu
to arbitrary values. This mtu has been since limited to 0x7fffffff but
regardless of how big dev->mtu is, it makes no sense for igmpv3_newpack()
to allocate more than IP_MAX_MTU and risk various skb fields overflows.

Fixes: 57e1ab6eaddc ("igmp: refine skb allocations")
Link: https://lore.kernel.org/netdev/d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: David Laight <David.Laight@ACULAB.COM>
Cc: Kyle Zeng <zengyhkyle@gmail.com>
---
 net/ipv4/igmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 0c9e768e5628b1c8fd7e87bebe528762ea4a6e1e..418e5fb58fd3f2443f3c88fde5c0776805a832ef 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -353,8 +353,9 @@ static struct sk_buff *igmpv3_newpack(struct net_device *dev, unsigned int mtu)
 	struct flowi4 fl4;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	unsigned int size = mtu;
+	unsigned int size;
 
+	size = min(mtu, IP_MAX_MTU);
 	while (1) {
 		skb = alloc_skb(size + hlen + tlen,
 				GFP_ATOMIC | __GFP_NOWARN);
-- 
2.42.0.283.g2d96d420d3-goog


