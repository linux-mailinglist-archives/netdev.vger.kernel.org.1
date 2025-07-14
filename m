Return-Path: <netdev+bounces-206701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19EB0420C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E14818920F4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC7257440;
	Mon, 14 Jul 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="to7rYd2Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC7246773
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504208; cv=fail; b=XN6QuBk30LxlMQegX3lZL0OrnY0Ejz8Qs5xCvCsPeLu6he2bi5lkefLabe+RZtfqrrvSnwdgF4bdtdq9pchN2jd/5UzH8WdHOdFH1dvGh6NETLkt26NSrHQZzNmulLGuXpXIdYhT7aq8wlqHIVD1criJ6h8yvVOI7AHZTAmgC9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504208; c=relaxed/simple;
	bh=rGj0qgW/HJOWZEin2wePepBCY+wO61YVuVIl4XeVXAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnwVUhbG/nE1pL/ofqNV/Yucz9wfLmFh0ykpD1E/Zu9JXJsw4g8vBfApztSca0K5e+GVgWEb2ma6CAWRC41Ac4aryYUOGX391dn3kAAx/TkGu0rPnbT1NtmFUq3Isq3EsTLi7wumAdN8rhfE1CQdciJVd4907xUIZd19yvIIxAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=to7rYd2Q; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu7e19i7do5GhaN1p4YmYDKiP2yCGDM+04EYJb/6UAM+BZaoZGP63wlHQhDMcCzdtGHG0Hl91w8nbbeKCrchPiIEClW9MhzLBt9XpL0PtWj0xGnMkyXcugEAlqb2yvm/Em3QW/87GwGLXl9Sa3sgrpU1ubjWj8cFLUdP353SyAB5CRHs25BQGD/XxOWakh9ZV4TLSaiWp6TzBr1+d+5xHi9XHAoXCagtYZIn9kYGq7SyPIeL6KGoqxoDy4fk3MoS50tLZoL9Uv1ipXdoxiuLq6FE3RBuUXzdzjXoNhwNk9wTFNGEQLd1/jB8559Dulo1NCdgb04JeJ01O4Xqunaoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAiBNkmYrj8xE0b6C80bbp5N5H+q20XfokOsHG1cmrE=;
 b=GK07ZZLj+kcdtvdcUVsJhrei92ohaMD0/y4Jjf9b8cE095+EOXex2oncJf/yliKt+UyuqNa8BWicCDJkqiRYm/8EXNnwx/dpBIs8ZOl6Al+vPQyjXGPKOzJ/nyM1JoBi8MB0wz8pLx6FzWKnkN1axREfZMUN/5tsb4qqyKdLqD+fOWtBcseCW8ydyB4dyERLoxgzeLYDVic7Z1RBIGOWtBRvgE9X1JCSgIICfP2wwuNjcO68LWONuoP5CxmzJ3fWdvCJjPi/t2vPMlZMmr5psr6Qh0YaaGFRMHZavDa1bMNNafG7XRG14f3qD5zWhfzUb687Bwf+EENrDkkTDJBhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAiBNkmYrj8xE0b6C80bbp5N5H+q20XfokOsHG1cmrE=;
 b=to7rYd2Qc84OJUlkutp7UAdWjYzaeErwIyXqhPp3pFKFja4/hkyEf96GwhDSe+K18zrsn4OSJK4shFeY1O8IlBu4RqVzv9zO/SWUtuvOjm4EgyQRASWmHniccH4p1N7m4nkdce+lnYwW5X4a33k81aqrfmCQTSMJUAIPhZ/VXGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Mon, 14 Jul
 2025 14:43:24 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:43:24 +0000
Message-ID: <6a246480-8e0c-4285-a3f1-4f13704d0193@amd.com>
Date: Mon, 14 Jul 2025 20:13:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] amd-xgbe: add hardware PTP timestamping
 support
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com
References: <20250714065811.464645-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20250714065811.464645-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abc00ce-8581-487e-c0c5-08ddc2e4c8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0VMZHMyeXJrMytNWjE4RzhVRWJTdDBjMnVIdkNIWmJSNlpxUm54d01MaU9N?=
 =?utf-8?B?dUFWMnpJT3JiMzVSRGhjdkN5azE1N2xRR0FWRzNuQWRIT01hZWFYb2JOek5I?=
 =?utf-8?B?MEwyYks2NGxiRk11ZERKckRTYnoyd3RiN21NZXZEbXlMYUw5RDBnSUV5aGNr?=
 =?utf-8?B?QkdkWEY3L01SeFRvcHdhWnNNUENhWGtBUm9EeXFIU1NrOEtuWWJDMUU3ZDdE?=
 =?utf-8?B?alozUU94QnR1alAwY0hsMDg4TUVIYm9ZNGJSbW1DdS9RSE5RQ0g4MEpieWFi?=
 =?utf-8?B?ZXdFdDh6cDJSWjFmakhadUdWRW5veVpEVUFOU3A4ZU1TZkp0d3F3b3NvZjRh?=
 =?utf-8?B?RTUxUXRKb0pqeGg3M2NnYlZKMGhmSE9xRDd3NEhqVEoxVUdTK2JFNE5GMngv?=
 =?utf-8?B?NGRHNUVWSVMyWWlJUGQvOXpsMnFNaUtNSkhNMUc4QUgxalNUMTAvaXgzRzNX?=
 =?utf-8?B?aThuUFNIZkU2UklaNjYzQ3lFby9ORmw1eUxyRmlOK0g3QVhMM0F5Q25UMldM?=
 =?utf-8?B?TWtta3Rvc3BYWlBiUU5GSWZiQi9uNWZOSXFJYnBtR0ViaG04VGFuNk1QeElS?=
 =?utf-8?B?VEl4S3ZwZWhSMkpGaDBBT0wrQ09zY0tnZTFzODJBUHV3TERkWHhQQ2NFcGRt?=
 =?utf-8?B?eENkRDY2V2ppVGkraWx2aW56eHg1SUJKemtlbFY3clVieUFqS0JRY0o5eUd4?=
 =?utf-8?B?dEw2Y0Y5cjE1am43YUt5ZkdNcUhWL1l2Q0pLT25NVkhha1lVWGNRS3paUGI2?=
 =?utf-8?B?WDBIY0M3WGh4OS9KOGd5V1gvOEp3M09FMTRSOU9acGtKemJPQURLb044dXBn?=
 =?utf-8?B?c3dHQVFqZXliM0dYbmxtZ2ZBc3V1alJOeGptNGZ4enZ0VlNBTll4RzFkNUM5?=
 =?utf-8?B?TXpqSGEzeFQ2eTFITy8zN3k5U2w5bDRrSHZ5WXFDV0tVZ1krYkwrV09YR1Bz?=
 =?utf-8?B?b0E4QUh0NGVUMENYMWVlR2JZZHZwWTRsbWNpcjdHVWVzVDR1YTQxd0haSWRH?=
 =?utf-8?B?SUJCdkp5WnlieGhMSEYzRy9VVzduSkxuSjROdjFFYjdPcFZHdFhjKzlLSmlY?=
 =?utf-8?B?SElHNGxBTU8yUXJMSTBMcDRaem1maWM1cndWMEZCV3d5anAxRmQ5Zk9ac3li?=
 =?utf-8?B?aERocFRVZmFPR0VkZ09HbFlVSDhkUXpvcVNEY0xiWER6UW9jWXVqeGY1YStJ?=
 =?utf-8?B?R21NZzBxb0tJOHdzSzc5N3p1R1k3L2VMU25PVlZ4OW8zTXF1QUFPK2FIbnUw?=
 =?utf-8?B?QmdwMjZSL3FZQkoyaE1jTE9IZm9Qbk5TSWxXYWw0T1VsSGV3WmN1S3NoMDhT?=
 =?utf-8?B?RzZkb0ZpT2dqVHRCckhwQzZqQ3VUZVJLVXVwZVNEQjNobGhSRWlaa0MvVldV?=
 =?utf-8?B?WHN4S0xRbENTYkVGU1F6aWRkb2k3YUFrbDRkbnNZa0V0Tldtc1g4djZIcmVN?=
 =?utf-8?B?Sm5WbXQwcmRyc0RsRFpkM1pFa2pIbEJVUFRMa2h1SUYram5KZ1NINHcvaXFM?=
 =?utf-8?B?TDhzendIV1BJQWFxZVh6bENzY2ZVdXJ0d3pEbjhtc1ZSV0RmVDV3aWRFVzdV?=
 =?utf-8?B?SnVIY3N3M1ZLVlNLK2NLTXgydWN5RCtIYWNoR1Y5TGhmQ0JxUVgwNHVCZkNY?=
 =?utf-8?B?cmRIcEsvSDJRYkZ2TDRoclJ1c3lCaWlpL1JGS3dMNER3SHY0dnJ4SXZoSFEv?=
 =?utf-8?B?Z1RxWkVvenZwbXpUMWNWOWRHVnFCb1JXVTVsUVVrWm9vdWQzK2Z1RE45MnBl?=
 =?utf-8?B?bUl4V1hZdzlXdUNkSnh3cVhqVjFvUFNManp3ZzRkMm0rUHk5bG5kcjZUZzVO?=
 =?utf-8?B?TkhqM0ZIbTdrUERtT3BkSXZRODM2Q2hTWGJZWkNiQzVzTHVIT0NzSzNMTlow?=
 =?utf-8?B?ai9qR3hLSEZ0RktPNFFWaEVWTEI5R1NBTVd1dHhsSjdzMkNaUkRXMTMxcmxm?=
 =?utf-8?Q?8BD3vTW4+4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU5xYmNMU2tCTFJjcVNRTUZabFUyRGlPOVdNeHVpT2dBbjh3UnlYcm82dlhD?=
 =?utf-8?B?TmdLMCtmdUk1dWc3b05tMjBRdnZycmtYd2QvTWJYenpkbCtxTHhUV3djYVlT?=
 =?utf-8?B?b2N4b0JGbXM0cWJWdlFsVWUvV0JrVUFLOGxnSEVIaUExaGhWL2RMeVBsYU9C?=
 =?utf-8?B?K2NKbytmMk1iaFI2Q0xLWTA4eU5MT2lkWGdHeTdnNExZVkVGb1MvSGZMZTJJ?=
 =?utf-8?B?VEpibGgwaWpnNWVPTGFPRFQyWkU3TTVBbDFDSjU3L0FIb3l1c2QweGFrVnVr?=
 =?utf-8?B?UUM0OEltMnV1NE5RN3VDRTJ0Q0xidHNGejJtOHN2OVh1cFRqL0F0VW9mZkov?=
 =?utf-8?B?ZHZGSng0cFhhcG4raFFlaDBhbjdYblBBWmk0VHJHQm10ZHcrSFkrLzJSY2ZW?=
 =?utf-8?B?VE1wcGVITXRCQUxJZStVNzNkQ1UzdkttVUlEVGE3cnh5R2dBK2x2UnBRbXlM?=
 =?utf-8?B?bDd5Zyt4ZlFEdHZNL2VGVkxYYm9xQjZuQ0dGaVREcm1pZW10T0k1cytCdy9C?=
 =?utf-8?B?NXE2UmdHS0NhTkJVVlI1WHFBdVdJUndZdEMzdjB0c2kwRnBscU95bUxhdUhB?=
 =?utf-8?B?YkkyWkpwZFQyNmh3K1RHcE5zdWlKYkdhQ3VnM20waFgrU00xSWlENi9oT29m?=
 =?utf-8?B?MUh5c1ZqemcxQ1RnSFFiOWdqQ3NaMmVwS2NVR1pWZ1NHSTBhek1XcDNpRnhu?=
 =?utf-8?B?TE4wTmdDOTVjczN1U3NCU3hNUlp5WFEyTmxmb3c4b2xxSjdoR3BFK1VrMC9T?=
 =?utf-8?B?VllUYW1wR3NQV0RidE1BaHlYMzh6cTRteDd5QWlOV3hvNVduUnVjUVIxbUlq?=
 =?utf-8?B?RFFWVDJEa1cxKy8zcGlKeXZIS2pOczFUYldSZ1ZuNnl6eC84Tnp1bFBlL1Z0?=
 =?utf-8?B?SkpGanh0cEVRVjBlaGNoK3c1N0MvQnhmUW50U1NEblJ2UitRK09KbTRMeEMx?=
 =?utf-8?B?N1pSY2VCV3ZXQkVTY1dVVEFYQ0RuaitVNkg1cldNZWZQd1ZUcU90a0Z6VjN0?=
 =?utf-8?B?QVJ1ajVQN1NnS2R0YzVMZDgrUFZhWWNwcU00SjUvRE9DdVFZRWswUkNWdjA2?=
 =?utf-8?B?aHpJcGxjbFBTb2VaRjZ3K2gwbTJLdHZJdDVOd29uMG5xdmtsZkF1dHkrTkhG?=
 =?utf-8?B?SXJZTXQya2EvamIxRmFhZlc0S0lkZ2cvS1orZDBELzB2UVlTUmFwbXFpSUZN?=
 =?utf-8?B?TkwzeVRQUm13d01sNkxVaXpzWEhzVEYvZU5XZXhZeDJmS0hHT1RQYkFIcExp?=
 =?utf-8?B?NlBHTm42by9LTEtwUnV2WnhVKzU2ZEo2allCTjlKYnNwV0l5NWtwK2d2K3lh?=
 =?utf-8?B?dDJLcGN1T0lRSlJqZDZLUWZ4ZG9ZSXc3b3Z0Tzdpd2ZvYjhkSDA5SG5ubW1v?=
 =?utf-8?B?dE1vaXkxTm5sS0dFTWNmdlAyb0NhM21SVzBsRGdRSHo3RHhmOWVRSkdVQjZ5?=
 =?utf-8?B?UjZCMzYxK2RaM0xQZzh3VWQ5VHNnU0FZNkEvYm5teDFNZ3FZcGxwOTlyVWRu?=
 =?utf-8?B?VzJsOHg2dzAycUZ2MUF0NTZoYmlNNi9aN2Y1Q0pkd2dvVTZCbWlUMno5Umhz?=
 =?utf-8?B?R052RStITVJONHNtaUtveWM3OUF0NEVrdW55Wnp3WnQxeU1hcVpISFhjUnRF?=
 =?utf-8?B?QUZtVExHS1FRMnQ0aDZ6YTkvYlErZENwYWNVTTlBQ3A4VmlSSTQ1OVl5UFpo?=
 =?utf-8?B?blc4ekFja1Yxd3kydHFteHYwNThBTDVkM3VHL0YwSEl1ekpXOXFEV2k0d21Y?=
 =?utf-8?B?RXlucWZlZVdlQzV5WGdkMENDOE1sd1RNTkJYaE9ZbUZ2Y2ZtNGhvck9NcVFO?=
 =?utf-8?B?TGwzOTZiOHc5d3Bqd3RhWmZ5cjZXMXJLdjF6MmtuQVFQYU5SVy9OWFdmYWkx?=
 =?utf-8?B?aFBVcXRHbXNMaVVCYXNDT21IaTBqTTRJRlNkb0krZElnbS9hQlZoVjZXVlIz?=
 =?utf-8?B?N3hlK2NlQ1RBNXlYdWJaZ0FNTXF4alRrejk3MFdhcENuR1VHWG4zNHdWNWJz?=
 =?utf-8?B?QjczVzgzZWpFNTU0Z2ZLckZSTll2c0p5Yzd6bWEwcU82Qk1sZCsrczBmNDdp?=
 =?utf-8?B?WXlPOEFyTHlMd240L2dEQTVuQi8rcEVJTk5QcDF1OUkvWDRzYVo2R2JJRGo1?=
 =?utf-8?Q?w80PnYcAwFtW2Y8QafK1VkXR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abc00ce-8581-487e-c0c5-08ddc2e4c8e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:43:24.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPLzHXEYGAIRIUaepZc0QEcgM/NrWUqOAEwOluztnKJPlAg8XAU488wksCt9kzmib5XQs6S/ZOm2zDRWaEJJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984



On 7/14/2025 12:28, Raju Rangoju wrote:
> Adds complete support for hardware-based PTP (IEEE 1588)
> timestamping to the AMD XGBE driver.
> 
> - Initialize and configure the MAC PTP registers based on link
>   speed and reference clock.
> - Support both 50MHz and 125MHz PTP reference clocks.
> - Update the driver interface and version data to support PTP
>   clock frequency selection.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

