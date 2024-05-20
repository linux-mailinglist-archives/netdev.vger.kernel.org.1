Return-Path: <netdev+bounces-97255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F68CA3FD
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67FE1C20FD2
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322313A3E8;
	Mon, 20 May 2024 21:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C513957D
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241856; cv=none; b=CV4rG9YomTcjGDDbAjiu7RlB8pWfDQtHhZiSKtdOLq2IRDtCIvMeUys7QG2OcofGpAiLwInzTGI+0GjUQfh675iu4UVPxBX2NLxgk+p/5wnBPCQ0EBpYyDdNV+cGeoAnCdTJv90Cd0t1LItfNTidbtDVW+NHJEdSZHVPTAdT1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241856; c=relaxed/simple;
	bh=xlUDq07T+tvZyjkJXCzpF9aAbi34XmsqnFaij7PDBVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndJuWpFIOPVEcM4AlfPNzvYdvhXFqI8wm7cnFGk2aAqTspNGGX0rQ04RXaPr6at9NMuVHFlnxVbNsesBFkf36zqdMSsK2JpiWEMssanjTtJC1ADvRxQwTXZUq1MU3c6FpTkGE2q4bhwOUqXKBaWGGuhqrWvtNKREIk3A5Va4zGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 600677D097;
	Mon, 20 May 2024 21:43:38 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v2 01/17] xfrm: config: add CONFIG_XFRM_IPTFS
Date: Mon, 20 May 2024 17:42:39 -0400
Message-ID: <20240520214255.2590923-2-chopps@chopps.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520214255.2590923-1-chopps@chopps.org>
References: <20240520214255.2590923-1-chopps@chopps.org>
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
2.45.1


