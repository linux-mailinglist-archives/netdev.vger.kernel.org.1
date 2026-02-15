Return-Path: <netdev+bounces-258779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AulvDhXckWmHnQEAu9opvQ
	(envelope-from <netdev+bounces-258779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:45:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3613EE3E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97025300399E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3128C849;
	Sun, 15 Feb 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QMWfSevp"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38686331;
	Sun, 15 Feb 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166736; cv=fail; b=KuFl2yMx7ntv+UzMm2rOaRFZ/G1wE0Jt5R0UKVoCehmXYFM9o9E+V8hUh+XQFpfBYvuFmElAVDDjtR1RE5AcrZ4pKw0/vZyPMwF4Bj7zgknOu4RoNd8EQrvNSl26DVsUTYaDpYgHz6yRTvwW/lo429H+6+mo67XkY6BqVqxxcp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166736; c=relaxed/simple;
	bh=NZ62VnmgFFBERQtplcrvV5DbFHK8Oz97DsbjbOKWTn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Shm4UAY7seFCrZwc+QIx165WE9j97gsxYbFJmxLRWXJFHPf4utYCFyDk18jgkZ6btq8SuodaY8Q8xwi0LPvXeMxnTJ5ixiv3PvOSS4WSLLrEjnnFLRDEUigJUcI73FoNUe93TC//IeQLSJLn2Y3O+kUFxlTSTNcfbzGStXL1+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QMWfSevp; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAnvnTOsPjlqKTUnDv61aoYktEidIEEOcHH+LdZXmXqun9Se4Txn8mem4yg7c60JwMOt4NPCgxL8VrByDLmWEPoy3E/CfM3ylEPLhtk1xQK5JyLwcmadMUQ0pvEyQ7Q2IpUj9JaUoQgl6CkX2g2V3L0zAD15hG84pMG/hUr/kiP9pOVRCS4/Wd5DN7wvAunF8raNvN+fMqT6b31ASSpOVwbQ5ApcpyJlGxzwnwt48pTV69LntXHBytew8eC4zkw1UZVxkZEI+NG1w23qG5LAtvF7exe0xZdlwZ+baJsNs2/y3uk3dSde8KU0tf8wBdbQWGmUeG5uyiPXo/zB5ZQQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El56DphfvOe28WhOR/YsG/k7ebDe0COpBiMiopS9+vQ=;
 b=okuuUtk6gUa3VCG6bDvmFK0Y5eZ9q4JXg5BoHFLQXbtxxRyhnKBEYnndJ5EmIsu8UKg/HRUxGmRMYsiNAAkzJRqYY1EHDZi/cfbrz348WsuhRVblHYNc06Ufv3rudAYgMxdmSUB5j08G6pFsyr2Q6I6UPUj+KHOk5RsHHKcUCWDeQuxtVDYcc+4EUQ+BKnp/3LGBd1u49MaOXxfZS51pZyaDYkSh2Wy6Cyr/GtWIzUhNE0JbZ5Sc5QDwY+J66ey8CuZlG4YfKmFPfHVOps7Zt1UaIs+22r7HaAgs7RZ2njyXkzCZAjFfefEHJdyhIkEpmFJZyAzBFkjnRb7HK8rSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El56DphfvOe28WhOR/YsG/k7ebDe0COpBiMiopS9+vQ=;
 b=QMWfSevpKn3JmeuZjVyYh5sZTS+Dw0FanqKa79q8DHrqspDW3JVU41MehHScoN3wBCW4jS5wxoilOgxaVEDGz/Kmay0deTVli89iCsGtNJyL/l0MmzLvqDidTVW5AyeeGsfnXnl65MCq/Z77hXt3XIpzedDfBcB+e/6Fcd96qeQ=
Received: from CY5P221CA0127.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::13)
 by LV8PR10MB7965.namprd10.prod.outlook.com (2603:10b6:408:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 14:45:30 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::98) by CY5P221CA0127.outlook.office365.com
 (2603:10b6:930:1f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Sun,
 15 Feb 2026 14:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 14:45:28 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 08:45:28 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 08:45:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 08:45:27 -0600
Received: from [10.249.132.38] ([10.249.132.38])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61FEjNdF319905;
	Sun, 15 Feb 2026 08:45:24 -0600
Message-ID: <06ff0e10-f412-44f5-932d-f14a0044181e@ti.com>
Date: Sun, 15 Feb 2026 20:15:23 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net] net: phy: dp83869: Set auto mdix bit
 for forced 100Base-Tx mode
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <hkallweit1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
 <a498b310-29f1-4775-aa65-fda027a3124b@ti.com>
 <5929eafb-6101-4570-beaf-ed08ae109423@bootlin.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <5929eafb-6101-4570-beaf-ed08ae109423@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|LV8PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b3720-05cc-46ce-3845-08de6ca0dcad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUVJWDRaT2VOSVJ3V056TnZZcEYxaXl1WDVwY2JpcGFVbmJqY1NWbUIveERW?=
 =?utf-8?B?bCtBYUprTDhpcmhLb3hqT1NPSEEwUGNQMjVGejZLUlg5YzhxbXJzTTZpUWJY?=
 =?utf-8?B?NzdraTQ1MmR2RkE5Yk1jcTJQQ1hFREJKdnAvM1VTY2lvMkRLTDd3OEFsUUM4?=
 =?utf-8?B?Rk51R1Nqdk1NT3hHcWtvbW1qY0RhQ0xzQlNqc3NNZi96YmZiMzUzaHIwRTJv?=
 =?utf-8?B?WXZHT0N3YlQvWjJsV2E1OXRscURGcHFaQXhMMGt6RkE0RkF1ZkFSQnk3SEJh?=
 =?utf-8?B?Y2djeFdsYndWeTN0T3pvK2lrNnBSdW1VdTBuQktScnBqMWpQUHBYdmZ0UUFZ?=
 =?utf-8?B?emkvUCtLUHZ4WDh3ZExoVjgvbVJ6MGRyWmN6ZGlwTGtjS3NPYmNaa25TSCs5?=
 =?utf-8?B?ZjBXTFVkVVdqSW5QVUdRMUJaRi9XeUZSdU4wSzVrUVgwNkR0aUhWVVFyQXFx?=
 =?utf-8?B?NmhUeEwvaGc2cHVIZFJvdklTNVpVSmxGYnd6K3FZMFc1aUowQU9JRXpnVUZF?=
 =?utf-8?B?djZ1YUdqdVFPK2FUUnhLZytMb0tGY1p4ZU8wZjhVTkdVL2tNYVdkNXlCVEpN?=
 =?utf-8?B?K3VvbnQzVHVIUGFoaTRRREdBWXVDcmI3emVhQnNvOTZBQkI1UnlaZzNqUTR5?=
 =?utf-8?B?RGpHeWVlU1R6bURwVVRzaHBhcUp5NzJoMEZKbTB3OXd3VCtvdFpXNzB0b1Za?=
 =?utf-8?B?NnVVNnhFREQ4ZUZWT1NFUm5WLzB1eEQ0ZXV3Sjh4R01ad0kzUWs4OGVFSlBI?=
 =?utf-8?B?dzJEYmM0L0xnM3BiMVhkeVdsZlBDK29ORGRPODJ4c2ZSZ2FiRkZwNUJZVEdJ?=
 =?utf-8?B?dlBiY212TW5DOU10bEtGUnFzbkhvT0Yrd1hRNEVjMlJPQ3FDMmFWWkNiQkc0?=
 =?utf-8?B?ZDF3dUZFbXZKRkxDSkRadDJja1VvdzcwTHZ4b2pvU3pDWktoUVAvOG9kbzNS?=
 =?utf-8?B?dkxNZXZSeFEyajhsYnJucm1QZVRiZW5hSllEanppM3RUaStrZGZuSkZEOG9E?=
 =?utf-8?B?Y3kwYUNDVkJPejBwdWFWN1RwcjQrR2RzUWRncWs0aFFWYkxKSFNvc2JTam53?=
 =?utf-8?B?dFpkMGd0aWpOUHNKUTFkSlNuZUNrRW9NaHl2R1lUcmtuMk5GRVhKMGFKQ2xV?=
 =?utf-8?B?VXlLVnJPRWt6cWZweVBZbkNYNkpGWmpVaGthUW9JVXljUXNKb0p2aVd4c2VE?=
 =?utf-8?B?b2xLZ0dPUlcvNVpWVEhWeFJKNVZHQWRXMlB0dEZjc1VMTHd1N1NjcEFYdkVM?=
 =?utf-8?B?VEVrckpQVG5zNXBBQURSVDBmODRzcUpkb3lMUVc0ekpNbnl1ZnN4YVpOQVZ1?=
 =?utf-8?B?dWdxZTNYNStMdUVmYjk3THFzSEkyZDhlekk3bERabHN2UlFpaE9tbnI3RlFw?=
 =?utf-8?B?Y1h2QTkwWjIzQWhoK3BORUdRRE01MFR6M1hQdGYvWXVLM3dXU1NxUWVHR1ZE?=
 =?utf-8?B?NWRuaHdBbmhGTlFDTm1DNTRXaFhDclZnNjVsMjhCR0Y0VzltRHJXOWFSSzBn?=
 =?utf-8?B?UG9nQVpTbmxGa2V6K2x0U0g5YUVXNExEOWhpTHl5ZlU4aXJPZ0JTU1ljQkpj?=
 =?utf-8?B?bGh5T1lrNWJMWXZGclNVanJsc2NuemZrSHVTcFdFUlljY2xkZUlKclBlQzBC?=
 =?utf-8?B?MkhCQTRBeGx3NWVHOGV2NHNNY21BZXVtUnZSaXhheDB4Y3FjN3VYUTRlUnBj?=
 =?utf-8?B?VWJXT2lQaHB0WHZRTHozcmVVMklpQWVscE5rQmorSW9aNzB6MzMxSnd0ajlE?=
 =?utf-8?B?QW4rUHJ6Ri8vZEZlWFBRTDFEa2JjWUttN3BEamNhaE5NZUtVMm43MnY3SHIv?=
 =?utf-8?B?eU9sSnIzNy9XbHQvUStuN0luQi9FenRXcW9vZnJ6Z2ZGdUV3ZDFWTTlmb0Fm?=
 =?utf-8?B?TGd5QVFzUU5qeDloUExIN3Z1dHF2RjFBcVBiSE1jOFRsMGU3VzQ4NmFCaExY?=
 =?utf-8?B?SlpaOGgzdGc0STNaTHlYR1lzM1dyYkJZN3lXb0VEOURzM2YvOWJxcnRoOFdT?=
 =?utf-8?B?SUtlZ09GaW1yN1JrWTRBMm5qWVl3TVZEcTFndHg4KytUMCtGMmFKa0xKS2Rk?=
 =?utf-8?B?SmtCTmdFejBYcWFlNlYrdXZ6QWpYOVJmeWpIYjZsTnQzdTQydHdpQjFrMHRS?=
 =?utf-8?B?Q1RPUlE1NElFN2RFQ3l5eXlNVGQwY3FDUmZMT29rZGlmWjF6clA5NDlJWE5l?=
 =?utf-8?B?c0o1ck4rSUcwKzlMRGxRcUdMcW9PeVo5aGxHdUdza25ZRFFraXdzZDFyTmFt?=
 =?utf-8?B?VWpQZk44cHh1VFp5K3hmdlRSWVBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	onBzw+ceAhLif8sHM9OTE27IxzvNjX59STCPinLGBCRfEJ2yzYrZ1EWnNFpwMxGJdT0CdyW7jc/1Dd/kC8mTqfxN1F5wFj87h3dsA812tVdMFt1cH1M+R5QOWkvP1hoWikY7DMoSPJfJrvnIb7MDfF7BOIRVBidE3138zrKoXPG3I5oFQLKKByNL3QSVoDJK4uUuITtuTVSIpz6tqCKsHqmi2EOhFZm0CUHSJ5pkrzOJzIwO68Emr2Is2PE4ccjOamEUI4k9vafTlwiMqkyq+3nbXUWZWKRuOp6YtKxJbbe33+IzLh+UhbflkaAvMDIwGnXO65RLow51yWAhuovxTavxG30HT5Ut9nEB/gGljqVhg0KoaYXQJz62Ol8c09QqKLydd451cPFz8WitpJxhF8BTH5RDCemEdXbTNSBt4DdMzwOO+7ZJMk8VsRS+NQMV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 14:45:28.5284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b3720-05cc-46ce-3845-08de6ca0dcad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7965
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ti.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 76A3613EE3E
X-Rspamd-Action: no action

Hi Maxime,

On 2/13/2026 12:10 AM, Maxime Chevallier wrote:
> Hi Meghana, On 12/02/2026 07: 21, Meghana Malladi wrote: > Hi Andrew, > 
>  > On 2/11/26 19: 42, Andrew Lunn wrote: >> On Wed, Feb 11, 2026 at 06:  
> 40: 32PM +0530, Meghana Malladi wrote: >>> When using DP83869 in force 
> 100Base-Tx
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uvdqvDfOXMcx4EXE_POD_-6kkowIhAz8zXLHMFm81_iVEIIhL4AZYTCCg5LBLfOFsQIbaQidTlj5ZWaMhdH1sacfSO1-r-L7$>
> ZjQcmQRYFpfptBannerEnd
> 
> Hi Meghana,
> 
> On 12/02/2026 07:21, Meghana Malladi wrote:
>> Hi Andrew,
>> 
>> On 2/11/26 19:42, Andrew Lunn wrote:
>>> On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
>>>> When using DP83869 in force 100Base-Tx mode, the PHY is required
>>>> to have robust Auto-MDIX feature enabled from register 1Eh.
>>>> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
>>>
>>> What are the results of not enabling this? How would somebody know
>>> they need this patch?
>> 
>> This is the fix for 100M full duplex when auto-neg gets disabled, it 
>> fails to have a link up and this patch fixes it. I will add more 
>> description to the commit message.
> 
> I have a board here with a DP83869 + imx93's dwmac, but I couldn't
> trigger the bug locally. I forced speed, dpx and aneg settings with :
> 
> ethtool -s eth0 speed 100 duplex full autoneg off
> 
> I did the same on the link partner, but I was still able to get link-up.
> 

Your steps so far are correct. But I didn't do the same settings on the 
link partner. With other speeds (10M, 1G) I was seeing a link up without 
the need to force speed on the link partner side. So I was expecting the 
same with 100M as well.

> I'm not saying the bug isn't real, I mostly curious about the kind of
> circumstances that causes this prblem to show-up. Do you have any
> clarifications on that ?
> 

Also when I tried the same between DP83869 PHYs of two AM64x (TI DUTs) I 
couldn't see this issue. When I tried between DP83869 PHY and an 
external switch or PC I was able to reproduce this issue.

May be I missing lot of detail in this patch. Let me know if this helped 
you with reproducing the issue. Thanks a lot :)

> I'll be happy to give the fix a try, if I can manage to reproduce the
> issue :)
> 
> Maxime
> 
> 

-- 
Thanks,
Meghana Malladi


