Return-Path: <netdev+bounces-253146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCjVAk/bdWnSJAEAu9opvQ
	(envelope-from <netdev+bounces-253146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:58:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0C800C5
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF94F3008215
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE543164C5;
	Sun, 25 Jan 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbKMlgtW"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED023505E
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769331531; cv=fail; b=ceeqGdi5MSv/ATb1FHzmaNFib4SOsHRzDkMtsP8sGscU/aECfodOYv8MnV1ODy8FVewCXLfWKFVmLhp6DODUqw6Gm7BrWSvIfGWSRGA0QS5UYkW44+bKii6j/IGflwbBLBjNY1TE2FSRLRtezs1g08JliqjQPFNYy9AUDsU0RD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769331531; c=relaxed/simple;
	bh=XQXRieCALs+ATVA0/3CpvE+mDLnC4RiQ5G9DJ7QCLsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnRa5h+z2GjLEkb7Mrj8p1JnRRceVCViFM8B/HcXY0dxVtbWGDpauAIYNrALJ/rHrvjs1ZWg+mMnKWoyh0bqnT0tcCDFHUc3gf+c61PHshhtYIS9dUoxzuLui5IInRjzFMxJqs7IV83mYgmPfBqFHJLCAB2P/ZvU+zqK02JepZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbKMlgtW; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYu49sxoOSziGOJBWais79O7dXrPUZtdL6I4er2e6mBBmm1sMqYHO+tb9QJ52tohijOYsZhTk5UzCssoA6X6cyaqD6cIwH+cPMzZJVl8810o4eVOOkAx/4lAxth/HxyIMU5lXHf2rt1JagkxIdT0l368D6KN65b30zd93Wtwg3V7mn8XDptc9be7yn5PaHVeiKn5yJo42VMUPqtbQVRH21RSCRk66DyM6yPtZesyPFrBu89RLejnBozjj7GblFiPeEkjKle0iSLJALdAY+QdDwbr7UQYRlQnakMEz2jbVxbW3mPmri/665uwPc+9P9F6LyjHnS5gXvvSL7gZiBgfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cot8xo3svNW8i5HpXV/Geo3kTTzM7Ayf6ycYc8GyDU=;
 b=eR7jLkzOPhFbuWEVVOVtmt3Za2pq4AGT+YKyTvmjHTyJGgCNYRiCisk+PzbzcSxU2ivOtTh7bIUDO8iEl8v3cburPJ4yGCy7ahcEf4MLYvNNB5s58lVboAZr2KeYk2fo9yPigusTydIwBVAsW04bWBosKrZMS6TKngnrSYAkfQf1RSOwB+PsIomTDX8jxJ/1IODDTNvwE8LxXc18bbjmQtlplr3g07ZrXaKZekDugKxW4jGA7aZsWSuhGZLNLSaHQNv+G+q9/r71uVruUOrpsRpdeCjyzfQlUBK8JM7t317mEks0nKUBCR6VvCp9bwuoN9uN9Nr5RdzD8UcNmYfnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cot8xo3svNW8i5HpXV/Geo3kTTzM7Ayf6ycYc8GyDU=;
 b=PbKMlgtWnfbvy35Jd2MO4qd7VF6lwMYo5hzLXpHZb3tV0QslxkXJI3z9n/YC4To7NaKCoYEm3yoCQy7j+9v3DneqBWexw/sEwZNFKpu0WqeMN12ZheWnbBbBIe7/ZbUvfq4HBxw3sFuGaVmiZjhH6xfsLVaJg98XynoBNNDCUd4ffCR1DwtnJJ7y9gIH3uShZ/cDWjKJD8TMpAHPbaYkyuRaoKHWhoOGSajT05KKbdyHgnut9rCh/dtc0fPeNKOOyT3Lcn6e0Tc0Fduax4+nN2NkysbozgeqpPZzrVOgWjbvhuvsvqRuTiRAhL3Tm4PAA8Em63oKUs+Xy9hEoucEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 08:58:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 08:58:46 +0000
Date: Sun, 25 Jan 2026 10:58:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH] ipv4: don't call inetdev_init() if device is no longer
 registered
Message-ID: <20260125085835.GA54633@shredder>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: a17a93ab-f0ca-4d6b-9675-08de5beff324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnH+gXFJv3Nl/XkJ3KUXRId0wJkAJG3mvzVEDMZABiHgre+FKEJgZaTYJQnC?=
 =?us-ascii?Q?Clo++kmD9YRB/TDXor+AStGFxV+qK8lvvyw3BLZEzJfr8PeKLQjXNhw8zBdc?=
 =?us-ascii?Q?pn4nYAXcNufqxZlq0+RcIQAXSU9ju7TvfPtgaWlZsTuMa3HKarARUROytPL2?=
 =?us-ascii?Q?RMi6QqSNJaeBlq83Pcc7FYZ+mf8UMwhV3RE4plzdm0yzHTbZ4xF3HD21VX9d?=
 =?us-ascii?Q?BbySrQAjr2wVXDpEYumLiqmnswyT860QVP8cT7Xl4xwUQH7KMFijeXgKYbox?=
 =?us-ascii?Q?d47Ojw/ebWQsV9mXfhrSWSyc/4mRLqbEy75B25KfAQ0HPiFM4moQyNtOwUD8?=
 =?us-ascii?Q?JtxqGwd369/K7Kuzm2dGMVbuGrKJV8sJ3hW48lTsI0Y0t9iAUUqpP/W2t2m4?=
 =?us-ascii?Q?A4p4DtkHo+Hb/mWCJDn2NpVKDWPeC1V30uQLHJBPP+S/KerYwr1mXXNjPesH?=
 =?us-ascii?Q?jcOr7QJDoVmkFRlN5uJ9R5HhpsWWrJVN/EP5CGyVvET+fudde3Rb0GPGM/GK?=
 =?us-ascii?Q?DNrW/vw2/oTGDGY7J0N1mmXC0Lc3A1VBQ5s2mBgeHoVG8FYqb34w7ytq4una?=
 =?us-ascii?Q?CKEZl69VkLqJnyiOQMK5ASX22Kq5thZ3pno7P4ETfHIPWbTt9QE0qqJ6uWX7?=
 =?us-ascii?Q?LUDOn/muGNL2lfamNk8KyOgO+6WKVntfnoYkVgJ/xv2iD6U4W5+17yxdcA37?=
 =?us-ascii?Q?qt8VvMfnW5qr7z/oh2lWwrq/XmBd/Xq93NxtpnMzes1WiKey9tlQQyE/WUt+?=
 =?us-ascii?Q?mW7u1JbfUdb8rLQkWH4ncE+R4Cx7xS2rlI/GZwmDsFYwPsFizq7eYhZ9aMCG?=
 =?us-ascii?Q?UCAp/HBlcKk2Pn3GIGI8J9Uk7gXKYemDKYtZbgMV5w75zwu81Zpp/wH4LbpE?=
 =?us-ascii?Q?ZhtTn4UO4xGxgFn4fju/4xE6b83zEd7sEVFJ1gijL0ybGDQvrKBwu174+Zsi?=
 =?us-ascii?Q?JcubCaSRZKTV391tSi4bCXyvdqW5OrLja54rf98e9yhvq7xD0awAZ8H4HHLX?=
 =?us-ascii?Q?OnoNBmXlwE26KFAq9ecrLGgb9o9COYZym1ofm61rgDFUVG9yF/2epbQFoEG6?=
 =?us-ascii?Q?7zZYyrr/wtVMD129+KfhP/3HzeaK8og3h+mlhz7Ou/q+k84cwMgT2ZDETmyP?=
 =?us-ascii?Q?zYJpyZEp6QDoGuM92/Gq8FrWIzCb9L1gXRB330tR5ZXUXCWkM8NE6weV/Lee?=
 =?us-ascii?Q?OtipvHBsw0hsVQvgTtAeK/3OdmzriuMmBwYDsMxzFAt9x1gH+RdDe1laRH38?=
 =?us-ascii?Q?YfWuW67PY1M8DEgSuhiNUVgDHdzWmre2an4tQMkky7YrKKFA4WtNdu0hFfyw?=
 =?us-ascii?Q?sXdMwwuVOTYAn11X3nB7RP31ocpv8d8eFQJTBmD6Bp9//HO8Xxh0M+K3JRRv?=
 =?us-ascii?Q?ViXv10ubIQH9/iZw4r90dceqz66aqMszTppj7l9cjQraJB5a1pAVPgl8n4FS?=
 =?us-ascii?Q?HyC3++SflqjdZGjztjS11aXu7WvFL1GLN1DlPPvgPz1azPCqve07s89AvZh+?=
 =?us-ascii?Q?m6u2EWbOJx0DPsZKJxQALdngjRhc3VFOiAdm+wgDaI5x8RRB7TZTUGrvRs9B?=
 =?us-ascii?Q?1s7Qs8U/DAnNoltPqUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tH0cCuNAIixKAf/01Vky6v/6iJfLND748M5uAJc/mz25GWPjqaOXRvD7Nqf2?=
 =?us-ascii?Q?9/wtywSYZxZCyDCWS5Z3NKWXOU/TnGKilq6gnUbq6ADApTgONt8grrRAFE0q?=
 =?us-ascii?Q?Nv619FqWWfK1UtSs5NHlcvuUtaZP1JjwBbmophjP1iqXzDeQ2ndOGpbFQmy5?=
 =?us-ascii?Q?iQMupB8Z5J51LpVCpEz29YttekEuWEzHw2QCY8eFnUyxsDUNHOOBAq6rTaQx?=
 =?us-ascii?Q?jvDVaXlK8zjQmV5OpoxlexrTknuaO8t68YwmGKfvq195HdaD1IC4A3cH7fIz?=
 =?us-ascii?Q?oVvtVZ6BCvBA45pmik5yltl5wUJWlhGY+4XrZBoU4GJSbI+V2R0lXCLJDzWM?=
 =?us-ascii?Q?Q/PXj4IHZG2Vu59n1DnSTJiN/vggHeqw8Fow1rqpOWRGJg0qiSMHv44jQKBZ?=
 =?us-ascii?Q?+l9sFcqysIwVO8pSAaTkgsda3pEs2fhJX2uWGhIEsu1FZAlvDzPqdHxl7RBb?=
 =?us-ascii?Q?eL+PNM3ufZffULSGocr2i0dsBUwu6K5Hf3bdffRkWizEPL8bRvX8KhP00rVZ?=
 =?us-ascii?Q?fyVYD2LWwof27Yqkc4XVARqVNQx3/xC0p70fUMrDj31P2Fl+MqD+Pe8V6MYK?=
 =?us-ascii?Q?2uM4hDeOiF0SqNi4P+xP/qjzyOyTxIhV5ZA4SProAz391t70msgq4lopQ9Y9?=
 =?us-ascii?Q?mIptBGsFmSO+dOMHhbU+X9VLGeUyS8/rn/AIHxKiN+/En46S3L+UZ1TCCwb/?=
 =?us-ascii?Q?GhDJFDIKJkodgZBSCmxb7Xh6E4OvpoLg8UJpPLAwE1k5CFBGyKsyLXvPmtED?=
 =?us-ascii?Q?8EXFDH1nuZozHQkZqxGUPP1TfgCjH1Fv5DQLP2NE0D85qSxn3i2vw3ok5rf7?=
 =?us-ascii?Q?/0AccPl5U4R2N3u2WYeqxl/wOfv/9TheLCfoysmpoD0FVVOCMwY2ofC1bIWc?=
 =?us-ascii?Q?MhCfKPdfIwg6YQJxTaQCw2wfYu4IOK4LGOKcy2R//7OkAeTxg2w1vI/DiaYZ?=
 =?us-ascii?Q?B3N5FR7+AqefVD5AMIR9FXeRPdSJrsg3gmgKhbiIWDc6gpgkBJ936+B83NxN?=
 =?us-ascii?Q?Mt4HrT0dMhrBxHXS4YDJ494KTVtbfPzKhi/PwxDqGF354uJXc1muELwbZ9yk?=
 =?us-ascii?Q?3rh0FdNe14gjFOHqxwhzsciRkhEijvyBaMSF6QzP8HRmtc3IiQDH72XZfe5M?=
 =?us-ascii?Q?MB55CTGL8pTZ7xqnTT7HrC5yVjRYJ/UUrf4gpDCNzkO1ZyIHBuAh251+H2co?=
 =?us-ascii?Q?noEBGApoOWHZrv9CMyo2TlVC+PNpBrZVUSHyrsWtzA3g/gEpU6RkPf8lSkq/?=
 =?us-ascii?Q?EN417uRWtGwABAtMcMf051+EoG3EuLFBOY7owsIRBXJnEK3JCVdMhoBtaRy4?=
 =?us-ascii?Q?OpGOPEup134NzUgcqqrZOoNj/Qqht5ghcUEiPPuSnIhycjtC5lysCaIYsYKM?=
 =?us-ascii?Q?0J3nOKglqspqpprH5236/H6JvcsMmsQ04EitbavHUIE/iLHg83HaqgfPIdck?=
 =?us-ascii?Q?PSHf9qx2yoaO9pGHn+H+SgrPqAn68/Ceq+SVImcQJ9FH4Kbgeh4eZNXYY1Rt?=
 =?us-ascii?Q?iuqdPSIXuMfo5a5GfX7+bNETNCgHFf5UNEEt5fau3CAfg+GnITEVWd3d51cQ?=
 =?us-ascii?Q?g7P4CDXspi+lD/zPbFHS/U95LaGAHP0ccWSvCnTJMlkHNbUf0+D5Nrkpwts6?=
 =?us-ascii?Q?JG7RJidYGGjiw/JQ1BdtCskYAcR/COJ8kCYTUntk1Ik/RD6kaLIQPXRpaqPZ?=
 =?us-ascii?Q?QqJZKx3/QSV5Ql3ADWOfoQj9C/zTtQ/IZjzysFgBOj6pN9BC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17a93ab-f0ca-4d6b-9675-08de5beff324
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 08:58:46.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Mu5epTPpLMmdG/3j37Zxd+NHWnse1sfCDhf5G5eqsQ5tNzRpP7iYAzfXUXM8mJclkUQLPm8hCvDLeKdW0ULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253146-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,ffff88807dcf8618:email]
X-Rspamd-Queue-Id: 36E0C800C5
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 02:11:16PM +0900, Tetsuo Handa wrote:
> syzbot is reporting
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
>   ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>        netdev_hold include/linux/netdevice.h:4429 [inline]
>        inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
>        inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
>        notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>        call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
>        netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
>        netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
>        dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
>        team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
>        team_del_slave drivers/net/team/team_core.c:1936 [inline]
>        team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
>        notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
>        call_netdevice_notifiers net/core/dev.c:2295 [inline]
>        __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
>        do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
>        rtnl_changelink net/core/rtnetlink.c:3776 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
>        rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
>        rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
> 
> problem, for commit 06770843c2f0 ("ipv: Re-enable IP when MTU > 68")
> did not expect that NETDEV_CHANGEMTU event is fired as a part of
> NETDEV_UNREGISTER event.
> 
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Fixes: 06770843c2f0 ("ipv: Re-enable IP when MTU > 68")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Since there is no reproducer for this problem, I can't test this change.
> But I think that ref_tracker indicates that NETDEV_CHANGEMTU event from
> NETDEV_UNREGISTER event is causing netdev_hold() on NETREG_UNREGISTERING
> device.

Thanks for the report and fix. You can reproduce with [1], but the
proposed fix doesn't help. Problem is that NETDEV_UNREGISTER is first
caught by inetdev_event(), which calls inetdev_destroy(), but then the
team driver restores dummy1's MTU and initializes the idev again.

[1]
ip link add name team1 type team
ip link add name dummy1 mtu 1499 master team1 type dummy
ip netns add bla
ip link set dev dummy1 netns bla
ip -n bla link del dev dummy1

