Return-Path: <netdev+bounces-260519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIbFLlSgnWlrQwQAu9opvQ
	(envelope-from <netdev+bounces-260519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:57:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C1187527
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8983081067
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6F39A803;
	Tue, 24 Feb 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P81bVzQJ"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB039A7ED
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937862; cv=fail; b=Jnp0E8djgQfBJFO4qj482FM9y1/W9WeI5/UltwF0pSsZGDzSRrAUQ+F2YwK/+Ro61ydHVOsnieFZM0QPqdYaIY0X+6scgGbNu4z9GXgRWxLeF0O/rivUkahfXMM0WobJKWPFCjKianxGz3tK537Q1GtoqvKQ4lnBSwBGu8UE+Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937862; c=relaxed/simple;
	bh=AcFjijD5vj8cGZncjZDHv65itdBvSxLprF6B4+qU3mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McVLRfiPCrdnuIA4Z+eQ8fSGXTOtFoHIW+qeUFeRZcKO3IORzdSQehf/R7Q3dKzBH/seQ63eT9vtxFsMsMfBvQymwvr+NZgvMaSdC7VduuIszmeh02+sYCfCEBrzSDANaIgNdiOhnYd6foiNPtLmwmbllSMmsLpue0b/iUzoNKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P81bVzQJ; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRQgy3mKTiw47sZQitRMXAkaXso+kFhW0KjoGCToXKlLNM2F0c76PBTQlAXrJ5nzL7+POfOuvjTNDl8hOTCkgevChPPrzLE9IptkU3q6EbaOXVcVKQ35YODw+iC+Xi3jskv+q+zZyy+OLu5RnKierYXgOoIkKyqMYnyz/1zviidXPVPQnLuYEurM8b8It+E0x9kuOzJIaDVKS8LF3s3Vk0x0WVmqmDFxWBRQR1NadXBfHGNYkpnTUQL829BjTyiNEe7KW+dvTosWbeH+zF0tWxPGWQvEquU5O5SHEzarGjl2m4Ne+thEQwncD7gQQnpLyoyiN0C3uvwjcmbl8poRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh4C3bE1c64WX7gjv7VbSjyamsOzOmXl1JgVldwkSC0=;
 b=QsmRB1CgMqIe0f+1E9MGHLT+TYDSZvb0oa1EnojQvb4WgI6wHbOdtgFkp/flQQl2ypkMEVRsnomtFSVLY1nHbtK+h3+knBDE6XA3Vam8Nt6cS+AtBW1qGSa6QS9fU04GfYZAoJrB+qYzuK7wtctkZhmFkFX+DQwVSkqz3W3v78WICZWOi+IUGfmSpItk5DiM9eQnmo+vnpuF+PQ14ytnPusrTKfBV5KtgdwDa9gcE9zp9AJEbBmmrSZLE5BpIq9621gOBiIw2ijmLpJ4Mxk9VyOwOffRAZc9UoFHTTI8hUSLUXaTdiY1QkgsuIoE28iAt2/q4OhLjTcTCxUj52/nvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh4C3bE1c64WX7gjv7VbSjyamsOzOmXl1JgVldwkSC0=;
 b=P81bVzQJEl/j+ppMT1qZ3ETi9c1pfPGj1gCTDSUXEWbWvyTzH7GhJRfq4cNuWR2kZGdBicnpRLm5h0eTkmnxX6/qD2aIzcB16bJFXIbeyHcgTYXE4WVKyn3jsHQgXPX2V5hM+YXS/+f0DTFaZ9J6eYMNTsLvtT3aGEwZP/6mSUWGBH7b9qv023A4hLdHRwcGdyRr7rt3YSrLQe+ZkDvq7D7gyZNz5OQpRmCTulhFHlc5AOfQRP5WJKkCaC4tJBN3RroOrhuj9iYda6gfc2zjARUp7eZF55r7S7bRC+mWsyF/J7Rk/C14GM+586LEqOrtsu4yAKtGxjA0FweAcAmCYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:57:38 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 12:57:38 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	penguin-kernel@I-love.SAKURA.ne.jp,
	stfomichev@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v3 1/2] team: avoid NETDEV_CHANGEMTU event when unregistering slave
Date: Tue, 24 Feb 2026 14:57:08 +0200
Message-ID: <20260224125709.317574-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224125709.317574-1-idosch@nvidia.com>
References: <20260224125709.317574-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b2399b-594a-4e80-f824-08de73a4497c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JccZzMFCpvWxQ2naKieuf6+cuJB5pOFnBP9zNxTt80b5+2pqtxvGItc5XQ1U?=
 =?us-ascii?Q?RScaEQv/Lc2OnY0YZw0g26GCFUlWoR1RDYq4K1uPQzUnsbZ7r/6p9i0yM908?=
 =?us-ascii?Q?BhvZfMCiigdRmtoO50AmigkP8qsuYHQ+hh5IrYB4PiVjzOq8N9zHtw44EXd+?=
 =?us-ascii?Q?++X1UYn/PwlVZpoYu3uwZe4ABmu4REQGY/ZD+VFeTrUMw5gdBDGwkZSjfZdx?=
 =?us-ascii?Q?xtoqex6abCVIl7eiP05P6cJiRCrjFhYMI3/8O67BkNSja7hkfHm45H6IABn5?=
 =?us-ascii?Q?Fbg2c1yC+gnVijEHwtsf8MkGVueNqC/stpgvwD4Z5qAe9qWLDntTzaBCAJsd?=
 =?us-ascii?Q?uCVPj/wFktnoQfBbKp7LQlXa3sfxPSJZgHoCskARuSv2cyugdYsojPaHdwYT?=
 =?us-ascii?Q?AuddkD/rkJk6e5cPrFKJf1pNxsnjwmpASrv5Q4y8vDMwrYWMwD7Ym6Dxwhff?=
 =?us-ascii?Q?vorVy4zUc6G+5woqgkXqFz2BEcrKqB3lEPwh7DDyOvnOUC/YzLzYduyVO1Um?=
 =?us-ascii?Q?V0Mf8Yak40pl9h1YmAyUGCXb1a2iR27h0/SkQmzwo6/i/b5+1wvXwbMXxUkn?=
 =?us-ascii?Q?56dj4zAOWfCRz2U8usvllBrxWUqY3b/bVPOExj5vvnC9XgiV3jJLgaEsGVFx?=
 =?us-ascii?Q?QqLqJM6Nu7M2lAMvGr7xtE/0arD4e08c8pM1/0d5ZCDfPio6WtcQw4B7sGmI?=
 =?us-ascii?Q?qgpRkUDUnJgt/XN5Vp9xSBRx54wb5AkEpw66YU8WVV+nn9TVyZj3/NSXPIjN?=
 =?us-ascii?Q?wrKOPLfM3McNClxjxdKckvEAWaDQUa9t9rWncczJuxZWcu1f5fron5MFH28e?=
 =?us-ascii?Q?oZAg+7ZlWeNH6+1QP/UVrsEDCOwTAHZR7XNC42EtKVbhg7+/bP0V9vIcipRT?=
 =?us-ascii?Q?NZ220lrUGm/5FrMufMU7Qe+M81misi31XMKUZTl+vd025NQuH7dtttA5cZx7?=
 =?us-ascii?Q?4PikR/Y3GGlNUAZ6EJrjN0LCzGDBBb0ezBlp+IL5C0OQsPsWEDAxfojfIkQk?=
 =?us-ascii?Q?lwVvi+JwWVhlWEUbJBZEGy84BAgATn744tv+rdVOKIR8zQLtqPzRHyqZEdQV?=
 =?us-ascii?Q?Nq906pY1FI+5tFZFGV0V60Yl4HkXi9SaLd5dSrKuNQnna1ea7XSnNHRCAx9I?=
 =?us-ascii?Q?XkuW+y5uh+vhxgcrNboutJijEmA1Vsftn5QhN037DpzeQMnDv6idYzfsnCzX?=
 =?us-ascii?Q?JEpUTfqGyVbjuJJvgGXgWI0zZnMgplKWhCbgtRISN7AzVPAehyS6u1aDdFN3?=
 =?us-ascii?Q?oEcPx/gYpi30OynVu0M5fzZX8Hk/v2jHqq5Dn0tXZYW6b4O7gv7d1D4aclGs?=
 =?us-ascii?Q?EFV9Bm+EqnoTwJX1QSJZoG2SUjy045efntnkFHY0GW15FCuqjeKgUiI4stj6?=
 =?us-ascii?Q?6K3Xv4owwt7BA5UyYM/SGgebD5SgPqr2Sy/WovHbtq1MgJZHUAPBBNKvjrz7?=
 =?us-ascii?Q?a0LTuHavXg3y6LT0V4L1UPNkupMfinm6LXdUZp/QSsUCjVq9sUqd1uft38kN?=
 =?us-ascii?Q?fSb2MDGfwFdRPGAhiaguFf0PYEV8RiuQaC9C6hafDUfLtKt9+R5ZXwusLxLn?=
 =?us-ascii?Q?BhcyYCakVwNIVW9gf9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4FxCxF6NWD0NHX4laN8kEzYQ+DQ8w2C3pKt/ElYFwsjV6xeoAntFhx4XMEA?=
 =?us-ascii?Q?z1oLkbc+YQAcImXU1tuIGcDgrbGqDFMzG4GbgDvXSQL1ntnMH0n65gQxe6UY?=
 =?us-ascii?Q?nZ7YQYMPbwqG9E9XhbUD5KdWaaLWXkKPJwSmiKqkF+w6OMosuHdwzDxje18l?=
 =?us-ascii?Q?FqeNHaWhagyqh7f5kzaVJjDsBKeDtihpIelp3qr7wPlCfz1QHI6uafiGGeAu?=
 =?us-ascii?Q?+QgGoyfcuU6j87E1wkldjXAOdY7vDzQCEvbXTXsFxMiIR8jeSqvBrwcY7WcH?=
 =?us-ascii?Q?H7Y7MEJi6QiIZfCUewsWcb/PCdXHB7DZOVYo5I+aJjxP4uQB5cqb+HJcOoMB?=
 =?us-ascii?Q?lQUZCUOC1FGv3Vi6yecTFub90LgQqdzS2asFF0FyKdjONP5xV39m74naK/QX?=
 =?us-ascii?Q?P36R5wOPOBmoWibhsBEneWqfggxPQd211g1ar6AI1BHq7iObBQMEt20VGdQZ?=
 =?us-ascii?Q?gu+21pHcspjfVmIGHgsQ0Rf0cIBjOKnrQRl/G45dAefwUompeaRZ+gzy8e00?=
 =?us-ascii?Q?Ab5sKvXakPdRRPMfLC2Sp8kT54LhP/JpGnINj3IZpdiGJraL6KaLa5phkOni?=
 =?us-ascii?Q?PXehMIaqOLtZF1sIEoy9B55EHevnNXd3+UVe/YjSDiA5GymCqgUxbBIqTBzI?=
 =?us-ascii?Q?V1y+G/taRJHy4wUsZr+eYwzbRjjdxoqDvw6ym2hFIkd+pjqdmxtTdH9r2M5c?=
 =?us-ascii?Q?izjzp0C+lMEzs3PAc/GaxHZOFyj28nS3IUFEW5bq6adaBedHJIP4HYOPp2B4?=
 =?us-ascii?Q?kSJy/mYaXartyu6yj5QfwGJMSmBC9/x2y+sCIMO7uDk6oW/vaNPjVY8ZlQxR?=
 =?us-ascii?Q?hu8vUP1lNFG/mPsLJXVj1HMjjaJjn/U0uOYj/S055rSR02whvHo0VMWZs2nl?=
 =?us-ascii?Q?kneyfa3qkWzw3GfWKESIq8EREf0ZznRuHm7Z6FGLxEq8VXlFL7G0cgzq2P5b?=
 =?us-ascii?Q?Xdcom1S3X/OYTgw/E7KD9LebHklUK7W7pAOnQqDZts4/Cg8ezARoC7Kc/Yr2?=
 =?us-ascii?Q?8aTu2EzxA5PtajHski8emuZx4U0rNFV6ji1x+2YbOno5/3pAFZp/wVeDcQxH?=
 =?us-ascii?Q?8iUboPoxMOPLGOIP9n0ZoPPTaVqDZUc3QZl6f1CdLW/1zMvVLzXw0qGOwwTS?=
 =?us-ascii?Q?mJhZSUfDb3rtNTApvM1aK+HgBm8NI4h/7LlN9Wjvgq/YOMssY3p0CaQ+twMF?=
 =?us-ascii?Q?247wdRdmcouA/3NpilxiqSpthTHIeXzE7cMWcsEffj7+t9mwN3ulrJbOyUqD?=
 =?us-ascii?Q?8kd9jI0Q3Ib1uH9E5q0X1tasc/PLNUU9pOZQt8bNEmWFIaIPlV04b/AUi5Fp?=
 =?us-ascii?Q?KOPZOvGWLj75x99K5+u904xMxpirtmCFkJF0qurSZi0kv7be2AV7bwijGRlo?=
 =?us-ascii?Q?NBvERcBcGPMmtjNwniQ7594Z4yQkM4KBSoeI1bFAJBUD3FyBDnDnA3EWUAgi?=
 =?us-ascii?Q?0kgCkJdMhtljOs7QMQS90GWQZEQo8hC4tEXpiPLTroBkIiEkT3XarY9NyyMI?=
 =?us-ascii?Q?BnrwdVV3NBJwGB7Ao/c/kfTHHBA+W8wyjD3joPNXtDZ5/JWU2bys+PiQreg3?=
 =?us-ascii?Q?RtWegbdHOFdz8uGt5hZOu5tw1fAhlX8Nu70YUqdEec9Silvis0xlbKWLR/3c?=
 =?us-ascii?Q?AP/kyuPXfVVpTj24RYlTlz6xORs3vmzMXEwxTvZnyjTSCi2wz3BX0Dn8ySsT?=
 =?us-ascii?Q?kX/5o5yxsatrsPo9vPgm9kF+7cMt/9yPA6r0V1qZVwzEk/2T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b2399b-594a-4e80-f824-08de73a4497c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:57:38.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX2H5yauAsaMqELKjAZrqVhgOqiv3tvt/jT0/Ytx1VvVInlcBisSzSkB9enYW0aqzuTTKGYm9XmDzdKrbNbgjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,resnulli.us,lunn.ch,I-love.SAKURA.ne.jp,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-260519-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.954];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffff88807dcf8618:email]
X-Rspamd-Queue-Id: 1B7C1187527
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
  ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_hold include/linux/netdevice.h:4429 [inline]
       inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
       inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
       netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
       netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
       dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
       team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
       team_del_slave drivers/net/team/team_core.c:1936 [inline]
       team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
       call_netdevice_notifiers net/core/dev.c:2295 [inline]
       __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
       do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894

problem. Ido Schimmel found steps to reproduce

  ip link add name team1 type team
  ip link add name dummy1 mtu 1499 master team1 type dummy
  ip netns add ns1
  ip link set dev dummy1 netns ns1
  ip -n ns1 link del dev dummy1

and also found that the same issue was fixed in the bond driver in
commit f51048c3e07b ("bonding: avoid NETDEV_CHANGEMTU event when
unregistering slave").

Let's do similar thing for the team driver, with commit ad7c7b2172c3 ("net:
hold netdev instance lock during sysfs operations") and commit 303a8487a657
("net: s/__dev_set_mtu/__netif_set_mtu/") also applied.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/team/team_core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c08a5c1bd6e4..a0fe998cc055 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1292,7 +1292,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 
 static void __team_port_change_port_removed(struct team_port *port);
 
-static int team_port_del(struct team *team, struct net_device *port_dev)
+static int team_port_del(struct team *team, struct net_device *port_dev, bool unregister)
 {
 	struct net_device *dev = team->dev;
 	struct team_port *port;
@@ -1330,7 +1330,13 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	__team_port_change_port_removed(port);
 
 	team_port_set_orig_dev_addr(port);
-	dev_set_mtu(port_dev, port->orig.mtu);
+	if (unregister) {
+		netdev_lock_ops(port_dev);
+		__netif_set_mtu(port_dev, port->orig.mtu);
+		netdev_unlock_ops(port_dev);
+	} else {
+		dev_set_mtu(port_dev, port->orig.mtu);
+	}
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
 	netdev_compute_master_upper_features(team->dev, true);
@@ -1634,7 +1640,7 @@ static void team_uninit(struct net_device *dev)
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(port, tmp, &team->port_list, list)
-		team_port_del(team, port->dev);
+		team_port_del(team, port->dev, false);
 
 	__team_change_mode(team, NULL); /* cleanup */
 	__team_options_unregister(team, team_options, ARRAY_SIZE(team_options));
@@ -1933,7 +1939,16 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	ASSERT_RTNL();
 
-	return team_port_del(team, port_dev);
+	return team_port_del(team, port_dev, false);
+}
+
+static int team_del_slave_on_unregister(struct net_device *dev, struct net_device *port_dev)
+{
+	struct team *team = netdev_priv(dev);
+
+	ASSERT_RTNL();
+
+	return team_port_del(team, port_dev, true);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2926,7 +2941,7 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
-		team_del_slave(port->team->dev, dev);
+		team_del_slave_on_unregister(port->team->dev, dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
@@ -2999,3 +3014,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jiri Pirko <jpirko@redhat.com>");
 MODULE_DESCRIPTION("Ethernet team device driver");
 MODULE_ALIAS_RTNL_LINK(DRV_NAME);
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
-- 
2.53.0


