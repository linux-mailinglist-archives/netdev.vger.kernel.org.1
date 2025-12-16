Return-Path: <netdev+bounces-244997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126CCCC4D3E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D666430CDFE5
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3834104C;
	Tue, 16 Dec 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="Hn08hZax"
X-Original-To: netdev@vger.kernel.org
Received: from mail123.out.titan.email (mail123.out.titan.email [34.198.80.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168C340DBE
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.198.80.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908255; cv=none; b=KulEuCKwaoXhP1glKEvGZfhvtNV/gOMFtJ019nQr4A/q7WgL5dYFvvMX5a/TYNDAQLZGdPAr/j4GLqdhjO3H2FOyi0fbNMkHqh1HbWMlrq0SfgO9PhL7ZPTzWd9iM+ZgmJSvyS4c5vLVbtwZwhmeJk5ihSDw4YlxUP2X9Sdn92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908255; c=relaxed/simple;
	bh=Cq8e88JiIvNizOWXEY4DxtIDVedONKmcD2p5e5rhajU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIbf9OFcbCKuwZZRfdsGPHDxPJwmdxnfblkFHAhdJnPiViBfIPfg/jOOuZk6QkOFYgr3+DeGrlTFymODB+uu/hRy0ZiMi9VjUYGaKmG3QRcx+UVylNmILdHGWwDcvSGekNObD8+1MOU6nq/ZjhShQ+F/8SwY3iYHalvt98MfJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=Hn08hZax; arc=none smtp.client-ip=34.198.80.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dW4Yz29nRz2xCs;
	Tue, 16 Dec 2025 18:04:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Kq1bEJooA3uMWxhU1+TR0ORYnkY1s/WzdC1SduHyG0Q=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=to:from:cc:date:in-reply-to:references:subject:message-id:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765908247; v=1;
	b=Hn08hZaxpBiKoqwVrbMn7TOrcjzAjEi4LEEJOIzx7DvgT/Xzfgf8fivcuB2hbIl41p1w7jiZ
	uYPQQZYIyeSvAHBCeTlHI0QG9GlEksNxto/txpkics1TZfHnujA93AgXNCfp1/koBFNXVhuyQXy
	IlR1NpVRdecKB5yLu1ir5xz0=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dW4Ys5Y4nz2xNc;
	Tue, 16 Dec 2025 18:04:01 +0000 (UTC)
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
Subject: [RFC PATCH net-next v4 3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Tue, 16 Dec 2025 18:03:31 +0000
Message-ID: <20251216180331.61586-4-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216180331.61586-1-me@ziyao.cc>
References: <20251216180331.61586-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765908247165786655.27573.7088989779329087934@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69419f17
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
index e5b1342ee2a6..1483c1071d16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17666,6 +17666,12 @@ F:	drivers/most/
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


