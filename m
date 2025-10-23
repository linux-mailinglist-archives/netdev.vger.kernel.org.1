Return-Path: <netdev+bounces-232191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE33C024DD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DD93AE854
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1626E6F5;
	Thu, 23 Oct 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="UrjEPilY"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDED2222B4;
	Thu, 23 Oct 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235423; cv=fail; b=tsvCweGeYY6/FfmRhasXz6U+ggviwizhyjMD7lqg+f/Jbn22x+0P/VeR64leMcZch0jlw1tsVBjKf2lg2nCEfgdcO2UDUVXCjpIR55UXhBaGYnyfAFERKovPVKNREcOyvK2pqDVX2wy84pcr2BTkJQXCHSjTMPCidh+azUQkoWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235423; c=relaxed/simple;
	bh=nmHsPtomk3VMB+WindzsLvqE2d/GCaA2MG/8i+MKi1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MMp4LIamAG8+5b3PznbRLvEPKYlICNenUWNJv5ATLFFTuVVUZ46YtCJFNWZGidp5FaE9SVd7RTpQU3iq6Rc9cjVGLbEDUxQv9RSCkWxp7ntSpJsjA6IscZ0ik1482E0ASShGqoyjdaJcneTjWS3fhDc+DFzT8QUI4grBTywmdDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UrjEPilY; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+GNETWHhOcVN7D91sUWSDwQDOa6La2vbmcMcMl7Mt8J9tFdXCxQkC0oticHpdYhrBurn6q86H5xwIWogGBd4Khx0UQ9qQFPjFHrdiqM2t5zIySGQD0rGdeOV+0lRt7bj2If5mnho/m14pyEIA9FLAKfcg8VUNnCnlVfr82l++Z1gqKLSNKCOLUkUEBLhXA4AQWj/6ph1vtoxlvFa9Kkh85Qsz3+UyerikNH9Ir8MSPERyvjKU9DUraA7NKNKtKV5qBHALy2JeG3s34Y4OSd00r7T5tleRqAjMsJsPF80Oh+jt+V67LzvQBT+Fzay1jzESPaGFjAj6hE+UaWf8vz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiQYlWzGxAzcmDxQx21R/s857ZIvlRsCxnCwp8B5EGA=;
 b=tPXMPe9xvZNxxHZ96siw899xQbNWfUeB23TyuLW1BXA5pkeBxRWf+x9BbzxpFLLB51KZUmB3hOZFgjvdlDvFfLMuHpX/CIa5Buee7Y7CEK6FEhFOf2veIpgILS3RGVhl9ByHke2/4js8TgvTv2ZMQuRh8co/EO55Ai9MTTzO+cKggo1tU3+KJyTnN/Nr3F3NipHp1emmxYzj2CwbEnZcBqyvFj49MRZVNi5XufNiDSz5EnXN6EIelhlMFm30Tq466eON71mhzfYV4RQGJyUUijSxcgGqXx40QPHvSZNL0cmquOWC+wluMKmnKNV42nU/Tvrmdl1HlwCnxR2wz+Pv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQYlWzGxAzcmDxQx21R/s857ZIvlRsCxnCwp8B5EGA=;
 b=UrjEPilYie9qGp/jqmGGWXmDrsP4H/8nbqb+cISOVMmPPLdQ0FkLEXnad2ClBhow1nCb3XcZTgzgaeY+ktoZC/EtbLSiC3Hc/iqDBubZeWJfqGnFPp90Cb8ShEKXk65SiXpBsrUehtEUlQ97YBtwBzQw6RZVt3IdfdbhId3gA+3x8LSL1Elyp2i0DqhhLj5F8Q3C3wpGN5QG5gvZOlEd8V0ScpXor5viaUXrBxBUvC7BqSt+vaiXqBQXGzm3Jxf54XX4BTkapMELI2y4uziuE49toRJdWuK+2DF+8Xdh/bHEMG8QUs4+LyNiXFMT/BAzwtGgA7qD25CNVOglt2T2jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH2PR03MB5368.namprd03.prod.outlook.com (2603:10b6:610:9d::22)
 by SN7PR03MB7260.namprd03.prod.outlook.com (2603:10b6:806:2dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 16:03:38 +0000
Received: from CH2PR03MB5368.namprd03.prod.outlook.com
 ([fe80::ccdd:249f:7a8a:648]) by CH2PR03MB5368.namprd03.prod.outlook.com
 ([fe80::ccdd:249f:7a8a:648%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:03:37 +0000
Message-ID: <e24d26a4-8c3d-4673-97a7-eed23f54c08c@altera.com>
Date: Thu, 23 Oct 2025 21:33:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
 <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
 <0d3a8abe-773c-4859-9d6f-d08c118ce610@altera.com>
 <aPoKiREmRurn-Mle@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aPoKiREmRurn-Mle@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0220.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::12) To CH2PR03MB5368.namprd03.prod.outlook.com
 (2603:10b6:610:9d::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR03MB5368:EE_|SN7PR03MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab7bfe4-d2c7-424f-fbd0-08de124db9bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzVoSUgwSnVGMXdGZlNmODVXWnFINEFDTjZqNkE4TjY4Y3VHRmt4RStpbG95?=
 =?utf-8?B?VVovMGFFYWZRUXlZai9xdlYyV2ZWYVYxQjhlK1hyODhKUVk0YzZ3SURuTjZD?=
 =?utf-8?B?ZzF0Z2gzUDk0cVk0YUFERTRIRW8zcFRaTTZRcmNrTDNsT2t0TnRRa1JVVDly?=
 =?utf-8?B?L0R6V0ZxbXd4Ris3aDNHNGpBVHNLTkVJZHlSemhvSXVUQ2ZTNjhnVmRFY1FU?=
 =?utf-8?B?eVFTenpmWXRCZ3phVGtFaTdDVTNVNnBjQUtRMEZ0TlJicWo2RCs4dXRQY01L?=
 =?utf-8?B?dlo1dDN1RVRoRWkwVkMzdENNUWtyQ3hZTVNKNTBHK0lVZjJWZUJ5TlR2VkxT?=
 =?utf-8?B?dFhlQlR2ZFdIMExBcHMwTWQ0dTZOZ0dkdWs4cVpxSlRRQStOM2o0SkttNGFN?=
 =?utf-8?B?c1BKaVd4VmJBV0ZUQW9GNXR4MTVJY2dFOVUrcmo1VXN5cWIyMzBjRklML2JP?=
 =?utf-8?B?N3l4RjU4ZnFndTk5dTNFdHgyYTY4di9naUxyemdpSFRRZnZQT1padnNtTDJR?=
 =?utf-8?B?TFlXa0J5T3JMQ1dCdU5VbzNqVEhFd3NQbThFNnNKaXltUHJsREZiVWFld3Yx?=
 =?utf-8?B?N2UrWXorbEtKTnZ4Mk5ZUlRDaTd4S0lETzltZEs0TldvaHZ2L1ZCcWRZekc4?=
 =?utf-8?B?OWo1a2NjMmhjMmxiY0V2NitKY3ZFeVBIaERGU2twZXkvb25UM1hBZklFUUdC?=
 =?utf-8?B?L3RoQmNHZmc2eXlTejkvTUwwT05oeGxhVUswdFpuUmJJN2c1WTM5ZTh6RlRl?=
 =?utf-8?B?MVJyNTdXUmpGMk5saXVSUFpsY3VsZXUxdkRPTVovWElnS2hHS0I5WEZKeE1s?=
 =?utf-8?B?RHZPVW5JSzNVS1Q5aUUzNHpZK3hxOXAxNWwyR3h1RDRTbzMybVRDVTFIZGpx?=
 =?utf-8?B?NGxCazBKQUJEa2pMclgyNUtkSUg2b1lzVVEwTWdxaUF1VjRJSzlVZjU4NHVa?=
 =?utf-8?B?SmZsTGpKOWVuUjhhWVc5ejhETnRsV2l2QzZtTGxDbmpaeld2NjNab0k0QU1I?=
 =?utf-8?B?TFJLVHRra0UvR0RRY3E0MndCeGp4RFZtR2cydWhJVUphVlJ0OEFkcnNWL3RT?=
 =?utf-8?B?TUlBSkVXNitkVmlqTlNScnZSd1FKdlBqRWx1ZUx6NTNoQS9VaFhnbzJBa2dX?=
 =?utf-8?B?WWg1aDlSOHczM2JQWmJ4Wit6cEdLSkJLMkJsNHoxY2JteEFucndGM3VMcEpH?=
 =?utf-8?B?QUlyVWs5aithRGZFZ2hEb3VnbVZUdkptWnhsYXVPUVd3R2paZ29HTzZLbFZE?=
 =?utf-8?B?TUZ3aDRPMWNuaXArQmgwK3dpdE9wWTBmMUZ1cUdQRHdybnI3NkN5WmxFUW5t?=
 =?utf-8?B?Wm1xa2ZtRjFkN21hOTl6UTN1WW1XUDE1K1V0U3h2M2FVdWttdThZRk9YVjhW?=
 =?utf-8?B?MThNRERxTmRJRlFOVU5hTmdYaDdnZVBNVko5UkRCeHo1TFdsVC9DV1BHb0Z4?=
 =?utf-8?B?Rk9LR0ZqWmJKc09qcEw0V0ZoMWJmNWsrcWlGNkxqaW1YQjVSR1dWeVdORncx?=
 =?utf-8?B?eXNkL2ZTVmIyL1hqMzhMaURROSt3T0NldkE1V0g2OXhVVXhBVFlkTU12RjlE?=
 =?utf-8?B?a1JJdzJZQU9RSnRGNjhEbk5hNW8rWWQ2TUF2eTVMeHBPdUdYQjBQbENjRGg1?=
 =?utf-8?B?eHREMzd1dktRd3JVb3lXSWV3TFZVWGFxaSt0U1ZkbGxwcDJZMFBDTG9nRUZR?=
 =?utf-8?B?a0VjbHpUVHJlUWFCTlAxT2hIcUgvYzBLMDJUMFZmbFFmS28vRXZ3WlloUWJu?=
 =?utf-8?B?UVZXdWc1T0piSUd1dXpkWlJJRjU3YmhqTFpaUVZwTXN6OXJjWlExQnp1bG16?=
 =?utf-8?B?cmhkaUNnZ2M1L0Y4SjBCQlNubVdpYUhqSytyYXJtOUdYeUJMNW4zY2d4YmlG?=
 =?utf-8?B?ek9rT0NUMUs2NlovSGZHTHlIUVZBRVlPeUFtS0RvaXlYOVdmaTArS3lkVjgx?=
 =?utf-8?Q?lUU10KLEahlwake+fyyoqT6OXRb+mH5X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR03MB5368.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXMrRlBpY2k1WC9MVS80RE1oOUV4RnFGRHJzOTlXVVd4V1JtWk9GNWhQeTMv?=
 =?utf-8?B?NDJJZzYvanlZR01vbk1ndzc5d1cvRk5pMnZmWllWdEtBV3g3Q2QrRS9Od3E5?=
 =?utf-8?B?TnptK0hTWUkzai82UlZIMGtHWkVkb1dNTDNpYml4WmpMRnliMVNVek1OZ2Nh?=
 =?utf-8?B?K2pJdVNJQys1cnpmWFRVellBUXhyZmtzNkd6NHdSanl3TUkweXBBSzF1eFZp?=
 =?utf-8?B?K1ZGMXdocUNiUFpib1ZQRzAweUg3L1plMUw3b2xrakRVaytTOFJDdW94OENM?=
 =?utf-8?B?NDBqREFFS3Z2UjN3VkJWd091WGN1ZVcvZkl5TWhFcGpjRXhsSUJBa2VaWUhz?=
 =?utf-8?B?VmN3OVd2UnFuR01uN3UwcFZEOTFWTGNJNC9nK2IySW5zTjFrc203aG9maE5Q?=
 =?utf-8?B?NTNRRWlRSm1GRkVoUU1COW5SWFhseCtFS05VaTZlUlh2d3E5UDFzTFJLNUph?=
 =?utf-8?B?UjI0bTJWa3Z6NlFWR0NON3pGa1FqRkMzSVpGeEx4WUZ2K0Y4dE5RbkxVT1NW?=
 =?utf-8?B?STBjRHU4WE5LaHBHOGlHWXNTVW5EMWVpZ1lkdG9GVVNzS0ljdm5qa1RNTkxM?=
 =?utf-8?B?UmpjOTdMdmxTSVB3Wk5BRStOSGFvaDFOaUVicEZuS1NWbVYvcXdYSSt4Zlkz?=
 =?utf-8?B?SWxJM3BnSEVhME9sNVdGM1FHR2tEcGIreVNyWWRRdHVwWU92UXpHaVBobTVu?=
 =?utf-8?B?cmxROGxIWEpWSTZPYloweW10RmlpRW5vUnUxZVRGVUFTRk9xUnZ5MlgyM3Fz?=
 =?utf-8?B?V2NNOEw1U1VPUTRmOUdXdCtIcS9UZTdVRngySCtYTGF2WHFuZVJjS09KRGJk?=
 =?utf-8?B?OEJVUERvTWVvWmdvMnlEa1BmM1NSOWkyeHV3S0xOM0pXZHBGaGlkdGQvZUla?=
 =?utf-8?B?aVpNbXBNSHFuUWNiNEMyMm5iT0NvNVpWd3FnVVo4ZUNEQXlab012QmpYY3dL?=
 =?utf-8?B?WEc0ZWkvV1crZjh3ajI0aHNCblp2NFg4STREamJoK1hvTWJJTHZyNW5iM3h5?=
 =?utf-8?B?a0FHZmd3bmtxblV0TTlaWGx0ek1rdWlYR2dyclpYQjV6bVZJUTRONEQvMkxn?=
 =?utf-8?B?T2FsTlpPTC9aeEFUOWRrV0wvaGFyOG0wMlg5VFVSWnFDcTZ3VGdSNVd0dmNM?=
 =?utf-8?B?V2tGK1k2QjNrcWg5L2lRMFlXaVZGTVBhM1RMSExOaSsxL0M4ZFg5dU1SSkdh?=
 =?utf-8?B?UDF6ekMwd3crY1hEZG4xUlQwRkd4ajJJQ0JCMm1VSUlreDYxSkFEcS9iZ1NN?=
 =?utf-8?B?L1NjTmxnRnVVZ2V4Vmh2cERKbmNLclZmNWNlSzZ0TzJWQWg3R01rSDVzVVRk?=
 =?utf-8?B?VGVjdndBVVFQSHlMS2pvclNnTXE3cENpcVZnTUJyeFBna21LblBvYWd5VlFz?=
 =?utf-8?B?d0d1bkZ0VFBMelU1Z3hWRTBHdzdrYitSU2JRRjZITmpPR1VndEhKNTNHNE5p?=
 =?utf-8?B?MldweElOYmFveWhZL1g3emhGYnozMWlwdDE5dTZKdXBEcjZnOFhFSnR0dnV1?=
 =?utf-8?B?clg3dllWaElHVmpET3NJYnNWL1d2UU9FeG5Uc3MwTHJ3UmNwZC9lWDRXbDl1?=
 =?utf-8?B?SGxRYXhZT2RQWGVXSmlEVlJPUG9qajJocUU2YXRJWEEveENwdXdYK1lCL05j?=
 =?utf-8?B?aXNnK2hYajJJSldLamlMNU91cEJPYkk0REc2VzJiSFV6MFc0eGdDZi9JK3Y5?=
 =?utf-8?B?UlA1MVJvWGpnL0NSbHE5QUFyV0hpNmhxUmdCa0pZL0ZVcTVIQUREblQ3UERm?=
 =?utf-8?B?R09PWDJGS3dkVXFGaFJsQ3lseGdqTkR3ZVh0M05XZHN5V2pQdGZ0RnE2Zm96?=
 =?utf-8?B?SGd4dW1CK0hEZ1NnR0g0aW8wRGxDN2tLTEd6OHZyYU5zZkY1UGtidnVSMzZE?=
 =?utf-8?B?QnFyTnBOYTExaktFM1RtTFJpQ25hYnJxN25IZzZ4bTRGa3JWd04yenEzWU9R?=
 =?utf-8?B?NVh0TEcyRVpKcjVBMmc4TWFaTFpZaWh1aU9aWlh5MXJ5UmpZOHMwZE5uY0VW?=
 =?utf-8?B?a1ZHanhxT3hDR1BOTnFhbzdiZ3R5cVcxUHp3UFZLeTA5UmhaNmdTMEpaT0do?=
 =?utf-8?B?SXB5eGZWTTgzbk15QndUVzZ1Y2Q1S2FqQWoyeEc5OGc4SEx3b2k5Y2NhQVRx?=
 =?utf-8?B?TnJEdW9EWXdtWmdVemZSU093bU9ickIxSEhvSUk1T0RIZzd6R1RCK2lzVGxm?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab7bfe4-d2c7-424f-fbd0-08de124db9bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5368.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:03:37.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A86lRv6R1woUj9opZE/vWWX1jmoO+XrN4xKs4MRXfrgd24cN0bFwl8Y0+l+fFPNLILPBd3jc3+bRXjF9CP7Py4HzWcfq7g/GG1fHbQyKqTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7260

Hi Russell,

On 10/23/2025 4:29 PM, Russell King (Oracle) wrote:
> On Sat, Oct 18, 2025 at 07:20:03AM +0530, G Thomas, Rohan wrote:
>> Hi Vadim,
>>
>> On 10/17/2025 5:51 PM, Vadim Fedorenko wrote:
>>> On 17/10/2025 08:36, G Thomas, Rohan wrote:
>>>> Hi All,
>>>>
>>>> On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
>>>>> +    sdu_len = skb->len;
>>>>>        /* Check if VLAN can be inserted by HW */
>>>>>        has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
>>>>> +    if (has_vlan)
>>>>> +        sdu_len += VLAN_HLEN;
>>>>> +
>>>>> +    if (priv->est && priv->est->enable &&
>>>>> +        priv->est->max_sdu[queue] &&
>>>>> +        skb->len > priv->est->max_sdu[queue]){
>>>>
>>>> I just noticed an issue with the reworked fix after sending the patch.
>>>> The condition should be: sdu_len > priv->est->max_sdu[queue]
>>>>
>>>> I’ll send a corrected version, and will wait for any additional comments
>>>> in the meantime.
>>>
>>> Well, even though it's a copy of original code, it would be good to
>>> improve some formatting and add a space at the end of if statement to
>>> make it look like 'if () {'>
>>
>> Thanks for pointing this out. I'll fix the formatting in the next version.
> 
> I suggest:
> 
> First patch - fix formatting.
> Second patch - move the code.
> 
> We have a general rule that when code is moved, it should be moved with
> no changes - otherwise it makes review much harder.
> 

Thanks for the suggestion. Will do it in separate patches.

> Thanks.
> 

Best Regards,
Rohan


