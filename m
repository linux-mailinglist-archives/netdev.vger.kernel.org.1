Return-Path: <netdev+bounces-100312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608A8D87FD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95991C220DC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96913776A;
	Mon,  3 Jun 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JSGomEIi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FA1369A0
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435939; cv=fail; b=PmU5Upj3x88Lrg2WW+NXuB3ycFio9CfooMqWjm9z+FYKzIPJKQLnvZHXoRTFCWhGOd0yPSRHJyiH6T/RBWd/1Nu24PPVeFOazRyb4u182XrCsFkFGYTiousQVdnw3eE+PiEjmNVosawcpN62ZrN8GpIrfjArT2iNx3CnsD91tQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435939; c=relaxed/simple;
	bh=2q8upj8FnabYdnbpSpGeb1SqHKKzlL6W1+Z5u4BRbck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uja7zBiBRocRWwnYmkYW+4U9nw1rDP+Y2usoDZ/JIs/KtRRCZxN6QYk3ldq2DxRhvJCgAMI+KCp5BFWB39wpR3S5lvUF25fKJR1TvTohLQ4bib3DbeeHvjdh3ZOb4Tvs2Kftgf039zIBiERVePZbpyp9GvOcUVBGvPkUn904SLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JSGomEIi; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv/vivRBabr/dsPGiyG1dkTuUyiGLXwpWVGoYXICRXMGGO8sgaDv6jRxQkJpZxuu9NI6vyTMjeJwbn8Pbaq6gLnqb/No919Kdve16xr64rtr/WEOj2jqC4udqpZ8MG6uqVob6u6279p6LwJXYFgE/rP96FgzQzXbcun5h4b4RMAxG7AFar/cllq+8XWOcFD0uqmzyGpMdS+ZuWtp0TT2MjW6mZdI2k9pOMxChd/DJnQskH0FEq6LdynQGqEKsIdKc4jzinUaVMce4k3o/SWpg8XdaVNsX6STcr+0pZexqD9G9QHLb85OCd8ahvK0xshPmmHkKAoZ591v02Cv0PjbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqmx5c5s1fmTdvX7rNSy36Ya9+U8pWonIXoeX7jEH+A=;
 b=FS8ayamAt4f+CYekQwgsnGWkL1LrwtoprXZsO3VjN3tUvTI8mOpK30aRHMrZaeDRCgdJ10U2pl82fXDblDBttujaAYMujAaMhG8/cYXcpo9SQeFy6KDtKkH/kPajxQzqD42816h8qRr3Nxu4aVLX6VaGimKQIQxDbJ4pAij0mrngIDW0tPhWGsfUUO7HS09yw8C7PXAPtBGWDBFxJBKqJXXN2n7XBO1UB//0k0WAWuxzm7mScth7rSRhZENJU3zWMd8oL8klgdtlotjEXCLMyx1puMHNQ+YdZaPAQjA32nfS0SnIoVwkOVJcq8dZ1Iw55BsVuovFMz3L1wG8su3ccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqmx5c5s1fmTdvX7rNSy36Ya9+U8pWonIXoeX7jEH+A=;
 b=JSGomEIiK/RZFc+pom8ktGaozqC14xKtX29ZDhL7wiJaHFavfWbyJZj++0jf0hmU4oyA8ArtwM5uLUFdQxoAGsWPrwnVKCsSJLfRibGLeZaui8qmCsNQzm/uT1s8+yTmWyHwb6Y0N9ugylorLgu4gUDY3NTvvrbIC7yfh5PivuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 17:32:13 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 17:32:13 +0000
Message-ID: <91b676fb-b067-4fe7-9cbe-7352625f1cfa@amd.com>
Date: Mon, 3 Jun 2024 10:32:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: fix kernel panic in XDP_TX action
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, brett.creeley@amd.com,
 drivers@pensando.io, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com
References: <20240603045755.501895-1-ap420073@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240603045755.501895-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5185fa6e-3d80-42d2-9150-08dc83f31b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlZSRTZKNENVT0NTTXB1U0ZkQm1oZEpyRWcrSERKZ2xWQWpZaWRzMEV0M2xa?=
 =?utf-8?B?YVRqVU16NmdLOFhJUDhrOEdxRi90NDFRM1NocDVtQlZFbTRldGM5Q0VUL1Rm?=
 =?utf-8?B?TkZ1THBCMFR3b2JQTGw4NCtON2IwOEhaUGZFaVlmUG5YNm5UOEFTTTVtYzJL?=
 =?utf-8?B?TVF1M0tETSswWDBXM0FmUVF6ZGlldXpOc2h5RzNadXRqVzhxVWZ6UGxuMWRX?=
 =?utf-8?B?Vkg0amI3THFZaCtDeEt1VHV1UTJZUFg1RkJGV3BiYWxJS1preERYbjZ5Ulcv?=
 =?utf-8?B?UEJMUTlnbnhyeU1OYjFvTXBDL2lzbzFQaEJYVmx1TEZUK3o3ZFF5eGtXd1Ux?=
 =?utf-8?B?b2Z6MVgzVGJoaHR4YTd0eUgvY3Q5OTU4SmNrTUdXaU5raVllcVNucEp2eEk5?=
 =?utf-8?B?VHMvMHdQUGpmdnd1VnNGREpZTGNYTGhFMVB3eFE3ZDlFc2JHVUs2SnhTT3Jk?=
 =?utf-8?B?OXhHYjd3dGhmcTJIdlNrNmxialRmblZQQjR2cEdMU0Q5UkxXYTZ1QkVRa1BH?=
 =?utf-8?B?YlQ3OVR3YWZlMzMwazhYdmQ5NVJxVlVLWU13TFlUcTdIV3FwTkJ2UElCQ0tF?=
 =?utf-8?B?RE1FUm41alEzTHRsdjRRMmt5RC80eW1BVWRydVFtTmF2NGE3SHRHZm9XZ2JB?=
 =?utf-8?B?N1VmVUpreDVsOTl3TXNvSkpmNVAzMXR5QzVEb0JzUTJCcHQ4RDE3VmJlc1E0?=
 =?utf-8?B?dHVqc0Y3MVBxRGR5YmluRHhKcnlST2hDNHBwL25IdStydk00SkdKYzRENUFu?=
 =?utf-8?B?VU9vZWpUV2dYUk0yYTBhd1dHNWNjRE9KWm5XWUcwQ2NWSVd2a1JrRzJnT0Iy?=
 =?utf-8?B?MlZrUUUrTlFJclVhVVVjOHhKejdhOUwyVlNNVWVqU0xtUTM4c3dNYlVxWmNK?=
 =?utf-8?B?WnQ0YlhwcjFQazluMGsrYUloZE1DQ3JJWmFvVTZmZTl4dGx1T24vZ0E2cjZq?=
 =?utf-8?B?U2dhZld6NVkyMDM3ZGtRRld0ckFLRUVpbUhMMGVmWmtGV0hTRGthbEZQNm1w?=
 =?utf-8?B?NzdqQisxeDJYcEN5MjcrS1NQVDM5bDdZdVdtY2h5dnJsRzFaNFBQcGFKMjQv?=
 =?utf-8?B?Y2wxUXFLVjEwbGpSblNvS3lwQUZoQ29oYXJZUkNnTXhkT01BNmQwRWlWS29Z?=
 =?utf-8?B?S044NTh1VTA2dG1PVGd0anBSdWNjdXAwOXhIVW11MXJHWXVMUWxLN2p1V2Zm?=
 =?utf-8?B?b2VjY2k0d2lQMTN5VmhtbHNabk5MdGdtdXg5d0FTYlJPczRDY3p5MlQ4b2cw?=
 =?utf-8?B?Rk8reElqNFJMcVZUN2pZU0lVMFNwMXFLc3k0T09HVjJ0MVU0NXpDcUZqWUdC?=
 =?utf-8?B?YlNXSG1JaWJraW9wbGpPNDhQbzRuVjVoNGdPMHl1dExJSzM2VTVqNkFDb2Ur?=
 =?utf-8?B?TExnUm5Mbk81SEJmU2FicDlCWDczV002SlZKNnpmUlcrNEtXbHl3VERabE5t?=
 =?utf-8?B?V2VydmhRTGhFaUFVWnJWUDQ0YW55bVk3MDd6YStiZDhPZS9mODdXREd1THJn?=
 =?utf-8?B?VGw3MStXSzJGL2tOQWN5MStTSENLVTAxL0JHcGtNOXF0OVlDNUhPY2ptaWVD?=
 =?utf-8?B?Z0RVZHA0MUtKdC9pSjRoMEliNjNWeFNuanNWSXJEbCtucHVoenluR1poMWcx?=
 =?utf-8?B?MFFoM0dCR1RSTWp4YXp3V09Pb1M3UndiWDh0Sm9OU1VEbEg3T3JDb3J2VUZp?=
 =?utf-8?B?djhnS1RuSGExbmpkQmhwRG1GM3A1UzlublZicHJLNjd5dzMrakRQUkVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0llZGxWbUV3cktENEFrUUR4M0ZiMjB3bmRUdTJjTUdNakxpOXBsSy8ycCtV?=
 =?utf-8?B?VkNHaFJnZG9iM1dnR0NBcVFKWlFmMXl2WVZIZ1ZLc3lYaTVmK05MSnpZSnVh?=
 =?utf-8?B?dEtJbWp0M0Y3NVRSQXcxUk50TFRkeFZnYXhXUHI1blF5eDA2WHNvNkJJaGVE?=
 =?utf-8?B?ZjhTL3lOTUU4K2VsZ3g4cXU0UXBjRzBMWHNHQ3VneEp6U0hUeDVNOGp0ZDJP?=
 =?utf-8?B?OGtPc0t6UUwyRkxyNCthbTBaSHJRNFY0RzZmQXZJbGJuWnFLelFQV0E5WVVn?=
 =?utf-8?B?RGtOTGczZ3VjRUJQSmh3YkhUcm4yZ0pGUnlFdldDN2hhaUp5QjBpaW5tR1FT?=
 =?utf-8?B?ODJVT0VJMXZ2M2JkZDBhMVRpWG02ZVdmZ0lkNEdjb1k5M2JlaTdCMVpQSlJ2?=
 =?utf-8?B?bm9KR0pLQjhYKzF3b1VXZFlDQjJWYm1FZXhSZ2N2a2JCc3E1UUVBbGxMS2ky?=
 =?utf-8?B?SnduS3FtUEZ1VzRXUng4WnBxZlBJdWNhdy9Pa2RWclFBWlVUOUZWTStCOTk5?=
 =?utf-8?B?ZmdoU2ZXUnNYaWpEMzJLaWlzOWluUTlhY256a3VFcTVFRXpoR1RGN2RKZDFY?=
 =?utf-8?B?b2xCNy9oOGJBSUZKa2pOQlhHaGpwazhFWEdNcjEvWjFOajY1Y2FEaUd6Zlpq?=
 =?utf-8?B?VDVrU0FLV3gxTEduQko4ZE02VEZtdktGVU8yRjRYb0lWbVAzaUw5NkNDZERZ?=
 =?utf-8?B?VlI3YVdMaGRyVGtGM3RHU093M005ZmNheVNxQlhwcEhJUncyVjNIUzNJa21q?=
 =?utf-8?B?aVdldlZYMEFBUERpL1JwektaWThkSFUzMzF1WUk1aGU5b2Q0cithdDRGTlQ3?=
 =?utf-8?B?bU1mWHUyVXVlVWhFZFdTa2F4Ympad1huTFZYK2hiNTZ2ejVqeG5qSXNtamUw?=
 =?utf-8?B?ZVVzckhmWk9LazlwN3RtRmZoZFBrNGxGVkRuUWRMMDBOWkJaK25QNHFsTmUw?=
 =?utf-8?B?eGxkZ1hDUGcyeU1qUjA5b3R4b2Z4N0VJMk1Gbit2ZHNNN0M0aDB2ZjdyOWhU?=
 =?utf-8?B?M0F1Vkp5bnpBK3RabjBxZm5iMmpwMWNkY3pqdmhXRmhiL2ZPOE1YVEFVYldi?=
 =?utf-8?B?bW9GeTZjOW1GSHo0NmVMVXArZzRoaXJKc2o2RUFnR04xRWZEdmFWYXVjbjg2?=
 =?utf-8?B?azhVYkdSOEJLSDFPVld3ZVNRMDA3MFV2VFpCTnVpK2F3cCtvelh1VU12TjRt?=
 =?utf-8?B?eDRVR0pYazRZS0ZzcjNhSEcwWG10VFE4amFYVFVkeWkzbThqencvVEYxZ0wx?=
 =?utf-8?B?ZjZGeDZUMnRsc2E3eFdlOEFNK2gwdzFVMkpWK1Vvam5HQVl3TEFOUG16Q3ZL?=
 =?utf-8?B?QVhEWGFzT0FVREJSQktnZlZaNkp3S1RwcDJoSzRJa1BZN1Q3WUwyN3lWZS8y?=
 =?utf-8?B?VWM5NGV4QkRGWlFpTmpWaEZuVW03dzI4MVVXWXYwR3NPL0FkcEFWdGVRS3h3?=
 =?utf-8?B?RjY3RmRZdTM1K01zWUFZZi9td0M0OHh0QXh1NGJVZzVPcFZlUTZKM2VybDRY?=
 =?utf-8?B?Wm9YcDJmNmdrazVFS2tQQ1UwWUhjQmZ3enNMdUNCZFJjYlpHVjZLMWIySVdw?=
 =?utf-8?B?ZFhKMW5Jdng2M2xub015UDF0dXk1dTA1Q3ZjanFBZjZ5UVd5QUxOcnNSVjdU?=
 =?utf-8?B?dFFDUkIzNUNLTmtxQ0lGaDdoQlNPNUJJY24zdEtoSTdpU0o5QkRKSFhZOFVU?=
 =?utf-8?B?RWlkaUdRQjViMUxYc2Fmd3AvdEc5ZUxZb0N2SnUyZ3Y4T1NDakVXZGlhWkh1?=
 =?utf-8?B?amZubUV0YlF2Mm0zZzlnVE5aVCs3dTJkd0oxVXVnSFkxMjFXRFlMRWRicXpQ?=
 =?utf-8?B?NFd6YlF1U0gvRklUUjdHTWlTQTV5OUI0V3VHVnppeVFUV3UxakxydWNHeWQr?=
 =?utf-8?B?NjJEUGpVM1ZwZkhMQUhaVExGL2cyYTVEM1QvVytIc3BxQ2xvT1hWNkEwTVJS?=
 =?utf-8?B?dU9ITTU3ci94by9ITUZKd0hZTHU1WGtVa2VEQjZtWCtCYm9LWTMyUi9aS3Fo?=
 =?utf-8?B?N1VjdGhtRm9xUU9yU0pqbUVDZ1Q4U3VLaG9WU0E2VjY1ZkxrRzJsKzVYdWVK?=
 =?utf-8?B?S0hRRVd0bDl3OTZ1R1NkdFlheWNrY3NEalhMalh5QTlrOG9LQzdGbVJleFNy?=
 =?utf-8?Q?bx+65ppb7atw7zyhRdZ38Sv7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5185fa6e-3d80-42d2-9150-08dc83f31b27
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:32:13.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad8tn7BO3XkzHiZwfHw+HL8FKwE3YriU2SvTbtn0GTk8C1Ha+EvcRzOxhUuyeSuWyUGJjo4eJFRFB5aSI5Zx/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

On 6/2/2024 9:57 PM, Taehee Yoo wrote:
> 
> In the XDP_TX path, ionic driver sends a packet to the TX path with rx
> page and corresponding dma address.
> After tx is done, ionic_tx_clean() frees that page.
> But RX ring buffer isn't reset to NULL.
> So, it uses a freed page, which causes kernel panic.
> 
> BUG: unable to handle page fault for address: ffff8881576c110c
> PGD 773801067 P4D 773801067 PUD 87f086067 PMD 87efca067 PTE 800ffffea893e060
> Oops: Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
> CPU: 1 PID: 25 Comm: ksoftirqd/1 Not tainted 6.9.0+ #11
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
> RIP: 0010:bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> Code: 00 53 41 55 41 56 41 57 b8 01 00 00 00 48 8b 5f 08 4c 8b 77 00 4c 89 f7 48 83 c7 0e 48 39 d8
> RSP: 0018:ffff888104e6fa28 EFLAGS: 00010283
> RAX: 0000000000000002 RBX: ffff8881576c1140 RCX: 0000000000000002
> RDX: ffffffffc0051f64 RSI: ffffc90002d33048 RDI: ffff8881576c110e
> RBP: ffff888104e6fa88 R08: 0000000000000000 R09: ffffed1027a04a23
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881b03a21a8
> R13: ffff8881589f800f R14: ffff8881576c1100 R15: 00000001576c1100
> FS: 0000000000000000(0000) GS:ffff88881ae00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8881576c110c CR3: 0000000767a90000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __die+0x20/0x70
> ? page_fault_oops+0x254/0x790
> ? __pfx_page_fault_oops+0x10/0x10
> ? __pfx_is_prefetch.constprop.0+0x10/0x10
> ? search_bpf_extables+0x165/0x260
> ? fixup_exception+0x4a/0x970
> ? exc_page_fault+0xcb/0xe0
> ? asm_exc_page_fault+0x22/0x30
> ? 0xffffffffc0051f64
> ? bpf_prog_f0b8caeac1068a55_balancer_ingress+0x3b/0x44f
> ? do_raw_spin_unlock+0x54/0x220
> ionic_rx_service+0x11ab/0x3010 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_clean+0x29b/0xc60 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_tx_clean+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? ionic_tx_cq_service+0x25d/0xa00 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ? __pfx_ionic_rx_service+0x10/0x10 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_cq_service+0x69/0x150 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> ionic_txrx_napi+0x11a/0x540 [ionic 9180c3001ab627d82bbc5f3ebe8a0decaf6bb864]
> __napi_poll.constprop.0+0xa0/0x440
> net_rx_action+0x7e7/0xc30
> ? __pfx_net_rx_action+0x10/0x10
> 
> Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Thanks,
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> index 5dba6d2d633c..2427610f4306 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -586,6 +586,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
>                          netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
>                          goto out_xdp_abort;
>                  }
> +               buf_info->page = NULL;
>                  stats->xdp_tx++;
> 
>                  /* the Tx completion will free the buffers */
> --
> 2.34.1
> 

