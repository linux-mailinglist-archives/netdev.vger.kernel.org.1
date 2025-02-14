Return-Path: <netdev+bounces-166517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470EA364BD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FF3A7325
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877FF267AEB;
	Fri, 14 Feb 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nO5gALlI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4F264A80
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554751; cv=fail; b=fb012/RQMQURr6WO3H/1pGeUFhFQOSngKGL1xsekNWDRSOYc7IPnw5patIy0/A8cKnj0No9EBZeLsPPyJy+m38lUtdJUPaIlwgDFxXOzDirHyW17iTGhdgMNOnmsBXBzbXrxpV+9ycORFuISM7gLS7igNYEBNni75u0rBkgRazk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554751; c=relaxed/simple;
	bh=m8zhGsteClumB0cE23S3+i9yMrW3onqCbngldL1J9f4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mzo3o+67hKt12se1ZLMarXptpDqjx+m/sT2PxvOBAzys3jGpJs6W52C2rEyllnQECkfWOXsZNOT22ko2ST4LxgTaoWdnOmzbdUmMAVHpNgoSrK7kCFBSQ6IzA0CWL1cb04fq7AsRw5Srapt80peQ/xd1b2j5TaJmlpo4J+jEv4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nO5gALlI; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvm58d6e9a9PiYYnZWoHpwso1BtaQIqgtgMqTpWkA1oRgzubkshI/kHRK+swaV9fDB9wJjNaEmlvDMuEwD8J0t4BwMb8yapXQwTXRUoVVgLAydB+NjghDJ4gSR9FUbJdEI+2tm7XHdVvBf8bhD7fBn189gvoi363hG+cfcr3naTMK90WdmDqmDsXKaE+uUJoYo/poiiYEM5+rrl7l7R11Cv5IujmlA5F4Nu7dYZ78pLsAW42ieC7Th1caQK9+w08cjrJgrzTlpndt/LhkjuG/ijILnBfPaB3rrnu0R8qHokK3AYA/+Xbis36nkVN2j3c8iDHAui3YC90vaakOdHwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlWzwBE9EQ201GBxkp28qobbU4jzHm4dzNu23ex9CCc=;
 b=fyhmNIA6kWAviDsttptTJ56kG0N5GyMjttL018D7M6pmM9bysUhCAvfPi12xMNQ56KcxWCsBARC38zXKdvXp7N3Io2fSqkXu7gbXFNckqaM/eSxFvPcAwhULrpk1d3ZTogDLNUBmCRd+2qgORP+E1BEfX1DwV/FljLOQvN3e7VAQwK1OtZxgnVf16VAyaqi38XCfWbNMken1erLe9e2z81JeQVkIy1rhyj1rYiQXaP2Cdon5IgpXSJvES7rHVjpeHKS6JmBBVvisY+42cZTHDBUiecaMnbQLpgOOsOwsgqYzPLuCdLLIf4SKKw59MKBQ6OT9RjYQHdu0+jPQ86Ajkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlWzwBE9EQ201GBxkp28qobbU4jzHm4dzNu23ex9CCc=;
 b=nO5gALlIegkV87vkWq9ghygpgIuGFYgP8q1u64UU3+nAnWx2aWO4+vAIAiBzpaov3ZoQJnKNuBsATpQ1gg7RVbsHEdRUAkQQte40YP1uPliL2ZyXggAYZ3qGuYuq/674RV2+kHPERrwdGVMEMnDiiarQElbA650qGF4/2hhshWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Fri, 14 Feb 2025 17:39:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:39:06 +0000
Message-ID: <252425b8-ba1f-4505-a7b4-9a90ddd5ead2@amd.com>
Date: Fri, 14 Feb 2025 09:39:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] sfc: debugfs for (nic) RX queues
To: Edward Cree <ecree.xilinx@gmail.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <a5c5491d3d0b58b8f8dff65cb53f892d7b13c32a.1702314695.git.ecree.xilinx@gmail.com>
 <0d1d3002-ff8b-4601-84d5-ee26733af54e@amd.com>
 <a73e6859-6a64-db5a-66ec-4fa884dd5b74@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <a73e6859-6a64-db5a-66ec-4fa884dd5b74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: d0dac657-1e03-4433-cbf5-08dd4d1e7b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVBNFhsemMxaFQ0RW9aaCtMQWg1TzRYZDkwK3hCYWxzRUZJQ2k1MHNJLy83?=
 =?utf-8?B?Z3doTWYvdWxDbEVaanBqelZPK1cxcWJxL1FKczB1ZGxyODNpSDE2ZFM4M2Vr?=
 =?utf-8?B?ZTRKZEZKKzVUTkVzOG92OWJaZ2Qzc1RmUTcvWVpnZ1lpaEZpc2wrU3FYa0I3?=
 =?utf-8?B?SmduekJiaHduS1ZLS2V4UDNQOTJaZGU0bzJIUzhPMDZQaktOVW9PZk5OZ0E2?=
 =?utf-8?B?MjhZdU80SHdPN3BwQk90b3JTNmxkNDBQcHBpelh5RnhNMnhCcVM1MmI4cjg5?=
 =?utf-8?B?YkoySzdja3ZuRWlXZ2Y5eTh4dm44TGpwMVlXd0RjRlhWLzlMU1hKUDU4QW1k?=
 =?utf-8?B?d1NCTDh1R1pBYlBIaVNvUHd4WUdZUzJpcGN0UTVIVUJYY3o4Z21Bc1pCdUJw?=
 =?utf-8?B?aTRSeitpd3NoaHlIQkdUd3dMT3lMY2J5bzBodGZDT0tUWGM5NnNtQm1McHJV?=
 =?utf-8?B?TzBUeGlsSXhIc3NaekRQYzFIUVZJeFNqTEhzYU5OdlZ2V3g2YXdWQW11Ylo1?=
 =?utf-8?B?d09jSW9hWE5tVnp2cjVid25IUENQR3NSWEhpRmt0bVJ1N1MrbHdMS1pTUkFz?=
 =?utf-8?B?M3dreXhYWjU3T2l0YzJjWW5aNWcyOVZkem5tTTVhanJvUTRZQnMvSHZHSDZk?=
 =?utf-8?B?WGUzZUFHQWd5MFFVYS9zQkdEYnVRUi8vNGxaVzNjY3pKWjRhdER1elkzK0lj?=
 =?utf-8?B?VWtNWGJ3LzZ0ZnFzOUMvdklzR3U1U01OcStPOXRUSHdFUjJ2OExFa21BdjFm?=
 =?utf-8?B?d3dLME1QZHZsRENlNUJHVzlMb1dBdmxCR2dtN2I2ZmdlNGl5ekZ6VlQveVZh?=
 =?utf-8?B?dHkwZ0x3Z2IwYldnc1Y1RHcyQW9taDAzbjd5TzJzY1VvS1dkWGdXN0YxUWxq?=
 =?utf-8?B?VitDZFpxbHNINVR2WXZjcU9wM2RTVWZTMG5uZVgrYmxHZjdOSU91ZHVCd2Vp?=
 =?utf-8?B?L1VZZDJMMGVvalFxNC8wOUpIN0ovSk5ScnJUaUpwVWJvY2RXUnZaSkUycXpl?=
 =?utf-8?B?UGg0VkxqSFBFTXZyemJ5MVN6Nnh2R1FvaTlaMEh0eE4zM2JsODlkclFWYWRn?=
 =?utf-8?B?cmJySTZ5RXpmYkhzNjRMK0dGV1hEZHBmN2RPRFA4T1owNVU2N0t3VHdZVmRO?=
 =?utf-8?B?N3JieWFkN0tUdWdtbG9NVUtMUTJ6aE5SY2tXSnA5TmtWZE1CT05NaTM2MU9H?=
 =?utf-8?B?SkZycyt0Zmd6NkYvZFFsNTFscG1UM3Qvam1WQzlZL2Z0VGdKS0xDQllENUNZ?=
 =?utf-8?B?ejh5OGhBTVgxSnloK0JIRkpsak5iT1lBdEZzVENJYlJHZFh2eHk0VmlWMFVN?=
 =?utf-8?B?czQzdkFreFZZaGtKYW4xa3dlQzh5a1cxSjdmTGpzdUNoWDRXMTBzcGFxK0l2?=
 =?utf-8?B?YWZsRzNFNGRqWUx1Q3dCd29MVUtHTzF5Y2N0VnN3aHhMcnhMS2MzN1JEK0lu?=
 =?utf-8?B?MnhDNkRyY3VwTDMzaVJhNlR2TDNEOFRYMUZiQWJsVXFRcHBCMjQyWitnSWc3?=
 =?utf-8?B?OGZYcHZqZ2FtT0IrYzhXSlVXd2trbmhkQTh1ZFlQKzJzWlIzSytFOFZ5T2x6?=
 =?utf-8?B?SWdmallXbHl6eXVpT21sRVhhUXVpazVMYkFRaHQrZ20xQjJyNitoTUU2VEoz?=
 =?utf-8?B?TUdQWlczbjdzVVlGOUwzbFNLNFBLaS9TdUc5bmRIbjNmT2NhMkxRNURVOGxn?=
 =?utf-8?B?UVFMMjdMQVZlcWZFUGUvWnN4VFhZMTBOUC9vdVdqcTgyUzAxU1dOVCsya0M0?=
 =?utf-8?B?YnRTSGhBWUx2UzZFTzJwaTZURWRVd3hqbXA2YXJNWGM4azBkNnhrMllrL3o5?=
 =?utf-8?B?UCtHUjNYUGpnWjBUdEFIQ1ArT0d1T1JLNkkxMVo1NEhyREcxd2xVRUUyWnZB?=
 =?utf-8?Q?lbtMcWKgRnD9r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjV0QUFpQUcyZk5wYWdFd0g4YW4xZDJRbmdMS1lBN091TVlpem1vQTdLUzFt?=
 =?utf-8?B?d283ZDBZekpZenlWT2xXclQ3dGcwMWNUWUEwaWxJd1Q0V2VwRUVSYkllbWZn?=
 =?utf-8?B?am9SeEdUUVd4aHNKWFZpSTl1Z09TaTdkWC8xTThVeGtPUDNMRytMNUNxSnBu?=
 =?utf-8?B?cnJHR2pzcUQ2dWw2WGI5MEcwRjR5SEpsTzE0ODhiREV5SXlkdW4zZUUzVEVT?=
 =?utf-8?B?VWhiMUVlTElRMEt3Z2F1cWRPVVA1VzdDd1pTS2J5MHByVlBiSVZma09XbHM4?=
 =?utf-8?B?K1hMZ09nUUlsSmtmT3l3bjcwNXBMTE5OV2p3RHYxMVg1eitRWENpaWErejIx?=
 =?utf-8?B?L0tjSmg4NGhDZzJ2d1JuOW03L3dnMDNENGZ3UGJSN3E0c2VTczg3d2xZUGxX?=
 =?utf-8?B?RXc4ZHFKM1RWa08yZTd1a24vcEEzZmlZTDZSRFZnN2pJMkR5MnpCQnJkM2Uz?=
 =?utf-8?B?OUVacnFOelFaOTcxeDlFR09adXg3elJvU2ZTeGx1QzF0bXdDVkFNSi9nc085?=
 =?utf-8?B?Rk1VYS93clpIUU92ZnNlUGhDK2NoaXhpM3dHL3IvZkh0aWhFdXVuUFIzNXZS?=
 =?utf-8?B?NnMzVUtrRTNZOXJnMDJab0N1ekpoTjl1eGVHaTJ3S21BNG1haTNPcVVCV1V2?=
 =?utf-8?B?a045YjFnMEo5QzA2OER2ak5jdjhQd0hPc2lHejRMMmI5QmlPREJyTlEwK203?=
 =?utf-8?B?VFpIeWxkdEJRSnYyUE9DZEFZQjNUUnExaUJKb0d0cHFPYTFxeGFZWjJUaFpX?=
 =?utf-8?B?aXVVUTVGK2dZM0tPTmd6OERVamFFa21mOFhhOHVrY3BCSzU3VHQrNnA3d082?=
 =?utf-8?B?SkRhaHJGcWVFK1J6TzVVcEFER1JObm5vS2RCL0JRV2pNTTl5bnN6OXV1clJD?=
 =?utf-8?B?NXVmYVd4WVlReDB1cGgyQ2NFZmtVcVBacHpPSDd4dmNnS3FhQVk4My9tN2s2?=
 =?utf-8?B?aVczRmtwT1oxOUtPb3poQnMvM1VObkJIaHcwNTdIQ05mdlRQY2VSYy9NYlly?=
 =?utf-8?B?UG5jZ0Jnam16bzBPaE1Jbm9vOUxXRDZjQUVlOTZPaVp2TitIWXJ3YmZzUUhq?=
 =?utf-8?B?L2ZVd3d1Y21KVkRHUVRBamgvQTcxem1qQmxuUXA5OTZMTGRiQm45S1BXeVBN?=
 =?utf-8?B?elM3RG5VLytZc3VoRVRXbWFnVGxPb2VNejVETXZDZnFGNG5rc2lEbXllSkMw?=
 =?utf-8?B?YVdQTDBJT0RVNTdQcis0YUpyMXYrZHJJaS9HYUtlTEtRNWdQY05tUlVSZzNl?=
 =?utf-8?B?b0FBYVg3eUltTWtlQU5ja0R0OWV1QjY5djJMTXdzL2w4MDBRTXVDNjNNdEFC?=
 =?utf-8?B?eWVhM0k0M2dkTlpoa0lrc0hvcFVVWW1VZWJwaTBFZXU0OVV0WmNMYk5raUxM?=
 =?utf-8?B?SkM4WUhlL2lDY3gxY3cvdXdkbk80TWxzU1BabURiNkNnN29LK3ZybUZVWU1V?=
 =?utf-8?B?MzAxWTc3Q0R4OUUvTXdjZ2tXcXhzRHUwejhPdDh6bGxjdGpPdGZrK2d5ZmpI?=
 =?utf-8?B?NXVVd0RTTXBYc2gwcUlmbkhXdUU5ZEdsOW9xanV4eUZ1UGk4MXdMS2psTzJH?=
 =?utf-8?B?NWswRVcyaE1MTkdVUHZ0WTgyaTFURVR6bHU4aTRTUmxYNmFvam44OGtkWHQ2?=
 =?utf-8?B?RXNsczVTdjV2RzYzNEQvZ3VROEZDK0hvSUpabk93SUdYc003RTN0MExGa0p5?=
 =?utf-8?B?c0RZQ1RBanlrc2VMYzZnMWFwNnIvYkEvZFg4cllSODBPYW9nR2NnMVNVU3V3?=
 =?utf-8?B?bktlcUZNL1dGbjVsdDdDU1d0YVhqWGZzWmRUWk1lN25UZXp4RmJ0empxanZQ?=
 =?utf-8?B?SWQzd0VOaFllQUtpWUlYaGRkclZYVTlUT1N6TDBBeitvWVprNHJ3ekxKdFhL?=
 =?utf-8?B?bE9MTkNKZ3lPb3RVRkxKQTI3WDlYVWliNHNiS2trS1B2L3JEOFltZ0F4TE5u?=
 =?utf-8?B?UmkvWWo5T2I2a2dldE14SURtNWRGWFkrV1VzNG82VmxuR1Z0bCtheG1yK2dD?=
 =?utf-8?B?R3N1WlBFUDc5MWd4NWRpemJOLzh1YjJxeXZJMWZCU3NtcTJOV1NRZ3V3dUMz?=
 =?utf-8?B?cTNzZ3lVRldSQjdCcGthSHJHZWpNWnoyUThnRnRxRzI4SHBaanlDcS9SOHV1?=
 =?utf-8?Q?Y5kUO6FTha2JnvIVkalXzADjF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dac657-1e03-4433-cbf5-08dd4d1e7b09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:39:06.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ispT51ABUiJsf8fHrm6kcaEZwc2hQvsVREMHpmACIl1JO1bFIQdTUkXL7KAqqR/4ug0+mlXYQBLpiY1Al6x4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

On 2/14/2025 7:51 AM, Edward Cree wrote:
> 
> On 15/12/2023—
> wait, has it really been more than a year?  Yikes.

Time flies when we're having all this fun?

> 
> On 15/12/2023 00:05, Nelson, Shannon wrote:
>> On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
>>> +       if (snprintf(name, sizeof(name), "rx-%d", efx_rx_queue_index(rx_queue))
>>
>> Adding leading 0's here can be helpful for directory entry sorting
> 
> True, but it's not clear how many to use — the hardware supports over
>   1000 in principle, and in practice it's normal to have one per core
>   (and more than that on TX) which can get over 100 on powerful systems.
> Yet on something like an 8-core box having queues 000 to 007 just looks
>   silly imho.  I don't plan to change this line in v2.

I suppose you could do something tricky with %0*d and log10(num_queues), 
but that seems to be a bit over the top.  No change, no problem.


> 
>>> +           >= sizeof(name))
>>> +               return -ENAMETOOLONG;
>>> +       rx_queue->debug_dir = debugfs_create_dir(name,
>>> +                                                rx_queue->efx->debug_queues_dir);
>>> +       if (!rx_queue->debug_dir)
>>> +               return -ENOMEM;
>>> +
>>> +       /* Create files */
>>> +       efx_init_debugfs_rx_queue_files(rx_queue);
>>> +
>>> +       /* Create symlink to channel */
>>> +       if (snprintf(target, sizeof(target), "../../channels/%d",
>>> +                    channel->channel) >= sizeof(target))
>>> +               return -ENAMETOOLONG;
>>> +       if (!debugfs_create_symlink("channel", rx_queue->debug_dir, target))
>>> +               return -ENOMEM;
>>
>> If these fail, should you clean up the earlier create_dir()?
> 
> No; these errors mean "we didn't do everything we wanted to", not
>   "it's all broken", and the files/dir previously created are still
>   useful.  The caller treats errors as non-fatal.
> See also the kdoc comment on efx_init_debugfs_rx_queue:
>>> + * The directory must be cleaned up using efx_fini_debugfs_rx_queue(),
>>> + * even if this function returns an error.
> 
> I can't think of a suitable comment on these return statements to
>   clarify this, but suggestions are welcome.

Maybe something simple like
  "We don't clean up the files on errors here as they are still useful"

Cheers,
sln


