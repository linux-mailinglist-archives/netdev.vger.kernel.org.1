Return-Path: <netdev+bounces-154334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10219FD196
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C6A3A0652
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5F5D8F0;
	Fri, 27 Dec 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MjYQHSQV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B21876;
	Fri, 27 Dec 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285687; cv=fail; b=P+zUvDls7F2Izr9jBn6Li1g6WkvOfFu/cQ80bJgWLAljXy5ixyHOLq2zGFNjDv4EMsmoGlHttz+ItTLlzMjnigHZI3PdAS1yBSE6o6xP05v1exSydTpvpA/iBwqnbGI/WwFgkEoeA1ImvB8F08cKPj+Na77NIBcZouvJTd8kM+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285687; c=relaxed/simple;
	bh=4dXG6vjdZOrk7tsBsZABNFFogINvz+dlYu94+A9k71A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+TSoh1NRAp9vJb9B/JOvH9DM/FXQDzbsveIDO0X2F0Z6YaVoXs7dIfJ16VT24/Wwo7QdICCL9NMs1X2u7qHH/8mHaoHOSRlT9nHDLYfjGjkxxVS/ELmxl0Ym116k2J4W3xVsTQVUdylWiwj44bxNCwyQCxIqgU4obJDXoQKx/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MjYQHSQV; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbGOajCjBUUVQMMzXy3aT5Xh8nPZfbtc5EGfenEPHu3EJ3lF/8BMfmgesiaJNB0aZuRSBS8GKu/JjbK4xjzO7yRwUNfMsapJsqjj3L3IL86+vmsGdd9pFkJirkPmRzYRcfYSFCLzH7OAa1x3g0sDc4eb62h+cFjoVNPVgQ8QANttzoxmahrUW4BOyCJ5hNpzX1MymBjKvfFWx9sMMthB0torahHw2B3I7E8bCoaygn7zEGe2ybThYWwsPxkXD4tqmHpDZ8cHdEvf2MIfRNzCMSs5OjjKkZUsvTioEnwAuzhrK5/FP2QXZ+cDh6tQ+8pREb7dlsYJ3a82uwUNnfFXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj15bSs+Xd9pDFhGABjWvsSsEe6Rhvinb/QRb6tMNrA=;
 b=klOUAZPEeREiiaU/VhoRfv+j0uLvGc7dXX3yRJ4LA97yIDprpeCZffmmscAkp4wjgQLMTYBZBL+Hzs9AXOBJJPVRCq1qJkzHf5qLi866ZMkTRgT/PFKE0AgkMbMalRNNIdG2ZDFIyCZn8eFJyeIhiOhtZMfYHsJ0dKscPnNDOe8qdg5F4djV7PEz3WwryOJkQV7ox9bA4jYtTWSYb3F/VRW7g1STd8/PEpcU6APYGlwngttVC0sarSV/DDQu7j29iStE+A+mrVtz8ySLI8VX6yxBX5ab1l9lglHtKY6Odvqbqmglau+b56Mh//Dv4HkHWDMf9vxky0JFLCF2gs7tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj15bSs+Xd9pDFhGABjWvsSsEe6Rhvinb/QRb6tMNrA=;
 b=MjYQHSQVXFtccWG5FXBj8zUVp/LmwjEXcW0VVFBo1ASF/zL3ZpOZ20dQz5/NF5UwqH6qEiv30qwdabiquwP57MoH0ziMSW/U+/iDDjOEu3y4noeXELqTfEB1UAOSG1QNAR0PCHqwAVo2J2rfQZD8GtDE8pVehqPDmvB7MrVi2G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 07:47:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 07:47:59 +0000
Message-ID: <e38ec5a9-ff66-3c3f-b061-50ee07a8bdb0@amd.com>
Date: Fri, 27 Dec 2024 07:47:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 04/27] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-5-alejandro.lucero-palau@amd.com>
 <20241224171533.000055b4@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224171533.000055b4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0f05cc-1284-4094-d71e-08dd264ac864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejVEVVhFZ1dyY1UzSlcyT0EyNVk1SkdETmZIeHBtaWlXK25CVllLbDMxSmJu?=
 =?utf-8?B?RzI1N1dPK25TTmRHYzhuMzhYTjYvMWVpSkV2Ri9XSHExTlpGKzJwTm9MQzdQ?=
 =?utf-8?B?bUw2WjQwR3RjL1g1V3Z4Tit2RXk3MmpKR1BBNGJsWHFNWTNGNVdXOWEzVSs5?=
 =?utf-8?B?RTNVT2p1VEpLb3VPSXRFeDVyTXo2S0hQdVc4Snh4OW5zb0xiYUYzT2R2eDZy?=
 =?utf-8?B?MGJJUzdKQTkvR09RVlI1Kyt3M1BtTmNCZWNRU296bW8zbTJtVmwvZGZwYzJa?=
 =?utf-8?B?cGE5Vy9mam1ja0xmSDhnV3dmNHVQWE9ZRm5NZHFxeExuQ1kyRkZhRDNYVlE4?=
 =?utf-8?B?bmkveHZsekFRQzQwNHVlNUx4QklSdlplRmgyWm1lMGZYSkkzZEI4a3huSWV5?=
 =?utf-8?B?WHBBUkNmSmliR3NEV1hiYzZUdUs5TXU4Vm9BZWNCQ2dvYjVFZXpneWd5S2Nz?=
 =?utf-8?B?aSt2NkhWTXZDS0srbUtFR211c1lVUDJzRWZXNHM2NGdkdTJWZjJJYmFCVEdk?=
 =?utf-8?B?bzVmWGhQWW5GUTBSVm1UeFQzU29EWDIvTjVoRWtLcEdPRHZoYmNsSzNEV0Np?=
 =?utf-8?B?T1cwMjJsNitYV1RBQ0FrQjN6enF3L2RUeUlwaTluMnk3YmYyVFR4aGJVRW80?=
 =?utf-8?B?enFlalBWMXZJN2RXL1ZlSEo0S3p2MDZISDhCVnNrRWRYOUNidVVZTTZkSFQx?=
 =?utf-8?B?TTdVaUJiWDF5ZndSQ3JnQnZtTG1ybFdUN1BmaUtvUC9CSlFNUDAxRHo5M0hy?=
 =?utf-8?B?ZVNvN3ZHelowNnMvZFNNa3NVN2RBbG5Da0daWkdJdzlBVXdETk9VTUlhM3NY?=
 =?utf-8?B?OXVCUFpLZUFHQ3l0aElwdHhlWlE5UG83eEFmSmpYZkJseVhXWkEvU084QjJu?=
 =?utf-8?B?Q1JFeSt4QmhHeWp4clpNQVZoakZlc2psaXBFZFREbndNczFDcEEya2R6Y0hV?=
 =?utf-8?B?a1NiQWxqU1B0Zmd5R2o5eWVjQngydWQzdXJ5L1NiNDlxUFpwRmVxTTVuMm10?=
 =?utf-8?B?QXFldVg5NkIremxxU1ZpeUk4aURiaDZnSysyRHl2REFDZ3ZXeUNFVlc3NnFq?=
 =?utf-8?B?TTBwS0ZKQjBPdFlaRStFYnFEcGFqZWpsVkpUTUEvVnlXRzZtaE9NdGpXQmtC?=
 =?utf-8?B?d1UzSzlwK3VCa3J3dVd3NjQyakF3MUR3N2VjS2g4eVYrbXlBNTNGbkl2RzI1?=
 =?utf-8?B?bjhSaHNLbSsxdHpZaUM5QUdMZVBOd2hkSHZFZ2I5R3VVbXlXUTR2SGxWOENM?=
 =?utf-8?B?NG8rVE9MYUE5UDh2WnpRbWM3MWUwYm9pUHBDc29BRUZ2dXBFK3dYWFgyNFVz?=
 =?utf-8?B?VUwvSm1BdS8vSUcza3BjS0Z0SkVUb3E1QmcwVGtheGVwSFBqMkFTRFhjdENM?=
 =?utf-8?B?RHJTalk0eHo3UWpxOElUcmNsaEVSMTVWVXJVbDZwYkQwSkFOKzVTdDRqR0x3?=
 =?utf-8?B?TGNtMWJMU0daZUQ5UnE5STdONEFsWEk3TmNkUDBna3JlLy9LQ0dZVVM1UTly?=
 =?utf-8?B?cy9NWGl1YlJaMzl4WldkOWljdmY1TmhMR1Iwc25NS0RsRVV2NS9OQlFKQlV1?=
 =?utf-8?B?eXdlRHFZSG9TY2YwMjZ0SWVtMlVFR0txN1NnSzg4S3VDRVlqdnBkQmlhWUxn?=
 =?utf-8?B?RjJEbjlnTVpRTmpDWWdjWldzOFlFSmxPek15eXZkbWF1NVB5M2c4Slphc0Ra?=
 =?utf-8?B?bFJWVTJGcHJ2NUtGRHFMVkZFUUFhd0ZKNUE5SFBId1U5L2R0b0hPaXlEbkE2?=
 =?utf-8?B?NlNQME56cnhjRm5HMU8yV3hkNDF2ZUR3MDMwdVU2OXloMW04NXEwc0NyK2Ny?=
 =?utf-8?B?bnM4OERUdGQ4cEt4aWFrU0dJazc2MXlMclc3SnpXMlMyZXRYaTZLSG9yZjZ5?=
 =?utf-8?Q?WTz3BVsel4gho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU9ZOVpOTEtPODlLRndoK1k2dm00U3g5S1VqVFQ4V2Z3RU5SSC9RVGdDWk9u?=
 =?utf-8?B?UVd1TjJ0ZkdMdk1SK2c0ekJ6eW9uczZTUUt1NHNyV2JmWDFxVUhpUjE1cmFx?=
 =?utf-8?B?VW9pWVNVeGIvMXpCbnBteENMTEhMNnNHNGhLUjd5b0poK1dkNk0yZXlMalN6?=
 =?utf-8?B?V2d4TlhPSnRNV1UvbGpZaG1QbW14TWdiVGwxS24xc1E2bXN5azNnVUhFVi9w?=
 =?utf-8?B?V3llR3Z2Q1pVQVNkdnJ6bzZBOE1qNXk4NW1HY2dNYkk2WDNVQStVZHQwK1JF?=
 =?utf-8?B?dC9jWU9xeWVaNE1vYzNoOWdFRm8yQUM2WllxUFYxZVV2WEwxT2NQL084SFdI?=
 =?utf-8?B?c2tDajN0OXVNYUN1MzJ2Y2tIOElFeWl5UncyR2d0ZDRUMFFSdVZJVXJDZWdO?=
 =?utf-8?B?STJYSFNYNEwwMm50emRVdWJYY1RNOW5sYVVZanVXVDRQUjA5blNXRldiL1Z6?=
 =?utf-8?B?Z0haajJ0dE1ra2dpVDYwNGNGSUNaZm42cW1qRGtkNndraXNZR284TkxWNi90?=
 =?utf-8?B?bDlYMzZxSEZtZ21DMW5sQ201Zy8yOVJSTjBodEVhL2JTcWE0akJJSTBRQUJ1?=
 =?utf-8?B?QjJGak9la0s4Uy9ybFdIdDd0WjFNdk5qMFloeW94ZExJK1ZDL3k2Y1I4MVY4?=
 =?utf-8?B?V1hRSmY4WFdBSHBKbXE5TFM1ODFXUjg4UFF3eVhEdkIvQ1MxbFFjQTBpdFdI?=
 =?utf-8?B?dnpiMXB5eFFjb1V5L2FCaUxnbzdlaDBOUWNzTkdMd1BVZUJqTnhIYmhKVGly?=
 =?utf-8?B?NWd4MEhNa2JrVXFTZ3pvWmRqYTVvSnVycHVUbC91RWdwSE1YWW8xS2JEZ21W?=
 =?utf-8?B?QnNHRlZRU0ZQaHBuR01lTUIwLzJhaG9vWURnM2JyVHJpajhITjV0UmV4WW91?=
 =?utf-8?B?QWdYVUtRdW1ITyswZmNKa0tUcnhxT3V5d1RMbXJHaUF0aXhSOVU4T3hPbE53?=
 =?utf-8?B?RVptOGJlN1psR1gxZGlaam1LSHFxVVVzeHN4TC92cGQzcDZPaGhjVHpxL1dS?=
 =?utf-8?B?cWFFTWNpeTdyYnZpdFBONTZlcjB6Q2J0WjRmWEplejZ2aFBCMUkyRFNGZ1Nz?=
 =?utf-8?B?VThPQzBsaWthaDc4YVZweDN3STJWU3JwMmFZczdUcVNESHdCaXBFQ2VUS1hJ?=
 =?utf-8?B?YVFEZjNtTUF3MTdCM0FKSWk2MWlKcyt5WkJKNm91bjAwUFBFQTFoQmV6Lzlt?=
 =?utf-8?B?YktiTENUNVk4REdFOVRtU2lRTnY3RkNXNVNCcWc4eTl3V0sxN254V2VTang4?=
 =?utf-8?B?ZlZHb2ZzemhxbkhxOC9QV1dwdW9IUDNyeU5NZnlnTnJIL29jaExDT0dGcEZs?=
 =?utf-8?B?NGV6YzRlZWpiWm5acHdYbWlzWCsrZjNVdkFJU1NwVFh6ajdQUUJ1VHZGa0xD?=
 =?utf-8?B?Y21EcFAzeFcyNmh1YitLcDh6WDRFY3N6dmpIUFV4azV3a2UvQzFuSUNUY1hN?=
 =?utf-8?B?aCtuV1NETXE3aTNybTJzZTVFNlpodjFTMEFmYUZkcjJoTlhmMFRQVTVVT3g3?=
 =?utf-8?B?UWluTjEwQUZESDB5ektsUVJOdE5EcjN5NVRGU09FN1Y0V0hWSnp3V09QT0JW?=
 =?utf-8?B?UHhMOUc5T3IrWnJlTThZWDdBNC9SeURHQmtNalJCSElVUE9xZFZhRG0rZHQz?=
 =?utf-8?B?NkZ4d3RyWmZPVW4zbXhzL0JCb1FQb1lEMW82Z3hTTlJtc2N0aDBodHdCR0lJ?=
 =?utf-8?B?MDVKNVN0TkN6a3RYT2RIK0NFb3V2OXZYUjBNRGx1eDdCN1lKaTlHSlh0MGx3?=
 =?utf-8?B?ay9qUFpDVXBUVU5pbEhwdlUwY1pCeWMwZGFNUTVqSFlqdUNTU0g0bWkzd2NY?=
 =?utf-8?B?MHQ4djlEaTB6MXFIMkdnTGFPbUd0dGNEbmJCSVpEWVVwcEhjZ2FDa3ZmcEpj?=
 =?utf-8?B?SHJxcFFZLy9ScUZPdDcwQmM1RTA4SVZrREhSZFVZM0Uzc1dRYm1wUnpDajB2?=
 =?utf-8?B?Y0xGRkQzR3ZkSjIrcnlva0JMbVRNMU9GOWM5bFhQclB3cWNaR1h2MXJJRWx6?=
 =?utf-8?B?ZW13aW5KQ0puL3F5bTEvMk53OUozNklGVHBmdUtvcmNWQ2VvRU16bVFxZDdO?=
 =?utf-8?B?UTluNW9QUGJjNGJBTXJNazJITHhLWjE1emY4NE1nWnpQSnFmS2lrV0NsamxD?=
 =?utf-8?Q?0DjTp3XhOn/Qm+YXH0Uze+zEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f05cc-1284-4094-d71e-08dd264ac864
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 07:47:59.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJHE77/IeJVlUIt8mr/932WSt7YzOKnt/UYMpF+bJ1Hr7Yh8RVGsgoIBKsmhFrr6PoIXtZ7aUvPGqadr8JRyiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315


On 12/24/24 17:15, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:19 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization and allow those mandatory/expected capabilities to
>> be a subset of the capabilities found.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Some follow on comments in how to handle bitmaps.
>
> Jonathan
>
>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index dbc1cd9bec09..1fcc53df1217 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_register_map map;
>> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	if (rc)
>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>   
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +
>> +	/*
>> +	 * These are the mandatory capabilities for a Type3 device.
>> +	 * Only checking capabilities used by current Linux drivers.
>> +	 */
>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> set_bit()  - see comments in bitmap.h, these are fine applied to bitmaps
> and make more sense for setting a single bit.
>

OK.


>> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_MEMDEV, 1);
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
>> +		dev_err(&pdev->dev,
>> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
>> +			*expected, *found);
> There are printk formats for bitmaps that should be used here. %*pb
>

That is more convenient. I'll use them.

Thanks!


>
>> +		return -ENXIO;
>> +	}
>> +
>>   	rc = cxl_pci_type3_init_mailbox(cxlds);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index f656fcd4945f..05f06bfd2c29 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   		     enum cxl_resource);
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>> +			unsigned long *expected_caps,
>> +			unsigned long *current_caps);
>>   #endif

