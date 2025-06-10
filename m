Return-Path: <netdev+bounces-196222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E269AD3E98
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6B53A1571
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9723504C;
	Tue, 10 Jun 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwh0p2n8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A79204680
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572048; cv=fail; b=p+ywzjWVjoAZk8CJ0z7clGP3kdj3g7mUc7jVEi7g1skTGvHcMX2ZrUV0Y6QQIsKg2ixWaRK4ZGCZLDPWK8OuhSPYqXcjUcGA/a/zhAKDNng23/7MqQJCgnIEXofokJnXsLyrC9FfxZNKBXi3np2csas18MSF78o4ZVfsF/x/Wp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572048; c=relaxed/simple;
	bh=Gbx9uQzpYR9BaXFaE54ASfyDiD9woINU3mJ3tPh/wvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4d7mPRlCgPjTT996zjhDZNBobpmerRJCkHe/+GZrmLp7PQ0UOpmpc1uJAwntbSkMUhjmdXWQ6kDjx2aJXIdr03G7IM2NU24bw45J9f2dQ7skAZWl2s6f7Oob/99+Cjwf9nXxuzZ7He3/O2LwJ1ROxnso2vzB5wRPJGEFy8CmtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwh0p2n8; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLl1WwFMit1EkY6ywf+GddM7BSj8/p1h12OrpcUwKRtiSBD3mVI0AGpuQTZo3I7e7rdJzErKcmupnuNcswSlizaxMJ6fwuSEQtgeTX8xR1yNgc8wpM5gzDteZRlLxUfQFKpzDiq06SS9rJGsnaV9o3sOkK1xVnGpSibgLYp/uZTMhKCpxxPZU9iyvjRZVN1rx6wylT5v6jfLDZN/uJ5T6K+Pj3k+QYwqj9kny3dkXEgedEk+AO1tx5oB37AlWbJu0VNNq3RlrIrByt2WVriNMJBKlysHDoHlcJV/tlXJg5yqYnPGmPuZWzR/NsJ1HxG+/YgSnek4QMdVcJ2L18if8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbx9uQzpYR9BaXFaE54ASfyDiD9woINU3mJ3tPh/wvI=;
 b=JyhRJ/GnPtoJW9wGZ7MiqSxStzvRdeauy1H7uODetQB1r3JRISG/GqAJMmZr2Xh7XAZudFBchGsuC/tCvU/Tgi5APR2SNkDGgDRUiRpbE6F0Fj0KtmaHdKOjjgkXviphZMHKR1oSmGnR3FglbrKSlcm4jdoAowfO1gHz3s3Cn9ZHAy+y44aZ+i1MkFEEahvLudKb4XR9XbvabwaLF9hIMpC93aEHrCdLZXlnOPtvohzpP51rEydODPrGs+c9g13lPV1wsFDsr8nlmLpQkcoAJZ2tnGu5L7R5iYkt9oyp6QflGNBE5oL5b6KnyFHtItwpFaKiE9i+cc5tH2lxqo5/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbx9uQzpYR9BaXFaE54ASfyDiD9woINU3mJ3tPh/wvI=;
 b=dwh0p2n8RiVwmAeZ1Adyjr17+rUduaokqDpUQV+utrfcF4mHj1CdwzpNn/LqOYKP4Y0EEVraQX1XHMd7/pnGZVOwT7JGAhTKPNsGvC+RNpNQwo4+xyGydRcu/cQASd3lZ4pQLxvNUqVAlJqXZPIIkJBcN+oyWMqjqE42rYVxlxs+W6HFV/IWG7h9PbTufAbsjntwFvjV9XJ9oJDedkSG7poVaC6H7xTQJG15uAMSOlxtL79OhaeiWwX1IHVsXEpsDe8/RI6dQE9TcStVNDaZ3s8bFoTy56WXAe2FYHZNlTdRjB2nPqHP37BqgTBlw0nSiSnQ0T5iE2ppkcjv1RzsPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 16:14:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 16:14:04 +0000
Date: Tue, 10 Jun 2025 19:13:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v3 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
Message-ID: <aEhZwqHynnpYclIZ@shredder>
References: <cover.1749567243.git.petrm@nvidia.com>
 <f45aec48b2c7db079d8ede72453854a8ac435590.1749567243.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f45aec48b2c7db079d8ede72453854a8ac435590.1749567243.git.petrm@nvidia.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: bb18e9ca-6153-4929-a4fc-08dda839d189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euq9k3JNwE+596YDUgewXKIMKoEWeI1+lPSqtoEwTSYn7vTUYZZ7005oLwin?=
 =?us-ascii?Q?DOimckdoAj+bubvnnrm3C2BCKxMyUE8buX/Dd3geUV2W7oqeDyDybcl1l+cp?=
 =?us-ascii?Q?IDi9R+CRDxVpG7ZlZL0DxbA3TplfD844QsWVw5FoxUH6uQPrv5prS3QnobrR?=
 =?us-ascii?Q?+ZwDDl8tvoiOHDj9YmRm/Va7Ic6PC4iIOWHDzpAVcu2zLmarKoSrzEHNT+tC?=
 =?us-ascii?Q?gEQ9eqyHStDEawefy4NIdqY21nchGDsHMaa0yuxcOBkELSWkFwG1/qAG8qZ6?=
 =?us-ascii?Q?Yr9lZIFARcfUr4XZSxeoH0RFitkFseNlU9456Vz9EnnXkTBGHvZXLqh5T+sN?=
 =?us-ascii?Q?bxUB1sm4WZYPZjlotLifFE0WyorrTcjyph2phLj2q1MPLYwRLuZh5rZaa+02?=
 =?us-ascii?Q?fAumIjhageqVhZ4HSp8n8/zrDp0fLkAJJOM4v+R57XVz9vpaa4Wo+w696sWt?=
 =?us-ascii?Q?wkScVerRb90nQvJk2aC5u/eQEAq7xzhKpT6mnbYUt2REFkEZSNmx3KKx2lsf?=
 =?us-ascii?Q?Rc5aPjcIRmjiuKyCMSHByCY1eyYj2WzGb4q79TIZKClmrVoIwDT98qCFfuJM?=
 =?us-ascii?Q?Zg8msztc5kKGzBEd8+UqYNdq0KPDLC6mcEY5iOtH+Nfz2zfN3ViICFgwwvaJ?=
 =?us-ascii?Q?lCpAA0BvP8rKC7dGJ683kgPl4JW8LcndrFXKCzU20rei47E5Q73KdGO8sv5h?=
 =?us-ascii?Q?mi5d4urbJph9QzB9Yy0R4sb6f5gwGmufeB0ioHGR2+c94XaWydVV4bJOiOxV?=
 =?us-ascii?Q?LkwoIgKn1kdefDNmtdV+yIZ7Ya2FtnGSpL6gmlu6imG/Lk2YFHFItKyo/wVt?=
 =?us-ascii?Q?rhhn7RFDaYtEbXfD5KRClqhf/WtpzTGYRGW3Xajx0mAwhtnZsYd1+QAimrcF?=
 =?us-ascii?Q?E0HJ8uGu37SfR25xq9JUg3ne2S9RlrdlhNGhVSV1xwFyHinZIF1B4yG3XeFe?=
 =?us-ascii?Q?BIO5vHxs4bpOr1PuC3m7iylG5//iuxJ63mm2OgYwA7e3aF5f2+gZcVYeFMxd?=
 =?us-ascii?Q?bs5jZMkgaI4UiSKd3+0z0QOYzTZ2RHI4nBIrwPRpR8Nf7Jzw383cd46SCN3H?=
 =?us-ascii?Q?UUFzHi4MaRzVMVMjtakeVa6l/sXG9B2JHcrPYFhhCJg6ZRZxtW+dmfF2hqY/?=
 =?us-ascii?Q?JjI9jl2zFHD5c6DpVd5F5GIkBWlo2DeL6982uiD2CxmL3/lWVMnGLJQ3sryY?=
 =?us-ascii?Q?d0l/6dLWo0HLEUeJmQUF3ITwGfM7HYPKYu4kM26hvElTJUko06a4ULmc419v?=
 =?us-ascii?Q?27NGgqNZN4S76RF+jbDHuDASMeQtu4Jy9lTPOkFGHu0EGwnKg76F+bYyhs8s?=
 =?us-ascii?Q?2D6wwqndIh47xX3UmQgZcgn3pVnkDUlX3CQ1ZSE1kmAbTsWvFsw2tWuypRqi?=
 =?us-ascii?Q?kNDvsnMMScEIewQhTcg6FTMHBjHZ5x7aWypW68hU4xGsRyZkDbQp8t3/xt1J?=
 =?us-ascii?Q?o7ilrOy1/4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZwBdZEfZF7TfFA5S69K1wwFNsH5lk60ZBeLss6qutNSuddnT2RHYufgTvJmQ?=
 =?us-ascii?Q?4JOZcwdm3jFvUjqhfJQUI7FZTfRlyicm5xGUFG49uMyzSYQmirkHTDaqvU2w?=
 =?us-ascii?Q?Wq7mWEfCVpeYQyUYDV7wCA2KmdlyydBQ9R9XIjqOHslZ7rl3/2z9V0NnmIOc?=
 =?us-ascii?Q?rk0fJ1HnYq2VD3dzrw5uMr7bgEjAN/poCeQZM6AVXB3UssUvmkYnvTT8QtuJ?=
 =?us-ascii?Q?gRwCexqtN/Jp0PkeLgJz3dC1c8ZE7TTozTAI3IdZ23sZwM/uTA1BI2HLUkqw?=
 =?us-ascii?Q?6NwA3D9xJyk65I3pNgn4nQ37yjUg9EkKoi9ZM51aMNLiiMQLLPGCEA9Gx38/?=
 =?us-ascii?Q?4UmZYLfaRZA2dIhEdzLZGNPRShKvw7BZxrZrYP8DwKcJ3Oegh4/Bki7uJyFt?=
 =?us-ascii?Q?OZVWK7IWMW9G299eRHowxVzpkyiVWNoQNkZScOtUY3FM3Egp3OvGB42rhYaa?=
 =?us-ascii?Q?rIxSvFLzDOJnb4sYsvxGblqBag+nCp2Ze+voR5Glj4FZfBPKxRdH6B9p9AXE?=
 =?us-ascii?Q?wtcIwwr+nHrAsViH1sVyieIaQs5y3g7MPbGoSbbTmvp5pH/vzWVcXyF2RAsN?=
 =?us-ascii?Q?C8XsbZKtxm6cJrojFZ/zejpRGjzQdwbtgxKhRpsDu1jvjSXElz67sXJwPFLH?=
 =?us-ascii?Q?ZcnBfQj11of1CCQurNkhaWWaOoG4aMMEs6uNMyahrCOnECwtkZeAVmPbtosc?=
 =?us-ascii?Q?CjEfQkfgNMkLekBvhmSnO44yBqC7X+kK1Kg4B3PFKjFBeBz9tAiXDeQNbZ4/?=
 =?us-ascii?Q?NsjHFWWuyLcs6XbJVQqLD3Ty80byJAjBJPbYXrhLS/6rvvgswGsgcYAWI/BD?=
 =?us-ascii?Q?kfAXLxzSkaBFq06LIntKkc8Jsch1abmf8v3Hs9bVYw4wrOt+7MLv1JywjK2m?=
 =?us-ascii?Q?jpy81k+FBHXJ4OhpcwbyvuTuqEg7d9LatW/VOPG9aGPMT2CqIOE3vOYokJKX?=
 =?us-ascii?Q?EvuC+GsJ4jh+4+JC/HY60Pz/3oQGKAVztx6SgzrRLq5bFRAB/HDBPZ3SmhKD?=
 =?us-ascii?Q?Rb+V/aP5lzKo88PIhJOBXNpzjS0k/LWCfqveBWFBNyxfbESI/zs3QCHUyM7Z?=
 =?us-ascii?Q?BD0YeR5pVI5yPmSZqK+6eW+BiP1GnGGe06mR9VLGBbOF6X5olphI8VaGVJus?=
 =?us-ascii?Q?kTA2pRraVi3o8vyMK3HFj+S9Jjfi+i3i/JhhgaeGfDX6Z06RTShzfLhb87is?=
 =?us-ascii?Q?XlmsA7nug6aL15aEuxWM5NbQVu4UjwwRxxGENHv0NUGOvS9fWkA36oWXBItL?=
 =?us-ascii?Q?BXRnp2ADrmkhyXL/6/5mscXSjIvgvIlmgQoerxpiYykBKWvcYkEMQCa7R5BH?=
 =?us-ascii?Q?RYSyrRaeB5hOSVAkETGCxkD676wMX5ZE+pYjS/ps+BgNtoGw7H/DQBO8+0Pk?=
 =?us-ascii?Q?3ZIXoir86KqeqPr/M/qmD1b4Hz5MqmdTxu43e70EIMlLvLq2iHPOJWN7W1Z/?=
 =?us-ascii?Q?+oBHyf6HzKqsgEYHQqfK6W9VLw2AOrwg7Zghyf82nYqeGhmfG8406zYze+QM?=
 =?us-ascii?Q?xA+PPG5WjXTDL49/XP83kBsk5FlC8k7q7aAi4rIhdPV+BjDpeltIckL7sT8a?=
 =?us-ascii?Q?UY+fm2B0veCASt6PKFwbCUGIOlAobevqk6UpvBKx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb18e9ca-6153-4929-a4fc-08dda839d189
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:14:03.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhEdRvsBq/H+KHfpPIxAWj5e5j6zhfej4tew0ETsbOxazsPGMWex5tMu+ESMaMRY/biYhgX4a6yjMwQj4xRb/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On Tue, Jun 10, 2025 at 05:51:27PM +0200, Petr Machata wrote:
> Add support for displaying bridge VLAN statistics in `ip stats'.
> Reuse the existing `bridge vlan' display and JSON format:

[...]

> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

