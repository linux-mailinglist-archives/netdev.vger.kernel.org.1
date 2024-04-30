Return-Path: <netdev+bounces-92425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313A8B718F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69B51C2233F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53912C530;
	Tue, 30 Apr 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gCYOHOrN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0B12C48A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474667; cv=fail; b=L/DW+NDXZ4DVAis0rf/FKRiKAbHs5VyCp1H47WXh8W2H2SDfn2Qrr11Sufkori2PQqoJY/z60NiGfLQPYQJ+0YyB2o2KJzC3nYW470yHBqV5fJgaE7Al65NcMUKqxGW8BiK4GbwmV0EXXyIZpfAfVUvm6uUYp+j7cDKL7uIT87c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474667; c=relaxed/simple;
	bh=W1Pdf6clhoBfL4S9J3Wy6GF9OnGYrC0F5cY6vQYviiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QuaTx1VmT+IrGrA4jxXXUYuzkSyd9i5Mng0IJA/Jge/UURPp0YYvFaohrp+CGnTKYh1Dn2yTIGrflMP1IAk4WAYWWiYQIESUHXw66hEV2xRsj/SoB+WtWcesDFH3+do7kKs6B8uyGZ0vhVtP04IW02ZMSatEDZgnjrlW8qwJrKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gCYOHOrN; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8MNO4fQiG5KT1MttMTKKnfQCHGk6boUch/8LqguNnhow+XhmlvJnVfUoXSWs+8BWYVZ2Z9B5+VepEXmV8buQhL0iZp8nHqC96mxI5K4V5W9444W9Ll12jJ17aPXCDZy0YMTSkF9NiNOPJAw2wd1ltFd68dZ9lw+V2YoIoaoxMhIq+W2oYj5DIEjNjUo8rEDvmb5L2o44I3jIn2DCjhvpgTcZv4FCP4TU84O81rWYYJdMibDn9KDPuQlNYyM7drR8K77UR2kzcLWRlyl9iHlV3tUltoWGlzzlW30FN1sNpgt6caJgDoijb+pcdw27MNIsDsqKOj6nW3dX2MyXVQoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1Pdf6clhoBfL4S9J3Wy6GF9OnGYrC0F5cY6vQYviiU=;
 b=THGtrgN8qWMXrOKUL3uABWD32WFGWUezdC4QiNrEhXBUzTk5tubDDIV0mUiBzGxQoS9PvqpnJ9cf65AdCj7WE6TXqqsKRiXgyyt144GfAizkuChoiOIBRlppPu9zTXOmDZ+AuDY7tgsIE66j3ORPOV540K7GqH/AafwFE7pjyujYpE+IeLvuq5tj5RCCs5ZsxPYe4h4cVgZWeOf3GgGfUy0/cuSpPszMN22zh1pRwM1FwHt0ixmYt9kgTDcTpG7msgP9VVQ2CYQiZTvrN4uK1f86ZW72eqKuaPASqLOnb/xMIU4Zxn2KT7b0tI8/Nzpoi3VRACVpCmr/nxg43McGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Pdf6clhoBfL4S9J3Wy6GF9OnGYrC0F5cY6vQYviiU=;
 b=gCYOHOrNrZPd5lSj55zVwHt/B8Q6C8bSXy3eJjoiS8mBTONWfT+5pPbvGIis5PiNDEl+L5g5p4wZtUtQMBzu8UBDDFZmfoEKcqGSBsN3+arSd/eSqYZkTWvL7lfznq1vcdFfWLVg5XwmNyECr+uxPEerhR9Wg/9KJvSSsa8urKiJgW0ShaD1/I8FTlVlTz9BZfWT8dUittyozw5UVF1pKOS2xXP+xHFCJwt76XWE5oNeG55beUxsOvC1mLOM7x6Cx65DS2Tu89a4/L6WAWi2cemSEeqJjDD0WhGlngOmZM8m45y73AoQRXEY1s2zaco/h8EJIxtPaIhFv9clPcGe+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 10:57:40 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 10:57:40 +0000
Date: Tue, 30 Apr 2024 13:57:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] test_bridge_neigh_suppress.sh now failing in both configs
Message-ID: <ZjDOn9SNq8baOfZB@shredder>
References: <20240426074015.251854d4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426074015.251854d4@kernel.org>
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f85242b-4e07-42f8-b1de-08dc69045add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o4WqGxWIxECY5xj2K32fEV8wgnULBX1mccRDaWETqDyWMikgnOpd3GLHF482?=
 =?us-ascii?Q?HBVaQ2ZBG34MHZS+SWZfgTHpjJwPJ7A5EXVXHPsdJI14v7E9CzJ1RNGuIBav?=
 =?us-ascii?Q?Z1uGFIyn2NLPfflFNnrchjV4tCwqWFb/YCz7ty+C/Xqr01zh/hz8ek4xj3rp?=
 =?us-ascii?Q?ayYc6uP4NFMieE0qOLx2XDMra4On7n5w4zhP/jtxAXvd0mOX8LCJ3sZe1yPF?=
 =?us-ascii?Q?TmqdFlyGVrmCllR/zqLO+87SE+bFLkhQk5Qwhol/IxU2uDftcH2IWAJkBANW?=
 =?us-ascii?Q?0c58TA/oN0n4o4OsrDT8Q7kc+BaiJK7BjPdrTPzi5K78DEBzw9NiB1BDxPjj?=
 =?us-ascii?Q?4ZWqGqh78sde61mIK5SmjXFy+UOcZRS+pqfTMjRGDYq9MJtOuUJx0jSLaeHU?=
 =?us-ascii?Q?vcA0gDbiHl1URj9vwyElWm8Oamqx4aNzyrq2YlIEmJHU7a5egR7YHAckmD2+?=
 =?us-ascii?Q?HcX4d96gv9+ZNPO0bbyykhAujPwMOCLTSXAR24lJm/+TROGJBw9zbOmPxFGe?=
 =?us-ascii?Q?5VSjSQ6CwuSecZX9JPZnhYP+WGwzyiHEWvvqHJtPXqS9V9bWo9tnctqMzYH1?=
 =?us-ascii?Q?aNom3HqHGXDRsJqXlf8EgIX+AoCI7IEtz6p3Y4UoHVyrI9G7VDavTmV4M5qY?=
 =?us-ascii?Q?Go0aTtZofIVSIPHhGqC3O3m6LCUOLb9gtkKaaJT+6UBgWtFxZ/dcKRc4QPVl?=
 =?us-ascii?Q?kn5fCqIKiXAKxlyVW4yYwyLXf3iuoXuBe9IkcUWCGmquSdUYIjWJUHxlisX1?=
 =?us-ascii?Q?m5BRtULKNhJSBRiCxw2mb3Nw0C75xep68hnM6kaN/q4nz9G5wj4eZ9r+yCoT?=
 =?us-ascii?Q?TYlk+jPXZWNnB9hYpR+geTgtAPui2a7oyySKeEWo/uPUJPz0osjoPdFEXqAj?=
 =?us-ascii?Q?pxQKcILj0N26hQ66V+U63laqcKGHNNFh5Qw63JL2kguglydRryPNGxWO6RPI?=
 =?us-ascii?Q?eNbojltPwSorfbQf162GTjppbxgLcfdRLyv80hmicvxkUtdRyiokILAl546V?=
 =?us-ascii?Q?/+9NCo/1wRN2OazIvQrAWxF/rEaZK5dK1UQriXG8/pQTAxWeDZgz2ADI9Rfa?=
 =?us-ascii?Q?5YPu6+AGLqV51YwWnGyClbyf0dkkoPYblBDt9s0G7nI3BMbSCfg88EE/XV88?=
 =?us-ascii?Q?j1skC3/AYQyMjCUhSsoltj4u88Arx1cq8vSbjDiu3ahJcNo5FFmcaYu1RnT0?=
 =?us-ascii?Q?Yuk9PWknrB/oYEd2HqDZQkhaEt1RSWygjY3Ld6wyx8a/yS4dAG9zJSADmgwq?=
 =?us-ascii?Q?QA2+Ommjurq1417VxTxC5AF4NwWVENBWqmC1RiCuew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sz0eiClbKEBjwHaiFwLoOpjunjlvDgZM5fm+0l/6tjQ77DPlkZiqk7UOINiq?=
 =?us-ascii?Q?kLBRYcxaSgVzRxEgz/MwFl/31iRJlIpjG9x5v7iZ31lTYXZn/kngAPFoeaU4?=
 =?us-ascii?Q?UKi/i/yklihmKaxjaVj64ZX11Pl7eV3gWv9dmmziPPEL5O/goNL9vM/GPSxk?=
 =?us-ascii?Q?uFcoTd4g8vLaQxVTwy9wMFDqLTz/VN9vEzvUHWeATXOW7Om4r1kIwLg2kMsl?=
 =?us-ascii?Q?mGM2TqrsjT79whYWyuyLOPRINGukerPfyukLTeLhPapZIbgzs5iiS+TJvXjr?=
 =?us-ascii?Q?DrhImRsQOGWUs6qTM3im7WEMd8l/PjgIGZ4p1L5I1eAaXXZvdZZxd3UvkyJ/?=
 =?us-ascii?Q?yQ0lv+9zjUMFY2qeSApe/+z8KeklrQFPiaD3vZGp2txxuTCKD3x8yTiSZ94X?=
 =?us-ascii?Q?hMmcdKmaJcHhy8zjUIqE9sqlmuQaN8aXuFgYhcx/PqiAlPDVd7Qm04WsWhqE?=
 =?us-ascii?Q?sTewkSkL9Rtrjsqvfp43yG9mcX9MqHeRdOdnOJSuIXMP5N4yWnbz+H6f+qIT?=
 =?us-ascii?Q?NZQ7mXSWwRmxLAxcij36a4d7GQSKKWcrPpG7JU4V6fvjvo/125uo15WIpRQ5?=
 =?us-ascii?Q?i821AQcrdETXlkA5MYs36Cmv6FHh+FPN0RPH0gKPDs0mQJlNfWFh7QvN/hNM?=
 =?us-ascii?Q?pBxudQGOg1z1UqCVbYFsXPxboo7pMVGMHgvCY5EKB/9GzPx1M/nqpyE3ukES?=
 =?us-ascii?Q?WhgS7uf2a4TRB1piYRDaOhKnPC3yASDejIHeqsiF0zeANDypdJNUf/yZrsrT?=
 =?us-ascii?Q?8oAp4HP2TGGQ8J5hR2MihS+4shyoBzeUCqobqG652790vWs6hkyBqT/FhY6P?=
 =?us-ascii?Q?vEWBv3aoFVKAC94oWBoMjV3qYofAPHtBpAi9uXtTQ7L2ZCh3ZmIrE/1ebaTL?=
 =?us-ascii?Q?e1reWdHseG2nhWZ590Jsh0Q15e9pfEiBM+eSU1E/9cbauzJfdGR+msyWVPCo?=
 =?us-ascii?Q?ty9fnn1jNnPNbYN1ffjZKNIbHc3Y69ANEHpND0ahclvRKAtpqMo3Iqdvi4Mg?=
 =?us-ascii?Q?Ry3/UTcP/BmsFJUnve8IjoziiVV7NdvQX3jJUM4Lx7TEou2hr72s1e+kd1qF?=
 =?us-ascii?Q?U4UvQUqP18+Pk0P1hKzvmfXOl0VJQD74fQp1m+OHwafoYkbc3vCYdqmPdZV2?=
 =?us-ascii?Q?UJDyrQEgVuYrfpWYNjR47ONK0I5k02OS31dH/ZhMtQWHBrFYIlR7bdZKCxoK?=
 =?us-ascii?Q?SBYpMBVNXfR4lSIiV0/XDD7Q6UN4L0WZBKPWFSHLUmEoGl6hgzdfv4DPxgyR?=
 =?us-ascii?Q?TkrKpjfhwBuAfH+VKGQfKYcvqE0DiUMVhavcK+BDVfNZWoOynYegAJxukW9R?=
 =?us-ascii?Q?QdM+cFMWUZywqQgRJef7ejcyAQHlpE/H6ptZrBXVppAxm4Y3LgDMdk8SlkPl?=
 =?us-ascii?Q?fDNvrZypFg+yloSEwJdgiyw/suUPdMCsxeLig8DBoP/HOMPnUMm/B6HNuyjU?=
 =?us-ascii?Q?NROCKcK7wr4EJPhdLIuUR6c96lROPXNSU5bl8QAXFx6iF/2YO+8uf9/VFxJG?=
 =?us-ascii?Q?pLslM6rWmfYczH530m+Y1OtpeBUc/7zt9ISorewy2h6uwUifq9CviIy7fk+e?=
 =?us-ascii?Q?H/70Q8LPioSVYugyPRsCBxIrwjGRHzofWtGjzC12?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85242b-4e07-42f8-b1de-08dc69045add
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 10:57:40.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+QWu5bSs8cHPxOx93rqIL4H0MtVOfuVF19jcEvp0tfYkxeacVSnlplFxy4rXumsajsyNx1xfXQZ411c24a1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

On Fri, Apr 26, 2024 at 07:40:15AM -0700, Jakub Kicinski wrote:
> after we forwarded the trees to Linus's branch on Thu it's now also
> failing on non-debug kernel, in the same way. It fails every time
> for us, so should be easy to repro. If you find some spare cycles,
> could you take a look?

Will check

Thanks

