Return-Path: <netdev+bounces-216931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54516B36269
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABC87B0212
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27688342CAE;
	Tue, 26 Aug 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="qQMGyWKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Or1nD1a7"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2321A83ED
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214218; cv=none; b=JFPfwXa9y1VrVQIBFa5HpQhYxckuP+rcccWvCwoPmd7RAzI7Ouu+JWz6i6xvTvxV6VXs8n5AsXTghpre4skXeXr0OfZE79vwCEmwwuUUb0NL2rMalsTmh8BOsRgWWVBvKqacsafX3QvuXjGOJ2dDLczlUlE3qbxP86NdkyiDLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214218; c=relaxed/simple;
	bh=O+2ZM2DUnPb38M6cpkHeS6cXDv01ernEWZQlFoepw10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOgL1Oi64EqRkarnanOBt062lR12T0A4UOWjDIQoneFkJVGX5r9w8rJ9Ekz0FiJap8B7dl+0yYaulsn3C7MkR6xbGN+bqc/MnP/q3bFZtR5kQzzR/xmItlXD7B0RFPgY1/2DZRNtkYTsnTk5zBiwgAJ/J3hXrUFg2y+J0qrxnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=qQMGyWKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Or1nD1a7; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DD08C1D000DB;
	Tue, 26 Aug 2025 09:16:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214214; x=
	1756300614; bh=U/w29Sy3YnJ9wXMjgxGhAPsVNCdUwrnLqjoTLq038bY=; b=q
	QMGyWKtBZKmENZCN2q3thHbCL/BiWR3Q7nh16XOH9J2keNFCzK2EGF8OKXCOlCBN
	xhL+/VzrQmBsMnZOXCZPHZJWOAB0gZUGmjZbcof6DgXFW+QQG4N4WMsBF2dAlfyf
	K2Idg1EVqH1rXxKs3dPN54YrXRBBqKHhJl+Yd0mw+7clKcqAQERiBFQn8RLTaLzu
	/VTqEL8ZHCKOnST0BwP0gVMlYjCwHlX/yDx/3LnA6znz+cfP+2GRzbnTNBRSYsdl
	EjiP/ohLma40QsmXrd3xOIVox2lWK7/QTlypnJEOajLRztKPr9f8hlNBDC0WZVJk
	vsMrzuQ8sCIUT2dPOI03g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214214; x=1756300614; bh=U
	/w29Sy3YnJ9wXMjgxGhAPsVNCdUwrnLqjoTLq038bY=; b=Or1nD1a73lqfunEGL
	W3G58Ka+yzCgvH+dMMR5w+7u5h/kWzE+eYPdtNPd4YPgcnFg3WuJDMgFMeEgfeHT
	THPXYgdrNVkpIGvxcK4mPuGuD1CD1cYAo0Mc30dbru+WOzoLEoo2egBP3OklWSmg
	dkLcK4xeEnBoaiUjo5Z+LyGtxVfQsygijMIQeRA6+BLHvvc80cuMUi+lqAUcxMCu
	Dmbt9PKln1X8soP0Rkjpa7kBD92kL26yQlxdHlcMx7K5T9PywiZVHwyx72WJ6C/F
	CUnXYO6/i9QrA17coe15osPPJbgZTsCXG4Zd9Yo7SRDL/3km3ZiHsWw0CNPBy/go
	V/mHw==
X-ME-Sender: <xms:xrOtaKmU6nwsoeDAnX6V1NF1sf5v0qJ_ekghL81wBuwc6JhzMnOqog>
    <xme:xrOtaCAYhr-HBIENOvfqsE88bFoekH-t74-FeShFm1QgB6HsckiPzrNuP_ILBBH4f
    9lWkz7tbc06_bEBEPY>
X-ME-Received: <xmr:xrOtaKdOHyua9gF3u2JRi6ZRg8aQW4rXcMn7kYQsx5AXx7hPrihT16xIt8bK>
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
X-ME-Proxy: <xmx:xrOtaNIEubqLU8_bfyAsPxYVO-FFeX66v705eaEUdNfOtKzWDIaNTQ>
    <xmx:xrOtaNekS-bv8qu_3A4AWk7mNYODbw4qESaIa33cU-RSIhtC0eZabw>
    <xmx:xrOtaE0MF0gqyMEFra3vCnvAWi8jZR2pb4U2VU2sBn1ZDKtj2Y9Lug>
    <xmx:xrOtaGhiqzVDGFyfjKyqg19_3JNj-QeUbb8cJAnIxk6AWq5AUsrBCA>
    <xmx:xrOtaNIY-E3rI9PeTlazsbrznuJ647jGHeKw6A8csTDMSvEpOYuTONAh>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:16:54 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 02/13] macsec: replace custom checks on MACSEC_*_ATTR_ACTIVE with NLA_POLICY_MAX
Date: Tue, 26 Aug 2025 15:16:20 +0200
Message-ID: <2b07434304c725c72a7d81a8460d0bbe8af384a2.1756202772.git.sd@queasysnail.net>
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
 drivers/net/macsec.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 96ca1b00438f..7386335cc038 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1665,12 +1665,12 @@ static const struct nla_policy macsec_genl_policy[NUM_MACSEC_ATTR] = {
 
 static const struct nla_policy macsec_genl_rxsc_policy[NUM_MACSEC_RXSC_ATTR] = {
 	[MACSEC_RXSC_ATTR_SCI] = { .type = NLA_U64 },
-	[MACSEC_RXSC_ATTR_ACTIVE] = { .type = NLA_U8 },
+	[MACSEC_RXSC_ATTR_ACTIVE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_AN] = NLA_POLICY_MAX(NLA_U8, MACSEC_NUM_AN - 1),
-	[MACSEC_SA_ATTR_ACTIVE] = { .type = NLA_U8 },
+	[MACSEC_SA_ATTR_ACTIVE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
 	[MACSEC_SA_ATTR_KEYID] = { .type = NLA_BINARY,
 				   .len = MACSEC_KEYID_LEN, },
@@ -1734,16 +1734,10 @@ static bool validate_add_rxsa(struct nlattr **attrs)
 	    !attrs[MACSEC_SA_ATTR_KEYID])
 		return false;
 
-
 	if (attrs[MACSEC_SA_ATTR_PN] &&
 	    nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-	if (attrs[MACSEC_SA_ATTR_ACTIVE]) {
-		if (nla_get_u8(attrs[MACSEC_SA_ATTR_ACTIVE]) > 1)
-			return false;
-	}
-
 	if (nla_len(attrs[MACSEC_SA_ATTR_KEYID]) != MACSEC_KEYID_LEN)
 		return false;
 
@@ -1893,11 +1887,6 @@ static bool validate_add_rxsc(struct nlattr **attrs)
 	if (!attrs[MACSEC_RXSC_ATTR_SCI])
 		return false;
 
-	if (attrs[MACSEC_RXSC_ATTR_ACTIVE]) {
-		if (nla_get_u8(attrs[MACSEC_RXSC_ATTR_ACTIVE]) > 1)
-			return false;
-	}
-
 	return true;
 }
 
@@ -1980,11 +1969,6 @@ static bool validate_add_txsa(struct nlattr **attrs)
 	if (nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-	if (attrs[MACSEC_SA_ATTR_ACTIVE]) {
-		if (nla_get_u8(attrs[MACSEC_SA_ATTR_ACTIVE]) > 1)
-			return false;
-	}
-
 	if (nla_len(attrs[MACSEC_SA_ATTR_KEYID]) != MACSEC_KEYID_LEN)
 		return false;
 
@@ -2332,11 +2316,6 @@ static bool validate_upd_sa(struct nlattr **attrs)
 	if (attrs[MACSEC_SA_ATTR_PN] && nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
 		return false;
 
-	if (attrs[MACSEC_SA_ATTR_ACTIVE]) {
-		if (nla_get_u8(attrs[MACSEC_SA_ATTR_ACTIVE]) > 1)
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.50.0


