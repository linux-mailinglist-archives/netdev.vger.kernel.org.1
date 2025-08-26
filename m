Return-Path: <netdev+bounces-216930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14210B362F5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D17E7C78B1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C52F9992;
	Tue, 26 Aug 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QlbLbksJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rh3fBiDv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F923F405
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214216; cv=none; b=npKp0PzPrwidY+sigL1k+OicREopr4oo5bNqvJYS31jHSRZT/ZaIgicVZll41cyN8fOFWFi2iATi466ZToRBV823ok4603I8VMg7bKSG/3tmaOWLwQePBgXcJlvAjNRpgWXFC+XQDJ4Wp9JSnDC7ufNONQyNi7m2JPqq9L+fw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214216; c=relaxed/simple;
	bh=F85/Wm6PbbYJk6RgAPV1sgjEm6nMlmvfK8nEPUv2zDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaWrTHuTIxcoW3bxQOgJ8ygMeVjm0ubuwshHTrO7D0kyd2E+AzB5pMYQM4Qs5LBAT7rJEUBUJr3uWMuFhDuxVKIlpzVN0kYGHCdHNtsdYE8e2bdajIQyjXhfxK/YQQuWY+3KN+nENlUquzGdd4cvVknbe3IVU5mg8efaxEbetvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QlbLbksJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rh3fBiDv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C645A7A00AE;
	Tue, 26 Aug 2025 09:16:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214212; x=
	1756300612; bh=/vX7LL5EOma/vPYNi1G3/bt9guzAulJ3XmNaRdn7yXk=; b=Q
	lbLbksJMKYXJNpmqRkvKJ21Ux/644X2+1zzilYslj1rk9cmjAlxbTrJLp8/pzw76
	uMbIWnJU16kS+A8w5lnUMP3gY8bOw0dg5uDOazbnWIrbMM94BXYBP/dRuKy9CqEc
	cjvCiFIFIoJxe+noO3nST+iFSRz0GH8xIkhVp0kQZ6MrPWQJNjoMkPZG9kT30TGZ
	qvofZT2Dfs+M7qqfsGL3yoqiIuXA+dgVXlUuMCj/cDklxRsGo6R2dmbtA6eCw5Af
	ngWcQIOOa+JvurBQe8lkYGgCmCfoaVhHSZnQvJ8Fl2rh6TwVWzjg0Wfuar4xcQ/X
	6ElN6FbOYXzPksL+F9ifA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214212; x=1756300612; bh=/
	vX7LL5EOma/vPYNi1G3/bt9guzAulJ3XmNaRdn7yXk=; b=Rh3fBiDvmbHUPuBqI
	7w/hGsdBNxhJasRWJCuvGwYGWnzslCdOQvCfopWyq3R468oCaXXlH5/i/quz5DP6
	1Xjwexut5fLh90UYjNKf9yLpmApGy8/6/WTWFnfvkH6llYbRWX0y1ZRSAQMow4E4
	BCzowvX2rQA1iCVz1xSYvx4tboBBDDRdQpF+cpUEzZdNIj5c5HHWzS7S772qrf+9
	YbgYdtIa8dIVsN8vWojZ0OApod2PxbKZ9PCwn/6gw0RNvFcwN2dHpDGczRSvcadw
	heAD5zcnsgDsod4/ZY6lVFhwe/PAGi6YupzD1psvYHydOYNYQwRHgWzPcCqZnnrg
	Xacow==
X-ME-Sender: <xms:xLOtaOfov4LrysGwzWL6HNDQPwQ82PrExAIsx3LRIJpZPOe6U-tw6w>
    <xme:xLOtaIaqMlL5vyCgpMVr1b3Sjyd7U0I593RlpEvjByvEKjDwiDeAWfaL1_SJwvLbt
    dbeKEj75KXhRkIwnZY>
X-ME-Received: <xmr:xLOtaBVIKRSn-T6PsM_yuLcGmxmwg3GceU3eY_5xYk0fgTwQ5s_oEivMg6tI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:xLOtaKgMeT_vsAytdr622rDEQMiW5ags0tgOadmAcHmM_WISSiQvAw>
    <xmx:xLOtaPU-YcAP7Ex4jY0Ibv1Zno5s0YJb-Yj1l6A2oAyt8Rl0eI5cOQ>
    <xmx:xLOtaBOfaKMRPczHFS9KIEkqFpFziBZyOtgUa0pLC33phcC4c6Zpqw>
    <xmx:xLOtaLbEzGPLpta3pjI0Wc57LDl-1khMsXeOXeY6zDLaazW_Hdr0EQ>
    <xmx:xLOtaBBkctLRNok7kpQD4gctPpioiuhB3wD72fXBydr7MVqcjKQ_0JzK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:16:51 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 01/13] macsec: replace custom checks on MACSEC_SA_ATTR_AN with NLA_POLICY_MAX
Date: Tue, 26 Aug 2025 15:16:19 +0200
Message-ID: <22a7820cfc2cbfe5e33f030f1a3276e529cc70dc.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 4c75d1fea552..96ca1b00438f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1583,9 +1583,6 @@ static struct macsec_tx_sa *get_txsa_from_nl(struct net *net,
 	if (IS_ERR(dev))
 		return ERR_CAST(dev);
 
-	if (*assoc_num >= MACSEC_NUM_AN)
-		return ERR_PTR(-EINVAL);
-
 	secy = &macsec_priv(dev)->secy;
 	tx_sc = &secy->tx_sc;
 
@@ -1646,8 +1643,6 @@ static struct macsec_rx_sa *get_rxsa_from_nl(struct net *net,
 		return ERR_PTR(-EINVAL);
 
 	*assoc_num = nla_get_u8(tb_sa[MACSEC_SA_ATTR_AN]);
-	if (*assoc_num >= MACSEC_NUM_AN)
-		return ERR_PTR(-EINVAL);
 
 	rx_sc = get_rxsc_from_nl(net, attrs, tb_rxsc, devp, secyp);
 	if (IS_ERR(rx_sc))
@@ -1674,7 +1669,7 @@ static const struct nla_policy macsec_genl_rxsc_policy[NUM_MACSEC_RXSC_ATTR] = {
 };
 
 static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
-	[MACSEC_SA_ATTR_AN] = { .type = NLA_U8 },
+	[MACSEC_SA_ATTR_AN] = NLA_POLICY_MAX(NLA_U8, MACSEC_NUM_AN - 1),
 	[MACSEC_SA_ATTR_ACTIVE] = { .type = NLA_U8 },
 	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
 	[MACSEC_SA_ATTR_KEYID] = { .type = NLA_BINARY,
@@ -1739,8 +1734,6 @@ static bool validate_add_rxsa(struct nlattr **attrs)
 	    !attrs[MACSEC_SA_ATTR_KEYID])
 		return false;
 
-	if (nla_get_u8(attrs[MACSEC_SA_ATTR_AN]) >= MACSEC_NUM_AN)
-		return false;
 
 	if (attrs[MACSEC_SA_ATTR_PN] &&
 	    nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
@@ -1984,9 +1977,6 @@ static bool validate_add_txsa(struct nlattr **attrs)
 	    !attrs[MACSEC_SA_ATTR_KEYID])
 		return false;
 
-	if (nla_get_u8(attrs[MACSEC_SA_ATTR_AN]) >= MACSEC_NUM_AN)
-		return false;
-
 	if (nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
@@ -2339,9 +2329,6 @@ static bool validate_upd_sa(struct nlattr **attrs)
 	    attrs[MACSEC_SA_ATTR_SALT])
 		return false;
 
-	if (nla_get_u8(attrs[MACSEC_SA_ATTR_AN]) >= MACSEC_NUM_AN)
-		return false;
-
 	if (attrs[MACSEC_SA_ATTR_PN] && nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-- 
2.50.0


