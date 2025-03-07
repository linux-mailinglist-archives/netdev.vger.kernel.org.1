Return-Path: <netdev+bounces-173005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F65A56D3F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF513164AF0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6940E226D0C;
	Fri,  7 Mar 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IGmzej1+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48D220696;
	Fri,  7 Mar 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363893; cv=fail; b=h4CnWPCfz61AypLGcmUnwn4ZopAp8zg97A+K30M0cCU5G+KCwZPFq4MSvvnUNf99MuRt8Cf6P1WEkMnUidDaCM86Ala1lxVfjA/8bb3PuIVN7pMzeeV2txsV55rPh2trC9QmvJWt3Fqj6xUoFTkt5dda+DiI0qalXxKmu8oGbCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363893; c=relaxed/simple;
	bh=z828COofRP4MZKJG1DO3Y28eqroxG/4265JXCXrFueY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhHLvm9Rdtku2MJkjGK1kU5LzM/Ta3IUPvuugw42Yrp+cej8iy9UNk/3jE6HCL8nznN1g2nMvB/3+4BfX7wJ71dyC2c7Bw/UXZdzwYDa1CToBtFIgnu3dw04z9k8ItMXVM4Bqke+pLaw5pQJvQr1foHB2sA40z/MlCMxg4qeLwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IGmzej1+; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0EwFDjkstvTqwVK0JY49+ByiQIae9tfiql2rjdyTnLnQxjDk6DXOe21U7FkdcHJ6XJJRzqZixuQtU1pvt8vJGlFJcQEKbzOJ8oT2BCKFWXJTdObZ6yGvAPqnFT6N1C7HoPhsKd/sfYWLltM6Uf08yaPBfUPn6bCC2gY8aiDesGhSRlN+8FmJ/4GO1ik4jbRGzYxfnEPSbxG2zhFpTLISXW4UDCHEIOAMBQaQ8k8WYg7TZLyAPq8mY51KBAHR3vqkM1TYoIcJfd1SGB/GwpIRdEz1FKj4rWztV4PN7e/jMrLi2M01Zs0nDZ9YwqLpqJZ7+3Dy6jRIYS182B7YV6bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBYuoHWs860VfL10nrLLC/KLmKXNfHEYvVGwVj9ipH0=;
 b=QO0D7N7Z+efjoCWoB8aj+4mxUQhIjF6vW7hhvpZs7HQOZyFAdgG/ibtfoPzuEamQIyFCbMJMfchleaYrB48eNvUM8+MwnSYjbASmferSyPho6w7J62VvvDLq/6qzpvELmHXCzQumEeBU7LmDm2gfNbUzAwJV0pihinK83Xuvi5OWWwRicOauGvD1CFrIUXAJgfspTs22e9HyLpVtGgGBBWpOMrIhSBbtkqFaupn6yiuy3Rhx9dilJQU2/OaHG518J8BsZWMTyDeUZze7zje0MFDojdrOCbI9H5hMSaHExVUMWWdBTFzaN6fGLmN1SOusKgFcud62b21IDcBO1fpt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBYuoHWs860VfL10nrLLC/KLmKXNfHEYvVGwVj9ipH0=;
 b=IGmzej1++HCGfEgVYgvItJPjG5ewSbClF6VQpc1+084y3SoyXqqCe3o/qAP2bdmZFAe16V1pneo+MpiFId5kmb14qPJDoaQ0wHL/9E/DQFK1uz5TstVkdumCeaIiP8uiwoEWY153nphglw7s3LP27AQp0l4do2qPdTknoxqxky4ErZmIksmQFYD2u/hwzvJ2AjNba2T/dA//+vKw6FfJC39IrinqponjG6qhkb8N4gft/sx24AbXYRKrIeHH3DJdCLE3/5ZeC5XrHHFhL9bZqLBGWTXwVI/w6ZQz2BZxE/Z0gFG33Apzdvp1w2FHTnliJlZV/b7bW+0OZT5cM33I9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 16:11:28 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:11:26 +0000
Message-ID: <29bc7abd-b5cc-4359-8aa6-dbf66e8b70e4@nvidia.com>
Date: Fri, 7 Mar 2025 16:11:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 0/3] net: stmmac: approach 2 to solve EEE
 LPI reset issues
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Thierry Reding <treding@nvidia.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: be366105-c7db-44ce-3af4-08dd5d92b604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEpiaHozb3NSSWliVUxaRGNoR1RUcHpteHhPOXJOM3FNUlNBVW5NendONGQ4?=
 =?utf-8?B?T3g4cHhyWERFejdqOUtTUjhuTG9qV0pCUTZvNE11VEl5d0ZtdVJpWHZZdGJ3?=
 =?utf-8?B?U05lOVUvTGtNZGdRbndVN1I5OTl0bWZ2TUlnV2t0STU5bTIrdkRIdGtjWXZN?=
 =?utf-8?B?R0Vka1A5aWxPS0dEc1pHTVZYWEZ6WjE5NnoyZE1vb1lvQkpOZmZCbFphT3pV?=
 =?utf-8?B?M0ZVTGdlNDNFejhPVEZIRmZLemtaa3ZDZnQ1STZWVFB1MWFUbmI2WWRQSkM4?=
 =?utf-8?B?Zzc5RWJGYklXdUVFNlVEWGVXRlY4WjRzNUdIa1RPbWRmQVdPcVhlcnIyNmlX?=
 =?utf-8?B?NmQ1OGxWZkMrRG03MWMxQ3RHVisxbDdha29NV2lUL05nOEdhYXdLbStHdkpK?=
 =?utf-8?B?aUM0dy9kUFRYRVh2VXJtRXgxOWpFa1JiaElNZ1FLZEJiSXZPUkdvVjZLaWVM?=
 =?utf-8?B?aWZVSS9XU1lYclVoVGoxNWp4eWtXbnhPNnE3K2h3cmhaN3FNc2h1b1RKK0Z1?=
 =?utf-8?B?ZjVIaktXVWF5dFV4bG9wTG91Ym5XZkhWd0hpazM0MDEzcG9TbGpkaU5PckJZ?=
 =?utf-8?B?bWpvQ1BMUEFqU2ttblJpS2EvamVOaHoxRkk1bVllTGxvVUFpVXNmSXJsdmVX?=
 =?utf-8?B?NnphOEdEZGRPU25EQlZCUmxHVmhhZzlWdXB3dFVoalRoN0ZoOEJtSWtsT2NJ?=
 =?utf-8?B?TlMrb2lycnFLc1dNTDVUYkVUT1l2SXBzMWU5Qm5yb0MxUXl6OVpCeTJ5UDk4?=
 =?utf-8?B?QXAvWk55ZkJoZVF0OXRkNGY2UWN0UXdGZmpWSmdpZ1pQM1VYRUZ4clBHMEZn?=
 =?utf-8?B?NjIyYi8yaGFhMHFNczQ2eVZJOVQ1SlluTUh0bXRMMDhPV0VJbmZnL0ZSM3cy?=
 =?utf-8?B?SHQ3VXp5NHNKbFNCaDVubG0rRHZtcEMvbHJkYXovWHplSnZndUxieTh4WnM4?=
 =?utf-8?B?c1RqVHdacnhuSEw3UzdnNTVxb3JRd05nTmQyR3dCeW9KeDRVbTNvNjlPMXRX?=
 =?utf-8?B?RVZnelB4dXJyNjdkeUhXV3phd1hkUlI0cTcwVE9IZHRpc2NpeVpKK2NoOUd3?=
 =?utf-8?B?QUxQUVpvaU0rWHF3aDA0QS9uMzNHRit5N3ZnQVFKZWIyYmxWZGx1dEJ1QnZN?=
 =?utf-8?B?N1NCN1dZTXdWTUJKc2hwVXp6TDJYWVlKODlNMEpnTFpWcjUvelpYZ1F5ekY4?=
 =?utf-8?B?UTVJK3Q1QkFNNWZWUlFlRVl4eUxrd21iYkkrMG9RZ1A1N2owYTMvcE9BdGF5?=
 =?utf-8?B?ZFJMWkJiSVFYMythdGFMMXJhWTdOSld1ZGdadnR5bXNNYlIvb0hzeTFPckhh?=
 =?utf-8?B?ZVcrY05DYmpSYzlwYlQ0NkVrLzZrNUVRZjhKSFBDcmhwQUw3UzAvVzdiMmJZ?=
 =?utf-8?B?WCtURk9uYVVYOTZXNnRDU0lVWi9sUjdjQjI0UFQrS2Rna0RmVi8yNythNmJB?=
 =?utf-8?B?WjZjK3NMVmZyc1FQOVZNWGlqd1p5RXh1eWlDY0lidkgwVTk2N01WeTZEQlYr?=
 =?utf-8?B?TWcybjJ6UWdUZXV0UDlmdUlmNkR6VzNWR0pQd1NpbDl3VElqdkpVY2pYa3E4?=
 =?utf-8?B?c2ZFYzBUN3RBZWg1ZXFKMHZJeTBnVWVjZVdnR0FsTkY1eVFMM0kvZjBseTgw?=
 =?utf-8?B?cS9JTS93ajRyVllhdnE3TW0wM0RDeUJRVitOQlVzWkFLYkQrcWw5L1BFSk40?=
 =?utf-8?B?d2tSdlI4eVdUY1FuM0tRYkRRbHN2bEpSSGhubVlzSlZhcXJ4S2N6dzEyK25J?=
 =?utf-8?B?Kzh2cUM0eWdQT25GRnhlcDdVTURkSitqTjliQVJmVnJEZmpxWFU4SU9zeXh5?=
 =?utf-8?B?SS9mcGFKczlyakQyQ0hjV2JKckk0WEdCY2xtL0V1cHZDRkNma3MxTFFaNkt6?=
 =?utf-8?Q?qQ+5P6M9n7SD+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXA0bFJRTkZMSklmd0pXYTVDanN3U0M2TnZSWEhqanRtZ3d4NFJ1ZHMzL2x4?=
 =?utf-8?B?VXFnYmRvNDlzaUdmYlFUaFl2TWkxNkR2M2dmWGZVS2FvZFhNbkFlSkZla1Ar?=
 =?utf-8?B?Mkx0a1dKd3BHZWZKNG9kYzhKVVg0OGdzbFBiSURkRzdNUGRyL3F3OWlUNm1S?=
 =?utf-8?B?NTV0NFRZb3orSmZFNE9vOFgzQ1ZaMEZxalpBRlJ4VzRKcjJGd1BnV2VKWnpN?=
 =?utf-8?B?MWgzZVZhTUVPdk8vZUhQNy9jdko5bUF5OFhIcng0eHNQSDF5cU16T1pFOHJ2?=
 =?utf-8?B?dm5UeUFVMDMrRDEwK05XY3FNaWRLRDBRN3p3aW9ya05Sc0tjSGRyZXRZekZs?=
 =?utf-8?B?bjIvaUhPbkRBUXp1ekliL1FuN3N4aUpuWmZLVTZHR3hiMzZrR2VpWEJ2MGVN?=
 =?utf-8?B?SnB6K1hhWFo4Vy9WVXdWdm5qWStKR0w4eU9lQ1hsNXo3ZkovdDFmUDlyUnFU?=
 =?utf-8?B?WDljcXdDeCtRMU5ITytPdE8vTFphZ2gxUkFWejhSb1hRTUU1QlNXc0xaOEQx?=
 =?utf-8?B?SWt5bzFvMVVrUEt0T1dhR2EvcGxaL1lQTGZYYUU0RGtsS2d1enJ4ZHg5em54?=
 =?utf-8?B?THRlU0gzZHovMlhOcDU3eVdzUDhpbjF5SXpua1QrazEvRU43WGhCRTFWakpn?=
 =?utf-8?B?ZEJLbXB0bW9uYlVSUnphYi9tQURoVkRXQi90SForNGhhdTM3VzFCSGRyT1ln?=
 =?utf-8?B?TCs0c1hYbzhJNTFHNmlDdnBicjhUUnVpZDFBS1VsMWw1YXVkdm0ydWgvb2tU?=
 =?utf-8?B?UnpQbWJ0ejF1M0xKbVFaUXR4Vm13ZVpRUURtSFllWFdvWUpPclE5SmRVVFAw?=
 =?utf-8?B?SDV0dk1PUXhsclY1M1RGR2svRTNVaFl6Y09mV2FGck5aWExGTXhscHJDb3Rq?=
 =?utf-8?B?WEU4OVJKY1FZK1g3bTJtdjVBRjFjM3ZkYWpYZWdiWUNrRVJXdmZKbTFsbzk4?=
 =?utf-8?B?T3JGQU5IVklMazl1WVVzdStaZURrQkJaVEtBSFNaZER2WEJIbURpa0hEcG44?=
 =?utf-8?B?d244NStCTUpsUFdFWjVsaW1iRU94VVlUNlg1UmsxWnQzQ2Y4eDVQeVJsaXpX?=
 =?utf-8?B?U05XU1ZuMUFKbkgwRFZWVWZ5SGV6RFFTQkF2VC9HdkZkQUZhanMrSTlBU2tD?=
 =?utf-8?B?S0VsWjFRclpiWEU0NUVZYWNNM1FSRXZHMkFjVmdnTlFxZFpTem9meTdqLy9D?=
 =?utf-8?B?d3AyRE1ON2V0c0VQM0VYZkEyTi9VWWJsKzdLTWdvajVxaDBpbjJSS2FYSWYv?=
 =?utf-8?B?UmVxWFdkbjdSM09TajdkZzNMV2lnMCtZSGtNbnRTRWFWSVRvdGd3VytZajFF?=
 =?utf-8?B?bXZTcnVPUXc2UmY2ZTc4WWV5K0w4c3FOQVpXNG83NS80YlN6cXdLYTRaMDc1?=
 =?utf-8?B?Q0tYV2hIbm1MakxkU2ZkbHpMMnYyOE5WT29OOEZJZ2JkanFjZ0dKaUJ6UHdi?=
 =?utf-8?B?MUZRNlVUTUp0Y0xGZU1LQ01Xb2RubDBYMDlJNmMreE4wajA5OXdPQkg1RmdH?=
 =?utf-8?B?SXZONnJHUnNyS0U2STc5S2pUVTFpUjlIQ1IzcVZld2JQdU5TV2dvbkpJdnhK?=
 =?utf-8?B?Mi9BWG9tc0RkaGhwbW9mOXlZOEJsNWl5ZUlPbWt5L1dRNWlReVlNTnN2Q1NU?=
 =?utf-8?B?ZldFNExMN2tIaXF1M044QWMxMTlOU1VMbGhCa1RRdEVDc3pGN21SRFFUN3V5?=
 =?utf-8?B?OXJRU2JXTVhZMy9OWDdZNTlJVmkrMzhGT01oTFRsMWZPSXM0ZE5rK3UvTWVR?=
 =?utf-8?B?QTBhSW54U0VuSXpQaVZuTTZ1enFkYktwclI4eUl4aEt2cHlydXpPRmdtbUpX?=
 =?utf-8?B?WnYzSC9Uc3RYa0NHUkhEeXlmQm45eGdVWnR6STNET1BKRWdnUDZNR3dLVTdG?=
 =?utf-8?B?ZXBmTmpMblBXWC9vc09wTGltUTBqVEFhdWh6MTdyZ1dFZ3RySXptWmdETUxa?=
 =?utf-8?B?bUcwWjZDK1ZNY3JGRHVhaDAvRDZSNU9ScVFvaXlrK0ZhTVJ3QWJzWmRlemFo?=
 =?utf-8?B?S0xqaXAva2pBK3Z4UldoaXlOVWVpV0xDZUFKSkZubkduMUFaWkt4SGJZbTN3?=
 =?utf-8?B?cVZOK25IS2NHTStVdnVpZlUwNjdHaEdsNllwTndVT1d1M1YvQnVaUDFyYnMw?=
 =?utf-8?B?NnBqOUJQN2szLzlmNWo4MDdXazF0cDFVM1ptcUg0eHVRRHdhS1RMUTNoVEJt?=
 =?utf-8?Q?w6vtHqahaV5GP8wKRHWuJoqz+XeBOG0vBscptb5OHfH/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be366105-c7db-44ce-3af4-08dd5d92b604
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:11:26.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcMktB9DrG7FicFT29tR0fJvholaE1v4YBcnaEJNMi7TyF/PR7KBsUAxivTR7MhSumTnPX0mg5CeOeNcwijDAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

Hi Russell,

On 06/03/2025 15:23, Russell King (Oracle) wrote:
> Hi,
> 
> This is a second approach to solving the STMMAC reset issues caused by
> the lack of receive clock from the PHY where the media is in low power
> mode with a PHY that supports receive clock-stop.
> 
> The first approach centred around only addressing the issue in the
> resume path, but it seems to also happen when the platform glue module
> is removed and re-inserted (Jon - can you check whether that's also
> the case for you please?)
> 
> As this is more targetted, I've dropped the patches from this series
> which move the call to phylink_resume(), so the link may still come
> up too early on resume - but that's something I also intend to fix.
> 
> This is experimental - so I value test reports for this change.


The subject indicates 3 patches, but I only see 2 patches? Can you 
confirm if there are 2 or 3?

So far I have only tested to resume case with the 2 patches to make that 
that is working but on Tegra186, which has been the most problematic, it 
is not working reliably on top of next-20250305.

Cheers,
Jon

-- 
nvpublic


