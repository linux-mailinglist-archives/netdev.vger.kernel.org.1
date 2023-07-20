Return-Path: <netdev+bounces-19515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA56275B093
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3083F1C21430
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4DD182C0;
	Thu, 20 Jul 2023 13:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3EF182BF
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:58:39 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0861BFC;
	Thu, 20 Jul 2023 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689861517; x=1721397517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5AS9+8VvEI8gK3yw0Iy/Be4Zus7tiFA4JHR9V+cAS8o=;
  b=j9CRCvuWkgXdGqDrajXcXm/JMyETWFvWnThdzo0PXFKasTwqmWpIz7Ok
   wUvhN3MrS7HnMKZk4SyxVxEyObmcIBjBMG9VlfnrWCvCWBxWI1g6qV01f
   miYwtQZHPSPsx/V8UJOy9VJ1iiUePnPTGPka67uwbDACMNo16KJ58tt+U
   6HP0DZigyZof7PyzoVkWl1dGh3RVAB98e+O9IUNaO/iT7AF5xwYNIzurm
   8Ey76caTLSq0mIZBimH0aPCxfFfjnVspv2hkyuTIPK/ECOfKa6PE5YSxH
   r2gvwhmmFdyy4D/LsDIG5TRYzuqh1lSLR4rgagCuNsPtvFhRJQ5AV7F7f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366771246"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="366771246"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 06:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="789815155"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="789815155"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2023 06:58:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 06:58:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 06:58:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 06:58:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 06:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5t+yHyX3S3Cwhl4rOaMatfOCuGpwQ4udLqbS5jRzqhPq2MAcTeBpJfDD2FHzYM8Vhg9gm+SK9hD9jgjKRPoSLM0Gwu2SqARlVPdpq1wjCk/7qJ851uKIIHj3Kbagig+ocCxGVRDid+o04FoJhZ3zP2a6gjU76yynjmWbZN3Y4eJnYJ3lV7MT9n+RS5bhiK8S0U+2sxIUCFaq5LJgXB6Ohi4LeP8YvWvJdEPvkzsLe7bJLFV89Ts0jncGFlugn26iO7S2zUFGckvXepYwxYYOPVCaWw6TI0JQ+bcnNu+JtL8cB0WOoCGizNAPCFU1jICN8pYBfcs592dTfOHx3F3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AS9+8VvEI8gK3yw0Iy/Be4Zus7tiFA4JHR9V+cAS8o=;
 b=cLpTBCju2nNsA9xV9xrNLnzHiJXjoQA7d7hxgdGYFV7R41N+ODQpPnKr3zwhtgm+dXBRQb5qcPuElD7Gb80xjmqRJZ1JlUuUvKphbPAGpWpEO0snT94TsV4TDCruCiLBptJDxHKDhItMavbtjduPKdTcjud/M41+nKB5Zx6cnrGuGmOA65jKj+9cznka4DZJYhN3dXd9d35gR6sNsW0phTAf+ESZh4i0Kf8wOBrHpHJztAU2MdYF9lGy4G74nelanyu5YRHPv9EsJ8fpNSiVX02VFuiDse7Oa1qb6V2yDEYUbX/AiskJAatw6xwJoJB/OV0mVymjpA+cTvxkMhgygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 13:58:33 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 13:58:33 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: Jakub Kicinski <kuba@kernel.org>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH net-next 01/11] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Topic: [PATCH net-next 01/11] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Thread-Index: AQHZuutbxupE6pTY50CsDrATsd0Tbq/CqYUAgAAEVyA=
Date: Thu, 20 Jul 2023 13:58:32 +0000
Message-ID: <DM6PR11MB46577F18C3C4229FEC00D7DA9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-2-vadim.fedorenko@linux.dev>
 <ZLk5MMjChnRFNU49@nanopsycho>
In-Reply-To: <ZLk5MMjChnRFNU49@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH8PR11MB6658:EE_
x-ms-office365-filtering-correlation-id: 5a625e56-1434-42e3-64ab-08db8929678c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90XmlQdCVa1hHa3rY38Jbpse5ITbB5q8xjnC48j8BDXleekkQ31+gvJGhYf7pAX54hpQMSkJhlHErhSGJRvXNajjFqWIv7k5Oi8RwAATVBTW++ugnHrNtVGnr/DNz8jY+76QisvoyGxPwOSmiE7qRn8l28axe07h5nVUYJz09OlfcWz1051RCMsq25LAcGeTi320/dh4kKLW6NrH4vo+Knk2v6BRG9liQYsbbGhGHkop2NcjtwsErTUCSsOBfND0g696ynErjYzTseIWvZzclhbNFeDFjNZHBjBu2m3f308DJFCLM6xrwwwkMk+RSg1+373jfyFaGSg1NRpGurdcXBifl6PvlxF4Zy+vPQU+3a6bd0STuODj9hwgIHDjgHoe7F/qqDaeTaX2hxA47E672jurnkCNm5Ew3OV6j72Tl68g1gISNAEIeDXSm42Ig+r8TZwhQvdB6KzhEP0zmSndXzBo2iwFiJ0BRGTYNPlhxmiVoFc54CyLsxOwXw6hFthXrfUgFk3/y1Hh2wDD+JU8gN5jermC6wAomozZZXMXp+rKdFm0o8VPBx/1vu+B7OOFMyW+CF+5YpSU6+PsERQt5QEuG6gpSKWDA20c2BUthE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(122000001)(82960400001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(76116006)(66476007)(66446008)(66946007)(66556008)(6506007)(186003)(26005)(41300700001)(110136005)(316002)(478600001)(966005)(9686003)(7696005)(54906003)(8936002)(52536014)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LTQMoAk5oh+VdSeEAu8AqPmScbm47tbcF4JpdiO9uM1bu+WJlCZ+iaIB32e9?=
 =?us-ascii?Q?H6ml386CyfcRvSQApcYXzJWTRZgg7ryKFZWXbDpLmcsLhRYbVE8a6MK3B50E?=
 =?us-ascii?Q?tZvlHeYuDPVZEqcI35wK8Yb7VFL3DQyPxD8httu5ajESD8YATnN/M9Yks0LP?=
 =?us-ascii?Q?nhcP51ShwNqeAEYKXkKytf7JrvJcF0XFZGJbLGco5k/KX5SHhySWtZ3c3tHx?=
 =?us-ascii?Q?gI+DPG9e9Y8fHjcrzUrYGL9dGXy+59Ea95FDfyqtIOIP4Q7d/qER5IIwTYzx?=
 =?us-ascii?Q?GQi3NNlCvKToTBJRQ62n/+QHuRFAkCSIdxooqz+LzocajtVG31Yl0FjAqJOI?=
 =?us-ascii?Q?LcG5SpAGeuGP1LVUFrZJrZCbFEuE7k34Smw2BhSSCVEVDyo4V3Sv6KVVUKVT?=
 =?us-ascii?Q?o4Q73nk1hQSXom7hW3TXyttHj8LMebMCnRiYpFx+hn3c7yvgsMZrhmMncrGv?=
 =?us-ascii?Q?z7taZqSRIADbYDQXW87aS8Eo3cBXWm0OhhUQKhiKqpK+bEWXyXNFBwD9ieW1?=
 =?us-ascii?Q?XHMB2YsYjZ1k4aEpprGPUkVSjrEcGn9wzjIGFHeWnFqxm1sw3pzneylcONGy?=
 =?us-ascii?Q?Yau2qPEgz6hc4iZhBtxoSWeqe+/MAIDKPhpr68fOweN14UeIn6/U/i15bZKr?=
 =?us-ascii?Q?O9oL48cSE9WFs2Y7fQGQaKvbRWDg2/Ac2hMmlIIbBjpZExrP/R3YbdEl943a?=
 =?us-ascii?Q?9KNQKde8vP2cnfLZdmMXDrgPTtQly0D+VckKNdONIFQ016PynzmmJcoJQfu6?=
 =?us-ascii?Q?vTpmmAWUIy2JOn70vDeXsdvDsFEJq7r5gYxkV7mZBHfKD4ZM3kk6k9zkQvsN?=
 =?us-ascii?Q?239kx4lnFd7hAuycPr5os46oTBAc/PxdN7R4aNfbo5l5ulZC4DvLb7kPvbOf?=
 =?us-ascii?Q?ziNPP4wQ3Q869m/oUMIlFBPTtZePq4bUuThpHtC+ACwD/CCCJRSY5rFcPBKh?=
 =?us-ascii?Q?dcCVGWAkkiA91HkIEaFN4vPUz5/cl2ZlB1MlwurXdabsVWDM0YD3sTdlZdEw?=
 =?us-ascii?Q?QVXF9BV2IcvDFHb8nH+UhxxZp4Hvyco/+Z0sB4ilPX0ZVyC/uDfJjZXRi3oU?=
 =?us-ascii?Q?/oVp33d8GPK9mQSNcD/MSi3cjxXBXurwar94eQYsV9CCF1oV1D4/C4+dcDPt?=
 =?us-ascii?Q?3R6UX88qOvFewz1HXFramhFYvy0E09fL4uRHWvDwt20Vv/AeFAHO8TSxqovx?=
 =?us-ascii?Q?ADFZaJqsah59t+tzsdzaXPDrkNWxtV5c7cP/TooXiGh9POzG1+f+XHosvdgQ?=
 =?us-ascii?Q?BQLQW5pc/wCbrW8DSYPtqc162+fn82h/DXx/wt7aq/ygPGlhtGkQp5FXeyLG?=
 =?us-ascii?Q?y/WWAbe5PzhwFnGWIrs9X7Dr2pOA0zdttDCV6ZJYKOzfc8LJZgQnjdiMh1jk?=
 =?us-ascii?Q?Dbo//I3hPVCD0+4wmvNwB/vQ9X2PkgDRnoFrUJTREmTwkjnduDq4SCfPbsIp?=
 =?us-ascii?Q?igaZy81fUBm4fCxJoLFYWPWVv4UNJX7gLjowH81LXYcwv8vsfMoBi/oN/mw/?=
 =?us-ascii?Q?lG5YiF2keFUA24zmLft6mwIpU5X0wH770+Zjlg85FTC0V7co3xCJ0aDdFVyL?=
 =?us-ascii?Q?+ublEMKNJkBrbuAgpTKrthPkgsMusiZk/oc5FwVZzVjVSLnm566zCkwchKmy?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a625e56-1434-42e3-64ab-08db8929678c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 13:58:32.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: da91B/hZTwSbq7DzYEt7IupKhToLxede1olgnwwGzcqy+a7URHC3CzW1+r+EDX8PWPUvQZ+lxYoGThpBYPy7Kn/os3vZwLBPJHrSOwjmCO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>-----Original Message-----
>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, July 20, 2023 3:40 PM
>
>Thu, Jul 20, 2023 at 11:18:53AM CEST, vadim.fedorenko@linux.dev wrote:
>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>>Remove wrong index adjustement, which is leftover from adding
>
>s/adjustement/adjustment/
>

Sure will fix,
Although those "tools: ynl" patches were not intended to be a part of dpll
Series, they are being discussed on the other thread:
https://lore.kernel.org/netdev/20230718162225.231775-1-arkadiusz.kubalewski=
@intel.com/

I think Vadim have sent them, because I included them in the branch candida=
te
for next version, seems was not clear enough on that..
I think we can skip them for next submission.

Thank you!
Arkadiusz

>
>>support for sparse enums.
>>enum.entries_by_val() function shall not subtract the start-value, as
>>it is indexed with real enum value.
>>
>>Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic
>>CLI")
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>


