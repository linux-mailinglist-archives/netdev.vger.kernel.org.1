Return-Path: <netdev+bounces-67613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033E8444AF
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44B61C206A4
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0812A145;
	Wed, 31 Jan 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFJQxuQI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146238DE6
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719145; cv=fail; b=Sk2MLQjze16iSW5+5EriPGKBNmKEnEgmrYYZVAr3kxEIb8VOXKkpRHw/1PbQWfBsafmHxa+MA/sGO3cFSGK/nvsqmJC6jATCII0pIWnBTYrhrnhuSirvrtHItW29Djv8X3By5YxQWQj1GQDzAnSCgqQs41btVnDMFs32RSUHF8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719145; c=relaxed/simple;
	bh=kMNAiWJpvmRx/wwWojjV0G8FTTHaGA5RiB1bU2yLFwU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JAskFaZQo8jUiBThIQMowUpTWoMFJnk7aTGPCAQQhBjNPYlHKtwqXzn90pJNhzo08Nib/H/mVGS/IetWOvOcX5xSB20gSx9VIyY5aUchoMuKW3H5YzuOfZZWIU6zNaVe9d4a9g/bIuQOBJqwjhn1S5RoHHsVoDeBD2pZ3/y92Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFJQxuQI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706719143; x=1738255143;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kMNAiWJpvmRx/wwWojjV0G8FTTHaGA5RiB1bU2yLFwU=;
  b=XFJQxuQIkuzvJ0IkWk7kyN16f3D9TPIjkptYOYmQzDkNKV410h0uKsiH
   3Xg/fRSTRysvZ+00Ay7J6N2pXzPELoG6YqY5qtRUIq4gSzZD2oHL4i685
   /ry4vfnn0X2jm8nVnu5l44Uu0m6jxfGrAxCEun4yLiuH41TGCeZZcKcuw
   Oqr53KOf7gsRCldwFOFHoXQA2sBGkUcJKCYIjAK0jJlYWO1pWTpcwXInc
   kqosTPAag0e4JqyD2GdiMDtdR4IOld5le0GwRz0hCM1+W1z0b1+peAJpC
   ouT3QzOPIkE+WzhoVz+DEahEJp/MjIBiJjVpJ0juq4/vUrlWtDL7dI4HD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3518199"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3518199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 08:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822617151"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822617151"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 08:39:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 08:39:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 08:39:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 08:39:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 08:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV+YKAGhzjUGYekWvb00D9QzH/chmQb/fcHSre0Ltv+hdYh/aVt593YfUhNj4SHPEdU2iH1AK9gpP2tB7rL8xyu64n+vPe9kWi4VJdS6AKz/nuEFxHIJqgOTkrk+mkOLDZBhU5H+cpunGJV3Ng1NwuDAtkZMEtouSBO5Fe+1+LQ+vrq6LbTnfIwyGIEdITg80LVV0kFiWYVeUPWF/lPRX1543tHGDLUD1DU3UxL6xh1zSvDMwjG67Q7KdT+HVhJXBbxDiO3MSCTGa1oro+d1N+BAChrLv3GGUNf5h+uj64meMy71i2hMjVAZmEdzhchgoUq9kYdbzEmlL5l70SKfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tE1rAWiZcCR1+0L0YG2jJBJ+FtyI/6x4WDfXxA1OZE=;
 b=TCYS7RNMS9L0dBk5lbU7vIlPwOgFU6kWvuxx83gnEWCPsTU75UcIu6Jrqe7ZLogh97k+FHlgxPIPtW0IpWwsZqL2/z08MhwtfZDWWxru9yNNWS14fNAPmVnTUmYngOUAYO/ayiiv4kpZ6CgufDhESg22VTmK4rOncYLWP4uo0r83REew5biV/7pJExiEQysAH3CpB5DOBxiAWuVFX2oRL88BK3EagjI0m93f1osbd3xUGLYugjoKBq35jM6KyYL+LDIN3yIq4pO7YyaXIBhPr0XJUiSnb9umvU1hRC/oxbRvfdDmYzE3hazngNXGFxeU5ONaMmy7f7YshOUZp7cf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 16:38:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 16:38:57 +0000
Date: Wed, 31 Jan 2024 17:38:53 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Seth Forshee <sforshee@kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] i40e XDP program stops transmitting after link
 down/up
Message-ID: <Zbp3ndhiNGw0uhll@boxer>
References: <ZbkE7Ep1N1Ou17sA@do-x1extreme>
 <47eea378-6b76-46a7-b70e-52bc61f5e9f0@molgen.mpg.de>
 <Zbkq4cVJ1rEPda8i@do-x1extreme>
 <ZblN2ABkWPM0gGZB@boxer>
 <Zblyz7ZnA2GXh04k@boxer>
 <Zbp0n4HTPw/xMtB5@do-x1extreme>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbp0n4HTPw/xMtB5@do-x1extreme>
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 978725a6-3207-4779-a28a-08dc227b1f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsFHcJsUdayxNeKifBgFoq/gTGrfHslg1JmxCmS3JkYKon4q5cgSWP5oxmQEFjfLJNDQCMUe5AhH1ni/OuOclWSUyC8XAr2eVrUJzxRPXrm5x7eie/nSkBecTxy6Q3Io3v2VNCQijhkYVjxZYkp3sXA6USFXJkRJiM3TccHplTTwo7ge8+pybDBnV3oL0Z/OC9NhDfBdDPjtZhWfwvjyHuOnYTMb3GKTv02lZiE+2ebaskHFL3Iz7h4Lfr8+vFgym1eDastEJ1dGZwftCB+T8EcSyInzRrcsdfWcPWJK0MAq+/GNyhXo1eGQEAUs7S2/2orlImozRYPLbPesafnYYpHyPJrCSvBa0iW2NjIq7or1mfWwDMnaHnXkRaTOp0Z+j90mQ5yKsrlbDhnsSYDdwScbIk3VwS8GFNiUEDdQla/wF0IxqDF/2CFvM/HtTm/FkipZlSqy5DwX2YazFknJXP7e74GJbjvgwCJjWIKsijRTeorr08EurBe4ADYGE9cSpRNdZZ36apPFQ7IuhPt+MLSZ+v5HkZqJ3gkuv7nTBWU3ZXCPT4EzZkg/KhrZaIyW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(107886003)(83380400001)(478600001)(6486002)(41300700001)(6506007)(6666004)(33716001)(8676002)(6512007)(9686003)(4326008)(8936002)(82960400001)(44832011)(316002)(66476007)(66556008)(6916009)(66946007)(54906003)(2906002)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW00VWJHWEErZGd4TWs4K29LMHQrblBDM2lWVHBYWUQ5NjhPeHgzL0pPY1Yr?=
 =?utf-8?B?RzYvRUYvMlVqNTJONEZGelZWb2wvaWxwWkFVUDJWUWlrMW5WbEZOc1A3TVRi?=
 =?utf-8?B?T0pnenNIeCtWOUZoRGlad1hsQzdmRHUvaWFnT3lYZDNxcnZXcDFIQ1A2T3hD?=
 =?utf-8?B?bjBQSFZjVzBsdGJpVkpZQmQvR3dqaEo2SG5vTmgraktmd00rVlQ2NFArUnR1?=
 =?utf-8?B?aWtSMWRPbklXUExTUHRHTEl0VmJkQmZPSmlicEhWV0VYdXlIUUpCRzYyZnFH?=
 =?utf-8?B?YXNnWEN0eXNmK2V2WXRTUDY4YlhQNmx4Nk85eE5JQitKQXl4ZUlsYVdqVmlH?=
 =?utf-8?B?alB4M3hlVFhBcjYybUZtVG5rZEpsZ21ud2ZIdi90Y2hWMTVjOFZBdHp2Z0c1?=
 =?utf-8?B?QzZMbHBFbkRKRENvTG5iL2p0NmhNc0V5MUNPTldmSmlxMTdJS3VrbjdDOU1R?=
 =?utf-8?B?L1VMMHpPeElDQ3hJWXRpbUpQeFhFWlRyTUpKa0twM3JJdkdoU1MwMUF6SHNh?=
 =?utf-8?B?VU5VVE1EeVdxWFFVK3E1dysybnlOckVjNHdveWlHYXBSbGdPQ3lzTFEyZVFG?=
 =?utf-8?B?OEc3Vno0dndIZGtDUGtpQnhEempid1dvaFIrUGFqd2Q0VURQZWs4Ykd4Vmp3?=
 =?utf-8?B?eCtaZnFLR3JuWnNZK3JTeWduYVVMcWE1K3VTSTRwSjBNZzl5V251ZDBqQTdm?=
 =?utf-8?B?b01IOWlBV2FhYVE3TjRvc0k5dG5QcE1pa0hHUm9WcjNrTUt5dDlibmtwQjlU?=
 =?utf-8?B?Nk5LSHFYSlJqd3pybmVkQ3RBamJTR004ZEJkYWU3a2lvLzRMVm9kVkdGWGQr?=
 =?utf-8?B?TzhCMHZnK3IzMHR4aU8xR2dSRkJUbXorMTg5dlFIQVZrSStETmxET2ZQbTNi?=
 =?utf-8?B?THdtbCs2ejd3WUJKWnBNeEYvZDJrdEt4ektlc3RaRTdaN1RRYVRuUlBXL01Y?=
 =?utf-8?B?Y3IreTZydWFwT1V4VmNTN3dmWTFaNzFYekk2STd0ci83WkpXczFnalpuVWhu?=
 =?utf-8?B?WjJOTjIvRXBtdTVUR2twNWJ0dHIrcEFQNWJGSXFKdjh0VlFiaTNwSmJvcy9i?=
 =?utf-8?B?YzJ6MDcwVm1zNGpmbVdPb1FaUXFVOHpoTHRoZWswWHdUd1ZuZnhqWVNVeDJK?=
 =?utf-8?B?U0hVWW1aajlDK0tMNnNZQ20wRDFKSVdyYnU3U3AxbUU3SFRUTVJLYU5lM1Iw?=
 =?utf-8?B?SVdTekE0MXVxSWlicmtUdDF5ZlQyZkF5Y0JCRzFyWG96WlNlNy9ydWYwaEov?=
 =?utf-8?B?SktyR3VJNFhIcE92cCtNbUI4R2ozWUUzdFdYM2Z6UVBNYnVHTEliZnRuMDdK?=
 =?utf-8?B?d0tWbjh4UkpubzVjRSt3Uk5TSlE2ekJXUkc3WlJWaDdVNXN1Uzd2T29sa1Za?=
 =?utf-8?B?THhCbFpJcFM4QnlOa2VZS0M0Z3dIMDdMVVEwb0JpdUhEV0dVaUI2TWwybWVq?=
 =?utf-8?B?NTlLclgxQ2tkdlEyMUlJZXpYVGtBcUZnRkNhU0lUbUtadE4xR3V2VEdSeEJn?=
 =?utf-8?B?dlA3ZE5kdVprRDRCQXh0Y0kvZGkweFhpYzRIQzEyV2Y5OXRyOTBBZjN4MkhV?=
 =?utf-8?B?NnFlWVArODBGdHFlbXdjbGp4MTI0MDJrS2QrZlVlTTN4L3BJdFlHbVhsUm9Y?=
 =?utf-8?B?QzJ6Nkowb3NZdmdlMzl5MzRSMjBLV2FTQmpZNjE2bVJ4QWd3SEJjN3RBTHNW?=
 =?utf-8?B?cTRoWHFqTS8xVDFXUTRaak9WQTlxMUlmZ2dyWXdUc1lPNVlJZVRlR3lkZzh6?=
 =?utf-8?B?dVF6Um1PZVcwODF5bFI5OWRpN0Y5bWdWVTNhVTM1NGFwUWxKYzJVRFBFVE95?=
 =?utf-8?B?eGFxWFVjQTgvT054T2NZMzFGbGVvNHFlQ2dXYzUzYXFZdGRoRk04dUs2dENz?=
 =?utf-8?B?OUplZzhheFY0U1doeWpCUDFQSzQxNXBOZzc5amJLSmx1STdZU1JQVCs3eWxR?=
 =?utf-8?B?czdEQVJhNTJhMjh6Y1ExMXBDSW5ZTFVONHNTOGJiaS9ZR0VMLy8xWUVBalNS?=
 =?utf-8?B?cTRINmhYT2dTRytnSlJmZ05kZFRINWt5cTRNcE5NZDljOGwrVDd3Um9KRlVx?=
 =?utf-8?B?U2lubGJNOCtRZ1hybnJHZm4vR050aFpqQXQ1cVpmVTZBY083QU1POWZ5NFNQ?=
 =?utf-8?B?ZFdrS1BLZzV1eGhPREs5cmw0UURNVm9vU05sWmZBRXR4cTNFU0k0eExFWGZo?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 978725a6-3207-4779-a28a-08dc227b1f00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:38:57.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynFHdUUgwHsBlKqY0pLAusl3/M20QIccDmN93DCLR1yMqrMPuK8WOs2UvkmjUQlUA644V7w59W/cVZJupYEQ/lmiW6CenFFCizCctUNkiM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5478
X-OriginatorOrg: intel.com

On Wed, Jan 31, 2024 at 10:26:07AM -0600, Seth Forshee wrote:
> On Tue, Jan 30, 2024 at 11:06:07PM +0100, Maciej Fijalkowski wrote:
> > On Tue, Jan 30, 2024 at 08:28:24PM +0100, Maciej Fijalkowski wrote:
> > > On Tue, Jan 30, 2024 at 10:59:13AM -0600, Seth Forshee wrote:
> > > > On Tue, Jan 30, 2024 at 05:14:23PM +0100, Paul Menzel wrote:
> > > > > Dear Seth,
> > > > > 
> > > > > 
> > > > > Thank you for bring this up.
> > > > > 
> > > > > Am 30.01.24 um 15:17 schrieb Seth Forshee:
> > > > > > I got a inquiry from a colleague about a behavior he's seeing with i40e
> > > > > > but not with other NICs. The interfaces are bonded with a XDP
> > > > > > load-balancer program attached to them. After 'ip link set ethX down; ip
> > > > > > link set ethX up' on one of the interfaces the XDP program on that
> > > > > > interface is no longer transmitting packets. He found that tx starts
> > > > > > again after running 'sudo ethtool -t ethX'.
> > > > > > 
> > > > > > There's a 'i40e 0000:d8:00.1: VSI seid 391 XDP Tx ring 0 disable
> > > > > > timeout' message in dmesg when disabling the interface. I've included
> > > > > > the relevant portions from dmesg below.
> > > > > > 
> > > > > > This was first observed with a 6.1 kernel, but we've confirmed that the
> > > > > > behavior is the same in 6.7. I realize the firmware is pretty old, so
> > > > > > far our attempts to update the NVM have failed.
> > > > > 
> > > > > Does that mean, the problem didn’t happen before Linux 6.1? If so, if you
> > > > > have the reproducer and the time, bisecting the issue is normally the
> > > > > fastest way to solve the issue.
> > > > 
> > > > No, sorry, I should have worded that better. I meant that they were
> > > > using 6.1 when they noticed the issue, not that kernels before 6.1 did
> > > > not have that issue. We've also tried a 5.15 kernel build now and still
> > > > see the issue there, we haven't tested anything older than that.
> > > 
> > > Hey Seth,
> > > 
> > > I am observing same thing on my side with xdpsock in txonly mode, so I'll
> > > take a look at this and will keep you updated.
> > 
> > Can you try this diff on your side?
> 
> That fixes the problem!

Awesome. I'll send a proper fix then and will keep you in loop.

> 
> Thanks,
> Seth

