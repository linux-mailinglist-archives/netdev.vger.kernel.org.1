Return-Path: <netdev+bounces-20102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091675DA6C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BC81C21715
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407A11C9D;
	Sat, 22 Jul 2023 06:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CC411C9B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:46:20 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F6270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008379; x=1721544379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7dTDQWcIk3KMMNGRxwOftda/mltlv1AHXxrR/AAaeQ8=;
  b=J/ttA/WbjDEbaappDm164PyXLAPKMJxqeNOtF48LHsOq8CJVy9h/fvgO
   mnpMe9Z1afoWWoYRC/bTLndj8xCZx+MEOOfqsw4kP1l5y4UVMjGS8Bu/+
   LIf19bKS2jkBgFLOZoLQQA2hooXUTQq7asJxdsQPhI2J3O/S0Ohjj2ZW8
   E6xW9YOhKwbln/O9ntOIWZ6SUH2CiUtXfo5PgsG0E5xGhWngw9RGz2o1X
   Jtd8dLULFg2o3c+9WO7ruEJ5YbwxUaRaHFxI5RmfxGRnf2L7iC6j6jJ53
   mzLit2X+cn9tyCAX1Gu0rV7zxtpF2BpZkqDHIUdDnLjVHuLbbNQRzandQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346771924"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="346771924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055813392"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="1055813392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 23:46:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:46:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:46:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:46:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRKDqo7aUGH2jo0ln8Br2cZ4JnptzoEjcspGw5NUV1W7ciOHXhM1Le33lSiZ9gTjt2opmHvbNDekOhe+fLAIllbh5PdvexylGH8d9yZMMTEdTQC68IhO6unAzVKMFecIQ6p7sn66aQ+0JAdB5z37DzRZDEgU/jUHfbFgG1Y4B/DCMlNe0m0apRfoFvM+wECTQ8CCduwDfxTvwvMVhhBBh7Zt33X34T7Y6iShOWCNCALHggI/flz7NsDpcEDkySetZkp29of6GMVvR7ry5Ojqf8rXlYNvnl7EnftKllvBNKXoDicbMaa7Yy6j2axVW/1AfAubX/wXoNYknElHRUh3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrBOPVdCIipajbNSWfz4ZDwufoumW20bYao8vfeZZfU=;
 b=GogmANQNWL+i8rN3HG0XYvEYaa24PUUfvUGxgc2sdwdjoTHjOcXKSdgI0SuglaHbpPn+vhbitV+p+Q2xfcAIevhTB7s16goGzmMLIK/e7QDfllhGeDKc15V7eDWCzoqrH273l3XdR2wj/zTmMnp91E4V/Mm84hnt81Y8N5gIM747wE+CVyXcQauoPQFXK0fMoAdnaVyH0zB1rva/XBbIhfhxMrUyDMdXdr1NUFeap5F3831AqJOdVXZbi5fdHuEHic12AaV11jgQa0H8lVP4LNwru6gsxQVQs94LQOyBzg7qblrKuOUePSrETcYIIJ6AnPPv3h1RqHV/oEPWDksZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:46:14 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:46:14 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 05/12] ice: Unset src prune
 on uplink VSI
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 05/12] ice: Unset src prune
 on uplink VSI
Thread-Index: AQHZtLDiqHwWXR3aVkOuPOyeYNjfIa/FZvhw
Date: Sat, 22 Jul 2023 06:46:14 +0000
Message-ID: <PH0PR11MB5013126F14A4E0D4007567CC963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-6-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-6-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: b6036a7a-d7ca-454a-b710-08db8a7f5801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDTBiJyiQix3XfWmLeATMLqr2sigVpLucgh57o2O39qehtEbB6RCvHR9P6VQGOA8Qp1H3dW4fHQu3e9DA2kOYHvqahUzfc6yURpL4IBi0iWaMGdZo6MX7YEkQOLh+hnTfyxEo7F1Wj5m52VxGk3/prT+XPfPVPXoujY5kIL8oc8N5lySGmJpWYtvOXuI9c/0jE+DR61SWpQGYUL84HPJxuYRgTzO/LJd7qDz082HbTkCxfMceHRsVGUxddlUfKqv/k1cHc5rPTw2rfkeoRVu6TQU2b0HNC5DFihIprnwFPjM/yzcB2WoifRpVD/6t9DGEzJzGqWKMm9klKI30PSwmhzgGMocwGUzXhhWxGkUHko5AkXJD+pw43H+S3lJVaYlyiTcHOlJbBpg3MSNPq10CGE/+Pih1pSPdb0rNtmL2vaev3mrYUdFBYtMhqyy0TPNZIfwqIPRhxkixHDdRUBmRSs/I4ON/08q5EdkENmoZpSCLVwFcWXycP0H2y+xPWKd2sLtd+EhBKF8D/cDT2zx9svIfTX1WGp6SNQiNo2sVjQhs6/tchcM/iJGc7TY8nJeEEYG5LqXs801m89gf4nf6BMWAZTY/i5SP4UqgjI1bkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t7nRJ6nvFBlswfi6yjHPH/oSf1VrCJuu2MrSypxnOX2Su7UmS1w/Xme5QaG4?=
 =?us-ascii?Q?2LZwrS19Ln0eQFzmHSS2QuyViXCNgXNjqKwpZ43zcZVkNkDdmOt8COsB2ij/?=
 =?us-ascii?Q?47gTCef3Gp1Psd6T/0jBIuGOIFAE7Tgzso1i5+yswLzc6bLqF8ZQSdDV11S7?=
 =?us-ascii?Q?TxJlJIBcKPlh0HYioLCiRKZtQitwA2gJ/SwH0nGpIwABDyFlJpTiDFKq6kpw?=
 =?us-ascii?Q?vPeXyQmkFa6khnu1Tf6ahLnCXxYd+EzWre7o+CJuLHBrsYzPlU5hKvBXM2Nr?=
 =?us-ascii?Q?8BCGH5CW+y5mCkIBS5QuhJzl2EtdtzX10HDssxxNLoRX1srHhiGhURlIp+3v?=
 =?us-ascii?Q?9DfZhL8xQiKKCOiGNJYNSaC1aIprK2DyPisYXcAsfbTUBLGjcC4RxHR2M9x/?=
 =?us-ascii?Q?4a5j6Ekpt8hOQZPnDBWv6XBjT3ktvW7wq4wuUmeyjzT+DHjuGUWb9aLCc84M?=
 =?us-ascii?Q?3o1sAfW2gUdoNoc60ThjnNt+szap38RK7mOctHIyl5HdgqCkSPh016UMHv32?=
 =?us-ascii?Q?1Zry3UvgWjWB4nIC/i18xyKAlJchNLIIP9Omrc/d36Z2/y6h+d9wf4knMT7f?=
 =?us-ascii?Q?C07MAC+jnHHQraWshh7HZNm0cxnRKMeRyTTAGOUegoBd8C3WtsxdTuK3op1Q?=
 =?us-ascii?Q?tVZleOfxHXZc482iWtsQs/n2QrFGjDPM6wu8OLzIajzUBYmTWTJnHMOhuL4L?=
 =?us-ascii?Q?1LVRnjhbE6kayeS4DRofW1GkMZ8bCt6kr6wIfNbWxdJsyGxy6DJl7yNTwZL3?=
 =?us-ascii?Q?aF97LCY+ysyBj2brgYRZp+Yj9sweotxPcBq5KjpcBIfwF6YpoGM8pseJ6ee1?=
 =?us-ascii?Q?XoFpXOB9+YaHrmwBnYFWBIrfHZ9mep+xW74uge6mI7QUofqfllApBmcoTBFG?=
 =?us-ascii?Q?5dADKBexYpfCQPi+5bZChUlSWTIjhH45vYmfixa7Z6Ot1xihkRNtdRS/K/sH?=
 =?us-ascii?Q?uqSw/oV1sURmrvlPV3iRkJi4eacgTYwm+n7JejwjYHL5gteA6mH6pgmtRdRM?=
 =?us-ascii?Q?fsu64KEip1Q9EEFzR9RpTKcYuc9FR40HTVWOlW61V5z6iPEhj7oJk4/fGkqV?=
 =?us-ascii?Q?VIboBa3Zh8fU/q5+2p224WBip60SlY2GnFTvkLrECpqbsqAtbdQ3/YFhKXn8?=
 =?us-ascii?Q?9OSAbyjl+uCWxLBuw4MtpeBYImj7ESMp83sDbP9AW5awVNVDdtbVo0IXHUlZ?=
 =?us-ascii?Q?OHVvgoMtgXGmmz/WJHbEj5sjuqtTclB5+e9IuWKa6L9lrpSEJM1dRY+ihcDC?=
 =?us-ascii?Q?rRIrUp4s23nzxzuz2Roiq/5SGJ1OjUf7O67MY5sJuq+OugqzFAgIrjYg8Bhh?=
 =?us-ascii?Q?IwEhjngnpBx3QU1wdo7i7SuH1eq+QQAijdzdoq1JZEIc7kSUDO/3BWk50Ty9?=
 =?us-ascii?Q?uYhQZp4Dc3e6y5abl01r+z8TjgE/t2xUsk/k58T4UvjW9tR+u93Vj650cbmi?=
 =?us-ascii?Q?ng1M0wWNWRsmptLr7+I85zv2O0V62BmhecYuCexEWwewbTMy9nyS1CP8dbBH?=
 =?us-ascii?Q?HK6XaQm7xYcgqjUQtF6qFyyBKP9Vbq8cKaWe/WTuGD7Y7xlScfGDhi76EpmN?=
 =?us-ascii?Q?2PKUht8/1xnkhGFBPhSN5MoPTs0G7WE1Fs8WBpsgqqammfdvOBKxtmRjpI4K?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6036a7a-d7ca-454a-b710-08db8a7f5801
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:46:14.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XiyE6isrfyTiC/9O/Gs4hQPYnBt0wgca82RKjurVd81TjJiapIHeJnTEALqRCiIrcs1dePey22msWfIEeTv1LBTLelVmVSlq+pGqzCZ3H84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 05/12] ice: Unset src prune=
 on
> uplink VSI
>=20
> In switchdev mode uplink VSI is supposed to receive all packets that were=
 not
> matched by existing filters. If ICE_AQ_VSI_SW_FLAG_LOCAL_LB bit is unset
> and we have a filter associated with uplink VSI which matches on dst mac
> equal to MAC1, then packets with src mac equal to MAC1 will be pruned
> from reaching uplink VSI.
>=20
> Fix this by updating uplink VSI with ICE_AQ_VSI_SW_FLAG_LOCAL_LB bit set
> when configuring switchdev mode.
>=20
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: fix @ctx declaration in ice_vsi_update_local_lb
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c |  6 +++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 25 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
>  3 files changed, 32 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

