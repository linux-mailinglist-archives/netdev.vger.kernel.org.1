Return-Path: <netdev+bounces-249516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E3D1A638
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1067302AE3C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E753246EE;
	Tue, 13 Jan 2026 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OXnPMpyv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-36.consmr.mail.ne1.yahoo.com (sonic308-36.consmr.mail.ne1.yahoo.com [66.163.187.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDC1C6FEC
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322628; cv=none; b=tgwpgKd5dY7z/UBtSzOI4bacq+FnO5TqUJuVfig+OmqNTyhPEOAFJ/894smC8LNcTtnOp0nYuMmyE0lXJ/oRemrtcVq2TmMGtn3B5j2rB3MeNobe7I3PNmhy0+XkgRS9SUuGsw181QVyAkUFfDHsoch6OoiRR7RZNmGZwG7Fiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322628; c=relaxed/simple;
	bh=9BYa0z94Hmry28of+u/2XQStTBecbGfiYfOBNk/CBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWf1XD16LWJK/wOmtljpWa3KVkvpZfmQjTW3e0X0/CKXbJUvGYYZi6/dTo9bD4/yYSK6FFzV4y9eI2vBfuzBbM2R+QEPAf+v9Ad/H4E+d2ptcWtDu+kDRoMyY83vFYfl0nl9xAoyD+940UAo6n/ByrUaFRM8xxtAiFs6v7T3+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OXnPMpyv; arc=none smtp.client-ip=66.163.187.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322626; bh=zcyjbB29jfSRIhqzAHiuH6pP28JinZ5meGFHh8E0HGU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OXnPMpyvRguhbhXtL2JPjcl8cqxlR0YOL2CAgSXNGG62DXWeS70ZcR7xlKu79DVqkVcGytLH+7kinvP/lQECwGncmydtjNkAgOUTOMutr3Izd3dU3iLZ8ivWKWEMsWCGVUfbTyzXcLEDJf49XezuLQHq5JCBZ7L8Nn6FQkCFU+iG/5BU7K9mL+v95W4GA93m7EZX5RxoT6g0KKmkq9jtQVwgraFeVGF3qH0vSdZeGQwiNw24SdNT4CNVSlzdYQUeAQswe3q7f0lQ8cCmiQU0XiSsn3B2JVsel7qTg8G0RK5s9sbm1cHI3sLtgcg7UioG/ylJF2qx7fMrj/+aWq8Cjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322626; bh=7j5NicKVSZJLhSCbn2ViAw/owOWTBZbl0U8RH1vIl/M=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tKOuEGOMTfcbO2G6zQY3gWFEqKT+C3clne+090yzAUauMGfQSBLlBTtEjMWlEp32z0j3BgDBDXrUQsDDR4UPGZTc7tf31vQgRG/GNsAJK/iuXO/BMyrMDMZuj5dn6JGw0dzdlMNmmpcpQLiRdcXzwWuIHCQ8VGz4ciytKBhpB3j39p5IpaN9YztSYkC/YzBogKGgqF/sotyqrgPf5YSBDnqch5x46UG6rTUV8CLYWb8AnrACmXeC86b+ps1dh4/FbUGHfgKhZzYSd06IO8IJEBy8Vi7Ki+jog69k7UNkOcbJGg3IYvpscBS3855DzvpCnQF7GOhQC+/OUCNrhc+AoQ==
X-YMail-OSG: 7ss8pWsVM1miWGCHLWVGnB15txSnBvgRUPkmTOGOoxfhkiPw4KBNSLmFZeJkQDh
 IYokDGR1zXb2NfE5i72fy4.Q1no7.m0j9MVvBbYHl_NJVJy.GK40eQfR6WmkXSZ.6JITAb8hX5ZO
 AQStURZK3yiNjue1.TztCis6ovRqrBZOF.FZrvKUWTyhXkVvUGlRPHqMQdhwhEYuJnNyubbEEMzp
 StuQkAa1poo9pLIxUtEvZLXl9NJxImP0hmGyHmZXh7sXA8FIMGnKH6.YW_EBxnKribWaAgNQttE1
 ORTjh6sfQrn0vrPXXeEBtkB5ZrXsjy.7Coq9IO5OTF3fhFQZlxcM7ZgrjUzp7j91C2bwd11A.37x
 9kkNK3Gh582R3.uOqHHKmmalig7Y7nLxzILdNWvzzJR_3c4LVEJMwzv.LZG2D9zIu.EvTiGzWuqL
 t2zL8oLaL8z4xEvygaK_H..MpmsMEQd5YWWLl0qF3B38sSqXWF2d.MdloYk.VtcYPaTxB40XyAzp
 0wgHkIYvOFoMSvVVDKMW36tmein5V2Nvtb3W97LCs85OYs2QOG4ozZKVxKwsIHfTTv2YKBPQ4FCA
 6GVB1mskcXYswFRerkzgl_8zO0IqK7V4eCkMOTcOWnAViLLstgjr3Cnt15.XN_E8kZ_4M4DK_YnQ
 gPQTvv34HY6THQA6iMQYj.CHdNxrLmBuKbfUyFzbRRXM37QmMK1Cn4P4rNvNCQ0U3F6Gb7.dMryc
 I0_TRFZl8Hfj0lj879Xs3JcEgQYeQ.cjjZD3xhUXOuVNcYL..2CCwnyg.s7Yyo_sSL9WgidS6SdB
 n8THCUFREJZLP1q47DjugWJXQmJGightfiqA1TPn9l0Fys497Ur9lPdAoNmyQdAyKqUjl4eatB5L
 .LLexc_Ia2vHgyWFDPUWx367K5h9aroRHomv733UrBSzj7R0Y3CwWKnXprZ2tEmysPDVf8b_B5Gy
 nmcOHDVtRkl0bQJmCCnXruC4duEqZ0gKnvsNbO7jDwGn.yhVYQolBMAfIsHw4p6GGqDttWGM3aBb
 bDVrPJEyXT02LdeAb.wWXf5L3JLSET9JS9bGqIp9A8ZpZcajhEl._EMRebcibtuTIDx1Ozhrkqs8
 _RCml6rbbInflh35eQ_Q71KzLnls2e39GQrWS.ZWxJ9ie.L9ZHoTqwLM16C0RfqwdgsLAzY9z8Ep
 GMMoCwCAiKh9eSbiiSBe_hz1CTK6WUcMffuBHuuQysUpW9B820fRIm9JtEub5HS892Fdl_j9Lwq7
 o5Kbw..9d3GTAfibP5LK8URq0HTxd9Y2cpZdWeGTYNojRWPCYqVDpuK9B5yuUgmeexlCUFOyk3UW
 lJlv_ldRKOeWBEbzX5EilMvOA5G51poVCcqSTRnLRyQtNnKe_4XvqU_aJAZ7KSByLkcijk_3gF7U
 rbZhbGobRtm_z3880QtDF4hPfpl7dScxFVRNfRnrBJAmxR5j6L7JRUR9wetbu0fqQBKh7lqJ7bTa
 MOmOtAVJ9Pb35NTXAAoXWuxpaK2cF3H9WLXibMD.0zL7FH_.OiDnLoCtzKPyRefl1NCdDZy1DX6o
 CET2dAkiVFX5ievr5RcBvgdi0f7jDwM3pYyqbJ61bG8CL0MWtnhhu5TwSsyPjhBiKsyWthCc6q2u
 4sXdYHch07K30V0bhor7CDTbKDpLQFXqRWe5fUswFbKCyRjbZjkQ1brDak62o6Sck5cd7Q.Szbdr
 XmiAOovmHCZU71luN3VOzhpQEJMk1oolW.TRr244IvI33wVJvtOr8OBW7X2QyfxFN1RCbLcmYe6t
 noT0Gzy3w0g_Ps.oBOtuJI06ytk3V0qlf3YQ9.Fu8WDq74VGvsxXsFOx3MpYzdrA5Bi_SdYPi_O4
 ufmacDQHLguOx5D3DsYBRoCjuNJ03s_dcVxT.6leeDEQSHJTYDCZjKE35VOrio9nnH93BevlD8b6
 k_TI8LimfT6Ml_n1S3G.Avixy4qEsQxUYpIqskbIahPsqrKKTZ_xaoSt.83_NZMCGCAP9KjJM.39
 DdbB3noUVSG1pEA7txrRZuJODNYvtJ2dNCiZlkRjTCca_cf5Bbq.DqmVefaYdrH7zGbxwqRec2cA
 wHLU7XFfXZ908PNfbhfDs.b2EaIaeH1.6mf8rGLp7AGHDRPCa4wcmnepduXwCSdfaeYAAC_EU983
 bRfT_ZrcGwbeaIwmzrvh2zkeN1pxCTXQRxBRv5N0ljiFbTioEw81zxGD1RmLI9_eXHepOu.U6vVu
 gFwdLmqrsjEdBxHN7tJH4
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 4d4431fd-1164-4f76-909a-afa0298e15ac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:43:46 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:31:36 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 05/11] net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
Date: Tue, 13 Jan 2026 17:29:48 +0100
Message-ID: <20260113162954.5948-6-mmietus97@yahoo.com>
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

ovpn_udp{4,6}_output unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for ovpn.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/ovpn/udp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c82ba71b6aff..31827a2ab6ec 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,13 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
-	ip_rt_put(rt);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -236,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	};
 
 	local_bh_disable();
-	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 	if (dst)
 		goto transmit;
 
@@ -260,7 +259,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	dst_cache_steal_ip6(cache, dst, &fl.saddr);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -276,7 +275,6 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
-	dst_release(dst);
 	ret = 0;
 err:
 	local_bh_enable();
-- 
2.51.0


