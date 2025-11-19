Return-Path: <netdev+bounces-240095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C07DC70732
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FADA4E1ED8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112829E115;
	Wed, 19 Nov 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qb/NvFv0"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFA1E5B95;
	Wed, 19 Nov 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572582; cv=fail; b=N8/iQLUSqJ+7BPckankPg09buconOIFsd1x47NtyMssU+4NNnBs/+3Z8xWk781l96sXFhpdse43PrIonoLqA91P64O5UuAhooCgtJnd20dkYcIDvGTPpJ9fScWJORO/sz6axEQCnKsox0p1WKUXEtfXmuxAbuAYB4POeTLx9CfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572582; c=relaxed/simple;
	bh=ZwtRxS8WRbMmqGwP+KKxu8CL1fHfbpEhLGd0ZFcO99U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWUoatHmMZpF30U9zUPaGG4XLtA9hr4y9JovFdq1fUxld8ben4M3e+HXZt4a9hYDSDQILfOEBMDxncLfGd1g7bWe+kTYmTEjx4ZjmPH93Z4vbvt8x5uevOQlW/IKonujEcv7wezhehCSwV6rflqXJqnsxnbSYljE8zYb8QgApew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qb/NvFv0; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSnwHFyzUTH54uJHVkrCJQwo/xlOOsbw37CQZKWDrHmpUSRU6lepTYpSvSObC+9MV7XwkNCuwXOxn8g4X/lA8ifJNJ7jK3uB7QJqJ+E7rZ6cIPxcWvR/7i3ZVrUlkb2G43xUYQ3dsU84IkVNBm5TCZFKM/pc0JDD0W9cMkdIitphwgdJj5dZNkMTmOXsX2tW+S6ptWxsFfQ/4OnzU8yMeR1MozkA4NtMbuZUeFa+i0ciuu9gIorfxSCUP67dOsyEfhmknaZj3vRXxmoCsCQruGUxjQjv9OHHG+Xe9PLYj08ifeS85I73ct0RAXEnSLT2W89XVI3ffJn2ZvCF5Uspug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IvUbKvXFSf8UMptf5wWehII6w/hEqUpqZ6Kxivl5rM=;
 b=YgOAWKi+ZM7ODrF7Ae6u+ScfqliOrT+6VwH4uKenbQSmLmoJgRF9LB92yzIxVRcLCkNN0ZEqoSdfv+9pNdzkSgkX3brMAdbe+UJ5WjIDi46Ve4PLrtabdBTuNkOumrn5DAdcwK+fHe0xMA3lVK5O0gXk1Odo8Yff+N3TOYePGiAHwnqTOsPDK+LqUINDt4OeYCVoUJ+qk7WVfYjRit6vhfI2FiRE70XRK4d6RWssj0vA7moCbPyMc9efkxDHnUeYl3NBYw7YG7+fxrooBZH2n2fkkYOUxd8YJAtEgaJZTC4Qp2iQ+XHhSvh3WK2/geD9hkoCaXv5zns9aMyN3bZ10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IvUbKvXFSf8UMptf5wWehII6w/hEqUpqZ6Kxivl5rM=;
 b=Qb/NvFv0rF4FVFmIG7Nv/BYQej3CgNImloTjoFlxobp/Y+UjO3iNqBcH5JT4PV/gWdoimEfyjEUF//QmpUOUGwtxg4h4zSQYsUcspbK2s23ATo7pa4ZSo2Mh+6ifwrbg6QmyCnfDzcFUyyKn0+3QsfOMaK4hm184x38AXED6NBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:16:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:16:17 +0000
Message-ID: <9e5d4cc9-1007-449b-8602-7c270afec50b@amd.com>
Date: Wed, 19 Nov 2025 17:16:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-12-alejandro.lucero-palau@amd.com>
 <20251112161059.000033bc@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251112161059.000033bc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 703e9c4c-be8a-4e03-ce59-08de278f596e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk1OKytBV0JzNit6eENBbG9kZHU0UGZTeStGUVIzRythd1VPR0t5R1FmcUpy?=
 =?utf-8?B?L05lc1ZkVGRLd1lqZWFHNTdzY2FwZFhqMit1TnRUYWlydTBSb29OYW9MaWdy?=
 =?utf-8?B?SiszY1pnVWgzWVVnQzROM1hTZXJkK3g0WXp5ZUZuOEc3LzBtMmJacXAzNEc2?=
 =?utf-8?B?WmZuaTdqRzNyVkJlMmNoS1k1QU9xcisrSGtNVlBsbStzaytmK08vMEdDb3RX?=
 =?utf-8?B?bSt0Y3dQeVF2VWtmNGFQNzdwV2xhbWY5TkVWQld6b3lVaDFwekt1LzU4S0Mr?=
 =?utf-8?B?Q3A1dzVFSkl0SGxJY0xCWU1jVTRmZnhyRkVlSzFhdmhjZm11aWdNVlZFalBv?=
 =?utf-8?B?MWZJL2Z4QWwxYzlVUWhPa0lISzYvWTBBVGQrY2c1YUk3Tm1hb29wKzlCMDZk?=
 =?utf-8?B?UWNIZFJIQTBteXBZUVgxd2NoYWY2WGZrdkxzVzhhamJpL3BWWi93bllKL2ZP?=
 =?utf-8?B?WE5tRXJmL1pyZERUR3NMM0kwbjdHbm9PaXlxa2RjZU44SmtKc0FaL2N5UHEv?=
 =?utf-8?B?ekUwemw5dFYxSk1lOTBaNG9iK2VCWWlCNitZTmlMTzZ5OU9tSU04MU1CSTlx?=
 =?utf-8?B?RlczcFJNcUV1RUJ3QkNpVUJKSVFZNTEyZEVjL2xUK1RUWkZPUE12cFBNaDM5?=
 =?utf-8?B?QUhRMXdBZDVCRjNMVjhYVENDM1YrY09XMHJZVEJTREFPbU0vOFphaS9ydDYr?=
 =?utf-8?B?eHdjL0lPUkY5WkFJZ1d2ZHpjTmlueW9CWFN3MEloeXFTNnBabHVHRXZ4Nmlr?=
 =?utf-8?B?aUlHSlJRRTVuVmd2cnRuYzBXVHZlRnhodjF3Vldvb3FnSHJCbE12TlFHMDBr?=
 =?utf-8?B?WUg5LzhCTnZHQVVLQTlRajdnTENTcUtRdUtzVHA2T0JEbGNOL1F0Y3NTbUxj?=
 =?utf-8?B?N1BXWllNekoyRXBSMldrOWEzaDA2Yk9iNjdsOTk2d3IrVnlubjZpWVdJVjlr?=
 =?utf-8?B?czNRNmNYSFhrVTVGNXQ4VGY5T1ZFZ2Y4NzNIcHFPRXFxU2hwU3MyVGlQVndx?=
 =?utf-8?B?MHpObHRHUEl2T1h0L0xLa1ZmTDdrSFdMSlhZWFBpS3gyTm16V1J3UGJlTWk4?=
 =?utf-8?B?RzFvV1hSTHlFcmhzOGYxOXAvUTdtM0gwenUxTUFxQmxBVXFrdzhNdXRjQnlC?=
 =?utf-8?B?TXhuNXJieU1HUElaalMyOG1QdkJ1NXlSRStyem42My9FeC9IREhuQ3UyN0pZ?=
 =?utf-8?B?TllpcjZmK3lDcm5DaDdLWm9VV3RJODBMZW1zMThpcTRkTWFmS0NuY0F3RU8z?=
 =?utf-8?B?WUZQTXh4R1ZDNFh2enkvd0UxZ0Q5Zm5HR1YvdVJ0Rm41K3VpQTdGb1paeFl6?=
 =?utf-8?B?L1gvZUJGSkFUV2E2L3RHL1VpelZPWUJzOUNEZS9JS1VsMmY0ZFFTb2FBWDdx?=
 =?utf-8?B?REdYaE53R3JTeFQydXVHYm1nVXU1aGs4Z0tJTU9jMkJ2cktHVGtTbTBFWnNj?=
 =?utf-8?B?TU1PNXU4eHVTRFRRTHZjS2Y3c25TNWFvYzNaK1dSS1NHblU3MlFaZFlUU0NY?=
 =?utf-8?B?S1JNMFQ3Ri9uVFF3K2E4MzRMc2hseVEzVSsvd3lEZUxnbHZrdktPdUluNGVo?=
 =?utf-8?B?SkRGNmJITVE0UzR3TzN0dEVDelY3MHBwSjNaRHZBbGlpVWFTV3NBc1I1Slk3?=
 =?utf-8?B?aXRyaFFvK3VIZ1EzYXVyU0J6Qk83b1JKQkV4V2FIRmRFbVRBa3NPQ2FxTnp2?=
 =?utf-8?B?MkZreGR6V0xkYllVYUhFS0JtKzF0RTBkRkZtb0R4OHhrMEZuNmgwcFRmZzF4?=
 =?utf-8?B?ckU3WXh1QlV0T0Y2Snc2SElaRTlyU1NncUZSN3FWRmh3TVNWUW5RNTVFb0pI?=
 =?utf-8?B?UTVDcFEwbVRoYW1qdEM3TFZuTVozK0N4RmwwWGNZWWk2Q29VVmFROU1kQnZn?=
 =?utf-8?B?OHlrQ3V6Tk5nZG1aZmV2UjJFN3RlMGhmMFFyKzdyenFCSGNKT3ArTjBDY2pv?=
 =?utf-8?B?S1ViQ21UdlJmdXFjL2g2aHNRUGxEMmlFUmJSbGZIeU1uUmRQc3VQU1lxRGU5?=
 =?utf-8?B?U01sWWplQVRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJnMWdzclBOQTdtSjc2SVhxbWFqM240a29aeEdBS2ZXaW9iakpkY3RqdWRG?=
 =?utf-8?B?dW9YREk0MTYxMTBNaXBqWml0aFVINmR1cytUOWxMNnJqNDAxZWd3VjAwSE5P?=
 =?utf-8?B?eVBFK0dMdUxhK2dUYzJEbUROWXBsbXlaM2Z4UzR0Q283amdlQVpwN0xDaXFO?=
 =?utf-8?B?VVJTUEg2MXpvRHVTYnVkRXk3QnJIckhXZ0tpVzlBMnJWYjgvODcxTmh6c0VZ?=
 =?utf-8?B?blhwMXFDM3dlNWd5Qnp2OFRER2NQL1c1My95bmlycUlRaGRDc1V3bmNZK1h5?=
 =?utf-8?B?bTFxcjFpOTFzR01jZmFWcUtiSE9HcFJVUjRUV0IydUVTM2xPK3YzM3dMRVFY?=
 =?utf-8?B?Ni9FdFB0SmhLZ3dQVU41cXl6M2E0dlRmRkFQNVUyTSsvT2VJZXNFNU1OWXVz?=
 =?utf-8?B?RElHUzFZMHk4QVhBRzFUakhXdzFaV2pSeStBdTFoaGJROUxPbFdmSjUzNTdN?=
 =?utf-8?B?U3hEVGVsOWtDQ2dVNzZHWWxLK2dSZ3NIR2pxVWRkYURDdkVRcGNrVWwwTGFm?=
 =?utf-8?B?NzlhbVUzRWQyOHNEVWx1MjJ6U3JiUEJqQW1EZlhXeE45VUg5b3ZRcHZUQ2VY?=
 =?utf-8?B?TjB4b3l4alpjWVdDY25sbXZDTUpiWEV3Wml4V3JDR1ZnUjhJRFhFajhIb3Ra?=
 =?utf-8?B?MUg1bTFUMGsvRWRZWWJ0cHkrcU1hRVJ0ckRqV29VQS9sY1Z2bXpXTy9HOFRQ?=
 =?utf-8?B?eWxiYkRoTWtScnpmZURSVVFTSHgrVzc3T3BMZDBjSzY0K0l3NlBBS3Bwb2wx?=
 =?utf-8?B?ZHBOYlRzd3dnNG1PSnZvbnpXdlRqYjBpNG5IS1kzUU9kdWtpSHdrU0pDcjNS?=
 =?utf-8?B?bXk3TkFpNVJ2dDB2QVVrb1BwSTNDSXFuU3NiTTA1KzJGbzRSOE5rT1FubTlW?=
 =?utf-8?B?NFdqczNtRnVtTmNPY2xQd0dTWjdESVBwNTByeTN0VmlzSlJzTkJBeVMzSmJW?=
 =?utf-8?B?dGdOWmgvMXVQREhCSjBoSmNlRi9RNWtNWW9jcTlKa2k4RUUyeGVLNk5Kc3pz?=
 =?utf-8?B?ZlJrb1hyWDF1SWdGODE5RStoblp4UnMzNWdLSE8zVjFoSTBZOHpRYmkrY3Qr?=
 =?utf-8?B?Y0lNakd3STlPei9zNGNHZWZUdERmZ0ZnQTNQRXNpaFZNYWp3T2hGQzQ5V2p6?=
 =?utf-8?B?MDlZTGl6a0VxZXpCaWNpYlREeTlTSW1tVXBZcFhMbXJUYXNtV3ZOTHZ2MGZW?=
 =?utf-8?B?eHRBMktiRW9Wc2M4a1RlVFk3c3BSN3VRdkV5c1ZEOGY2L2hJb0ZFWDNab0lM?=
 =?utf-8?B?V0MvcUhYOXNLYWFEUi9tRkVaYitvcWNHQ0lCbFBYTGRNQmcrSEIzWGNYaXYx?=
 =?utf-8?B?OVZadGNRRHdGRWMwVFRwTXpoaExvZ0xEcEcraTJYMStHWElFM3AwbjIrK2dh?=
 =?utf-8?B?MTRIanIxNTBWWkZaWnkvNnNZMXVIMjJ4NHBsV2Y2RTlCbTNMeHNIR1hKOVl6?=
 =?utf-8?B?ZFdqOTJvUW9TTGZWa0JHRTE2UjhlRHlQV0JHYTRoZEVSam0xZVNBRnVaWEhT?=
 =?utf-8?B?aGFYUElkM01qcVdtS3NsRld1a01MWUtTQmxBVDZUaDRMdXhrT3VTSitONW5O?=
 =?utf-8?B?WHZ3bXllVS9SYmhGOGlLdWFlamtDUGxaVlQ5ZVBsQU12MjhrOEdRNURoMVJp?=
 =?utf-8?B?bWhreTlTNEE4Uml6cVZLNjhlYTg1R0ExVWpxckpYZWxkcHpTcG9helNXVXNw?=
 =?utf-8?B?aGt0eFUrL1FGQVpyenFKV3IwQnZzaWd3eU04cEdCWG9QUGxTOFFOUlg5cVJw?=
 =?utf-8?B?czZpTndxdFRzdHlIa0RyRk9FU3lHdUlyUWVjSjl5UGxFT0pJRXpJMW1WdVl4?=
 =?utf-8?B?c0dVVnhucWREWDRVaVFQQnlhTEJMQmRuVkpoVDJ1MTVCZ0dxRnZHbFV6TlRW?=
 =?utf-8?B?bHR5ZDdTZ1RFZnZhOG1CK1B1OXZsWjE2U2dseGt3VFJrMUt6Y1FBekNsaERG?=
 =?utf-8?B?RkRCcmFtTUh1TEJLeGEvTUVSR0RYczdVNmlXbmhNY1JjaS9HenZhWVVHU3JM?=
 =?utf-8?B?UUdrckdnM2tKdHVUd1BERTRKcHEyZzRYT2hhMTQ1OE1QUkE3U0tyVjcvZEFq?=
 =?utf-8?B?emltbDRCbWFIS1RkZUFrRk4vOHdvUkU3clRyUi9GOEUzMXR5MzhLdEZKMzJK?=
 =?utf-8?Q?Czb7v+uCMDNcSh4wkZxZhhWOc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e9c4c-be8a-4e03-ce59-08de278f596e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:16:17.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xTe6vPrY5PAKyNHoOV7bm7e7wOI3jMqYiimoUSJgmSveXzxDjaBoBMWmsizYgz8z5cue4y7mS8cJiomUxxdrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433


On 11/12/25 16:10, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:36:46 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical
>> Address (DPA) and assigning it to decode a given Host Physical Address
>> (HPA). Before determining how much DPA to allocate the amount of available
>> HPA must be determined. Also, not all HPA is created equal, some HPA
>> targets RAM, some targets PMEM, some is prepared for device-memory flows
>> like HDM-D and HDM-DB, and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Took a fresh look and I think there are some algorithm optimizations
> available that also simplify the code by getting rid of next.
>
>
>> ---
>>   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   6 ++
>>   3 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b06fee1978ba..99e47d261c9f 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
> ...
>
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
> Why doesn't the next case happen on the following loop iteration?
> I think this if (next ... ) is checking same thing as the if (prev ...)
> of the following iteration.
>
> Given the !next only happens on final iteration you should also be bale
> to do that out side the loop which might simplify thing further...
>

I think you are right and we are doing the same thing twice, so I'll do 
that simplification.


Thank you!


>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
> outside the loop the final test is something like
> 	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
> 		free = cxlrd->res->end + 1 - prev->end + 1;
> 		max = max(free, max);
> 	}
> as prev is now what was res above due to the final loop variable update.
>
>> +
>> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(cxlrd_dev(ctx->cxlrd));
>> +		get_device(cxlrd_dev(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +	}
>> +	return 0;
>> +}
>

