Return-Path: <netdev+bounces-103418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D401907F10
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EEC282130
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BF414BF8B;
	Thu, 13 Jun 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxQSBeib"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D313B5AD
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318410; cv=fail; b=MZOZULCbaVHikpkCD+d3Rq5/BKiBDS2uwy0P32oxKVSaEnv2JElJ6XU06Ysn3z/cDyTftwQTG2G8xssfms/MhR6qN4xhnUodu++fiYOEEVkJF4HrGObynqFxCdUXJmc7/tg842cJuUA4V+OpifGhqXImehrLDTlmANfRBYMQ20I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318410; c=relaxed/simple;
	bh=WsQPu/k49QCq4eCYEzHBsUN3RTlPOi7P1ToRP9iVD3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZ+0PhJR2euXnRPI3WVOC1JKa4hynx+r2rfZawqTVpAH9Kzqmsh2Fo6bvoz6Kxu67B0y9dl0DTFKJ/mYr3t/p4hOPfanob55LJtGaj2/4O+mV97oriVrrQrdfWEh+OcfWcHNbTxbuK6CW2geX+DwVaYLA3JkvBDJIQJ2ORBsxd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxQSBeib; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuqBh29CfZ4IPxId2eWaRaj6yCisyVpz0Ekj1LpdAcyUwrD8d4V+j7rPh4eCzr7Hq76Gn9kGCXnZwoNmJCBwQQFnXLpcIRWRwIbtji+wfnJ4X6rDomGhqXL3ltMfJt26RfJLnxO4b6h0uS3ojvb2HvBqQOqi8UcK2xdXQGo+E5cfC5Bj91wklloGkRl49/bDsLHsgiVZXMOn4VVuIAPIaUlO4d5RPrVjy2PkUhjsR/PrF/R1B7IRQMG/oteg8RtnPelvbt5pJDObvHgW65geIn4W5NZmUkLsxr64Qm8aufMwntKcz26ZKm8XE3eWuziauC4tGfC8lBEQBOp71tu4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY+o+ai8cyg0EJHc6BZyCg9MGKNqydUa/WRW4lzBaNo=;
 b=WwkqTEuDHsviPEwNxQwWGPqhFKKQODz5wSVkiOsXgH/9XLiP6XabpaZPtE1NfL26dMRY+SFe5RTNMc12TJhyfkpmHHv8uJhjcNkfrlgsqcKX88QYFRtQayJABDaJ04d73C6/ubJ0f66b7IAixYzbTOYFe2q6nxRH8y4Y2LlG3M4WcqDWlGNgV9sDZbsWvMFgpklDhPGllcMzNGcsgFadUHD/UVTsg5hHcJEucf0LxkgNu9I5ViOsyQQuMCoUmoa96227FjgEzN5M4EiCum9Ht9J/ArzHO1RgnhyuD29qLIGS23DKllFNSNxKLjuZQECUInPsxE9EMrq2wy7QdJm9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY+o+ai8cyg0EJHc6BZyCg9MGKNqydUa/WRW4lzBaNo=;
 b=nxQSBeibtlt6IZIrxd53d1d8HPLgTMq2M4Alh785mpa28wUgJjofzdDHCXrNwKWE9C7L03VzUhlFr4WQVxUOD6y7IoOmfSXQRrEL54/shYwEoPvBvRHrm+w/g2TqLRBWCL1W1uw0q95IkTrMRxQOjY5/mifRfqPMk3DiOgj/u1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 22:40:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 22:40:06 +0000
Message-ID: <3211c9c5-6a42-424b-97d7-2c85d3408c0a@amd.com>
Date: Thu, 13 Jun 2024 15:40:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] ionic: add private workqueue per-device
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
References: <20240610230706.34883-1-shannon.nelson@amd.com>
 <20240610230706.34883-4-shannon.nelson@amd.com>
 <20240612180831.4b22d81b@kernel.org>
 <54c39843-b81b-4692-a22e-d2c51e617219@amd.com>
 <20240613151928.6cc91d18@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240613151928.6cc91d18@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 00835694-1b8d-4335-1e98-08dc8bf9c5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2N1L1RjL1phR29NTG5xRFU3aG1EKzhiWDJYaG5rSm9FZEt1ZEs1bEZhNzJt?=
 =?utf-8?B?akQ5TWI2Vzg2TVVSaGp2RGJxckJiVk5SRnJSdzVxZWoyL2hEcmZtZWdxWWxS?=
 =?utf-8?B?NWZMU0hBV2RISkJxQ09yTzZJS2RubHM1ZlJmYVAzUm04MHFDN1cxRTZKaXoy?=
 =?utf-8?B?VHdiSEJDLzZPR004enlkSWpidEdGOTFGb0UxV09RdkdlY2J5aWMxSWVFS0I2?=
 =?utf-8?B?aldPL2RnWU10SWttMGs1TnVtVTVnNGlxNHc1bUw3R2Z0dDVuMkx0WHMwTW9W?=
 =?utf-8?B?VlRJWGthZTFLT1k3VHNqcDNkc3dhcWtkSy9md283TC83ekp5REcybzVrK3Yv?=
 =?utf-8?B?N1Z1Uk4rdUtCaDVkd2xJeDNxUTMrV0kxWVB2dzdQTzlPYW9WLzh6OHRHQVNB?=
 =?utf-8?B?MTQwbmhkR05jOXlCb044TmxMZUVoZ0RHcE85Y2FYMkRTNVFmZ3ZxVzhDOEhn?=
 =?utf-8?B?TlVzRlNONVdxZlMvNTlzNlpHYktGRkM4dWNWL1hQam0rVWY4UmpDYmRoOC9G?=
 =?utf-8?B?VjBsbGtrVlgwU2kyOE83V1pYd2V2UlhHRVVXYmNkRFkxODJoTHRobkZkRFN3?=
 =?utf-8?B?V3JEYXJ6UFZhUW4xNCtab250cDRCWjZkbmtCRG5wYmw4NFZZUlBtMndCMGk4?=
 =?utf-8?B?cERQdXNLT0dTMTRjaTliclQ1YVZaS0d2RHNFWjZadFprYTVYamE5UlQ4Wm1R?=
 =?utf-8?B?RitJVERJNEl5MWttRkZTRTdsQUNsNWVyTkNNOHd3OVc2OUxPOWdRUGExVGFJ?=
 =?utf-8?B?Z09LTk9CWlNkRjZKU0tCV1JBT3NHYVVRdnE1RExYbDBQVkhzc3Z2WWR0TjZp?=
 =?utf-8?B?U01oMzZ3TUNaN0lTTjlzU0RiZ2FtdTZCN013NTNMcC84WGozQjRkd0xCVmU1?=
 =?utf-8?B?VUxXajVrUEE5SGg5WVJEVGc1VTlNVElKS3BVUTJMdzRxOUFGNXFZQUJ5Ulpk?=
 =?utf-8?B?SHdicTNIclNvKzIrem5LeStqME8vL1lYUTVWQWlZYkdwMW56NmF1MWdFdXc0?=
 =?utf-8?B?Y2t0bDY3ZFVDd0RzK0pua0VFdE9hcG44Y2NRbmVCVHRPUnlHODlkUG1MNkUr?=
 =?utf-8?B?ekhobDBCOEdYUC9hRzYwa2NjUEZkbzVaMUIzLysrUitOdkNZM2h3UmR0L3ov?=
 =?utf-8?B?UFZiTEdZTW55UExYL01MSnZYK2p4bXBXUXlCa296bmRzWlpJbmRKZ3BwMWlt?=
 =?utf-8?B?OE5nd2FsU3FGUStaOUJBVVEzaUtVT2U5cjhFUGRXNVBhQmtualNsNVNXMVRL?=
 =?utf-8?B?UXNPVS9uKzdPcUtvU2NQNVYzRE1CK1FzYzJld2NraUZqdWtpYnh0YmxuOGMv?=
 =?utf-8?B?R2FSNDMyN1l1eFpwSWQvb0xnMmoxRnBsWWl0Y1Y1OW8wamZ2S3UxbW1iQ29N?=
 =?utf-8?B?Q3o4ZDNGb0orSlJ2VW5lNTNmYTRmOTBTb3NGOWU2cVVoNVVYeG9CTHQ3eXBH?=
 =?utf-8?B?SjJ1MzRGZ1QvVldVSHo3SVdyVW9TRWZMQXdDYlpna1V1eHgyME5uQzlHYldF?=
 =?utf-8?B?OFJ2anFOVzBua0pEU214OHFCYUNlbHRWNmlKdWZ6ZUtaU1Z6UHVHWTVxYm0r?=
 =?utf-8?B?RzQxeGlLWFJEcU94UDAvMWNMUXBaYVJlL2IveFNzOTBxMTdvaE03clVUWEJz?=
 =?utf-8?B?a3RmZFFzQ2xGNS9iOHE4RGtXOXZnN3VtK1A3MDhJQ0xVeFQraU9JdTh5dEZx?=
 =?utf-8?B?cHI0V1BaRmFra2xXV3BkRW8wNVI2cVI0aFZnZmZMVlJGdzN5VUZXRm5PR2Fr?=
 =?utf-8?Q?8Nk9mMPYpmH15jXJx7RPpuI68SbY1tgF3J3Ko1U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1h3ZlBBNG9lRTA4a2RrMlpXNW5EUkdtSzczbENKeXBBb0p6WHVNZWhKNXA1?=
 =?utf-8?B?YStmelhjWmpxSVRaMERjR2NXb0pSNjROTEtJd0RGdkVqWSsvVzFhbGt0TDZG?=
 =?utf-8?B?eW1xbE85bWFkWmxoOTU3K2V3Qng1WGROc1h0cTlVN3Qralk2UG4wNFI4M0Nj?=
 =?utf-8?B?RzhiOVlsdnNMRmhxNm9jNTJHbTFrbzZ3eklqeGhLSk5qVVZYalIra0hCRlJa?=
 =?utf-8?B?Mkh2clNEUHBzSCt2WXlUaEdjWXlpb1Qzb1I0TmFtdk9ydllwcmVCQkZJNzA0?=
 =?utf-8?B?azlqaHA4L256UEoyaXdqWnQ3WjFWT1JVSm5aMVFzRjQyZzg0anp1d1RQZVpL?=
 =?utf-8?B?L29HZ3NReDd6Nkk5Q3RVNmw3WjU2MFd0T2JMOHNVdFk4MHdVUU4xKzErRDdT?=
 =?utf-8?B?TmpWK2dXeTYvODhCSG9uZ2tyNloweHRDRDZxTWU3dW1aUEJTMjllU0ZXdnlr?=
 =?utf-8?B?OXVZcVh4Ny96Nm84TEd0d1RtZVpzaUNrM2xqVXJDbDR0ZktuaHZlRVNNNjRq?=
 =?utf-8?B?RDhjWGI0YUpxbVBhNkdvT0JLemJXZmx0MFo5T0prQnlkWFNHSXV5a3hwT1l5?=
 =?utf-8?B?VnBKak1BcVVNZUtWcDVVMTVOaThDY2FVNnpJVHNSYVM2TzU4aXp4R0NvcUpa?=
 =?utf-8?B?YWwyTlRxT081cW9PR2U0WFh1M1IvcDBaeFQzMmZ0ZWhKSEFqRFo3d283dUsx?=
 =?utf-8?B?UnU3MGkvbmNxelk0TzF6VytrWVFjeVkrSEF0RUFkWlpId3Fhc1BrOEJSYUpC?=
 =?utf-8?B?dHhDR3FFQ2JWNDJKamxySEFIZlR6OEZHY1QyeUN3d0xXYnNqTk9RZlFYU1dM?=
 =?utf-8?B?cWFiNFB4eUZYN3B1dndEL1FVOFd0ZC9oQmE5RXRRK2pOUERUUkFGU09RV3d2?=
 =?utf-8?B?Uk1RMFlKY0hXdTdlNnVtbmJlN0o4b05MNEtDYUV5M1d0WWdlMzYzSWs5ZG1t?=
 =?utf-8?B?WTRzSzNyR01LdEZSbFRjYS9LM0szdkpKUTNaSVYyMEMyTzJGWVV6M1NXbnNK?=
 =?utf-8?B?NmhDTTBTSlozSGpvL2dtYUxaVEJoR2ZpbzNwS0Rhb2REZkpLOWpCY05SOFBL?=
 =?utf-8?B?bStMaTdjUTE5SmJxUHFURU9BQUIyNEFybUhPVVh0TUFtTitqNmI2U2dRcERs?=
 =?utf-8?B?aWJuOGFEVHd3RWhtbWxTSmVNWHp0eittWkY0dk1vRWJTQUF2SVprckJUL01M?=
 =?utf-8?B?Wk1SY3g0RHZHSW1WbjdCeVduRHRUT3NLU1pMVmVjS1dLeUkzb3F6U3lwUUMy?=
 =?utf-8?B?ek1RUWtLaTZ4WFlRUWdyYkFQK015VXN0VU40cWZxZ25iSWwvOTVsUXJhcEFY?=
 =?utf-8?B?YXpZV2dkcFpLRThsNTJQb0R3eEorbTFpNmNhS3ByWDBFd3ZpUUNYR1RHekM5?=
 =?utf-8?B?K2s3RGhrSGY4K0pLNlJBY2s5ZUt1ZVo3QXAzcUxEOUVHMThoNHZweHNPTTBX?=
 =?utf-8?B?L2NFdHJBcUkwMUFVTEJoaWZLWGtRMGRhMjA4U0VjRGhDUWZ1RXhpZEtnSnV1?=
 =?utf-8?B?a1dHZXhPV1NMVmIxcnZ0YksxblU5M2tjbll4RjJTRCsvS1RsVUUyc28vckRq?=
 =?utf-8?B?Y0xqVmh6THZNNjh6L09NTTl1UHRsdlRweTNTb0FqUzJXQUhCY1NXSk1hWjdh?=
 =?utf-8?B?aTNWL0lNU0REbFFSVklMVC92NHZXTnhkNnBpVXRHd1pZdFhoT3JodHNBUmdK?=
 =?utf-8?B?dXVLWmdwRzVYTjdhVDFIQUJiNVRyRVFUZEtITnYrNU1sRGt2K0YvVzZCQnc3?=
 =?utf-8?B?NmcxeGF5OW51Yi9CZkRDZ1FkeVhaS2tYTklYOEtpRVJZanpyaTJrYjFNSG9Z?=
 =?utf-8?B?THlPZUY4SHZMU0tocXJvRHh3M3lZMWxKRU9oaXdqZ0FYZkFSVktZWDJQWTkv?=
 =?utf-8?B?ZzdTYjVkWHBBcVMvRExrN1Y2dXdHYUhLSWRMRlQ0NGR0bzcyUVRrZitiWmhp?=
 =?utf-8?B?ZCtucWRXcDZPSkJVZnJnR1NrdTh3eURlaGpvQlNoSXcwQTdhZDQvSjZSeGht?=
 =?utf-8?B?OFVaNkdXekhGTlVaaS9zR0pPUzN5cUN3Z2VGY0ZabFBOMS9xeEp0UDFFbjRn?=
 =?utf-8?B?ZVg5RUZzb0lCQkVONDJMQmpiS24yaWcvQkc4T1B6RzZFeEVLcUlVeUhMUkZJ?=
 =?utf-8?Q?ykukQ2hniULYW8FwosSQaVjcL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00835694-1b8d-4335-1e98-08dc8bf9c5d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 22:40:06.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HBVlSFMa3dtrR7DdOyfQS/hdUJbYm1fo4aGbnehxeBxNcp8qgyCPXy/kwj8KfDiDJNxLoOf40O2NChbdoUYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

On 6/13/2024 3:19 PM, Jakub Kicinski wrote:
> 
> On Thu, 13 Jun 2024 13:38:18 -0700 Nelson, Shannon wrote:
>>> little jobs little point of having your own wq, no?
>>> At this point of reading the series its a bit unclear why
>>> the wq separation is needed.
>>
>> Yes, when using only a single PF or two this doesn't look so bad to be
>> left on the system workqueue.  But we have a couple customers that want
>> to scale out to lots of VFs with multiple queues per VF, which
>> multiplies out 100's of queues getting workitems.  We thought that
>> instead of firebombing the system workqueue with a lot of little jobs,
>> we would give the scheduler a chance to work with our stuff separately,
>> and setting it up by device seemed like an easy enough way to partition
>> the work.  Other options might be one ionic wq used by all devices, or
>> maybe a wq per PF family?  Do you have a preference, or do you still
>> think that the system wq is enough?
> 
> No, no, code is fine. I was just complaining about the commit message :)
> The math for how many work items you can see in reasonable scenarios
> would be helpful to see when judging the need.

Sure, I can add to the description - thanks.
sln

