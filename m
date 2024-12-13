Return-Path: <netdev+bounces-151675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7F9F0861
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC61169007
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B451AE01B;
	Fri, 13 Dec 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H5N9slmd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B21B4137;
	Fri, 13 Dec 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083272; cv=fail; b=B1cpedDh+2XSwuBMv7S+G7Di847LtLcXP/rHHaXIN6/hEoSWqCycOmT6XCsofspb6lWRtD9vnoxVCvFi8V5xl0SFSoNaB3kVV7EBEwlGtkwRgCXvGnh71Nc3mYkdWuYgW4RfqO87Rlt/vMcyV4RozJBHoecIzBBSGhkJoM+2EFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083272; c=relaxed/simple;
	bh=Z5QMFJgi1LLVu8X4YJfoF1VEJu5sAPU7uw14I93f7zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kq5X4SdGcTKSipLTW/bE3m3HTVgxtfhwV2wji6QURdTCn+M0G0iS6T+6NkDbBVZNzwQPrDUMouNPj7Tijv6m2tYbKPS0zps8iK9tHQeEctmhld4h/zH90lQLRlJjvzA3Cridv4dU08/ds7hQUo0Jsg2Qe1Y9MfCvBZ7GnWUaryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H5N9slmd; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6/A1f2LOgf776vUkgkP+4S+TnJhnPtblgppd0l2DPzivrCPoaVKm4VxpyH4nZowq3E5kmRyPJCur2N2SD7DWQuxsxaAQGOB0w1alRpUH1nc6Np2eyJbcxNqLeEtpwBdsRklp0B5+0i8ZxeNQVPLG1BuOz+F7ukTFk911BhMiTGOSZYIf/IP/X2i8yv2yHxAtELo6UyenOa2R8X+tVeTYx0t2Ly4YF4H1HKs5MxUGHeNri7XTwLi9A7nIOaOCBDOcA7Z8LF2wlZ74WHZXA4bC0ePpXurknZFaY9iDxd9J+c3hp47y6XxgMx2FfeAFo2pShy4KGXPHzdEWsl5XKrxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6KU2kUFeydSqpMjXocIYHx67i9gO5aqo+w7IjM9DCU=;
 b=eHSz33IJI4ifWA9HT4DKyGoQ8wKG9TQke29yzs180IKKkZbgGfuJQINqlqH1XMQXsntgPyT+byLhIovU75jQn/uJLNqvJJ9lMnt5SFu/Yar0ujZng9djHoWsS8dk60wcLq1g0+0jmiOcV53f/jEYw0fofeDQ2uRypvuEyf7LsZpqjz6j03TMob5dVxVMXdXWT9GwyaOR1WkeUP6Kl3e6ikTSQpl9uoLzYR6yodV7kj+xNfoOp3QIepZ1MvkLGd/2r+oXRFTrAJt6DDcxPmWnR8yC4xdxO08xvFjZvgnWP3CWSmVzn7RHg4hHsQ8ME6cXQMMTsN56Ga+6mLTUIQBXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6KU2kUFeydSqpMjXocIYHx67i9gO5aqo+w7IjM9DCU=;
 b=H5N9slmdeM8tJI2FNVgJW862kA9slCm4wIIvECLXM38fwMRJrz4wMbGr6fpzQGufIZLBVcea0wJt8S9u+cT0ugds6+dCpUJdDDcJlDmjec6UPsIC0qaQRfWXl8M1eiETAJ/yjoyHiEW483Dc1/8CpKiMwg1RpbQasmKdDhg1ulI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 09:47:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:47:47 +0000
Message-ID: <1c3dc1af-a633-141b-8425-8b7f2fcbe1ca@amd.com>
Date: Fri, 13 Dec 2024 09:47:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-25-alejandro.lucero-palau@amd.com>
 <20241212184404.GC2110@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212184404.GC2110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ed5561-6714-43fe-3eb8-08dd1b5b3358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGM3cmkvWkJFRlpUME5HVTFScC9xa0Z0ZjVzeDQ5akMxekVkeVRNVVJ5MEJi?=
 =?utf-8?B?blRoZEhmSnEyNzRHUmxwNFdmZHJTQVlNcEROYkNaeWdqSCtYZHRYeGoxNTBV?=
 =?utf-8?B?L3hKcTJhTEFPZUJHaytiSllPSlJyQTBCcHVvZ1ZJb2k4QjYyQlMwc000c3JS?=
 =?utf-8?B?Nm1GVzBUOEk3Njgrb3psWUhrODhxdFVEdXdXcTlSd2M1TDY3TWtzR2NwZUI0?=
 =?utf-8?B?aGo3NVd0RG1DeWdNdHlVdmJqNUdVaEl0Z1JnYVpkakpFcVg5MDZGK2lMRUU4?=
 =?utf-8?B?Mll3bXJFcHNlLzhhVE5Ma0N1anl1RDhNUDdoeklUbGpIb0JxS2toaTM5MlJG?=
 =?utf-8?B?bHRsTklIbjJFMnR6VzZYSG9ORWxIaUpKS0h6R1UvRWU2eW9RSUVHQXdNdlhY?=
 =?utf-8?B?VHB2SlZCODZzcHAxMXloNU1XNExycDVwN2RPWThneTZFQ1E4RmZod0dRNDBq?=
 =?utf-8?B?MnJwTmpzbjMrRVJvdGhsYU5neTVKVFRhbllPTHIxdUlrMG9oYTdyQVJSdGlC?=
 =?utf-8?B?cExVUldIa2NxQ1F4Z09MbEc1L0NHajM2aW9UOUJMbGVTWnVQYmE2V2ZsVllI?=
 =?utf-8?B?WjhhQmhUWm1JSVZNVkYzMW5ud2ZzZHJmamhaYWJibmFnZS9xTWJNZ0FlNWdQ?=
 =?utf-8?B?c3RFOVl2OUtaY21YTmJpUVJEQm5WQTBXUGN6a1YrQi9rN0MvWW5XTnFTOGRU?=
 =?utf-8?B?UVRCYUcwT2hjYlFSNGtiZFlrZVBsY3hTN0dXanVGSGErekJhU1hNMzJ4U3pV?=
 =?utf-8?B?elFqOEYxZmpOQndaRW1lTmJDZE9hc0lJekZDeWF6ZnBCNE1YbGFTV2VSb2Ni?=
 =?utf-8?B?VDkwNnArQ1haZlo2bEE4QytUaVF6M2NsWklJWnJpY0dCUGNwVkVtVlVZckFh?=
 =?utf-8?B?UFZUL3pKS1RCOVNGWHFWY0VLc1NvaGVaRENqN0dHOE1zVS8vZ0VkazVTcUJB?=
 =?utf-8?B?K0MwQ2RKQkFUT1JzMHpHcmNLb240ZmVnMk90cU1iMWN3cmkxZGxzbWRMT1p1?=
 =?utf-8?B?YmRpaDVoOGhockZmKzJycGJyak1OVUlGUFVhc2JEdWZSU1h5aWh5QVp0KzV1?=
 =?utf-8?B?NDRNUEdsRFNuNXVnTGsvSFdteGlKNDNWbnY2cUhUK2Jld0hjbVFyU05yOGpC?=
 =?utf-8?B?Y3dxMHl4b0syMnJ5cGN0YmRiZXMyUVBqZzhacTQ0eGdrUW9wS0lwQXdrLzRG?=
 =?utf-8?B?Z3NwM0hEQk5pd3dHMHhSa2FyZE9PMnY3N1NnK1drSGplRFl0TmRMMDhKSWVm?=
 =?utf-8?B?ZXNzZkUrYlhOdHQvK1I4VngyN1dSN1poeEI1YmUyN1B3ekFDTHUwY2JkM2dy?=
 =?utf-8?B?dEVHRDFYWkZTL2toNWRscVZodklJQUtVR09zRk1saUl2RmJHUkxhYS8vaFBL?=
 =?utf-8?B?SXlDMmltYksrV1ZqSVBidTIrODNrcSs2OEFYWklUZmV6aDlPRXhVd0NiVVlW?=
 =?utf-8?B?NnhmSGs2WVNoeVJUSGl0aUpITmc3dXYybFVxdU1iWUc1QW5WMDlpNFg5dnBz?=
 =?utf-8?B?SzA2anJuS0l2YkVOd0l1cXRiTS9PUHQyWS90clFBRFJCczF2TWQ3RXNjdEI1?=
 =?utf-8?B?MExNbXVhcFV3SnFzekRnQ2dkQU1ENzdTRElYd1FVRE1XYUxCSHRYWVNBdWRk?=
 =?utf-8?B?d2FwZEhZVHpWN0E4QW9MdFhOdVhLTUFDWU9nMmtWRGxGUW1BRzNiQ09EcFpT?=
 =?utf-8?B?WnRIM3BHNEYwQU1KVW5na2FLckdxTHliS2xKWm9xU051MzloaTAyZG9JZDNM?=
 =?utf-8?B?ZmUwRldEZWdGUi9VU2IwZUkwN041R0huOExQY3EwYk1ZTGNKZ1Npd1R3TnZq?=
 =?utf-8?B?WjBLbGh6OFlTbENXbnhzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDFOaTV0Y1NaK3AvWUNsVVNKM1hTL0RSRlhSekZ3MXRkT0Fnc2lYZVBWak1I?=
 =?utf-8?B?QUZqcFZ0bTFzRitHMU9uMXdYek1CTTd5WiswZUZ4bFBhTzR2YXRLVDZnL09H?=
 =?utf-8?B?R0I0dGJBR0hxSWNidTJYU1VKakY5TVBIdU9CcnU4WmdYOXNtZmluV0IzNkwy?=
 =?utf-8?B?WFg4UTVmNDRIc2ZXS1FJZW1GbzZmWm55UU51WEVmVmM2eUJ5ZjlWWlUyQ09Z?=
 =?utf-8?B?S2kvVUU0dXZYMHhZeHNvUXZFcWFRVVhBWE5ZTi9PRDVUMUlCeFZ5ZlFKWTY2?=
 =?utf-8?B?Y2JKMmFZTTlpWXllVFNJekM1cU9vaVBYcWtXQ3NuVitRdUozWTQ4dlFwemJt?=
 =?utf-8?B?b3p1ZUZnOXU5MmFPK0lpbm43STJzcHhJam9jaVRwendwSVdwQ3k5d2VMTlA1?=
 =?utf-8?B?MzlrSS9CaU5aVElMUWV1S3VkMThBZGZuY2tGNTFnTTBGZHNhWGg1K3pKdkMw?=
 =?utf-8?B?a21Db0FnRStxRjRuVWFRUG51SVM3TzRtaUd1cFhzeWpXZGYxUVExdmliZTdN?=
 =?utf-8?B?a0hmckpUeWJkM3g0U1krZnE1RXVxWktRWlRzTUlvaGJWZDk2TGwvNVlXSUov?=
 =?utf-8?B?amo5aWdab1g5UHJFMmdGekVMWDRvUmI0R0NxQ2RuWUpUbXQwdDJGZVdaUlJu?=
 =?utf-8?B?aVd6SHdMclJMbDh5RDdiN1MyQklNR3VsWEZxcytOK1JnU1hqTGpMTlB6eVFn?=
 =?utf-8?B?a3gxSmRpUmFpblFBZS8xcTdtbHhTUzBtRDJuSm5JUDJFWVEzSGhWVFJTNFZN?=
 =?utf-8?B?WFR5Yy9LRi9qN1FJR0owTlc4azNGZnNyMW56eWRDVnRXcWRrekNuRUFZdGR1?=
 =?utf-8?B?YjlvQ1BtZzlkRGFxcWJRYmtmRmhGTEdYVW01T3l4cDIyejkzTWNuVEorV21r?=
 =?utf-8?B?bWNjOGN4amhxZFBsQnNsZlB0TUJPMysvcEl4akZjQnlySi9hNW00UFRIcGRY?=
 =?utf-8?B?bEUxKzNZbHV6YWFpbldVeGYwUjZjalpKaW56WGUzUGlJZCtGVVRvZEQ0eXRB?=
 =?utf-8?B?THV5SkU1SjJDRVlCMHJ4VnNMOVJzMHE3eFhjdG5VbS9QZHFWZmQ0M2Q5NHVs?=
 =?utf-8?B?V1BDZHc0UzhWWXBTWVd4Ni93Y0x3ek5PbWdEVUc0ZFlubWgrTjNhUkczUGhz?=
 =?utf-8?B?b2w2U0MrQWpPaXZ2clNwZTI5U1dqY3N0OHdaQmNrV2xzN3NVazRqYy9kRDI0?=
 =?utf-8?B?aEhrUm4vdGxubXY2cGcrUlo2M05Yc3A0RlJUZXFSYkNWZGtGeWdCWGU4ZXlE?=
 =?utf-8?B?Wmg4ZXN2ekNkc1A4bGxCZFRkNnc4RXRPd2Nsek9zdWp3ajhrYmg2WWhaYURM?=
 =?utf-8?B?OTJXZ2w2aktxNUR1SGZKZS93a3RkUmhka0Iyc3pZZmgzcWFZYmI0ZVJMVWFa?=
 =?utf-8?B?cEZzUlA1bnRXVmxoWFQ2QUZQcGN0YjZJU1BPNzc1VHp5WnpHcVR4ZXRCTFNa?=
 =?utf-8?B?dE4yQUNRMWI2WWhOR1pudDdZMitJcXUzL3o1UFp1OVlkUUpBbjNDS0pVcWdr?=
 =?utf-8?B?TjVXWkFsc1R4a2JWWEUwSHY4MFJMdjFuVDl3eE5OaFArRUZ2cURsT1FHbWlQ?=
 =?utf-8?B?Wkhlbm9JQmYydlA3Y3RZNFZyZjBhSXVJbnJTdDJtMXpwYWZ5cnhzNzl3Ukpn?=
 =?utf-8?B?djN2WEpEeFpHWi96cTYxQmtrOXFZekQrcnlvUVd5MGROSjBlTXJCVWdKNlNn?=
 =?utf-8?B?OFhnYVdJUUtOcVQzdDhWL3ZSWmR1TWJiZFFBNytLOGdmN2J3MDB6dkNETC9o?=
 =?utf-8?B?K2czK1gzb0RYZTNQSmJIaDJEOEZQcVlHWCs3U3Z6Sk9vWlNyVUpsSm56bkdk?=
 =?utf-8?B?U1FuZlVFVWN6empUbWpjNFQzMTQySWJtVVBnVXRISjI0b3lTbU9wc2hWbEZP?=
 =?utf-8?B?MVRQZm1jbUNqNDU0YWlSN0NaSEhUdVRNZkV5ZVp3OWl1cXAwdVo5R25Tb1Ji?=
 =?utf-8?B?amhTeGVxc09JSmoxWEhqZXM3UVp2dXM3MUYvdHRvRHZTTTEvZFQ0bGdmclBJ?=
 =?utf-8?B?OUxNUmtmNWcydFJyNHc1SUFiN1NtU2JDODZ4UVVWOHZySnJvU1ZwTWhCSGVO?=
 =?utf-8?B?dzFNQ0hvSHQ4VWhiaElwZlRGU0s2TlVVOWx1R0FLOGgwZklJSkVVSGJpYS90?=
 =?utf-8?Q?R3f2N9kqTuZyASwiZR+oLlgjz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed5561-6714-43fe-3eb8-08dd1b5b3358
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:47:47.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGYTdmKFthx1uh9H4IrrbAqCFWx2QLSE6EQI63yapL1dlLUu00vG5WGc/6LyQMJwK13iUh59wQ+XqcjWS1CSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972


On 12/12/24 18:44, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:25PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses. However, a dax interface could be just good enough in some cases.
>>
>> Add a flag to a cxl region for specifically state to not create a dax
>> device. Allow a Type2 driver to set that flag at region creation time.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   drivers/cxl/cxlmem.h      |  3 ++-
>>   include/cxl/cxl.h         |  3 ++-
>>   4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b014f2fab789..b39086356d74 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * cxl_region driver.
>>    */
>>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> -				     struct cxl_endpoint_decoder *cxled)
>> +				     struct cxl_endpoint_decoder *cxled,
>> +				     bool no_dax)
> nit: no_dax should be added to the Kernel doc for this function.


Yes, I'll do.


>
> Also, I think you need to squash the following patch, which updates
> the caller to use pass the extra argument, into this patch. Or otherwise
> rework things slightly to avoid breaking bisection.


Correct. Ed raised this concern as well, and I'll change the patches 
order in v8 for avoiding the problem.

Thanks!


>>   {
>>   	struct cxl_region *cxlr;
>>   
> ...
>

