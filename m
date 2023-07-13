Return-Path: <netdev+bounces-17663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282A7529D6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FDD1C2141D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBEE1F176;
	Thu, 13 Jul 2023 17:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC51F16E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:28:22 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182A2D51
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:28:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a311a7a9so43912385a.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689269283; x=1691861283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8HL7CUl8Nl4Ioty23RUOK+NanZNksrYlNe7u93OccY=;
        b=IgmWTLtWvzxwXmXKucGTWvHEQBwX4I+ktgmiKb5RlTIuEAiLZLITR0bjYejAFKSH3I
         ZAot26yTteCpMKtiRr65TyvjIDaOxA5L+5hQvVlBFMyuJ4l+Pi3Uvcu0H4luOKn/aAV1
         gWZuHm84uvEENnxo0XK6Fnz+Pd/curjNjIggs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269283; x=1691861283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8HL7CUl8Nl4Ioty23RUOK+NanZNksrYlNe7u93OccY=;
        b=Szs8YvGEbZX2FjMiLkgRE3u8vVn2EZGyXab8/XQQXl85UN2Ztw/gs1zmPhe0cfj+LW
         dWXjH45Iga7G4EGGUBTDxtloKpYxrImy0rf1Ybev6e9j+ZrwH4Y9azO3O86OfHdabMhT
         SevG/qG04iGqAOqRiWrFOF08XFSKnxnbAKPWoBtFzFcmM68wxWh6OmVdkspDrruqeACt
         XfVyQhtRMXeTEcaXwoE/yTfv8keN74YuZLfaKMDP1k2xv4Dv8I2GF8Bbnp4ASX0djTfb
         vhWuMreQ3u43QNdFc+ddbUqgxEo8IPVdKKLp+hLKJu6gmIor88w0em+bV7IEtoiFjiNy
         AcsA==
X-Gm-Message-State: ABy/qLaY8uhDcG22f6xFQAeuElIOBUDp5809d6AF0pRWer0xNdyglfXE
	Kq6/fU/wmAQi5EuWKR64YQCt/0dOhk/gVfjByylDIA==
X-Google-Smtp-Source: APBJJlGCb+ocFoI0/71J3QpD/JyGRpP6aexUWwJuxeqih+WcGwDRhK6UP2v/FHPvUWAdtd5K/UOJbA==
X-Received: by 2002:a05:620a:4455:b0:765:5ba6:a5c0 with SMTP id w21-20020a05620a445500b007655ba6a5c0mr429843qkp.14.1689269283055;
        Thu, 13 Jul 2023 10:28:03 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e10-20020a05620a12ca00b007592f2016f4sm3040949qkl.110.2023.07.13.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:28:02 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:28:00 -0700
From: Yan Zhai <yan@cloudflare.com>
To: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>
Cc: kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Melnychenko <andrew@daynix.com>,
	Jason Wang <jasowang@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Subject: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
Message-ID: <ZLA0ILTAZsIzxR6c@debian.debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
packets.") checks DODGY bit for UDP, but for packets that can be fed
directly to the device after gso_segs reset, it actually falls through
to fragmentation:

https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/

This change restores the expected behavior of GSO_UDP_L4 packets.

Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
v2: dropped modifications to tcp/sctp on DODGY bit removal after
validating gso_segs. Also moved the UDP header check into
__udp_gso_segment (per Willem's suggestion).

---
 net/ipv4/udp_offload.c | 16 +++++++++++-----
 net/ipv6/udp_offload.c |  3 +--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..f402946da344 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -274,13 +274,20 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
@@ -388,8 +395,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..09fa7a42cb93 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -43,8 +43,7 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;
-- 
2.30.2


