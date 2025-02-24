Return-Path: <netdev+bounces-169073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF6A427E5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082CC188F019
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E725485D;
	Mon, 24 Feb 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXV3H5UD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEBD26136F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414498; cv=fail; b=fGGnvm7zJIqWw4Lt1FacNPdSQj1DhHSUgel7jd5RiiZqNx0mP1Q/BRPxD/DfJDIGHhVrgK6gAgVoSZSy+g2Q/IUSNbthgpvUXPoFX84dlTeUY78QDQYYoRDRIHsySMDpsiuroa2NlTXPW048kynICtFI5ygn3lbArk7HLpCWgz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414498; c=relaxed/simple;
	bh=pd8fSGoNDE98eszYKVZK4ONKCF8xji59WYQsxjtFeWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ox0Vd4+6Hvlm48fZbJ50OfNi60IkFtsCy43WthcnJ5kLhhVNA7/EJTgSZFuPH23a9O5UMmwKUO8UwRcSdH1ahwKMmfPpJrUEakhMJ4F0vH0KRfM+Bdv1Be69caiDUH6qUOfh+J8OEi1uJQUMKD7vCJBSESaQ0oHuIKgA8Ss88as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXV3H5UD; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBuq2FZUTlk0ZKNaWA6+VN5GdktAIYfATEhrgz74SyLp4qbRKEb9Z2RwzHM4j4qyYF8llYzuXPnvkhOK+/bUewlMVQsLGHCDFQsYJkk6zUVELu792y8PSQvNK7rqjlLGSe2NAHW4SVoRUqY1Sc9gz3rrbQpL1yylYOv7+0S9wRlOnOBrY86+rCwWHXL25M8HbI4lQwhDCHvb+35IFb7S1AXF4jcwvp7DIPmG2x6thfblDIC/XXzk3X0oNhEkAwWWZzntIRWk0iXUwgXoBjn3CXNWcBHas8/szm5vA+INCB9ULAvvG4NK61mP+2tSMYrfcU2DzGBhaMXz+WktQ99YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhKr3hBorEl5kBzWizWks2nB9ah+ndcZYMEhCuxdZCM=;
 b=SSuqo0CnIP5FJVtAKmYDMui5CPXkawPB9Ww4v5gz1sE8dwGXlRnU+w8y+s+3LRLdgk0O0bSEhYpVZjnZCOggchN/vhH+sY2OwByQ/tIWcVL7XFOFpJvVVDZq0UGmXoLDmDARryBnfP+o7NkZ2ewCU88RlGrtVhn7HC0gVgznk9jMOukijG2HPBUcnVTwHj/agls+aGvgUSVqvvhLatzOWBuFDGp7E2L3ELaKRp/ay9yRxtG2tZYOc1MQ7Qu4EynKpPcJmhV9GjTXFVjwBzVeM3IlY6Uo0JyN1ASgpJo8hlJ9BxIxOSetjH47unKpXQqMjDJmAvxc1BQrc13Ai8YyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhKr3hBorEl5kBzWizWks2nB9ah+ndcZYMEhCuxdZCM=;
 b=SXV3H5UDBu9z3xjU5aQFa6YbiiVrUe36zeJByaOy9xJ669fkZNkgFXEZbSirP9YNe+R+CattMDjcBDnHdOknSH+zauE5s+A2GErNEBh4K17sWB9UQtylOBvIxaux+zZFW6W22/gGoUnC2vR4GTVUQ/wlwDXNV4WYdza1L1ds7zCrRkhw+BKC6CESXbAzz/TTsU9t/9gHUWGyVA6xwhg/TINiVTL8M6WOpymAZ2OB35b9YHwM3Zgh/PU+vS/px7wshnwyMMVlIow3TJ8EKuf7H1VjRaXajP1mLl5tei5AVU4sd85jLcioF6l5ASzO/NhZMwDUVaPvPYdN4i/KHIDjQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Mon, 24 Feb 2025 16:28:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 16:28:07 +0000
Date: Mon, 24 Feb 2025 18:27:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
	gnault@redhat.com
Subject: Re: [PATCH iproute2-next 5/5] iprule: Add DSCP mask support
Message-ID: <Z7yeDXAK26NOEue4@shredder>
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-6-idosch@nvidia.com>
 <87jz9fjt6o.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz9fjt6o.fsf@nvidia.com>
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: c9450e55-38e2-4fb2-2dfe-08dd54f0388a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kkjmy0o8kBaw7eGjg83lzO5v984bFpRSn2eeyX6V+o56Vy2nIBfD6kuN520?=
 =?us-ascii?Q?k991ScQBMSMMO479RBOigEa4qLf6BC5ltxscsPgyXF7OoQZHmXrEu6UUxJTl?=
 =?us-ascii?Q?ARpN+ccID+5mK3EmH+nQIPqgMzoUGm5rGKMaE4zCkd32CCKMNJuFFK16dazO?=
 =?us-ascii?Q?IQg6RGzsEQeVaGffhgX/vhRROGVgSTwWO71QDmy2/fKbsHikJ/X3iBmWPuN9?=
 =?us-ascii?Q?1uPnIbxyDPGh+ZteqMSLab75vKABrmMtC/+IZrlPKiQigJ8xgFXLjUOU/0AC?=
 =?us-ascii?Q?zgtoZDePCVTCzdo95xGbjlHToa5/57/cHl9NhuYen1H+OrNc1muWAwEAYKSQ?=
 =?us-ascii?Q?3k2HkOs+R4+qj3Y6mAF/5MYWdWROBjzN22sm22b5AGO1jQT31QLz116oiGpi?=
 =?us-ascii?Q?Xyv/nXCc++jlOQwIxL7oIpnrt71y2IC29i318zC2l8+rlKo9UsQj2GB+BRRr?=
 =?us-ascii?Q?wElAV3c/YO38nuy1eHuFGL+TaxHGt9MvRPWpvMuAHjHlmY3+yyv6SZ8gu8ay?=
 =?us-ascii?Q?bur8/MPOGFo1ByQdO5xNdWmPFLtNMJ6DnSS3gVHcIpw9u/UMzzjxIvpwbsUP?=
 =?us-ascii?Q?Yqi0hmY7osoMYWtFvEQzaOl37RhncCcFVoG2ZwVdluJaHFy0nx9Uzu+0pSZy?=
 =?us-ascii?Q?YTH1gxRsuI2N1OM7fQRfn1MDzt4uo9Uia9G/nFT2QG4vocTmfV9SATerIkZk?=
 =?us-ascii?Q?A7KahwYkxkLARKFZRSoxwOWkQmop3SQwQBluXR1gp/oX0nAgw9U6HTxFPLrA?=
 =?us-ascii?Q?fIJQ+TEOSCHwURhjQwrBwu/Ltbwrdn8smfeJaxn8lXmMau0oL1x/5g6DjESw?=
 =?us-ascii?Q?3UC88Ce7p7Kd0R8aPFC3X1gZVYDdqOe02Tp+am2nahxik88z+nU78FOk11qR?=
 =?us-ascii?Q?ENGf4DU0sYMMvaCMBamyUnlItvU5h+1gPZbwRgbkCDWJMTewYjgVJZO33lJu?=
 =?us-ascii?Q?rS8nsos0dHVlPpY/U5z5Rg15ZPIeg3O3gw6MKhUVxJqY2rI8GnArY2aPIfvD?=
 =?us-ascii?Q?5AFY4p5VxuR1oI+TmTI9anmbc2XOfYbbDIob5vj2pGyqHIdKMihGfpRERIDY?=
 =?us-ascii?Q?jpfvW9mo4C3shnp4xvYa3uftfwFrStlg/NxzSupMN0DnNo8qMJKxhZGx6qIr?=
 =?us-ascii?Q?jlEURIVYbZbUNgVNVFYIl1QdVcxK0Txs8xTebvCldfAOGnu4JZy1joAoN3yU?=
 =?us-ascii?Q?ccLmF/WNfxuYa9EZcnFEVJlWUi5ru+nCdZk+zepRdzTcJlmTa7ZtNAuk/221?=
 =?us-ascii?Q?O5SX/K2o5+g4oX4mfLNeewDz4o6GrL/3H3b8sPpjvSWYQ3VEhtEZraHb71Cc?=
 =?us-ascii?Q?mCq1Xm/o5fkhuM4omb2mC6e1zuNyyzM15wOfQmVS6ZemfhCAmSbwQ4k6Pjen?=
 =?us-ascii?Q?9ifC/rsZZjWeEIPPNEmq3XRDQzz3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jli0VbWmu8IIrVvVZ8/J3bZhPwYqvD1gLJTL1I1xrYo9D2NS7CotBmvWtZbp?=
 =?us-ascii?Q?QoxgvNQjJs5YSaCH7YbNQtot3X9Qk98HDe6zkZaLUNIuIxLIXTtJPCkmm869?=
 =?us-ascii?Q?Wz4AbCMDdT3VNaHzSgihDaiV54C3863QwMFGJglH3+S00XN+1VeHcFkZBW/G?=
 =?us-ascii?Q?1T8OJB3aS485vv0hB2nL5/zO50PxRR6nKMsxnQYs3lfN2VQ7V/L04ulUz+P+?=
 =?us-ascii?Q?bD/fLiIbHbfDCnFdzxg+UUBEOebhBfG1CMN4fhkPyriu6x9luBcLz6RINRI3?=
 =?us-ascii?Q?RL045OUWkSomPU1IJZXZTaLW+wD4JJH/l4ftrwAFWX3gbA1r1wEcmLid/mlS?=
 =?us-ascii?Q?ZuJ/R+pci3cucGTYxN2Tg8s2cXhQmbY1y6A7daf19sh0AtUatidStTisavBD?=
 =?us-ascii?Q?oAymK+p3QYPkKbII8TXvJmGwXeOUqqi5jXSEHnuZhlXvZ7A1pgidHmq7hQ3a?=
 =?us-ascii?Q?F/2QXimkeYOzz3xEAcgXKyb2DkFunOkD6UpKpu34Eaqjju37UoS5k6Njk5RC?=
 =?us-ascii?Q?N9imE/Kc/qhBkJnQW1d4izxPO8sBTLH4zOP39B9man6BtkMevpx5uK7Sd8lm?=
 =?us-ascii?Q?AHQQAaguTSFZJCVAsq3kNULhSXXjejUofys3voffSLLTo1JicjZXTvs4RgcQ?=
 =?us-ascii?Q?Z7bSgssYDzhsJGU4omMAQCYgcCMeiIcpiUalGI6LlU4fmTki5gV6u74niXYR?=
 =?us-ascii?Q?hoQmYznpUWEWb1/LXSMJZ1IaC5LYJwPdPikF3bkNq/hYWkcAPqv6aH//1AP8?=
 =?us-ascii?Q?WKjiestFpWUtlxhd8e3l9fMJDL4r4AKPG2l8XGfGPxYNmt2Dd0bxUWag+kFr?=
 =?us-ascii?Q?yUCVdc2VEyUEWPhuLGk7oZny1cI+5fFa3W6y8lHjmoHkxLJB4K6qW0nFwPGp?=
 =?us-ascii?Q?1Oy2ju52fW+A8g9MbCP6LSQ1Pw58uqKkFLT0Trt+dqQqbGeH1lAg5WIoaQ3T?=
 =?us-ascii?Q?fNPDwBhYbhH/2+aOTKDc65UUAYFAYIkO+I5GR8+iYo+r3TNz551J2JOLqdtI?=
 =?us-ascii?Q?ho1BUF9ALwRAVlBtF6s7zLfxiAswQilBfFjK4S53W5Axmq2AlinNGo9cvoiL?=
 =?us-ascii?Q?UZCO83lzbTWvJ7vQTQh/gw59zOQI8xwDt9HhOQ+RkfLhMCQrksbtUXYniXRf?=
 =?us-ascii?Q?MGfFIBpLZSB9TmrzcwI3FG82naNCpPjKZA64lnYo8lObrnhqU96zyRtr+2zm?=
 =?us-ascii?Q?Xog9vPUBrlTozB7xPzcoybd6U2RDjbQ572cooCGW2UOoj+mubQjX/8bvj3pK?=
 =?us-ascii?Q?hmhs1khYFvaTWZDmevefNt9CroU3OEWET1GOp2hFDZpL/BaCSLeEtS+zKS5l?=
 =?us-ascii?Q?hTwmhQL5LtruD8F78SiAoWWoLn425JkrYtN17aNIxn7fJ5vRpft0BEEkJDPi?=
 =?us-ascii?Q?k2UZsM7y9buQmnNFluYrNpC+Kpvhc10Sr7ll20uyKMnoKegrR+Xdl2YobLDo?=
 =?us-ascii?Q?3914kp/ZJ9WKe6biK10O7xn5/nYeJvWlwVPsbcVtluAZ7iAilLFfwDvSGnvm?=
 =?us-ascii?Q?bhiISR7fUhjg4wVZHIrwhAtkqvNuvfj8DHHpoOp4p+wVmEi6aSagKVGJYFb3?=
 =?us-ascii?Q?1DJ4122+lfBC0AOGvaoM8hJtv6xG6wiTS+6qIUti?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9450e55-38e2-4fb2-2dfe-08dd54f0388a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:28:07.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xx2JIC9fQLqccd2378trqoNqJzgD5T3fbvRRVpYlkFTt/i96gIuh3SPhaPbcFq4fdJrRPH0dBSjLOSWDi23yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

On Mon, Feb 24, 2025 at 03:35:51PM +0100, Petr Machata wrote:
> 
> Ido Schimmel <idosch@nvidia.com> writes:
> 
> > Add DSCP mask support, allowing users to specify a DSCP value with an
> > optional mask. Example:
> >
> >  # ip rule add dscp 1 table 100
> >  # ip rule add dscp 0x02/0x3f table 200
> >  # ip rule add dscp AF42/0x3f table 300
> >  # ip rule add dscp 0x10/0x30 table 400
> >
> > In non-JSON output, the DSCP mask is not printed in case of exact match
> > and the DSCP value is printed in hexadecimal format in case of inexact
> > match:
> >
> >  $ ip rule show
> >  0:      from all lookup local
> >  32762:  from all lookup 400 dscp 0x10/0x30
> >  32763:  from all lookup 300 dscp AF42
> >  32764:  from all lookup 200 dscp 2
> >  32765:  from all lookup 100 dscp 1
> >  32766:  from all lookup main
> >  32767:  from all lookup default
> >
> > Dump can be filtered by DSCP value and mask:
> >
> >  $ ip rule show dscp 1
> >  32765:  from all lookup 100 dscp 1
> >  $ ip rule show dscp AF42
> >  32763:  from all lookup 300 dscp AF42
> >  $ ip rule show dscp 0x10/0x30
> >  32762:  from all lookup 400 dscp 0x10/0x30
> >
> > In JSON output, the DSCP mask is printed as an hexadecimal string to be
> > consistent with other masks. The DSCP value is printed as an integer in
> > order not to break existing scripts:
> >
> >  $ ip -j -p -N rule show dscp 0x10/0x30
> >  [ {
> >          "priority": 32762,
> >          "src": "all",
> >          "table": "400",
> >          "dscp": "16",
> >          "dscp_mask": "0x30"
> >      } ]
> >
> > The mask attribute is only sent to the kernel in case of inexact match
> > so that iproute2 will continue working with kernels that do not support
> > the attribute.
> >
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> 
> > @@ -552,8 +560,24 @@ int print_rule(struct nlmsghdr *n, void *arg)
> >  	if (tb[FRA_DSCP]) {
> >  		__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
> >  
> > -		print_string(PRINT_ANY, "dscp", " dscp %s",
> > -			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
> 
> Hm, this should have been an integer under -N. Too late for that :-/

I assume you mean 16 vs "16" in the last example? It is a deliberate
decision:

https://lore.kernel.org/netdev/d3cd276a-b3b0-4ccc-9b51-dbedd841d7af@kernel.org/

