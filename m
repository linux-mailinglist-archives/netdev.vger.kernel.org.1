Return-Path: <netdev+bounces-134250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263A998861
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE48281E14
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDB1C8FD7;
	Thu, 10 Oct 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jjvdjsy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811F1BB6BA;
	Thu, 10 Oct 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568414; cv=fail; b=J3mb1QmAesMQ8q3oHSrML7pCCOQBL3+Yc5NJUmLSCG8ZDR638qNi1AGLaa49R7C2o0nRl6OIy1OWWbxNSPA/RhPq5KGZH/4in3cf9r/Q+8ddbg0GgTDlwjSgM958ylyrZ14+WT1Q4QuQwQS3b2Mw87wl6qaewvruQ48WW81IHuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568414; c=relaxed/simple;
	bh=qYs25Vt4TsO7txtU4G9q6p54L1fmIS7QnIlPvQJ3zus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7H0I3/QPgz++hYiDv8pC4PS3ZMhCCs8/Nbb3YXDmBB8/nABzSsF38KRzYaLr5uc1Y9H+m7P/R9JqvMtGIefu/GA0Ttul3XFhDtg8yklm6oU8uiILhz7+8n6k+niyE4ZuWocSIX8POGX8oaOyosE8Z9RFbl0bppAAvGO3AvcpEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jjvdjsy; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH7pLh/aO4tn6O98XRleYr9eaTdvOY6JgACWliAmN7g9+8py7tTi4WtJTMNJZSDQk9rr9tjF7qDWBt+z9A/UXiMbIbcy+UPM92+/s+NFTELizTqXa4oD55310LpZLyszzmHG40pGubd9KNvcaYyNAkFcj8Foc+8tacgexYr4448IRkWdW1Iy6asMWwvNOiGGz1QGArJi+ccT99OvulKruhr5E5hU6cC4rj1MssxhKCQ/kxyfcQpwy1s1G7fhrzwGpVm0mwUepPeaokiL1i6nNV06/2CZUL44tZIJWi2Y3o8dGEm4FbLleGPCz2wKfVROUiUt5nOkcXWLzRUyF2Fljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLiZ7MQe/PzcYp5xVUJruO1Ipunw2PQQ5REc/IM1buU=;
 b=C2VSKHgl+Bi2k9F4YVtcYAbl1PGFJ9/QoXOgbWIOmwZUZmTfSkqvFV0lBA7gX3hUx9H47BEUa+twmw8D760JIphmd5Q9TZDgr4dh25rAGsA46dE9YuKJZXic13QXu2PvQ+9wT70s1rT6a5qx9W9mAA6NsVPc92jnEwzqkq/NVOY0AQh+vDUUnAFdcCPuXF/9ZW2fPODWUW0gk5RXiIKn/atyzjIMycQosvE4jQWB4rdEybhiuCp/bQP0owlPopF5/o5L0CCDeJi8cY7QJmyFxW3d+Zt9rcdJGj/5XdWSMIF/0ag2r2XCbudnAi7e8re1TPY2hfiKNh/+bTaqFR9tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLiZ7MQe/PzcYp5xVUJruO1Ipunw2PQQ5REc/IM1buU=;
 b=4jjvdjsy3dKgbnfD2zxHWcyo4uud5mJy5NsMbwj53hRjJXbLMIVJRS7MV3q+N8dCyRfeBvIP29SYKWq9ohzS2pkNFIG4EEh54YGOIhtTtVAY2jnsVpjXAIrT8CGBCd5tpiVsI0rurJJoOohReebNoKtmjPpOpiGspHuvbEJJDys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 13:53:28 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 13:53:28 +0000
Message-ID: <1450b6af-875d-4ee7-ae18-1f0a89e36345@amd.com>
Date: Thu, 10 Oct 2024 19:23:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac for
 given speed.
To: maxime.chevallier@bootlin.com, vineeth.karumanchi@amd.com
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
 <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
 <20241009083653.3b4ffd6d@device-21.home>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20241009083653.3b4ffd6d@device-21.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::19) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f094f10-c3d3-439b-dbc7-08dce932eb0e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGoyaWh5WkdRUStSM2o4YVRvRnAvbHhweXhHaVJaWWlJSC9OdllCTGFMYW5O?=
 =?utf-8?B?SzgwRE5veUg2bjJyaEdnOXN5bk4rdytHYkNwdE9lU3pnSXhMREhWcEFoQmJL?=
 =?utf-8?B?Z3diWEtiWXNueHdGY2hERjA1YTc1SE43SFFvTWM1amRJYWRsQTdGbmNwakFa?=
 =?utf-8?B?dGJQdG9WRHgvYm1nLzVORTB5emdmQ05aSDFLUER5eFpGMS9saDdGSmhlZXh1?=
 =?utf-8?B?U0lPRURWTE1Db1lIcmtRdTVva1BvTVJSSk5Ld3ZEdUwvWURCek9HU015Zkho?=
 =?utf-8?B?NlRuZVVrbDlPaUNpQm55b25uZmZETlM4YmVOckdUMG4yaS9jdkFiakxmMVo0?=
 =?utf-8?B?cHdWME1XVFdwT3IwQzFIVDlDMzE2Qm1YR1dyV284VFJueHFra2pkeEQ4eTUy?=
 =?utf-8?B?bGlLR3lxM0FRMVlGaENoZlhUWWdhUlQ1a1c4K0RHM2pzVkhNcy9GZWpmTUNE?=
 =?utf-8?B?cTZLQ0k5SkRBaFd0cFgxR0xKMWJkUCtLVWtIcVBXalU5N1d1TVZaVzBRUG40?=
 =?utf-8?B?MkJSV3MrWWgxNXZYQy9lbXNTdWhPcjVHd1NsekRheGpCNHZiVEJyQ3RZUFFN?=
 =?utf-8?B?SUhobHhSOFRlMlNzZjJXOUlGUGpuS2FtQW1KVkpxNHNjNnFYMW01cmI2NGEy?=
 =?utf-8?B?TmZndS9uYTB3cGJDUXpVcFBxZEU2MnVYeUlOSlFrb1JGa011OG1wblB4UE1D?=
 =?utf-8?B?RnJuMkNLd1U2ajc5N3FpbmN0UUU2TXFhT3ZtMFdSdXpwUkhHRVlZVDIvZ3BG?=
 =?utf-8?B?Zjh2RzdCNytDaDFHL2tCS2ptRy9MKy84SG9uVFVlaStXandSVWtzbkhFcXpi?=
 =?utf-8?B?ZWY3US9vRlFyVnUrS1QzaU5pSk5WZFR2UVdKY1BTL3hVTCs1THZUaGord0xy?=
 =?utf-8?B?enB6N1ZXZmQ3QTloQm1OLzVKenJSQnkrY01RUnFRQjdoL1lLaDB6NlVJcE80?=
 =?utf-8?B?TWRYVThxeEhZWUJFWkc0NC9URjVRSHdGaXpGUGNGbUVjc1RuemFTS1BFSURL?=
 =?utf-8?B?R2V2aTl3T2ZwMmNVNDlEV2d4VTNCQnN3Z29xQ2JYcG1tN2lJb2x3TFJjMkdE?=
 =?utf-8?B?d0plOWd6QXdmSm11eEw5RU9rMVJKWVlwV2ViTUNKNFpXL29UNVNpU25DK0ZV?=
 =?utf-8?B?Zm94OUVDNGphZ0EzbTFZNko4VGw5UW0vNEt1RG5xYnZscW0xMUhqWWx4MUZL?=
 =?utf-8?B?SlFkN2hLSzJvYkVlY0RvNGRZOGFiZFc0MEZ4YXRTZDZEaXo0dlhmNWlSaUZ6?=
 =?utf-8?B?ejhZODQrSXRpZ1R4azZVa2ZzeXB4MkJhUEpxUWUxUjNiUllYMjV3Z2lGZDcr?=
 =?utf-8?B?Nm9KQ0JuN2U0ekp6S0h0UVlxdktkUFhwQk5WVkpFRjBWRHk1bXkxM0NqNU1Y?=
 =?utf-8?B?blI5Q2lhT056cmFKMm5QZzc1WmxYclY5azN4a0tUdUd0aHNWZXhIMjVtbFc1?=
 =?utf-8?B?UXA4c2V4M2daUEdXMFVPbEZtd3RreEdOYTgrMVc1RDhaR05tSVVrTnVVaEEz?=
 =?utf-8?B?b01GcWRvSTk1MVJSR2Jyd1BnYVFmamNZOEgwcnNHTzlHOXJVSkxrS01vVXJx?=
 =?utf-8?B?bW51VXR6V2ZJOEJDWE83ZnpjeTZnTHhPZTJEcldZRlBCR09pdTc3MnFSMWlO?=
 =?utf-8?B?OTRtdCtXSDk1bmczczU2OXJXOSszWjlDdmE2MldiczZIejduSlVVdXQxb1BP?=
 =?utf-8?B?MzI3OFZ6eUNUcStMRWdwWnlZbUE2RStXam5LYnZ2Mmc3VVRHK3FxZDBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZobXlPeHM4UVNBbEtleUpTMFQ1cHJMY1dDQVg1b0tFZEFTWFFBZlRlNXMz?=
 =?utf-8?B?WDNNV0pZc1VWZ1l4R3F5WG1pQUdqdlZhNEpOZGw3cjlVSGlEblJrd2ViTVkr?=
 =?utf-8?B?eTVSWXJqNGVVVUpna3FYcWR1VDlubUlYR3Z0dkNHWGNRMnJZUDZ4UUVLZnpM?=
 =?utf-8?B?ZmpHQTFabXZ6dVhHRFFIOVR2VEFLdHRiMFlkNGNpcXJXNTVRVThpR2w5a0d0?=
 =?utf-8?B?M09SNHQrU2FKeStQekh2SzZCUm5wOFB4WnBteHNGdkIvY0VzMTdQT3IwZWlE?=
 =?utf-8?B?UGdTeTl3YmtPc2FjV2pMTVlsWFJJTTJIK0dnUnFjRmdiTWRRU3ZrOFVGb09w?=
 =?utf-8?B?UWJ1bVR2N1I0ZVgwTk5rYStqVlp0TDZLSEREa1pVd25aOXM1dmVyWmcrL1RZ?=
 =?utf-8?B?aktaaTlHVjRPSFlJWVBqY2lDQUpraUtKem94N0NXKy9GeVdVVlBuR0VCWk5J?=
 =?utf-8?B?UUFpZkMxZ0RBVXJ6eUw0Nkk4Qlg1V0lCTDRvQWJSOWF6Wkd2bTBXaGZVQklm?=
 =?utf-8?B?SVJablU0SWs2QXczMUVRek5QSDJ2Y0F4VFE5WDVqTElxQXR4S0RoQUZlQTlD?=
 =?utf-8?B?OVYxdmRtMVhiMU1HT2dIdWQvQWJjbksrbTFWeVAvcEdQbWs1amJmc1BQTHBk?=
 =?utf-8?B?Uk1hYVVuc0xpRmtlYWRVbDlLSVNFSVpuY2VNYmk5K3hSMEFVNHhvcFQ4TWN1?=
 =?utf-8?B?RXhiRXJxelovQkN3ZmJ1T3RjQUhxWHdnMGhvYlJnU3k2VnBidUVISDRuRXFD?=
 =?utf-8?B?K0pKN0xFNC9BWjQ1Sm85R3hDTENuSU55Qm90UGZMN04va0JPNFJxOEdaUlV5?=
 =?utf-8?B?T0Rlc2lyVkVIMkpZMXlCUS9oQllmZWFmVC8yeXhaN1hmRjlGNmIvaGtMYS9m?=
 =?utf-8?B?SmdKYjk4N1pucUdBRlNISFJwVFpQOVFwUFpkWmpQTlRveERoRnYxcEdMVFFV?=
 =?utf-8?B?NTRQT1pkbjY2c1ZGTTZtWkpCUHcvWU9YRG9iY2ZVOGlzUWkwNG0wTnlYZGRv?=
 =?utf-8?B?Y25VbnVpak56Mkd0UnJubVM5elNqQlpHcVQ0VExyVk9xU3lNRUw4b2xuN1Bq?=
 =?utf-8?B?VkJ6dm9PcjJZK1Q2Uk1pbXg0alJ0aVEwVlJtTXRHZUMyayt6RHRnY1p4YkxR?=
 =?utf-8?B?WkJ3MEUzN3g2ZTQxVHoyaisrb3p4MlNlZzJWRGxsMDhLVjJ6MFVzTGliaHdr?=
 =?utf-8?B?dDZIV3A4N3RHY2hTUW4ycC8yVk9iaWYzbUZxa1FxVEhEc1huOEF4THl6Vms2?=
 =?utf-8?B?K2o0YW10U2g4QitvZDBxY2FleWp2OFFWdWdZck04aXVPV3V1amNlTXVUOGFH?=
 =?utf-8?B?R1RPejl6SWFVK2Y1Zm01L0tUUVpuc3VObjJOQnUxNmN5N3FwOTBsN2daNVBC?=
 =?utf-8?B?eWtLT2E2NXhqOFN5UW5HdTU1bXg1bjcxemtISjVZMjhGemtyRkJpMmd5K1JR?=
 =?utf-8?B?ZFNqUzNpWVpwQS8rYUtnUVYrbVRhb0RMODZBSmtaa2N4cmF3aGg2cmMvMWp4?=
 =?utf-8?B?TmRlVHV6ZjFFWDYrVEtSS3dYVXM0QVpRTUxnVTBxQkwrWVAwOGVWVFJDQmVV?=
 =?utf-8?B?SU9seVpFNXhlZDAzRHYycytaNVYra0ZQa3FOTlQzd1dJOVgrcGkyakR2SlFp?=
 =?utf-8?B?OGkwc3V1dTYwaGZMU0diUVhtNjdxSDM4NW9qSG52eDhyY29kQU9rb21zTkpE?=
 =?utf-8?B?ajRpQzlCMFg0amV1NmtkYktGaS9UWTBCa2dLMjEyQUlLTy9IYjhuWUk0SS82?=
 =?utf-8?B?WDV2amRuaW53TlNSQ2s5ZjJicXVyVUg0bGZmSWxHZklQY0dCbng3YmVWR29Q?=
 =?utf-8?B?aHVGN04xRGRKbDFVd3hpSlNLak5DMTQvN202UGtTMHBTRzNwV0pqOTU0NnBS?=
 =?utf-8?B?cTZTcVJqeG1pOXFwLzh2NklPWGJPUis0dzVNN0xCQ2RMOXRvU0pBUzhVSUk5?=
 =?utf-8?B?bWs3ODVHeFNoaHEzRFpQWi9wa2RIaDZZc1dqdDFFQ1lad3gvRWJpL1dFWjVw?=
 =?utf-8?B?ZFp6ayt4ZzRSUFVGMmFneDl1cWkwYzd4ZStkWHVNUjlVbWhsNTNCaWdzSzE2?=
 =?utf-8?B?V3dXVW9xajlna3g1RXA1ZUZuUHBGYTZTQks3bCtJbHU3NlczbXE5OWcxbElm?=
 =?utf-8?Q?gFMAYNMz/c1nll97zfuPr1CKU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f094f10-c3d3-439b-dbc7-08dce932eb0e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 13:53:28.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js1RjzWNr+cK7HEMkU2wLZMso/DA8OKfZVIfUD6ny+bENdJ8I8CHl8ipDUwe7ulh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

Hi Maxime,

On 10/9/2024 12:06 PM, Maxime Chevallier wrote:
> Hello,
>
> On Wed, 9 Oct 2024 11:09:45 +0530
> Vineeth Karumanchi <vineeth.karumanchi@amd.com> wrote:
>
>> HS Mac configuration steps:
>> - Configure speed and serdes rate bits of USX_CONTROL register from
>>    user specified speed in the device-tree.
>> - Enable HS Mac for 5G and 10G speeds.
>> - Reset RX receive path to achieve USX block lock for the
>>    configured serdes rate.
>> - Wait for USX block lock synchronization.
>>
>> Move the initialization instances to macb_usx_pcs_link_up().
>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> [...]
>
>>   
>>   /* DMA buffer descriptor might be different size
>>    * depends on hardware configuration:
>> @@ -564,14 +565,59 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   				 int duplex)
>>   {
>>   	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
>> -	u32 config;
>> +	u32 speed_val, serdes_rate, config;
>> +	bool hs_mac = false;
>> +
>> +	switch (speed) {
>> +	case SPEED_1000:
>> +		speed_val = HS_SPEED_1000M;
>> +		serdes_rate = MACB_SERDES_RATE_1G;
>> +		break;
>> +	case SPEED_2500:
>> +		speed_val = HS_SPEED_2500M;
>> +		serdes_rate = MACB_SERDES_RATE_2_5G;
>> +		break;
>> +	case SPEED_5000:
>> +		speed_val = HS_SPEED_5000M;
>> +		serdes_rate = MACB_SERDES_RATE_5G;
>> +		hs_mac = true;
>> +		break;
> You support some new speeds and modes, so you also need to update :
>
>   - The macb_select_pcs() code, as right now it will return NULL for any
> mode that isn't 10GBaseR or SGMII, so for 2500/5000 speeds, that
> probably won't work. And for 1000, the default PCS will be used and not
> USX
>
>   - the phylink mac_capabilities, so far 2500 and 5000 speeds aren't
> reported as supported.
>
>   - the phylink supported_interfaces, I suppose the IP uses 2500BaseX
> and 5GBaseT ? or maybe some usxgmii flavors ?

with 10GBaseR, ethtool is showing multiple speed support. ( 1G, 2.5G, 5G 
and 10G )
The only check I see with 10GbaseR is max speed shouldn't be greater 
than 10G, which
suits the IP requirement.

>> +	case SPEED_10000:
>> +		speed_val = HS_SPEED_10000M;
>> +		serdes_rate = MACB_SERDES_RATE_10G;
>> +		hs_mac = true;
>> +		break;
>> +	default:
>> +		netdev_err(bp->dev, "Specified speed not supported\n");
>> +		return;
>> +	}
>> +
>> +	/* Enable HS MAC for high speeds */
>> +	if (hs_mac) {
>> +		config = macb_or_gem_readl(bp, NCR);
>> +		config |= GEM_BIT(ENABLE_HS_MAC);
>> +		macb_or_gem_writel(bp, NCR, config);
>> +	}
> It looks like you moved the MAC selection between HS MAC and non-HS MAC
> from the phylink .mac_config to PCS config.
>
> This configuration is indeed a MAC-side configuration from what I
> understand, you shouldn't need to set that in PCS code. Maybe instead,
> check the interface mode in macb_mac_config, and look if you're in
> 5GBaseR / 10GBaseR to select the MAC ?

Yes, agreed!

As our current HW setup doesn't have AN and PHY, to support speed change 
using ethtool
I have moved the above MAC config into PCS. I will explore on setting 
MAC config based on speed
instead of interface in  macb_mac_config().

Please let me know your thoughts and comments.

-- 
🙏 vineeth

[...]


