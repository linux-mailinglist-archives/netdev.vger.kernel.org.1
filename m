Return-Path: <netdev+bounces-108923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208099263E6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0109281631
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BD9173328;
	Wed,  3 Jul 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhZXdFEv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120741DA319
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018420; cv=fail; b=Se7DwAO0J8WnY6NPMCmPoE3UTX/0kKsoe6dsb++PeHpoQrUxWOnK8d8iM+Rpe5HysUOlnxApuvnVORGl/dl4133HPIUXq9p2mwdFxueCx7+XzeDWeYjBS4OhuZ9XFlI6OXMI0F6bDOXetXihWWiIY+3x3HJuOHjxOZ4dNBQ32UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018420; c=relaxed/simple;
	bh=WpCVz1/oDjWq/M7X6aZR3KqXMdVgPuCfdr3L8fLF1qg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lgE5NXQA29yaaej6PKclayqqLF3tq6/A/tNtrSBQyeLITR5U0tkevPCrRZRnTqvByi6V3lk709rAAXe9igjDLERQPbjMR+QAv05s3qqmwcvVE2N81Cklpu9BiL/S9qhu7ia4RJlP/htmGu0og1IGkRuuOxJ1uC2M42q9xrh8uhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhZXdFEv; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720018419; x=1751554419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WpCVz1/oDjWq/M7X6aZR3KqXMdVgPuCfdr3L8fLF1qg=;
  b=XhZXdFEvA86EDXxhDWeoafV71lCyMkNLCR6RkwqSryISOjB+UDeuE4Rh
   GPpJhUd/Vzrtk2sn/hvJIMBeKUjldryLc+uEQ0rRdhMK/4726br+/DVZq
   9ux+lJjTNXLcF93d02fIvuWqAMdKzKCROH6Y73MgdRvvgxkEOvUhKUnew
   DMek1l09HIVgVwPZ65UTxbnTlK4X5mMEdm4PJcSefCSGe/j7IX0X57bF3
   pmp9K04cUKVfa1dnfwoqiT0r3fkqXW82tWczJgZ8DNZ2ldovbf+aVyNlT
   4dhqm+Cdyq2uyd8PfdMYhZVo05JU8uW2UA5hqLAWljdVLd8YX2Dg9MPlB
   g==;
X-CSE-ConnectionGUID: fYwky34TSjWw5zrLtHZ2Mw==
X-CSE-MsgGUID: 49MkwpBeRRmF6La+TvAttQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17076717"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17076717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:53:39 -0700
X-CSE-ConnectionGUID: i3zDl+dOSayG0Yk++QM5jg==
X-CSE-MsgGUID: bHFQi+F4RumMIyBtR30KmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="51466255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:53:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:53:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:53:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:53:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePlG8aDkfLrAPhpEXKYD5fkVjCTT/pPUDZkK0KGKenVGkE/Sqlw1SQKMaS1mHPFEX7iZ1IQdSHh7vV7kJoJhSxEK/lYRjs5Pcx8vGRvtgjD9LVcuT7rVk7E1rrhtyc+nJYqk5u7G6PrQrR7fX6q7DXxEv4tbCIRFUwUsslXx4vRmUvlC0H8EOyW06KsBd561LM8C8F1uPtQKohI8XPozYlIikYshjHqKdsxIDKb1Om2bcIDlvHcjDL4mZel0gDKr6Ff365w5WkKp+NjrAl3V+Ubk4qOKTMQfh5LlxJAWJLqP9gcMmaeQrr6ALpMdsHRN1scUhgErmiuaazSRr0rJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEq/ECRNuQVKQf7L6ONw6B65Js1jFZoFaULKRDm8XKE=;
 b=czVLqvJ6M8iBHA/nl43M5ixCkM1LE3YbBKN8OMvEvqxeyhG2JsdmcSD9AacBfRr8o7FpFgWtdAM3UPJO4VAMH1EFdmAjyNygzfWve26Vr8kE/LXK4XAYpyQlD1gKYInojXthgAaBXMbifcgy3aAU+fLeGFUVK/ctYQ6axryHWQdp/OaaSs61mZfxQ80iLDj+npdy2xxSdnOTz9TuqpekXdv8Si/qPrbJGh0pNIftwxB36NJ+t8D2Yqp5PZRQwiGQaF7PhgQVPWdDjX8gO++j5rR9mewtagKDyaX/+EBYJuh9amYe+/fRV8Qbl6HUg9xtbXhUzcq43lC96jzHQzLS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 14:53:35 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 14:53:35 +0000
Date: Wed, 3 Jul 2024 16:53:21 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v3 2/4] net: txgbe: remove separate irq request for
 MSI and INTx
Message-ID: <ZoVl4YqVG4Hv94qU@localhost.localdomain>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
 <20240701071416.8468-3-jiawenwu@trustnetic.com>
 <ZoVTJIGmBMP4gCD3@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZoVTJIGmBMP4gCD3@localhost.localdomain>
X-ClientProxiedBy: VI1PR07CA0161.eurprd07.prod.outlook.com
 (2603:10a6:802:16::48) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eab3d63-e356-4a19-f4f3-08dc9b6fea6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tOdo3YbgqQB8mCJVUS03LJ6nctEf14olzJc37A3lnTgv01nLKNcGGVllsEkX?=
 =?us-ascii?Q?9YrMJVDLnIpoM4ABEnTcHXjf2JoQ0XtJnSN3RXiin3pDsD3gJ5KfrYAX7Ucw?=
 =?us-ascii?Q?HT9j3Hp9LJodGl9QY75bc3jEC3av+uBCNKZ0cGWQTwI0C86FkhSsDnEXj0d5?=
 =?us-ascii?Q?fPHPNWUlLfb/yIyHOhU6rW8Ypb1ZFSxsmDAy/8sGm08enP95nhpMFN6G1Acc?=
 =?us-ascii?Q?DpZYk9WZb9CKvcGM7qcylKkgQduit6Kb5YTGIIc7/H7BPUVbq5LzPTQ60EDY?=
 =?us-ascii?Q?jdOpAwX+n0Jn//+Ujyt+jTjLZOvDdQuYc4wOKTxgHZbVLDEGS+VkdTtzIW17?=
 =?us-ascii?Q?BBsNsNMJkdw1N+s/Pxb3VCFM/zHxy65br91duFWioXydlUNIKeXPUftmPpxn?=
 =?us-ascii?Q?drrrgGwPLuKwLA5xA19k7MbkGmHqpbrqDi2YIrvqce6i6bQrctDJtRad/Bs5?=
 =?us-ascii?Q?U/uRKaofy8n4mRBkcpLkU9jhpkTmYQZncOYpxA6gnovsqB7Z4rSkU9t5raLb?=
 =?us-ascii?Q?+y6WvZg59F9eOPW+rcS6rspif4FqTHIn+ZmnG+PY7qFSX7PvM64AEY444ryz?=
 =?us-ascii?Q?Ka46NsnuG7a33XFl+CM5rzTkM7+hlVFhlS1T2xEr/NP4lxLztycjRi4xcaiO?=
 =?us-ascii?Q?iBVAN8zTzaUvzN4JHoKIS5w8UFZ7NJXiTNH0kSFh+401EL+ZWomHm7cgbMhm?=
 =?us-ascii?Q?+RLYkLF1kGylsCCdwxZ3Q4JdZDT5a99yyz0yjKvc8m7w3QrRUlPfd8htkpZR?=
 =?us-ascii?Q?Hlf5bH1Y/WHjUQrHoK6LA0II4UH1UQ4neNztbBBUGJT/63XTMZlmDUZR38e2?=
 =?us-ascii?Q?SeL40hoJMds1LFIC0IYL9seDhThLMFR4t45kpitSLce8ApZaw8FLTxNfGgjT?=
 =?us-ascii?Q?OJVsBSz2zkAJq60YiQxeqdbGkfDPAEpCZyTuXytG+BU0N1VGae7gTwoCHNTo?=
 =?us-ascii?Q?jY98zFNwW8iPH30XVwf5zjpRa4zBtn2IwB7lxeX2a/lR7a5DtVXkhpX7krHR?=
 =?us-ascii?Q?XzL6lL5LswpSS1so4ZlgdME+ARhSfRGCUt92XreHMVW9nLy013QQruqzTpFo?=
 =?us-ascii?Q?REauGH/k96Z9fCjTKE+urcxGjAJV6fTUq4iUximANgVLXtm7oDFr5hBBPwt0?=
 =?us-ascii?Q?TeRrrlJszxmb+uUtbNmGBGRuqbtH3xIph2Mq/uvLLNhSSyyGAkY2E5Ih0iNo?=
 =?us-ascii?Q?Y/hUkdyJnqbxDXMczl+NPndndcO66OMTE50241oSIxk9xtVhEirCqOp6jYYf?=
 =?us-ascii?Q?GFjlLOHXw76UUZmiKAiTd/qHLnJEc3CY+pFx5dw+iovStLv50nEL5JUu86Ut?=
 =?us-ascii?Q?+JW9ajS0Uog4OdTcyHcQGRadXYG8IbsIq3SFqPAnjHLgHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QqwwlLhlYA4Q3BxtpfCTD3H1cfukhym0Om3cU1ufc6nGt8lGJkoVes+KAvSS?=
 =?us-ascii?Q?WEA/NMfzVCtXOj77NAPweuY2yJSO+Eun2xpVMh4VI8JAE8/d1GI8MPp/lbta?=
 =?us-ascii?Q?zM22XfK6xwEJq6iHJWVfpZLX55SZ89j0yMVmAbhczVjZddn6XTQfr/b/O+C9?=
 =?us-ascii?Q?y0Bt4lq4r/dwWfbnv+TALFp27zYJ+IOg7ax14i82+52hxgjMa4HeVYCrsVIM?=
 =?us-ascii?Q?Le5kZCOybsckxXHi70DWPNKmFnlgYBuDEvKc9xJmiRd/NMaMUD8CM7ipvheH?=
 =?us-ascii?Q?XumQ3HUqIZC3wf30esgEmElFaH5OXLF0n7ZH+GN9aYsC6zuBOvlkj3CVTXoz?=
 =?us-ascii?Q?QiFg+BMfPH6/A27rhT2udf4FKMHrdL5V2Xst4TC79NKHt452lYtOIozLMmHa?=
 =?us-ascii?Q?JUspVAS7iCFoI3f85LSs+ryqRMGOubZ3EuPZPF60Po2a0vqOsgpRupIsA2GV?=
 =?us-ascii?Q?cg8bG+ONcn82dOsMPuc04FdYnOAfw4RFS+BGb5UyoDC/HwaggpMzAT1AhnVI?=
 =?us-ascii?Q?cQVo2ZYK22/lr28IV4pgJW5EwCncnP88UJMz0w9YMNjhV9PK5oJzphuGL+3k?=
 =?us-ascii?Q?uPtfPjQ2QRj+Y9uY1JkmhUaQs23zLYr5PO7tO1wmBnrM1H1J2e8QSv0rlhA4?=
 =?us-ascii?Q?68g/rA6NWf4EDQB+LA2YWmok28Z827hiZeLv1pyzwXbPmIVpwx3ms9Qi+6Sw?=
 =?us-ascii?Q?C4UrvPl+6V2wJnBHHynfm9o8Im0PgEyjOkRHNS5zKvks9BfTgKdxH3AEYpqc?=
 =?us-ascii?Q?oUC+fVGEIojouzZL53YzN5Dh1A0o6YZrEnoQcsTmPk7re0Y2yBm6Sf1faO8m?=
 =?us-ascii?Q?8nIq+iNXA9YnPDabehQEV7nMjX0RI0B4fZs2j39j5cU9H5XkZJTXQgcunuiF?=
 =?us-ascii?Q?szKlOl4v3Kihdbv0wK2TxyLUHAPVZ4PfEdR9Cga8eFAwYTsTOuWX97Gxk0DX?=
 =?us-ascii?Q?9DTDjzQZsrpGmeVD+GC7zT5t0NdpWEf/dI9V24JNiU1SgLXSUQpYbbLMk8GU?=
 =?us-ascii?Q?FokvkFf+0VDlyxdauHDHEgClw32iC4OLfe2DvI6Mz2hInEJxlVINr0GZvMRb?=
 =?us-ascii?Q?UTwLA6oyJcnHnjoOyGTLEOLEJAfcGoei26E5rMDlEMprsJbA4p1sRmRpOI6B?=
 =?us-ascii?Q?XSh0g8pZRAxWSgPOVIJA4Rn++oV5aq7kZMKckuPuEjKGUaiy3IBjHgw/pDY+?=
 =?us-ascii?Q?mAt5KYuxEKXmw2oxsTdXdIm/DauzpQ2vog9mEd/5IlaSJBgg4Ibqt/kCnxLz?=
 =?us-ascii?Q?zn9Ww5ZVbmt/Zow54hHnM2062pa+JnzWYvMY9D7f9J40uJbx3HvNxoMl+SPI?=
 =?us-ascii?Q?Rza3VZzH2ue+4FoGmOxGmJolp9EVxq5IUnmph8HV6B8CZMNDsN2VG3mzwdEB?=
 =?us-ascii?Q?nQFKK/2qYDKLTNeKbJoVOmTT50zfydldgwoszN1fuC7uaSDU2lnqqzZsi9zZ?=
 =?us-ascii?Q?ao8a598LfdNEsrGZD9SAq1VIqzhTBN5+79hgwgRO02PNIUoDay1x4wYgT1/U?=
 =?us-ascii?Q?BQ2fHo6wBLX4Bif4xLcflMxQtHes1yeCuK53q4RBXAgB6vaDNrkcr8+MWqkY?=
 =?us-ascii?Q?6kTCrq6mETKZxtNvmWwiACngDdjISX8E9V8my5IGFxmjdTKppufoSWFdxDIB?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab3d63-e356-4a19-f4f3-08dc9b6fea6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:53:35.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmZvGE3pdChzLo7JS4VO4UMJ2ohgpdmEEaetHBRVmxzyDxuImduY3X8bmdv+VhYuGvAJ3T99knlTG6SKXz4SKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 03:33:24PM +0200, Michal Kubiak wrote:

> >  	if (!(pdev->msix_enabled)) {
> > -		free_irq(pdev->irq, wx);
> > +		if (!wx->misc_irq_domain)
> > +			free_irq(pdev->irq, wx);
> 
> Does it mean "pdev->irq" will never be freed if you set misc_irq_domain
> to "true"? It seems you set it to true always during the initializaion,
> in "txgbe_setup_misc_irq()"?

[...]

> 
> 
> I don't think that introducing a kind of global variable to determine the call
> context is a good idea.
> Also, it seems that member is always true after the "probe" context is
> completed, isn't it?
> 

[...]

> 
> Is there any chance that member will be set back to "false" after the
> initialization is completed?
> 
> 
> Thanks,
> Michal
> 

OK, I think I understood that change better. You probably just want to
distinguish the calling your library function between "ngbe" and "txgbe"
drivers.
In such a case using a structure member in your board structure seems to
be justified. If so, please ignore my questions.

Anyway, I didn't notice that the patch is already applied to the tree
before I sent my comment. Apologies for that.

Thanks,
Michal

