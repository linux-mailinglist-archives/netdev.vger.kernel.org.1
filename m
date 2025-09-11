Return-Path: <netdev+bounces-221995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB39FB5292B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FC73A45D0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD725D202;
	Thu, 11 Sep 2025 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gq8WQrAW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3F225768;
	Thu, 11 Sep 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573006; cv=fail; b=OSTzxBZgnGdK4mXY6ZxLTjpITRFc6BTMItNizuqUs526NYT5eaSH4Iko1hPMkMZ21zZbciPb5ZltRWDff5ZvQlV1k4+6kenkSjWJL7JOnPNVLWuLX18sBBfgYnFsZeSSiZcDXtftuyGDik0haKx/IIjZfVe8MLbvjqM+a+i6F8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573006; c=relaxed/simple;
	bh=UjEhNS3/5eLiaEhf0YMu54oMGFosQ+o0iuv8l4uROzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BggmWTddDX8E8bzYtRrcoQtZlTIIirMuWlKXNf0RWLvDaWTy0aiFtLTsN56fRaScSF4g056h+MYOhVkbs/AWiS6scfA/R2Z29XK7LipdMcBTyfDAlaQv3rhZi51HAa0pRMWkdgT2BOLAybW09QvBzpfWowR2krEs3IjYNNbbwAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gq8WQrAW; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5xNzQh6qwOlWCNILnRE3ct6QOlWRP5oGMTz9q+1NlXacEpfByMt/p6Fo0FMHeSpAIx1/z/1sy546MxeseMVstoSJfFMRLDoX+r62yOlHP4G/nds1mBHJ8G5tU3nWdbnkt12GCJNw6cHuZxmGQUOGqZLsl8sEKnfBDs+wRNLyN5J5OBD+GKrwNFAjpZlbtPz+tHPlMVZ58LZSNwvkKl0naywAnU4bVqZ3g9A4GELz2UeX4NbEhDXbCce2I+sH3OFDQ4kkLS7uLpVyiY/DF6MHv0Da/zWnLJo8crRH4mDYJUOsbM9BlPcJHQG+w9D0zO/TR7v5ZtE9VVWt5sjU2PkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KEYslCAI5HQwUasjH3rLqTAGRVpVA5r5NghIw7wgZE=;
 b=oLM5/anl+7rI4I7iQFmg92t0Stc8pUFR0oW9dxi2p1B/mwUyVexnHUkzphxcJ0kRVS8t529kbNfkIjPaDTgJz5JkmZeK+L/j/8dOgQSs8IrzPUNHgZVHN3TZcQFhd6WDipXPdCWUgsyYTqIP3uddyuKMJORwIkB8lX1rHig2xgPjnjdVdgDja3UFravRVuFVhOU6d/erc/TDrlhWE9QXr6Zfm6+reqzHXR9J9xyNJX8a7hSKooHQyUVPa41l6DtT7mnsSaCrS4oixTkgNaT/9KDQ/1xGBOxNRFJjnpJu8ii/twlxB99nL7+K2vGZDqpypSgJ+Dt71X7FOdJfp62zAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KEYslCAI5HQwUasjH3rLqTAGRVpVA5r5NghIw7wgZE=;
 b=Gq8WQrAW4LDMyBzzuWYSdfoHYscNjadj7O0SlAnarAAUZp65k/eFu9+2KpxZWKzHAN3L07EuClpzaQ/33WEsCnO2SLHK9NngPUmcxBg9y1r2znwrY3V3t8romoJBqR4I4R2yvtZg5jakfXyzPNVq5/ux+W1awTCNAiSA4rUoS8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:43:22 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 06:43:22 +0000
Message-ID: <ba25cca0-adbf-435b-8c21-f03c567045b1@amd.com>
Date: Thu, 11 Sep 2025 12:13:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/5] net: macb: move ring size computation to
 functions
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Harini Katakam <harini.katakam@xilinx.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
 <20250910-macb-fixes-v5-3-f413a3601ce4@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20250910-macb-fixes-v5-3-f413a3601ce4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::12) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: f162131f-76ed-48c5-9f94-08ddf0fe7feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UldJQWRzWGNFUlFrc2p1TzV1RWxQbzlYM1EzUUZnTEhvcUN1OFdHTkJpWkZv?=
 =?utf-8?B?MzA2c3FBRDd5UzNlYVFPdXZsQnVYanpIOHJPS1VudkRiSDYyclpPek9wdG1I?=
 =?utf-8?B?QWxBd0UvVUxqM3NKZVNBeVkyam04SWNvVEc3OEs5UXRPdkovUWtPSXRsYmMv?=
 =?utf-8?B?dS9wcFhleUQwZUlVckpBUmlCclNxd0g2MjNqSmhqNkJSWWt0bm5hL2drRGVD?=
 =?utf-8?B?UWk4ejczVnI2eDR4cWFJOS9YMzB0RzZRNkUxaDFBRTFiZlE3eWZpN1lXVkk0?=
 =?utf-8?B?bWh6Ymo1bXpEYkFvNUFyUjlUNHFGZEdtbEp5RDdLWGlYbExUaGFaZzZpOTl2?=
 =?utf-8?B?NWhtRkpZaWVXSHdhK3lNVDRQWjZsOThtRW9LSVlmNndCRUYzazdjd3NWdXYv?=
 =?utf-8?B?d3BnMmFnS2lXazVrSGdmYTBQeFRyZ3E5WGorNXhSZTdTYURnZkVSaHkvSlMw?=
 =?utf-8?B?WldXZnJUZGl0WjRjcktVeEJhYXh3OFpHL1ZKR3BDUnVCUUEvMnFCL0hPNndN?=
 =?utf-8?B?VkdncHVwWHZDbE5PMHk5Mmg2ZmhJYzVvbHpUclVOV1oxR1JCUTdaWXhpaEs1?=
 =?utf-8?B?d3owRno5QmNncHZ0N0tDdnpWWUlqN0RBeUorMGJRQ2Yxb21IT21YRjVSMkhk?=
 =?utf-8?B?Sm9wYy9yM0pDVURpR3o2aWR1bTI4eFBTRUZoenJGSkE0U3lENDN1dUVoMkcz?=
 =?utf-8?B?VlluOFJYK2V1TlU4Z1pBbWxBc21COHZUdEsvUW8veUN1WFVRRk5XdDZzQWZQ?=
 =?utf-8?B?Ty9JakhRaEF0MWcwMTF0NmlQY3BTNWVmU09PT2l1emxoaG4zMzZ5WEN4SlVp?=
 =?utf-8?B?N0piOW9hcUQzaFpCRllrVmRlN081U0lMY1hOMkxtQVNZT3lieno0T3k0dGlO?=
 =?utf-8?B?VE8vaVUvNEt2RUkwZXZJYTl1bjZmblZIankvcFdNMWdRdzJWSmdRb2U1K1ho?=
 =?utf-8?B?aDYzMnNjVTNtM1hlR1llR3dtMXpOTm14WGdGSHp1MU80UWFxRUhvdng2Z1RU?=
 =?utf-8?B?TTZhdXJBc0tZTFlFTXJHS1FQMWVtaytHdHB5QzUzeTFwRzZBMktZVld2bmY3?=
 =?utf-8?B?b002aldDMW9ScVd1MTZJeklKRXRwdzBNWGpHT1B2K3UrWGVSTnJlSENoWXpn?=
 =?utf-8?B?QVlSY2I5TUtraC9BVDJrMjNuVXpOQzN5R056WlE0UDdKdWt2dFlqSmlvNGh4?=
 =?utf-8?B?bE1Xc0Jlbml6Mk5rdWVKaWZ6MktUcE1MbVRvRTZ5NlVXNGFNRk5LWEpURklJ?=
 =?utf-8?B?d2tSdFRVS3VEL0ppK0VkWmhWYmxEaVg0d2FUSFlZYys3cEU1RTVKRG11NVhC?=
 =?utf-8?B?WGt0N2huMVloRFN3R3lBMk4vdnJnSVR0QVE2YVBqNHYwdFpjT1UzYkltUEt5?=
 =?utf-8?B?RVdEV2Nzb2ovSlp6REpad2d4TUUrNGMwZ1g2V21UL1pDaytJV0ZJcUg0a0VW?=
 =?utf-8?B?N01rVndZS1R1dGlQa1VnN2xSL2NYbW8rNzV2VndiejIzdTMzUFp1aWw1cXFu?=
 =?utf-8?B?ODJnZUZGN3VOR1cwNWVQcFpZRm4zTkFoZjAxbnlWZzl1STRLV3VuQzVHMi9Q?=
 =?utf-8?B?V3dBRGYzUkNTT0gyUWd5Tk96NHdYOXNEbVYzQUY1QlZoY1c2T09Fbjd6b3hU?=
 =?utf-8?B?dGY5Ymd2b01hR2h0QW9VZXk0Tm5QWHNWRThhdHpvV0d0MjZ0WmNVSGlBTUh0?=
 =?utf-8?B?M1d3YS9ZWHhxZUlYVDJMaDRTWlNuejZMOGxxUHY3TnNjWmJFL1hjZ1dNMmhF?=
 =?utf-8?B?eTlKWTJkdHNUWERhK1VEYXJiYkVpN3gxRWFJbEo3UGRYR2VpMjlyVTJjUEpU?=
 =?utf-8?B?bGJLMXV1SGlZU1ArL3ZGK3oyL01rY3AvRkdWZnU5eWhheVpEUVpJaEJMaElJ?=
 =?utf-8?B?aCtmblZxdmo4RUlYdkNwZmlKc0g2WERadk12azR3amdmbDRnUk14ZWVHUjBR?=
 =?utf-8?B?OEcvN1hXR2hlcVc2UUhKbG4zZXRHZmREaFh3K3NISno0d1Rsc1pGLzN2M0xi?=
 =?utf-8?B?TjNDZjZNeXlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WndvNG8va094VVdQZTBFYm1ZOTlYbWtlT3phTGhCUy81bHFkT1IwbVYrM0l4?=
 =?utf-8?B?U1UxbTU4NTJVWXliOHB5RE9uUkFGUW5JK2tnamd0ejc0UWhGeit5R0VvQVdZ?=
 =?utf-8?B?aWs1UlhVTXRZYXJlaHV0SGlNSHFnRDNYRFJQR3JueCtjV1pBV3U4TTU1S1dQ?=
 =?utf-8?B?OXRuWWRkQnJodk13anRReVVOaHprOHBIOWF3RlJRSm90bERPRi9GQzhlSzJj?=
 =?utf-8?B?QVcrcWtNUWNZMUc2ejdZU0ZpL01jd2RvdDFTQkIrNnhtMDVJazg1dHBZWkFx?=
 =?utf-8?B?WWh2SiszNlVBYmpXWm9XcGZZRHE0NzJUd0J2dXcvVUNFRElYSG5WVHlXVEcx?=
 =?utf-8?B?SUhoWjBiM0hoWStRUkc5OXdqRkV1djd2azgrNWhiY2VNMTJGUWNTQ1luTEd4?=
 =?utf-8?B?cU8rSjM2ODhyY0oyWDdqM05RYkJnZS9sZ2NxbFJ1R0RoczRyOHF1c3o4bnNZ?=
 =?utf-8?B?bnBRZVhRV25qTFhQeVU5OGQ3N3ZYZjRNcUxhbjA4MlhYZHJPYXNoRi9KbVNI?=
 =?utf-8?B?UFhQdERMRGo5cUsxRHR0dStqZk1DVjRGRkY1VC8yc3FqcWRPdVMycitwOTVK?=
 =?utf-8?B?c1hiS3EzMFZ1Y1g0U2k4azk2emZwNXo4ZEhjT2YxZ2IvMVBKWWtDZ0dCTjhH?=
 =?utf-8?B?VGxYQnI3QXc5M0ZkTUpaU0c4bG1lUkJZYXkxNlF2anozMVFpTFhYQWpQdURO?=
 =?utf-8?B?TkVQdHE0eG5BNlZsVjY5SU5FY1ZIQWlYNGZiS3dVR0J3aVBOZ3pEdE9iZHhk?=
 =?utf-8?B?S0NqUGc0cmRuays4TXJVWGtXbTZmbnp4bkdQb243TWF3OFd4dTBXNG9QWVZY?=
 =?utf-8?B?TW1EeFpmZUpSbExyN3doU3VNam9PVEl0bU1panR5TTFudTFUQ0ZwczdRZUIy?=
 =?utf-8?B?ZGFQdlFkaFcxSGQ5eXF2VzNCenV1OXdkK3J3U2dETmJkMGxqWUlDRW5YMHlj?=
 =?utf-8?B?NThLL3ZEUGtLSnVsMk1ONUpWUGRnV3FpTkw4WktDblcwUlBNOVNyVmRNYitu?=
 =?utf-8?B?RGkzY2RQc3VobzdSRmpwc3RlYjBtbDQxTmxEV3dOclNJOEh3eTRTTGNGQzFr?=
 =?utf-8?B?bkp3MmxjdEVFWmVTckJ1bW0xMlVCMVBSNUdzK2MzNHBJQ0Z1Tlc4bE83OUgr?=
 =?utf-8?B?SUlNd0NxbmFIUEFvcjJCRkp0ZXJSSXNEYk5nclhCZkQ4ZHFINlRWNUVBWnNJ?=
 =?utf-8?B?dFFyQlFMalZibGpoMTZSOENHVmY5VkxqRnY0WjliemE1QldFaVdadDYzT3F1?=
 =?utf-8?B?emxmdEN1Z2Vqc2hLc3UyYmZIaDEzOHVRcE0zUmN0V3hTamd4L2VvQWxkUGFI?=
 =?utf-8?B?Z0h2b1B4em9SNXhNVVFoR0k1ZS9kTE9hZ2dvQmo5ZDR1ZFBPak9OS0pXR3Nj?=
 =?utf-8?B?eC9EZHY3dmxZWU9EQVVHYUxSZWNUQ2F4YUVLYmZJemg0ZW1XWG90Y2JqYmJ6?=
 =?utf-8?B?UDdybU9ySmFCUlNFM3hvWENuV1VlOUtHV2hwYkg4akJvdmI3bWxYSitxcHYv?=
 =?utf-8?B?MTFjRHYwYXh4SDhLaUNuQ2NleUNWSFpJeUpjc0tCaTZHc0tVR0lxVVRqTU5B?=
 =?utf-8?B?Q2g0c0cwZlViRHBPMG1XTVZ6Nzl2V1ZzSmprU2tSSHF4Zk5ncmo1QUNWTjlt?=
 =?utf-8?B?b1JSMEZ3M3BOczVxaFpUQWtVTlJYUzRmMllFeE41V3BobEFkVUc4ZkM1UTE3?=
 =?utf-8?B?QlhDQzBzMkhXMzVmZjRpelNoNVk0bmtTUDJBYk0zUzEzUDM1Zzh1bXJkWmtt?=
 =?utf-8?B?S2xMMHlpSFR3L2RNQ0tDQUhjVmFqMzlIVXhsZllZdTRvZEZabFBxRlY3KzNQ?=
 =?utf-8?B?MUVwMXVpQnZxZTJ6UzhiRmN2aDZpa0VhWkovV0ozeHU1V0lva3R4cnlZdm1a?=
 =?utf-8?B?RjlpQU1rQXM4VmpidlpDREdxMjVUL0hLd2NSenNjKzZudkxRWU93cjdQbTl5?=
 =?utf-8?B?ZWpMZVpFbnhUNVNHQk1NK3FuQUF5UDNiTUZCMUtaelNwOEJoOEtpSWpmVFdR?=
 =?utf-8?B?a3pUc0dsNjN3SG80Y29QSmVqOWFwZDZzS2c1NUFHcjUydEZvcEdCWkFVWUhj?=
 =?utf-8?B?eUh5WFpCSG01S3VzaEVwd2x2TFFQMzBjQ0x4UTVmOXJVU1MrK3hGOEhncXMz?=
 =?utf-8?Q?6wSFVGn7ajV8mjd28XbcnqQ9G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f162131f-76ed-48c5-9f94-08ddf0fe7feb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:43:21.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95ex/wjpH84mW+Yo2pWSzmF6pyG3FiG2FyXU8oZx19xJhg+FCPdvdd7KD7Ct3cG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

Hi Theo,


On 9/10/2025 9:45 PM, Théo Lebrun wrote:
<...>
>   #define DEFAULT_TX_RING_SIZE	512 /* must be power of 2 */
>   #define MIN_TX_RING_SIZE	64
>   #define MAX_TX_RING_SIZE	4096
> -#define TX_RING_BYTES(bp) (macb_dma_desc_get_size(bp) \
> - * (bp)->tx_ring_size)
>   
>   /* level of occupied TX descriptors under which we wake up TX process */
>   #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
> @@ -2470,11 +2466,20 @@ static void macb_free_rx_buffers(struct macb *bp)
>   	}
>   }
>   
> +static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
> +{
> + return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp- 
>  >tx_bd_rd_prefetch;
> +}
> +
> +static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
> +{
> + return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp- 
>  >rx_bd_rd_prefetch;
> +}
> +


it would be good to have these functions as inline.
May be as a separate patch.

<...>
-- 
🙏 Vineeth


