Return-Path: <netdev+bounces-115141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB269454C0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860501C21121
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B714B95B;
	Thu,  1 Aug 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UTjmMlo7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3FD2F5
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553654; cv=fail; b=s4kyk1NC3hn43uZeJ0s0wap+G6jBAJelCt/jA73JabW71UPv/kMVlWynx7WAa6T/6KmXeoN//CfoRM9vdxS1iBo88k3GicDaj5m4uo9JclE5o7eQ2iOMojeBYjHx89YpRKun6mvv+WXC10B55wdSKsA1Vr/B1nqNzE5A8vor+CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553654; c=relaxed/simple;
	bh=uuGx9whS6TlL2ehzmK35vCdhzJEOmQOnltQP0amHkZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OxKiuombxjsbQBkJzJbRUvrPiPHKDPmLyPKsaxbJvP9Xp8HB2vP8+vIAradP984TqzwCQ6zti9r5L9KUE1OI7Ca+wZTFEP2rsRcyPhkOPJr5W79/FHptHVA67ZZISHEBoIqRJrg2vWOjv0o96Di4TOkEoPUmtRj6Pj2Cd9oWpsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UTjmMlo7; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDcMhcMp4SeytvKxej7IZOtwE2PTuyjWOgBnhZ7BnVYko8IeInFtGo6QTrKHxrlDjJxUMWY/IDGMwAfLl0fzygfh3P9SaLaRb0xqShiKyZ5FkdCa4e6pEFzC4ZLYrkwAjDWvFnkLClCec/SIh/j2txnxrifaBw0TOtP27L42IAacMaxdoal/DEf2/kakrnKc7OZzh3ZdQnW8JDS9Qd7fE0QK2fsOzzPgBWgTM4YDGQTrSGw8ntJaCwKWwgFr5DGu8PiyWW3dlQ+O+jNyK4mKD9nwm/7v6KPXe9ykDMlmQjSyPf+BtTXzNg6puqecHAnNYOJ/n0CPj5nncRWbechjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te8/XjjkxpTL8Ma9jASg3QhskxvlfIdHUTKgz7Zs+yI=;
 b=gZVP+1fgFTQl9dLqgMDhOYMNs8/DBRVU5X4Ez4FXEmNhSwDzOdvOhZM36AMy4HbtJGD3Zgo/OaL3jQ0WwmqAoG/BJG9CPF6z6BZjyYJG8VizLbzyc5urZ3cvNijBc3dleflFDGbNadRKp5z4l7cIAUAN35iR4IMMsoUFbbKmteLlLWefUefj8VHqiS9MKBOes3vNnftUoItPG6GVbRxuL+OBmQTaqXdFmty/2cK1SE41OL0+TF3EHe2txoJd3ZmG0jD0yPB6b90/i9sNCRaowIl0++jlbmkuf5NPYkBnnK29QSzI7k5pNwiwYO/XaTnTYROlAodl32dstTaqhNSfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te8/XjjkxpTL8Ma9jASg3QhskxvlfIdHUTKgz7Zs+yI=;
 b=UTjmMlo7FqRaVvBKhqLYflI/6MqfYBRwqg/EbvpINXFapDgfW2Z4CcMyYsjkKe93pDOoT8K2XJGuE6hUFNaZseVLtcQP5IRVXTycsFQjyxeHTO/o0Mebj6fEn+ox/tueCvZ3v6YL0qahGlDA5B+HKlajDkoSxT7nN/2UZVvz0/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 23:07:26 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7807.009; Thu, 1 Aug 2024
 23:07:26 +0000
Message-ID: <3feda087-400b-428c-8604-7b993e5662bf@amd.com>
Date: Thu, 1 Aug 2024 16:07:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ibmveth: Optimize poll rescheduling process
To: Nick Child <nnac123@linux.ibm.com>, netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
 <20240801211215.128101-2-nnac123@linux.ibm.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240801211215.128101-2-nnac123@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::40) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 12595a3c-7c68-4d73-f77f-08dcb27eb56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtjVGkxd210L1lXQXViakMvMHk0VlZoVkc1SEdXOUZyUVZzQjZOUHB3Mjlj?=
 =?utf-8?B?cVFMSzdHNVJycVJJRHJsRVNnSks0UmpYdUxuR3dYK3BqMWRIK2c5bnpjNlhz?=
 =?utf-8?B?Z1hyVjkzN04wMzV3QXp3NzBZdVJEUGtTTTNFY20xWEluYm9LMlozRG9Zcnlv?=
 =?utf-8?B?Z2JVYVRLcnQyeXo1cmVHeXcvR2xKWERCa2RhcnBxbUMxNEJoMzZ4cjY3TTRl?=
 =?utf-8?B?N1ZlUGJnWldvOC82WFVyOVJsZFZHMXFLTjM3bkpCL1psNHpyOHpDbXA0QzRM?=
 =?utf-8?B?YzlBVEVkcER5akpYWU1Mb2Y0b3V3YmhraDV3dTYzVnFQLzFhUk1PZTRuWGpU?=
 =?utf-8?B?VCtTdmRPMVhTZFAxdWx1aDVQNUdjREd2Q3VYdFk1NmdPMzcrZE9mR3N2STR1?=
 =?utf-8?B?S2VFQmxsdG9TcmhnRVozMHVqZkRhZ2picGs0NWI0NnI4bjJTWEhoa0pkdFkr?=
 =?utf-8?B?eTdHcG0xRXl6dVVhd3JRTXpFM1FTaDU5Z1BIYzZRczd4OVErZG9DNnBHVVNM?=
 =?utf-8?B?SjlQWGdvNTR4Z3YxSEhEcnNsanpQQTlOTmhrTzNvUEdwNDJvRCtPZUtNa0N0?=
 =?utf-8?B?ZjY0QUVOeWNrYW9KcWNFb3NUWXFZaFc3TmphOTkzV0N3NmphK1NNTTBabms4?=
 =?utf-8?B?SFc3NTdRbE1YQmlYbDRlRXVQTjY3aldyUkIxbVRXR2tiVGc3alZ3djIrSmZO?=
 =?utf-8?B?QWF3TGVSSkhaOHVqd1g4OCt4VmIxdFhnZlVtYURGdVFPZnlBdlF1TXYxU24w?=
 =?utf-8?B?M2J0NWxQbU5HWWorYytCNDdVNWJYVHkwK3dyL1R2K3k4OWNGaEs1aUdVdzdj?=
 =?utf-8?B?TWdsR05vV0c2bGtJNmFDdE12TUVmQlB1MEtTNXpKNDhWa0x0VjREYXYvWWJZ?=
 =?utf-8?B?dll6LytUYU1VZUJkNGtMSnZQT0hCUlFoYWFId1lkWGRqZ0JUeFBkeStMVXp6?=
 =?utf-8?B?czhjRzViMFFQaVptRnBDVXJaRWFmRnNQOW9HREZOQXhPQmJYVTZJdWpVdjRu?=
 =?utf-8?B?MjJvRTVucmpkNEZBdGRML2FSM2Fzb2EyV2VjVnNDUEFobitYT1VMK3hFS3pp?=
 =?utf-8?B?UHMvTXRKUmQrUnpWQ1VTRXlkSHJOc2tGcGorc1lIbDVMQW1wOXlFMzFvbmlN?=
 =?utf-8?B?SUltdjhoQ25saEtvVVJjSFJUYXJONTVZZS94ZFpGRFRUTzFUZjJaSmR0djVZ?=
 =?utf-8?B?ZDhFWXhlK2psa2QxallwQ1lKWm5aMzNaMlFQNnpCamdoVk93bGxvK1ZMQ2hE?=
 =?utf-8?B?R05qQWxWVkNVWXlWdGZGUG1uV1lkMGpVSDVUbVNhaHFYUnZpdGFpTDJLVWNu?=
 =?utf-8?B?NmVDL1F3RHhEMldiNU5DTTlKS29lL3F4bHpITmZQem1NZGQ2Z1Z6QXhmVzAw?=
 =?utf-8?B?akh0SHZhMzFNcUs4L0p1ZnM1NGI3WUhpaCtUa2tpd2FjamdHZVo3aVBDSlNK?=
 =?utf-8?B?bXkrc3UvQ25paU5JUFozdDVKaEZKVDU0YnhUQzZJTjZxcW1GNlRxY2FwQXJ2?=
 =?utf-8?B?RjVnYmNTTEJuMThjQ1hlcm1KMWNlR3lkWVZpVjlCZUNVNmxWcko1Y1g4WjZr?=
 =?utf-8?B?N25LWUFsanVsV21pS2pSb2xJbFJ4NTRlSEJSa1V1Unowb1JtMDQvbWE5MUxr?=
 =?utf-8?B?dWFSZTN4SUQvVUwweTlXNWNWZjlLNzhZazF2VXZsSGdNWEljb2krOXVwL2Vx?=
 =?utf-8?B?RkJucWRuK1l0TTc5c1N5ZFB5Q2tVdTJXZWx5d1cyMnAvSG95OTA5OFoxRXhR?=
 =?utf-8?B?cWhzRit5N0hzd3hUNWlUODVhM2c2Mzh3bVdDNkVMNmloYXZyQ2c0NGRYVGk4?=
 =?utf-8?B?MkFxOFBsbHFvdnRHUzhQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW03bktmUnZmaG93Q2t2YmZmNHUxd0Q2MjRUZkFMZks2Yi9ZMmY2Qi84N2xE?=
 =?utf-8?B?Q0E5amp4V2VQYUR2L0JkRGtzTExNc3R2L2VGaUg2ZERDMXc5YlVtTVNMeHdo?=
 =?utf-8?B?NXdYelNIUmZ5dmdMZnkvZkh1K0xYSGE5OS9PV1RmaGRoejRTWVNNeHJES1VP?=
 =?utf-8?B?azZxZnl6ckE1QUdwVU8wTU5VOVUvbkU2VS9EUTBzUnpIQlJXSzhRVE9pT0JN?=
 =?utf-8?B?MFgycnFOMWR6anM5aTI3WktEMXp0RTVzNUN3QTZGb0lzZ3AzN2tRNnF3dy9Y?=
 =?utf-8?B?SjBseTRoSmVRT1E4TENFN0ZxUlVBVno2TDZNd21SUGVXUUhQTWE5dEJSL3Mz?=
 =?utf-8?B?NkxGakMwV1d6RmR5VUkwY2JXZU5pbjZWMmdycG90RFhtTks1QlY2UTV2SEd6?=
 =?utf-8?B?dEpLUGNBSjRWTkNtc2FHV0Uxc3JTQ0pnVy8yb1VhNDgrVXhZell0cjRWa2dR?=
 =?utf-8?B?OHRHcit6Ti9pMjhUbENqLzdPNUQzY1BmYlRXYlh5S1g1QWIzdjZmRWxFY054?=
 =?utf-8?B?cE11U0w5MjhqVDhBY1lBY2VaUlVIcDMyQ3hNY2NCdFRGa0lwVEd3ckJKb3pa?=
 =?utf-8?B?b1lCaWhZbFRWS1dHaFBWUXF6cnFPbmNYZkRtcnc5dWxBVDhGRXp3TzliSUVX?=
 =?utf-8?B?bXoyNzgwVVdqdW9SaC9pWEt3WERZdkFtV2hzQWlrU1kvYkM3NzRtQTkybjFY?=
 =?utf-8?B?cU9CZiswU3lnVmZMNzIxbExBa3FlRVJpSXE4Yy8wVDRpQk9va21CNVRsZlpz?=
 =?utf-8?B?aW5KRmphaGJFTnFTa3V0UmZOeFdlUytxSWphVXkwRmJ3b1JiRDlHMDBzd1ha?=
 =?utf-8?B?K1lFWEkydExnaHhjTklDWjNIbU1ZK1hiZGJSVm5lOGEwVkNTUForUWF6V2dV?=
 =?utf-8?B?OVpOenRaSlhEczQrUEl0WmpVUDQ3ZXBRWWNPaFA4V200eURlTFdIV1pxc082?=
 =?utf-8?B?Ym9namhzdnJXZ1VJK1E3c0oxQVRqUmIrV0JESU1KNzZCOTFHZHRtQVA5Y25l?=
 =?utf-8?B?NnIxeVd4K2h3MzI5bVdDVzh3TTFCbHR1R1Z4V2ZxblYrWXoyTXBLOWlrTW9v?=
 =?utf-8?B?NXBxT1NrWm1wVEhVNTVsR3NYeGdmZXpmTGdBdkhBQWMyeGdJK3hDRGM3VEZD?=
 =?utf-8?B?NmoxUVVkdjJTaUlWMWcwOFoxZ2NyTk0rQktpek9WbGhMZU4wRTBDQmlzYzlC?=
 =?utf-8?B?OVVoN1VxWjlaNmhBNmt0czNmN2lQZERpdmRBajZvSUtYMVJHV3dTS25CM3Bx?=
 =?utf-8?B?d2VIc05ndDNueXI2TlFSa3JmMDJxdGtmcGJhNHowdS8ySDJNWmRHWUN5RFUx?=
 =?utf-8?B?OG9pNHc1WUcrekN4eDgvbUpRU3hPVm9jdzhCNVB1dUh4dU9lbkZ4T0dROTdJ?=
 =?utf-8?B?WUFHRFlPbGtBTHJBQlJDd1RnNFZNdHhpNkloUGRFOWNoQmUrbEpBdVVjUFYy?=
 =?utf-8?B?Wm1yUTR2ZjZaK2tWUGI4d2RrMWlrYmw1Z09uLzdJd3RoRHRQa3gxdGdlRGJ3?=
 =?utf-8?B?b2tlZi9UZElJbk5kOURTWUZNNTNmcFlzcy9ZTEZUL3NlMTN2bWVrWU4yYk8r?=
 =?utf-8?B?UEtlOHYzVncwdHJHVkJPUEo3cXltWXpUeUdGNHVVRldOV3hZTkJpVHl5ZnJZ?=
 =?utf-8?B?Q1RaOUlFN01UQlJXRlZyOXFTbjdDNzdiVzJ6bGdWZm9qZEFLeUNIRi9wSFVq?=
 =?utf-8?B?TmpoYVdtdU9LcFpWdWlCZHYzaDBXV3BvK0FnVmxLRStMZ0JrNitBN2NHM2Vl?=
 =?utf-8?B?aDdWYzc5VWZXOEVzY3JEaENNZnlqYktIOStySTdlWVdDczRkOEgyWC9MRCtu?=
 =?utf-8?B?UWVnYmF3VktISk5MSzZ0d3VZc1NUcC83QWRBY3RGc2Q0a2l4YSt6bDJjc0hm?=
 =?utf-8?B?MjFiNnhYZmEzbmJrQlY2ejcvWmJpMnRuaE4xZTU3eUFzcEM3cEx0amgyeFQ5?=
 =?utf-8?B?M3VwbkM3SjlFeWF2azJCdE0zbWZRU0xrMEZhQlByaW9JNS94OUVhM2xsOU1V?=
 =?utf-8?B?Z3RFRmFvZGpxQnRIVmVvc2xoRmZ0UVJ0OFlyZWxVZVZ2d1pJdWM4U2VKdWFN?=
 =?utf-8?B?ZXdKb1I1MW9lY0lZZ1Y3aElxNFR4RXM0K3V4RDVPeVc3eFBXNFFNRUlZR0dY?=
 =?utf-8?Q?xI8qEJTKMg9PPuHT7XNJSOl+R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12595a3c-7c68-4d73-f77f-08dcb27eb56a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 23:07:26.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtfGG3e1UyPM3pJPnsx3tJIjRSeTIQEz5BshkENZxcXNV34cko9EUuIsrQBtWB9Jk4N8w+WQGsfLHpV4c1ZomA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

On 8/1/2024 2:12 PM, Nick Child wrote:
> 
> When the ibmveth driver processes less than the budget, it must call
> napi_complete_done() to release the instance. This function will
> return false if the driver should avoid rearming interrupts.
> Previously, the driver was ignoring the return code of
> napi_complete_done(). As a result, there were unnecessary calls to
> enable the veth irq.
> Therefore, use the return code napi_complete_done() to determine if
> irq rearm is necessary.
> 
> Additionally, in the event that new data is received immediately after
> rearming interrupts, rather than just rescheduling napi, also jump
> back to the poll processing loop since we are already in the poll
> function (and know that we did not expense all of budget).
> 
> This slight tweak results in a 15% increase in TCP_RR transaction rate
> (320k to 370k txns). We can see the ftrace data supports this:
> PREV: ibmveth_poll = 8818014.0 us / 182802.0 hits = AVG 48.24
> NEW:  ibmveth_poll = 8082398.0 us / 191413.0 hits = AVG 42.22
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>   drivers/net/ethernet/ibm/ibmveth.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 4c9d9badd698..e6eb594f0751 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1337,6 +1337,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>          unsigned long lpar_rc;
>          u16 mss = 0;
> 
> +restart_poll:
>          while (frames_processed < budget) {
>                  if (!ibmveth_rxq_pending_buffer(adapter))
>                          break;
> @@ -1420,24 +1421,25 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
> 
>          ibmveth_replenish_task(adapter);
> 
> -       if (frames_processed < budget) {
> -               napi_complete_done(napi, frames_processed);
> +       if (frames_processed == budget)
> +               goto out;
> 
> -               /* We think we are done - reenable interrupts,
> -                * then check once more to make sure we are done.
> -                */
> -               lpar_rc = h_vio_signal(adapter->vdev->unit_address,
> -                                      VIO_IRQ_ENABLE);
> +       if (!napi_complete_done(napi, frames_processed))
> +               goto out;
> 
> -               BUG_ON(lpar_rc != H_SUCCESS);
> +       /* We think we are done - reenable interrupts,
> +        * then check once more to make sure we are done.
> +        */
> +       lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
> +       BUG_ON(lpar_rc != H_SUCCESS);

I know you're just moving this around, but maybe this is a good time to 
get rid of the deprecated BUG_ON?

Otherwise this looks reasonable.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> 
> -               if (ibmveth_rxq_pending_buffer(adapter) &&
> -                   napi_schedule(napi)) {
> -                       lpar_rc = h_vio_signal(adapter->vdev->unit_address,
> -                                              VIO_IRQ_DISABLE);
> -               }
> +       if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
> +               lpar_rc = h_vio_signal(adapter->vdev->unit_address,
> +                                      VIO_IRQ_DISABLE);
> +               goto restart_poll;
>          }
> 
> +out:
>          return frames_processed;
>   }
> 
> --
> 2.43.0
> 
> 

