Return-Path: <netdev+bounces-257049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIY5CVxWhGlb2gMAu9opvQ
	(envelope-from <netdev+bounces-257049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:35:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAEEFF34
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85E04301BA4A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371F346A1E;
	Thu,  5 Feb 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XadcyAwS"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C43382E9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280468; cv=fail; b=qVGekKX0U7b4FsApMo4HWLiX0hJH/SM/ucdMNoP23RKbyfhlSYXaKVP7eoiaLcgGjromUg20XVMaLqyjpX87ZkNRIdT8sN4AxqR9r3aGpqJ9987SCAnoKKDdJ0c431CMLfkZjRwx9/TX6bt4NSf2C5cvhT+tw3/KRs8hAF5ivZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280468; c=relaxed/simple;
	bh=UZyxxC3S/BAH3jHhjGG2cblGtQIlg08NofnWO8ct8UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VRuQ4nGn3hYchiny9Y1nyLpchXwBzSNM+GhSd0l2+VaAnZYt/+BeMkIbkrmUs/BWQVhiswL5CP5tYZl4NeMdJA2gPxYp7gmrszFk9HW3XC4wbB6AfKBB/9irvyt9smTIq+oqcGZqMwmA3xZ3pypEKSfL8MzvLGS7y5ehJDRIMUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XadcyAwS; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B70HipTkRjpZJ0V6QMVWW0O8bAEuJhA5xHGbFfozb+vZu2+R3euWjOU95XwOdeDHhqIxzirH7wXrE+R7BW01oUHJnYB9ls8JTRqywIAodLdj+zmAG5uNbzzF7Rf9fEW6mGNNgxfXpcJr4S2HPoDLcdq0thRBrQtwXvIJbBIn5vOm+XU3B/u9hUf/1wgIdhJGju82qYIrvHjbYJku6r0TPIhpTplQ0JUJFzjzIXqbqLcNdwjxCo6QXwHttFVQfzY4M5YBkTrW49kGE+VdTitU6V0qqxDqR3sZceURBS9F4mhzz0qGtDfs5Xzut5rVe5mbK7Y0eo4ofWluq9JMGJE4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16/gJ5mrAUype7r5dTPimDm8m3VFYmV7+LQEsqt0kAU=;
 b=xXQI5ZFmN+ZiKpHNXf3efpVzYrxRo6D3WtCbahteoZ1IyyMf+1ET+Kv/vxrqJCrpVy5DU3esmk1CpbOMlGB+L+iUwPH0e5cY62RuKuwWKVT6F7DQdP/IcB8jvwCi6K0YuhdHxnintVjFPEq7Dr3mUhxe34zMwtZD6R9NtHfdSNmAaMwQRAfgVISpHT4qMHBrRccqPUdtUNf1F/Y/SJX8t4U2Wg1w2sXN1x6R9vXHr55GRJUCrIg9XZ1dOZoEz7IqS0BPfd3B0tn8JN2ogrDJUKagKzAsIdNTiRdrtTuzEnzVOl8gCNa539gOCuE+2GyXiTCYrTRhHA+ZJXklF7ayZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16/gJ5mrAUype7r5dTPimDm8m3VFYmV7+LQEsqt0kAU=;
 b=XadcyAwSa187A6rE0L5hO9Ht1CG7XJIaFnX+kF5q2SQeYRYOvvQXX87deTJJRHcr3AMI9n/eJB6n4Sh/NRPcAOG8BwyBLjq75LTXmNN20P+csGqpFRJxcCwxatJa0RhqC8z4T5ouYyNM87euby3kL26IIgUvhbpQp0Cdn0QmweU=
Received: from BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20)
 by DS7PR10MB5005.namprd10.prod.outlook.com (2603:10b6:5:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:34:25 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::5f) by BYAPR07CA0043.outlook.office365.com
 (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 08:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 08:34:24 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 02:34:23 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 02:34:21 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 02:34:21 -0600
Received: from [172.24.231.152] (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6158YHBw3106924;
	Thu, 5 Feb 2026 02:34:17 -0600
Message-ID: <bc5ac28e-d830-402f-b5a2-741c20263aa3@ti.com>
Date: Thu, 5 Feb 2026 14:04:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg: Remove dedicated workqueue
 for ndo_set_rx_mode callback
To: Kevin Hao <haokexin@gmail.com>, <netdev@vger.kernel.org>
CC: Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Meghana
 Malladi" <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Himanshu Mittal <h-mittal1@ti.com>,
	Simon Horman <horms@kernel.org>, Byungchul Park <byungchul@sk.com>, "Markus
 Elfring" <elfring@users.sourceforge.net>,
	<linux-arm-kernel@lists.infradead.org>
References: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20260205-icssg-prueth-workqueue-v2-1-cf5cf97efb37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS7PR10MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 7508b739-2ec2-4199-0c58-08de64915e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVN3RDIvUFJ5dElMSGhOa0kyUERaMUptUGIwSXljbFZSbThnQjkvbnQzQUE4?=
 =?utf-8?B?a2V1Vm91NmZtN3YrdjlEZG5TVkNUbzhwaXNjS1BuL0FqanhvMUFIZ0cvZy9a?=
 =?utf-8?B?MzlkTHBvOXZaTzdQL2krNmZRdWFTZHZCcU1menNhb0VGbFFBN1hnTSswL0s5?=
 =?utf-8?B?QjJZems5aG12Q21aTDlpSTJpOTVIY1lReUgxSFJUWENJMVVPd3dSVktGOUVD?=
 =?utf-8?B?eFVWU0lUbFBxZUJ6QkhRSHBQekFwb2NnTWg3VlNla1BJenFRL3p0ZXNnYW5p?=
 =?utf-8?B?NTlKK2taejVtcndhL3BsQzQ1VFBQZmJ6Qks5alkvT3JidGNveHg4Y1A2MDM4?=
 =?utf-8?B?dENldXUwQjBBV1orWGV3Tm8zYWxicWFMaGZadWUwcFI5cmoyUU12VzIxOUdV?=
 =?utf-8?B?U2ZzQkR5bGJpbjRRVUNLU0FTUTI4VlptSEh6Q29va1k1b1M3cmVhdnVPa1pV?=
 =?utf-8?B?dkR2ejdGeWVvNml4S3VQWGFMY3RORVd0YXJzZ2hhL0VjN2lobFFLalpMdTVp?=
 =?utf-8?B?b21lVlJTUEtQTFF4aDRzb3dINmplaFVHcmsrcXNaSlc2Z1ljTUg1VmlyYjRK?=
 =?utf-8?B?bmt6RC9SSG1LRkJuaVlwVjZOY2VJYWFyNGw3N2w4a0xBNDR2YUYycFl0TzYw?=
 =?utf-8?B?NmltWDJUbFRQK3I4QVR6L0F4cDVSbjZOUThDR2IwbU11YmtqTUpvdGFIbnA2?=
 =?utf-8?B?ZGtTWW9oNUE4QUZEVUJvZ0lXcmYvS2hBbXg0QWlDM0kwdTR6c1hNV1dCOHlW?=
 =?utf-8?B?K3cwRlp1bFlhbWFSTU9rMHlMYWcxSnl3dkFVeFpyUWdtTUkzWEtyOUlzeEgv?=
 =?utf-8?B?S2ZFeEViNThPS0NvVDY4TGNIMHlWU05jZHlXcmhsRU02Q1R2YWZZUWRjYUx4?=
 =?utf-8?B?Y0huSHNPcTBGMnZmbnlhSmFxWmEwbzFZZ2V3SndheVo3anl1bTQ4SmNGRVZh?=
 =?utf-8?B?ZmVMRW1ZRjdTRXM2NXJXczhyQloxcFUvREd6eC9VRmxzMXdNWVFiWXh4WnJY?=
 =?utf-8?B?TGpJWW1tNnBJbUJlZDljQitMTXJkR0VqOE1kZ3hYSmNZSitMVzM2VSsxQzNa?=
 =?utf-8?B?RzFMeDFtN3RHa1R0citMVzRPNjRGNjZrNlY4ZXd4bFBGbGJMSnhsTU1Fb1dj?=
 =?utf-8?B?TC9EdHNzU3FDaENTSTl0VTF2cnZ3TFFFQlRTQUlBc1JlTVhGQnd0RllnSTkw?=
 =?utf-8?B?NFRQVElVS001TFBrTkFEN3psM3NaTjNXR2l2bFFodmR5YW1MaWcyYjZ3ZHpE?=
 =?utf-8?B?VXJYY05FbGV6Rnk1TDI1YklCMndmK0Z6T2hSRUQzVFl6UHZuTDcwWmtialFY?=
 =?utf-8?B?UVJkY0ZkSVFSTDNKS1VpbWpJeUZiQ0ErditIZFdlMWpLVTFtRS92eHRzeFJO?=
 =?utf-8?B?M1lacU04TWg2VkFuTWJHR05BUUdndlZkUDRMVHRvVEVJb3VrbjVQQzVselM5?=
 =?utf-8?B?NXBubXVURXNNVzZQYUtFc1NkVFNYR2VBeVIvdUhuUzRjajdEWDkySW1TMjYw?=
 =?utf-8?B?OUxFamZkWkZad2JuUzBrQTBtaVJUcVI3TTJRb2NQUXhYdU9MamJmcERsUlZM?=
 =?utf-8?B?cVJnSERGSEhOZVdrSlpma283OTVzTm41dGRpSzNYWXJVUzA2SHNueTdrc001?=
 =?utf-8?B?dThMMUdUTitFUjFJSk5FSGhDcE96Q1N0a2wvM2I4dEY2YUQvYWlCOXZXRnhE?=
 =?utf-8?B?cmpEMldYRGtrakVJN010bmd1UktKbnNYNzFHWSt5QXRxZ1ZFcjRtTUcrTUNi?=
 =?utf-8?B?cUFTUEFLaStNdHBUWXVvOHBUbFVTSk50MVRrSm9FSVp0TVBXK1ZEd01veERL?=
 =?utf-8?B?dE9sL08zMHM4WjBsekN5ZWxPWHJQWFpKaU9XTnNzdXZyVXMwQ1N1YXZkaFdR?=
 =?utf-8?B?UGhrKzJLTjlpaFRERnlNd1FONkREMEFJemY1N2ZpekdwK1I1QUZsdDNCRENZ?=
 =?utf-8?B?N1h4eXBqalVBZmhRajNRaElPWWVsR1dYRzYyUUJaSU1PemxvZmlLd3NoaEph?=
 =?utf-8?B?NDVxZExPM2NocjJOY2tLWCsyM29CRG1GTzhZYzJsUWVpa1dLcWQvUENWRkdl?=
 =?utf-8?B?UHRwb1ZCZ05QZXNDL1BvNjNaV3pkSGNPRHJSek0rVklHMFc2NHlKSU1MdFFR?=
 =?utf-8?B?aEpyQUx0VnRubnJwQ3I2VktlaW9MTkhuRWZCaVI0UFFLTUFFOEllNEtNV0g5?=
 =?utf-8?B?TDNXWExVQ1B2alIydTU1NWJGVkpUZktCWUdFdVROVzE4MFdPRnlwblBXbDZU?=
 =?utf-8?Q?zof9UlCtC00SoQJWplYAxoL5GeLn2wYZpUOJDVthoA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ecEJCM7ThP2W8lssohz/7qaFg1oKm7Z/hksIzNawJ3Ifv/f+wbCNBALxtd53egmkX+in5zbK5iQXLzi56rbjuM7DyQloYojaopgjq4CAOwnrLga2TMzsChVU2UkR9nfsObfX+EfsUVzJrTorrHgeG1G7L4cm4lmTwnJPFfughZn4gRmGu/3HyMfBIkTgOZUdS/55EISleQXV+wcxUfYryeCeYbRC62AxqFw7aK33hTyk5fPVqm9WLN9dkoXnHufEDj+aiIPLMmZ7/9kAcqvv48pMakfOhjObNVoodI8qlCSeffnDHXmqVQYSyYyxdYl3UFAR4RQyffRRlAm868fjTqjEPbTWJzWLyQ71iZJLwnxmHoVGnZUZA3VBOZWFe47ZcSoDtoX7IsmBTHt7J8OkfXFNI/yZiryD/DSyoV9UwMnNKsVQLXIS34TeOfXLHZyj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:34:24.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7508b739-2ec2-4199-0c58-08de64915e0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257049-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 72AAEEFF34
X-Rspamd-Action: no action



On 05/02/26 11:55 am, Kevin Hao wrote:
> Currently, both the icssg-prueth and icssg-prueth-sr1 drivers create
> a dedicated 'emac->cmd_wq' workqueue.
> 
> In the icssg-prueth-sr1 driver, this workqueue is not utilized at all.
> 
> In the icssg-prueth driver, the workqueue is only used to execute the
> actual processing of ndo_set_rx_mode. However, creating a dedicated
> workqueue for such a simple use case is unnecessary. To simplify the
> code, switch to using the system default workqueue instead.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> While addressing an issue in the cpsw driver, I based my fix [1] on the
> implementation of the emac_ndo_set_rx_mode() function in icssg. During review,
> Jakub pointed out that the dedicated workqueue for the ndo_set_rx_mode
> callback might be unnecessary [2]. I subsequently used the system workqueue for
> this purpose in the cpsw driver, and it performed as expected. Therefore,
> I believe the same approach can be applied to the icssg driver. This
> patch aim to remove this dedicated workqueue for icssg drivers.
> 
> Please note: I do not have access to a board that supports the CSSG PRU
> Ethernet controller, so this change has only been build-tested.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c0b5dc73a38f954e780f93a549b8fe225235c07a
> [2] https://lore.kernel.org/all/20260127190836.6a420768@kernel.org/
> ---
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Meghana Malladi <m-malladi@ti.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Himanshu Mittal <h-mittal1@ti.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Markus Elfring <elfring@users.sourceforge.net>
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Meghana, Can you please test this patch on AM64x and verify icssg_prueth
driver functionalities.

-- 
Thanks and Regards,
Danish


