Return-Path: <netdev+bounces-102338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B82902888
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C21F22157
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CF3611B;
	Mon, 10 Jun 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M6rF0Rd2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90B15A8
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043673; cv=fail; b=K66f5AOul7WvClfgkHptsN6MYUhZpiw0XlnvEyuXtplxDuFJrD91ugIj7HAekB8SrHCx4ix3skAaE/PXhHv/awZr6cIXeEvY1hpPdnis+HuoTH+8lB5pnIRp0MPBK0UUrCVBYWT7TKN90WZuElD/rQTFFVUYVybNbbTN5isBRM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043673; c=relaxed/simple;
	bh=Yk87b8xeKOmslNM8xnXiWLBl4Jr9gOIwzu2F3C1UceM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGoy8R2ZuJIiQiFk/yME2IfMDhqVp0uc6SaU+Xd+yZlC8AXaoRBhWxioO5DQ5rkKFhpwmD9eCC5VrOn5sCnvPgHhLdAGFz+f1180oEs98JmzTmmD5tB6M2siDGVThzXQbU9LmfJv8OobJ/OA+xAIbKdNWAfVKRU/UKSPwH5IwmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M6rF0Rd2; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGjtzOy9ivBJ5VUPkyTA5ZVhdqpDfSLOBKfw2qlwe9+NuZ8wwQlH+6QktNORqzXe5d9a+vAfsO6u1D3AxoDJ8MLvt6fhlBTNLneZ54p4/TRhVf5/F5mIiVN5NUzE3NF2pdkVX6bDcATj/lpBMO2HQWd1w9LC9XsCPMtlFSLE3GBOseTVoi5j0AVKW4yRIgtbIMCasg4zxAXEmKSF8e0Dn7/S0FOMZy6f8Al/NAaHRL4nbBV2fXTESeIBNKsjiv29vERCddtalHvciIb2QZaO2wUvfiLODv2Bf/HJYNI/1vqVrsuuKrynn9PEraXF+aHmONnXVmAf7kruB7FmzwQqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KybkmONtluoW8t1O+AQKETBQYQbBJRaWPRxea1xce5U=;
 b=F6v/LydYZnoo8zKF8AjCOjb7TVPXHqrVQ5b2WIAm1nkHakg34Gqjfl6OPnim96klUAFrmLqaD7jq4shxc/J5kThq+qpFqM3vfGgJi09kuj7ezmVuWL5DvsW/lpE42za+PLjgc/30RT6hX+Q8En3Z4g6wSbCP+sPKhi2IfFkdLsLGi+zQ561Eoq3Y1rAZXJvz0H+H7NVaLGkbV5eRmx8jtJWdgfQJYp2X2WhpxBKwCXNrF4CbMEg2DrzkX9fFBu3zdoDYFQhsk+YlKV0YxpjR+FtbPJC3BqXDJ8GYt5qXWRf/XjFZeUNW0/VGs7+qI4FmjT9OB6ie5APC7p7caUZ7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KybkmONtluoW8t1O+AQKETBQYQbBJRaWPRxea1xce5U=;
 b=M6rF0Rd2JvRbm1IhF5vc1JJx0BCkSy40SEpOah/dzaWhc2Y++/4UOPeAGM5LebwrFh0fqUMfpKWLWRIoZQbg/aI3YHD0BYT3Png1B7GR1q08pI9luOb2JV9RKbw7+LNCRKVTgOPY+k/nahe6kChGC9m/UiVBkRWQTcEgvP53eR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:21:09 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 18:21:09 +0000
Message-ID: <d1b1d6fd-26be-46c5-b453-538ca5880e7b@amd.com>
Date: Mon, 10 Jun 2024 11:21:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix use after netif_napi_del()
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com, nitya.sunkad@amd.com
References: <20240610040706.1385890-1-ap420073@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240610040706.1385890-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: e6072c41-a502-4adb-487b-08dc897a199c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJjOUJDMGNqd1JSMEU4dTF1WHF4eHFPa3NYMFNvaXVJSTlQZTB2blpRSTZI?=
 =?utf-8?B?Ty9VY3lZQk5MYmZxbStIYk9zZHFBN1JjQXo2U0hrZlBsenJwY1NVUFAwc3U0?=
 =?utf-8?B?UWEzNkZzNWlkM3VjemhJYWRucTRkcExic1ZzMUNDNVVKNmx1R3paQVR5SzEx?=
 =?utf-8?B?WjlIcDVjUGF3MnIxcHJJTDBzbHJCTVlnbm5rWGdzK2VtejI5bjVtMjczWFJ5?=
 =?utf-8?B?TnB5MXE1UGlYSWJhWHRrNUloUHhoYU9HWlZvNnViNmZ0Q1YrYld1Q3ZjbG5F?=
 =?utf-8?B?Mm5OdlNEVGs4SmNQaXNjSEl6UEtlZ09DeWdNWXlYNUlGRGJYSzdXZGptVmc4?=
 =?utf-8?B?YzNQQkI1YUprZ1pVMXpCMDJ3ME5hNFNlZXZaL0ZuK2ErMkovalh5MlZ5OEky?=
 =?utf-8?B?L3VHdzI0TCt4TXhJRFJkWXFQMnB3Z1I4QWg2UlJKNGxvR1RpTFpRckVQMjdW?=
 =?utf-8?B?T2dBMVFoZmpaV0N6L0hhcFpDSlJBSmN6MGZRS1MzK2tOdjJzeFVvMWlnQlps?=
 =?utf-8?B?OHFQQ1lTc3NrbFpOQi8xbUNINlJSbUNuNFpDcmpPTDFXSjFpZXdQZmc5UmVF?=
 =?utf-8?B?QW9heHZtNnpCN0lyNmpiaGkyRTR2UHZiQmFhS2JRRHd5WjdYNkx2MU05SFB6?=
 =?utf-8?B?aFQ2RUZaZXZQMDA0ZllJWmgyeVErQWZWZWxqY0NTeWVpN2JjUUJ2U1hyNzdn?=
 =?utf-8?B?dlgrWTA2Q1ExVFVRM3RYbElHdVBsWk1Za0kyVE1FS0grSHJ3Nk1ydjgxQ0Y5?=
 =?utf-8?B?NjdWMUtsN09GMVNJUmxlSkVSempnLzhMRWlwNFFVWk43R0V2SWdGTUNvYzJo?=
 =?utf-8?B?WUxDcnNHdGwzZHJjQTdDV1FmNUphUThyUDBRVnQ4TzltSExWMEVUVzdnYlhJ?=
 =?utf-8?B?M1BmeVY2ZXkrMkZnNW9TT3FCdi9iSm5xT0dRZ1BIYXpDR250eGI2cU9DQkJK?=
 =?utf-8?B?MHFNMkxqZ3BEbk5ReU51aFpZUnJEd3VPellyUExSaElZTWRXYXl3d2pYZ0hW?=
 =?utf-8?B?aVd3dVJEQTJXNXdVWXFaKzZwK3FReWpEbGN6RFVVUTRwOG1hRUFOUXRXR0hW?=
 =?utf-8?B?cHVkaVUvcU1qNEVnd21JQ3Q5NEU1MXB2eHBnczdnMUhoS3k0dStTNHF0bHJL?=
 =?utf-8?B?cXdET1NwWkY5Z20wSjJmT25lN0xsSStoTC8rNmJZYkNhYUp0Wjd0MGVEeXZI?=
 =?utf-8?B?NWtOZ0ZEZTF1TmdqSEMzSDRnRGo1Y0VhZVdQT0lzWE5VOWNGbjlaT2d3bDRh?=
 =?utf-8?B?RWlQRTltTnlkY081Q1ZNMk9DcGU4WjBBTEtZbFRiQ2grY0RiV1F1YXNXQStv?=
 =?utf-8?B?N3VOaHQwUHkvaldtbjRtdk8zeEZoUHd1V255TjM1WDVXYTdOQ3ZhNWxnY0pJ?=
 =?utf-8?B?NFIwN1hyQTBVdnFuZTFYT080MklLbHAzbTMwc0lDSzV5UEYrWDVmdVlkdlp1?=
 =?utf-8?B?L1pmSTBzem9ZamxBNHBXaWE5R2RRUzBvdGdST1dyUXBuZWFYam14ZmtBUmMz?=
 =?utf-8?B?L0VJdGg0S29pOVRqTnFDMnA1UWxxbk9PMWhXOWJ4MWdCNWovaUhvUUc5TGor?=
 =?utf-8?B?ZG9nMVk0b2t3ditDeHFEUFhVRWhJL3ZwMVJtN1NzTTdITDQ0YmRFTlJ0WHZJ?=
 =?utf-8?B?Tk1WQkRUblBCSFE1cEIrbHFCRmpmZmxRUk9zRi9CcEY0UXVkQ3VtLzMzOXFW?=
 =?utf-8?B?ZnExN0dvNVFZME45cDRjby92WWxHUXZ6V2w4NC9lT3QzV2JWSlJyQmVsTGZF?=
 =?utf-8?Q?3yW6Zx8N/ib1Ni+cVWyH8bxPgU+Bbb34fEGro+1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtJMGV1dmxlVGUxMnFxVnBleDk0bGhNcVZUR3NsOGFQbk84MDdYVnZjS0JP?=
 =?utf-8?B?ZjNERk1jMGJSaUhrVElqRnVCVE5wWHRXbFdsSEw5S2o3RnprcDFuYlBGSk0v?=
 =?utf-8?B?VWRYNFN4UlBxMkljcUdUT3lQSDc1Vit1UXVvWENzRU5zdFp5Q0JEU1N3TjJI?=
 =?utf-8?B?Qzk4RStJa05oaXpRRlNEeWJnNG1CakhFRTRsSWxzR1RIeVVhOXY4WXF6UEYx?=
 =?utf-8?B?eFk1dmFWVFpBZGdqTWRFLzVNdXJJRlozaGtpZzluYkc2bUhVeG5LZCtBQ2pF?=
 =?utf-8?B?d01BN1Azd21Vc0h3bmZHZzlqMkxsNFBLd1hSUXc1dEdCcXJKUTBjVExoZmk2?=
 =?utf-8?B?QkowL1BOUzdOQWE4Qiszd2ZnMUp1MlZqUjBTU01KeUh4Zk14T0hIT0JxQjRy?=
 =?utf-8?B?MzVZeEh4czNEL2xQY0VNWGtCOVBiSENiSDhnekhsVWlJbHBydzlLY200VHdF?=
 =?utf-8?B?L1JwKzRCS1ZkTU9pTGVkUzlUdDk3bjhOWHFLWXNQRFgrZkppU3NUOUVVTTAv?=
 =?utf-8?B?YWJ0U0tRQ3ZaZ0gvVCtNL2dhY0hxWjRoS2VvL3lPVW1FTjVFNU5uMmhUTEVQ?=
 =?utf-8?B?U2FoM0JMQU5LYzBZaWM3cGlYa01TdW5yRHdsUkZxWkYvRVFZRDBmWmZvODFD?=
 =?utf-8?B?WDBUei93QXZYbDJHR3JLZGE3Z1Z5VlpRVkFkRE9RR1QzRnhHU1oxUVJFN3l2?=
 =?utf-8?B?dzNqMFY2aytEQUx0UkNUR0xHOG5DOFgyOFFTZE1FdmZ6QjZqaHkyY0F0MXVu?=
 =?utf-8?B?RjVOZVlkeUlDWGFSVWRoU2dJb2RmNUI2YWVWQ0R0bmN1cmgvT2Z6RDFHdDBq?=
 =?utf-8?B?Z01OamJ3VC8vZWlwMVdQZEt3NGR2K2xsSWhvb2hYSi9vOWszTkUrTk1jRzlG?=
 =?utf-8?B?UklLK21mYVBwTnA2c0JKTkg0YWd1Wno3bzJGckpFcFRqamcvdFdrcGpNVG5W?=
 =?utf-8?B?bFpxSkU2UUhSTkV0Snl5bkZPS1BEalpWS3Zic0lyMXpaM1FXLzM0Qnd1VXkv?=
 =?utf-8?B?RkZnVENKcENvWXFma1VzRmhEelJyT3VodkhUaXVhWXdLOGZ4K0Zmc1lVa3oy?=
 =?utf-8?B?cHF6RThDUGVUV0FiWm1iQXAzQ1A2Szl1b2NuMTlnUndtTmF3YUJrU3BYTklY?=
 =?utf-8?B?R0FmeTdXOXR0TFltMFBQc2xYb0d3RDVjcVZ2YURBRW5JMGRJS2hJcGpCVDZT?=
 =?utf-8?B?bUtoMmlOOUlMZEZrQVQxa2JHTFJ2Q2QxeUdIdjFOMmZCbUl5VlFRbUdwS3E2?=
 =?utf-8?B?eTlITGFWbWp6a3lQNnJhaGJJOXd6dVd6Y2VtNjlEOCtCdnVXdVVDZHdVTFh5?=
 =?utf-8?B?WUdPN0Jaa1NEYUZEaG54YjVHSDBLcUFFNjhwOWtQV2pnVU5KemNCRXNHeHU2?=
 =?utf-8?B?SmJTTjBVN3J5T25ZVkozaktSL2RucWJROGdWeEgyd1ZvZHFWUnlPbEk0T25Q?=
 =?utf-8?B?MmlrdTVBZG5XbjVvZ0FyM3J6S0dIOXdQRkl3Z090dTNLSzF3OWJoSlEyNDk4?=
 =?utf-8?B?YVBjamVWSXpiWHM4NVhGVlU0VWdsSThOWWVJbG8zRitkaTFKdWhoVFRCNzNB?=
 =?utf-8?B?RzgxNG5YdmhyMDVIK2lwWDY4bnVrTmRhQ29KS0MwY0dNMEJKdUpqTlBnZlBK?=
 =?utf-8?B?Y0FkOEVZdmEwZXMzWE93TUxpcitYNWZBbVYvdk9ySzdNb3lSSHgzVlI1WjZq?=
 =?utf-8?B?TXc4bzJRZDVCNHpveGFGQnFNWHpVcGdvNWxET1pFN3RVQkxrVU5UUGdKaGR2?=
 =?utf-8?B?VGhWTndlWGN5ektmY21aRWpnbzRhaW14YUoxUFdsd2ZKVG1CaWZFMXV4OWpT?=
 =?utf-8?B?MzZnbEtSSDZROUtHYVhrY3NyV0tiZzdWQW05VGFzY0QwL0xtWEpwVSs2T0FC?=
 =?utf-8?B?aTZ1SDhzdUpuK2c1Z24vS0NGSmNRWEkrWkVBaTRrcG9GOHFGVG11blNHUG5F?=
 =?utf-8?B?aWlZR1RPbmRPdDBYZDhkK1N5eWZHRDRkeTJUYUlGRHlCWWNSQWU4WjBIZ2xR?=
 =?utf-8?B?QWRETUp1YlFrMmFDUUFQS0YrNUw1Zm4xaFRIanphWFEwSUJ5OVdkWllFdjJo?=
 =?utf-8?B?SUJiT1l4QjFYOGUvYTM0SDV4MTZQMVNCeVp3THpMK1hxMW1BRmNTdld4ZnNt?=
 =?utf-8?Q?p6N6ztut1ucu+JKlddvkss2vv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6072c41-a502-4adb-487b-08dc897a199c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 18:21:09.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oxmlfHkMHD82ze2YGBgkZqxJ1QGRUhyEovfZvCn0GFBU1voCCSWXBtvx9S2uR77EoWt0N003O6RQHZuMFNZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

On 6/9/2024 9:07 PM, Taehee Yoo wrote:
> 
> When queues are started, netif_napi_add() and napi_enable() are called.
> If there are 4 queues and only 3 queues are used for the current
> configuration, only 3 queues' napi should be registered and enabled.
> The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
> enabling only the using queue' napi. Unused queues' napi will not be
> registered by netif_napi_add(), so the .poll pointer indicates NULL.
> But it couldn't distinguish whether the napi was unregistered or not
> because netif_napi_del() doesn't reset the .poll pointer to NULL.
> So, ionic_qcq_enable() calls napi_enable() for the queue, which was
> unregistered by netif_napi_del().
> 
> Reproducer:
>     ethtool -L <interface name> rx 1 tx 1 combined 0
>     ethtool -L <interface name> rx 0 tx 0 combined 1
>     ethtool -L <interface name> rx 0 tx 0 combined 4
> 
> Splat looks like:
> kernel BUG at net/core/dev.c:6666!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
> Workqueue: events ionic_lif_deferred_work [ionic]
> RIP: 0010:napi_enable+0x3b/0x40
> Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 00 00 00 74 03 80 ce 01 f0 4f
> RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
> RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
> FS:  0000000000000000(0000) GS:ffff975d5f780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? die+0x33/0x90
>   ? do_trap+0xd9/0x100
>   ? napi_enable+0x3b/0x40
>   ? do_error_trap+0x83/0xb0
>   ? napi_enable+0x3b/0x40
>   ? napi_enable+0x3b/0x40
>   ? exc_invalid_op+0x4e/0x70
>   ? napi_enable+0x3b/0x40
>   ? asm_exc_invalid_op+0x16/0x20
>   ? napi_enable+0x3b/0x40
>   ionic_qcq_enable+0xb7/0x180 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_start_queues+0xc4/0x290 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_link_status_check+0x11c/0x170 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   ionic_lif_deferred_work+0x129/0x280 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
>   process_one_work+0x145/0x360
>   worker_thread+0x2bb/0x3d0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xcc/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2d/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 24870da3f484..b66c907d88e6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -304,7 +304,7 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
>          if (ret)
>                  return ret;
> 
> -       if (qcq->napi.poll)
> +       if (test_bit(NAPI_STATE_LISTED, &qcq->napi.state))
>                  napi_enable(&qcq->napi);
> 
>          if (qcq->flags & IONIC_QCQ_F_INTR) {
> --
> 2.34.1
> 

I think a better solution would be to stay out of the napi internals 
altogether and rely on the IONIC_QCQ_F_INTR flag as in 
ionic_qcq_disable() and ionic_lif_qcq_deinit().

Thanks for catching this.  If I remember correctly, this is a vestige of 
an experimental feature that never went upstream, and eventually was 
dropped altogether anyway.

sln

