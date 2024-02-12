Return-Path: <netdev+bounces-71005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88758518B1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9F1C21251
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D33D0B4;
	Mon, 12 Feb 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JH6CtQId"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928473D0B3
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754225; cv=fail; b=mT4Ej3wsG+a3SvIbaMK4NcQA2Mjkx1IXrKN+ZtO3O0SKMhrAQis1AFFTUBYTUeN0Z6cKnt/K4vRjU1VG55Wh7Bblba+U/D/L7hh+1ZzOqU8DgVOs+fzpRjrSHrcdm4LCRK26mWNM4M8WepNPYk8ZtBo+O0aXE6oE/vXSDaKfXLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754225; c=relaxed/simple;
	bh=7C7VFfzZn/yxIBmjy1OSLH2q+IDwRJIQA53XBC5fRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iTyrUvXGvLWhEZ4RWa066lKB9QS3yifjG6qpx9LQwHO0ztDeOOUk1bpiiO+JnVVXtE9w0WUMjDYSz+7jeVPAqY471DZYRUn+fEmZul5xy3TLll1dFljduiH0uxSsa0PxJMj9h2r7kadef7yfqjNyFzcfCf5DMvCLo4wMJGwRHWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JH6CtQId; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzstk0S8hpxF04Lh0opCDzqQGZwtq/wJ2Oydatwl0gFrygMguy23ZsuK0NO8cLn42Cr1G3scSduGFU3KXcKpW11QZ5yvGoFZnHM5PS1j4uBfJRhhUxPhQIJmUpxc3OSVmBduEC5EGmZ7hvgX98vq3ZcBWVCAixlte5UV+eRQWUmvRQd3bINPvcUFUItqxSA41fcOhXvVILxJ8oPdS//XnhBXSoFFabIHhmTKBqmp3JxU9fCx06rSixhBXoN5xy7ipjfhTu/MaRwiCJlNcz2eSFhHVKMlw+wDBcK80pvV/sDZxdbVsccVysxFxQ+maMd8ALtOLmy6l3Xx/0wGiKxOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1V+NmJ8G2KpqlElwt9bsvKjnk2MlrNvdnqgBViQLlg0=;
 b=hd4MOy+cklx+HZ/6XwUbhyba3Q8ppsJbBa/+pxGohn9Yo38epELIbc6+W4mQRbU/N0b87c+kFrnuwxVYDRmOK5BDO6qnz+c7HI9FSSomq3N/h/RcnKKzBZQsdt0nk1b3yybc5uP1Y8xmyuIZzP2+cpRe5GMM476doLKKUHKHEk21mQAO4lhiDEwbX6iaeP+ZZFrWiwoEddEtkvGbTIl/J0VkgTxOnoM+vdnp0IAAYbboGAKslFDKOclIXnHicMJsZrTkVzPLDt2D5jp1TolHvpU5zzTKI8jt/tXdTfc0RFXWA38gioTNFj6l3S9Eehp59KvJZVNITBoY/vRSzSnapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1V+NmJ8G2KpqlElwt9bsvKjnk2MlrNvdnqgBViQLlg0=;
 b=JH6CtQIdFgDCYZOI9S6KGQq9zKMkPWqc5Tyw4JHUCFaaJDbBlosENnHKKzy00H36aVrtMhcHrYK5hgoTczhEm9pbPfn0yWmXugbRjon7AgNlQkI1/gxmDT5DQGH5VKcwwsH6YouyXmBfvCDAcDxIxmNZgySeVZZzBfOk10Fu4IvKFHytzwb2yG4dYcLAlnKFGDFMIaLcjUkyemsBojyju4brPXM+UBVtFVN5k2v86fbSenD3VOEyukEeFor4V1ov5elYd7ayrqmRRbCXL5wtpLozBmu+Fq6ujto3rd/8mo8fodjIdrJj8p7J6m/MLSI9MlyK1TYbEF/O7aSSIeqNIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 16:10:20 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a%7]) with mapi id 15.20.7292.012; Mon, 12 Feb 2024
 16:10:20 +0000
Date: Mon, 12 Feb 2024 18:10:16 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/2] rtnetlink: use xarray iterator to
 implement rtnl_dump_ifinfo()
Message-ID: <ZcpC6Gk9fmJrv80V@shredder>
References: <20240211214404.1882191-1-edumazet@google.com>
 <20240211214404.1882191-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211214404.1882191-3-edumazet@google.com>
X-ClientProxiedBy: LO2P265CA0423.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::27) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9680efd8-f600-47bf-b7cd-08dc2be51c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3JTGS6PFc/BCpNx0dRysUizlTDum3y8JGL3Ufh0v3E4XXGQkrFTwlohI9Cym8NzPdLOy0sldM3WZSNpBHp9ht2eEEP73ELITuP1nDON7SsrhRF8Awbf87mPYlnzr6/dq2a+TLf1jTwzxW7raJEeRr0NLwYApcffq7udU9L7She1nZ1WNlnsusApcTKgJtJe9+StXA1fQyMwaz0kaXArTeP6Kdo5jFzBUKFHDyRYkti4k1w+89BFE2GJBG8Et/E8Jhj4ruec8fhJV1UwMAf50WJe/1Y7VKTOa5BfZRwo53rDdRemXKnJskKQ9UVE7j7DQUi02/h0DP95aEQMDY4rnNrHMZGG+KNs26W3zpe4rnJ7sPGKqMVnu+qx1A1y9nCzpB7XJz7lDjxmSPAnmlSvE5QNQUVPnNGusaRgbZqoF6DTSl8FGPaYtP/W3YNTvscm4slohPdiQQhxCp+HW3KaEOogZ17qh3Dyaz0tJqzGr4bFrl1FlgmtmSnPhQl+Gu2KQPtGc+EzCRvP72OVKocd6UCEpwLUHFGtE9qx1JqCfEwQB5jPpjMMwKkEKEIVzr0HyVsi+L2s8ASL5/jsxenb9M1DQoqZ38ZhysVID4tj50z26FCjgaQOvdc6OagW/deXeBvkjiVyiW2F8vVYfzdi2Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33716001)(86362001)(5660300002)(6916009)(66476007)(66946007)(66556008)(8676002)(8936002)(4326008)(4744005)(478600001)(6512007)(966005)(6486002)(6506007)(2906002)(83380400001)(26005)(41300700001)(38100700002)(6666004)(316002)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1M/Lp1wQkIVW+McAREQdAG2jjpsCFd5zx1FvtPU96kZrJtDXQvQr6E4zfLtw?=
 =?us-ascii?Q?LlB3UbvFKG2EoGUR0IpOPckgynyPSEO5E73rS+Tit7diU/XSHT/I0kMsEHQ9?=
 =?us-ascii?Q?GmuhfcHCjgaVFHPqtCdCKKtLlN3dt8CSLsQ3lhoa7Yw9zDK+Tq57Y2ledyAZ?=
 =?us-ascii?Q?MRoejVqvZmXVxNozDH8ITb4j8m1S5H8jkndl+r7kY8KPbo/E2LzWW74XdB2e?=
 =?us-ascii?Q?tH1KBkjnOMC3NUOXTx0xrw0uoG1pTi3Bfg8HJZGjzWo396VaVSZjUKDZU5Pr?=
 =?us-ascii?Q?XEIp/q0ZL3akOLoBZHv8m5XcbeRGJqywmhURJ0HOmlkayowfyD/GtNIWwY2l?=
 =?us-ascii?Q?ewQBlAd0BE3j9p9yTZSfLO4plQnFxjEMe56iQNN/4V3pO1fb3JQvXY/Tu4CA?=
 =?us-ascii?Q?ZcQvgtU6XZm9TNW2FTRlm1nCCy99P86kvlxLICWZVQn7Ys+8RqqfXjsTbAAn?=
 =?us-ascii?Q?XYGlLQ95OcKeQ/dGJfOnZq7IA70igLmlfmaEIxkNrUfFOSJzyYMZzlJZweNv?=
 =?us-ascii?Q?/HyqvGNvrFfDXE0byazpgU5dptFpdnB3gV2JpsOZozGaQvsWX8y0DqXQRVzS?=
 =?us-ascii?Q?ohX7+bBU7p2LE81qfo/bafCvmMqjA+KvuW2MUHAUGYrO79qK/eb/yxxg0j0z?=
 =?us-ascii?Q?JjNAYXgeQ9QCVwVqe8E8+pU3AlSqoQ/1N/mYOXKxEjKQndBX4EZyoNl7JV11?=
 =?us-ascii?Q?wrklmPRQ96cEKPkDbLzCYNfrpWbYpfH/jSymLbeCYXErbaUDK4E/LqfpHFBx?=
 =?us-ascii?Q?p4OJM2rT0rrYigr6XaNKZm76wXhmvbWI1YxQG5HkgZINWToc1NPrKI9AYTz+?=
 =?us-ascii?Q?fSues34/YdwQmKZ1UiUic2RX20QptaQIRvuxhI960fy/ps5knj3xsPgDj8aR?=
 =?us-ascii?Q?RAafS3CLXp3CPuHFgJ7nA4gtIuYm4vB8gy1YCqjJCg03j63NYQNnoSC2TiPm?=
 =?us-ascii?Q?9e7zCuBVYVJO1sfvd6t87zdeeTUAzqYtfq+/SRlqJClzEFeaIpl9kE+Iskrt?=
 =?us-ascii?Q?/mjX/d58DdUh3ujxbNeNIfIEwj0NgusB9tkRQSY8mqio+BjOnqX/DTAfg43M?=
 =?us-ascii?Q?3S6/NsbutbDocE5n5wywTvg4Pbicj9mRmhpix6xCl5YS1y4sDPLaQM3bwtQK?=
 =?us-ascii?Q?QEGUXcJ1GT9ZS2UcK1q5gsAGJCoeWTFkmYw2pGuyov5Z0pNNzgiBf1WILa8y?=
 =?us-ascii?Q?OX2sStsWNIwresx6M9XXrmS1kCBsjvSOAyMyDL18+7M7TngOZlwqNIh+yuzH?=
 =?us-ascii?Q?NlTXn5FG8gqyBLT+BZQa6b1oR0hslK36w6iGIu9XFW1rlazSoNF4ZGrRm1dh?=
 =?us-ascii?Q?zMmfYMy8njptkEQZygWFZosp/xKpab6lqqNbBkNa0zBa37QFheq+x2D/rBx2?=
 =?us-ascii?Q?b5GQD+xCE/PXw3U2qb/DBAlXZGXcqBnFix3JAH7ZOv9yBvp1qBW6axwz07wT?=
 =?us-ascii?Q?7IUEEoy4TD5ZFFcaUh1MuVjMJM3refV6KHVPqF/22vlmxstd85NAVNac96bS?=
 =?us-ascii?Q?Cb3KNHA7StMZ6A8oIImbVHS8ckjeDqGE1jbOP0web7b4THIDZeLsQHxez6cA?=
 =?us-ascii?Q?ivKY1JzhazZoV9G9+NdKq2S+yuYab0jfvOC1Ky6y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9680efd8-f600-47bf-b7cd-08dc2be51c8c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:10:20.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld8+3kRI/L+tG6Hmz8ngZCZjRYHFkMsoSFnKR0SJaQaOeR9WXB/kcKGWmMC0wNYbJvcAzTsCcxTB2xc/ePUN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654

On Sun, Feb 11, 2024 at 09:44:04PM +0000, Eric Dumazet wrote:
> Adopt net->dev_by_index as I did in commit 0e0939c0adf9
> ("net-procfs: use xarray iterator to implement /proc/net/dev")
> 
> This makes sure an existing device is always visible in the dump,
> regardless of concurrent insertions/deletions.
> 
> v2: added suggestions from Jakub Kicinski and Ido Schimmel,
>     thanks for the help !
> 
> Link: https://lore.kernel.org/all/20240209142441.6c56435b@kernel.org/
> Link: https://lore.kernel.org/all/ZckR-XOsULLI9EHc@shredder/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

