Return-Path: <netdev+bounces-57570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFA8136F6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D491F211C3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002461FB3;
	Thu, 14 Dec 2023 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOic3fXy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91A10D4
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702572791; x=1734108791;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GDQKT2agmerywj9jWojH1O8+CRnBro6qh0/zwFtt6sA=;
  b=dOic3fXyE73i5ZCNCp7e8Dnmmt45gQagpLwyLNmZ326k1b9sCwnxofhg
   uWfJOTHRk6y3qQ6FdsVw3lNDCc52k5F3+LScPrEnVYcjlAAyDPDYU9T4j
   zhWYebXugoKoZ3bbL5aGTSmuqz3UB1QcQzTJ/2/c8HLJYO6ouh7EYo/0q
   W16mbRML8E+juh5KuyCaIJNfcYX83lb8jR0++yTvh4izU30H+1YSXQwf2
   wsNil+GDDGMmAfO3N6DwP+dBz0xIKHc02KSch9pdWHO+HT6ofPDHCJmM+
   tdGJER8dZ0j3WN5TQMD+esqzKHdEM8Ibg8r8rVFcQB+2YV3AaaqHbbMbn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375303854"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="375303854"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844780191"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="844780191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 08:53:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 08:53:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 08:53:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 08:53:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 08:53:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk9cLFsuKtqd+bx283XRftG5G62axhMIxLxWheKfi1iEbGJkR+fpnwvnkuygVCx47hmhWRIPaHs0P1BNeymsX0wAYX4qA3GamUs31Hz/sQowMmroGnOJM9+nYvNg3x0nM+tUc/0zuWF1okG1P+LXEp1hpN/W+G6ILFFxGbop2Uqf2LZSpgAmYkWZ36fuUH+7FRoifehdJjc93ssQOVoq9+rbhIn7A0gxQlOZlB8YLJHFkWhiDK5PfEqf13RERgzq4jHtYwvyrhEofJwA/DF5i4E0i7pCcIwYno49Ru/En6gtpIWepBAwFwQJmL3Q/dUfHULDiU1WgmK07BBuoT40hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/o47soJqTH0+7JCTljAnFcGwwy/2bjyFyQu5E4B4Fw=;
 b=W2LPdLbD2P5hZtOe8n6RfTxEsJlyXWWCWCjEaUYih8gGtZClvSY1sptz1dlPVnzBBXOO2KR9g7p5pgqgeWAS+a3TLN8evABvUafxEQYydNRtdUf0VxDRglMD43WHxFV9va+UhQ0bg34OoUZf9OQqS4nckZ83hmjTBZRS2fc/98HETUg2E3lHg1si0u+HFzPvKpQm21gi7+1zz0a3OaeJpoLwK08nCkfnoa0ZIwKosc6fecCB2SaIBcSb/ROqGemCopwmj1PIDa2xta3IlUZli0HOp1zYuefyLCZQuUWvkfL+yzwlQ95ZE86Qqd3+5ET2aklhKok0eUQ+Xlt1GfphjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:53:02 +0000
Received: from PH7PR11MB6748.namprd11.prod.outlook.com
 ([fe80::7c0f:4cd6:d4e0:307a]) by PH7PR11MB6748.namprd11.prod.outlook.com
 ([fe80::7c0f:4cd6:d4e0:307a%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:53:02 +0000
Date: Thu, 14 Dec 2023 17:51:08 +0100
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<pmenzel@molgen.mpg.de>, <lukasz.czapnik@intel.com>, Liang-Min Wang
	<liang-min.wang@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
Message-ID: <ZXsyfFHcFnaqeWe+@baltimore>
References: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
 <CADEbmW03axMX30oiEG0iNLLiGYaTi6pqx9qdrLsR7DSC-x-fyw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW03axMX30oiEG0iNLLiGYaTi6pqx9qdrLsR7DSC-x-fyw@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To PH7PR11MB6748.namprd11.prod.outlook.com
 (2603:10b6:510:1b6::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6748:EE_|PH7PR11MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa670e7-d24f-4218-c444-08dbfcc52274
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3Ctb5gbhNoKnoI2s8o0Et6s9EsT+2YEPnktKBHhWpAq10kaqOv3PHolAAAcFgaQyfqvFs1GB79o8qM2Zma/sINCQGM/37YzxYaBQTzTAo8T3/yBBJOm+sgzgfXoRkHdXQQxJkM5M9ay8V++J7AdDPhWY1Z6fV2i6fqY/kQFmWH7styyoVWZpJkIaf082/4PHyXUuaAqyxqLtwgEps7YwWcmRMZg/Sjdzz9Q6rWBFVJwSC3XtqyffBff6pGLxparbp9owE98YprpMzywhPkA6iLJU8kBMBO6RDuYdPcqNN9fpx7Mqx8osfiJmKuqKyVpdFUyXN9F90pnVLFtl2xZFR4aJcoYlAqhw5eq9oDWzd1NlvzEQqsaPy1Ge38l0cO4VXWyvHfpkG1XNiL6Niy4SSIQbm1q9FF8+Jez720R8nU029VXa8RmZ5u1hxkxhvydAqelXYrthEuD0cxRFK2mTuQ2VJ9y84+K/f0F2tBlyuswGPiLsh9uFQKmzoK1lg+zq9QAPX2SayNahv2gnPWdr9Yw9OGVRTYrI1ygoJptOiMk1hZgO0YZA2UTLV9XArPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(4326008)(8936002)(2906002)(316002)(83380400001)(33716001)(82960400001)(8676002)(5660300002)(44832011)(26005)(41300700001)(9686003)(6512007)(478600001)(6486002)(54906003)(6506007)(6916009)(53546011)(66556008)(66476007)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhnczNaaWxEMkhGTVk5dEJid3l2WGRtZE5jZzBLUW54ZGcyOWtob2RleHA3?=
 =?utf-8?B?U1E4aktVVGVPSlZYSzE2V0lkNmowd3BkUE95clFWa2RyUHBTcnlqRDdiK3Zo?=
 =?utf-8?B?c2FVVldnYWRkQTBhV2ZrTSt0TnRsZTlpQmpXVnlkOVY2T0k1MG8zc1hUZ1Uz?=
 =?utf-8?B?Z0lYUFpIQWpvN2JST1MrVFR6Tlo3U3kraEdpNzBXVUdoZUhqSUp2R3Z2UXdT?=
 =?utf-8?B?ZnZUTy9WM2wxdUNiVEhzck5GeEg3NGR4MWxBTS9ORUY2ZVV3dHFlSnJyS0RN?=
 =?utf-8?B?ci9PZjVCbXFMMkVXZTNCcVBVTVprYlVhYmN3bGZqOGM0THB6VU5VR0YwRXVu?=
 =?utf-8?B?T3pYMjJCSVlDc3d0STZMbWs0RUN1SUMxNVVidWtCWXFjUngvQ08xN3g5WjFU?=
 =?utf-8?B?V2VZeS8rVGJ5eWJFa0JXM2NIa1BTMUV5dG04ZlBHTXVHM2Y2YkUvZWxKL29O?=
 =?utf-8?B?M3hOdmhRUmVseEo3d2l1dEd2V3BhUlhpWUlQTXhCQkZHRjFQcjVhRTlKYmc0?=
 =?utf-8?B?eExaRUhtNkppU1R6VGVaalhibkxZdXpiYmJKd1ZRVFZxQS9yUllWYWdPbDl4?=
 =?utf-8?B?VkcwdWhXcnZGaFowRzgrQ1IzYXJEU1cxQmhrYVh0M2hrdXlTVWRwSjAvMXBi?=
 =?utf-8?B?OEh2QzA4WHc4ekFGV3ZyLzRQdDFheERVSytORk93eEdYWkhOS3FYVHo0RzZn?=
 =?utf-8?B?QVUxbEdOMjcvek9mRTJHREp1RjZSaXhjOVg4Z2tjNXlCamRHSjBZYVFPZFNu?=
 =?utf-8?B?WEFJTTdiRGVJWEtWSEpnUHdHNkZXOGVqbXRyNFROWFFselJTb2tETENxanl3?=
 =?utf-8?B?emUzbnpObXhYSGk3VDJUL01JWGxxU1lpcko3K0taSThEK0lVTkFxVXBuV3B3?=
 =?utf-8?B?OHViQ2pIM1ZQcng5aGpldmFTOW9jMGx1akNXK2FiRHpSVTJxR3JULy8vSGov?=
 =?utf-8?B?ZDZZU3VrWjRlMEJ5akpvM21neUdFMkUxcUx1TVd2WHVsVGFRNlhiWDYyMDVp?=
 =?utf-8?B?TCt1NG5jOTBrRk5LR29KZ1RZdzF1NXo1V1R1VE5DVHl6aWNPd0dhR3BlZ3BN?=
 =?utf-8?B?ZHJ3ZjdHRXZkendwYi9manJmbmE0TVJIWWZha2FHVEdWN3VvMnFEWEJDdWdy?=
 =?utf-8?B?TThZWG82cGlieHM1VlBhOE9jalJRSy9JYlE4SVgreUJNVGRkOVBwbFh4V2lv?=
 =?utf-8?B?SzRYQlpSczc4a3IyMm5TS0J4NGJpa0xEY3NLcWZHNG9hMDBMZ3hyY0c3SFJG?=
 =?utf-8?B?NnhGTE8wM2FHcXZtc2Yycy9DWWZzb1gxVWl2SUFEVysvMGw5cWtSY0FacnZh?=
 =?utf-8?B?K2pOVUt5aU1mMmpDV3VMSmVHL2dHVW5ad1BHMEhpTnd6SzFLcXZKRTZESkJh?=
 =?utf-8?B?VnFRQVQ2VmI0RlhvWXRXMWE0cnI1MGhvNHltdGQ3bjNld2pHNDFsS1F6SDZJ?=
 =?utf-8?B?TGs4c1ZjSFNXWktOcVAzazVMT1JmdmVKejNpSXhXRnNEd2hBZXBkQUdHQlRC?=
 =?utf-8?B?WmdJS1Nvck9oYllRYTIyY2MxcXJqVWR2NGlqZFV0a2thQU1HWlF5Sno4cWsr?=
 =?utf-8?B?VDdUQTZTL3dHd1k2R0JnVWI1LzNYbVBsajlPMFpBQVQ5WS85VHlxanB5aG1G?=
 =?utf-8?B?aHJNdFBDVjZZWm44b1ZvL3BZZzBhWVo0RVdEQlFtY01sUVh1OVpxQ2xackZa?=
 =?utf-8?B?T20ya3o0SDA1MlNDZW55U05GRFR3c1hGMzNYQmkrUjN1NXB4Sk1RUjRGbEI1?=
 =?utf-8?B?NGJGOXlUSk1ZdzBOLzgrQXZJOXFHUm5nVGdWRzJyZ0pLcFNySkk3clBVQ0Fn?=
 =?utf-8?B?aEdvamVxa1VZUUFveE1LQUJzcldlcHdJOVEveWlJUnpTcnJzbFUxNEVVU3U1?=
 =?utf-8?B?bitVRWtxYWdEdG1ac0s2VEgxYVdBeC9Lby9iKzF6RzFTTVRwajJMWlUyUFoy?=
 =?utf-8?B?T1hwNFJLREUzelNreXZraEZsVFhsODdPTU1iLzNPeWo3L0tNZDVDZDJHUm9N?=
 =?utf-8?B?UTZDdUdCWTh1MVk1cDhJT1ZDdGp4dno1a2FsMEFCejB3dHU3dHZuRyttOEla?=
 =?utf-8?B?aGRXR1dVUGpMRkY1MnNLSlQyY2Q1cHJJaDVjbTJFdmR0L3BsNGdNN21oQXMx?=
 =?utf-8?B?VjlWRDdSa1BWbFp6VDNJdUkwSGNiSGIxRkZ1SjJHQWh1MGRDQThLWWNieks5?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa670e7-d24f-4218-c444-08dbfcc52274
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:53:02.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY9ZvmqsKc8z8J5k8ZF/f/BxbxPkKGKUj+/GxgK/Q6GFdCxyPVSF1nBaQV4dR7XhUBZtiDOLOL/LujWb58faFxOzchc84A1N/cO6BBOR0yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com

On Thu, Dec 14, 2023 at 09:37:32AM +0100, Michal Schmidt wrote:
> On Thu, Nov 2, 2023 at 4:56 PM Pawel Chmielewski
> <pawel.chmielewski@intel.com> wrote:
> > From: Liang-Min Wang <liang-min.wang@intel.com>
> >
> > In cases when VF sends malformed packets that are classified as malicious,
> > sometimes it causes Tx queue to freeze. This frozen queue can be stuck
> > for several minutes being unusable. This behavior can be reproduced with
> > DPDK application, testpmd.
> >
> > When Malicious Driver Detection event occurs, perform graceful VF reset
> > to quickly bring VF back to operational state. Add a log message to
> > notify about the cause of the reset.
> 
> Sorry for bringing this up so late, but I have just now realized this:
> Wasn't freezing of the queue originally the intended behavior, as a
> penalty for being malicious?
> Shouldn't these resets at least be guarded by ICE_FLAG_MDD_AUTO_RESET_VF?
> 
> Michal

In some cases, the MDD can be caused also by a regular software error
(like the one mentioned in commit message), and not the actual malicious
action. There was decision to change the default behavior to avoid denial
of service. 

