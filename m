Return-Path: <netdev+bounces-258366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KnTJ4f+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4312802B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7F293034321
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698F33342C;
	Wed, 11 Feb 2026 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QTqUXW69"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD8332917;
	Wed, 11 Feb 2026 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847865; cv=fail; b=g3eLeG0vW2dl9+gD3qWEqLUXgnWzO5uUo9a2zw1VRJ973N9OmzAlUCJFNnxHmRedLwq+bvFq9nQ6kkuUI3mb+e5b0adyoMB5rrw/VAjT6Q5t4rIzG0wbYl3o7FyLZ4FvorPas1NczVkLQdmSWDCJU/BPeCR7gnTm5Z47CSwQayI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847865; c=relaxed/simple;
	bh=8CCmvZPp1hvlZwuj0NnwQWMc/8YqmfUWB8O5sHcSZnE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=lSax/al4ahCPGAZfGDJspZ6xMbTwVn7QxYscDlTnqODylc8HshhhDqeljD6sQY2mnpw+yEl4De2hu41heTat4qhVDIRnzCcmUAeSMy/t7ARCNFo9JIrkzM+wSh303I3nWAmv6JocoM4J5zdp4NtikOx/CPSo//nH88LH2imLrVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QTqUXW69; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQLdQ5n/r1+JSQiEA5td7GNx5xaRqEeXzicuUe4bi9chplyZxDAONxbH9mIzkLmclom9Uucr0CR/HijtYdaiADWTvW1/PqQOMiDoOf0aqHLNebTjFHtAS8zh0xrUccBFvl6nma74UyMBv7z0oGVYj+Y66h4eqIvTqppkWMQg5dsiBLfJRFrnmJi2rcOSa/hyStV2uDa1QJ7St9tJhzTEyzkaPRz/8DFYhUHqKIEXuYnX4Fx6ZZ8h6huYxw2PQV0w7eUZOPiHeECKKWUOXfr4zxkE+hQm+wDN4z0rN8OgjTxWHivtXZzJ3ouAqiiEijRUUFehwxtowRCShSSsrLw5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv5USmF+aelVs+G5LZm6PxCKznsqLpZkRqTXTZKA6jk=;
 b=b6ZgPIb/OJTJkFw/dO+9M07oxTYLGzBivWVCQ3Gmzh8o5AV9mon1du2rc2XEVh9BNuIBLwODfd1UfGAXoHPE1+aQ30yRK+A2n6tkyv9sLp3OxxM5Yq5vEowzvmtR0FZmkYONH4P6UV43KRMyEzdlRjcdFXGXnBRikvT6B0KNb/xz5BQB1D3S/cUvQZiK700NBVed1yYvMgAhfAkKv1XUy2Ks4b4b82LtHSH/+XJa7+6N0+1Fk3/5qRc3HlVmINta3ZmrLIgh7ZjEJbK0YM2X9/hO4QzmNNf04lKJoLgHM7Gv7chz7ZeyeiEXqvKuZ+L5w1/vMQwy7ySp+BQwAFccdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5USmF+aelVs+G5LZm6PxCKznsqLpZkRqTXTZKA6jk=;
 b=QTqUXW69AafpMCMoWp0obCBIlDrYHulEMGebtPs4elRCV66yWCkn/ZTJZmhPUmrEqra1wHi6ozhLM7A5K/TjK3JOwyAeYaILqTjOtcDb31PztK3vdVVcs4awS6dDEsK9VO05jo+Ta/TfhZdFX758ZIq2igCjqWYTh6S1yuINiUk=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:10:56 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::8f) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:10:54 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:10:53 -0600
Message-ID: <9b2ab16e-d9da-4bff-a8bf-1eebd0dbf1ac@amd.com>
Date: Wed, 11 Feb 2026 16:10:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 14/22] cxl: Define a driver interface for DPA
 allocation
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6b5ea2-0719-408e-1bdf-08de69ba6d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3g4ZTlQQmhURkRjVFVQTnRIU0JBTE55dndWVFNURFBXdVROQXUzZnA0TUpD?=
 =?utf-8?B?eUtQOHRXOThlOHk1R0xyR1Fsc09iVjFpdTQxa1hzTHZqUmxOdzNGNllRT1RT?=
 =?utf-8?B?N29KcE82VFplc3JHeHl0WCtBUmpCWFFkWjlTbDZzd1ppK1Bjc2JJdXVCYU56?=
 =?utf-8?B?Vkl2TWFDOEpZU0JHY21nZjRmS096T2E0QXpROXMzcG5kREFVNFcyd2pwcjF3?=
 =?utf-8?B?WncvQ3BmZmJKMXQrSWlGN3Rad0JpSm05dytDRFgyazdXRXpRV3BjRWNCaXla?=
 =?utf-8?B?M0w1OUJTSkUzVWVuaWhoeDFUaEV2RXowenViaUlGdEdJTjZxL0FqUDFkV3M5?=
 =?utf-8?B?UjNqdUVndlI4RytQZnhsZUY0cC8xbWpKM2Njbk05dm5CeDgvTjNKOTFLV1Z2?=
 =?utf-8?B?WCsyN0ZwZS83R2UxaHNiZG9uVjJrNC91MjRSdHlBRWRnQW9icGJ2SUhnMFFR?=
 =?utf-8?B?bUZTNDlFeW9JNmNNSjNZZlBGNkRzb0pxUVdaR09mempIenFSQ2hCL0dNemZF?=
 =?utf-8?B?LzhxZVJTVjI3dEQyeWY4NVZuQmxsU3lQQllHa1Q1eGlRc0hVeUFwOHc2QXA1?=
 =?utf-8?B?aW9HSlpWejAxRlV1SFAxZ1BzaGF3VmtTSTBYN0FXT0VrdVNqRkJ1d1htY3Ju?=
 =?utf-8?B?RFZZd0Q0T0UvQjhIb0NFUU83Z1MvbXJtRUpQc2lSdStvNlpYS2Y3K2dzeTFx?=
 =?utf-8?B?S2pIQlI3Tm4xS1dEOUUwY1hYc1d0bG5RclBiTmU1VEN3cFkvVnFpTUxlSHQy?=
 =?utf-8?B?U05vcTJPVC9rcGVYcGxvNlRWcFhtMEErWkJ4RUhPaHVnM0hzM2xwWXkyZk9v?=
 =?utf-8?B?UHNUTWJIcWVMVEYrcFpGWWNPd1hxT1c3M1Rhb3hCNjgwR09ncjlpSDdOZUcz?=
 =?utf-8?B?aWkveVc4RWV5bmIvWUJmRHNLS0RHc2dubGwyYVh3ZnYxZGp1cG9kSnY1Mzhh?=
 =?utf-8?B?OVJGVkxmbHVuOUxCZlkzNjFnNGUrVTR1MWl3akhtSUhtejRncTVlMGZzdmhR?=
 =?utf-8?B?NVFjUVZ2bUFlUmxiZWpJcXlNQ1lSQ0tsOFpmTTZHNDBYUVFEUVF4bFBqa3ZJ?=
 =?utf-8?B?QXpPUExMWWZHbHJyK29FTVNQRDRWa3V4c3F2aXVIM1hsN0Yvd3hyVHRIR2Fh?=
 =?utf-8?B?Mk1CL1pTMHdFUmk1dHFOTFJtdVI2NGNXMmIxbE9uNlh4Zk9tN3VmZHY4UDZm?=
 =?utf-8?B?YlFPay9DdjJTZzNFRzJUSlFLbFlQS1lCTG9kUENrWmFvMHlkczJNcUNZQkdJ?=
 =?utf-8?B?cWh2MmdidGgzMVNJMXM2YnlUYk5BQzBCNXNDSGZtS0ZHYUw0bngvcnlMSEty?=
 =?utf-8?B?MjR6QXV1R1FNQm13cTFLWVNUdlZ2QnpRQVJYbm10YjIwUDdDNWxQZ0xlSU0v?=
 =?utf-8?B?RVVRelFvZ09JUDQwVkNJRVQwTVpyYmZSRkRoREpqL2tZaG1BNUpxTlpLOGNZ?=
 =?utf-8?B?UEsxWTJKM2pJZXpCR1l6UXJ3Ri84L0pCeEVtMlFBb0VUQTVMeTFKZG11Wmpw?=
 =?utf-8?B?NTRQdW8rOVU3dU43UlJydFhnWSt4UkJCanN0am5SeC9EWEV5MUNVRjQvK0lI?=
 =?utf-8?B?RkwvaXhwUG8yYmRvYmZWSjhSVHRiRlc0Z0F0Q21JZTNtSnBTdkFKNmdpTmhL?=
 =?utf-8?B?T3c1a2dwbUEzZkJnaDVCOGJISnNOc3BaOFRKaWd1OHlodTdHQ0lYN2JRRmto?=
 =?utf-8?B?UDRNSGVuMmQ1d1FXMzFkNkpRbDNJT0sxc3JMR3B2bjY1SkEzcWNTNEpEWWls?=
 =?utf-8?B?ZlBCV0pHYmZ6UlpYT0JuY1p5VWlNV0Qvc0hvemIreE5xN2ZaaWhYTkN6TjJr?=
 =?utf-8?B?ZHVnb014U2NPdTNkZG9zMHhOZUJmVXArV2h5bWZJRUg5SXJWQ1kxM1ByTmIv?=
 =?utf-8?B?UEhnTEQ0b2FBbCtBME1wbDlCSDZNNWFvc1NhVEJUaktPUWFNQkNHSEVEOUxp?=
 =?utf-8?B?WmdiR2FSSjZoQ3Frb3QrTDVwUmRvZm5VR0JROVpoNElrTHlhN3RIeEhlUkZL?=
 =?utf-8?B?QzZhZk9RcHM2QUJCckRhcUx0d29pSXdEdFdlcVhwZDZ1MVQybGZoQnFxbjdj?=
 =?utf-8?B?NWZYUTlXUFR5eERjSGs4RkZTcms3SFZEV2I2bXZRQmEzZHlRNG1VRGpyOEF6?=
 =?utf-8?B?TTlGclZ3UkpGRmtBWjM5Wm5rYkFEd0J5MnlyVnlnUm5JZXRSUlU4YlR0SGVo?=
 =?utf-8?B?Mmo5c0l3cTdFUHh0RGxKWDU3R2xLTUd6TldadllJRFliWHp4ZFc0MDEzaUVk?=
 =?utf-8?B?UGd2cEJSOTVSRVJjbFMxdE1nYzd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3OK/gdhWcqs6unbYVKk1Oio1K8lt2dCjEeA0+FD2/toCnd2yRqRujZ9LJ9JsoWYRoMpNHJyTZVqlTocjfU/64tjAy0HBlzfXqNSO5XySIRqIIt8pjveKhLSRaVnrdhwldOYdu+QHwz1llfW56nWg1kJn8nZZOa6exoOj3FSnPYQyKcm/WDyjUvI5L7TW+UXTlELosCUQBav3beV2FSj5Cy/teS/X4yGli5vBA7TnjqOMT6m5IP3EJGtdYYDk+I7OARfs/MtA5jye9L0MKisFfiZIyCDoPW1fkpQFPDuzoFy6GAk19v+GBFsPfWqx1k6atRJi4wr8krO5B4LaAslrrxOcEVSZgNh49TfEixgvhIzdZcg2j4eFFagqfNbb9iQoBJGYTuwV350H1y/wqoJQ+SvMih9O2h89mo3KT0gFABvobttCGxOfV4HJcSz5OmTZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:10:54.9969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6b5ea2-0719-408e-1bdf-08de69ba6d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258366-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: CDA4312802B
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace().
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a172ce4e9b19..d60a697f12cc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>  	return resource_contains(res, &_addr);
>  }
>  
> +/**
> + * cxl_dpa_free - release DPA (Device Physical Address)
> + * @cxled: endpoint decoder linked to the DPA
> + *
> + * Returns 0 or error.
> + */
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
> @@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int find_free_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == (port->hdm_end + 1);
> +}
> +
> +static struct cxl_endpoint_decoder *
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	dev = device_find_child(&endpoint->dev, NULL,
> +				find_free_decoder);
> +	if (!dev)
> +		return NULL;
> +
> +	return to_cxl_endpoint_decoder(dev);
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @mode: CXL partition mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
> + * an errno encoded pointer on failure.
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but which could not be fully
> + * available due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +		cxl_find_free_decoder(cxlmd);
> +
> +	if (!cxled)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		return ERR_PTR(rc);

Should cxl_dpa_set_part() be unwound here, or does it not matter? If it doesn't matter:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> +
> +	return no_free_ptr(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> +
>  static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d1b010e5e1d0..2b1f7d687a0e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -667,6 +667,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>  
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
>  DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 783ad570a6eb..4802371db00e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -276,4 +277,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_CXL_H__ */


