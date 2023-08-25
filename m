Return-Path: <netdev+bounces-30643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F114F78854C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376751C20EC5
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58DCA4E;
	Fri, 25 Aug 2023 11:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEEC2FF
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 11:01:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E46E1BC9
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692961272; x=1724497272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qCI5M+FZGm4QZL1DvL9RfyyWR/jolvzH7/hdNUjkFNY=;
  b=jeHVINY3IFRmdE+0q6k7SO0NImtC1FRuHiQLV0Cy5F0itvUp9UNl7g5w
   +pds7X3bqbzSiMqZWrp8ZhGPsCWDoUMNZMeCS9uAsOzgS4YqJlIhXtBQd
   r6NsGnS7j2hIwxZaB56ttcOZ0GY7RsK1fs0iAKzGq2CyjUs/6rIEcN8p7
   JV8/x2ZS/zL1prBwEC8mGCJeNGaIChIPjNptkR0bXckJ3n1SyKyh22mWZ
   ngD6yk4NrD4kXecFLvzCqbugOTtFLHpKJ93cqoZW3Jmrxy2SYKk8GLQgb
   DHPJCtRRUL+DTWZ1ND3u3j9N8gfaMjEWDeo0l62EA/5xysbCQftQzL44a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359686820"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359686820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 04:01:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="737445625"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="737445625"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 25 Aug 2023 04:01:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 04:01:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 04:01:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 04:01:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 04:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2yzaXZ3qkf3PIIPVwARRFQb564mz7Fqw3K+RHVxTB+3nngm3hx2650ZQuuLECPIEfe5dmB+Xx3iU9v0uF6zXvTSd1jQyF7/7KcgYKT9ztpXYQXO68aMBVrPOotew6haTkfoIvBZc6Kp29wkbbyY7WGCnpQNsgyKPbpdNSUDVLd78YvrcJ3ajzt07ew0tZcSTxWsHmukFRtDvHBF8gEQvn0BR4eYDGCbJhzIIMYQub5IdZ3Bt/oev6bX68/89RM1fxEi/d6gUv7FdDZdSGKs5GEOOov6Hny6O2ynKEs0Y3BPoTql7rLN18YByUPNH+TZHolEe8hy++FJ/tTX8cV5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCI5M+FZGm4QZL1DvL9RfyyWR/jolvzH7/hdNUjkFNY=;
 b=Zk9kYsBaeF17yxIgSjmwmXMlDt/uaSvQA+qynmCvFAyXastmsC+XkqMMcedxdV4ZInRCOcsPKFs6T8cozBeqFt4mG8E3MME646WA4gMOkXajrwAVv5+wZxFVVysfIxHzTnWpR4qMpKy7FcEEezmGgPZC/FuBlKExfPAG9Rcth6WwSln4OiotDj86B+kC/mpCN/nA4/nMY1fFM04CjyMqrL0zGsJn4ngY799IzCLy3RgVrragApqYS3aNLpLYy5ooNXlbLcQZyqPNzDzsWaR+0oCHAW34jlYTB9nZk36+3sMYXBeDpP30WzJEwuRsTR57y0HlD7XetRY35yNyoeYN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 11:01:07 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 11:01:07 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "idosch@nvidia.com" <idosch@nvidia.com>
Subject: RE: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Thread-Topic: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Thread-Index: AQHZ1qBBv7SVSOjez0eHlWI2L+3Nxa/6wcIA
Date: Fri, 25 Aug 2023 11:01:07 +0000
Message-ID: <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
In-Reply-To: <20230824083201.79f79513@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|BN9PR11MB5546:EE_
x-ms-office365-filtering-correlation-id: a64eefcf-bb56-41f5-1319-08dba55a9553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dmbj/7tcrqz+sLHEoAAijrk/AyJwdMGlpCuzFhBTqHKJ//fV+6lW/lGIiIJ+Taq1aGujPyecN43S9+kUbXB8w6rVOmk3c07xrOiftKc9+nihslOifydAn7SksMaGs0YJ/6TNXc0bWo4lnC5c4FXPAJNyaG9rESjqkJyqBbdfLjHhNG6x+0ebSd+mTkNaS3QAzaB3poNiqn6FRCbEuCbRZUWUDGqi/S0WPn+M9ul/AxtT/RtFcjuxR3jRlga7Nl3uORYF/MdC9Sv+3AnsfB/ghkaG72y9BGe43hJM20J8Z7ZrSYLU5CQ4N+xI4YNdUHUv96/4WTmhVmHhXun2VxYJmruff+lM2c6cEJWbhsLd+DSMIvQgOM3SSQww5WtN52t07TZb71rj8JZKQfI2IUlq/s3zs+rKbxb6q9tmllXSQO4RMJ0rI7iJxpiEZ6rcURK2X3vSVMNqmWD43Y/LY2AkZZDZGkKWYJv8GvPN0VU+lU3rjKCfEWRm8dAKiJkiP9REH1JeDDKulobwUcF6851PGqzxN7d1Ltf/bKLqTQns6xX4/Hodabqv3+ySD+qZEzFRwEhhyH+usSgP4NczMWDEaCitfCSUsV/wioSE8XwdBCLEA15QSdApUTkA2dmUXmRl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(82960400001)(122000001)(38100700002)(38070700005)(8676002)(4326008)(8936002)(64756008)(54906003)(41300700001)(6506007)(53546011)(33656002)(316002)(66446008)(7696005)(66476007)(66556008)(66946007)(6916009)(76116006)(86362001)(71200400001)(9686003)(55016003)(26005)(478600001)(83380400001)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ivZRGB7ctfnYxIVfcmUvVaZSQDnl2nstqRkPfXUv0x5VEdoD7B2ckLSwNhut?=
 =?us-ascii?Q?fY6AV0Bxeu6tY1pkIdGq/sCWPKYooJjbJ2cjf6v0CpCN2RlBN95SG6rjHR7F?=
 =?us-ascii?Q?3ElZVHPAZoF4rPBM8iv3XkwuyeN4k/nWlLzOTOUBK/tNMBso0BTRzalubcOv?=
 =?us-ascii?Q?9VlJcAV2ntv/qMBpSrckjby9NnUebxzcgsWM/BxahOHpx7xRZwi/RXdFtVFK?=
 =?us-ascii?Q?2UJ5hVU+VzOWY3frn39T17TkxMGKeP2IJlxuNYRASAIAGl73o9gt7wVK2yuo?=
 =?us-ascii?Q?cLfy32I7lMQrjhwccLDOBaAmCNL/rskELgcowzf+7KTgFtm7WiHy6IdY6tPU?=
 =?us-ascii?Q?lW7Jygmk5fd2IQqNhqJ8HdjXR1eCcmGDKJ4wQqb5H3+vHUEDAFDkmM9bqayU?=
 =?us-ascii?Q?VBNHRMVm9vvAlPb3KxF9BBiqEebNwd7jlav0oDc2tlqMTqTIM0aV2SMTT1G3?=
 =?us-ascii?Q?cWu0maaaEf6uWTHSscHYISZg7iSeAA45xtp0q/3dHmFqUA22tS9p0BhxKCR2?=
 =?us-ascii?Q?f+2crrQc6QdVvjOKN5aeUO03WaXFJUSv7CdD/jadLlXY9CtqVHJL3FYzwU3E?=
 =?us-ascii?Q?xBDkT1uU5RPM1SJRSuVlL3X2lsM0lUsWEVYNF1MIuDqWCFgvucM0Vv3FUCKi?=
 =?us-ascii?Q?sPhdTtiODdr3BIeS2YWM+KqJ2CVymMY0iKSFOT49ZV4UStEsjpMwRDuba0PT?=
 =?us-ascii?Q?3GgtC1AZ836LjgoRiTAgweVV6LcIpytCUC52zznCt2vQP7ZGhPSZNLP7Gj6L?=
 =?us-ascii?Q?SW2K5mT9EzozUkjvn5745JOymad1KAMcNcA+IVJ2Gt2puQ4CQHCKmg3GQFsV?=
 =?us-ascii?Q?1qBr0nPNtuyKxXRL2NAzg0Zo+Mo72JaRgO5BoLvi0/VqL2Ee5BhgBZIrXjWG?=
 =?us-ascii?Q?Vw2wP2aJkXDpf0GoRBH0aWTmboJZTtqZsIut094aQw9CpETmec/qcr7lt3Hv?=
 =?us-ascii?Q?v48ajvWB36MhrnFU/ObR8bHjt7OweuhkXEpJojtMkUsCvLnp0eCw4mRgr00l?=
 =?us-ascii?Q?/K1bvc5KoFPZF5VF2zeXYD6OW3fK5yECuwHo7AypFpDzKSVJX1wB4xqwaUaw?=
 =?us-ascii?Q?rIxpcL8sjZsAlIZRMUf5qnGHHy68679O5AVHoi0PDLcClVHqHiqvef+T6EFw?=
 =?us-ascii?Q?jB2JYthe9VXgwsvzr4dnb4/1TVdeSv1wfGwuBJaLomHnqMuZkvNwMhDOKKVu?=
 =?us-ascii?Q?mtMzknLvdU9lpKQPVeSZr14/O9bMe8jqEYBaTa3SoCnY952MsZyFFo7CC2Y1?=
 =?us-ascii?Q?seZYyoIy1W9An8Y5kZdrtGyNELs2BhHtk/3/AFf/8JSb+sqG5QaX6YlJoTWT?=
 =?us-ascii?Q?P8TL7UvRm/cY9IBci9bkKvnXWc+NDrPMd3DRH7en8iAu2i4slYgkDFnPKmUo?=
 =?us-ascii?Q?+JuJ0M3Pu8PomzqIpkYSekJKwWr1B7kG5UcAPhXT6j0/qu+eV60DKKT3BLB7?=
 =?us-ascii?Q?sfW9ofoEnkC4Wozlx0RqTll+KTJBgXco4FeTKNvAbtZ5orCVcHI8lvJQPAvQ?=
 =?us-ascii?Q?8p57ueUi0jv2xKoO1GjlreZBl4wmd4Uth5kgLN50qBdjHK+e9lsGJ1PpdvRX?=
 =?us-ascii?Q?XTKRbPgEOO5AsBj0HiffL99Dj7Z6WV4Kt3FvTqxs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64eefcf-bb56-41f5-1319-08dba55a9553
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 11:01:07.3424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/Nu3T0P/Wov9UII/a7tbuR+cJEuef43HLLYEjXs11CjbnjlHM/ECVIhZg5JxsdWk7WxuvKw/AxASqKp6KFhx0FbqbZmeTfjubwpWSfWCqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CC: Ido

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: czwartek, 24 sierpnia 2023 17:32
> To: Drewek, Wojciech <wojciech.drewek@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel, Pr=
zemyslaw <przemyslaw.kitszel@intel.com>
> Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
>=20
> On Thu, 24 Aug 2023 10:54:59 +0200 Wojciech Drewek wrote:
> > NVM module called "Cage Max Power override" allows to
> > change max power in the cage. This can be achieved
> > using external tools. The responsibility of the ice driver is to
> > go back to the default settings whenever port split is done.
> > This is achieved by clearing Override Enable bit in the
> > NVM module. Override of the max power is disabled so the
> > default value will be used.
>=20
> Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
> something we could quite easily get ethtool to support?

So you're suggesting that ethtool could support setting the maximum power i=
n the cage?=20
Something like:
 - new "--set-module" parameter called "power-max"
 - new "--get-module" parameters: "power-max-allowed", "power-min-allowed" =
indicating limitations reported by the HW.

About the patch itself, it's only about restoration of the default settings=
 upon port split. Those might be overwritten by=20
Intel's external tools.

