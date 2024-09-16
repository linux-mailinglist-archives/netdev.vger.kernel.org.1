Return-Path: <netdev+bounces-128494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573E979D73
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0471C21AFD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9DC143C72;
	Mon, 16 Sep 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ofzDREZz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036931465AB;
	Mon, 16 Sep 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477093; cv=fail; b=DlbmwSGrSm/Ao+mc63nfzpuuzXxupO873Oz3bMaWfkdqRbKPs+IkWzi7LjXBB9YzBvZj9tezEHZqnBf08IaxcFvZybV6i3XoHGAYE/AT4B2DPesxHNGNOYiq9IgVX8xvdJmtlsKgx1OmHhKjFAMF2MWrFPY3pc+aSmhTdKWkgZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477093; c=relaxed/simple;
	bh=dD4VMk3+mr8eYi1jxNxg5bEacDy8g42qcwfFnagWeZc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfoI9qclWMUj8JN0oXF8TL7LLTRnkXvqHHGqjkps0RqnvV6KJtwyb6JGwAC17EBUzL60fcPKEA2OPtnYf9dDfUSHmRbizxyWsohO6xfqlkS/NRs5MGp8ummRh/5SkIUJmacxeWyrNkWFjMFD2g8CdjhCwqZRre5HsH+8y0Mv1ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ofzDREZz; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtmaVPcWQhJzYDX7B7fKoMxZnVYwPO0alvVIoLz5JjbynRiwPXC05f9kqTA+urz5VnxhvS+LHLRNNDduTAanQUY6wEkd1TlDhE3F8++SPU34qDgyZD8wlTvrca1a+YWW87mHCTlteGU3x7AA73bmI+s9b51OLeSuzNkjeo5svzsOnutcQSSA+eKaC3ZMZbmfs64y5w/jVih90bxCfEhyEncqLP1IoQnzJ52C85kBMnZ0nX3A9LEo+7ulaPk4PkuHkS+rpYE0Rzuh8qWIYASqVdXmIFO767yHaYAufMnsbDO5aUMJczyCNmfnA4O5yJ3lkhlOkyqK6OJvIcxa3lwKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev0AMRJ0E50nVganbpKqZW11hGMFY4jchHWZTjMaJyU=;
 b=d1Zn6hiHJBEVUYq1zIgV79zApvfUiCPQq+RYCBzXs5AqOniOKZcTT/aUCfT2/QUcvMEd3jk0OvytcE93RXv/MykD1t2MN52nOA1cV0l5iEY7lpzv2pHVzNL3gsuYY7wPDUyUdX8Xn4djP3ZrvgBXCIZfN+FoI6MUdXrfUeZLNLRQJ1Ar4HrAdvAZ82CkvXNPGbvHBp3n1wUdYH2a80LSdn6Y8jnGKWD3+OUuKofS6DS50/yaC8Z2QJmADWgDIASpq8X/ly63f+KotnKROmU3+ftqOLTwuSEh2otVLAgErXk1Yp0N484TVlpU5fhlznJ9DO+L2G697KXTUl2QlBKsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev0AMRJ0E50nVganbpKqZW11hGMFY4jchHWZTjMaJyU=;
 b=ofzDREZzxfKvIwg+iRWEgkIjERG7iCHdyFLbinustQHhNAPxcl0LDAW1UylHFIJPVT+DTzg3x8as5Uamfg6oNYsMlWKWwl5ry59iW4cejn+uBAmw8h73RNYVEPFNt7mWXc0C/6xBsnxS9C6FMea8Qezj/qci0sRjstn8ut2oG04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Mon, 16 Sep
 2024 08:58:06 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:58:06 +0000
Message-ID: <0db3b805-8c09-516b-c62c-8637c6a90da0@amd.com>
Date: Mon, 16 Sep 2024 09:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
 <18ce82cd-e5cc-44c3-ad87-f735f5dc4263@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <18ce82cd-e5cc-44c3-ad87-f735f5dc4263@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: d637193a-ffb8-4a7b-ebe5-08dcd62da629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHlWbFU4RXQwWWpQY1lKU2M0eTR4dEVCcFdJNmN2M1AzS1dmWVh2SmxwQXVj?=
 =?utf-8?B?NndraDB1WWRtTzhTNUxvaHNoZWIza2N5VDVZWG9wczVUc0xZOEE0M0JLWXc1?=
 =?utf-8?B?dWVOaUN2Z1FRSnhLcSthN28vUnRlNGVQenBIaVVXNi9LazlJbkRoY2s0QThI?=
 =?utf-8?B?cGhGQU1iYVlXSno4TDVtNTNLdUZVTWVjTTU3NGhQc0NWVmdaUGNDOEtBM0NR?=
 =?utf-8?B?WlowVnpmdXZhVEFWNFpPcExWOHBTV1VBK2pwaVZXN25LUjRUbk5PM1V6Rmpp?=
 =?utf-8?B?ZVNVWXZWcUlGaUFncWRYQ0tRZGZ0WUFHSVk0QzRmTGlMMHhVdXBvSzN3bDVp?=
 =?utf-8?B?U0dlTDNnTldlZ0JjWS9EajBPRE44bDVUYy9LWlhKR1NybVMveWxkYzBDMXpW?=
 =?utf-8?B?eXZienVWNE1jdWJQZXhkOGZBcFBLR0xUTjB2K3duRXZnZG9TTFRKVU5CZTA1?=
 =?utf-8?B?Q0E0OWFZbm9HZTg2UWd4SW9YeUlXWDMyR1lmcFZsV09Gd0xtSVBNVWhqeXhH?=
 =?utf-8?B?dTJsYnAreHpodXJzODZ1bkJlRVJEM3JoczRrdmRUWlZWZzR3cjN4dVdtSlZH?=
 =?utf-8?B?c0J2eXBpZVhCZWVKekMzT1hlaU5tUEI5YnZnR0w2RGFWTlR1WVpCM29qV1ph?=
 =?utf-8?B?WTNndG41RUhWSGRRdHZqVlA5d2tQN1hwV2hpOW9lVmsrWFl2d1B2STZzTHFo?=
 =?utf-8?B?TEI2bWx4NHowNGFRK0h2LzBVaVI2R2sza09XYXdYVFhOV241SUtOVit4ck5G?=
 =?utf-8?B?UDc5cnl6bTFiVGxhNnUxMFd6aFNJeG52RjBhVlVBeW1BdHkvZ2xSbnJrUFk1?=
 =?utf-8?B?d2FHdlFkTjBOUmF5Z3loME9BRDV3YktIYWIwSFlQcXdWMVpMYm9XcW9SeXZu?=
 =?utf-8?B?V2VjTnVQTlhyZG95MGpwSForMkJCeCtmRzgxYjJjd3NwQTBpTkpXZDNkTVRm?=
 =?utf-8?B?NWk2OFhBOWlSd2JYNVZZZDJCVlN5VXlIQllQMCtpRFloOGhQZi9USUJQLy9a?=
 =?utf-8?B?K2Q3RjhWSHlSc1Y5Z2Fyd2xTQnpnbmZqS1RoaUFJR0tMZTZJeXJBaFR0a2l5?=
 =?utf-8?B?TzRiZmw0T2JmNmZIc3JLOU9uWUpYRXpaUVlKNHNOdjEveDZobW5DR2hsZENW?=
 =?utf-8?B?N1dOUlB4N252NURGeTM5R3ZHdU1hVHJxbFBJN1RPSm9NVkt6NmZaWUQxMXp5?=
 =?utf-8?B?N0hmTGdwL0tJNFZ3RTRVVHNVQlNKSk9BWFNLSmd4MGkyTjVRZFljZFF5cStI?=
 =?utf-8?B?UFVTazAyc21OVXYrczJUVEN3YVRuUkUvcEsvVzArdU9GVWV6Z3BHMEZWQjRT?=
 =?utf-8?B?VmlqeVlsTkFsRlVkeHlTL29rRHlFb0lOKzd5alhmSzlJU2pCY1k2cFdPL0ZZ?=
 =?utf-8?B?WUpIbkl0ZE1VYm1CdmRFYnRVSkJDVjAyM0pGNVBqZlNIc0VzcU12ZlRpOG1B?=
 =?utf-8?B?aXdQeFR6S3o5Ym1zK0ZMNEsxMVJ4WGpTN2JObkJjYUxFWmtTeTRvbGtCSThn?=
 =?utf-8?B?cUJPRmk5T3ZOQnZJbmM3Y1FGRUQxbTgrNW9wenBMdzZjbXBHREtKQVU5V1dR?=
 =?utf-8?B?R3pPMzVoWkt5U3VQZGMrL0xESEtGaEVnQmRBMUNPSGNvQ3pkWldpYVJBSXBS?=
 =?utf-8?B?bkhsa3NsTFBZT1NJck1iYWdNUjFjMk9GM0dDZDhWbnkydmFFSnhPTlBJRUxz?=
 =?utf-8?B?M2NidFNBOG1qWXhTd0dvMVNoa1lRZ0VySTBFWjdpYndzOG1mRUpaRG1qd01P?=
 =?utf-8?B?R1B3QTlocmt6SW0vUzBaWld6TmhxVjNvUkFOa1JNWDVpRmtoQnhmNlQ3angv?=
 =?utf-8?B?M09uSW0rcjBqOC90N3pRbWZXYXBydi93UzBoQmkxd2NqNFcxQU9ONWcwUFJU?=
 =?utf-8?Q?bZTm9yMuzLGod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXpzOHQ3M2hXc3R2K0tpaHp6ajFNR2Y3OWF3cHhWaHlST0JzaW9wVjR5andT?=
 =?utf-8?B?cHdTODhUbCtaczNPbjNNVUtxN3cvaTBRSDN3cjZkaG5tLzFqZ3N6ZEZYbkti?=
 =?utf-8?B?R3JHZE44aXVkOGVyV0lueW1iajZid3VZWCtpTnVPejF3REo2QUJlZDBOMjVx?=
 =?utf-8?B?MjJMM2RJWVpBTHBKWEo0d2VheFpDaG1SK1A4b0JseXlBZThBMXZLYlhnbmh1?=
 =?utf-8?B?M1RmK3BMaXZmZUtCYlFaMXB2RUtUZTlTQ09yMEkvdW9LVGNmWVlydCtZVTE5?=
 =?utf-8?B?ekRmZUJFT0V0SWxFVzNyUXV0WUJxYmljV3pFa2ZWSks2ZVZlVzBHUU5pRVRn?=
 =?utf-8?B?d2owZ0RZSXdTaVlBR1BORzA1ZlRXelRCY1ZZNjAvRmg2WnhjcXJ0NTJLVmtX?=
 =?utf-8?B?d1F5OU40Mkl3MGZ0QXJYZjhLalA3d2VZMFNBUlRTVlpUQUtYdW1WZVB4ZHVI?=
 =?utf-8?B?VnpDajJ6SmdpcFU4ekJjODRoaVJ1aHlIb29jMDBEVDdyVkNjcXdnMStqQnEz?=
 =?utf-8?B?WlQ4bS94VjdPTGlSVnR1ZldHZkhqQUZxMTkzQ3NpMUtPWE5VUlV0V25GdUZY?=
 =?utf-8?B?c21YZG9meUdMZ1RCUFgyd2N4MmRycHp2UXQxTVQ3Z0hwL2tOVUpkekY0cGdz?=
 =?utf-8?B?UDR2K3pWaFFpOTd5YUFVd1RuelVDdlkxcHFjVlVUQWR1aUxRMktqTytKVHZj?=
 =?utf-8?B?ZkplRlJsSHJocVFkSmNIQVFST0FxdWhrTmJsVFdkdkovVlEvaDBpWWZwbjRY?=
 =?utf-8?B?K3dDTTJFMFhZOTN5dVU5U25TUHQ1aHhzZ29WaUpXZXBOK3hzdVNUSFAyQitT?=
 =?utf-8?B?SjN1ZStnbjFjbitRb1psWUdVTU9EU3BaT3ZDYUpkRXQxMkRBYVV5d2pRWisx?=
 =?utf-8?B?MHFJM3ZPV1B6V0dXays3OVNWWDRtY2RMTEozalJQYVFTZXJ3UWVWc1BDRGRT?=
 =?utf-8?B?dkdETGt3Y3h6aGRhYnhBcVZZckJYOWh4bFFaZXNDR251TCtDQ0VJS002MU40?=
 =?utf-8?B?N3BZZ3BPZFlvK0NoNm1sWlpCYytXNlYrME5LdTZnbWNERlAxa0RZN3NkKzBi?=
 =?utf-8?B?c1RLbDY1YW53ek5BSXlvOU1ucnk5RDBtL3gyOTFVZkNiQ3RHY0pZVUFRV0Fi?=
 =?utf-8?B?WHVuYXpPRjAwQjRicXNsQ0xTNHpsdzNSWE1QbXl0T1loQzIwMmxXVVRLcjJn?=
 =?utf-8?B?YmJnRFJ2cUlPMkV6cDFKc3prVFFIcExHSHlvc0dTeTBudEIrZ2NYdEhZSUNB?=
 =?utf-8?B?SVBudHdGc2FjL2szcHEwUXRCaDJzRENSeWI3Y2RDOXBDMjRVNExXS1RjZldD?=
 =?utf-8?B?Vlg1R1FYSmlXMDJUMXBGU0NOV0dBT1ZnOTM4dnhYR3ZpbDR5TlgzZ0FIRm5H?=
 =?utf-8?B?MWxBc1Zza2thUVdsK3BrRXBTZkYrQzZTMG4zLytvclRxbThzc01JY3d3Z2ph?=
 =?utf-8?B?cWhZaUZHSXV6T1JYdkZBcDBrWmFacnFsUFJBeXBocm5QRUhNaGg1QnlMTTlM?=
 =?utf-8?B?OVoraXZ0UUZFQytHb0F3TGRlOUl3NTJIcUlsT3FRaUZnRWUwYXZsVDgwQXFK?=
 =?utf-8?B?VzR3cEJNT0hENXhUbStxMkRhZ1RsMk8rS1o3RWRtNHdGLzl2MTREeVprM0tT?=
 =?utf-8?B?eGhwWE16T3YyY0FRNzRoVjR0cnM0WDVHQ0llUHFPVlBnNTlvY083TjVkYlNT?=
 =?utf-8?B?QW5GSWxhODNNRmRZczlxQWc1bURoM2JBdlRPeDEzcnU3dmZKaFphY01PU1g0?=
 =?utf-8?B?cUtsd0lBTGVrT3Z1VmJDT3dLSXpyWnRWM242cS9KaDVHMWFpVEZ3aUJJT3Vx?=
 =?utf-8?B?NzNVRmo2NU1SVkZNU0FUT3JwTmxEK2h6ZGZlMEptbDVpWU5qbnFOUHBaWXZF?=
 =?utf-8?B?ZGMxMWJwRkVTeTBoYVBSUUJTVnZYMkpYN28xUFBibytuaWFpaGdFbERsSVBC?=
 =?utf-8?B?Mm13Zm93UXYyT05RSS9JL0lHWDBNL2IxQkJGMGRIcUFUSnFJdnhiL21DZDlq?=
 =?utf-8?B?Sy9TeVREQXhvdjd3RUJYMjQ1Vm5ONDhrQVVOOUw2S0xHTWRMVm01bWNOYk9E?=
 =?utf-8?B?b3Q2cFM4QVJ6VFY2YTljdWtlWHZoeWh2a0F3b3N6OFh5QmNmS1RjOG5lK1dO?=
 =?utf-8?Q?jbGz0N8D4dbdglImtIixLuU9P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d637193a-ffb8-4a7b-ebe5-08dcd62da629
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:58:06.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OgmNul32hlKMddoJEvZjCeFkkVnb0WoqpOrGFfkoP8TJgw1u0rE1Ex/TM3hH+Jv/Dw9R9C0f3Q7kPC2lOid5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213


On 9/12/24 00:06, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 12 ++++++++++++
>>   include/linux/cxl/cxl.h |  2 ++
>>   4 files changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3d6564dbda57..57370d9beb32 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <linux/cxl/cxl.h>
>>   #include <linux/cxl/pci.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   				     __cxl_endpoint_decoder_reset_detected);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps)
>> +{
>> +	if (current_caps)
>> +		*current_caps = cxlds->capabilities;
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
>> +		cxlds->capabilities, expected_caps);
>> +
>> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
>> +		return false;
>> +
>> +	return true;
>
> I think you can just do
> return (cxlds->capabilities & expected_caps) == expected_caps;


Yes. I'll do.


>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index 8b8abcadcb93..35f6dc97be6e 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> -		    !dev_map->memdev.valid) {
>> -			dev_err(host, "registers not found: %s%s%s\n",
>> -				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> -				!dev_map->memdev.valid ? "memdev " : "");
>> -			return -ENXIO;
>> -		}
>> -
>>   		dev_dbg(host, "Probing device registers...\n");
>>   		break;
>>   	default:
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 58f325019886..bec660357eec 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_register_map map;
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>> +	u32 expected, found;
>>   	bool irq_avail;
>>   	u16 dvsec;
>>   
>> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	/* These are the mandatory capabilities for a Type3 device */
>> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
> Maybe we can create a static mask for the expected mandatory type3 caps.
>
> I also wonder if cxl_pci_check_caps() can key on pci device type or class type and know which expected mask to use and no need to pass in the expected mask. Or since the driver is being attached to a certain device type, it should know what it is already, maybe we can attach static driver data to it that can be retrieved as the expected_caps:
>
> struct cxl_driver_data {
> 	u32 expected_caps;
> };
>
> static struct cxl_driver_data cxl_driver_data = {
> 	.expected_caps = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
> 			 BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV),
> };
>
> static const struct pci_device_id cxl_mem_pci_tbl[] = {
> /* Maybe need a new PCI_DEVICE_CLASS_DATA() macro */
> 	{
> 		.class = (PCI_CLASS_MEMORY_CXL << 8  | CXL_MEMORY_PROGIF),
> 		.class_mask = ~0,
> 		.vendor = PCI_ANY_ID,
> 		.device = PCI_ANY_ID,
> 		.sub_vendor = PCI_ANY_ID,
> 		.subdevice = PCI_ANY_ID,
> 		.driver_data = (kernel_ulong_t)&cxl_driver_data,
> 	},
> 	{},
> };
> MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
>
> static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
> 	struct cxl_driver_data *data = (struct cxl_driver_data *)id->driver_data;
>
> 	rc = cxl_pci_check_caps(cxlds, data->expected_caps, &found);
> ....
> }


I do not think this requires so much plumbing, but maybe using a macro 
for type3 mandatory caps makes sense.

About accel drivers, I'm not sure a macro is suitable because, I think, 
when hopefully CXL designs become mainstream, the caps will likely be 
needed to be extracted from the device somehow, other than what the CXL 
regs tell themselves, just for the sake of double checking. Thinking 
here of same base device with some changes regarding CXL in different 
device models/flavors.


>> +
>> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
>> +			expected, found);
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_await_media_ready(cxlds);
>>   	if (rc == 0)
>>   		cxlds->media_ready = true;
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 930b1b9c1d6a..4a57bf60403d 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>> +			u32 *current_caps);
>>   #endif

