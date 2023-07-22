Return-Path: <netdev+bounces-20106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF575DA73
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2441C2095B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7BB11CA8;
	Sat, 22 Jul 2023 06:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5AA53A4
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:49:39 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02324270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008577; x=1721544577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ou+gwjy75rlN2Id4ONIqLXLCr3nqfSmsmgIK+X1aqHE=;
  b=KuBHyj1mxeKUXmgE0NypTOvOlGWiB+scBPRdfO0RLvWLeLiw+QnCU7S2
   ojXg93lGQ2JSo5URYsaXPct4k24c4gKCdpjnO7Wk7nHUqJBxvDqhN/rXV
   upNc1Di+5hgJw04PF2C3K/8z4nQP9m6Byjb2GBIe3nn9bwDNk2EyPquZw
   zXQRz/W8Q1ab42/kPlXvDcW1Z8a0rmJ9j5x3aVkbwSFXUH3ivJC/eWMEL
   +pGaa05U2+SxV4xcCf5xi+5ggGWWvc5wroMSEbR63CExLqQlwLQrmVcw4
   kpuBLdLr/KbMAA1lT69Roy5LBbo6aFgwODE+gW7VZBtkl+g/7+L4L6AAc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="346772093"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="346772093"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055813729"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="1055813729"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 23:49:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:49:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:49:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR6PjOGNKnL0D0wGRCr1RFbE7z/MrnN0gBgiY7OUO9KZ5ub3yTnbnqWrhm4IFl1k2XFBdfjmZEIffjd9H44zq4cP3OEOkWEt1+z4nd8oDMBIKGEDTYXkBpEDjujtk8IMH1rX7bVhQH0AMB0QoPXu8j2HHgUqB4OtQ506OjC1pMZEHuLMeZkDsafnCcEN8J1cDZGt0lfLMJHhAYGLbw6gm37MNGTVCs3CFLBwC2DfB3FL9TBw7gvAIclNy/7Y0asMA4apE1Llh3s2YAMry8Npd0iz7uInALVff0a3elMnHwd6A2mmcesterOLVQf9Vs8LHoJyFdMRPbvrWbzfJA+Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bKFzXIMpDrWFRm3R7sFYXWW1QZ1x/LdwoWftbk9klo=;
 b=NaqZxWl75cHJNetMFckL+5YLUJylnaRqihqGAizvjcGyVjJpi77vJW/RJdsOON7EXDXuSpqlqUUPYT1luBwZm/S7sTvBASpzsglPNt4zEwuwDp3oTktM1wRxrjKnbxUs4qPoJgkMvAH7OY1qt7lSMvZFOPcnIfxBsmldFU8bfvwQPoA2gwZt0+VkAivbin4KBjW46csP4nmFAZ3Be888MPinzUgl2eJSUhhSIVHdSoPiZU7OZLOBMw2XDmpjALwja3pPsgspwNDoXRDyElgATexezSGK/+B3FUUaIoKQ5xkXbu/ezDmoRNa2AL52rnWXZGNr8mQSvvMbILjBplldHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:49:35 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:49:35 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 09/12] ice: Add VLAN FDB
 support in switchdev mode
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 09/12] ice: Add VLAN FDB
 support in switchdev mode
Thread-Index: AQHZtLDwV0LB362gckSxqw7fFrefp6/FZ9cw
Date: Sat, 22 Jul 2023 06:49:35 +0000
Message-ID: <PH0PR11MB501360B80A71892E233FE0CD963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-10-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-10-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 2f042aef-351b-44a9-25fc-08db8a7fcfb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RE5WFDLotnwHxqgcmCGBR0xgLGJNHfxwSqQW8hDOx+mqi/gkLlQ4/83/fY9LHNgjLlqdMqByNn0de8TVan5mip8SJjzUgujAaeBQLai6n98Bi18jmEFiR5BNtM8xR2REE2Tt8SR4Agv5zqccZTdbclF3YPE1ehgH6ds6wxSwluJauyY4x7t9VEcbKt9kQHb0Wu/F/DNcJIbkOVAh3s2doKPG/ZqRtt9hMlfc4htXNoqQ6xgzyteEplakm/vV/Q0dwONj1O4YM74n1yHlqu15euGsX/MrdrQDHDjSRis+xAKYk9GP8t2UmOASCKw5F0TbDaGakF7oTgT24n2HGqm+hU8/f5lb2JDvWm3XeQdglHoGaJGZrZOcROMHsCCshX3Y9Fy0ZdLXZRt8N6S24mfm9ongY3CSSAtMXg4qSUXLxqjTUn1G3RC8h2faoAoEg9eIooEMHN6dyIXr2WJiU+UJ/DpdrdZZvX0lKahBd3rbQwCrQ4V9JA/oDBItzcDCGE1JaUca7zCUYh6Ab5JXdGwXWUKosMOoqk14xqBZ2hzZvUAQzSo3cMxs9/WVKj6EiuDUYDekcJDYC6vkpJmG2/vByMyPR/ACGghQAebuhmC8ODVagsyed+fJw+u0rmdfYEuJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5jPCwVDJI1FcSyAd6wzfiW2kL9oLjJmp3U/qlortDQfNY1B2+axHkwW9XVm4?=
 =?us-ascii?Q?cj5Po3TwZPTe6b+t3ZlMSxNWUYepuHvDhEnZLx9G2SXCZzkerIZkl7iDjANQ?=
 =?us-ascii?Q?sT/Rj8Y9jsUFPXifQ72GvHMuAZxtrXmDao4nyjz3AdvFORmjXTysC4y63Egq?=
 =?us-ascii?Q?yg8/Zw3XzEWf/YEzLzzftozLUfnRrin7+Px2K9LJje8yf7g0SJcTi1CKduCN?=
 =?us-ascii?Q?V/GQth0ebPfQQUMrYsMwTVw+l+PrfjE03t2WCG7VeY/jYs2a9wr6rBRMby16?=
 =?us-ascii?Q?QFvQSu0le5wguhhSy3PuUBIYbTTH4ygYpq5MRhvGhuh8LQWpxhBHWovFffqO?=
 =?us-ascii?Q?b6QYT2C3+SrZ+Hoa0XMgUvPoUxwlI0ngDa7gTHIb9hFH0uCvMpx8eKanYCAF?=
 =?us-ascii?Q?repSTXrSmmNW6Pr7VuUwoeDFkseL9NNu84euLGKtnVdbwPNvlFhn78gcRTA4?=
 =?us-ascii?Q?dY9qQtDI/SkFU6YroTZedNxqEKu2CfUGVx7RmYGRntngVJWS0MWtlR4PEMgN?=
 =?us-ascii?Q?gJsMM4hWjzhcLQ7JBYV+XGW2X4eKA/G1a/zz5K+K+lnsd+LPXXra4Wkvo/iN?=
 =?us-ascii?Q?k212rjeQJLLbPW+Lg0bV4JuywIdFopr2iWn8w3tSYe5BVogKPxmccdI6i4hm?=
 =?us-ascii?Q?oRtQfCFeRJQI3l3Ec/JdsQ57F+nLZoMGDkoFzSLU4vXVWyjNRw96XEt8LSSL?=
 =?us-ascii?Q?4mpZKikcZCTr9J5IDC99TzzHenD62SZ0JLiNYptP73nyvebS3S8lkjTG9gcW?=
 =?us-ascii?Q?/vc+B4pNjmsnDG2dgN604Pmbf4OaD1v5wbr3W/WtHiCpzCGF404inqcxX1ip?=
 =?us-ascii?Q?npnxed0zjlyYx0RKKjQlvoa2V3lLTJYjw6+RpQXx9iRzBIe5x+R/joaVtRkl?=
 =?us-ascii?Q?HlQdEMffbmAfR6PA+LEa4a3SoFsjQiC+5mIYVyPDNY3ofgI5AEgkFyAROWMS?=
 =?us-ascii?Q?PsLdqUiSQBULngX4LUaXVgp5YA6yrq+R2V1M6nNX9OmNoNdKKVmfbYODocCx?=
 =?us-ascii?Q?HxRnIx8How+yYYyTry4J/FNkhhq5KJka7x0WZI+AktqYSif3dH2+P9sKkmu8?=
 =?us-ascii?Q?gRQ01utmvaAn4thOPNmNeYNHgmkwguUeJuKrQBvEeX37iPY9F5Rq/js95A/Y?=
 =?us-ascii?Q?see711ep9NjiE46+rpZ1uHAuGiA3TbsGhVI2aZ3v+01NCojiJLj3J1egVoPm?=
 =?us-ascii?Q?HKUghWP6Rt7gY/HlXV9iOfDTukixZu/UYV5D5lH5BY6zLQSuh0p1Ek7MZrbw?=
 =?us-ascii?Q?JjIHvUhvBErGrIVn1MT+XaDno005pdEH6qVuqloQwHo/4HZs7TYxcFIH9mU+?=
 =?us-ascii?Q?FRCxu8ftpizDF8XyffsKppU3iN6pl5O+7mmnIRn7Up47byrslTC6lQL/2nca?=
 =?us-ascii?Q?bfgXU113t6oFlM5CwNVwCmYMTWt5cPTCQDSb7cIiQmq/Uf0ExHTnCqlNlpe5?=
 =?us-ascii?Q?WWDubuWV2xpSZoyRkDnpiUKHDCywhf2kFBGJqsULD0ZIGgYJSOhNiXJ2cwHu?=
 =?us-ascii?Q?kYrmXLtIqNQHSA0Blv4Irke3oYUjcJAHUzoZbAevNwt9vADy/llSpldd7uL9?=
 =?us-ascii?Q?Z6sCKi/whKdZtMqpkS5tYIKc+8vi0KiIa12WCICiGC3uagedrg2qMVLoUAOy?=
 =?us-ascii?Q?PA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f042aef-351b-44a9-25fc-08db8a7fcfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:49:35.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pepdBBvMTOXHtpt0THvJjV4OIyZ3lfoThnEd6At5hm7YF5lcw1NCmN63GlTyEVhGBMVPBpcUDB+CG1uzvQ+t7MFpbSXPUqGD+Uf7INIJhSg=
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 09/12] ice: Add VLAN FDB
> support in switchdev mode
>=20
> From: Marcin Szycik <marcin.szycik@intel.com>
>=20
> Add support for matching on VLAN tag in bridge offloads.
> Currently only trunk mode is supported.
>=20
> To enable VLAN filtering (existing FDB entries will be deleted):
> ip link set $BR type bridge vlan_filtering 1
>=20
> To add VLANs to bridge in trunk mode:
> bridge vlan add dev $PF1 vid 110-111
> bridge vlan add dev $VF1_PR vid 110-111
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: introduce ice_eswitch_is_vid_valid, remove vlan bool arg,
>     introduce better log msg
> v3: move inline function (ice_eswitch_is_vid_valid) to
>     ice_eswitch_br.h
> v5: introduce ice_eswitch_br_get_lkups_cnt and
>     ice_eswitch_br_add_vlan_lkup in order to reduce
>     duplicate code, rename ice_eswitch_is_vid_valid to
>     ice_eswitch_br_is_vid_valid to keep the naming convention
> v6: remove FDBs associated with the deleted vlan
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 304 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  21 ++
>  2 files changed, 317 insertions(+), 8 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

