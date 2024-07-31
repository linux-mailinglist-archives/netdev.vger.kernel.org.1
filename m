Return-Path: <netdev+bounces-114720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8394398A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF35E282C68
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE516DC35;
	Wed, 31 Jul 2024 23:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A814B097
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469982; cv=none; b=RgtwhNPOfje1SshhwPwfI8XmsE9SdqH+XPjQhSK4QvpHVDNBxOsNdDVUWUA8N9aZbsgFnStxOogkAM3hBXSSR4hniSU0uK6RnRPkksk6WooJkyp17B1D3B0F1HP2CpU2ZI6974R5iroYu7C0b1i2AMVgTvlWTAn0C1QRBaJYjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469982; c=relaxed/simple;
	bh=a9wqeE1U94c+w3UAW0UHYs+vm9vSTNg0xyu6UrgdDms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX0tcQ2FTywvcliZ1wEzkgfxWYydC/b1fTDJ54rGSm/dEJplDpsvB/ULCnxlLEDz+Yy2obBwJejDpLIhbBq+CVTxT7J+03i3VQJDWdldKolsyzZzuBNisIs0wEyvNPCgEhhRrCnBEiHxlB0zNZxogyR4AqcdhlKiOwZFZJBN5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 733207D052;
	Wed, 31 Jul 2024 23:53:00 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v6 01/16] xfrm: config: add CONFIG_XFRM_IPTFS
Date: Wed, 31 Jul 2024 19:51:10 -0400
Message-ID: <20240731235125.1063594-2-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731235125.1063594-1-chopps@chopps.org>
References: <20240731235125.1063594-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add new Kconfig option to enable IP-TFS (RFC9347) functionality.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 net/xfrm/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index d7b16f2c23e9..f0157702718f 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -135,6 +135,22 @@ config NET_KEY_MIGRATE
 
 	  If unsure, say N.
 
+config XFRM_IPTFS
+	tristate "IPsec IP-TFS/AGGFRAG (RFC 9347) encapsulation support"
+	depends on XFRM
+	help
+	  Information on the IP-TFS/AGGFRAG encapsulation can be found
+	  in RFC 9347. This feature supports demand driven (i.e.,
+	  non-constant send rate) IP-TFS to take advantage of the
+	  AGGFRAG ESP payload encapsulation. This payload type
+	  supports aggregation and fragmentation of the inner IP
+	  packet stream which in turn yields higher small-packet
+	  bandwidth as well as reducing MTU/PMTU issues. Congestion
+	  control is unimplementated as the send rate is demand driven
+	  rather than constant.
+
+	  If unsure, say N.
+
 config XFRM_ESPINTCP
 	bool
 
-- 
2.45.2


