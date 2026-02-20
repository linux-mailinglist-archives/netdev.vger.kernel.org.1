Return-Path: <netdev+bounces-259659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECZaM5oXmGki/wIAu9opvQ
	(envelope-from <netdev+bounces-259659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:13:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE091658BD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8909F300AB26
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B8A33509E;
	Fri, 20 Feb 2026 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjfDmdLN"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8102BD030;
	Fri, 20 Feb 2026 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574933; cv=fail; b=P3bR4S8hsJBFQlRPt62g5AOoaK4BZxMVPKJaXqLv/tlMI6J6gvHi1WMBnnDm1TjDGz44SCkhuLFjp8Wm720X3IgiuZWjezD4fQb05pOpN6uwybyy/MiI2vrnpm+BLMcx1aRg3Vmpw7QD9nyxBLxB3m1WJiG8xpzNnVOrq9iQlZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574933; c=relaxed/simple;
	bh=4OM5tF0vPyVKRi9Nq1tL8OUOxk7extBXUU7mmxaMLx0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBYwoNhMRiL8GgXSbCyk6mXfp0BT6I7PlazzvFFiwOo9y0f0SxzA3ig5D8cSK4zE3mWntPROfmCluYwjmC+1clMWgDS3mCi8IzQV5iVr3bfb/DvjPPaCoUXA3IKiSsHluR0rYor9WyK1a/XHyuSMGXpWbo3c9QxKPGVHuF/hfPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjfDmdLN; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2UgsQj879sa5iazplBWYSiEh/t6bPtkLC5Gh4tksbyWTFGqTRVaY/dxjLs/ZP18TQ8L5hsc2Jhid8UGe7iG1xuCcfFGvNAlbGuXaielvgHkV6Uf2vTpaJmlVAeLssWDn+JOSA8UOichDLWPobzCCdMxBvjsnanAirdpluKf4QTOK+GcV9FR+oauXoiTok0TWmriVjAFcf9G3HbInu9NX7brVvS5tMw2JcuVkU1/0t155mkRFFVH6xoE6zQ3BsMOcnGPCe1v4knPK/KXI9OK9IPP5iX8yE9g7Fzw76V1I4mqgExnr2f0msplxTGPOJaBX88QL8qA1HCSpdqgHcC8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16V0Mtkntxs9GWdv4n5PifEfb+/H+K/zGCj/52Pd35k=;
 b=x2A8L5rXPqTfgjy2NvbBJGoYklRYXV+b8o4ETzwoEoz3axoavrMfY0yPrJ9w5eTyRKqRpCLD+F3G8cHCm7SuUVUFgK6dADwPsbVIB68mmH+l4KqdSQiksCZ/vcL3yOtoLA5lU4hCEwRw+SN7JHPuU/m0v38bGKZUsNUeDXXzjXC2joKkwDbD4yLhx7cymhVblHEzCZXy72yYzGplVcVwrtMAJLMjhW7tM1f02YSTsKWc5MSyGDaef2OvrcnFUt8TiBsZdUJWTRGtUHP+/17BPYaTgUC3yQoW1KBVvkpwg+1TaglPEdzX+0W+/kT2xncRHm3KzEf6W0VLogUuZU2W5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16V0Mtkntxs9GWdv4n5PifEfb+/H+K/zGCj/52Pd35k=;
 b=gjfDmdLNb4siGef7KUXgKE1uXxYwXH+++RjZInMUCgRNf5WO+qcW38D/px31OXzvR/6qKhn0M4WiT5moRHDixym56uXUvC3BqC3qieCDPy/29Sts1YReDyOm4nEsav7N1ogPK1PWC5VNsMFM6148dpgWMgp+QjU8HNDyEJ87n/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 08:08:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 08:08:48 +0000
Message-ID: <7e9e5772-1991-4447-8b07-846b2c503545@amd.com>
Date: Fri, 20 Feb 2026 08:08:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
 <817fca78-2416-44d9-9e1a-301e2a42e88c@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <817fca78-2416-44d9-9e1a-301e2a42e88c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dc24c3-bc03-4056-4624-08de70574699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGk4L3gzUUNuWnFtWHJUeDZmL0ZDUDFBS296UmM0c2ZPNm1Wc1ovVWVobW1Q?=
 =?utf-8?B?bk1tTVY5bTJmRCtabWZYcG8rQjkyWWhWNnJuZUhrWFV1OW9kS0VsRTR0S0NL?=
 =?utf-8?B?NFRKWC80QzFIVnkzMm5zNGpoRUVQSDA4a3F1bWxIRkF5OWMxUEZ5NzhvcGgv?=
 =?utf-8?B?c0pReVpqMzV2eVZ6V0VadlFwMW5BRW84eXpoNjU3ejQrRW9aZjhWbW1SK2M4?=
 =?utf-8?B?aDFGYmwxNkxrMTd3MHpJWkRPZmZxc2xxVGhIbmFPdWdram1mT1F2ZUQ4VVVx?=
 =?utf-8?B?SDNDTWRjMXAzTStJV1dCN2JMRmgwYlNISGRnczRpNGU3UE5VVUdkamY0MGNT?=
 =?utf-8?B?ZllEYW92WmpnRG5pNDlNSk4xZzBFZTBuTUF4RUJTMC9uNWJmUnN6K1ZFM0dR?=
 =?utf-8?B?OEM0dENiWlJFajE5RHVGNGNIZEVvY0pCNitWYVBpZHpuZXg4eERWdXZnNS94?=
 =?utf-8?B?cDNzOTh1ZUFrN2FRNVJPM21xSFU4ekpKdlM5Qk1YckVHK2NWMFhBdkpKazRn?=
 =?utf-8?B?MWRwb3JPNXNDTTk5WTAxaU9YaWdhWE5rUVdQT3FkaGRUSk5yN25VV2ZjSDZH?=
 =?utf-8?B?YkZXMER2YTQzYXlrWHhNcXFHQUxXbWR2amQ4a3VVL2ttQWxmNDAvK05pdUZW?=
 =?utf-8?B?Y1FZMVRqaThudUQzb3N2bzBOc0FDSTcxbjkvOW52TVNmTC9YQ2RlMVBsRXha?=
 =?utf-8?B?NW96bHpTM2RSMDhFRlZKdGtuZitoeWhnSlBLQTk2bXdZOFp3aGxlang2OVhj?=
 =?utf-8?B?UU84TUt2cWVWN3hSZjhadTJnVCt1NkFITituOFVwNHorNnpvbldoU0FEL1p6?=
 =?utf-8?B?a3lzR0tPN0lWRDExZ21pQnB6SnlVNlR1UmJOL0JuSjJ2Q0NSRm5MUVdZODZz?=
 =?utf-8?B?QW5lSHVtdXEwd3pjeXhsR2FPcGlHWHhxSWNnQWtnWlVMenNCMUtFS1JML0pS?=
 =?utf-8?B?Wlc4N2tnWExhRmphT2JTUVVvbXQ0R1dIdmUxeEQzZnFWTVJSS0NtYjZhN1cr?=
 =?utf-8?B?MUVPOEFRZStkMjZvczdKMDE3RFNSL0J6NEdjdFVPcTlQa0hoMkJZTk9VQ3lq?=
 =?utf-8?B?SDdlVGhoWXlQWFYxaDMzSk01WTRIcTBZMHdOSkdzenNFRy9ITWJ2ZzVVTW82?=
 =?utf-8?B?MHNYQzFBNWsvZjNsVTErUTl1RGJyK3hrak51UVJRS3cxREYvanN5N0tQVTI1?=
 =?utf-8?B?eE5BSng4Q1NQelJvWWtFZkdHaDNNc3VyNFBjRS9jcU1OakNUWlN3dVVCcCtL?=
 =?utf-8?B?R1dRS1M0dXVqYjJ0OE91OTJzYTYzenlhR3R4VmVCUkZqY1piSUVrWkw4RTdR?=
 =?utf-8?B?SzdlVFZkTVRIb2ZZTVFKQkRMQmc2OWxtVDdJVWl4VTlSY2piL1lPUUtRRWQ0?=
 =?utf-8?B?WVhlSWMrblRqemVHcForY3BhK1dSOW1rLzhjQUVBVVpJSy85SloycC9JY2ky?=
 =?utf-8?B?Mk9LMDVueHdwTEQ5MVhqTFhJdTJpb0FBazhBcXVYMUg0K0hYYTZVZFVQOWFx?=
 =?utf-8?B?UUhwR28zdmd1ZVdUN1hsYzFlQWRNNTNBTFZ2T1pGQ2NmdTMzZnFQSVptY2M5?=
 =?utf-8?B?ZXhlWjlCZHY1RVBUa3V6QWVmc0IzT3JOWFlacWFLcWV1OWt6ZEZEQnpmMnFs?=
 =?utf-8?B?MnZnWGNPT2hMZGxDSU1WN0ROWmlSamxkNjhLSFA0cE0zRTVZYmhUUlpsTWps?=
 =?utf-8?B?RStsNVVlclNyTThJelhLS1AwRXpzWnRnZmI5ZWlMNDRQNHZjNTJQa1p2czBv?=
 =?utf-8?B?VjR1ZzN1WmNTU0lwKzRMMVBySDJ2eERiRHZ4cU9yNUt2YTM5SDkyM05STW83?=
 =?utf-8?B?SEx2R1ZHZ3ZJRVN2b0IvQjZPUkt5MFI5Q3FHdXhYVGpmRnJoQVJHZEVIaG9G?=
 =?utf-8?B?QlBTSFE0OXdrZkh2TUs1b29zbXZsVmZoN1pNaDZ6NHpEVHQvamZaVlZMcVA2?=
 =?utf-8?B?N2xjUlFWWWh5dlFzQlNDbEtLWkExNDVzVCt3WVdSQ1RhSUFzYWJxdHdzMDNo?=
 =?utf-8?B?aW56dkx4V0dGOUNIb2tpakQyeElXMVpscXF1bTk1NlpOVHNld2syVDJNR0Ew?=
 =?utf-8?B?QTJMWVhxV21IbTZ2NWhqTzV0WkpNQzNReDltMGFBSWlIeXNCWnRFS2JFMm9m?=
 =?utf-8?B?bkZPenEvaVFsd1RjV3lQazQwSlFQZ3BDd0RlbWRYSzgvQnBjdVV3cFJxTG9F?=
 =?utf-8?B?VWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWNzU1laWEY2Y3g1WGpFRW5NeGU2b3VBR0JKOUtCeGRvMWJJZ2JqZ0xyTHNq?=
 =?utf-8?B?NE9nZUw2RjFsalFQY1dsaTI2eDV1VzA3clg4c0l5d3A0NWhwMkU5a0c0amRD?=
 =?utf-8?B?UjAxMTFjSHFidzc4ampXZ3lHWDZPTlk3NHJ0L0ZVWG1naTNib1RoNndDYUky?=
 =?utf-8?B?QllqeGVXOU82VzdxSzZ2Q1h0ZmQrbFc4MTNrSGttL08xK21wUVFwZ0pYN3Uw?=
 =?utf-8?B?WmVpdEgyakJkcG14ZEFwWVBkL2oyMXNPTTlqWlpHUXg3c3VRYW1Ldi8wYjVr?=
 =?utf-8?B?RS9tdk1rSkJ5YW5SOW9Id0t5bnpwVnllaFI2MGFzYjNLSHZNZFhlejhIV0lt?=
 =?utf-8?B?M3pKUzE3L0tZdDVaRGo0YkFiOFBtQ25KVlE3UDlRYTM1VnV5MVBUL3hMbTd4?=
 =?utf-8?B?eWhLN0diTG5KOXBVZm9aWThNdGt2RENXeCtlSU5PelJWNVVQTnIyZGhFMVhP?=
 =?utf-8?B?WlZUUmQ2OHgzQmtNNXlFNVdXRW41RWhyRG1ZVXhYeGl3UGlBbWd4VXJGWEpF?=
 =?utf-8?B?eEUzM0JLTkZUT0dMaERkL1kzKzhwbVhaZDJSTFRHTnFJdEZLa3dydVlkamxq?=
 =?utf-8?B?aUF5SWRBK0JySi9qQjEvWjh6Q1h2ajd3RWtja1doK2RldDlPcXQ0K0hCaEI2?=
 =?utf-8?B?dTNPc1ZqY1lQdTFjVk94Nzl5dzI4UVBxQ01XNWZVZmVtR2tLTS9MYWNxeXhH?=
 =?utf-8?B?VGI0UGJCUnY4dmFaNEJMU0Z6dXNlZmlVSU14Rk95MU9BOXhiYWo5czZpSXgw?=
 =?utf-8?B?a3VQZW9nRkpzSmVXZlphN0xkVnpZNG1hMkhEUlFhZ0VIS1l5M3JOc1dYcTBt?=
 =?utf-8?B?NUxOTmZLSUx5VUtCNDRPRUJXWHlYL1hDT0tBYURYWnZ0ancvL0VabDZGenpK?=
 =?utf-8?B?K0NoWlk4ZmsrUW0weHd2amt2VitTWDZiNEdLVSsxdHVHeld3NkcrdTZTYTly?=
 =?utf-8?B?SHd2R0pHVkdTKzVGQ0NqY2EvSTNhaFhsOFlMNDRqTEtlbWppYVBJS2V0SUVl?=
 =?utf-8?B?Q0JUTFhWQUczeWxMTVZJY3VXdDEyVE0xR0dIMDZXUlF2NmVXT044UkhPTEcx?=
 =?utf-8?B?Rm42aXBjbVNqZGxZdzE3VjduTWliTC81M0dxTjI5cHovM3h3a2hKQUhOSllw?=
 =?utf-8?B?Z1FkZlBSbXhIMnJZRGt6REVlbjN2QlB4andKZmJ6MTgyN1djb0tDUFl3dXBK?=
 =?utf-8?B?NnBFN1ZWNkdEV0EyTmdVSnNDRktSM1I3dGJ2S3YyZFNyVHdPZURuWEVrUHRh?=
 =?utf-8?B?MlFXY3ZZeitqelI0T1J0d1ZleEs3UGNwUlg1ZnVtd0xRcGFCeEsrcFlmeE5P?=
 =?utf-8?B?czh2YXdzQnUzeEJGcWZTS1o4b2RWMVF6dkZDelNCU1NGTEhlZ2haWHRSbVdU?=
 =?utf-8?B?VkQ0a2x5Z3ozNmxrd2kyS08xMHNPZVNBTVVLeVpUdzR6OVlJS2pXT1lUUGhF?=
 =?utf-8?B?bEVzeWlid1FURjdJWGw5Q05JdFNnOVhrY2FmYVVEbFgzZjdYOFRWRjRoaTh5?=
 =?utf-8?B?aEZwS2NJSlUvUGt3SStsRGNGOXQ3TG1GZVd4US9UUDVmNEswemtQcC96d1U1?=
 =?utf-8?B?TERxNUo0WC80d3FzRERQdHpHY2dvK05QVENJeDhWVDlKL1dRejI0MC80U2RZ?=
 =?utf-8?B?Ti92emRLbHZRQnlrdzFzeDlOTlIzWnJ2NndwZlZRdzlGWG5sODEyUGZQNjdH?=
 =?utf-8?B?bWk1bmJaNGRSeVZFa3dkSGp1VmlaTXB1T2hMWVRMNGVoN2xMQVU2WHRJOUNs?=
 =?utf-8?B?SE51UWp5VkRzLzFUbUlJekI5UldPSUgwWnAzZklQYzYxbWx2REt1QWtiR0Fq?=
 =?utf-8?B?RDA3V3FpbTRUOWovL09vWVhES3NxdUg4d1dOeGorMm02ZFZQMGhjUGl3bE5r?=
 =?utf-8?B?TGxGS1FGcVZXK1FmNW9XK296cko3Q1E1Mm4yRERkMHY2UzFNemJWUUd6clpR?=
 =?utf-8?B?di9rUHd1M0ZWdlRXTWs1VXIwSWgyTWJZRU1PTDdUUEpTS1ZYckdtZ1o5QUFZ?=
 =?utf-8?B?VkdvTVcrSC9aRHhUV0cxdmNnTVhpb3IxRGtnZU1YaFNvelV5cmtYM1ZTd2NB?=
 =?utf-8?B?TG5QMmF5d2RDNkZrYm9nRGljS0FyWUR2QXVPQ1J5cnBiMjBPZm1vdHFNaHR3?=
 =?utf-8?B?WVVvdG91TlUvaUVPcHViMjVqZUdncjJOcW9GUzh4M1J6Zzd6dysvYisxRzdM?=
 =?utf-8?B?NXFFVllhM2pzWTQ5YzhtN2wybDFLcW9nNDVKeDlWdFNOcERrM2FydGF1ZTdK?=
 =?utf-8?B?QmFqN01mVDZ0eWxQMUpzcXdZU2dBM3FGTTV5citESC8za0pVN2c0LzVSV3NB?=
 =?utf-8?B?ZnJTb2JJUEZUZ3hXWi9RMnlhaDNxRlZjRWlFNUNjK3o5VDhkTmREUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dc24c3-bc03-4056-4624-08de70574699
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 08:08:48.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSmOh4trsBQUUqso02xLBuw1qk9dsihVajHtqYsfF7kLqAmL/11JJ41OJfjKFBi8/SXAyDX3n4A4WyoFnnp+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259659-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EE091658BD
X-Rspamd-Action: no action


On 2/19/26 23:31, Dave Jiang wrote:
>
> On 2/1/26 8:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Check if device HDM is already committed during firmware/BIOS
>> initialization.
>>
>> A CXL region should exist if so after memdev allocation/initialization.
>> Get HPA from region and map it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index a77ef4783fcb..3536eccf1b2a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -90,13 +91,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> -	probe_data->cxl = cxl;
>> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
>> +	if (cxl->cxled) {
> if (!cxl->cxled)
> 	return 0;
>
> Should save you a level of indent.


Yes, but subsequent patches add the else branch ...


Thanks


>
> DJ
>
>> +		if (!cxl->efx_region) {
>> +			pci_err(pci_dev, "CXL found committed decoder without a region");
>> +			return -ENODEV;
>> +		}
>> +		rc = cxl_get_region_range(cxl->efx_region, &range);
>> +		if (rc) {
>> +			pci_err(pci_dev,
>> +				"CXL getting regions params from a committed decoder failed");
>> +			return rc;
>> +		}
>> +
>> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
>> +		if (!cxl->ctpio_cxl) {
>> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		probe_data->cxl = cxl;
>> +	}
>>   
>>   	return 0;
>>   }
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +	cxl_unregister_region(probe_data->cxl->efx_region);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

