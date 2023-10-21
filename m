Return-Path: <netdev+bounces-43179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB287D1A62
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1C2826FF
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389357F2;
	Sat, 21 Oct 2023 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCqUZ7Mb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7777EA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:53:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C0D73
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697853195; x=1729389195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kaX2Pj6pnLClKFSPxXe/5EaCOpMZTFVKjUdpElcTOgY=;
  b=cCqUZ7MbAY2qedZ858aURV+yXEddNc+nL5BygyFa0Jdt9J4MKy4q9ZYt
   cIA8k8ZYPE3nSv/8fIy8wyvxfSvSaarjzoBsSjNLULD11T2kSGxlJGOUo
   0J7/tfPjcWKIU5vK19LKQDOJra5mTKKKEtT1RRsCuLYBW7RYlKsg8Fd3H
   sMMI86FtInA+sJEKIImVebcJUWgVGN/Au4UKwaea9MwO1x1M5+ccYY3Ko
   cYPQJK01S2HJxKAZqkDmWGxz5c0ndecovxAXuq19sY9sRwnPw9zBth3g/
   U0UQCVbsa1tNKrEMPb8XJD1CG6boNvyJtByX5X6MNgDe6l+QfCZmdJQtD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385493074"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385493074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 18:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881231303"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881231303"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 18:53:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 18:53:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 18:53:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 18:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzmIDfyOgsjGoXNCzWov6HipM5ioLZXg/MflgBvUzKQE6npUVu9KvqgoBfyRprhngUYTGdqUn9jOADxIifMT+k7UESK0iYuX8ZIN0EmZl3ScA95pfGlf0r5ihWhMm/+46x87b/u1bNSStOKes014UxYN6ZzGVOzAqnoPWTm+bnat9PosA+DY7UCR2jqbvnhetzpRvVVpSYL0X7gXBXh5fkBSw229ie+KAHfNNyc2zarEu4pN1PTMAlKTLBHsZPHbGdprAFiqpKx1WemLfMVwtiby+WsORWDB+hZ92AuKfYth0nLFlOaD6kmRdUl7KlGvsVlsp23ExLWoIx3scfmReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xEucHUnJ2Xc0MpjFW30+000eLDu2ITzaXNJovOzvBk=;
 b=bhq5IklNZBWhaE8RG0Ysb2PQR7XNOmiX7MU/BxBzYclieqlxDPU/T9JiUhR1ILLZi9tYowXRr3dCf2FqoG375NnJsld0zilKrsLarQxL4a5CpnigY43vAMTSzZBohJY9ZB9V4lUwTKPtUemPIy0anAzhOxgmKOLTlwSmrlu4Sln+BjBjsdSIWQCyvfxYoPQhK/TjKm1djOBw1ftKSUgFXlGm7W15KhF5N/hv6l+0eoFnrcsdPy/Q5JQNUX7HbtieNM/sKvKHzXvcqighBc6PTOgmLpPu4d/KYYhWc/tdDWmFnO+RcMsKRwHv0jAgyeAj57XkdTrn56u/pdKNtY/QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH3PR11MB8494.namprd11.prod.outlook.com (2603:10b6:610:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 21 Oct
 2023 01:53:12 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%7]) with mapi id 15.20.6907.022; Sat, 21 Oct 2023
 01:53:12 +0000
Date: Sat, 21 Oct 2023 09:53:03 +0800
From: Philip Li <philip.li@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <ZTMu/3okW8ZVKYHM@rli9-mobl>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
 <b499663e-1982-4043-9242-39a661009c71@intel.com>
 <20231020150557.00af950d@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020150557.00af950d@kernel.org>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH3PR11MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4b4815-0166-4504-2ae4-08dbd1d87b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlKhzvGqf7Fe0url92B1ZmbUkTLdDTFgPQZnjjm4FLkOEeKw5Ugk6i+jpj0JoqjdBmPqCq6dl579SRGGLr78boH9IGxzWWfPEYr3wwF7WIx4cXQX4WCuUh0fDNJTTNuvz+eyIkKRyCPA88JmNH0ZCgpwgyQoUU8sN/i9RVDOTVIomVsOkzNuGqUg5tLybK2/tvBJ2y2+W7fucR5/jCMg53sCI6uRXw0OKT24oAxXbOLsHSCXlHlUyLmnM7GSVXHEhF7P7NSE28cj8uUrU/OnjucgvKVv3iCJ/MKVZOAGGIG5nkF9DIyH2df4GrNBoc++lDu4XRNGlOnv4ieaTc7U1+BiCOnoIHyJfiTGM4Xf8XQdgaSlsyNXgxRCyYP2C3QeET2UHTJQFPfqM4GTz5eoIBxYZe17STaO5Bkt+gGldYWriEO2wPGv7H/Ll1/GI5xOCdEcU9K8v3bo0g28GEaWUQJhW3rGhsHJBXwqM03Ixtspx3UcCAOr5fTC2isk+fzVY+tqbUSTXzAsxMTuwbqhCon4vBFrL8ajw1jJIjZUbPds6auCL8r9jDrnoap5bnzL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(66556008)(9686003)(26005)(6666004)(8676002)(6512007)(83380400001)(5660300002)(44832011)(2906002)(8936002)(4326008)(33716001)(41300700001)(6486002)(54906003)(478600001)(66476007)(316002)(82960400001)(6916009)(38100700002)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10ITcCpUhnl3+S41tvYgeYVDfsAr03V4XV4+mj1vM+EwJLUtoajqcdTVpJDG?=
 =?us-ascii?Q?/SwIRXAfexL1WPZHY2Pd/IwhrXh2EkyqyLl56eEXbFHUGloakHGhOS9QBH4n?=
 =?us-ascii?Q?+4D+LZxakqMFQ7f2j2VW11oTpB7AqgbFSahT2rjD0KI5rQg+UfM2H1ftLMmY?=
 =?us-ascii?Q?927f5f4FMfdOusTd29Fv/QH/dyT/WllRx8phliDH6JiAEc/DnAHjiJrhd4fM?=
 =?us-ascii?Q?bNiSlQ4yKzq6Tx54q/GmrU0CoNwcNNLwobKZYAIfbIoeb1QIOZcjx5I+2CoL?=
 =?us-ascii?Q?fdXGHLLX6YCQ6aefYatkb/I6LFAylRSYx97h+COqQ954JuKRLxlMD2WrXdZT?=
 =?us-ascii?Q?bdKO7lvbA9JWRX0z/8irvd48PPkYh/wpC6kmVw+DaQGlzCmHSiEeLKH3uUOm?=
 =?us-ascii?Q?Y0M/wD4KbjF3bFDLqc3nW2NQKr8PI1GXSdbNmSC6iXEyBo/ZnXQXMlshMORs?=
 =?us-ascii?Q?DQRNhOwVYSGDM+em4tP3MEbi+TiKBc4ufUDjiaxLjQzxrGQ9UY77UOKrSs55?=
 =?us-ascii?Q?g//p2AtqdAorefgpnRFi5Sr2trWSw/RLXkY/CNG5L1iUuzj07bWQFQIa1b0d?=
 =?us-ascii?Q?meWR/oZCK+QYCoSid6erxjrIImxpOGTvOD2DVJH0BIhtpClHO/0lb+P2RgHO?=
 =?us-ascii?Q?jG9bQedvwENmNkOCjOBo3dNghJDJ8kMUf5IOJeUggyK3u/mh9GsN+WHBqWR4?=
 =?us-ascii?Q?BwwUe1pSwA5m4MiMNlU6t9ng0Fb+WYbxwNJeNBJ9ey0f72chkxPfN8BuQ0GM?=
 =?us-ascii?Q?zDDsW47jTJPkNMHvuevzaHnAtHwLNg90tPMQY/EDKqXK5FrD+nPMenlYL8mD?=
 =?us-ascii?Q?DGKG2Yi17QQ9aFTKfwD+lGTwEh2Mrq3fQWbC3gKBLjjSRo/N7UjrfXHya5uZ?=
 =?us-ascii?Q?88rTIlKrQSIaol7xpMuvEu+l5gWRsQSV8CmbxgZroMJZnxgINM9H2I7megcw?=
 =?us-ascii?Q?v4Mmhy70Vkj20/1YWVZtR52EFfrj8QUckM1VJXikEjSSlC0IGY+cxO0vL7Fe?=
 =?us-ascii?Q?un0S/ISRNVU4ZT6w5rvDLV8eHvqzSk7Ky3SaNe0rVe9IaiPfQEYrnH4DknlL?=
 =?us-ascii?Q?gJ00jTLQ/frQC1UIM8O+nNX7O+a062XiM8Vu54tLaMHqc3M9/0VUGpUhBWRJ?=
 =?us-ascii?Q?P2tVq8zm17EfbUMRq48Mn7s4aIyLrh/iD972WOk5prlz5+9BcZttuGircH3W?=
 =?us-ascii?Q?epO8jXOOZNuP0vN1TeLDFEo7i0bNASZ1nUqqWBUfcu7PSBRQmhJua3TKDTTt?=
 =?us-ascii?Q?5B9z3IyU/kmnijtsp87Fs/771IBlxykAl+ZRVBHZm233BX9a01iyCNkmWEPk?=
 =?us-ascii?Q?vr/lu5MlKB/Q+9DAsHzBVPwX5cLN6LVVIIzSRA610Rzej/B4k0tQ3ri1cH+Y?=
 =?us-ascii?Q?IhYowYg/LizybX/R3MA0f+3XjwqqyiE4YSvXbQb/sKV1fm2hYkJjc0AWYdIC?=
 =?us-ascii?Q?z8mfQsJjjKjeddmckEySPv7+VkOUfoeQ9HC+b+tx6Jmx9FF+WNM+zjq/YFpp?=
 =?us-ascii?Q?E/CJ6qQ5znTfWFFrRaHR4uKcnqfa5wBvIvn3cD8BKAcZ78kLPRJuSRl3SqcV?=
 =?us-ascii?Q?NmDIbbC8vF+UYWfJiiDXfFAlEnk+Y4SBSKONU8DY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b4815-0166-4504-2ae4-08dbd1d87b1d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 01:53:11.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBCh2E3cK5eWY1sAkW8T0PqV5dRRtEwjt+r6tsownnLg81//jWQByhPShDq8OtfFr24DtZ/L4l/cyHDt09wrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8494
X-OriginatorOrg: intel.com

On Fri, Oct 20, 2023 at 03:05:57PM -0700, Jakub Kicinski wrote:
> On Fri, 20 Oct 2023 13:26:38 -0700 Nambiar, Amritha wrote:
> > > WARNING:SPACING: space prohibited between function name and open parenthesis '('
> > > #547: FILE: tools/net/ynl/generated/netdev-user.h:181:
> > > +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
> > 
> > Looks like the series is in "Changes Requested" state following these 
> > warnings. Is there any recommendation for warnings on generated code? I 
> > see similar issues on existing code in the generated file.
> 
> Yes, ignore this one. I'll post a change to the codegen.
> The warning on patch 3 is legit, right?
> 
> kernel test bot folks, please be careful with the checkpatch warnings.

Thanks Jakub, we will be very careful and continuously monitor the
reports and feedbacks to filter unnecessary warnings/errors from
checkpatch.

> Some of them are bogus. TBH I'm not sure how much value running
> checkpatch in the bot adds. It's really trivial to run for the

It is found there're quite some checkpatch related fix commits on
mainline. Thus the bot wants to extend the coverage and do shift
left testing on developer repos and mailing list patches.

But as you mentioned above, we will take furture care to the output
of checkpatch to be conservative for the reporting.

> maintainers when applying patches.
> 

