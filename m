Return-Path: <netdev+bounces-232596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093EC06E45
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961823A2CB5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB54322551;
	Fri, 24 Oct 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2sIMS3R"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22242EFD8A
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318786; cv=fail; b=PLfNxvRlvqpibcELC0EEoRbV5RqI4stYB9vJZuPP/uDfv0xn2T7sIGazvTNVmm91FBnR2ilXsbyUy2QS/UeheYdvIycGDEll1HzVrej3nmczVp9vM+qNMJ02AWyTNnUnaURuKRrsxxrmrU8rCdkDmogLJoheLB+l0jZfclaPECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318786; c=relaxed/simple;
	bh=EgZNYZQ/GDBR5tMmzruE7tLv9ZHJorct0YWUpawH7fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IO/n6SiSIpRuhbvgR7ut/4i6NU1HsB9PuJ6UPtSL5NdGmqgYFGegjvMCphjL6yUG5MnmaKUnQ1rBrcXPepJTsRP1GPTWRX3poGbbfbLY3eE0rxqcDc/vZSgWQKCmWrHbyWgDoq5gsNMemZ/IbvNXnHJVJqChWwTBJIxjRi3qfkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2sIMS3R; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaXB013ai4eeRAMReaGEiKx9wRrMVascKguGzNFtL4dxJWMPBf7uSnWl5FsfVgdxI+j7FdzA6vVXmVKrzVnYHZpCIBsTPOtHsyYercOuD2+aYeIwt0DWQp1zJEmKefkCu6Oy35LtKbb9rMj9MtJ5dzNodDuvJwb6TxoACLBhANBg6OXKfLzbCtIjlyE2W+PZtgXpIdTzYvT5mMj1rWA9kfl6T6VCN0fXOxWnf2e9DD/H9ooCVf4NNEZBNy6Iy1gVsUUiNkGkMiEme97QI35enA+5qVXFs9nyzH/1HstNd6jw+MoovDm0ZVMwM2naekIzfMjffp8DhoFP9dIN/J9jUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1vGyvlmxWHUgVPcLHVoC/iHNbn+/7znSpSrAuI0IWY=;
 b=XElRy41H4ATirmwkxbRejnXEO9ujaJvsUR3lp8cJEQ0GWR9c/txub+T+vwJ7jS+l55ZRY59DEZ3pXPqm9JXUSHhZP14tbUm5tBVHfZPKv6v6edshYiaEfZfMXn/bidwJMzOEddE6/lJaMKNBkWSYx/5Exm4YARAjXyGkXTw+FGIAgZjh7eNNXqjZZV6XLmkd9f3fy9JXd3qU6AptGN1C//Ewg+PoIpJhcx//8WTEmMRyg7cu7hruZZSUVrYt7jL+Suz58CdVPHOcg7ymdRgYdz1JlP4gq6svOzX8rkRTTztnPnvoHHfHB4PRdbuKXG2eiUcVAvMTSuSg7s8TI047qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1vGyvlmxWHUgVPcLHVoC/iHNbn+/7znSpSrAuI0IWY=;
 b=s2sIMS3RRL5dBBbDPpcwG82knxCAZWVnRWJBafqPYrP6RPt8Aw6+gv4npm7rOuQbojqz4tzZ4FeBB3URqGl54pRrcRG+7xmgJwtULJZ7E2+5z/n4vNo3iD+C8glJGWctHLZ+mcJHMTcQXxoRSEwzEwARhpE/X6xsj5aPjlE4iN7Uubjxe88LBlBIum2xtSAuGymafiyPWvSocb/DuyWz94gvdfRv7lP4vwxQo3F1GRNwzzANj1YTw/3Blkw9o9Inii26fjx13yrOKFqIdZUDcbrMn+hjk2etVVjDdlYAIvn8vMEWgig+RxpR6b02D9yFV5rIsBiPKmoqT6prGgL0MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:13:00 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:13:00 +0000
Message-ID: <1a43cc72-126a-41d3-8af9-b1a3a303386a@nvidia.com>
Date: Fri, 24 Oct 2025 17:12:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tcp: fix too slow tcp_rcvbuf_grow() action
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251024075027.3178786-1-edumazet@google.com>
 <20251024075027.3178786-4-edumazet@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20251024075027.3178786-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b6e403-a76f-4188-95c5-08de130fd201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhOSnN2WWJXSU5CSVlqZ0J0R0YyUHFTcFFSalI1WC80RDJCL21CTDJCUVlJ?=
 =?utf-8?B?eFJPU3VYR1E3eWxPZW5wMG5CdldXS1J5cjVwbzRMNjBDYmNYbXE3eFBNT1Rq?=
 =?utf-8?B?cFVZTm96M3QwYlVZZ0pPdS9sSWJuVDkyQUJCQWwrbEpnRys0UWJBUkMxWWp0?=
 =?utf-8?B?U3NPVEtOdktuWFU2WnZCeDYwRFh3alovZGt1Vnp1Tzk2NE5lUEpPaHN2RlNj?=
 =?utf-8?B?S0gwKzFlTXFjK0grMHVXSlduaTNWTUlUMkM5QzlDcTZ1d3JYZGE0ZGpjQldC?=
 =?utf-8?B?djhCY25QeitJVjgyY1F3MG1nTUxzM0NQK2R3V3E1dlhUQXdhbFMrbnA2ZkR3?=
 =?utf-8?B?TUdzenFNelpnR24wa0lmRVNTaEtZcVVvVllNVTBNL2ExRkdxbk8xTUF3b3Q5?=
 =?utf-8?B?K1h0ZCtWdXl3TUlENEJSRmNhMTVCUDFaR0svYnE1a0ZYY0tFY2VJVUhnWkhK?=
 =?utf-8?B?Vmc5djVEMjFpdHVEY1lYTFEzM3hEbXdic3VDd2VPRXRVNk5ub0dzRkRZeWVu?=
 =?utf-8?B?VkkyOE5Pb3dTL1ZQdnREbGVoNkdrWHdacUhVeWs1S05US1FaZS9zVFpUb2li?=
 =?utf-8?B?eW9oSmlVSzErTlRDOWVXcGNpTFU2S2p3d0RCK0FFSzMySjI3ZmN4SlRlSjgx?=
 =?utf-8?B?eldIZWRENmYrVHlMbjdiRUNNeCtrQ29kNGtWcytaWnJobEc0NGlLQWQ5SUMz?=
 =?utf-8?B?ekpLdVdmTkVxRzdJTm83bHYzZm9RTThrTnlvOWlQd1d1bjlYU095VWtSdmpp?=
 =?utf-8?B?TlFBLzhkNXNKWDVvWVdJZGlXYlNIZjBjNGZGZ081NmJnRXVaMG9lK2tDME9t?=
 =?utf-8?B?N3VBQzhJYVM3OHEyQm5VYmtOdm1KelRta0Nna05RV1FGZUxtVStTdVU2aFhJ?=
 =?utf-8?B?TVM3UEdqRFBia2VXUTU2MWlyVUwzczNvKzVHRGJObTFpYzhXNDBCSGQ1TVlt?=
 =?utf-8?B?NEtqWjZwYkJpOG5oK0JiWDV0U3JjZ05qUUx0MzFpaVMvQ3k4dUg3V0RXOU9H?=
 =?utf-8?B?U2pwQy80dTFNL3Vhc2RBNXdLT0IvVk5LUVcrMmxkZGdYcVVvQUpsRHhrT05D?=
 =?utf-8?B?ekovVVVpOUZCTC9KVDQ0WGdrZGhKQmtRdGZYVTNZYytqcWkzajdBY003TER1?=
 =?utf-8?B?dnBoUFFyM2dwTjVXQUY3K1c1ZTIya0c1QzcxeXc1cTNBTSs1N1hsOElmS2E1?=
 =?utf-8?B?WmI5ZU0vdlo5a085T3kzclBHNE5sQXVYTFpEZnJmRmVpUFFVZkcyMFpJY1JZ?=
 =?utf-8?B?N0w2eWpwZ2JDN1VxZjNLZU1tVkdMb3lDRllYdVRaYlMxeGpGb3RxeVhYcmE4?=
 =?utf-8?B?ZE00UDFIMlVDL0oxMzBjM0NpTm5IK2pQREs2aGl3Y1BkNkh3WkpSTGpIaStI?=
 =?utf-8?B?UFdhUHYwWHNHNXNYUHZseC9pRFVHc3pVZ3owY2xzWVFjazVlWUhPT083bjBo?=
 =?utf-8?B?cjYrS3AxM1lvOEhLZ0UrVjBOaFpiZHBqTEZPVUtLa1dWQzhPRERYNUJCbTFs?=
 =?utf-8?B?emFRbkhSWUswcVUzWkRnQjJOdXV3eXZQVzAzeGw5cUtWQy9xcHZMR1NPVThz?=
 =?utf-8?B?WXpYa1N3ZkwvS1QwaGVnTENUZDdGVk9mMURycnJKVFg0Rldwb2tqRFZHYXRv?=
 =?utf-8?B?cHV5di8rT1VqL25BMXVkSEdjWHppdWdQRjJGVkFma3N2SkF5VmxsVlNzR2Ru?=
 =?utf-8?B?NFVUa3BsZVczLzltMUl1OVpjNXoyU3o1N1N1TzdtYWJTTUs3MjJUbWpYbWZF?=
 =?utf-8?B?MkgyQlVSZ2FHS29rT0ZYU3F6eXRtQnpzdzFFWUJaS20zb3QxWm9yNkx1VzJS?=
 =?utf-8?B?YWtSZk1WUisrcG04L1lUWWJFRC9OQm94aEhEK2RxMGV4Zlp2Zlc5NXVUQXNv?=
 =?utf-8?B?Vit6cjQyZ1dabFFnM2tackl3Zi84Q2dhMXVGNStQVk9HdXBVbys4UWFydzVa?=
 =?utf-8?Q?yyHbyWC0giaxayd10N2EBQ6ILCpOTGC6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVVQb3RmRUR5Z0xsSUV1T1J2alR3L1VJNTZBaWMrWG1xRHQ5Q1hmN05VUU5L?=
 =?utf-8?B?SEFoTCtCbHh1elNKVzhKRGFNelZ5RDR3Z2lXYjlyWHdXbVp3aHFkUk9zVkRy?=
 =?utf-8?B?OHdiRXkvd1d1d1NwTG5mWGlwSjFPZjI4S1JFSXNzNXRQRys2NUxUWGlRZzZ3?=
 =?utf-8?B?QmtxMVBseEZiYzRMblE1TDFjTnVTcyt2d1hBVUxRNklvbVFDUVRtUU4zVFlC?=
 =?utf-8?B?NEhUeGVZN0I4eXZZbDlSYUxOOG4wL2xsSTU0Y1JKT2VPNmFzM2JXaENFaTZX?=
 =?utf-8?B?ZmhKeDVwU3BSaGk3SHREUk5OVjFUUEorZ1JjL0FRdURzSXNrcTZBU28zYkl1?=
 =?utf-8?B?dXI5TmxPT2tieFVmc1k3STZTd2J5dDVYVFlPNUcwR09qQ0Zidit1S3N0SVYw?=
 =?utf-8?B?OFhVTUdjZ292N2ZXQ2ZWcTViQ1Fha2oyMHFEODQ5RzZMekRuOXFSQ01STEVB?=
 =?utf-8?B?dUcwdmlTdTY1dnlObzM2VStwbmVCSk93UlNpdUROcVpOZWFXU2lyTzI4L081?=
 =?utf-8?B?RnRoMk1ZMVVpNmZWMGJCUjdCSWFIYjM3cEpOUWZiNkl0dlRFOUJvT3YwUkhy?=
 =?utf-8?B?STZFd29ENWhRTjJvSHdXVmZ1bmxEc2F5VWFVSUxMbzNKVDVOQVJ4MTdCTWQ5?=
 =?utf-8?B?V2dRYUx2UlZsNDIra0RLRTRoZWJoZjFoaVlTQkJMWE9YeTBid1JYcFdVdzNO?=
 =?utf-8?B?dDVWNS96cGVxMUwxMjhoWUlGVGF3TDNxeG5pRVZpdjNDb2srSEh0VVdpeDVW?=
 =?utf-8?B?d3p4VTl6aFhTT0xENHlZWVNTMVVtYWp3eHNtRFlmOVc2dGlvRGR3ajlITFVB?=
 =?utf-8?B?Y1c3VFMvVFlUVmtkRXpCRkFROTNVUDM4WGtjK0t6cnROLzVVdmVpM0tmMENy?=
 =?utf-8?B?SGdPeUNyai9wMTZ6M2JJaGhkZlp2OXdEd3lJS0l0T1hGUlVTcWQyOU5PV01x?=
 =?utf-8?B?ekV2cE45cXVBa0V4NGsrN1hhQ0xicjdUMXZUQyt5VXNDc2ErYzhHNGVXaDZP?=
 =?utf-8?B?QWlva0xxNWxrUmFrc2pRenorWFJHM0R0ZkhTMGhaU2tudkxVckRxUTJYN3N3?=
 =?utf-8?B?cVBhSllxZ084Y280UFZFWlh3dnZteXFJSE9iZTZLWDlhRC9FOWNvZkpveUo4?=
 =?utf-8?B?Ky8vcUE4MDNDQy9DZENqeDhrMldmbS9mWmRESEU4VE9wOGdGdnNqN29lKzQ4?=
 =?utf-8?B?OWxvclhYL085bTBZU0o3OWcyY21aWVdCQk9DelczR1NlRmxqTEhhSTZiaFNj?=
 =?utf-8?B?Wkd6NEpQNXdrTi96ZWEwb1BaTGpFZ1huejkyYTZ6T2lwNW55akRNZTEzYmRN?=
 =?utf-8?B?Q1YxSDh6cVF3azgrK0tpa2NQZ05RZ29udDR4ZEEvU2VvWWlyWlFGZVpUcy9l?=
 =?utf-8?B?MGFKZUVocmZJQ2JBUDB0VWZ3dkR2QjhtclFzT1IzbjV4MDhPK2J5dVFscmtB?=
 =?utf-8?B?UnhycXBZOFNWTFBXWG9GdmxZLzJNNVVyTFk3YXJacGtkZnR5QU0zdUM5ZjNi?=
 =?utf-8?B?MGJhK1RNeFVyQ2hicUlCUkwyL2tWZ1NhL2JydjJ6dkNsdzZPVWllRVJ2T3kv?=
 =?utf-8?B?Q1M4Njl2cGpBOXBDNk8xS1F4dmR5ZGlBQ09Ud1ZGVjQvTHc2UytiS3IyakZw?=
 =?utf-8?B?VDhlRmFWWi81d2NDSkFFbmtPdjVqd2FIVzdSby9qMDQ0bzl3WCtkQzI1WW5w?=
 =?utf-8?B?UWx6SC8zTmM2SGhBVWwraFFOQk4zME1zMlZvVlBTUG9VVXBIL3lsclR0YmJk?=
 =?utf-8?B?cVYxSjBPN0JadTF0L0J2Z1Z4RHk2S091UkJDRWVaeUpBRWNFanVlWGNTV3A4?=
 =?utf-8?B?SUFpSW1LeHhYNms1ZnFNUDlTREJTb0hSVVQvTzNtVWtlUDdaWWRJYmhuSTZ6?=
 =?utf-8?B?YXJRK0xiWDhyMGhZTmJDOEtUSEVoYWxFcUgwSUNsNFdQRktSUzBNM095NkpZ?=
 =?utf-8?B?Y280SFA1dmhFek9HUnJNd2tFbm96UW1jTU8wdzVzOUxKYWJzdHNLaGtNSUVl?=
 =?utf-8?B?c290V0ZPSlpXTmt4QUxTZzg2MDlWMCtLd3lFTW45eXUxRHhqdmxrTHRoMXdR?=
 =?utf-8?B?eVJ1bi9CYkp2VlRHTUEzdVlnSVRRaDhvRHZzYVp2OXFzM2dFalJENUdFOUtv?=
 =?utf-8?Q?DQ+td20AoeRzRaWo+ZaaNIYu2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b6e403-a76f-4188-95c5-08de130fd201
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:13:00.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5NT6FRfFOlwI44Qi3mblCXR6e6y1LuOwgTo5rc8U/n0Egkj0uI51ZsEFUFwZksm5DfwLnnueoFdMCXT6ZJOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042

On 24.10.25 09:50, Eric Dumazet wrote:
> While the blamed commits apparently avoided an overshoot,
> they also limited how fast a sender can increase BDP at each RTT.
> 
> This is not exactly a revert, we do not add the 16 * tp->advmss
> cushion we had, and we are keeping the out_of_order_queue
> contribution.
> 
> Do the same in mptcp_rcvbuf_grow().
> 
> Tested:
> 
> emulated 50ms rtt (tcp_stream --tcp-tx-delay 50000), cubic 20 second flow.
> net.ipv4.tcp_rmem set to "4096 131072 67000000"
> 
> perf record -a -e tcp:tcp_rcvbuf_grow sleep 20
> perf script
> 
> Before:
> 
> We can see we fail to roughly double RWIN at each RTT.
> Sender is RWIN limited while CWND is ramping up (before getting tcp_wmem limited)
> 
> tcp_stream 33793 [010]  825.717525: tcp:tcp_rcvbuf_grow: time=100869 rtt_us=50428 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
> tcp_stream 33793 [010]  825.768966: tcp:tcp_rcvbuf_grow: time=51447 rtt_us=50362 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=106496
> tcp_stream 33793 [010]  825.821539: tcp:tcp_rcvbuf_grow: time=52577 rtt_us=50243 copied=114688 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=201096 rcv_ssthresh=167377 window_clamp=172031 rcv_wnd=167936
> tcp_stream 33793 [010]  825.871781: tcp:tcp_rcvbuf_grow: time=50248 rtt_us=50237 copied=167936 inq=0 space=114688 ooo=0 scaling_ratio=219 rcvbuf=268129 rcv_ssthresh=224722 window_clamp=229375 rcv_wnd=225280
> tcp_stream 33793 [010]  825.922475: tcp:tcp_rcvbuf_grow: time=50698 rtt_us=50183 copied=241664 inq=0 space=167936 ooo=0 scaling_ratio=219 rcvbuf=392617 rcv_ssthresh=331217 window_clamp=335871 rcv_wnd=323584
> tcp_stream 33793 [010]  825.973326: tcp:tcp_rcvbuf_grow: time=50855 rtt_us=50213 copied=339968 inq=0 space=241664 ooo=0 scaling_ratio=219 rcvbuf=564986 rcv_ssthresh=478674 window_clamp=483327 rcv_wnd=462848
> tcp_stream 33793 [010]  826.023970: tcp:tcp_rcvbuf_grow: time=50647 rtt_us=50248 copied=491520 inq=0 space=339968 ooo=0 scaling_ratio=219 rcvbuf=794811 rcv_ssthresh=671778 window_clamp=679935 rcv_wnd=651264
> tcp_stream 33793 [010]  826.074612: tcp:tcp_rcvbuf_grow: time=50648 rtt_us=50227 copied=700416 inq=0 space=491520 ooo=0 scaling_ratio=219 rcvbuf=1149124 rcv_ssthresh=974881 window_clamp=983039 rcv_wnd=942080
> tcp_stream 33793 [010]  826.125452: tcp:tcp_rcvbuf_grow: time=50845 rtt_us=50225 copied=987136 inq=8192 space=700416 ooo=0 scaling_ratio=219 rcvbuf=1637502 rcv_ssthresh=1392674 window_clamp=1400831 rcv_wnd=1339392
> tcp_stream 33793 [010]  826.175698: tcp:tcp_rcvbuf_grow: time=50250 rtt_us=50198 copied=1347584 inq=0 space=978944 ooo=0 scaling_ratio=219 rcvbuf=2288672 rcv_ssthresh=1949729 window_clamp=1957887 rcv_wnd=1945600
> tcp_stream 33793 [010]  826.225947: tcp:tcp_rcvbuf_grow: time=50252 rtt_us=50240 copied=1945600 inq=0 space=1347584 ooo=0 scaling_ratio=219 rcvbuf=3150516 rcv_ssthresh=2687010 window_clamp=2695167 rcv_wnd=2691072
> tcp_stream 33793 [010]  826.276175: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50224 copied=2691072 inq=0 space=1945600 ooo=0 scaling_ratio=219 rcvbuf=4548617 rcv_ssthresh=3883041 window_clamp=3891199 rcv_wnd=3887104
> tcp_stream 33793 [010]  826.326403: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50229 copied=3887104 inq=0 space=2691072 ooo=0 scaling_ratio=219 rcvbuf=6291456 rcv_ssthresh=5370482 window_clamp=5382144 rcv_wnd=5373952
> tcp_stream 33793 [010]  826.376723: tcp:tcp_rcvbuf_grow: time=50323 rtt_us=50218 copied=5373952 inq=0 space=3887104 ooo=0 scaling_ratio=219 rcvbuf=9087658 rcv_ssthresh=7755537 window_clamp=7774207 rcv_wnd=7757824
> tcp_stream 33793 [010]  826.426991: tcp:tcp_rcvbuf_grow: time=50274 rtt_us=50196 copied=7757824 inq=180224 space=5373952 ooo=0 scaling_ratio=219 rcvbuf=12563759 rcv_ssthresh=10729233 window_clamp=10747903 rcv_wnd=10575872
> tcp_stream 33793 [010]  826.477229: tcp:tcp_rcvbuf_grow: time=50241 rtt_us=50078 copied=10731520 inq=180224 space=7577600 ooo=0 scaling_ratio=219 rcvbuf=17715667 rcv_ssthresh=15136529 window_clamp=15155199 rcv_wnd=14983168
> tcp_stream 33793 [010]  826.527482: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50153 copied=15138816 inq=360448 space=10551296 ooo=0 scaling_ratio=219 rcvbuf=24667870 rcv_ssthresh=21073410 window_clamp=21102591 rcv_wnd=20766720
> tcp_stream 33793 [010]  826.577712: tcp:tcp_rcvbuf_grow: time=50234 rtt_us=50228 copied=21073920 inq=0 space=14778368 ooo=0 scaling_ratio=219 rcvbuf=34550339 rcv_ssthresh=29517041 window_clamp=29556735 rcv_wnd=29519872
> tcp_stream 33793 [010]  826.627982: tcp:tcp_rcvbuf_grow: time=50275 rtt_us=50220 copied=29519872 inq=540672 space=21073920 ooo=0 scaling_ratio=219 rcvbuf=49268707 rcv_ssthresh=42090625 window_clamp=42147839 rcv_wnd=41627648
> tcp_stream 33793 [010]  826.678274: tcp:tcp_rcvbuf_grow: time=50296 rtt_us=50185 copied=42053632 inq=761856 space=28979200 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57238168 window_clamp=57316406 rcv_wnd=56606720
> tcp_stream 33793 [010]  826.728627: tcp:tcp_rcvbuf_grow: time=50357 rtt_us=50128 copied=43913216 inq=851968 space=41291776 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56524800
> tcp_stream 33793 [010]  827.131364: tcp:tcp_rcvbuf_grow: time=50239 rtt_us=50127 copied=43843584 inq=655360 space=43061248 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56696832
> tcp_stream 33793 [010]  827.181613: tcp:tcp_rcvbuf_grow: time=50254 rtt_us=50115 copied=43843584 inq=524288 space=43188224 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56807424
> tcp_stream 33793 [010]  828.339635: tcp:tcp_rcvbuf_grow: time=50283 rtt_us=50110 copied=43843584 inq=458752 space=43319296 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56864768
> tcp_stream 33793 [010]  828.440350: tcp:tcp_rcvbuf_grow: time=50404 rtt_us=50099 copied=43843584 inq=393216 space=43384832 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56922112
> tcp_stream 33793 [010]  829.195106: tcp:tcp_rcvbuf_grow: time=50154 rtt_us=50077 copied=43843584 inq=196608 space=43450368 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=57090048
> 
> After:
> 
> It takes few steps to increase RWIN. Sender is no longer RWIN limited.
> 
> tcp_stream 50826 [010]  935.634212: tcp:tcp_rcvbuf_grow: time=100788 rtt_us=50315 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
> tcp_stream 50826 [010]  935.685642: tcp:tcp_rcvbuf_grow: time=51437 rtt_us=50361 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=160875 rcv_ssthresh=132969 window_clamp=137623 rcv_wnd=131072
> tcp_stream 50826 [010]  935.738299: tcp:tcp_rcvbuf_grow: time=52660 rtt_us=50256 copied=139264 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=502741 rcv_ssthresh=411497 window_clamp=430079 rcv_wnd=413696
> tcp_stream 50826 [010]  935.788544: tcp:tcp_rcvbuf_grow: time=50249 rtt_us=50233 copied=307200 inq=0 space=139264 ooo=0 scaling_ratio=219 rcvbuf=728690 rcv_ssthresh=618717 window_clamp=623371 rcv_wnd=618496
> tcp_stream 50826 [010]  935.838796: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50202 copied=618496 inq=0 space=307200 ooo=0 scaling_ratio=219 rcvbuf=2450338 rcv_ssthresh=1855709 window_clamp=2096187 rcv_wnd=1859584
> tcp_stream 50826 [010]  935.889140: tcp:tcp_rcvbuf_grow: time=50347 rtt_us=50166 copied=1261568 inq=0 space=618496 ooo=0 scaling_ratio=219 rcvbuf=4376503 rcv_ssthresh=3725291 window_clamp=3743961 rcv_wnd=3706880
> tcp_stream 50826 [010]  935.939435: tcp:tcp_rcvbuf_grow: time=50300 rtt_us=50185 copied=2478080 inq=24576 space=1261568 ooo=0 scaling_ratio=219 rcvbuf=9082648 rcv_ssthresh=7733731 window_clamp=7769921 rcv_wnd=7692288
> tcp_stream 50826 [010]  935.989681: tcp:tcp_rcvbuf_grow: time=50251 rtt_us=50221 copied=4915200 inq=114688 space=2453504 ooo=0 scaling_ratio=219 rcvbuf=16574936 rcv_ssthresh=14108110 window_clamp=14179339 rcv_wnd=14024704
> tcp_stream 50826 [010]  936.039967: tcp:tcp_rcvbuf_grow: time=50289 rtt_us=50279 copied=9830400 inq=114688 space=4800512 ooo=0 scaling_ratio=219 rcvbuf=32695050 rcv_ssthresh=27896187 window_clamp=27969593 rcv_wnd=27815936
> tcp_stream 50826 [010]  936.090172: tcp:tcp_rcvbuf_grow: time=50211 rtt_us=50200 copied=19841024 inq=114688 space=9715712 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
> tcp_stream 50826 [010]  936.140430: tcp:tcp_rcvbuf_grow: time=50262 rtt_us=50197 copied=39501824 inq=114688 space=19726336 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
> tcp_stream 50826 [010]  936.190527: tcp:tcp_rcvbuf_grow: time=50101 rtt_us=50071 copied=43655168 inq=262144 space=39387136 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
> tcp_stream 50826 [010]  936.240719: tcp:tcp_rcvbuf_grow: time=50197 rtt_us=50057 copied=43843584 inq=262144 space=43393024 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
> tcp_stream 50826 [010]  936.341271: tcp:tcp_rcvbuf_grow: time=50297 rtt_us=50123 copied=43843584 inq=131072 space=43581440 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57147392
> tcp_stream 50826 [010]  936.642503: tcp:tcp_rcvbuf_grow: time=50131 rtt_us=50084 copied=43843584 inq=0 space=43712512 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57262080
> 
> Fixes: 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
> Reported-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c | 8 +++++++-
>  net/mptcp/protocol.c | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index c8cfd700990f28a8bc64e4353a2c78a82bb6bcb2..f004072654a4c50da14b9dafc46133feb71f12cd 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -896,6 +896,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  	const struct net *net = sock_net(sk);
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	u32 rcvwin, rcvbuf, cap, oldval;
> +	u64 grow;
>  
>  	oldval = tp->rcvq_space.space;
>  	tp->rcvq_space.space = newval;
> @@ -904,9 +905,14 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
>  		return;
>  
> -	/* slow start: allow the sender to double its rate. */
> +	/* DRS is always one RTT late. */
>  	rcvwin = newval << 1;
>  
> +	/* slow start: allow the sender to double its rate. */
> +	grow = (u64)rcvwin * (newval - oldval);
> +	do_div(grow, oldval);
> +	rcvwin += grow << 1;
> +
>  	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
>  		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
>  
Hi Eric,

When applying this series I see a regression in a simple 25G iperf test:
retransmissions are seen due to packet drops (out of buffer) on the
server side.

The test:
- server: iperf3 -s -A 5
- client: iperf3 -c 1.1.1.1 -B 25G
- Configuration:
  - Server has a single queue with affinity set on CPU 5.
  - Ring size: 1K (4K ring size seems ok)
  - MTU: 1500
  - Client uses TSO, server uses SW GRO.

Before series (includes first patch):
<...>-2192  [005]   162.451893: tcp_rcvbuf_grow: time=1622 rtt_us=1596 copied=76781 inq=30408 space=14480 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=91990 window_clamp=96256 rcv_wnd=66560 
<...>-2192  [005]   162.451998: tcp_rcvbuf_grow: time=106 rtt_us=105 copied=158720 inq=0 space=46373 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=91990 window_clamp=96256 rcv_wnd=92160 
<...>-2192  [005]   162.453254: tcp_rcvbuf_grow: time=142 rtt_us=44 copied=292496 inq=91512 space=158720 ooo=0 scaling_ratio=188 rcvbuf=432258 rcv_ssthresh=270533 window_clamp=317439 rcv_wnd=253952 
<...>-2192  [005]   162.454446: tcp_rcvbuf_grow: time=113 rtt_us=44 copied=343176 inq=127424 space=200984 ooo=0 scaling_ratio=188 rcvbuf=547360 rcv_ssthresh=349656 window_clamp=401967 rcv_wnd=345088 
<...>-2192  [005]   162.455726: tcp_rcvbuf_grow: time=52 rtt_us=44 copied=264464 inq=40544 space=215752 ooo=0 scaling_ratio=188 rcvbuf=587579 rcv_ssthresh=391036 window_clamp=431503 rcv_wnd=194560 
<...>-2192  [005]   162.456444: tcp_rcvbuf_grow: time=37 rtt_us=36 copied=322560 inq=0 space=223920 ooo=0 scaling_ratio=188 rcvbuf=609824 rcv_ssthresh=391036 window_clamp=447839 rcv_wnd=323584 
<...>-2192  [005]   162.456865: tcp_rcvbuf_grow: time=40 rtt_us=36 copied=421840 inq=73848 space=322560 ooo=0 scaling_ratio=188 rcvbuf=878461 rcv_ssthresh=581105 window_clamp=645119 rcv_wnd=515072 
<...>-2192  [005]   162.457762: tcp_rcvbuf_grow: time=38 rtt_us=36 copied=430176 inq=65160 space=347992 ooo=0 scaling_ratio=188 rcvbuf=947722 rcv_ssthresh=631969 window_clamp=695983 rcv_wnd=467968 
<...>-2192  [005]   162.463191: tcp_rcvbuf_grow: time=35 rtt_us=34 copied=411336 inq=0 space=365016 ooo=0 scaling_ratio=188 rcvbuf=994086 rcv_ssthresh=666017 window_clamp=730031 rcv_wnd=354304 
<...>-2192  [005]   162.469069: tcp_rcvbuf_grow: time=38 rtt_us=34 copied=444520 inq=0 space=411336 ooo=0 scaling_ratio=188 rcvbuf=1120234 rcv_ssthresh=783379 window_clamp=822671 rcv_wnd=679936 

After series:
<...>-2585  [005]  1061.768676: tcp_rcvbuf_grow: time=623 rtt_us=600 copied=72437 inq=28960 space=14480 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=81968 window_clamp=96256 rcv_wnd=82944 
<...>-2585  [005]  1061.769859: tcp_rcvbuf_grow: time=89 rtt_us=55 copied=250560 inq=46336 space=43477 ooo=0 scaling_ratio=188 rcvbuf=592631 rcv_ssthresh=302062 window_clamp=435213 rcv_wnd=230400 
<...>-2585  [005]  1061.775618: tcp_rcvbuf_grow: time=56 rtt_us=55 copied=405296 inq=140016 space=204224 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=1927847 window_clamp=3428745 rcv_wnd=1928192 
<...>-2585  [005]  1061.777324: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=450664 inq=131072 space=265280 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3106743 window_clamp=3428745 rcv_wnd=3006464 
<...>-2585  [005]  1061.783411: tcp_rcvbuf_grow: time=58 rtt_us=55 copied=521280 inq=41160 space=319592 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2086912 
<...>-2585  [005]  1061.790393: tcp_rcvbuf_grow: time=55 rtt_us=55 copied=524288 inq=0 space=480120 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2492416 
<...>-2585  [005]  1061.935387: tcp_rcvbuf_grow: time=55 rtt_us=55 copied=537824 inq=0 space=524288 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2258944 
<...>-2585  [005]  1062.977374: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=545064 inq=0 space=537824 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2223104 
<...>-2585  [005]  1064.873376: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=549408 inq=0 space=545064 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2509824 
<...>-2585  [005]  1065.984340: tcp_rcvbuf_grow: time=59 rtt_us=55 copied=574024 inq=0 space=549408 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2336768 
<...>-2585  [005]  1066.210718: tcp_rcvbuf_grow: time=410 rtt_us=55 copied=589448 inq=0 space=574024 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=3364864 

Is this expected?

Thanks,
Dragos

