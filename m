Return-Path: <netdev+bounces-148407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D159D9E1656
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951142830A4
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C11DEFC0;
	Tue,  3 Dec 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="amcobkKi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DC1DE3CE;
	Tue,  3 Dec 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216006; cv=none; b=NZCBsfHWOUT1bqNiDIQm+zsXCAKPmsJIgN9PMfM4Jb0LXFn5ZlrC217j1N1FCer58muOaXzuxquxkGna2ks345k9gxrCCRBRW2/D1cPg/aYe7OKv7MevzGeuZRedDdiIpPaZw4GeVg3c0eLMFR9gPe7kaVQh6kof4fQ1swO0cl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216006; c=relaxed/simple;
	bh=OA/nV2yPoFw2d+CvBeaMlumBuPI9T3l2MZw9NSNqfto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryckWI3z2FdDIVe1cl9dl1M4UCYBYvDuJmrGAFxfhNnAwROrm9MU/8jol42kBlBDZB1hqjT5+wDikndevOiTJ+EQxDz+dQ6XEeJlXw7msQy2UJZmoUUzbQSko0TLBky2vnrSj54MIE4Ev3eDBCNUlj1abGwBJByYkgL11nOI5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=amcobkKi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733216004; x=1764752004;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=OA/nV2yPoFw2d+CvBeaMlumBuPI9T3l2MZw9NSNqfto=;
  b=amcobkKiaY519FB9PTOuVguT+Sv/ncc0QtOzGfHlWT46M9o5k2hipmEJ
   n9G2ILu4x2p9OLFt73fuY0Plc00qb81T7B8+8bZKYc248Efycky4pf6vt
   hj7GF4i/cZD+EJ3JkPcUBLDkDjO3s9nSRcnSRlifvEwPhCu/bg1OJlRyZ
   HZPB6NIshqfEYYkdEPBHY1jjleBALNrJ+F4HPgkNsAJIOGr/g07VW4eup
   63OJ8rLWH/X5oh3KIM8kmqScRi5c36/Lr16OSbCpKMOyKaK3MxgrCWYNp
   bQJsB7kXa1xUaslR0+da9qPas9ZuaJJJXbN2B309UDpI6oK0Beq//Eulb
   Q==;
X-CSE-ConnectionGUID: PYHc5D2VTXmCViyiEXibzQ==
X-CSE-MsgGUID: YMRgXJL/T4ecxtHMKurBQw==
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="38706054"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Dec 2024 01:53:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Dec 2024 01:53:09 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Dec 2024 01:53:05 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v5 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
Date: Tue, 3 Dec 2024 14:22:47 +0530
Message-ID: <20241203085248.14575-5-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241203085248.14575-1-divya.koppera@microchip.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add makefile support for ptp library.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v5
- No changes
---
 drivers/net/phy/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e6145153e837..0a19308dcd40 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MICROCHIP_PHY)	+= microchip.o
+obj-$(CONFIG_MICROCHIP_PHYPTP) += microchip_ptp.o
 obj-$(CONFIG_MICROCHIP_T1_PHY)	+= microchip_t1.o
 obj-$(CONFIG_MICROCHIP_T1S_PHY) += microchip_t1s.o
 obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
-- 
2.17.1


