Return-Path: <netdev+bounces-173561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816FA5976B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B34D3AC0F5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D422B8BD;
	Mon, 10 Mar 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDEWS7nF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2F22B8AF;
	Mon, 10 Mar 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616459; cv=fail; b=s4trE6NskUd5ChbsVWTVh887mBDL7ykNujPpH0tWBK0FykhEjTUVEoTlxd7u14OPXEHlcpm7aPLym2yDGmlXiypvvt+FcM1DZhWeAmEnkTQD6jMbOc4CRu602Wj8MdDRTEYFzzouY5uOjhss5q1y34HT8XamRZhI+HwOmfiJ/A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616459; c=relaxed/simple;
	bh=HrjNDjfwrnDDGrVR1OahTfP8m/VTXuGnR9R5h4wS3lg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3NcXlIxgeoQWm0peiD3oUkF4Qj7JFx7YJ/6AqAWm2d1Ph0+FfGoeUwrP9wudywL4oJ90do+4RUA981jSgMxJB0mWAOnE5/gfPfed8LDitrNokeQlLdRp4te2F7/KbpJvNGxt1wDpeSokUFarenZxAdni5+lyJ3tz92pX3e148E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDEWS7nF; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTcg6y8S+3Rjjja6xdw7UGhltAvv61Rus+560/EciU+gKFfqfpJ+7j74AQUOPXCy0ucHH5xu+lRk85fGqxmoxYgzd8erT1yh5jfCJxsinzNhGCd+tjBVZ3UTvVa9a/wZvmhde/LDojA7ur6fIPHtW7fDGMbnVCNaDJVFPU2zKwsn/tENFRFIOUKcuDyrYdJ/vjMskdlZ12GwHincWL65F1pimVX7OKo3LE9DNdZ0C0P6OH0aZlFWdO0K5+vJF8ODz8Nc+Su/1YpV0f/h+hX8zzSCXybxi5rzZ9faEJwjkea/Q6n7Ja6DVicmeA0PxV8LyhdDOWcysrGewIyxwZFE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9OZZegtcLeXX+VSscLRYQF/kF19JxG9+MzYpAv6H0E=;
 b=hpvqxWK04+JdL6FVdb41dlkBhFXlQ54gl6flFUNjMslrukhN4wyPmSUmtEjgWME/rsV3hkJCCE9NFXgen9/cR0CR7LhXjCRVR/3Euiwu0+YcGiWRhPW12V39Oa1+jqA9KNq36e8ZcY6FAtzmusRXi6E5eGhPrhKvqcZIRqKhz08X4RynHFrT8ONB+79bX/dKxzg6nSQsb3HGOl/H9e/G3PGbjC8qFKZQJRX2uIZHwFyOqFXdflTYyWe4cNk8EDQGrjZC3r6VVo0iqfueh6Eq6HeOetekJ2Uj12h8lx1G/oddsDIjJOHTrunRBrRkaw2zG2C4Mb4QDQD8bmPq1ei1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9OZZegtcLeXX+VSscLRYQF/kF19JxG9+MzYpAv6H0E=;
 b=jDEWS7nFNBzaQ3gV6GHmNr/R6Ob3/BeeyEZuvRUaYfZ6mnbgpZaUOcVfaJWmqLFw5aGUp8UnZMs34y9tEbZEOS2UM+oQkSE4/h3RhnNMhA3wQPiQCcwApDTLICuyP3kzlyynOcwapVIVFpOrE7W/ZW0AUndmOtkwKpjnZ6ObPaSdQ6HyfUXkcsGETAQ0pLlJO0YTUlrEUpNgPiYq28TBTl8pFGDb8pQpRgB4yHv/w+7a+SZPFfD6uMQT1jlf5SWNeK4G5b2wPz7Ydb6uFjkl2yIO9KZJajlTfaf4RY87TdXzmnC844oAbYu8eZHO+mRHZSrSl0937mS2ME9QMp47Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:20:53 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:20:52 +0000
Message-ID: <673e453b-798f-4fc1-8ed1-3cf597e926b4@nvidia.com>
Date: Mon, 10 Mar 2025 14:20:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v2 0/3] net: stmmac: approach 2 to solve EEE
 LPI reset issues
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thierry Reding <treding@nvidia.com>,
 "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z8m-CRucPxDW5zZK@shell.armlinux.org.uk>
 <29bc7abd-b5cc-4359-8aa6-dbf66e8b70e4@nvidia.com>
 <Z8sn7b_ra_QnWUjw@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z8sn7b_ra_QnWUjw@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0402.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::30) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfa8d87-590b-431f-bad8-08dd5fdec361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1lMdnU4Zk4xcnh6djFidXZJbFh5RkNzMVNZa1Y2M01Ydi9QT1JiK1QyOFlq?=
 =?utf-8?B?eUw0d1JsVWhyV25xNDFqdTF5S010SldFN2NaV3Q5VWlVWC9McHp2SWZyaklJ?=
 =?utf-8?B?Snp5aHh5azVxUjZtV0R5ajM5d0gxMG4rNGtoLzMrNGs5dDIxNTBZQTBMSHZZ?=
 =?utf-8?B?RUUrbHJtSUY1WHR3VXhYY0NuSU9RemdLQkFDMmNOemE4cGl2eEljOE5sOSt4?=
 =?utf-8?B?ZHRaampvNEwwQzVwQlZyWjhHbjJwTDhmamt6V056RFluMUNnSDg4TE8vMU11?=
 =?utf-8?B?d3lQQkN1MkZoNHpMYitpYlRraDdUWXZ1MnpjbXAzRW9nN1dqR1I4bWZCUnlX?=
 =?utf-8?B?MzhiUzNQSEhxM1Exek5UT3BTWkNHU3VmZ0wzMkl4YnNOYzlOZkZRb2JVeTdL?=
 =?utf-8?B?OXFKV0Z4Q3Q3dzhkZjNjNlg4eThlRXp0cU5seTB2L0F2VDFsY1RtNmFpL0xy?=
 =?utf-8?B?OE5aRURlaHlReVFLaHluZDBFYWU1ZUh4ZGRySFpHaXRuNUlMTkowWGZVSEdL?=
 =?utf-8?B?SlZLV2JhRklNVmN4TGpsRWtyajBFQ2dXTVFjd3pKUldpenByV0dkdlBjRkJT?=
 =?utf-8?B?ZUpzM2JFQ3lkT2Fyb2I5cVduT043QjZ3M1FHd2dSQ2Q1OUR0dzJ4L0JaSEs5?=
 =?utf-8?B?YXFzcVgvWTFsd2N3T3dsalpqUC9iZnROT2Q4UVM1OHllRytUOWo4MFVya3l2?=
 =?utf-8?B?VG9xUHc5OGZjZkUyamw2ODlOMm1MRm1CR09uOXJCYnVGWW9zR2NnNDRBUW9X?=
 =?utf-8?B?OTVHVGdVV0F2eHliSytBMEFPNnZQZVNKQ0xnUWxaZVF2QXlFdlZSRkNUSk03?=
 =?utf-8?B?TTU2YVc2dEkvMHpvREhXcXdackxFeTlMcU9XMkVWSHdlV1lGMGd0YUo5NWwv?=
 =?utf-8?B?UzJDcnQ3bzNYUk9OZnlQMHVXUGhpWEQ5MW85eWxocHFYcWRUb1ZESy85Vjkw?=
 =?utf-8?B?eGZPdUVJTGNjTDZjWWJOaXNjWGlJVkZRUlB0WHhudXpxY0p3RVdyb2RUM0FW?=
 =?utf-8?B?MFVEcnZBV3UvU0luUWErd2xRV3cxc3RLVUo0M2src0Z4SnBwK0EyNTBGTFVk?=
 =?utf-8?B?aGZUSzYvNHppeDBCTWdJTWt3YzZibGtJM2d5UUkyYTNYT04vMHV3b2U1QnRE?=
 =?utf-8?B?VnNsemZrM2YzdUNjSENpRDhES25PdE4ybUJEcGZ1c3VFSEd3WUpLSFNDVFlk?=
 =?utf-8?B?Y0E0VVgydWQ5SHlaRlVvSmIrTmtaY0oxL2RDVWFXMnFycGNDaHEzWUFZSDNG?=
 =?utf-8?B?bUd0QTdkWU43U1ZENWd1UXM4SDRwY0Q1aVY5NnRSei90bmJuYmZuS3RPeHFa?=
 =?utf-8?B?dmFBOUR1NVU3ZHMxVGE1MGRaWXZDemdHU3F4WWlldmlScHNqUHRHRWJRenZo?=
 =?utf-8?B?WEJ2bXpXUVFWNEhSSkE4K3BHa3lvWmg3dzFQQksvcExxU1ltQmE3QjlXYmFS?=
 =?utf-8?B?UktwQlg3R2RSR0dQQzhHWm5BNzFKU21tbEZvWjJRUG1tdFVEWmxxbG9IY0No?=
 =?utf-8?B?aGJKNWdpR2pDb2ZHZ3FHUUFWY2xHZ3JrMTNZWjRtUUM5NEpFMHFsRk9aZ01O?=
 =?utf-8?B?UzU0WHlrVzB5Umt4TGJwc08rQ0dmbENOVlZMZ2lmblU5UEsxN0RYdUlWT1ps?=
 =?utf-8?B?dm9VWk9RampJRnZsMkJwZlRQZUdrcnFUVGpvNXErQVVwVDZXRFV5eWoxQ1ov?=
 =?utf-8?B?TVk0ZWRwSzA4N3BXMzVwWWhRRWUvNDcxT0NYRk5HNXpwRjZKVXc4bGRrc3lk?=
 =?utf-8?B?YTQ4MHdqQ0hzbjZxZFJld1VIbUpuMEphbkI3eHJmb2tUOFg5dzhPckR6b2Ns?=
 =?utf-8?B?cStNQ3NUbEI5N3ZwemxtT1BuSWkwQWxwekNhb0w4ZzUycEdTakhXUlQva01V?=
 =?utf-8?Q?Mt/IxLP4UIOSF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDE3RVdsNmdOMkkxREVldFVJR3lXeEJNYzJ1U0hOTyt3NnFUaml6RkNKZ3F3?=
 =?utf-8?B?WFZvd3dFamlqUTdWcDRXL0ZlNU5tbWpOMXBWWDMvUzNHSFRTL1ZkT004anJH?=
 =?utf-8?B?clAzeXZyZGhXQlp1NUl3dEtwT09MRGVtOTdxd2lDRDEwRHJZSkdKYXp0NHRa?=
 =?utf-8?B?aWtEcWFNNUUzNXpmb3RsaXFwTTRzSnF1bUJLZFJNbXh3OFpjVEpNeFZ3c004?=
 =?utf-8?B?Vm5BV2Z4Z0RSZ3RIL0d1T1RNZVl5VFc5OFBBS0pIZ0xybnVaZUk4TDlGQ3FT?=
 =?utf-8?B?U3dlSUlKMFJPeTkyL3RzVFdnVTBrM3pDa3pQT3JhTFpUMjRqT3hOM3RFdnZs?=
 =?utf-8?B?T1dSM2t3MWZmMURzaUZJNVd5TVNuam51WFAzRGUyVGo3bEpUR2JpZmNTYmlt?=
 =?utf-8?B?V2RVQzh0c1RKZC9TazNacnQ1OWRsUFdoRzFQTHRJbkViTUtlY1Z6dUprNmVt?=
 =?utf-8?B?aEplbnpDU3psTDJuUVk0dDVoVDNUNjYyeTk5UWFaM0Z0VWpBbmdJTnZNdTlB?=
 =?utf-8?B?UXVGcGMveEtUQi82KzhOK0lyRlFOWjNOa2YrSXpQU1BGbk8yZ1M0aWdsNUtU?=
 =?utf-8?B?VjhHNU1lWDNIVkJ1cHh5M0hjYjR1ZE94Z3ZCNUJJcW9FYlpWeHhFK3RadmZT?=
 =?utf-8?B?QUdKcHhMWXNCMGo3YlUrR2o1YVNLblZhL0czUzVBV1pBY01MLy9rTzdEd3Y4?=
 =?utf-8?B?ejJ6VlkwZUtwN2dIN2RNazlPd3V3WGRkZkFSN1NEU1ZYbVVwY0NRM2wyb0Uv?=
 =?utf-8?B?b240QnV5Q1hGWEtPN0lSTitKTnBEV1JOV3UvdFlSTk9uWEpnODZkS3BqZis1?=
 =?utf-8?B?aFFBdXhZbWVVQXIrTHlYc0l3Y2JVeTNVZ0pHb2Erb1ZpSXNKNG5lWEZWUVdI?=
 =?utf-8?B?T1hkdVl3TFNQalFQcDRQVUMwWHJoS2lWYUtrVlNBcTZ5d2tJMk9uMW1JTTdT?=
 =?utf-8?B?Sm1Vb1BOcjBBaWJhd0JzczJjM3hXNzRrVHRuY1MzQ0NLU2FWa0hQTFNYVDdp?=
 =?utf-8?B?WDJZWWN0U3RsU0duU3ZoTy8zcGtuWHg4TUxuL0o1RmlybUQ0Q0ZjWk9lcUV6?=
 =?utf-8?B?WGl4eGE2UEJSVlFVWWhvWkxBRElQNUxubGREc0ZFdnJ3L28xcU9PT3dWbHp1?=
 =?utf-8?B?eUY0ejZCMlFxUzhQdUp5aUExZGd3alBXUnJKSVY4TlpNSGxYRUpjbHpJUkVx?=
 =?utf-8?B?RUN1TCsxT3ROOGFPYlN3ZmduTkNsaW4rWmp4MW5JK1ZCSktjQ3NOMU14aDJG?=
 =?utf-8?B?SmM4MkRqTWJ4c0NmSXNWeWhRMkM2TGRRVXpMQXhDNDhudFRnSmF0UmcrT1RX?=
 =?utf-8?B?L1cwOWZYMllwMDlHVElQa0xLc25ySjhiNWR3dG1zeWRTcFNFdnpTbmd3TjRI?=
 =?utf-8?B?SEZ4L3Q0bi92d0tYZU52ZVU5eGhoTzZYVFhEWDkxL3RRSXdaSEhzbzJ2SnlH?=
 =?utf-8?B?Y243dllCNGpNd3hnOEhYTHlSOVdSRW1zbXhnMjBpcG40alBiaGRxWEJNOXRu?=
 =?utf-8?B?blhEenlGYnBOZ3FyQzV5U25TSUJseDF2dVU4OHVCQzlyWUU3TW1KZWZPOU5i?=
 =?utf-8?B?WUxGRmlnUWFxZXVkb3c0SGM1dEhFUFBnVWoxdmY2S2F2V3lISm8wQWMxTzZt?=
 =?utf-8?B?WjJiMWN1K20yQ2Fjc1FpUnloNFZwaWZpUmtoNXhrNnVtekJnNnM5blU5RjR5?=
 =?utf-8?B?MFpuaHJpeGQ3Nmx5K2ZBN1RTOGJFeFczMGRTYkJ3dFc4Sk14dGhkUlMyMTM2?=
 =?utf-8?B?UGhwM3V0TnNZdXVreHl3YjFnbjVFYjNJcTVOMlVUc2RvcmtYTVdLRlExV3RI?=
 =?utf-8?B?OVFBbitETWlnRnlmeXhVaGRycnJMMmx1NTdVbWJLSnBjZXJaNkxVZTZ6Ritq?=
 =?utf-8?B?L1Rac1RYdkVYVXhKUmVHbXM0T1FTaG84ekh4RzN1WlB3cDFtM3k1MkZza3R3?=
 =?utf-8?B?RytIQUpSQ01tYXdId2dEY09Zenk1S3Q3MUQ0RGtNZEhZK0RINUdaaHhBbFZO?=
 =?utf-8?B?eW84TzF1dU5TQVp5Tzlodi9JaE1URER2S2dyWjlTVDdjUVpkVDJ3Z0NNeERt?=
 =?utf-8?B?Mi9PNFhCN3NnaHZhaFRXemdUeW02SjdGS2VBc0NYcVJBM1N3L0Fpak5aeU1Q?=
 =?utf-8?B?cW9BU2E5SWZaZ0Jzb1d5NWN1N2xLZStmR1c2RmRpTklMWTlQWFlWV1crSEhH?=
 =?utf-8?Q?D51r4z4zZeYX6G9QjzEM4v/jCrNvW3Jh7daZLyL98Yc7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfa8d87-590b-431f-bad8-08dd5fdec361
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:20:52.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzBKyJTbKHdXlw8B1G8AQTjKvg2FRl1lyfFZnd2a23rACH0WbEq7WYosWH03WWceUFzAknwr+An0w5If4plFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932


On 07/03/2025 17:07, Russell King (Oracle) wrote:
> On Fri, Mar 07, 2025 at 04:11:19PM +0000, Jon Hunter wrote:
>> Hi Russell,
>>
>> On 06/03/2025 15:23, Russell King (Oracle) wrote:
>>> Hi,
>>>
>>> This is a second approach to solving the STMMAC reset issues caused by
>>> the lack of receive clock from the PHY where the media is in low power
>>> mode with a PHY that supports receive clock-stop.
>>>
>>> The first approach centred around only addressing the issue in the
>>> resume path, but it seems to also happen when the platform glue module
>>> is removed and re-inserted (Jon - can you check whether that's also
>>> the case for you please?)
>>>
>>> As this is more targetted, I've dropped the patches from this series
>>> which move the call to phylink_resume(), so the link may still come
>>> up too early on resume - but that's something I also intend to fix.
>>>
>>> This is experimental - so I value test reports for this change.
>>
>>
>> The subject indicates 3 patches, but I only see 2 patches? Can you confirm
>> if there are 2 or 3?
> 
> Yes, 2 patches is correct.
> 
>> So far I have only tested to resume case with the 2 patches to make that
>> that is working but on Tegra186, which has been the most problematic, it is
>> not working reliably on top of next-20250305.
> 
> To confirm, you're seeing stmmac_reset() sporadically timing out on
> resume even with these patches appled? That's rather disappointing.

So I am no longer seeing the reset fail, from what I can see, but now
NFS is not responding after resume ...

[   49.825094] Enabling non-boot CPUs ...
[   49.829760] Detected PIPT I-cache on CPU1
[   49.832694] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
[   49.844120] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
[   49.856231] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
[   49.868081] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
[   49.875389] CPU1 is up
[   49.877187] Detected PIPT I-cache on CPU2
[   49.880824] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
[   49.892266] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
[   49.904467] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
[   49.916257] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
[   49.923610] CPU2 is up
[   49.925194] Detected PIPT I-cache on CPU3
[   49.929010] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
[   49.935866] CPU3 is up
[   49.937983] Detected PIPT I-cache on CPU4
[   49.941824] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
[   49.948593] CPU4 is up
[   49.950810] Detected PIPT I-cache on CPU5
[   49.954651] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
[   49.961431] CPU5 is up
[   50.069784] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[   50.077634] dwmac4: Master AXI performs any burst length
[   50.080718] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
[   50.088172] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   50.096851] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   50.110897] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
[   50.113922] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   50.147552] OOM killer enabled.
[   50.148441] Restarting tasks ... done.
[   50.152552] VDDIO_SDMMC3_AP: voltage operation not allowed
[   50.154761] random: crng reseeded on system resumption
[   50.162912] PM: suspend exit
[   50.212215] VDDIO_SDMMC3_AP: voltage operation not allowed
[   50.271578] VDDIO_SDMMC3_AP: voltage operation not allowed
[   50.338597] VDDIO_SDMMC3_AP: voltage operation not allowed
[  234.474848] nfs: server 10.26.51.252 not responding, still trying
[  234.538769] nfs: server 10.26.51.252 not responding, still trying
[  237.546922] nfs: server 10.26.51.252 not responding, still trying
[  254.762753] nfs: server 10.26.51.252 not responding, timed out
[  254.762771] nfs: server 10.26.51.252 not responding, timed out
[  254.766376] nfs: server 10.26.51.252 not responding, timed out
[  254.766392] nfs: server 10.26.51.252 not responding, timed out
[  254.783778] nfs: server 10.26.51.252 not responding, timed out
[  254.789582] nfs: server 10.26.51.252 not responding, timed out
[  254.795421] nfs: server 10.26.51.252 not responding, timed out
[  254.801193] nfs: server 10.26.51.252 not responding, timed out

> Do either of the two attached diffs make any difference?

I will try these next.

Thanks
Jon

-- 
nvpublic


