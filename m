Return-Path: <netdev+bounces-141833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9A9BC81E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16F71F23AC6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3581B1C9EB8;
	Tue,  5 Nov 2024 08:38:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65CF19993D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795910; cv=none; b=j4q4jkOGvi0p83iJBXB3Wwi7BVhQgB4DuIh+8g9patmgGOTZhEoZY0RHzIMWIyUazXLapzd3TJii/mJutrLl1I5s7D/ZVTHpSRar2EplRXsX15IWR1sJY40fZ1eR2JiSA//vqLcb8PXzxxBfj+RIqXUaFwzGBjFV6RYdKHlmrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795910; c=relaxed/simple;
	bh=a8/vqaW0uX50yZryzxBJ2Zz1oZFtb94lbgHBcf3srY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u60o5Ki8FPUZQepNQqnlgs1MlLnGHnXz7r4yOah/rQyS4s6vsK1Tl6vLTCLACkfVPvzAOw5hdR1z5A/++tKq2aojinI94WmZvZUGEFqzYr3X3RuMscmySGavKzVAd7g18giuhYMIHQwJ+GGB1JXcP7XBFaS6NAqA+RNsEdrsLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 9F2677D11A;
	Tue,  5 Nov 2024 08:38:27 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v13 01/15] xfrm: config: add CONFIG_XFRM_IPTFS
Date: Tue,  5 Nov 2024 03:37:45 -0500
Message-ID: <20241105083759.2172771-2-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105083759.2172771-1-chopps@chopps.org>
References: <20241105083759.2172771-1-chopps@chopps.org>
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
2.47.0


