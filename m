Return-Path: <netdev+bounces-43703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276597D446C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81002B20D29
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBD1C03;
	Tue, 24 Oct 2023 01:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLjSko+q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBC15AC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:03:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC09DA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698109379; x=1729645379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+7hyG+Ae2ncOpMzy0ctT6rrBlICFyaTGE1z5hXO1e6E=;
  b=VLjSko+qL60jwynWAIUKYtwEW9cheea2MIe7XwezCEiQiaw/8pwuGCaD
   99ZkS/nowa0ssRF/SdvqVDVZbxVM0nfx/lzBR1KfxSQZ9VcTV8acODxGl
   6BBQPf3F1sYJyd3c13jRqWYSPy5AuDDAnmIrX9Y5TU2xjFE05jInpeDmX
   f3tZWOocplxf0RFCnnc6UAlA8F4K9GYScRphAo2FFtuoTixj/m3OuS95B
   ZvMDvNAGvxesvNclb9uCFIt14nw3GQHFhQGtIQAO7tVRq0NLQnl588FfO
   MDbpHirWytEm2zP1qnXm0yyk+s6jyzl+HPyVvtkczXXoNP3V7Oi6HIGFC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8512280"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="8512280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="874884870"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="874884870"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 18:02:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 18:02:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 18:02:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 18:02:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 18:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehVNg9rT7IOpSEqplahVkpVPw4FvW7XUQywIontqmJyK1xC93sjFXMnl6yQIlQ6FkEeCfWiM2tujyyzNFV39FEj8yr0FUqTDCKVgfqsrOGPrUvR+Txj4ATP4zpIDYL6isndpP/u3eTqGtH7iHyuV2P3Vscb2Evx3555L+kv3lbydhABaDQZLmC3VPWBbV0ypNdzWE0K6B6P5Znlz6yTHqEPzr+vnZmtJIIRbKjCPn53gj2l1kkLFIdFV2LVyNpwwg79jrMW74Lt5EEd9HTdjskQ+wcaFjFpCUe3KbBryQVUo+u7k5I0aWco2AGbbpuFFtvhqJyyo8wV41kN44k2cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7wE4XYyjpvirm/yO9V45zpEoctFbQfMA/zwSyPTFy8=;
 b=Djk/G5zqXB2idpPHJb/D/vFLHfD4uqGxKzGdszkSF5Mk1F6Q51N7zx/CP9aGpGDpgjkqWyksOMRh0nuIB4iUIwjkVOeUgDl/I2IZonZxTYZBVmg+gjNdfJ87uVbMcPwVWS+HV28e8cU41fteLbzRnZiZ+PbkMq8a/nWGDsZlQO9jXRFn/VIx413orfhvTH2pH9v60GtkflvI3aM97dOuRt0b6vFF2yssH+8CAyt2tDzP5NG7vuk5Rw88KXaBw8fEXzK9UsbUO19UmIYWVEy/X1CZt6nuVbxSrjBstqRZ7hBNNAEnXS7sMkLaAmPgmeiToPZrvMiRiO7D2njSsYYgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 01:02:55 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::6f48:fe0c:6b9f:5d9d]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::6f48:fe0c:6b9f:5d9d%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 01:02:54 +0000
Date: Tue, 24 Oct 2023 09:02:46 +0800
From: Philip Li <philip.li@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <ZTcXtklgqYXfoSce@rli9-mobl>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
 <b499663e-1982-4043-9242-39a661009c71@intel.com>
 <20231020150557.00af950d@kernel.org>
 <ZTMu/3okW8ZVKYHM@rli9-mobl>
 <20231023075221.0b873800@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023075221.0b873800@kernel.org>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH0PR11MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfff988-8745-47b4-f4ee-08dbd42cf3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAdPzjq0vA/tCZsUhit3mwbO2D4Mcvvar6m5O/4oitNdZBUEh3Ezlu9ARZBDqSDjSdANBr4CpAyOiLVAAq6IitFDI+xJQBMlsao6g/kbFadDY3LmIp+S+17ahe2nU6nmyrUp5+dmrvtBzscBo2XfHnGmfSTUrIwNQMysUi+dXL+ns+pmDTivl9eoGGX/NuqtDYVkWtmB3ETLsj5d1Cn/FWuc5/KkC2h5Hte2vE+Jf/jCOBQpLpWRVKIm9hLKWye4XQxLrhBMUgCyDI96zLpsuXp12jdzSqaB5DL/iaqqNVdpEButJKpUbbeIpKYoekf53I5Te7NlQtjjit0bUIpn5MppUwDY/rA0TfDHj52aRF21z/o+xyc7G3I8aU1I0isUS8+EId93ahSUl32dVMoXSzEtAmU6+ecL2u/KKx5UCu6UPh3sDnl0f1Eq/m9wEmhtljs90j72wQ2vTw75yA84yPvo1VymkwRBA3WpEeSgAEGotCqxrrJ1IwlNgE7RW9R5M2h2H5TLU5ek06zBeJAKN2T7ukJjdPktWfY0cZTzzV+os8D0qQwBrKfJeFA674EZdwoEzZuQn7MfwN1VmHnKZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6666004)(26005)(6512007)(9686003)(478600001)(6486002)(41300700001)(83380400001)(966005)(6506007)(6916009)(44832011)(5660300002)(4326008)(66556008)(66946007)(54906003)(66476007)(8936002)(33716001)(316002)(8676002)(86362001)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q67PyVcux2QiIbY9cJj+37yUoWtx0FaXQhs3lveG6EQtOm6XvHa61fCi5ekX?=
 =?us-ascii?Q?ZqFXAaKuVSt2D8q8JD8aw3ZkyHPVUX6DQHEU60g1JYCVbcxDzW4Yiy++rRuV?=
 =?us-ascii?Q?Hhfr9vNumwj7ZyvoRQERQWcApbj6Kqbvl+MzDvwy5ag5HbrBMzYjtxoMR248?=
 =?us-ascii?Q?6BQua5hi217NC0G4aVmKLkOzTVpVMoG9vuML6Oh8Oba7T3jA/vDsecIGeoK8?=
 =?us-ascii?Q?XYmUYtajfXGala1t7ttbeNUyPZn6HuJp7LRY5ISUzukMV+rw4E6yiJFp/GMk?=
 =?us-ascii?Q?XfZaGP+YaVS96HhKvH6i/vFGLml4ntKO8FDRiV//RGJdhpJ+NlH5RlntsgEP?=
 =?us-ascii?Q?VH4wLz48+b41aJ7simk4vajWmJ31o9NacmVra6kPluBrA9NtVS7MK7zQCsvS?=
 =?us-ascii?Q?x3qkk+LpDmJ9DvOKPi2LiGFMTSN8a7bSr7hMhHyyektGg9lbME7z3BOyaICw?=
 =?us-ascii?Q?gnReIgGPYUdfNdCiRSsJ2MrkU2UAyRhmYAchLM8ozDe+XWke2ghH7AVcvqn3?=
 =?us-ascii?Q?L1v/2JWHMyhHgv1ELm1EulTc0xBwAno4ELUEhByRCHR4/km9Ka1smbxaqDih?=
 =?us-ascii?Q?jBrb9M5sqYIoO6FDj/kcIfl12kZy6OhWzWMex/xTnIkSkRGrFymJ9ohbTEr5?=
 =?us-ascii?Q?XWEPjHQw/yrK1lDElNmwOKYKv3pZ1ej2gDBIqcD5QfQQuQeiv+qX/g6iX+1A?=
 =?us-ascii?Q?1mwZVoS51jY4MRIbqBfpYzesaZFyAmNKulZUN/GkDtRhhkq9G5VA92hpMOsB?=
 =?us-ascii?Q?n86DlEQ/OsVSLUuBNGcknZs+xqNLCcG9AxqNUzCWeOZe04ENSTJVTo0E1pCo?=
 =?us-ascii?Q?gDdAcn18TbChtP43rI8YWx3W/zLskTr+k/U5BWEc+17LOBcbMKKERh5s63hs?=
 =?us-ascii?Q?HzmiMYwSfDEiMrDDzC6iOhHrMzevGI2ALn91QJ2PQBiCt4GEcDPDjM5HlPrJ?=
 =?us-ascii?Q?mQwRsS3D7UqTzoVXWGg472ttXlPotCXYBwbaQ38+0uRN/UjsiQUy3isp4DIB?=
 =?us-ascii?Q?L79IBJuuRd4v7nkILYecOHW27lTfCYcvbeY4Vya2dGZXIAH89NvRu/x/4xgm?=
 =?us-ascii?Q?3T4L+QIA/g9wLK0FwMOjwQ+MEh5eK1n50aOj+zfCywAMed2h8fHf/JjkZYHe?=
 =?us-ascii?Q?9gc5ZZV436MN8FGN6pIa6+9jB857oGmuX/QtjqUjdbiVryiZWFDSikpYh6hc?=
 =?us-ascii?Q?/zo5kgM802/cTeh9HXbViE3mssWdl81k3Pt6FrVE6tY0qZvwW5r7dQBhY+ZL?=
 =?us-ascii?Q?kY2uCoHj9Z9GT8ZgZ/Au+9SO6ATo9+H53DjiM8iF7KOST58HNT5z9sd5HSQG?=
 =?us-ascii?Q?agqzBYSKhyu1E06YWBQwggql9Mlj/WzHL6XQvV6IKI3fEY//hHqNHAiGDuC2?=
 =?us-ascii?Q?kr1EQ0uSdWstbzzGq99Oaq03vC6s+zj5QMt5HvtZwaly+6AvAHdkp0u4SsQ9?=
 =?us-ascii?Q?bfcliJJJr8tN7G+5wj20FEEMKRxFZaXNEiFHdXoLV60q3zEQkY40jBmCDHPn?=
 =?us-ascii?Q?dm66u1lngU2aUPC+zSGf2MeIPe6Q2jVvo9OPLEAZh7B6/Sy1d3JkvBWmYca2?=
 =?us-ascii?Q?NZ+Zcefki4V43LQycWpUA8rD55Er6EFWn2NIZ3Hx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfff988-8745-47b4-f4ee-08dbd42cf3fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 01:02:54.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kkBoeyHunXnFVhBZZpnFzpoy53QOqjAGma4kkl0hZe7FOYWZoZnDyQmkP5pRgaeeNXyvys3WVTs4BStfkbhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
X-OriginatorOrg: intel.com

On Mon, Oct 23, 2023 at 07:52:21AM -0700, Jakub Kicinski wrote:
> On Sat, 21 Oct 2023 09:53:03 +0800 Philip Li wrote:
> > > Some of them are bogus. TBH I'm not sure how much value running
> > > checkpatch in the bot adds. It's really trivial to run for the  
> > 
> > It is found there're quite some checkpatch related fix commits on
> > mainline.
> 
> Those changes are mostly for old code, aren't they?

Got it, we don't have the statistics data for this yet. I think this
is helpful for us to understand the status in depth. We will think of
this to gather some data.

> It'd be useful to do some analysis of how long ago the mis-formatted
> code has been introduced. Because if new code doesn't get fixes
> there's no point testing new patches..
> 
> > Thus the bot wants to extend the coverage and do shift
> > left testing on developer repos and mailing list patches.
> 
> I understand and appreciate the effort. 
> 
> I think that false positive has about a 100x the negative effect of a
> true positive. If more than 1% of checkpatch warnings are ignored, we
> should *not* report them to the list. Currently in networking we fully
> trust the build bot and as soon as a patch set gets a reply from you it
> gets auto-dropped from our review queue.

Thanks for the trust. Sorry I didn't notice the false checkpatch report leads
to trouble. From below info, may i understand networking already runs own
checkpatch? Also consider the checkpatch reports from bot still contains quite
some false ones, probably we can pause the checkpatch reporting for network
side if it doesn't add much value and causes trouble?

> It'd be quite bad if we have to double check the reports.

Got it, We are aware of keeping the reports in high quality to make
it fully useful. Usually for static analysis tool like sparse/smatch/cocci,
we maintain both high confidence pattern and low confidence one, which is
continously improved per developer feedback and our own analysis. For low
confidence one, it need manual check to be sent out.

Since we fully enable checkpatch not long ago, it causes various negative
reports. Sorry about this.

> 
> Speaking of false positive rate - we disabled some checks in our own
> use of checkpatch:
> https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh#L6-L12
> and we still get about 26% false positive rate! (Count by looking at
> checks that failed and were ignored, because patch was merged anyway).
> A lot of those may be line length related (we still prefer 80 char
> limit) but even without that - checkpatch false positives a lot.

Thanks for the great info, this is very helpful to us to learn from
this. We will adopt some practices here and continue improving the
reports.

> 
> And the maintainer is not very receptive to improvements for false
> positives:
> https://lore.kernel.org/all/20231013172739.1113964-1-kuba@kernel.org/

I see. We got this pattern as well, what we do now is to maintain the pattern
internally to avoid unnecessary reports (some are extracted below). I'm looking
for publishing these patterns later, which may get more inputs to filter out
unnecessary reports.

== part of low confidence patterns of checkpatch in bot ==

__func__ should be used instead of gcc specific __FUNCTION__
line over 80 characters
LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged
Missing commit description - Add an appropriate one
please write a help paragraph that fully describes the config symbol
Possible repeated word: 'Google'
Possible unwrapped commit description \(prefer a maximum 75 chars per line\)

> 
> > But as you mentioned above, we will take furture care to the output
> > of checkpatch to be conservative for the reporting.
> 
> FWIW the most issues that "get through" in networking are issues 
> in documentation (warnings for make htmldocs) :(

Do you suggest that warnings for make htmldocs or kernel-doc warning when building
with W=1 can be ignored and no need to send them to networking side?

> 

