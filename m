Return-Path: <netdev+bounces-119223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85A954D4C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2701F215B0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A41BB68D;
	Fri, 16 Aug 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pPVupozX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B91B373E;
	Fri, 16 Aug 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820451; cv=fail; b=XekOVOqCIqAgkuQuGrS5Y+9l0Jl5Jc+5fmEJEW7saM/RPlI06KS9hqAYSAw8dOmbMXRplI0Yphw8+5AeX8hHOul5V5O+XLKERA4tL+Rd3tQxtuhxss/W6yue4fLTIB9NkoR3eWLBUbIcZIoqs1zRZ3MRuDsIivDoSbrRSU7HZvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820451; c=relaxed/simple;
	bh=SGUx3K5NMP6fpTkObJmO7nc3oONEGowBjj1c+71H8cA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueSBsNqXiUe29nnoUJQrF3SiHaFFtEwBJnPQYflOxnwVerLSFb0SbTBWjVCkw0hdpf9Lhi220VHy8v0S/gF3LViN+f3Nuw8Cw4dd1FsQ6a2VDUzDYVcIz4N42h4PFALgXhLjEtNSIOqIHMWZRLfrTgHhuXp1ciRoBDcQVrq0akI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pPVupozX; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvMfHloTWBCTYPVL1mH/et30/dVLc3Hy2gRBM7//V9UbSFNXTLT8Uw5+6OsZNuPLH91Elfgp1AYfQzGm7Hl+IGJgt6s7FtRwTzmfV/G8S9woZRWPIJSUvLDbl9w4HLYLdhbWPGlobvNcYtRteKk9vgiA8lx1PdbJwiA2nhpk3z0+YnKBsTKoPkRxgnL4lySqNY/BwTA+SyQr5c/RQ47tbAtxKaPtOQWp5D0JNYWnaVxly4ZcUnfPn8l6GQuOEkMCln9a83LCcPROAjuogp83XIEU2xKEE+DsdMaOraMQhQ4qOhDuqt3PWPXCg51ndNUI1dz00veMYxzsT/xyUUyYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDzq8qBInC9kp508LPpDzuMnjQY7j1R+uUJN7SNlFnI=;
 b=SLnfh4sRGPjEGiu9+Nq3mp2SLenwcrw0t6wtYv0AvJjxx36hZvj//qSkOukgNKjK8hQl1wNEwcWWa1bcWE5OhKlsrVppYfVCK939e3mouqSB2hrXCQU+Dp3Eaky/V4GemU3Vfdd5SmRUdYW6IUwt9iCYYBNtVSyO5OR0BGK3ueVUEE8YTyIw+/KEl4eCUegDws7LhMCx1x54jc+gRtrHRQCzJvmbE49ELW6Jz1wf9kOK882Ke8zBty4uvu3JePDx9UOZc5v2BDO+HdnoplCsCRE4Fl4133FY4wgZl6KErJ/mLqTcnse0VDicgTSlh3DbAfSYxOv1E1eUERYdWYHcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDzq8qBInC9kp508LPpDzuMnjQY7j1R+uUJN7SNlFnI=;
 b=pPVupozXli24Xmc59fhYOiD+pATaVP20WV2MuMDB3/Y5bLQz8PLAf/aJLdA6iS9fXMlu5CtAefvzU0+wmCKxUWY3Hy6MGUkroVipSJTTxsFk/A4qxVT6P2e+cI6v8xYFtP9CTLtCktIMYTEdR8I6OjGtf5Ab9YnimuTL7ajsmuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 15:00:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 15:00:41 +0000
Message-ID: <05ee01d8-4687-b44a-effc-1c14cd28d79f@amd.com>
Date: Fri, 16 Aug 2024 16:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/15] cxl: support type2 memdev creation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-8-alejandro.lucero-palau@amd.com>
 <20240804183139.000019e2@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804183139.000019e2@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a660dab-c00b-4484-ce59-08dcbe043205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdzTkVLSnV0YzJMVzZGZ3o1S1ozdCtIZ3BFNGdXbnlkZk9GWGRlMW9CUXRF?=
 =?utf-8?B?eDR3WjAxOUNCT2txb1RNaVZ4SnIzU0h4aE1lcTdobDQySmVDZTEwdWhLd3lu?=
 =?utf-8?B?YmxpZ1UvalNoTUJyVlBXM1EvazAvbEFBZ3Fjb2FRNWNndEVxZzBnbmRPNkpD?=
 =?utf-8?B?QlI3aU5VRWozSDFPaUlGRWZHLzhtOWxpampjYmo0TjJ6K1NVVDV3TzZhOFl6?=
 =?utf-8?B?ZWFOMEVPeE96WC93N1R6TUh1bzR1Nms4T2UyS3laTE9JcHRoMXVMdlZRTkJI?=
 =?utf-8?B?NzRhSk9yQmdEUWJOaXB2V0lQNWtKS3d3djhoa3lyc2d4d3R3NWhiVkp0eFBJ?=
 =?utf-8?B?RkZHSGpHQnNoM0FHSHdrb01QMm9laC9hUVhaWVNoT3R3Sk90WHlpK1ZiUk5U?=
 =?utf-8?B?M2JZbGY0Y2xhaEZWamtTcnl3MFR6MGw0ZnZ1REx5UE5FV0hlb1h3QW5WY0lL?=
 =?utf-8?B?RnNLeWRJMFRoakVuT0JQQU5qQmgzSitTejdqMlFHTTJuTTVYMWx2SDkvaU92?=
 =?utf-8?B?SWYwK0c0a1VIRUFqbnc2dk1JZVYwRHBhQmJrQ3R4bm9vSFhTeXUvMzFERmc0?=
 =?utf-8?B?eE9lbXQ3Y2JLWHNGV1pqam1HNWdacmdzT3JLZXhMSk85K2d4K3J4MDRIUFc2?=
 =?utf-8?B?OE1GZ0sxRzRpM3JNRE9ldjBZakVPQWFZQmRzeFF1SENOWGZnYzhTeHVFK1NR?=
 =?utf-8?B?dEEydHBhMXMxbXlwaXdFbXlMa0FreG9JWC9UT2Z6eWJPWGkwSlQrR0JlMncv?=
 =?utf-8?B?U1Y2Z0pCeFFUWlBxM2c3TkV5dEhCODduUE9TcDlPb1hCbHJ1dGE2SXM1MlpK?=
 =?utf-8?B?c1h2UFU3bkxVZU56eXBwWkU2dllrcUVsU3NiUEY2NXMvYUwwcGlVRDRDMWlF?=
 =?utf-8?B?VjdXd3dYYkFvYVZpV0JmWWtDT2JRaEswMktOWDgzeURrUmgydmRmZVNvSUZX?=
 =?utf-8?B?RExJSXpJRnN4WXB6UEVYV1pVNjQxVFN4Q0orTEZmM3NBUmhOMWV3Y3BlVE9Y?=
 =?utf-8?B?NEV0UUo4MzFVKzloQTlKcnQyMXRqQlFNT3lmYnJyK2JSWnVRZGNHRjRHMkYv?=
 =?utf-8?B?eFpmek9xYUcvdy8vZXJteHREVlg4ZVZqa2N1MmFkdFp1K0JLN3J4c1pVV2Zl?=
 =?utf-8?B?VzRVSVB2dDdTY1hBSDdiZmdPNU5Ddk05cXhxUHlaTXpWeXNqOEFJZjdsRlIy?=
 =?utf-8?B?eDA1T1E5S0FHbU5qamNyZk5WS0V6cko4WE5yMmpOQmF2YW5ic1FyM3MwWHI1?=
 =?utf-8?B?QTExT2NJaURqdnRnZzVRWmdUQUwrZzdYZU0wZlgyZVM4OHpQaGNMb294V1c4?=
 =?utf-8?B?Wkw1RExtaDc5RGRoUkRDRk5jTEpJWG9leDQ0N3ByNUVOWTJyVDRabFFuTVJ4?=
 =?utf-8?B?NzZrR1k2dXRQd1BSampUWXZJWlJZVU5wdVNaNFJST1hWUmtMSEU4NUtyL1Rk?=
 =?utf-8?B?bVBmajJuTlliNmFvZGJPYWErVEZLT1A0L1lGN21zSFVMdEVjWHNPNnR6TThs?=
 =?utf-8?B?Ri92NW11Nm5ESVRlb3c3NWVEY0lMMzg0YUJLdUJzUnZwTC8wSEFEbWlaZ0Ru?=
 =?utf-8?B?bXRrVUdqVzVSMVRKZHlqSGFsZFdEbjVxWGs2R2RkWXZ2bGlNcE50MEh5RUtJ?=
 =?utf-8?B?NmlsdU9FclUrNWJZVGJtR2QwRWdTU0VKZHorKzZtaS9vbUYyTXZvYVJPQmRH?=
 =?utf-8?B?cUVkYnJuNzdqb1JzbzNtOFJYUHp4dk1zMWYyd3E4MWY5WHNieVhzRVIrV1Uz?=
 =?utf-8?B?c1dNZ2dwL2FsTldEWVlPS0Ura1dyTmdCOXJ0eENENUxUU3d3RlR2YXBUbnBi?=
 =?utf-8?B?T0J5THVtYkFzdWQxOXJrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzU3bE5jRjZRS25ENFF0eGFMZGRtMU5McHR0S2J3aWZlWXJnSXVpZzVIcUJj?=
 =?utf-8?B?U3c4dVk2YTdGNlA5REswNUVvOHl2UW04TjU4cENwSVFxRXVUcVpRTCt3WXN1?=
 =?utf-8?B?aDVXUjVsaUZwUjhveFVGRTFySG1LaDhuR2RDZmh5WXlMdURpYkQ3UlhucGJT?=
 =?utf-8?B?NSt3eFBOWlpHU29vbTdVNkdlREs4d1JYbXJiNHJSeHEzSkFzS0s0cVJUSjI3?=
 =?utf-8?B?RTZFdVpoSjhZYUZKNlIxWC9pL1UrdUNVTHd0ZGJKL1NnZ2pmb0liRzhrWDJK?=
 =?utf-8?B?R0E4NklaWVlwVGtvdGlrME93U2JZWXBCUGJhZklUeUlld3k5QnpVbFNWZ2RN?=
 =?utf-8?B?QVQzYXo2YU4rV2VkK3ZpTXdpUGFROWppOFNoQjM0dkUxdGdOWVZDc29UcjlW?=
 =?utf-8?B?eWkzZjVhSnB0YXFUVTZzRHBFQXM1eVpiV21PcmpOUm53TS93YkVrVHg4VXBp?=
 =?utf-8?B?elhtWjZNTnh6QXlCMlAxOHo0RWp6dXM1MmxlZTFMMTc2dUJRbkE5dElyTEhL?=
 =?utf-8?B?UjBwOHFhZnhWdDB3dElPSGpSbHl4Nk1mQklPZDFsYmljM25PM2VTdlZlOGlY?=
 =?utf-8?B?eWZjNzRrS3ZWc0Y4cVhrcDRkbWUxWUVYOE8rNUJub2xEZ05pQzRQSzN4OUp3?=
 =?utf-8?B?TWc4alpOaXBlM3dMVnU3QkQvREhNV3Mwd2ZDcEZlMXIxNGlpNXpWNTdCTjVT?=
 =?utf-8?B?VEhEMWxUZWZIOVBtZHpkUndMNExUR2ZtQ1U3c3lNczF6cHNlWTU5aHg4Njds?=
 =?utf-8?B?UkdZVDlLTHhLSG1wV2RrRDhBRUtpQitSTXI0YWtaeWcwRUwvVW1tRzQzVjhO?=
 =?utf-8?B?TWlkaXE5dWNtTzkxcE10MkxUaWQyK0tSbm15aG1qV0tlUzVDaW9lZDQ1M1FS?=
 =?utf-8?B?WFdUaUFQLzJJZXZFRmdmcUxhdGtxTlBHZ3dQYUgrZ3RUa0xSVXFwcEZNaGJi?=
 =?utf-8?B?MkpjN3M0ZHlCdXRwZEVlbE9CWlN6TlJ6QmU0UVlhRzAvVEpUWHVpWm5NdjQw?=
 =?utf-8?B?eVBObGZDNFcyWjVXVnlEOWI4ZU0xMlIrcVBUNHROU1hIYS9NMVc5RjFCVFNN?=
 =?utf-8?B?QWFxajN6Q2xTT3VwaUhRdHkzRjZiVlNFcDdvMFplQ0tCdlVyc1JOQUtmOXdt?=
 =?utf-8?B?VkZmNjRndUxSZVJwSFRFOURpQTllYVVMQ2Vlb1lmRHU5TUdCdmJIQ0kxRWJm?=
 =?utf-8?B?RFgwMTdxQVA5UndvU21RODd5Um9EUm1MNWFjcWlUWFVNZkVrRjVNamw3aXFp?=
 =?utf-8?B?VFk4S1d3Z1cwQUgwdEdHd2I2QmJPcTRsd2J3ZGtkMVYzNGV0MkpweDRuVW45?=
 =?utf-8?B?MHEyRVY2bHF4NkRWZ2hibGhJN0xGcmlSRzA1ZmY1NHpSVU03UHJpaWltWVBS?=
 =?utf-8?B?TUZQclUwcThBVmFtUlp5aWxQU1UyeWhzME4vbUhLbGwzVStLaUV6cDJ2eGha?=
 =?utf-8?B?eVpyRFlLSHhreXI3Z1o2MmxjVlBKSm80QzdocXdMMGdtNHZ2OWZNc0hqNnNj?=
 =?utf-8?B?SE5XOTdTU0owQ1VZSkpwRUVTY1RFMzloa3pES00ybFhzMkpnc3BJYkIxZllj?=
 =?utf-8?B?eSs2Y1k0OFlkL0RVUjFQNk1WUUNCb1hFQjhSM3daUjdITlRhRWQveUFZdCtL?=
 =?utf-8?B?c2lGeGo2bUU4aFplTTNaL3d1SkJLK2pNdEY5UnllQ09Nakoxc25iV0VHc2Rk?=
 =?utf-8?B?K3VHMUZTMW56TzRwNnpXUGlHVHRma0RMUytsME1YUjhIYkpsZGsyV2QwUE03?=
 =?utf-8?B?ZElZdDEwOHFqWGR1ejltRDN2bU5HZEl3MGdRWTJ5dlZ2enRnUDAzU3pLVCtE?=
 =?utf-8?B?cUh3SnRWWVRuOG14NXI3QytFaTlEeXVIUDlPOW5hYmxiSUpVVVJxQnFhSjl2?=
 =?utf-8?B?THROMEVkQ0h2cWx6aDVlbGZvTlc3ZWdXVDYydW81NkRLd3MrWU1NZEpSQXFh?=
 =?utf-8?B?NHg1cWVJMExQMDZSVUEyOW1aQlZsOEhiRXhPMEZ3L3JYbFJUMGZNN2RlMytj?=
 =?utf-8?B?dEppdnJIbGMrREtFaEhMV3ZIK3RFWnJ0dEdZa1YvYnNOZnJqanArSVFvZUZj?=
 =?utf-8?B?UndRYytuQTZ2V0dPdkRVZG1aMVdGalFVTnVoci9jdnhONjhTcnB1UExOZGdO?=
 =?utf-8?Q?pVUsMDylt2j96y2mQHpBf1nMK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a660dab-c00b-4484-ce59-08dcbe043205
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:00:41.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnzYaUZlNkQSF5RWiffIAeWoz1aVR+pGCVOkczB6n8NI2ebNrip1NBzVgmUbrYleDxiPhfR++Kr5W/AdMrXp+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999


On 8/4/24 18:31, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:27 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add memdev creation from sfc driver.
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected. This patch checks for the
>> right device type in those functions using cxl_memdev_state.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Same general comment about treating failure to get things you expect
> as proper driver probe errors.  Very unlikely we'd ever want to carry
> on if these fail. If we do want to, that should be a high level decision
> and the chances are the driver needs to know that the error occurred
> so it can take some mitigating measures (using some alternative mechanisms
> etc).


OK


Other comments below already addressed when replying to fan.

Thanks!


>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index a84fe7992c53..0abe66490ef5 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -57,10 +57,16 @@ void efx_cxl_init(struct efx_nic *efx)
>>   	if (cxl_accel_request_resource(cxl->cxlds, true))
>>   		pci_info(pci_dev, "CXL accel resource request failed");
>>   
>> -	if (!cxl_await_media_ready(cxl->cxlds))
>> +	if (!cxl_await_media_ready(cxl->cxlds)) {
>>   		cxl_accel_set_media_ready(cxl->cxlds);
>> -	else
>> +	} else {
>>   		pci_info(pci_dev, "CXL accel media not active");
>> +		return;
> Once you are returning an error in this path you can just have
> 		return -ETIMEDOUT; or similar here adn avoid
> this code changing in this patch.
>> +	}
>> +
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> +	if (IS_ERR(cxl->cxlmd))
>> +		pci_info(pci_dev, "CXL accel memdev creation failed");
> I'd treat this one as fatal as well.
>
> People argue in favor of muddling on to allow firmware upgrade etc.
> That is fine, but pass up the errors then decide to ignore them
> at the higher levels.
>
>>   }
>>   
>>   
>

