Return-Path: <netdev+bounces-231270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5ABF6C44
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C7A541F23
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052A31D736;
	Tue, 21 Oct 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="egMXftf8"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5032E739
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053200; cv=fail; b=ghMjceHXRdkxSeMikACMaQlIjg1mSj8gpkpErhA/AWnmE1a01bPz3LtsiGIw9QDEFmyeXrNLDbzel9g4/VeELp/RJcoqrtEH2+WulC3q6N9jWexbS9rlXmTHKAkbnTqotgiqauuWipxXCqgN2wlkSCggGaI6uk6ccV+KpUFwWnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053200; c=relaxed/simple;
	bh=S5Q0qz1puO0h8eXOcl4aph20dJSKhTlav1iGo4G8Dmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CW3DyC9gDuGG3Tt8xqt9Bbv6wePeQbqvyujPNmRNrG0F3v5oQQiS7OuOBu4yIVWqHMAph7R5VqlAb3H6eVv2JvU4lw6sMh4DOnTq5r7yJzu7cdaLKiSnagiFns8fy+rfU/Obuvm6f/N9zjRtmnaIpU5arpQZGYsUvWgg7Ac0znI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=egMXftf8; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8E/oGtD5NuhdYF8Iivhz+s0Kvy4uBK1IGy6n2T+Hegr930MUccaGpkjPHMplNh2jSSRwR+igVY/cEJdwXw6ce2Mpmj2Omo+Y+qBjHdGlL108JIc/jr1RWZtFy8Y9hZCNYR8CCLxnZy/ciSs2q76tf2pm3+W1RWzYr4wWS+v9pytOkWAOfJ8ptY0rRHhJOKN7zMLLoE/Wg1AByeTtaRW6oPESO0DMYME4QMGU6VAKysziKulpThIW6/Cf0xxAYPTJ4+OlZisGHblD5CqNSB20I2I5puoAIL6cuP5sYj1ppIR3AdZzTIE3lOJLT3mlRg2/s2Zvoy9iBKGq6EekgmRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1s32lSfkpBxpcW72wH9zGGgb21RJKHH01s21fIfCYs=;
 b=bNpkAAfF9CjDmxrQw/UOHuvRQTbJ8H5hWyiW3FevHwCWGYvNt/6BUeNFnmVyzuuV73a9mYEauw4ay6P4hGuUMEx7u4sI+wyWlkl5I/WaJWIeDE8XR6eiCYivSs1b4C7iP9FC/qwi/YeLBtmtlbPWzeBgf+9KVy/FqSVC3ExRoBiNeGQITTAjtOr+pmlxQhV7HkGPYCdd4NOPZLhYq7qf0fLBL1XxE9OfkvJAhMp/HNmLHjl7vmmdKbjAWpWDh0dyt1Ep0/Zf3CmCP0VXdVZhcNr+pSkOYxQLZCm147pCdJu261hDXZCF+x6iOlXcO9S137njMvbUinBLeDQINM+E5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1s32lSfkpBxpcW72wH9zGGgb21RJKHH01s21fIfCYs=;
 b=egMXftf8nHSp1YWS5UNgg6VuKDRBUS35lyu4TiXNozD/OB6uBTGxQl2NhA/62bgqNeT1M2yXh+wa2tkgx+fgHc3hvEP2n7iura+V1OFmOl5G/Z+O8zGaaIJfpbkaDnYPLbiaDMSgOjtYgcqhDXcJo5LyYjHorCBHxxg0mz7pZuYfLoPTIO7w/Na2xuv0WB9GP2lvSzFSAf+cQaMKvLE+G6VUIrrs5ounH9FUYXoSqxEjDwL7w2iavG/cjSq3MTQkRjOEA8YIbe7K3XMJWWJWpWbf4ExWUOJgX8BNWHqKc9VhzgMl27LwxEo428QrEBvIUbjCrTyVVoj4tQDEQqmLfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 13:26:36 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 13:26:36 +0000
Message-ID: <6cb58417-3c5c-4f74-9a04-2bdbc266254b@nvidia.com>
Date: Tue, 21 Oct 2025 08:26:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 05/12] virtio_net: Query and set flow filter
 caps
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20251016050055.2301-1-danielj@nvidia.com>
 <20251016050055.2301-6-danielj@nvidia.com>
 <20251020165957.62a127eb@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251020165957.62a127eb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 0751008c-3e7d-46b4-7521-08de10a5750e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnpVSWtqWVN3TWZYc2wxaEJ4VVhrZGhtMDAyVmw1RUJnOHVqMW80RVRDZnI2?=
 =?utf-8?B?eHlaWU5kdzViR2Y5eHJMZGI3dklkQ05YdWt5dG5EcDJwSW83RXVRbFNxcXBt?=
 =?utf-8?B?Z01kTVQyUWZSSE1pTHNXZzVTYzJNNEF2Q2ZPU0k3TGZrZWl5cVdGeDlQYkdu?=
 =?utf-8?B?eGdTWHZjL3NaMnpLcG1YR0lKamhLdWhFZzJXNldaZVpsdlkyRW5ibzA3czNT?=
 =?utf-8?B?cXFORmhaY1VTVGJhbXJTUVZRdFplVnc4QVJZY3pKaThreWtTT2lkMzV0Q2dU?=
 =?utf-8?B?bzBOS0Y2MUxINXpuVkU5MFRsekhHblBjUjFJQ21IenBxcnFqM25Wbm83UGNJ?=
 =?utf-8?B?VGs2UjdRTFVEdCtGZ05nUDhmeVBCUEhaYzZMUkk4dCtibEhwdzEyL3U0dXov?=
 =?utf-8?B?aHdjODE0V050UlFvZTFObXlCMVF2bTIxZm1yYXcxS3VrS2d1V0hDL2JzSkRM?=
 =?utf-8?B?ZWd5TUJJUFE1SXZ2aTVlcktEbUNRaVl5WXpYWmxndjA5amxrMlUra1NXYy9z?=
 =?utf-8?B?TXV3UnB1SUczdVhlcXR1ZGQ2VTExd0dIckV1N1dCZ0FNc3p2ZW5YOFgrbEpY?=
 =?utf-8?B?UjNDYkVwOVh5QWpUVnU3Y0kweWU2WXBxQnRYNGpmV3I2Ri9aaTY2eWwwVnFi?=
 =?utf-8?B?bCtDQXEzV0tHVmhaU1NZdkdkRkFRdXAyTmFnemRzOFVjcW1oeFhGTUV5Tmha?=
 =?utf-8?B?NHlhRXZSbGtWLzEwMzlZY202M1NoYWRWOFBaSGJxaTM2aUNBR0g3QjI5aWpx?=
 =?utf-8?B?TGVzTmoxUnZhY2paWWwyV0p2S0tCaC9FQUxvdGVjYUZ4aUxhUmhNUU5GQm9a?=
 =?utf-8?B?dUhsTm94OU1sZGZUM2d6Qmd4VFdBdCtXeHdnMlZpaHUzblNQMDR0S0NUdmRO?=
 =?utf-8?B?MzV3UmZCTnVuSjc3MmQ3MzFhZ0wwSEQ0d2ZnMUVaSW03K2E0WUZIU2k4MXhr?=
 =?utf-8?B?SE9GZUp4Q3REelNzdWtDa2xEK3JPeDBHV1NxKzRoYk5xRFo0ZkRpbTdZR2dN?=
 =?utf-8?B?ZXlOUU9tV0VNbDBPQ0RlQ1B5dGJGcUl1TW1Ga0p1NTBtaEtvMlNyZjFRSjNR?=
 =?utf-8?B?ek5xeTd4RjV6dWRCU1kwWEpFU0lVNCtNSFdkYWxNeW1ISkVIbmN4eXlLVXZE?=
 =?utf-8?B?MGNXZ2ZIbU9Oak5wM2FRa3FVUmFOaDJpSGpGVk1ub3B4MEVpYTljMFpNTUhu?=
 =?utf-8?B?OVJ2WnlMTjQ4N1RFRnY1SjliVi9VYzBZNDU4VFBzeTRtOU1ZanpYSlBPY2pR?=
 =?utf-8?B?aUJlZVJQTGFmRlVONWN6Vk5Gc3d2eDZmS3NYdmJZeGVwUjBsblpvVE95VHhD?=
 =?utf-8?B?N3BwdmJUV3kzdXdHY1FpbGZVem5HSEsreStMREFEWU05Nmg5bHlnK05LajJG?=
 =?utf-8?B?RGg5aXF1WmNiQnFTN0hpbzNKOEJjcGJuOFhqOFVuVmh6NFRhNVBCd01OMzdV?=
 =?utf-8?B?akljbUc1ZzY2NWJGd2JLR3RQbitxM3V0eGdCM1lqS2pXMG1sLzVKY0c1L09I?=
 =?utf-8?B?RlJzL3h1UnJpWi9PRDJZaVhLTFVrZXFJLzJuUU1QN0wyTEE2aUxsMjF6dC8r?=
 =?utf-8?B?V0R3eE40Zm1oN0FtNVJVMTExSFZMNkJ0cDkrdzIyL1BGYVJEQkhPcEc2aG9o?=
 =?utf-8?B?US9JTjB6WVhrVW5LZ1JaT2VWbmxvL1JaSjdpc2I0cUphK1hLbTRGeFpNWDh2?=
 =?utf-8?B?eXpCUmEyL00xTjY0ZUxKK1htUCtWMjlVblI3ZTBTVCtqSm12SWVmQ2VveGxS?=
 =?utf-8?B?TTgxY2VBY3hKRXFGaWxweGFrRlJBek9wNVlab2c2Qk82VC85Vk83eEdPbVFw?=
 =?utf-8?B?UkVXUlAwZzV4Ry9jdnp3eFFyMHJNa09oTjRvUXIyeGpzMng0UU1QdkxXSW5H?=
 =?utf-8?B?NWx6UytKVjYydkR5OFhMSlpUclUxdjBoSmEzWU8zaEp4anhRTGRWV2VJejFl?=
 =?utf-8?Q?cg8jhuXw/i47OO1ubnIK82F07na3+9GV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNTZ245QkJoNGN5bDdjOFlNa1dmaWkxUXBwVUJ4NmZjT0xBdnVXNFRwU2RM?=
 =?utf-8?B?M2EvL0lvb2pEdzdNaU9VeU8veU9tUUNON0krWGVySS80dEsrSDgvMW0wRnJ1?=
 =?utf-8?B?MWhoRk0vbmVGRnY4NldrN3owMDNBR0FGME1WZE82dU1zNmprMlhkZXJRSTJX?=
 =?utf-8?B?OVBFUnRKaFVHTEl2dzF6UUw1T3ZkcXc2QmlXRzRGYmJlSFFvSDlyYzVSUWYv?=
 =?utf-8?B?Ykkrd1UyWEs2azVxbzhxcXFWN25KbmtyTnVtZnBaZjlkY1NFeEZqamEzM1hD?=
 =?utf-8?B?aWg2UzJKK0tibnBBSEV2K1RiTmFQNG15SEFrOUdaZTRwVi9DRHY2eWpoS2ll?=
 =?utf-8?B?MnIrbm8rZUtwWGEraDhjRTBzMW5sbU1OL3BqWSt5dVczREFqK1NKZ2NrVlpO?=
 =?utf-8?B?akV1ZkhadTFtd0FlMXpWQm1BMGV3b0pGWG80WGY2T0cwcTYwdkdYdHdybW95?=
 =?utf-8?B?VURsWUFocDNwRUNYZVFrV2hqdkxaMkphVXhXelNxWGJvM2tycDkyRS9PQ0NU?=
 =?utf-8?B?cGxQZ25xbVhkMGNnU292V05NSG1CWEp6NnJhcms3bUJjVjNCdTEyamNKQjM2?=
 =?utf-8?B?bDg4QnJ1amtkT3ZXQjVJN054U04reTZjbUxFQW1VODJGYm1EdG5qTUVKTlBB?=
 =?utf-8?B?UGlDREkrSFBnYjN1dGxreHNtV0NMaGEvQkllQVF5ZkdORUdQQXA4MjBVbm9k?=
 =?utf-8?B?TUxRUzJyQmVGQnh4eDkrdFNEV1FMZ0JhVTlrWFBjWUY5NndxWFhaeW9Db0lh?=
 =?utf-8?B?V2JUNkRBMko3WUxOTUtCeWkzbGpkMDBjdkEyTnY0ZTVIeGMvR0JSSlV6cVFK?=
 =?utf-8?B?WkluOE9BWEdiMDlCTmVUVE1VaThEU3Z1N012UUczMW5oZ0xUaVlEZmFaKzZl?=
 =?utf-8?B?NDRuM2Q5Z2k1aE5KTzMxUmcyRTJ1R21rRG03bEJ2YXNvVHZPbFMwc1Y4dHlR?=
 =?utf-8?B?SDJjZHZmR1c1WTJEZy82N04vb1ZKY1d2ZWVES1dieitvSEtsZjZJK2V5QXhH?=
 =?utf-8?B?YUx6NUNoWFV0KzRHOGNXdnlXZndsRlR2NmUvaGE4bHR5ejU3QmVQL2dGZHFS?=
 =?utf-8?B?K1NscTlVdkd1bmxYTUNjMldHclZpVFFhb2N1dm9NM0cyMS9mT2FDTE1EbFNX?=
 =?utf-8?B?bml3T3VzQW90R3ZMUDViN0NiR3hZTjVzWFNOc3ZHbm9ybmFzMU5NemN1cEFW?=
 =?utf-8?B?and3dXFZRlN0M09TaFlWZkRvcTBGK29DeTRjdjFVOHVNd05pemxKamc1dWp3?=
 =?utf-8?B?NmZwSG1FMWZPR0ZqZ25Ic1pOZHpNY3c4RVJQNkFub0FDUUpMdWlLbjRTMVE2?=
 =?utf-8?B?L1paUytVbVN3VjlJRVZ2ejVpai9hcENYZXF4T3RNZWVqQ252MTFEZ092SEIx?=
 =?utf-8?B?cjZ6eklmT3g0RzNBL0RxTjIxTTc5MVQ4aThkdFYzVkNFVUc0bXlVY29Ib0Rl?=
 =?utf-8?B?ODBWbk82eWVDL2NNM2FPc2R0eDFLa0tSeFdyaGVPZVRkb1puT2hENERkb2tp?=
 =?utf-8?B?cWV4TFpiUGZ4NWdvV3dtTk80dHlTZ0VSQnFMTlN4VnVEbmxaZ3FaK1FWK1Bi?=
 =?utf-8?B?MW5WdFIrRXd0ZEQ5cEk3aFo5OVdNbFZxRmdoRTYxZm9BZC9JNm03MzhGM3Mx?=
 =?utf-8?B?QldYc2VLMmlFV1RubEs3VXhZTUZVakdMS1F1WTB4ZlRTdTZYOFFPbnhlNGRR?=
 =?utf-8?B?bGl1SmdENkJSdlAwNnZHNzBQVnQ3MytQSGIrZ3pNaFVqWTJkRWVEYmtldDRP?=
 =?utf-8?B?Y2M4ZlFkWkpKNUdweEMvVy9WbFgyN1dQSkpqVWN6NjBVMGh3eUwrRDBsenpQ?=
 =?utf-8?B?VUk2MFIweXlRTjVlTWNlQmhRVFBqZjZZYzhMQ2k1NzdxT0hvNFBrU2pHRENt?=
 =?utf-8?B?MUZwWmZEd25EL1R3OFlNTUc4TjB1RlZ5ZUNtK0xBb0FnUTh4N2J6cURTUk9T?=
 =?utf-8?B?cjF4cSsxR0EvZERkbGJSeit5b0k1VTl1TS9vQUdCeWV3emtTc0piMXBhSEEy?=
 =?utf-8?B?VVQzeHRmRXlzelp1ZC9YY0VnS3JMckdLYnNoa2RkWnRmbzJtOUFOWklpbHF6?=
 =?utf-8?B?WGtEbzVaUWcyazdpWEpQRVRpNFRBRTNrK2FhVVE1aHFtQ285dkg2a0JGRmtP?=
 =?utf-8?Q?PvGus0kHflE25BegZUMW4qErG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0751008c-3e7d-46b4-7521-08de10a5750e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:26:35.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8Q14YP99X3HMnvXd91QFQ+3Vf9jfNtx2JFOTOA00NpwaYAb83QERL89USXrfbetJlTPuzd9VcDsIVZi8OY8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

On 10/20/25 6:59 PM, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 00:00:48 -0500 Daniel Jurgens wrote:
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[];
>> +};
> 
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: array of supported selector descriptors
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	struct virtio_net_ff_selector selectors[];
>> +};
> 
> sparse complains:
> 
>   include/uapi/linux/virtio_net_ff.h:73:48: warning: array of flexible structures
> 
> which seems legit. Since only element 0 can reasonably be accessed
> perhaps make selectors
> 
> 	__u8 selectors[]; /* struct virtio_net_ff_selector */
> 
> ?

Yes, it's being used as if it were a u8 * anyway. I'll do that.

