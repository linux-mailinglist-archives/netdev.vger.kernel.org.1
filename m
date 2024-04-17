Return-Path: <netdev+bounces-88607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233C8A7E83
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EBC1F21AAB
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D887D07E;
	Wed, 17 Apr 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQ98hHKR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44F1EB40
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343390; cv=fail; b=RD2Fvwy/L0LAYssp41V1Ezrmyhr1QHb1HMqsh0wsVk3a1LtT9zRTi+z1N1fPFbbJwl1LpBRjha/OL78Q4ifQEJb7JnvC4vKC4TcFnNUJDV9VK/Y8aIi4YfkLwW9sdOBxmJYtj9ZYCNQbTBGfBzr5MshVgFi5zg+0nOQ80D4SloQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343390; c=relaxed/simple;
	bh=6jBE/ndd8MpLzalyjj/Uheu81QBCEjsA9hZQPhjbOYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/i6h+DQgoTMkXrKYwwVbPk2e6OinZ2tB5ZkvinXvwZ+RGj9zHQBdB+AchW4UrZYKSs/cRoRZ9GVH/myfI9wOXV4hmBNB/OBJo26hbGw2akSKBoloAOwBEcwMg0CY/K4XFN7laOaRto3ciykTAC50FBx2a2Du1BGfhAPucC/L9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQ98hHKR; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG9S/hAz9WIS9ldbn8staYUCwS9rPovDO+rObyMOLrzEX3s7e6xTtwfz0f1BdIG9YMYvFhu5Si0X1aWvZL8DNAgS5rRZDWcGH+ybIORrryEUpFfWq5Ho5TcJctyvgaggOhhZRe961GlV2LGvjQ74HDTajg8DaGhvjj1qFfS+juIvsXk43uuCgmOP20+fNfath0OwcQB/rjFVVMYmq7k+bHJecc0SZtabrf3j4pxViVY2ZrNO1kKQTUKfSJbVrCnj60BH6gvTRcEIlHnZIJNxJC9IeUbL/9nM/6YHdAu5xLRA6HzpcC0B/ntBF3PRWDN76dpvk8cEWcpsfROowDU6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jBE/ndd8MpLzalyjj/Uheu81QBCEjsA9hZQPhjbOYQ=;
 b=ajH6g15Y+WiOvnXaNn9pzTmkX9MFwvp6MwnIeg7ynCOhYgUjWLMBYhwFs8z88z/vl33A0q2xcetQK4e76MzcoBC9pleELGF3bYAZrcp3HZIWmsBq+2oqrz0I7EXwLL1HMQCzvoAJTiO0E3O5KDkClzteFZADcCr0Abo2qZ67SQ2OAscLbc/oQb6MtVTsceH9kju0B0+/EcBH7qqY9o5LFNg9efLBQ9kWwUJ/gP9gE3xAM1oe5fuBWffmxCOUxD3Jk97rv3TIKyVDI09ehnT71KMPoc/CSt0oqh5VWog8m6LNcZYVosiSOGRUNmSeLvKWi1ohw1hLYjPqDm9c93YYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jBE/ndd8MpLzalyjj/Uheu81QBCEjsA9hZQPhjbOYQ=;
 b=PQ98hHKRgBFTm+bet2PN0vmk1x0Q4wZ1NkxPwaHo18zxCzhy9JcmjK1UCxLeonTt7doncXTKpKPmLh4XdQ1YpEKPCip/9GZXNBx3vbeCUKR1dT25vgv27EWoelqqAkxfwLulXqkyvBHHBVrrEROXQEjspzo/erzez91T/DdBt7ktvpbx7o+6rbdoaLSB5GSzkruVu8N/3PjjjQECgt1evNMJnuTMaVq9+6go9an0g/bp3rT9iD2TjKNrzir7sTuYbV06p/zX1EZnw6y2vdMIufPRbTuvbGxIjhzbbfrem9kXpQ1scJFe7rZGZKJC6xTDKIB5MY+rwU/PVmlmtdocGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Wed, 17 Apr
 2024 08:43:06 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7452.046; Wed, 17 Apr 2024
 08:43:06 +0000
Date: Wed, 17 Apr 2024 11:43:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Simon Horman <horms@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mlxsw@nvidia.com,
	Tim 'mithro' Ansell <me@mith.ro>
Subject: Re: [PATCH net 2/3] mlxsw: core_env: Fix driver initialization with
 old firmware
Message-ID: <Zh-LlGGuSrX99iMg@shredder>
References: <cover.1713262810.git.petrm@nvidia.com>
 <314f08cecbcae00340390e077cf20e02d0b48446.1713262810.git.petrm@nvidia.com>
 <20240416143626.GR2320920@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416143626.GR2320920@kernel.org>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bf9b0b-f732-4e46-28fe-08dc5eba66af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eeyb9hjgqFdlHJmT3cAffjQogXYQkymP27gDaftc/TlrmkKaFatziNqeWQWJ5KEHQDyLt9gcvmZW47EWTyaUV6OWfqehFVGRIxwlOFX98S8k+tyZTybGmwTftwO0gOTc7v/XWWFGW3rXR6Mlpon4HHPm3smWrroAmhhIO4Ug3IqekTbqVqkpR1XbCK6/S06bhtjsPTkqgIo10RHSq+Ond/KJkXZeh0t+6+WYUGyYugnWkfW/mPYAAfVn2p/pC0Jmri/VYmCGSCVzAf8mTwJQQELEW5c9MRmdzoSOLnYpUfbu/UBd6yQpNvZBR//QEi4UAaqmUmcxd0uDEd6WhKlez20zDCXQpEc1oWwSeWwsleCcpdrG+QhW/849ZT1MjpwmYriy445LG5EBAHI+CuAHG/QLDYaN5xkIuC0hNONI1HzSlBhqyll1PE5HIlCDrpBEjnfuaGzknecaPTfE1FmnzHdP1Neoh+dKfZV4v82RAgZ8E8VXdyynk7M8DGi+9E5NowR5Qmh9UBNumDOctTMr/lBYyTwpZCAvhajfCMB5R279pGU99SLY404a7kvj3WkeBZ54JrmkIk9RG60u1qtk4WdY2EM85X1rbTxMUAxh8DFgTGbdNk2H730Gi90F2mUt4FKTddw37DeixygNlIYncQ8mXkArEjqPoUn/CHIijuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTaOmsYMpqVQBwjv7Gd80ZGZBE7jFJ3pLmrSC10yJrJMsHaqoplzI1FkkfLh?=
 =?us-ascii?Q?jrFj2D7XVkCsE8zke+dbt7cZwvmQ5yC1DlwDedLSON7aXSYtq4TgV9/vUuB4?=
 =?us-ascii?Q?x4Pw1YRd4Pa6MHpoS7a/kmt6f8AE4WgQ6mZiLgmXk98Mko8iPM6Yly61/teN?=
 =?us-ascii?Q?DDcZSL26SvTtUv9pNYHE67KyDWyGZqjFm+tbMLUjc+vYri0FO55JRl44P55K?=
 =?us-ascii?Q?EIDCDEEvUoVlakeF+J3jYZCJP0K+f8GO0EuNAuH1QJyuYs5L2JnUYTE23deP?=
 =?us-ascii?Q?bbtsuKrtTLRlum+bVCqM4/pVx8u+3EHBQay+GGIiYsFO4kLn0IvYYEz0qjdr?=
 =?us-ascii?Q?S+KFElCt9QddjEu3E6K3TGv5D88QTxs7UjfNhxdvmIr4TooyBnuKq5PWeuOk?=
 =?us-ascii?Q?pzypoq+Vcm7zQXA/BUnd2rmYsaU0dY43ACQBIFaY1197fgdvfhtC08HSZxqy?=
 =?us-ascii?Q?HHaZjXN5VRZ31ckF2gzU1lFns7o2B8bkgaCW1zndnxR+WuLNOpZBYXk9/5ui?=
 =?us-ascii?Q?XIAkIwEtFaBHI0IiQ9z9Y54Jc/MyWQSpvlo7262IMXhUAnFFbFoSiYtNLIg/?=
 =?us-ascii?Q?5Dgq8Q1komiz2rWIKq2IA49xWJ5ar6RdCCwZQnkSNoE1A6Y5U1MLYy5gy+FE?=
 =?us-ascii?Q?AeRWiUK1UKX0Gddim0c29cIRJ6pJJ/WLXWn6NcvfhR46yvUNlEaINDwcVt1C?=
 =?us-ascii?Q?QgKj3/ZvAaAaoDSBO5VA+ZpXDxmzUhEcws/5PwAeFJMfE90xNjptylqhpkeF?=
 =?us-ascii?Q?1IQRcvANNK9zaOkWl3Rs5r4rrSMOH3dXhIZ60ZoDXMHJlOmsHcnyHz8r1qLh?=
 =?us-ascii?Q?KGntr3cKTyE0Uos1bzZ8jLlxvhYjtJ90IGNHN2fcN4+NtbVEHJY/B1BEAmP3?=
 =?us-ascii?Q?gHb0gMgKrx3XT2TwQG6yFRvyVXTROzartQsDRxp5b7sgoDYbZ3coDwryrONc?=
 =?us-ascii?Q?wzjcCrU19qe+oZiKI+bTE97HubqH1DRnWg66jNDYGRSgZiA03n1BEnIVDy00?=
 =?us-ascii?Q?Ow9cg7UZ8SPJjIAmzc9LwbMtMqIPLXJk/8CzVj7eLbDppIazFU0pTcISzYrN?=
 =?us-ascii?Q?zduGOypr6nLWztqmZMM7+bDSZnJl97Kpj9RV8/b9Rn9u+UABtutc8VWBAgut?=
 =?us-ascii?Q?JyRr8ug2j2C2ANCRNmqeac0o+CeaSdBXAfY3wZthSnQCsU3ndqmTihLtClAD?=
 =?us-ascii?Q?DYNC/ffr7yWfhSOyCAIrEo9L/eWi7y8AAXo61hb6Yr7BdJstuOVCMoL91oAR?=
 =?us-ascii?Q?NlgRB8NRZW4EEpCA4Qz0s2/a+8ydqGUOZN6TEW2eXqTJ9FPMQpxbEZPLls3C?=
 =?us-ascii?Q?CgooNhel0t0g5n86I99DBpFuqQGprIUUYGI32SFztOlWkbzVcmakapNPvQZL?=
 =?us-ascii?Q?8Qi9A1QZGF7pqD32we7o1SZv2RAbKgV5+7xAoSJaoq0jQkKw10eKFw1UU7mF?=
 =?us-ascii?Q?RxvIV9xhkNxd4zezh8iTSXiVUI3zLqwWNzDEjAQxyg1YdTuOrQzOjE8NghAd?=
 =?us-ascii?Q?HLntQYKfo3+KKFYpTyc7w+tahZIGSu1huZq2moeMD/+KK/dgjghGh21nB32J?=
 =?us-ascii?Q?9BQ1+vSztBZZ6gGzJMAco9Wi9as8VuiVK+mapA9K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bf9b0b-f732-4e46-28fe-08dc5eba66af
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:43:06.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CvYCIbS7QCQsP0BWTwWkHLotQM41bfh4wcP37h/RRpx2Y3ELJ7Kkw/Cct3EKQjoyPCYehzQ82cN0+iOgDr70A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442

On Tue, Apr 16, 2024 at 03:36:26PM +0100, Simon Horman wrote:
> This function now always returns 0.
> Perhaps the return type can be updated to void?

OK, will change to void.

Thanks

