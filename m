Return-Path: <netdev+bounces-123125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA968963BE3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FDB233B2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367E16B723;
	Thu, 29 Aug 2024 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2UcqxZj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82816B381;
	Thu, 29 Aug 2024 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914069; cv=fail; b=uX03qUOkVCVemL88fYUa1vPfwr9AOjSsK2R+7LPt8o/XqmPwDG2WcfSCyCwtUg6gKkyrbnLhBghFy1nwP99+Zzt/s8R6sIshKAX+fNHgH8uRWYc2vIcVPYAlfPHWf9SG3pvGuuWbLGiZIeXs0cG+ztlioCIThVYCxXhjSNaRdWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914069; c=relaxed/simple;
	bh=BzeIguqy8yuqlyQyN2D4rcqLL6aXaTtThX8Vlp6yhF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ta1CBQ1uxnfFeQ4VmrdUU2oHDsKweJJXlYYJp7ZNr2pGL7hJ55QpRdKOeSYgi8bWd7YQCTYBvxTjx1HmsLzm2oA+OzgTtr0Q6a96IZ6aiTUCHLPAT6y7igKanSfdAwpIdmG3foV2sriT0cZDB21HeHCXp8j8ZBL5iHc6sLI6g3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2UcqxZj; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsMGs/S2stH76uwK7jsm92dvEyI5bogeNBCZNZuj+I4Pt+LDWtOnJ2d6Yonkac9P4eX74m91M2bTMP7C5J+eT++LFeqkxjgQXHmKEmVv2YCDQb7yyugPXsxG/5L1juGAIITbFk2fA501kq2IdCTX9aEs/CkLR1o8itdpbIkzSEZHSlrYvw+YeZNE1RVCYmQ6+5+jf3Gn5Ya5FrdW100c+TTgeluR9L4cwjFpfI3lwtUXMuLHrHqJUzl8N6T2usT55vFUsOzbS0dPbNFUoyb2Qw87A/o7eVKnoDg9bOaTyEmlXBxSj3uWv0tcnPmVxzuOQQcVpmOdrThRMfOy/WjwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzeIguqy8yuqlyQyN2D4rcqLL6aXaTtThX8Vlp6yhF4=;
 b=mFHEKiyYevKPQFuq0LvwRwE+XMrmhRzHPOZ36vL6VlmbUVAfIcXotF3Sw+3Enq5KRbn69Wp8l8SAEdkrAXHu384j3Rhb9jIyd0oH0A2NZl0PE/WcK7ZMGAw1Uya6bv0OuFgUJ+aCFyPNTvrjBXj4MyaStMincSo32B9JwgHj069/wK69fcyawRkz0I8v5g+W5V6NWNw34giYRxXjgg7egM8JWwvkMjWhzAfF3v8CBRWfs+3Xj0ZfzyQ2ZM8x4MNZjG9yFKJKv87sBUyxqvD4e+yLmsBWyH+ldrw2XHJ8hYndtzwEaNJpn69E01ydVoBd69v9aWhMSStbOZBN9TwGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzeIguqy8yuqlyQyN2D4rcqLL6aXaTtThX8Vlp6yhF4=;
 b=q2UcqxZjBBaKQsJj7dUFYtlXG8U/n6Q4l2Jk5ztWILB7ArWqoe0QhKXaJ6ydEfjElLA0ft+vagjkX+WYtUFNjZXD2Ds2KyGHtrgJYSv5mlQbMjNJoKuchydhSPx9EjD5tWmN0BJ4EHV6gfjIib2TYZLZNXLB0BORo9exjSWyKxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:47:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 06:47:44 +0000
Message-ID: <4fe03d79-d66e-d33a-b5c6-4010f8bdff40@amd.com>
Date: Thu, 29 Aug 2024 07:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Shen Lichuan
 <shenlichuan@vivo.com>, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240828100044.53870-1-shenlichuan@vivo.com>
 <6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
 <63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
 <20240828160132.5553cb1a@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240828160132.5553cb1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c95dcb-2088-48c5-d1e8-08dcc7f67c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlV4RXhyUVBHUkVxbExFSW9QeGNDMCtjcU1RVlU5QW1RUlhDZHFFVnRPQVBT?=
 =?utf-8?B?K0NzOGlSNFEwdGFZckRlOENlSUdwNXYxUGZVRjE2RWwxNWlJNDM0aXU5bUxz?=
 =?utf-8?B?Tk55M2ovWGRNS1pRbWI2RmxOdUhxUW83aVlYWFVjSm1NWnVuQVJPNkFGZjlE?=
 =?utf-8?B?eXd3TjlBK1EwV0xzYnJ5a3ZOZXRvNSttZUY2WDJMc2dCcUxycEJ3MGQ5amNU?=
 =?utf-8?B?bjRzRFVhUktCQXJ2M3dET0ZxRjNzTENiMkFxZTc5clZEUXhVNEtBeDlCYzVZ?=
 =?utf-8?B?YkwwNWdTb2FYZ2xScXJZbWZCbFlmTll3Nk9lT3RHcWsxbmdCSCt5T1FPR0Qy?=
 =?utf-8?B?bDQ3eCszTzdLbjRGa2N0REt0UERHSHJpbGRxYllNOXphQlVXK1pZclVyazJL?=
 =?utf-8?B?K3JFakJLUHF5QmFBcU1zNFNUZEM2TzhsaEIrYUxlNWlWUUJqbjROQ0FsYmRy?=
 =?utf-8?B?NHNQZW1Wd2o1bGxMaThDa2VSLzgyajFMWWg4NzVKTEQwTFdja0Ivek9zaGNv?=
 =?utf-8?B?amZvRnhtQktjZ3YyWU40K05seFM1UGNRTkpBaTYyeU5qYVR6NUtmT05ERGd3?=
 =?utf-8?B?TGdKT21JcmFLVlZuR3FOcUdEV1lvMWU5UzZ4QjJHRmpFTEsvTHlwVmxjRHEv?=
 =?utf-8?B?dkRZZnRKbUtNaVlHREdaV0FUZ1AwQitCenF2ZEdYbHJJOTJHTVk4d2dUUkJR?=
 =?utf-8?B?TXNYZENqbXZtUTU5cUlWVGNqK29DaFNWb3dQYWJKNEt3SWVEVzBySWlaK2Qw?=
 =?utf-8?B?eDdwb0cySkc2bVJtc3BTa1RRaFZLZXptV3Y5YXQwVU1Kek9MYUI3U1JRZXVa?=
 =?utf-8?B?aDNMSW42dlBvemNIM29Jb1pXNWtuOXJZclFrUFFGMlcrd0t6bHcydlplVzNY?=
 =?utf-8?B?Qkg1UkNTNFdtOGVSTGNKbmdXNXdPT1FmSUFHY0V4UC9TZmRxRFVnZFFkSHZN?=
 =?utf-8?B?RVdlcUo0Z2VVdHRlblpiWHpBMWQ1Q0FFZmlBRzBuZWt0MkFndmQ5aUpwc1ZW?=
 =?utf-8?B?T1pndVNnN2dicnk1bWhhRXFsUHN2K0V3OVYxdisvK1dXaEZsUk1iK3NLdWVI?=
 =?utf-8?B?eTVTS3VPaEVERjFUOHl3MnlHVUtlM003MTR1OTBWbTd1OGY3RUxHYlIzSXFK?=
 =?utf-8?B?SVE3RVBuTjNzRy9kR04zcmFVRVo3YnFYRVQ2cFlvazBKZTBuT2MvUUNUV240?=
 =?utf-8?B?NFJuZkFtNWZCdWUvajg1WTM5U3VjczFJL3lzcXpjcUJLMmp3UWNJR2dwS256?=
 =?utf-8?B?a01UemdXa0h5V1ZSUDlJMjFkelpJbFdjODBzZmVCSURRa1pyaWZpRUNCK3Bj?=
 =?utf-8?B?L3BMekU3cjR0VVNqMFpDQVRhV3BobjZYZEIzQjU2RWEyakdONTNJTGthM214?=
 =?utf-8?B?RTFYTkF1R0FIYjU2TFl2T1JENDNYZ09TTEtCU2ZUQTlSS09qaERFbjFjazdk?=
 =?utf-8?B?a1hqYkNLeWJHcXZJZkFYWkxCZDdPZXpCOUNkK2FNOUs3VjBFRmdsekFDTW9D?=
 =?utf-8?B?a1ZnY0MvSXJGcU1WZHNZZFA5TjI4OGN5ZWk3QlU4UEV6V1JtZ2FNU1V6M3N5?=
 =?utf-8?B?VUdsTjA1UmV2NjZZZGxvTmJQV0E5MFhGRHF3clhDSzZKT1poak9oWUF6ajZr?=
 =?utf-8?B?Zll3bmxIQzVGWFhQeDB4WlJrM0hyaUZodC90UDNLa1BiQkhDV2lHQnRLNFJa?=
 =?utf-8?B?T294eXl1S0xEUXd0MFFPSkw0MlhxN0xVWWZRS0NWdC9DcE8rbVNjRWJLUlV5?=
 =?utf-8?B?R1BPWnA4eXNTK2JMQmRhTmFHdDdSaEZ2RW5uMHZtaVZHMUVSR1VqZU5KeTJq?=
 =?utf-8?B?RkNYUTB5L3pBTmYzM3pMdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG9nVFFoemtZME9CMEhZTjRBWFFrN0ZwOGJlN09COGZZdmUzcWVwdXZxSnRz?=
 =?utf-8?B?YnhCS1RGcHhKdGhoMFlmYm5SOStVR2ZXbW9tUGVNRUJ5OGRoRXNYSWRuRDNK?=
 =?utf-8?B?QkZmbFk5c3l3SUNTakpyQzIxN3JCcWo3Y0RLNDVCT1BuL3Z6N3ZBYXRXYVlv?=
 =?utf-8?B?czVkbTFxSEJuZFRIMkZnbTdjMFNsVnVlUnNrdGNlQmhPVllGS0Z6Y0VOMnpZ?=
 =?utf-8?B?YTFSRFJBb1BzQ2VmQ1VYbFZuZVpKQWsyVzVxSXUxVy9waGduVUkxR2V3Ky9k?=
 =?utf-8?B?OEMvZExOdzdZdjZzNnF3WHJWK1pqd1R1VnFjNDhPRmdkbWFzQnlNWExiOVZl?=
 =?utf-8?B?Wk1tb1JJelA5a0VGZVkwd2E3UTNXMzF5RDk5NnNyZDN1SWtQSzRGL0F1Rzhi?=
 =?utf-8?B?OXRYcVZiN2FoZXJmS3djaTVCa3lKWXBrSlo2bjdQMkJMYnE1ZVAzNmJUd3RB?=
 =?utf-8?B?YUNPNEw2SjdOR1JBLzBDc1pPQjczTWJNa2t4UDd2clFIL2dVSjllZitnZU9h?=
 =?utf-8?B?TENrVGN1emlSSThZVkp4MzZ6c2lMYS9jVDA3S0R3bTdZeXdTSzBoWmtIQmpw?=
 =?utf-8?B?OEtKMEdFZ3RMeDFEMnMwMTZHVWRWT0F1Vk5QeWZ0Y1JjUzFGUW4wVnpSTWdM?=
 =?utf-8?B?MjZiOFFDcWhBWitDNjRUc2d0MDIvd3BjeWxBeFY2LzIydlNrZDJJck5ZODNG?=
 =?utf-8?B?a0REcUNrRDByTXdtUHJNRnhrRWFGZUFVVXVHUGJqVy9HOG04Y0lmQkhDdVFw?=
 =?utf-8?B?bm45dVpwWU80Rmw5Q2VqUUo2Mm1WdURpcTBlUVRCTzlnNlRLQkFjUUQ5Zm9q?=
 =?utf-8?B?Rk9NTmcxRUpZczdOamJyMHQxTlRmY0dlMVRSN1pjYmFhN3RtY1FjRERic1lI?=
 =?utf-8?B?cGxIS0M1NVIrN1VSbVR6cEV0SUFsalg4T2xBaDBxNHltVzN0TyttNEZ2VlFk?=
 =?utf-8?B?dzhCdzJNc3lJTm9GV3FYU3hDMWZCbllrRUh1QnkvbHN4S3V4OTZlMThOeFdT?=
 =?utf-8?B?cG9BN3M4a3VTRGxQSFE1Rm5wMUpZZlVFbTJSdm5NekgxMCt2OFZZT3Bha09Q?=
 =?utf-8?B?QW5Ld2FmcEE2endRdXRhdEJiSUk5K0FySkNTWU5VaUQ2RlBjYVVXeTl1Um9P?=
 =?utf-8?B?dktqUFpiUzZyQW5FTW9iR0V5WjdZQTU2bGVwUTNWLzVISmlBZEFZbG93V0ZO?=
 =?utf-8?B?aXgraVUzUVJVd0FhUFhOM0dHVFJXVUVrY3FUSGdxeDlpekZ0cFY3U25PRGFj?=
 =?utf-8?B?UzJ5a1VBYVFHZndTL0s3NFhsak4zZnErUmZlY1FMT3ZCWVI4TkxBTjl5ak0x?=
 =?utf-8?B?TzhDSUY4NFphQWJHZXNock9oaXJKVXhPTlBkTXZ1TllqamYwWGRMTmJBUU1i?=
 =?utf-8?B?aG1NcW83ZWNOamVKQUw4eTNzZEpXTW9WclhHNi9RSXM4YW5YQ3I4RC9IWVNM?=
 =?utf-8?B?ZDV1clh2TXZGRjI3Z0N1aUxBbWp4blFNeTJFY1FTVmdIc283dWNCUzl4SG0r?=
 =?utf-8?B?cnRyQ2xaL3AyM3ZENWRub0hkWkF4b0c1T0szYUhWSk5zRmpnL3Iyc2RaWW43?=
 =?utf-8?B?UTRQeVYwSkQ2N2hLMmNUeUxtcnpwUFdmU0lsQ05VSXdwbkpDWjM3eXljRGt0?=
 =?utf-8?B?NlJFcGxqR1ZVbnl5cTFiemY3SndzMExMYTA1c3VxKzR5SlljQXNzUFV1SSsv?=
 =?utf-8?B?aXdGRUpPb0FleXIyUzRzZWIwbXJrUHNVL3Q2L3g4SWFsTGZWR0Zpdkp4Ynh4?=
 =?utf-8?B?alREdHVSTHF2aUhMalNvWFpwaVNHeTVCbmU3ZVlPbEllaEVudFYyM0hLb1VX?=
 =?utf-8?B?aFZ0cnoyRzNmQzZRZUNlV2NSdkxoTEN0K2pUbGR0YlFWYzRESFZQa3V4YWUy?=
 =?utf-8?B?TUZYeVg4ZWUvYVgwSXN6N3EwbE1KZUk2VWx2aERYVzh3NUM0Q0U2KzB4UGJn?=
 =?utf-8?B?TmI1T1ByNEpFZkdGUzF4Tlc5QUY2Mjcvc0pqRmtVU2dxUWR1amtaejNWWFl0?=
 =?utf-8?B?MmVBaTUyZ2lJRzdyOGI2dExVZmV4cjk0cU1ac3plREhOTU1ETjZJZk9BRlFZ?=
 =?utf-8?B?ekk1L3R2WDN5QjFzTisxVkJmemVRN1JWN2VseGpUSUh2K2ZDT1VMa2lPTVpR?=
 =?utf-8?Q?xsm+0GpwHfnIshDA37uAlSpw6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c95dcb-2088-48c5-d1e8-08dcc7f67c58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:47:44.3934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykU75SKwFYaLkLodAr1jwM1cNH0ukDeVbN9B/dnRFSR2dxWNqJGhCSM6Wl+h1rDVw9Igi7Pbdfg1XNvjakMiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245


On 8/29/24 00:01, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 15:31:08 -0700 Jacob Keller wrote:
>> Somewhat unrelated but you could cleanup some of the confusion by using
>> __free(kfree) annotation from <linux/cleanup.h> to avoid needing to
>> manually free ctr in error paths, and just use return_ptr() return the
>> value at the end.
> Please don't send people towards __free(). In general, but especially as
> part of random cleanups.


Hi Kuba,


Could you explain why or point to a discussion about it?

Thanks


