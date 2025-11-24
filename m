Return-Path: <netdev+bounces-241228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67163C81993
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AA4E5E4A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AB2989B0;
	Mon, 24 Nov 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LBwPLgJd"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2A27F72C;
	Mon, 24 Nov 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002037; cv=none; b=W4VGbqn2GIgTHnSOhZR5GnSni1sg/m58onNg7tYyjsOOYAVXZKKWCh0EtSqZdU+1PCFEaYRPXMFX/fiyr3dsDdjMYdx8oHhSfsX+sPWUsdXcyAavGk4/3lt/YHP2TDBZVNOJNFjI6sAvX9H3swcB/L5liAcRBV7iC2eBCL9yQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002037; c=relaxed/simple;
	bh=LHwd6JrefgyWI8xExIx4u6Hsl73OaZYFYM9iOgoRhb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpsvNo6OHsQIV+J96f29ZKx4p6JOk5zb4WW4g/LdcnDt/ekMf/5MdEe6Qhj+FPoiuDUjOjfsDyOlQ6/BfLL9x+lOwNVZWWcA2GSrPVIbswe67pRfH4IQH29arI7UdcvMbsZgXaGPBPKvfl2RNOZopjyExTYQNC/lA1apYxYymDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LBwPLgJd; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8DB1E219D9;
	Mon, 24 Nov 2025 17:33:53 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gINJHskOQWXk; Mon, 24 Nov 2025 17:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764002031; bh=LHwd6JrefgyWI8xExIx4u6Hsl73OaZYFYM9iOgoRhb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBwPLgJd/lPJ5ibRonxzpIfVbrR2wvYlgKLb7c2GYMFPSdFfwnxoIpwQ33WbJA+OF
	 r1ZtjTzh8yeyldNWP1JSKfUcHXz04lUZMhjITpbvClDZgFcNNEUDt2qlB7CqmDq2tW
	 WQc7InNaModBKIub29HOI8GkccgQCzg2mprFuvs46u/nnjpRnrzRnXOj6pM17bohw6
	 mjaG3z/JHaJ0UlmH1Gj8m04baW7lUsD2WkVKm3/8xZ+ZUsrdYo9/eL26V1cfLN82Sz
	 633XYW2ubTdemhHJivXgtV386vQtaucTkJ/ZmFAWLBk2/cvBpdcff4ryLpcEtYwurZ
	 2YdFHiXpsUe+Q==
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
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH net-next v3 3/3] MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver
Date: Mon, 24 Nov 2025 16:32:11 +0000
Message-ID: <20251124163211.54994-4-ziyao@disroot.org>
In-Reply-To: <20251124163211.54994-1-ziyao@disroot.org>
References: <20251124163211.54994-1-ziyao@disroot.org>
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
index bc0343b10489..b9bbf39e61ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17621,6 +17621,12 @@ F:	drivers/most/
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


