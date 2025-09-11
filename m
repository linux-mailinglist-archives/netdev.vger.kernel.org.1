Return-Path: <netdev+bounces-222098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4BB530F8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AE6A07B26
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B6C32252A;
	Thu, 11 Sep 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hOfDKkMm"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEF321456;
	Thu, 11 Sep 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590631; cv=none; b=pYIXerUg4XVfONQPlwFDrT0+N6Br6Bj73LkuceC83iWqBHh3SGOdvzRpA+oc5ssFulUjoBQLSywRMDiRzWdgie1jgp6LrEPtM5LZWN6rKkUy0UklAKqtbJfrF01f5hTJteM8Ys6Uyc59Y1jmXPK6uQGHD9JkvboXG78bjqtUziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590631; c=relaxed/simple;
	bh=f19zsr4kaltVZz4tiXmXoetEm2f2Hxlavoo5DtHjrPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r52JFribMlw0SdS/T1b3i1IBV2/tmG9GV8bXWDD1KGc1Fz+juPJgw3OaNfS5huEiWgtCQ/9QO5MY/pvWdYGjoBXr8rcGXccSeJtLrEj8mEzeK/nz0CFDHJht7oy4+Ub1wAFqzg9zT12tDkDn+7jMH7EzEdekP9al4oRfxRjFofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hOfDKkMm; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BBaUED793666;
	Thu, 11 Sep 2025 06:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757590590;
	bh=78saqbBV7l7amg+T7GZYrtVBXo8ffvbG+RF5wZUGKuQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hOfDKkMmxr580oGsCMt4qLsxC/JdOJSSOH6HAXjmH4wLKLlMk/EhVPMVUgwjQAovq
	 Ju1gdfKhxfgyemDxuACApHGu8RoKrW/C/8qTj0UqA4oUdIXZ3NuEEyg5jKr5m312wl
	 RSpA7jo9VlnvcIQfC8En1GqcVEJZs7PAuF+2BLD8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BBaURW1027202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:36:30 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:36:30 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:36:30 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BBaUha1015163;
	Thu, 11 Sep 2025 06:36:30 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58BBaTgj032087;
	Thu, 11 Sep 2025 06:36:29 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Xin Guo <guoxin09@huawei.com>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v4 6/7] MAINTAINERS: Add entry for RPMSG Ethernet driver
Date: Thu, 11 Sep 2025 17:06:11 +0530
Message-ID: <20250911113612.2598643-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911113612.2598643-1-danishanwar@ti.com>
References: <20250911113612.2598643-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add an entry to MAINTAINERS file for the rpmsg_eth driver with
appropriate maintainer information and mailing list.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3907f0c1243..9fd0f6a602d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22001,6 +22001,12 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/rpmsg_tty.c
 
+RPMSG ETHERNET DRIVER
+M:	MD Danish Anwar <danishanwar@ti.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/rpmsg_eth*
+
 RTASE ETHERNET DRIVER
 M:	Justin Lai <justinlai0215@realtek.com>
 M:	Larry Chiu <larry.chiu@realtek.com>
-- 
2.34.1


