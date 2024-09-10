Return-Path: <netdev+bounces-126767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E218297266F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123A41C21653
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8376A332;
	Tue, 10 Sep 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="03SMuY8m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9159167;
	Tue, 10 Sep 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929769; cv=fail; b=Q9J0GDPl1tBlhiVc2PGSnM9FWR67eWMa8sJ/1hnkea38gUyQ1kpCGyLeQFpTD8Nn7RXV4SjnzThEqeO5/kkGTX71ng7LjApWu4MUgKueD7lCf/eLIyRV3Rw4tfBUNS0+0uw4zsdwKnwtcWI37Do83LN+7wlX6pnQBmDg8EFVRt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929769; c=relaxed/simple;
	bh=mDYKz+AzASHtm84XJnsCXhsCOb9BAr9+H2lbxYhoWEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb8WvY3cynuBr3+c+CuB53hB9HrnRWMuas+nYshO3C19fFXKo+TEdzk5n7fPcMVAOcii4cI8GlEHc4301mF994DHV4z6g8x167zrZdY7+v5RF35cTSPcgi+6vEKggIVT8RqWG9Y2RUPiNk9lofKjkiCBTpu2PIarxxIkaJKgH3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=03SMuY8m; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xil6DU1qBJ1aub3X9MJDBiuZS0W7//ZPmSfayBGnQFAoJAZY5DgPQDXZ9+fc/bKphf+Q0n/SjsInOdu+JXFLP39lqimv/tQYleAWbrPihBSxzdCDuT9RHa6oy0XtI8LXp7wMVwJngW4BIY8FtQ2AG8ra2gJPGMpxwD8TU2qWyh/v7TNURnsfluH1Q/fXNCRUDzVLYqHa0jDRBdY5RpYkIYWfmkJP1L4ilKm1JRIhmA9LykRyz/Jum2yQ86Qz/9sWFq1+Q0BsTIW7uKw2dFPn/UyC4nK7UXaKq9lQDb+NbJRUAwz0kq2S9KAopftnFFH8R596ySQ+Bnc/tAv8kSQ7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+dg2XQB1n63MHR7Viss6FdZJXYe0YQNEQoalzRzMAU=;
 b=COpPd/VnAmGlY/DFPb7WYwWExZKE17cl5fluJCBezkL3pl8Dc8RjyljR7oilfokAcY0y3CGksW4t0i8wHGD9Cj9EdD3yrYxExPUfyfohgZtA3g7DzVs0NaKN0KFQTlAecznWBgWR4udcT9NKGETFIHjOQQ/Kyn+Z2fm6TgBPYWugzVVFJmbVf1/rwa4RQms3t1RqVGj3Mo0mFixk58EEgpGrhRmDxJsErmJyvDFLFGjUB3oqvrLZsgwhvgmqEOmo6zHesPgQTqGRpuhCNITUghL6WK7dxQY38FbwHUkeseCfrfLQFM5bueLLKI9IM4YPGPuMU5IslYFpeKR1Xx3Vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+dg2XQB1n63MHR7Viss6FdZJXYe0YQNEQoalzRzMAU=;
 b=03SMuY8mzBRwg9tSM/xNPOjPxpiQnDtceo04UQNHGpE1aRWgzY3xHpOmlp5HqfWPr5cJ+26V30tor0Ydfj48QtpAj2U91/uEj4Kq1I3n21YQM8IZOWiuwc5zxEKsXynDUcyya9iNSw06/Ij7ODCTIy8I7yeGdYmmP9hbxlrlytY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Tue, 10 Sep 2024 00:56:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 00:56:04 +0000
Message-ID: <fca00e5f-638b-4457-8832-f8458899ecc8@amd.com>
Date: Mon, 9 Sep 2024 17:56:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: xilinx: axienet: Schedule NAPI in two steps
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Robert Hancock <robert.hancock@calian.com>, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org
References: <20240909231904.1322387-1-sean.anderson@linux.dev>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240909231904.1322387-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e68c47e-299a-41c3-507d-08dcd13358dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmZKazBZa1FKRERhOGErSDgvMjhCMVYyTDVIcVFYaWhBRmxEcjRHVUtqaFBy?=
 =?utf-8?B?aFZGZ0ZHQWtqaUxJeXRzRHNEbzUxY0pOa21kRkZOcGtTVks1ZjkyMEJZTHdo?=
 =?utf-8?B?TE9lYlZPMCtnd2xFV0FsVzhRR0o4SzVXcnBZZUNFYXdQZGdlU1J4MWxRUVds?=
 =?utf-8?B?VVpkVUFRMm9oTE5zOXhnOGRScnZCeGtxTDkzMWRaV2I4UFNjZDAxTExpcWhD?=
 =?utf-8?B?b3M3RFV0dFdqSlFXMUU0QTdXZjYwTE9BY3Vaa2tsWHYybXhBV1BJa1Bsb3VZ?=
 =?utf-8?B?OTgvQmpzeUE3REZKdU0zYXBsUWtEcC8yeGZnYlhMc0hzT1FtYUxpYk1KR1lC?=
 =?utf-8?B?eWFYekppTXNRNW0xMzBBanhHbmRuR1BtcGc2SVBoYUZ3dlpZRndraWNvcEVm?=
 =?utf-8?B?SDhYc3BnNjNpSjRnTXdqK2hKcERNOGZ2MU82SW9UV1NFSUlDdmQ1b1ZhWkEv?=
 =?utf-8?B?TkhqWnB5QXJDdWRZaThxUGRWMFY4Wk1VdHpGczlQa29UV21PYjlCRXVNT0x5?=
 =?utf-8?B?UnBiNk1ZclVCb1Vjc0g0S3JsM3RDbUY2Q1YrQWZOcjVTZDloZEFjUTh4YitK?=
 =?utf-8?B?MjVsVm9yeDIvbUJsR1FOL2hFdFpoM2VtdFZDUGhnREIxZ3BEOTN1eVFhNGx6?=
 =?utf-8?B?NWdwNWVCQXJpQVgrSXU4elNBUTBCRy9TeEd0NW1tVUIwSENSTURqekoyNUdC?=
 =?utf-8?B?d2JrdkIrS1VISnp5a3lBQjh2L3R2ZStFQmtIRlBySGpyVTVQelZpU3lSQWVF?=
 =?utf-8?B?ZStqSGFlOVFETm95d0NMdnJmcWd1VVJIUm5VTzAweDRNUnpKYkpqMjA2WUtK?=
 =?utf-8?B?ZTcvYmttdEhwekRWSnBXK3BjdnhxVTF2WjkvZ0ROaWRvTmVaR2VTT0poRjk5?=
 =?utf-8?B?bnhoVENVQm5tT1lLSUVFbEljMzNYbFFJRkNGNDNuWENZTUszR1FoWDZLQ3Na?=
 =?utf-8?B?emNLbmJWZC9RZ2ZHdGxsSjNtaEwwMUh2OE1YaVdMZldvOG4yWVJnOWFwaUZ0?=
 =?utf-8?B?K3NrejRuWWhsWGx2eHBmUjlsb0FHVHZiUUJzSStyZlF5TWNwWHJudmx2ZjZ5?=
 =?utf-8?B?UzY2UEtudTdoQldVaWkybktub2RGQklPaEt4ZU5zL2hQU0VCQTlNRWx1b2RG?=
 =?utf-8?B?djJqcGNHcjhqNFFUcXRPdjBjZWU5ZHJuQ0psUm9NK2xtb0JmWUttU3dRQmJ2?=
 =?utf-8?B?VFJ3U3ZlM1RLc2o4RVRaTkI1WmpyTVh4ZEYzWUhSVWxtR0cwSHZVTnQ1ZXYr?=
 =?utf-8?B?U20vWU14bHdybEh4VGMxRkZJN0tpeG00YTNQOUwrVDgxaUN0bURyNnl4TC9l?=
 =?utf-8?B?M0QwRWpBc1ViTU1Vd0lpQTcxUzFoRE83Y1dxSjRTOTJyWUhLc0ZTN0MyY2V5?=
 =?utf-8?B?M2JOMlpycnR1cnJwaTduYjZ5YkpidDhnNlVYYmRvMExzWXlmd3ZlTUJld3hX?=
 =?utf-8?B?WmkwbXdoQXdVNTM2MGpVM0dRcXovYmQ0cVptcWJtdkFQT2dCb0ZUMGZvdUth?=
 =?utf-8?B?N0JpL3dQSnVUbW4wREJObHFyQUR3RlZRaUdPd2VCREVtV0lNTXJpNmlmZmoy?=
 =?utf-8?B?dWIyV3hpaUNyN3gvRUpvMGRBY2RDc1Jpd0doRysrU0hvYVpZWjhsU0FONGo5?=
 =?utf-8?B?Y3BreCtQdjM5L2MrU3VNL2dPQWlVUmxqalZhQzNQMlU4Vnc4SjZzV0pRdUtj?=
 =?utf-8?B?QnJQRVNNRThBZnRZSy9JdlFrMVFGQmZuSENSVFgwV0hlMzdDSmF3WWVrWnRj?=
 =?utf-8?B?MUFHUWZqeDZUZDdNRUJDSXdzQytMMnZUelZvWVdrSjNBaTJIVlRWd0dvN0sr?=
 =?utf-8?B?RFZuZUxKQlF2MktmdmlXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxQWFBpU2FqNVErZVo2OW5UdThBRDNQM3Buejg3Wk83Rkl4SGZSS0JqazVs?=
 =?utf-8?B?Vm1reVFGcjB4RytCZWl6TitMK0N3cjhiWEpJQzJaMGR6R0ZVQmZTNktJYXZB?=
 =?utf-8?B?Z0lET3FiVWFyTUMrc09RQTJlWTlIOG9GSm1yK0RrYzlFbHNoSVU3em9UdGZK?=
 =?utf-8?B?MHhDQXpPR2ZjZ3crZ040SjBMQm9nbzJ1TTlMckwyNStnQkN6cVJLMG4xOW9C?=
 =?utf-8?B?YVM3dU15N1VsZXdrdGtTcFVzbDBpQlh6NFRhTWFRZ3FmbW9NdTNZV0VJVTNB?=
 =?utf-8?B?QVpLRUFJOVdYSVpCVWFhcktLNkhaZGNTdjdmT09tQkJSeFc0VUFlYkFpVFBZ?=
 =?utf-8?B?N292eWZnQlJBbGlPa1VwVWhTbmdSN240STZUejl5bmlzZjFvZEVOTk1LTUt2?=
 =?utf-8?B?QTVIbVFaTEkyR3R5WGpVcitOL2JzU1FLVXFHcmQ3ZWdHS0gwZ3JWQ1lHRXF2?=
 =?utf-8?B?dUhYeEsrdkpYVGRJVmU0Z3NZN2twT1Q5UnhYOEMvVmgxMEVRV3lqdnBDdmk0?=
 =?utf-8?B?K3UvcGVZNXNLNVI3RjMwUUluRXN0VkxaVnVGNVZCL1VRNFZ5UDRuelRmRXJh?=
 =?utf-8?B?elZhMUdQWnZqYnpPeVRoeVFTRC9nT3BSQTFnRTc1aGhUNUZiMG5HZDFRWEww?=
 =?utf-8?B?VEU5dUgwVmRORXQ1amZ2QjkxQytRV2RNYmtrdE44eVhQYzBpTmtTUnA0Vmhv?=
 =?utf-8?B?ZzNVZkUzZzFmUm8vblZ4SDhvQzRrbGlQMGJzcTVEQXNGWkwzaXpCSUVDdVo1?=
 =?utf-8?B?MWljU3VHaXZUcWNQTFRZRm9pOS9LVWVxa2IzWFhRRFQ3RnF6OGx0cVZmTDNL?=
 =?utf-8?B?UUFTWmlQb29iTm5VWlo1S2hCR2dtaHlwa3o3eTQxdytNUkk4dTR2d3ZnQVZw?=
 =?utf-8?B?TjNXYmE0Vm1walh3cE81UWV1WWdaNEhhSjZCVnhhMlZtbFRGd1lPc3RoTDJI?=
 =?utf-8?B?cnFheWhyRzJtZkNXMndJNFhuYVZFSVZmbkc5NXFQMUp2aEIxb2w3eUoxWmV1?=
 =?utf-8?B?Nm52d0pPbnF2QW9TYWd4aGl3V3JPemQ0ZStlTy9vVWpRY05zM1ZpeFdJdTRO?=
 =?utf-8?B?NHk5TnpFYjJWYnJPYitKRjVvU2tjUEU1VWwxOXdmUXRoSDhQUWN3L0I1WnZZ?=
 =?utf-8?B?cERMQ2swelhvVFoyMTdwdU51Zy9TMUdFUWw5Tktubld4VjdtQjFBeE40REgx?=
 =?utf-8?B?cnBiRmUwUnVDMUUydU9CdjhVSElDS1QvY25JZUQ2MXJMeGxBVTcvNU16QTZ1?=
 =?utf-8?B?RTE0R0lpanRWY2tLQmdkeHFTQjlvOFV0em5vL1Rwak5tdXZhcVZMSWdIb2ZU?=
 =?utf-8?B?ZFlKc2hucDFYelRpYitJVUl5dWVFUW9nMXhLVFV1Smdrei9wTlVJcUVLNFJC?=
 =?utf-8?B?UTRwRkVzZ2pWdU5ONGcyV3paZHdyQVM4MlFCQlB1bWRDMEZMRHo4TEVVY0lp?=
 =?utf-8?B?Vy9iTFFFQ2JpR0V3NllrbjV2aXlwWjlId3FPcmllbGdpYjVieEx2eHd2WXli?=
 =?utf-8?B?SUZsbTdEWXNDellsT1BNREhRTk5samc2bitDMFo3QkppWTF4aXd3eTQ0SFgy?=
 =?utf-8?B?OCs3SjNYR0xlem9CdE56VklvYW16TUd3aVRMM21oRXA0WDR0RzdQczhQQWps?=
 =?utf-8?B?Q3hwRDA0SFdBV3VobWkrZ3FGOFVjTGFuZ3liMnM1Z2I0YmpFUjkwa1kvQVVS?=
 =?utf-8?B?TFVFWUE0ZzVuT3hNaS9oc2RXUzVETS9ialVRRktFVTQ5dVcwbHczSzNqSnY3?=
 =?utf-8?B?ME56eVlRWGNLbW1heElhNnpTRDdta2drblV4NE12STB4L0RGNzJTaVNKYmVN?=
 =?utf-8?B?eVBSUXhzSzFOUGhCUGVhL202dDhVeEp5OVBJWUpTWnZxL2lLZzR0YkVjV3lR?=
 =?utf-8?B?TndpcUpZaVIrenFMZm1FSk9GbUVaL2pyS2FkWVN5ZUQvcnQveWdtMHR0a1Jm?=
 =?utf-8?B?NWs2amxOSm04UFp6WG84eXdNcExFMmowdVNwNndzWTIwRzVQZkllSStEb2o5?=
 =?utf-8?B?ZTRxbUpPODcxeFpudFY5NkhzUGRTTFBzR1RDZytaWXNiZXdDTklsRkZZL3J6?=
 =?utf-8?B?U29iYjUyMlZ2RVlvaHFGZ0Fkak1pNTJLelhScWVKNDJTdkdvQUsvemJ4WTk1?=
 =?utf-8?Q?xHXbTtQ2eXGqeZmGcd/7jTM6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e68c47e-299a-41c3-507d-08dcd13358dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:56:04.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGIaomNoHUYAKt5aOuBmSznXYbthkAyTb0Yw0PZMQk7PkqhQ6Axs57q0on1JaWQqhbk72kHOoZLCSzSTCNF91A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

On 9/9/2024 4:19 PM, Sean Anderson wrote:
> 
> As advised by Documentation/networking/napi.rst, masking IRQs after
> calling napi_schedule can be racy. Avoid this by only masking/scheduling
> if napi_schedule_prep returns true. Additionally, since we are running
> in an IRQ context we can use the irqoff variant as well.
> 
> Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9eb300fc3590..4f67072d5149 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1222,9 +1222,10 @@ static irqreturn_t axienet_tx_irq(int irq, void *_ndev)
>                  u32 cr = lp->tx_dma_cr;
> 
>                  cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> -               axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
> -
> -               napi_schedule(&lp->napi_tx);
> +               if (napi_schedule_prep(&lp->napi_tx)) {
> +                       axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, cr);
> +                       __napi_schedule_irqoff(&lp->napi_tx);
> +               }
>          }
> 
>          return IRQ_HANDLED;
> @@ -1266,9 +1267,10 @@ static irqreturn_t axienet_rx_irq(int irq, void *_ndev)
>                  u32 cr = lp->rx_dma_cr;
> 
>                  cr &= ~(XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> -               axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
> -
> -               napi_schedule(&lp->napi_rx);
> +               if (napi_schedule_prep(&lp->napi_rx)) {
> +                       axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, cr);
> +                       __napi_schedule_irqoff(&lp->napi_rx);
> +               }
>          }
> 
>          return IRQ_HANDLED;
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 

