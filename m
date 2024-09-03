Return-Path: <netdev+bounces-124637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31896A495
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23AF1F24B81
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1618D64F;
	Tue,  3 Sep 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gyK1HIx0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28318E762
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381307; cv=fail; b=ErYqmB7jPoLvewI3Nchz9iZm6drEfpu6vxUVRbPYVAJevm7/Lcym7AYB3XNPQFg+8B6jGTTuZJ0t+6dezYALAVSXK4SuKnyCY2p3jRZdOwZ2yvM1h6qkpfN8cYqESEjHWR6xHOZTbTlHvxGUXxtse6SQGyu92pB2Kb92UqO8Pk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381307; c=relaxed/simple;
	bh=rBbx2M/X1NCUeTeg688wo7j8tLtv7m+mWZG8ug61O0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxknL8ZGA9y5aNKGB55QMZ/gY+ZydPhslkzvSGCLRmgU2tcT4fCMyUktQ9phRBce2KMr/ACrqPjzJW0a11WbaJ5i9tXqVTqPkqa5unTpka1sWCnu60x7ZnyZju/K1kpxKj4ivnwF/950rOtxobzs7mezrLxielKnePrPhIYokEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gyK1HIx0; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/kq05IyADlRRKGDe/q2AIGYeYfMqN77hriG6FmkfLEAhQScB1niDOIi4czk3J2sOc/MmEaP8HU6OPpjCTRLYtJWMNjrfIb7yURC0HnDaX6zckwUKJzCIGAqxMMN4aw6RckSHJ2rTEMJ9cjKrpjBEffY6EvKNIOkUtiCjpAU/ChMwrvZdCM6nFWlXOMH/8sV6xnK/A74rAnMGG+XxvIymC26j8kjpOimCOV0E09vUakSIQ6tlpF4CULz/IOlpF6q25RlOolKEagpwegiCsIdtLuKH88NL4DObgh2w+uiCDsQ4nGVTxCxrwKXq13ufDKFTNgljb/lei5EBlKDkzNjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeLTohrf+B/rTPnxMIlXhlKfWXamMNfqsuI/NbeWT1c=;
 b=x4rRtOdrAxtnzUCADLxzzscyrcOo4XLGAr3+MgALI2Y1T9a50H+LmjW17qxou3pRrkI8uUxA1A7pz6DGi53rVw1TK8pOhfZwh5tPwwiMGDQTZLnDaU7jWwAbJN7xXVpGz3bJ5+J3MHenjlYR4ng3aq1qbGTf8Gg4sQ9qUqPZ5zgoHEvjsOwVZ+LDtvU1yT2HcWOsprlQyrDXQgKVuQ4aGa8FkzXRYDVpq3ycUuEOPSRrkKfbyGiWLGEd02M+MA/4pqutG0FG37SaV+4W4wLorFdKth9B395seCS8HaFY5p7qwhHOT3jPxRL24xBw/nCS2mHjz488mbBDAddIuLI6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeLTohrf+B/rTPnxMIlXhlKfWXamMNfqsuI/NbeWT1c=;
 b=gyK1HIx0qkCMv/lbct0RHqXT0HeC+/Bd9jzbVa20D6sm6NYChOiFgZ/+JTURJOe2gNeYJpbNpz/3EJWy/8068vGt8o6fAkkDuv6Nmfv1Nng6Tt8lJ7oKsbzH62IxZgd+55Vsu9bYTJy0vyyRahtT1E4jvwA83G1i7ypaKKZ4+RI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 16:35:03 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:35:03 +0000
Message-ID: <99666c4d-6d42-401d-bf66-1c46b11f479a@amd.com>
Date: Tue, 3 Sep 2024 09:35:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] pds_core: Remove redundant null pointer checks
To: Li Zetao <lizetao1@huawei.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20240903143343.2004652-1-lizetao1@huawei.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240903143343.2004652-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::15) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: a502deee-8121-46d1-da97-08dccc365c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFFWNVBDYVJUN08reVJYc3dPdHBJSXBOaW15VkdwdldsTVVVakRVK1FaU0V2?=
 =?utf-8?B?UHMxNXRDZ1VHblg0RUpWKzQyTHlNQ1loakU0WWtIMGhNUGRNTlZuQTZTWDZo?=
 =?utf-8?B?Lyt5TDJxbHRjbVBEY2dnYlczZlJ4eWxSZW9DTmo5anYxVm56VkxvUjhZMFYy?=
 =?utf-8?B?WGJnN3V3TW00R043M0NOSytWWnV6YTltby9rSlA3MytmNU01RWpEWTh2S0pP?=
 =?utf-8?B?eGRRanloMzB5Nlk3S1lWNzRiTDJpY1VUdmJyRkFpMGVUOUVXWldUSzJLeUxB?=
 =?utf-8?B?ZVZCMlptamZsNTM0eUFaY3NJbHQzay90dndHK0s0RlE2Ui8zN204ZVdxbDVN?=
 =?utf-8?B?dXI3ZVlOQnVLMGRXZ0VlVWw4MXFjQ3NJd21aSWthdWZ5dXV5THJac1FIVG9a?=
 =?utf-8?B?TDFrVE45S2pGakM0VHBrSzcwZXNkNHRHQWpIOGtpRmV4dlRQR1luVmVobzl4?=
 =?utf-8?B?aFhxSlhVcDVXSGxBOS9mRktOQ0tsM29leVBqeHBxd294emJ5TEVrU1lNc2xW?=
 =?utf-8?B?cW5JNlhGd3o5c0ZDNWVpRlMrNjlBMzVQcENJVy9zcGdhOHN1bWg5NmFFTDVo?=
 =?utf-8?B?c05NRUFtU2U4a1lMVnAyTXhHNXB5SDVIeXlBR0prV2pJWEcvU3c1TFVVVXlW?=
 =?utf-8?B?bUd2bkcxeTllaFFSUk0rN2FPbE1RNllXbGxDREtoeGhqT0tTdk9xWlRYRkth?=
 =?utf-8?B?VDJJOGhTR3JYSmVZKytLY2IybXlYZjVhalRKRGtDdjQvNndVWE9NUDVGcVNS?=
 =?utf-8?B?aWM4cGZKcWc3VmJJRnR2V0JjUW1CZUVhWjB1SHhVdUl5d3MxYldiMEh3YjYy?=
 =?utf-8?B?bitXUGxCODdMb1NXVi9GZG5oTXNLZGQyKzUxcVdQRDg4cnNtNDJ1M1VCdGpw?=
 =?utf-8?B?RE83STFIdFpCRlEvZjE1V1JpdWkwUzdOZStKS3Awc0c3L09rRkhxeFlnL3lQ?=
 =?utf-8?B?SXRrSTdoQ0dVemppUzlVUWl1eDdUc3htWC8ycmN5UHBPeTA4TndBeVBuakRi?=
 =?utf-8?B?UFgxOXY2alNkNnhPcHV6VThGcVdXNHQ3NEdYOC9kOGlhdnlIMDlOUkZZMWJU?=
 =?utf-8?B?NVBVRENERnJhQTRSenR1aFNlK0MxeThxa2dPK25hMi9DbCtsWWtRQVUrdmU2?=
 =?utf-8?B?bklOQ1I4TFpaTDErUVVrTzVEWU8vK0x6VFZLT2xVOFdKUUFEU0dsUXd1eUFF?=
 =?utf-8?B?VW1DWWhZMXc3UWQ3c2tmck1wa053NmhRNERXMWYweXBZcFR3UU5wNUxnNVR4?=
 =?utf-8?B?L0tGZXpjcFRDWDU5T25hVVVzWDJqN2lXRi9wVjlpRUpvTENTbUxrYkUwOVdn?=
 =?utf-8?B?Tk1McGZtVmM1UjJ5SE4xcUs0M2RnMWN0Uk5UK0NqbHNnall3N1B3OTJpQk1N?=
 =?utf-8?B?OVhVam1RSXVCUVhBcmNaaXZPSkx1eVNDZ3pFdnc3Z3ZDS2pkV0VaU3BDVkV5?=
 =?utf-8?B?TlFuTWtnRXZDNXl3RjZWV3Z3eUsySkhXZTdKemwvT2EyaGp4OFJtaWd6ZVF5?=
 =?utf-8?B?NTAreHBqWGxjdUYvUnFKREs2M3ZxMmpQdDFmU0NDaU5GOUF0bnNtV3FDaDg0?=
 =?utf-8?B?K3J1eTREbmp6eENpamVCMTRmbGd4amhtL2sySitMQ1ZKME9IMEg2YjZoQTdC?=
 =?utf-8?B?TzB2WXF5aHVucUtORXBHTGs0Q3MzeTJ0UHJ4cHl1b012c1FybkRDTFVOcjcx?=
 =?utf-8?B?UVNBcmFBR1NwVFI5RkUzSXZjMU1ibVBha3lPbkVvQWVGS2VaNzRWWWVjWEVR?=
 =?utf-8?B?K3VPK1JkTHBpYUl5blhXY3ZWYzExd0RwY3hPRGZxbjI3STRsYnRPbGJWaWhp?=
 =?utf-8?B?d2hjU1lOMmg4VHBINDMzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDFxZ2tObjBlWWlYL2svWTk4a2xKNTFrVDZRVlFJdHVidm5iSnhldm9IS3M0?=
 =?utf-8?B?ZnovS09vZnhzbFRTR2ordjUweG9ySWhpczB0cVhhbU9GS3pZMkZLcXpwY245?=
 =?utf-8?B?cFh5NUdQazhyRmk0YUdmaU1JOFB6anloWHRzQ2dnSzFQQk1sWlBwOXdZU2lN?=
 =?utf-8?B?Z1ZmUFdTYi9ZTU1Zd080b29KOEpFcmlEbHNJRys5U2xjMFhLaDdaQVNXbW0y?=
 =?utf-8?B?R3NtM3NoMXVBcUJRTUxTU21wa0lnQkViMXVVU0JZK3RlS3dkTlZBRXQvTS90?=
 =?utf-8?B?NzFGOGNwZE45bUpFejNSVitOR2tYcnhMWlhCUlQ2Q0VOSlBoTzZxK1hMRzJq?=
 =?utf-8?B?bkhzV1VHYmV5MnFoL1lxV0xxS3puRFd1RHlmdURRNTg5bW5TeFhTbkNmYW9Z?=
 =?utf-8?B?bGtmS0hWaVczekc2YkY5SFJNR2xabjRUWTlpbXpTVnFQZzhuQXhoaTJGdzdr?=
 =?utf-8?B?KzkycjdoS1pFQ0JZd1JGVzZoSzJMQlNod1ZmZXlnRWJqdEcxaXJpM000V3hD?=
 =?utf-8?B?RHdjMWlUYTJ1UWtWbFBmSEhNTHlKeGt5YmRicnlzeko2dnp6R0tPdElRVWpl?=
 =?utf-8?B?aGJGd3VDM1RiVEZkT0NwTWVrQ1FhcDRMS3VUT2xzYWpUbHh2NzVHbmpzN1Ex?=
 =?utf-8?B?RGZ0b1RDSGp2b0M2Rk9HZzQ5ME5aVVNiNlZoSnF4L2tlRFhMVWtTRlMyY1g4?=
 =?utf-8?B?UmVCMy92dTJ4U09XNjc1T0dDbkc3bWhoK3Y0aUd4eFN6M3dySXdGTWJvVXVS?=
 =?utf-8?B?U3VpWXo1dDFGRFEyYTgxZ3pHVEZQb1F5S3hxQ2ZrcVQyRzU1ZEZhTlY0enhX?=
 =?utf-8?B?cnNLMGRZaHBDY1lDbUM0VVBWMXVjQXZHYnBNYVc5UnY1ZTlhU1hYSE9uUEtB?=
 =?utf-8?B?UUFTL0tQNHpTSGRLcS9TMjVvZ3VIN0JPSkxiekdLZ1g2NTFFeDNFSU1KYXhM?=
 =?utf-8?B?NHdZUW1NUHFERlBVYXZ5c2Vma1hjRXBnck1aWjhuRnoyNExkYkRyYlptbkRJ?=
 =?utf-8?B?bU1vVERYMmJVWnovWEM1UmZyRHVtQ1pDSjZwS3F2NkRFY29GRTNYOUhtY0R4?=
 =?utf-8?B?WkJwUmVkUTZWaXZHeDV1d3Bqd05BQlFvMEpYV2ZqU016ek9NMkpSb0xlTkM4?=
 =?utf-8?B?MnFGczNUS1htZ2lwYk9SeGxzNTFnYUhDdzZhbzV5aFRNREV5Mnh2allSSVVK?=
 =?utf-8?B?TGJacG53bVBZbWhJbGxOUjgzVk8xRzBQeHhlNWpvWk56a3NoVFdzM0pUc2l3?=
 =?utf-8?B?SE1Xelhvd0hNS2h6N2l5bnNGNUFwbEhIcnZLUDJBQit2OUtWT2RvQkRValQ2?=
 =?utf-8?B?RjR6U1RYdmJjYkQzSDk5WmJ2SnZPZ1dYQ2FCL2NJalBOSXZQSEdJM2taeElP?=
 =?utf-8?B?WDA2UEhvcUl1S2FhMlpDK0IzRy9lNWlJV2R2TjR3cGxPTWQ1L3VZWkR1bjFO?=
 =?utf-8?B?RVdBQmx0QWdqTGVwY1kxdHhGNXA2L1dLRUtwYWpwazBJQVN4SzZleEdMVlU1?=
 =?utf-8?B?TW1pQ3h4d0cwNy9aS3BGYktFa08zQ2tLemdFaWNXSmk0eW9ZcFdnOXhEMCtK?=
 =?utf-8?B?TnI4VW5Dd1JUTEZsQ215M3hqZGxJaWlxRDV2aUxCaDlXMHF4Qy9YVHo2clIz?=
 =?utf-8?B?K3FRN2dWVG41WSs0VWkvNVArdmEySTNwU1JxUVk4VkV5b1YvSGlzNkE4c2dx?=
 =?utf-8?B?Rlg3U203c1ZlSG5SUUhCY0JXdUE1QU53bStVOWpUSjBFMVllNDUyQnN4YStB?=
 =?utf-8?B?dml0R1dnSDV2S2pITkV5UDJWRHdvSStkenF4N2JDZGI5dlRmTWdJTk1TelJz?=
 =?utf-8?B?NzZuTC9WL0FINy9MYURzUW9UeHY2MlFwZGorU05ETi9qODhZeEVmd0ZZZmtX?=
 =?utf-8?B?Mys0Uk5FTVcvRXEzbWJCbW44dzdoeFhLNUowaEdxTVdUTERqNVhoOUxUZ2xV?=
 =?utf-8?B?Yk1YWWcyNS85cWxuOG12L3BSUEFvT2VHR2xaaG9tSUxEOHZtRlhLbE54VE00?=
 =?utf-8?B?S2dKUjUxNXQxbkIxUDVBdHB6NktVTjJnT2RiVjhjTjFuU3kxZnJOYWJIcEsw?=
 =?utf-8?B?bk40eGdha3VPeGUvS0F6Q0lDdDkxd0kwUGcrSml6T05TcmFRV01RZ1NnNThD?=
 =?utf-8?Q?w8EsRSvnCCJdBNV1rf0LNHOVN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a502deee-8121-46d1-da97-08dccc365c46
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:35:02.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01qTVcS6E1D0k4sO03Pyl4NintwcqjOSq7IirxGVdAi/Ksz9+dmSbW8G8kX1oRy/NeM1s4vKRYwISrz8CeD81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450



On 9/3/2024 7:33 AM, Li Zetao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/net/ethernet/amd/pds_core/debugfs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
> index 6bdd02b7aa6d..ac37a4e738ae 100644
> --- a/drivers/net/ethernet/amd/pds_core/debugfs.c
> +++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
> @@ -112,7 +112,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>          struct pdsc_cq *cq = &qcq->cq;
> 
>          qcq_dentry = debugfs_create_dir(q->name, pdsc->dentry);
> -       if (IS_ERR_OR_NULL(qcq_dentry))
> +       if (IS_ERR(qcq_dentry))
>                  return;
>          qcq->dentry = qcq_dentry;
> 
> @@ -123,7 +123,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>          debugfs_create_x32("accum_work", 0400, qcq_dentry, &qcq->accum_work);
> 
>          q_dentry = debugfs_create_dir("q", qcq->dentry);
> -       if (IS_ERR_OR_NULL(q_dentry))
> +       if (IS_ERR(q_dentry))
>                  return;
> 
>          debugfs_create_u32("index", 0400, q_dentry, &q->index);
> @@ -135,7 +135,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>          debugfs_create_u16("head", 0400, q_dentry, &q->head_idx);
> 
>          cq_dentry = debugfs_create_dir("cq", qcq->dentry);
> -       if (IS_ERR_OR_NULL(cq_dentry))
> +       if (IS_ERR(cq_dentry))
>                  return;
> 
>          debugfs_create_x64("base_pa", 0400, cq_dentry, &cq->base_pa);
> @@ -148,7 +148,7 @@ void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
>                  struct pdsc_intr_info *intr = &pdsc->intr_info[qcq->intx];
> 
>                  intr_dentry = debugfs_create_dir("intr", qcq->dentry);
> -               if (IS_ERR_OR_NULL(intr_dentry))
> +               if (IS_ERR(intr_dentry))
>                          return;
> 

For the patch contents this LGTM.

However, the patch subject prefix should be "net-next".

Thanks,

Brett

>                  debugfs_create_u32("index", 0400, intr_dentry, &intr->index);
> --
> 2.34.1
> 

