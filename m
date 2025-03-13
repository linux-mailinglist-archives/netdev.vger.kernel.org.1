Return-Path: <netdev+bounces-174440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D37A5EA22
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 04:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AFA189963C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 03:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DC78F54;
	Thu, 13 Mar 2025 03:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MxiwdOOX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E81126C05;
	Thu, 13 Mar 2025 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741836696; cv=fail; b=OpTu1Odu68vxs4wqeb1FpKBnp9LpQg8LXQhHVtsBhSSgcyYoUmzCO4qNyTfXm3sdPnR/h8GzuhjAoKeX/6RGB4uRyBqcVrNZ5twibKz1SWh6+WzbCd1u1QO++T3QEmn9xyn5/46plTr2oiuToNqwTrMTf0Lagva3jurVRxVKSIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741836696; c=relaxed/simple;
	bh=gLsP8azcp2iQUKemmgjh2si84AAPclBDJ16g7CH/zAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKSW3jOGzJUNi91YXY71UUiMHTDrDpaXEtiBvQKTCD+A+znAdgZlfPlnErmEoNYh7X+EK1JES1hFtGnNANWzvfdDcgZOulWVF2g5kGGwWUkJLiQypoiXm/eqAu1JpzSldGfI/zKBjjVMMjgvQM8hn6ZxzT6qTFYQ5ofLlK1jI9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MxiwdOOX; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDMRagtY8mi7avDRyZf3fWuAN85zk+iX419psH8dTwPbclFr4n7m7Zlb1YDqY45vbnnsvJ/84qA6tbW3/Orw6qKEFEYj/drSiZt/0CiWM3b5A0+bqS72LZ+WwKz2Pc/0u0fyR3TEcSRSwdEE0AOF8WpjOvep6gaPE4DvpAbVKxCxKnOaWLLlaclxS4MksnfB4kS9whxN/i2KHoMKl6AhPQIS11JIXbm9zsEjK0rgWhB+Cwr+bB7SSbSyQeytP4p7QUlwVccQbnFuvKSrJZVCe3WeDbQ96uTV1G93/yYtftjR7YK0/paYYD307h2DGWtBfGwPq780fO5VuM6z1xyRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrdCZNUZpDXMW1kCMRtv3NQUOkt+7oDUBwAO2zfc1Ho=;
 b=nIrZdpmyjd4W/LAOdPwuNX28dwQ5/Jf+LeVKpzUZQfwijJ6jCibfUo+PRGGm4CQUWXxR1KBimpkFPwQ4GGc9lb0S/pgKMeCJGmeK03pt//clKqOLkdxXd1rgPYI+uUfxcoIVFoNpDoUsdioEfWDUAkJZBMDwwH0EeHIqUHH1Px24whykAuQqhqiwEiPg37ECTIfDwysOFlEpCNGDB11H1ApIQ4fRvUmyzeU6GO0wEiY8n+Zr+TaimjsY2kIZJRGIEVpcH4xsDsh/aKB6YibWVTqtsWYUtpLbVlHFBEjj+HTOqMSgoKRLhCJE02UaSJiABQD9aERZB0V/OcSMcnGmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrdCZNUZpDXMW1kCMRtv3NQUOkt+7oDUBwAO2zfc1Ho=;
 b=MxiwdOOXaHYdbLWE0Qsl0/2q7RjNzmpDfs+jEMEAIV0BWev2s/J2teqID4e/qxj3m3YUBD436w40gIzlrAzXs2aU0cHp0RUK8QtGBhrYmy+wE4IklW3a15cM1hWZjB2ey8KO/92IVv88bbfMq1POW35LhpJxbrKGdlqzYRD5SQI=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 03:31:29 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 03:31:29 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Topic: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Index:
 AQHbkzTKsOmRASZLiU2r8QNuR6Yh/7NvfgWAgAANigCAAAd4EIAABRmAgAABiVCAAAgAAIAABycAgAA+CwCAACn9gIAAU7+Q
Date: Thu, 13 Mar 2025 03:31:29 +0000
Message-ID:
 <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>
 <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
In-Reply-To: <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e9a92bdb-0a75-44e4-aef5-e2da97db286f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T03:10:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|PH0PR12MB7813:EE_
x-ms-office365-filtering-correlation-id: db438b5c-10c2-4d65-b299-08dd61df8adb
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mI61qJtYiN+M/KDpicLilPzmtTfRpEk85ScO1a3ViBfJgLYAsH+8+cEYtuDy?=
 =?us-ascii?Q?sI/VlQg3iZkbT9GOPyn1n83nrz5sfxKz1G56sly9eAaAOX8B4c8nWdVRGStS?=
 =?us-ascii?Q?XG1aT1/eL2MSlkFZxMbTyXaPSTEihsT75iKx7Jwemxol93CdAEBsvwqfA28D?=
 =?us-ascii?Q?totKRmDAminesosRUqFX+j6685ubJrJc4qE7BreoYcYLUj3XYjWoUfmnJa6D?=
 =?us-ascii?Q?+pnAPIzDv8LTtQs34hx+yyLz2P5sDaeTFyy8VGRXYasjWONc2tWR8hPuuYck?=
 =?us-ascii?Q?uhTYRR/aL4pd1IHLLw3wGQW18kb9cXA6f51338GA3A4/YWP/lNbHppK9usR9?=
 =?us-ascii?Q?b8oljOJ972Ztf2776afFp4R0KIkXj4vYbv13iLUdR94YL04/7uO0VTV+TYB9?=
 =?us-ascii?Q?5l/misz2K//4LCPHTab7cmT4yEQAbdQoG+rI2gy7tKo3K+kO8cvTqAtywzu0?=
 =?us-ascii?Q?Gq9s1mjKaU5/ytirjQy9JmT5BxBwOx465zAP0sZoScgI/1gYSPXUP1zGAfBC?=
 =?us-ascii?Q?OECwrfJJYBB7pPWT2VDkkW0NyrfTySEiMvoDNFyyIN2UHGlHNJcf7atVibSm?=
 =?us-ascii?Q?Yi6i421ctP0SVAO9t9WLl1Sj4sS65GEYJ8Y524fEQWUSYNmovts9n3c+ctQo?=
 =?us-ascii?Q?HXWtX7cPlX450+7H4tHiMKBtc5wLG3wltKpidEfe9NcC9fXvrf9TbjtNVKMg?=
 =?us-ascii?Q?fa38KAQzROft7xtrzxuQ78fwOCYyl866o9QyUjxvk2cluJSgCvwBZs0kk0VN?=
 =?us-ascii?Q?yxcBoOIjo2VH4fSsZ3nIu+R+jhmdGnxUGEOT7mbEiDRolEmtJpQLWKNCVcwJ?=
 =?us-ascii?Q?n/Fh83VGOxd38+7dUAf+m5Lcu81LVaYjAl8cKrztBdYxhxmBwjxL7rnBuXlx?=
 =?us-ascii?Q?3mB1txipy5EZ93zS6CZqhqsraYADuoSFhMyGwI70CLUqvNJ8p4QOJi2/60eO?=
 =?us-ascii?Q?K7+jwssgyZ4BzCgKF3CxZ1bECsZ/w++7suC43gbUSPjN0QvxfbfJ6SZapUKE?=
 =?us-ascii?Q?KRVlF8A4K4VuGJJS6ssEpY6STv32aoxoToei3E4RbyAjnp4tpTkEH1agRbHt?=
 =?us-ascii?Q?P29RzR9jtCbL1GNZX56wwUMrd7pShhaFSN+ITzCrENw0EAgnhEIqvoQPM7No?=
 =?us-ascii?Q?d1emkccUZNeYsXamDOBYW9GLmMcFArexCjfgebSus2E+w1IdAQjqKogXu5X0?=
 =?us-ascii?Q?YprQD6rU+2z58cj/LDGkJaX5WrS+6cdsEjpNIY/aiicykWZsYM+7yjvckxTB?=
 =?us-ascii?Q?ybdkwG4u4CDdBQl8GS3M8mebCW3bcxIoEhY3JLJAD90jkypQ+c1IJFoBz6C6?=
 =?us-ascii?Q?h3HyBh07HiScdAhhLf45zk5U9dXAmu6xS9czy8yNWDdk0vUFrG5phA7UyV5t?=
 =?us-ascii?Q?tGoEnrY/qbQ6oQRp+8JuiSVLuQuSqTv5iqv2uqpTYd0fmo+rCsbmNY8/ee4q?=
 =?us-ascii?Q?CVG/lMqdHbNQFe/MBzCyMtt4MuzmXcKX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bLRdYUviSMKtxNAKTaP+6wBHZ1hiUe57Y397JCk+bys2yKIRE2SEM7yrUyXq?=
 =?us-ascii?Q?QBreaSFLrnevSy9jEiGEQok78bCESmDkkOpI5mPBQ0F+XIyc/WhbYYLtJg1J?=
 =?us-ascii?Q?AJwB4VoiDJVO27Yrr4w3D1YW/LfZyorPDVS+T4LdzrMvwOxHoyzSuZYqyz6I?=
 =?us-ascii?Q?ZO0r+FTGiCaqjkIf1KazXphnqKIF7iJPIqGYrv5Gyuvup40kCpVd5h8Ss6X6?=
 =?us-ascii?Q?8pXhBxolY47kdLJ78Lvj9xMEe5SbQ5QHQiQ68mpN1FC4ikLOcXzTLHPgQ7pW?=
 =?us-ascii?Q?7GULDNxsX6jaYVTxHZard6xjTOJIJknY7k3cijQ1BTADDkHADj7CFHOxS6GE?=
 =?us-ascii?Q?6M0c0/zjseVP89aLh4b7chZgQECarSt5jL4ueQ+AiXk4KJuVOgWA+unttoH6?=
 =?us-ascii?Q?3TvoAIT3n9XmyYBWHLjXjwBuGPA5ylY4djfcyQQWeBrVnq4AwLUbUPBhDs0g?=
 =?us-ascii?Q?lq7FfGrJR+37ohv6o/7FLgCAZY4JfdzsOxynjjlkYlup4pLZvyYx6aEpzAfw?=
 =?us-ascii?Q?TI4zSpnwkngwTKM9rvI5OXYsSIn2Mip5MC/J1s8qHvDP6cQZd9Bfm5iyqNnH?=
 =?us-ascii?Q?2UWEZ0fYS1NARw9tfBV0u16VHTlK10gIIhMtwlqlw5THVsmjfwuJUUuDXYN7?=
 =?us-ascii?Q?Fam+oIetrfcoHcx5/RnntLDen3Z5Cot/GgziTdE9zPrg/Kb1G4raE4WA1F0B?=
 =?us-ascii?Q?QASffFYDNxNIAxPiSM994HGLAZXA2YIuJt0ka12+j1yq964i4UNVp92sBNF2?=
 =?us-ascii?Q?t4ErZ1e0/rR7EJ/hbyZes/RzyMna5CK4S5WtZd9PzMmHNIWbIpreGftTcLfp?=
 =?us-ascii?Q?ds+AC/BH7m2cL7oPGTb60tlQ6H6NAUROtJguYlBGWkOrXGGfZBc0WNpy5vR5?=
 =?us-ascii?Q?K7LovOU2BysWxXt6tUdJLBzSsLIXCQuvMYJ1uBYgH5nicd/NLA0zHPmhrwMC?=
 =?us-ascii?Q?S+N0pNMTuaxgK4ChzcLUwYbMG+6kOAADltzmtlk1ul3HJKShxNCdEbGYG6h2?=
 =?us-ascii?Q?pitEzQ7XqXkjgZoOt8C7t1N8Y9Nmev1tj9Q+ODO/r28pb1t4fjLHdDC2zsrh?=
 =?us-ascii?Q?RXM1+8PSm5snwldtCgwRuxBGmbHJ8CkZxWt+lnd+UHgd7pVwodNnaPrLu2Oj?=
 =?us-ascii?Q?52/PJAwrXPveGBEMMC+iyrnDq2o4UfolkvbXJ6dhA7euBl/yRE9zs6nisz7S?=
 =?us-ascii?Q?GMG4TXpygwwfKmGZK3p7btP0E7+dxi0/ypdxEvfiLv/f9CrK0LJh90gh9KfD?=
 =?us-ascii?Q?2BBiNeoSGhr7NjWoeNdFsv8HPV5XPQlRnnN1aU2WxCkt4iHSAoDi9lexF3N9?=
 =?us-ascii?Q?HOHoiP2h6VjAfsOVMhBe7lXGIAtyNaKFLtAb24efcaIQblwXCyZXWQJXLtV2?=
 =?us-ascii?Q?IvdFMlmi2vWhJSn9u3AeAQ08Y/vokoV7aYgiisjfyBqrnZAgXt9i8e76tTG+?=
 =?us-ascii?Q?B8qxkyslZNU+Ypqup1V3r35t51Pxzq4/S3Yqni4M2tqg7P9uXwrhn7pWDzzA?=
 =?us-ascii?Q?Jb5zTOtfnVjY6OoGyrqQhfI+A3OadhHWrF7EHCTOXsBN1UD9nk+R60VYvOwp?=
 =?us-ascii?Q?UnQ2OvtDPziKqDeNsew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db438b5c-10c2-4d65-b299-08dd61df8adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 03:31:29.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvGYPPNV6ow5YUmxhOQ36rFLuVrCUUyOCWP3GBG334h5p8N5DNvV3X6S0YgHDQgOqjzo1qY3sgP6YUh1J7zOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 13, 2025 3:41 AM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> Simek, Michal <michal.simek@amd.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Katakam, Hari=
ni
> <harini.katakam@amd.com>
> Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500ba=
se-X only
> configuration.
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> > This is not an approach that works with the Linux kernel, sorry.
> >
> > What we have today is a driver that works for people's hardware - and
> > we don't know what the capabilities of that hardware is.
> >
> > If there's hardware out there today which has XAE_ABILITY_2_5G set,
> > but defaults to <=3D1G mode, this will work with the current driver.
> > However, with your patch applied, it stops working because instead of
> > the driver indicating MAC_10FD | MAC_100FD | MAC_1000FD, it only
> > indicates MAC_2500FD. If this happens, it will regress users setups,
> > and that is something we try not to do.
> >
> > Saying "someone else needs to add the code for their FPGA logic"
> > misses the point - there may not be "someone else" to do that, which
> > means the only option is to revert your change if it were merged. That
> > in itself can cause its own user regressions because obviously stuff
> > that works with this patch stops working.
> >
> > This is why we're being cautious, and given your responses, it's not
> > making Andrew or myself feel that there's a reasonable approach being
> > taken here.
> >
> > >From everything you have said, I am getting the feeling that using
> > XAE_ABILITY_2_5G to decide which of (1) or (2) is supported is just
> > wrong. Given that we're talking about an implementation that has been
> > synthesized at 2.5G and can't operate slower, maybe there's some way
> > that could be created to specify that in DT?
> >
> > e.g. (and I'm sure the DT folk aren't going to like it)...
> >
> >       xlnx,axi-ethernet-X.YY.Z-2.5G
> >
> > (where X.YY.Z is the version) for implementations that can _only_ do
> > 2.5G, and leave all other implementations only doing 1G and below.
> >
> > Or maybe some DT property. Or something else.
>
> Given that AMD has been talking about an FPGA, not silicon, i actually th=
ink it would
> be best to change the IP to explicitly enumerate how it has been synthesi=
sed. Make
> use of some register bits which currently read as 0. Current IP would the=
n remain as
> 1000BaseX/SGMII, independent of how they have been synthesised. Newer
> versions of the IP will then set the bits if they have been synthesised a=
s 2) or 3), and
> the driver can then enable that capability, without breaking current gene=
ration
> systems. Plus there needs to be big fat warning for anybody upgrading to =
the latest
> version of the IP for bug fixes to ensure they correctly set the synthesi=
s options
> because it now actually matters.
>
>          Andrew

Synthesis options I mentioned in comment might sound confusing, let me clea=
r it up.
Actual synthesis options (as seen from configuration UI) IP provides are (1=
) and (2). When a user selects (2), IP comes with default 2.5G but also con=
tains 1G capabilities which can be enabled and work with by adding switchin=
g FPGA logic (that makes it (3)).

So, in short  if a user selects (1): It's <=3D1G only.
If it selects (2): It's 2.5G only but can be made (3) by FPGA logic changes=
. So whatever existing systems for (3) would be working at default (2).

This is the reason we didn't described (3) in V1 series as that is not prov=
ided by IP but can be synthesized after FPGA changes.
Hope I'm able to answer your questions.



