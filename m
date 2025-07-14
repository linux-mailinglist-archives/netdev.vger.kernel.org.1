Return-Path: <netdev+bounces-206742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C6B04413
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0763F1891435
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1826CE3E;
	Mon, 14 Jul 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sFCLANpL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F225D21A;
	Mon, 14 Jul 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506754; cv=fail; b=ovtYAydoQ90+RFohRfQuAxHuU0t6mTPghmlCvntTm9+NYBrSD/itKP3pjypg876rluDIGxFZVY+aI9e9nTrVn7JSgLpyrkfLGCVSBsoRaGEmHt7ZCbcbjrtiIUCeS7kgfDHsNwCR8leqjPiM7fe6EeP4x9Rg1p09+7SrxE+wDMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506754; c=relaxed/simple;
	bh=FylIXG8tYjdftEAqLd4HAnx4ROGWUsKvd+fvfqTVDSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7/8/VDToQZQ6tLMQW0ciAOP6a3VwTCHQJ9CJix0xg0L8KFfteGFLmaKo/pCSsniITfV2yOvdcGmD9lxNbhQ1chZSezq/TVRWuH6N+iUEva7jC/ygvXMA4mzGOFpAmy5ARt6jfoeNjBoNeNpibsw7jIPlGfkqKcyenaG7NAkcF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sFCLANpL; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKdTyfO03BtXMvOo2gcI+7NqcBeKRjnGUHfHSB0VTyaNcqlcMeaycuuLRV119pD6rqDZKTPfWOZRF5IYFml2jMEtJgCPSmPTIUbNcDcdLu4X3qVG0LjeSX+aLWxd4OV77/256yG4Jwi6zTpORUM0BAIbFMlVSjmAWkmiOdamxvg805RvagJEroX1vnQUk/x2izJXFB3I4rKWClv9zhKtPnPSJ8Fdyz/uoWrR4Q2r3oTBhEvCnUi5kljS599sXZzSnwRHoCWzUvOOdbTmP+FpT0jV+2+tEln72teiDuyzJoaSM/wQY1bXK8Z/JAABPgRLYrW1+F17Guicyj0XeNS28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L62VDmE2Y8VOteGabwKOQEKAJijpTK7K0NWj8PiK3rU=;
 b=yZxIu16WWosOfRs00Nz3VtAFsxWN/l8J/L+bmQrhxzkqgfJXwYTI961WrKzaReCCaz0JRdC6wnDlpmto0pmlm/ZP5/IUWDKTUB/LM+S5PrW9s3vgjk43sMs/xx3YNYelW8C5JZDOoN293YujSyngSJ2sDOvJsLtkDuKw++EPsmJqyrs/f915sZr4SfWvC/o8lW6qJL44HqySgHfnrsLT4gabsI4i3gfLx4KEM0ZXopXja1hbESPpj9xZN9lDDa9cOdc7tn6QZTgcXuF6bGpj28lqWnYvaUayzcnRhIDVY4nfcqY8wt5TXm5YfxtqjxFyvY+mNH9PGTRDKUcBjocQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L62VDmE2Y8VOteGabwKOQEKAJijpTK7K0NWj8PiK3rU=;
 b=sFCLANpLMg8Y6h6CgjDLjphz5qXcLUnHd9x3SnuAGp6ZjHhHENintpVL5Hj0ztHtPJ3rmaqFk0rEFdK2zGbxMnf2TlgqWLunns71Ch6M/xbrCWryZ+gr5hKZcSryKKxk860WCNyktp+kV+7ckdJm51uthn1/vhacA/rbyxRD4e0dxe9i6KQxZTvuneQLQPmtY02Va/HBq6JT1FmvvAM+O+/OJNQ9eRAxOAq9zzyAwieKHTDTk3bXiim7JdWMAC4SEMisXKIDpwP/fhNuOLkDrOm2wBLjIMbPCSgfC2/XwsSFiLIeyRGBc4G1m05jZsvIwmTqX1BYXAJ+4BURQWrmgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS7PR03MB5592.namprd03.prod.outlook.com (2603:10b6:5:2c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:25:48 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 15:25:48 +0000
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
Subject: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit
Date: Mon, 14 Jul 2025 08:25:27 -0700
Message-ID: <20250714152528.311398-4-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714152528.311398-1-matthew.gerlach@altera.com>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS7PR03MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e4387e-8c86-4b91-7824-08ddc2eab59f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1vkoMHw3wor4kqqyrpIlci1LcpyKHBO7BwptECOmOKGKo6mQdFTG0mJ80T9a?=
 =?us-ascii?Q?RLikr3Sd3i9LasKEbCRhmq1LKMmE/QjHf0oN6VENDp6qYrRrfN/IEAbw+ne+?=
 =?us-ascii?Q?43UwgiR2Iwqf5RWc+PG+/cKWrKqgfaubZCTQ0mbv5mGDoI4Szbv/FkKg4EG6?=
 =?us-ascii?Q?lf+XzMm1M2o3+Egmo/fF82fGIkxM7Yk+W2DYVQ45MCZIhAxo9DHfbSMHAa4l?=
 =?us-ascii?Q?vyDfCpUnh5BcuutuBKLoJlXPdtUiT7dHf2lPqJRIGzMxc8fmwRD/65D17jAO?=
 =?us-ascii?Q?12++JkaXjas2Dvr6iRFzq5MvbSX44bRHmJePz8kxHdfFUWg/nV8ApBB9fZnV?=
 =?us-ascii?Q?D85y6v8HXcVtn96hkcIkTnY8Q/+w/jJgs9nXcuT6faLpzC//ZgkQ0ROkUJhE?=
 =?us-ascii?Q?8+ZlJJjHKEgOcH21hffPZwJ1TSasB7Rzvik+F2etj6g9FJSkZNl7vMGWiPU4?=
 =?us-ascii?Q?ez3CZyvmeC4PyeMdnc+WMlRPMBrD3eYzZgFOo46leG+YGl2TteFI3q3IuVT9?=
 =?us-ascii?Q?ACP2DKJ2bF8RlFsEZeS40LOkbmdw231X+95KrjufYB/udUoDhUGJBOMhTy2/?=
 =?us-ascii?Q?DVZFpaCAn1BheHAEP2kEnfoXb4WaYqmLCCXJSsjd13sgxNkjRLImb/SVkw+u?=
 =?us-ascii?Q?jOe8AsLVFv6YQRikCf/9i/pBbkiqipUIlqsOppRJ8/zuE5IeKHmUMTpeQhEG?=
 =?us-ascii?Q?GDt8H7JeKJa9WNSYO6Gh+1t6k1NRfBOv1fJzuKhHChfm9SEx+s1m24yYGxXQ?=
 =?us-ascii?Q?s+C9zN87FjHa5fYj8nqiN8adilt3aYT/XppsmJBx8WOVqqIdYBwuJ73dndZO?=
 =?us-ascii?Q?/0/IvqRL2n+DmY5jvoB0aQ8nDWHqFpHp6SC0FMsXtjUr24mPJF0AOe0KNzam?=
 =?us-ascii?Q?uXqe/xGHYWNi57GxV08eIXor8R78Rza9dM4aBY28Nx4P8ksT3s24wMy2ljDc?=
 =?us-ascii?Q?3SMYYDzTdju2u514IRWVm/yZcTG2RJ1Uj+r1M0x+H4z0rRHHXYm/x6jmZbIb?=
 =?us-ascii?Q?EdWefp2YIMWycuKvtuKRM5DfmxvMYnQLdBxNi6DnPheQKHKd/Z2Tzl7I9+ez?=
 =?us-ascii?Q?N2h3dzGYztBj7OKB3ROQrbY15yDrWXDcVJlTtn69iB+ohxRDjxlzOFjnDbzy?=
 =?us-ascii?Q?xk7TT6yuw1etPLuiwBy7+Jc3eklCLgqhIr80a8RTVEeZRDT4tYQZT2f0D0MS?=
 =?us-ascii?Q?9D8J+eG1ya5+RwP5vFoLS22eL6POs61cA7mdVCwbHj2ObAZnOjgJpvSeciv/?=
 =?us-ascii?Q?K/Jn5jGjpsoIX5ObQQKmEt7dMWwj4Z2S8Tos3wxcW++hBRDHoNznrvuSBA5m?=
 =?us-ascii?Q?w9Epf/vF97HwngdYtKm0AjImZivDpGwDJ5lmCT1reiSZ9sd5q0gaL9WGoFy1?=
 =?us-ascii?Q?5liVaCbUXvVVmgYtPV2M5OlzS+d94/SCveD2c3s1LnoGakcz9C7Gz6nvF1s6?=
 =?us-ascii?Q?aihpev2OMA2vAj3GbR2R3zC0u2aImev5xI9RV8eXjARA2oHLr3wPdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8aY7XyE1QcOcPbpHvpXMJyM6fMir/ak/WAo2c/zdCiltgbiDBvaXDJ4hVpc?=
 =?us-ascii?Q?Fc7DKDQoMul2ySw06R7fdsKt15HLIgc7CO6YtRgtN2rCvvLZFtArm/WpThim?=
 =?us-ascii?Q?rYlKd36C65TL0d14lPIryLR5Qz9b4+vLKulWN2DsCpOdNYUh2CAc8ZiXLNVR?=
 =?us-ascii?Q?eRLwtA4bxkwE2VFzLX8rb6jiUinQvr2kOM9fQ4Y3bjLBvCKNLLSEGVfiVyRG?=
 =?us-ascii?Q?PoTmJn3DJkBlKAALIhqEH3hUYE6IhZZBoxW2AaDtb8OQBQMBymv58Kh3PGAQ?=
 =?us-ascii?Q?kcACYjv/ASWTUElAZh00/iEqhtnl80kkTDEofI3qcIFI2xNg6S3au+z9TT1M?=
 =?us-ascii?Q?VkFsCf5/t8jYx98v4cIlBKgkN+Z9WM1FIv1QvpKef+r45Z1a9BTXOzZPVGjf?=
 =?us-ascii?Q?YU6wA+IVVHdF9TuDkROKKQa9BzERsFSm+tUT8rhmeS5sVWyPTPdtD0Si9pSg?=
 =?us-ascii?Q?kbMALHrb72OhsWM/5uOKFFwR2MkzRpdp6z3gOdTcx6AReLJB49pOTzwPQBEK?=
 =?us-ascii?Q?he8a0qJRa0hKqtkLAJjRru1OU4SnP2b4djscyV/aAqXwC42QOKDJBXb+9AMO?=
 =?us-ascii?Q?eQOIgbkKWq6r/EFsV15WW0LT22VTGMozD9aDlz1SKxlzRmIfFD3ii9xpQxnp?=
 =?us-ascii?Q?UAF/hzyvTunr0fzCV27qLWYQh4+ZR8d96scBicWjXbdrHAsF/OcE2AQu+Oss?=
 =?us-ascii?Q?ZonoJ+yVoB7nLD+LBFxN1zOQMRRy2VhwpGxZp0uSOfsjbvvE9R6C53E85smq?=
 =?us-ascii?Q?lcp8jmqXYpYsJnWijVtXXABXyfqPfDTG+rralnkf0odKdjbTGJ61dGzEWaEM?=
 =?us-ascii?Q?XsUok8VYA62yPsO2UirHQNlJEjR+nKDndtBpGJz2so/wvomKAWkqnKbgBFtw?=
 =?us-ascii?Q?xESsjhtn5l230mf021UEMlAXV7NO7v0Nx3675u14RzhFO2D6SkEEV612CswB?=
 =?us-ascii?Q?k/MMb0LVrqBAFZFX71AVc7Yn0b43C/VXhJH9JIflx9pE0uoWibO46zJsr99X?=
 =?us-ascii?Q?2mm+H3P80MO+AH1YGacmj5n94kQSMEXF5mh+eqawWzMyCh971MVK7mYtgKUM?=
 =?us-ascii?Q?q5rHVcBD1QUFatNF62QYq5DK9DW1++I/rwnXeXVxcA6sLXLwsBQDFD9C1xjx?=
 =?us-ascii?Q?olesD+gt4yEYBGhRtZsQYvZAooVpfm17e7BqOcZECCarD5SikLLh7kQlciuX?=
 =?us-ascii?Q?+ayv8GD5iGwQzXCEVBV2R9zztFBI59BsE4HAOEh4pOWjj13uKQyqonPH8qcT?=
 =?us-ascii?Q?9+8bJmQ9l8ScvKT1ls/9DgOE533Zk/xe2mzmftTP5c2jdJIcACDoyvsflz17?=
 =?us-ascii?Q?HfC+Liql1pu6Gy8m3YaO6FGRJrUCDQfI0QPuF/on07sBF+PHYGL+bfN+KEH5?=
 =?us-ascii?Q?5w5UvH3PrD0lTqSE+eytrnCRsA+a5y0n0YnFy6spfEkOvZ+d4eoHPzaShSwq?=
 =?us-ascii?Q?t2PyzRbF7fys+odenXj87/iACplYORRO5QfEmZZHZDKbmPaNy0eXWua6meaw?=
 =?us-ascii?Q?tZR1z9ChFBAMArI0uVTmvR1ov7R32ySJUosdtcK6oqFdDlxIOy5ASjBOY0kP?=
 =?us-ascii?Q?F0kjZFZNWG0LmqjH6dKGgXkCXzdn6GmWC1Dhm7Chva98STHc40eEKWKtWxzW?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e4387e-8c86-4b91-7824-08ddc2eab59f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:25:48.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1JSJnvsO8Jnn5B1qve3DKi4DJONkFGz+rTVpkTpypto1N+5y1sQqyeQYX1YgYGAl81X6Vu4IzpeI1+atwRTywV91Z+ZgCp98WPrhcqX4pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5592

Enable gmac2 on the Agilex5 SOCFGPA Development Kit. The MAC is connected
to a RGMII PHY on a daughter card. The necessary clock delays are
implemented between the MAC and PHY by the IO ring of the Agilex5.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 .../boot/dts/intel/socfpga_agilex5_socdk.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index d3b913b7902c..5436646ec7ad 100644
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
@@ -37,6 +40,21 @@ &gpio0 {
 	status = "okay";
 };
 
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
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
2.49.0


