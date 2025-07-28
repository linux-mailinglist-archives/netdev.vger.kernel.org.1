Return-Path: <netdev+bounces-210547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15300B13E11
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FF3168844
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DAF253351;
	Mon, 28 Jul 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AzyeVGRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B133gKJ9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538B26FDB7
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715888; cv=none; b=CiaTQcnNSduaoFHxj4F8RU1oFCWo0+I2y5xfNmCNDIDzhAQp46f85iIER0uR3KP69uA4KNtfFMaIk7u7UspcPKaflq6k01IP9i8mfUsOLORZzcwUVEbG9HRvj3SL417LyyPWEiXBXXkoLMyB3rTILGDzVRI8JER8D8FuBPEQeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715888; c=relaxed/simple;
	bh=3JWQ51Mbtx6LiDDhJaOcEGkeb7eRmJD84Zl1CSZYGIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/TUAeS1NWV2gjqirix1JE44njQ6BCvTzlh4CJHpmRFGRqPDz4VFjc1yvm1VmdRAOYZ4wsfepSIitu+7nKYHCaOH5zHIp+bfHK5GeUl2aXM/wZkEFhFZWnRRzsJ7v7AYxF6dsRKYKQ+NdIdk1jlu3891ZDmZ1mEdHd5Jh4V1J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AzyeVGRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B133gKJ9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E48E41400285;
	Mon, 28 Jul 2025 11:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753715885; x=
	1753802285; bh=YnyY12u3nUj0A0CNihkoM2jfWPu8RRsJ4/vNGXdlUaQ=; b=A
	zyeVGRr9ZAnUsGxogsu39f7SxHM75t9V/tklIzEn6Z4O9INv32Zaevv9RQXXDy6M
	s1o4E2h05wflXEFAuw7AOtTkGl8M+R2OFs8081JK8xnILn5rqQjLpVb0MjUgpRu9
	NjkygO1O36dqKltACMYwMvbDWT66tepWipK8Tvbv+OMVpCwqNJIX/2KhgiV4eoKB
	jKcC917TO02+lNr2Sxys+NMjpnLkjp/HRSiBxOKRJueOwuYuVPKzziyCIhIvooOL
	25/pz2KwHRqiDRjo+AwOGjgXylOTRTAqYDmrXLfNoUeGfG4HVklC0AuxBh4Nip9m
	zqOMURwbrwPn/3aLyechw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753715885; x=1753802285; bh=Y
	nyY12u3nUj0A0CNihkoM2jfWPu8RRsJ4/vNGXdlUaQ=; b=B133gKJ98e6WuJe6U
	j0mN2LOzKOFwmAIBDawR9DY+JUuVlDvTXJtoGFpHsw7h6WY296WSkR5T4Ip0mJ7t
	3SLnafHk/dPYoGvdmnQWAYpxWLrWWkGRQ5UMptwGx1xYYCI8+/SgIi7OJqPfwV2f
	ejaU2qmyJwdxW7i2PO4mQJWOfecrOxs/RW59/461xKTNBorzmkoP9QraXDfd/mnl
	mo92UZWBTBaNdC3klzTUblIbaMCwn716lSx+gg0IlZDxtc5D8lJZ3LiYsMCbjSv2
	DE3zPJ8l3yGptYpbFNePyLqDvJb/40/Qm+CcZeB1eYB7J3lBZ9yddJYG0gN4I6fF
	hamxg==
X-ME-Sender: <xms:rZSHaLQSt0_4PsTSLJOWZAnDzvE8ENuc4Zzu7lQLLkyKKr6ClZVnFg>
    <xme:rZSHaFMJdAo7zhSBshdItUxBzpi-_y6BeIft_0dXv3-E2otVSY2DvTiFTMGL0x3Ew
    KTKCd59vPdK1dw2UnU>
X-ME-Received: <xmr:rZSHaBT6OSoTCRaxg3f9XDcremgl6aOgQr4rOu2f6tYyE8xt7jOwvirZcmIV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfetveeuleejieejieevhefghedu
    gfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthht
    oheptghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonhhrohesnh
    hvihguihgrrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhr
    ghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtg
    homh
X-ME-Proxy: <xmx:rZSHaLhBQ1ojyJ-XBhrFdxpEjVeTovSuKRXwfKxTbHDQTFk7EBqlsg>
    <xmx:rZSHaC9qfpAq3M7Naazve52Ip27pij0SeRlB6_MaGKjlSNgAOEKKew>
    <xmx:rZSHaKHmlczbDIL8na7OhylwepxyeMqiLw_kGugQymg7-y1RCZ74NA>
    <xmx:rZSHaNncQQJANSdOatXKKUhJXLA0x_5c7c7UrEy6cyA3TtTAjnoQOA>
    <xmx:rZSHaKldpRZhulQ2fP7HNXA17tMJCKfVJV6PL4wsM2EmuEW5U0-lq-7->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:18:05 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check from validate_xmit_xfrm"
Date: Mon, 28 Jul 2025 17:17:19 +0200
Message-ID: <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753631391.git.sd@queasysnail.net>
References: <cover.1753631391.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d53dda291bbd993a29b84d358d282076e3d01506.

This change causes traffic using GSO with SW crypto running through a
NIC capable of HW offload to no longer get segmented during
validate_xmit_xfrm.

Fixes: d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 1f88472aaac0..14d39ba9a362 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -145,6 +145,10 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return NULL;
 	}
 
+	/* This skb was already validated on the upper/virtual dev */
+	if ((x->xso.dev != dev) && (x->xso.real_dev == dev))
+		return skb;
+
 	local_irq_save(flags);
 	sd = this_cpu_ptr(&softnet_data);
 	err = !skb_queue_empty(&sd->xfrm_backlog);
@@ -155,7 +159,8 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 		return skb;
 	}
 
-	if (skb_is_gso(skb) && unlikely(xmit_xfrm_check_overflow(skb))) {
+	if (skb_is_gso(skb) && (unlikely(x->xso.dev != dev) ||
+				unlikely(xmit_xfrm_check_overflow(skb)))) {
 		struct sk_buff *segs;
 
 		/* Packet got rerouted, fixup features and segment it. */
-- 
2.50.0


