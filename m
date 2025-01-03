Return-Path: <netdev+bounces-154916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2144A004E7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2941883D83
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C260E1C4A34;
	Fri,  3 Jan 2025 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V2dkgzYg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E570199938;
	Fri,  3 Jan 2025 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889098; cv=fail; b=G/EJkXsG8ac/MWzynWLBSmVcp7P5oWCVufpjNsuecNIKIFm23JqiSvTgx/V7PE/PjXp2NuZopn5LbAhTM/f9IV0MeGET+raEc9uqtNlgbJoS3jtlNlZrRpXX0r/wsVCX66HHSmgP4AZBYiJVfEKwlNEbN6/A6gg30ILfhQyCJFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889098; c=relaxed/simple;
	bh=lP/bdG2m8iAZYDi9WLGweaC+D450smz3Ydc9zVxsHS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NWoqOKzcL8lixuycM39+1oQy9251SE3B9mzQGBLVq+Vn1rusPJuBeJmNftaoJOtNkU5DizWvLQDcvVUg1wyZ0iykeFkyagIfzt4689gjBmcfIYvmZrGT96vrNw5YfzoodJqtRnwSvkpBJ0HaeKS+yBD/HyATaED5OLUzXEcBD0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V2dkgzYg; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8gwUWOLBJZs2733kZeorz+rZ3BNGhIg+/RWzyHRv/m2c+2mo+28zYo9+t4o+yQKSF4zvFdYAjgIDswyg+Ic4PEC2ZP8A9sUXl5jzbl2aLjlDOJdWUJCrx+rGbdWHiVrGCp7quHndQlKlVn8pzgJQkZbE1vuPy3b8C1WUvqAJBAdBKGO9dIyuV7iuCC1oRIKulXsAFAGchppxJ/gvzhQf+qwkMZbXrjjHsdMbmsM3kzwJElzsh+2huNiyQubzQqqyOKOnePpUVe036eGEm9zTLumO64xTZeb4qkUUN4epGXAvN82+sE39yfnsVt6tUk4tliDR7dTpweI3ztpizqWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP/bdG2m8iAZYDi9WLGweaC+D450smz3Ydc9zVxsHS0=;
 b=NeAX/ZzyBo6HVaUcZXZk5gFJPiewWHueE1UTsZWssvRhW8HYtRvYUJgC/X+iqwX7Te/z15O+TH7qbxh57SZmpcHz4UI8kIWgHXRe+FweDhQgiArRzBqNBqe+SjoVXBS7SWvACB9JmQ4bMigWkYIrfdkW1aeimVCaIux7/qypMVdrO6Mynb26bjKvEYQJ+hvvTD6tVtTyygqZk6MrrePlzdhYBSH1rme2hNJaBAVsD/ikCCtBdREUXHG5LssQt75FvVen+seTOvDQTeMslOfFuVVSxjPB/CBuhUgzXGI0tsGcRpXbJQieM4CUxMLgNVU/NRTis5pQKAjdmwnB4Zfqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP/bdG2m8iAZYDi9WLGweaC+D450smz3Ydc9zVxsHS0=;
 b=V2dkgzYgKTt7p42JTLekjtF29TKLmtIssUe3wenEfJBUVS+ZwNLsvyV3R4WPwx7UAReRgGrO6MNiJlk+k9eRY2aUnhbiJXWDGbG2txJyFHmXwzQfLDrxuRXwpWoAczsqsLbGnGW8aavIpmR62YoKkpwvrtMn51eIr1ab4G4CE00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:24:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:24:51 +0000
Message-ID: <670ecc5e-afe8-637a-8c98-3559e4a9e42c@amd.com>
Date: Fri, 3 Jan 2025 07:24:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
 <20250102150136.00003ff0@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102150136.00003ff0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0250.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b1635d-ebbe-4064-b62f-08dd2bc7b5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1U0UWZOV0hYUllhcVVXM3pnMHhPRmxWQlVSZWxvWkxxMXBtZS84TDdoMjEy?=
 =?utf-8?B?WUhEWjVGRXlOd1JIYnN6M2FHZTFLU2ZNTGtrZjNLclBjZDN1MkJOaEUxVzZO?=
 =?utf-8?B?d2xSUVVLZHQ2UGFtNlJ4azE4ZzdnODgrakhtVk40cU9hUFF5RHJvcVowU0Iy?=
 =?utf-8?B?RnR3L2NBdVpmTUlEZ1orRWozY3hPWTVHYTFWTGZ2WEV4M0VpdWlScU5vTU81?=
 =?utf-8?B?M3lnSm50OGxnczBnZXNVTFlWVlZpYTRUNW0zS3RYNVdvZUxEaUFHOHRUemRB?=
 =?utf-8?B?ZTQ2ay9kWTlyOHp6VHVYUnBvK0dVUnVSTWwwejdJRDNSTG8xSlE2RUdETHVm?=
 =?utf-8?B?dHAraVVpSFBSSE5teDdGQjM0V1lFcDIvYkZnU1Y5OUdnTStwRlZ3Z21aa1o3?=
 =?utf-8?B?Nm5OclFrSjRRc1p4N2k3c05tcTVxcFJ1TEZyUVVqZXJuTlU1U3ZNM0Y2OTBt?=
 =?utf-8?B?ejdPZjRreFBQYzU1S3NPNlJ1V0liVlNucUZ2eTJzVm95MzRsbnJ0N25Meklk?=
 =?utf-8?B?SlpjWWhUeGx1SThSbFgvS1d3YVp0dFBmQXlIS3Y3Nmtsbzg1c3dYQ3NjOXJx?=
 =?utf-8?B?RVFkNmxhcXpLdTd4dWh3b1BkcTRvckoxV2xaaCtzR0p1RDgzdm1xWm1EU1RE?=
 =?utf-8?B?S3I3M2FTalpYeTd6RnlsVHpmWDNPNWRuZVNsdEhlK1FnWVpESWprU2k5RUdu?=
 =?utf-8?B?WW56a0NXMzJxbHAyNWxPU0MwdmVnbnR3NldkbkFIWFdEcWlSOW04ekpyMEU2?=
 =?utf-8?B?dnRpVDBxZmgrQlhaQyt5ak5MWjIvbmltbFpJY1g4ZnBRVHlhQlUrdzVka3hC?=
 =?utf-8?B?YjlRcHNwYTdPQ1JIZHFyTDBCZnliY1BQQ3N2UnRpMkVQaWlmRkt2UTRucFFD?=
 =?utf-8?B?ckFPM2JxckM5RDRPREttUGdRQms0RXBMYSt2M3VhbjVSZWR4OHo2aERPYzd5?=
 =?utf-8?B?T3MvZHpSWTBOdFVKeHlVWDYzcnBYUnl3bE5zMnFJVXUrT3RUV3hqZEZqOTRy?=
 =?utf-8?B?YXYvd3BpZEJNS2VhMlBZMGZzaUJnZkFKbXlOQnFSL1VVWU00TUZsV281OUFV?=
 =?utf-8?B?ZDlsNU0xOFNNeWRMUkpJOUxhQ29VSTFmMWo1R3V5ZE1BanBQL2xXcytBalEw?=
 =?utf-8?B?WjFkYzhQZXphdTk5a0hER0I0d2lIbFBpV2hMKytXdkc1blRmVnNRV2JyamQ0?=
 =?utf-8?B?ZW1GQlNkdVh1NXNuZ3VKUzJUKytzMTNndVZsdWZFZ2tlanQ1MUYzZDN3djZn?=
 =?utf-8?B?QnlXNk1uWkZ0Yk9Nc0hkZ3psZnE3UmRmMkFkeHNiWXdBQnp6Uzk3ZkhxNzlQ?=
 =?utf-8?B?clo4L09ud1B0OVFRUWNhK254LzJscGJ0allhOU9yQzZrVlVPa001dHhwemFE?=
 =?utf-8?B?TG9kR1VJcE84dmNObHVGR3FMc1pUbTIvZ2tTRlFhMm83aVVBa3N2SXEweFN4?=
 =?utf-8?B?ZmVMblBzWWFFMXVvOEtpcHZUVHZoWlpQbzFmRkUxeWtEdEtRdnFpSGJRYVRp?=
 =?utf-8?B?VnlhN3QyVXA1ZEpQa093bm9hUG5qU2VTS2dlY3RvczJTcFZ1RlZTUmxmWWpl?=
 =?utf-8?B?YjMrMVY4clQrM3grbCtzVjlRZVdwY0dIUjZydzJ4YUE0Y3d2a2JjZGt3YVBz?=
 =?utf-8?B?MHJEcnhYVmtBNDVCLzlMTnlSV2p5dVJhOEhlWG9NUWlBdFEyTFM0SlVFbXZ4?=
 =?utf-8?B?dndqYm40SE9lN3ZJZUVQRXZsNVlxN2FGaWxzTytvZkRkK0w0dktNYllsUDRi?=
 =?utf-8?B?dVZXbXlQU2JxUGk5K1JuT1hnTWlyVzlsZVpFTUdTTEtoeXQyYTJ4SHF5U1BD?=
 =?utf-8?B?UkQ5N1BLcjZIRTYralB2NVl4cDJJMzNzQ1VWSEhUdUpuS1hHa3FXWEpUSzRk?=
 =?utf-8?Q?v+iMmVMCQoaSG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1laZjNqcTlzM3pQdDI2VHJJZnVNbGdZMEtaU0F1MzNCZlRrZDBUUy9zTDIy?=
 =?utf-8?B?TjNqQkpkZjRhYmkvdVpqTkx4ZUgvcTVBbFFWMzhpc0p3UlY4dXRYM1JDWm43?=
 =?utf-8?B?M0xiUmFBS1hKTHRjMmVZV2p0eUFsMER3cW9jb1FzN2UrZ1k3eS9DdUJnSkFl?=
 =?utf-8?B?ZTdMdVNZbTgwTzZLK1B3dExUSDNUZ29tRDlFMi9yY2NVdjRML3hYOXRjYlVY?=
 =?utf-8?B?Rll6cG54ZnNSV09VMzFVYlV3eGhFQ1puMU1pTmFrTGxXRjNIbmR3M2NJcDNn?=
 =?utf-8?B?ZTlEUFVTUzQxdXFucStJM2hqUC82dlp3cWtCVW9jN21RVGlKTjdsYnBhRkNp?=
 =?utf-8?B?UVdnNzVpUnR6N2p5KytWOTdSMk8xZ0piR0twaWt5ejR4dDlVeDRVMVgyTklI?=
 =?utf-8?B?aVB0WUVhM0pzN0RYN2xKMWRHNlRLVW0yQ21SOGJPY24zc1dDTThGVFBlaTlx?=
 =?utf-8?B?aFJ5K1llQkZkWkhwWGU1Z1FOYkR6NVFoMFBXZXV6RXd3b2ZGSkoydGxKNlls?=
 =?utf-8?B?T29oWXR4SjVRYllGdUtvVTZXbVR0UDI3ZDAvMm5wUEpkQjF1ZEtJZmUwU0tm?=
 =?utf-8?B?UUMzamZrclB6V1Jpanc0dUJkQmZGbGFDM0VIWU5qS1NUUmw0SVJPd3A3ZXl3?=
 =?utf-8?B?bGtXYS91Q3RPTFFKZVptcHNBdGYzRjk4dlZyVUxyOW4wVFlNYWtGZjdZVURz?=
 =?utf-8?B?NEkxdTM1ZkVvME9VOURqY1R1UnB3c0QySG15WHo2Ly9takhKeU54Mks3UjU5?=
 =?utf-8?B?dFQwbThwYVJqVEVTcjc4WVc1NXQ0USswUmIreGwxZW5uOHNLZEtudjJDU0oz?=
 =?utf-8?B?MmJhT1JvRTZSSGc2c3AzVldqem4yWWorNGZEZWpvazNvcmNOMmdvdGhBdXc3?=
 =?utf-8?B?YmNzcHozbkZJNW0vZHo1VHNQbllIRG9hVGo2ZmF6aWhTMGU5emVDNEpWSG80?=
 =?utf-8?B?bVdEQXFjV0VraHRGZ01VZG9tcWVNNUtLOGExakl0QWR6dTRsbVVOR25XQzRw?=
 =?utf-8?B?YXgxbzNIdVBCRVJoVG51NWl3RGVnekxHdXRuR01oNzJHVjVUZmU3ZmNtUlpp?=
 =?utf-8?B?YzFDRnFiVXNPMFlPN05WNDk0MXp2eGdLTU9yTStOS0VBM3cyblNCbDM0dWlz?=
 =?utf-8?B?SUxRa01aL3QrMUJ4TUFoTTkxdDBkaEQ2dkg0cWpJNUNWMWh3UG5XUXAvdEdp?=
 =?utf-8?B?Rnk2SHZMZ28xbzUwMTZFR2FldVJIcWJoS0ZpYmkxTmFXdCtZK285OXAxcktn?=
 =?utf-8?B?R3lody9vYU9XSjRaMFpZVVZWaUZoVzljMVFwKzBmSmI0aC9QTGFGKzNxODdm?=
 =?utf-8?B?YzVoSFEzYmN4S0tyalFuSFFwVXJnUnlGQ3pOR0Mvc1Fob2NrQ0hpQVRsUVRL?=
 =?utf-8?B?UktGWU0xQ1RJOWpaaWZMWDBHMThGY2tteGJEVFhXVy9zWXcxR1FrMDA3T01D?=
 =?utf-8?B?SURYTzJya1hkV2dNSmRKcE50VnJ6U20vSHQwQ2k5Qmp5SFNTQ25OQmk4Z3V3?=
 =?utf-8?B?ZzNSblBoaGlmOWhwWjd3Vmt6bjZjMm1YUTJYY2VuLzVZU1FkcnFpNWZIRXYy?=
 =?utf-8?B?cUlUaHJBWkd4RmFabXBBNmwwZG9wVnE2Vmxzb0ltOGhBamltQ1VJU3VJNi91?=
 =?utf-8?B?djBCYlNwQW1hVlRpUU9lUDhjSHNndlJEajcwOUUxTnpCT09mV0JKWlZCaUlT?=
 =?utf-8?B?dWdmdUsySkFQUnQwd3pNcFd1c29qMld5cTFxQ0xWOEd5eGZVM2VTNFowbjlv?=
 =?utf-8?B?MDlreUd1OWxwUy9OdS9mbkdmK1JWY1hua3ovU1p6WUpXTVFRSXFNdXRid2x4?=
 =?utf-8?B?UDdaZEZFMDRPY1NOMDlpU0Q3RU1MUUVBNjlrRlMvbVJ5V3BpZVBYSUVaUG52?=
 =?utf-8?B?am1reUlBa0FNdmhRQnhSWExQak1IdHg3QW1pUmhhSTVOa1Urd3pzUHd0K041?=
 =?utf-8?B?R3ZTTG02bFNiU0RsVyszV1hWSi9ucW41OWIwUkhxVzFGTnhGdzZ0aU9rL1FL?=
 =?utf-8?B?eHA2NzhzYlo4c0QrQU5oS3FETEhOdk45aW9hQVhmYnNXVnhqZElqWStubWNT?=
 =?utf-8?B?akx0MERKR1lmQlp1L0Zadmw3ZVNOc2wwZUNLOHgrRDc4RStReWxHT3RGcVd1?=
 =?utf-8?Q?WiRbNwOzKbr+ERfXUMSQ6R8lq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b1635d-ebbe-4064-b62f-08dd2bc7b5fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:24:51.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRhScqLElE8NyNtMANRIxJ+EcCVJCspWfku+9p1Z9VCqRl2RHUF5in9xgLAIhMvTHjfWxKC5rUZJL//dAAO//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333


On 1/2/25 15:01, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:31 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of cxl_memdev_state.
> "Avoid debugfs files that rely on existence of cxl_memdev_state."
>
> Currently it means you keep the files but break their reliance
> on that state. So subtly different from what is implemented.


It makes sense.

I'll fix it in v10.

Thanks!


>> Make devm_cxl_add_memdev accesible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>

