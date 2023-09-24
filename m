Return-Path: <netdev+bounces-36045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5057ACA7B
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 17:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CBAC91C20456
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E05D302;
	Sun, 24 Sep 2023 15:31:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF0D280
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 15:31:15 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCCB8;
	Sun, 24 Sep 2023 08:31:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso597134966b.1;
        Sun, 24 Sep 2023 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695569473; x=1696174273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pM+cS4xkipoFkqRFvppgVlJ829+I7pdub5JIx78AhSQ=;
        b=KMosOautp7h/bCvdezUTiL3tpoesDjEoJR43G5PRZuVdRzImnWW8U1P4z29xTBO7ym
         K5tosniFTMgFJhCeS/YgWMVHaRgYHo50pkK8rKm65U93Yd5Bh6ot/nLOfcZ2YkbFKMbx
         dJAaA88RpqtCajYIyVkWjjwHCVR69j3Qb4JfvGIpFpx+Tdun/0f7g5MGrY1ohhW6h5S9
         zxd6MvWeFPeFwHg3nfB9odYw+ki7cCsWa/28RZ0j6/Zzj9EBWxa8EIsF0y+QWoY+rwid
         sDcGIR75jeceM40sFjW/+yqPZOxpqeHhPHpClrsT9lcSsCT8vgyGATN3o96I91vXh/mg
         X8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695569473; x=1696174273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM+cS4xkipoFkqRFvppgVlJ829+I7pdub5JIx78AhSQ=;
        b=skErX66XFNynupxSC28WUL5gjbvx+UdudMPnwfWQPjz3DyIfJCSzLfdfXNTZy+o+53
         LLVdH1bJFlS8OOsZZoL/FWQjbv4xyKevx4fF/ds/bxLulFTGoAXXWYeJtXipcqC22yJL
         SP8FMUntZYZfyepkrCFMpl09W6BaNF+FRKqYacJJPufbJlYz55z5YxduGitz04haLX6x
         vgoeIhc6MrvaZbJNp3JLEJ5XTmULEzm5mbW24pW9Pg5K7Ev387XJB7Sa/RtrT/eQDX0X
         TSK1+goJiA38fFa6ug78x/803V65fjBBFb6TnKQyGET8KhnEwMCwu8Ggpe4UxaDvDHQ1
         et5A==
X-Gm-Message-State: AOJu0YznYAyKpeZdKeZ6kS1birtuKUfYM+f18gTCQvIBQ5Wo532sFpj+
	7vqa89F3j6j1MIBVwdrZIEQjffWW9yI=
X-Google-Smtp-Source: AGHT+IEDZ/fZ1NORxT8XbnjwSBri8HXsEXNvH8uuHccF5HMdWnpyPRDGjAn6JDRBNDTL9ZceQcOR9A==
X-Received: by 2002:a17:907:2d20:b0:9a1:ad87:1354 with SMTP id gs32-20020a1709072d2000b009a1ad871354mr5124279ejc.34.1695569473140;
        Sun, 24 Sep 2023 08:31:13 -0700 (PDT)
Received: from tp.. ([212.38.43.101])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm5125099ejb.156.2023.09.24.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 08:31:12 -0700 (PDT)
From: Beniamino Galvani <b.galvani@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ipv6: mark address parameters of udp_tunnel6_xmit_skb() as const
Date: Sun, 24 Sep 2023 17:30:14 +0200
Message-Id: <20230924153014.786962-1-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The function doesn't modify the addresses passed as input, mark them
as 'const' to make that clear.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 include/net/udp_tunnel.h  | 5 +++--
 net/ipv6/ip6_udp_tunnel.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 29251c3519cf..21ba0a25f936 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -154,8 +154,9 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
-			 struct net_device *dev, struct in6_addr *saddr,
-			 struct in6_addr *daddr,
+			 struct net_device *dev,
+			 const struct in6_addr *saddr,
+			 const struct in6_addr *daddr,
 			 __u8 prio, __u8 ttl, __be32 label,
 			 __be16 src_port, __be16 dst_port, bool nocheck);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cdc4d4ee2420..70d38705c92f 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -75,8 +75,9 @@ EXPORT_SYMBOL_GPL(udp_sock_create6);
 
 int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
-			 struct net_device *dev, struct in6_addr *saddr,
-			 struct in6_addr *daddr,
+			 struct net_device *dev,
+			 const struct in6_addr *saddr,
+			 const struct in6_addr *daddr,
 			 __u8 prio, __u8 ttl, __be32 label,
 			 __be16 src_port, __be16 dst_port, bool nocheck)
 {
-- 
2.40.1


