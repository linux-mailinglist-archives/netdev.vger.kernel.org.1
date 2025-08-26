Return-Path: <netdev+bounces-216932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B07B3626D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C54E7A86A5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0BE343D6C;
	Tue, 26 Aug 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wXP4ryMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RzsbCNOl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEF23D7DD
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214219; cv=none; b=UoeFXaQ3eRMcfkjTxqoPKQZPHpTii4toAlwsKZPWk2IIgdRWPcF4iLVRxN3IbJy9T3IZtUrBD45d4e2Fvb2YIu3q+u/OQzggdAWh8CyhlKcHkaXXBK0CcPBEEM7wvV5+vqBFNdFu0dgh5THNZ7R6FptDlSsOnZsQX3jb9u7X4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214219; c=relaxed/simple;
	bh=s02B6tThHdtupKKSDb/iMs1vi/tYvgkTi3rmAYQIYJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkI0NotWYppRzlduyrI31NaUf9ObQMLaX95v/wt1bQgZjbourZuI4gJqUpoQYZlXWkqw20RqodB14pPENxgsk8TpA/1QNOi+FA23ebo63m1+fLB7/mv7jbtf2oX/Wqu57l9qh//ulGi32DFj77ru0NKljFvz1TqZt+PftYBerOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wXP4ryMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RzsbCNOl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EFBFF1D00074;
	Tue, 26 Aug 2025 09:16:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 09:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214216; x=
	1756300616; bh=EGGySp3mGBkE5qQy3FNxhXMl46WaZ5QjHWCBRn4Gdk0=; b=w
	XP4ryMzeICrlWiCc68jMwWJr2P4YOmDgmuSD/LS8ikPjl6UuZYYeQaBc+kB4akz9
	U+2wws6b/1nGKANpwU3EZnu2TIE4SgwbZFvNAgRfH3vLLJAc8L3yBlhh49n/X+Lp
	HJw+MpA7gMLSUJ2C7AIV1s4DhaGtc4XdpISlMVWaLxRU8zYBvGsD4N1dGdcBKTku
	tCJsOPMqCYcvLReiWfplniVP6M01ipT6FdnH/uZPnrxR048A/EfbDerX3JU2BWbU
	/v0Yc/2DJA2j7o4Fm8LJ9Bu4kPfgoTlnzF0Upb2pfkXM91GJW/z7ytaIS/M8LswL
	zCZO3G+oeS3DIPTUH420Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214216; x=1756300616; bh=E
	GGySp3mGBkE5qQy3FNxhXMl46WaZ5QjHWCBRn4Gdk0=; b=RzsbCNOlIg6jXOR8K
	12n4uE8TOJAe/X+3tR+G1eEKpfC6aRpMe43ocPaptYgcC3PuUCN/tDPkX8K1WKZO
	cq6pVg9q2IpUwThxri9Op8+lwS8KRMs1+MyYhBzlqqaa9J4pE6xotiiwjORbbjNw
	fYBfEIlE6ipAtol6I511TgvDkfTL/R4S7R41E2+WJJAJP5vuBhfoTwLiFJpZMtHC
	qaRn/VF1bPeJ/sf0Al6SLOZYVJ9NmcmhIrkPsRjgPMz/O5PyJTiTypnCuEqIUvE/
	IJ21rxs2qJIgmkrJMEEZycpMA+kL3lHy6FOCWkT9kS00K95UJHEGDmRr7ICWj9hG
	DpldQ==
X-ME-Sender: <xms:yLOtaEh_jb4TnJaVli30pcA5tRXW8SagKYRjVxriBnmmJRibURv1-w>
    <xme:yLOtaNPXQj0EFO5rgFlGUgcKqwftE0wliG07_YS7sTA56smZLYMkkREMlugfr1ri3
    7wwQ84khzyDFO697WI>
X-ME-Received: <xmr:yLOtaN6_uzufV-qHXQg_JLEvuulA_0A9Tr7xoCVrGrecFtPAItaVHDkO8NaH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedv
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:yLOtaD2jwGsNvmDtH1cIHHKoyk0ugr_UzlIrxGyDfvigSMNoexqebQ>
    <xmx:yLOtaGY6gvPRF1obWPWbo2WyhtYR-cP-UKgo-se8oVF6Y14AAYUMuQ>
    <xmx:yLOtaDA0h9TqJNKazm4_-iqLR7_nnUSXzDWLqyV2yx2kPDHLRNLHnw>
    <xmx:yLOtaA9QhmTfetOU09w9FRehGeC-i2ZXBxDqbKWLTwsw_1uclZ3ufA>
    <xmx:yLOtaPG-l8YuG5muEE9od_bZHwqt3WwcIvbdflAekHA463uX-q0swXqW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:16:56 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 03/13] macsec: replace custom checks on MACSEC_SA_ATTR_SALT with NLA_POLICY_EXACT_LEN
Date: Tue, 26 Aug 2025 15:16:21 +0200
Message-ID: <9699c5fd72322118b164cc8777fadabcce3b997c.1756202772.git.sd@queasysnail.net>
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

The existing checks already specify that MACSEC_SA_ATTR_SALT must have
length MACSEC_SALT_LEN.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7386335cc038..4bff2c90ff49 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1677,8 +1677,7 @@ static const struct nla_policy macsec_genl_sa_policy[NUM_MACSEC_SA_ATTR] = {
 	[MACSEC_SA_ATTR_KEY] = { .type = NLA_BINARY,
 				 .len = MACSEC_MAX_KEY_LEN, },
 	[MACSEC_SA_ATTR_SSCI] = { .type = NLA_U32 },
-	[MACSEC_SA_ATTR_SALT] = { .type = NLA_BINARY,
-				  .len = MACSEC_SALT_LEN, },
+	[MACSEC_SA_ATTR_SALT] = NLA_POLICY_EXACT_LEN(MACSEC_SALT_LEN),
 };
 
 static const struct nla_policy macsec_genl_offload_policy[NUM_MACSEC_OFFLOAD_ATTR] = {
@@ -1799,14 +1798,6 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 			rtnl_unlock();
 			return -EINVAL;
 		}
-
-		if (nla_len(tb_sa[MACSEC_SA_ATTR_SALT]) != MACSEC_SALT_LEN) {
-			pr_notice("macsec: nl: add_rxsa: bad salt length: %d != %d\n",
-				  nla_len(tb_sa[MACSEC_SA_ATTR_SALT]),
-				  MACSEC_SALT_LEN);
-			rtnl_unlock();
-			return -EINVAL;
-		}
 	}
 
 	rx_sa = rtnl_dereference(rx_sc->sa[assoc_num]);
@@ -2029,14 +2020,6 @@ static int macsec_add_txsa(struct sk_buff *skb, struct genl_info *info)
 			rtnl_unlock();
 			return -EINVAL;
 		}
-
-		if (nla_len(tb_sa[MACSEC_SA_ATTR_SALT]) != MACSEC_SALT_LEN) {
-			pr_notice("macsec: nl: add_txsa: bad salt length: %d != %d\n",
-				  nla_len(tb_sa[MACSEC_SA_ATTR_SALT]),
-				  MACSEC_SALT_LEN);
-			rtnl_unlock();
-			return -EINVAL;
-		}
 	}
 
 	tx_sa = rtnl_dereference(tx_sc->sa[assoc_num]);
-- 
2.50.0


