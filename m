Return-Path: <netdev+bounces-56886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9728112BD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D29E282223
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341442C86A;
	Wed, 13 Dec 2023 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFwd/biy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB428E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702473815; x=1734009815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qSeSAPZb6eFml392SXNQlCuOaOq1i3VKQ3pi/Q55/T8=;
  b=cFwd/biyXYpCyttfaiAMiRicPv0n0qm5ubqggfNDXIu7GLlG1WFTbrII
   JpvYU0njxbIRYQTMQCORNMqJVze3Tbs0F9JcoVKNT3qY8aAqaXk3oxAhO
   ASSRQYO6wNlsYqeG6xFpNkb+LgwopKd0mDMEfbx9JS7FvPCKHT8WJsqwx
   zGWDwtyhWkvDWXb8NreM+TtkUBatCui3oo/6rDrniOGWgfwg1n9OdhMXD
   I/Ahp29aShBcrUOwhtY3vP70TWc78O3IjKTHpd2LDWMWQBVtCsYVYiJmB
   /y++uVK2j1OnrhcfIeuSuxI11Cfo77IhIbYZK+QUn2LJ6k9KV+AW4oG9P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8353064"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8353064"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723647869"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="723647869"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 05:23:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:23:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:23:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 05:23:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 05:23:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt5aCQTZW37ttIVMRP6MLjqjbXg6rA8HV2L+S14f1nYho1BvYn7H9HJ8fGWDQhDJGonuJQ7SDdvozuszWq/BXlyrIsV7VjTr4M7Wu1xXnWVmu0lTfoti2VgtFmcSxZXACPfeTAnDOJNWbZrJl77cgnnbwCJcWZnKh0P6J2e6dJvwPVPX4buGONdEtsM85tPEzcnqwKUisuxzKQCWqYFqzSoGzTs8pUUm9sHI4Yu+9WUjxY5sKH7qdQTWDkgR9lhVr2yAqmhBIC9G+frPbYKAggMc2HzaHPBaEJV3bISGreBrjj1rK8WY6TZlSdGwxi79blKUg42UqX6O08u5+dzD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFA7QQoG/PhtKOjAhB6n7zXjCfQFlcqag4W/CP9Wmik=;
 b=Cb0Km3+DLZErnKa7LgX9Gi0AGfnK40bgekyBnVc7elLGdeOpcSheiYcZgXMKU76DunY+E5r41hmLC+D7K3GI2Q4P1GbhdaMX1Tz0Q1PDv8FNldipJJExZJp0QbRSbjWK54IYc9TpgC+5llBF+uBuZr5jqb4Y7MmVysXV15IU4K7Rmw/lNAK84ug8i9wXSD935wH/2uzn48Cwh9EwurRn5PVsomaG5OI3RTBLTtpTuxcVclLINONG/x4Ysy4O+lwY+7svcbYFEbLyGYh/c0KcD+GGTDggRWnEu+oHFbLvcsJNvuXIjBC5cWGYazwRTZKNzhEewi5lLFdj5R8TKKjMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:23:30 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:23:30 +0000
Date: Wed, 13 Dec 2023 14:23:19 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Joshua Hay <joshua.a.hay@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<larysa.zaremba@intel.com>, <netdev@vger.kernel.org>,
	<aleksander.lobakin@intel.com>, <alan.brady@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: enable WB_ON_ITR
Message-ID: <ZXmwR4s25afUbwz3@localhost.localdomain>
References: <20231212145546.396273-1-michal.kubiak@intel.com>
 <78ecdb9f-25e9-4847-87ed-6e8b44a7c71d@molgen.mpg.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78ecdb9f-25e9-4847-87ed-6e8b44a7c71d@molgen.mpg.de>
X-ClientProxiedBy: DU2PR04CA0357.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::32) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9297f4-2576-4926-1d3c-08dbfbdeb2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPKFKIvRc/PXU8tQVl3RFzJFc8XgtBSrnZbG9cPVKoSzka+1m+mDBGWRrFzjFuiT0mSSLVnoz3Lqz2x/7Nic7q2R4FKW/5JWwSQI14OID18dL1E527Y8AJV6Ytrr1rWZd+eqsFpTVU0K6Euy5CzMrRTOeSbzGO86r0iluv4U/PUz+F5h1qOBHplnrVM8LCRT8lL8XNQKLTqhcHTDaFgd+0Ti4KDc3xVzNlRwYoxJV1MRu6SgxZajPs5mmwCv1eIGNJpSvtIbN2+XI7QpHvqqYQsH1n85SFIhkcriRDvZ5EtqHDip1QPx8vJXQm13/LbHmOjm91jD8lhMWwXkN2tFfnVyiyBfYw+XAAx8JK9MNddh7cpwUpZ2K4gYsJpmE/AXmIW66GUKW7oVInAUczh3vjGXhM1n1YTxTyYwU2xAxiVzL5I0SZ2gJOwtGofP+gMDgGbaERSgINJnJyw+1BozfT3buMqkQ7VJl6kefr80Wq8G27O+UTpbfMQOg4s6r6f8BFXhXeeVuqX4kKmaaUIqJ+ONDnZDT3yc/LQ95DZOSbSMap19aIRHui4DVKoCYlz2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(107886003)(8936002)(6486002)(26005)(6666004)(2906002)(6506007)(478600001)(66946007)(8676002)(4326008)(53546011)(6916009)(316002)(66556008)(9686003)(6512007)(66476007)(54906003)(38100700002)(5660300002)(44832011)(83380400001)(41300700001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFWRJ6YFiS1+SkPqivBoxLhoGRQbziVKPRTccCOClfP/6/OpCGoKdHvcCUGl?=
 =?us-ascii?Q?IBDSXOEWVO6FIYN1zphRucUdW7TCxZ1J/wX6WQh6dYPYwR0QAMTRTTtGeNH0?=
 =?us-ascii?Q?jXhuzbR7nzqIaTjVwlgdSfbtLe+b0TK7VDDW3Bz65pKd5odWJSTKX6oe6iUI?=
 =?us-ascii?Q?lOpQj3iYrXW5iDLwqdAbFbEYueRqprnKwCbve8leu04Yohv4+zy/pcoUBc9j?=
 =?us-ascii?Q?VbyoRxJtwc/tGUcKmzHZoFYU63QkIZCum1oqpMoq496oYzkZgm0T6YvEKQ4s?=
 =?us-ascii?Q?xtRSfjLYpEE9eRnOCFDrpJ0JQNo8dspuq3fn7NcgrTi90eqBi+5EecEZPYkp?=
 =?us-ascii?Q?C0Px7fmMvuXtZHTS2jadwTws1bzQpqUi0Hie53QAYIjtPLLtyXzkUAs6PAm1?=
 =?us-ascii?Q?mkTQtH0/sZmC9HBE9qdUySlrA3LSQFg+q4oJLuz8ZbdZlhlRiHCLSZHhZnB0?=
 =?us-ascii?Q?B7oivqiI8UKPtVenshXbYyBXMR5kZUaNSEvoZIVa0t23jKWLPzMoSqoSZlQ4?=
 =?us-ascii?Q?aa7hDsUUAAEGlD3ktSx3j0xOWpMjVmqK6aCfoJ03pNR4rO+fxyCnIxyex97L?=
 =?us-ascii?Q?aikzA2oKRtaj203X2G7FAyffP5Fm8vAmbX30ra01DPrM4+rgY0Is9BZvH6Ju?=
 =?us-ascii?Q?oD7i4l3FNRrY8eIOinDCfdEu5+xio3Me8cq/W0vzdAaCLiVSp9l/Oq90NeL/?=
 =?us-ascii?Q?BEDpGr+f9E5UelWBEiy5Vp0239DjPIs439B3ce4rQZQeEFTM3VoDhpcZUziq?=
 =?us-ascii?Q?4wxsq7EwcwKevOnGYCHslh7ba095+eqv5BrToIAMlWMezyFWsfjuytsmYXUC?=
 =?us-ascii?Q?SZTm51QPUtWW6tt8RRCmAJBp7YCazAdMMqWPBxOdqsvYm2KoqxX7Q2oFA3uF?=
 =?us-ascii?Q?gldotDg4ZW49ojTOMyVqKm0+WWCqja+u0G5LL0hgk1lkrMdZ22gkMKTAA1MC?=
 =?us-ascii?Q?OAX9eLwre/Rxo9f+fZut1hwJ9u84yzZ5hQYtl9wIkEbTEgOGDKvctBy9PV8v?=
 =?us-ascii?Q?utneAfK2KZaCX2cRgeU+uJldeBs184N85k+r5vyM0JXIZN+VAREelMD3yVfE?=
 =?us-ascii?Q?O6Gl8NF13z3WQXGGrxhuuiEd91AlbhQsN6ucX7+RPyAFEqUJAJhwbypXVRTl?=
 =?us-ascii?Q?BVO6TpRzde1R2sZGR0VLKXffL4EOjk+ANB7IuveFd6223BEZqbMt1HyyerJZ?=
 =?us-ascii?Q?zFI+JIei/bMs9tpwb7j2ptCtM3ieIfNkevjbWXGN/kUFtxqJ2wekO2oL2GCU?=
 =?us-ascii?Q?48G4yUcy1AJ3XGh55Z2SltAs6ciMToQUrGjGG9ZPZVr2gx0OSTqoxVQ4B4lI?=
 =?us-ascii?Q?xZpvjC3ieazP2+AQFGlc01orM/DpvOM0/DmERVYtxMlTzcc+WeTd7JEgp/wu?=
 =?us-ascii?Q?laRC7OiY3DedvHrcvkYJfpf1iSo73HfuBh1rj3dYJuYsjAYZuA7AUU1MLknL?=
 =?us-ascii?Q?ozQeJCoxqrD4FGPhLszUfirGOkjdmvv0TLf/PQPhTdBYQZRQDI/kQWdZoNL2?=
 =?us-ascii?Q?g9BwCYkt4Xp1hqyjy++bXGftt4zpWT9+ynnQGyLH3tEpY0SjdTVr428c/0xx?=
 =?us-ascii?Q?SuPahTExTaN55D7VESPziThaetfJ3HNF5/pflCV7eiL+N7vniZd66tlU5ng1?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9297f4-2576-4926-1d3c-08dbfbdeb2f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:23:30.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyGDH34C7JBZ9MT28oRnwCjIkP4JwWwLocxETMFoTc6BRKNh+Qm2X6AeMOn1UE+hFwAc4X2Uipip8AzGWlXkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com

On Tue, Dec 12, 2023 at 05:50:55PM +0100, Paul Menzel wrote:
> Dear Michal, dear Joshua,
> 
> 
> Thank you for your patch.
> 
> On 12/12/23 15:55, Michal Kubiak wrote:
> > From: Joshua Hay <joshua.a.hay@intel.com>
> > 
> > Tell hardware to writeback completed descriptors even when interrupts
> 
> Should you resend, the verb is spelled with a space: write back.

Sure, I will fix it.

> 
> > are disabled. Otherwise, descriptors might not be written back until
> > the hardware can flush a full cacheline of descriptors. This can cause
> > unnecessary delays when traffic is light (or even trigger Tx queue
> > timeout).
> 
> How can the problem be reproduced and the patch be verified?
> 
> 
> Kind regards,
> 
> Paul
> 
> 

Hi Paul,

To be honest, I have noticed the problem during the implementation of
AF_XDP feature for IDPF driver. In my scenario, I had 2 Tx queues:
 - regular LAN Tx queue
 - and XDP Tx queue
added to the same q_vector attached to the same NAPI, so those 2 Tx
queues were handled in the same NAPI poll loop.
Then, when I started a huge Tx zero-copy trafic using AF_XDP (on the XDP
queue), and, at the same time, tried to xmit a few packets using the second
(non-XDP) queue (e.g. with scapy), I was getting the Tx timeout on that regular
LAN Tx queue.
That is why I decided to upstream this fix. With disabled writebacks,
there is no chance to get the completion descriptor for the queue where
the traffic is much lighter.

I have never tried to reproduce the scenario described by Joshua
in his original patch ("unnecessary delays when traffic is light").

Thanks,
Michal


