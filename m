Return-Path: <netdev+bounces-237859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C32C50F42
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296774F0F07
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE62D879F;
	Wed, 12 Nov 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I/D4/Kd2"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-47.consmr.mail.ne1.yahoo.com (sonic304-47.consmr.mail.ne1.yahoo.com [66.163.191.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94227B353
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932667; cv=none; b=riRYP1CnJohihpU9JYYU8u6l5dxh4vH/U+mBk24wfMkXhe1+UGSjLe2Le4Vf/Mw5GOWRx1i6xwh6tmQu6D5sw4DJIxYuoLi/iC8ExPjoyL0AhBePNlIk2ELtGj2kwA/36DGeC6cHcf7vdFAcia8c8TRreviANS8gEH22E2z+DQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932667; c=relaxed/simple;
	bh=/2UZubqXgb4+TZL51z+T33odPKXsPYcKU2Ihyqk2zZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciWxCcvMDdgb+rkJnFqOy3XEbV1dECtRAzESrBWb5emz+QPi1NN23jaS2WYgUa+wGoSFXJyFonuGRq0NEoBMutG8uXV40Tqcy+X2//NTz9fQW7LH5seu4jkp+rvVujHm5SwtItVkwqnplsU7ehjpvKNBve8ZaL0tt2hCGbkRaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=I/D4/Kd2; arc=none smtp.client-ip=66.163.191.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932664; bh=Mmu3klSDJ5Yt6q9fCfxZ8bgbCgHbZ1WuiMAMoW6+yZc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=I/D4/Kd2+I2/KwpqZdIBE9p4qLUV5mfCDbRyXD164stg/zqbtYhOsRfH9oBxcQdM3qyn9gNDSoCBWF6zs/pwAV1g/T7o1MW4kS9Rj1h1N9K7rd7asN3YX+8p4YyJExBRcOpJ3+4DAHJTRj/95zGfXB/Ogs7QlPTYYXSI7XvI/lechnAJiFWaYCGlhJ6qD6Bsqb8otwqfGn7TS370QYaafpyy37gc7DbMkStv9aSOSh44uSZld44fDBhTUzk71RODAskTYWZjnQy+p2BNV79ZLrXDUoI0DJyPjHDaBf2u5aO1K/kX1WVAAhnKT4gC1QQo9Efdh83euJcnzmlli1EsRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932664; bh=HszpxYV3Cf6TnF0yeREQcJpgYw5F2XonlIcFrA14TV5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C93KvcteI+frmBYV8b4yo1tUxqcVzQ0p8b6wFW8qSVuc0X8xTfdk0Tt3cmA0NEemkSxxRvrR0BUdVhhx3ipZ9Zq5CJj7pfQgs4f2D0Ur+pDU6F9zUDeiR+fPPCmVzAxU38snyHwAC6wTqoqwey3HWzn9ijlWfDls13OhEWnSUNe+SaAIa8AptXIGtDoy04PGq9shOWgtTXpNafRN8WCun9l6/qYoxJRQ291izqJlBZKsDRBafrkwu4+b4cuAROS0ZNO5gXXWQMoF5GwltET/uRBwARhTLDm1dg3Pl/3NzARummdc7FAn1mLCMdF8WfBBSSuZR3zVLd3V4/+VeWYrcw==
X-YMail-OSG: zK6QkXsVM1koANDACUBHT5niKicG8h_njVuwMWF.F6n0_MSuXOZC9exNIXa_nlG
 UELImFR_pdmX_zLb.eDnBVJ1vdIEKCKsfUv8tIaYJq_qSOjqSb7znda9mO5k5tJDhIeMJmOTFXBo
 iho99Sde5P6OjzgE1Sch5k3fbO8okYLaL2QHrKodw_nbHPotF.1X2v45pPJmdxR9Q5Xbw9T7HpoF
 S68cZkJBBmo4w32dJau3J7ohH6A.n_y1LrxMW_2FCcTQmLzwGSjmatp67fy79d_QLu7VL3oAkObz
 LaT6xvdM7GO34M9XukOZXNcIlxztKvkVzvPp93eRsulaEn2kj0DmTxE.BoA4BmIYicD0JKHOOE7f
 IJCt_8azLIpBoBwEIDLd.nNCqfWRiXoPRYqxBkCy9SkjxO2v0FI6A3IuO69MVCURecjuKm83eYEd
 pY_a7MAMvfLCIoaKtRChoOIPWwLnvi.sRcOn0WQuMmcVPu6mgSG_lHS4YPKpQkt3N_FCqP0nUISA
 bockC4LPbgUMClcAtvxQXj9sg6koiXeQ6IrQC7Me1uu3DaAzGZFlaATxk2_7aeYCIplOb9aYShfD
 8vD9keJo2rcLvq61wrUSVo7GVnpAploP4vxCA0Wx.OyxgxrpLNpPsdbSCuVfs2uxK7NqIFb79HIP
 lWm1DsFLrQJCBM8zxZNt8WGDQWJ8nRZNfBFLrVycHhXeQOwVUGigu8.PZCNCjVLz3z7mjq6Ub2p2
 h0Dnu2qHrR435t316O_x7IytNGFIaJ7nhQTA8wn6mB_Z5LFvoxHOI7rNx1kl3qL3cxoZGfKF.aW6
 REZEetq8BY4GiLKOzc_qXTFCKfzeBx1xSEpz95FrGnX75QYrDGhK.Yi7fm.UQrdA0R1phuPed29s
 neHYj97wC_yUz.f7QBPeMBJw8v.mkzmjt_MvHGXWKMvdJdcxyDL6Uv6Jw_LeWjiltcPCp47rvWdz
 wpOEOS9i_rtjkPFO9ARP5U8J9CdmzEeFJtjYNO7ObFWKCN7sie8oMLUpuBBUHSU5DEypfU0oIIrT
 7.fW.4PmVUC9_JMl0ZO_SngzhiNRHhk0yoexGggUC.QP9U0c7okDQ1zZi69fdVn84GKNW_wuo51r
 01sAkVXxzEGcKJTFBKEIEvVy_UIpZ0chVP63rDLZl1PuiVpqN3doijqZfiM7Cw4kHaqHjloRoZze
 dZRtheSbm6G3bPGh.VtoyTwtbZ_.z.6RnHW9Z5nNu_NIShngdjYMNPOpHTQWWHbTixSsrvyTs9nV
 nPvda8mjaCzVYHBcw0C_mo5n74BQZQ2o_5B2Z8ybqlfUaqlpMvE5fURQ7JQQyBLNMEco0OHiveEK
 f_4spx6SE8yy9pKQAcGXJHC_B_jZP0_frG6_TLMBCAg20YNlweKt0HMojoIXqA0vSrJs_BrtjBz8
 RfyEBun_NGEJ3hzbZNTeKidwDBgmOQi4J0Jf0qQxttsjKh5qNdMlurjtBxl_nuxxERCYaFIbqVgu
 AQsIY.phv4JENJZ_5dzbmua3_9Si7E44WQPYY4tWVwTw5xhb5yro_9GRt8CVI46JiTz6PNjZf8Yt
 O1I4jzKB54PL7JBij.3cWhqptcKBZt393u6jiBF.sdD6xicCKiPg_Wj7g7jbV2KacKGkukfhGZPE
 _0ZZYtyjV8bMpP9PRyGaAFa_0WkKV2yD6m5_S5yIY1Z29.2r69jTh1EeW_T2..8NsStgsH9hIBtl
 HnZ8XXTUFMKSug4ko8piv2tDp4W2VNPy0scSHC6fbwHhTVm0F6gEum4tKxpk.fwShR.NzHDHIcVm
 agt1db7g5cwvE_r7LTOegrpw9.hX0axxBcwVUgqXgfNwdhPvT98BJBLnSwVc5tXuI74WMUXuKQko
 OoYYjS2qR36achbsXkMJfMVLxLl8E8VL0heEcqU2AmjbM8JKMKi2Qmp8MA3MXSslw1tzMl2MTxqT
 0bN7rA_RjHI0I7tEhVq_nzo1MSX7MiWp0RO1aKuUbsXmhhfAP7q03u6dTmoa9cgfu0WOgzqZUeTV
 20glgvK8aROde5KnMZV0z_lY6NJjMr1At_8_6M6g_76TUCR3uoZKzPDE8s8TX2v2VJ.7DzIUEviL
 IjXJjLfrdMlr7N7WvhjkSJj6V83_wjM1gYaYnbYST0hUpFvGapKrVi37fHyhawQtGW9thq757TE9
 4hzV7DnBtq9lCM1Qyj8ajKBTgrzd_3kbSzdXvykcntV6mlUZTr4hpZA3WVqEQq9sM9psPfQPftX6
 EGH2Qpn8M
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: ca101c15-0dc9-4704-b4d6-bf229666393e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:31:04 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:29:01 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 09/14] net: wireguard: convert send{4,6} to use a noref dst when possible
Date: Wed, 12 Nov 2025 08:27:15 +0100
Message-ID: <20251112072720.5076-10-mmietus97@yahoo.com>
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

send{4,6} unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for the wireguard send{4,6} functions.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/wireguard/socket.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 342247d324ab..51c61527da94 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -29,6 +29,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	};
 	struct rtable *rt = NULL;
 	struct sock *sock;
+	dstref_t dstref;
 	int ret = 0;
 
 	skb_mark_not_on_list(skb);
@@ -45,8 +46,10 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 
 	fl.fl4_sport = inet_sk(sock)->inet_sport;
 
-	if (cache)
-		rt = dst_cache_get_ip4(cache, &fl.saddr);
+	if (cache) {
+		rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
+		dstref = dst_to_dstref_noref(&rt->dst);
+	}
 
 	if (!rt) {
 		security_sk_classify_flow(sock, flowi4_to_flowi_common(&fl));
@@ -77,12 +80,16 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 					    wg->dev->name, &endpoint->addr, ret);
 			goto err;
 		}
-		if (cache)
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+		if (cache) {
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
+			dstref = dst_to_dstref_noref(&rt->dst);
+		} else {
+			dstref = dst_to_dstref(&rt->dst);
+		}
 	}
 
 	skb->ignore_df = 1;
-	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sock, skb, fl.saddr, fl.daddr, ds,
+	udp_tunnel_xmit_skb(dstref, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
 	goto out;
@@ -109,6 +116,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	};
 	struct dst_entry *dst = NULL;
 	struct sock *sock;
+	dstref_t dstref;
 	int ret = 0;
 
 	skb_mark_not_on_list(skb);
@@ -125,8 +133,10 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 
 	fl.fl6_sport = inet_sk(sock)->inet_sport;
 
-	if (cache)
-		dst = dst_cache_get_ip6(cache, &fl.saddr);
+	if (cache) {
+		dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
+		dstref = dst_to_dstref_noref(dst);
+	}
 
 	if (!dst) {
 		security_sk_classify_flow(sock, flowi6_to_flowi_common(&fl));
@@ -144,12 +154,16 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 					    wg->dev->name, &endpoint->addr, ret);
 			goto err;
 		}
-		if (cache)
-			dst_cache_set_ip6(cache, dst, &fl.saddr);
+		if (cache) {
+			dst_cache_steal_ip6(cache, dst, &fl.saddr);
+			dstref = dst_to_dstref_noref(dst);
+		} else {
+			dstref = dst_to_dstref(dst);
+		}
 	}
 
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
+	udp_tunnel6_xmit_skb(dstref, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
 	goto out;
-- 
2.51.0


