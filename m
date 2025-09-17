Return-Path: <netdev+bounces-224091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C76B80A07
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99648466158
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496B3397D1;
	Wed, 17 Sep 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gXo94ePU"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BE30C0F4;
	Wed, 17 Sep 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123432; cv=fail; b=FQkJhylPbW8dMWjNmWyVNB1FYVBPxlwVccsdGt+ryNXZhDcnNZp/E+NmqyaH7nLI8ts9LnMQMN6bK2giD3ciq39hVTWZ92rj8Ebn6PedxGACjaFHPkJhapezcOzO0i8ZUZvQASyYsamIIhFwgXJwa1Sq+4MaLiHe+qeZyZy1jls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123432; c=relaxed/simple;
	bh=u/Tl1qagx3IDH2CKln0BmjAxJHhLIE5LoYoA2gDM+Hs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=K8U6aZWNr4+cZ2evB8JdXSZNpoJb6lFbiywpiD+CynbO9HS2w2COfKbHdE+uVVhTP8x0VFsTVFoKQYKgn5w6LQIL/68ZIpSgTlsx/HI4jbPiFsBIvar+5ur/yDRmsPJVdfo2jHNizv9/cHNegVgY/b4cQufEXXAOobr9F0dU8vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gXo94ePU; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HF9JWf016183;
	Wed, 17 Sep 2025 17:36:46 +0200
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhmf5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 17:36:46 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myrcD3RrQqJGPZ+c7ddgdyZpfI2Gt2SgnZ9Gl7MxOHwlWGY39cWwSDXy9QyR1C+0G55RXMCG/ic91NefjgK8cuSWonTXj1ln9afPF0PhvK3gBzN0aUw/s+0+D0LKnl+Meq5OL2jUdhWs8tOZtqnhpQzPvS8bCO6D1W/mX+Tfs8Gbw6qaqZXtvi5h42tIVKXL70rpvIUeipUMrknGU0dXRZK9NGqpAFNI0cQ7DgjWjfo/y9qJL+V5IteUhE58FCafgI8nPbeCOWjeCPf5nhj/1ns+/ATX2guUHlgkTOnY1VAk0c/UY2zBS4Kc8Crj4r6gtj3QXwFjg/bSwKacwOOdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFYZzrTBwxT9h3GbLwrd6EgDgohBSOThuYRIpO+nHFM=;
 b=vxFTSfT33tCS2wl7Akuz1C16vOMtEYAjYPEkOFGK56/98G1AWkl+EyC7//cWw0gO4BrMBTENCZMOCWBePxMfZjKHuNEqYnCp0UiALs7QM7DxthKE/ak6UeLm8HWCHsknNqzOiBHo1TaFp4KdYqwaP+WKlq9yTRiM4FGzvOyAvdVECbC7Uu8c26Sl25Q/UfDEfSdExUKjmPtZ/TrwHMsr61B0dgo7vMNavDXoOkOxCHzVFyYbX5iScyJ3onVNZgdB5Tj77nn5LvKBJFPQ0ZKLvKSUkwhq8N8xW9cOHEeZogq/OgEEnUFcbLAUuvHqUfD9twEuCLznu6mdA/uNl8lBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=google.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFYZzrTBwxT9h3GbLwrd6EgDgohBSOThuYRIpO+nHFM=;
 b=gXo94ePUvgCuHYqYJrxwNqZR+scZhKb2gHKMIVZ8Jn/PCwDFND0qJnadqjXS1RXHg3fynTRWztfDdw2FfbSyDkRVaJOZUorRwE7GUIKcNFpgTSFkFbkLAe1GNL3P8+6u2A24Immbq3poM0nCdYVyYqbwC2G4UPXufxiJoJ/TZbSjW326/aE9yTmUjjLF/ASdLIqbQuN4IO2iPIsjAZSshfXZCc0aV23QFhSPiVS/62FdutXY3yaEQoraejw5G4nTz55nkOxn9vYEmizNe2X2L5xhPMGtc/pXZLCrRTzY1zCNDd3n1e2AAbkGc9qmZ9Iio22L3l4vDeoPuDBxKwEqLg==
Received: from DB8PR03CA0004.eurprd03.prod.outlook.com (2603:10a6:10:be::17)
 by VI0PR10MB9249.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:36:42 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::80) by DB8PR03CA0004.outlook.office365.com
 (2603:10a6:10:be::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 15:36:42 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:29:38 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:36:41 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH net-next v2 0/4] net: add WoL from PHY support for
 stm32mp135f-dk
Date: Wed, 17 Sep 2025 17:36:35 +0200
Message-ID: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITVymgC/22Nyw6CMBBFf4XM2iHtCFpd+R+GBY+pNJGWdBrEE
 P7dhrXLk5N77gbC0bHAvdgg8uLEBZ+BTgX0Y+tfjG7IDKSoVlfS+AlvlEl6nMcvWnvuKmUqY2q
 CPJkjW7ceuSd4Tuh5TdBkMzpJIX6Pn0Uf/n9y0ajQ3Aa6kNE0dO3DBpFSUtmHCZp933/0cZxbt
 AAAAA==
X-Change-ID: 20250721-wol-smsc-phy-ff3b40848852
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Simon Horman" <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|VI0PR10MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b28969-e5ce-4ed4-1849-08ddf6000060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3ZlMG9sa0tCNzZIQ1hhWXBzdWs5MVRvKzhsbWhDb3ZlSnhWRUZVMjFZWVV2?=
 =?utf-8?B?ajVHNkhnbUN1a2E1dm9GQnBuWFd3WVRRYTV2MzVMT3RQWUdKVC9BVVA1K1VC?=
 =?utf-8?B?N3BBSXdra1RLa1NOR043N0M4SzE0SDFzWU1JVXBBRUtsOSt5ek95NjRhVXQ0?=
 =?utf-8?B?bGJKUDRMVFBYODc4Mlh5VGtUWXl3MzNmaTJSRkZZQmdJK29XWS9zaE5RUzBx?=
 =?utf-8?B?YWV5aUxuVEo4eCtNT3VpTEZTRDQ5RE1PYVI3M1NXczFPemh1M0c2dmFwV0p0?=
 =?utf-8?B?L0lCWUR5SUJxWnkwV3luYm5NUDVYTUZaUHhOdTA2TEc0MTVZZUM3ejNKWldk?=
 =?utf-8?B?NXNDWGg2aitrQm1vVXowd2o0V20vVUxGbEtlVFBPWVZrTklvVWQvN0lFaVlT?=
 =?utf-8?B?bHM5NG9KZi9RNEVhQlNsb1NFYi9NaXpyYk5YM0VCMmp5WEN5MG1CRURuUTY0?=
 =?utf-8?B?LzBodmIwQ29iV0VVdGRkSklSOWFOcmk0WjNKTFRocFgwbXhWalF0c05MeW00?=
 =?utf-8?B?VFY4S2paSWVMc2RmdXZ1anVJMVJIZ1lKTmxMaTdMTEJjLy83bS9pSktsVFVz?=
 =?utf-8?B?TlVqcHAvMnNWSE15RnZrRWNIeVRKdnlvbWkxbm9mb1V6VFJtQU1mcDI5ZWxl?=
 =?utf-8?B?YjEzWldzK2d4bDd1dzdCV0xSWjdsK0xrY1RhdWtiZHdRYSt6b244dGQxOEps?=
 =?utf-8?B?TVExY0tLeTVTejRQeEh1bXJ0aUFncVJETUNxMGJzNXA2TS9qWEVOMTJ3UkEv?=
 =?utf-8?B?Yk1GTHZhaUYrMEVnSDdmS0xHR2hzOVdMZk5mbW43djVpczNSVHNDbkR0bWJy?=
 =?utf-8?B?V2hXZU5jOWVCNFlzVXBYZ2lLeUxUMXpQeitQNXFXWldhR29rRjArV1kvcjFw?=
 =?utf-8?B?TEMyZGF5NEdIOEVDbmhJZUdyK055QzFWNm1RSVpQL1dUOXBrTlFRYkhGVzhX?=
 =?utf-8?B?YitqS0ljUTZxdFlHZ1IrdHFlRjRLNEcyYmZqQUVueXdKSlFXczZQaEtWdXJE?=
 =?utf-8?B?REExaEd2cTFjd2VIT2psRjhSZVRlbUtPZVNtMkpzMndaZGF1dDR5a1lGRVNh?=
 =?utf-8?B?YWxSaUUvemIyaFY5emgyaE1sZVVhVXJUSUtiK1IvR3ZNWEVEZlFQZGdUekx0?=
 =?utf-8?B?VGhtSzNmVE5NTUVKWGNuWHh6YzdMM0FnTU9kL0RmM2g2WStJMjg4NWIwZUVO?=
 =?utf-8?B?U3c5MDJMVWNOVURaaTIvWVd5VGl2K1FmdTZzN29JcGtvQlFjR2h2SjEwYVQv?=
 =?utf-8?B?RDZTaC9HNndPelh4U2VCOTc4M2kvMDhhd2IvRkROcm94Y0FMR25HMlhKa1VY?=
 =?utf-8?B?QnI4UmFsZklnUFVtY1V4TzEyR1ZJdFlQSzh3N0VHd2FINTg4aDVrWVJFTTNz?=
 =?utf-8?B?VVFvZjJoTjRVeDJseGJTdjF4Q0d1TjlVOVhLZUVhc2ZQaWFSQm9DOHR3YjVq?=
 =?utf-8?B?Ykl0SFVTa2Vyd2YzWEN2RWRHUGw4d08zWHNuVUNkcWNWUXNDRGRvWXBXOW8x?=
 =?utf-8?B?cENJY0RVVDhSZmJhTDg2aFl1S3BvS0ZFaTQyMEpsU3VQM0wzUHlhV2QyMC9p?=
 =?utf-8?B?N3Yzd2NlcmQzeU85KzF4MmtMUkhZelh6VzdXSFcyZElIcWhqQ2pscElhM0pk?=
 =?utf-8?B?Z21ueWVpVjNnM05ZdG0rc25KWWJ3Ui9mcVhWckhDZEhzVUFSV3BKMXVGUEJ2?=
 =?utf-8?B?ZHF5b1hoQVRUYXdsYXBqb0tMYjVjZUF1MDdTN3JmVlZWQUE3WE14N2tWT3J0?=
 =?utf-8?B?ODZMSFVSenlwTmRxRjFrQk9iUjV2Z0h1WWxEUm5kbkVOQVdvZGxSMXpyZVZZ?=
 =?utf-8?B?UDNKZi93MkNXNVFBRFpTeSs5dlBNOGxmREZKWGM3dHVibCtURHhWZjFOa0lY?=
 =?utf-8?B?T0hmQ1FOU09SdTVpRytOV2pOYzJhVnlBcjRsY3hXMkllK2Y4Tk5HZkJCQ2Zp?=
 =?utf-8?B?TXQ3NzBWbmQyVHdDVy9ZYlhObjlCa2lxaXFKUnpwcHlvSHZSRGpiMDNKRndE?=
 =?utf-8?B?MGhRWFJYN0thVG1TYlNwclZIdjBDK1VRL1hKcXFFMCsxT28rVk9ia3Y0d3pS?=
 =?utf-8?B?WGxhalpSV0hpaTNacE4yZm56K3kzYnZDOHJIZz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:36:42.1945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b28969-e5ce-4ed4-1849-08ddf6000060
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9249
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cad58e cx=c_pps a=Uuq83E/5hH6QxGThgS15Jw==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=MS9TGE9eky3ku5q3IUQA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8qreVm4GRC7R oBwBDil2fQCsnnesxl4nDcEVIkz3aKCJQA6Z/w8mPX63iN0/k9LqMbTz+5KO/aZxUah6ex6xmyz gW0Qrxcc/1Sl7aGBTVZ1worsNUs/4DQmJ+LxVQzhiiEYWL4JfQ/sLd8DpHM/IFo1DLLGMqgOnO5
 /f5vPQpni/FhorO3Ss0sa+Vnn/O3rS8WhiAcftkJfQjZWOWAn43ky3vDj3NqhG7AHNPGZi9jYuR KRrpexPFpTQgzmf3yTPohkl/c3EJbWgaVVVvsjnGCcH4mE10q71uVcpxpNRYvDKz5Q6km3qfe4s esIHNn8t3KzgSIGvhzDRwkWn1LKs4iWtN7/Hk0TXWk3BaBgZL00L6/6pghxYgoUnPbCJKdTQeKA omJch+OT
X-Proofpoint-ORIG-GUID: qBTXJ4W9bztRf-3tuL8CaedLp0czIpN2
X-Proofpoint-GUID: qBTXJ4W9bztRf-3tuL8CaedLp0czIpN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

A previous patchset in drivers/net/phy/smsc.c introduced the WoL
from PHY capability of some PHYs. The Microchip LAN8742 PHY is
present on the stm32mp135f-dk board and posesses this capability.

Therefore, add the possibility to specify in the device tree that,
for a MAC instance, we want to use the WoL from PHY capability
instead of the MAC one.

However, when testing multiple power sequences with magic packets,
the first one succeeded but the following ones failed. This was
caused by uncleared flags in a PHY register. Therefore, I added
a patch to add suspend()/resume() callbacks that handle these.
These callbacks are only implemented for the Microchip LAN8742 as I
have no way of testing it for other WoL capable PHYs.

Note: This patchset does not solve the issue regarding the PHY pin
alternate fuctions (nPME/nINT). The driver still statically configures
the LED2/nINT/nPME in nPME mode. The interrupt management discussed in
V1 still needs rework, and probably at framework level.

The current state after this patchset is:
- Successive system wakeup with WoL event now possible
- WoL event received while the system is up do not prevent system wakeup
  from a WoL event. I took inspiration from the broadcom driver
  regarding this issue

Question: Given that the PHYs have pins with alternate functions that
are difficult to handle (some drivers like smsc.c are configuring them
statically), should we consider working on a pinctrl-like solution for
them?

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v2:
- Rework commit message of the bindings patch
- Handle WoL flags in Microchip driver suspend() callback and always
  call the suspend callback.
- Link to v1: https://lore.kernel.org/r/20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com

---
Gatien Chevallier (4):
      dt-bindings: net: document st,phy-wol property
      net: stmmac: stm32: add WoL from PHY support
      net: phy: smsc: fix and improve WoL support
      arm: dts: st: activate ETH1 WoL from PHY on stm32mp135f-dk

 .../devicetree/bindings/net/stm32-dwmac.yaml       |  6 ++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts            |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  5 ++
 drivers/net/phy/smsc.c                             | 66 ++++++++++++++++++++--
 include/linux/smscphy.h                            |  2 +
 5 files changed, 75 insertions(+), 5 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250721-wol-smsc-phy-ff3b40848852

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


