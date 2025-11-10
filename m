Return-Path: <netdev+bounces-237155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03EEC463F6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC4F3A47AB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0E2F5A18;
	Mon, 10 Nov 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ohf6SAzO"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422751D5141;
	Mon, 10 Nov 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774094; cv=fail; b=oFIZ5TVQVUvm57zl8P1zMxtIIwIFDsulhFMloCbCAYf6TlRAlIi5GdEICgqJrgTWZzQ4303Mb2OR17MX7R6b6+54vjoZS9YFkLt7zXxXzhigBj0UhaIstkojJFe2M97bILDYqer2jaSzHcv4hujxWwChHGYGXDNqmlGr1LKHmuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774094; c=relaxed/simple;
	bh=Lp62q0HYTU87H556yzpZ5rM8KktzzzbC5HY3rF2vdhw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E1rn9gR3R8V/0VDKZGGVaE/HGfExpKoi1FqdqCfGSbUhBMimxPuoDlss6V++3mSRalFOY758K4Y0Pkq5O1MsbYdKDhreTuMreZQZvDtz2snNYb2fOkhKdHD2hqW0mMHMXFkZlTgdUiY58ceDBSKxG/x2qAGj27FBz3VeVBSlqCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ohf6SAzO; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFarAInxS3NdNbEvNgnZ1fmlduCeKmvGR60DG2QfaKf8bp5wfnAABFNiFM86wBAdkXC9mXjxlBMs6yeo0uNACRPtpkvwD/FFZ7/QxD5ViBtLVEf2bc9dIftIec+M1maYtGQs59LkVXh6ZXrsU9kliwkZHxYGhpEisvUd4wsjazwect5p8b7qSm6oQFF4HKavvi5BliZtaEKhiwwqWpEb50DeIBdco1PDzlbYzDg5byCJk+rpYfTbhedXOiuFn4Jy/U43MHdEeVi6AuaI+sGfEn95AywMyWx28qy/xrm/dbDZe3uYozCOq15sikPbAazcojkM1TjhqyVRNjW82r6oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX1sSOJwgjgSkCPYnCgtTiot0i5NO0D8aKSOd3f8dDU=;
 b=Y47xy3Qj2txk60E58powaT++1BaN9wnckJgEjHYjiDN3Vx2EheR3l5mSTAPN1pPemoIrD7O9pTbqPfR7cuFfqYYj2NS/KrO1wp9923ea3GpxWzbiduPc6PFQJc3A3joN6NnCyJHcbNsWiIXJLx4I/lD1QLI/ZWTvxkCKTl8ieE72hCnaD+NqYT+ssifZBLwZg8VkzYXqaSTOBRMbRXcdvE2EpJd60cgUCqbT/Gbas0JfwxfPhBIeyB88qoDeZR8FXs+5Dvb1u68RIcZyL2/X3wkv7J1FCGHnNYsI3KgldBwRRdYG/1Gx1gprSEX6mfNl0dnNV/nRBFgk8k+G8xmaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX1sSOJwgjgSkCPYnCgtTiot0i5NO0D8aKSOd3f8dDU=;
 b=ohf6SAzOu87prUEYhSnF2pjYoVJ+u06MBs6UHkEnz/z6EhZWqcR5kzdSkZFeupVdywGlz8VSsPBCBKxc7DA6E9e9pRmp4akI+shr3MTEM4ci1ugaD3J5DqrrxthMn6IVFHGBX5+lIEYvdOyOsMIPSXaURZ34eVkPAv1RghdyLUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:28:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:28:08 +0000
Message-ID: <1ada6169-1ed6-476e-8602-98f53c8ddff1@amd.com>
Date: Mon, 10 Nov 2025 11:28:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 07/22] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-8-alejandro.lucero-palau@amd.com>
 <20251007141822.00001c4a@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007141822.00001c4a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: b732b115-c1ae-43c6-0926-08de204c3869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlIzKzBzNjcwbG5hTDdpajF2MG5uVkZzMFdycTV0N2h6eDVMVUdqYUlFTm1S?=
 =?utf-8?B?cDBVL1VXU2hiUHk5b05FdEZGU3NaNlIrSlVrQTk1WXYyTmVjUDR0b2Zzc1JM?=
 =?utf-8?B?Z1UrZzlqTXowTDVXblRFQjFvR0ZGOTB6Wm51VXYvTEYyN0c5NFh3cVlpR1hQ?=
 =?utf-8?B?Rm5iWDhBc0VQZ2NiWlBBMVBObHl0RkhlVkxVamk1dXhKakRHdzhZa3ZrSTlD?=
 =?utf-8?B?Wkcxc0QzbWQrTjc3SFpDSUdBWWpSZGwrcXY0R3BXTkRKV2k2ODVacjJsRmJD?=
 =?utf-8?B?TzR1MnF0V0FkdHhWNXJ2MXQwRzdRbXhUcnVxblNJWCtUaWl1eTh5ci90aith?=
 =?utf-8?B?djhvV1g2NXFtc1F6QldUM3RMWGJveUM3S0FpUldXN3pYQXZLaHN0bk45Rjkx?=
 =?utf-8?B?R0RwM1p6MEpEdTJZeHJCT3RGNG5yWTVPWXhLK3FGb3gvaEYrYy9vbEdNQmFw?=
 =?utf-8?B?Z2lMcW4xMEZOamd3SFNIZVNiOStlUERQNFFPTjZIemR2end5d3FHeWptYlV2?=
 =?utf-8?B?YStQZjJWRkwvUFdUWHE5N28vdHBkeU9oMUpiTTkyRFY0c1RHZjEvcG1ja0lv?=
 =?utf-8?B?djVtNGpFMXhmTHc0YzhoU3NiQ2NGWXhaNXdqMmtHRGR6ZzVENmtwTFZxS2NC?=
 =?utf-8?B?emYzc2R0YWMxOHFtVHVBUEhUUDNVNElTZEZ2cU1ta0dtZkw3a2UydXJjd250?=
 =?utf-8?B?RnpjUnNObHgvR21EdkdROGJUN3NUeHZkM2VlNU1ZSmpIL2NVRnAxbHcvejZh?=
 =?utf-8?B?UFZLYVhNNHdEa2dhZFp0ZUVoaXRmWUNRYnFwQ0tOSkJ5U25RZ2VLblZGd2ZL?=
 =?utf-8?B?U1V2enU3SWkxL0VsbkRnNXVENHlINThqOGM0N1ZidG93RUpGaXNWQlJnUjRT?=
 =?utf-8?B?dGx4S2lYWHo4aXdEdDdlNUVZcVNmUXdtMUxnUFM4aUlqTFNHWGVCeWx0UTlp?=
 =?utf-8?B?NXc2RTlrUExUVEtpZVhuNzg3VG1wZ1ZrSWFMMlhRa0NSS1NodXR1WWEzQjZv?=
 =?utf-8?B?cG83SUQxVXNrVXdEc0QyZ1o3eHFPWngxQ1Z3UXdMQUhxK3dMS1Y0UVZvdlB3?=
 =?utf-8?B?enJYc2FKN2doWlFZdU1jOGU2c3JEellHVEh0Zi9BL0JJYjhtQlp2NUlOSnpB?=
 =?utf-8?B?cXhqZ3JKN3NRSDRmRTNMNGxaRzRYWHNYMzRJRDYveWJYZVlyRk5oT0RUeU1t?=
 =?utf-8?B?TnhCRmVYODBRQ3B1a28zZzlma1UyQmkvQWkwRXgrVUhjWFYrUFExSEtJb0R6?=
 =?utf-8?B?ZUtablRDSmtTdjZFWk1UbTQycUMxSHVzdjZiRTVoTGdWa21PbU1FRkRIZWJj?=
 =?utf-8?B?bmt1ZG1vbURmMDYxbWNxazFLZU9tL2FjMXRWMnZFMTdIenJJVXpIajdrTnRx?=
 =?utf-8?B?WkFCQWFRc2ord1VIVzArbkpNVUsvVWMvZ3h3c2h3dE84eUlNdXlxWnl0ZU9j?=
 =?utf-8?B?eVNoZXNlZi8rQmxKVTRhVUl1RmJGRWJqcnYwUWRUOW9rYzNCU3NsdW1WQit5?=
 =?utf-8?B?VUJPbjl1MmZWM1B5OEpmQm5pckpLb21GWGpkN1MwS3NPVFR3K0E0LzBtdEhM?=
 =?utf-8?B?aHlLR0VmakZacU03b1granZBd01Gd0JPSG9xRjd3MlIyL09JbFVIMjhLRkxQ?=
 =?utf-8?B?ejg4REhrMVNhd1lUaU9leWlLc1BjL0lHRDZCcXZNRDRUWWU1OGdrd2JrN0dT?=
 =?utf-8?B?UVQvTEhqVUxsYXhQTEdPL0hIUUZkS0V4SzBXQk5jQVcrMlFGUm5HaDFuNDZm?=
 =?utf-8?B?aDY3UCswalJoMklnNWR5Wm90Z3NFdVRZcVFkTk5kQmJlOVhyV292a0piTjdv?=
 =?utf-8?B?N0M2QTlGbENQYWE2VkluRkFmRm56aFVLblNXaG1PcGM3bGhmVGJPRTBpOUp0?=
 =?utf-8?B?cERMYnJPclNTZlY4RjJNUGYzdGVIbmM0VE1hY0d4WDQ5NkNUbTdiWldqK09a?=
 =?utf-8?Q?m0AH06RAeUyswVG44XoY4amRM6srid/Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFI0SFl2bUNnRW5aWS9BT3pJS0tTZURHeGdZMTM5UDRHd1EzcnU4SDdqUkVM?=
 =?utf-8?B?M0Z6dVZ2Ykd2ZnJXcDJRMFZwb3FNV01DVjUya1VQRmZtQ1Vod2RpajA4aVFu?=
 =?utf-8?B?citsQlhNTDJ2TENZNzVIY1A4bnhEN3VBWVFYSTgwVDZ6M1cxQVgwcGNwVHBj?=
 =?utf-8?B?Mnp6SllwK0hRLzNraDYwS0FiWXEzeWlqQkFOUHNQTnlCVUEwTXhRTmRndHJj?=
 =?utf-8?B?KzAveVI4MXE3VzVwdGY0MEZET2srdzh3UURRalowbDFIaWhZVjIzeDJLT3k4?=
 =?utf-8?B?YnVDNExnSWNSWnpkRXVzWnNnYklQU01DNnIwZitoMy9Fc1NSUEJwOFRLYVVz?=
 =?utf-8?B?S2RZL2lQYmhrRzlJaUV6UEcwQkNHSWVlZXZNd3U3cFhqelFWcVg0VDhJK2N5?=
 =?utf-8?B?K1RuVXh0MkZveUpIQTAwaEN5b1hNKzAwNE5sV0IzV2ZBQ3FkYmNPUWphdjdz?=
 =?utf-8?B?ODJvR0hIWEkzUmpKTTN1MjhxelNBdVVQei9EUDhMU3lFMW9nckZDYk1SZFN0?=
 =?utf-8?B?SG9QNHhoU254eE5BeTdoSnN0SU1HVmZLVnJNV3BpRmVnaWJQeVF4NE5EZVBE?=
 =?utf-8?B?ZXd4ajZFZEJTNUZMODdDWEVuODdRcE54Mis0RzFHbmRPSnFnaGxNSzNjcFMr?=
 =?utf-8?B?cHd4YUZONG8xeDZhNFlqdlhDY0RGMm5veWNPQUsycWRleEtMQ0xTNk9ZZi84?=
 =?utf-8?B?b0lZbW1RdG43WUlrVElEdnQ4V3ovYUx5VlJLQi9MdmJKQUFacG0wdzNPMGQv?=
 =?utf-8?B?V2FxbjZrdFFiYjhIeEcvZ2RSdFVROS9PZUl6clI1aDhCY1Z0Vmc5dHgxSWp0?=
 =?utf-8?B?b0dzZ2p5Y294c1VVT1lySjRYTUV6MGltYTQxeFB6d3JTWUdZT05ORDAwdHgx?=
 =?utf-8?B?djAwdUVteW9EQi92ekl2ZXh5KzdLc1JYWDBCRmxnQ1kzVEcwVUFCTFRGRjRE?=
 =?utf-8?B?Y1c4UXRJUC9lQjdYRGxEMzdpaEtZRGZnc3VXTVduRDhEQklDbDA2aWJaRzZ0?=
 =?utf-8?B?dGJHMUVrbjBodmxTcWVqTUF4Yzd1VHM3VHh5dUVFOEp3SHFiK3J4MDNLNkpp?=
 =?utf-8?B?ZGoyWTNtd0pJN1lrM3MrUEZ6bVpDU0FMOXJyb2t0WE9CY0xhK3loODhtMXBj?=
 =?utf-8?B?VXo2OGZYSzA5bkxOOUpMSnEzWmowU1NvaHN1cnI1WUorUHdxY1R2cTZWQjhU?=
 =?utf-8?B?VmlaSytvYXMxOHFwT1JqUE9HR3BaMEZ3V0xPd2VkRmZvZ24wWEdpeWc2WjBl?=
 =?utf-8?B?L2I3S0N5TXlEYStZMFRPRTZUUGlIUzh2Y1FHLzhDM3V4ekl5Y01OMHFCSWll?=
 =?utf-8?B?KzJFQVFJenY1ZlczeFIvVmJxY0pRd1ZWejU2K0lzL0NjaWc2N1V4Qk9YMHdp?=
 =?utf-8?B?WjQ0UjVNblRnb3VmUHRlVlU0SlFNd3F4OGFYT1pTTTBUUURMYVVMM2t3N0Uz?=
 =?utf-8?B?UGlzT21NTERlV1VKTGVBQUVnOElQQjRhRGJOVXhIWEV4WUdGSk5oeXh6VUNn?=
 =?utf-8?B?Y3pFdy95NVJoYlNlZ0UwZ2M1VWNSUXVLQkxvSkV0emVkMlc4NXhCZVByQzdo?=
 =?utf-8?B?UExRVG1ZRFV1NHFHYVlYeXd5aU5XcUFNV3d2Zm5zVmExNm5yV21waHdrNXB5?=
 =?utf-8?B?UG5nb05FWmhiVkw5UkdQTjdHZkhrNkhSRTk1cWl1MEJYSjlhWFRxbHd1M1dL?=
 =?utf-8?B?TnJtRFZ1dUFHRkR0Wkg4Z2FOWUt5emRrcVh2cFVDUDVTT1BiVnkyclhtVGNL?=
 =?utf-8?B?cDBTQ0FGN0dmai9lTTBiUUkyZTVnVjlEajlnRVVBRmdiWlpRR1VVdFZpdzVr?=
 =?utf-8?B?WGtDa0VQdGEvc280RVlLdWVnbWhTa2Vma0pKRTdNeDNyNS9na081SVV6eFpj?=
 =?utf-8?B?TFByZm9wY1BOMHE0eDNqTFpFSk85WVdJMGJueW5VaFBkWmZQZjlFd2N1dEFr?=
 =?utf-8?B?WmZoS3lJU1hjS1RLaWFCT3NXZUtaU1FLZmxDTmQ4V3dhYm4xcjZ2dzZOQ3JK?=
 =?utf-8?B?N3RiV2NmYVE2b2xyU3FDQytLSWloSHMvS0JHVEVjZ3ByTWUrUHIwME1jNHFP?=
 =?utf-8?B?NEx1ME11d1E4SkNvMXV6Z0xtOGpmWmJMUE9yZDA3R3NzSWMxVWFaZW1lSVRs?=
 =?utf-8?Q?sLzXQk2V8bqP1YDYm3D6CXFY+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b732b115-c1ae-43c6-0926-08de204c3869
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:28:08.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y85qQxCkMRhkebsHd8R6P7ANT9x3GKuFPG+w8fA5z5Z7oU8Uj74g5BX1FVJL2kmYi0xZX75x3kwDvB5HrdrVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732


On 10/7/25 14:18, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:15 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> I'd amend the patch title to
> 	cxl/sfc: Map CXL component regs.
>
> And talk about exports in the description.
>
> Other options are fine but the patch title should indicate
> this is being used by the sfc driver.


Yes. I'll do so.

Thanks


>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device component registers.
>>
>> Use it in sfc driver cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/pci.c             |  1 +
>>   drivers/cxl/core/port.c            |  1 +
>>   drivers/cxl/core/regs.c            |  1 +
>>   drivers/cxl/cxl.h                  |  7 ------
>>   drivers/cxl/cxlpci.h               | 12 ----------
>>   drivers/cxl/pci.c                  |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 35 ++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h                  | 19 ++++++++++++++++
>>   include/cxl/pci.h                  | 21 ++++++++++++++++++
>>   9 files changed, 79 insertions(+), 19 deletions(-)
>>   create mode 100644 include/cxl/pci.h

