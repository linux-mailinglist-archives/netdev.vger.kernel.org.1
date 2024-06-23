Return-Path: <netdev+bounces-105959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36F9913F04
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5A1F21069
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD1184102;
	Sun, 23 Jun 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="D08FCFdQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2098.outbound.protection.outlook.com [40.107.6.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D264085D;
	Sun, 23 Jun 2024 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719183717; cv=fail; b=GC4Pyu0/j1RtgXmsn1l2GM92HvrggA39W0XYxHIBHa4dos0SQLy4irB7P4ZEKbr1k7eIkDSnUG0x6Jnx3MtSYJcW4xdX4/mVuVmDi/3vzXCoWvwwT1vI0CWGzyY59BVoRs5S13BRfG2FTmYfFWaTvG050hItEHPpRJqosWXrXdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719183717; c=relaxed/simple;
	bh=MKpuI6JpwPU46+sBVnad1kg9RAGSr+G7cn4dzwcV8Wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDYqmDH3hIMBShEbL6or0eZsqr54x/B+MMyoZJ+iBRNXH6/Uoe/P6weAE1Pb/uKOXMZpuZrZ36Ag5U6e97TtJVKL0o+RwBE0bgnaEHRe5ZoEwhnbKr//9WmUFS1rBkDC5k/WyXuzEUNdvSeDomWslFOd9X2ef3nFkHKQyZNJiPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=D08FCFdQ; arc=fail smtp.client-ip=40.107.6.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEfVI9eU8m/lasS6jf9cJbtkPF1rEnMOdaCAp5sJpeAWLKGwkQe/3gE0d21RTLaO+8UDE5sv0eI5oNWmCJomLhTlfe3aKgSnJIo9s0y7NVZt3B4SJ4u85SJ9AyQnaEfOx4runMIIYV03FufSqJpiDKAxQdwbetT7GT82ne44K5KsVbZyC5VWVkfq94R1TI2KSFtMYfOqpvsralvy4Nsu+z0FBSOmNrtZ5JWvziBvxVcKGXhU5iE0PQI2/rDJyKfG93SKhgSuPoYt9mdAEQg2ixa/u7rULzAC+D07x6qeCvoB5XthVAYzvGC3NEp9dP35gG6+HLmhA0xmo6swYDMLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4iNVw0zjFap5WoWID854yvf2Rf61EyvZo2LvA3p9hI=;
 b=OsP6YgsWx/tgKm0EJvk6Plma5B6TiiF6WR3+TjSeYs7VEN+s+AHE1nkYX7t1uLXT8rs1qsCZLCNFI1ANcbajT5QDeLZvlMub//X/TnxcIGdm9PUAonSd6fNISJJX+lPBv3INQSFHhf+YllokcFxa57iUrsDhfwZBnvHojcF9pSwT/biPumhnqyglvmp1Vn+SCabN6YaI/vQNGI6HIAwDcgKxFpTlnOZlhMbYSUEJQ4JTJocAu58iVBI4DfWbUAevbidyz1BwIZihuF9uCCOB6YDItrC+GNzLgoN50fu7tU2fpJM9RdZKag/rsbyLuiSGRe2uDqZOiDNL7H8YeBY9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4iNVw0zjFap5WoWID854yvf2Rf61EyvZo2LvA3p9hI=;
 b=D08FCFdQLrQW+R46/LIdK4GALsb0rLGGYuCtFraMC8YGdG2HuZBr+WqiAlAzW6WYs/6ZDHrsxd8WQzRR0IB1EWiBG72UTXZJR101eOJ4NTG/+tv4XxLGhUt366TacfZF7NgiSIiIeNTl8nX9ZKMJYtmM0O8HixN5m5X/ScbZEJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DBBPR08MB6044.eurprd08.prod.outlook.com (2603:10a6:10:207::7)
 by GV2PR08MB8317.eurprd08.prod.outlook.com (2603:10a6:150:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Sun, 23 Jun
 2024 23:01:47 +0000
Received: from DBBPR08MB6044.eurprd08.prod.outlook.com
 ([fe80::f5b3:3fcb:d608:bfe2]) by DBBPR08MB6044.eurprd08.prod.outlook.com
 ([fe80::f5b3:3fcb:d608:bfe2%4]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 23:01:47 +0000
Message-ID: <b023dfb3-ca8e-4045-b0b1-d6e498961e9c@genexis.eu>
Date: Mon, 24 Jun 2024 01:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
To: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, conor@kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 rkannoth@marvell.com, sgoutham@marvell.com
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B56.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:1a) To DBBPR08MB6044.eurprd08.prod.outlook.com
 (2603:10a6:10:207::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB6044:EE_|GV2PR08MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dd8d1a-9193-4bb7-8c9b-08dc93d87576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFIMjhlK1l6T09mYUJaUUd2alFwY0NZWGEvOWoyMDZaa1ZuMGM3YWd5R1h3?=
 =?utf-8?B?VDJwYTZLZTZNOTZIblBLck5FMzR2bmh3ZUNtRWxNWTk2ei9ZZ21XU1N2MzF4?=
 =?utf-8?B?WnFJRnV5NU5mQ0Vvb1V6WWhxc1ZNcnNJQjNxMmR0TXFsSktvWWdncWlFUGpn?=
 =?utf-8?B?OHc0YUh0L0V4cXpsQVl6OEpQZzZFQm9PMk9uRnFEMW1qR0RaLy95enRWaks5?=
 =?utf-8?B?SVRxa2E2Ry9zS2NVVU1acHV5aks2TGIyWVR5TWFDRGZKSnppTFMrejI0R0F3?=
 =?utf-8?B?aC9qZkRTL3V0ZmFuVFZCV2E5R3dQbmpEdDk2aktvWFB4ckl4YjNHVlc1U2du?=
 =?utf-8?B?T3RnMFlETWM4Nk5IZWlXT3RiNmd1Tko3aWxEVWo0WlBGWVUzUkxwL0xCK3pK?=
 =?utf-8?B?QWMyQzJmZ0Q0NkRTaGtxZmFaWUNGb1JZVFpmNjlMeXZCeTlNUkkrSVNqSWxL?=
 =?utf-8?B?c2ZmOUxlcXVaOFNmVmwxWDFDQm1DU3llUmVJL1RaNmU1OTdwTHdpblo5a3Vs?=
 =?utf-8?B?MzZVZ0lKVURKNVR1aC9SckdiUCs4alZ2UmFJdVZzcnFCMWxxQXlaekZ1R0NW?=
 =?utf-8?B?QXhwaGl4bGJIK1NtVHF4OVBIY0RUc0NsRDBpRnM5K2FXVlVZUTYvbUtxd0Js?=
 =?utf-8?B?UXB1amRSQ2JjeG5hd3NFK3pYT1o2OHZRdTVicWdqYno1QncvZXJVcU0ySjRR?=
 =?utf-8?B?WHZSOTR4bkg5WkFGSEt0a1Vyc0FNbUpMcU82aXJxVjgrRFVsUmkzNS9YTkNt?=
 =?utf-8?B?Mjc1Q01nU0U4RW5jUThzdXBrYTkyZUZRTzhzUEl1Z3g2VE5pQytoeENobHNJ?=
 =?utf-8?B?b2wwYmtUN2p5bU1tZ01hTGxoRGVLcS9xLzZtT1FWb01JVTRNNC9EdUl2QWR0?=
 =?utf-8?B?SEQzOWVLZDRWQnJqWW92MGhXVDdHWU41U2ZRSUNTLy9lZzZ1ZDl4OSthSFJY?=
 =?utf-8?B?eFJ4ZHArWU9hWXhXSStOOGxRUGpEUXcvay8wcUd3bkQxWUZ0ZlNhU0kvNElS?=
 =?utf-8?B?TXNTM0h4dnd4OWR6dUlxbVRSbmgrb0JnZG5BZ2Y1WVVoVlRXUEFqaElwZGhO?=
 =?utf-8?B?dnhmdVhDb0Ztd29oR0JGNE9IUEpDTGN6VGhkTGszVnVnalNWMVVmY2gwVFlU?=
 =?utf-8?B?OER5aTdFVVFoNGs4cHV1NUw3YVdFU1kwcVB0UnQ5M28rMHJ1SklBUXZwSS9I?=
 =?utf-8?B?aUNrd2NZbnJ6Q2FzeTFIMWZHUjZ1ak5GeFR4aFczdHltbHF2TnZZbkRONVJV?=
 =?utf-8?B?VlErVXdSZWNCeThycU80d09ETUh4L2NmMDYrd2VxUy9WaVBMMEVqRjZ3SFVy?=
 =?utf-8?B?VUQ2ZWZjU0FIVlgzcVV2SVdiZ0dMRkVlUGwzVnU1SlFPOEhKT29RSHpMUU82?=
 =?utf-8?B?OW9MNU13elA1bnVLcHAralc2YlVraUpxY3hqaDFkMzVHNmJuTVZLSVpsd1Rw?=
 =?utf-8?B?SzNNTGE2aG00UUx2U3Q2bnAwVFBYam9qR1d2M0JxNndURHVnQ2Z4T3dHVXBV?=
 =?utf-8?B?YVdqTFFFQkt1V0FnZTI1K3RqWitpQTJMUFlLNldVWUxVSGV6K3B2TEhGNG9v?=
 =?utf-8?B?N3ZCdGRZLytGUDB5eHlBMmZlTmthbEh3dTdjQVVROUxyRW9jRFljcWR1eEh3?=
 =?utf-8?B?UFkrZjZLQmt4eTFLZFpCdUNjR0Y2azhDeEN6QzVZRTBDRG9iYUwrekp2bkVS?=
 =?utf-8?Q?XVo+eg4ejXfp2anWgZ7o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB6044.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDM5cWZCM2hOalhnVVdCZmE4MEYvbUtYbjRPZjl4TEFTTDJPQnBYdGtIYmZs?=
 =?utf-8?B?UHJPU1czbFVHWGxkQTBQV1M5bWRrNXpiK0dxWlZhc2tMT0lYWWR5UjZZVEhn?=
 =?utf-8?B?QVJYMnZxQXN3RzkzdDVWREg2M0U2QzZ2RnNrbi9VTndjVjdVZlJ3b05yWmJt?=
 =?utf-8?B?V2pJSUhtVnZWbHlDNWt3RzFZUzNtY3d1Ny9wWkRneGhvTUFxditZT2YyTDZ3?=
 =?utf-8?B?TDNUemRXam5uVUFsNFpQRHdiODloN3Y0OHFGY1FqcHZMQ0J3anZoNHlCcmpJ?=
 =?utf-8?B?eHR4Q1hkRDloRnE5NDRuNDRnb0lwNkVjNnZjSUxGTks0czNuQkZqVi9VVWs5?=
 =?utf-8?B?RjVFNThhVTlDWkZRS1ArRGIyci9xcVllbGNvSlV2MWlBVWhWYTFPdTZXNXlE?=
 =?utf-8?B?N2d2YXFLd3dvRHYxalBlb2paQzY0ditHT0pBRmhsa2xsMzZhdGNTNlBNaVNa?=
 =?utf-8?B?QXREdDNtZExKT05RL29NM0RFL05wV3Q5d0RJcG1CK0cvKythSGE2Um9uWWQr?=
 =?utf-8?B?bG9maDlZTFQrSHhVYmdtOVNxZFUxNGNFczZleGFZTHQ4RVAxcG56VzYvM2hT?=
 =?utf-8?B?VEh5YVdKcWJKem8zY1RuMFNLai85bWsyNnpoMW04bGMyekpiOFBGUEpBWjJJ?=
 =?utf-8?B?akg4aDVwUExJK1k2V0ZBQmk1emhyTVY5bi9xTnBnWW0zb0RzNmRDczYxSCsx?=
 =?utf-8?B?THJaYmJWZ09WWm8zWVJ6dEdnSHFqenhmQVIwUDNWK3U0bXQ5NTdhYjBVNVZq?=
 =?utf-8?B?VmErdXpsMVRXMzBPSFdabVdOYU5Yb1RFdXM3WXVrQmhZWXFGbkN0RVBKaGN4?=
 =?utf-8?B?ejR2TmxjM3BJWno5V3RNT2pUL3BqZzZ6R0lhU25ScFU0eDgwMFpsd3lPQ0ZK?=
 =?utf-8?B?dWM5S0FBMFZRck5VTjlSME9oWmVua2VWUFBoTnAvclU2VFhSSUtPdTlQbG1H?=
 =?utf-8?B?TEFkYzhuYTY5V0F3Ui9ZcWZmRm5JNXE1UmErRzdQWmNkMkg1Q1M0NHNrelEv?=
 =?utf-8?B?dnlyOVpYQ1paTU5GOFJEUGVlT3NyVXhFc1VjaFVGSWZkR29vcmk2ZFcwYlZM?=
 =?utf-8?B?RjFwandPbmR0WXRuWWpBbHVGcXVZSlVXeHo3dDFtanJTNFhTTHprNmJVcnV6?=
 =?utf-8?B?SnRYcFhsN1FZYTQySStsU0cxWkw3U1dRbW52N0Vlay9GVGlMd0ZPMUpOYnFW?=
 =?utf-8?B?LzBUS3JRTU80enB6SlpJMzd3YUJ6MjF3UVBOYnFya3Y2L3NkZkJRWmlvVVlS?=
 =?utf-8?B?ai92ZVVYSC8zWWFBalpuaitWZjhqMTVjcTdzODFBS09DdjN6RmdLTVNIa3pU?=
 =?utf-8?B?R2pDWUx1c2tacDVKZTVOVnpNa00yYXhWUlV6RlNvVlpOaXF2UGtsZmtJUlpO?=
 =?utf-8?B?eTY5TjFQdnJMYUM4YWg2cTFUTTVhYXBBejhzSlo3aThQK2VHeHQ3NUI0YU4y?=
 =?utf-8?B?M2YxU2d0UWxqQUd3Q3RHcXpleWxMby9HOUF0d2s2L1JPR3JUVUc2dlROZDhM?=
 =?utf-8?B?OXV5K2ZmT1kzc3MzdnI1cnMxWlJHbHZWYS9ER1NVTFRIWE5SSDJEcEN6MTVT?=
 =?utf-8?B?MzdZejc5ZXgwQm9nMzJxNndjK3M4VEp3N0FUWTZqWktET1V1Nm1WZnh6Wkkz?=
 =?utf-8?B?YUdNTWdBemtxKzd4dDh0cnZWR01mdndPZDg5TitOODJLNkpnOCsyTkZVMVpn?=
 =?utf-8?B?Z2gvTFk4dDlFL29CcjIxWGcvMkRmR0I5bzhLU2ZPR3AxcjRwdHNrbmhVMytN?=
 =?utf-8?B?SHpxdWVSWE9DRVRGdDdzdFpmUU1JLzg3RHVTL3pvTW9mQTJZc0NpWS9aMWky?=
 =?utf-8?B?bGNXc1FFSURRM1NwRjNKUWdKQlpEZWppbE04VHRkdWlhSkZBYk0wcU1SUURi?=
 =?utf-8?B?QUczSXRVbVdNQVF2RjVUbWhtOVp3TDMzeXk0c3IxV1AxcEJ1ZzRpUmE2Z090?=
 =?utf-8?B?QjBJQzRUMEVqTEt0TTloMmllZFU4b1ZOb0h4TjgwM3F4ajBmT1dZNE5ReGs0?=
 =?utf-8?B?bnlEdC9zQVFWeFliemowRjExWEVRYWw5MGs5TDJCeC9BWlBpbHNSUkpLb1hY?=
 =?utf-8?B?bTM1VlVZK0dtbmNNdnlrMkRHcUJ3Zk5MSDBJMDVOdVFjVVNpQ254aXBaeWo5?=
 =?utf-8?B?bC91NmJIUGJTS1hHd3NvNW1sU1JyVHVINkV5eXRFdFozUU02Z2NtQ2Jla2N1?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dd8d1a-9193-4bb7-8c9b-08dc93d87576
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB6044.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2024 23:01:47.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVJ6sQh4aG71/nBg8EDiN/R7xlRRtTEpiPBI/cdE2N8nk8AqoB3U2y+lDYX7TAA18ssm7vDDI397zU/pvjqtjW0xbWM0NpmJWGcDLWSX6p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8317

Hi,
> Code like this is making me wounder about the split between MAC
> driver, DSA driver and DSA tag driver. Or if it should actually be a
> pure switchdev driver?
>
> If there some open architecture documentation for this device?
>
> What are these ports about?
>
>> +static int airoha_dev_open(struct net_device *dev)
>> +{
>> +	struct airoha_eth *eth = netdev_priv(dev);
>> +	int err;
>> +
>> +	if (netdev_uses_dsa(dev))
>> +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
>> +	else
>> +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> Does that imply both instances of the GMAC are not connected to the
> switch? Can one be used with a PHY?
>
> 	Andrew

https://mirror2.openwrt.org/docs/MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf

page 107 (text for 9.1.1 is relevant but not a complete match). In the 
EN7581 case there is a 5 port switch in the place of GMAC1 (one switch 
port is connected to GDM1).

This is documentation for another SoC but it should hopefully answer 
your questions.

MvH

Benjamin Larsson


