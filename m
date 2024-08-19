Return-Path: <netdev+bounces-119679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33095691F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42F12834FA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AC1607B0;
	Mon, 19 Aug 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GNgKa3YD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3132165F0C;
	Mon, 19 Aug 2024 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066081; cv=fail; b=VjpNDz6s+e/cLgNXw7hChnl4t2ejoMtTbQXGF2OeGSl6ZcODB1f5xbSD2+iNYn5u5fFsOueKhcK5WJ272P4s2i0YEv50rYAY074Op9aMUde8uib7pzsVXNCbIvfuBWbM30YfNpV6a4YRlnojzoPsqSolZtISuJsqR6MG8oeH5eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066081; c=relaxed/simple;
	bh=yFd3VrDUK4awUn6Y+HWDeIZA1QBmQcVd5HzBDwuHYjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1EQ0kaiZa5rZbRm45JfUqDNbVYHfPUTK3FiZ3cFIns92ljJQUaBI+WfiyizlkTdTzjY0aaFEeisgttE7/uwB14h5g6IndewqYi3dGqpX28/7DBRN/Gd4ZZ25lhGat9395j66ouC7gwQvMVKlUQfr74DzOrFbecoXiM/lEa2ZYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GNgKa3YD; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkdqRbr4okUIJDq4HDtcorgEiQIALD++GaBa2jmgCxdtUgCu8lJddzrtj9G5GczzslOR6jgaAVCDxIl0kGIRvUxEbcml1BPROfZJ44jP7RmZlz7G70l0T/kWJ0JGKQ5QjzNmGe4UtE3p56ztUVNJpV5mymRCX8i1qw/DDTg9L8mXWi3vk+qP8OmMse/Oh0Pncc+RC1+fmImbkVid6Q9uKcrrKYDOF3soGDuIzRdlUPifAI89c7kpNK0wacrUWb1F7RRYGsJu6iyKyIsOCM5+bEiX7tFSA9GMVRairafim2lp4fIekwCm2qMzp/dLi3v/lJ+Vzdta4TAfN4qCgGsF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMyZigh+SK2TpbCTmxI06zAnyy9PXPv4ems6WPLVe2c=;
 b=IgumzbYzS+HXRHPmhaRXL9J/TW1eUXkNOH4U/2aeLVGEWp0PkG+mzL/dCty0Mf8eO3+t1ZUf/4vhTFUSo+BmYyvMTsXflhvEepH34PMwmK5VeAFFHLDfOb5jSGyVMlyCTNU/265A3w06l2aRN/+LsJ/oC/xOw9r9CVisbZAvGmIG1xvSXpTNi0wiKpqpFSZLUFUtwrB68RYVLaPNH9P7xW/AE/NgSPxYbVtFDQHGe9COefvgetZkNLiWKbnL1ozPQmE//IfctOKgdSUs5WDFk8Gk/UtabtZe4+4UzIIqI89Lc50j+/jMewjbjLZSCJf1wZUatUw9Ye7hUhZKGikI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMyZigh+SK2TpbCTmxI06zAnyy9PXPv4ems6WPLVe2c=;
 b=GNgKa3YDoZHG1fwYumCko53UvxYpMkxIObiJ3Xf8YS1RZhTiQt/lLE8n3iJcjKgJfyxSafjm4igyHJ8BZHkch4lprsoTTjr458x2eh9zp/jJ++9KJT+oXy7a4zk3pPQ9Jm5lOLabUvLmwMn4uuqOYSMKVMire4d7eTSQ3ky4CcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:14:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:14:36 +0000
Message-ID: <7fba32da-09b7-e9d8-c859-b01f073d127e@amd.com>
Date: Mon, 19 Aug 2024 12:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com,
 targupta@nvidia.com, zhiwang@kernel.org
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240809113428.00003f58.zhiw@nvidia.com>
 <8498f6bd-7ad0-5f24-826c-50956f4d9769@amd.com>
 <20240817232657.00005266.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240817232657.00005266.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d7a5c0-2521-440d-a0a1-08dcc0401c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGgxcWp4TDNEOVFyTUZQeDE3bHhGaG5vRTBjOHRxUndYVC9BUTBkQ3VNZEIy?=
 =?utf-8?B?NGs3WDl4R0J2RmFIUVZSZEdwZThkbkpFMkRuckpzNkFla2xncUFidzNSV2sr?=
 =?utf-8?B?Y09MQmxVWmZId0FZR3g5Z2FlOFFoR3hsNy9NVzNHL3Z4OW5FT2lXaitEaG1S?=
 =?utf-8?B?ZzBzNVRUMElrZU83UlJtRUFxZUxNaU5YWmFhT2tjbzIzZXZKMGQrT0owMjZS?=
 =?utf-8?B?TWhsaDd4ekNxNkRkL3hLLzZLMG5zNXN0aFR5cm1ZeDhiMERHbWN0WU4zK3Zv?=
 =?utf-8?B?ZjlHbUt5dG5lcmxMeFViaGsvb0VnVnNJSTlzR0d4NW5MZmFoTFp1eHp4TVdL?=
 =?utf-8?B?dytMTFloV1BRQzAwRmJibHpQOTZKT2hudFhkc05qZkZHZTRteU9xeFV0cGJj?=
 =?utf-8?B?b2RMS0FWVVJlZmRoUmkyY2tIUk1oQU92WE1xWmpKTWdjbUZQMWFQejF3Q2Z1?=
 =?utf-8?B?YSt1K1lBR2l0M1RlR3ZyRVJqck1sT3BNOXV6ekRESUFnWmQ5QzNuY1BiazJi?=
 =?utf-8?B?MnRWK3k2UHVLZHN6a1JUbmJ3Z1hjVUJlVHhHK05FS242Rlp1VTg4VGdhV2M1?=
 =?utf-8?B?V05GRm1TS3RkeVJOZkt0eWZXSFJ3N0VtVWNqVXNTV2pDK3JiVjJuL2cvaGNV?=
 =?utf-8?B?RUsvcTlrQWRrbXRpa0ZjRkNHNVh0YWtkYjY2N1lhSk02MGJBUkRVZDI3cHBG?=
 =?utf-8?B?YWlRem5XdUtEQ0xMeXdXR25LNnpMSXpIZWpQcXVGWW1aQmlCOWF5VlpiWnpm?=
 =?utf-8?B?ME9aTi9tM1V0UG0xVW9LSno5bXVhc0FKbzNXU0RGcWxxdVl4V3lZRFFOYWJh?=
 =?utf-8?B?dzFuOGlMQU13eXBndDdhSFZVNEZkdXFaak04bGJwSXBFYU4ySndNaWVVeGV5?=
 =?utf-8?B?b2dJK1RnYkNQRm5SRFJxTGdrcEdVOG55T3lPRThHTUYwUGp3TmFKWUF5dnI3?=
 =?utf-8?B?STNPOWlOMGszMkpXa204RytRR2NLTE1xanNFNEJxVmtoZm85K1Q0VnpXWHBX?=
 =?utf-8?B?bG9ad2laRHRlVGdNT1RtWXRiaXdvMFhaQkVua3lXek5Hdm44eHNiekEvL1FE?=
 =?utf-8?B?QXg5NFdSTjNwOGp3RXVRaDFObmtqRkFhcmYwN1JNTVI0MXE1bVQvZ1FwTGVo?=
 =?utf-8?B?Z1R3T2tuS0ZSRTNTSmxtb0ZTemhLOWs5K0J6VDM1endsUDNCU0R3L0c2WWkx?=
 =?utf-8?B?L1NwYlJ2YVJqNWZZNGkwVzdrYldSQWpBV3BSL3pudUt5bXVCS3JXZHZJbHhW?=
 =?utf-8?B?WHU0eDA3ZGFuSW1mL29iU1p5blRyT0ZDSXExMkZyelR4MzZyNjcySVdmcG0v?=
 =?utf-8?B?ZUh2N2phZ1h2ZWI0KzVISGg1K2c5MW44M3pGZU5zZGhoN0gxUHJKK3VONTRp?=
 =?utf-8?B?bGxjVU9QT3ZJMHkwZmxOUFZ3ZGlqWStkdjFxQmNna1NYWDJoNzVOV1Z6bDND?=
 =?utf-8?B?eXFTNmU2QzRBVTRYYVk2SnpEc2NtbEpVL3M1VnpFWWl5bWVFTVlBaWdLcFg5?=
 =?utf-8?B?dmdtTEljMjJQbno4eHdWdDdOeG1pWXV0cktRTkxvTlBzM2hRbzVHMzA0QlNE?=
 =?utf-8?B?QnhFbXR4NWlOaHh2OTZRak9PVFpibjRoNHA0MWdDTlM3YmxMMGs5cGR1OGo1?=
 =?utf-8?B?T01wcTBVRGZ4N0poY05pclVBWnE4V1FubDhjVGVoUzBZRi9PcWpmRS9VbW9n?=
 =?utf-8?B?bDZ5VUhobmpmbnJXSXM3bVI3RFhRMzRHd0tVVDgxSjlWUFJpbXlIS2RLUTJu?=
 =?utf-8?Q?plf7rTBeGfAqMnljvs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdLcW9QQy9zVUhPTUEzUmc1cWZ5aHhQQ3NxOVhkVjhwVWRFNHptSHp1L0lo?=
 =?utf-8?B?SmlqMzZTRG9teEE0Qzcrd2NoTmNoQ2tFSkFMRStpb0dKQ2oxWjRQMGNaMmxo?=
 =?utf-8?B?VlFiWlRvWGxKVkR4MnJsanpuazdxMlI2TDVqSk12Mm5YUFhTc3ZZQmxFT1Ro?=
 =?utf-8?B?Wkh4Z1Vxb1I5VHhGcllxcVVkS2lVVTBkc0RXZ0VHaXpSdGN1bWRtTFZZUUta?=
 =?utf-8?B?Y0ZyTDNjN1pKdTBnQXVnNFR2Q3liRUtmR1VKYTFhSWVqSW9SM2NEU3kyV2ph?=
 =?utf-8?B?czROSEJNc2RCM01FdEFCOFBpY0l2UmdXajIvZ3MzRW5FQ0NTQzFYSXlPT3ZK?=
 =?utf-8?B?R3I5WnB6bDlUSEVmLzdObnFJaTJ6UHgxSUJmRFIraTViZzBqaDNjQmc5aFla?=
 =?utf-8?B?V09zSld5VU1JOEVjd1N6VjU5T000UTJpTXRUSi9wb0FvOTJqNTBJU3I2R3Zz?=
 =?utf-8?B?ZUUrOEtQNlRoNWFMVDAyblhnb2VvRzdtVFJVVStZWDZyZWpLdjg4RFRUaVg5?=
 =?utf-8?B?TytxNEwvUWZLUXdVdTIycXRCWjlYdWV4VDNNcmV6U1pHa0RwVTFSSkYvdWE1?=
 =?utf-8?B?Nlc5Smt2bmU3bEszKys2YWZGZ0lYYmFvZWFNUVBzVmtpWnJFTWdUeC9NVTBW?=
 =?utf-8?B?eUhFRGxXTzRreFB6TnNFSmdGZkdPL0swK3h1aHpBbjNuUWZReHZoYXVoR3dm?=
 =?utf-8?B?anptNWdJUmtqQXJGOWczT0d0ZmNIMG1DeWNrS3BjTWVsSDQyTTFDYy94QXEy?=
 =?utf-8?B?WWY5eVpjQWRvU2xRamdZZTNHNmxZR0c3YTYxWjFzK0NhMlYrbXl3Z3FCZmVG?=
 =?utf-8?B?cnFibFU3Y3ZCRzNmOWlxd2pRMnNjMFFRMFZ0bDd0VzRVZ2Nlak5abkxRYUR5?=
 =?utf-8?B?dzl6c3F0UHBGWUVTZU0ya0xmZWtzUmlieFpnYXBpMEc1OEY3RzE2QndOaENG?=
 =?utf-8?B?bG5sRnczeSs1TmZSd0pDWmNNeDB3emlhQzV4WEE0Q2g4blk5MFhsTkh3ckN1?=
 =?utf-8?B?R1lBTDk4dUdsRlloUDdXL3ZIWS8xb1c5aEZ2QVR6V3ZGbUtIbUZqZm5jRkhR?=
 =?utf-8?B?QmFOR2lsdW1ZKy9KelRKbmZsRGNMMHF3c0FuZkxpY01JUXBvcjI0TndPSmFI?=
 =?utf-8?B?MGhnaFQ3YVREZTBUMFBOT25nalJlNmhFazZzYWtWQWhFMm9WbGY0ejIvdHFm?=
 =?utf-8?B?aE0wYmw5eVM4b1oyc2lQVGo3YlgwVXd0WWxCSStMSjRpQnlnRW5lWVp0MUR3?=
 =?utf-8?B?T2wvNnk4NERBNHNXdURyOFQ2eDFRZDRsaVB5VVZYYnpOZzBxekJBUklhdDlO?=
 =?utf-8?B?MXFWclU1K2p0UXJPTmF2Ui9UZHVwVXFPazJWWVFnTHZQTW0rcVhyRFlPVHQr?=
 =?utf-8?B?VGhwZkRJVkdSSVJXU0IvSDJla3k2eWQ0RUpQd1MxbnFPQ3BCd1p5V3ZkMlNr?=
 =?utf-8?B?TXFhV2FRWlI0eGk3VGFFak0rWVlrUUZJdjBFSEJENmtQWlVKUGViQUduRFVu?=
 =?utf-8?B?c2Zobk10UVZ6TXNrWDNINStSUGd0RXI1R3l4dklnaENpQVBHWG83VlFnc1Rj?=
 =?utf-8?B?aEpzb1lIT0xVOFpsWXVXUDMwVnBsclIyTEdJV2FTdWZMS2FwM1J0YzY3LzJY?=
 =?utf-8?B?ZnM1dXJQc0FhVzUxL1JzV3NGb0lMbis0UXU1VDlMd29GTlJkRFpTYU5pdGhn?=
 =?utf-8?B?RGRMb1UxbVdwQXdGaGprTnFTVVQxTDhzdkpCd0pkdXg1K0xTN2pVRHhHMENN?=
 =?utf-8?B?ZHdxUjl1OThza0NJWmx0L2RDMDRlSGJCTWR4cHJmdGo1YUlJRnpSSzdtVTdZ?=
 =?utf-8?B?MysvY3d6dFdZK3Q1WWxNVHdqUFZPYnFjdjhaTEFlajI5K2dESlByT3VURXVm?=
 =?utf-8?B?djNRLy9FTG43Y1FmUTVTa0NzbTMybmVnK3V2OHFRUHlEZ0dWSVhMOE1lcU9V?=
 =?utf-8?B?S2N2Qk1BY0diUEhLOTVJSWtFTGExdGR0SWRIaHU0OE91T25rSlJoSnNEdHJ0?=
 =?utf-8?B?a1pLN1NhSk0zL243c2ZRa1RNai91MjFqUHZYYVVuT3dqZ0hXWUV4ZTFyNGRq?=
 =?utf-8?B?NURXWjhKcTFOMk5saDZDU1hQditDR1pKRDI5dlZvdjdGODQwM3RzQU13N1Uv?=
 =?utf-8?Q?Mc2u+ISnj9YCKew1c5gQ9fZ6+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d7a5c0-2521-440d-a0a1-08dcc0401c4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:14:36.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQinQzJe4HLwg0QOXXg26oSX7s/QVfudBTxhDT69zDmhP1maVfZHDZBdqBU3eoiEq54JMJ5zALc54i8wN5Wq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187


On 8/17/24 21:32, Zhi Wang wrote:
> On Mon, 12 Aug 2024 12:34:55 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 8/9/24 09:34, Zhi Wang wrote:
>>> On Mon, 15 Jul 2024 18:28:21 +0100
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differientiate Type3, aka memory expanders, from Type2, aka device
>>>> accelerators, with a new function for initializing cxl_dev_state.
>>>>
>>>> Create opaque struct to be used by accelerators relying on new
>>>> access functions in following patches.
>>>>
>>>> Add SFC ethernet network driver as the client.
>>>>
>>>> Based on
>>>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    drivers/cxl/core/memdev.c             | 52
>>>> ++++++++++++++++++++++++++ drivers/net/ethernet/sfc/Makefile     |
>>>>   2 +- drivers/net/ethernet/sfc/efx.c        |  4 ++
>>>>    drivers/net/ethernet/sfc/efx_cxl.c    | 53
>>>> +++++++++++++++++++++++++++ drivers/net/ethernet/sfc/efx_cxl.h    |
>>>> 29 +++++++++++++++ drivers/net/ethernet/sfc/net_driver.h |  4 ++
>>>>    include/linux/cxl_accel_mem.h         | 22 +++++++++++
>>>>    include/linux/cxl_accel_pci.h         | 23 ++++++++++++
>>>>    8 files changed, 188 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>>>    create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>>>    create mode 100644 include/linux/cxl_accel_mem.h
>>>>    create mode 100644 include/linux/cxl_accel_pci.h
>>>>
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 0277726afd04..61b5d35b49e7 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <linux/idr.h>
>>>>    #include <linux/pci.h>
>>>>    #include <cxlmem.h>
>>>> +#include <linux/cxl_accel_mem.h>
>>> Let's keep the header inclusion in an alphabetical order. The same
>>> in efx_cxl.c
>>
>> The headers seem to follow a reverse Christmas tree order here rather
>> than an alphabetical one.
>>
>> Should I rearrange them all?
>>
> Let's fix them.
>

I'll do.

Thanks!



