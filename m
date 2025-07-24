Return-Path: <netdev+bounces-209806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBDB10EF7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B951D01885
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5152EBBA7;
	Thu, 24 Jul 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aPfbNgHh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E52EB5C4;
	Thu, 24 Jul 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371779; cv=fail; b=e3JFNAvox/pA+/+S8MuKihRVrvLv8KSqzGuFBjJR0xM7heKFI0mHpV+glyyg9EutBs/XIcJz9NZzJJqG6UWWAN0eIZttzunCOwIfFF+hkqLRaOjNTLUyTGqGTY9kEZ2llHdyxMEw8yS3g+NlOEhEX0E8ZT59vBFvOm6grnlf7R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371779; c=relaxed/simple;
	bh=Ghruy22oWycOI0xT622I+ShgAKqJotrssYiL3quaH+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiSVhf8YNgvH0lL3DupG9uIaQkptkfVA/FqRdDuCB2zRhvHn7ZeAf+PS+HjisjMvq3xxa+6FiMEUfA3EA3sIVouN9wOAQZPhPi7Lq4mLXJcrLW7qVT/NsriSZ1D0jsJ2WL5Eb0ghzjadak6jaAOdnu952jW9G52cvjAOmEjSj94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aPfbNgHh; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpf2HS0JMlnYyaPNhS8OU789ikJ06Pzj5PEz+QF7QGJHCrIOlJe591G5sludoRbrhzSdb0iOEK9Km/KxMXUeVeOOKf33ohOMulkl55xXCNgne5lOHIVC5HOmNCHrSNJlXJ0I/NjyEQnV47okiwhhJHgSY2tZRmyzRPGlGrkYKbu/b1KCSoxWz5NGR7rJdJNButZLuyqIgxe4uQeACrnoCQ1LvU4MZg0yD/NADtmK95Pg62GaPBeiMac4zlY+/RKnh/QZeV1l8pGQf5hBEMSNshkcPdGtG/vUQMsG4/SAu74d+KagSPFPbhk0PC/qESfbw+TfHDA8jKHzFBNyjpm4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPGOWi2fIEKtqzZfN7o7wYhaU2JZTg0ipLRcDJ6uY9E=;
 b=TiBMVRUb0cpTdI1r5m6cESXblyN4im648P6r59t1ulo3aWwDdYKEx+EzXUmXIOHaOBKfem0jCQbbaRqVUOAY3tlqSJ+3LtkpKl/4YpyNAaHRn+63QEAesNa4yjFQv0K2NnjAaiXahMoVlyHSy5k2jLfTKw5Jz6f04Qm4xLzHycMiuKc1sQ/JHFckB89+zxgx60ztgwlqZlcwEbQr1VE4mHZh/HHZrdx2EAhzg6NZtQjntH+VcBQdSqB0UcOPNdlaXO22XsFRui4DiKfBv/oijZHaMq86BtbmjK1o5ehpTwzOU/rh5HHSZ6YjLJ20dv+yxhJop0uTQOhzE8xeBytNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPGOWi2fIEKtqzZfN7o7wYhaU2JZTg0ipLRcDJ6uY9E=;
 b=aPfbNgHhVi75AjF1xZckEy8t+3eCwbMmcJ8daGgut3S7eUn+oOU1AoomrGa27hw5LXRJokfFYhlF9odcvt//ekyU20rszS3X/20ku7t4T0C0r0mEHQfYr7a3jeb1pjkkrYZe+dUZT0Dq/roT+xdv8AYF0m3KiReT13dKItM0mehagxf6Z/Hv4MtoWATO7B35tQBWQtcL3RHUlZzq2ZFAE218nHu2ptMVS61DT8hgP5webL6s6xnv7EtcFY+ra+NkhAGwqyURumfLCDKeJhKuDX6p6J4zZtVOgOY21HqzoyfHA8ZY+5r4enepxtiqQ2W+MpXOB7LZYTGzCZ7l46ytJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 15:42:52 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:42:50 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit
Date: Thu, 24 Jul 2025 08:40:50 -0700
Message-ID: <20250724154052.205706-4-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724154052.205706-1-matthew.gerlach@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: c94c6144-c630-4be7-2c83-08ddcac8bf34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+8Nl88eMASGmAu1WYjBKoCX5t94Xb1uwFt5ROvFiMu5u6AKYDMxLTYByGI3?=
 =?us-ascii?Q?nbe/hIJ5t6+nFfftkhbMjuYhC6crVfkWhfy/YqeKIvCK1vzO/8QnbOYoXSMP?=
 =?us-ascii?Q?7bYwUDifKWkup9c/FpJMWwqNaujtWsB8Opc4Ft+UuhTKSkXBanVa2NMo2fkn?=
 =?us-ascii?Q?3WtScC3hNYOdD4QsxMdA+OFy0nrrNY4Fd5VRopxmKk++WxK7PNWuwjpd5XNh?=
 =?us-ascii?Q?VzQ42vlfH59pQ5hL2xz+usJ84klika1qxs5PvwJXbIxPHfxIQoLTtm+gQXvp?=
 =?us-ascii?Q?5+D56DrjmkUqg5oaxr6d9cubXqlqPOykfYh05PU+cWhWIxNqSsZaA/k7xJ8n?=
 =?us-ascii?Q?HepCGeN7741SeGHZe6YxuYbdu2lrlshcuwuNIu93R5lc1aRwlzd1ayWCI3ar?=
 =?us-ascii?Q?9sL7VGdQc60BD47BvKnQ7dAL00bw6nxt3DxCQUkSF5kB+cQTnAbnyfvJPmJ6?=
 =?us-ascii?Q?eHgIFy5WDExOr0r74rXRJQwakXWDQxEQI4Ge8J+9ytSJpkN4NRVMqmI7PVyz?=
 =?us-ascii?Q?VpEMwh3Gne5wYxpnPEfMSmd3dKMpVFjCWPDiYXYQGXhweAwkoqPjOCKfB+1c?=
 =?us-ascii?Q?nYmkBRqfryEe5J7AUIWcVJ4qQyPM4v0dXGJLnpvXzyt522Nbkcuxn2iSws9M?=
 =?us-ascii?Q?2bqOHb/gGQZmeryDRqhT7RGFdsQmkIcP/5nl0385Wvgy/OfUtTnCYmFynaUs?=
 =?us-ascii?Q?nK21yDGXhaZHM6cXKEni1R+B/jmTh679ByT+icWX8Sa304nyBoz2rEDxYJLP?=
 =?us-ascii?Q?+R22bOrUHCQKafH+VocnXqsM6vx4w9yTB9NPX4L0pgtUu+CDGK+yj41OT12z?=
 =?us-ascii?Q?2urCG8dNJamMbNYjRC7mhRrnktlBarQV3ZsYvcOXi5rZnxfQZmn1RfNdEBF2?=
 =?us-ascii?Q?/dRM1MIBbK2U1XPoB3nVQDF1oXcDB8n/8vvqaqPhe0VG5qaRSC3VQFeLxoyk?=
 =?us-ascii?Q?59cmdLQTrydQEcMIaYdvH/s/Em4CJCENaTfnVdljhXD9TMoXHZDxQPYt+oEH?=
 =?us-ascii?Q?mmtC8Xx6NWycWiJqU0op9aoQ9CnmKkdzYtHEx1EGgDR9j5kbJLkO6pfYhiIQ?=
 =?us-ascii?Q?ukA8rFDn1PCVG6Y1Za7Pxa2kmeiK3hRQCGtv2b+xlUGs9nfW/mNZAPEcQX4N?=
 =?us-ascii?Q?nw4Z4GJXhBJlidAdDWL66fpKJrY7nTBWNcd1uWJSm11cTvCwArLvfyxZZqdD?=
 =?us-ascii?Q?WOtVfcqiAJoTQ+VSziKCWLB7gAHP4Jz+LWo8nHRA2uJEI15sMpufOhl4JzmU?=
 =?us-ascii?Q?rkbu0jHUK6VKNV5PQhqIzyhicwo4kt+325V4RvyLkeD1CaLH82I93Gnz5Jj1?=
 =?us-ascii?Q?mRd64dYBtw4Yx/1N1Yxvlc8K5NtoiR2MmI/Ln3mnZpGHg0PUn3kZcGRZGBFQ?=
 =?us-ascii?Q?0eDk82VaJbNI5Anfy2F3mstpOtbVdmUF29lZ8uDm1afw9Xk5KnJmF3eo3QYS?=
 =?us-ascii?Q?K3UTVIuL//ykkP0hsTgYguJKB8qQAGmbxM1x5iDwBDGH5q/sUVfzQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adeBRcGaIuk1hCEd7dIt0dASRkowphXWVSJI3SBhYIy8RgnHsyvq5RjG+NQQ?=
 =?us-ascii?Q?EWCNBV58GVXRGDvqlVpe0/nqJF+eIqnFvb2D9wX19VPgaEHtve/aYJ9DF5+s?=
 =?us-ascii?Q?bGDankz03MDuY2YYBuZOf37VlkVuTbixhpaF7C6sx2D5BmU6aV0OOR70981n?=
 =?us-ascii?Q?zDj0mLKwMlCAlTo1dT3eSfhrTiKHA6p12Paj96Ai+OnA9C839oIehRSG0BAI?=
 =?us-ascii?Q?J2yTila/7bezzdwJk7zoeKe+7m/GvI+kMfZLf/SxskUiL8OyM/q1JgvzEBcQ?=
 =?us-ascii?Q?wSVMBK3NclfuI3yIHM4zrV7rscytVYCUzcPhSF57C6ibT2P6Hvj8tpbcVCC1?=
 =?us-ascii?Q?vuI5ejNOXexmy+PNWCNhjm1AyJsWfUcztvXGnp+0BZNpsJNxf3Wwpq2n0HKG?=
 =?us-ascii?Q?+qt9MGsQUC5kH/xzsWNWxJxS4CHZbikujTq7busEoz+G4yPXS0aFHHhKMH58?=
 =?us-ascii?Q?hPny/D2oY7mnYgk4wbl/H9weouL2lev50zRqdYsIXh0yLvtk/O4XkNZdWQ2d?=
 =?us-ascii?Q?ny3EMP434W+Y3M9o/Un84JWMCAx/c0tVhFIUouF/+JyGedHPlvcr3e8w1hMt?=
 =?us-ascii?Q?NCxTLv5OBmSI6OqLWNp2cvXgki+cl/5j6aDS3A1A/e4EazoR7+f+cdmBkXVM?=
 =?us-ascii?Q?JdX7mK/k5wKPZxngcvZy9rJsQR5n+tpbF3KGL0aBo95O7b9SxZftHCXnURiA?=
 =?us-ascii?Q?WIp8u7yY+iFsDeaPIl25vUXr4uMBrFSSogXg229OFgmPWCN9AG2GCjp1k67v?=
 =?us-ascii?Q?cG7nF4VCqQj3nzEldi5drCISGXeDWaiSCuFOAXrgqEL02GvUNTw07hJfUXfb?=
 =?us-ascii?Q?EPW2oCh+59s27BBsnyj3lmqOGttCR5D7qJYU+W0FfNtrTDJRFhFO7Y7teNfb?=
 =?us-ascii?Q?VXPjPpu39TkH6Z5KdcOK28U8IZNP3Pfh3Nfkq9LmCYKbpTi3OEpGGSHX7J/j?=
 =?us-ascii?Q?IQoFD9K42QnD5fNU/pfyslxIUApRcomNBmXYW3GxMYF3unJq1e+ax2Qzdbri?=
 =?us-ascii?Q?QetczL8BHU1dff0uMvkYA3eikf4rp1j5hMQJQS5TLRj8PGrGE7E2vZtOr3GL?=
 =?us-ascii?Q?95UMoCWHyn6HOf9MC6ea+/gPXlaoyYsfpEk42OZYYwZj+SDiOkM/+3Z5/4p1?=
 =?us-ascii?Q?d9Xuu3wrcuQ7j0fC7eIbjb5hkQmO8WBYVYx1mTqH8AZVECMzX3d4cy9ch+43?=
 =?us-ascii?Q?Pjq4LWzj746jqZAAbt6AP7NpuCoxbXdRmls1tffvCLPRAYCmoGhm4c4MQGmc?=
 =?us-ascii?Q?TwXSW8ul0IUFHBPwmexMrWrqE2dhUpPKiBKZG+oVYNr+7N605Nnkv5fkUMLa?=
 =?us-ascii?Q?dQSosPe3vG3IQntXFtdW7bN1XvJJ2HcajqO4/+TG5de+i1ASfVgHsIz6/VYu?=
 =?us-ascii?Q?Yhbss4hXJnhZVqwbOQ6lmDBGZU7650QmeDyRMhITNUeyuUd/oXcuHoERScoV?=
 =?us-ascii?Q?PIP5ozK4zvDqxzHPW9sY5ED2aCvjc++W5AEdno5gtQ0WYc4XVtNekJBIFqOq?=
 =?us-ascii?Q?7YaLCyeRfMZpyyGopXGLgisEHWsbZhIQyNAJwbZ58d4KuLPgkdTEn6qPDCLc?=
 =?us-ascii?Q?dzot7xC6fBmAVm9J38+RKOOCBGHmFcMenjd6PFnzs2cH1BcTSUHc5kQSyxdp?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94c6144-c630-4be7-2c83-08ddcac8bf34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:42:50.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmNBONWBNVyC895xufl1gl/mqGnZgbXKopUm1qOq95RH4qi9/zt8qhqnOTHqAcZu8BqTHxQHRl/dtIyLgNeSETtDXokzbw8qbRGwk3Ore2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167

Enable gmac2 on the Agilex5 SOCFGPA Development Kit. The MAC is connected
to a RGMII PHY on a daughter card. There are no RGMII clock delays
implemented the on PCB.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - change phy-mode to "rgmii-id"
 - add newline before inner device tree nodes
---
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index d3b913b7902c..e9776e1cdc9a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -10,6 +10,9 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
 	};
 
 	chosen {
@@ -37,6 +40,23 @@ &gpio0 {
 	status = "okay";
 };
 
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &gpio1 {
 	status = "okay";
 };
-- 
2.35.3


