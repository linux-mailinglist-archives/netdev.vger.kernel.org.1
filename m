Return-Path: <netdev+bounces-201728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A42AEAC86
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0327ABA20
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B261946A0;
	Fri, 27 Jun 2025 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I6QnkUvW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4E1922FA;
	Fri, 27 Jun 2025 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750990129; cv=fail; b=MbfX48E0IXDZMGbPVJPtzPmLKyjesweiYVozKdgVS1hSGXQtidPehKzdFaIH/IKuzv8/B63NsuNZiKKE9Tx5JYD5w2UHNQbew0k/pYCorN5BxNKZJ/89xtvO6IVjKiUuJn1QXZJFbeFa7zeepGO10sXbXZNxP4Ajx+kOWZghC5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750990129; c=relaxed/simple;
	bh=B0NfE9g6Nf20CHoC4/ZeCUovznUeFAZpuRxO39/WIOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vd35PhJ37LD17hEH7yNmfoiUSdrC0EEwS08XeyLX/wzwCG0MDLTr6u5mTXukTIVen+WFaAJi5nUbpd6804bbxd5FSOsUnJqNZPuj4EFTrBtRoANuSygdh6dPfwdgnr43mRLoeaCfQm5jhoYO3tzEupi7ZpL1vIVojkie5sAH+Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I6QnkUvW; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6QfPVncEv2tMnWj+PpgpqxoiK6jxomrBD3mRiGmuGuUQH3LmG3R9DlPZFIAELQzkmtylKxdsXvppxbZdyvo9LbHfuRDYilgteV+zqFwYXqNmJZ/ARsaLP4iV5VyGGcYBC9zamCNFhUpZwGW2XnaUe8Mr51/hE78QfL3iLK5S2l6WvCJADCgmwseHFwoVffnKYLFpwNRQBJST8a8+MpJwp+xAm60ygE27GI1SvcTNt3RSa4CV7NK4L6O/eTkUJGVpGhCn0O6DD0Al0fVzWoO75vHhwgpFhmSUS0rMlVgZ+DJ5g5J2dcyVv4r4Ornbip9svdz7XP0WuH45S2aBd1Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV5Km4lHtsJ7Tw2H1gc2r09qH8Hnd9x/IYova5L+8Zk=;
 b=J0+NP4HZQEGJiWoSUTErldLj17/RbDeEb+bKZ8UjW1yi/g4c6PkPj1MvR4X1KFKfqkggNXYFKXr60wl3lVF8UqRGfyXbE2XTyrOQccuduIAPA72dW7EYHwsPBuOtjQ2xzrpqvt9gSMuN7D5avYVouy/qiMsohL9VBv/kSUKCOvllHNZNn9x1vZ0eQZRE18PiuLpdOhB5vZukgiioipfivHpcGJOTRzBuUaavjlvOxUeLbVpHpXLIDGlfRGducXKye8tf7DidhDvBH+rZNLTnCmIXZT97oa+yWpgKQy4gNsSDg5yDpx18xLHL8AqAJj/BXyDSEXvxujEDrAq+g9qkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV5Km4lHtsJ7Tw2H1gc2r09qH8Hnd9x/IYova5L+8Zk=;
 b=I6QnkUvW/0G4R1N6CjQF8k/cWHNow5Y3FxrLXqmLfEJ+F9TIiCeAf82BO90lON4f+jDNw5dKpP2FPD7fHFlTK3s+Tcbg7pBW0pUaeH7KuFu5/nrYbKs7mBNvYhAptImfeBZQdoS25mjZl8mSfABvFmErnlz8RVXxRyEzNPEtJEWWRKjrSpBp0EIQQ1NuVlLGT/DcrFvQ1bDnTBmLxdgmHrOmiM3VgtSDGZ3zLBw7yTK2K1ZnQu283V/x0djysdP1zCUlTYxu2fT1/8MNp720jbl+xOuqcRua9WH+23zW9A33ZBqjAM96n2X7VE3GFXyKJ+XN6wSGgDrhd3J2KRrc0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 02:08:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 02:08:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 RESEND 1/3] net: enetc: change the statistics of ring to unsigned long type
Date: Fri, 27 Jun 2025 10:11:06 +0800
Message-Id: <20250627021108.3359642-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627021108.3359642-1-wei.fang@nxp.com>
References: <20250627021108.3359642-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: e934de42-7759-44c6-0f77-08ddb51f8af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ThvvajQoWjBBLnhUwfjvKQvBVIYziOy8+khlZV3dH7aqVvAtcY+YBu2pIrv?=
 =?us-ascii?Q?5dBuXGTRhnplokGWb9VELB0acgppu+qAey+5z92P3O35VQJxM9UAH5MBSZjh?=
 =?us-ascii?Q?IEmLZ3uvJNHLGBMYvdxW6sg+0l44g7US0IvXK5yKRdDhgBUEA3mBC64Dm7Ba?=
 =?us-ascii?Q?EkJcGrtNJ/heqNioFgvsih0Ddq65gHWM5O5LtpzGbnNIv2/lJWmjmjC8CCce?=
 =?us-ascii?Q?Pp0N2A8aJwqGHyQxEEBU77p7cyZRrBFrJteFaTS6nHXsrZBmkM2TZ0dCZnor?=
 =?us-ascii?Q?x2gIRGAyy52RDrqDUeDQ9KnCzPXxr/+KRTLsPLmhYSkRQsg+xo+chABJ7hwM?=
 =?us-ascii?Q?wEm9o3AGAWSUSlqPCE1yHOVhy0PWg7ULcn0rW8bi9dd49u6wwBFq9QOWSyAh?=
 =?us-ascii?Q?mQW552RNW1gfDNNtgHX0SvA7v1rTU8isJ3rIngyBMLHTm/45YdFx0g6D4S67?=
 =?us-ascii?Q?zHn+5CgQ6bhWCevtijNgufENe9SWIQPwNKtc303y+a95lzQjoIYXEB8C3WLW?=
 =?us-ascii?Q?ia9Tb0Xt35dDJDqsF/arpXKNH9coo9JFlZnsh0LkvQiGPSBpFZbVpG6zxevM?=
 =?us-ascii?Q?/y2t0dZSHfi++g39K1r0ZaMAXHtGsf9Q55FImxAEc7I7R8j/Q2MCdl0PATXP?=
 =?us-ascii?Q?wm1yG0TYKDOAL+kzy0br6VGP7hrXaKb+VdZWL90Bc8frfDg8lemU99QiBg29?=
 =?us-ascii?Q?/rX1PnVUzH77x0iJWc4W0DQDVvfzxgsBCykByeYQhoN+VXcMy8SQKjSR4nJ+?=
 =?us-ascii?Q?9VRz2kDonWWEsNzDlSEyM7G76C1AK8wC4R3eJVytlGEfEkVVI15DOIAPQ49o?=
 =?us-ascii?Q?8Eldg/E1djXEvKD0osb/iSOERzPVzY2oPCI/B9OZaIi3oF1Xy5/PMEJmHuzR?=
 =?us-ascii?Q?IZPCVOlZ5ii/ZTuRB7MQk2VlFwHXKvFmUlEa70ZBYdn8KYIgAVGYdvA0AO7q?=
 =?us-ascii?Q?AVVlEQeARW0vvcez2X/D4L9XI+Szri7lM1A5+02nChXBMkXEt/CONIjVLFiB?=
 =?us-ascii?Q?Ng1tmv9W6JNGquZjbqZVmKuZzVnZfl2pjQeX9yZ1dnroFYzAPzh+HUIHQHCY?=
 =?us-ascii?Q?C2b1ukF26m5qnS5VKFDGD79A8akbgRsFYzzaNr82S+ZGpaGztGDF1lVXlEm4?=
 =?us-ascii?Q?m+1k56UUt/aI8zR1rQO06VCaVXOXXx2GfHd/rdQC8hvlnMcLtyuKpcVcWz2S?=
 =?us-ascii?Q?73Vz18aVCE6TDMYmikIYHTdKtXnNkW+2iJ1X0swEugjSGOjKZ32L3OnSWynd?=
 =?us-ascii?Q?QgxurQiotN1+2/lGtmvy1HQ98eecp/0Vl923hgepGSE309DLqRji+MS6+3MW?=
 =?us-ascii?Q?ofJzx3Oci4LuVnw2XhmucnwF5Ns4dDDpKErgfvVmFQNT5N9Oub2xyWa56JVp?=
 =?us-ascii?Q?2Y1el0Ag/nUMUAJVtifnSDtDsrhwFiZH6d/9M/UqSerwPGVt7iwBDT1U4pQx?=
 =?us-ascii?Q?lDFtDuU1glAXsbkKya2YaoTRUKQISfAhMm14VbxKN4gnCVACUkrmSuvmfTKk?=
 =?us-ascii?Q?Ex2e8zYzx0jko/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/FU58vzDeeaTZBbF9oTRmEwnqW8ldhm4HsDenQP7/7mzJvYjzbPxHQiP6ct?=
 =?us-ascii?Q?BJzG6ElRvguWceGivEvUi+mTiYL9+pWVS98xZGT9JPEx2tbBaih8SU9jz0mM?=
 =?us-ascii?Q?+TSqfFam/uyFb7ChHHos+sycMCaYJpjBULTbJsA1LrsfIPlyuKy6fjuqNNXw?=
 =?us-ascii?Q?4ASHi0jfg60BYVTkneQdeQ6xpRV3tJl51YB8rUkBOixgRBpQYybkR3IQ+oq8?=
 =?us-ascii?Q?aKEZfwVUmCOtu4qSZnxbIgY2N3NiZ3ilhNMhUnl/I/5pKaFaaVi/duhf03Q7?=
 =?us-ascii?Q?mFdGJRK+66fE49LJZvjYOynurKhKJ5lQrEfCaQIPVIXj5/yCw+bflY5mFnJX?=
 =?us-ascii?Q?OCy35H6Bde1UgX8VtmwtkSz2NAOzMLdPD/yZxcWxrMyUvACp0MB8vtvfMjCQ?=
 =?us-ascii?Q?HIOLf3IYIT9FV+yh1kCdZguR8LFfJFQUGun/LPKRSuc6V5x/z2gdC+uw4sh3?=
 =?us-ascii?Q?VaqcREhKGP5LMdCihdC8Szi//SVeqviRXCr463zwQ5ZZJGaQ6I0YEERsVkw1?=
 =?us-ascii?Q?ZxI8E0bVr0nYJU3Gp15OIIEQszKGknpM2PdFzQQa82ZKbZz6X/+NVKcIC7NK?=
 =?us-ascii?Q?rRifiETTTQr/IicpOZ79Nsff9S/QmKR2wJ1Piyic9Kh85oKxHQmSkN6e4Cvm?=
 =?us-ascii?Q?OoBV19vujQIuZWULRNuZl70EKhWTT+kNLTcjRTk3xZkoXMgpuj0yTZNsR9yX?=
 =?us-ascii?Q?JCTfNOGqJGTjb5x54ry8rjYQWamWGDHJW1Z6wIhRjQstyE6jZDPAaJJ8pUje?=
 =?us-ascii?Q?/jbp3cPwA9/izVRVBxSy3vIqyTAa/M0Wd+bRC/b3F/bf3H4+/YhUo/z2HTkJ?=
 =?us-ascii?Q?/sF4Q22yaDcEY9GxMWZykizgMI6NXYDJkB8GCH8tb6S0z0/MfLRSZCes8z9d?=
 =?us-ascii?Q?l+aZTYkgsBe5ct2EHdhNqOGOToV3PPGPh8Cv4lJy++mQKlNp6MSow+Lzrt/m?=
 =?us-ascii?Q?BmKa9M3XzXB+RTsc2uI5XE/TKrM4yKu4l69aovOl0pm8AbiT4TegGFdwUkR3?=
 =?us-ascii?Q?+qO3LsmoVugvmTN4j2QLuAHwVufdOtMbEy4BuEjCiN7yWZvt/HINtx4FLUIh?=
 =?us-ascii?Q?+Uz3C3sWEISN/UAHTsqWyxniP9ypyVAqG0ZS38L/hZTyLPltNOA0mLZr044K?=
 =?us-ascii?Q?JKPHR8nsTwS1rtVV44UfLSmVFOyO5M+yxaBsqZGrf/DE/M7tTadDBKvWqj/F?=
 =?us-ascii?Q?Xh5G83hs527iANns4Tg7e7HvoNR/2g7fvrzNaEkwa0F0ZDQ3Ga5xJ2W0+N8b?=
 =?us-ascii?Q?q+3Hvh3EissnkPAC1FXntia62k+N+FLlnjKN3LSu2Iep+SKn4HV2lifSG1pB?=
 =?us-ascii?Q?NoGlWrwPqM9dDGV0Cg4a0JU/zAI62FfBLMzgljykN/Bz0Yt8R6hQIOr34qTe?=
 =?us-ascii?Q?6hkxtMqxd1sFKumTraZfhN8BqLIDOKsuSN2Uu+pXegGAsLb9YiwYBqWW279P?=
 =?us-ascii?Q?LLD0OsWD1xSw229kKqmck1rLvT4+st2sligwaqKWORt/Wy2gG88f/Cjws/S0?=
 =?us-ascii?Q?EgUd5euaYFLU/4huwS3ziWAlhph3slK5XTCcsH0IVGNV4j3Ghg6fZnn/USqS?=
 =?us-ascii?Q?8GeNJ/PKVqZbolb+R44fafooytQhABKEWQRFUppX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e934de42-7759-44c6-0f77-08ddb51f8af5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 02:08:44.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7azhDZE5US2e1lCwUEntqzmREvNrmbPOhzKayJJ/LgZG/WYqa8PdXvSFIdaERdy2ZZgnBMRprJRzVHYe2qiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

The statistics of the ring are all unsigned int type, so the statistics
will overflow quickly under heavy traffic. In addition, the statistics
of struct net_device_stats are obtained from struct enetc_ring_stats,
but the statistics of net_device_stats are unsigned long type. So it is
better to keep the statistics types consistent in these two structures.
Considering these two factors, and the fact that both LS1028A and i.MX95
are arm64 architecture, the statistics of enetc_ring_stats are changed
to unsigned long type. Note that unsigned int and unsigned long are the
same thing on some systems, and on such systems there is no overflow
advantage of one over the other.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 872d2cbd088b..62e8ee4d2f04 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -96,17 +96,17 @@ struct enetc_rx_swbd {
 #define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
-	unsigned int packets;
-	unsigned int bytes;
-	unsigned int rx_alloc_errs;
-	unsigned int xdp_drops;
-	unsigned int xdp_tx;
-	unsigned int xdp_tx_drops;
-	unsigned int xdp_redirect;
-	unsigned int xdp_redirect_failures;
-	unsigned int recycles;
-	unsigned int recycle_failures;
-	unsigned int win_drop;
+	unsigned long packets;
+	unsigned long bytes;
+	unsigned long rx_alloc_errs;
+	unsigned long xdp_drops;
+	unsigned long xdp_tx;
+	unsigned long xdp_tx_drops;
+	unsigned long xdp_redirect;
+	unsigned long xdp_redirect_failures;
+	unsigned long recycles;
+	unsigned long recycle_failures;
+	unsigned long win_drop;
 };
 
 struct enetc_xdp_data {
-- 
2.34.1


