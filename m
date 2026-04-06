Return-Path: <netdev+bounces-275637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ETCpMc/V02nUnAcAu9opvQ
	(envelope-from <netdev+bounces-275637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:48:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEB3A4DF1
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1966430143F2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005201EEA3C;
	Mon,  6 Apr 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSrR6wIK"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFC3B7A8
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490506; cv=fail; b=ZtLScvL/vHmveukYrztGHZM4lm/eQU9aX5zN/AUiiHM25KaNsJ4x+0VPsWr/urZr6npv504ulFwA5wCWzHH1+cts/5dJS0etPiNWBrdjVjmE/v33+s61s5/FlPI4vid+z+E+DHDV06nVh04p94bUgWFmK67gtAJcaXXc4oNwIHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490506; c=relaxed/simple;
	bh=4XJaPWD07b50NQ8mEuI4qEaM0HmbvwGGZ2INMINN2UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAe+RwpeBz4MpqfuyrDNpltgCp75kingj6atezrsTHe+HEdecYakpDYFflk+YO2udcbXpuv/usnrgbiuEGEH7tOhOZkOQ1UjcVBDEXujKYkWXMp/LoURpTCrxrUyM7aQJXygGZ3qfEIUN1wiufNbkaX47mvEsh5jLsyxYCTfxtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSrR6wIK; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZuJxs20Bz5muZVoBvLVsjGN5ZLNaKjx6d7/RKtWiIpHy3l+OzYvLt92SUZi9hOzbSzB59sGbi3f9kamQi9dIP6c1XvRo5bxFd6C06iDFSJ9/OksioykbIriBJLxzlf/htJxpEl9kR7m2DUva2alhUsF805ddqd9OHsJrQ5VfbWqYrucn4pU5LxbIUercuX8zhzHX72tn9E4BUghY972itco02IRf+QkAnfS5E7Tv8mT8ZQtkflFCM68i0umKgK7HMhB33sIln3kWJFgxR82GnQts4Dy+0kYpt3NQz+fkNaleRLBytd1dOEq5MpmYP9uLcxnGdRT5nQfRF0rRBZEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3u7zRveHyaXClYluzFnryzePVASDiieXCo6CsxbTm8=;
 b=LiMzn7W2vb9cdsB21DJE8GWFqgp2ODzneMDyUZxKrROk51n4HX1hblwwQ+CJnIefVsKJNMUQRJAeM793YcoWmCPSrL35CKj4qqaMK2QzSrBuCkhTebS1sYHUKzTia3lOdXaQycHsrq/K4ZJIfJmrvDsRQk5AO769hrZPxVItyQgNnWJlk1orKtIilOGloPHQsn9z/qngHEMXKETNlmhI9dTkQo00iHyVBB1ERrmP4COqodKvai7KyXzhc5seUvgD1ftYnkTkjRppZa8eMGY0l5XpxlXrjyE6eBtV6tlZAQcY5MK3JOPhkC0KPB5H6gTvHj6SFrFUG0XngZbBRpxa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3u7zRveHyaXClYluzFnryzePVASDiieXCo6CsxbTm8=;
 b=DSrR6wIK+v3l0A+lxYvZzU0t0J2PelQk4iKxob308dQGDF9IS+68kFqyTU+hz+qdSLtLX8GPClrfcs5XVLN3mjjPNbmW7ZIdU1yyw3y18J9U8CAcrj/21nYJX6ZdfGBw6jTBKb11CcIDjTGxbJWTs036Kr8ivYPOJVsp+yomFiYe1myl7xpMfAhRBhQK42R9pJjjemtDGwwqsEC3HN4KTnQ8ww4RGXxT2LiBZo8GkgWJKeBq6r3I07CLVfGRIMjWpJHmhm2b8ycvsNpx7dOoI0I2+oFgTtc4aFl8YIqP+shdIEjHVWMQTbJ904xrdeB+EW6G84lPwLYuG12G/YXjpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 15:48:20 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 15:48:20 +0000
Date: Mon, 6 Apr 2026 18:48:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@mellanox.com>,
	Jiri Pirko <jiri@resnulli.us>, Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
Message-ID: <20260406154808.GA714138@shredder>
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0dad48-9fe4-4f2c-b1d3-08de93f3ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X5QOOBZc28I0Qc+BBmb5zcpcsvGoKe0kWBOuDF4CAsIhCOloYIfygVycwNUtEowFyA0BC+xCmW0b2DfghUXof8VxRpSj4LL+SgjrIhSV9Umz0hbMegW25xifkCRrGx5KrndBkgw9RoeJZeFpAKElwAYu05AocJp8stHtxDtjOAOKc4x9nfDWiQUgiMI1YartjBOVFS3Sz6wEX6JTt9KUnZ70Qv6ML9yC2RLte15hZ9kRj16uDoyZGjzqCVHaOvx0c41bye8R67AYewwB7/i0cA8qg6e+QPxadK22pWgQ0SnesS9IJ03CwAi6AH0TJ98djoSKMswZ+SSnTyWwDZhkpej/RRLLAQ7fanqVF42zouE/Vbiwt1YPFM6Ocoupq06BArQo8i2SDL6sksYs/FkCP2PpCTN/fU/qaZxDbnjdrsOa9qMXZnV/5TNO5IrNyFukHV9dKbCm+wqYSBdKR9dwotKFfH6/sFbb/00i9MjLnIB+Vtg4xNmi4mnKcCbFr/Hntc137mzFRXPAvFTZ953AevWH7cMMR0IwUPIQjmNYq85BvKIxaQUlPIzjtrBtXef5d1aN39n/hYR779bC0viXjqSrCqUOEXIXB7vjWfl8gqf1I2kTgpMt3BSrq25/PWwLE5cUBo5Aee5WLP74dBnYWakWInO9aIo0JmV1i8hORheZ/4iS5Twk1EO3XjuwilCEfu9XmdlWFZWI+uFgo/yjhZxAy/Fw8/HNpUDZEiLx5G4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHpVMitYPcv38R931LlpwmX9ag3DsxHjkK1F122rjLi92Lc8WAiRlvP9bLiw?=
 =?us-ascii?Q?4TjXMkB2DSx7Tv6eCpszZQ5SAj9DXw9l+VkODeNKwPLNd7335KACR8lKolUw?=
 =?us-ascii?Q?8WqVwT5xwovWL6SxE9Zq4ll2Zp2x7UTe8h69EL+JZ7WWiDKwuFb6JxNIjhxu?=
 =?us-ascii?Q?qy80JUtOUpUPF8b5BoT0YO9yy/guhSlQV8glVjTt+OYnP9/SnyeN72FM34eZ?=
 =?us-ascii?Q?hYh6ucw2nWnRM77S0Cip/LWegRJEtrU0brD+NyF1qjGieNYeIXIXAMwx227z?=
 =?us-ascii?Q?Cv+HbRONxx99wLgwRPFL5aCkVAfRbi9nRjpU0qd0iudna9rgz90ivvQ0JCHq?=
 =?us-ascii?Q?w9Ma8SDnfUyHLqJ/2bwex8K6qEwF+NY25CXcszLBQZUOHHY/4qfaP8bUgAnt?=
 =?us-ascii?Q?lnf1cL8kTsEBQ8yrJQPnZlCvRz7eU4CqV06BR7oM6nhBt/0zy6ZUwS4kP5FK?=
 =?us-ascii?Q?lY0j+9bHFCujjKoIo4SuTtereeV6rpzNlJhsatGYbglKwtQlhyacFzhmPXK7?=
 =?us-ascii?Q?UAXRK2CG/kBa9pw0cNEyVVwieoSQwQQFeUf9wZFQaRCquMWrU/2B+UW5RtTH?=
 =?us-ascii?Q?YyJBQ9jgBWtzzlV9Pu/SP3jm/DjpeJOmPdozxx2hUi1aj3KI09xF/p8OVGWp?=
 =?us-ascii?Q?3o/cgG/w8UKAzpP/KV1zU6xq5W4u/k05/dXhouUyI7K99GqD7ojBnS8TPqNt?=
 =?us-ascii?Q?c7kH+gU2e8TNtVjP7CxBY/4/p5jOcw1emx9OLfj13/bUvWNEBGOJ8rqKCHvX?=
 =?us-ascii?Q?WO0CD7Ech+5LPmJmX++USHwgeUrRHPUOsrabN2AqZUns5JPMiWTgR5pWwdQo?=
 =?us-ascii?Q?cPLa9ccoRams+WtwJkjoOzmISY8HHUMRv1wgByAirKRcYxuqMeiBQ04PTBCu?=
 =?us-ascii?Q?0K5uESc6VinLqu8lKrhiXReAwSWB6o+nCBNcuvlyDw0nQFolBFkc/ID4iy1C?=
 =?us-ascii?Q?Bz33JCbYHoJHVJDNabTosTZzEZPo+ilwAmnC+cROMEXZMMi1vxd/ffLUYIGy?=
 =?us-ascii?Q?RhBeaTYwufjF37E9u22/PMkPcKYhDTZ2804dxL4jXJmNKi9xYCEbH5Ep9+yK?=
 =?us-ascii?Q?dahR7ZjP7k2dQgQEIOMA7nNFk+kctWzDpstSzTOVUJbYoGypyjYZtojwlbAM?=
 =?us-ascii?Q?7h1mQMkEspnEsTcewchda0nM2XJ2i9GKaJVh19tEe3qP7KEPTIOcsnosvTEu?=
 =?us-ascii?Q?5We2QVaFXPigp/X9YMQwjrcM5tTTpwFJItn8EibfOMAT5nwhPBvPA3YUPv+L?=
 =?us-ascii?Q?BMHUib3idr5Ho/5WVjGOGJalCiV/chmIO+F996jF3YGtB+9cAFpDaVKXZImh?=
 =?us-ascii?Q?tRduCsV/4H8twJ0FbaMGGVnYAxfv2+XpEBwV5T1bYwa6au7+nq59uOSqTZZk?=
 =?us-ascii?Q?2gLdhtSQiqqAhrGqckB6bI5AHQxS8sleM1Q1MUfLtAIFvB11zGwD+pVEhm1Z?=
 =?us-ascii?Q?Gznbg8x7p7LvRSSOfVe2GYMarN1pJ1nV5dbkR1l0v/XlojJseKAfYc3hAWSB?=
 =?us-ascii?Q?p8PqkYx4dgmMLDmZjrvyqwfNnUA03bdW5iHioOu2BL2xvZEc2dG6vAaamxa8?=
 =?us-ascii?Q?L3Oaikhfx2Tzh7fNu9Fsr0g4fhapbV7f9WkP0UdAIw+LltoozRnI6Gfv+9+9?=
 =?us-ascii?Q?lxWGXxmKCqwMfhr6bQH99BO/uq/iPUUOfbxpm/iXwAi2mlNmFNzmjDHGGWFe?=
 =?us-ascii?Q?ZPuDUgXgQ3/KQTVJAElzXLVBUzEG5EBiPNNNvYqSrK2QqAFRnmTe6QzErxMG?=
 =?us-ascii?Q?LGTR8RwMLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0dad48-9fe4-4f2c-b1d3-08de93f3ed1a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:48:20.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbb5eDjlYyvO9yYYo7R3OQ4KeT+XviJ4YBJdizhiMBES9JIp34tOQM9fBawqW0Y7QHjHjuJ/YA8FH34XOD0Glg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275637-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,mellanox.com,resnulli.us,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 33EEB3A4DF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 09:28:16PM +0800, Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> l3mdev_fib_table_rcu() assumes that any upper device observed for
> an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
> master->l3mdev_ops unconditionally.
> 
> VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
> switched, so readers can transiently observe a non-L3 upper such as a
> bridge and follow a NULL l3mdev_ops pointer. Require the current upper
> to still be an L3 master before consulting its FIB table.
> 
> Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
> changes in v2:
> - point Fixes to the VRF slave ordering change identified by David Ahern
> - add David Ahern's Reviewed-by trailer
> 
>  net/l3mdev/l3mdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
> index 5432a5f2dfc8..b8a3030cb2c4 100644
> --- a/net/l3mdev/l3mdev.c
> +++ b/net/l3mdev/l3mdev.c
> @@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
>  		const struct net_device *master;
>  
>  		master = netdev_master_upper_dev_get_rcu(_dev);
> -		if (master &&
> +		if (master && netif_is_l3_master(master) &&
>  		    master->l3mdev_ops->l3mdev_fib_table)

Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
If so, please check if I missed more places and include them in v3.

And I think that the part that I was missing earlier is that we don't
have RCU synchronization in the unslaving path, so an RCU reader can
either see the original master, NULL or a new master (e.g., bridge
instead of the original VRF master).

>  			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
>  	}
> -- 
> 2.53.0
> 

