Return-Path: <netdev+bounces-269639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEFcEttZvGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:17:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A00872D1FEB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2051D308F8CB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7213624BE;
	Thu, 19 Mar 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBP5d+Rs"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B97347BC9;
	Thu, 19 Mar 2026 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951443; cv=fail; b=bDcgZyEDJYo+TLThTZHFmbxnVGW4LWCwTaF/asheAG7nRFc+99NXek+TfK3qABIRP77GraNZETsT7bMaOcmTkyYWe0mZd7FUcQDB9Z1rJvl6IDHN1c3Ad+XJ9ivtdNR41+nrRa0fy5/Qq7PI5VTKltSIvMGYdD5BUngOVAjzOUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951443; c=relaxed/simple;
	bh=9jNIrKs7e1M4WpcCjVS//vazEed9Q6d27f9W0kp2loo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rJgSWAaN5XnWFsr8cSkgE8+n5ycQIQwXPPV/zR9LreTY16DACBWiENGhCKz/TNH+Y2FBfiCrTcxx5YvFNTaOz74QReboxqi0wxecckplvmu8/EBoaM4XyQKB0SWC/Rdk/j6LyWhdqsXh5hhGFd7LNvuO++DklAR3p4v1QwPgRL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBP5d+Rs; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teWN2PbVYEvFmw25axKDNSCb+2+Dm/5N8cpUelk4U0QQz8FDb6DlF+h2soXScWr9L7V826U+he/A4X0bf80E9yv+a7ECYV7DggO6GEvPD4q069BND1bF96wY/tNyEa0lDDU1+4QUh1QLPmyUlsAaz7ybYW5AlVyHK5jF5FA7LPpqSo6UGJwXElU8X3vKzeVRfgEKiLovM4Ev8N+e6LHOX659eKHTRfZP5r0lSesXA0Z5yFVqXvII3Zi6jX+GKrEPvaS0+O/6QpnxK7p0/EFC8Hk2JgX7RRpymow02Ggp43rysLrqv0IIC1Jyb6AwpofowfN9jITNKHCYcf8exvkGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOhV8a8vMY3xG7IfJxw6wYuCJ907NChfI/wgg34eENI=;
 b=Sl/pscnDmyGzWjIteIUJgWU8CxLc5mA+l0eQmbOJMojoYejOqznX/SobrVU07WqQSzWWPqOu1BdXqXry7AXe8OhOogc8dqGrmJ1Z6fxY7hDcS8EI8wfC759dKK318m2os2c9t3VQdt6dQBIhz/t5c3naqbfrH44asRpXnq7Ge/LwvASCMo9baoKd5a6nycq896I9pfpGAzawcy+VfOOfSQIn18cb3JYqMeoRB27g5xz8hkyzDlc19b70caaGy6v694R/YhLpT0FMvo0Wz474SDElUNdY6gW+mATYKK6U59b10pShrdfnLnXNMHG4ZwfnRfiwkR3ItxK+SurlG9vqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOhV8a8vMY3xG7IfJxw6wYuCJ907NChfI/wgg34eENI=;
 b=hBP5d+Rsybt3ShBGRh7ZjdnBunYWRl8OnJZKCSFmvUKjAOpPtK8nRUn9eEcw4GT8W/4zqK0JFUOXJIhuAxtmSzxh5dmlGldUByTtISobkOQEYPAugESRZkTj760cOMd4Tcxr8jxLJWEi5kLy6P+nib+Tu0tyBq4cQNXPdXs2M3WfmcBMO5gJ2/YSlMmdv6o4h8fJDaldzTa4weDxBflG1mMmFD6PnOpM8/cvXvwFQh4jYpP+hC9iU/+NZTapr3+uujhrT8t4oOgPPsSDBq4hJLhaWp4Yeo/44Aqv+bpHdoTzso6nLaNFRrOZqB+vgZEmCHzlKVSlB3RMdQX2sVIkaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 20:17:16 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 20:17:16 +0000
From: Yury Norov <ynorov@nvidia.com>
To: "To : Jakub Kicinski" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 0/2] net: cleanup bitmaps printing
Date: Thu, 19 Mar 2026 16:17:09 -0400
Message-ID: <20260319201713.941956-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:408:ea::32) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: d5135381-6382-4b27-02fb-08de85f48379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dC+26Fu6IAdOKL0MddegU1jLbxmCPoWj8grPbH27ankmoVgEK8oalAtiTKCCK2x3afrscKMj5FCoE8MFbyp+0W/F6JLWPTjeWD7ZiC2qKmCpf/fIEMfyX6gsAS/AMSbIZQ+ee53TQe1H3yrqURrABqTj9at1A9X1rYyKqhD4sMew+tdT6j6M7wT86fMM0Cc1jQOhYCIcHcaLMgvLQ8vHu5cD51yRvMPAzQyHFwbQKU35BbREA8VmT93wqLL4CqNC0YVQ4wS46N7qHgfEHShDdo9dGI1CnGiWIZcDo9YntPg6SnLskr30/55c18NkmUQF19Vp47bPhfXuP0xANuyJnpytxOCqJtDCRH5qPf1/fowXebB/MhRwBBpGiFEePgd/Z9x/Q+agQqCP6PRAau6WdmA0JohW7k4nWy9Hr7j94hrlobZz47icepdgwrWCc2w03g4tskXe4tM+JWujYs2pCw/BY2QXzTKGRKOtO5kKKbfRisA48+cCcRTgNuTy+QxtZH6qsooIteYoBdfyC+ucOuNdC9xG5ZEaPt7CXyhcaSauaAimzlJ/31OhN0Jchl+cslHz67dRpLCiCQnIvJOekA9lqwI2BjrzBiVZjZxJr7/Tx8hGq8zjp95fQYLlLJ6C4TUcn+vPoIaNIyfFH08xNRpo9sohL5vemDghLvxFHbXSLoylvCtFV3NIeMK8yx9H85y/SxXpcXwhGa1RTiBCxms6ezS0236X0YfW8dm812DCmvrxN1OQDW5WCHSmMcYbA6WqmasX3COMjr0T/R8TeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTRoaXhuVVB4VUUrRTBJRTFSTTRyQUVnbVFqWUs5TjhhWVRyekpJcVRKaDZs?=
 =?utf-8?B?RngyNVJqWnR1QWU4SmRGcjJJVjJzTW1YRlZGd3RGcVNxR0xnTHU4MlNWOFVC?=
 =?utf-8?B?WFkxUlI3ZEEzSmI3ZzVZN2hEOHRQTGprR2xmbUVsdUdIbFIweFBRRjFwWHFu?=
 =?utf-8?B?dnJ3WGxtY0lhL2ZqV2lxc3h0Q1hnOHZSczhKOUV4VjNZMkY5SDBUbm1nejNt?=
 =?utf-8?B?RVQ5TVhEcjQzdG1kOGNMSkt5N1NJbDloT0ZEVmdNNkRQbzdteTFwaEtzbFJz?=
 =?utf-8?B?b2QxaWNBQkc1dTNzMXZIQnYwWDF6L3hEQkR2ZGtkTFRySkVpc2VZa01PRE1h?=
 =?utf-8?B?d1draTdOWlFISWh2c0xBcTZyRHNnWUZBTC8xbXBnNGZSTkNIU0F6QndNVWZR?=
 =?utf-8?B?dytRdFpMZ0FYVUtIeUNqR2xzREYrbFhFRmZFMFo0dUdMNTlBSFNpV1IvdXp4?=
 =?utf-8?B?bUJJYnJnTnYxQ2dYT2dQdnZrTjJ0Uk9TYkJZdU03bnVaMnR3NndwWUdvR2Q0?=
 =?utf-8?B?SWlubEw3dVJWTEt1U0d4UzhPL0xobEFnNkgzaTV6MVd3V3ZkU1pFbmJJbDll?=
 =?utf-8?B?UzQyMjVLYmRtRXlnYURUODJaNnB3UnNnVktZM2UrR1VtN3A5RWVOSjcvU2cr?=
 =?utf-8?B?TDg1RFZ4c2VKZUR4NW9RdUNYTTM2SGhzVGw0N1Z0STlTZWRUYTdpMmt2ditZ?=
 =?utf-8?B?REZ6K2VtK1NDTW9ZUDZPTG5wbEg4T2IxOWw0Zml0elJ6a0JXQ0ZNMlRYOWE1?=
 =?utf-8?B?ZEJUMEJXckFrZUFhaWpBQnJNWHhRdm9yZE1qSzdBdUNnVlJRaWorZjY2Zkdz?=
 =?utf-8?B?dkx1QU5XQTd6aS9OcTFtT1pNT0xrbU5HL0Y3N0pqS2JmV0tuWjZyeFU1WFZY?=
 =?utf-8?B?WlJ1cHZLTE1SWi9DLzVZNG9VT3ZKZ1hiMUcyL0JwUi9rbG52Z3hRTUlFV1V6?=
 =?utf-8?B?V1FoQm0rR1RhSzk3aWNTL0lvSzZ5NVh5YzgvRXhBMGxMd0lKVkk1VGNkcS9w?=
 =?utf-8?B?NGw3ZWh4cjdjWUJXY0ZaTXhQYkl0NUJOaXZoU1A3NkZWR2hmQktZNjlDSXov?=
 =?utf-8?B?Y09HQ0xNMmJIRHhtZCt5QVI4eDFIa0ZnRElnVWg4ZHlVTjczWTYyM0ZQaWI1?=
 =?utf-8?B?ZSt2bmNGNElVWHd0bXYrdjVJWmtualhrY0w3QWY1VkN3dmd1USt1bWtaNTZL?=
 =?utf-8?B?ZGUvUm9NaHBsaWZnQnEzNVMreGMvRkF1QjlkNElqRUdRTFNJVlRuUzM5OWls?=
 =?utf-8?B?Vlplc2REeFVFZlN5K2R6SE1LVHRjRVB4OVZkdUVnSEErUlQ2dTJvV1RrbGJ4?=
 =?utf-8?B?dmxCN2dBaFZIaVE1ZVROTlRSM25hSGFNd1VxMzRab1hpSzhnVVp5c0VHVERG?=
 =?utf-8?B?N2hWSkZxR1J6MWN5U0lQTzl1dmFJOXczT0dpdmplV0tXRXJQbVo5T1RsbCsw?=
 =?utf-8?B?K05oekJTK2FtN3RWemJUQWtZYld3M2QrYmwxaVlZQnJzK0kydGVQSTRQSTFR?=
 =?utf-8?B?azFDWDEvdU5ZUHNwVFZYNGY1Y3BBYTJCUXVDVWtGa1AwU054b1lmdFZhR1JJ?=
 =?utf-8?B?bTgvWmNvdmVWTWZCdTh0bW5mUE8yUHFCQU1MVFZWVnBoNEQvQWYvakdKd3Y2?=
 =?utf-8?B?NmlUMkNDU2g5clFlNk04TDdJUzc0N3VTQ05maHZsRnB4UXZEUkptaTVtRXcz?=
 =?utf-8?B?WUdhcVdXc2VNRmxndVFiLzFGcUJsb0tkYjhmUGlJUXlhWWlteG04Z3JGS0xS?=
 =?utf-8?B?YjhlYzZ5RDZQVWRzT09rbFJMbzB5MVFGNjF6UFlmdG5oUVNSUXVIdndienBY?=
 =?utf-8?B?OFpnYUdpRzNFR2JyOGxjbmRxdlQ0SDVxTjBFN09YWVpNL3krUGYxdU9GVGJS?=
 =?utf-8?B?aU5ka0RqRVlNeDhNSmRGL014WEhIZXRFTkJIS3JEQ20xcWViT1ZOdDIrU3ZP?=
 =?utf-8?B?MU5SalVXb1Yva0l2a0tzVE9VNFluOHhRcUp0R1UzaTJuOEVOOExPNW1leXVr?=
 =?utf-8?B?VE5JckkyZTYwTFk5Q1NrTHdnSFlXOEl0YTk3a3JLVktNb0kzSGVuV2dxTUxi?=
 =?utf-8?B?OVdvbEkvVG1VNkxTWEVKOXVFelN2ZVl4eUtsRjlGQkR4YTZmNTMveVVoWklB?=
 =?utf-8?B?aDA5OThDS212bWxzenRaWGdTU1p4cHd1ejNUZ3VjSzZKRXc1emh1M3NPQkVW?=
 =?utf-8?B?M0NZYlVVRkd4Q2dLTi8yRVJjRVduclJoajhLVGFML1FBanZxUVpzZVZ6a0Ey?=
 =?utf-8?B?ZEowWnZhUU1rRzFWaUlzcUpCWERxNVVEek1QaWM4dEF0YUF4a2NuUHRoRDlU?=
 =?utf-8?B?QmxsMkZYVlZVTDBwYkxkdFlMYlVEck8vbU9VVSs5ZGhXaWpuZWszcThRdndM?=
 =?utf-8?Q?BWT3lFXhmXkNCdtCUOoxOJp4p+Jzcn1OPBrkO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5135381-6382-4b27-02fb-08de85f48379
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:17:15.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4s5vUdwjI9wb7UkhRNvIP+uHEeAGpVKHQbMYAwn75BNjwV/05XYpquFPqinujjdM/oLk0OikncTnZELgsAwSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269639-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,weissschuh.net,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: A00872D1FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
print bitmap into a human readable format, making sure that the output
string will not get big enough to cross the current page limit.

Some drivers use this function immediately before passing the result to
scnprintf() with no modification. This is useless because scnprintf(),
and helpers based on it like seq_pritf() and sysfs_emit(), take care of
not overflowing the buffer by itself, and perfectly print bitmaps with
"%*pb[l]".

v1: https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
v2:
 - fix copy-paste error in print_npa_qsize() (Simon);
 - fix typo in #1 subject (Jakub).

Yury Norov (2):
  octeontx2-af: siplify rvu_debugfs
  net-sysfs: switch xps_queue_show() to sysfs_emit()

 .../marvell/octeontx2/af/rvu_debugfs.c        | 28 ++++---------------
 net/core/net-sysfs.c                          |  2 +-
 2 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.43.0


