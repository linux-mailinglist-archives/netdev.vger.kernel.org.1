Return-Path: <netdev+bounces-61961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD89825632
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993811F21567
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD62D78C;
	Fri,  5 Jan 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oa/OU5dt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D22E3EF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704466580; x=1736002580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4J9e3gABZKtn1P/CvVYZmAB/O3SQBEos0bu0qJldKug=;
  b=Oa/OU5dtCdXVZEpBVA12vtLuRuq7rkzjtRZ7/fr5DDMRCxZeqRfsi3GJ
   ZOZRu4/NdPMCOsdwp9em9c9QIXYkdCd9CBJXsG1DlfDgDBH0i5vGVFobx
   xoqWR0jsdYmuo+UD4yWBSg8gIJJbylgkWT/WsSLpTKyY/++s1iJgWUHIY
   r5uY32JJQGMV4DhHE3WI+iZ2zESEo6Xe6X7S0ry1qCHRa0C6uqZp4Ike8
   fTg+TbWiqKxk+T6AYHODvMF4pf1brlg/0vkHme5aXl1vbx6vHVCTSAQcZ
   u0Fnj0PEU6qyrlxj+AHnlPZOdW9zgasvGVbtT2ox0IUQUSMVP4UtPkcEb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="400277204"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="400277204"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899661385"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="899661385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 06:56:19 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 06:56:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 06:56:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 06:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlpneiJ7eemSD6Z4jVFHS7l66QNmkIl1rBmWITxHu7QzrXoy1zEpTHuZ6Ky4A1+yxakQZ/tPgnqxsoglk3F5RQ9z5nzLxrco3ool2w1b1OQqT/mS9xSsSYXeQApTTI8p1iJrI5LjbaYEJIcMjDtB0DcfZ76dqCt+vZBqLJfEY8zt8Ec2KIYdD449SUD9ILWNwY0rICi+eSSEyzPYP2O0+P9M5rIZYvnmxle9xOZAkez1Vrh0FhlBTi8k8IehF9zsqoV1mgpcbSV2IMvd/qvr4CpRsXX/qA7be2E9ZMU0W1yG6Dq2uIGlJeUOcXMIsRxPbcXo25s2yrJSZMVYh2sV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNSMafsVjeR1qrF1tH4Kf6SrdhcgXLZKROBiq/CYK+U=;
 b=KBDunznGLAFXui2fzONt6SxZ2OzSeNbpbelnGV5ej4usq7Hxf/SbKoOKYTmQvD0M6NUNkGQo1toi9a0+NXCGmEkETtLHRCiAv9CTYdJEEEpG3W0ATMS5gQbG4+k++dk66dAhrMGg/o4WTmX5geWKxEJAlIha8ovLUa+kDgGGlrgL4ccjRUmCflCEwkWAlj3rHX+N8usA59eHUQndDIGLuQo9/vcoDxYxQUJ/QrvZnuAfx4U+cRxXjnrlj5zGbqbVkzyQDFWk09XENUmvQEFgIX5puoQafe5ioKr9sJP1HZoLoASml5B9jGxuZm3oGXAHiQ/bIGGyngribL2AYn6TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Fri, 5 Jan 2024 14:56:16 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:56:16 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "M, Saeed" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "Michalik, Michal"
	<michal.michalik@intel.com>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>
Subject: RE: [patch net-next 0/3] dpll: expose fractional frequency offset
 value to user
Thread-Topic: [patch net-next 0/3] dpll: expose fractional frequency offset
 value to user
Thread-Index: AQHaPkjYruZpH6mqNkmhLQ7/TCBdeLDLUbzw
Date: Fri, 5 Jan 2024 14:56:16 +0000
Message-ID: <DM6PR11MB4657FA0395E74A28B7A32A719B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CO6PR11MB5636:EE_
x-ms-office365-filtering-correlation-id: 0184b734-cb82-48d6-b873-08dc0dfe77fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVIG+XwXbgoc6XkCIyC9zwEyTURmD4YQ4KEUW56rxAVAHw8ztx/88u9UHoqUMc+OJTYg65rrImOU/845rlLlYS1qZ52IsRRSpsJMS4uBdf9+JluSwk8Yimz9m9666sGDdz7InprWyaqaI5g48/slEn8LutRXl3dJ3j5Qf3m4g+jzr6MXcGiBdCl1yvrpu7YiJdyCM65aMmQToVJqR/af7lSmvhTs8FIxSCU/jEZLIUe9mrMcfWg3M/TRETfMaO+L3d0KV8wAOAHnexGCCkpK9j0cWEU7HHzSC1LCCGYzH4149O8wiv7nP6b1dyp7kw9qI2sm085rBKpkgKfziEwoUJvVv2J0830nqyyfEQ6BCzY9vfeqqcvBZ9TbLRzJjldrufv2lgdkaZnADm+ivMzCNi097pSEEMmxKjWvRBpO8Sr/Jix2pwZWsqDopBIeeC78pAoRewkJY+LyexMX3FIIOBypty7E/7/40RUg+0t4BoxIk7iWoacV7gNIsLyuE9Ry62cef/wxzUNY4gn39/3K67XN6EKxAxA2ke0dIFhqMozfVmpZvqhA4gG0Pd6aqetBVFhNsjd05WAFqlCUiaUPZu3WnbXsVGFGOPF+mbWotTKGj9/4WUq6sWtKvWHksu5p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(2906002)(4744005)(7416002)(8936002)(4326008)(8676002)(316002)(52536014)(64756008)(66556008)(55016003)(76116006)(110136005)(66946007)(66476007)(54906003)(66446008)(9686003)(26005)(83380400001)(38100700002)(41300700001)(122000001)(82960400001)(33656002)(86362001)(7696005)(6506007)(478600001)(71200400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJDcx9C2ZwYTT52Ed8iq94btpVIxWcP+S3/4YoJ6j2JgwWOOnQyvvIRd6SiM?=
 =?us-ascii?Q?sq6/pQdcMsHXjvPH5PQV4kgMDkibCSbLhye6vfDWNd3ez77lTxmAANUXqSP5?=
 =?us-ascii?Q?KK1UhCb1OqEBEdorDWq6uMZfMDoQSgFO55F1gP2uCRFgdZFn7tn+3yt7Ewo7?=
 =?us-ascii?Q?EcciD3nHZQLG+Db7/5/YujrP6V6ZA8m+VHb6QBGQis+WrumyAwduroBmiyR1?=
 =?us-ascii?Q?ouGUSuTVwfGNrUPXibvy1tHbqvHx4cQJZF72xE5qpjF1iRJtVp77xXIb48/v?=
 =?us-ascii?Q?BkrkzEcA5S24YMJQKs7iP2u7udL51t1bMmkT7pOvlTEzkzsvChOFOiMIfI+e?=
 =?us-ascii?Q?49vsmpiqTOWCLoh6WeGe3AY5TqmzMiF7Z9hNc4SL2gySYYdu4UXnMGdvt2+q?=
 =?us-ascii?Q?oyjHcPGMo/YIDIDhVmYwltKNdc7whohM0HQkuAW3iop/yC2/GL09g1d0L6+P?=
 =?us-ascii?Q?NdbUflQNkd1tiRERW4ewGLzYASksNiLl0SBSPAd2fdK7XnmF8Vii8qBhFNWp?=
 =?us-ascii?Q?+256ULdKrCQLRO3xKcMZcRzt9qdyIXs2XlIsjyjc2bNAGHq9sKHT0qdjM0AN?=
 =?us-ascii?Q?F/S2IVY58SRZ3MzWrZhbHIWI315dwPyG4QTdh/oM6qHztYU7B/y7kCAfo1Rn?=
 =?us-ascii?Q?yeH5+R45E+fWlLgbwrp4FjzKDUzQSDiAKsGqSs7PFyJQgxaoQPK5WgyRyvYi?=
 =?us-ascii?Q?J5fu4nrkHTtrHFG707q+OCxaie66vBg9brqehz7X+YTlh/frujiDFBrloz9B?=
 =?us-ascii?Q?LXHu8vDsHknMSusFP4fk680EQzqB4KWT+8Qj/JQFR5ropWllUxYjC2yy+GyU?=
 =?us-ascii?Q?OgSV5IQ54iCFu7uiLMlX0JnNBnZbP1oINbmhetcsTpMXbJmioXJ9+FuV0Wsr?=
 =?us-ascii?Q?wvAu8w2KU6SloRyPmGWD1noGCNC9qlWgWyMrl7elsnTzpFd9QLoeHRdp7kBE?=
 =?us-ascii?Q?mTxrfHAYfgNCDyKbnetwMuXQgVlr1t18LlQ3g6Hq7c4ToOOquUGz33E2jy7G?=
 =?us-ascii?Q?kbVwedkEMGPxvpGd/M8oGG0NczPNB8jnTKxAKYXCFwWrpacM44rifiGel86E?=
 =?us-ascii?Q?GyBpYJUUoYqWqJg7tgXo2vWdhwMIID4OJSZi1P+hEkIIaZ/IvwFiwKr2qX4U?=
 =?us-ascii?Q?OuWHRZPMktqeySl7hhPuBgseYpNZWHx2Fsm6u4ttUcH/jfuQIJF2mEEYdXn5?=
 =?us-ascii?Q?1v5ykNlHwDFGjrOltotGELBmc3bG/mpzJeHSNFuqYrKdsOXLWVjQM3iauQm4?=
 =?us-ascii?Q?1fcpb9nVt0ryyW+O5ru91qTlolgo3JRdepxNTcouVWr/2tjJ2PfxkMy3M+Bj?=
 =?us-ascii?Q?MN9kgTtH1AVJIN+AaW06YudzqqcUdtn/NxTRLADzh4uqLuhtCrbWyNyPcNzG?=
 =?us-ascii?Q?MrHzxwbhEfla7EBQaTYkC28bTMpCIT/34r0/z2u31QrfSfiYFQwg7Zs2Qo/a?=
 =?us-ascii?Q?GJClSsu+CowX4czkqPv/HAHq+Qd130CK5WxfJpBMlAyp3r9IfQYTLIt5p7BP?=
 =?us-ascii?Q?ZGE2xSzTnsh+K2TOXJ2a+qihuUar0Xyh3Xm9zlhJytNEhToymWtXTGR/JJrQ?=
 =?us-ascii?Q?LmPXh7xaqp7tK8mDzM0wcepuFhhVec2o6j9dQUSjN/vl3doDsQ4fh7jdjNXC?=
 =?us-ascii?Q?9w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0184b734-cb82-48d6-b873-08dc0dfe77fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 14:56:16.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgwvxjjdwuZaQyONOXq7aQ9gGQQFXT7yzPC0we2IuFZC9CKgFWWZJXDiBE+oEc4bZb1ccUQMOLwiVjdu26Z4ZELZ65xvG3nEs4JP62A15zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5636
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, January 3, 2024 2:29 PM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Allow to expose pin fractional frequency offset value over new DPLL generi=
c
>netlink attribute. Add an op to get the value from the driver.
>Implement this new op in mlx5 driver.
>
>Jiri Pirko (3):
>  dpll: expose fractional frequency offset value to user
>  net/mlx5: DPLL, Use struct to get values from
>    mlx5_dpll_synce_status_get()
>  net/mlx5: DPLL, Implement fractional frequency offset get pin op
>
> Documentation/netlink/specs/dpll.yaml         | 11 +++
> drivers/dpll/dpll_netlink.c                   | 24 +++++
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 94 ++++++++++++-------
> include/linux/dpll.h                          |  3 +
> include/uapi/linux/dpll.h                     |  1 +
> 5 files changed, 98 insertions(+), 35 deletions(-)
>
>--
>2.43.0

Sure, LGTM.

Acked-By: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

