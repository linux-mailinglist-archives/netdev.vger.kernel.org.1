Return-Path: <netdev+bounces-153713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1280F9F94EA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E9E7A1C5B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA382163A2;
	Fri, 20 Dec 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm+en4nG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8251DFF8
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706411; cv=fail; b=lt8PU1ZW+zwdMw09UF8a8Gy5vmAEH6xCvuYIB0qk7fahPLevpPTa3sFSSJg2Gc2iLATzi3k7DMKd4jim6LJGfxlngcvRZCsnGkV1lAAqlnIf8jHtIofP3RHvLt9kTAay0ELknwcx54DDKLjO/q8w6nWyApQ7cEJnpsd+pSDFirY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706411; c=relaxed/simple;
	bh=S6VEUFT33nXnfsf297aEE8RnS4gmYGVJA4R3MI/V8WQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLC8c9phHRbW5dN7OMPRbfsaWRjMTgsUvRmSZtJUkT0jeY7LMTeFud8N74NrtAu9+LsOAEefHoGQ9JqSuecKQwFZNLAuRuecv5oaW122p9f7NJK1YzLKI5v6ZvHcDQRaGrYiJP5NKXRR1mBSzMg3Cw8c89tW511tPIt4UCVPby8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm+en4nG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734706409; x=1766242409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S6VEUFT33nXnfsf297aEE8RnS4gmYGVJA4R3MI/V8WQ=;
  b=Zm+en4nGmDiDAE56Tb64uSIUubYNYlYwfv2qAL/jKowa4M2vMtHUyoYk
   c3wtvKFRiBr0lOinJvuKiK7IVH+3dP37KUsKn90f5xeE5onH1XsejVUGG
   0J1YUNnZLKlF3FP19wzQQJ+X1k5xDuj84rwyc5g+AX+D8VkmP4SqFFGlS
   SPnw5tvuglcAVykMSLNGAdpG3DsVvz5MWHBinztS3hTly097fE+5H/V+D
   q5+hcdklQcSlhB4VxHDApAwqnEHhy89i4X1r/w2bNB5HFzgssF+EQMwqb
   nhnuiLRnTnL01FSyV8g5dL3DSWI4qjIV3GmIOquGOW63+mJJDXCVdtxlD
   g==;
X-CSE-ConnectionGUID: QBGQQurPQiWSt8WyDRQ0oA==
X-CSE-MsgGUID: 5VePhB7QSiyrxZlCtCvbfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35473714"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35473714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:53:26 -0800
X-CSE-ConnectionGUID: cvsQGMBGQdKKTLde5qNeEA==
X-CSE-MsgGUID: w4i7uk4XTymO3uSaEWKgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103518614"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 06:53:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 06:53:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 06:53:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 06:53:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5fsqDXY0dI/fnTsANOl5NqcS7vGoFam8PWhIcEleaPU65wM9tXEeXsMByCwaN2qdHgyMZQx5H/ypLjaBgfgz35dGOwSXGJNR6EuBpNa11YvvZjO1BKKYVSYvraHUDPjEabNhbiCrmJr+/98nY0cd03omU62YP602iymlOUxvZ1uuVs2/uWWr+UnzDbNYrgMsHKwcaGRWFPhADJO5Kwg8iBqhmWqnQyYevrvlC7V46Xokm2wXSLJkI9ULmXCEfGspknrIt/sGv0uqXJ/tuK6+IVzSPZYwYIwGHsz0eUY3zSUMkcoY/zGAicFmLw0TgX1WSwOUOBF7Nv2Fp54c4ITUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SeGUtrobBKg8P3/nVrd80PsXRDm1vFnfjqwoLYrI1o=;
 b=QiiY6UpUqO85tJ5I84GHDBC9Zkp0WJyTlpiGOFb9MqxLsI8YCre3n8uEcXwGS8kpw+qokpmH1uT7efGLdoSEfNSjpTyG9FT0j7LvletHuY1UxcbghlqP+W9I6U3MLt/uEPqV9FCDkI6wNAczqruyibg4UKDW5ioH67gM1WGYvnOVrADYeqxf8UPiQflyKccbY0IU53EXmtkVhA0Z0eaDIVvvUEYnwC3nqjkOD8EwRYXtRPUdzNUK1KV6Trg5g38Um4somUXPVrYliSLm4aLCJS9P562UuNRj1xgYi0X0YjlTMuCamyUGQq9uUh+B8snOnF4iOdHnggctC/hHtfhkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:53:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 14:53:23 +0000
Date: Fri, 20 Dec 2024 15:53:18 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] eth: fbnic: reorder ethtool code
Message-ID: <Z2WE3u2xrBw8XYxr@lzaremba-mobl.ger.corp.intel.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
 <20241220025241.1522781-2-kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241220025241.1522781-2-kuba@kernel.org>
X-ClientProxiedBy: VI1P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::19) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CO1PR11MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a90b3a-37d3-4b6b-c6c3-08dd21060d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TGXOgyWNVZja7PE0lgM8Z/VrloJ4pccN8l6tbv2f4r50RsCAeVxyrH//czOf?=
 =?us-ascii?Q?s0inIdLQwIXe/ByQsUU84CFfEIesvWaCFBjf07g1kIp+T0xcZ+INmO8SfejW?=
 =?us-ascii?Q?PYlesdUUCWlWXhchgDZug2FMqlaxTyXPv+4Fu1gZ2Zc9TII6U4NCzLRDt5IJ?=
 =?us-ascii?Q?GZuQBGXGxD/WkSKJXgRKRo8m/ghb2gORJTSGqdJNRVC6Xh6uyNFZP6t1rIHg?=
 =?us-ascii?Q?bD9hAnkOWv43m4sGL6poJDqHJO21jcHhOMii65ZXtUflziaRpzK3D3Kwannz?=
 =?us-ascii?Q?v9GipYanNVlefsEYaHCAqGkQTOER3l2eR8THDIXl9wEpq8DVnsy46AyEiFIX?=
 =?us-ascii?Q?KbuDB1I0VZhKUQ+kAlrMTCD2DFrIV4Spc/cAhOVoBdlbnRh33yRzzPhGaDDZ?=
 =?us-ascii?Q?Q6/VGvCc1O4pIRn6+SpcU5T9AYUHjn8AlkO7X4LKsAGpoAHKgS4vaDJiaAwm?=
 =?us-ascii?Q?xOfJ406ZuwmToM4Phg+eaV4wfQ10W9bwtRziooW56/WQFe9cko1JeIf2w1hu?=
 =?us-ascii?Q?5YSxYYvmgc8KeBFMSMYKqElQUpCzUOnxJCK6yk6PJSPOOVM4jjCGvu61P+qf?=
 =?us-ascii?Q?TzQYO21bi/vnRXBPsUJdoz0MxJkWnWJyMqoRZR+BBZmV9dlVLK7Xeh9IqBYZ?=
 =?us-ascii?Q?eYUn4d9JgeUnEJx/GcQRR6whAtVO3jnnTLBZQdZO4kpUBMed/XM0HpQuKLOB?=
 =?us-ascii?Q?mo2znrYny+KKBE3XJ1y6tR4oCOpDtmIPcH9qf5EHq/INv+NSqH4JcNij+iJ+?=
 =?us-ascii?Q?dl0ZeVQrSgOhjcrFi4dkrRAbS2MDm17U7nLR4BKretiKaTxYtgVtS34jcacY?=
 =?us-ascii?Q?VUhySFwUOE2sIvLek6WKSHMUmlzzP879FQrX2YKonmhXpUjtE0MNMwtV5e8u?=
 =?us-ascii?Q?lsNQmUfxzB/imhXozw4tjSLo6NdMamcNmSkBu2PbRA8wo5gIEVl2gPbD1Tci?=
 =?us-ascii?Q?u2DVWFk61d+ZnHbaoCKFh2VNBPXFQkDqw2NEj9AL2VoTqwlcHQfTQ2gGRpDK?=
 =?us-ascii?Q?FCYkv/iexXJbwIcgZwGybtfU9Ia7Xy7sCLyzhHKFGq/KPsgjmGZ5ASIx+a5z?=
 =?us-ascii?Q?vVLvsaUCi0XKFdabvFnv+Ckylwh5Mp6mKvteyfWIfTDEPoZIUOBMaYMf58Uc?=
 =?us-ascii?Q?K6hNjwlPJsRSmbYJQFCvqZ2g5uPK60fUB+MyXG+TIi4ixXUojAQpt2lppNKj?=
 =?us-ascii?Q?zQy8y0RlPqXb75jmx2FWMsuP+IOtJLTBNsNtmdjKu/gaF5EJX9nb08E67uxG?=
 =?us-ascii?Q?wd6pk5ftWHoJLLFJ+4NtXDiYlrD2ei/QX+MgjqqyHLJBY9+k11T1hy8ZLalm?=
 =?us-ascii?Q?i0j2gIp4It1Yd3qzfai9waMIC+Pb1F+PTiEOaIE1u7JF/I8Rb1s9H/GRs6bS?=
 =?us-ascii?Q?PlYSIdPiQTxVkxIHeQK1KYbxiB7U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ktkwOoN3nIh+MQyDdEj/I8G0Ufdo/Y/rfw5HRS+xUIFRL40rI9vxuURnzPHP?=
 =?us-ascii?Q?RTNmx1Yah4uF50HAZGFncd086LZSJj7Sr5ovbjjqSEbpcmx7+TW1oBFSUYLl?=
 =?us-ascii?Q?4Iky1aTFWhG8nncqajW4RsdRVawIi6fjNn8ZjIYhfNL0b5Tvh5Bx1lCW/+RR?=
 =?us-ascii?Q?lzv7dXozOaclFBXcytnvyrWw7wsWQk9UGOgqrK9fD1uu7LMrUQAhCCY78mLn?=
 =?us-ascii?Q?kOPJWpJN7V5CxAQo9rQyVSb8/Gr5TMqnUJ15hzdg57+AN33yypE6xUVaX3Gx?=
 =?us-ascii?Q?3EQvhr1qQH/93FO66uDrrhTXdhUHGwwPH6zt5QwbMLTzPmDzjTFHHHzkC8pX?=
 =?us-ascii?Q?V3VbaqeBT7mM6CT4Fd0pyNx2UZcfDiowx1qqBSWXTIf7xo6KF6tD0zKid8rZ?=
 =?us-ascii?Q?gw2NP/jdad+culuNiVygrMySRKuKZsu4sxFMbrYBnmIS6ZKOtt/0Bn99sIX8?=
 =?us-ascii?Q?gjkcS6HKPHWAgkpxfiNlFScK+dzGAjlsPxMNEY34ffp42hhMIRfcwIi5g4R9?=
 =?us-ascii?Q?Pj1/a1g/R7uRSpYaYRklftSvX5RY022GLpr075nJC7oXDod34ZZ0cAG7/i1r?=
 =?us-ascii?Q?jgAGgH9x2jfvSR4tykEoJliZdhIxmXhrZtJOBcN4hdxaeKgIfhHFfNdwX70B?=
 =?us-ascii?Q?pCe71YVVjxj+4gGypaRVVHecI6/TVBfzH2ouveYFWDWYGslZCpEogITnKlh9?=
 =?us-ascii?Q?b91d9IJA4bsZazu8lwtUTOU9TrQMx5m2k9NtdZWTESsemv+TeSYjHuPWZ1XL?=
 =?us-ascii?Q?2dWTUSnHmNymiNiR9epF5iHePHbzx6sCOWkPLTFz/DxCCI6jLAvDO0fy1TYm?=
 =?us-ascii?Q?fuKhyP5GsakA4xZgIgYE8OOq3b9mzC9diLvY682cmlTagZKThGle1wD+QcJi?=
 =?us-ascii?Q?dZkp7UQFgVeoC1BCUnXL4kw//rAn/wyq5ijiVLwg7G/YzsyCuA1qUzB7g7Cr?=
 =?us-ascii?Q?iiatbzOHBLl8uKRyLKqLVmbXsYEBLGytHbj+h/kn2QqPa083WXBMHHxBqbnN?=
 =?us-ascii?Q?VZfTOyInxiM4/e/30rWkPQsx014twGVpcz+lko6rP7rz6erkq+EzbLsuG4yt?=
 =?us-ascii?Q?T5AVRM6UsyfZjCaXqE82jg9mr6Gmukyn8XK7qF5rRjpBqJPc80xM4fKGlVb5?=
 =?us-ascii?Q?rzJigZRfTeu0VQ2IjJiYN7bwUocmHbrfXc4ZpFet6Rimcqzwzn8rM5OGFafr?=
 =?us-ascii?Q?Q25A419xjhWtborymqqnvJNmSnMABVdr6QV1/6XOcxLu53py2ifLH5uC0yT/?=
 =?us-ascii?Q?3xgE9f3ayTL+Px3qrO05nlaRLOM63QZ6+hNIc0AsLRxrtmSluOsIugoOzgpD?=
 =?us-ascii?Q?f2JGShaD2/Dm3E5sEElh3j2ocyoq5X/MfdpbQCqOJ1jM4YwXMzJ1cqGjIKQO?=
 =?us-ascii?Q?d76SsGj8E8iWv0XvyO4J1pQ2du9cEwRR4NeLHt8neWy2McWPpnFkzvsNb3O0?=
 =?us-ascii?Q?zVlRefa4c8ofYQxbA7Pqn/IuraP8595BTn0IhWXbZqIKUhuII6/OlOMoay/m?=
 =?us-ascii?Q?14AsTuhUeYDC10c+kVrHBxZH/ZXmBlKcjxkXANX8S5lg7+rwkeZqnRArYR+i?=
 =?us-ascii?Q?cLTN2uHz8pfUfnR0oZyJDlESL9/Bm6zTzHO6jjfB4ebyb0DT/8o8OTbGfBzs?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a90b3a-37d3-4b6b-c6c3-08dd21060d87
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:53:23.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3YWwdB6ys6ayIekNAJUs1zqu+A6NW3B2WS6r/crg0KEgKAz42kapLAKR31xgCR9dyycPep9cmc0XEmZK76h9Hj1rxbRx+dDaurCUfis9OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

On Thu, Dec 19, 2024 at 06:52:32PM -0800, Jakub Kicinski wrote:
> Define ethtool callback handlers in order in which they are defined
> in the ops struct. It doesn't really matter what the order is,
> but it's good to have an order.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 160 +++++++++---------
>  1 file changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index cc8ca94529ca..777e083acae9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -40,6 +40,68 @@ static const struct fbnic_stat fbnic_gstrings_hw_stats[] = {
>  #define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
>  #define FBNIC_HW_STATS_LEN	FBNIC_HW_FIXED_STATS_LEN
>  
> +static void

I thought type and name on separate lines are not desirable, it could be moved 
to a single line in this commit. Assuming such adjustment,

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

Also, this would be a little bit out of scope for this commit, but seeing 
relatively new code that does not use `for (int i = 0,...)` is surprising.

> +fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
> +				    sizeof(drvinfo->fw_version));
> +}
> +
> +static int fbnic_get_regs_len(struct net_device *netdev)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +	return fbnic_csr_regs_len(fbn->fbd) * sizeof(u32);
> +}
> +
> +static void fbnic_get_regs(struct net_device *netdev,
> +			   struct ethtool_regs *regs, void *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
> +}
> +
> +static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> +{
> +	int i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> +			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> +		break;
> +	}
> +}
> +
> +static void fbnic_get_ethtool_stats(struct net_device *dev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(dev);
> +	const struct fbnic_stat *stat;
> +	int i;
> +
> +	fbnic_get_hw_stats(fbn->fbd);
> +
> +	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> +		stat = &fbnic_gstrings_hw_stats[i];
> +		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> +	}
> +}
> +
> +static int fbnic_get_sset_count(struct net_device *dev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return FBNIC_HW_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int
>  fbnic_get_ts_info(struct net_device *netdev,
>  		  struct kernel_ethtool_ts_info *tsinfo)
> @@ -69,14 +131,27 @@ fbnic_get_ts_info(struct net_device *netdev,
>  	return 0;
>  }
>  
> -static void
> -fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
> +static void fbnic_get_ts_stats(struct net_device *netdev,
> +			       struct ethtool_ts_stats *ts_stats)
>  {
>  	struct fbnic_net *fbn = netdev_priv(netdev);
> -	struct fbnic_dev *fbd = fbn->fbd;
> +	u64 ts_packets, ts_lost;
> +	struct fbnic_ring *ring;
> +	unsigned int start;
> +	int i;
>  
> -	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
> -				    sizeof(drvinfo->fw_version));
> +	ts_stats->pkts = fbn->tx_stats.ts_packets;
> +	ts_stats->lost = fbn->tx_stats.ts_lost;
> +	for (i = 0; i < fbn->num_tx_queues; i++) {
> +		ring = fbn->tx[i];
> +		do {
> +			start = u64_stats_fetch_begin(&ring->stats.syncp);
> +			ts_packets = ring->stats.ts_packets;
> +			ts_lost = ring->stats.ts_lost;
> +		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
> +		ts_stats->pkts += ts_packets;
> +		ts_stats->lost += ts_lost;
> +	}
>  }
>  
>  static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
> @@ -85,43 +160,6 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
>  		*stat = counter->value;
>  }
>  
> -static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> -{
> -	int i;
> -
> -	switch (sset) {
> -	case ETH_SS_STATS:
> -		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> -			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> -		break;
> -	}
> -}
> -
> -static int fbnic_get_sset_count(struct net_device *dev, int sset)
> -{
> -	switch (sset) {
> -	case ETH_SS_STATS:
> -		return FBNIC_HW_STATS_LEN;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -}
> -
> -static void fbnic_get_ethtool_stats(struct net_device *dev,
> -				    struct ethtool_stats *stats, u64 *data)
> -{
> -	struct fbnic_net *fbn = netdev_priv(dev);
> -	const struct fbnic_stat *stat;
> -	int i;
> -
> -	fbnic_get_hw_stats(fbn->fbd);
> -
> -	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> -		stat = &fbnic_gstrings_hw_stats[i];
> -		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> -	}
> -}
> -
>  static void
>  fbnic_get_eth_mac_stats(struct net_device *netdev,
>  			struct ethtool_eth_mac_stats *eth_mac_stats)
> @@ -164,44 +202,6 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
>  			  &mac_stats->eth_mac.FrameTooLongErrors);
>  }
>  
> -static void fbnic_get_ts_stats(struct net_device *netdev,
> -			       struct ethtool_ts_stats *ts_stats)
> -{
> -	struct fbnic_net *fbn = netdev_priv(netdev);
> -	u64 ts_packets, ts_lost;
> -	struct fbnic_ring *ring;
> -	unsigned int start;
> -	int i;
> -
> -	ts_stats->pkts = fbn->tx_stats.ts_packets;
> -	ts_stats->lost = fbn->tx_stats.ts_lost;
> -	for (i = 0; i < fbn->num_tx_queues; i++) {
> -		ring = fbn->tx[i];
> -		do {
> -			start = u64_stats_fetch_begin(&ring->stats.syncp);
> -			ts_packets = ring->stats.ts_packets;
> -			ts_lost = ring->stats.ts_lost;
> -		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
> -		ts_stats->pkts += ts_packets;
> -		ts_stats->lost += ts_lost;
> -	}
> -}
> -
> -static void fbnic_get_regs(struct net_device *netdev,
> -			   struct ethtool_regs *regs, void *data)
> -{
> -	struct fbnic_net *fbn = netdev_priv(netdev);
> -
> -	fbnic_csr_get_regs(fbn->fbd, data, &regs->version);
> -}
> -
> -static int fbnic_get_regs_len(struct net_device *netdev)
> -{
> -	struct fbnic_net *fbn = netdev_priv(netdev);
> -
> -	return fbnic_csr_regs_len(fbn->fbd) * sizeof(u32);
> -}
> -
>  static const struct ethtool_ops fbnic_ethtool_ops = {
>  	.get_drvinfo		= fbnic_get_drvinfo,
>  	.get_regs_len		= fbnic_get_regs_len,
> -- 
> 2.47.1
> 
> 

