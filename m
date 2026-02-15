Return-Path: <netdev+bounces-258764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fXKyDQyVkWlmkAEAu9opvQ
	(envelope-from <netdev+bounces-258764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:42:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08C13E66B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F032230039B0
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF12BD00C;
	Sun, 15 Feb 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJ01o/BE"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28644230BEC;
	Sun, 15 Feb 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771148551; cv=fail; b=A32+TEX5H756E4PhTLr9jn0U/kXOehI9vykRtGG/w0/Pwug76N54bZfgrbtkpbgG8BOZ0wQjBD93cdPbCCZgcCpKeNiVh39T+OcPFMj3DGeK/907abfDZwovm8R9kFXu04JZHUVuRxujDQ6y+pXJ4ox3QEEIYXaQQz96mua9gYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771148551; c=relaxed/simple;
	bh=m1UXBr5fA46dNhwbawqcb4wtQMHWJMk7Sw99LbAkGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nn/wh/kH78UXHL6iwUwuQ0E+karN9JnWimBPGPs7GLpwGcdXK+9F7DvzENKfBqJqMFufP6jv4Lazu9bE5OkMVrrkyGarIiLvRvEL2jhkawkxhDhYwcDvph2h7ohqyDn9Fzxav5S0/qO6yWjTrg8UhgOUIlKewvJ0OXvTnouV5PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJ01o/BE; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njFZHnczbBlPfkrchuaqsJD1d/Hfvkwk8t/qUzsLDOtg/c968yfUnlurHtGEppHhJN1cl57/wN1378+zNjbCYDezuqwrkLmgEZZYJYmh1iJOrRUUjA6fv0PSSiF6k8fgVRKlVp//r/Pil+9rRNwTerIvpm4DYtqGMUHUI/VxlQKeRBFtdUYGODVUtXq48tr5T34vMcVCcBjgajyfwl8+Sn7650VCB9UDsCiANzXgOO8AGqlfWDOYv3eMQHSCSt7FqBXo6SqWIjnTJmeLSNsFSEG7m4MsXJiTXVXTvSRX4jgVJuifRqSXwx1xUlza2b1W7ShTIkSnju1IaOzBQQqHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qKB/vp1QDY2LJkSayaZKiU8JgpjHfh+kFumNeWA9ho=;
 b=KNaehwgv/GvLglllnncik8sfw3kYSzrnftMKG/EFjxu03X04Buij95XCvl7jHEO/uiKSacM/mp9kiSS8jp0pBahgHmHgp16mAJny6CFrm+sWgLzdAocF4T9MmDlPM+ymQzZfrPXOHWli6lcmAAorQL2lIHldRYBSHShXhRv1lpDKAPdAre500S01FggGTMZ2GGPbWb1pOwj34Tut1jlVMwKCq87jfsBwvfGN8fxmdVGB1+5SNLyZo1LoqAvJe1DFYT3WoBx3K4pbsHQtK1hFTO0D0tRKk1r5RHUpZpxhrY5JpA/olWNUzYDCpB8po/rXOAuMKkqmURw11nMkbVA0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qKB/vp1QDY2LJkSayaZKiU8JgpjHfh+kFumNeWA9ho=;
 b=uJ01o/BEX2DZqgpx043o3Tks+5gNa7i4KoZ2zRQPgdXegVNDBYVsX1E97+cXlfoSE3XJ8siIdKthyccsNjEW01cuAgy0XqUny4fGKNPCARo3hp61kitXIki3uJ2UeUsTKOM+6cTGa+kThXmB/+Tpf5uYUT372SbSDwocNKNfQg/QcGLS41tbLQn0b2D/V0CmSuDnG4kywV8zdEOZIj78PLTxwIMmpLCipMN5GHaliuLxsYZ61Ch308K/jGqgHIeFIO+wdGMOPpxFH5JkLod/SBCf/IWuNMeWdqVa/Xxc2tTxwWMm+XyHbHSTYxGsj7HBOCbByTuuOaVymTTNrZVD/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 09:42:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 09:42:25 +0000
Date: Sun, 15 Feb 2026 11:42:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests: forwarding: vxlan_bridge_1d: fix
 test failure with br_netfilter enabled
Message-ID: <20260215094209.GA114305@shredder>
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
 <20260213131907.43351-2-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213131907.43351-2-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 29db89f7-ba9c-43b1-1f0b-08de6c768654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIG0uJkmqVq22YYLTxlHg2HWXSXDJG2m9wzcsfIfXUQcUpD+eWKpucwT4gyP?=
 =?us-ascii?Q?A5hzaxrq4CQ+8nZfrdYY7bJaZO5q7zUsUt3rEtwEtFfqrnVPKE56vkEXZfPV?=
 =?us-ascii?Q?Vn19YUr4jtz9kmeLH0g4wP+vbtb3RzbhsKiV71nQM2OqUkTdzJBDuOlGEbDA?=
 =?us-ascii?Q?4ZAmUsbhOMnRO5SvHFYVMPwbK/tzu1rS7KHtkhbhRQjIZnXbFevTxq3RzVlS?=
 =?us-ascii?Q?syAoVhlrc3lFfNzjz1g3swMX2cQo/bBEgzbFyech553y8MBPnOnullE2aEMP?=
 =?us-ascii?Q?iXR6bK3E3k7XleeodKbXcEAzHuzhwCOd2VlS8YDQZLHy4yEvQNWJHzT8tWVq?=
 =?us-ascii?Q?JOUlE9TmPalUJBWynAFgLZ63ShDk+s4JYOVMKRTWyX06ycLMOwgSH70dFKML?=
 =?us-ascii?Q?RCY5e5jZ+87l1XQdibBM2+Y7YMBQXlHyR8ORJl79cD7BvXWRsCM1FRV/gj0o?=
 =?us-ascii?Q?SS573jdWfOC6o5TKLpu7VaaiBkAJmCktuijz+YoMaP5O3pYmt2mr2qK8uqet?=
 =?us-ascii?Q?DDgqt2MdADVAiFedJ4PF0BPUZzz8Z4VibmvqcKNx1/KE291hIhFJUT3QwktL?=
 =?us-ascii?Q?X2eS0S4+xSSzoQm9qyQdrliL2U1IxKk/Sveh+Zy2Tn12Nbz9HHfFZTGgSiUw?=
 =?us-ascii?Q?PhwHnRXW6Pz3VZZto+P1hG3Xs+KXDlju3b3dfDfGqDwIS943E1ejzAc8DFSK?=
 =?us-ascii?Q?Rrj/Qs3BLmk7kxsKtk1tqTgE3wx4mOeJ/l2kbfsxRBHMbEIv3nvs8cZn26PC?=
 =?us-ascii?Q?53xKra5C1ThVUHKtwCzpSfaPumFzGq6QZSX8998Khis90mmdlPuraNzr49H7?=
 =?us-ascii?Q?pLkUs0rkOefKMPZGhGz8qbMxnkyomcwQtRK2BxaArKrDzDEV40r8eWQ2FvAc?=
 =?us-ascii?Q?IuY+877Q0OIlD5tmNKp9N8Sb+malOMoighUNxfor1bhRPjt79DdZQLR5w2hA?=
 =?us-ascii?Q?jh0m/Gqu7dgBypufNIk4ajdZwRWUHNMAsuH8LUXGzYYywuyUG7wg+DoiYaNZ?=
 =?us-ascii?Q?t13tafu5s383kPIZIkfpawI8SL0gpggR6a7eMpeU7PzGHIFfODxEpSmICTXG?=
 =?us-ascii?Q?Tas1tiL30+GcN0L5vTcRDMu5Qouurvam0oBJYRbf9zvf0tmPOlQqjY/NP/7t?=
 =?us-ascii?Q?FnR0AXujkacL8V23F2c1Yh+z2d9gmJqACMv4y5u+4waNFA+Az74rqotwUiQl?=
 =?us-ascii?Q?IDjyd9LG0w2+XMEcLP13gmLvDYPDJJXXRDmWgvbLNdFu8HW038O4BShycEEl?=
 =?us-ascii?Q?gXT58iiJETI99Fvpn04NS7uqQOrOecdTuXZYTqEC+r56cnPyH2GIlRaQgwyM?=
 =?us-ascii?Q?ctnQ7mEsnjtx27AbsIU1xlv6z1M8VyrrDDAvNOsfuuJh4xKqwdveeo+cCiCI?=
 =?us-ascii?Q?WK+cB4DdCT4OAPNvTNsFgnvOMecQ2bjPcJwSPbUCNx4iGIqQyp2QwP1+XY7L?=
 =?us-ascii?Q?xdVc+QROEASXgMX+YHkArQx/ur1t0gNVvxIUDL017fccoU+IImL/LI0JZYN4?=
 =?us-ascii?Q?TLK216P3S0vpeFh9861fxD6LtvGLmyxQe8cv4JesdKhlF+JohRXE5RuSoObv?=
 =?us-ascii?Q?yMZTPTapH+0Q37Kllpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeEnHNvvRYa4bYdA51C3YU7qDXb0G3MN3zw90VJhsIBx57zTsHOGUPRQbefd?=
 =?us-ascii?Q?M03bhq2jiJI4dZplTdtlpwFrJGdX/7BKekJW3rgZ59P4VcJC3jTehmpTx76X?=
 =?us-ascii?Q?6J5h/LXXsWWLxBuQfqtTYR3t2EesS9GbbhdywQYLbTt/GUDM3+vfX6bY69fX?=
 =?us-ascii?Q?qcozRLtd9unTwaV87m7M7ywmv525mQbp8Iu7hvtNTRqcRHV58YQYDx+xS8Fs?=
 =?us-ascii?Q?qKMfDGEH6ubRuL5L/hWRPCBb+rsyJhCMqAdrG7p7a3CDlfL5jEIIoO1mZk5p?=
 =?us-ascii?Q?pL25IdN9YLa+DkGCATiPwNJV3YM7a85Y/MnV0VFmchY3tP44f+G1l9mLMIcY?=
 =?us-ascii?Q?c1U4bx+c1tFClA0hzbnJkEBVo2kYrCjtSZo/vl/VIzOtOdB0XhE1GjsOFIMw?=
 =?us-ascii?Q?GmD7scFjdohFL4WMJBqi7FwaZenHECXD6ev4yvJ2Wyewb1y95TeRB4JCOIcy?=
 =?us-ascii?Q?WaRTf9SWU8LYpf1O6sS/1I4QoSdbantUlSPE1DRlqDCmMqti5n3XK48TXDs0?=
 =?us-ascii?Q?KkxgRQs9U+TSYAHPS1ulE8E3cVkCs8YjrmVN4J6fNkuTp2Bqfo+txnaR9Lid?=
 =?us-ascii?Q?C3wOB/6No3hKyp7rNWG3HxUPEgfJBrjNodEDjb1+dybGJLwuAiUlOWeugw8i?=
 =?us-ascii?Q?RUU5jyU1gegLT8k7vcYV/qkBcGqEeXHr/tDxYSi6wsg5Zywb1wm6fUOcUZcG?=
 =?us-ascii?Q?kDer1Q2ZzUKDxmGSWV7gYpZ1DGyfjhFUIF8jvKykYRnfVW/ubfzAa//O0q7j?=
 =?us-ascii?Q?fWzkYUZ4VbjTsWegE5Ud8JTT1KAMTCDm/UsiwJ/2ZGX5pY6zba++0xp810W5?=
 =?us-ascii?Q?n7MhmkEezWHKj3vKqXu4qCRYuV9yMkOtJejf9cXO3Z+mbzw/OlWpA1eY3R1W?=
 =?us-ascii?Q?k1ju5qa+/Jue29sBMytLOTOcWbHja+qfJT2hotVmnor5hazt3p63tO+Rm+Z4?=
 =?us-ascii?Q?Y9VBMUmiAvlwBAzDqkBOCokixNH1ZgPtK6s2UtksUtVncgBPJ38EqXoJrndW?=
 =?us-ascii?Q?NPNVn5J4r0HxyWmTy/e5z+dlz3WqOAqXSa3AoaqmwVUNdc+AvYDjCUIMGUuF?=
 =?us-ascii?Q?kz31aRYMz1nWQlaPj8IyqbjOMQmjOM/Sq1pYRUVYYF0K4Z1XNcoH47UKbjDU?=
 =?us-ascii?Q?JU2lOg+dKzvhvePG/Wx3xlBq9gngsj9GIR/a8Aq09IkEVVqhgugmDyb4jtyq?=
 =?us-ascii?Q?73XRGnk+gOP8VT0NDtHtGRrTGK2Toowj9sFAGkCmWWDtUBLsL7QlPc/8ux9C?=
 =?us-ascii?Q?UxwXluJVPXs7np4yoZJIEOLtpNGOEWBEpRlBYgQl7LKRI/BuuvZuv110HZli?=
 =?us-ascii?Q?mddSz/oheM7DEagnghZW8sZPekTHgU0sSZMf7yaPYsziBqSn6wnlvNkI3bdD?=
 =?us-ascii?Q?DFhuckMXtrRMrgAzdal+u4HVpRXtIfSPp1qmLj2lZ0CewgdiobaG/TxfeUGj?=
 =?us-ascii?Q?Cex6Vbzt+gYNg8YY8/lU1FI56plWhG+e9clksjl+kHu6eRl1F+pWQk5If112?=
 =?us-ascii?Q?pIWL7SUb7GIDco6qx6pvFea6hm6g9KK644qxi/qXkMwvlwh14E6kWeGZL1lo?=
 =?us-ascii?Q?rayQ/bbEPhNGVPjXqLcARuSxBVUacKPLKqoc+rbgIuwWOzFRf5TclG7IldgC?=
 =?us-ascii?Q?l9oU0lnzcWd/ixNlP0REB6f9F0Xk5N1ohCW8hPvM3Xfd5s+gdBDgCehxCtaz?=
 =?us-ascii?Q?V1GTY9u1BgTPRn424q4w4D4Z7uZh+EM/ugjQOF/oiRQKGmVU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29db89f7-ba9c-43b1-1f0b-08de6c768654
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 09:42:25.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74QA8JRAPBHRE1CGaypaq5vp1dNqGJk+wkfeJGl5uWAlM4LSoGjDK20swFhRfZoGYNXdgNXmPg4xC3V+8G2b/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258764-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: BD08C13E66B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 01:19:05PM +0000, Aleksei Oladko wrote:
> The test generates VXLAN traffic using mausezahn, where the encapsulated
> inner IPv4 packet contains a zero IP header checksum. After VXLAN
> decapsulation, such packets do not pass sanity checks in br_netfilter
> and are dropped, which causes the test to fail.
> 
> Fix this by calculating and setting a valid IPv4 header checksum for the
> encapsulated packet generated by mausezahn, so that the packet is accepted
> by br_netfilter. Fixed by using the payload_template_calc_checksum() /
> payload_template_expand_checksum() helpers that are only available
> in v6.3 and newer kernels.
> 
> Fixes: a0b61f3d8ebf ("selftests: forwarding: vxlan_bridge_1d: Add an ECN decap test")
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

