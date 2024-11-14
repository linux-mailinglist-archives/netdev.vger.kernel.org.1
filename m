Return-Path: <netdev+bounces-144718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD49C83DC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3128792A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE21F5856;
	Thu, 14 Nov 2024 07:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265741E7663
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568395; cv=none; b=auRWIZP4pEU2wvmBfb5oP/W/50QRU8DJfF0F9ExbBb831qsJSlSiwt52XoGKJsO6f4ckrS1Ly8c9JtMX+9jdUQzmesE6cBhr8sDeB8Ag48x9+oRz7wUzxpErgTvOX3rK8x2uTadeWpF5cVphYQ59VKMMvW/CVRgBt4nzU9AULgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568395; c=relaxed/simple;
	bh=a8/vqaW0uX50yZryzxBJ2Zz1oZFtb94lbgHBcf3srY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIp+0eRqQWzsMG2eWL1KfquQ47qNhzilGKQYUIw4b3C3lLptUm0tsFxPe7FXvSF18zUOMvGZXtLw1Hw0tI493peOQJd/u3nqVdEglO9axTkEY1s2nPGs4Fa/bEKDXAf8CVU2PAnbsOodxMiBdwxrPWmgIIXuqP9qlnCdDnDOzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 7D0E67D027;
	Thu, 14 Nov 2024 07:07:29 +0000 (UTC)
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
Subject: [PATCH ipsec-next v14 01/15] xfrm: config: add CONFIG_XFRM_IPTFS
Date: Thu, 14 Nov 2024 02:06:58 -0500
Message-ID: <20241114070713.3718740-2-chopps@chopps.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114070713.3718740-1-chopps@chopps.org>
References: <20241114070713.3718740-1-chopps@chopps.org>
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


