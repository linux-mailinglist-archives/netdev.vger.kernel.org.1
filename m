Return-Path: <netdev+bounces-249520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C57D1A6B6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 715BF3091F6F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613A34D939;
	Tue, 13 Jan 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hMwh8Ga4"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-36.consmr.mail.ne1.yahoo.com (sonic308-36.consmr.mail.ne1.yahoo.com [66.163.187.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7B34D4FF
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322968; cv=none; b=ZG2u0eE/PkycDqHtNHoqBjiFazTanrssWEAuKBKnC0/56i6U1t6E8TBSoZq1L8rthY7X+N1rdEBvNTq4UazWnpn8+MhmBhClqtz078gitNkCDHCAFzFGgvE4+1nvrCkjBhMTirlqGcFUtwiPcMUn9Zs2BRLd5tpvviLFHQrBZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322968; c=relaxed/simple;
	bh=OyOaWwBvHND5r3TfmA5EfR/0ZZhhdD9apaXkw0UcDzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/VIDMH25HkZl4/NX7H1Sduoky4Zb56wEXh8LAkVY1IG9x/Bbp6FsCw2CdOPlWdiBnniFjScl+/BJ1Bl4JQ99OBW61fGdMBfiFMood6SIUaTUGsy66IytuUBAbvxhb5xgEWpvGscFyeoiIZDsfPoidIV8QQYHhBWLWGOdg4zE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hMwh8Ga4; arc=none smtp.client-ip=66.163.187.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322966; bh=NWYeVvUmPkhrr6EVYaqNHPu/ef7X6jiiHaSE1eZ3j9I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hMwh8Ga4IdzX5UmCgtzdCdmft1FA5adBzxaFiT1FxAmhBhHVAqpMxOCfInH9izIPRtSvB/H7XDsVGjwS9azyB9OubjUSgbsa4+2MwLA0Zt3DmNFyp4Er7c4qPW0JHgRXFfNZ2LMCXFmvFZJZNuxZaF5P2HUynr/UySo4OL77glEhYT6xpxRWtQjBiiZ2RrL0e52Tm6a34vPAtYXdaLRGE4m7khqM8P3ZVdI98zmOcxXpXBMiFeU3V9bNaxJYJxe4fabUWI4+hTSbuiRMR9udJvTWma4QfGIWBcjnZ9WZx4DCKaQXsW5cS52kVeDWNOCr4VFtqjt/ac74Q9DUfwP56g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322966; bh=YfZXH1STePBpHXsaoONo6+zHNkZsrpoqNy4mgNfNx9o=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=knf3Vzed3Dkr0smdg2YmF0yGokpv/lTGF5BZovxA0ZahiFmTJ8Qy/mENSSKLPygRE+pT4A3BHvtbd53Iia7PV5ZWFUr9LzU39TOAP2nYuDgDDtbRJnTn/UNEhVG4Opw5pFx1xl0h9Af5Ug5bFL/grwJIARTSRbOpgl6wRt//pClAI18+jx22I7SvOz3uR4XBEIAjFNc4xW9R77XKKmv9oz4+Db+z3g8SqAaUp+3VW4tuJqcGB5Th12WAjq2UgEgRIjFYNywk5QDVtU4xQ6KHLYXg0JAuQIvwK3Y04SkcBn4pL/uGf8on+2HCWH8fM/88IvRrvH7hl90SHIoopHghiQ==
X-YMail-OSG: oonfWk8VM1kv3gGrxtMp.Y56WLWB0z5pL_qRGagGrKe0neDKOA_xSCLuvUq7dFu
 NV_F_cgE0fc_AoKSxEPOf2gFOKaSDkO4kRLqZ.IquHSycYs_x7S1MUSM5xp6Ys9YVAPhkT1kq08y
 CcfOl.YokeznFuaE2zot0EFFJBOM2q_5Ne666ggIv6E.UNtIFq1wr6kLWPP.xocf5iT8vhau_Kam
 NSQMY6QW.t_0bwCe2YGuhYVji5J7XO.GBsaXrNZAivjHMoh.BQM9w6NYvRl15UqSVxpS10enCUOw
 Oic_oXaFAUG85SG9izosctVQUCHPODUSd2k0EEr8dEmGDts3NquBcLIFmu81lh.bYXKC_vi49jC3
 kiCS5jQ92GWX8COn2_SBNJgbfARIZYvsRsX54pDzkB7SnhEKKcF.XPtZ8LWkh03BYS8mmPX3QfTt
 5TXI6L9UAx6xhY2HQIc3NTTa.Muu7tay8Ovfsf8dtKpZUyHkjfOmikb6DrVSKdd6ZoXq8alnQgmJ
 WhBemI5UsjS3pF2VTvfe0exf2A8n1yurl088ULFN9jR5QpszDfHhbVPJtX4kcz9QltD1U7SbB2gY
 sGDDSeR29IejsvSb7c2XhDyS6AqqcS9cevyb6MVh8wlZbeQFDbn_JEAV_3.Tbro_elEgXpilTCyB
 ShKlphQZybMlB3INlHKIa3Wt7oci_DTxDXyhyZ_HfZudda_DMsw4E7BeCqgJzt1nPa.bLv_7fhFz
 MZcjwsAhM_wGFyjOKM_Q4Plp5NtL6oy0SmGfhHFbva7FGp4iPU8WInIOUbgqslqvYJ1mT.Bo68__
 mflCROtQbE4TJ9bJQmtfeVm_QFWtuwbsDgn.Wb0mbHIKDJlzN9gp.wkZo2MNLVYfgJG2g6j6jGPc
 RR_Ab7DslOsU1eFTHiyXfzBg5Za3ugdzijGjKP72Oamr6rGnB.pdwsYywuIAsNHXYstOhbFb2TSg
 GyeL5apKkU0VuY8bIRZ83zPNguLgZ7nuN0Suay.ahUI8AAI0RsiZIAYhiB4VyrKUsav_SZGC4fX1
 kbwHtj5flr4BRo92c63PrMVN43p.WUMaywunDIe66hSo8qmpDcyHtfN1gYltJyuG23l.jVZNsTH1
 mIf4eQ4WwCxp9ZL0q6bH1zhCej16zKKJyykWU5vsa7qhFFQnJBcqvwFlfWqMLUKEDM.g.4WJBnIk
 g67.sdlGdmO_WWintfFixJPyVMeSzps2DaNunBf9z44hS85oyguXXsefnSbE4hUlLrQHU_K9DyWI
 U3dugLVCE28P.pOWjoEyy50xHSIJ_WwrkxuhCmChY6e4L6afYfuFXwVMELFfJvgf9hbhczoGff5V
 7Abvpgelu5eLEKkxsp7.I._aBCRzbA_PMWknyBIeuKVVU9zGRGSbf.lAQVqaB3rim834B.j4HgBs
 6UNYpeWKbo6EZomju.1ZMnbQfIfYH9iAc0IWNRbor94spy8rGCSmDqEDi9sVgBDe7laNV56Titlt
 AOipWYQr9yq9qs.HhZfaPf0seFar2cTS9Byl29Wh31kKKaecV7yFEhiZuxJ9UtnSyXd29zCkeu6q
 0DsRVY5kREpWggV.KUIIWPkOlB8oGbKrhyj4yoWQT8j7pERKeqWQJ6jKEHf4IAPfk2UTPZIM6Enk
 fil6XfUZFkBoLhOHluibqSLZEuut9IFV.rnIc71hRkWyzR8tTmGznSQp4l4hxoOr0HTzYSGd.oFL
 D_ucfSfer_n6zMxrIXCOzwIdsh.YX6eSnx9h3rem5sUAs9ktZuY_2_H.lvwzGErobu8pc6iRixvM
 dFQrrspbNZajPFnIP56eMLLtrs88POTUP84sQfakRUa6z8RIctvsAxv8M8TKtCLQazdpyewy_TnC
 druwTZG1Wkml9h9v5FJbFlUtKMVkW.oUaAmK6uaA5iZpDPE8dGI5CZ3MgcgOBU2lkPgwGu_iyx21
 XeLuOb5lWYaE69nlQrFYoiP1yqhLmQoENn48tQ2E8gg5ZmVZQx5d0fvAPM_onT3mFW3sIuO2SNtx
 g9eTx3G9aACOikL8n53XprHPZ0NUIIaezgROySr5Thgnxhqnwak5Uop.fNzbBXcxevaFS78Y_Ha7
 wm.jT5n9N7dT_jKzji2xjR1lhhQo2Lxhjrwq.5L88SXebhlDZHylhBBHqL44iN2P2I0_XdjDQw_m
 e1ci7Ttp_hdSUUh7n4aNObTVs_SLWOcAjYOYQCbk_d18atGVyt_Lb2pw48mChth__UlDMtcWOt0r
 kEnuW7i3YBAiudrSA23pA0nI3dJU-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 19d22beb-231c-4ffc-8abc-ad96a16dfd4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:49:26 +0000
Received: by hermes--production-ir2-6fcf857f6f-9ndng (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ae45f0023da4d2f517b44dd167b3090b;
          Tue, 13 Jan 2026 16:37:15 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 11/11] net: tipc: convert tipc_udp_xmit to use a noref dst
Date: Tue, 13 Jan 2026 17:36:14 +0100
Message-ID: <20260113163614.6212-3-mmietus97@yahoo.com>
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

tipc_udp_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for tipc_udp_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/tipc/udp_media.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index ba4ff5b3354f..cc1ef043aaf0 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -175,7 +175,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	int ttl, err;
 
 	local_bh_disable();
-	ndst = dst_cache_get(cache);
+	ndst = dst_cache_get_rcu(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
 		struct rtable *rt = dst_rtable(ndst);
 
@@ -191,14 +191,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(rt);
 				goto tx_error;
 			}
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
-		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -215,13 +214,12 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(ndst);
 				goto tx_error;
 			}
-			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
+			dst_cache_steal_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
-		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


