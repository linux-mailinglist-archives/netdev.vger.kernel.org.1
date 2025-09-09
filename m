Return-Path: <netdev+bounces-221072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F2B4A1A8
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FCF1BC1B38
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252D27CB02;
	Tue,  9 Sep 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gp7X9k/v"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-3.consmr.mail.ne1.yahoo.com (sonic317-3.consmr.mail.ne1.yahoo.com [66.163.184.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8C2475F7
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397389; cv=none; b=XVrQAL+OOVdf1ODWsuVpZJKmWoWomSfO+mZ5vkDehx51U8eQ2oj338U1JFYEDxU71T36w6rPMry6tPYRAwwNaVWDTBHRbpYBt6LHi3h/dm/qb0C5bolKGmjFWw7IHgWP757mIfrJ1Rqp8U1Bd3KReMBzy6Mh3MF1gR0g1XGiUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397389; c=relaxed/simple;
	bh=gHgAIh5CKdT+Gci5DQnkrW5L4ya1rh1mtkmgIkURaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQrg+kOJKS5FCZEM3zYYNjQw0ERrO1MxRYkeTS+VD+8abZeno13U2geaEFyFnOzvItfENPxsBnP35nn8B8pDCOj8zqjqAGTFmfkGe8u9sJdbgP4stxDiYuFPzQtrb5vfmBzu0/Lc7AmvZkqbT/ggjtHzeeD+brccg4q/SUhqX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Gp7X9k/v; arc=none smtp.client-ip=66.163.184.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757397386; bh=5tdcv9pUVVHNs+QwD5gb0mr+Chpp7ofQFMpu+NxUlmg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Gp7X9k/vCjkhOIiJTyvHR8EAmDkjPJ1L1rUo6QX0kVsNbVLsbTd5SbUpEPUIuMquyp3duaxghT+uS0mlecGFXuH8NL5GB5I6Yt6kAryX0lCYJA4t2BIQ2FPR+2A3M6v3BKeGFBJSrAOIEcLaHtwJxwKyjVYx7bYr3VbWZNcyMzBGDXgzw76ji7FfS2p203GEf8O8/6MirH7uVuaBws4E2JBcgY86881DBbTisKbXbFlpkE2mgiYdke45uvOzs7cfrIGrfIyYQVpc0lsmHNXS+g+oIKXkxeThHpJLaC1BNNx4mfFfuTFbT1o8qSC46mUrccqwynRmjNzpTqJlKALifQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757397386; bh=Cc1uxDIeOqtncB+xOItf+/k9+liBX2gYYiiY7goyn7r=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GjxasMN40NhTmIQDuaNOpe62oIN23o3pcmp+btdiv+YltvwQ0rkkBi6xQN3zuH7sFq+kip0sPWK0KRyCd81WwmKIXBS59YogTkfE/sn30K4oZR+iwv0uHdO/1mNnCTZ9/8beQA9gTtqigo++wzRSf1z3n7L7TAPhefGed/Eb0PfhiTy/3fa/Nt0VyC57Fp+5a/U8wkyOofOTPOJ1JZWaNMCp9b1CKCRQE/H3V6jIUz1SbzWhWU4p3zxEHVVVLBIr+s2R3Ebw8DShiYMx6/0EHOOx4KjwdS76EyFDaozMm68SdvuQYKAHt/2tH+310t6jdHjSvFc0EgCQ//CYzMPUDg==
X-YMail-OSG: fUlY18QVM1nsm.K86OyP3jMJQdrXImbnoFLrvtMleaV9NeGXiHGSBGfMhGjxARr
 kqn9nWN4yZjldovMJE8VDyNelle0tKBSoIsEu9eHbp89WWs26rYYL6GvGZFJbnHi6wH4Nisykhws
 vj4drN2Kofbj3Y7E9iyFSklWKIlJxvR8ZlyQP_Up2wsqfXHyzvMTmNvx6SXUKmKWmy.XEvhIxJM9
 j4Ucw87a3RI4MJMqytaKUkd5VAeEck7iESHw2e43aWoQD7z7ylwuCTdDwHw0JAtNuTr9LoiXvKGJ
 jKk9DUbCDTdkNfdQXOS6YjVntx8SnnKni6g5tZidCBUu9jeblGfox6I9BQZntWuE0NanZcAzPxfv
 aJvpBGSVKLiKZHiWisIppiqJ3BBoVHKMJWBh_VZDDoEoRLhvjXYOLLc9Xm5tCM8QRplvLaWyZfWr
 gmxDcQyPdUxWp3TjGG.doi3f07HaEJP76l3TmJsqdimHPS310HiZ9auuqSK2h4smYv0jhKkO1g93
 iFPWkfPywdO42Bw_Db2fUKnnd8pqLefB8wV4MpAJgFGrln83gGlqEkcmoVn6wua9IIg6lLYURVwy
 IIind3bJuMeRoIf6x9i4QMc5VgXwD7lg3k6kI6LvHLdIz_.sR.LX4yA8N9Oc.dg7OcTkD1KnmlUB
 IsiJJJnaYOt0SHm8eG0jpv7mVcNH.TNbCRNPwEn3PHPYIcqRoefNW7XhpOmJ0aoCe3FlS94XC3r7
 CMdOjJnuY9.bpyu_4I.Erd2i_2pkglFEBqvGf8ZbVh8lWnXcRIMeCWiQCNadx3mjwfbpVRVdLyNh
 KmNCnJpg5PWBL4jcvBIs1bzacpyo6xWnZ91XrVkUkG9rM.z0B3mC9IqRuoWSZz5uUib06Vw6QRth
 c.cOsKGk8b4UzmqQnwpHhTdFHUFhm5yrntJx.LsLPOrmtvladOEdmHiQwAQr5.6Wzy9r8F_AeK5B
 KUx7i7UfcRdU5Bh.tvha1ikNs0wtdmX_7_PSUFRQe1jSlvxBWwmoOaaJx_FZydHCtEmf22ZDUg_J
 TArmnAKjXvUozI5CL_nWIvQeu8bmi1Q3BanOXsB6Lb.94psbm4YtxlEE.6j0sVXUti_quHYj15gi
 .jVe5xK8RpW8xmiisN8xhHfNbjnGcQnVzyg4eqw57wpUk2s_zvox.45hjaOFXKtG1cgEAdGDBIOd
 ub.wN5iXwBi8GwaiBAHV7Dna4Mv2QgWGOtg5rjUJjeLNn5zVZ50nPBT4WyjORBZqEokxvhGAfI1x
 QvNWfk72_xftfJKMuwAhuGvRfd3P8TicYvFNw2yh.ZRyr3uOyWLJV30A.xvarAmbwOSd3AyE.GTY
 MwQSWsSLn8Nbltb.lI0als4YdiBml7cnTHuzMFaqXIZ_pniX93v6NM9MA714.8.CfLNtsiZ2W_fM
 66ZukVuXu62jfeeR4aazbGxG9JxboxEXuYkYS4UUnJNEZJO.gjmurmwVQr0cRQWLubMfVPmYtyPO
 GPAvqpESnSSbZvmVH_R2OzxN0uRWyKmk7W0KKRHhIIekDKU3NqjSzBrrz5oH7DzYMJqqHue2VHGN
 DEwyQJzpAWt2.Qi2iICqAaEaVqJE1cYoh7lQ8haTB.XKTBnVBS_sQkULFqrpYc3JUqev7qONaeQV
 NycRqdmsdLEdjIAwxKZmvVLr7Vbgeen9GgkbnWTYnygLEfj.Bu0cEsByXcfh_w.cdE26Y7SP12dz
 rvGjJLPH5jsTrDYl7QK_YHa3ozYlfm7phPcPlTYO0j_iWce.qkeBCgV._hevBz45MCrpoj52Ae4I
 nbjdddRkC6V4ZcY1I__.B8poyqkZAkpBdFaSig1eoMr01om793AEOndmQrwYHg2U7ny62vbHfTwA
 NAML8aYW5cvc8UKXFf6syHYc83o9N8Vw74GnIoeG5M0.tz8KP.xfCZ6tAaS4_HJ1bd35m6feIaO4
 EnR2j_rogaHwpScKOnUQ2_9JwvlGLCIpRmXcULTpODZA3tSBe_u2L2b2XLZZgXAsECxkjJHbpcS8
 YUpm1Dp4CGKXhwzp0d1ladeMt.JeXBiVBL9_Zer9vkY08_wR7QKvkBqwpC5t5Zt0ksZnFaA6Alls
 amMv9zm7kAkOQrBAAcGlBs_PIyVri_DZqYnqY72YoWylWMbNGNa1wv_VdF8IzSJW3IB8pc7mQuHk
 z25b1OqOPrc0yhwBxF33w2wV8K0O9BROh24XRLqAmrojVGs9ekAdlXEYh6JmsjkYKFDIDecBbz1J
 h6UUys8QH9hXxJXkXOnpxM.PRgAm2gg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 7d566367-e231-45c1-91a4-49c219a420c2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Sep 2025 05:56:26 +0000
Received: by hermes--production-ir2-7d8c9489f-9tl65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06aa482699b918a59f317ba4e6d13960;
          Tue, 09 Sep 2025 05:44:17 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next 3/3] net: ovpn: use new noref xmit flow in ovpn_udp4_output
Date: Tue,  9 Sep 2025 07:43:33 +0200
Message-ID: <20250909054333.12572-4-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909054333.12572-1-mmietus97@yahoo.com>
References: <20250909054333.12572-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovpn_udp4_output unnecessarily references the dst_entry from the
dst_cache.

Reduce this overhead by using the newly implemented
udp_tunnel_xmit_skb_noref function and dst_cache helpers.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/ovpn/udp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..c5d289c23d2b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
-	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
-			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
+				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -269,7 +269,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * fragment packets if needed.
 	 *
 	 * NOTE: this is not needed for IPv4 because we pass df=0 to
-	 * udp_tunnel_xmit_skb()
+	 * udp_tunnel_xmit_skb_noref()
 	 */
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
-- 
2.51.0


