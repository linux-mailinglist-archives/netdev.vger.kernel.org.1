Return-Path: <netdev+bounces-230744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF039BEE645
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979A7405A8C
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0825A328;
	Sun, 19 Oct 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CUvEIyN+"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFA916A956
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760881651; cv=fail; b=NigyxnpVOi9eyQ/JWNapXX9lRxF/Uh3GD44Uf0yDiHRMRi6tnlr0X9y3oiHBZZmBLR9FM+KfCVPlrhqG6R9KQ+KowFB6Hb/bWEHceEqKBCTKOIhaB2MpoeKGF7mwPRQnzI9LcOE+FOR1SUslxkSn8qcVA7/mCMRGhnoUbJAtg6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760881651; c=relaxed/simple;
	bh=bIGCXE9BAAYfQaNiV1YgcqL5Oa2n+hvXk/QvUjkJCig=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMHm9uNEOy/TyScZok5fCU0aS7NCiEo81Rj7jWzaI5W8GvUl+V4Gnk+eCjvOtDXeBrS0F1PuYtzT5k0m0TcCkgGBQOQQ+nkCGsfWqv3JFLtfb4MfKgKV3SZyghQ9pV1QBGUWfDdjTUMr/bDriX/3o8H+nwJxUgFmQKUJZUPeBCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CUvEIyN+; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjrfZTVjA8sz+PMNoF++j5eRG/0yakU/lT6xAiMVukwCcO5pa3EhnQMCmfI9CvFHJGcZy+blUhMzKGAoDO0eRvVWBp8sBg3W938eutfMFLNXbVjAzi02Fj02fFU5geMI7/4/mWOgHO5buf+mkh0wLPLa8LFV/VTxd3bD6x2SYu76OtLzKEwIqqZHwmiXwpQtqNhVzaiYTuLFc+gpZ6zqndHcTSV9U24cu+HxxSWYgMLXIqqN4a/PFZ+m64vxPD9seCwpjIJf9AZuS1F8F6otDPZdWZjZXvuziOQ1ZsjuCO7RcD57fmI8Wgkmm0y+bgpdlMmmjtEGd8pBrnJU+fHiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rwRgbXqIW9K75pePEDEcUIJNlwMyDxBUpgdaZH58Dw=;
 b=ZrLLqEyWzaOHWpr1Dzc+hYihCl8S1VGgjoc4J7JRnCIJwcFrd5TL6psvpzUhf9oOmmoH8bX/jLbVT2ODlF+sVFr3jSby+rwwssrcBf4mx+vWbeRbwEIvRi9VLp0lpJX1I5++nJ8GEupcfmQ+T/09hykg4pXkpElPI3V4KD+Duu652S28Td0NontGCPQ6EbvAgovmAJxv/CtmpnXRjcpdxFU2EDQGs2dhq14oiX33BdsfspFnXc3yhi7FKGMKda1S74APf59LgsB3+eIJ1Gni/d7u0YxIXv3O/vRToP02psdcsFJ0vJgnWeZN3pJXQ4AExQPLZwkAZvAPKRprcsG0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rwRgbXqIW9K75pePEDEcUIJNlwMyDxBUpgdaZH58Dw=;
 b=CUvEIyN+UUDVDBpZnxWGgRsEIKnOhWPTrgs9Z382Ncx95R5lO8QHynVZFsUCwKexEfELGIbpIq9sJpIDUXbMoHaPXr5eZv9kCNOrIsAl7mECuwCqfCc5D9d9mZte78N3g6lMQlAKtdmGGJZz+IC5bcjwUPU4kGTqaNAPlF9OWv9h/oTudlfk9XQjdupWKZC4q3pFfHxKtwdPl5Ibmcdgk9BOG1O7P4IlpqK8fiiquVrjm8fClC+Da1NhNH7J1VXJEXNLCgyfl7QuAVMt9/ImH7U2CPjHzB1753i1fRikGWzBHakiBroRjCMD7rknsllssX88nSob5C7lTiMC5uPUZQ==
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 13:47:26 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::90) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Sun,
 19 Oct 2025 13:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Sun, 19 Oct 2025 13:47:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 19 Oct
 2025 06:47:17 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Oct
 2025 06:47:16 -0700
Date: Sun, 19 Oct 2025 16:46:12 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <steffen.klassert@secunet.com>, Chiachang Wang
	<chiachangwang@google.com>
Subject: Re: [PATCH ipsec 4/6] xfrm: call xfrm_dev_state_delete when
 xfrm_state_migrate fails to add the state
Message-ID: <20251019134612.GJ6199@unreal>
References: <cover.1760610268.git.sd@queasysnail.net>
 <6e1c4b4505fa3d822e2e33b681ac4a44bae959ed.1760610268.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e1c4b4505fa3d822e2e33b681ac4a44bae959ed.1760610268.git.sd@queasysnail.net>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a9526c-b2be-4fdc-feb5-08de0f1609a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B3WS3+NSToYJKkvjvPQN+JggkZCUjyRl/gY5b14TgAmoSi/49rujadMc0w7t?=
 =?us-ascii?Q?Y44qwJYt+GVES3HN1ppLSUCq7ctWSAFvq1tGeiUAyan8IuPC8UkdVTspy+fP?=
 =?us-ascii?Q?pq84hnp1pzy88ejhYpBkem6mmdvB0F1f6C4WSfUvIl75wjSlPCNhAihpIn4n?=
 =?us-ascii?Q?cdscOjLFo6Gv9y4ViG+KYnorU1HUIhfeBcxG9xFU/Nh+XQo7D4Qi1hek+XWd?=
 =?us-ascii?Q?pkNUHFl5lTeXzijZn645/nGeF+U1lXgPL/zo6BDOFt2f5rxiJsE9tnZH/HBC?=
 =?us-ascii?Q?q8/CHi1+K41AaAUw2Q//D7/dum8nzoQwckuWhutYRkMpA+TCw1W1XZJDABbv?=
 =?us-ascii?Q?DJW67Dy4rDv/mqD6Ih/4dfyatXMdezPXpNm6PvS46MSGPnAFPEFewgsYoX8O?=
 =?us-ascii?Q?ulpWpj68ZON3137s/dB0BQO0LdCJGCXjaf4dC+/IhPsmp2gP57xtpVNdgwxE?=
 =?us-ascii?Q?G5St65/izs9bvfXIfJiDFrZy5B+1PKaxBMUraT0c9GttdkoYA+Dap3GwkHyo?=
 =?us-ascii?Q?JZZ9NMTt7rOP9Zl5DkbJUdC7NbO1gRbtqeElkF6+XBxzHQ8gAKa6YsujpPIm?=
 =?us-ascii?Q?4IMRe1aO3J3z23sWTFgSnRrtGZwV/2BD2i0bBKr2P/VDDhrIl3AQeq3cZajX?=
 =?us-ascii?Q?a8XNad+O2BvQSkH2Z3SxLepg8oVcnJ89LAhowKTFJRr3c2EP2UsbUfX78u+s?=
 =?us-ascii?Q?IoMrxW3qx7qfarIG3qSxi7oasCBXwzOYyOu1+6ZUYf4d1Qlk87DZWPK8CDsD?=
 =?us-ascii?Q?BJ5VbyWDn0onyz1Fw8Uvhw4VrPjl+sv03sy6HoljUJouwlWK3sDnMF5lIRVc?=
 =?us-ascii?Q?PUMgec/gh2M1VaBFmzyiDOZYDR9uzLMy+iRAsTRsB0ekAYcJReC50GvzIbhA?=
 =?us-ascii?Q?+Gd1BR/jUBB6RHT8HbcI0J7RlRsP+lk1OAK9BI14pud/cGcr6Lwm5Qls9gSU?=
 =?us-ascii?Q?97C4P8FlBEkDonUc1iPfDCqY3055t8rZExFHTGNcVyOZ2//SDQxxdBCt2Q59?=
 =?us-ascii?Q?AYO5NOICsVc3SQFGpdEJMC+umu2JWQYCGZVG6NdBIxIedaZtGexlrM0irJTB?=
 =?us-ascii?Q?tXP9jvaluc73cSNX6g9wygI/PtpkTLcw8B/6qp6fQr1KaqsZPianSBFmkXbs?=
 =?us-ascii?Q?TLk8v59kvyYOFbOCRXkKKTdH3/79mktFbEJa5BmRAQML9CCjnXOzljQnzgWu?=
 =?us-ascii?Q?6l91dbPwV5TcGQuOXNY5O7AskrNZMKs1hIMzM025By1ntfxkJWv5g60+gsU3?=
 =?us-ascii?Q?QmVg0zZAHpcbxYNKhIuVmSg0lG8d/JNyAhx8k9XTjZBCkpv65XwzI45HfpZ3?=
 =?us-ascii?Q?/ZeBT49XgU7meGjxveLCDtglCR5cNCvQ7Tz3+Ygh6GPLpprytZK/5kuyqgkp?=
 =?us-ascii?Q?ilfMO/9OKG1MblfPsCyeE29BUiY/j+LFDytBAbv/d+smW03pbTXeuCpxAjao?=
 =?us-ascii?Q?+rZvEsH6lbLAr/TGBL+g9+9n/zn4Ou5UMKygP9IpEKnZBJcFdOLRwjpBca2V?=
 =?us-ascii?Q?OFtqJkoKh6IkxOS1AJN5Foa/zn96uQDqj1ET1C9tF3vZSXbXmmmOOQ8sFIRZ?=
 =?us-ascii?Q?2pz0Ob6LxeSem/wJ8j4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 13:47:25.6532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a9526c-b2be-4fdc-feb5-08de0f1609a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

On Thu, Oct 16, 2025 at 12:39:15PM +0200, Sabrina Dubroca wrote:
> In case xfrm_state_migrate fails after calling xfrm_dev_state_add, we
> directly release the last reference and destroy the new state, without
> calling xfrm_dev_state_delete (this only happens in
> __xfrm_state_delete, which we're not calling on this path, since the
> state was never added).
> 
> Call xfrm_dev_state_delete on error when an offload configuration was
> provided.
> 
> Fixes: ab244a394c7f ("xfrm: Migrate offload configuration")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_state.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

