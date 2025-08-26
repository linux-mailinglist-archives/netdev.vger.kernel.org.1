Return-Path: <netdev+bounces-216935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE2B362D7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD6E1BC171A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F923D7DD;
	Tue, 26 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MGeeJmE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUZ7ApJ4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A92BE058
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214226; cv=none; b=lTXr78Sg5DCemGsGvJKhmgpObNk0i+lZX+j3Vw1PdL9UZb7MVgh6KW0Txx1rfCpwIkUBIt1YxCT6d1/eJIbpa6eu/Zao3IEiu7cYIvvDlU7MSe7aIhIYUG6wPfq+ZcIag5hVdsOKO928rBEWWt/AwvG9Sh/hsygNweiHElIE0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214226; c=relaxed/simple;
	bh=B24Nut/jes6HhEYdPvmRLyE6JvbzAcHLJi8bSk9OSrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3LcJ61zLzKqEflaUgfXo4t1eAbwTXkk0VKxqRYOoPEe9igEF0Kp6dsQqjBsZjC/LDNZU3mo2lL0oE8aRscry5xmjI7Jb7EjswB0XF9Fz+K9ur6ZyuSjYn2rzIZp22fEaaLZK7Av9bbNy9YcQQBE+XAM45koer1B1kOn7o76oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MGeeJmE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUZ7ApJ4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DBC57A00E6;
	Tue, 26 Aug 2025 09:17:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 26 Aug 2025 09:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214223; x=
	1756300623; bh=VFfJcECVbtZALSuUfbUWL1VlgWi0VujYdaeoOAXwE9M=; b=M
	GeeJmE5wiRzF+u13sA5PKpSTi/UrtOtWhnaBabKInLwNDQP2wzhRyvqEcWLXzVbr
	E9vRVZDBM7MdaTEybOIbXG87BmZuaxbEulZr5YA+Im8kNPtbER/WsPi9H1yE2m2C
	hR3hY/oOUDCZ8Pw9aFRaoPoM3VrfFgYQXsdbG/bVyZkJMd7cF33zGTqe368Io4te
	QivAmhg+Z8dPyThYkvdPVgjl+QCLaKvYFEVTa2WlmbAAmwSTrgOPxMVrTx6PL9xL
	L3q+pN4hrSnLvI7sXO060+W4aRmp8iuF5A0i3y6kiSMO43kAfnTJTRNlkmzdV3OJ
	V2+sIuxNkmIzLNPjd0Rxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214223; x=1756300623; bh=V
	FfJcECVbtZALSuUfbUWL1VlgWi0VujYdaeoOAXwE9M=; b=iUZ7ApJ4Kz2JAUh24
	C/O3mHrAVTxw6NNLuTW0WCFSlAsxcrLGVtiyTTM1aYyJv9tEqoolQ9dwPx1vF/2F
	1MM7TVg9W9fl1bxNYcm6YRw3nBY+40ltA0TXRN7VxK/995ZXyd0/educQh4SIN70
	F5nYy1Z3fWxbsMx8TxZfEI4CYGUJDhLPuxqSmJiG7CFXCaJD3eRh27DB3/8oc+IJ
	fP/Ebv2UEarzpndqvwU6/H82IjsERlrtTMOvGF97CqKN0f0BaXsXNrcEYKcu9mns
	YmgGfmC6O35Fwwou1O9Ykuwx//BO1pX7coHYyPDWasM7MIs9Kh9g2zBeo58RXBXt
	L9/Qg==
X-ME-Sender: <xms:z7OtaAUZpM0sjcMmuEHpd23ZempADbVx2i5QVFuUS97eUYyal-9Juw>
    <xme:z7OtaEwbPpgOtsVFjc7bPtW9FouDA4bKEheCiOA1qIWBBtlMcJYI97XB7D7KPyEye
    kE-nFWTLDO_raMuzgY>
X-ME-Received: <xmr:z7OtaGMw4tinkaqWalyg2FQyVKpjHRLo_6c3lnlkQLhaznaTGuSGZ215kqZi>
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
X-ME-Proxy: <xmx:z7OtaN4J0u4cFNXM8tnmmSakVw6cjTGvQHvz8R3_P0LZBfFnUljDjw>
    <xmx:z7OtaPOSi57RDf_TROWX2YQ-1CE423i-GlYmPUOSUUmZ0SE-sIsP8w>
    <xmx:z7OtaDmWDPVv4mf0ubKc5SJ7eap4KTLtet6QTzpwaWOS03TRKPBVwg>
    <xmx:z7OtaOQjsUFZKYRTCpxcm-tnp6G6y5ZMMEIQfGkK0FL0pXl6P31ylg>
    <xmx:z7OtaC779prN0bmJ1_REkJ1qtHrUjRWNEc80oJdOSGWK9fb5o8CAyQ2G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:02 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 06/13] macsec: use NLA_UINT for MACSEC_SA_ATTR_PN
Date: Tue, 26 Aug 2025 15:16:24 +0200
Message-ID: <c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
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

MACSEC_SA_ATTR_PN is either a u32 or a u64, we can now use NLA_UINT
for this instead of a custom binary type. We can then use a min check
within the policy.

We need to keep the length checks done in macsec_{add,upd}_{rx,tx}sa
based on whether the device is set up for XPN (with 64b PNs instead of
32b).

On the dump side, keep the existing custom code as userspace may
expect a u64 when using XPN, and nla_put_uint may only output a u32
attribute if the value fits.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index b613ce1e3a7e..83158dbc1628 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1671,7 +1671,7 @@ static const struct nla_policy macsec_genl_rxsc_policy[NUM_MACSEC_RXSC_ATTR] = {
 static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_AN] = NLA_POLICY_MAX(NLA_U8, MACSEC_NUM_AN - 1),
 	[MACSEC_SA_ATTR_ACTIVE] = NLA_POLICY_MAX(NLA_U8, 1),
-	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN_LEN(4),
+	[MACSEC_SA_ATTR_PN] = NLA_POLICY_MIN(NLA_UINT, 1),
 	[MACSEC_SA_ATTR_KEYID] = NLA_POLICY_EXACT_LEN(MACSEC_KEYID_LEN),
 	[MACSEC_SA_ATTR_KEY] = NLA_POLICY_MAX_LEN(MACSEC_MAX_KEY_LEN),
 	[MACSEC_SA_ATTR_SSCI] = { .type = NLA_U32 },
@@ -1731,10 +1731,6 @@ static bool validate_add_rxsa(struct nlattr **attrs)
 	    !attrs[MACSEC_SA_ATTR_KEYID])
 		return false;
 
-	if (attrs[MACSEC_SA_ATTR_PN] &&
-	    nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
-		return false;
-
 	return true;
 }
 
@@ -1952,9 +1948,6 @@ static bool validate_add_txsa(struct nlattr **attrs)
 	    !attrs[MACSEC_SA_ATTR_KEYID])
 		return false;
 
-	if (nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
-		return false;
-
 	return true;
 }
 
@@ -2288,9 +2281,6 @@ static bool validate_upd_sa(struct nlattr **attrs)
 	    attrs[MACSEC_SA_ATTR_SALT])
 		return false;
 
-	if (attrs[MACSEC_SA_ATTR_PN] && nla_get_u64(attrs[MACSEC_SA_ATTR_PN]) == 0)
-		return false;
-
 	return true;
 }
 
-- 
2.50.0


