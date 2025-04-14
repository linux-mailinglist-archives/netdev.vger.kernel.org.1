Return-Path: <netdev+bounces-182218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DECA882BB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933531733CC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416782918EE;
	Mon, 14 Apr 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HI8r80mh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB42749FB;
	Mon, 14 Apr 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637302; cv=fail; b=N6DS+b357UsDdkCCrJmpgbZGmM+pClxCAoDzomTXHWezTfz4t0bBYBX4Boq1aiuXKkJQaLPlqjZzogDXtVQ1Fl5ULhJ+5vVf6cl4Yn0/t9yeuv8DdYwGeDyD8441iVAtYnEDnbPTl7FMJIUYAZmSsa0KPJZ6+xcUS5zui3tsC0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637302; c=relaxed/simple;
	bh=CTyd1+r7CyiwA2jdZhLiDVK1ugeJ8W7I01q7pNtP6Jo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RldedYGq+h7QLABn1+lSt/KZw0oZ4Yx0LtzPgbuQb/D9cSLG9Wyq6TSvHN+x8axrLc5ze/QV+N1IPFMx5kIAkhsqZRtno0TYS5pFsFa8ougNAw9fOxYkzZyAnRNkiQhtJ+qX5ZU2IOwKuJdNUCe6YiBpwA5dJBangyn7k3gbhfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HI8r80mh; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCVlWoABp1fXm32wzh7YvVSoRTtHtyzJFRBMSE32sbIe4JkdZSzvDsXLoM6a2p1AiMG5ktJJEio49sCATBRj4+L/zIMRxELI55Qm/0GyXhef+bo+wdALdpC/Dz4U/JEaP3V5REd3UjpKk8jlXoYmCVEuen3/bWgj43XLr1E6bkLA7zentn7lykxHpfckRLWXcKen9q2YRWOCI7fIOp+SstLfUYcATIFM7jx9cmjXIi+2YHfFLaTCTor+wbi4XToaTQUY5ZfTGMiz9/jw87u+f0jh/GMNHQf2c2tcShgDmVUHGiJbWlXW0zDMicjMi/x5ckvlFf+O7SfVhkYa6dK0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=690CEMK8s828huhUAxr34CX2MpTtOdS5nQm8oa7QWeQ=;
 b=yIzVdd8KuLJGtHaXW4H6yCJ5I5H8gMey77l/agwE+ual3GinId5+2v2/qP6r/2g0hqBehUxEll0O0taSSYmWPH0xwsJaJSHvIXYEIhSHF5r4a7D8sixDSZq/mcGH5DORNPiEbzkFYkI8Q5Zpd0kLyVEL8Hs1+XNFTeKJC/8ndKZrNe/cPlD+BAGCtcwfXi7pKXnlvNGwRChiOLCfXroMOmh7y7MYZd/zB3VshS45ZLl1p8g4jnl88pGVxQ/H+43GT2ASMosFueeGGb9seEgRNlTdOPbr/d6bVl5y4i4lSz3kzvBKop5R/FfDhMP4FQA+jYqt1gk+uHPu8SZeOoxtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690CEMK8s828huhUAxr34CX2MpTtOdS5nQm8oa7QWeQ=;
 b=HI8r80mh9EF8soanYm7LDffjidTkSm4qaYvVWGVJ0ExWVA3UkF0tNAC08ktoxs4D7v541efPaV1ljOltIrRqmGnpqphtgRO5Q9agFqwdkV1kmfpXD6BkQe+IwEAwM71rOqXuRoerbQHkXzyzJuXfUCiFEsIbpswMApznpF1p05E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 13:28:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 13:28:17 +0000
Message-ID: <61666e34-fe78-4f69-a30a-e43b7f92ea54@amd.com>
Date: Mon, 14 Apr 2025 14:28:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/23] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-14-alejandro.lucero-palau@amd.com>
 <a0ed9543-dab3-4c56-b128-f3372eb3ce82@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <a0ed9543-dab3-4c56-b128-f3372eb3ce82@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1664bd-8187-4d5b-d601-08dd7b58373a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3c1Q21lMkwwNGNUbjMyY2tJZFQ3MjAxYlo5ZnJyZzRHNGJtamVLZ1VtdUdL?=
 =?utf-8?B?MklXQkZSSEdRcUNLMzNEcTFPbHZmUks1SWptYktvSHJHZmNoeVd0cksyaTdn?=
 =?utf-8?B?dlRLdmQ2NDlmUG1ZbUpIaUhxSjB6N2NEVkRtUzIyN1YvSlFtTUFUbjdQK1RL?=
 =?utf-8?B?dHBzbjIvUWk1Z3NacldpUXdmZ1FiM2R2WXVpM2xqOXR1YTZiOUk0MS8vVER6?=
 =?utf-8?B?YUJNcHhoR3pDUmxGZmNLVXk4czNFS2F0ZGZhdGxCZ3oxYkF0WTBnc3A1d0NQ?=
 =?utf-8?B?emVnYmVkbkNWczY3YVJEV0FrZ3JBb0RyT3RzMG90OURtdG1Sa3dscHYrWkJJ?=
 =?utf-8?B?WUF1anFsZUVLV2lKRHEvWi9RMGViZ1IxRkpJSFRuWWJkTUpnR08yQVYyMWRP?=
 =?utf-8?B?RkY4Y2JKSE9BQkIwRFFYb2pxaG9Zemh2YU91RHBoQ1B4bzZoU0pwWmNBV0Iz?=
 =?utf-8?B?cXppRm8zTnZnUEpJMXlHUUh3RlZ4MEFTenlNR2djUG1qMGxvSWxFazZrRFIx?=
 =?utf-8?B?OEFuL05YM0FTVDM5RFdPaThDeFh3Vjc5ZW8rSkhFOGV6TStyazNRcjlGWVVJ?=
 =?utf-8?B?K29rdnc1TEdRcElOL0tDOGNGUW5yVmRwOStncHBCcFJGNUl6UlVKMzM2VE5M?=
 =?utf-8?B?MGxrS3JVc1YrRlE3RXp4MUpxZTB2ODBrbWpYUlV5bWRWVnlQNFM0dHg4ZkNz?=
 =?utf-8?B?RDRKOGdMenVZZEJpd1RvMDc0djg2VUJtZkhSbjZLM3NrNFR1WFJqejgwem9D?=
 =?utf-8?B?SUZ3U2NUUjMxTm03NTIrY3hkb0VjVEFXUlIydEI4STl1SU1UTkVPM2J4RlVU?=
 =?utf-8?B?N1ZUcVNkNW9iV3dBYVRoN0s0UXhmRGxobTVtSEMweWthOFg3SlR1ZWVDbnZj?=
 =?utf-8?B?WCtTcVdXUEdoQU5kYU1sdTB6Qlkza3RSdHF4aStFbTFrYjhVRm5PS2JWS21D?=
 =?utf-8?B?SnZyenBVNUIvZnRyRmJtUWIydzBnd1FqQ0NObUtnSThhYmR5MmxKM3lBTnNB?=
 =?utf-8?B?YWQ5QU5VSkc5Z1lOQWE0SVZqZmVmWE1rQjd6VkdxVW45R0FJazJyUXF0N0xh?=
 =?utf-8?B?Syt4R3BFTXBPMklQcWZieG0xQkxHcnQ5MDZxSW5iamxyY2pZVTlkMUxKMGJt?=
 =?utf-8?B?ZmwxYzJZeTB2NkdSSDl0VjdWZFZSR1BiT0RRQTlvWFZ3NVFvYWM0emxrQUFS?=
 =?utf-8?B?b2FtK0kwYTBLRUFETXlGTS83TmRPa1FPcE5KQ0VOZUthRlZteUpZcUJ0QjVM?=
 =?utf-8?B?SjI0Z0VHZnV3eTh6WmhUcXNIL0tvcjUvdWJSMWJheXhrR0VLWmpvZUpsanBQ?=
 =?utf-8?B?c2MyMHp2YlcrVnF4Z0xOS2d2QVNVOGdaMkd2YTIzdTZPakxWSXhIMFhCOEpz?=
 =?utf-8?B?cERiRUx0c1JlUk1oeGZZSDlpSThBUEhwUWVOaXBmNTNkWjdnNmhjaWdBOFdE?=
 =?utf-8?B?Q28ybm1vVXl2dCtvZUMxRWVPejhaN2ZDTjdUUVgxNWdZWkREMm9OYksvbnpO?=
 =?utf-8?B?ZkxtdlVyR1Zrbk56WURnNStaVEg5dVZoVU44dW1pK1QyVzdIclByYXlnQmVO?=
 =?utf-8?B?b0xHOUxZVFRJeXJzaktBR2hIWmtUc0U1ODdEd04rRjNhV2JvVTZNa1I0TVJW?=
 =?utf-8?B?d2hGcDlXdzNwWDdqOTFidm1rWUowZ0hRVzY0TWNCM29BTjlta1pnalBwQjYy?=
 =?utf-8?B?WDNpNFVkR2R4NzJVdnB5d0F0dGpoS043ZXJZWEIyejNkS1JPSCtEZFVXWXJ5?=
 =?utf-8?B?M2xYaWlPVXdjdEl2TjEyY1hYaWZTeWlvVk9oTlBUSXdqV28zckdWVnJuSkVr?=
 =?utf-8?B?Yll5bFQyOHBSMHp3Sks0ZlZyS0JuYmpTZXY3WE15aW4wdDFKc2V0eEVrNit6?=
 =?utf-8?B?ZmVIRmV6L2pXeDdjdTlIc1JEL1NsRUFpQjJBTmVabHgzSElDT0NaYUJhVFl6?=
 =?utf-8?B?aFpZUVliWFdVdi8xY3c3NGZhVmF6ZEFlOUIxWXZTS3hQUWkveEowb2NpM1k2?=
 =?utf-8?B?Z2daNkVJQlFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdsa05XZXJPL0UrRm1icHd1QUtlQmYxZzc5S0NLQWcrQi9qUENQWnd0RlM4?=
 =?utf-8?B?bHFKM1lIYVJOdFlDWU4zaVNUNGY0dXdXN1VxZWVQb0xmR1dENFBSdnpuSGRm?=
 =?utf-8?B?ajI1b0M0WDdTZ1ZncUJ0a0syWU80V0ZIKzFoeGhxU2hSaExka3pwaWtkNzRn?=
 =?utf-8?B?N0hSQjAyWXJqbndqOEpUUGZLM1RkamM4bTdjOHg3M0hwam5BWW03bTZsdDk4?=
 =?utf-8?B?WTdibjRMOGVLajJNNS9SRytpNlhSbDc3Q0ZEMnZtYjZCUk05a3dXVnd1eWJI?=
 =?utf-8?B?U0lzcTFIeURkdFJBajNKbjZ3RC9vRkJkWklnOUZ6UXhmMlBEcVU5ZzN5bmtp?=
 =?utf-8?B?OXBrWm5UalpHM3dLb2FOY0h2NGkvamFuOFdtZDFWRzhyaURjQXZhdzE4OGpV?=
 =?utf-8?B?L1RjckJxY01RT1FxZlozM3oxUUFwandLOVZlaStQYnhNdVA5UVA3c1RUZHF5?=
 =?utf-8?B?QWpMejdxK2dNck9ZdGJvazduVUk5c2ZmRWk3YUtYQmNoMzU2QUNIWkVLNGph?=
 =?utf-8?B?U0wzbWdwTTJPby9CMlV1Y2E4VW5CcEw3Y2s5SThiNDFkOVgraFhTanFJZlJ0?=
 =?utf-8?B?alFIWGo5UkFBSkRHTytYaG51dDVHTHdiYWhxTGM3ZVFHMWFuaGZ5ZUFZVkhi?=
 =?utf-8?B?QldWKzlaQTVwWUpoRFpsK2hPSW0rTzFSb1B1SzNma3FGYkh6eWhBeVdpV0Jr?=
 =?utf-8?B?MUQ2ZDI1eGtkQVVTbG83WHVYTUc4dlFUMWtzd2hhbkwyaWpteFNiSUpybnJH?=
 =?utf-8?B?MmRVdUxnYUIwMlVVZzROT1AxVkZpdkpTT3lFUXBnRXM2dXB2T1ZVVmpMdm9B?=
 =?utf-8?B?RWhZNU1pSlhyc1dENmkwRXhnNDRQYmxlTUNWaEVtcWhQRTgrZmZZakRjTDQz?=
 =?utf-8?B?eldWRExmM0tsbmNvL3hsV0txYVZXbjRadmFQWDlYREZiUmNxaG5nSXE0N1V2?=
 =?utf-8?B?UzdRQ1J4UkJlZEs0VWUxVnhjMExvNUlFSG1SdlhHS3c3WVlhRmZSb2psaVlP?=
 =?utf-8?B?Mk81UXpHb3VPRXRHN0RIOG5KRWFUbjIrREtPd2pUMDNMVFU2Q3RTbi9FNFRo?=
 =?utf-8?B?RExmaThtRDMrejZ6RFh5WjZXM3FGTkdaM29IVU9lUWdyQTJWRThkNnc5azhh?=
 =?utf-8?B?TFFHMks1S3ZYUHp3aThYbFI2dDBvN0RKem1MTGZkYk1mUUpXVFAwMlZXaEJB?=
 =?utf-8?B?VklnQjNjbEhnY1JoSjBXcEtoVmlxOGxrVTRqcTRzQ01VcHZyNHdSS0R5SFBh?=
 =?utf-8?B?alJwaFNzdDN3Zng5aDE4NDYwd3ZOUGVqK2srQXFFblBibTFsN3ZkS01CUUVI?=
 =?utf-8?B?R01Cem9rMW9mVlFjR0liZ2t3RnIvdDR1N3NWRnMzWXYrWVZxcndVODBrYndP?=
 =?utf-8?B?Ykh4NWFJL1UxSFRZS3hKbFpCd0lnaWp0dmFqNExnRGoxckNUSFE1MngwS05h?=
 =?utf-8?B?RTkrNnJoZUZLMmErclE0VDQ1NUEzdnZ1QVc5aFFXdzFFTDg2SUhJc2xyMEVU?=
 =?utf-8?B?MmN2ZFpuZDVaMGlHSER4TDg5dnVIRG03UjZyMjVPLzQ1SGhVbUhXMG1XcWFs?=
 =?utf-8?B?NjNSL1VxbHpaSWhOWEF6RVA3d1ZyVU1HaXBWK3ZLTnRCL2NWS3RoUlN3aTMz?=
 =?utf-8?B?cm5HYTRBQlFyZm9mK3JzQ0hwQlZCMWxXdnpldytOZmhmc1hCWW45SjNyWDVD?=
 =?utf-8?B?QTFiNVpjSW5nM2RRMDF6c3JMeWR1L3lQcTB0VjJiSlhFYm5YNWZ6UXA5TW9D?=
 =?utf-8?B?OWk3cUh6YzFyQk14bDA5SE41V1VIcG1LdW5IKzFDSXNmSks5M0tzSEh5bzJ6?=
 =?utf-8?B?dTZLNlRZdldEczRwSHc2akM1dHJxL2t5N1pXWTVxamdSZEtiazExUVRYOFN1?=
 =?utf-8?B?bnR1V3pJdW9JY0ZQaXdNTitiSHFwTnNqREs5UnlMczlOelFwL1c2SUtqazdX?=
 =?utf-8?B?d0xKRG1NTStjTkF6YVJ2V1E2Wjh1Z0tSY1VBeklndkg1bUNFUVhaVlRReFVl?=
 =?utf-8?B?S1ZhN0xCQ1Foc3EwNHV5ZStrK1dQTHM5N1ZHcExFWTB6aGhkNGxraEFhZkZG?=
 =?utf-8?B?YU1jenVlRTNGZXNHUHFCRFdiZGQxS3J0ZCtDWHptN21RZ3U0U25uNHc2Zk83?=
 =?utf-8?Q?zlW0yT6KWXkOKAO7hFkJQTu2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1664bd-8187-4d5b-d601-08dd7b58373a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:28:17.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYZQbPMc0ybaj7drW7A0vR+dQDEec87ml2MSqr/pGT2/1Mzy15xVTht6g+c7WitoHNtVRPZNzghCAfuLXZswMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041


On 4/11/25 23:41, Dave Jiang wrote:
>
> On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:


snip


>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but it could not be available
>> + * due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     bool is_ram,
> Why not just pass in 'enum cxl_partition_mode' directly?
>
> DJ
>

This predates that definition and you are right for pointing this out.

I will do so.

Thanks!


