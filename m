Return-Path: <netdev+bounces-160838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E97A1BBE2
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA6E188EDFB
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E71DA2F1;
	Fri, 24 Jan 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTUmVx2f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5003182D98;
	Fri, 24 Jan 2025 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742037; cv=fail; b=ifMs4aX7Bj6IfKC5Uh/s+jOhi7KXjR1wN4o5enG8Jtj4eLqzkH+fwAbLKAopLVgMqJoAzEIuM/7iRuy255hMVV9QpYm4j9ZEPNUn6cOoDxZWP80pq9Mg1k4uz00YjW7PYSvt5aAdTW/8JvDAQzIsr1njGPTuz6QcjEO1W1tTyxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742037; c=relaxed/simple;
	bh=U3gZ/pp5qzL0zpwAimKbs+kdcHs15jeh0OPxr20NVW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDqKDsw8yfbZMvFIEvzFPWF3DcZul4clzxK8GL1Iqg9YrNDDA4Ealh/ykygwLKDucjmkle6UNLdRqP4JiNzgS10or4TCdCVrKvlnPH0aU3CIZ6q/4Qo3tZoX4H2MXGZ3bIGfLGpLKgngNU9lp0JSfMXVJni1QSMOV97N4gPr0ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTUmVx2f; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5oakpD0YKROC4X6Mevflt95NzBx3ILuI8+WT6zRZVX1Nil7jo8UIGgQRRlSPJ6XOGuaZG1ojPHXG/GwLwksdI+KZ/3e+6m2bh+vryHs0a3sU8i6owQult6IEonlE6IKHgPjkAw3SghvvqFoXK7iiVIDIbHKaCdrPqLZCOtsxEtYCslul/MRobKxwBLvW6BqvNkjkkJwGxb2qMW1DRFBZDKnDiWIHJzIl/+Y/E++BdJ30SN4vv6fzaJvfqJqShVicGMPEv1d/6tn3H6LY+rO83YrgJHWVPhtokBAeAsZg6eWKBQs2Fw2dv9/2AOSA8BTkkHGFsMgj7YKQ/PvJLRF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZIKadRgRCZ8j2KEemOJkhucOKJrobqQ3XrKgQyDlVU=;
 b=ICZybgWkbb1nDf/yb8YNANQ5l/djL0JKqvDVw3WdFKF+iNbB1UFmQigsh7WrECoFFsKp9Doj91k6f4/fYWWlGy7hn22ClVEXtUiWT7FyUoy834CzXwF86lnfuGjgyqUseRhZqsgzLL7o84DLjLygrvRrfVbOpmYtK/V4lkQmZ+BsPuIF/Dc49VGjE98ImDC1yxX4jNKfA9G6ezc4clRyaJ5NjfLBZcieU9KR4086Pi9g8pPlplxsMwQPI0b3udXpjf6tbGxXkA69/lo1e6zwagiyA4jG1kpuQ5owL1SGjniItPXFx0WMdt6D77RkKXXchdJYFuYIBBtnnziOBusz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZIKadRgRCZ8j2KEemOJkhucOKJrobqQ3XrKgQyDlVU=;
 b=iTUmVx2f4GKnYd2YznAv4aRz1nbaQnfj6LUlVWcim23UV6ps8ktubzdkMg+zApjhFawf35dhGYuHF3GGLYlHWftH/9ygIcqU38BUx7IToA//yrBZVDEmL08886Ay+E6Xb2jTuOi73wi3idRgFLe+KsQI8eUDI0ucax0FM++/QQwrGJOpDvbzOOxIpjrCt4zLldaBXyJVMDFgTqyHPZ8/lKVQ74YgbtCOy6GQlB9R5t5iGduAC1i3QwhnFLauULGjZk46vV1Z3ejTAnN2+fAvzpgG06IlFJsZXyPzWe16oDHEaVh9I9DSK1zCSCRF/WpVUVKwI+aW+MiU+sIXvWO6ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 18:07:13 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 18:07:13 +0000
Date: Fri, 24 Jan 2025 19:07:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z5PWzNYxJAYjbJkv@gpd3>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
 <Z4uwbqAwKvR4_24t@arm.com>
 <Z45i4YT1YRccf4dH@arm.com>
 <20250120094547.202f4718@kernel.org>
 <Z4-AYDvWNaUo-ZQ7@arm.com>
 <20250121074218.52ce108b@kernel.org>
 <Z5AHlDLU6I8zh71D@arm.com>
 <426d4476-e3b4-4a95-84a1-850015651ee6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426d4476-e3b4-4a95-84a1-850015651ee6@kernel.org>
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 1013f45d-d9ae-44c5-3b83-08dd3ca1ed9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxVy73Dam5c+Nmjs3HvARI1y3IAfo3vKXVQ0m5fK4HCrRYfouJZz2wgFaemH?=
 =?us-ascii?Q?D42wnTnZNtHfgtOPgzMvlCiYu5Pql1tYBvl45DrbwxrL8qnoRJtD5nKw0XqF?=
 =?us-ascii?Q?P0gDCFnZVWROKQkx8I8I/UbDOzP6kt4RXQNbT+WEUrzj1VkRJGrehpSL3EKq?=
 =?us-ascii?Q?J1760oFuUpIdcilMJzrDUKRPaDI8OquBEsXXO07AstuX9JcwaDfpF8qsuRAC?=
 =?us-ascii?Q?BOxxJOLzoHOBeWuy49NwUgufcyJe7XLtDiAtmrHN80msL46jatIHlF2hDse0?=
 =?us-ascii?Q?vdkd7eGZ/hgYogZLsu569t3wtjToXsaiXmRLbivjrUDciUncnCOc8K64k6+y?=
 =?us-ascii?Q?E9FIEhm+6psaZbqVNrmgCLp/ERGpDkIWtOkKUAZ6Jl8Z69iopUfuKmIZk4x5?=
 =?us-ascii?Q?7yLPkKeq6NjDAxh0q/mbJ8p5hm+siWiFyeW83nhw9nMpmyenjfu0pT6oQZCV?=
 =?us-ascii?Q?Spwa1g8rqGOnAcahkCxjzoHgl8zxjwN1M/HwOMgG+fgaTUWxRLpY9lbMpAQa?=
 =?us-ascii?Q?Fo9E37erF2U6L7fqsiRFKhaTCKsXdW55ymDtkc3gUe4C49Tm9P5xkb64sFlq?=
 =?us-ascii?Q?a/vnmhB7LQplf6mesDY6aom2k5I+VbYUywgCdHeqv1jS/rebouJBQ3XUls5X?=
 =?us-ascii?Q?U4fLgKGFKZqqHnR5EljOFEseOO3mX57OMIXvr2G0Fqu8X7LuFNn+TSYsb8pC?=
 =?us-ascii?Q?dIDQ94KqGc8Qg9fUyScV/DFNkTdFzVpuPcGILC+RIHWHrcwgkKEWAM1rKW9N?=
 =?us-ascii?Q?1qK7+aZOD6Qv6OX9aKGrfjywpiW/9yVlX46tDkC0FhHiO3XOVd29qaPgi9Li?=
 =?us-ascii?Q?s4ZgwK/xfp87U2GdlPrVg9VQvzeccv0EVx4MwWwNDJhOpzGuInpgdUfBAOEC?=
 =?us-ascii?Q?w8Xw1dG7/ZTi8nb+xGPws+oDEtmif9ZP0XC1W3aeNFaYpIctFErQaqL51kwa?=
 =?us-ascii?Q?00p+A3tCybOh+TJtMz4YZleZeTtBpQHiflfA8iGae/F8upXK9Y4jDhnj0AMt?=
 =?us-ascii?Q?fwaKQGI8HBovcRbhray1jKGnQFsxVnxadMYjYPHlFEPUCtlFmli1pASP0bGn?=
 =?us-ascii?Q?uLhqhxpQoXdJaxnXPqDY2S8BBTnCiAjb+rhsGxa7MLUC4VFd72n71qaLHSM7?=
 =?us-ascii?Q?ZqX/mWDRqXfqShOeSZs/r8fMh3UsnuiwI5BcXraBnfi0H4vNS7hdoNJLm/Vb?=
 =?us-ascii?Q?ZBWfwMntXSerEMRN5q/BsepoolqSjZx8GGhIDgjo23p4QM1gQwByGfjMhMlh?=
 =?us-ascii?Q?Jk6fU1Rx8h7G3GKzHwwt2r55dleG0vs/w3cFa5Elte0LOVnU66FD+U6HfCrk?=
 =?us-ascii?Q?82aJ26cn2bbo1pZWrFNXHBbS6DzRVWRH+XiSD2vWCIuM8XRjpgynx+bc3F55?=
 =?us-ascii?Q?EglDAKhpM3vMgXIDLCusbQ7IEhH8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TH3+cghagZKpDRKZMRyDknk1DLMaFMlE+rmX5NXpCum8s55oWP7k8aBRIRO3?=
 =?us-ascii?Q?PYyvNnkTrc43DuQKGJJzNRE9BVIzcu5I/Xj9TlrP+qawemxhLUZI3NYlQo8U?=
 =?us-ascii?Q?r9TJdo5ofPXC4w5imbJKG26qxxiZEtBqp4LNc0ZOqbZdZTP/lBZBenb0Ss/J?=
 =?us-ascii?Q?LkRl1ztGX8rjkK0nIkl/meqMorQOO/352iW/Wxv250xAk1+D5LIgcW6OgBWF?=
 =?us-ascii?Q?nTeQwiqXMt/7DcQsvBu5/WiWtOPI4IV0QJVKOybiFFKmbGeRttBGuaKzD/en?=
 =?us-ascii?Q?QE+2e1V816cOroDKPaF0Nni9AAwxJXbRg9G2dVHTnqlo4TJGTMukC56Yvf8K?=
 =?us-ascii?Q?CPF2S8xMgMR18EZ37BVr0gIl46ZFVUMZsSeHyrAdiJQV08eyflBZmG0HGQ58?=
 =?us-ascii?Q?cq3/NrENOhgW47RZknHsWk6/wTSWEB6ospMFLmy1z/y8u4xZ0o3G/Cwrrdxb?=
 =?us-ascii?Q?C2VYdxRETOCQQlp2UJJqwk6UATBHHbiuuJLgVXe8G7PN8+XaasdqJ3yb0Vfi?=
 =?us-ascii?Q?al4IIEAh4VBS4hgxNK9uXchSPzTHPvf289MoK337v5Of5CV14qExKJJsehGI?=
 =?us-ascii?Q?bQaVc+tIUp4+fem+5p67MKnDPUV5AviU+e+slZEZKwEsRtJYpE/ykvimJAoc?=
 =?us-ascii?Q?+5rR7ehULIaOgg8b5QjYTcIBoPZmyYKMWrT8nXwCSpE+dcOMCcNqGjM0Kz55?=
 =?us-ascii?Q?sgAGHQmMLeouR8NQ5T1Wi8+okxpTns/Ia0ktaYtxCUoRU2LLdDBi+8RI9SLA?=
 =?us-ascii?Q?AcA3sblgwv9mHuoDINOfNxsz/eaS/AoalG37UNavLyH3Vx/B+JoPdNfPUW/l?=
 =?us-ascii?Q?IqgtujPYhp5fLVAoy6Oen/3sMm42bTpqJG//mJoRrtNqY4D+x8rD1OEMhhuS?=
 =?us-ascii?Q?n5GgTYxZYMbvbJFhv1XlLPUFxfdOV0ymQLSMeB0fUViIFWmD0cOe5WcWRwml?=
 =?us-ascii?Q?gZut+eQWFZ4JwoJZMkOmTu2KVQuqMeHB8I3fIue9pWZAffp2WT+3FT2zkHlC?=
 =?us-ascii?Q?GdqvQc79fCLgcG1J/IZznLTuRTY/4CN2SD295LciN9ASkGIV8T8Hpm86Tu8E?=
 =?us-ascii?Q?NemMdVG8cXT5LfYIKlBh5IieF+FkcSrG0tZfMsrtYErwSZPYfQPOr56QGWH1?=
 =?us-ascii?Q?fCRzGNdLf8utPq7RoJNg3EsvLr5z5GuK1rGF4bAcEW/FU+puzmc7iRzVHQbp?=
 =?us-ascii?Q?iG2EHTUkS1elqYOduVrxwCWJ6Xu4r4MzS9hy8V1ZiS8mt2K3TwQcb5msk7fb?=
 =?us-ascii?Q?f5JgxODbBmCuI4aYE4eeEoEtahBCnXF1v3xTn+x/joLtKXeFlhBSsMQajH6p?=
 =?us-ascii?Q?RSBsZzA01bN8D17hXr75Rm60V3urMvOao3ma5nIOpDgmPiVUwQpMMYF99Y3r?=
 =?us-ascii?Q?Y0nVbEq5raQR1F2kWEnj/bYURYF3oHmCvT2fstRsZZCathHcGxg+V7wXa0b5?=
 =?us-ascii?Q?ulv4df0N5ZUCtuT1Ls8o5oz29yebHCwFwKMWMWWXMi5rem6anPej3AP7+FgP?=
 =?us-ascii?Q?0hc6/mMqwFHqN8t9qLoG/c12pW6QlLK25jWN0V35hsw8thSz+828V7hxZhGa?=
 =?us-ascii?Q?2RFmv+PJujnGacr4AG3N+qNsHrm5p30abPB4AqqN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013f45d-d9ae-44c5-3b83-08dd3ca1ed9f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 18:07:13.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XMZSVPw+DGBoKvL98uOcL09I/2pWHr+a4YgMG7QQ+2LkGH2T2HtC5C9preKS1PgexEI9pqXUbS2vEIBjcihBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

On Thu, Jan 23, 2025 at 06:11:16PM +0100, Matthieu Baerts wrote:
...
> Please note that on our side with MPTCP, I can only reproduce this issue
> locally, but not from our CI on GitHub Actions. The main difference is
> the kernel (6.8 on the CI, 6.12 here) and the fact our CI is launching
> virtme-ng from a VM. The rest should be the same.
> 
> > (after hacking vng to allow x86_64 as non-host architecture).

Ah right, we still don't support `--arch x86_64|amd64`, it's definitely
something we should add.

> 
> Do not hesitate to report this issue + hack on vng's bug tracker :)
> 
>   https://github.com/arighi/virtme-ng/issues/new

Yep, as pointed by Matt, feel free to post your hack there, otherwise I'll
take a look at this.

Thanks,
-Andrea

