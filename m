Return-Path: <netdev+bounces-128535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D051797A25E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0005B1C23087
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA9142E77;
	Mon, 16 Sep 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvXs++ZG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84E47A62;
	Mon, 16 Sep 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490081; cv=fail; b=kZqe6Qnme2ja6fHKpbbNZZ/Uj2SuFH5XDeuINK2gTd+LsfFSHeeawh7Aiisf93bDSXrPVfqZPiZ4jeCNsbxWVAO+OplWdMLwn+pBbowETQTIMLHvyTIT6VRekk0bMvDKfBpzAC3GhuAVIJxBEb7vOsKmZvgHns0DIB01m2tvRdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490081; c=relaxed/simple;
	bh=njLC9ZweuxiG/nLF/0cdiAoVn8Z2KxG0z/tlhwUo0zI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oXWsuks8E7q4FwMqOtk2H36D7AKhhp3nQoy8bJ3pqctb+yQNwnkhAxEwIJY0ep1uqOiXHDegPBDq5ByvIXdrseTBSpY0DtB8mJ8ThTsgq/q9IQeixd/NpMW3EStlnsacajOC/Nt3EQRS4BIMu8MtKC85dyJuop/bVS8ezrO/LVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvXs++ZG; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7MfJxZUlL+2EESTG+83e5hg4/H+3zEj/8T5xpzfef5wN0PZ+bVDpSndgYe1Jgih5KSX13mtxwj7gAP378UWSIi5vxe0L22/Zl8u8U6VLnwbfAa2g3PmO5ewOpMmwHz0b7tItm4PdXqd5k6UKG3qbgUX6cAOvKb2WY2HKw0DNWKzIFBFYPdCPvolCBunLeEFquc1r7DAxGKaKmUR+w+m3aATJJiwITLQAcsGe35Z2isQBDZjjBG/IuJ8pzK9PoY5jsw4MYW7JHPg/AK3HPLHfWpoTcTmdgR2TkyZAVKULoPNWJz3f8cxRySFFoObIpofQhWYibaa7W+sAHlfevO9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsYALxN7MbZxvSxmkDoENFBl4L0+dPUG1fQE1sP+Ig8=;
 b=c0tE0/VW0IeR0ncqts5ufETfNjqUToSUoVzaS1wHejhRxEc5eGLDItYG3ZdThkxGYUCYtHQ7/3IM+B3lyB4nX87ozndBKYPc3bMY16hHYgYz9nTAn6ZV47XwU7++XtjqFZUcRQsZ1Cd90u4VRDCg0xnUQMNi/d0gPt8JxKQF0SPq0wBVK7kLFUpCdpW5QLhr9pqa4e3VdkLI+fX0a2HWtIAqUJZ7Ssw9f90UpIjF3cnYfjqKYQ0Nm5c2ysmU5wPibs6lS4gQC5JY27lXj2KFVa7y2mLVHE6M4/N/73EffXRuDjjZjvNPtO5eMoR6ut+ir1z+2aAzntHFWrB6d0/f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsYALxN7MbZxvSxmkDoENFBl4L0+dPUG1fQE1sP+Ig8=;
 b=NvXs++ZG+vMj/DtilFzxIqybuwyDFfZZ9SmuTm64yDhNoa2JhZmzJHCv1KDSUuwUv317AxbrNfDssy3g2oEUOslDv4sDc/0t0pdpL3jD1ciL1OlsBk8AuP00y6UlDiaLoNwjCHJbCNjcrpWwf+/PC6NcUUGP0CbBhSrxqycfXi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:34:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:34:34 +0000
Message-ID: <9c01c578-ea9d-bca6-2544-addd0225b003@amd.com>
Date: Mon, 16 Sep 2024 13:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 06/20] cxl: add functions for resource request/release
 by a driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
 <20240913183520.000002be@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913183520.000002be@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0384.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::36) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 54275492-fa50-4e77-1c29-08dcd64beba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnhmVGVIOVdiWHZGQjNaRTBjVjBva0llVHd0ZGw3SkNxdVdPYkZSa0tSL1BK?=
 =?utf-8?B?K2dVZWtkbHNWUVd3RWdIb1c4cmNKa01yRzVEVXdyL0VtakN4dHE3UmN0czdN?=
 =?utf-8?B?QlBVS0lkUFJDNGVJa3N6c3JCWDhjakFNcHFwL01ZdGhYWFd1U05BRDBTTmJR?=
 =?utf-8?B?aExqaERFS0d1blpPcUdYSzJVVXlZeFZuamxsbXN5dDNCc0J0MHFINmE1NzA2?=
 =?utf-8?B?ZjRmcTl6Mml1aGlDWmtXYjFPV3JKUGh5STlPWFNiS0x0MWxaK3FNemZFcHE4?=
 =?utf-8?B?K29tUGtMbVdyejM1TW9MZ3NBcGxGMFhFQU9nUC8xM285dmo3dHozTUxzbHh6?=
 =?utf-8?B?NnNQbldXaDlhNFRFTDNIUmdXYjdQdWdrV1ZHaU05eFZNc21BcjZyWnBRUnFs?=
 =?utf-8?B?c2k1VCtXL3ArdE5QYW5nQTJXaGx1clVzNnNOOWs3eDRhSk1JYktDWElnMzls?=
 =?utf-8?B?Nnc2clpMZ1RDZU9TQWhkUEk5Y3U2V2xxTEZjRnc1NFh2djBNRUJJek5YcFBl?=
 =?utf-8?B?Y3RIZHBMRXhOY1Y4QWlteFJFUGlkeGhFUlBEMUYzUGU0S1FxNlZOckQzNzZk?=
 =?utf-8?B?R3g2ZUxkcHpiOEluUkk4NnhhRjMrWmx1VzRaWWhlSldmWTlNZWlkZnBaS09S?=
 =?utf-8?B?TVJpOVFPRzdCU0dLdEJ1MGlKVTBoN2hDZXZZUUc4N0JyK29ISG0wOVZzMjc5?=
 =?utf-8?B?SUJKdlRFaHB4UnBJd3o2R1hqT0FVODZXSy9ubjgvODlPOFZ3cSsvb2xHbVdR?=
 =?utf-8?B?Tzhja0xLWkIrYkN4MjlWbDFkUGtkVVo0VU5Hd1NUWGd3bHZYN1FwQVlxdkR0?=
 =?utf-8?B?OHRWSmMxVHpXS0Q1TGhBMmtaTytxd29MTEJ6UU9tM1hQY0dpelByNSt4aERV?=
 =?utf-8?B?L2J3dHI3NFBPakhNeWRoT3EvUEhRcEJlbURlQTJiZHlqZTBVSlY5U25sQm9n?=
 =?utf-8?B?bjJmbFc2bzlJeXhiaTkrQnBEdHNmcW5nR0o1MmdXQjU2NDhxRlhIQ2d4UFZw?=
 =?utf-8?B?c2NxKythd0VHb2o1dW1kWTZuZ0dLRC9CZWZmYUI2ODNQRlU2U0VuMVViUkxs?=
 =?utf-8?B?QWt0Mk9OSTdUVHUyeXIzdGREV1NrWE4xdlBOU1VoV0l3VE9PMUJ6V2ZQcFdi?=
 =?utf-8?B?Um5lZVJvSFJ2ZEhWcjRYanFpWDVEN09GZW9WVmdrNGxzOUtsbFVrZkZ4dVB4?=
 =?utf-8?B?OXQ3TWk4ZzZ6K0hOclRDQVhaRFdDTkhYOG5rYXM1Z2ZrRlJoNWFHSkc1L3pX?=
 =?utf-8?B?N2FYWkx5V3hoa3AvdmRaeUEyeVlLaitYS2lyUitWMTJQOE5pVE9ySitVLzd1?=
 =?utf-8?B?Ynk3dDhQTG8yZXNaejg0OWU2THFIT0RZU3prOUR3dzFGVnNEdWMzV3gyY3N4?=
 =?utf-8?B?amhYSHdUZEVRbDJtaVc3OFAwUzJ1VlUra1pOcW1yUmNtT1dNTlNyRXlWdlFm?=
 =?utf-8?B?M3dzZTZjVGpsbHgrWHI4K0QybjR6S293MlBRZjltNm9VNHEvNnlHVjZzWmpz?=
 =?utf-8?B?aHl4ZWNnZ1ZISHozS0RDcjcra0ZibHdXYzlKcUs4MGhZaGtpYWUxbVZwRGJD?=
 =?utf-8?B?VEJFVUo4aHd1blllbHRLTENzR05mYUZGZTVmWDNXaEsySGhvQldndmF3a1lz?=
 =?utf-8?B?bjQwWXN4b1RzcENOdmZ1OVlGdksxSnNLZzJoNkk2c0N5VkVqWXRCU0pBblBr?=
 =?utf-8?B?bmpFcU9nQ25rL3RUNDEzS3ZxZldPN00yT0dmUGZ2amx5ZS9mT3FIWkJ1aDlS?=
 =?utf-8?B?MmNIM0o2UkR6MVp1VXlwbVRvYVh3KzJJakJEN1hybWEvNVlCMDRKTDBiVjZx?=
 =?utf-8?B?dE1DelhZejY2clpSYWlWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHlEVW9Qa05meWZJSFp5UGtEdzBLdGhFNTVBVHNzU2QwOHJyTkRManB4UnVa?=
 =?utf-8?B?YUNYeTJtc2dZSjFIdW5PUS9Sb2xyMFhFcHpydHcxeXR6S2E3OVpVQ2lxUHNI?=
 =?utf-8?B?TXd2K0tDendRTDFid2R6R29qenpVOXlsRXdlai9YWFdrYXMrMkxtTGtyNEtp?=
 =?utf-8?B?bzM2cVk0bnlwbm1tcC9KeDlXZDNLeFF2ZHBYSkpsdjNKcTdzLzZyMEVIMnlF?=
 =?utf-8?B?eVY2ZXZ0cEd6T3pCTURLMDcrLy9sdjFmc0Y5TnRVN2hUb0lWcHEzSzQ2RzZp?=
 =?utf-8?B?TVE0RjJSTXhBQlJkOVBzL2NxQU4wUFJJa1NDK29yVllHS0NVdDN3b0lBR202?=
 =?utf-8?B?WTJiejY3d3BKZ1EzM1NkeTJadE9RQUtGSml3Yk5LbDdZb2NXT3cvUmRsbDlU?=
 =?utf-8?B?RkU0ZWJCK3ZEWlZsR1Q3N1V4b05sdWRGdE9FTnJUQmVLUkQ0R29pQzNWVVI2?=
 =?utf-8?B?Y0l0MlRKK1p1Z3pwRXFGN2V5ZUpwb2luQXBVL1VhQysvc2RINWRwZ1ZWdERX?=
 =?utf-8?B?SlhMQVBhN29xUUlLaTdOMk9KSTJvWW5UZktHOVhDUHdCVHYxUUtVdW5tTHZs?=
 =?utf-8?B?UFQvQlNCRVZ6VmdENm5UOXl0SWVHREcxS1M1UG1lazZHYWdkYTdKZW9sdG5v?=
 =?utf-8?B?Q05RQk1pOU9RZHhCaTM5MkNDRDZ1Q0JwNk8xcm5DQWpkRm1JUG1TclFoY0RQ?=
 =?utf-8?B?Z0UrU01PMHFGWFZaeXJabXBHYUFlRUIrSVEyT2k3OG5wWnNxcHFsQk9tSjI0?=
 =?utf-8?B?N1VuQ3o0WkRJbDBYZkNiSDlBOUNEZW5yNGFDNHdmVjhuK2pGM2FDSEkvdzVo?=
 =?utf-8?B?UkNQTzR3K2V5UXdMWExoam5qUTZtWlc2aVZjbE5Ua1JFT3FEenZ6WVlwN3NV?=
 =?utf-8?B?YXhIZ0tQOFA1RkFaR05renlCeDEwUFFNNkl4RWEwd2E4UnRuWU9Cbzdyajdp?=
 =?utf-8?B?L2kxYndMSUFqTkFkSnl1WGZmcGkvb1dEQkt3Q0o4bllZV2dVZnJ4Tm12S1pW?=
 =?utf-8?B?dHJJQVh1bGlobVV1MHNYMkx4L2pOVGFTNG9WSTNXMi9ac1RoUzF5RUtDZUxn?=
 =?utf-8?B?a0hRWFBIZjRpWlpNNzJNU2VQZU9Xa1loNCtpNWQzcnJrNUlBRCs4QnVEWGk3?=
 =?utf-8?B?QUdwb0tzeUhXTGtpTXFlN1N6RWpwK1JrV1U2eXNZVXVRZXhrQlN6V3d4NzRW?=
 =?utf-8?B?TnpYNjBrOG1ncTBMZU1Ub0RVTkp4WmtuOHA4VHBJUk1KSmpMMmFVeklrQXRy?=
 =?utf-8?B?eUt4bFVieWI0TlVyVnVpZHF6Z3FMSWZ3TDRHUlZ5K0o0alRCbUY1a1FZNDdw?=
 =?utf-8?B?ZEl0S1I2ODgyZkVUSXVxeXBqVVJTOXBoM0xkTnRhTXRRaDNSV1J2MnVxZm5t?=
 =?utf-8?B?THpBSHM3NDNiUG16YTVvN0I3d3IwLy8zMnNZdmhmWlFQeDA2b0M0b3ZOcnI4?=
 =?utf-8?B?RlVaUE0rZXg2YXJ2WFlEeTRlRmdXOG9kRHFCZUNSaE5oMWZhWUZnODllUHoz?=
 =?utf-8?B?clJsWWNVUStUS1JkblNYRXovMlFjOXlHRDBCcktaRkNnd3VFcCtHbUZnd29u?=
 =?utf-8?B?ZlJjUHNDOXdaVk5DUXFSZnhTV0doWEhmbndTSldVZlN0eWkyVnVwc2llbGdY?=
 =?utf-8?B?ZW9mRUVVQW1zZE5YNVdyd0RGblNxQmc5WUEyZFBoZWdHTkFFUW1vbVNLaUFL?=
 =?utf-8?B?YjRkeVNlelNzL1NQTjFiaEV2N3VXc2I1dVB1SCtBRS9BdjJvdnBPNHVXeTQw?=
 =?utf-8?B?Y0ZjTWkyWWpvMmtLTFB3UmxmSkkrWEVseEErUS9jWUg0RXE2SFllQXdCZGp5?=
 =?utf-8?B?V3hQdnVXOHJXYmNxVkdEc3FzVE4wNWdiNFltZzUyQW56YWFEMFR4V0ZiN1Ft?=
 =?utf-8?B?Y2NZcUY4K0JvVFd6TzNwWkx1em02NDVOSlF5ZDNSMWtwWTQ2Q1p6U1dFZE9N?=
 =?utf-8?B?MXpyd3FleU16UGl1U01xM3lrUklsWFU2TDBreU10cURtQmlKWTVFYWhtS1lT?=
 =?utf-8?B?UVQvcVdKSkk4dTVDVW5vSGV4RWxGZDVGNjFKUEZuZHlRVHRVdW1IMEFkaTJl?=
 =?utf-8?B?U3U3K0hHQm9VZHJuSStGaUQ4Y2ppdEUzeXA4NjZuK1luZ2c5cHJyUWx1MXBG?=
 =?utf-8?Q?+IsWSYbFk+OB6yqUsI83s2ZGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54275492-fa50-4e77-1c29-08dcd64beba2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:34:34.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmjPhbBa9zxRGCHVNKQ2RNq9+Q5/jarqwBXvEIJp87SYaas4vYSOh6vCG3K10HeCVar8X22NjuuPdD8FToC9+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267


On 9/13/24 18:35, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:22 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create accessors for an accel driver requesting and
>> releaseing a resource.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 40 ++++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++
>>   include/linux/cxl/cxl.h            |  2 ++
>>   3 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 10c0a6990f9a..a7d8daf4a59b 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,46 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>   
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_RAM:
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +		break;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>> +		break;
> return request_resource()


Yes.


>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> No unknown. We know exactly what it is (DPA) but we don't have it.
> Unexpected maybe?


Is this not the same case that you brought in previously? Should I keep 
the default?


>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
>> +
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>> +{
>> +	int rc;
>> +
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_RAM:
>> +		rc = release_resource(&cxlds->ram_res);
>> +		break;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		rc = release_resource(&cxlds->pmem_res);
> return ..


Sure.

Thanks


>> +		break;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> As above. Probably know what we got, it it unexpected not unknown.
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index fee143e94c1f..80259c8317fd 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -72,6 +72,12 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err;
>>   	}
>>   
>> +	rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL request resource failed");
>> +		goto err;
>> +	}
>> +
>>   	return 0;
>>   err:
>>   	kfree(cxl->cxlds);
>> @@ -84,6 +90,7 @@ int efx_cxl_init(struct efx_nic *efx)
>>   void efx_cxl_exit(struct efx_nic *efx)
>>   {
>>   	if (efx->cxl) {
>> +		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
>>   		kfree(efx->cxl->cxlds);
>>   		kfree(efx->cxl);
>>   	}
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index f2dcba6cdc22..22912b2d9bb2 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -52,4 +52,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>   			u32 *current_caps);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   #endif

