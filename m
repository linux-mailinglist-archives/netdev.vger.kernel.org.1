Return-Path: <netdev+bounces-237864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2842FC50F71
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DD71897C38
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48B2DECA8;
	Wed, 12 Nov 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rBgaIlQd"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-57.consmr.mail.ne1.yahoo.com (sonic301-57.consmr.mail.ne1.yahoo.com [66.163.184.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D32DE6F8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932969; cv=none; b=d+SXa6tE88BkNLM613Fqo2ddKVNjyQVi0gydD44tsGiHx1L5kjM1e6zqU8hQocDd/n052e1fZKeeoDJ6RnegA7UFj5TX9lYjedwNfzEWytFSIUTBx3F15tC6IyscQD2Ntg4GkDZr1RJhSo7TYecW9Ddls3M+A9hBUDlJ1FmKVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932969; c=relaxed/simple;
	bh=hkvXXIK2bOOw7u39PS/H9v76xTaPqAAYgN/iYjSJQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMgJ4I8YGn3niAYpxOfuauYYdqbCmw3Zct0RlZBq146+X9sZVDHoKAlw43aoCmqEANU3zOiq4ZeQ4nzDhEj5PTDXAGsshk/d9VVRU1EeTqN85FF0DnYM97/2Fz0LZEjGjgHr4421nzHG8ioh3mK6DH8kPWode/1fWRRvlHH+4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rBgaIlQd; arc=none smtp.client-ip=66.163.184.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932966; bh=UOXF4Xd9nzrKmgi9ddwhwNNT8mIivkfxxmc4Aef0qos=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rBgaIlQdypv4VwDHQZn4ouwosLRBGLJ1vbukaSFZpFlpUs5V0TrAkfbYIewaNrnsJVaTKup04/GioW6ui8PTkgsaGKan3D+YcDCqcC/D601EArBZCwJpUNzMn3WDhw+/X6APvjiEAEusWP9RztZMCMf6jzv6RRmoykkrO47+FYls3KCcQoaDWoCbg6ORIlbUfpFVuf9JLN8VPZeNx8nypFswiVFY27UWPqBpVneA2g07UFDne3uYpiz55YpT6NlOkHO1Zws+2e5QAaE+tgeQ8LzSJI/qucwLQ9VwNAI2SMigtwuwMy1AfRZELiKIIG5ICi4bioiMFxizETbx8emwpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932966; bh=LARf0NI4JjFHoTIlNpPQ/ht8iOaP+dwPtlp2nQRKTV2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LT3okdQap4x/gxh/F5yiZe3Nxq37VgCMHnSWN7Ni/oMjd6ZFe7THbgtTK+W9JZomlfGnCJU4WgKGRJHBdQaJVx0hVt61z8qY1m0YcYgypwWD57Yy8ILEPhlUy89lmD5eJZx0OmU0uhyhxLNYyV7OSFBpGdcMYc4+ruZETFZdhCzMkuzGXaE85GvwntDb0bUiBIZj63hl9TsmKfX9DKvTnb7DI56R81sAughZROyBzDIGhE+WySv8NOOXSNofklTT2IFGiN/fKJ9DR6gbbFaWHNLUaaDOyrnKtY76RzUYUBkuI0ZGZNaqzeteWwlEtfqBJdnjcfd4mSgCtvGHSgkAUQ==
X-YMail-OSG: PUkUHHQVM1m91nbxNBRO.a3N.kLasvyAGQSbOEg7rh3kmJWXMtGNN.YvaDryuY5
 CgNYE8ZW84bfjfQbq5j4SMAupN_ZXVdHiUkN6w.VekLAQ043iYA7je_.hNXoWRKFLGIrQzX0bF00
 QB9hFx_2ARsRzgQ0eHdC8iwRIzidHNfAk1g01LmWU9bFUTijD7xlhIBT1RwEx39yVNsu0ctuFUPz
 wRHvgiiN5NNrdJuCPNt6kKT4Uv8xp41YjoYUfCye5MrAqZQz9kiDQrnI_IzL7OvfGlc0fTcNTZCs
 OtY3XItA6NqscF_jiiCBGAZxOWVBlra1joXjpnoWZ1hY8RKuu1FM_nxJLZu4qShdxTa3iebqOgw9
 D_Jv2TLL6.1MMO3QOB1DpsPyZu2njHcfB.AQRu14v8EDJR5FttqdTkT_uYh5ax6GEkU8nIdH9cZr
 LssJ_SXVu7OKhJrzwkSsw27T_JE.1pKlUvVrz0fQcw7qLKjQNC..Qn6GyoHVJTVABAYa.eHTH7Vu
 TctEab8J5uPHfpdkKVFOaWv.CMqEwYbJKYHA5f.VNx4nN4KgrStLdk5NRGBfmvqwI.aMRnsLa5cV
 UaAGDHpAAJ1x.7rUQGxo1NgmveJ0GqXVqH4mfCLbFTIBealzmswM8A3BMKG3zJohXhl2FBulk9Z3
 xSktWeTQ2EQKrFc6UG.OXLD_FIIwKPcZsI5v7iRJYz_2y3WJpguqqIyu3bpeQpVSKfJZlw3UyTwV
 D4VuBOoLeeMr4UHk0HrsqsU7jRIYV1c42inWSK7sCsn_.K8s3oBD4BdSPsJrGiW_Dy5GVmepUSwD
 U0OTGI_2YeEK.IzfyCA4qYb5.QQdxbHUVHlAY55DAHINhkfL6Wr9ws4GULvMpq9EmNYFNefnUUhs
 lrrYwF6hUr_I_Hc0A5OVil0Ei3j4NF1rOtjXdXf8AdAq2vR5Bq89xqJZqp4Iw3qUv3JuswD8906e
 4QNuXI2RqYlcY_xpYWViC.pOZN6x6pf0Iz5kWklDwbJ.p6Anw2yEE9X0P9Ywoo_VGtFnTiC06IEf
 xf0yvuCKso_XsTqnyEaGF4hvZu0HUhE8ERvx7wP26d2P6FlNUXRbFMvMIsxDupklKsdQF1qqif5R
 uiuyOU.JvKMBzE3O2Oi7PNcd95ka90oAV_8BussYj2G2bWulGajTd8nc3Yf.ZvNMGVrsHgRx1LgJ
 ZXaVVNeDxniwgr58IZUUiyV5S2Ge47kgEPh9KTJdUo6TW6FoVyyYgtXv7bsrqFYgDbtz8gggCGwu
 h4RDTGEjSxN6f4d34ljJtiv7uGq9cy07iL6nH6WV8xvYstTcAu.cDvr_to09xdAUY4iPEkz0IVs7
 goGGXEPYm0EMz6r_ROKlNShgycixQ5I.hCQSLdbzs1zuzVhLpEd4Xh7rvxczW1ThVye2E20jw86G
 yV.drYKPFFbqW8_Jx3WuYNXqguE50zrqVUz2jSWLS9NYtDlUSlGFDvifpi8M.5yoN4K1M6SG24n_
 j8hchNxxief7uFtC1QirIl1tvult1ZDrWuQjmXDxDn7TMWtzHO6sd6YWu5B69RzHCS6pdLXzGFAF
 OiGBiA7oqivExu_xFvxczQAcU4FqmX1fR1Pr5FWn3yJ9JMLShUyraJzJYiY35DtjbHO77gIEchtc
 fwOg1AYm11j9UjNloFQTew064WLPV.ISTtGPswg8_1LfzMRvQnjRdUAw06zxty35ZJnNk7_j4oyS
 srTJH6N7p3iVm5jI7sMXx4f5lpsYSxV_zzEU8vHxHkPdtIlc0MZmW6r_pEPU4FwWv8Ixx8xCKT.e
 xTUxQpPVuWOSZtBSjcXkFKw_fQtABq2N2C5M2scUDu6Fe9bG3qhMnVXWxJg_LKo2MDrUl04WGYH5
 mVBFGZ5xdqZgl0DRHbDoReH2In.93qJE4hmlMdMq4SemQa.nR.Z2rFKSOfhtMQ81PTaXWNK18Vrf
 7DRpDLXOf_7D9yOF_m4CQLzg9NeEveMYx2cWhteKKLN.0APnfvHtTmz1r1XtfRB0VZeE2nF0aX5i
 vaWl9JVRWpphixf1S1ZA.iBJUvEqWRv7m9khlmmJwvhsGiqDojq0.j5DuNMWcii_Uf8J_OCHgWyz
 GZ6zWkHUOmAebfMHrjxWvzOP3pUw4YKXbibo84nf1mYjLT8UJrqZeblYR7jjU8.H3JS6U5CnnzAV
 .xSaQpI38o9dIGw30_dL7CTgnuiLbzrjLB5c2LtdPGa50M3R4EZd3pwujQZLxBlHDWBWc13uQOoG
 ld8MXx7t9sw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 5442c658-a396-419c-be50-c634aba87224
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:36:06 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-gtwf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a3972250952fefb5c72bc783ca56e47;
          Wed, 12 Nov 2025 07:34:04 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 13/14] net: tipc: convert tipc_udp_xmit to use a noref dst
Date: Wed, 12 Nov 2025 08:33:23 +0100
Message-ID: <20251112073324.5301-4-mmietus97@yahoo.com>
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

tipc_udp_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for tipc_udp_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/tipc/udp_media.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 8e165b219863..2a6c4df0c0a8 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -175,7 +175,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	int ttl, err;
 
 	local_bh_disable();
-	ndst = dst_cache_get(cache);
+	ndst = dst_cache_get_rcu(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
 		struct rtable *rt = dst_rtable(ndst);
 
@@ -191,13 +191,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(rt);
 				goto tx_error;
 			}
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
-		udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), ub->ubsock->sk, skb, src->ipv4.s_addr,
-				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
-				    dst->port, false, true, 0);
+		udp_tunnel_xmit_skb(dst_to_dstref_noref(&rt->dst), ub->ubsock->sk, skb,
+				    src->ipv4.s_addr, dst->ipv4.s_addr, 0, ttl, 0,
+				    src->port, dst->port, false, true, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -214,10 +214,10 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(ndst);
 				goto tx_error;
 			}
-			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
+			dst_cache_steal_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		udp_tunnel6_xmit_skb(dst_to_dstref(ndst), ub->ubsock->sk, skb, NULL,
+		udp_tunnel6_xmit_skb(dst_to_dstref_noref(ndst), ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
 #endif
-- 
2.51.0


