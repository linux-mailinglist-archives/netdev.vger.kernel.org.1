Return-Path: <netdev+bounces-249510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD7D1A4B7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7005E3009246
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D330B51B;
	Tue, 13 Jan 2026 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bZkPNNEC"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-35.consmr.mail.ne1.yahoo.com (sonic313-35.consmr.mail.ne1.yahoo.com [66.163.185.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78430B514
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322036; cv=none; b=HawrF53g90A4GdywlvjitzeAtAlVKBLPi0S3xIM+rTR4Ciq6qh82bvZUeXPTtvUnRMwP4k5Y1GOZMOqg9CMLn1/xsfgEYhJuvZAM1J4DwqKxzoTdWquhus5Z56M0tIG/ASXnwyVleiDiyn9fFU68VsqTwOtbGVcS50AxkmoDmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322036; c=relaxed/simple;
	bh=CuiTJOOmsW+aFYNMJm5VXa6RQE5Ls9xLs9QS3bXmUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNvrnuOnxyYlq0Zqq+NKXtp/2ls32C9xWSAGO8FYwxkd5UEHC3FH5uewj0eVkcD9gy8O4JW+lA8ICqhDruJlpOov4FxEy/AAr69QEqzskRjbijGGttEP1HTNxxukehscVpnLEdXz3f06NIR/2IWkn6ya9E9RhJz0RIzmsYoNwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bZkPNNEC; arc=none smtp.client-ip=66.163.185.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322034; bh=9m60tMj2busabF/Oy+HOZ18Gf7Iev+cYqYon9NoGSWc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bZkPNNECQSKDVxgFgNDHlr6n0g42+P9WVPz2OXTOh7Bt5DPhgLP0nxBN932qMSoR/tI8n8WZ/aC3dRgldWAH+lO1bruO+qLO1hvoFs8Sbam57uUuEUUyb9acbYQ6eVmSw340EIRlgnuvbQPqb5vuL+QK5qBXlwCxrj30vPCpz0RvwRWPkU7rc3NXc1PzvN80JhaQmGF6+ZO/dRpiT6xnjTLJrMesNNNZfWCG6ZE0xxjc4FCNDoujHTOTBy0Qzx4Q8Os2+nBavBCLLOAygAvlkZjkit32/GRAjfcTbQfikeqgZGVK7TK6+wnuq6PoJWiTJz2DsHPCI6t4IjsIsMo6Lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322034; bh=Nxo+dyWYXHpufY4k4hqip+85qsrtYFzwqQDfkwu/nj7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ty1SHjtQ8e/sK9JBPo7xN5lLKlv1x33UCza6UP/QjFK536ZHWz2uB+c6/PP+RNMJArCyPR+PX+C1gColEhdhqNhKzU4qthFnPWtrEufGg8nS7dtdqutToZ0PVPt7XLlImtH3tTZ6sYSeygcu8COvaGziJn1Ys0ubwkEyKGlEQ95EuVHjehVYOXKJowMpz28x4VgsGLKgtXT1KhiWPEsUolRQInctLkRHKZSleH2UxI72KCSXkofHkzbbcsg42RniDkAV9OUGhpxtf1EkRuCcY+nq1S6WpqK5rxtyc7EmBtw0WWQDo7ccKGpXzCLc0JiHzcmIrAuuJ3tzYC7sBUMsZg==
X-YMail-OSG: q7XFfckVM1nTuN7JSF7HxtxUK_WZRc2bKm.JGIPePsA8JhcZEplNjTmfzN736Hj
 GGdjF70kkJQHrm75O93Ws.5231KJaFMk4TifmMvwAHPZ1Zy_NnPRdhJftmUGpxcVLr56nbZEkfms
 V3shx_eq8C9VzySqlnW28wNphFp3A_tE.4DY4D3MIm6kSjAwh2a2rDfguFWgQYt6zsmS08.0Dnrd
 .BF8OGwlIdPPwCW1l.KfbD4UOdPszgrW2SaPN0DI1Gsmw_rLWrk979KnhdtO21XYaJDHJfTOxncl
 UOU.zgFe7TwsEtVdimxr6dWUnyZUWTHRZ01D.ZGRjzwLSF3f.ngJxxWYBZ6Z1HgLxDVqXpcDEdGM
 IzgI.ESb5LDZbnhMt5ZXrrnyf47kizQ0XbtO1IbgnPA_0OY.zOK8ebDBhSGvjMDM2m0J.tOMA1c_
 eR0knNwmAjcK.svjTdpgPLkAMQAKsbDXSz6r3HRS7k9fFv_CrhAjr3q9lUzdAHrIn4.3adQ5KBSm
 WrhBRbmoO4V6H8KCcvuVZxgmq1j3SO5xc8BvxuJ7oSBLG3dfzHCDDXEbbhawcH1kI4BaQ5NUHxGE
 8TsWRXMq1SM3OFlF5PFw8t9Ej.YgWMHBh7ho6A0BqO94GD8Tm5ZthgfV.1JxHPbtGaNNDFrdQa9s
 VoMEwzPRQ8SJmtJMdUjF7g97GI4puqcsydTxA3h7KZMT6uEuAV638aZc53XzvZaVNRBKDIIxAtp9
 9Fg6iqDDm8BvUpV3Zw2bimlY9VmpnK4.kSZAgWqKHt4mNpk6iDTkfn3pXEtEK2snlsSOeeXqc333
 pYylkJxjzhv0F7mYWHGJE_5N9xEtl5Ktgf0kpX3wPcJZc1WlvHOFXH_RHY5awLR_KUcJ5jvvBX2z
 .C7pc3ZU9.OgRYqBUYXumpaYsPXkvIHIrVuzRIaoEC3rDuY0UU4jGlt75NrYYtQd0bBd3IIed1Gm
 UhZM_DQlzx8aoObCnPtlY7anmRlZAJk4M0erst3oPvHpFvsidHayzoG6nCmKLkznV.jk1dPWwzjT
 J04m.LXvVT87LzmQuYXHF7TAOWwwyFm6aXkwFlv.0GnRGie3DITxeku2TCuyHjFtoXqqmF4ZuC5L
 9vcPYDe8A5xKcZqM4VZjWSnuP26d6gzFZi8I9egTT3kbHDRLmxo6WFUlTe0lHND3NiD2Q3G4IpYp
 bQvjJYZRkSYise01gkVAandjbkqj1k2sbaUDUkXIO5hz0bobbI2iPjrGvvF6XHY9lpjYJVZFi74a
 jbLqsYMpGkjClo3xZYq3wuJGy1T5zO09LN_5aaljfuppx51faiUOFvtU_ksm5Dcr0w.1cHE3Q7o0
 fOK6zdAT4GecyT73oTiW3Z7NtqKubvDulrWAb4eGarmybtT271Z4McQt7OrqllntP.ZNUSscjF9n
 qL_Zw0FD4MoAzsaoYDk8u8Hlld_3.ZBoUeapBdA1dw81NEZENVFxBrKmgY_YLzkOalEVwg1D2W06
 grS1yymByub9EuI7EX4MjOur2LmfnnBkhJp.A7JXnv4SfEgo2BfYkgCJb2dnuylTAyN_Q7L9yUel
 a6XIQKNcDTqu1HBcKPJp.XSo0WN9e8XYQ.gqeIHD7UwjBpTLWXQ41CHv_mgDobrLiJN1JSM8lKH3
 SH5YRv.mQBYOXiz9FhdDXDpp2cufxsz9jYJ_36N9VCeWjwp402O.MaGvYNOUNULZaz5EGgNJButG
 Yi2xGq228xnxl4mjLbSCjdeaM5BlxWNNDeLEOlgnKs2ERNw695Tov3YXfQdYvT8Hdfrn4N2I1g6b
 cMk.6XbKgr0LmQi8TLiC52oxxhb3dqPcTnV5mRtR7jdFrZWhyP7I3d.L890dOYtJj2R01zHiUaI_
 oz..cSIDJljyQiMQGdqhwEA0Tt.u15jTCKtA0XglSiE8cctCTDMajsqKkhi9uAEhncC9D4Lxv7Vi
 p7O50IVwpwjfHA5bRuf_dSRKA7AHlJaOX9aWina7AMEHQ.2eHkjMEkt4SxI7F3ftR4QMOjbY6hTl
 tI7o2j9SWc5TDevQ1skh68pjUvgl8n85_fJj_4ykC2.1aBWCE80Y0hzd6CQD.zwP2bRBhrXm9.FT
 h_fkRiXtPUxWk0ttETwfVs1NFQXVec2ivt0MCZIqt3MDsatTZIww_4VY2NrSP58HpbEGfKS1pFGN
 jRDS3oPujhqeB128eVZivvyhsYs_PlwLRu9NOD.okrP9.rKWfngwE9bvuRUyzz3put6UvisSD.rA
 wJHWjtUKnoI1C5Lm32YB1mw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 00a63e6a-9c32-4c04-8a67-5db3ed02b69d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:33:54 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:31:51 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 06/11] wireguard: socket: convert send{4,6} to use a noref dst when possible
Date: Tue, 13 Jan 2026 17:29:49 +0100
Message-ID: <20260113162954.5948-7-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113162954.5948-1-mmietus97@yahoo.com>
References: <20260113162954.5948-1-mmietus97@yahoo.com>
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
 drivers/net/wireguard/socket.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index ee7d9c675909..b311965269a1 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -46,7 +46,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl4_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		rt = dst_cache_get_ip4(cache, &fl.saddr);
+		rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 
 	if (!rt) {
 		security_sk_classify_flow(sock, flowi4_to_flowi_common(&fl));
@@ -78,14 +78,15 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
-	ip_rt_put(rt);
+	if (!cache)
+		ip_rt_put(rt);
 	goto out;
 
 err:
@@ -127,7 +128,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl6_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		dst = dst_cache_get_ip6(cache, &fl.saddr);
+		dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 
 	if (!dst) {
 		security_sk_classify_flow(sock, flowi6_to_flowi_common(&fl));
@@ -146,14 +147,15 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip6(cache, dst, &fl.saddr);
+			dst_cache_steal_ip6(cache, dst, &fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
-	dst_release(dst);
+	if (!cache)
+		dst_release(dst);
 	goto out;
 
 err:
-- 
2.51.0


