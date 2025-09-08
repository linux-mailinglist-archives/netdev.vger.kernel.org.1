Return-Path: <netdev+bounces-220754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C29EB487DE
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C76176F38
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C12F4A01;
	Mon,  8 Sep 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fgy9AHse"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEF1E1E1E;
	Mon,  8 Sep 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322526; cv=none; b=A2xmYHHZ4pOKvW6c8PZg+CWdd5HJ1ftPj2S1vUoVAq9tmG/Jxvq1VJ1mCfK+P8kOHs0cgaaMOosIydWyUsJKGwJxwlD6U3Hky6d4m4oflGmjw0gq9bHhuxnuVbt4skJxW3WUs8ToQEoBHjr6Smh84WNk8pJePykX4O/tzBkNuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322526; c=relaxed/simple;
	bh=pxCk7XGN3L7r9ZczqLXHX57qOG+ulO27ydJJwfzrxKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/uis9g+8QlQyv9e5btPnrxrmDmFednTCNWhGn9RNowxnMflMthfzWG6UN4SwV3G5oq6QuOciQGrg1kxNnQdP47pxLh/sulJbcDq8woZZaHDe8c9t1DOy259RIKPCMOca1yPVuqFnoBaFhxphDVi1wXxsAB5CBK4CkOnB9UPeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fgy9AHse; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588986dc071994;
	Mon, 8 Sep 2025 04:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757322486;
	bh=WibgegTqo+WJ+bFaRM+5vscvWKwWpKt986Uxz6u8MQQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fgy9AHsekO02wFnSIM8AfzFYvbHCdXufrzVAIH9/VtA69wnE6SKvxLyvKZsIYOUYw
	 T+ZIFlqFsIvJ2lJmBHvg42HXOqY9DjHl+5MjHkzo5yxMGNH+An5O8HA4kMfDGtS4cr
	 J6Zmr/ggYy38l+lDG2M0FN2ZDjf9bNTPZHUe1CsI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588986043666698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:08:06 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:08:05 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:08:05 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588985Eb2298756;
	Mon, 8 Sep 2025 04:08:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 588985f7023054;
	Mon, 8 Sep 2025 04:08:05 -0500
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
        Luo Jie
	<quic_luoj@quicinc.com>, Fan Gong <gongfan1@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 7/7] arch: arm64: dts: k3-am64*: Add rpmsg-eth node
Date: Mon, 8 Sep 2025 14:37:46 +0530
Message-ID: <20250908090746.862407-8-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908090746.862407-1-danishanwar@ti.com>
References: <20250908090746.862407-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add rpmsg-eth node to main_r5fss0_core0. This node describes the memory
region to be used for rpmsg ethernet communication. The commit adds
below changes,

- Adding new reserved memory region main_r5fss0_core0_memory_region_shm
- Adding rpmsg-eth node to main_r5fss0_core0 with memory-region as
  main_r5fss0_core0_memory_region_shm

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


