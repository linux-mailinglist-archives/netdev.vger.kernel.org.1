Return-Path: <netdev+bounces-158503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF47A12361
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AB1188C653
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDC2475C7;
	Wed, 15 Jan 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOYxxg7h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4D2475C0
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942510; cv=fail; b=TLeAk+H4MH4hUaNBWBJAA38xYFyOMr7GjPKCoT7ADYfVEZbHIMrh1KD8RUlQLFH4QWAaColXJmDwihnkjUGvxe0cDUNEInaXNi3W/BtjUcgAfhpLo0Z2OGZ4NRX4y2o7oUhVgErqKlyIHOPya2Gq6vmSdCEwEyI+/aWQP+XNm5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942510; c=relaxed/simple;
	bh=zL4dHzNVuedlxi08medBV74Ozp0UrbG/G4PHP0GHj3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mM6NWSMq/o5Vtgjf8MTqCQBU5gwBWnK1KkFF6Q4Ep0ah6B/BiJfwsCkGazGJk6ha4QMDYDjQ/esHuOWfudYZUG60lKUoQDf5iPWQO2P38MiiiElsRfE5SYx9l2kcWQ4guTaAM3JTQeEm0l5k01a+un5wW0Oj5Fzz5fbfw6Ed97I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOYxxg7h; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+vVOoa7+RUVN8Q+8Ej1MqjEbx6cKZe3NkV/fVLCIA6fcFvwP3xMGkzJdCUYhlgGzcbOwWMv+GA2SA6VKXUp8zp7K2Lr4Mz0nZkjsg3hIn62dvj00pfVU4HpSxLyVTGk49XO+mXifZOARQ1dvyKQXc79iaGwrLNFkQQOLdRnCKkfAXhr7eM6PSa5GGTfbxQNxhx/1F8EqJEywsS4aHs3jS7xtd9xX/wi9PrnlGiGLhyH9nRauF/xypO+i/lB3CdsoWyJl0kh2dfFvu6otay9IsOVFCCBH6ALM1nnqx0r4m2fMEhVjTzmy/0b4/Mnt/L8P5Y+q1KLWErbUH27v7YJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VADMxiCoxDRlVlEwykaktsrwF8lOHqRAWNb6dec9h6Y=;
 b=hBbGdCNeDgfNgSxhGnUfmbmrkyAMKBFs4nNT++dKqTp/QAFrCcIOYeVTuNSCdSI4IFJ0gsJUHqD+3NECIoL3V2JbtowN+utz9SFrHX2pRwSiuFp1Mn5/Ppqiu/uUTMAX06ZAfXRg892NdQl4SgPdTYOM8u0WUCFfZ1xWuW+ry2CMf/K5V32fx5AUnN7vT1q6OK6KDGPtyQ1dGOHUp921tLPVFXnuGK4Gz5f/3MvVEWztbhu+Sl64HRTDhKGKtx8TdPpWwyLxSu491AyyGK7muaisN6DwmxKHouonem7S5cQ6QBwXu4sIFcI4KuHG2kI8Zeixh9Lmsw28KdyndB+0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VADMxiCoxDRlVlEwykaktsrwF8lOHqRAWNb6dec9h6Y=;
 b=bOYxxg7huWyDctRjKepiTBKm5NSH8IIVxyYkzRdncAHr40C2A+uZlA7dM+an4+9dYEzBuSuEvMX/HhSKPDYXeEOekQGyUeUu90Esipx0WZl6h6dhD7uH52i5w1fIXTs7ga0HY0z/OL/201l3EyzBycjgDX3RBAigF/QbNYwjAXQq7saInu1FAQs9DweTzU+wIIQmn3jv1Yw9EJacYlBJl0Hz14WqKMs7BHk/PaDP1MYCSwSFKdu5dZcxRjT9fQNjpNPEjUFYxQ6Qmql8pBtMC7p1aG5mBVpV1tdk1/Eka3Rbk4zYo/JgL2mq0x7scw9PWP+7RRp8graqAYOFg72g6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 12:01:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 12:01:46 +0000
Date: Wed, 15 Jan 2025 14:01:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next] gre: Prepare ipgre_open() to .flowi4_tos
 conversion.
Message-ID: <Z4ejnz5FnlVhfWf-@shredder>
References: <6c05a11afdc61530f1a4505147e0909ad51feb15.1736941806.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c05a11afdc61530f1a4505147e0909ad51feb15.1736941806.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P302CA0045.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8a6428-20be-46da-17fa-08dd355c624b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/oPLXbL156plRq4lZlafZ0hb9D6vXffqWCfFcX5dB2PdkAg6ID/3b/aRgakK?=
 =?us-ascii?Q?Qo4U1B/4Fzk7KXleneu+WuVJnpSrJ+Mp6ufXqO3uK3m/Tei0LmDeHss6UnDR?=
 =?us-ascii?Q?/WNyUYJocLfXsPP5DdD0maGpqxgjvIfceL+IiiUwkFAu2CCr9iW6zrNKa1f7?=
 =?us-ascii?Q?7zlG2cOKQbzhQPJFbQzPOwbXBVi50JH9GBOgU9bfS5dv7tO8LtMimbGU51+P?=
 =?us-ascii?Q?9foVgZP8kiGxYseUJD+4UXgZgP08SRtty5cGWr5CQtbgd4SbjD605CIajmoH?=
 =?us-ascii?Q?tUgt4iOarlDsZEz65BKUCEzY9yV2/Ar5WeReF1A3F69QpmxBxsjngr809kHa?=
 =?us-ascii?Q?XLlP1MegtHUxALrBnsz7S9JaXGZ5AvTqlKZY13NFiXfSsdvsJKky+/do/ZiI?=
 =?us-ascii?Q?2RDsSeF6gG/2gcI3t2T6TUqQSXIogCaEXgeJXlHAHyZEOBO0qGfs9vJG5QBI?=
 =?us-ascii?Q?ZkeGWo7nATKx1CR9DfEe6BtR3YH4Wg/JgcBaXfY81M1K1EWfKTVHrAp75C+N?=
 =?us-ascii?Q?S34UACmKPhFh04kSWvx1gKXhbQtYyUnd3Ti+OLyPecMxHkataGtlvR2xExoI?=
 =?us-ascii?Q?wJqNHbOEy7a64Y00lL5M04euKedppNBr4+wjXd4va0m84DnYScj8cbOakJ96?=
 =?us-ascii?Q?3X/TXoRcx8QSdSDg+9Fcw6xjHG6J5r57fyWUuWrNFPFe55qE8m6sSH2EpzXE?=
 =?us-ascii?Q?zzI27sBQMgH0qCgNxgWVOUw+6GGrds711fy6xWQGBsqr5PbF6kNDBbpWiOl9?=
 =?us-ascii?Q?GCclPWZRO4oJXATMz+/nFzAFEuEK1vfqDU6fxvC551xgksvkgfrjwn5SAC7a?=
 =?us-ascii?Q?y8IIqILBpe5wnBbA4mPICnWB9r1wOxmnk6XllPobuznz1/75kVC57VXKWOaG?=
 =?us-ascii?Q?nK4kHMYAvn3uqRjzHDn3xLzxAt2o/pN1Ugxff72dalfjzORhEv13l/C3Sq9H?=
 =?us-ascii?Q?4RoOgi1ax5zHS9AQjR9Gg5rjblxhpTnBPjcIbvtapMETBKptCA42JYwBO0MJ?=
 =?us-ascii?Q?99QKuknXWEeDjkn8OGmYafclCBZl1OTF0XjYx+AaG138xo4uvcdWW0TRCrGZ?=
 =?us-ascii?Q?+Xgyd1yudqOUDfxCKBMLJ5iqsmZXkrh7rqvqEQumYH2I7sTzsgyxZIm8xtSn?=
 =?us-ascii?Q?7vaRHOSuvbJdhydRnD/0qzPw/eVxHpQobcKKpy5rJtKtjPBS9qbm7i2DoYLi?=
 =?us-ascii?Q?agPlm8ZSGysnWP1aMPX63YnHVfu9WS+vFCgD00Jf3vZP/HTII8KlrdB7IVoI?=
 =?us-ascii?Q?1hWBYaYK9AqtRNH/QTy2wy/I5UuZAHmPJSCMDfdB9VQ25O72BEmypkHFqLOl?=
 =?us-ascii?Q?8cupT7QtLPmDx8V2E2srvBTVolW79n/wMyPpfDovdYNP0JoYZIGy58DfFCm6?=
 =?us-ascii?Q?TUu6+vYIrSOExS7NuZkh8R1AY9wY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOL26Q2EfTsqDFTH06nl/F+wHeOMk46qRdF17ceKjGEPOqfhQ3KLvAcNcH9t?=
 =?us-ascii?Q?urFO12awhw7s1e9OSlgqYKqFyT4GuUSGA9qXWdIX6OLJ5ryaFJT8w5o2r/rm?=
 =?us-ascii?Q?zIlgP0TfaB7xXX1nu0oWNQmzHs5w6bPxQ0vnOl1fsJfBovs9LVzAqdQx8tzX?=
 =?us-ascii?Q?GJFCXmWRU7NFVNlSwRPAfXrxbJQOAwBwnrvHlMfpolDgyLM010H5deN/27Ba?=
 =?us-ascii?Q?ngfylsOvIrLpGrfJJm+oYBsdCcATDSXbr72nZyyrKWQ4hvBT5qARxBhjDpZh?=
 =?us-ascii?Q?Ldk9hZGIC1UMZLI9XPNiSFih6Cq3GFL+Q0FYe8E2lNzLLYlZioXgSCP7faMX?=
 =?us-ascii?Q?OcBdkrxiqD7zJMFquykw13DxQUl/0xz8Lu1EaA7MIQHRsFhQiHG2YRLfI+AE?=
 =?us-ascii?Q?ZaiO3hp66bYbaP8aLJMu2KrO6Lcq0KzNwszyzC9ov/V/K7D1DXgOsTq3iRTj?=
 =?us-ascii?Q?lnWMGqXm3SPv3f+P88Xphjg/emUqxNATyXXPAfg4SOcXE6oyERhdrLZrXhlp?=
 =?us-ascii?Q?x0ZQ2MVoIIYTcJ4wvLnQYbwinYiAEu3/Vqak2DdK7Hmj1dSAF1hLrK2YrBTw?=
 =?us-ascii?Q?fnKqGKw7bmLPc3tB61OXZwxiL9XRwVqDy8ebjj6To2T/zAWIVg07ymhz2Ww5?=
 =?us-ascii?Q?0kik5qaUE9Ybbu1AJ112jqQwSU92hnLs3gyT/rAbO/E9gMHXYYU5je5JT6+7?=
 =?us-ascii?Q?z7iFVE+BUH2bAfhY5vFZwQgQJ2trPptmRtM0z6rkZfCV8uLg9+SxCOYP289R?=
 =?us-ascii?Q?+AHygHKb4tpGdnLZhqNdTHrrMviuCIlG07XB/X8d8zTm7sIJSaBNzvPCHnbO?=
 =?us-ascii?Q?BqgC3pgNlMTkqFcVYI/CJqn85RbA975IPtl313acUyIbDusexdhCdRZQzycI?=
 =?us-ascii?Q?MEZwmq21lxxC87b+qKjMpSN6XyRDLRaPAt4g9wy11BBJyg1L9ywsHzu0kg8S?=
 =?us-ascii?Q?GKg9osMvbLy+O7XDj9LL+u0LP6ZBuvADoj2ENANrDPaTGCLJyAeCIPWoBBke?=
 =?us-ascii?Q?XB17cSqrjzxnGuIRXhMhjRy48E/QC/BP0jas7wT89gMuUEinRUB09TpUfln2?=
 =?us-ascii?Q?m4NnB4Bk4DaoVD5xJfBPR2ir5dhJEAch7daZzFvyCeQ5eYsWOaO0UMg7qolE?=
 =?us-ascii?Q?zBOfpmDcj6NBQNfvBevryRu9/n3q9RjucyCRZAuFw11o0eib3QP0O0k4pHGd?=
 =?us-ascii?Q?QN08lDMFFW8qipflleGfB0n6wfRWLL6KcbEA0TbaKaZ2oG970jXSw4aN8sQc?=
 =?us-ascii?Q?fR7dUmwEqi7Hl4PUhBG0gHQz/Pp61Tf6bCJCWUgz7dO30QUUOIY7ucVnz0FP?=
 =?us-ascii?Q?tXJZJzxeEt1bC8xMgX3Y8T5SW1Wv3i7BbxVkIo50/Dku7Me4dUrM7AKmYNo1?=
 =?us-ascii?Q?B+cTWwXPwqHWhjrhl9AxP5PNnEbXBP11gZp0d5xZ1/O3N4d719yiHgncCOll?=
 =?us-ascii?Q?sh0MaSFoIy/mIXcm/kz7eTGub2623fETylgKBlDlJRa2/5VFFF/fkUgzbWo8?=
 =?us-ascii?Q?3WPZOyEehtE6moRU2GMQL5ARcygWMMF/F1pBz0m1g+MeXiB5NApb+9Z51QBd?=
 =?us-ascii?Q?c0n4KFjfgWnE8k50ZOFS5jTmoBbvhMf5o9garjyh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8a6428-20be-46da-17fa-08dd355c624b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 12:01:45.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcM8F7ikFDFgQ0h4NQgHbpBi2RxiO5tbBLQ85O98RH+ooum8i2WCavEeTPCxWOvat742kwmB7TbdAcFmr5vGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

On Wed, Jan 15, 2025 at 12:53:55PM +0100, Guillaume Nault wrote:
> Use ip4h_dscp() to get the tunnel DSCP option as dscp_t, instead of
> manually masking the raw tos field with INET_DSCP_MASK. This will ease
> the conversion of fl4->flowi4_tos to dscp_t, which just becomes a
> matter of dropping the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

