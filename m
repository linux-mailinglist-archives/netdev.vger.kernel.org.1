Return-Path: <netdev+bounces-86861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D58A0856
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4161F21438
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87E13CA96;
	Thu, 11 Apr 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="YcHKdg8n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE213BAD2
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816401; cv=fail; b=BjiN5AHUXmTCytxMaHPAxMd7wBci0tmfs+Yjtv0vjWRwwxkF0fIrwoon+sU3Lbjyqeux95nAaOvLFW8k+izQW3ZV5L2rtPK2ffCJUlxNuFvhivlTheOYza4hZr7+D895Rl7LMkolxsuJN5C+THcethLL4PcdP2X3oUNQ/C2F2b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816401; c=relaxed/simple;
	bh=zRzMPYTPKOKEGB3ZxW2B2wL1TrrLjjKtNY/hBKujG+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2/jE8qppZ0o8oGHwIcXgJyJRwkadqsRxGU052hCJXMYWssIJ07fpU9uAvxN6gt1q87tzUyH1b4CuJ0MdEqqpkmDyyt4xaEWdOGe9VNXxrMajwYHqVGunIeRgJtry/4bW6/+OqbYwIMTCC/BtVT3gMDttn7c91OtvMBl6S5+Pmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=YcHKdg8n; arc=fail smtp.client-ip=40.107.243.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLsVetUlLflWzZrPPaO+yu0Mqp0TAQN3YKLWL8ehnP8iDOio6MD9CLenGyXPOxZO7Sa187AHajuxsYE1ZhWDerRV/4EafJszNDtzMxhUGWuzF1ijsl+2TsEjxYHWBUeGLTWTtAYrdiWTWgtf9veuFx+LDR6c93pjAfRcmJHyTXUaNqEZYDJ0C0vWbp/fOMJVZBRT9AxrTOrQ3WJ9erWk0NPh33C4gfsKNuFYl/+1P84aSEVW6CYFcHwBSphQRnJpT5WPTI20qmmJpB2QdT3OfnoddPgBfdj7ru9FcPxumqZFamAOjZl6nnlOvAGgNai+SIcKYNEN2nKyKPWU72kSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCTCLxM9/GPhzyB9qQjs0EVHjy8rS1wpczJJ0TZGiqQ=;
 b=fA42Yq0fjtqtOwhHodEeEwAQuGgSU7SWFudbNNrICUMaOEnoC+EQOInZ2qyxf9IubgoLwBInPoGoGiqxmTN2SgpEqz4tBlrUMHgZRCBdR4mPsguVC7/3PZgXhxmybAOz07b1jHqQpq71/Si2jzWO/LPVVmtAnz4oAMEuA792K4fW27U5WSQ6VIe36DIdnnvDxUd8VAxTO064fjWY4AjS4H88cDa6a2XM8smyh0SLywjXvd1BFlQQrdK5FG7WLOsHV4k955JEDP3HwgsxPkPv1N0DV1XCEYv5Rj9D1ft+UUl+CGu4p13UklP8oFafEMukXHjkLU86B3QE8nXvRkuxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCTCLxM9/GPhzyB9qQjs0EVHjy8rS1wpczJJ0TZGiqQ=;
 b=YcHKdg8n6tCqm34y0PwDzUbLv4c1ly66LVV/4jVr0GBxuvOxf57teLpylCVZNXLK7nV9Y+b9CyoNIJ5Va4C3El3RqKp3PRTRC2AsgezXz0Faix276ePTdzv9zeb12rxzU4fUVNFcTsqYkaHIPY8KpR58v4fd2Bl2dKP1Xu0Dfqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BY3PR13MB4930.namprd13.prod.outlook.com (2603:10b6:a03:36b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 06:19:56 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 06:19:55 +0000
Date: Thu, 11 Apr 2024 08:18:46 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v5 2/2] nfp: update devlink device info output
Message-ID: <ZheAxsfnbF0lBK9Q@LouisNoVo>
References: <20240410112636.18905-1-louis.peens@corigine.com>
 <20240410112636.18905-3-louis.peens@corigine.com>
 <fdfecdb3-2070-40d9-8129-01df41d4232f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfecdb3-2070-40d9-8129-01df41d4232f@intel.com>
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BY3PR13MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 06224c57-0cbe-4b6c-7633-08dc59ef680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	58IBs5X2aN2gq2OcAAeQI7klbkvFzyAQ7XN7c4S04vJO3pHqh7yR1cjOGbd8X85YC2Jal/i0OtVF3xA2mI4I9uiaBAj4DcerCqNtZCqiNUkv8RclK9muTGzEpqFpK7amQ94vAyrpXTFf6/ix4m4z/0xppsqkkKfZpA5st38cPm1GnFavfprimPHeCK3ymP5lwzmbohGQE9y8UKC+f51qdGbXUwys5cM7SAajuRp/r0E4f0+hzQ9R8Gb9Ime0Lh7huKyOGHMSfy6UcN7/dp8kLCyEcCL+kSjBTICAPbOdVOAW/Xsb8P+AQzYFUh9MjGXOu5fp0lna4ZrpXRtTb3w/WdV3dt2P3SSaWJ1NiYhxaTA+ZWDLiAsKSZRaygpJ4T1iKRJtSmdadgIDUilqJsYQqznvc2fh5dc8iPMAO8EBDz7stn2c6mZQ9XtfOcj7amEMiW+IrdPsw8J93wnd90m5/1DUynYcqh+YpyoHP4piPAiGZjC8VM4Rb8ZVvkdWo9JS6G70OUggbc5NSVVjSb0hGbjwe+KUCXShy4MxSTJB1N4i6pssb9wVfhDOD8U3jHRDXPjP8ujWsR5noK51ddw+ApWoFqoDNf71VIUa9a73rmiZQnHHkMNd9CwiBhmwCFSKNCn8YL0kCez4zFU4Fmuzp2xfMq+1K/mp5lwp3QFpy6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNrpLvWJPcuLtZjHvAwE+pm09lvS/E3qcHa+HohCBZj30acnSJfAmY6pwSer?=
 =?us-ascii?Q?0HOGN+4wzew9MYkiqDfLcTQZt2jRRDevveDMI143iqoUl6AmFscXrgq8CvNm?=
 =?us-ascii?Q?m7DPyjBx69cfqIIBG3RRzqV9mnsreGPRyjjr9h9vQHvI8Nb9XPkpBI3bISJz?=
 =?us-ascii?Q?MC45a32I7N4taARyyQUDhNsyq1QzxcdN7wStHvbS0lgWnkc/RWVw61ckiUK7?=
 =?us-ascii?Q?z5Fu47Az5PsUY0tEA1mC16EP/3b2ZiUh1x7483EqpV0bXU/ut9uJSXDFG3/0?=
 =?us-ascii?Q?kiWzByxzdJuq6VP2AB3t3F/K72LhQ/TXACYmdWz2lh2ChNP69YAWIHzQe/DR?=
 =?us-ascii?Q?/aOee9Rohna82MiDyIhhUZiD1tjWqmpY2/oG3JK8Tikp5LNlqpXaVu8WcXqt?=
 =?us-ascii?Q?/aF35jBWUzZ1p+Xenw3RuKjc02fpW7drqcY3Nx15w31tv3xxjx0lg8wwjz3U?=
 =?us-ascii?Q?VRP0Bl0tjLnIVB9NSSoZAsK3VidrTK2uWhlpAPKC38PKNiV7Mc+gvgzqZ/vn?=
 =?us-ascii?Q?YKBnq7KpUX85w0Y9VAwdRpROzn39p3XAKz/0fdMDc64I7pdy2/B4HBiVNTKH?=
 =?us-ascii?Q?MoWnYKun/ULodxHadQGgPXIlQikxyevtlxZIYOVYgD8o/w4YK6P2F/BSQsAy?=
 =?us-ascii?Q?rkFBG7fdpPSHmLdG/58XfBp7ILpw0L5gbsWbu4EfD86SUfmR91GFbgvqIwR2?=
 =?us-ascii?Q?TI1obNQQTvokHHcISkaazfNBzo801fvblnw+iX6pp1aqila3yRQDf1QRr6mt?=
 =?us-ascii?Q?F2qu03PDP9qmuFqQORquGA0bPZ5rf9w032M9/7sfSlICBiEQ0On1ntJUNir1?=
 =?us-ascii?Q?DpXA4d0FVYxmd3ofePZI7kVlsqIjXrUve+kukWH26j6Zcy4TIXM7KlC4gWge?=
 =?us-ascii?Q?mRS6O/7ut44mQLTXSLIybut+A/GAXaIphxSAuwxl6kkufuYdwRJeXyCAQEbI?=
 =?us-ascii?Q?rrQ5LXe6DrZqlqZu2bhNKv0GHduVr8iEsNS3mluWOtK6+8mtFLUQrPYeY7b4?=
 =?us-ascii?Q?wvDG12n5obpagjkpCxxuaEBkmeclVGI8sX5fAx68T6rFc1E7rJVEPja7y6NK?=
 =?us-ascii?Q?eJdeF/Locq4sIp2M3K+vGL9Bgn6325z2FMufyhqMe53J/iAzh+5FA5zkMVqk?=
 =?us-ascii?Q?iMuvda+IcRqfpmg0Ze3KkJ4Gw4KjMGBh9womU+h28nCcinyfVj4kAyCtmrnJ?=
 =?us-ascii?Q?LQBcWVHPbQ8vaNz+BI2t75k9Rbk1uYaMnSjJJvXO1SW2plko127kHkIX75kG?=
 =?us-ascii?Q?GsxVVYqNllUP03ZlP8PfhYNz+zFHL2SmexpGGWLVaWj7Qd3SpratLhSCKDOH?=
 =?us-ascii?Q?u6pMyG/N7e9JabolvKUAgbOXEs7ZCo8kiJEwtof/B5NRgBV6hG6fHyLHi4AL?=
 =?us-ascii?Q?vKxOsQkdeqwX0pLMzthYWkDH4jjejVyUXPrInxNNXkFRu5FK4HpO9dMc/osG?=
 =?us-ascii?Q?EbxFPXupqWcZJkz8WT0G9ywgWmryGlxASth9oPhVQdsSKZutAlEFumavlApj?=
 =?us-ascii?Q?0nI4tvngOtXard501yw0HgiKtycEbXz6oaJg0hgOdNaRDjV1Ug31vcbnGZZr?=
 =?us-ascii?Q?DVTGvPGoyv0PQxWN9ygxwYDIeWUDDGHr5PjZRxLLNuPF6IggFpmxAk2eo/LG?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06224c57-0cbe-4b6c-7633-08dc59ef680a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 06:19:55.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1Dvnm8YIWm3oymLGpKlbKZvbQSQOhesuQ1Jk0dFLFZajvUx52SMuWUtzgojAPFVNyH6UL1YVqzG+6ORSW5yDi10jdUbREBCucnoKmBL+EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4930

On Wed, Apr 10, 2024 at 03:27:22PM -0700, Jacob Keller wrote:
> 
> 
> On 4/10/2024 4:26 AM, Louis Peens wrote:
> > From: Fei Qin <fei.qin@corigine.com>
> > 
> > Newer NIC will introduce a new part number, now add it
> > into devlink device info.
> > 
> > This patch also updates the information of "board.id" in
> > nfp.rst to match the devlink-info.rst.
> > 
> 
> I was a bit confused since you didn't update the board.id to reference
> something else. I am guessing in newer images, the "assembly.partno"
> would be different from "pn"?

Hi - yes, they would be two different things, approximate example for
new images:
    board.id ~ AMDA2001-1003
    board.part_number ~ CGX11-A2PSNM

Old images will just have board.id. The field naming we get from the
hardware is indeed slightly confusing, but since they are used
differently we could not just update board.id.

I hope this clears things up.

Regards
Louis
> 
> Thanks,
> Jake

