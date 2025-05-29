Return-Path: <netdev+bounces-194149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F33AC789E
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 08:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F6A4E8349
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB30C254874;
	Thu, 29 May 2025 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyMCfrP2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6411C8638
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499715; cv=fail; b=JpCS31TfqXEoPEsUEQG/HE9Nqd/87gkMYStfHz40OCfhwUBLgAVB0B3nwy1FHowuwWUAZleeNHGwkoNqZPbdn/qPsTQAcPQFMk6vUSif7xdwIaWLt13rin+TErhKJ1yEXZfUPtBEdQu0qQefcoQQtO1FDxVTMy/UL8V3GOvuiao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499715; c=relaxed/simple;
	bh=n9ykgAPv+pli/C3SE21cUK6LB1mLlURsBvr3ZpgGwVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HcLDfKhjTWD9wyQf3ojUgJecRdimmiyPfgiRaUVH2vj1LZRxg3ARdp9Fn+FBuS9+LKLvtUnnwQMmNXmjdh922gY30qSFeSocKYvid7xplybZUuc7vDiKfQO5KQzEN8hqWygV50IsOX7F6by/4uVlHy2/FXpE8sqQPvvaUk2j6aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyMCfrP2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748499714; x=1780035714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n9ykgAPv+pli/C3SE21cUK6LB1mLlURsBvr3ZpgGwVg=;
  b=QyMCfrP2evG1HfWlu3iBXexNn9QwFF6s8W515qR6MDUnTqssHq6+dMxY
   GnaDxWWAOZmteyKvMhJ/08LFeC6f+6Hstcp6lxaL3iRR0VVzE2k0ILI9Q
   PWpWneLMsBBFFQijiAx2cs3EOo1sn+SetlO3Yr1PkfuUK9hQov0y8USZ1
   tbLSbPrJVGgKrzSRWp10XJXY0iRzaYKZwy6ebZWdAJcfVjz4/3XHb1Eud
   CKYPkLeWzbpF4gNHbb2Tp9G8RzEAsW2M/ln8/A1VPwz24INAykQfvImTy
   w/hVJ/4sCIq6fIHHIPjlOjyTieD5Wn7OP/PJfoalhYkfEGeMddaIqvvA6
   A==;
X-CSE-ConnectionGUID: Foa6YRcQQVKH3Co92HFwIw==
X-CSE-MsgGUID: BHSjO0A3QaqaEFylU7yACA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50701516"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50701516"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:21:53 -0700
X-CSE-ConnectionGUID: SOd8KxXGRhOQhvmQ7DnJgQ==
X-CSE-MsgGUID: WBvNk0YDTIKC2lQd9kalDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143797769"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:21:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:21:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:21:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpvpJ8Fx2lLAvSPdoiGSoFVv7It57C+r1F7DURnv7c7ov9MlYY1Y1U1cDEIgYLb86G4FPKkYxF7z6BqWsbrkTZkaT2a+7guSmD70Wn/Hw0ZXM8miTtSBMSgexMsmpqJsoy6hZVsqhzNcv05U5xJo81ZYMG5lj+Ok1H8zjuypo8IgsiKD6eMWGe63JNkDmL6AjPQOPCJg/Rr3YzmBLfs4xjfVCMN1IK0LDozzxpEW/CfkRTkBBBIzorzssKGUG6DJgpbUehYZUqTkqxZFI7JvN/729Uj1ETPy7/f5tPtCaJGROCP2kYWfFtW9nd0rQmMufsCdznkCDF3fuVW4MLxmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lh1F/exQneysvkM9tai8qBRBQrPJsuLrD/jnVt/dTU=;
 b=KYLegJb8K1fVUhoYgJq9kw7SGvPLfwe0MjDRXtE0mcKujkrUzKMWc9u8HXMUQ3UAnt/i3pIFQB3Ml2oEnudeOcvEulYvy48Ni94NQyezw5FMbtQkUkmL3WN5IlwICbnSI68IhQ5U7Pmkl0hUhxRvi9g2UJj7iGiwrOMkv4mPhgDQieGnS5Q1LmcRclV885cCJz6dxeILsckOd8EUyB41LzEKSj16+FTLzhx6hTUHwr+cj97/7ebjAvvvCCTmLezMmF9TWxLdBbbPE/qbSWzJy4oErVDKz0YKYgl0FaNX0jnRBBBnHv4kEcSiEugkgXEOyRUaPFPp6H0QT28HFTcRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 06:21:49 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%4]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 06:21:49 +0000
Date: Thu, 29 May 2025 14:21:41 +0800
From: Philip Li <philip.li@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
Message-ID: <aDf89YA4rHGfOUvF@rli9-mobl>
References: <202505281004.6c3d0188-lkp@intel.com>
 <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
 <20250528175811.5ff14ab0@kernel.org>
 <bf24709c-41a0-4975-98cd-651181d33b75@gmail.com>
 <aDfiTYmW1mHBEjg6@rli9-mobl>
 <0b86612e-591b-46c3-adbe-538a1f1b0cba@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b86612e-591b-46c3-adbe-538a1f1b0cba@gmail.com>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 8598248f-9286-45e2-4f57-08dd9e791867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7grU35UL1t1GWOATW47AjriOEDfP5lsA5xvVcsItXzzizZRJwORYdkg75HBg?=
 =?us-ascii?Q?vXi2psa0nAkkf0tmx8XJQ/ER3Z8dU7/kqdjPzIMQ/cQnDNVMw5kNnW/JBpkW?=
 =?us-ascii?Q?vXMCOoWkAHgXCwtB3e/BUpqAqLQ+r6ZWUnt535A5YjrHgE74R79vEBDw/veP?=
 =?us-ascii?Q?FaPeP1qJANoCO5FLScmGwEUIM8rCUbIL3f4+yNyZ0By5lhbG62KJKLgC4/lC?=
 =?us-ascii?Q?YPHuTuYpGG6KI/kDLvcRgQBdTjhEVVuXbdUg8cikmOta8QXbHyy1iiZWfzFU?=
 =?us-ascii?Q?6u/Ck3k0ywLoIRc8Xf12XrUqsTKT26m3XopHW1b6uo/qloU4AdQqG+nw56sL?=
 =?us-ascii?Q?O3ozxWBrjj3hG6+yK64HouXxtRSOpUgSqgny+6r8M2iPyu7wII8RjQy+oYZH?=
 =?us-ascii?Q?u2oCOlscb8QCY9CTKy0ulsUjfllCD5qnqa7sIs/l9SJcSop/4yoBlpwzdob1?=
 =?us-ascii?Q?HSG8QyPlVxBTOCYrhZRwH03ww7GCxWR9qTP2HiFEDg9A7KzWNDfMjA4XN2dl?=
 =?us-ascii?Q?c05SPhcg0x/A6F8AoPRNQsuhe7uzCj9G+QxX+1IG74x3gY2izxIwsCFmWPTN?=
 =?us-ascii?Q?C+AXP1PIacLRV+MZ7K/wN92jJFC9hQnTtUdTZqFNeExs+aPfqEXgHXpWr9i5?=
 =?us-ascii?Q?J+8YJpZeJ70DTOXhmsRneoSL55G3fDHmAAPwZrgmZTvRAuapNmQkP5y/63R8?=
 =?us-ascii?Q?88ysuTvFMc5eBoIvIAYBksgWc1N661galE8vZWzGC/B2EGTslCdLecGls/zT?=
 =?us-ascii?Q?pkIaIIsfU6CZg6AOtC+ix3f4mThLKbCxRiDgy89vICW6DiKRcYD3ziJXSXL2?=
 =?us-ascii?Q?f+soVLOWEYRDw6JheXQ431kB+5CCjEWCXz3TbOUz8ahPK6KgPC/lU3GJcmLm?=
 =?us-ascii?Q?p+AOnSL3Dp7OedhklPSAEgcBR3pgRprvLDHk1umSDyfzFCN3BSnhKjZCESzf?=
 =?us-ascii?Q?J1n6lLALz67DXHVyH3oGXpEwuDeqi7riNquWIBD8t2J5ExJl0Bnes50bAYlG?=
 =?us-ascii?Q?/lONFFOnH0zpkVSnYraICaVjdTsQ71PmCVQbrXs2TZTGOAqFJrwx6GNmu6ZT?=
 =?us-ascii?Q?zujmkaTZWhbfi/Kmu1zqyavhYDxW5zhWNZKNVX4I1KAYWOd569QawE+LF00t?=
 =?us-ascii?Q?upvZRcOVLySWjyE/FvSEd74+Vvg4HrrcNKwGO2nVWqRvDZmpCDBqZLyYFMlr?=
 =?us-ascii?Q?3cM5Ji5c3rBIL5uO/ROFCArP1AhsghXYB18bWZSozTIvoPPiYwQd5XxMzSoH?=
 =?us-ascii?Q?CoTNvMd7SlRjID9ChXU1vgf2IHNzqk5TL6beOCW4UNB+ZooXk06pHseNxrB3?=
 =?us-ascii?Q?PfbTojf39z4EbCGIb0+XT8BdxmtuSN73mp4QZ66Op81u6qxFuZjY6bAJuw+u?=
 =?us-ascii?Q?nU9Kt0bWOsq70PT2EYrvQeGFV5wk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wI0kN72gMOJ3pA5jap+Qk9W4IylK0tBXbQt+CDoGkJ740j4SOAjRpdYsGW6N?=
 =?us-ascii?Q?h8T1VNn/4lmaIg3KF49XLTy4+mV9SGPU26p/edGDTZKfPtRQ0L9a1I/OgLtd?=
 =?us-ascii?Q?JzYclIWAOjNR/2UcJODxqgTvgJBmxV8ODZLYzp3UY5aFcdIkdBm+GeQf51V2?=
 =?us-ascii?Q?LhV5cX6cgCHGoviqX1pe2FLVPsO5W+3rKOBAY46I4VPswxJCED0O50MbYZLc?=
 =?us-ascii?Q?7nSBvBh2b1VEd/Ev2Oi+L2sHom2Nlj1AAWwW62udfPridzCPQsBiYKeVp2TM?=
 =?us-ascii?Q?yebWAqC4j48+nIwcTdS9TrRmih4mAJNbsLRRmq/iZ/Hf3U6ActQWxyp7GPqm?=
 =?us-ascii?Q?VwZIV+befxMSOQ/5NrwdMYSA/GL/NKLEq9XgOgf4qz0MOvx/s4CuqTxf3mA0?=
 =?us-ascii?Q?cfaP9U4m+0BS+XSLJFkL7KmUc5BDs4lctGfluO0riBcLw3L6opUqvuNAosYP?=
 =?us-ascii?Q?fmuD3JrH5vtAMKjg56cBvscKBwhCnv+pW+O6SbmzgQp/zPtnEaC4JhUQyOI4?=
 =?us-ascii?Q?4ZZ5OlqLjpqYpyiYGYIDOlFE2eLrhO65KSd006IvNEDVyie7VbSup5w7Avpr?=
 =?us-ascii?Q?6uok6qmWUnOjoGQlPj6rNIv5Fhx/AA3OlqFfSwKj9LJFWj/pksfjjL3SH+vJ?=
 =?us-ascii?Q?/XZ3FoGjipxeSmpGvoRef1gKiyWXzTjmQ5/A+26zSBJUrC4z2SaZKoJWfhNt?=
 =?us-ascii?Q?MhH/EeBrsDK0NLN0uerjHA36F8ZlgaN/XpPtSBCinCAX6NHuETJNs7Y7vdXE?=
 =?us-ascii?Q?mLwoySKTbmLWJw1j7EoVLCLUR4fE0IHxGwB3pmLJvyHFEWumzYsCmD6p55Tc?=
 =?us-ascii?Q?Wsmqiyfqn5L3wVTzQYG/4ef9DIlPUvlJRjfwJ28qzvoNvO8LW8em/PW+SYGg?=
 =?us-ascii?Q?k6254OjiUf74s+cbeOpCc7LDX6XunC3GHitkVeOUl/hEVOF5BVMwn5BLUx8q?=
 =?us-ascii?Q?CIOiJn1GYAjv22eTkYBeQiQXsCzvEqvuW5062n0uUyCvW3VBp2Xe5Wa7RN3w?=
 =?us-ascii?Q?3Ac/irGHXDv90ehJBJdpm9/ub9jhe1Bx8//0XA9bHUXRTCPuT4vwAwd1hIuz?=
 =?us-ascii?Q?v13X/Db3ToZ/rgg2BU7GOuPoJmmmzv93aIUYTliHu7Rphv0UmadMZLhuH1yZ?=
 =?us-ascii?Q?0OEAG/3/n/nuEADpRE5fi2GHvTUKkCZ2kHCZSphV71DLw+d+1YGnunWmTqfe?=
 =?us-ascii?Q?rpISPZ7I2gL1xVuL2z3tCEJhiEaAgEPpUlpmSiMztzANJMNxtD5ED/G8vupq?=
 =?us-ascii?Q?du2rF3UcPzQ8Pjj82nbbcB0WYgHew7DEI7d7zRVZqusDmvpDB9Bhfd/KM3Zt?=
 =?us-ascii?Q?nAWGDgqWxbXgEcawwycTc2jGEUgvnSE1hFOmVwbxEchBmkwExgT19p/NXJ/W?=
 =?us-ascii?Q?NO1oe3iDhOsqGL7vHbn2Zkom7ci9Sx3ro5i9+4nDL4nmw720t9y42l7whcwH?=
 =?us-ascii?Q?BDqPCKczxrycdUvAAB1vqTj9UGS9DGNg+RkA0XN++skajPGVxEFX0XizhtRK?=
 =?us-ascii?Q?8FMvH+HkRdznENixt8N9dyscsrtLg4SaG8wu0NroWZuKO4hAUwqxkkaky5Ri?=
 =?us-ascii?Q?RjLILFFgZDxKcE7Cp/cyQb+dZiXqGULv93lXLLb5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8598248f-9286-45e2-4f57-08dd9e791867
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:21:49.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCnogs4uKfe3hGbdoHxd69I/h4QWf3T0igRlBWDjwVWXxwH9aYiAebLXxN3GQAeoDtoH9es+AIM+6qY4nnWdXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

On Thu, May 29, 2025 at 11:49:17AM +0700, Bui Quang Minh wrote:
> On 5/29/25 11:27, Philip Li wrote:
> > On Thu, May 29, 2025 at 11:06:17AM +0700, Bui Quang Minh wrote:
> > > On 5/29/25 07:58, Jakub Kicinski wrote:
> > > > On Wed, 28 May 2025 15:43:17 +0700 Bui Quang Minh wrote:
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > # timeout set to 300
> > > > > > # selftests: drivers/net: queues.py
> > > > > > # TAP version 13
> > > > > > # 1..4
> > > > > > # ok 1 queues.get_queues
> > > > > > # ok 2 queues.addremove_queues
> > > > > > # ok 3 queues.check_down
> > > > > > # # Exception| Traceback (most recent call last):
> > > > > > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> > > > > > # # Exception|     case(*args)
> > > > > > # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
> > > > > > # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
> > > > > > # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
> > > > > > # not ok 4 queues.check_xsk
> > > > > > # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > > > > not ok 7 selftests: drivers/net: queues.py # exit=1
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > The kernel config and materials to reproduce are available at:
> > > > > > https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com
> > > > > Looking at the log file, it seems like the xdp_helper in net/lib is not
> > > > > compiled so calling this helper from the test fails. There is similar
> > > > > failures where xdp_dummy.bpf.o in net/lib is not compiled either.
> > > > > 
> > > > > Error opening object
> > > > > /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o:
> > > > > No such file or directory
> > > > > 
> > > > > I'm still not sure what the root cause is. On my machine, these files
> > > > > are compiled correctly.
> > > > Same here. The get built and installed correctly for me.
> > > > Oliver Sang, how does LKP build the selftests? I've looked at the
> > > > artifacts and your repo for 10min, I can't find it.
> > > > The net/lib has a slightly special way of getting included, maybe
> > > > something goes wrong with that.
> > > I understand why now. Normally, this command is used to run test
> > > pwd: tools/testing/selftests
> > > make TARGETS="drivers/net" run_tests
> > > 
> > > The LKP instead runs this
> > > make quicktest=1 run_tests -C drivers/net
> > > 
> > > So the Makefile in tools/testing/selftests is not triggered and net/lib is
> > > not included either.
> > hi Jakub and Quang Minh, sorry for the false positive report. And thanks for
> > helping root cause the issue in LKP side. We will fix the bot asap to avoid
> > missing the required dependencies during the kselftest.
> 
> I've created a pull request, please help me to review it:
> https://github.com/intel/lkp-tests/pull/514.

Got it, I have merged the PR, thanks a lot

> 
> Thanks,
> Quang Minh.
> 
> 

