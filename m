Return-Path: <netdev+bounces-17360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737897515EE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 03:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B56C281AA6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7A632;
	Thu, 13 Jul 2023 01:55:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B77C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:55:32 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839B173F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:55:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7659924cd9bso23289785a.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689213323; x=1691805323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC4l+DMQhb6kc5rWIsMuFvnWetpCKotmNlfSav918o4=;
        b=VdDCd2rwQPbltzkne/8cYfxnkuaCKmFeRcipHkeV5r5b9iyVOJ/o/XOTDIvxXsoZRq
         kzJrj9I6zxi8mHbcPDLKrJ/iTuQu+OTIzr6ATwW+JkoDfWEFyD+x2vOHh7fxGo4ZF1Xs
         PvudhpsE7CEWCSNNZfNksQ00yWADTZWPg5X8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689213323; x=1691805323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC4l+DMQhb6kc5rWIsMuFvnWetpCKotmNlfSav918o4=;
        b=DMSK18ACMTDZqjbzNMs8vBUZYjF6NEPyhBmDGZaUpQtXq2clZ5K1ztis0XWCp/V+Nm
         WJO2atE5QUrGkc/IpN2hurOcPN7atGmonzBti3lXzH6K+gHZ7Cc51ykgMUS1zeuZ9iIy
         mmcDS8Cw3KBnwOk31cejU+O/2TvNpohxIblMtvij2x8AEOi+TASafYJhtt11+zva6ob9
         6o0Q2BdnxHDVXl2NVI94i8k5SnDIUyA+uPUELHbPp9CavFrL9pcsecwIqaXl0Hf/HejT
         th3gY3q4IFRE7s8j7SarsN0sYywdfkhLrEZf/bGknvGhZ8hhM9//MrEMknHH3NtRpo3I
         OYAQ==
X-Gm-Message-State: ABy/qLbA39mPL6FjLjWxbgRX3oRYk4nOJH3eiKN8+8ehCj7kaEv2kIaa
	MiYkFEIbR+SiBmZk770XrIlBG/LTDxfIP07UL82jEw==
X-Google-Smtp-Source: APBJJlHXnjSSjDOxycQFia95pEocVbUmuLmuF+evJsLCFSQS9qAmMqhl9alS5Ioe+fxOUCbJ3wKqug==
X-Received: by 2002:a05:620a:198e:b0:767:173e:9 with SMTP id bm14-20020a05620a198e00b00767173e0009mr233241qkb.58.1689213323421;
        Wed, 12 Jul 2023 18:55:23 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a208100b0076729e726cbsm2580913qka.22.2023.07.12.18.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 18:55:22 -0700 (PDT)
Date: Wed, 12 Jul 2023 18:55:20 -0700
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
Subject: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
Message-ID: <ZK9ZiNMsJX8+1F3N@debian.debian>
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

SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted source.
The canonical way is to recompute the gso_segs to avoid device driver
issues. Afterwards, the DODGY bit can be removed to avoid re-check at the
egress of later devices, e.g. packets can egress to a vlan device backed
by a real NIC.

Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
packets.") checks DODGY bit for UDP, but for packets that can be fed
directly to the device after gso_segs reset, it actually falls through
to fragmentation [1].

Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the DODGY
bit after recomputing gso_segs.

This change fixes the GSO_UDP_L4 handling case, and remove the DODGY bit
at other places.

Fixes: 90017accff61 ("sctp: Add GSO support")
Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
[1]:
https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/

---
 net/ipv4/tcp_offload.c |  1 +
 net/ipv4/udp_offload.c | 19 +++++++++++++++----
 net/ipv6/udp_offload.c | 19 +++++++++++++++----
 net/sctp/offload.c     |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b5..f9b93708c22e 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		/* Packet is from an untrusted source, reset gso_segs. */
 
 		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
+		skb_shinfo(skb)->gso_type &= ~SKB_GSO_DODGY;
 
 		segs = NULL;
 		goto out;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..bd29cf19bb6b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
-		return __udp_gso_segment(skb, features, false);
-
 	mss = skb_shinfo(skb)->gso_size;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+		if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
+			/* Packet is from an untrusted source, reset actual gso_segs */
+			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len - sizeof(*uh),
+								 mss);
+			skb_shinfo(skb)->gso_type &= ~SKB_GSO_DODGY;
+
+			segs = NULL;
+			goto out;
+		} else {
+			return __udp_gso_segment(skb, features, false);
+		}
+	}
+
 	if (unlikely(skb->len <= mss))
 		goto out;
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..6857d9f7bd06 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
-			return __udp_gso_segment(skb, features, true);
-
 		mss = skb_shinfo(skb)->gso_size;
+
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+			if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
+				/* Packet is from an untrusted source, reset actual gso_segs */
+				skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len - sizeof(*uh),
+									 mss);
+				skb_shinfo(skb)->gso_type &= ~SKB_GSO_DODGY;
+
+				segs = NULL;
+				goto out;
+			} else {
+				return __udp_gso_segment(skb, features, true);
+			}
+		}
+
 		if (unlikely(skb->len <= mss))
 			goto out;
 
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index 502095173d88..3d2b44db0d42 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -65,6 +65,8 @@ static struct sk_buff *sctp_gso_segment(struct sk_buff *skb,
 		skb_walk_frags(skb, frag_iter)
 			pinfo->gso_segs++;
 
+		pinfo->gso_type &= ~SKB_GSO_DODGY;
+
 		segs = NULL;
 		goto out;
 	}
-- 
2.30.2


