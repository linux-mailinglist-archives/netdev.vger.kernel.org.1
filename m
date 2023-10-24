Return-Path: <netdev+bounces-43730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1917D4544
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 04:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73000B20CE6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACBD6FC8;
	Tue, 24 Oct 2023 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2xJ+nvd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008110E7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:01:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF505A6
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698112900; x=1729648900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BBC5s0ORQwOTWn6hAOr/e2AWBtngmHCXD5sxTRiN8VI=;
  b=L2xJ+nvd4fjcQ7Lb3q6bUfU20nwsSAPlsoPFZBsxeSLo6P+P0Zux/t4b
   ekxSrakQLn5/LadMeuX9fvXbJrzudHw7LAjb4O6L79ad7pm5UE3myU4hm
   IF/ahHNXrd1ibswpQI3ysHcl/+onJ7P7rLsuoe93NIuiUWGKXNKub1ImN
   m4T0Lx+tbiO1+VV1eG/28b5km+7WdmRt2xyYI8IPvS3ZyIzxhKPAgiBJw
   YJWWUesCmNO+QEN9svXAFGRy+rTnLtZb4b1lFXtqCoK6BY/7//IcStXQj
   QL7r4UB+u/qIgAf6A5BQneiwOC6ey7ZAFJiieQEjEX9pYip+viorzq+1V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473195322"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="473195322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="902006652"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="902006652"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 18:59:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 19:01:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 19:01:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 19:01:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 19:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqSSBL5IyHhvad7uIVSGqJ3wICmPGDQAnd7g5Q0B9fr11NmqWd9PjUTRcRgr/90uLGK/oSXJkfvl1pXY5QbU9eGixpk8FmjT8HwtUbe+odZxvhfND7TyDF1ammw6tMEdnqYWXS7pJNpiW9Idkvm4tcdilDyHd/txRhyIMyzBV4kahQdg5k3poHiVWoq+TNVG0UjMKfSD5VujxuNmLIU2v++KRfXQgs4MmSU/iIlCStS+IFws11BTb9rPVQXhsK0I3F2w36k51NOmxLFl3npqJPDVw8p7BPcKybB5GZpKgf3Oa/2WB0+oazKiT6rmf36t+OMoZtdO7MpxnGmN/GvcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVGkHZD31CxQaXxLzpUr8szRFOgodOQu5rBv/ckAbvU=;
 b=l2vI0QdnpIEShMBX2UDGYw9x5P2euGjBA2pFxVf7J96+Ust8WWvOXdEMGPLarQCITJ8cTzlt40pISKBQBpb6io4c0Ls2J7n3CoF8HwTFg4Qj5I+8NMqxoeffcRkN/D/QwXIdNNVjP5H12yGUuyHploP0PGgnC5Ih9H1v/Si4mZEokh0lWAPupJYk612Cc1TDp5m7aVM3LATNyZ+9iOcv+P5PYqV2MKX6I57UJnG2svS7QN8wHT92dCOgiD2peqTXpnvLc2FplQ0wAo0R8C5Iatz3aadaG3M2UAnR2Vt+scI5wWQkmlIENPhQmNJh5LL7R1yHE+2LAyPb6yZRJE3g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 02:01:02 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::6f48:fe0c:6b9f:5d9d]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::6f48:fe0c:6b9f:5d9d%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:01:02 +0000
Date: Tue, 24 Oct 2023 10:00:53 +0800
From: Philip Li <philip.li@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <ZTclVfX5mtWXziSW@rli9-mobl>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
 <b499663e-1982-4043-9242-39a661009c71@intel.com>
 <20231020150557.00af950d@kernel.org>
 <ZTMu/3okW8ZVKYHM@rli9-mobl>
 <20231023075221.0b873800@kernel.org>
 <ZTcXtklgqYXfoSce@rli9-mobl>
 <20231023184411.73919423@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023184411.73919423@kernel.org>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: 5373284d-a017-45bf-624f-08dbd43512da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZJVonVQZCXcU7zGWSyBaVl0yZ6KugqOalR7t+/1uV64PFvuvVz/aR1G6U/hlXYQYi1688zlpz9pmxWgrbfDPYo3mjROOwmzaF5bhASIZm69iUfscSoXK8zPnSIJSqikhj0EGpcCIHz8E0ND+0auFDRRp4diV3deBnGFVosGQu0BloOYh6efPO5LYg5zPZfiZbB9ZHQABnl8w/YJRWwdQ3fQ6my3GY8o/cmpZprGaG3nivhoPjjqfpDk5kVn7301aQXJgwbRhiz7ZBWiCh57lLB91eYf6RNQu2ecvhOfwGIYEU+E0NnSAoFfVCEeb5YYtYpaj7DiKUuzA3wf3vCGawUmmeOy3usZMH082X9EYvVFsNZLK18q3uD2JsKpYRjW2K4Q7rvLzj8nxguwcptFMXQdsAuqoVmzBOlgiDCst/Q/ndOOiwxtqXNvjaY1z8XSTk1341cxuKxS0oW4Q+15EQ5HjsDDIYQoOFFEQCxEmuMVonhxNNYrKo6F9AInrcls6+9+GbiWAg14DBC2WEk66RHXSl1idsxq+iTsl1/yFD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(44832011)(2906002)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(82960400001)(478600001)(66476007)(6506007)(6486002)(966005)(6666004)(9686003)(83380400001)(6512007)(86362001)(41300700001)(4326008)(5660300002)(8676002)(8936002)(26005)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KB+V1RCD1Q5emfhDCYwMaXketmOR7qdF0VHFBW0tkSA6HhjifIJ9fEvQfTm4?=
 =?us-ascii?Q?kfdh0z2Ksi4O/Dz2H08ZLGtjstMo7zCcIA4X6tn8/r7vnxDvS5QHYKXdpt0B?=
 =?us-ascii?Q?P1KeQWn8n9Ldq1Zn39jiG3oKCLFCto6RtiAfS2YL//y129SSbvlQ+BaL8Kqq?=
 =?us-ascii?Q?+TXMY5DzOrqOf7Z4Y9c8fhyPkckYHPk+sfboOHzqy0BkTp/KrYicYsNkHm1E?=
 =?us-ascii?Q?Pr5lXjf582EieynMa5C/zBB/JaprRiR3xtcoU0w2j9aPxhNfAUrsFVHMGLI3?=
 =?us-ascii?Q?d8B4n+PYL/iZHeom2eUw06mGg2TlkfSajWPM0AqLNI82lp02pNccmI51MORI?=
 =?us-ascii?Q?wmJOGtiCh98VG2mEuhgxLVQrnjFuBF9WgCekxLkjopBMuqj9Im+izDRloahd?=
 =?us-ascii?Q?nnculq+58w54q0Xw/cON4U5V733eiY5AIZP5OdDrGGSBR9lUI2TXrKM1zw7w?=
 =?us-ascii?Q?nJeEwtMy/90Tk0w5dnDtktkHla3X/GUc0svExchyCWnbOTwum2sISK4tR05j?=
 =?us-ascii?Q?iumYLZ6WEXUG2D53W0YGT4oy9ZhM2lpiD64euQX1BjtLl5W1JIR+YDSr8zHB?=
 =?us-ascii?Q?3inZVST4cSS8GV9zIUj4ekTTQR6s6D0eI+JsUVnBUCM+JuyBdZCcP1B8b60P?=
 =?us-ascii?Q?aImZvZi+Vp3lk96l2wSC+QFAsVhLvoZZ8XEdE5LfaDhHqBzLu7WYgz7Xl8KN?=
 =?us-ascii?Q?NNPxWWZQlssxb2pF6AHlEOK1sJ2bspZ2J9es/5O6GKsy16Djj6LHlgQ9S54y?=
 =?us-ascii?Q?N2nB4fHWAmdtOEcrEtYUpJcwbxLygFkVIyTUhFT4wF8dM9C8v5rsDzkhxZlh?=
 =?us-ascii?Q?/ehqG3qs1oqiNIRPVa3+nQuQXzAEpxJnZVfNZGmIzyl1R0zANUsBofIIuhp/?=
 =?us-ascii?Q?saBGfX7v4KbseHgL0LqTfjwidDE7Dd7nGFc2ZuSl6gp+lkFs68f44nRbXtzt?=
 =?us-ascii?Q?z7z3cxDlDA1nME2STVsxcRUMyTjeukyoo51ttUSXDiwq4otyqCjtBZrdQlvY?=
 =?us-ascii?Q?+exMz+WkQF8tzAEdS4oEYdE4v/qSAQtfQYHiPiRCgVoYfoquKPd1Ge/jn7mO?=
 =?us-ascii?Q?w0z8gDnwqk6tQ7V6hpy/iKK53Gz9AZR/ThLmWUITq0mgWJ4Sjd8xdzkbCsbl?=
 =?us-ascii?Q?l1QdJjAtghOY1NcK+qREdF/dVV5JdmXFER4KBtO6uswKy77o9ZhgYZzvu3PN?=
 =?us-ascii?Q?2dkM5ApOVy/Yr0b68o/snFEw8Kn5viesYL/BiHvqlOtKbPR/FIkjWdBZ+/1+?=
 =?us-ascii?Q?JuNcEVdpJp/QCJHUg2p3LQSOGuqKKqzskcx+UMFs/k57joISiwodjHct3Y/L?=
 =?us-ascii?Q?SWsl4WC+YJ0anMQeU7XQKJLnmBL9D9USiyxg/wXrVkw9LiV1dVbYD13JlVHj?=
 =?us-ascii?Q?UxYrGNAB6ZmCJtuqDIoxsst5OcZQ8mPogjCwWYW0/+5qPgjkcaKh5d76sH+Z?=
 =?us-ascii?Q?OKeiI23rwRmcsdHTcFikYsaqqEaVUeUXicmVElnyZlNyhTVncZ1AgUEjprFy?=
 =?us-ascii?Q?cSQ+YA9oOAKJM0tGGC74DT9KPzRkCwjnVBRoHdCdF8af6+2D8TwPkMUUQ9yx?=
 =?us-ascii?Q?xgj8eS36HBJTUvOLE2OyBC3Dx6GXeQ2nZDzbx4oa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5373284d-a017-45bf-624f-08dbd43512da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:01:02.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQEiNq0nR1jIpZju01IusLtSaAL+OrfqlRXd7h/S6lhUCOJFVFxM+56aFPhxJg6mXexguQbxhxEzHh+TeJ7gyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

On Mon, Oct 23, 2023 at 06:44:11PM -0700, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 09:02:46 +0800 Philip Li wrote:
> > > I understand and appreciate the effort. 
> > > 
> > > I think that false positive has about a 100x the negative effect of a
> > > true positive. If more than 1% of checkpatch warnings are ignored, we
> > > should *not* report them to the list. Currently in networking we fully
> > > trust the build bot and as soon as a patch set gets a reply from you it
> > > gets auto-dropped from our review queue.  
> > 
> > Thanks for the trust. Sorry I didn't notice the false checkpatch report leads
> > to trouble. From below info, may i understand networking already runs own
> > checkpatch? Also consider the checkpatch reports from bot still contains quite
> > some false ones, probably we can pause the checkpatch reporting for network
> > side if it doesn't add much value and causes trouble?
> 
> Yes, correct, we already run checkpatch --strict on all patches.
> 
> If you have the ability to selectively disable checkpatch for net/ and
> drivers/net, and/or patches which CC netdev@vger, that'd be great!

Got it, thanks for the detail info, we will pause the reports for these
places. Before that, i will also pause the overall checkpatch check until
we have resolved this for networking side.

> 
> 
> FWIW we have a simple dashboard reporting which checks in our own
> local build fail the most: https://netdev.bots.linux.dev/checks.html
> Not sure if it's of any interest to you, but that's where I got the
> false positive rate I mentioned previously.

This is very advanced and clear! Thanks for sharing, let me dig into
it to learn from the dashboard.

> 
> > > And the maintainer is not very receptive to improvements for false
> > > positives:
> > > https://lore.kernel.org/all/20231013172739.1113964-1-kuba@kernel.org/  
> > 
> > I see. We got this pattern as well, what we do now is to maintain the pattern
> > internally to avoid unnecessary reports (some are extracted below). I'm looking
> > for publishing these patterns later, which may get more inputs to filter out
> > unnecessary reports.
> > 
> > == part of low confidence patterns of checkpatch in bot ==
> 
> Interesting!
> 
> > __func__ should be used instead of gcc specific __FUNCTION__
> 
> This one I don't see failing often.
> 
> > line over 80 characters
> 
> This one happens a lot, yes.
> 
> > LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged
> 
> This is very rare upstream.
> 
> > Missing commit description - Add an appropriate one
> 
> Should be rare upstream..
> 
> > please write a help paragraph that fully describes the config symbol
> 
> This check I think is semi-broken in checkpatch.
> Sometimes it just doesn't recognize the help even if symbol has it.
> So yes, we see if false-positive as well.
> 
> > Possible repeated word: 'Google'
> 
> Yes! :)
> 
> > Possible unwrapped commit description \(prefer a maximum 75 chars per line\)
> 
> This one indeed has a lot of false positives. It should check if
> *majority* of the commit message lines (excluding tags) are too long,
> not any single line. Because one line can be a crash dump or a commit
> reference, and be longer for legit reasons..

Thanks for all above comments/analysis/experience, which brings a lot insights.

> 
> Every now and then I feel like we should fork checkpatch or start a new
> tool which would report only high-confidence problems.

:)

> 
> > > > But as you mentioned above, we will take furture care to the output
> > > > of checkpatch to be conservative for the reporting.  
> > > 
> > > FWIW the most issues that "get through" in networking are issues 
> > > in documentation (warnings for make htmldocs) :(  
> > 
> > Do you suggest that warnings for make htmldocs or kernel-doc warning when building
> > with W=1 can be ignored and no need to send them to networking side?
> 
> No, no, the opposite! Documentation is one part we currently don't test,
> even tho we should.
> 
> Do you run make htmldocs as part of kernel build bot? As you allude to -

yes, the bot runs make htmldocs check as part of various checks such as
includecheck, dtcheck, etc.

We will continue doing this for networking side.

> W=1 checks kdoc already, and scripts/kernel-doc can be used to validate
> headers even more easily. But to validate the ReST files under
> Documentation/ one has to actually run make htmldocs (or perhaps some
> other docs target), not just a normal build.
> 

