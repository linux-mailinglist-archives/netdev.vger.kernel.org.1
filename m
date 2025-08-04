Return-Path: <netdev+bounces-211614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41317B1A6F2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE073AB1E9
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173E1F1527;
	Mon,  4 Aug 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhuVLwGx"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEF2E36E8;
	Mon,  4 Aug 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323327; cv=fail; b=pnYfCee40y1WTqTaAeLNA805eBLCHJ0VFZ2dpycaMpSPJ04+ebQ895vCKEWRxoVlicgeHcu5EqQHBkW7PxlRYhiiIEKEFbP5BNgT2wLcWbb/6NnjNNEvcDWs0TzEicLlPTUjNMAPEk8CcqPukHklhUwaRbyS56+WFzPZNxIeGgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323327; c=relaxed/simple;
	bh=J7tEjEJps92uUY+Ufj5PDsgGhhbo0yJZwkswRHLDAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uWDkUgxxEZXya7svWxoC5QFqkSqhhlMuCLMtUuPeTDDgsr2TRyBBh5sLA4GhyVS5LqlqsjB1cCV1r6mQser1XX2mG43BN4WOBjDaOMt6OqbsycVr0lYffbuYKV2tWzF+Zb/0N1seQNAlJeNQGvUp0/VUkj9l8HApOLUpbxvm4ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XhuVLwGx; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXba/Qh4aWcc1+u8UFRi/zO1vVnzJ0gM6J7ZDNsVPotYtxLDFnWAJWMJ0ZGUt2x6P51NF12l3WXfTC75wGnan+iFHDzbmjhwRBSAQPFQGKZQfPoxUWkkATUNPUujkO6VtObw3zwjth2VIuNupl6cGzLvoOGbyBF3RWXmQ8bojcg8QAWOQx9ET2Pb9EA82R+sRM2h+dxxRaA3qiUh46SuqFQK5+sfhD9mtdEkjlL8A5r9Coh5SVQzKXJZcIIYdoIpD0aZTd3B2T1IakWJrR+blNTdb+Xgh5+2NGUoVy1cXXO6hwy/HZcDKtJ+tP3VkgVPkgGchUFDpATfvgb79OzLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N14zQ5VGPC+yB+KJsVGTsLrfQw4dkFr+axlOWC1tQ8E=;
 b=KMrQzmA77Y2hAzpMv1h2lF/C1wZKWOdngIeebpvsNxnZYXxYk31vglmt9boakgctAJuI8hP5/GQzJy38XbwWhOMKMLdDoJBeYG4/Tgmtn6gw4xvUsYOfas0m+6WQfYLGupFUhJhAYH4IlNS/ARGRYz+7Upxp9YNJ69vtILBTg1ZRYkuSMXNF9THB6HK2taZD1FVPWZxLn+QsvU1XzUCX3BKsvyrP667lIWcCFRbAs/54LM6agSk0mPHHqP+zkv/ocC4zKtiG38SiuXvn3toBknyjQREkk0bVoXrWyDEFK6r/SB6qH9QfF+78mvCwY1LYJPsQHOnVzXwPdV+2BV7AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N14zQ5VGPC+yB+KJsVGTsLrfQw4dkFr+axlOWC1tQ8E=;
 b=XhuVLwGxNOY6DSWXFpyvW6bUCqG/rHIsFktK9+xEaTcpiYweFoWwsgDKstdJMmPUSQ83UKBePr80VFJ7KhrQSf54nvvgg4lJOBzVUlcDkCUF+qcD/LY3HkmQr4Z3nS8OhTJctQHg3YZNRnwRyJP9aDY/pTdhslhGBQXm7BCCEzQ5HaAzVa4W54zGhnp1yxH97kw2DzCSMmUmS5KKi6u0UVmMua6b/FpiY/qHGHQt4aLi4iux9tl9V+GAchaZlSk8G0XLhqFJIEoytYUuP7tJ5hE+6uJn/LkPS5j/V6c6U6+qlA4hRIWNWyv4k3kDeTIiv3B2JeftOmHXdWHZldacXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 16:00:40 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 16:00:40 +0000
Date: Mon, 4 Aug 2025 19:00:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250804160037.bqfb2cmwfay42zka@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
Content-Type: multipart/mixed; boundary="gx7vsanqtnjz5di6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR09CA0165.eurprd09.prod.outlook.com
 (2603:10a6:800:120::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 432fc9ca-e935-4153-450d-08ddd3700f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|7416014|376014|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWNFSGhjeENTM243SUsvSWNnQXVpaGllS1ZHc3YxK3RkU0lpc3ZXaytCUldD?=
 =?utf-8?B?QmJzTldPNXc0enlEVml2ZzFHcGtLOGpkZ2FBZjl0Zmg3R096N2VhQmFFQWta?=
 =?utf-8?B?ZjJTUzU4SldGT0dWY3dIMzJBazR2c1cxUVR5RXhzdjdOQ3ZZbDJDUDhTVmdr?=
 =?utf-8?B?ZHJtSm5XZXE2THNkUW5hRkJTcTd6dVU1dzJoZ2p2TE1sRCtQYjJHWGcrZk04?=
 =?utf-8?B?czA2ZE1PN3I0VVJ3bHdXVjJ3bnV3RFFJOU0vZVBaaDcxWURuN2F2enNDUVox?=
 =?utf-8?B?L1NEU01LMjAxaENmZENvcDhqU3BQWkRMTldEQ1o5RlpLeko3WWFhdVRYU1pi?=
 =?utf-8?B?a00xZWpOVjZxdUw4VFhDL3lHWm5yQTZxSTZRQmhwZjRoVkVCYWhReExMR1Bw?=
 =?utf-8?B?aDBvWjc2VzZYN1QwT1dqSUhremVzU1IxRjAwS291QktCTUZ5SVU5TytxbzRV?=
 =?utf-8?B?anpBU014OHpJTWw2djdXTGpqRFdsZkdyQ1RjRmt6UFNubm8wbmx1VGRrZzN1?=
 =?utf-8?B?V2hZQ1F5SEoybnM3SENnU1ZhbzJaMklKSXNod0NFS1N3WDJlRUtaZ1hTd0ZC?=
 =?utf-8?B?Q281WlJuUUlUTHk0dGs4WndoVmNnMFJia0NleTlWZGQxRWFSVjF4dHo0UFBU?=
 =?utf-8?B?WHo0Qmw1b0oydmxXTVVrTmwwS1VkV3N1amszd3U2RWRYV3dwRkVZMnRoZ3I5?=
 =?utf-8?B?Z2owRkF6YnZKVU5KNy9UNlVDUGlDV2p3SWpYREkzSFdRSTZFUzZKb3lrSE9F?=
 =?utf-8?B?L0hUcURtYm5EUXFueHpPanRzaFpscWVzdjFhVDZRU1ZDR1g2SnNiV0pIc3J1?=
 =?utf-8?B?eS9pOUliUVpra0tuRGc2all4ajZ1MHZWcHNOSVloVFhzcU5BSmtadE9TelVr?=
 =?utf-8?B?ZVRrUnViaVFpbXlhU0FsOW55RWV6WmNvV1VPRUhROVBoOXZYcFpmeVRUM1JG?=
 =?utf-8?B?QllVSHBwbGd5WE4xeFpXK1hlc2FvcUdYYThHVEpFMTdURTk5ZVVCOFU0b0tX?=
 =?utf-8?B?VWg5N2Q2MVlJY2dnb2xPemxEUis5ZldMRGxzbVl0NHg3QmdlNHZBbjBaL2Jv?=
 =?utf-8?B?RG03MnNBUVNDR2ZSME1GYzc1WU5rUkN4L0l5WUhsZHVodUNsamt0OXlaa3BL?=
 =?utf-8?B?WGFwdTN4enNteFpEcHdDSHVSRVNabmtFZWh1QmptWkFqWHlsdSt1SXI3UmFy?=
 =?utf-8?B?UFdRT2hkbVJhYkZWcnVuV2MxWFNqdzlCZjc3cXoyVGcyak9FdHdlTlVTRTlw?=
 =?utf-8?B?NEJYdkNFTXd1RG5uN3orMDNJRGl4QmxHVUllUGQ4ekxvQjhuNXdwZTRTakpv?=
 =?utf-8?B?VWRPM0o3LzU0a3Q4L2F4RmE3aVFKbnNOWWJNeEU5SlU5QitYVmxvSEIvN1BM?=
 =?utf-8?B?ZGltdFczWXlXL1RQTkJHalNoUFRDMFd6enZHOUhKRDJDeDBxK05PR1ZGTVdq?=
 =?utf-8?B?WC9vVjZNK0NEL3d2cHVVVXBjcTl6STFDalZiM1FsQmZ2QVpnYnBuOG1GbW1L?=
 =?utf-8?B?QXRIZk8rUkVoeDFHZnNUN0RabWhnbGRiK1MzZWdBSXNDckhJanJ3SUNXVUd1?=
 =?utf-8?B?cXR5RURTRXNPSFdZK1ZObWlSTWF1Uy90YUphUExEdm5lUzZSZmowZW5leXZz?=
 =?utf-8?B?aCtsZW9xS0M3S0RHRGNPSVF3eHlBTUhaamZuNXdXYTE4cE90UXhpWElJeG9R?=
 =?utf-8?B?WGdaWEhOa1NMek42RWJYQndrdldHRHhQeHJHdGtkZjZrUlFOb3RwMDdQZmVJ?=
 =?utf-8?B?YU1ubStJaVNDWXZuT0M2ekljT2NwWEtvTFlwNUxuUXNYdkkraktZSUllcWFG?=
 =?utf-8?B?aTA2MFpQeWdEZDhEYUhOckFnSVpiemppbHYzcENuTXpwN0RCWVpIcTkwclI4?=
 =?utf-8?B?Z29iWnNWMTJSRzA1c3p0NWVHdFV4Y3pnUmQycjQ4VUZRZktJSFRXRWNwdWtR?=
 =?utf-8?Q?OGFH6tOhjps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(7416014)(376014)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZCYkdDc01zRlRCRnJBWjZZbnJDTVBnY21XWVlYeDhyYUhFUHFmeGpzL0JO?=
 =?utf-8?B?Y2h1NXBYck1lQ1FqaVpQUVNmR2tFYkt4YmpVOTcyWlFxQ1U3VTRlUzc0RUdh?=
 =?utf-8?B?M1JHYUU0NnB6ZWJYNUM2MWwxd01rSWhaMzd0Z29DaXU3TFhDYm9FTWt4Z3Yy?=
 =?utf-8?B?ejEyYTlwWHRUbzZadzVBTFk5N1FkSytNUlB0L1VHZUtpckdHRG0vdVBqWXY3?=
 =?utf-8?B?WWFTN1VMRmo2WDUyN3UrSDd6VG1LanZGRzlQSVVJRktSdzkxYS9wQ05MeTAz?=
 =?utf-8?B?VUtFZGZQWW5yVTFxVlRVYUQ2KzlDd2F2RFc3RFlHQU1tbSsxbENtakVpdW1z?=
 =?utf-8?B?M3MwRDBmQWZHbGU4Y09FTHJyM29tc2Y3NGQwck5hc080QzNzR2JXZ0pzV3Jj?=
 =?utf-8?B?aUxWdWtTbkRKRzZLTDN0OVNiOWRJa09SODhGc2hsbXJnUVZ1K0I2OHdidEJS?=
 =?utf-8?B?K1JnV3V3ZTN3ZFFyRlFTZFNFdzErWmplNHVsU3VtdWpRWkdrVzJldzdEWTVo?=
 =?utf-8?B?c1gvdi82VVBEMzZ3UDUzOGpja1Vlb2FrdGdCdHBub0RzM2JEOTBURUJpZmx6?=
 =?utf-8?B?TkV1QnUyazlVUGZ1MmZwa3UxbEc5eFRZMTAxNTNNSXB3N0NPRDZ1Y1ZPejdu?=
 =?utf-8?B?VUxkZ3pDaFJZZm9KbXZuc2o2WEk0RkRRZnFlcE1Dd2NuZndGL0QvaE53ak55?=
 =?utf-8?B?Q2w4Vm8xWGV2bEs0TC9LQVZUUGpZbzZNckRpZHR0d0k0a1pDT3ZkOTI1Wm50?=
 =?utf-8?B?SlVWM2NDUTk0a09zSnRnVXc1bVo2b1Iyd3RiUXRiWmFla2Y1VHNUbTlqbkVO?=
 =?utf-8?B?aGdxa0JMbkJUTExUVWZoZDVNQ2xVTkxWQ1VsZjViRWZ2WWFTbko3RndmNVBF?=
 =?utf-8?B?blpQSHdueUlNUkRHUjQzNWFZS2l2WlBvbDd3aGJFdjBlOE1LNGhXb1craXJL?=
 =?utf-8?B?em5XWXRDeVNuSmY2VytIcjM4REE4VXRyMzVzRWZycnZwa2NUU1VEY2JQejJj?=
 =?utf-8?B?YWlZTFBxM2g2RjJnMGNqT1U5NUZObmJFbkpQTWlhQjdyT0F0aU1UYXBFajQ3?=
 =?utf-8?B?S3NGK1RjR3c4YS9NVEV4dTVubmJ0ZHRNemxVMS80R2FqNXhlRUVibktPYTdh?=
 =?utf-8?B?eUVXS0lqL0dsd05lajVHdkd0enN2QkVHQVIwdGEyQ1hzU3oxYTl3aGdDdEF1?=
 =?utf-8?B?d1dZQjV0OThXaW91TU40a0pzN3haaFhoTlhIUngzU3JNZWdOaWp4TUliRUxW?=
 =?utf-8?B?U202dzBCVEwxUFcxS04zalgwSHpoRjEvbzZyQnRBNUtnekZsWFM1U1ltY1lG?=
 =?utf-8?B?N0RZS29EelV6NURtaXkrdG5CWWs5bHpkYlBVK2dobER3SExzczN6OW1UcUNi?=
 =?utf-8?B?OGxTZDE4L0RtL3JpVnU2OFh2MG5UMmdhV0FHUmZkYjhwZVZjSU9ObzBsd2Fp?=
 =?utf-8?B?VDQzbzVHMWNNRG0zanNKTW1PS3k2WTFEY28zNVZZT1JTUzRsNXR3WWJWSjFn?=
 =?utf-8?B?VVBCZVdmWVFqYlJ0d0FEUjUxaDJLVEs3ZEU4YUx6VWNFUVN6cElEaHBIMnBz?=
 =?utf-8?B?V0ZiRHNiQ3lkZElqNW5xVlVFTzExMFB0SUtRS0JhVkVHTi9jWVI1dlZvditk?=
 =?utf-8?B?b1dVVlZtUXZxOEI3cGhuR1dTSUE4RTVtR3VXc1ZmVkhrRGdJQ2UvUWJEdVpx?=
 =?utf-8?B?UjM4aFEvQ29vODczZ3ZjemFRSGswSytBM0VCMEdUYStHa205cTlnbG1xN3E3?=
 =?utf-8?B?VjJqc2xRSkdXa2ZzVjQ5ZGVVYmNCeEkzMTBBc0NwZ2lKK3RjQ2pqSXVjZGVr?=
 =?utf-8?B?c1E5SlBBN2tVYmVmY1p6TmlJQm13VDFNTU0vejdML2xnOEFEbmE1a0YvQlk3?=
 =?utf-8?B?THF1VVI4UmtKb0hhTmFWTWFTQkt5YkJzTkxSUXFXbTVlN2lCTHBNbXlrSTZa?=
 =?utf-8?B?WmZZQktucTJOZ0ExZmp1SDV5WitqWXBzbGdZNkRQRGozVDUrVFgzTmpDV3Yx?=
 =?utf-8?B?L2tWR1J2c3JIZ0xBYStDSnBlVUxKR2ZRdjhra1BHNmY3dUpLeXNzMmxubUph?=
 =?utf-8?B?V0RLVHJBbDRhNitROC9idjU3VUx1R0NXZDVzRUdrSXhGaDVHckN0RzZJVHEz?=
 =?utf-8?B?Smp6YlA1aXU0czFpNk5TZzIvQ3dzQ3JFNDB2akpiTzA1T3RkSkUxY2JNTk43?=
 =?utf-8?B?WmZ0eTRRNWM5QWNmdGQ3dERIakc1VFI2aVp6a0J3MGFQZ1Q2eTZlN0NxNWl3?=
 =?utf-8?B?ZXFwU2xUeEZvUk0xR2J0QURiSkhnPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432fc9ca-e935-4153-450d-08ddd3700f32
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:00:40.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJAt2ej8tlyWb9zFEBq+7yjILcyrwQh7NDPuY2roDlc66wdgnrD6jNhr6EgHmqdtWgG4wDDWnO7j/1gCTwnUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046

--gx7vsanqtnjz5di6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 04, 2025 at 04:47:03PM +0200, Alexander Wilhelm wrote:
> I’ve applied this patch as well, which brought me a step further. Unfortunately,
> I still don’t get a ping response, although the configuration looks correct to
> me. Below are the logs and the `ethtool` output I’m seeing:
> 
>     user@host:~# logread | grep eth
>     kern.info kernel: [   20.777530] fsl_dpaa_mac ffe4e6000.ethernet: FMan MEMAC
>     kern.info kernel: [   20.782840] fsl_dpaa_mac ffe4e6000.ethernet: FMan MAC address: 00:00:5b:05:a2:cb
>     kern.info kernel: [   20.793126] fsl_dpaa_mac ffe4e6000.ethernet eth0: Probed interface eth0
>     kern.info kernel: [   31.058431] usbcore: registered new interface driver cdc_ether
>     user.notice netifd: Added device handler type: veth
>     kern.info kernel: [   48.171837] fsl_dpaa_mac ffe4e6000.ethernet eth0: PHY [0x0000000ffe4fd000:07] driver [Aquantia AQR115] (irq=POLL)
>     kern.info kernel: [   48.171861] fsl_dpaa_mac ffe4e6000.ethernet eth0: configuring for phy/2500base-x link mode
>     kern.info kernel: [   48.181338] br-lan: port 1(eth0) entered blocking state
>     kern.info kernel: [   48.181363] br-lan: port 1(eth0) entered disabled state
>     kern.info kernel: [   48.181399] fsl_dpaa_mac ffe4e6000.ethernet eth0: entered allmulticast mode
>     kern.info kernel: [   48.181577] fsl_dpaa_mac ffe4e6000.ethernet eth0: entered promiscuous mode
>     kern.info kernel: [   53.304459] fsl_dpaa_mac ffe4e6000.ethernet eth0: Link is Up - 2.5Gbps/Full - flow control rx/tx
>     kern.info kernel: [   53.304629] br-lan: port 1(eth0) entered blocking state
>     kern.info kernel: [   53.304642] br-lan: port 1(eth0) entered forwarding state
>     daemon.notice netifd: Network device 'eth0' link is up
>     daemon.info lldpd[6849]: libevent 2.1.12-stable initialized with epoll method
>     daemon.info charon: 10[KNL] flags changed for fe80::200:5bff:fe05:a2cb on eth0
> 
> user@host:~# ethtool eth0
>     Settings for eth0:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Full
>                                 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Full
>                                 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Link partner advertised link modes:  100baseT/Full
>                                              1000baseT/Full
>                                              10000baseT/Full
>                                              2500baseT/Full
>                                              5000baseT/Full
>         Link partner advertised pause frame use: Symmetric Receive-only
>         Link partner advertised auto-negotiation: Yes
>         Link partner advertised FEC modes: Not reported
>         Speed: 2500Mb/s
>         Duplex: Full
>         Port: Twisted Pair
>         PHYAD: 7
>         Transceiver: external
>         Auto-negotiation: on
>         MDI-X: on
>         Current message level: 0x00002037 (8247)
>                                drv probe link ifdown ifup hw
>         Link detected: yes
> 
> 
> I will continue investigating why the ping isn’t working and will share any new
> findings as soon as I have them. Thanks again for your support!

Can you apply the following patch, which adds support for ethtool
counters coming from the mEMAC, and dump them?

ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0'

Could you then compare this to:

ethtool --phy-statistics eth0 | grep -v ': 0'

?

--gx7vsanqtnjz5di6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-fman_memac-report-structured-ethtool-counters.patch"

From 899d6147cc1f70f579dda2f51d9dd38d697f85b9 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 4 Aug 2025 18:45:48 +0300
Subject: [PATCH] net: fman_memac: report structured ethtool counters

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 45 ++++++++++
 .../net/ethernet/freescale/fman/fman_memac.c  | 87 +++++++++++++++++++
 drivers/net/ethernet/freescale/fman/mac.h     | 14 +++
 3 files changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 0c588e03b15e..c24ba6cbcb95 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -465,6 +465,47 @@ static int dpaa_set_coalesce(struct net_device *dev,
 	return res;
 }
 
+static void dpaa_get_pause_stats(struct net_device *net_dev,
+				 struct ethtool_pause_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_pause_stats)
+		mac_dev->get_pause_stats(mac_dev->fman_mac, s);
+}
+
+static void dpaa_get_rmon_stats(struct net_device *net_dev,
+				struct ethtool_rmon_stats *s,
+				const struct ethtool_rmon_hist_range **ranges)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_rmon_stats)
+		mac_dev->get_rmon_stats(mac_dev->fman_mac, s, ranges);
+}
+
+static void dpaa_get_eth_ctrl_stats(struct net_device *net_dev,
+				    struct ethtool_eth_ctrl_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_eth_ctrl_stats)
+		mac_dev->get_eth_ctrl_stats(mac_dev->fman_mac, s);
+}
+
+static void dpaa_get_eth_mac_stats(struct net_device *net_dev,
+				   struct ethtool_eth_mac_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_eth_mac_stats)
+		mac_dev->get_eth_mac_stats(mac_dev->fman_mac, s);
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
 				     ETHTOOL_COALESCE_RX_MAX_FRAMES,
@@ -485,4 +526,8 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_ts_info = dpaa_get_ts_info,
 	.get_coalesce = dpaa_get_coalesce,
 	.set_coalesce = dpaa_set_coalesce,
+	.get_pause_stats = dpaa_get_pause_stats,
+	.get_rmon_stats = dpaa_get_rmon_stats,
+	.get_eth_ctrl_stats = dpaa_get_eth_ctrl_stats,
+	.get_eth_mac_stats = dpaa_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index d32ffd6be7b1..c84f0336c94c 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -900,6 +900,89 @@ static int memac_set_exception(struct fman_mac *memac,
 	return 0;
 }
 
+static u64 memac_read64(void __iomem *reg)
+{
+	u32 low, high, tmp;
+
+	do {
+		high = ioread32be(reg + 4);
+		low = ioread32be(reg);
+		tmp = ioread32be(reg + 4);
+	} while (high != tmp);
+
+	return ((u64)high << 32) | low;
+}
+
+static void memac_get_pause_stats(struct fman_mac *memac,
+				  struct ethtool_pause_stats *s)
+{
+	s->tx_pause_frames = memac_read64(&memac->regs->txpf_l);
+	s->rx_pause_frames = memac_read64(&memac->regs->rxpf_l);
+}
+
+static const struct ethtool_rmon_hist_range memac_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, 9600 },
+	{},
+};
+
+static void memac_get_rmon_stats(struct fman_mac *memac,
+				 struct ethtool_rmon_stats *s,
+				 const struct ethtool_rmon_hist_range **ranges)
+{
+	s->undersize_pkts = memac_read64(&memac->regs->rund_l);
+	s->oversize_pkts = memac_read64(&memac->regs->rovr_l);
+	s->fragments = memac_read64(&memac->regs->rfrg_l);
+	s->jabbers = memac_read64(&memac->regs->rjbr_l);
+
+	s->hist[0] = memac_read64(&memac->regs->r64_l);
+	s->hist[1] = memac_read64(&memac->regs->r127_l);
+	s->hist[2] = memac_read64(&memac->regs->r255_l);
+	s->hist[3] = memac_read64(&memac->regs->r511_l);
+	s->hist[4] = memac_read64(&memac->regs->r1023_l);
+	s->hist[5] = memac_read64(&memac->regs->r1518_l);
+	s->hist[6] = memac_read64(&memac->regs->r1519x_l);
+
+	s->hist_tx[0] = memac_read64(&memac->regs->t64_l);
+	s->hist_tx[1] = memac_read64(&memac->regs->t127_l);
+	s->hist_tx[2] = memac_read64(&memac->regs->t255_l);
+	s->hist_tx[3] = memac_read64(&memac->regs->t511_l);
+	s->hist_tx[4] = memac_read64(&memac->regs->t1023_l);
+	s->hist_tx[5] = memac_read64(&memac->regs->t1518_l);
+	s->hist_tx[6] = memac_read64(&memac->regs->t1519x_l);
+
+	*ranges = memac_rmon_ranges;
+}
+
+static void memac_get_eth_ctrl_stats(struct fman_mac *memac,
+				     struct ethtool_eth_ctrl_stats *s)
+{
+	s->MACControlFramesTransmitted = memac_read64(&memac->regs->tcnp_l);
+	s->MACControlFramesReceived = memac_read64(&memac->regs->rcnp_l);
+}
+
+static void memac_get_eth_mac_stats(struct fman_mac *memac,
+				    struct ethtool_eth_mac_stats *s)
+{
+	s->FramesTransmittedOK = memac_read64(&memac->regs->tfrm_l);
+	s->FramesReceivedOK = memac_read64(&memac->regs->rfrm_l);
+	s->FrameCheckSequenceErrors = memac_read64(&memac->regs->rfcs_l);
+	s->AlignmentErrors = memac_read64(&memac->regs->raln_l);
+	s->OctetsTransmittedOK = memac_read64(&memac->regs->teoct_l);
+	s->FramesLostDueToIntMACXmitError = memac_read64(&memac->regs->terr_l);
+	s->OctetsReceivedOK = memac_read64(&memac->regs->reoct_l);
+	s->FramesLostDueToIntMACRcvError = memac_read64(&memac->regs->rdrntp_l);
+	s->MulticastFramesXmittedOK = memac_read64(&memac->regs->tmca_l);
+	s->BroadcastFramesXmittedOK = memac_read64(&memac->regs->tbca_l);
+	s->MulticastFramesReceivedOK = memac_read64(&memac->regs->rmca_l);
+	s->BroadcastFramesReceivedOK = memac_read64(&memac->regs->rbca_l);
+}
+
 static int memac_init(struct fman_mac *memac)
 {
 	struct memac_cfg *memac_drv_param;
@@ -1092,6 +1175,10 @@ int memac_initialization(struct mac_device *mac_dev,
 	mac_dev->set_tstamp		= memac_set_tstamp;
 	mac_dev->enable			= memac_enable;
 	mac_dev->disable		= memac_disable;
+	mac_dev->get_pause_stats	= memac_get_pause_stats;
+	mac_dev->get_rmon_stats		= memac_get_rmon_stats;
+	mac_dev->get_eth_ctrl_stats	= memac_get_eth_ctrl_stats;
+	mac_dev->get_eth_mac_stats	= memac_get_eth_mac_stats;
 
 	mac_dev->fman_mac = memac_config(mac_dev, params);
 	if (!mac_dev->fman_mac)
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index 955ace338965..63c2c5b4f99e 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -16,6 +16,11 @@
 #include "fman.h"
 #include "fman_mac.h"
 
+struct ethtool_eth_ctrl_stats;
+struct ethtool_eth_mac_stats;
+struct ethtool_pause_stats;
+struct ethtool_rmon_stats;
+struct ethtool_rmon_hist_range;
 struct fman_mac;
 struct mac_priv_s;
 
@@ -46,6 +51,15 @@ struct mac_device {
 				 enet_addr_t *eth_addr);
 	int (*remove_hash_mac_addr)(struct fman_mac *mac_dev,
 				    enet_addr_t *eth_addr);
+	void (*get_pause_stats)(struct fman_mac *memac,
+				struct ethtool_pause_stats *s);
+	void (*get_rmon_stats)(struct fman_mac *memac,
+			       struct ethtool_rmon_stats *s,
+			       const struct ethtool_rmon_hist_range **ranges);
+	void (*get_eth_ctrl_stats)(struct fman_mac *memac,
+				   struct ethtool_eth_ctrl_stats *s);
+	void (*get_eth_mac_stats)(struct fman_mac *memac,
+				  struct ethtool_eth_mac_stats *s);
 
 	void (*update_speed)(struct mac_device *mac_dev, int speed);
 
-- 
2.43.0


--gx7vsanqtnjz5di6--

