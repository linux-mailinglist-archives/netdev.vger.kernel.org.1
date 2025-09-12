Return-Path: <netdev+bounces-222514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95758B54AF7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8AB1C2453E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C03277037;
	Fri, 12 Sep 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FnHQrsJM"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40426B769
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676304; cv=none; b=dLDtYreE0c3BZMGvjJXowuXpYTXK4ko8EA4TyVUvnOREIPdwndzJ4bPI8tQh3uIFqp8W6ot36zlr4wa4tu83bQKyqoIBpbgG9pvHsuBkFn0TK4arDbRhq3Te4QPLSt/TXmLFY2CXY3W51p/hw71r79F4mFLuMOKBUdJN31jeT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676304; c=relaxed/simple;
	bh=gHgAIh5CKdT+Gci5DQnkrW5L4ya1rh1mtkmgIkURaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeNdQvxQ6mm53z9JmRQj85IsAY6fibQ+lgzi6XQN6ObbfiswODbOZapa+ts9XW3XKJPJ4ztXQ8MEf9djuYUmpQgRI3c6wYNg1kYq+gLGiz4p5jKfCEiieEAYna1oT9P8BnouNelVRINPSSMhR5+PBAChf0u6+D8m3+KD17OIVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FnHQrsJM; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676301; bh=5tdcv9pUVVHNs+QwD5gb0mr+Chpp7ofQFMpu+NxUlmg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FnHQrsJMPTJZ34GLdN3An9gYGdOBNblpnzcxMniCprqy+JGJ1B58Jt0hj2gU5+2UyM5UkZ+jgT0O8TRwN2hLULTYyuej3mfHqISFbzrYGxgVstFNn/nZnydPDcGNrk1m34yPDZPpVuG9IUcjB6wRZlWL0p1zbcawuvI+uJ5OMK2XX1mHpT3zScVDE6ifm95Hp66CcQDSJuk5nJYYjR6Z17yx8lJor3D9eEJ2W2DLJLBpk3UZc7+8B4nOrVUR1pcr9uNdy112VGHASjbDzAQfWjOajOZbe168sdidNxwLK0/I+fDWlGN9BWSl0NS6Gj/dCnhcET0Xxqw12qZ3Irxmqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757676301; bh=h1VXu4cusrsAmVKpjOf20nk9BSmOxu5xvGRN3Vaq8vI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ehAlZ5FwCoYGruSJGTIf+zpEqA9LN6EHWDR33ouZn8SW7LXuB16CFLLeLUJ6nJtlKljBXYcjZAZcIc5G1CTypzbeQntIOs2w3Ndz+j+gwFijOMhyK+DV8lcDLGiWozqQPAwDAKxa6XB33UB1S4H6S5f3NCRONQjkXWyYH5n08xdXyaDniyQqZXP3ifaUpWLbWI2kX/mLECI7aTjnt1lDF2MKRTLZUE8NX6mrSuInL7o3CJUmVACTIYwDk5W8OAiQgWfV+Insy1uRJ7Kvsdo9HLAoO+mxb7nkCGiufel5zrBCKdEBn+8iRUY/hxVmOs5ctzFQL5kNp7BHSgknW3SdHA==
X-YMail-OSG: sjMusMgVM1kbrsP_QoAyz0qrbkinPBdd4pjNcIpj655LT8OdKlVAtXxwLveG1Ui
 TnTGBZJPRiDkBWTkM1WWk0xYMpR7K0siOIAoQjs1uZcKy.bX9sIfnkm5evVOs7o7HVuAkFktk6Z.
 9tJYm2K3_hWqOEFoQKW9dUUOxmBIFJ3U0aY5ljNk1xW9C0TIfL7oCOtEb12mgujscXhszg3zBQ9c
 68mspQph.FYjZJzQEUtUKWwwPf9WnUxZiQ__TXKSqPO4e9xR_eqXU1EyZXMHpMEXbAx.JDYHRXx2
 My4iGgqXWkbkEkWLs3sKs5AL1IMaaaj.REEs8tyi.W7vcnWvSff8qmYfeZ4QC6GaR2SqeEQtpiPp
 L5ktNh7WN6pR8RrCYI9HhLiKc7FTOvBvva4ULOQd7LsdVK0OutTSszVPaksvHwRPAGAzVdTyYJjB
 bYlOWIn0SVQfKT.hzME.g55MlM8brQfw_P7GTE5CsLw081AifLb3lsDx7xXBwyYXeO86qZEEa6T0
 CDKsHWebwaE3l7lskRXXgeNVTbOQKebk6G_qkcbQjSsfYcWZm5a5QwW2pWsRGc7cWGMPIPYL2Krk
 M3FNwMrI_Io0aPC58QaVUDr.viOeXpS_iDPUS_xYdPt1nCOXsGIElb1TXM0QgDXabTkGqQVFLnOV
 JzL4wtNfkzMbZvHBabFlLDKKXeq6DqXmwbXFmSgmQ_E3VsGoJXp7.xvKJLSqziYmnGlXLXV.OYOu
 LLvyJK.Ch43eliiRNaKGU3AIedI4ntq_3y_x_cOovYRqnFGqgKd8qriWyiiXSb7PQ9VcxMizBSiP
 rAY1syCZx8y7.y1L5V4yv_Xu6XVmp3dzD74ZdSDTN7Iss3OHQwZlqE7GuzaYOIKdBi8VH33tLtlU
 sbgx8hB1aGaQJA5gBZoLN4mk19LIXrCTrjR7XHOlNgvvb78AP5IV9pokpceFTw9QpBdO4XCU57QD
 RcyRmIqAM73_cxzgcXsT0OmDYuzt7kNH7fFyB75Qe6E1Y2qjqklKpBuszaT2.3JljDOseNxhp14_
 ayfFgJKoaD8jo1cIqV4sYxLEVqvH8q6Qy6JQTayZubZKUC00qDvrg3lgr_BY27lXvbXNK6BWdg7U
 cyxZV6zlIabckIPyAM2cop1qfYBKAH6MWf6OBgbnhacJlFWDo2YjWKcfhg7d3LQ7spEEZg1kGilg
 rBWh.8y.zaRgzyYttVcFbTO726SJPRX2C1yKZL6guHDqpJaPmXL53LudDKJSVTN9v2vRh1vOiigN
 1x7JhzM7uGgyvWTIMA9jKc0RIt_qntZOznjfr1cKmLQfPXZRW0PSjlqbx5P2SHCPdXaCPIZCQUQk
 aHD259fHQTl0wfAdltkngYnpxey55U2GiYIOsXcv.WabBZFZe4DP_VSaELSuFw28_7cnKJZEwIAm
 YrGOVMeeO061qYrVEJJU9htTLIJcmbB1ArvSlSGy5C0B4d_3SeFxkqdGehXt0Z8I1rKfAvfPJ5xV
 gmNn8OcoCoPyZinCiH54nSrXL5xr5JwjBFaSGptWI1Hy0qNpS6ib8yUiCR4PtIQpLmjfy_ZWC1rN
 _eV5eDhmB7QqDY_aHM854dMi6KjHGzNfkodE7TWUEYJDHyd53KI0GZ.24ujSWB1qQaOJabQ5gJe9
 C1J3PZxTiwUHF5nZzaa7cvJvxfi1JEHFcIdhNCHb7kMLskFvXcWOQbaqF54_yIdnDeX6Dz9gr0Of
 49ZjchR_txWRNVR4_NvFXseoSd9FMHqr3zg6eQuoBueEo2Jliwr_xTGZILzL4Ns79RmQ7uurkOm8
 xEd.Mbjs5iGSdo_._uJ2a87iCoBnf8iEREb_9mIx88a4dxe137KH7H.leo9qXSKZFhWBBNqzZ.jA
 rGe.MMUz9JtJlTAqFGKhVHS3L0xAuTc1aOm2gEUObLacwTTGAKXRgbVqfkq2MOTR.UFKfH7qseku
 2DHLQzgBB8uUip3IoSG8v3gZCQ2kd31kapHZGp4gyu3HnVMO.k1lIvWwhJ9qYPRTzq0YfONfPggL
 RYjzzg8H0KWt3STiZMDxPSSK2S5_aS3RTVys4Yb3e65jhKpZENGVnUMgUa2J4lYzuMMcNrIKZFn7
 P_XPKTb0F32jtQxB8QtieMM45zK6M1Xf537sfIVnYdZK0i86dveN0D.SN.Gu59QxmQVn8Cho3P_l
 8WvFiFVzRgGLOATwyez5MU85.hRhteCIOiQnXywTGYFeaq3Ib_l0-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 5dc2c8ea-e83c-4326-a34e-d2b13ee2b719
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Sep 2025 11:25:01 +0000
Received: by hermes--production-ir2-7d8c9489f-pnggd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 93cda13a9625b3ea865113cded111022;
          Fri, 12 Sep 2025 11:24:57 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net,
	kuba@kernel.org
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v2 3/3] net: ovpn: use new noref xmit flow in ovpn_udp4_output
Date: Fri, 12 Sep 2025 13:24:20 +0200
Message-ID: <20250912112420.4394-4-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912112420.4394-1-mmietus97@yahoo.com>
References: <20250912112420.4394-1-mmietus97@yahoo.com>
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


