Return-Path: <netdev+bounces-237570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED4C4D3EC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4178834FB51
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFC351FC1;
	Tue, 11 Nov 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UQdH3Awx"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE934EF0A;
	Tue, 11 Nov 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858460; cv=none; b=fIE835SdALeTvoWw4wlGi9IPTvc1T29yHRYabG8oCZ7QEljIxmLAF9CbZw8RshF1uLAm487wmlvnWhYDmNA3A5ci56AQPp7vNHpa1I/vTGBjTWdNMc0oCbvaSXyMUKJPz8+l3O7zmUL9+Xz3rXnkS7V2Mys0OzYqnlRBDVtEnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858460; c=relaxed/simple;
	bh=fOoRk5pYJFVJNCXLLphSPxJWA9vKkuaB1E5P1bzsu2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2AEZCJwaRpuI35aF2kQpWZfmfMP/42PPZ2aBkkSLOOmH+hO3G1042ynjBtINmfByRpe3Od8uI7nhBoFAzr9wdYEaS87G21pLpGrDd55N4kNwStzjzhXW1xyBAHWJtVrBiX9UGEiAeww9qyMXyl3+5ggVU4LV+8xGFhiht557Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UQdH3Awx; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 074B022D94;
	Tue, 11 Nov 2025 11:54:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgxASFd3aDV6; Tue, 11 Nov 2025 11:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762858452; bh=fOoRk5pYJFVJNCXLLphSPxJWA9vKkuaB1E5P1bzsu2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UQdH3Awxb9j3sWRxi2VlWNN0HUTiguirE02jO69CmAnlTJdkCFqMEh66zPWo8qd46
	 P1asl6D2PLoghtnbii2uFgHP2kADkHpk0izoAURVCXDiLbuMhf2JUcuwPjgIBljpxo
	 lNSGp9suTosikEb/A4vLXB7zqy8w9WqQ3kbOqcQ4hXJerom3zCql3FfNOgbOFJbL9T
	 s2Qz0ZNN+xqip+4m7qeM3UCjNuDSE1hEEfbZpVSkCUWL3NuVKNZKevYFv65OkCDrxm
	 0tyPt8T1FotXWm527bZnEv94X1wcbYJif2UWcYWpsAavXfOFOPqKtUPh5StHtEmzhu
	 ydSWPVQTPslCw==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Tue, 11 Nov 2025 10:52:52 +0000
Message-ID: <20251111105252.53487-4-ziyao@disroot.org>
In-Reply-To: <20251111105252.53487-1-ziyao@disroot.org>
References: <20251111105252.53487-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I volunteer to maintain the DWMAC glue driver for Motorcomm ethernet
controllers.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e2c790126fe..dce5c589a1fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17548,6 +17548,12 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM DWMAC GLUE DRIVER
+M:	Yao Zi <ziyao@disroot.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
-- 
2.51.2


