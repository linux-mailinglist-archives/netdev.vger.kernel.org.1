Return-Path: <netdev+bounces-169905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A94A465D2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB813B2161
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0121CC7E;
	Wed, 26 Feb 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxrnemnA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10A19CC3E;
	Wed, 26 Feb 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585361; cv=fail; b=hwH0VrVO+26V59wUEw/qWbfo4I+TKVn0hLdVFS8S/Svancx4oK6bpbMl7wtwmLXb++dYqbV4LOY4vS5AqktOCmKn2ZSHaQFcx/nVi91rBv69726Y6eyN8s/9iu++WNf8bckdpT9bPa0Fux240qbVHMg5in/MwLBvP6bN6Dy6uHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585361; c=relaxed/simple;
	bh=XPoCh7jHJc+Y2RWsVFXaQxQXl0OGAK+TedPK370LXMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HtiO/c2YEPip/VfhIDzEZFQj2eKe0fT/e+S9/6VvI15cWMyig6OQ8YUXu3vh/5mjmA4yhlyV9R3Ndk82quH+pCR/G/9s20v0bV89Pjshu6CsuuU8mInx2zTdDZS9Wljk2xSoD1qHi9dY9NNOP/qwtWaCTQWe4BijNngq6U1cuYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxrnemnA; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoANOXmonwJQWREiMSVQx3mEn4t0R9s7/aEeQhQP0jyHM0AbqThuNwPcYDnLxPEcT/lDR9manhMUHPH5NGlgqocHkbixXeaxax7pCXyxivSryvcU/sOeU3MJbZORMTh9Y/a9P8bh8T9PxiazHEZOViLYmLgu5vYqquiN8cn+IRdJlZ9A4ZcBqBMSg9SDqzG404qj8eVIcxp+A/t9T0c/+RHt8tMBGkeoexlvEW3taEW+Vq4nDMpcq6OCLwFoy1uhM/bGtL65TDEY2OKkWVpPOHQoGhnjIuYRsO/4RkHDIvszshVp76GZdeYb80OmHfvbcMp5uBvvkCUMbJG7cPDSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGZQ+N9hHbAtsvxdejQTX4hDnsHdbVqfBLpF/YELYL0=;
 b=jp6fnLdAv1TygGMjPLtdd1G0wurYDeLYpQWa4SLlc2D9WZC8Qiezn8CRwWiG4xqCQ0iWRgYJ6Y/hq28BKK/5tPJAw/d5ARG/RxAq3d4MZTJB3B171JcdKmoFlQtEecdfor0XTvL0sDHjh7eZu9YiHNJ3+hTwTAelzWlunMN6ZDBZ83utHpc6+rCwrRNVBmUFxQ0zEJ+U9/cQGGXvuP00CZPAIlorsd4ENvN0BTyjZXi17yk9scjKHRhSanaxBj7f+YNl107X1bQQfe2z96hXjsF2iqDEC2XmDAiR/ir6U4IbJluo1APOcFdMJ3mgkwuKrGGqhbk+2CR9sPd7eSXq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGZQ+N9hHbAtsvxdejQTX4hDnsHdbVqfBLpF/YELYL0=;
 b=UxrnemnAmLzhlmZu9k3JF2ITEUT8NTt2Ns7Lq2jX1cUNPoajmIPg7JWTebknkjWZfz9rU/d34GEq1V2NNaMxAtSgWXcwgOBpPaOj3nHbas9wGLvd6OIRuWs+Frs1Ij/afMW1Z04ACPM/B++06k62NQtGwdvP3YiF+gDFHdKztMEFod6GS/oADKZNMzeItB7dPTTsE86GfyyTZvLytGfwYh151X2cNMAmXCJU30VCUseyzIr95fkh7940EYhRFhIjyCjVmXzVLPREA3rK+0WQRvl1jENP8ZGVPxkO7QBfQQPMs4FjKLNqMKWE4Ty6KC471BepqDmad6G7NeiTWDLoTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 15:55:54 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:55:54 +0000
Message-ID: <63f9d470-e4e4-4e06-a057-1e1ab0aca9d0@nvidia.com>
Date: Wed, 26 Feb 2025 15:55:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
 <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
 <fd4af708-0c92-4295-9801-bf53db3a16cc@nvidia.com>
 <Z7ZF0dA4-jwU7O2E@shell.armlinux.org.uk>
 <31731125-ab8f-48d9-bd6f-431d49431957@nvidia.com>
 <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
 <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
 <Z770LRrhPOjOsdrd@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z770LRrhPOjOsdrd@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: e0359e28-b7b4-4a72-ed32-08dd567e0cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2VRcHdqOFQ2aGZOckhpVmRUbHJSRDZJR241MHJRcWMwMU9DelhkVTVEaC9K?=
 =?utf-8?B?RTdTdWZwblBhaVVpZVB4Z0xvNUNrN0JVeXlSckpINmhWVFJEUFNGVGprUTFB?=
 =?utf-8?B?VUJrTS9RR3ljaFhZQjdGMHY5NlQ1SVlNUXlUc2NVVHkwMVZPWm5BdnNucFBP?=
 =?utf-8?B?TVV0THFVdXpVQ0FrYlpZVENSOFNabk13d2RjR1E5TnZwSTF5QVMvenJFVUNF?=
 =?utf-8?B?ZERCTzF0TGlXcnpJZlR0L2s3MDA0SkM2TnZBQmdNVnhwS05Hd21wTkwyNjlU?=
 =?utf-8?B?OUphL1BzL0RMeWJHQ1Fvc0luWk5RZVJkYk0yeHcvZWx1UlM4NE1wanFRSWd6?=
 =?utf-8?B?OXJjd2ZRaTE4NHFjNzVpRmVFblR3QVVXYWNPVVgxRnpPeitjaG0zRVJQOWlL?=
 =?utf-8?B?Y1FqbVJIVUZ4UnB2ZUVDa05yUnB6K2lqWUlzS0owSDhwbXQ0R3JiRFEyRjF5?=
 =?utf-8?B?N1AzSCtEVGFqUVd0UHQ2TC9oY2d5NVdxbmdBMVpMWTR0OXlCU0RTSWtuWWJ6?=
 =?utf-8?B?NE81REt1eU16UWkwbG16SUdaSXF6RG9GZ3BWdEUrWUpmUFNTd0l3dHBTSmsw?=
 =?utf-8?B?eDdwTFYxdVNIQUw1QmFmU3VWUXZNK05XUnI2c01Qc24zLy94RGttbkVPMmhS?=
 =?utf-8?B?TDNLbFdpSE9paUhEK3NxY0dqZXoyOCs3VU1rNnZvbWRPYW0vblBjUDRaVnRC?=
 =?utf-8?B?ajRLcXhrcGw2MzZmVURlTnBNYWtmY001NDltbnFYZVcxRTBkbUE3YlJmTE0r?=
 =?utf-8?B?SVJzenpvQjhIWkpRdUgwam9oUTIzNVFjR3lqVStiK0NCZnVDbUUyWnRYY0Zi?=
 =?utf-8?B?VzVoUE5LV3paUGIraFl0QzZtdnAvdFJoU0NhdTlHRWNNOTVOYS91a0Y2dzIr?=
 =?utf-8?B?dTJmR0ZGVXZ0NzdrM0tQcVpUenUzUnlwd2RSZlJWLzRSN1RIZFNIZHhiUWNS?=
 =?utf-8?B?RjJQYmdQUjd0TmswK3BHRllUejQ2WUxPNFcwSE8zdG0xTXVNL0p6Z2M0ekFH?=
 =?utf-8?B?UGZiS2Fod01nd2FWODRqVitKS0lWaTVKa09kbk1xU2NESWR2NzJmRHRSalQ4?=
 =?utf-8?B?c2Q5ZExiMnU2ZnhEZFJiZXFtOWxLUGQxV1JvUzc3c0xhdTdZUVhuMHhzeDlS?=
 =?utf-8?B?bU1icnFqY21tdFV0SmNibXBiUHRzWDkyalhVSEZEUUZrVDErakQrWDdnWWpl?=
 =?utf-8?B?M05vdENtNkIzTnVReFByMlN3WmFGVDR4TEJtTzVtUEVqSVlRSVBURHZJRGth?=
 =?utf-8?B?Q3ZrU3NxazhwT2IyaEk0aVBDQ0MwVmFGY25KR2FRanZlM21QQjZjd2EzeGFE?=
 =?utf-8?B?dlhSelBiRGN2TDFlZG9sbk1ZZ2pSdExKelpKK3ZMLzQrNDZEY1loTEh3dUx3?=
 =?utf-8?B?ZlA4UWJNVTBWSUYvM0crb2psL1Bmb3pOZ0dJRG14RUZXdnlrNXdtTTRkS0VU?=
 =?utf-8?B?ajhvNUdheWtQRWhNNFBZbC9FYWZUNk5QaXdScHpvSXBGNHdlTVVHdllSWG5l?=
 =?utf-8?B?QThKakQ3NXFsVFdNRDFJN21aQnY1b2RFWS9admdYZlQ2WUVRMUFYM0FHdCtz?=
 =?utf-8?B?OXpCNVhMNXEybjNIQXdBSFVUU0pWbUpqaDlLTXF2RjUyTDd3UVpBQXByaFZG?=
 =?utf-8?B?ZWh2MWVMZjhFRU55VlBTcFZaZDhYSDBTME5qbTBrdExDS3oycSs2RForTHF3?=
 =?utf-8?B?c3BJV1g5Z0tVT05KdnhUb0lSMlVKODhHcHVQR1pDYnhOYkJxT1NmaGRsTkVy?=
 =?utf-8?B?aVdCZzNaOFRRMWNkaFR5c3o2MElqRGxnTEM5eGNmZnJJZnFITmphdXY0aWpr?=
 =?utf-8?B?RVFtTEFESHF0N1NLcDJ0Y2JpNjBvNHhCVzRFQkhhMFFLelZRUTZnTjc4c3JD?=
 =?utf-8?Q?aFglrjUcXQgbr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBLWW9VOFYxYTFFTE10OWdENkdOMUQzaDgvVXJEVXR1RzRhSmxFdEwzUEV6?=
 =?utf-8?B?RUhodmwrTjBBSWx0T1lIbzFPY2dSeDlFRTZXc0plOGJjZ0xyMm9tM1VhZktS?=
 =?utf-8?B?UFo0dGlFS2ozK2ZUL21nZ2VodExaanFFUDY4ZjR0R3MyYk40MUpGYVM0U3RO?=
 =?utf-8?B?NjF0YU5Bd2JSbzIzQ2tRMGFyTUVyempRdGhXd3ZpbE1LMFltSjBDSGU2NGNk?=
 =?utf-8?B?RzNwRmoyR3JkaCtsRUFOVWJGZHUzMzAyVXdRR3JoaTMxWHFzZ28wanZZdEw3?=
 =?utf-8?B?MG9TYTF1blN3MlA2TThEa2s5NmVPcmJsNHppNk1uRU9Jd0hLSDdXNXVRRXZK?=
 =?utf-8?B?TExQZDdHYkptTHUzYXdqdkZ5VUNTeGdBWUwyaytNOUlFeXlleFliaTluMWlS?=
 =?utf-8?B?YzZwTE41VHBwdi9XU3d0QkFvWFpGOXBUUnRaRXBEK3RHU2NLTkdoVnFJQXZR?=
 =?utf-8?B?dGVsZ092dG5Lb25iN1lpNEg0T3lnVFV3eGgyWG40WWtKU1V6bUx1QzMxSEhW?=
 =?utf-8?B?ZXR1Nzc3dWdlR2h6ODdiZU9GSzVndzAzNWlQaGhaQmwyeHR0ekdLNmlvb20x?=
 =?utf-8?B?Rks3aFZmcWZPRmx0L1BtejNJV2NCNlRsQUsyNUZid3hQUGgvbHllcWJ6YWxB?=
 =?utf-8?B?cGtSZWJLdEp1OUdKdGh6SlZJaE5DSEJCWkkva1NJaHF1cFdPVG9FVXEwR2NP?=
 =?utf-8?B?cXRrOUtzYkM1Mnl5UXQ2Ync5RFRMUWx0WXJRcHN4dTNHM0xhR21qUVhNNmNu?=
 =?utf-8?B?aEpCYWh5NFdKNy9DVEpNUHEvYys0WDVEU2FjRnhHQVdrWE9Hckk2am84cndF?=
 =?utf-8?B?SmZ5azluYytTTlpFWVJNSEdWZDlyL2hOOXM0UUVQa25oUjJaZ014YUpLZGps?=
 =?utf-8?B?TVJSVzJZZG5EUysrK05GSDRBWDV6ellKVVF4Zk5kYkVCcTdSLy9OTmhDVnkr?=
 =?utf-8?B?Yzc2VFM3eXBiNFN6MUQvR1BNeFJtczlFNUxUakp5OWJRR2VSajRtRlViUTNq?=
 =?utf-8?B?ODFFSzl4TVllQVNYOHM1cHdCNGR3NExOK3d3S0F4LzhTcGhyVlg5NGlXR1NP?=
 =?utf-8?B?YWgvSVptZWw0M2xmM1pjOWw5N2RuQldJZ2Z0MEpQU0VXN1ZNRjVsZzd4RVZX?=
 =?utf-8?B?MjB2YlIvZEU4QWFBc2FOcDRoNlZLREJMaFhRVENlNTlndDVZS0h3N2lEL2Yw?=
 =?utf-8?B?ZUlabHcvMHl3ZjJuQitscUZaT0xhaEdzdzhNcjdMTy9QZEFFUDN5U0xkYjhy?=
 =?utf-8?B?RDVYVENXbjFPdUxKSDhleHllYm51TzhNckpuOHVyTW5uVGxwRW5LYjBmWEpn?=
 =?utf-8?B?emJYNlU0M0FzNlBQZ05SMGJkSU9ncWdKVFo0VFlJUlV6OVBZT2ZzbU5ZdEts?=
 =?utf-8?B?ZHYzSGFNUnk4RUZCYVlZV3ZRUGovbUJkWUdZZzZiZDlmVk5NazVrK3dDenBR?=
 =?utf-8?B?MmpkVmh6cE0rZU8wUDN3ZDU0U0dUUDVub3FwTXh2ZFJabE82YURNc3Q2T0ZV?=
 =?utf-8?B?VXhDNUVqS1N1UTJpdy9RTHI5c3hkTlhZN0ZiZVhCMVNYOVdtMHVLeml0ZFJJ?=
 =?utf-8?B?NkhzYkcvN2tnTDNPczIvcTVUQk94MWgzYm5uKzRmS2Q2ZDZscllzQ3pJY1M1?=
 =?utf-8?B?bWdlVno4azV2d0hlQXFZbDNYQ2ZTUXRHWnJMdThyVUY1VmxEd1NjcVhsRFJD?=
 =?utf-8?B?dWhCN1lXanZXcCs2c0gxcUVnNzQwZHMzNG1yaTJUQkNObTVweTVMRTlSN3BV?=
 =?utf-8?B?clNXWkdmdmNDRVNZZGVOa2dFT2tQMkxFSG9lcHVjbk9PbDdtbU9mOFdVRlFz?=
 =?utf-8?B?c2sybjdBTjU0cktTL0xnWGQzaHc2SWJIa3NKU2paekN5WnBtV05DZ2tFa3Zn?=
 =?utf-8?B?ckJLbmEyUjZFa0h6dTN3aVM2L3NBYXNheG5qd0NrUStCOEY2cXJLVWM0MW9r?=
 =?utf-8?B?VmhVUTdJTkNGeFYrODRpWHdhcnNqVnFITWxmN2t5TmlOdGwzQ1ZrdGlqdFBi?=
 =?utf-8?B?VUtkdk1zUWFSb1pSYlp2L0lWK3NoTG5PdllQdUQvbXlwaEpXcGUxVUthL09V?=
 =?utf-8?B?TEcrT0RUQ0w1b3pvWHVFb1BPOXR0ell4K2xQQ1VJbjlUenNHUWFxRFR6MWF5?=
 =?utf-8?B?em1kTlYrb0JEUGRCZUVRWVMyWDg4RWRsMEZhL3dFb2hVeStCcm9pOSt1Qmhl?=
 =?utf-8?Q?Gp5i7oX6YGSntzHNzIFLyvxJN8t68673tl1TF2nLSnY1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0359e28-b7b4-4a72-ed32-08dd567e0cd6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:55:54.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dataMl9ykQMelL7F1jBjoty3CVjeQ9bhRQtbbDx3gJ3NwhhAJ5wO3H/k16qlQ1qk+8G/QFhO+LQZ7kROxvJzPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826


On 26/02/2025 10:59, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 10:11:58AM +0000, Jon Hunter wrote:
>>
>> On 26/02/2025 10:02, Russell King (Oracle) wrote:
>>> On Tue, Feb 25, 2025 at 02:21:01PM +0000, Jon Hunter wrote:
>>>> Hi Russell,
>>>>
>>>> On 19/02/2025 20:57, Russell King (Oracle) wrote:
>>>>> So, let's try something (I haven't tested this, and its likely you
>>>>> will need to work it in to your other change.)
>>>>>
>>>>> Essentially, this disables the receive clock stop around the reset,
>>>>> something the stmmac driver has never done in the past.
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> index 1cbea627b216..8e975863a2e3 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> @@ -7926,6 +7926,8 @@ int stmmac_resume(struct device *dev)
>>>>>     	rtnl_lock();
>>>>>     	mutex_lock(&priv->lock);
>>>>> +	phy_eee_rx_clock_stop(priv->dev->phydev, false);
>>>>> +
>>>>>     	stmmac_reset_queues_param(priv);
>>>>>     	stmmac_free_tx_skbufs(priv);
>>>>> @@ -7937,6 +7939,9 @@ int stmmac_resume(struct device *dev)
>>>>>     	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
>>>>> +	phy_eee_rx_clock_stop(priv->dev->phydev,
>>>>> +			      priv->phylink_config.eee_rx_clk_stop_enable);
>>>>> +
>>>>>     	stmmac_enable_all_queues(priv);
>>>>>     	stmmac_enable_all_dma_irq(priv);
>>>>
>>>>
>>>> Sorry for the delay, I have been testing various issues recently and needed
>>>> a bit more time to test this.
>>>>
>>>> It turns out that what I had proposed last week does not work. I believe
>>>> that with all the various debug/instrumentation I had added, I was again
>>>> getting lucky. So when I tested again this week on top of vanilla v6.14-rc2,
>>>> it did not work :-(
>>>>
>>>> However, what you are suggesting above, all by itself, is working. I have
>>>> tested this on top of vanilla v6.14-rc2 and v6.14-rc4 and it is working
>>>> reliably. I have also tested on some other boards that use the same stmmac
>>>> driver (but use the Aquantia PHY) and I have not seen any issues. So this
>>>> does fix the issue I am seeing.
>>>>
>>>> I know we are getting quite late in the rc for v6.14, but not sure if we
>>>> could add this as a fix?
>>>
>>> The patch above was something of a hack, bypassing the layering, so I
>>> would like to consider how this should be done properly.
>>>
>>> I'm still wondering whether the early call to phylink_resume() is
>>> symptomatic of this same issue, or whether there is a PHY that needs
>>> phy_start() to be called to output its clock even with link down that
>>> we don't know about.
>>>
>>> The phylink_resume() call is relevant to this because I'd like to put:
>>>
>>> 	phy_eee_rx_clock_stop(priv->dev->phydev,
>>> 			      priv->phylink_config.eee_rx_clk_stop_enable);
>>>
>>> in there to ensure that the PHY is correctly configured for clock-stop,
>>> but given stmmac's placement that wouldn't work.
>>>
>>> I'm then thinking of phylink_pre_resume() to disable the EEE clock-stop
>>> at the PHY.
>>>
>>> I think the only thing we could do is try solving this problem as per
>>> above and see what the fall-out from it is. I don't get the impression
>>> that stmmac users are particularly active at testing patches though, so
>>> it may take months to get breakage reports.
>>
>>
>> We can ask Furong to test as he seems to active and making changes, but
>> otherwise I am not sure how well it is being tested across various devices.
>> On the other hand, it feels like there are still lingering issues like this
>> with the driver and so I would hope this is moving in the right direction.
>>
>> Let me know if you have a patch you want me to test and I will run in on our
>> Tegra186, Tegra194 and Tegra234 devices that all use this.
> 
> Do we think this needs to be a patch for the net tree or the net-next
> tree? I think we've established that it's been a long-standing bug,
> so maybe if we target net-next to give it more time to be tested?
> 

Yes I agree there is a long-standing issue here. What is unfortunate for 
Linux v6.14 is that failure rate is much higher. However, I don't see 
what I can really do about that. I can mark suspend as broken for Linux 
v6.14 for this device and then hopefully we will get this resolved 
properly.

Thanks!
Jon

-- 
nvpublic


