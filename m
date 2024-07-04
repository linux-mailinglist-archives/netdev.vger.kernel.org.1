Return-Path: <netdev+bounces-109221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CC927737
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC62B1C22A92
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DE1AE840;
	Thu,  4 Jul 2024 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3GZJHLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2626AFA
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100040; cv=fail; b=lI5GaMkPbKZn9SG1yPgpZbzLT/wv6S8cdy3lJ7JvKDU0dr0ejZYpsFMgOPhLt6uFWi4Re1uZ/pQLRG0GJWdOVAMZUE8DKxsmYixY+OQOkJqlo+jOCgFnjABNxVFxme/DT45tTDhDAY7K6+N39uZjrVavC77rgRg+a32mEpt7FCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100040; c=relaxed/simple;
	bh=PX4UIFPQkjTDzbM/LwIeDBsYRDWcQnX93yE05tczSuY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q79kr95pnNwQcrTMWIaa2LU6S12Ah+E9HdmKRlZ0Y0lgqe9Z2BRU1lkWfR1cbP/AU6wNyla0wnQDi2iLpUrLdN5rqU8jxJQcec/+l+SKdp6FVvo4co6ljptQYVvlqe5GWzpdxlOYvj4iFtYfCRb1mdx4fQ4ozLGPWhAGLjbp0Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3GZJHLJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720100039; x=1751636039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PX4UIFPQkjTDzbM/LwIeDBsYRDWcQnX93yE05tczSuY=;
  b=h3GZJHLJ2ifHqUheEA5LglqtdeRm4TK9YNwKCo5RHQmMOYyTmfYLoUWc
   lXNBKsevvQmLRnMMUUbnoXisj/cSSTtM3YsgBgmzXNPJ2dLPv6b4at9CP
   ZEG9v9mEAbCy3q7dqcRP6LTG0MrLL8YxoefaWnzR2N7uJAC6Maam2T6/Z
   gcKvtfg275kO72Cd2BnBvezIDhhUTNche3su+IFZTbxdOK7E/z9IH7RWY
   Ty6Q2/BtJQZOUB5fjERlcj/ybWRnYshwl/k3Q+TWBAs6NOHzB6lVV8hNH
   m3NlyuDFKiQvHFSFS4sCjCP0P61nTL00EIjM1VYfPLjdLvrjlbKLSB5LV
   A==;
X-CSE-ConnectionGUID: L2/I2gOxQQubY2YYbgh6YA==
X-CSE-MsgGUID: 8M8rUp+NReCNRmAbfqQSUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17589564"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17589564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 06:33:58 -0700
X-CSE-ConnectionGUID: yFCp50ERR3a5zWKFkHo5ng==
X-CSE-MsgGUID: lR2SPmfxQTKtRaVvgp/VxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46567336"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 06:33:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 06:33:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 06:33:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 06:33:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 06:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdWL6LM6yA9Y//Q1jKaZhZx6wNRqOFEw/b8G85eky0TCoJK0XID7tev40iB/fBcN/ahu8t02Imd68YPy2IbKBgayvyISw0kk8YLzVLuOv3O7rYMdXxYKD6146uKOdSjQ0InR11AiOaQV7p7jGwhOfhfHiJJ+naxSLRVVptkPveLC1lV1xyuoMGFzyUn/LQ9Ulne/zE4KSBPJbiiHSwmAedIUs20hcRA2K0KbV5WmgNxNWLRsD5jHnVsbisfe4w4XI2fVHIN3eUcCr0zjRV556n2RBbIj+qOzuUJf3mvGkeJ8y7Bi5LgyNGXoCyeXkHINZXeh73WdJRBihhRc+ekZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVkUWHCgX5MkI4G0E9exacqhzfgLkhLL962otFyZCZA=;
 b=YXZhWVLTsyNuLHR75LNDiuqFkbtZcBiN6Hh7l/Z1WVeK6I4gh0a1XOcAlTl9EG6drbiFC7cAekZKqpiEht5sfe4+RjYfvH24Z/Cl9CYIHfodDdyk+Sf+ltd/5BNoxAUXQs7qTb26bphwcZLsaXOUjOEShGeJ5/4Cc9+/96wYuUYXF55wn6iDxsCouhkpkKAQ1d/tcYUP4cvn1BBDmzhZQhIaOhSW7CrRHnV3kAWHRJDGLFmwlgmu/w/FenJmmdtAczeYBEbkpBwEoW+7ZV3VDi0VuaINldEcsHEcbkfHiTf/GYPqKbqTgiAAFD6OpGHd8f9nItXRgrJKAgV3oIYB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 13:33:55 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:33:55 +0000
Date: Thu, 4 Jul 2024 15:33:48 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH iproute2-next 2/3] devlink: print missing params even if
 an unknown one is present
Message-ID: <ZoakvNeIz2WK33fj@localhost.localdomain>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
 <20240703131521.60284-3-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703131521.60284-3-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: cd518248-f6aa-4224-7236-08dc9c2df349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCK0KVx96GKU06DzUBi1YAePFp0BgOOITdCk1+FO5aC47RfSTqschip2H9ck?=
 =?us-ascii?Q?PTTImZzlrmwCUxsW7smrLdSGb+UWniaSwX3ofpBMTEXAZiixeuAC3Z9YrHHK?=
 =?us-ascii?Q?m3Hr3PpaDbQdyq3MwO/YcJCTTRN2/r9oeJMsdA+Dfb/xbYJvJ/F227IJrb+F?=
 =?us-ascii?Q?3kmKN/bV1BTOkS6KFIWqa/zX1eh8OxRxnhtF/xqOwCd9b1g4jSH6YZYis70F?=
 =?us-ascii?Q?rBdctYlmNTU6VCkFyNkIOt88DJwQFxVYK3vSjQ0nYWOU5L0dHLx8XsQtevjs?=
 =?us-ascii?Q?qVU/m6drq4gcYe7TICQGgXCz+SOiWhK86OoSM4gqwdFsSjP2Axn0a+MUw24c?=
 =?us-ascii?Q?pUsCLxuSaJAZENClV2DOq73zmRefM53P8QZQGrSGbkcaIWb10lsI+jY7rlVA?=
 =?us-ascii?Q?3nas102c4gpGxHWQJTOAT6VENeWm0py266miQ18FXEZno4kxCuNtqpbIJNqc?=
 =?us-ascii?Q?wIf4EksVBTT741ut2Q4tVTveWnUWQutBynoeWeB9wEXIwyXJxGVNDyChi55e?=
 =?us-ascii?Q?boZX963aP3+j2GkYXQa2E75ZmER1vK6o9BniC+cD7Oq2bZApj105St5D4oBQ?=
 =?us-ascii?Q?2y025qwjRwMbw2wWL/86+eRr+IXaYYorC/LLGnFy6qW6cFBIV2E4VNjGdHDX?=
 =?us-ascii?Q?4gTtP2nsaciqNAsMLK59jOCancQkkv3AAOZLCTurJZG9i7BtPUr1HmQ+IqUw?=
 =?us-ascii?Q?u5Fn+hOGdYSqpQjry3ztCF+6PKAUaXGrdc3CV7+oA/l58cCtIyUD1gvZk5Pp?=
 =?us-ascii?Q?o+ciwJn6eto1ffzealWmk8YZyhrllRutKM+5QQTGWk9cpodDslX7J9YCsMf3?=
 =?us-ascii?Q?grwSJmshrpz11yKYNhZ5gCpxiGurgl595QTopNgg+mw4cCQag/9tw03Fb/pl?=
 =?us-ascii?Q?5xCeJ0psWCeAx0MbjtWdssmRcwqUY4dNYXkhBpkBri10fhkGexI7biIhFDRH?=
 =?us-ascii?Q?7dja0u4Qs4FQSFHxCgN4axI5ObjtryPR/hCm1ULp4EQd5sl/05ipuv0MdhJw?=
 =?us-ascii?Q?7gdjReO8zqUoNG6SKSdTXqDhC43yqc9unj0kBKba+ldpPBNu6kNWiiUinCt4?=
 =?us-ascii?Q?28EHwuCC8FaKsrDCMczZ3BFQzNjYHdtOvIF3o8cPbGuXyDAcU9vPA+WIVYoF?=
 =?us-ascii?Q?hJfsx69oRl45PE0vQdJWrusze4pKkJzEyQ8AXf5GFKcDXrPwBomcVBTadv7G?=
 =?us-ascii?Q?keaEd1OzTNGvNQ9QNjj8oMD7dG5e8gEnr3AQsgmgDEBNHLNE2Su84/UiP1O7?=
 =?us-ascii?Q?fN2Jl+gGfeiOkg/XUU4V5VwCXA4ozd72Us0nHjlpgxpg55zhqDeh3rkYQJp8?=
 =?us-ascii?Q?jiH4ZWHM8nEbbmMcuA7fZCG7PSG0jh/ELqswieq5dgTBbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hM9BOunFh/odSd5MDetYdzk5ggUOboxQ5a8UzNt9F+8eg4r3+UXZIUZcruqd?=
 =?us-ascii?Q?qusLyuOe0sKsUO89f05zmCztxbn7jMvFH+nJrwe6IWlkpBa8di+aE8xF8Bfy?=
 =?us-ascii?Q?tK6JGlWR7XLOQl6Wt5H63lBxxIOZjhQeGrdsoJPO9I0qkdieM3pAfkPM9eJk?=
 =?us-ascii?Q?SLBuVkNjw5AQKzef7EOt+wYg+z+dyBTTLS9CoDmXcNuipi6YS1jly7lGuHa3?=
 =?us-ascii?Q?KdNz6yw66qlV/bhB1WEXKTrsn88D5OGu6rHGp/c7olcjjPW/xgdwFvDHziTg?=
 =?us-ascii?Q?RvGrE0LZKF7+9/1KyzEnwZviF1ssWnKaI87nO+Bs0b3j2bANi/FLhkLl5TNR?=
 =?us-ascii?Q?/AmmtL2aE+2ktyNrg2F9MuHMJXFRLi+VqEKt2QLLYMCwfNvpZVO0p0C7OQMK?=
 =?us-ascii?Q?NxOrOYmlnQHuNulojVALxCk1Ct2D01wtvPmihJg0pcP4JPxZpg26hLSKCPyU?=
 =?us-ascii?Q?DHwtCjZh/eFGurtW2HFuFvBHTpbfkAi0xyl/sZxxK/YjynKc06JZdMz1DeB2?=
 =?us-ascii?Q?WVYObIOcTzfDSwPgOU7EdT8E5sXaRxKOVALvPHSG+qoFYLKZOwn66dOZKUeL?=
 =?us-ascii?Q?B1i3kATnPYaxN/kfSm8DbX3Oji2AAY3pTT11Kt0hvq4LZg50gpErEBRfGeoi?=
 =?us-ascii?Q?dv+PMVzTtS8kgrOMcV+Aa6eIOl/c5wgRVeLWYhnTrG/oOiQrE3Ewyn8Xd3F1?=
 =?us-ascii?Q?MFQpCvA2lSuRvTfW/6e5ZvTXWdJ8Xc/0Vgmv/hjI7jFatJj9clTcv8wW1UB1?=
 =?us-ascii?Q?fp+/X08n6hki7h2ZFF0Jugr0SeXP8+ZcSbuTx2toc0vAwPVRzgLkCZJJX7uo?=
 =?us-ascii?Q?zrPFqoNpCuiHojCjTOpuzSdmiN9t4pD8SrQTkyKqM99JV+tf4zFA/UMddWkf?=
 =?us-ascii?Q?8wJAUa9EvHjzbjK97c7uAMgY9WAaQwoWKeF0z1qDFkdiUHkP7YopEW526BGW?=
 =?us-ascii?Q?S7Djg5y6NqvszaC4397IuR0YpP1ahIGEw2TyW5UO4tCkvlTyg7nWpeqeiZmW?=
 =?us-ascii?Q?mZJtM8ksFmamrcth0q6QUgmfe/R8lY7y8twcouBFkOBdAJsopXX9XG8U7Eaf?=
 =?us-ascii?Q?u256F4DW1/rciB1HlLdk3dPMC4s8/T1gp/ZXQ8M2woKUGZizT/H2xhhusd2U?=
 =?us-ascii?Q?98p66MnShSyAjddwtB5GZnKbXf6CxDPOSJV6uCsFiHjU2OOEnui9egt1/4V6?=
 =?us-ascii?Q?jH3UfJej1X6Jd4Zd8ebJBaiFizjjR1wCG7Vr8sgo9xmFJ0GOTMEFvq56I1hK?=
 =?us-ascii?Q?ECTxYx3oBO5/S/pr7HyGqm2BuHp5PYfQU0K0z/d/5wIjUreeDNK8mEGVZXfB?=
 =?us-ascii?Q?yFu2wxBX9daGj4cb4G84oIETFfqBJqNNoeqtdDeus+fRio10OZK0cIgHIo9X?=
 =?us-ascii?Q?OAbMLjsXAJdXqctPSGq7AeHLBz76+/hSB/L+OnedeVUWRi5jiUYBhe7SFkcC?=
 =?us-ascii?Q?DrGRbwhWVnu7yInsn11ykTnuOhskPFc68/+KJ+1cViS71/rx/8R4exesvTwa?=
 =?us-ascii?Q?okaNcUQ5HMGDTB5XDAKf3gcqq3mcz3qPglkecIRb1g5krqPbD/e3A3bpg+Ro?=
 =?us-ascii?Q?U1IGSzX5lX+I/SydGFAFLKt78373cPQWz7vTKGja2BKZAVAlDJTv2wJQhWZt?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd518248-f6aa-4224-7236-08dc9c2df349
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:33:54.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0AAKJOK9ydrVVM/IDCRQJB3+ljYmJBpqcbsks7gQjvNbZ/yf6v6p64WiSgYdNWF7ekUzZjNOt9btNdIy/qnIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:15:20PM +0200, Przemek Kitszel wrote:
> Print all of the missing parameters, also in the presence of unknown ones.
> 
> Take for example a correct command:
>     $ devlink resource set pci/0000:01:00.0 path /kvd/linear size 98304
> And remove the "size" keyword:
>     $ devlink resource set pci/0000:01:00.0 path /kvd/linear 98304
> That yields output:
>     Resource size expected.
>     Unknown option "98304"
> 
> Prior to the patch only the last line of output was present. And if user
> would forgot also the "path" keyword, there will be additional line:
>     Resource path expected.
> in the stderr.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  devlink/devlink.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/devlink/devlink.c b/devlink/devlink.c
> index 57bcc9658bdb..9907712e3ad0 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -1680,26 +1680,28 @@ static const struct dl_args_metadata dl_args_required[] = {
>  static int dl_args_finding_required_validate(uint64_t o_required,
>  					     uint64_t o_found)
>  {
> -	uint64_t o_flag;
> -	int i;
> +	uint64_t o_flag, o_missing = 0;
> +	int i, err = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(dl_args_required); i++) {
>  		o_flag = dl_args_required[i].o_flag;
>  		if ((o_required & o_flag) && !(o_found & o_flag)) {
> +			o_missing |= o_flag;
>  			pr_err("%s\n", dl_args_required[i].err_msg);
> -			return -ENOENT;
> +			err = -ENOENT;
>  		}
>  	}
> -	if (o_required & ~o_found) {
> +	if (o_required & ~(o_found | o_missing)) {
>  		pr_err("BUG: unknown argument required but not found\n");
>  		return -EINVAL;
>  	}
> -	return 0;
> +	return err;
>  }
>  
>  static int dl_argv_parse(struct dl *dl, uint64_t o_required,
>  			 uint64_t o_optional)
>  {
> +	const char *unknown_option = NULL;
>  	struct dl_opts *opts = &dl->opts;
>  	uint64_t o_all = o_required | o_optional;
>  	char *str = dl_argv_next(dl);
> @@ -2313,8 +2315,9 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
>  			o_found |= DL_OPT_PORT_FN_MAX_IO_EQS;
>  
>  		} else {
> -			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
> -			return -EINVAL;
> +			if (!unknown_option)
> +				unknown_option = dl_argv(dl);
> +			dl_arg_inc(dl);
>  		}
>  	}
>  
> @@ -2325,7 +2328,15 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
>  
>  	opts->present = o_found;
>  
> -	return dl_args_finding_required_validate(o_required, o_found);
> +	err = dl_args_finding_required_validate(o_required, o_found);
> +
> +	if (unknown_option) {
> +		pr_err("Unknown option \"%s\"\n", unknown_option);
> +		if (!err)
> +			return -EINVAL;
> +	}
> +
> +	return err;
>  }
>  
>  static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
> -- 
> 2.39.3
> 
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

