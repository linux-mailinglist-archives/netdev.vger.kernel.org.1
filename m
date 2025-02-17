Return-Path: <netdev+bounces-166996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F7A38457
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E033A51ED
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099C21B91D;
	Mon, 17 Feb 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTEijksv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC0215792;
	Mon, 17 Feb 2025 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797907; cv=fail; b=Tc/xDI6FaKy5FinvtD6ROC/R9j/BOwhd36DqqDw7umXQO7dvD67MXT7WaZofRKG2u7yED1RpFf76dTus3f9jYqe+p6FXXvEX28byaZXre+i9h5XDVn9wMVUNATgYJoQhfiF9ldiTpsTe0qKl/ZvUXvOwfiiCeFMI+vR7GDQhLYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797907; c=relaxed/simple;
	bh=PbSRS/wPA7dAIxmwFKour+wAMyFtLCzJmE2ZVmUpjFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxJA2DmQLQaIEgHil5ZuZaqYsLG2hXESy9UIjN8f2V0ajcUo0imWlGNX2/sHAx+zE16GDGIaNOf06BIxckf514nrgAO8U3wba4G7IsPap//90ELQsCP8iu7JkYyB4D4TeS+dS52UQHk9Jf3dhcqGEBhMJuYgaDlDPt7/kURgqsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTEijksv; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayCazHR8HE3iYT2Ap0RNJnFbfbVBhbZmQBFVmtQbgYeBrRiDk1UVHHl4AaPgGdPKTuWi5N/vpXamRN9jnUoLoE/GYPPc3LWp/c7qD9QvzOEPlU7THKVBoUd2bb05Qsw6EOBfnKLCgt4gtGAqELwRyQpwIr8+LUUwuMhSNat/ONvOw/6ZaZT4sorE35lVxvX42h0TygQ2I7NCNU0jcLm6gcD1JBbuVd5Hlfd8CfhOLmBDCJtxEE9ui/J5NpLKZIZhZcu47t1kgwErJipkyeoqlRXvR7ofjwzE4/HBNGpvGIsdXSAuk55wL/1fub54xSRkbrjtbCsesaXPyOSRnh1YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQaC7OIrAU/GcMV2akOYe3ox85+gMGRFipf7ek6jEw8=;
 b=hmpzjsFXkgcFsZnNYHF0ZCZcg75SJC6VrtE51cYvze6s/asGbLg+aSGGt5nwOgyvFjF+/giK0Hbe5TODaEKrCApWjWz9q7ca2NQJJ/Nwot9tvzVk4lSqHcPIscOyIPOq5mEQPqGiM0MQ0enLBirSOZzTIW41aDHb/ZNHVYso0HT8V6pEUMc6JSTbGU3RIpzhjuSmYbC8UVgCBGs/k2RafuMFCqMtladQWfEyW/pD0NnYCFWJL59CkpT5tq8kdj2XI+vUOt4A2XDQBbmyAM1uUH+HIqiKfF7RDBX+ZNvdVZtmIWoHMPpKU+e0byNs9ROloI7uFWO5XysYpqPAjJY+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQaC7OIrAU/GcMV2akOYe3ox85+gMGRFipf7ek6jEw8=;
 b=vTEijksvqhzgSd0H8Qk1DQCLz/XqlOmaM7GuV6MC499kj9Dn7BexVbWoRS1b6sMEtEl959uEFV2fHJoICWQHxpTUn7k593S/cMJy5Ackxhi5826VvPgHbZ2b849epLyMdTXDRvmSS3ud66XE1/CWpbCP8OPkItP/rO4HHMEDLac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Mon, 17 Feb
 2025 13:11:43 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:11:43 +0000
Message-ID: <679b8737-8655-456e-949a-63db07a71d2b@amd.com>
Date: Mon, 17 Feb 2025 13:11:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
 <20250207130342.GS554665@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250207130342.GS554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:10:100::49) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 85853293-25c6-416c-1f4f-08dd4f549fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3BXT0IxR0x5bldpVjlvMDBRU1owK3plK2FlK2U4R2MxY0UyOWcwWmx4aHRW?=
 =?utf-8?B?ek12b2EraUtBZjJwSlRhTmV0TmsyTStvOWo1YTZXNGc1RzVjQ1l0TnUrci9p?=
 =?utf-8?B?dmkyY1EwRVRjUkpLZTFGdzB4Um9HTlJYcWM2Qjl2TWRtcExnalVNS2lCQ1lh?=
 =?utf-8?B?N1dxaFg5Unp0QUVzclhEem9YQ1NUbnM4aWVuN2dmZ3NRdDZUSlI5ZEVCVldH?=
 =?utf-8?B?aWxVdW81Y295TS93cWx3L05wYVE3NXo2eDgzV1ZsUGdGVkk0QTljODhuaDlv?=
 =?utf-8?B?d0kzNm1WVzBEUzhWVFNKREJkb0kxWVhmTWJkTy84VWgwczU0aXRlRlpBbzVk?=
 =?utf-8?B?bk8xem81Y3h0UEFIZTFNNFd0NTZyWVFvc1ZVc1FBWHVuRjQ5cDBWaXNNbnMw?=
 =?utf-8?B?aUhRcWs1SGx6eTR4Z2pudnhzS05XS0tKdjk3RHhyM2d3SG9QN21mY0ZtRGpw?=
 =?utf-8?B?VUs0YlhDMHltZjlVYkQ0N1dyZUQwWFE4UHdyQUcvem5GWlZYQmZlNlNEMW9E?=
 =?utf-8?B?MndtSUVrOWNSODZydTJBKy9Welp6MEd1Y1ZMNUY3d3RNeUczeExYRjRZYzZX?=
 =?utf-8?B?VXhrZjE3dU9RUE91Y3BDSkRFZXFJeHRzUnR2a1hiZ1dlelZXMlRnMWJZUHpp?=
 =?utf-8?B?RVlJU0UyUy9Tb2k3em95VUFEZjVnb0FtUW1qYnpiaGwvUW41Yk1qNy9ZVzBE?=
 =?utf-8?B?QTZsbnJ6TlJCZGFsNXJxN0NTa0FyT0VvcVpZL2ZvdVB3Z1QyVXpiVUlMcWZo?=
 =?utf-8?B?SWh1Y3kxQ1MwRmQwOHFPa1ByekdueWR2QWNNZXFqWmJkUjBzNVdLVCs3Rkkw?=
 =?utf-8?B?eUxDM0dIb0FyQ21EY2U2Y3FhQkl2ZnFkUmNvQ21Sak0rMXIzRmROOThZZm93?=
 =?utf-8?B?ZnlmVDlud3pXT1p1dTBVdGNqbUtzR2tDeEp4VUpPOUNlZDJQOEM5WWQ1UDlX?=
 =?utf-8?B?c0trcklVWFJoeGliejdsTDVOc2E2N05tRnJtaUlkaEV4Q2VZTnErbG9QVDk1?=
 =?utf-8?B?aGZUSHdNSkxlSkVSV1ZEMnJpWm41UGk5ZzV0Q2NCUXYvS0NNVnFKNW9rL2x0?=
 =?utf-8?B?Tm5tMndWK0hzL3gvYWowMHl3aTAzMXRaKzg5S0VYS2xPSThHNVpZNmZ0U1hL?=
 =?utf-8?B?anZibERPWEgyb2d5MHRJN2s5Ukh6ZHZXcVZUWTY2OGV6TS9FdnBmelpBVmU3?=
 =?utf-8?B?U0VhLzFTWkJhRWJIMGcrZGZpMUJTVFZZdGZST1ZHM0h4V0FkSmd5UEd3WjFU?=
 =?utf-8?B?K09meDJBMFE1dTg3RjlIQTVtNy8xOXNXSlVoVFhPbDlXdmFrb1pyQ3NsRXdl?=
 =?utf-8?B?cHpGTXhnV2R4NlNWRHdEeW5DQ2NNa1Zyd2ZNdUFrVHhGU0p4S1I0Q084NUhn?=
 =?utf-8?B?Y0NJenRjL05lQlNmUG5LY1V4anByRnBYcFJCRzFEdnZIT1ZJVFh5VnloWk1h?=
 =?utf-8?B?bXJlcE8za0JBMmQ5eWE4ZnROblJKcUxPRjV3M1Bwb3lhSnovMmpwUWhXZGdE?=
 =?utf-8?B?NlNoU1lIUFdzYjRUVnp6azBUNTQ5aXgxZ0daam9aUFZYbWs4WlVsOWFLZlN3?=
 =?utf-8?B?THVGM2N5YTYyRGpBZVBmeUFucmZBNTJnbkVjSHVLbjVHR0lBU2hrUE5sVFhJ?=
 =?utf-8?B?YXVtWEFyVTYwMDQ5eDRBaWZ5Qm5EcUZmZzFrMGtpTFBwR2xIYktJU3NpcXFr?=
 =?utf-8?B?amNFaEY5ekVPMFJNQklwT05mMEczQ3RZMSt3RHU5VHdXQ1g1Y0xDc0Q5czhD?=
 =?utf-8?B?TjNPRXdxSXlkOVhMNG1wWm1VZkpmdEZHSUNTR0FITjM0YVhpUEdrd1UxRWpD?=
 =?utf-8?B?NURReklOM21GVi96QTFKVDkydVlVNndIdDlrcjQ0NTVGbFo3cmpSMFg2SVJ6?=
 =?utf-8?Q?21b2QzGMMWxPU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE1EWlZCazNFdlJFbEJEandjOXNsdXRGRUw0cnBCcXU0L3JSaDB3cjZTaGZq?=
 =?utf-8?B?bGhWUkY4dlE2RlpITTJSbGxIazNNcHpJWUEyWElmbkN0MUc4WG9zZE5lZXpu?=
 =?utf-8?B?S0tDNzhWWlVwKzhIWGg1L1lvQW1ZcVpSbDZ4MUVBenhacjYwOHZydjdtUlBa?=
 =?utf-8?B?SjBYUHlRelE5RThPM3c5RmFIZ0ErUzhRWDA5cTJwMVRhYThuUkxPWitKbFE0?=
 =?utf-8?B?ZTZJNmRIRGtsdGllVlg1bWN3dVp6UldIVDlJMG55Q2J6ajhWUzdQMGZTWnFv?=
 =?utf-8?B?OTNmUHBueTFVNGJWMHRXTEY2dXYrL3V3d0I3cjJxQW9pbE1mbjRDMmpia3ll?=
 =?utf-8?B?TExhMzZCWWZGSjdXanlQOWtKTE92eTNsQ2hFNVFnT1hxaXZGbGVrM2c5VjYv?=
 =?utf-8?B?UkNiL3NOKzJxVnd5a0FxOUZwS1hhaXdKemo3dXdqWXg0RFpNTFNObS9pR0V4?=
 =?utf-8?B?bUNCcGZaQ2kvQjdjZ0d6aXdwVDBTdEhuZm9JT0g1L2FmTlhETlZ0d1c5NGxB?=
 =?utf-8?B?RmZxZW5zd0N1YkVvVmhxNVRHMU9wa2JSZ1JJUGNIVWErK0MwdStvM2FWMHdB?=
 =?utf-8?B?M3JIWXJ2bmRQK0E2SG1FQkFFakJYSzdXZUE2Vy9sTE9IdlVlcHYwUlhnR2Rk?=
 =?utf-8?B?WXRWdmw4MUlTY3J6MFQ1a3FaTlgwenAwTmoxTTVmMWsxM203YUw2NThCbGx5?=
 =?utf-8?B?WFVlaEtJREt0cmRXMlBJMHhzY2pob1kzTjZhT0RpdTNCeS9tSitXRDhIOHh3?=
 =?utf-8?B?M2Y4N0g5aUJKT2VVRnNFTUZRN1Z2Smg2TG9KRU9PVkxsVDZEL1hIZ0dhaThz?=
 =?utf-8?B?SXZ0S0h2Tlo1R2RzendacWNROVQybUJEZ2pvUzZEakhIdkFrQ3JlSDVjZDFa?=
 =?utf-8?B?ZUpoMmhMN3RnZStzQTdGa2kzdlZOTjNSOVRaeTJoRnVpTDY1M2IweHREMWdC?=
 =?utf-8?B?OGVjUnYrWTdzVmhwVzN6STJ4Z1NmNlhxdVdScVRNcHYyWmltbWprV2dMOGQr?=
 =?utf-8?B?VU9GUHZqb1FYM2RQY1hEQ0pzQ2Z2dGtxR2IwT1Y4U0s3cW1JVk05Q3U5UlVS?=
 =?utf-8?B?VE1YN3JWSDNNUlBtSUxuc3FMUnQyUGJELzY5SU1FQzAvSy8yN3Q4YlQxbFM5?=
 =?utf-8?B?SjErM2JyKzI3VHYxTWovMTF6SDJNcWdUajFFdmhTbnkvcytuamEwVlV3cXV4?=
 =?utf-8?B?YjkzS2JHU1FJSlZQZnUrOGZqNEJtdkFNLy9Bd0IvM3JqOVZHaGRBTXBHMVJQ?=
 =?utf-8?B?VlliakltVlFRbzBUMnBaL1RJT3ZZWDM4YmdrVkt0b1NEcHYwTzlOOFAyQWZL?=
 =?utf-8?B?dzBGQVJyUzAwNmpKMmQzMnBuT0x2OVk0N0l6T2dPZEtTc0Jld3M3YWxpUEVL?=
 =?utf-8?B?ZFBsbGZEdlIrS01XcEQyK3k5MjdpSDBiSUV5cG1ad0dpZmpWM0tOaFRVREUz?=
 =?utf-8?B?SmhBMkR1Zy9oNTAyMGw1UUduL2ZuUnpqR0xFenYyYm45eXRrL2VoejJJZUJi?=
 =?utf-8?B?cVRLcDJuRWFuQURza2t3cXkyMUJVMFpWTU5GODI3Y2RET3o3bUYrdS9qbldS?=
 =?utf-8?B?QmZmWFRVRm5OYXlxcHowb05TOEFteFlCS0I2QlJMby9YOUgwZ0hQRkQvK2ta?=
 =?utf-8?B?ZGJqd285Y1lxRDhWRDhybzNTbzBXcXhta0FFemh0dTM4eHRJM1YxL2RKaUtr?=
 =?utf-8?B?ZTgxOGlaWXhBbW9MTXVtcEZYSTdGUUZVVmMxZW9OalM0aGNrRjk3akQ3VERJ?=
 =?utf-8?B?SHhGYnBmZWZWTXBidm5iWkxsUmUyZjYvUEdzM3JPQmVIb1ZaSkhoWmZJOUZy?=
 =?utf-8?B?M1k4V0dkaXh4SXJ4RUNtdkRpRTVucENBNk5wTFZSYU9Fb0F3aFlVVUV5eTlC?=
 =?utf-8?B?dHlCQUFFaEVSa3dwcmZiOVl0TzF4RzlwSWNNQjFpS0o3S0JIL0NsdEo0QlJn?=
 =?utf-8?B?YVpNNmlmaEVzZ3hTeEFEc2Z1Vk94VnA2dUc5SmJEMUZPWm5mb2hiMnMwQTk4?=
 =?utf-8?B?U0h0MXpSS0IwVkhMazEwcEZNZXFiZ09SMTdra1IwQXNxUkdGRVhjdEdxRUlp?=
 =?utf-8?B?aXhqVTdqS0dzMVpXQmtpZklxR2swM0N4cVl1MmNpOXczTlBVZVZXc2Vqc1ZG?=
 =?utf-8?Q?lM3o+NlUt87hgx+96YSNfBGng?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85853293-25c6-416c-1f4f-08dd4f549fb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:11:43.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CArb/Nnt4kcqeNRNO4H15b00jqkF2p0EH3Ors8PltFVXvDdJHoNAprbyk8aDWFOGHt7d+pme34GA5uEjb+ZuEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864


On 2/7/25 13:03, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 03:19:26PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
>> device.
>>
>> Make sfc CXL initialization dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  5 +++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 16 ++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 60 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>>   6 files changed, 131 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 3eb55dcfa8a6..0ce4a9cd5590 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -65,6 +65,11 @@ config SFC_MCDI_LOGGING
>>   	  Driver-Interface) commands and responses, allowing debugging of
>>   	  driver/firmware interaction.  The tracing is actually enabled by
>>   	  a sysfs file 'mcdi_logging' under the PCI device.
>> +config SFC_CXL
>> +	bool "Solarflare SFC9100-family CXL support"
>> +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
>> +	depends on CXL_BUS >= CXL_BUS
> Hi Alejandro,
>
> I'm confused by the intent of the line above.
> Could you clarify?


Dan original comments will do:

https://lore.kernel.org/all/677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch/


>> +	default SFC
>>   
>>   source "drivers/net/ethernet/sfc/falcon/Kconfig"
>>   source "drivers/net/ethernet/sfc/siena/Kconfig"
> ...

