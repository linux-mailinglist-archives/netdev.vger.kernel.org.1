Return-Path: <netdev+bounces-23241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667776B66C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79F61C20F3E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1A23BC1;
	Tue,  1 Aug 2023 13:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D5111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:55:04 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CCC3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:55:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d0d27cd9db9so10460383276.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690898102; x=1691502902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yit71oMsx680KafiyUWCZMFyhA9I6XCSFIZv1F378=;
        b=ZjNkOZlgVvT4lVUzRiM5AB/rLfgYNexEb+FLb+UPkycxQacFfhW8I+W+UUT6RN5jRr
         94cO4o3zoilqCLzPUx1efyr6GRn1bK0Cr7QH7ISuYTjiXvc+5Ee1nrHdyM3QP2NQiA9F
         KJyegYkqE3aytVhSdje3AsSt8X9KuicIjQNLRKXMMRa0OUC/4e7fjtOvQG+DQWKTXPE5
         RnesuTYuZ/lwefSMHcN3bI6wCsdqfo7HGiko3H0R8hSADf66NAYmj+tz5/VP0tNU/SDZ
         JM3Pgyxnyn9upgZYQ99OM/j6Ak0rTtteHCL00DyHVpOEjPFzU5uYF5loUArCzTHwz98E
         8+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898102; x=1691502902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yit71oMsx680KafiyUWCZMFyhA9I6XCSFIZv1F378=;
        b=GNlHLvz5nJgTSvSmeQniaxDLTmHZzZJ5/sUmtjd0ARYTdy3tHex3kGKteUQhVp+bNt
         7dV9lgLzeq9a9c11e6d6dClqbBEHdbSOGdUH3A4a1jSykL7zfO6C5a8XZmFYO5HivHLZ
         4s1J50j9Y3j+jNTXZvKG650uLoNfKPadYV5z5aUtWTpAVoVEPiNnQNkoUTAW2teUGfJ7
         54rkn8iiYEqT+to87IP9O4ncMFHiE77SnD+OQy9aiB0EBc0jeBfuRoMB3XJmKpm/Dp76
         niI/OFJrtXNA0+SM553kzDwfIaBaL5gcQ7k7j1o43k1INMOH/v4jEw7MB71MTh6T2HVl
         cTRA==
X-Gm-Message-State: ABy/qLYE4V+PwpTy9zPfFVZLoUfpD+fmsiveom7++Uj1Y3Tn/zEuyi4I
	tChaGvdSeI8mLqc9bWGz1KjvbWbG9blVMw==
X-Google-Smtp-Source: APBJJlHKzH6ysyri1zvpoC9Fv9IHMolv7Q6dDcntuIQoDn/LlI4wrdR3IGeSh3BQP4Qaka9pIjXlqFX0MKZmNQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:11cb:b0:d16:7ccc:b406 with SMTP
 id n11-20020a05690211cb00b00d167cccb406mr141182ybu.5.1690898102571; Tue, 01
 Aug 2023 06:55:02 -0700 (PDT)
Date: Tue,  1 Aug 2023 13:54:54 +0000
In-Reply-To: <20230801135455.268935-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801135455.268935-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net/packet: change packet_alloc_skb() to allow
 bigger paged allocations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

packet_alloc_skb() is currently calling sock_alloc_send_pskb()
forcing order-0 page allocations.

Switch to PAGE_ALLOC_COSTLY_ORDER, to increase max size by 8x.

Also add logic to increase the linear part if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 net/packet/af_packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e3ddec4c3d57e7492b55404db3119cbba6f6022..3b77d255d22d6d2ed23cfc50e69a32e9c7b94531 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2927,8 +2927,10 @@ static struct sk_buff *packet_alloc_skb(struct sock *sk, size_t prepad,
 	if (prepad + len < PAGE_SIZE || !linear)
 		linear = len;
 
+	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
 	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
-				   err, 0);
+				   err, PAGE_ALLOC_COSTLY_ORDER);
 	if (!skb)
 		return NULL;
 
-- 
2.41.0.585.gd2178a4bd4-goog


