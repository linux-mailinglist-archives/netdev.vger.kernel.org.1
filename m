Return-Path: <netdev+bounces-237858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDDC50F3B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34DD64E66DF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E127FD76;
	Wed, 12 Nov 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DdYyGGg8"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-57.consmr.mail.ne1.yahoo.com (sonic301-57.consmr.mail.ne1.yahoo.com [66.163.184.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF59221265
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932657; cv=none; b=SPC/MQUviKNBOjKbfsXYilG6lIxmQehH2RNrSXrXaalz33qYPzCFeIw1e0gkqGAYprXPoKSZ2ulNxJRuR0+vF8+SvgMRbJ5QO/hHpGTHKUh9PS6jpOYKBfg9cIVRSwEEn9Tn2y3Vzf5Dig49jBqVQzhd7TPeIln5aY8LAMw7PSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932657; c=relaxed/simple;
	bh=VDZwWu4j+XuPBVpD1LkYpwA2u4LhIhf8IcfJi2dlFuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LidUabeCuPv9vCIvfBlq05APx5StqfSuSKr+1Bo9QD+9B/MGEusOvo0B+TyyorVNFAI5FZuUL6dM++akAHQOgSFyfvKkvul7v6sPImnfv0WCpqOpVvTLPr0zL0mwhwG1yHpxW5FtzMBMQWMejsGNJTEBJdcnP2/VL4fw/Zy7e0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DdYyGGg8; arc=none smtp.client-ip=66.163.184.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932655; bh=kvWH3ir9Tt564V4+bM4XADGbg3FdepDzfCnxpl6+27I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DdYyGGg8hZYADGlXoh1ggPGE09fzFypwN/kDkZerMPGEaDHlLPmlPPjmWyWIpVzaNoCUZQdMnhFWmc/jLjQe0IZPABB+cX4lzgE5LPbk95ceTJ+9O5IUjkq1mwCCXx0SCVoHs7yvFynfufmyiA3KO9AjSky/yfnSJNnpv9ANwbMD+mNaYH9lPHvlMX8BYgxJqRTiD8kmJjGXeufTZKzrr7f5rdpKiqzZaiTpLNKpauYAxAWiG/Q5FCGwhosHFCTeRRASOO1xHh3N/GKc+/BDz8gdn1CAjztDKYaQHLVxv3Z+2ss8TAbWjntp4MLs+AYqbpOK2K1gIdpoe/0Gsrzm3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932655; bh=WIOC7Of/8LHJFY9WWSi+v+knqL2uglo1yMZ0XROGK3l=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OGHKtSBpM6JwkB9Onacr5va8dy1GyHUGo9vH7VNnBxYqmnm7Lqa4XG1EbSMO1NwEkU/39U+RqBlG2ut1pSqgyim9854tcNXqVou4WiSHnAiUEDvFoebCcQIkaMQRA31F+/LXx3ExZLU3fditdbcDsEJoEhaY+LG9MHLgfjR7FD9jqvgjZG6Zb+kJccUQD8l4UJ+VM7di+KA5XLU2XLYKnZVJ9M8Fh2GK3Kp4rFy6ODTKAXeIDyFD+eFBMhKNWm7Ew0kiuLBui+T1MHBOlJfsIuh79W0J4YgnKUegV1Yg+oc7yNLGSw9usEEE6OhQjqkaOccolIsn2mvnnoKX1M1u/Q==
X-YMail-OSG: F81QYlwVM1newNuxEg9zaPd6aO1EzQiGQ_HdhySV9a7yT4JSmhTJy_F2mR4.N4T
 MGBQUCEd_.OEr0GQfKVkB10DzeW8c3SWVgMwDXvMbQNVV1chzwuyga1_P.1LwJb0Sze5iU4PJhWU
 678JEiXB6WR6EV3o60XPMcIXtOdvL5AICyQJXcepwmNntt9My3lZI0OVK..UXr4TLCMTCEuwtdTM
 xqMW23X4Z1d7aPo7ssiC1cUHFLMTGYhO68rUV20wOwD8gJU2YNE0C3BBgtVxK7xb4DFALJ2QFfEY
 4NPXoYPzufe24J9GxklX5pOoMDp4UrNBZaM8J5swLSCZTBtncMy741GoJZJkuYG.7gWQzB2NV5R1
 DeiLZUyDHWtdqiZ8LqwsJtg_roohPcg9cfiw_18kIoj5S5GSuSQMsiRiXZjiITpdsHe_TXuJWYp_
 9IypdBTbiFfeHDVfQVgZKULtGQbrA24IYe4UiR_.CpV1l7va5IorTwilN.zjHLgxqrnXi1fTXl7u
 K4LDzGe8ZqKTfZWSfBhu07f2Xbwd4u6MTaMhUA0MafVn.2dDYPR3k3jpFs8FwvocHtSP3lceM2GR
 l1FBY3l3XntGbZ6f0yL4NAYxFPoCiabL.cbCQkFvS9MScNEY4pXPWrN8OG4.VUUVoCcOJGi3vGTu
 FJYvF4_qTS2BYn5n_shtCF1HgTsczC3O598M88bq96JBVI8OPL1RGJKEIk59nxiITPUHjupLG0HO
 p2qLJdeJsTs3Byvz1Gyab2BOq8.L2x_hNC5jMLVsTcyn8w7lJ4dTlkRtBEO9GsuIdGlCiEAl9cAM
 wnwaPD9Wrs2FR3TuuNZY9OlPc3NttDLuEzLrpyx1EN4Vt_XzYoy_ilgfZJsW8Yh8AqammFo0GKQ6
 hDPRXuZideHBAndp83vdbMrJ8ivqyT8SiEjtBgVndRaP.n2d1gGTAhEII1wuhJtWyUD768J0iR0I
 eHKz6eB56_SuxNgRmQmv2xy6ZfxJDqtc1s0yGmsomFKrjtVtyXI9G8nNj0J81YI7VQn0nmbosjzn
 e5LV950X1DdqUK7Fsn5yTP4MO_zt6a5XNst2PmWfRjeMbcWPR6FIxwcFH.HkU80L0_kseGEjkaHP
 hdCICXt43w1ieyRVqtd3OQcNXdNTMZgDne6hLv1brV9EZDGKXAKRRpnjvwcYBb7e2UAElxni.mx_
 zXBwGvV2coD7pe9BXcdWeac1v3q398K4FdFNpiNHtY298L3SRXMq9x71hh.Y6_18JPbNHARVrUxM
 95841VQrn1g4wyV63K32d5MgueCY97CGkOKZDeq6rKI2NqD5kzommLaV7kBKUUFxmYmc0XSd7xAL
 seEveR0ADy6TtW7e3Dttdy30gOrCELCDmflT9ymQj_79VvzGmjUZAFoUVYMEOeZFM3eGIgz8Hkkp
 eNWmhOBr677hDPIbnojw2Pmhtx2snpGnTlzBDyGb9rGy6UninFQ74bpyKExqKxjsFavDSJs4t1v2
 34X_Kw9P9zTFbKQtV8YskLRF15D5XQ6zsynP8C.3k_C65QkBR00n2QKxiPWT0sioX6Y3ul4POFr3
 2XNV6N0Ts3BLF6u5dXfpgxQT7hZe0VJ3OfhFYijsim8D5OD5hCXK5.Rv00bEGTZw_uA8S5BGAzXY
 PjG1QJewyHmn0DDcM.Pl6NCcUhOZdW4l0vTWyW_J.1agBcCRzTRUdlOsyjsVnZca3Relp12zP6IP
 Hkg4gfE3pvRAlV575eDoJCs4Nng.tSPDreAKbl7fOHvHslwmYKY6ze_FjhwuUCNjIMOZV4yeP0X1
 0NGaknxEUUe3WR14VJBoaMLNQQ48lfWEuz_Zzv2NCAmK1y1OiyuYx2ilrWAy8_W9K372C4Xrfkm1
 Ez0pi8JjeZoWBPLgBdV8rJLsc68OJYndNijNexaI3IMFdtN1LxerAFPsQIwrISl7Dt9wxKyFSslk
 2udsHO7BqOmi7WihxBu3EoDPPa7Etn2Am9wDuJIX2546ZzugRPQaaYdX7FR.N0D0Gx66bPaHCymo
 estPt1l.f4op2K.BV8YZ2.b4uqhxzkDRXdKfWL4jLVrEAfe9VYgmGgWNpRKOK5LsbRcXHt6O4rNO
 rgUCJLjK0B6cRzSWpSXdl.bl7fNuc8zQEQ0f.7J2pc0O1hWvHNiBc1bHT0fCUHn5M6n3idsYOZ_Z
 .XcX33i_bVssPnYiRr.aezLPiwWgY7pXqvpH75bGja..SAIjE08Cz3F08WIIIwdral0JnHkpjYzc
 f6bQC4y0-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 65e8fec1-d9a3-4c7e-ae60-3743749be930
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:30:55 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:52 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 07/14] net: tunnel: make udp_tunnel{,6}_dst_lookup return a noref dst
Date: Wed, 12 Nov 2025 08:27:13 +0100
Message-ID: <20251112072720.5076-8-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112072720.5076-1-mmietus97@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since udp_tunnel{,6}_dst_lookup return a dstref, we can avoid
incrementing the refcount on the returned dst and return a noref dst.

This only applies when CONFIG_DST_CACHE is enabled. Otherwise we
always perform an output routing lookup, which returns an owned dst.

Update udp_tunnel{,6}_dst_lookup to return a noref dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/udp_tunnel_core.c | 13 ++++++++-----
 net/ipv6/ip6_udp_tunnel.c  | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fdfa5420f9bf..9859d6d5f521 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -240,9 +240,9 @@ int udp_tunnel_dst_lookup(struct sk_buff *skb,
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
+		rt = dst_cache_get_ip4_rcu(dst_cache, saddr);
 		if (rt) {
-			*dstref = dst_to_dstref(&rt->dst);
+			*dstref = dst_to_dstref_noref(&rt->dst);
 			return 0;
 		}
 	}
@@ -269,11 +269,14 @@ int udp_tunnel_dst_lookup(struct sk_buff *skb,
 		ip_rt_put(rt);
 		return -ELOOP;
 	}
+	*saddr = fl4.saddr;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip4(dst_cache, &rt->dst, fl4.saddr);
+		*dstref = dst_to_dstref_noref(&rt->dst);
+		return 0;
+	}
 #endif
-	*saddr = fl4.saddr;
 	*dstref = dst_to_dstref(&rt->dst);
 	return 0;
 }
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index ec7bf7d744fe..e832d08b643d 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -149,9 +149,9 @@ int udp_tunnel6_dst_lookup(struct sk_buff *skb,
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		dst = dst_cache_get_ip6(dst_cache, saddr);
+		dst = dst_cache_get_ip6_rcu(dst_cache, saddr);
 		if (dst) {
-			*dstref = dst_to_dstref(dst);
+			*dstref = dst_to_dstref_noref(dst);
 			return 0;
 		}
 	}
@@ -177,11 +177,14 @@ int udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		dst_release(dst);
 		return -ELOOP;
 	}
+	*saddr = fl6.saddr;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip6(dst_cache, dst, &fl6.saddr);
+		*dstref = dst_to_dstref_noref(dst);
+		return 0;
+	}
 #endif
-	*saddr = fl6.saddr;
 	*dstref = dst_to_dstref(dst);
 	return 0;
 }
-- 
2.51.0


