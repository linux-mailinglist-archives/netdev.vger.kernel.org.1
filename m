Return-Path: <netdev+bounces-185057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B3A986A1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDFD3B2DC4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527620D4F6;
	Wed, 23 Apr 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSDPzUkZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345A2701A7
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402431; cv=fail; b=RCPxl3T04lSEJwzMEODE/M0ACLhSe57aOUBmhS8eOGLfza8bLuvNXCOq0/uaTS5lgv6etKpftsW7Ir1UsTqWLR+El0kmSw6o2logN+OHafOFsQ2GNlyz4uonl9e/8JnMC8M350Q8ixC0gQDS+Knv/QnyXGviFKiC7HHk9JJBH8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402431; c=relaxed/simple;
	bh=p1Beh2jCBFURjQProu199L0IZrYIldXT/OZqado2EEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NO9Q7zfKOcQIxeHeQBDIaVVP0BxOZX+hKvU/vTOFUrUc5dokBm8indPzs3KNmJ2kPeKFqnB8hZM9pL6zZ8xi91qe2DBC80+oRyTGSlh1MldtIEFtHUJGGiZyxAbvaa4KlHJpMDww5fc8iSol8qMLChXmFZqUS6ZMqXb49cMB3Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSDPzUkZ; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tvy3yuqlLohXIlVB9Fok9pXSSCi+0qTedlJR1ao6gz+2Lo8kokYvz2fF1lB9Xmu9myOpBSOuD8a3Oc5YZtnwaYDsNQzoKMC88IxKZB1UOeYOdBRFjtTQoNJoNvr/xOGe7i2feL6EnXg95xeLko7lqMhjpgwXe0R7LpEaqgDrZn6dGat4XtDFAiyJ/NO0zQtEWjJqlV0zavIXvwQNG5npsRH8JvomhPvsdWjBeTtrSrUM79YjJ+zr5MR2phM6x6rxrqvtcx3rjNBUJ2svGyvdeuNwZoT+oiKNlnhPJtp5iIe+fISKHU9P2G3X4ExMiNCDwKe072TAMaTgN7u4/+tIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2bskSi/friMDg470hm+eCNZ0Gb83EDhOlwu3SKwuTA=;
 b=QpU0ZYUuvWh6f9ZDwBxoG0KFuqXmkfS9yBhOSJsgEgccqqZYbF6ZUKfPSfr6IBR08GbBBXvcjwyx5EIRx20Ybx/rf23JR/dBrZqTviyhk6PnPXSy+DkRJu7VCJCwNjd4aaKoCg1CM+gJjqt29mdJYrQGlWmmB3lLrZ4HQ+owEMVJotP3WoOQ0Iuiuw/QPCooQT4jhTLE3IBHZsvx9sOqZohvDRRZ+jYVaSDQHZMPHpIL+vjlBx92ZlsnbCPTicTGWvN6wW6pkYJdvHOjtiHwOx5yMT28tm4jvUEvVztaIdrn5SY4ai1bsaKIOsJtz3Sq4spYAgR6fqJojXCel1/JVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2bskSi/friMDg470hm+eCNZ0Gb83EDhOlwu3SKwuTA=;
 b=mSDPzUkZwezhgCUBXP4qH1WosxIgMd/9nMDtEBbfHiN8XHMMFclGYr/ls1UAqHMMtCHWDo9i9L6jp8RNGUlKLe3rAdrDFA8g74bwprWwFIVGEETlSKxbgr/o5IxIIm/zwJkbBVVkYg979BqFtnWypx8emJqwxIdQekDoaizIZ9o8AEfV1nmvBD/pvwP5Iy2GTYErw/+M3H5l0Lh+NiYaW/+GfKqL7iBVbrqJxy5gf/xUmdFD5R0L7FgFVASU+bvPAmTm4jDaQPsO6srovSzl95MSol7aInKWQ3lXmb8uz2tfY8IxC9TeerO0YHSSpSdHCeF+TabqD39/U6X5ohT5Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.38; Wed, 23 Apr 2025 10:00:26 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 10:00:25 +0000
Date: Wed, 23 Apr 2025 10:00:01 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, sdf@fomichev.me, 
	almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com, 
	jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <a5uokb5qgp5atz2cakap2idwhepu5uxkmhj43guf5t3abhyu4n@7xaxugulyng2>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-20-kuba@kernel.org>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 94813ddf-5037-42a8-1ab5-08dd824dab5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/ho37P6CkmoUfHAEEwFJaFrkZ8Y43qrVrsOSExvSyaOqbKxYeUGkPlZdFDf?=
 =?us-ascii?Q?TCn5wtRKCmtSjeeGe2M7ekP0R/DYIYr8TRQy+IE9ZIWDJ0dhbPl9JjivJjIL?=
 =?us-ascii?Q?PsfrSSabBAj7iHE+IXVGP3kLtrS6tOK+Q4vhWU1DdDfoiEZQrly5PHrVjW2w?=
 =?us-ascii?Q?UEgka6hB3qp6cIzc2hnME05+V4i2jdCjTYoOJ7uQRqyL/CBl6NBu507M0Wx/?=
 =?us-ascii?Q?FQcJAsuIFrMk1NKuT+7AlyOhzqg1Zime4R/1r8VTI8fQZHLI/zwlxPWlV0VF?=
 =?us-ascii?Q?Cip2IxwKPiAI4E5R1m6lxX9gjC8tOQb2Q1MraWZj904etGYST3n9/C9HAlgI?=
 =?us-ascii?Q?QlRivWYzflFBFJwcReZu4iyfGqubetM1XyCCdA5TsUnxBWIjnQ+gAZZSZ2Um?=
 =?us-ascii?Q?Dtjve99AVQVedCLbFhApDEIDDClJ3mikXR6lChnVbpsIiO4hWwijnQ8vxoSR?=
 =?us-ascii?Q?gvAJTdqRWWAJTEOeuuKAULXPLbezXqdaCv7NbyuybsV6q9xXdZfQnXueF8o8?=
 =?us-ascii?Q?4gQUi0BryTRNWxIsnBp79tkW/e9Ghjy0lFAIfaz+hZqeZx+8kwSHlubsse4b?=
 =?us-ascii?Q?NB0WoVrJ2UrTsjYtLkYBKvd3InQ7WW5QuSPHxF8Zy4CYmS0vnEEBCku5BG21?=
 =?us-ascii?Q?EflV1mMXSrjrwgkjll0/T6PnnXqwbdz+FPSzFO0duKbNG5CzzVRgrqha/Asm?=
 =?us-ascii?Q?v38xUpO/JwAp7DyintndZso5tzimgal3w4MC5kMZdDykUHPV/i6DLJASwUVV?=
 =?us-ascii?Q?8/WIjQaF5yFQoAAuaWlcgycY1E2MrZ2xub/6cTKRJ/xjjtb+AxQ93mxPIDWK?=
 =?us-ascii?Q?IGYAcrx5I/NLr2VIoTYT5tK4IMlJkezKDAroGirli14cTAUcPxY4Ugb+zcrO?=
 =?us-ascii?Q?58nyPtYAz4LeqiCDu21ZRDZiyvlXp4Myddb4kMxjOpqBf8kFWCjchBw4RWR3?=
 =?us-ascii?Q?XTnno/vgWalX4yCpOKpDOKSVsYxvX7XFiAv6EQIFdQRSIr6EVADo/RYPSKJ/?=
 =?us-ascii?Q?X0HOVQ7JZbGzpFRDWe9IFXCF493brTVUmF7CNrdGszcIS8Nc36ZZL6JXdaHM?=
 =?us-ascii?Q?s5p3RhmuB37u+6FqHrll1msQDl0jCk0shsJ+Im6TDh3EAZgKdDHmO5Fsozbr?=
 =?us-ascii?Q?myHyy1N1WOXGEqtXpnpqS+IW1RVexnKzFCqwaWPyWkm3K4Px7AqUH122kAFb?=
 =?us-ascii?Q?PdpKi1eq7Aub1Tz5V1IAlndRhZ8Z0z3/Mp3m0jQ2gEPHG2IsxeULSqJ/YuLS?=
 =?us-ascii?Q?urlaOyRqbJMYUQDemDaWD7GTyr9F3ZNExXJcS5PWGC8YdCPHGfHx3xaWgyHo?=
 =?us-ascii?Q?Ngg5RTt9PyEee1Obb++6GxUq/S7PHO1Ti9ugLAbrXxBr+cuN9t9bP9XvlYNN?=
 =?us-ascii?Q?pooxC9TMH4zTCUtB0qrMKQOQY2tuv6NvKpdmPEekC+ZYEL18tKpoGUdSZGqY?=
 =?us-ascii?Q?gzjFQkEYmWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2ATbPx8McPphDAWBVZrc87VhilrxhCwqtLullKQd3yyNuLgPZ689GmhnwPh?=
 =?us-ascii?Q?E0W5wHWZsCwCUE57kKEDCMRQfZubhxxXysWFalnCEvTa/CYDe4CaS5wnI21h?=
 =?us-ascii?Q?N4qb5ncihXwwcYPgO7MaHEvvr7uS+tXdNbMEu90x6brwF+D40FBDCB09PmZl?=
 =?us-ascii?Q?cvVy5XVCQtXvDfs7lBNfrLcPTpBpdoqe0OL5OxJGwldcXnvKRvv5E5Rz0e1D?=
 =?us-ascii?Q?I8t12BzwiBC4NMM28r+QS1z3/R3nA7XkucICtoMznyI5qaRVPMoG2xM0QQoi?=
 =?us-ascii?Q?WWKzIb5y4mQ9P7UtHoqwsxM/wLNcTUJSRbbyerQV58uTykS5MzyxEzlBwHEF?=
 =?us-ascii?Q?o4FqWN7dw9ydcDj3G8OeOdIb+64PtglDktV9Soc95mJiye4FJV6Q2o2HauCZ?=
 =?us-ascii?Q?UhtmABB6cNg6rpS+ehtgKyQaEJ8D4SSxJM9hilwFW41LzHN6ZPBHKcAI4ZlU?=
 =?us-ascii?Q?Up7ysP2QaWrbXSCekJMQcAqjCI45BE9C0aUlelpV1uiXvJBGcOi7VXx/kurP?=
 =?us-ascii?Q?VHWhoyM+10GNbAH98xCMGxSk2Lw4576U2x2ppTL/i0AmCrJ+uJlxhKPvMWGk?=
 =?us-ascii?Q?0Ls6zG4IeMvLFnNTds4Ku74sDyCWhCDO9t6Rc7Zn+uphC2pYeQRqCenDtCPW?=
 =?us-ascii?Q?QT5rpJfnJJYiBH6jVbL3j8lZARNsqbDEyRVPIRLAVQrqjwc6aYgCkDplAAI6?=
 =?us-ascii?Q?dR1dt7HAeTw/C2o7bdmoJz7uxfrL4lJK4moDckC1eEZWbYqQz38N/YW9XQm5?=
 =?us-ascii?Q?gSvDKp2Lu9n1daGKweoVz28bvlPFnHJY+1LQQY/fBKG02M8w+1/tlsH8qlne?=
 =?us-ascii?Q?c0K8PZLur8RZl8485UGCrf1UP6ifLcMAGcs7/bpHlcHNRC5ngYTZalQzEwBy?=
 =?us-ascii?Q?o1Zfv3BNZUzE2eDVtD25wzUWYKUbW2vlG43Bhkq3wEmF7hcBtdagp7+NrZUD?=
 =?us-ascii?Q?p8Qg1y4Fz0FqBq/ZhE779QFPpw8PFVzwiKwYv5jimKiDbZfbpRMtGoJGx8FY?=
 =?us-ascii?Q?L/G+FcnnvJFCt+f/hq8evlVI6RLTmmvUvoYC2Dxa8/8g3EkuAG3UsMXcagXT?=
 =?us-ascii?Q?ufiJMqf78W2913II3I/3xX33mDBjJ8mRJll84OZQohVMd7nBvkhRmnI1m9MJ?=
 =?us-ascii?Q?9qK8HZCjAG6K9UhsXtWzj/YQCjMm563a1Sd9b1ZFA6EqcrSswzob2cQRrS3s?=
 =?us-ascii?Q?npG2xkKVO1eD73Ski4EaPMYwQSCz81ACtU0Y2NFMxrxEFrY6L0MT/E8Yxabw?=
 =?us-ascii?Q?PGCcfAS3H90yQBTdq8lsKm1QkopExS7NXkiYY4rv3TtKgxYac1KuqPBwx/LY?=
 =?us-ascii?Q?CQGdik+qcS/MltHpStPliRPv6m/hhv56W2yHbwZ6eikLRDa0wonwxXaei+9a?=
 =?us-ascii?Q?nIdnO1AlfOsNAMBYRnGbKq42ls49bywpRzQ4gdBs3H6jmvWE/1u9lr/qudK2?=
 =?us-ascii?Q?w4TwA9qG+ddvDN3Ce5zUSnYkAhiTVqUQrs8nGUb/hxvUpKQl2Ot0388Fa6va?=
 =?us-ascii?Q?ArzjqRWM0Jucx6yJOkp0tbG2qjiMV8visw4Wz36sihTU2nY0RoYvInPmbXJ/?=
 =?us-ascii?Q?hGd9uw147XSVKB4/VcSvPSpzxrwpWsTdBJveNBnw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94813ddf-5037-42a8-1ab5-08dd824dab5f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:00:25.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oeVqhO5tHtMomwrNAY1YT+5PWTILZV6DCzB6ljpm0fCp+cuWOrH4KXK25EKU7lWQTCkYdeMJiayQFSHA/azwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

On Mon, Apr 21, 2025 at 03:28:24PM -0700, Jakub Kicinski wrote:
> Move the rx-buf-len config validation to the queue ops.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ------
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 43497b335329..a772ffaf3e5b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16052,8 +16052,46 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	return 0;
>  }
>  
> +static int
> +bnxt_queue_cfg_validate(struct net_device *dev, int idx,
> +			struct netdev_queue_config *qcfg,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +
> +	/* Older chips need MSS calc so rx_buf_len is not supported,
> +	 * but we don't set queue ops for them so we should never get here.
> +	 */
> +	if (qcfg->rx_buf_len != bp->rx_page_size &&
> +	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> +		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
> +		return -EINVAL;
> +	}
> +
> +	if (!is_power_of_2(qcfg->rx_buf_len)) {
> +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
> +		return -ERANGE;
> +	}
> +	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> +	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
> +		return -ERANGE;
> +	}
> +	return 0;
> +}
> +
HDS off and rx_buf_len > 4K seems to be accepted. Is this inteded?

> +static void
> +bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
> +			struct netdev_queue_config *qcfg)
> +{
> +	qcfg->rx_buf_len	= BNXT_RX_PAGE_SIZE;
> +}
> +
>  static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>  	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
> +
> +	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
> +	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
>  	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
>  	.ndo_queue_mem_free	= bnxt_queue_mem_free,
>  	.ndo_queue_start	= bnxt_queue_start,
> @@ -16061,6 +16099,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>  };
>  
>  static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
> +	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
> +	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
>  };
>  
>  static void bnxt_remove_one(struct pci_dev *pdev)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 956f51449709..8842390f687f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -867,18 +867,6 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
>  		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
>  
> -	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
> -	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> -		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
> -		return -EINVAL;
> -	}
> -	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
> -	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> -	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> -		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
> -		return -ERANGE;
> -	}
> -
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, false, false);
>  
> -- 
> 2.49.0
>

Thanks,
Dragos

