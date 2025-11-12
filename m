Return-Path: <netdev+bounces-237873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953EC50F9B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8114334D075
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAD2D9481;
	Wed, 12 Nov 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KoJji6Fv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615232D8DC4
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933268; cv=none; b=Ar/YKz/q0GD8SoCuM3qevQw+f4Lkyz9tH8A5M7JsZp+e7D35DlXhCFW/9jIzuhcFIDewuPKjFPDZhCoLwjePT4P3Kf8w785nWcQ8h4xrjuotgO4W3Q4uEzab38B3mwlUHDePy1xKSnx3dGFfzyWR6DM1U5QeCxs52CefGDlLZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933268; c=relaxed/simple;
	bh=vOSYy3d8RdePNEO5mUQGcMPEW37oYY4vW8zblmLvw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+BSscXGWBLgMJ8afgd7ysnjfjYRfNX559iEFNmjAeq9WCrWzGT8Y/JTjfL32wDeaJAjhRsIJeTITmFykxvUzxovH+5LY/6oMsmRo3CUiqtKXGVsNQbgTZ+HswEob02JAyvqwmnQhUbdE95mf7RpWMrd8c8EpclEKA67Xa8uxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KoJji6Fv; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933265; bh=bsU4C0TZ/LzfguV+NvTH2t+eHZCd/2Vp7tyevRR9ycA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KoJji6FvYv5bj/tF/gz/AZdOdpBmuXh8axqiMtBCcSUZC4HbOsn7/XkvUUnnVQmhvRnhiMtr2hGg8oOeisx582j3jLywsrPPjRETomPHaGr2Z+JseTB5ggI3M/bbNbniW7j8hkDDf+PoUnXfj5Y9/ojFPF/cZyh4p7uEbQeUzfg/HLOf0Pu0vSAE3hcFPt9g9Er58R1qdR5vshZ36j/VOpggdNS4gIMx6uEY1Ay+w2o7Xwq6JSc/+POlnOphuj9b9ZcIxV+FXRMuCuYe9EYy/+qk8NEw1pOvedwG/pcZIEA/zOxzyE+FSbRK9tBrtSwU1PKzJnF3zoEZwVT14gexPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933265; bh=p42zhy2W6JZbYh0AM2djJzjTZzS8GiL7sZmrJkDOA7c=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pRRcd+bMPGsZ6iCM5iV0V+/KNZJjeKjRWdTAt3Jfs8iuC2kFjBAJUPifI7FjropkQk0LCnfa50ONA/uRpLqUErAbegIMCO9vtpXeqm/lhXqv6Npgy5Mtc+Rt5qRK/OTQmW/96Jl+/sTTVKfhtGv3/gWH4kvVFTvE85w5/o9EKp1wnhYd8YszWRDRXQihmjBsuS+y+FmwYLMrdBAkvoJfesT0iXc3bFVxf7215AirnQG67vzo11QOkEfiaR8r/gDRq9hMGSAyDjBjvZnlbA/wg9XT5P2NVCAs+7DunMNNW+A9M/j8yBzQxBo9xJq3uvUc06BRGHoyCLcOVVo4DIT8mA==
X-YMail-OSG: WgjxxcIVM1l705pW7RbIRNad5XBqbRs8a_KyRGqlOpq2MA4yclkaQNljyfMtCUq
 euZgAm7t4.4sEZl3nNjqod2KND.OB82lInnhhbyTzIjn_nhZGcsw5nPAphT4xFx31g33EKRAMZBB
 rK_lCpVYfGG0EEx6FsVUh4eX3mavvSXGMf5Xjuv3DPBhJ3pFkZPczknlaJiKhq5J4KA.p2fTAOA5
 L_KfVTJFYCcIoioHukqkGvH_I0Tfphfq8JlZ7MRNJUOVTcYwMXEzPg8mszt_PkwiMuTintWtgIEn
 z0uo8v5hOGFwQ8j91QfkJua5gsJUjYHvprG4.FS8f5_IX5BR_sfSfZ9BkZloJ6BBVh9V3K9BCYg5
 ciuVqImecU7HRSWtBGZwybiEWIvhJc7N2YzYUV7GzWP_eEJAuoAykMC6kbTsfW.LKtUVzGxFh_Pb
 vNtdSCQHJ0FembhTgoMZ6r6lidablHU8UZ7Ch9f.VX6peLZsT9CfJhBU9Z6Tuv_9EpYMVcHR8cIl
 P8ke18GLspEVm7lS6dioQ2suipeltO72KB6giYCTigWUkIEa6xjBS4KWkB90GAGp5khsvMyM6Bne
 wAuk5kWWH2rOmrXCCcoHWrWAOz0CU.hYXPuFEeo8XUTTG.ShrCmfDCw9hbewHtN3YerMoa4x9bw5
 0an5zBa7FcDHG55SJ7nbQLEEmjVxzdI4ssqcwOXsrWBI8B0FgVk33dWStIpA1PHSgxMUsjbrk8gf
 SMe4h.NayrrWc8LKLEHF2mec1ITg75c529SGaW9KRwcvwHhc.HWX1Rh.f64jtEn1ysmOja2yDtdI
 GhiH6xy.5xuDAseYQPaGPzUrTg9IprZtA9VKRgW52HLk0d2H49gVdGBEj0okWvzuk3Hw5K2RK1rn
 ySrKNIpefylxtb7hnPhsgLJNwQyjpfMEFJpCBNt_u5XDJ6EdZbWt0jcScBg.AThpKphDxYXTyvOU
 MR0Nwnb3RK6AcdtKWFB6forH_A08zEuhPO6_ePtN91Fzv_lbuZvSNJmbWwSP2Oa5UAKKjeCV0IRC
 cqIkXWzX33nb86l5zaAx9bhgLNPFajaXGuuL1KZL.GPBptznOVP0M2n1KKC8QrD0kw2XXynrETRd
 ESevpTvAlrClGYgJBjdNVXjXt5vmTuPlpnDOOIuCHB8kxEdseE7fD4rWdYvKOuKrt9kNm8Y0LBa3
 LQ0tE1XQyawQR7jBvgGEKdQSc_2zIz3jR1njiEU_q.u2XTBNyE92egkk_PC4NqHxBSRhKOnpeCXZ
 w1e.O98ZJNQg5174tQVFSFPYD0781as25YSyaxSPWqiOEEqkChIFm6wpDrA9VnVvuA3za_An2g7w
 31.lIQqiHdmtFH5gVST1FAYO4pJqe2Ar6n_iSw5X4QLrv2lYQ8XtpAILDcZkP_lQgLDmwBilBTED
 B0cuEvDMlJExmWsMjmB4UxZo069ueJA84AuPrzkAimstOHCp1h4_.HvqWvDdxlFbXg29BSSatOZV
 YAbhAsV9IBfPxb02EiNFgR4FWLBYaWzsZqLQvSALdoij_j9F4kYk1EDZDS94zorueoF5h_KU2Hkv
 fitv0S2Td.gPAva4JSnvzzQcX6wNqiRBGL3J9cD8UnNRnJmZ6w1ku8wnekqiaNLLZARaObQbDfdD
 yWF5f.vl8ChG43lKhc7kTKrCMDi9w9FLEJLiUi_u.xC8Lxs9ZgWH5FWAu2v6CB9B4u1DPqMUbs0U
 2FAeuqPLPrWb0FfKhYwRWJJlp3vG7I7SEUXRuu7k66wqkKlPwqxPPgnrDt1xwJKa_qJtxYAumk6t
 uCnYnqXdvwq9JRNMfkaeryJ9C_84M4WOfBxFcsQn4Ge.N1ZvAYfoK4UhThXPPKLi3Fk7hA7MrcoS
 4t6ggHjkKw7YPfo64.N2wF2xC5o0IfeG_PVBZD0P_bO93lIVe0Vjl1RDXy72K5ZpO6q4YB2zsQS8
 tYO3.4p.Pn576dQf0xVfvVjodS82B6zA.ArBL1TCQv9GauKa68y9n8.9iyAAONvQg2NbflZQGNId
 r68IwttDSmtXNi3WVfYTxWm2iuQ8sTz4oNZs6M.JckhN8ZywvOmBe1k.7AlC0Qh6EcCyZG7dPSmt
 jFTynKkThr4bFogtbUlotUzIFX28rol7wR.j7n4oVuFq710wGp5U9v46afQwXxB3UmwUgxlGX5FP
 VRU5Lzo4CYttWAMRR.AGPXZ4Q4b.dfrgTeP8ENxDA0oeGCv3RJtitrkWqvb4gjuaIVqHbrtsKQ4t
 qzq8kXL8c
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: f347dbba-aa4f-4165-82ba-e4e984b69007
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:41:05 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:56 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 08/14] net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
Date: Wed, 12 Nov 2025 08:27:14 +0100
Message-ID: <20251112072720.5076-9-mmietus97@yahoo.com>
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

ovpn_udp{4,6}_output unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for ovpn.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/ovpn/udp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index a765aee6e36b..6d623a0df782 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,10 +194,10 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
-	udp_tunnel_xmit_skb(dst_to_dstref(&rt->dst), sk, skb, fl.saddr, fl.daddr, 0,
+	udp_tunnel_xmit_skb(dst_to_dstref_noref(&rt->dst), sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
@@ -235,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	};
 
 	local_bh_disable();
-	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 	if (dst)
 		goto transmit;
 
@@ -259,7 +259,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	dst_cache_steal_ip6(cache, dst, &fl.saddr);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -272,7 +272,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * udp_tunnel_xmit_skb()
 	 */
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+	udp_tunnel6_xmit_skb(dst_to_dstref_noref(dst), sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
-- 
2.51.0


