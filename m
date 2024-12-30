Return-Path: <netdev+bounces-154531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403D9FE5CC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 13:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3CD160F22
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C91A4E9D;
	Mon, 30 Dec 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CAmnn6Z/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378F19C552;
	Mon, 30 Dec 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735560975; cv=fail; b=Pzgj+D4h/j2awkgeMZODTgdYjVb0SPa/1M8TNZQgFpWnE0hVC+xAKqUkv04e7f7i7d6GCsXQmvQHMjGAj6M7JlN6VBLS92g2rrbFXwbwfolQKuZXIDWwlSgxbHIayN2C8YWEVzSAZX9v784b+r+C/DY5YEqsWnR9hnpEip9TcAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735560975; c=relaxed/simple;
	bh=YW153WRszVSe3h134f6MOS4DS1ENy4bMoyAPlAJNv/4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsLLh20F7/M8ns/QHM/Zcc9dQsTy+9nGpA0+nLxBN+eX7Ohl54TYdFSE0+glSA8M/HlZ1HTi/wa1m1MYZvRFV/Di6oZLCQJFPFvVu7s1Dn2GiRcfAeR7A4odChAKX8NcOvi8ELFF5Ua97Q9jjPZjEnk25jyXhxqXqFYiTmrxRN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CAmnn6Z/; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/ZlEFCfacMkgzG20bCQOBT5LJbi+26bUwUBRQ0h2AiyZecl/SVKrRKtCfd447UNVls3Li19V9qpTjrtCo/IVbcbCRfr55SmzLnTtXbqCiT0RvtV91rpfiyX0bajBomx9/+pm9dMANqrm+/ff4DgyvEDb1M8FHeiR/gjm1YjKIzSZL/JheAx49JY+wLf5QKIn+RideTS7tfz6nvpV/JOkfXgwYdX72oMy1sQB//GwffGu1jYSFeHVCPf7UcidOawX6TBk89PZmCVWyS0jd2W2Gwj42SqfiuG9l+xZ1uMPhYY/gZSlQ5Snv+2eBMY5V9yXugGCg/gA+KbWYWPNRMHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys+LDpKk0W/0CoTP/URUSJuUtO45gbuIynHIxumbXDg=;
 b=TbFqF1ls7VdjTQNqceH/nkzV5gK2mRoyyaOJbj3K5jjOlTXsJvilMNmh7c+Va6Ky2ncBfKCqHPnA0RQf7G+8pNxDyXwcSHooLvHfuqtRH1WX9C6ZbpJyUWjLCSr8Hi9YjD6ID8ssKgq33C/WKBWA9Rx011xLoZvD8Q8XZHtJRIW0bRV1c1bo0Vu5dXhnDZQxiCn4suSM6DMAlTuQbAUj+xGqP+jSlAE8jeW2iVidWIV/R/yQaPuYJYBYMYsm4kHjuproHifaCWoKRYLxZ53F6c1VLOiX2AWLokDx9pU7n1VbXYKFLNWvbDz00p1CE3w8+05YWsVNqyuVrc5uDIdE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys+LDpKk0W/0CoTP/URUSJuUtO45gbuIynHIxumbXDg=;
 b=CAmnn6Z/Lhg8PnJkQnUomXJv24zGhOVFnLzdjDcoFwWJg0eX2YtmhAved2LzSrZ90ar1VU1OaNl6WbtR9CA6N0FpklZ7FFRLG7EDbj55P7sq5CltnOTHedD2huuVPHvGRpDlrtnHvLvANogu6o1tiakUjUmhHa3JnqyN/fsMeaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.19; Mon, 30 Dec 2024 12:16:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.020; Mon, 30 Dec 2024
 12:16:05 +0000
Message-ID: <09593973-23cd-0404-1012-4efce497435d@amd.com>
Date: Mon, 30 Dec 2024 12:16:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 27/27] sfc: support pio mapping based on cxl
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-28-alejandro.lucero-palau@amd.com>
 <20241217104726.GQ780307@kernel.org>
 <616ec928-eed6-dd1d-496b-73c6794c102a@amd.com>
In-Reply-To: <616ec928-eed6-dd1d-496b-73c6794c102a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bf5480-3f86-4c95-f3ba-08dd28cbbbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRrNmd1d2hSL28yTWJSd2tkOVcwZUdydFNYbEdMeGRybzcwWXZmWHNTczhH?=
 =?utf-8?B?bURtcFhDS3hMZDJRVkhZZjl1VTVqL1VucktIT1cyZ1lCMmdaM1I3QVZaajI1?=
 =?utf-8?B?TE0vdGg3T3dQUjNYL3RTa2xuTTBLZ0RkUFV4aEQvZGdFcCtHZGxiQmNKYlQr?=
 =?utf-8?B?TUhOM0NuaEgzZnV6TEhYR1U5N3Q2NEl2RXJqYUpIaTZ6M3JoQVBmbGR6MGty?=
 =?utf-8?B?bHRZNmtCcW9vOHBEblNtcm9tVUloWms1YTlTcXBvaXU2eWY2NEp2S0U1bmpq?=
 =?utf-8?B?ZTFHb2YwUmZKVnlDSWh4eFIwbkhkcS85MVZoUmFTTkxXRnFWcmQvbkRCZkFt?=
 =?utf-8?B?QklhRkh3Q0dyeldpTTRCUDg5ZXZsdHNlQTFyTnZkN1p5VnpXYVU4blhtWDdu?=
 =?utf-8?B?cWpSWjVrNmdPdDA3QUduR2VTQVV3NisyS2tzckFnVW42bWFITVc0TVQvU1NN?=
 =?utf-8?B?NlpvdFpiVDJuaTI2Y2FtS28vbXNvZHc5YnlTOHNSOWc1aCtsN1JIT2JNTWNE?=
 =?utf-8?B?eDZZamdUeEhxKytDTmpKRHdsK2tOWVZ3N0c4VzZJcnVrRkNjemh0NU9BOTVV?=
 =?utf-8?B?aUVuQzdmREl3T29BbVo0c1pZUXQxVEdxZmRWbC9rY0ZGRDBnMVlVZ2pKNFBv?=
 =?utf-8?B?QzhTSjdyL2JXQzJERHZtenVselpXdC9XQUFkVjBnNTNjSzZzOTFTQUo1djI1?=
 =?utf-8?B?K2JJK2VOelpEUDRueEdEUU9MWGhJT1dxcXpienNlOVBIT2hYNWVLOE9NWDdu?=
 =?utf-8?B?MGd3cDc3S0xGMnMreTRMRlpMTTJOcUdFWlczUFhYc3o4NlRUV3NDYk42ZjNx?=
 =?utf-8?B?UGVoaTFwY1ZTZVpaUG9rZEZmVWJ0VHBTdWNYdm9ZOFBJWERoMTZyNjhoYmJz?=
 =?utf-8?B?MDBtQ3psYjByQTZucDdCUTNTUTZ6azhXSG1aZ2xtRU9MTVU1a0FybkxIN1Rw?=
 =?utf-8?B?SWovdmd5anBybkxnRzNEaTJIaXU1U3o2QzQ4QmNXVnRsZDJsdEFrZFRIV1Zo?=
 =?utf-8?B?S2JKRnM0QmVJcmVBTzhtY3gvZGZXUG5qbmF0aFNaWC9GRzFNck9pdFdoT1Jp?=
 =?utf-8?B?Mkx2cmNyUENnZHZCU0Y0SFdORnZ5NURubXB5VnR6NnBPSEh0cGZMTTQweWxG?=
 =?utf-8?B?RW9XR2YxWVNSTVNBUUlnZGNRN1B0d0F4bmxnYXlRZkc2QW5QWnR1VEhIUDln?=
 =?utf-8?B?SU40dExUL3lKeXlKdWJsNmFQY1J5K2lqMzhveTVnZFpVM3Vyc0FzdEZuK3Jl?=
 =?utf-8?B?WmcxamVmQXgwbWNjdjZDVGZkSFBYSTlxeWxSU0JNakY0b1pVZTd3YXRHc0Mw?=
 =?utf-8?B?K2lSWk1EdW05L3I2aTFPYWQ3Z1FsOU45bGpFNDJQMDgvakw5dHpjTmJGQ0JD?=
 =?utf-8?B?Mm01VHdHMFlpWjhpWHQyT2tjYkVOUFg3ZHhaTFhhbVI2aENmVFJZQjBsYVdY?=
 =?utf-8?B?eG1SMEZiZ3hGcE1mSGdiUW9QckdVNUFMbEZqMlN4Z3lqNmdCWGV1OWxjbGxX?=
 =?utf-8?B?eERKSXdqenVrMEdPY2cyOXpScE5NNjczeS8xZEdyd08wY1lFd3Q5RkJCcVJR?=
 =?utf-8?B?elFrVHFub3FVVE1CWVZScVk2NTJNUHJteXpJWTZFZTRYSy9Vd2lMOE1CaERV?=
 =?utf-8?B?WkFmc0hoQTJHdzl0a0pwV000SlBXcTRBcGI4bGhoVldOV2NCemtkZU8yek5M?=
 =?utf-8?B?OXBxODhrdUNBaFM1OGFxMzR0Wnh3UUtYaWRKNXQ2b09ueGl2OHVCQkR3U0pY?=
 =?utf-8?B?ZzdFT2hWL1EzVVV1b0ZqbDBVSzZvdkdlMkp1MlA0N0ZyNHBZVXdFRmNvNlhY?=
 =?utf-8?B?SHJNQWwxbkZNWUV4U0MyeWl4VktiT2FDbVhKbUVNdVFQcEhFeEhyUXgrZDAw?=
 =?utf-8?Q?P0lYxxZlHrAQW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BnWnhodk52czcrc3I1Zy9WNExEK2ZkdXI4ckRlZVpOazJIS0NwT1lhN0FK?=
 =?utf-8?B?MGRMcFdnUGJZRHFTNDVNRVlTemtOZXBYTXEwWmk3cHpSTTlUeWwwUC9Gbldj?=
 =?utf-8?B?M1FUYVdxL2pxU1BVTWxSdThGRHo5QXo3SG9nL29DN0JwOGY3M3I2dGk2bW13?=
 =?utf-8?B?U0hUeUFabnN4UEhhMFdKbFpaSk44ZVlORzBWcHZJUWhsb0xDRXY0OXVZOG11?=
 =?utf-8?B?d1A5ZExMdjMzWUg1Z2tCcEVqbFFWQk5FMW1lOExDNUpkTVNwK29Vekc3dEh0?=
 =?utf-8?B?aWVsZExlWUhFRE1tcVR1Ynd5dnZScHdiSDROcGovU3laRkFodWtrd0w0dWV2?=
 =?utf-8?B?TkMvZHhTcy9iQ1kyZHV0QVppNXpWYVppWVJCNy9McktoZ3VQb08wMGJiV0NW?=
 =?utf-8?B?SG9OK0JJL1lTK3A2c0JQRGFXditPWXZtSzRJOWZRUGtyM3dVYXA5VkhhR01X?=
 =?utf-8?B?dEVueGREbDJ1Z0pudDgvMHhHNU1NS0MzQ2MzQVZ3NTRQS3FNSGE4RU1DaU54?=
 =?utf-8?B?VGhMbGtZSFp3TDBDVDNHREEwNEczNWF6OUh4WU41Y0ZPblgva0wvOTBsT09r?=
 =?utf-8?B?QXQydkRSWW9CRWx1N1Fyb1pFdEQzTWRrVUowbTBZaU9EQ2hvU1B0OFRQUjVD?=
 =?utf-8?B?SEF5ZUFOaHFVZ2YxWmlOb01PbWFQcnJtSW5mWGwrcm5sU0ZwQk5NWUpFT2Ji?=
 =?utf-8?B?MjVvMTltYWhFV3Q1cWFlUmpCMk5SbitPWTRuL1I0eUhETCtQQkxvTFhZeE1M?=
 =?utf-8?B?aTloZzRXWFpsaVFYV3BDUTd5OWtNV213V3lZV1dIenBSRjhWK21UYWpQNzgr?=
 =?utf-8?B?dTFGZUdUSURQUkdyMnhrYUJya00yRGVKZzRpZUNvdGhWTzFIVUxhbkFSMXBx?=
 =?utf-8?B?VG9ZVTJLRVArNHU3aTRIV05aNmNya0htNWZscmpXZDQ2RGc1SmNrajdEaUhY?=
 =?utf-8?B?dVhHU1h6VlRaR2NrcXBXMm93SGRkaVorOVM3U050d1AvekdIN1RuU3lwSHk5?=
 =?utf-8?B?KzNucmM0MXhJVXluRVo4SjdGYk83L3hodHk0U09TVHV3YWFqV2VYRTFqS01R?=
 =?utf-8?B?dno5RmNmSk0vWGxhU0Qyc2xKMFZKc3ZtK2ZWeFRTaUp0TWYyb3h4WTB4eDBh?=
 =?utf-8?B?OTgxMXNsR1hFSVNPdGJUaUJFR3g3Rlo5bTRRbGsyZUdUa3NRcmVZdXBhSlRH?=
 =?utf-8?B?ckVBZmtzMmI0ZHA3TkZNY0JBUURQNTkwaUJoT1JxemZnNlNzNmJRb0Q0VXBI?=
 =?utf-8?B?M1ltWXdsTnJiNkszZkZRNDljVHp6UTl4cDYwckhWS2x0cUo5NE5YOHRlY3JQ?=
 =?utf-8?B?SjNsdE5pbU5iOUhKMzhub004SE9TOGthUmxrczVTcFA2anFyWUdGYS91RzhG?=
 =?utf-8?B?WkZBdnl5Q0ZvVCtFWFhuVGZud2g5QVJmU0p6ejQ3dWpYTHo0YW15WktWeHdl?=
 =?utf-8?B?REQ5dVFReEROUGJOV0tMd1V3VEJFeGhkSmNhU0pEdTJ3V3NiMDB4aFVpTlJm?=
 =?utf-8?B?KzdzQ3k5VlN6b29oZjFsaVFUSm1KUWViUTVFTENRZnVjU0Z5ZUZyK1hYZEx6?=
 =?utf-8?B?OFEvNlpCSmlvK1R4aXBLL1FwWDFmM21zV3Z5SjNiSERMSGdYMFRqeGRDeDND?=
 =?utf-8?B?ait1OFRXTTQzUnFaMitqZjdsdHN6OHluQXhaVWRiVXdYaWVwQUFYbXQwcDZz?=
 =?utf-8?B?K1Njcm1YZjNGSWlBMkZoWGR3VXA0UkxvcnJyTnQ0MkdNbEYwdWF2MmwwOVZv?=
 =?utf-8?B?Ymd2ditzVXVPTmd3eHVvNXd3YmRmYnZmRGxHU2dyNTQzUzgrTFZNL0pIbTg0?=
 =?utf-8?B?SzZtbmRna3NJcXdCWFBrN0xrMy9lQUg4RTJhWlJsVm9Ga3VPVkdvVXoxZ3l5?=
 =?utf-8?B?Y2ZtaVltdHI5ZGxQMUhZUm5nQm40Unh2bVJrdmdiaGhpK3pOVldCaXEyYzNw?=
 =?utf-8?B?M1h5R21ZNHNZaGxiZGpaVjBrVjRLak9jYnYrN0UzL0pkZWhyM2lhNWsyK2pX?=
 =?utf-8?B?UnFQZHB1anlYN08zWmRHL1V5cUNnUWF0SHl5UEtiMVlvQW91NlVMMWp0cG9x?=
 =?utf-8?B?cGtHT0QwbEpNczQwb1VQVE9DcGRHY2NtUXpreE9ZeWhna1U4V3VnYk95cXQ3?=
 =?utf-8?Q?LEKCf7LjnChe2cNvDj+aUzofe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bf5480-3f86-4c95-f3ba-08dd28cbbbf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 12:16:05.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM4dxv5U2j3+pVF1yqITRytTTBYvIsctYamMlUiySK4y6cDz+jQItv/rEU/Csn34ucawOdDY1wt9w3va+71fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862


On 12/18/24 08:32, Alejandro Lucero Palau wrote:
>
> On 12/17/24 10:47, Simon Horman wrote:
>> On Mon, Dec 16, 2024 at 04:10:42PM +0000, 
>> alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> With a device supporting CXL and successfully initialised, use the cxl
>>> region to map the memory range and use this mapping for PIO buffers.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ...
>>
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 7367ba28a40f..6eab6dfd7ebd 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -27,6 +27,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>       struct pci_dev *pci_dev;
>>>       struct efx_cxl *cxl;
>>>       struct resource res;
>>> +    struct range range;
>>>       u16 dvsec;
>>>       int rc;
>>>   @@ -136,10 +137,25 @@ int efx_cxl_init(struct efx_probe_data 
>>> *probe_data)
>>>           goto err_region;
>>>       }
>>>   +    rc = cxl_get_region_range(cxl->efx_region, &range);
>>> +    if (rc) {
>>> +        pci_err(pci_dev, "CXL getting regions params failed");
>>> +        goto err_region_params;
>>> +    }
>>> +
>>> +    cxl->ctpio_cxl = ioremap(range.start, range.end - range.start);
>> nit: Smatch suggests that resource_size() may be used here.
>
>
> Yes, I think so. The resource was not available in previous versions, 
> then a requested change did not update this.
>
> I will fix it.
>

I was wrong in my previous reply. We do not have the resource but the 
range, so I'll keep using the range although doing the same arithmetic 
as resource_size.

Thanks


>
>>> +    if (!cxl->ctpio_cxl) {
>>> +        pci_err(pci_dev, "CXL ioremap region (%pra) pfailed", &range);
>> I think rc should be be set to an error value here.
>
>
> Right. I'll add it.
>
> Thanks!
>
>
>> Also flagged by Smatch.
>>
>>> +        goto err_region_params;
>>> +    }
>>> +
>>>       probe_data->cxl = cxl;
>>> +    probe_data->cxl_pio_initialised = true;
>>>         return 0;
>>>   +err_region_params:
>>> +    cxl_accel_region_detach(cxl->cxled);
>>>   err_region:
>>>       cxl_dpa_free(cxl->cxled);
>>>   err_memdev:
>> ...

