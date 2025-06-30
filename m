Return-Path: <netdev+bounces-202388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39659AEDB0A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C4A17822E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869525FA29;
	Mon, 30 Jun 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="k/ZU9c/d"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60F25F793;
	Mon, 30 Jun 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283064; cv=fail; b=Fxk+r6LKKblOuT2Xjxtlz2A4ljjk/62XPpV5G0j73pIUfcWS3FM411CLInE09i5Dl7aC4Iy31lgvDK5nukPppmQVxoBBo1yAWUbOHE7SGQ9RZvaZXlk/ms/e2fkezaBFoArwgsQSZ/RKxkqElTUefszjBSglFrseQcmgzV9uCpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283064; c=relaxed/simple;
	bh=DdzIdH1tBo3M0022adW53XQYloGoEH4wQXm2CJWpc7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsyckBhQSU2Gl+sSkpK3l/88hNZmKgRVmEtYRTbRrd7bZ1H6h1hUJji/qqu4H1krcHJ3tU5Lawa3/hADPoij/mQKf+o8t/OjfP/+g/qu8rPJSJUrGUvtms9NsXV3WxsZqlBQNpcOCQYYWYN8w1swvgZ0e0VkaHKlVGJ71SzykRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=k/ZU9c/d; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnspSWhw873vuLpEXj4o7DTXk0WjjSKdrHLKPRe7xkBbnH1rZ2tqemuTQdxjC4Tc7NexjqJiJLmmGfK6dOwM2KNXxWtPmPDddQmcCfB6hEO5l+/zSQqRWxbRRVN/hUThsKlXcGCxmoVV+xVIUZd5INVkTWngv4AOcbFoL6EPeZzXZILEelv7YYsmFCT2gfxPkhummVuSej+9dol9r5q/ZIFAnkO/XowUxscqUm9ZT5nhVrlnH3V3Dk3BAvQN3xE3zYn0hNy++WCWOsfsfklQUx016TYwSCPE2h/+1Y02t2apQ9yOkkQGVozAktZSk1WeodQxL+rlPlr3VYhcSI8WXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTpduEGJqNGs1WF+pzrCnRCGLcMMsJs6mPoO1Fjx1Cc=;
 b=YXYVTr/sbVL5RjtYDlFobghsrO08rxL44D28nacztPP7vYSVRk2pTDl1/skP39hLAcAZ32OpWo8CNkelOw3XFSiWXXBNa70QNFneBZR5zxvZJNVKo67Z2rzo0Fb1bVADW2156E6ziJdj2VZqG/9c2uFA+05jB+f3uQ+jXe/hpq2Zh+pYibTM4Yao6GL/NN6NNayCRtvAHLNW5LB8Z4i7cJqnzAH2+Q8pFAhlQ5q5XDTz1we8eTqavHyAOnAsq3pBKPN5OH1EqHQFAFZNakLYdjqfDhxWkvJ7Y3hiYu7s83iBhlh9h1EFSrVp7ko7VQ0OOh5xhAIudNJJzhdYHe4Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTpduEGJqNGs1WF+pzrCnRCGLcMMsJs6mPoO1Fjx1Cc=;
 b=k/ZU9c/d4sKBNPH4rwGN/03IplSoDkI3LU589k9CQy63ei9JoJwkRneTNLtEVpeJ/apJN0e0XCK8NuCJqMIz3V12K1CN8H5jLVw8vsB5e8Uac+v1vA92eDlFGcxY2+nw7oyhutJ+B7qKmYPSM5LrTmlWd9Th79DItLyacBqjsio=
Received: from CWLP265CA0423.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::9)
 by PAXPR02MB10342.eurprd02.prod.outlook.com (2603:10a6:102:248::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Mon, 30 Jun
 2025 11:30:57 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:400:1d7:cafe::39) by CWLP265CA0423.outlook.office365.com
 (2603:10a6:400:1d7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 11:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 11:30:55 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 13:30:54 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v3 2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
Date: Mon, 30 Jun 2025 13:30:31 +0200
Message-ID: <20250630113033.978455-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630113033.978455-1-kamilh@axis.com>
References: <20250630113033.978455-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|PAXPR02MB10342:EE_
X-MS-Office365-Filtering-Correlation-Id: b5622e48-be17-4ba2-9fed-08ddb7c99400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|19092799006|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amk2MWJRQ2pWS0VIQWk5UkNaRGI0Nzd1eUFEekluUStuM2h6V1BkaEtpa1B0?=
 =?utf-8?B?bm9kQkh0eVAxZS9lTjVqVjNRcDlxcUtqVTl4NGsyQ29MZGlSODBpbndoK1po?=
 =?utf-8?B?eVNmWDFXZTkvdFV6MEtEbzNseTVRS0plTE9yYnI1VWRwVXZZOTNKZGcwK1kr?=
 =?utf-8?B?aFQyVnA5VHZhTU15ZUE0Yzdyc2txakY3Uk0ydkRzdlhWbzVmSEk3bzdKalFP?=
 =?utf-8?B?U1piVjRDY0ZZRHVVN2t5VXlUbmtGUmhjaHlWTUIzRmRBMVlvczdKU3dmY3Rt?=
 =?utf-8?B?M0hTNS9kVlB6dlY3a2h5TDJVajRlbkpoQncyUkNTa1AxaUpsRFZoNmw5aEl0?=
 =?utf-8?B?bUF4VlQzTWNmMTFGYityNEU4N2l6OUo1Lzg5ZTM0eHdQdVlnVk53SnpQaDJR?=
 =?utf-8?B?T3BpcUk0dHhFT1MyZFEyY2gvOTdKNDFzbDZyNmx3bDZzc2ozU2N6TDZiTWk2?=
 =?utf-8?B?dXBmV1c4akUzOFJxTnRhUEk4WTJYNVB4U25LUXRCYlV5TlJYZ3VrdEZqc1By?=
 =?utf-8?B?ODEvblZuY2ZrKzl3VXBkU0pod3BOU2xTNjNEYnZaclI0UHFPVEtXdFJLd2pi?=
 =?utf-8?B?NmUwWHFDR3FqbmdZSHhkSWxnQlJIanpHV1FVcHBFdm5GY1BOTFJoeWNtWnVU?=
 =?utf-8?B?aXZLaUVwY1E2Ty8rWGZrWTVkWVZvbTNXdlJWc282NTJ5SmVnbHNtYTN3VzRo?=
 =?utf-8?B?KzRuTHRpUzExQVRMelUxV1BMTTNiL2Z2T3plMmE4U1VNZnJKTFl6Tm9NbVpN?=
 =?utf-8?B?T1dRd1oyVjY3bCtDVzdEYkl6SmJMSEE0L01FM0J2bTRMN0tRQkJsczI5U2o3?=
 =?utf-8?B?V2E5TXhWcm9wVmlkbWxoY01ZQ0xWR0ZYQnB1R3VmcU5OUWVpTEVnZ0JWVnY5?=
 =?utf-8?B?ZERKRmN5VXkycWIzRmVpVUErTUdVSmtVUW0zQk1QRTJxMm1FdytHQ1EyM1J2?=
 =?utf-8?B?NS9IRDd0V0MzTDZzRTFYN1djbWIyK2k1RnJhTGN4ZEcycmVRMU1pYm1BSUlC?=
 =?utf-8?B?Vzl4ZXp2cjV1NEJRZXR0V0FTVjBQRTJreThwdWRHZlhNN3YvaU5waTE1aFRx?=
 =?utf-8?B?NzhvZWppL2NNV3NPaUlzWkNiT3ZaMDhLaW9PS3R3VVNZNW9VamE4YkVXejZT?=
 =?utf-8?B?eDhBR0dkT0p2UXZVbGpzQ1ZvQ0FSVzI1K0RQZHIyT1FtMFF4Tkl5SXhhYm1n?=
 =?utf-8?B?SVJjNWpHc2IwbFRrdEwvZFpkdVluN0hCL2ZnRGJpbWpGS092cEtlRWRYcnNt?=
 =?utf-8?B?UmRjUk14S1FXbEszR0tZRnpoNjFhWUZTV3JxaWNUYUFSN0xFOU15UTJTRHRU?=
 =?utf-8?B?MFdUQldPL1ZzeTBabnRocXpBZzdUT1hPeFdQUmFUc1A1NGk2dnFnZ3kzQ2F5?=
 =?utf-8?B?M3gxU2JQekRxalNSeEcvVythMnF3NjREbXR5RE5wMDVoVGdUOHVqc3FFMHFk?=
 =?utf-8?B?aktUVzVMQlFoMFNQM3M0RHdEVS92dFd0V3VJdkZ5YXJGNTlocHBWMFhtNys1?=
 =?utf-8?B?bHpZbnJIVHpIeVF0aWRiZHZkK21sQThJSm5mVDJTQ2JFVXBFOVc2b24xck1Q?=
 =?utf-8?B?Z2xLc0o5TWU0VXVDcWhPQ0lKOTFzZ0hlYVM1RytlVXZsN3BsTlFZZjV4Q1Bi?=
 =?utf-8?B?ZDFPYXVPVzQ1ZUVYOTZzUGRDalZrcW5maVJ0M3VCL2FEbTNGVFRCcWdVWnp2?=
 =?utf-8?B?dXU3aWhIR3hzd1dJdVdKbE5TMElwRHpwU2NaZVpFd1FhQnJWNGJzSTVKQ0k4?=
 =?utf-8?B?OWo0MTUyNDhXM0t6TlFvamQyYTgzR0h6K3M4aGg3dmNud2N1ZjRBY2VPKzl1?=
 =?utf-8?B?Vk4rWDduOHRqaVNONk5Ea3Bxb3lQT3ZLK0ZmeXlLMG03VmdDcnR5R0pxTmE3?=
 =?utf-8?B?bm1DZlVnR3JqYUI3MjErWG5RWk5yR1dUMWdld09DV3RZdC96TC9GUWN6eHMw?=
 =?utf-8?B?dlJJWlZWazI0bmZ6ei9UVy9xL1hWN0dSWlV1ZGQybllWL295WXVjRXJ1TUdH?=
 =?utf-8?B?M1pZRTJqZHk5N0s1bU83blNObUpoZExib2NYMzRNeFZKYjZPTkY1UDU2dVhk?=
 =?utf-8?B?azlEdnNVK2dCNGxFd2tKeHc3MDFYWlhoMW1rZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(19092799006)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:30:55.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5622e48-be17-4ba2-9fed-08ddb7c99400
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB10342

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add new interface type "mii-lite" to phy-connection-type enum.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 7cbf11bbe99c..66b1cfbbfe22 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -39,6 +39,7 @@ properties:
       # MAC.
       - internal
       - mii
+      - mii-lite
       - gmii
       - sgmii
       - psgmii
-- 
2.39.5


