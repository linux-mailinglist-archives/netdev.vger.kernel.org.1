Return-Path: <netdev+bounces-267450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I1kBeAMtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:10:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C17D02837D0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CA04303E170
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1432383C96;
	Fri, 13 Mar 2026 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6jy00UM"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65937F8CF;
	Fri, 13 Mar 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407441; cv=fail; b=jqHuZJfq/BqpYohFhIO7bTk8RqrJG1fahyJcgeazlDaHciCpmAg0x34XnfbcpSn/5Bgt2GvA1J8KEJt5Xt6kGRYBR9szyzLzJZlPmzmaMlVfDawAm+c9FLx9EXnl9olswIWFngqkASoDWLt6/Iwn6ohWEVtu6XOhJiIWrh7+Cpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407441; c=relaxed/simple;
	bh=OnuR7fHv8US0ZZ1E5Q39Sc0HW8iDCR9OcN6+AKPnhzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5mm7p+BT5hzIMmyox2m8S4Xrr9oGvf3mcGKMNFGEkZLot8m55SS0K4ZCtTEYlrbPuwMYIiz7uI75Dd4Cu7xwhfeDWZ8slxgxmRtgFnEQGcawE0hu0gOISZkvP1S9G3iD2x56LSoqyUkPaByf4695FulE2WK4x9yf12dKDUI80k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6jy00UM; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qijSyr/KLMqK8PSBMZ8fo170YZJnCq3uKQ5ScMcWz1Rs9LxgVkduvEihJBeZ3VKk8v3KpQlx3/Xg4YLmTKBD7mTMdEstCNFWlBAep9Qajr59VvHmEiXhUoVkVEzHpt195nE3zQEmObfxx/xsoBL1w0dfSYHFYoMnno0Var8J/dYqU17Z2EtJmq8+xY4zs9F3BCh2D65RzRSLR1K52bYEeCGtzcCw1rF6io0BudOW3bG5g4RZ4N4EDS9tBjCUGuyUxmfAOZ2NL41+QBd+X8H5PmRZxuiTsryP+FzNEr7MzIS89qutBVAxYIIP7eM/YZHvU8TqVbc1up2GOyMc/zFUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxZPfLwrkJNTUlWLKyhhnJitKTmVHVp9sv5TPAeJKl4=;
 b=Y+1EaqKPEDQPbtNcuvgvmFcpcqHy9y2voStJvjQmWqBvaIxLP3dwQCVt1NH1uET0QPfRbeF4BlZ5d3C9W/wB96J468nA+RjS3o8SNrPpQ3stWCrfB40ZjEqbR7fURv9nJAJ2MIZi2xe6YLpEg5QIHWQ0OCgnl92ptPpv+Pz+jeVjpTGaC7VUMdVN4IrVbTBbGW2JnO4qYX0zOzHzqIvjvewZZA5YSXgx55KR9KXIcSpPYgdmmVOJHSNeK4H0dKKnqMnKPWSndX2ewGwwZZJvMy9Sh+rAz1THWiE9Jn/cuQXbdPwXawE28BMJIWyRxKQpoeSG0wBEMMrGUZA3K65sPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxZPfLwrkJNTUlWLKyhhnJitKTmVHVp9sv5TPAeJKl4=;
 b=e6jy00UMHWnf/ygMr8ixYALJN9lx5qZ/5lNuJzK1TJcaHOT2pB4PSc3ot2lC5LAOEpVOiv7qNAE7hr6A4PuixmJqCNxS+20Wjm2MFpaz3C20xDAvs7jgujsk24Gd9u+qzu16BK4/V1cjrWKXTJomuPpjuSjlrA4wwydw2e1QqVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:10:36 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 13:10:36 +0000
Message-ID: <5a42d88d-3825-46a3-a014-79b3936e3f6d@amd.com>
Date: Fri, 13 Mar 2026 13:10:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 PJ Waskiewicz <ppwaskie@kernel.org>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
 <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
 <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
 <69b37069af0f8_b2b610068@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69b37069af0f8_b2b610068@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7079b605-84a7-4191-42f5-08de8101ea6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YFxCJz27DBcInZAPCjbCSneNbcSzkyAdSTTaPhxt/HCiIS3g7ZvPpMAd9MTrRj/Ii3nw0lNbDOhn4zdQZdb6geKce80MWAKAV0bqnHRJU0fNdJLuvdYRygi/KPkZLXRZRd2/ituJtL9sQGEeLQhLmWeIHTyPSJ7QoT8TswDj8Y3apW8ssjJjNwfhMyj3n+iHBPluEOPbrq+f7X1j85RQTY0Kntdi2dGjytu6TIQT3ftj+3rAUL/rW5Um95LzM+eGm1rEN65cOARuTFOp+CQKT8Inbm9X0816rA8GF4C3ISHs4Q3U1ycLcep1s1mM1PT69jx99PJUIXxvWgxZHxcyj8JisP/zKjx/f35dMTFoI0oS61O9zjuUwAu0g2Uejzbxt0nRPPeZgh40IzY39M+6VxnjOVMXrFwiku2ojSRAuvXmwOhaz1qDP0rvFFUgKzqjv9W2zRdHkq2fmA+qNI9sE+VG3dziCNuNYk9NfKxLOlW7iUZUj8zRNMpP8RvgS+6xahMXJzzLrRVEiphvsptKMvPs/Q+q74HpzhJ2o/WOCS7rOYzEwDtsAhtyu0Y7nOPUQsOjIX3vOvoed4duHHgo2rDr1Hd8zDCfpBs70BhLj5iayf6hk4UyujYzf/jMhsrnggSEC6e2JvN9iFgl5kG5jGs3zzYNdY0RJBykRtrqcYdyREAbGBA3jfrw8dF0IHw/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djhURnVMejlCREZvRE1WOVRlTTFjYXdEVUQzQ3pzbHVzNGlsd1kzRk1zTEZ3?=
 =?utf-8?B?OHdlWmxDdGNqVGsyYzVUVjVnMWp2VXNONUhJTVJXdzVGU0YwSDZCT1dqc1Za?=
 =?utf-8?B?dThRKzRkbUFwVHdqOHZ4Mzl5aXNNWUxyaTBaNlVpdnZYVlBjSlBNR055WVhP?=
 =?utf-8?B?WDdUUmU1SFNWZFBkc29SczRvS0tPemI1eFJKT05hQkYzb2dYb3hsSFIveVVh?=
 =?utf-8?B?VG80NUc0ZTNUL3dIbzJYUVE5SWQyRFFNWi83N1NsRXlRbXFabUc1bHk3V050?=
 =?utf-8?B?YUVYcHdka2dyYWViVkRLd0FLT2JFZW9abEg1MkJqZGl4RitscVFBRjRhbjVE?=
 =?utf-8?B?QjBudkhLdVllQlk2M25sbFI5MEQ0WG11T1RrQlRhTm5GVHJ5YmxiZXJ2YnJr?=
 =?utf-8?B?ZXMwNFBlR2VsS1d5Z0VMeURhY2czWlVNdytGTG93Y2VKS1JWY1dkbWI4M0d3?=
 =?utf-8?B?cnVzQ3pmYmdFSUhENU1jYkZNZFhSNGEvRW85MUtQN2d3QStGWkVLTHF5U1RF?=
 =?utf-8?B?VjFZaWNId2ovRUY1R1RoRVk0Y28xNDlaWFVWMm9GeHp4VmF2NVJwTy96MnR3?=
 =?utf-8?B?VWVXRGpqa2NiRXJ2RDVIZjBBZzdUczF0dnh1OU0zK2xZbUlnUHRJaGU1N0Rm?=
 =?utf-8?B?YUZjZDJaNWVKbmVNS2trTVVrTWlHeTFjQ2pzYzZKMlA5Z2JiRVQ3VE1jQjFD?=
 =?utf-8?B?UWpKUEZsUkRUTGRPbEREUWtGUUJ2YVdPREhib20yRWZoYXhvTWh5eDJBbzlL?=
 =?utf-8?B?NFlmejg5Mm04Z255UUVlUm9BVmhZZzFpRFZSSnRzMWtwNzJRVi9CMnRjUENI?=
 =?utf-8?B?bklyWDFHZzZhWjJWK0lZUWhRRXRQMlltd01PbVlMQ0ZKSUtNUDFMc1dobE85?=
 =?utf-8?B?dXlXNXBjVndsTlJHR1RCZGxEVFZ2ZkxIR2l3Qnk4bFdXb0tUYVhHOS9OMmds?=
 =?utf-8?B?UjNnR0ZTdUJCVTdhb0NYbjVsU1pOREFEalpwekhVK3I3eXNLSXQ1TlhuUFVN?=
 =?utf-8?B?VjhHOGE4TUtBNndtaVJUcFRla1lTdVBZMWJseGtPdTZ6bVRhZnRRbjJiSmhi?=
 =?utf-8?B?MW5wY1RWN1ljSjhKc0toWE43VGtaVmRYb0JFUW5lN3R1dVBYTUE0aVFiT2lX?=
 =?utf-8?B?K2tvd3A1aVdPeDRGZTBpaGZWUUJWMTVvQmtYakZZSHRkVTVVeWxqTkgrZlI3?=
 =?utf-8?B?TTNuRzdKSCszQU8xakFnVERRUG55YUUyYTdUSUFZRGRDNEVvL2N4eDdBQXdX?=
 =?utf-8?B?SnVnT2xXZk83d1ppUlhSODNON2VZV1d0ODQ1K3FSOUFxSE1xcTRWUkZUOUJm?=
 =?utf-8?B?dDZkdjVxdFRMcmpDN3NjM2tDTkhlUDF1T2xBMXU2eGh0VGwrOERGUDRGcjFI?=
 =?utf-8?B?YkdJSlZLYzEremF5LzRsczUyTUhUSEhxZFFTZ2xWVzN6b0FVSjhLeXZqT2JC?=
 =?utf-8?B?bExJbDVGajJhQ2NFMmxFTnRhTTdJZ2Nua21Yb0tpYm5yY3FFc2lzeEtXZEha?=
 =?utf-8?B?aUNjMGcvUXdaTElxb2VwTzFudGRRcFYvd2I0RE03RzliYmhwTEN0b3JHZkQy?=
 =?utf-8?B?WFlhZVlqeE1ucHJpeWJ2aVN5S21DZkk1QURMTWJDNytnRkdDMTdDSVQ1TDBQ?=
 =?utf-8?B?c1hEVEdYM0t2SEdWYjMray96eHdTdkpwK3NlVkZNNnAwRzhKT0ovRHJrMG9U?=
 =?utf-8?B?KzRzT1k0bjRneW1OUXU5UDNZcXB1cmJDVWhzb213dXVtWWl0R0VKM0VMNzV1?=
 =?utf-8?B?OEhqamN6MEZRaHV1Z2c4QXc2Ui9SQndhdHhJL0liNE9QMk1jR1JxMTJSUVhG?=
 =?utf-8?B?SGQyUlh4NVJzQ2NvSUxSV0ZUN3VVS0EwSEV2VXF0aUpuWDFMS0cvdndsUzlH?=
 =?utf-8?B?cTZYUkh6M3N0QWdOeWtBaU1SYjlGRm9vMUIzdjQ0MDFidDFUZXFWRzByQkUw?=
 =?utf-8?B?M1o4M2tEQjUvSDlraTVGZnQvSnJiblZBWTBFL3ZDNTk1azQ1NzdiYjlwRy82?=
 =?utf-8?B?TnV3dCtvL1BnRUFNNmlScTM4NzFqQlg0bEZlaFZwRjBqbkw3UGJVWFIyUEI1?=
 =?utf-8?B?Rkl3ZjNnaEZLaUc5alVCOEhhZjFjRkl6MzhUcEN0V1lWbjBwRXgvTjh0SVNJ?=
 =?utf-8?B?dUlEWm45OGNWR1pQZWF4U0pGcVNYTHI2Wm8vNWt4ZnJERWpXa3QrZUFCMmts?=
 =?utf-8?B?VEdQZWxoRXptL1R3M29sVGVQVC9yK0lhdEUxK09hcUJoUWgrOTZrRUxOdlR6?=
 =?utf-8?B?UTRHdkdDRktxRG1iclpMNWZuc1o0dEowSSsvdzFtQTZ6NjFMYVNFNVhhRUdj?=
 =?utf-8?B?a0YzVmtFTEVtYXJZWVZGTWZGZ2RxZWdmbStxM2VMcHFlSG9nTklFdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7079b605-84a7-4191-42f5-08de8101ea6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:10:36.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hChhurdeC825Stwt9X0yqs9QLr4yJYTtu+MfOpsJ+uNvVeHy1GhzMIE5lqVjcFGmOa06vDFM/txdqgqWJ+TKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267450-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: C17D02837D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/13/26 02:03, Dan Williams wrote:
> PJ Waskiewicz wrote:
> [..]
>>> Yes, I think you are right. This works in my tests and it is safe
>>> because I check the region does exist before using it. But the error
>>> inside sfc should then not be fatal for cxl sfc initialization and
>>> fallback to the other cxl initialization possibility.
>>>
>> So I'm running into this situation I think.
>>
>> When you're testing, are you surviving a reload of the driver?  Right
>> now, I can load and successfully create the region0 device.  However,
>> following the same teardown path in SFC, I cannot reload my driver
>> afterwards and map the region.  I get:
>>
>> cxl_port endpoint5: failed to attach decoder5 to region0: -6  (ENXIO)
>> <driver> 0000:c1:00.0: CXL found committed decoder without a region
>> <driver> 0000:c1:00.0: CXL init failed
>>
>> I'd be surprised if SFC in its current patch state would survive this
>> same insmod/rmmod/insmod test.
> So over here [1] I reviewed Smita's patch to stop resetting decoders by
> default if they were part of region auto-assembly. While that stops
> resetting the decoders it does not allow the device to get a hint of
> where it should place its HPAs if the decoders get reset while the
> driver is detached.


That is already what type2 support is about, and what was from the 
beginning: to get an hpa from the root decoder. The HPA will be found 
when the driver loads and the memdev is created and when the related 
region is going to need such HPA, and based on what is free there. 
Before v22 that was the only case contemplated, assuming the BIOS would 
not configure the device decoders. v22 added support for getting the 
region from autodiscovery if the decoders were committed, and v23 was 
for not resetting those decoders if that was the case when the driver 
unloads.


I'm pretty sure what Type2 pre-v22, v22 or v23 do in this regard is not 
perfect  (v23 was a quick hack for PJ to test the new functionality you 
demanded), in fact I'm changing the way hpa is allocated for Type2 
because after Gregory's concurrency tests and pmem patchset, I really 
think the approach needs to change. But as I said in Smita's review, you 
are precluding the basic stuff with your never-ending "improvements". 
You are not in a better position than me to have an opinion of what 
Type2 drivers need, and your comment is this thread is just a lack of 
respect to me. Yes, it is a blunt assertion, and I will repeat it as 
many times as necessary.


>
> I am going to draft some patches to allow an accelerator to mark an
> address range as "designated" so that it can recall the memory it was
> assigned by boot firmware.


If you do so, I will start seriously about passing this work to another 
engineer, not necessarily from AMD.


>
> This also dovetails with the conversation I had with Paul Blinzer at
> Plumbers about an ability to designate Soft Reserve memory. So a generic
> facility to designate memory allows accelerators to recall their address
> range if the decoders ever lose their configuration. It also tells the
> rest of the CXL subsystem "hands off, this range was accelerator
> designated by platform firmware".
>
> [1]: http://lore.kernel.org/69b1e0aacb9d0_2132100c5@dwillia2-mobl4.notmuch



