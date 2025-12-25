Return-Path: <netdev+bounces-246043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA86CDD69A
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC39F30010E3
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526C2D5C68;
	Thu, 25 Dec 2025 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="VDcmkbgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail59.out.titan.email (mail59.out.titan.email [209.209.25.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12454242D83
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647216; cv=none; b=EitbLLl1WsY2A/a997e72FCUvJknhT8+mtLa2tdO7g69KpANW2mgX4R2fFTEi79MS9rX3giDeYf1yMJJIxZub5RWl05CXIwp2H8LQHwO0p03JiYfiRT9pBoGXyYHROpKFMsBPZEV8WNBzQS4vALiLXmyajvR0kM7P0ZanGmf2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647216; c=relaxed/simple;
	bh=gKXZUtRqNTjlEZ/DuNWXKmVqHjTWsHOXuMJwCR60w4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNvgiCzcmUM+FUhgyeyf8w4/LQwYXywfwadOyRafrpqDXsNih6Lh36TKavJvTwLnNaDRuYgT7mqtH+XYIjV15w33ZJznKz/Cq6g9VKHMGwPIiAJM3k9UldfOwPOT9BW+Mad8c7RXrt5B72lCNT8n3LyhixrPx0bZ7B3CxEZwl9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=VDcmkbgs; arc=none smtp.client-ip=209.209.25.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dcKrm05Wsz7t9p;
	Thu, 25 Dec 2025 07:20:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=2Ji3Pl2L2zAVH/GS44GahuZhVODf8IxiYYafxPItiyc=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=subject:in-reply-to:mime-version:to:cc:message-id:from:references:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1766647207; v=1;
	b=VDcmkbgsn6gJS/ctEeqV93Ixe/+OD0yORQ2ieOFlLaUy0Pur/ZD28ya9+xgKbuwZyadpLGIR
	aZJYrpeyivV5HeU9MeEsj1mkZ9Jy1wSDdxwxQMYNvmFbp8ocru/giifRcWFVu8qHkpTuNYcIvVf
	DeCw0YMsgDNbu9A+y1sfhnh8=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dcKrf0kTBz7t7x;
	Thu, 25 Dec 2025 07:20:01 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH net-next v5 3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Thu, 25 Dec 2025 07:19:14 +0000
Message-ID: <20251225071914.1903-4-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251225071914.1903-1-me@ziyao.cc>
References: <20251225071914.1903-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766647207861936128.30087.4528525047229280765@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=694ce5a7
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=NfpvoiIcAAAA:8 a=QS5k1xlMZ-r-HGU3PrcA:9 a=HwjPHhrhEcEjrsLHunKI:22
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

I volunteer to maintain the DWMAC glue driver for Motorcomm ethernet
controllers.

Signed-off-by: Yao Zi <me@ziyao.cc>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dbf349fc1ed..a73a97716e00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17675,6 +17675,12 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM DWMAC GLUE DRIVER
+M:	Yao Zi <me@ziyao.cc>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
-- 
2.51.2


