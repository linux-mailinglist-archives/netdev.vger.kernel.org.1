Return-Path: <netdev+bounces-148640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5659E2B74
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECBD2809FE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472231E009B;
	Tue,  3 Dec 2024 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YFf3pTr0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E461362;
	Tue,  3 Dec 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252170; cv=fail; b=KL9mNOg/xn+aLcJdaIR1zuNJmJpJgEfHtgkY757ST4hai/aA+hoGTskWdkQiJIw9SCq3ID31YG5CptsT0gWvgp/HuarE4G4s4eZwCO10hV0tWNIs6fh/J07DaGFMuSaoK27xEGUe3TDzcbBVjt7NQSTf3ImX79S6KmM8NMpuD9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252170; c=relaxed/simple;
	bh=rHOcjMe26RxleAmv4EGd2MNGOrkqrLUFsp5HfdvNqZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KlWI5VictczKvJMgDBJdfox8ims2iZ2BdZTFuvlJagQ2CJPB8M3zZQTF4JuAdK2zfAG07GwxjFuizACdarnfUnQCi5rp6KfhtR3WXKJATwZ4zKOcuicOx+74rDxZkyn1VetVBSj5JCTToaD3wkR4+NEoE/pGOjbdy3E0jY6WTMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YFf3pTr0; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkcNO/64m231WsbnyCuZncJasZ/raCouKV4aWfsM2cZHODEg0LTrOEfjkFvNXzuUA0MJKuzLTm9k5HmXmXd6ybNJSbgLDjYQspp9aBKpHYnAldPKsFHo4iOPjHpV4O7Z5eslk1ESU7cMk58X4u+7PPrmA+SPbx50uyHS30MNQmAzl+54PYPpz/Y5yd8EYqFOzCJRl4fr+redR/7cVVB9yaqwckOnruvVTl5Rmj1O1DVw2O6N5ubdkpaw0MwbyLpBWPn28SbXm2hmQwYg9w+G1NwiLTIRYBMmKTD01RzCfYi1z3hGcpR0QI6ZLWzzQnQHHz5pwBNInq2fDCwH+FktgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjiVhSnCr+imJaHv1w+YWDpHMV2oeNODOKL7u3tYlr4=;
 b=DCbUSpXP/Dlqw1HAtBAVACFjr8IQJ3jTxpc5CM+ovn6XV7o2d4DRbC52Rjp0EWzMWLwRIQ5p3DmNF6sIDFPWQaBU+WAhssu3gYnKRYpgDFgJUDbkHQ7hv9IWsL6Vre3N1WMbdOdwkT1ZIGCS92FqV8AyLKMlxDC8TqZQ3pJdprEyHj/4DuWwMBspn3/RnLzWIKhZSjAr8iLzWTBPaP5/Yn+35iMlL4woELhBxiDlknCh35qL270JRWcoHP/YXnY3oMufI07K/K51JsggtOKbsFH/VSvFOWZY2G9hn2gcFHrAMes8XKer10AMxGRlnzOD++Z5a6ToCiIgqg4V6ug/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjiVhSnCr+imJaHv1w+YWDpHMV2oeNODOKL7u3tYlr4=;
 b=YFf3pTr0mZErTs1O13xCNYfqeYK/RkClc0c/5NR6DKIZFqRnSmcZGv0urTHt3llGWfzuzYLiXXjueRQUrQgVL7ynPryNLe7dIBfnu1PvhDy5oeEkDTGDzbOo92GW/fxyU4duMHtoMF0eDE+llJxNQDOy+PP+ogbS0slA6wKN0Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 18:56:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:56:01 +0000
Message-ID: <25ea9212-5448-b77c-d2e1-9ff1f285bef4@amd.com>
Date: Tue, 3 Dec 2024 18:55:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 04/28] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Zhi Wang <zhiwang@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-5-alejandro.lucero-palau@amd.com>
 <20241203203713.00006c8b.zhiwang@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203203713.00006c8b.zhiwang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: d00b681b-5b29-457e-1525-08dd13cc21af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNuRU5KVFlTUW5kUEQ4MUxLVXhpM0dRNkt5NWtkUnJXYVdpSWlGSE1nYS81?=
 =?utf-8?B?dVJFUWlkR2NBVHVwSWFsUWxuSU1ySSt6d01DY3duVFREWGcyR21BODlXbU9h?=
 =?utf-8?B?UGpGQWJTbG5yQjN2ZERTZGpjZ2FrL1h4eEtzUGtHTlBsNiszYVc4Qis5TkVm?=
 =?utf-8?B?Z3RYWjBIL3ZHb05DUU1kc29mbHExMU1zQ3ZUaERsNlgweEhkNll2U3Ftc2dW?=
 =?utf-8?B?cGZxTWxjbFFUTVV0eVB4Yit3WE85MFBGcGUydTlHd0RWL1ptUXdmSlhmVjlS?=
 =?utf-8?B?UVdoWmNweGRFeWl1VzY1NG5mYkU1M05hRkcwQU14NGhoVy9jNUVGSUEwYi9k?=
 =?utf-8?B?cWRycmR1cUJ1TlJwYlNLZEhTUGxDMWFzcGdrT3RDekpsa3doZERLRE02UFBz?=
 =?utf-8?B?TWsvWnUxS3pGTFYwT1VKanppWHFYeFNlem5XL0hFNTFrOXdUN2NyR2xzRXor?=
 =?utf-8?B?NUpZc0VaaE55cFY5YitiRFgxZXNyY1dFMkQ4SGxUOTJTWGo1Z0F3eENNZGpK?=
 =?utf-8?B?Tmdma05DL2FDSldYZ2xRMGMwckhqc1dvNk52Zy95MElPOXcrV3NvZ1VKT2Rk?=
 =?utf-8?B?VDFTMVJTNGV5OENuZWFvUkV2OXgzbGNXeFpxZVN4RWJpdjI1OTI0c2Nmd2Vk?=
 =?utf-8?B?dmNWT0NhOFdNSVMzQmRocFI4blRsUHRNOElsUlhaekE2RWRhTXExbHNSTHBS?=
 =?utf-8?B?UTZhU1ZERkcveStEM21ZMEhhUmJMWFFvbCtub1lkSC9Ga2VsbXlwOU95SGV0?=
 =?utf-8?B?RmhBR1BNMngxaTFyVWFBTXJicHVPWlhxbDY4YzhKeE5OOGtzNDBJbEJidEh5?=
 =?utf-8?B?aXFlU2hhMkI0eHVxaHk1b3FtOVoxdnRta3JTa2lLa25WSFRpYnRmdlpuTDBz?=
 =?utf-8?B?Vy9ZNVU1WEJCMUF1THdyQjF5UDlQZ0FTVHhZUXpZemxZVFNCYlJTRFBkV25H?=
 =?utf-8?B?VFBUeXZBWmZrNk80elpTb3AwMnI0bmlrTWRaUXpXOGJGcDRVMU1lMVJFM2E4?=
 =?utf-8?B?WUZ6b0xNUjI1ejhMdUppdXF0SkRpRU5VMFdaakljejl0c29NMnhtRVhUZnJU?=
 =?utf-8?B?c05tOXIvdUZxV1JTKzJXN1c5VkEreDRmeGx5T0NXSm0yd2RsTGFHYzg3RHhv?=
 =?utf-8?B?bzFHejVsV0JqS2NWQ3hlN1AyZEVKSDlHLzJtOUlUNFEzVkZ1MDNMSEZLS0F5?=
 =?utf-8?B?UC9mNDlxV2U0TGZtK2VBbThmVUpwUllIdWhCS2E2VmlDaGVhSlVSRG1hNmJn?=
 =?utf-8?B?bm5uSmN6dTJQYUtId2Q0YnpNNHZZTTdIK1EvbUN6RWNNS1hZWUlCb052cCs1?=
 =?utf-8?B?VkxOdEpxRUlwdzA5dW9nRW94MGFWa2FFZTJFUWhyZWdrVVdhRmV0Ym4wREl6?=
 =?utf-8?B?NDNJYkxSL3o3akFGQXM0VHpMSVFDUGxqNVIyQnJiTlFUM1VMcnErY2kwUXdP?=
 =?utf-8?B?NzNmUE9kMnB5UXRJM0VuUTYxRlBWcmhsdHZBOFJIZm1ySUptdjdDUUR1TEpC?=
 =?utf-8?B?bCs0STNxVFc2UmJXOHUrOVR4U0k5MDVzNUtCWStJdjgwRkFyNXlJOFA0VGhk?=
 =?utf-8?B?enFORHZnVXdhUForL1RpOGNRZGN4QlMvN1VvVjY1Qm1iL3ZHOGdiVlRnUkQr?=
 =?utf-8?B?bjJLckxzTmNsMXZpeFRTK2FFU1RsejlPcnpaeGoycVAzY1ZJTWVZSmk4Nmhq?=
 =?utf-8?B?VHBEZDZiczJHSDJUZVpzWHhtYldidittWnJFWDUyeEJ1VG9IRnAvN3FpRldh?=
 =?utf-8?B?ODd4K2U0c29WVkFpWkNZUXh5UmcyTEUwRkRzUXhwY25vd0FuRWNYaVB2bVly?=
 =?utf-8?B?SWgwak1uTVFRQnBtS3h4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5WU1ZDZ0JXVTNFTUE0VmxZWk9NcktXUmpTSXBjUTRjSzNmNWRob3lxVDZV?=
 =?utf-8?B?Z09kMVlmNytHa2FTRkkvQ0pzSWU5OVBjeldpRDhmZDBWMjBOWUxqRmlvNFRC?=
 =?utf-8?B?TXN2WWtkTlV2dkZPTXlmWUZWSnMwdjU3MkdKYkFCamg5cHQvK29pS1hNR1Nm?=
 =?utf-8?B?SWRJeTNVZzE1R0Y5Q3VmbGRUTDdycFJ6aGdlYWpRVDNzRGZ3WWFEOW9TY2NL?=
 =?utf-8?B?a0pJdTFlc1ZRNG9aMmtuUUg3UVEyUW02RlRDa0E1VFBzaVNoMmppY09INVUy?=
 =?utf-8?B?MjA0cE5STFFHdE9HTFpxR2twNnR2bjdranRYeWt0VE9wczdtUFJCRDc3L1FR?=
 =?utf-8?B?c3ZUQ242TzZMSGRHUjQ3Ris2ajJzYmpLR0hwdkhLTWlaYzhjY0gwTjVxNlJp?=
 =?utf-8?B?SklPRW9naWlwZ0lxMXNqY3lUUHRQTWt6WXgxNVF4TTNrWkRzSmQwTFF5WnAw?=
 =?utf-8?B?L2RqbVVxUmg1SjZpclBSKzJZSG1XN2gzazhlSnREajRJSDZZMXlYZzNsTyt5?=
 =?utf-8?B?Q1Y0ZmFMbW15K2Y2dmRJckJMREM3Skk5bUJPWUlZeURKUWE1czh6SDBhV3Rt?=
 =?utf-8?B?bi9FWEVMdDhZNWZ6eHZnUWNSaVRRUkFDRE1nMERGM3lWS1N1N3ZzTkpvcmJQ?=
 =?utf-8?B?MUpzRTVkQ3RkTFZSMGpLRnF4TjBnS0M3SzBzSHRpcWdod1N0M1dUNU94TXlM?=
 =?utf-8?B?QXVEbWJSSlRpM01MeTJWeklYQmtxdlRNY1BnaWhmYTgwV3BwaDk2WVdOako3?=
 =?utf-8?B?OGRDREkxeE5BNmg0UEk0ZEl6YlVXUGJUZzBkanE3THV4aGd1bzBPOU4yamZK?=
 =?utf-8?B?a1liWGFoRFRxUFlRRnR2bFhieVJXcVR6eWI2d1Q2blRiRnExSWJxcTRSMTQ5?=
 =?utf-8?B?NDNJT2lkNGZNcU1ra04wWFFySVlWR1l0MXRDWlFaU0g4Nmh4eEw0T0svTFlr?=
 =?utf-8?B?d1Y1VVpHOUVQempUQmQwdXcvc1IzaTNLSUwrQjNqenhOVWJ5bGM0QlFBNWtF?=
 =?utf-8?B?MDUwRkNTNEtjUlJPemMzSnJsQmdtMFVCcGpOZnNYNGZ1aTBnUG1wbmZ2ZEFV?=
 =?utf-8?B?cGhkL2tVa01XL2lrcGpFVnRDQjBxNkdyclRXU2tMZ3FDelc2SDZ3dGdFWkxN?=
 =?utf-8?B?YWVlSWl5VGxneENJdXgxbVdjWVBZNFZMd1BadVN0M2xuYmhLbkhtUXRLT3dS?=
 =?utf-8?B?SGhmZTBWajNVM2ZDcTA0UWZYTWRZNllEem1SU3RhYmtvK3BNYStuTDQ2K3Y3?=
 =?utf-8?B?b1FBeE03QStkTG85RWJZckRvQUVFM0ZjZk1ySWZtRytTNVVRU082YUNvMkZU?=
 =?utf-8?B?eHpycWoxdEtYNVJad2YreGpuTDlSbVVTNVlQaUhub2h0STNaYVowNnRmQ0tp?=
 =?utf-8?B?SG5mSXBUT0Q4RUNHOWdrSXZBcC9jZ3JIa29tWUtYMUFNcGJBb3lodWlxa3Za?=
 =?utf-8?B?N3dxdDRZbWlQUnlZRWJ5QjJpQUswUXhCdUl5Z1pjSW9tZUVGa0tidTJsc2cv?=
 =?utf-8?B?QXNtVW5WK1hyYVZ5WEJHVGIrcWlyQ1RwRHFId1pNbFBXcXFEWkdjVU1oaWxU?=
 =?utf-8?B?Wms4MlVka3ZDeHVRQk5sdm81Y3JUb205QmVIYWVvVDdMYW53bnZrdjU3aEpT?=
 =?utf-8?B?cXdyZmo0WVlISVFnSm4wV0xUT2YxTm0yN0p0VXBndEwwMk5DQlkra084eGFo?=
 =?utf-8?B?WkZHT3BWNTFsSlQ5RkdzVzBUSjFRKzRpTHdCOEpaL1RiSGRyRDFoWVJvYTda?=
 =?utf-8?B?b0JwazJjVkZHRWZZbXV6N3BFZW5Zakd3ZElNTHVpMkZKMkFUUjFEV25wTXpv?=
 =?utf-8?B?S0FibzF0RDc3d0U3RkxUd0RBN2lwSGE1SWM0S3Q1bkNPMnhoYzc2YzE2VUNm?=
 =?utf-8?B?R0kvY1BOSzRmYUNUcjFUdUZLL0JOQmJCZUVyOUNRcXp5RWlFbEprTnBQQWM1?=
 =?utf-8?B?K3U2ZkRLNlRHK0k2bSsrZjcrWU9TK05wVHNWbWQrV0NTTTZoSlBHM0piM25Y?=
 =?utf-8?B?cVBRYjk1Q2NaWlRwZ2tXTWJsYUNIKzlkVmJqanBpT0hHSWxrZHJkWVQ2WENs?=
 =?utf-8?B?b0lmY1VnK3pOL3VmWlNKZFdDeWhHT2tKK3RoVWpSam5NQXhlOTR4QlBaclA3?=
 =?utf-8?Q?Pus+HdQgjfSnQoSejYqQLMmUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00b681b-5b29-457e-1525-08dd13cc21af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:56:01.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UvpORIlr5xZtqN0C0mfmJ0sJ2trxkBZGjnrJBl8aZD+QihWPYHgKzcR1qFHNUxg00QvYTyO8urPj6VG38alIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525


On 12/3/24 18:37, Zhi Wang wrote:
> On Mon, 2 Dec 2024 17:11:58 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization and allow those mandatory/expected capabilities
>> to be a subset of the capabilities found.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>>   include/cxl/cxl.h       |  3 +++
>>   4 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 7114d632be04..a85b96eebfd3 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev
>> *pdev, struct access_coordinate *c)
>>   	return 0;
>>   }
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long
>> *expected_caps,
>> +			unsigned long *current_caps)
>> +{
>> +
>> +	if (current_caps)
>> +		bitmap_copy(current_caps, cxlds->capabilities,
>> CXL_MAX_CAPS); +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected
>> caps 0x%08lx\n",
>> +		*cxlds->capabilities, *expected_caps);
>> +
>> +	/* Checking a minimum of mandatory/expected capabilities */
>> +	return bitmap_subset(expected_caps, cxlds->capabilities,
>> CXL_MAX_CAPS); +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index fe835f6df866..70378bb80b33 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -444,15 +444,6 @@ static int cxl_probe_regs(struct
>> cxl_register_map *map, unsigned long *caps) case
>> CXL_REGLOC_RBI_MEMDEV: dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found:
>> %s%s%s\n",
>> -				!dev_map->status.valid ? "status " :
>> "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " :
>> "");
>> -			return -ENXIO;
>> -		}
>> -
>>   		dev_dbg(host, "Probing device registers...\n");
>>   		break;
>>   	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index f6071bde437b..822030843b2f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id) {
>>   	struct pci_host_bridge *host_bridge =
>> pci_find_host_bridge(pdev->bus);
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_register_map map;
>> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id) if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS
>> capability.\n");
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +
>> +	/*
>> +	 * These are the mandatory capabilities for a Type3 device.
>> +	 * Only checking capabilities used by current Linux drivers.
>> +	 */
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +
> I suppose this change is for type-3, looks the caps above is wrong.
>
> It has a duplicated one and I think what you mean is CXL_DEV_CAP_MEMDEV?


Oh, you are right. In fact is was like that in v3! I think I did tests 
changing the bits for checking the code and forgot to restore it.

BTW, with the new implementation this would not be an error, although 
obviously not correct. What I mean is now the check is by default the 
expected by the driver being at least a subset of those discovered and 
not a full match.


Anyway, good catch! I'll fix it.

Thanks!


>
> Better we can find some folks who have a type-3 to test these series.
>
> Z.
>
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset
>> of those
>> +	 * found.
>> +	 */
>> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected mandatory capabilities not found:
>> (%08lx - %08lx)\n",
>> +			*expected, *found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index f656fcd4945f..05f06bfd2c29 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16
>> dvsec); void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource
>> res, enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>> +			unsigned long *expected_caps,
>> +			unsigned long *current_caps);
>>   #endif

