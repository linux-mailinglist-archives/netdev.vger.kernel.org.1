Return-Path: <netdev+bounces-89322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9A8AA08A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73BC1C220CB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED78175564;
	Thu, 18 Apr 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HFnGZJKo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A81171E74
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459486; cv=fail; b=BX6YqadxC0t1uJ+lgB1MULxg1Fx5LCmZaV/0vk+Sdxw58QDdpa/CDFWeHs/+HEadP1u1i1NAcSqor/StUBJ1nlmRG175rPoX77HZB8tJ4j2D8+SEiZZsniYvs/MgDCk1z4juONyBNdg0BzRAjdis09HpuOb739m8wbb2DuJJd6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459486; c=relaxed/simple;
	bh=WaGattLWlTYoWus7ESR42HZclwfPChtGX/XWgmdG0cc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bX6SOpMuy9Y1SRwnS6hI6YN7BqFxHhzU8BH1kMdDcEdtK0jnhLUm6yii1q0kl3YK+mk0iVNGOAzYhBuvGmWszZjeHnthRzICmQDMp0SgFYr5m9XayiYzsVTvAZqiZgcjBGCNkjePcWXbOQ9Vn4a90Qo3Fj/YrmNZkS9ZZf84D0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HFnGZJKo; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOCjiurz8QPVRardwjnqkRDhiJTx4uMweTjolnY0eGpP62c7FJOLLtbVHxxqjgq2953rME5aIhUpVONG6HhRfTE03JvDucB9e00r+ZGxQm7Nu0WxDTpoKFFHzXpH6407+HafIWmCXnw2saZJOGevd9yhTznpaYTxHDlnr+o5LUC6K/8rDkW1XhCONJ82QlXRv1p3jiHzyuxaF02J7tF37Bk64Uvum1FlP9wsn3zyxeOKeI4fEQ9C8hYidCrLszGT4kIBCQHyIfjgBe5+cowt/Px+GMuECuT5LVCe3c6Tovevi4/rTWT5YcB8Sl69L8pt1A/pnpTBO6ujl3fV83ZD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaGattLWlTYoWus7ESR42HZclwfPChtGX/XWgmdG0cc=;
 b=U99WR3DVJg0/tTFY8xya7V3EI/AlpWAv6/FR0HUeJNvuKQZ/E4E2mw5QjjEmKVlYAs/UT7kg2HGVN5fJjYr/zmpjoXdGScvBFibe+0d9/SMVom8AibJPd5kiWHEoIpiAnNsMnN+0b1HxXRSeAqAqWRKF/208uPRI94WuAwie8qfTSHMKq3DohCPzgQlEGVWsIqJF3f2f/fH+ayUkSFl6u7rsy7mVA1+WhA8C5JJhWswVLFpK/ynniXS3a5h4pzXY5k9WVAuFCmX0p8iShSFkrTivNM+f+0ZN1pm4BjlKmulCG9WPx97bFBKfQo7cz0u9vNvGB1SD1eG8qtKj5d5VVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaGattLWlTYoWus7ESR42HZclwfPChtGX/XWgmdG0cc=;
 b=HFnGZJKoFKh/380f1asepeOWqOU4ZPjmttMZ+biO8D3XNRGVKU1zDCNQD+0rwiApg8x+EkeFFpYdvaBD0TBQE1wCPLvHop/qmQwR9rmjUydgZ//BzlmeRexN4wnmrYHfF7unz5NxG4WqUbbXfxZOF/HcbWArFBjx0C3jPXf1CFk5r+aH6nRNPb0asBtSVE4iT8E0wZrX5d3sOfUN8ceO7hdcpmvGISFNJqthbLlciCuYOBb/7laQ4Mz51HttNGTNxwtviBz0kF2P4rA6Qu5lqt8yMW2/qSsmIv6kzXHCkj/LrBKIaPOtQap4XetIEJ5FAiRn4U4hKsRJ5dicVvEKLw==
Received: from BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::14)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 16:58:00 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b4) by BL1P222CA0009.outlook.office365.com
 (2603:10b6:208:2c7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 16:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:57:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:57:34 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:57:28 -0700
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-3-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v4 2/6] selftests: forwarding: move initial
 root check to the beginning
Date: Thu, 18 Apr 2024 18:56:41 +0200
In-Reply-To: <20240418160830.3751846-3-jiri@resnulli.us>
Message-ID: <87le5abocr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: b79a318b-e246-44f6-9961-08dc5fc8b403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WTC+9b7pnCGEEZMaBZ4NULZdu3HjBBN9Kl+01rHXrYHgUwEcYXTUchHs7AU/OFmpWLH+3VZzHZMBSm/tIB/R4TUn6S62sTtslp/gHk1/sKMRQ4zvp6/HOC4a4OQvQNF9IXsO8Zm1GljP9PlZyHYb8gtcxWVcroFIKloz0644g4SWoK1mjK0QYf7A6EpS9eR5E1o4gxB52/uJfND1Qf8C/UZoLh9WLQ4oIkcfc2HRniHH6WWnNE+mtYflL+asL06URf+eEvx8MW1VsQ7F8g533436gmEUQU/YxNrkj1d2mAjpg1JeepKrNGYDDBtS2gigDs1eKB3ZWqDrBGB2KZ2vmqsflViMJ+w4PJRyBq99KWgSegExAFk+C+DDEAPG1VvkOTnkiPfMs+BrAmEXpkHm7kJM4d6sB7DCbjVe+p0rlQlSkENHVhKplrBEkc6Q81LzHHsP6skgwUN6hLgIBqEJXRVTpgydaEg+pLiLcOrm2fpAUD9qhhJkco1ZwhnoATo/b03ICQtbXfKTtMiFhGfmA8+oLVZo/NSJGOfG1l6TcsUhUsa3Z8vilrLxzBdrfF4HpEEBWi5L2PNLDDFjTlXimIkUILTuU7Dt9Kwl0kf0bUw/TPD7/deMXYzy7DkZ4wreW/b2CBWjeSZ35qsD1lGyiZ2K6iGN7+wjomzx7V2FzjAy+P268tPtqxQYMthIJn1qvFGRzLjCESlGbawvujkSep0X5MoeQ7aHCfkS4Kc/WxLg/KuFFXc+THT2/GqivWmT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:57:59.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79a318b-e246-44f6-9961-08dc5fc8b403
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> This check can be done at the very beginning of the script.
> As the follow up patch needs to add early code that needs to be executed
> after the check, move it.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

