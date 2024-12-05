Return-Path: <netdev+bounces-149344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBF9E532F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5386F1881C4B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDC1DA602;
	Thu,  5 Dec 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="diLmDzLX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6B1D90AD;
	Thu,  5 Dec 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396291; cv=fail; b=d2irpYyU/XOUFXGqf2Wkkc0sNl/mhrSEkEAgklH435YkDL3HkGbFp2BTBw4/43pLDGm3KcNNnv816WhdZw80kqWnLgaFSDaMHv1IxReAaguShMDeiQRJbMWnOjfZ8k3qHEGRao2g5MZT0YqJ7tNOjzAFXChZ+H9CKdQ0o7qco+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396291; c=relaxed/simple;
	bh=X+q1HfPijHdHWTXQNaO7qUx7g+6XnZuKcAHOREkR/D4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5xed4vphpFLBHuzT2Y4clfvs9Ue6OqTN7d93An+zvLHmhiV3rNHwuI49ytRdzCbYWWNmuieM/ZgkOxSw/aLO4pz7CKVOwUOnzfjEg8cl9z+Fm4HjbjVIy5PwG9plsdgMhpN5s3Fj9wzUE2fevLkpAOK/68R8DB7cy1Bz0uchWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=diLmDzLX; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTAuJ6qfSjRKcixWz1LUXHmHNjQFyPSLcKRwhZqpD7q2EMGvvZZalHSOgbi7LE1FSy7A9/NsdEO7un+7qblnpUNdn1O1dS2Wex33juVOmDApbbwj6aqMcpJq6etHqbCGmuOBvZ7+PZMAv7shuxt5BW/L2PNHpBfgg8N22XMyHXUbNan8/xAMW3OY/UlIazQGYkzcsy1R8rLMQBMpAaf3JV2jDljjgqQHcQ4qZ80Tja/ZxJWsWdhOw3vtObi5LeoU7lUIahZG85lQqVRJfvg1/jHfh0dYM2sHmdwJWCjhWpW7tOd38eERgC/1CG2NDhyE1nVFlLhDyO0XoIEsbFIF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj5zQD17csIL71lcnGY1S62H/bE2egDx+Gif+PxfhRE=;
 b=mrG6gnDmXb67qB3R3pePm3lftOIElyjQa2wLQyFCVRMv8e+xvmL0BBCCFKNy+jYrj1l8l+0YNeqQ8kYbYPW/smeAeJARstvdIIDfUMdlaMB4J0hjFKY0+MLyCOYC3KRUXHpRkeumfRp7W4SBV2md6vdmIXCiTu2FC3t9LvAUInt0fZmG0EPyOM1/jKlQkxM4FQgi4cxlb6/X6WBmzlv3kINe2B7v4gQEj47HCir8dU59yq9dIWGogmViY+WzO8GA96Ivn3S+vMrMx6BiiF4NY4onJOQjIZ1BoC2/8Mc2g0SncL8oSY4aaggYomGslCEzxG4ASNiBNUhNPU+3wELJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj5zQD17csIL71lcnGY1S62H/bE2egDx+Gif+PxfhRE=;
 b=diLmDzLXGeIBdnc+UxmqhIxbs7gQ+kzATfLAGkxPKgcSYf9FjUVMDfNoOjpWewehDFtAR/aZov7fu5Ul0p8DdWlh6y4BM2KmNRxQBPhN9MYQuq8bMLOPsfWeq78nny3AUG8eZ0w9UilVOVaKwNKwzKSMsUjM4rziqfHoDWZaU7F4hiRpR95XW4Cbu50FciqVzW4sUaUddEB2nSLU6QFYinWrOL3yxZLHvb1BiLoHy00+DhusP45yy6oEkan59mVxde+LQaB4FJTcv49ov1Ko62/HpgWTthrHhmhUSZMPSGKw6eBWLyWwfxH9uQI80bGtUWhGvBCvZAIGrRivJKbxsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:58:06 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 10:58:06 +0000
Message-ID: <0ac66b26-9a1b-4bff-94b9-86f5597a106d@nvidia.com>
Date: Thu, 5 Dec 2024 10:57:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
To: Thierry Reding <thierry.reding@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Robin Murphy <robin.murphy@arm.com>, Furong Xu <0x1207@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding
 <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
References: <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com> <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
 <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
 <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
 <2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
 <Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
 <9719982a-d40c-4110-9233-def2e6cb4d74@nvidia.com>
 <Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>
 <pckuhqpx33woc7tgcv4mluhwg2clriokzb7r4vkzmr6jz3gy3p@hykwm4qtgv6f>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <pckuhqpx33woc7tgcv4mluhwg2clriokzb7r4vkzmr6jz3gy3p@hykwm4qtgv6f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 06035efe-4166-4b11-18b9-08dd151bb28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEtCbVQ3OExpRW0rUkIwZStuOVZWTTYyRUJLeEZRZHNab3A5L1ErTjkxb0xY?=
 =?utf-8?B?Q0RidFFXLytqelFRcHp3V09BbG5LeDBCRFgybnJVK0VtQ3RpdjdadFhrelFl?=
 =?utf-8?B?SEUxcjg5c0NSSndjUVVKY2ZpRmo1Q2JDcGxOSEV5L1ExYmhkQ1hCU1NnT3Z4?=
 =?utf-8?B?ZHV6Sjl5d0hsakhkTmZmMkJkYTk2a3h4SkFpNmRmVTVMVVBvdk5BMWNFWk9x?=
 =?utf-8?B?d1J5ZS9vaFVzOTJEMmZ6cmhuYThzd3NUSDdNVG1CQUtYOTlSL2tJVXRleFFN?=
 =?utf-8?B?K0dCRjZTakI5c2szTEdOaWJxRXl1cVVVZThGTmV5NlRTUVRCbHFqUGx5OVBN?=
 =?utf-8?B?RFdsVDJKdWltMENvd2lPZUw1anBYejRlZnJTSHhlT3RGNHRKWHp4am9kd2lG?=
 =?utf-8?B?TW5nMWVEM1pQQmh2UGQzYXZPeDhqaDNDUmxkdG1QbWRRQXpZclkrUWJ2RUJZ?=
 =?utf-8?B?SlVBR0VaeFdTVGVXdDFKcm00dE9aU1E4Vm5GZXNja0hsbWN3c2Yrc0VyZXNH?=
 =?utf-8?B?ZjBKQzhsZ2RpdnpIcFBIS0FCOU83MGtZNnFVKzlBVnJmVE5sUDk1WG1za0du?=
 =?utf-8?B?MW5yd0duQ0pLK3BZd3BZRnVoU2t0MmVnSW5uMU8rTXlseklaZEVzdi9vM05E?=
 =?utf-8?B?ZGMvSXo5b3VYcXJZSzNaYnpUa2owaGRqbnM1WEFYbHNaN2lzRkhFK2hwVE43?=
 =?utf-8?B?T2ZONStQWHl0dElDam55VkhGMnhIR3FBNlVqYU1jcDhObzFVYm1oV3lwRTBO?=
 =?utf-8?B?UkpLYXRXaiszbUswRE8yQml2WW1KeEJ0WVFPUlU1TTU1MGYvNUVSVXU3ZnVn?=
 =?utf-8?B?Q05MaExuZTNoMXpzVC83Z2ZIOW1LcU5ld3NZUEx4ZjB0Mk5sN1RLRmp6Zk9M?=
 =?utf-8?B?cHgySW9iWFEyUkxwdWFBcnZ4VFpjNGlIOWFtNE5KckI2SjhOc3BNMVJmNXdr?=
 =?utf-8?B?WTZTSENmTjVneXVYSFpFZDhrRVVxNUNWMXA3ZUUxK1lIQXdoVVdsUEg3cHpU?=
 =?utf-8?B?elJMQjJ1MnVCWTJOVmFsZHBkMDYwQ1dZejZKUlZsS052aEFJb3JtMml3WWh0?=
 =?utf-8?B?cjhnUFdOZ1FwbEhoZGd1dFgzQ3VnVnBZRGkzTVhRUGRta3hSbWRUWDZPbFB6?=
 =?utf-8?B?RHJnVFZJY01KQnQ5a1I3Rk40dS9XeGhVRERyY2Z6dXdOak0vRDJkUjdib2Jx?=
 =?utf-8?B?U053SEwyeUgzVmdIZW1ENlJQdEFCQjc1L2N3eDRlek5BMHowVjlkNSs3Vlcr?=
 =?utf-8?B?OW9TaXN2am5DSjhuRXR2YTNlWnVRbzZyblB0T2ZOWkxTcmQ5cEczUnFkc0JC?=
 =?utf-8?B?ZzkwcFhWUHNKRlk1Q1U4OXI1ZVg1Vmc4SGk3ZzQyTXdHRjFBa3pwd2ZIbzN4?=
 =?utf-8?B?d2JnSnU2OVpDTG9BSmFVbG5uV2Y5b0R1Y1FVMWw5dWUrM3pKb0M4SHFpQnVz?=
 =?utf-8?B?STlscFE0V3lEM3NmRHM0T3B3UzlaWXVnUGFVMExPaWlNcm1VbzhjQ0gyOHZu?=
 =?utf-8?B?dUczd2Z1UnNWSTJEeEVMRVZ6TUhuQTZBS2dVWWZvM1h6K2FlQi90VWhnQmpW?=
 =?utf-8?B?SlMrNHNtZEdDZnRJNnhrK3c3WXQxaEQxUzVCUGsybVNRbVltQWREQW1DUTRy?=
 =?utf-8?B?aWltbUFJeUhnSXJrbHFtM0RmSnJXNjM0eS9PZ044UGZTQnVSTnlCdk90aHlZ?=
 =?utf-8?B?blUrYi96QXVYcXJya1k1S2VWRXA1ZzlKK0xjL1ZyZzJsY1ZqRWtEZXhqMHJj?=
 =?utf-8?B?bXZTaUg5M2Q1ZnhHK0QyV3JUOFhiY08vL1R0dnIra1dxOUlQRDNvSlNxVmRz?=
 =?utf-8?B?RXRTTURKWDlkdzM3V1Q1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhtOEJJRVhrRHViTFZCTW85ZXlCRU0yL1ZHQUdDL2trbTBSWkpIMk50WWJu?=
 =?utf-8?B?ck9YU1lZd2RiaEE2ODdnUDFPT253UitJWDN4Rm1kaytva3U5bkNBSTVNNTVE?=
 =?utf-8?B?dHB3TlZPeDVETEZIajFCSCs0K1ZPMEswTGFHaUh6S0Y1U2REYklUUVZVSnpp?=
 =?utf-8?B?SGlEZVZZckxMRmIwbFZtL2dVMTd1cWVmdFVLRDltZVUvOGF5SHVBQUJ3eHo1?=
 =?utf-8?B?VERIK1lGSzBpbkVLUmFxTnFBTkh6Rnh5MVBnUnZzK1VCc1MvV2ZVQnhIY2sx?=
 =?utf-8?B?Vzh4NmhJWjhXcXgzYmM0YnJNa0E0bHZBSDh6YXZSeG03N2xjaXJWZ3Q0eTNz?=
 =?utf-8?B?SERHK2tNb2FVMlRqNmx0Q21GRmlNdDFZWEsyNURIK3lhbWIzYnpMUC9ZK2wv?=
 =?utf-8?B?b0VZTU9mWkM2NTgyeS8yS3JvUTV2SExtQTVWUVdiODlPK3pJNzVHWTZJMzFV?=
 =?utf-8?B?dVJiUWVUZEJveGo4YjlFbHFDSis4T1NFdG9sMGFxRFkybi9KS1I3eEwvTVpK?=
 =?utf-8?B?OVBmR0xwUEtkcXZwelB2TlZOM3htWFFScEwzTVZzbW5Hdkp6UUZ0TzZhS0tP?=
 =?utf-8?B?NmMwNFViVEFzRmF5bkN0VkFoRXZkSU5pTUJvYllVQ3NWYVRIZXBtZjVHSS9u?=
 =?utf-8?B?SXk4akVobVBvWG41UGplZ3VKbzZ4YlRmeTFpeXdmWW1KWU9QejZRQndQSzJC?=
 =?utf-8?B?UUs3YUhJS0hEd2tUZ1EwUnpDaGRTOXMzREQrYTRZY3hqQTJBcWt2MWc3T2tj?=
 =?utf-8?B?Skx5NDZxalZ1TFczM3RvY0pVNEV0SGx6RTBQaHZSMUF4UU9jbFpSa0FpeGdI?=
 =?utf-8?B?elg3bGlob0JiUlNGbS9Hdi9iRFU1RWxtSjFDbHZ6dTd4ZzM4cS83dzh2MTFJ?=
 =?utf-8?B?dXRaY2o5dnY3K2o4WTUzRUtlVDVyc3Z2ajdWMHFRdTRTdHYxOEkrMjIyUXlY?=
 =?utf-8?B?ZDQ0UmNsb1NNYVJnVWY3bGhqanJ0Nm55MXphMGIwc2ZtbStPZ2NzeEozM1BC?=
 =?utf-8?B?S1FWZTd4U1h2c2FMU0laN2x4WjZka1lpWnB2YnZxdkVNMVBIUVRyL05GOVJL?=
 =?utf-8?B?K2hOSjI2dVFjYmdhQzl0Uk1lbVZ6Y0FJV1lFQ3BtejM3OGoreFVzdDIzNGxs?=
 =?utf-8?B?RDVkT2VvdDVUeXg3RzJLVnNCK0tJVTdabWVDL2l2T2hSSFUxbW5ZMC84N0tO?=
 =?utf-8?B?QnErekJEZ0ZTT1J1UlhYNERPTU1LWXlMak51T0hINmdqSjA2aWlkTlJjV1E2?=
 =?utf-8?B?bG44amtyd3lmYXpyUm5jRGFaMTNhb01YUW5idHpaL2YxcFU1VDFQeEE4RkxT?=
 =?utf-8?B?NWQzdkZMS0RqVjJhU0xXR2pBblRHNzhNblVuMFJZUVVqS0o1dXFsajVWcnlX?=
 =?utf-8?B?Y3VXS3pvbnJGY2JjM2M5Y2FuNlJmcm1YVkVqVkxVZEFVQlE4YmtOSVNOZDBK?=
 =?utf-8?B?S3lzS3cwUWdObGRPcWpERHRuV2ZRS0doUnZxanVIZ3FxbHlZT3h1WHpKN1RS?=
 =?utf-8?B?TUR1ZnZSMGV0Nis3cFZQZ1U4Z0lSaDVCWFgwelpXaElWUkFTUzJ2VFB3ei9z?=
 =?utf-8?B?d0JsS2lxbUJtaUFiMUxobVdGNnpLUmhsT2Jid21xa09VTTlGN1Jwbk1kVnBM?=
 =?utf-8?B?RnljZU0yYk8vYUt4YnR4WlZjVFlLN205TkkxUnVYZUlzaHhMNnl4RFY4RHdT?=
 =?utf-8?B?QW5aSVFuV3pCak1JSnF3RzZFeVdUNGNQbHFMSklxRVZSV3RVL056aklrbm9T?=
 =?utf-8?B?akVuZUx1ZTlxNklwZnFLWjR5dlorZFRoaTlCd2ducWs0Wjh3OGpiM0NrMFJj?=
 =?utf-8?B?enBQNExjb3Nab0VTblZrVWNnVjJBd1d6R2hPNkZHc1N2YU1RTmZpQjF3YXA1?=
 =?utf-8?B?QVpLUjBHQWNhSGhMYTJkSW1jSUxoc09ESU4zVkVmTE56cFROQWMwZ2RxaG9m?=
 =?utf-8?B?K01ZQ1FtdzlmZEhKZi9YeUFROU45cjcvOU5jTHNTUVVLdk1kOTkwQmFINFVY?=
 =?utf-8?B?UitEUEJ0THdTbG4yMG92UngvVjR6ZUE2NFFheFJaaE9paTl3cnVMK3k5ZUdD?=
 =?utf-8?B?a2dvUThiei9KcDlubnZ4UnlrNXowY2xSaS8xTXBhUVVZd1RDa29oK29oM3JX?=
 =?utf-8?B?N3BBZmJNTW1YT0dDUGV2MzQyeUR1dHFYekwzdEw5MTBiY2QyRU1ONWlCcmd5?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06035efe-4166-4b11-18b9-08dd151bb28b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:58:06.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RxyrPFNqkh04vA/u/PWN8rFF4Z9p5kLVKmb4U/+OthvPiWPP5fraFrXNpf0ipP73czQs8C2lEuCwEpY/RV+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893


On 04/12/2024 18:18, Thierry Reding wrote:
> On Wed, Dec 04, 2024 at 05:45:43PM +0000, Russell King (Oracle) wrote:
>> On Wed, Dec 04, 2024 at 05:02:19PM +0000, Jon Hunter wrote:
>>> Hi Russell,
>>>
>>> On 04/12/2024 16:39, Russell King (Oracle) wrote:
>>>> On Wed, Dec 04, 2024 at 04:58:34PM +0100, Thierry Reding wrote:
>>>>> This doesn't match the location from earlier, but at least there's
>>>>> something afoot here that needs fixing. I suppose this could simply be
>>>>> hiding any subsequent errors, so once this is fixed we might see other
>>>>> similar issues.
>>>>
>>>> Well, having a quick look at this, the first thing which stands out is:
>>>>
>>>> In stmmac_tx_clean(), we have:
>>>>
>>>>                   if (likely(tx_q->tx_skbuff_dma[entry].buf &&
>>>>                              tx_q->tx_skbuff_dma[entry].buf_type != STMMAC_TXBUF_T
>>>> _XDP_TX)) {
>>>>                           if (tx_q->tx_skbuff_dma[entry].map_as_page)
>>>>                                   dma_unmap_page(priv->device,
>>>>                                                  tx_q->tx_skbuff_dma[entry].buf,
>>>>                                                  tx_q->tx_skbuff_dma[entry].len,
>>>>                                                  DMA_TO_DEVICE);
>>>>                           else
>>>>                                   dma_unmap_single(priv->device,
>>>>                                                    tx_q->tx_skbuff_dma[entry].buf,
>>>>                                                    tx_q->tx_skbuff_dma[entry].len,
>>>>                                                    DMA_TO_DEVICE);
>>>>                           tx_q->tx_skbuff_dma[entry].buf = 0;
>>>>                           tx_q->tx_skbuff_dma[entry].len = 0;
>>>>                           tx_q->tx_skbuff_dma[entry].map_as_page = false;
>>>>                   }
>>>>
>>>> So, tx_skbuff_dma[entry].buf is expected to point appropriately to the
>>>> DMA region.
>>>>
>>>> Now if we look at stmmac_tso_xmit():
>>>>
>>>>           des = dma_map_single(priv->device, skb->data, skb_headlen(skb),
>>>>                                DMA_TO_DEVICE);
>>>>           if (dma_mapping_error(priv->device, des))
>>>>                   goto dma_map_err;
>>>>
>>>>           if (priv->dma_cap.addr64 <= 32) {
>>>> ...
>>>>           } else {
>>>> ...
>>>>                   des += proto_hdr_len;
>>>> ...
>>>> 	}
>>>>
>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
>>>>
>>>> This will result in stmmac_tx_clean() calling dma_unmap_single() using
>>>> "des" and "skb_headlen(skb)" as the buffer start and length.
>>>>
>>>> One of the requirements of the DMA mapping API is that the DMA handle
>>>> returned by the map operation will be passed into the unmap function.
>>>> Not something that was offset. The length will also be the same.
>>>>
>>>> We can clearly see above that there is a case where the DMA handle has
>>>> been offset by proto_hdr_len, and when this is so, the value that is
>>>> passed into the unmap operation no longer matches this requirement.
>>>>
>>>> So, a question to the reporter - what is the value of
>>>> priv->dma_cap.addr64 in your failing case? You should see the value
>>>> in the "Using %d/%d bits DMA host/device width" kernel message.
>>>
>>> It is ...
>>>
>>>   dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width
>>
>> So yes, "des" is being offset, which will upset the unmap operation.
>> Please try the following patch, thanks:
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 9b262cdad60b..c81ea8cdfe6e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>>   	struct stmmac_txq_stats *txq_stats;
>>   	struct stmmac_tx_queue *tx_q;
>>   	u32 pay_len, mss, queue;
>> +	dma_addr_t tso_des, des;
>>   	u8 proto_hdr_len, hdr;
>> -	dma_addr_t des;
>>   	bool set_ic;
>>   	int i;
>>   
>> @@ -4289,14 +4289,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>>   
>>   		/* If needed take extra descriptors to fill the remaining payload */
>>   		tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
>> +		tso_des = des;
>>   	} else {
>>   		stmmac_set_desc_addr(priv, first, des);
>>   		tmp_pay_len = pay_len;
>> -		des += proto_hdr_len;
>> +		tso_des = des + proto_hdr_len;
>>   		pay_len = 0;
>>   	}
>>   
>> -	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
>> +	stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags == 0), queue);
>>   
>>   	/* In case two or more DMA transmit descriptors are allocated for this
>>   	 * non-paged SKB data, the DMA buffer address should be saved to
> 
> I see, that makes sense. Looks like this has been broken for a few years
> (since commit 34c15202896d ("net: stmmac: Fix the problem of tso_xmit"))
> and Furong's patch ended up exposing it.
> 
> Anyway, this seems to fix it for me. I can usually trigger the issue
> within one or two iperf runs, with your patch I haven't seen it break
> after a dozen or so runs.
> 
> It may be good to have Jon's test results as well, but looks good so
> far.


I have been running tests on my side and so far so good too. I have not 
seen any more mapping failure cases.

Russell, if you are planning to send a fix for this, please add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


