Return-Path: <netdev+bounces-150265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1169E9AA7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E51881706
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC81B4240;
	Mon,  9 Dec 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BWwbWtcc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2635954
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758488; cv=fail; b=f+fSs0CeSnxxf6Wp84Pv0X/lLz3Ru53ypzFDygArE7wLcafOo12XYd9uQuzOLQiMPWOBgiynISM1eLJGKRbNvM+09X5ot1DqL6U6aRMWWimRrOH5rUJqszZKOjSRkuw6lSrv3s7Zroc5uMfcBgjy0vSXD+PjknhZlJyU07xubsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758488; c=relaxed/simple;
	bh=XdGPxu+ktbgIzoaLUAhRmrMPdGWFKCspZcPKkNlTuwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUSLcHmCd5NjYMkkvgAzquE76yfryT1MRmc7Wa0H9vw9H5oFJzBtwiD6q8ZOI+0shnO2m2jmobAwzS11IsbzKwRVtNwqCpHjkW3LR2hjoIoJOTgOFpt5uCHUY+GbpsbXySwvZ0mvu9Tr/FVLYXU8tVL30wG7UDK6U3ElvVC0wS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BWwbWtcc; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIaSN3cPP1tusqxXsuj7VyA5kMgU+KQmRr9KDECrlROor4nra1iHgAqUyuCTF8cATuNknuA43FxMNbCbfoiW4BJz+COWx+ZI9nYGq5H0xLwCWEXxObQEEfWr5vbAAU5ChlpCBaTj8akgMHviVeTHxKuklv23ueKT1jf+G84QsV9qQ69ugqArEXRbdw6STWtzXbFhtK+ULSptzhlvWxNkrAdSga3q4NOSBgAiAE8BX5xcOd0woVc6fUXu1Pt4PSbBDpLtUFpNPUGRaO4eBBkGlo7eCE6W7YnSvpMRrnpM5UxCbAtC//OWmobZBQpYALIB+wlfCu/RRqJKfYVqPvKaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9pJfnf9r9FvZ86sRDO2zV3lowxVScDTZh/mqr9/27o=;
 b=AWfA0Fs/ZcMqk1EvH2ngg7Svwpq1W5qMlPkJ2vS8qbtxLZpC4b9O76D5VKarPMdBmLsYf22Kt5IlguPoECT69UB0udxSXmhLnVLsStzc/RZ/LYKQsiydtIaFrBdmFmGbHhshnbYm2hvsguAlI1hpg2ObFMxdXugXgGMznhbTdwDfsyJfKwUalnNNwxuvaa81k9s7FFNmrWTfVJP5B/KPZu4GQIU4MU0MEbkZnXlykkdo1HyL4Th8w8wtdImTpI26qDFmnT4qLIryI2UN+S0RptVlxALiLAn3Sm8EXEFfqpkB4RFYf9PntdpK2GKokZ+TrA3Z5LpTCxhBhxLNDvhZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9pJfnf9r9FvZ86sRDO2zV3lowxVScDTZh/mqr9/27o=;
 b=BWwbWtccDhZ3UAPU5nRvDbRTI2v3gYPVhsi55rFeCZDD+EGNLLCGrZLeISsls9iPjJ3G8kjT/7gQdeyVYVwIrkimcNhisd4wLf+TnsXv28d75r4J/XfWPrBAP4dgsq1yzHQzotzxfWCSl7xP1Qf+6e9MY3vR/hxSZcdMFkVmIdEv4JD7sNRglWyz7nmi+8u5KFr09AogY1wVDjV0ke9EOK8CP/Z4m6L6BD9AeK4iU1Dts1a0oQSz6Hn5NBI5slPebJOauZvIO35zrdrov+Q4owEd6owHIgPr5eskcPtg5dEnMfTBovVItMCCXC18KIl09O6OAEVgK+hxblbi0PX6Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 15:34:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:34:43 +0000
Date: Mon, 9 Dec 2024 17:34:26 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net] Documentation: networking: Add a caveat to
 nexthop_compat_mode sysctl
Message-ID: <Z1cOAv1Xq1DU-v9a@shredder>
References: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b575e32399ccacd09079b2a218255164535123bd.1733740749.git.petrm@nvidia.com>
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: d9034aaa-0b88-43cd-a95d-08dd186700dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8fzMul9gXwkhKE7F/TnSfuGZGafYaPxu5/VrzZpPZDssEQMjlKXeKEx5IMfD?=
 =?us-ascii?Q?S/pqa++h0gaWgo7aFcH4DAEXbI4CJY/Y9GJ2/cdTZNpI1pT8YiIA4U/h6qx0?=
 =?us-ascii?Q?NKgmYZJhHwfBRtGZCui67Ken2NmzOPttn53EvLp/yd+8aRaaTVtkahmwqztj?=
 =?us-ascii?Q?RID7geAnk9z5ZYs62oSniqzxMj/c3WY+3KG7yuwJX42YLupb13WuxV4AZjHu?=
 =?us-ascii?Q?DAWecvE0hev8SxtC5sLjfKee42bsIoFi2VitYAQ8gzpCAAsDqLOg7xpnVGdn?=
 =?us-ascii?Q?TqNPSvrqJ61GOSmopsqHkzD7sIXF/y1ltHqrPxDa1oTTvx/nTtVRncWqqazy?=
 =?us-ascii?Q?mGk8w2SubOMMBQU2BRsYezuZntYrJFfmYnrsK3TSCL2DelB+1cxTFf/VWNwE?=
 =?us-ascii?Q?x/Bk4tkaHWFVADhMlu1t79RT0y5kWwZUY3s9vHoqGxqDMamEpwc6MLWFG5Fz?=
 =?us-ascii?Q?bQPE1NZmsVgJVA0W/c0K4xryFx/N70vBkKIZx0IAtCL9VvKO1XJ8DyWhdL+2?=
 =?us-ascii?Q?5R603v8zOktT8OGSKNmPT4CO1OxlQXvMlSikv0VhvaPssLJBMB4EZU3+dZMQ?=
 =?us-ascii?Q?XNvMcUN8VHKEmMXu2Sx9yDhLryZ9LOEORGr2aVeGaXaXOHrnWL03gCMZaS7y?=
 =?us-ascii?Q?IyjwFX9XIFbcM1/BSDccJYWmZtTTjdTY76n6TpNmVFiJgwQRzjQtNNby/Zgr?=
 =?us-ascii?Q?JPNa+19brki8W0gG16GMTuMJw02gnAM3UoD0f2uPAb0ZtU0u+Xcjr8xNSU7S?=
 =?us-ascii?Q?RFALBWF4NRRE1HW/pIngs1/maHvMN7G8SLyqII/wKH2COKX7fONs90zRz0ER?=
 =?us-ascii?Q?e/5cg2e6K1eKv+9wVJcE5rxS4/UlXvCkHLTqsedfBTvMVPv4himAhyh0WUzi?=
 =?us-ascii?Q?f89mBshjMbucWRsoIEuGTcwcsbfglD7apgnKi8Rqzxn9IiVx0S0bnN098NCN?=
 =?us-ascii?Q?DzmqwWlO706rm6Fwa5vxmWOmC3JOmgDhCLlKR2Q4QpGpiWwxTQiaq7BroSWN?=
 =?us-ascii?Q?6qxKvJtSGlQ7qVINdu4X1rXrFPv4y8IsDEwL+LWw8WSSNEK5Kjpz/1qhxPvs?=
 =?us-ascii?Q?eduTi+KhGB2jctmIMxIJ072bO1mXGw//hYIT579gLREWSAT7cS+qMJXohKfb?=
 =?us-ascii?Q?nz4pUEi9OKGF9jsqrzVkKYfXachqBl9thgPdz56pnnJhLUhzkruFaPMLsJc/?=
 =?us-ascii?Q?vfc8cOtUbMFynOKTO9uKJA8yOZPom93yowSCsZ0wIFqOU++pIj0hh9Js40Jw?=
 =?us-ascii?Q?xvimCUD0vVJZHeR7/1Tgw7n7GqOXD53E94PtFLiYYy8plgCcNRZI/ZOAlgPp?=
 =?us-ascii?Q?6BqOIiuTyXrE9uUPgg87CKZYVTWeD+q5zpv3MjJBBjkvkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r1vuPAzcwdMqQYNmK37HFJDfuAqdnT1kD9lsQ7evRQzatWgKM8mmJqdUmNwv?=
 =?us-ascii?Q?wMTvSJbXnaS9W6H+qTEKHJytJBbPztGAsW22dDj4DpYnkmWnewSBZd1Li0Qu?=
 =?us-ascii?Q?ubzMEjkg37F7oC4Bd12no3uHpWsc/9Bw2GP7T/Ef1n/tIDB6VT6VtxzGXeyo?=
 =?us-ascii?Q?H5E69zvo+sYghih1dHxAitk0nSpZt1FHpwyEhuKBwA++0JId4ZsxYkaCesS5?=
 =?us-ascii?Q?PR31GU47riMOiTxm/YIvyOq+ZGjFQyD1TNPm6xNkmze79wHnAl0xvB2mWClr?=
 =?us-ascii?Q?yGiJYuUWUDgDgLJ5kMpFwQrOR8bpZZ02TQLvd4xMJ8wtgJ7B6ocZzacNR9db?=
 =?us-ascii?Q?zY4IvzTO7NoImpw4OIt7UyXQL2hHopKMFCUXmMB9lkG2M17i5uH5FR5pU4df?=
 =?us-ascii?Q?018DivnfdRiKevvhYXaQejy/L7+6zHyKh9ci6aF6FywazWhj9zRmUtL0iutk?=
 =?us-ascii?Q?zsVzK0S9z/pf7d/RHuiPzuL/kP28VG+iD8w5W9J5fZixv7vg7cVVNydKddaz?=
 =?us-ascii?Q?LjkRheUV/EH9ZjX4mlWY+XZesF7QJeiYmo7CUjG+xk+d0oWOqU8MqVjCeyBG?=
 =?us-ascii?Q?djbSi2apOgAowfdsL0WMosnnLLHyTF4B2NdXCrvESHgl1ptNtG/BYX2hUWkG?=
 =?us-ascii?Q?ndaiMNc4CYe0Ry3RzT8Qv4uvvb3rj+ucFF3MCOiAJ7MOrXv54ZOzsIruTm6A?=
 =?us-ascii?Q?qXLGgo87GinBYMTcIF2iKQOUxTiJbSm0Q/dlzOgqGWtSErstHv9EDaqzka+8?=
 =?us-ascii?Q?u/ib8GMNT9z71sTgOVn8vpIZ6V2pBJOBKCy3nk8hNhK1l1JG0R5/U7bhIRit?=
 =?us-ascii?Q?v13N7CSCW+0Loamu3X/mNxfqMvbA7OFkZbh2WFCV0p827ekAhnsIkQ4yacG8?=
 =?us-ascii?Q?lMV2aj5dpvOriUJd4dO4tW6gNw/jeoLzn8lW5Qugqur71bTPXLxdhrzwu2b3?=
 =?us-ascii?Q?dVDI0hIsHlVRKqe9/gsVKA9ATMgvWkjpXHzApUOtzKBx+0JlG3t08C1QMNGc?=
 =?us-ascii?Q?KjaDwkhOa+RCrFIxb9QCkBfEOoQsJbHsqMvuGy5oQlUhpadfquRpJsAvzB7B?=
 =?us-ascii?Q?/m3+Uj2lWf2x/MFs3cDvCaEsRe55yuoBOFszD9Dcuhu72WtUXYKPlQvAI36h?=
 =?us-ascii?Q?jbY5zuJYdR1M7Gvj1Yt3G5kIi0fLB2bFdwOFDdv7ONGvNV2+LO+YkYCJooK1?=
 =?us-ascii?Q?Z47P9yYD64LScDuXeAit5ymBuIbSxFoUb0IbUsbzlqnRmbZd6LeyQlyDi8aJ?=
 =?us-ascii?Q?9sZHqm/770Xd+I9B0mG1apf/4gD9RHtY4zDz1kgajeKzsudJv66aj6Z3XqNp?=
 =?us-ascii?Q?CCZQ83pcMokh1KbECPqV0x/CATGSgxl8amYsat3YSsFMPtqsO6FcmirUAYCi?=
 =?us-ascii?Q?CF17X1whxWkx9HAqOs6QA8w/vS3/hZ04NQjShr2GZq2xrDrKNtL5SXXwcMZd?=
 =?us-ascii?Q?avnD8ZVaZr44Wx+HIWSeYJTDQrb0lnAY511KJErpBVETtcKF6savqX7FT2vL?=
 =?us-ascii?Q?YTvEihF8RFyVkhkbSmWVLufXrWPK0c7L0ZC88GtxBD/uXF/5Fgh3gv/3twJN?=
 =?us-ascii?Q?/NsrNRmznaRMZJF21bu85CBEP2BpUicjtSQGsq2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9034aaa-0b88-43cd-a95d-08dd186700dd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:34:43.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+DBJCdGzwTTx9BjfPOee8VInSqW1Of7z5CrseF/frnNQHngd3/dkotqaf1k3KGNEfeAsDsgcemkWt3PdLQdaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

On Mon, Dec 09, 2024 at 12:05:31PM +0100, Petr Machata wrote:
> net.ipv4.nexthop_compat_mode was added when nexthop objects were added to
> provide the view of nexthop objects through the usual lens of the route
> UAPI. As nexthop objects evolved, the information provided through this
> lens became incomplete. For example, details of resilient nexthop groups
> are obviously omitted.
> 
> Now that 16-bit nexthop group weights are a thing, the 8-bit UAPI cannot
> convey the >8-bit weight accurately. Instead of inventing workarounds for
> an obsolete interface, just document the expectations of inaccuracy.
> 
> Fixes: b72a6a7ab957 ("net: nexthop: Increase weight to u16")
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

