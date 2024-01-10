Return-Path: <netdev+bounces-62823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5E829838
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367641F218BF
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23E3FB36;
	Wed, 10 Jan 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuKrUvEW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70454776F
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdj5g94Bb0XrYc0kBhxx+JFTQhrTvWZrOrHmFTL9/MwOWPWWF6qHZGrEyJLCVsj9gpwfXlDo56t5Z+I4wFU02O0Wf9EssrI355iUwpMWArdtd+Mej7/8fLbX0IRgeTCP+2mB/b4ditAAg1LPPS1BA3wuIugY8OmkWoPQ0MSXFeQNLKbNurWVOr6Eo0f56yYoHdEB9yRi6+l3yg0YqWa4h4Jx3ks/Z6mYMFGaIFdp/LwbedidGPC0lPIwpKsEFHTuZ9pMEHdMpVhk9Sox+vXWH3eRoHcGYP1CX1iiaA8Xc5cn830kGQF5UNR+k+5sntH67gbENPaau1PMnayyV/2j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OaJiQA1Fy2clZDCGF4DF2nn23oxhKXN2PwUFH/9e5o=;
 b=YzeLqQk2FJo2n5twTX+g82WcOYHprUPkxYBxczDtgvPh7+W3fZLARMbbRj+hfpR8dsXAs6fwCCGRBsAqtqhPOHsY/hj9nDuayjGzbiBk56wt9YElVd5tGjmXsDJ4n/Rxg9TYrYj9vUlF2ku3KYzpFe4sHBfFmnxKY9Nw3+anGTOw1tgkcAJhItve4CB4pLqf5xc3bQjFKnhVnuJJBVGHq0TXDAEuBX2aVq+HtxhPoHg0y566Gc7AhfXP1+zNgboo7ESRvSUgCI6mdeosYDPtomN3ui5P37FTXuJwHdCCHN9I2gL6myTsFIhPWE/D0h2X5SXygrO3wxwR44/xv7T02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OaJiQA1Fy2clZDCGF4DF2nn23oxhKXN2PwUFH/9e5o=;
 b=cuKrUvEW8LOLQJyv34W0KOL8Sgy0tJTFHz8LNIPE6z+tEMRSvcJ2bqMhvMBkSCK5hq7i9B9XQFpIC505s+A7FEObv90MOduueIkwwb5bAJFkoNWwkhBbEtz61rdwnKrspZMxVAj2Q+CGHdaInXZJDH6Hl2A7Cpzcu+/yzSnSsaojxK0OjetdGXMFd+ot6WxYmoIR2YkNEGqdpRCwoRmr1A+CAKThmT+g7OTIML9FVhJWsXN+/czNsEG7RlZLTmgmnr4SvyxPRkfnt/b25hnIYcTB/mKQvmKC4oLQ/AgbByBG/bgO/uW8kJeNq8T/Kvb2VhOp5Ng865WAfb5otM14QA==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 11:00:56 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::47) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 11:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:00:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:00:35 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 03:00:33 -0800
References: <cover.1704816744.git.aclaudi@redhat.com>
 <f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Andrea Claudi <aclaudi@redhat.com>
CC: <netdev@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>, Stephen Hemminger
	<stephen@networkplumber.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 2/2] treewide: fix typos in various comments
Date: Wed, 10 Jan 2024 11:54:51 +0100
In-Reply-To: <f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
Message-ID: <87ply9o3lc.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: cf008bb5-5414-40d4-6d52-08dc11cb6bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DY4d5797Uz/bcjtVWR7hB/I0v4e/3jsBNw+MMQ9nO9PN2qq0YysXTXpBmhCyJ+GEKTvYb1kv9L8jgEMsLVnUOjWtXGqMF9MqducxWdS78bKg21pYddE+qmzyYDGuzI1D/b+7bcV9H7iUFN1Xw8fDpu8YzX5AGsXKIDjUAh4VO17PCaHDJFxSzL9g+u9iyiPKLo+1KfaFxYycKSxIx5HvB6cpT3jQFNWMJIFV6CcI4yKUmCfMPL4KGfKAMRhiVpB2tVmeVUWBVE5wVj4e2xqIUJHfAehpEdSdHl/n9xN5e4XVbA/diC3M+JiFO/1P2RRq77XY5iNwwBsu8dgs+qhZqQGQ8qGd9LVNOr8dXbF2NPVPh07RV7c2GLhAMdnHXer42hr0F63MMQ22QHJWI7MUfRAhJVxwCVi6GlW0qr7ygajyHuyZkxV1ttRRG/MwChbfRy+XFctrX4pE8qRYTDhd66E5iLS2/LZ/ZY8a4Ht645KGT5bkIGrl5dtujQw2/rp/M8VqU4C4ewdZe19/j9F373qbgbrq5cHn78UXYaZU0M3jj7PacDnqgc3Xx0QZZt/SDdAVr1ECCODCUpH2hDPS2xAn4RXZLv0iKVbIfy0JFKIoC7Y0DH1RKeTRAYSLeVxo1NM6AJd3raw4zK2BWKe2K7zN+Pak6lNGzhdX+mdhqTzutxXdaRbPCZP0fowAgyWjeZ2yc2cCZcN1iCS4SKLW0VU1x++FiAd5Vny7guhgv0l0VKzeAt55gUF0JXwurBdAvJWdEGnMVnxkPK64kdCdLq6ITqBB6kbXj1p2kgtK2dY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(70206006)(41300700001)(70586007)(86362001)(36756003)(356005)(7636003)(82740400003)(5660300002)(36860700001)(47076005)(16526019)(426003)(26005)(2616005)(336012)(966005)(2906002)(6916009)(316002)(478600001)(6666004)(54906003)(8936002)(8676002)(4326008)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:00:56.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf008bb5-5414-40d4-6d52-08dc11cb6bef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953


Andrea Claudi <aclaudi@redhat.com> writes:

> Fix various typos and spelling errors in some iproute2 comments.
>
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> diff --git a/include/bpf_api.h b/include/bpf_api.h
> index 5887d3a8..287f96b6 100644
> --- a/include/bpf_api.h
> +++ b/include/bpf_api.h
> @@ -253,7 +253,7 @@ static int BPF_FUNC(skb_set_tunnel_opt, struct __sk_buff *skb,
>  # define memmove(d, s, n)	__builtin_memmove((d), (s), (n))
>  #endif
>  
> -/* FIXME: __builtin_memcmp() is not yet fully useable unless llvm bug
> +/* FIXME: __builtin_memcmp() is not yet fully usable unless llvm bug
>   * https://llvm.org/bugs/show_bug.cgi?id=26218 gets resolved. Also
>   * this one would generate a reloc entry (non-map), otherwise.
>   */

BTW, I wouldn't spell it "useable" myself, but I think it is not
incorrect.

