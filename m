Return-Path: <netdev+bounces-222097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D7B530EA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13683566440
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE0321F40;
	Thu, 11 Sep 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="csaVuRTW"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF321442;
	Thu, 11 Sep 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590631; cv=none; b=bmAsKvTNjm7bELpuPflnDZJXTJ5PGArfI8S4tiAlGVYBOD3am5pRHFqH08fWlWWsRuQkh83jDhmhD/CXw5dHLTtawKokTiZtg8TYDCiZUeFWqbZ28SykzPtxXOoHEZicZg7dJOBuQhQohg+5pfSvyDHMFrMbsbJMxP0N4CYF8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590631; c=relaxed/simple;
	bh=uCqh6weCbxxwSYUyrSLOci8g9ps7pnde7H7nW1y6vTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEZPSdLHHa+q08l2rKx0PbgdNx1yuuAMIfl59R4y2Y4zfPkrBFIyFRfWIY/2D+jtnEe88EXmiHN4mIqEN+HgtRqBLhODA+N6MQs+AyViPiOmGgKtkEX34/GEPdRPKfc+RYEacOS5u/6Nokb0yY+CfZxLFj7TqXqI/DDoHK2uyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=csaVuRTW; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BBaWZ0793678;
	Thu, 11 Sep 2025 06:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757590592;
	bh=zRsIr23BIzgLzTmL8Py68DcXdNh7zzWEy6t51VP+4LQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=csaVuRTWANMjTWvJzA+8pI34HZcinEHvdvvHBq/vPXeimK0ExgheZbJ59jgLUQuha
	 CiSgL0fBWumCz/N0hclO5oyHkHipU4+gqZC5cgeJuk3jMJGiR0oN9QHoK8dorJQzvA
	 NaVcgiwywP8HPeQLU/wowrmJrcrZwOnNtUEDo8R8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BBaWPC1027214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:36:32 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:36:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:36:32 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BBaWWU1766328;
	Thu, 11 Sep 2025 06:36:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58BBaVFh032092;
	Thu, 11 Sep 2025 06:36:31 -0500
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
Subject: [PATCH net-next v4 7/7] arch: arm64: dts: k3-am64*: Add shared memory region
Date: Thu, 11 Sep 2025 17:06:12 +0530
Message-ID: <20250911113612.2598643-8-danishanwar@ti.com>
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

Reserve a shared memory region for rpmsg eth communication and add it to
the remote proc device `main_r5fss0_core0`.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e01866372293..6e8e2c39146b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -61,7 +61,13 @@ main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
 
 		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			reg = <0x00 0xa0100000 0x00 0x300000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region_shm: r5f-shm-memory@a0400000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0400000 0x00 0xc00000>;
 			no-map;
 		};
 
@@ -767,7 +773,8 @@ mbox_m4_0: mbox-m4-0 {
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
+			<&main_r5fss0_core0_memory_region>,
+			<&main_r5fss0_core0_memory_region_shm>;
 };
 
 &main_r5fss0_core1 {
-- 
2.34.1


