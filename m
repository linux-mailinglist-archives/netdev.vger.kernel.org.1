Return-Path: <netdev+bounces-213278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E68B24559
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDB672307C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076032EF654;
	Wed, 13 Aug 2025 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOxW6Wqe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC827280E;
	Wed, 13 Aug 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077149; cv=fail; b=otX7DSXO5bXx4+MTsx/NQkcTXYyalhTrRATYpkO5Z0fUT7AbrFmEpWvkSaXeQH0+5JgweFjFnHFSyVDhKJeBTz0K2c9jqYxymR2C1QMteGvSbwC1B5lOWhrenQG8oVjKZDSiV7WdjUFdZWT4alXZsMvP8I+8sBsp8zEjzIkd3JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077149; c=relaxed/simple;
	bh=l2HszhcGM77c7ZDYeCFYzC5rtTybB7gVE8BnqHQEfPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AEx9Dk57ekLIEdWP1+zEQF79K0jJUS7C5qiWYpoy1+FYgOJMuTvee7rqXAw0EsqF3SNZOFyESrRKkT8Ovjk0cNV5NCaLSnYFnDCPYzaHdANOGHTSAh5aEGoduTgvJJzaHGjJQlz5R1wOavCUo/LWO3cCbWipq18k2oukQ2iZyPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOxW6Wqe; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szHE0v2RhtESnWx4gCFvLQMm18ueFMMnwea4+KjinDIOYRKEchDxorF82tiiAGpQLwH+ziOxDfVlpzFVBs/pApI+bS9tXZvCwZfTKkEWwqWQNRuVrNPK6h74+7rQyrtN9lsV3oXCo13i5FUotWJJNpx/mC9PzV6iV4IeVOBc2fnu0wVvmJPuZUtr9T9DU6ouCThNF6uJwllv+0M+AMK78LritDLI95nb+c5gOj0L8GigsgW7oVvNVg8Tz4EcCXzSQwDZrBZMxtiTqMkm2XQfK/OpKf1vnibZ4TOHIINQWRAUVCsjEPCMAJKvetrdQuc6QATbbeg5qTBXJeu1odqwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2HszhcGM77c7ZDYeCFYzC5rtTybB7gVE8BnqHQEfPA=;
 b=KrupcKdKd4+Kuf4yZI5kdUaKn5bntRjCNU7mldw8EViAByOSxYWyU04CQ2FxwJ5FdA3BMs2uF6ijv5GM3HnuaoAL760oLEJCaCGf67AVl2Yq3YQuAtnTGtYp1sdqW6fi5uiqyR60Khos2ytq1L+gBBF4N2P2LEsgsJh1qiCNl8soB5iuXVZXA1kBOktvqpq7+4UPXPWWxAbMc72gOzKMAsfvk3Ib6NDcUdZXuUdcWmdrLBSnNenGa5XPFSVEOmR7zrEIzKdeKvQLSQbFfs7tqWOiqlEaSDx8PgwWvtcjL9y1I//iMIvgxQ7eUO5tUf4vPkLY+eefBlfR1q8a232bwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2HszhcGM77c7ZDYeCFYzC5rtTybB7gVE8BnqHQEfPA=;
 b=jOxW6WqevGKbOWPmjgHXMNT3Ev8nlCGTD6WTGwc42pK+lQqAVdZG72p39AJ6EOnfx/5g/2tLBaoFadKCkXmkKg0BhJvJ767yEBuOyVnLvb24MP/vcwefkJxZqNQ0JyIAoQzjZNgh8eo06bKMk0DvOz3SYmW9WnSYolcKE3jC5YOrD0vaCWCQNz2ivVjfoAEN5us9iJx9QGdfZoUKJfTgZjzWSRKjiPRl6I7wo+yrC5q+L8fgpsNmrS6RjART//XHsyb9+3GA297w2g6o/+ehCk4YcjpD0XZnrEa3MphPWwqrBJuN0NbgnafQ4GEbJkBViNO3CuO4QFr46wXEwCqx1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:25:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:25:44 +0000
Date: Wed, 13 Aug 2025 12:25:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/5] net: add local address bind support to
 vxlan and geneve
Message-ID: <aJxaDxt9T83r03J7@shredder>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 53119789-f921-4e02-3f3c-08ddda4b6115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzvxWBaYjXu8hQ2Si1UfYbsVxL9m/ixGMp2W6qiPilmtLjim5ApgSgP1wMFg?=
 =?us-ascii?Q?ysARlW7yG6IW1ZQ8BmxNqrJ8GBjFerrCgA78yAuu3efk50enJk/Dbz6a3GvD?=
 =?us-ascii?Q?Zx16WfGhqRfM/vNWgXGds90rZ79ScaecAE89FMYdcSWG15lrFeyKiQrgCs+o?=
 =?us-ascii?Q?xWjO1bUD2vYjATOlbpuPr7tfB1H+3kGBVGMmuHkLazpahRDes8C7P0pmAnyO?=
 =?us-ascii?Q?PELSdOEEmeVo55gltkjadqOQ9iQ7Va9aUDJdXAyVEvtr5N3piPpE8vGyFWmS?=
 =?us-ascii?Q?Bc06GLffJM+dQ6OrTWBiUQZvF65vZ+W6TQphgdXTgnj5TtWSmlm93cA6bvgR?=
 =?us-ascii?Q?gLzV1GZSy1A+3B0bJB5za2JQZnk5l9eNb+Li6OIpfbbakuhgjXB7OzHtU3Rn?=
 =?us-ascii?Q?FtZO7QuRpM8qt1OR9vyQlM4hjQSuFeIoj8Y2PzYhjPV6Zkg7WIjfNmSXmHhh?=
 =?us-ascii?Q?TaIQ7Af68izacOiMpQgux1Hsx/w+QWiTroClBmKcYkNnGVpkFtJcyDT8bbtX?=
 =?us-ascii?Q?4kdOtDdI1XmXIzWodeCdYQORSphbcMHFt1pfdyJ4IS84z/R90sLTu1Arm6+H?=
 =?us-ascii?Q?39xmxxnEbXNaLqw9gRvf/e5LMJ45U0smH7SAwJEBGpqX285EMXAWlsIgxG6G?=
 =?us-ascii?Q?vcIH/VZrSdJmaxlogbdZIsH1Z6uzFh0ALUs5Szp0hG0Nt1LQZSnmLS4IE71c?=
 =?us-ascii?Q?pBV9TjyQ8LoV302uuL4g/szNoT2nTXTDbZqeS61fT9Fd+X2L2xiinsUIe+by?=
 =?us-ascii?Q?f1rbQOBn3BRmgP0i9fJytUXdd9sdqPPnGc9XI6HSKp6A7qAQzEAYUCZPft8Q?=
 =?us-ascii?Q?c9Od0DRiMhDK2Yhuv/9Wo0+oZWyI6q78DlN/V2D0Lcf/PBUkbtLbkaJyc8UX?=
 =?us-ascii?Q?0ZgteH3m2EVb6P4T5jne7ox3oEyuWj2292Zensb/MLn50VSeja909BuaJRrD?=
 =?us-ascii?Q?ZW2Sb5xs9iX6R2I8x6xoJ+/uxf5j2xGUPuy9tXQQCU/mhMZqvdTKw826r84m?=
 =?us-ascii?Q?+bPJsOVT6CQjKkAyS73v4arBWyn4kshNntwVV4iJ+hGQHCYvlahBvRnnuJ9Q?=
 =?us-ascii?Q?D+dE6PnTVqnImTEsiWeeIoHibNGrvPXrCti0VK33WtSs5itVUFQCUmpBbF0N?=
 =?us-ascii?Q?1sEQ8n2LSJTRqkZ48yVzXj/ricRg7KcXXy5Qs12+95L/OSEOLTQWIndPujfj?=
 =?us-ascii?Q?Vbfy9HJ+v0mB2mjl2wiRxWUjJ1A2djrloBEwNXjY4bn2+pWYnESKc+df6hex?=
 =?us-ascii?Q?YgCgCFSmjG3cTZrrrgko7OH1It1lXO2poRIzIboVyfROWcAPjW6pLJBwICqk?=
 =?us-ascii?Q?79hW83HdDeWMS4IRhzdSqFB5c6p0IAHYpaH32DIf/y7ZZHZUoK7Vuzyqs8xv?=
 =?us-ascii?Q?pG226E13uI3+MqJU3qgjSloZvcCT0s275S2qjtSxlfbTe1+cUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmxlhO+k31wjUi2ZFRSZacoSKm4rRZWiratVwcRTbvu6CwMiMpzSJWfmqo73?=
 =?us-ascii?Q?Urki5cE7+76WymDUEFENUVbcGL5EaZHwkPurygL4MoyFcGBMJSiun0Mbo09K?=
 =?us-ascii?Q?LIqhjnDCqxktqT4UvhZ+tOOxtz4BxD/eWIAtThh2skYcV076djJxu7cbiZqb?=
 =?us-ascii?Q?W54tKGBYZeq1MrMTXAAqYOtZtGM7UftJtcnT4EVC9PJcT4IK5WSlWYyJXZFs?=
 =?us-ascii?Q?dJdK3Hmkcm2ZQiv7tUCG1fyOgrGscUVXAA+1b6Sm7PUu6gGdXK/5Oj+PF7VU?=
 =?us-ascii?Q?KBG4ed1+iimDQlejpzx/mRcuoAAdSl8/tRQgwjYD+XmBea4yXjoTUlBJETcq?=
 =?us-ascii?Q?OrIWvA7Feg84+K7NR8lkmK2zy/FHuO11mgOsMNx9vPjtzAda7ExMHRJN0DO4?=
 =?us-ascii?Q?L8glWXHa4/r+v0RxYi85VhLzVb1U3PbHh4KfTtCrYELcCswCYzJIniCGvCiL?=
 =?us-ascii?Q?lMbyw0gVRFDuQVHd4RMLIbAbHfT/TQpq0XPbZ7ilDN6Fw9uiSjT5m6rFNruM?=
 =?us-ascii?Q?s2eCuaxd5qZUd8sk5bNIN0bO7CN78FbrfuZC0jKqJbuqtw9h4aoO5uIw53V/?=
 =?us-ascii?Q?9+cF9VChDaMKwO69Rt3hb9wbQNortoF4BnG5nkjW4sdY+MbgkzOtTtIRnjaU?=
 =?us-ascii?Q?DvgMCIgBizomqelKuKuJzfmVmY0ao7kclNOJh8ScJFhlxdbQDN1NP0WFlzQu?=
 =?us-ascii?Q?1a5SJiKuE3v7lAKYY3kbs0Y+m1PC2qZ14rHcQqtxP3U8SHPqeopDMfJCOhs0?=
 =?us-ascii?Q?YOI7h0uuyHj0CXvb0Kf73QO7yWykJFaaMjRbaGzBla4ztRXkGuR/YE01ZOmE?=
 =?us-ascii?Q?92apPxnQTdl2iVEsJDmHgtW5enva6uF5Bkklrp62mIeNW5BvK46voscm5oga?=
 =?us-ascii?Q?Y34C6UMKkTdPyWB6F1gZUiZBIPTfkchJ1XsL/2dY/LWNQHZoPevIYs30RK7u?=
 =?us-ascii?Q?Kpfj4GuiL3vbF7op2K+tmPPBEbVd6r9xIw52NsGBwBL6FDMF+QN2+txe9cj5?=
 =?us-ascii?Q?sP4baRN03oQOQfbHFfp51VrGir+vILRlrX9SeZtUMt7SBa82gh/Ldu2n/Vnl?=
 =?us-ascii?Q?Ib6FgCSXEHmSlr9RAx6iQVeDxgzhx5NGgD+lQOhDbeD6cU1bgpxo5oIpD4OX?=
 =?us-ascii?Q?igEkHayczyP0TYYFPrl86cZx++vjlFKzwb0VBcEwmPtMZKl1q0s/ID52+seG?=
 =?us-ascii?Q?vju+3AxEL7r6V1xJiXMHY0eT4iWMc6O2cehs017aP00nphTkW77oRcHuIwAT?=
 =?us-ascii?Q?fxjpIKyeei6k1g4Bt9pJrY+DH8G4Xv8H0vO8pypAnrI8QuG3K4YIbLTKQVz4?=
 =?us-ascii?Q?8jS0rxA8i9ldEjSS6lULO9fP59vmvKM/JPFyYYx7CMmibwybWHBsyXHxXfPg?=
 =?us-ascii?Q?FlrAvithe52FslN8/r1NNQNsmnEn1s2wx791W9XWYZhEJ8/NnrYY7vF2hqpo?=
 =?us-ascii?Q?FZL0wfk5OVjieOtYOliaAwbtTcqju44cNup/oA0K5v49IFiFBEdLs5v9Xwmi?=
 =?us-ascii?Q?BqCiMuMzmncVPSfr+eeqIGYfC+3aCNTjoc8FZykhtXOeeiuNlEz8nnww/a+5?=
 =?us-ascii?Q?jQuZJl6JpFWjorykuKRPmnqJEas9adkqoTogltWX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53119789-f921-4e02-3f3c-08ddda4b6115
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:25:44.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLVq5G4zJvxl4a+V0TFiVbxhNazr8Ltc+CMApUAeiy1PxROn8Jaev0SyhE/5DbsmmAg/vHUItrKGr3UBEXYQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Tue, Aug 12, 2025 at 02:51:50PM +0200, Richard Gobert wrote:
> Currently, vxlan sockets are always bound to 0.0.0.0. For security, it is
> better to bind to the specific interface on which traffic is expected.

s/interface/address/ ?

