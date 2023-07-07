Return-Path: <netdev+bounces-16031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A874B069
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981CA1C20FD3
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E4BC2E4;
	Fri,  7 Jul 2023 12:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63956BE7A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:02:51 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76E2107
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688731370; x=1720267370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hd3jyKL3W3fYFX7qgp1FitdySdzuJf9dJJOs2Pe/FUo=;
  b=CewayD6vfqZUooUV/HTaOKGmgXEbJOpWrj3xboqQVgxdHkbV4w2lem+Z
   Vqkr3XhGZUuQW8xK1zKHY6W3/yudrRLTdb23FckuRLIktyV8HU6mx769P
   LuAk8XJYnf1jmfQaWDEZjoj4JesycQQdOoID+Jr2MlSrpNAYt5ma8BdGB
   lhrrCKO2tUPxwQCx/hMm3M3jgB6+2NBw2wf1grnCsC/Z9Uzt4xwIs+7Km
   SwqoA84K13B/MBHDFic5jr1OGan5OM3AHvPDp639/qj4u2mATKW0BrfAR
   t9UWLGhNTjxXBHKGmyDB7neGR5RWVR5BzIkKpTSHTf+e9Ko7QPINXbP0P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361343343"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="361343343"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 05:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785345370"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="785345370"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2023 05:02:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 05:02:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 05:02:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 05:02:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXfmdsEAju8Bx6qFaR/Ddm32U+PYXyrfmkqUmmUwYkEOnBMP8J3KUjVd+6Eij3vi+mPw9PMm50XdFHUulnrdrxkFf1DDy8u/Qx53O21N2x0F8pyaLm76sSVEz5VqfP+hAH9BLYLjUSfJRhGLZO9FiwwuODvVwH5Izg/RD/w5/y7fwuZ06go0xa9BQ9k4y0K3SpOVf9kWx2tiHnw8omZm3lGz2R3ddymRnR9J6F6AhrbnRbNDk3nex4osBfagU9zHgFEg8hVkYd2oUGjSQsyQa1vu+EtjuyXojebqrj5E9xfDslHgiTB9nbQImh87u2d0/dnuvocAiPhSUSc4BL56Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2m7SNJ8r0WRQl/vcBtiWzg5KZNAcrmobuXajv5b/Mc=;
 b=Yl1YFlCw2KUH9lEFyGQ4KCDVmS9TX2CKB8SbW0mdF6gpn20vRyfAWPUzDqX5U44vJEZDZtHI3liHLCmaXwQBKEduT0Lu2QtbWpVNkCUs+HV2S6svSktyg2RJJG6Okvrq4eTreThM+fjVGaRXsRRy1GJ1g2WSu+AjuIpowNxo5A1WTbDKIscTTlYNj7+p2nTBnPBhjVCMKwZqn0cA/P0ET0fB7hVTSvNGhG/myBURZTpcr2NSN38JwqqbS3JbiIvwp97h0VAQ9EjQciZTErNsd39QgAi/QxyQt+tt4gYbU9cMyU+UkIpd1YddgZ6uHBq0ZOmwoSA5SUNEmElXt1So5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 12:02:02 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 12:02:02 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 09/10] ice: enforce no DCB
 config changing when in bond
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 09/10] ice: enforce no DCB
 config changing when in bond
Thread-Index: AQHZo8XNs0tWM32rn0+rUFrpRw4656+uThHQ
Date: Fri, 7 Jul 2023 12:02:02 +0000
Message-ID: <PH0PR11MB50134CF5C4E1063DF3028C28962DA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620221854.848606-10-david.m.ertman@intel.com>
In-Reply-To: <20230620221854.848606-10-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SJ2PR11MB7501:EE_
x-ms-office365-filtering-correlation-id: 52a90791-d043-4f2f-cd5b-08db7ee1f9af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZxtOEazi8CvWaIh/a5w95SLl7hv42j9sDDvojniY1JLs2p+lBaAZoa48afLwbfWskRciaU8SzJgcTxu5Eql1Vl7Cye+eVYkv62E5by/qKV29q2bqOvqL5aixRKKP+tbQ1MT26eU7HeRrzOXyoh8ERrRwdLCMS6elCP9mgavKRIt4/CG5EAYarxC5ksVmtk9byoGz1B56Z/CLIcUD4B1QJwozAtEjm5QIzmtz5jYH2DWjvGjMwOVwBl4fpW0heFQz3601ek67qUXEga+vZJEK062AC+6B8Eh5rfupK8T+If6/aNfhxhaU8pSw/1Hs/1KjzafuNU2ibjL5E625Oo+gAEzNRakJAaj91CqGxmAcXnoeYi2t6wnAitUmOlTVThN6zPD9nm/2cOov5vfCIihKIc9R1LmsQ+7TFUu/wBS1fTrh4UBaBBxtEykI6Ejx6UqqBB8uMl8n61tO53mbU2UeQe+8StfS176dyFPUHsJS3hdNvC+YWLoCtv97iUXCqCbto+/B6M9zYordV9aPK2BfofITNG+NBhfv4VbBsDVrow2KGX5StUp/D8BPwu1J/7vphJ6B0N1uI54mKbL844bU2jiKQwhV71bU47mrDwM+ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(71200400001)(38100700002)(122000001)(82960400001)(55016003)(38070700005)(33656002)(9686003)(86362001)(478600001)(7696005)(6506007)(186003)(53546011)(26005)(8676002)(8936002)(5660300002)(4744005)(54906003)(52536014)(76116006)(110136005)(66446008)(66476007)(66556008)(66946007)(4326008)(2906002)(316002)(64756008)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TPOXAlgmW4+BJMu+Dm1FA5Dj62GS2I5PZt54BMk5jKY/wP/EMsPmQvzbV9bE?=
 =?us-ascii?Q?GcDvoCNxZcJg4JIyMsVECmR4j3CRv0pAwJtXut/4A1+GrOnFldRVWFj6IZmP?=
 =?us-ascii?Q?aR45WXgpKVD4sumzm+zK+b0SnT6Ts8QovFcZ/0yZUIfCnlPKk5In85yTfBGS?=
 =?us-ascii?Q?rfKDNlXzvZRjd95kVy75bNB/hRTxVahbx3gvWaTISIUz7gZ+ep4lqVIQJiVc?=
 =?us-ascii?Q?4cCx7HLttX911n/8ogwcNhovrVyi67hy9N/nhzC42g0Ti1sdeYNH337E42tN?=
 =?us-ascii?Q?DzHOVu5F8YZe1vgriy7XXYDsAm2p8na6WRm4f+kiehybEAPASzSuNzJaZlGB?=
 =?us-ascii?Q?J0uYGpXOoA7dsl4y2Xg/Jx+Sj+AzRqKVdg2edoE1CAeGubSwwqZiN0RDqR20?=
 =?us-ascii?Q?nxMijHVfQwD+af8nxFXRQxSbJeuU21eoimKwEa0HG4g6AV/dyVqEh7Y9VgJk?=
 =?us-ascii?Q?lSevnlh/YLfSkmt2gZKHlvg4zjygV9xzC6weQIREPKv2JPbQrSEk058CbGJ9?=
 =?us-ascii?Q?wDbQP7LECAZsuRSZrfEY+YTcdD8VqEeOj5V7VkfsVWWmYWhQq4+jcl7iF/wA?=
 =?us-ascii?Q?B3lt/fpoeLTdkvMBdkD8chSJhZtXONAUZlVfwOGAxGfw60GQaTbTtw3vmALj?=
 =?us-ascii?Q?/IfX6ssiT4wEAoCQRQhSBvL1/FX2cPdMkS0VhutAI3Bogr3CXVKPSOI7exNw?=
 =?us-ascii?Q?87SN3vjellAy+zrM7p0GZhKJ3ob5956X8hxvxSwbo1Rv1dQfyTAsDs4L50ZJ?=
 =?us-ascii?Q?U/8JhAOXTJsSo6J5qv8jRrBM9ZzudzfiEgs1XKEDs1Y4orLna6D6cqnAW35L?=
 =?us-ascii?Q?X709UiV4PD+q0RxZPqi7I0sEkZs37cF1BObnZgHikS8BWnub1yIIW1G7c/Mz?=
 =?us-ascii?Q?xG03uHtSFQQqvBYPwoYqDUHzCMdKpY5q164wAO0bkdn2cneAsoT+KIE5+vRI?=
 =?us-ascii?Q?zWCzq9C5w/tnKF+LeJlmCb32ZKFWQK/nKhjOWrw+L0dt4U8dcdEk4PoLDX7w?=
 =?us-ascii?Q?SjXPn4DamzSGita8IKgAIBQi60x2WAc6bvDPZi7IK39t9V57xDgklwLMIn0I?=
 =?us-ascii?Q?8XwiCAuZwsb4F2RTZvGTtrdD24bpYd622N/b63l0acDg7GpsqZ8QHlQkwu30?=
 =?us-ascii?Q?Z8Jj8ZHjTFNAV6Fcn/013GG9NsbHpKNG7aA4vPAPqBfNp5d4yjuz+ij74Lqu?=
 =?us-ascii?Q?pZnZ0CvC6ixfHm7B5d/m4qafNhFb+1wUgZVNBkYrE/zytPlrEHf2D9qU4fFw?=
 =?us-ascii?Q?Fr/Ln2HtGA09SaD26ZPynfrSB67wEfv8ufyv66cHWdpdvytZvns2BfkFTSb0?=
 =?us-ascii?Q?mhxn0axHnbwo3FFBFSHskjVc5utmaiCvcxX8PC9q41UzvbHjC05XnCKcS+zi?=
 =?us-ascii?Q?caYuhy9uEWVoaLYv1z37YbB8MXXqhH58DcIREolzA6rIymCH4w0GAArpJO83?=
 =?us-ascii?Q?C1LaM5KnRHltg2kIH8yqK50UDCgPmIoRYOI7G8wdzFCmHay6k9vi5y+oITJn?=
 =?us-ascii?Q?ap4HkOWE8nc0WKBqUyhDjZmbIOwhR+/JFZ3mOT2fn9yowWSYoz1k57xQ6VEU?=
 =?us-ascii?Q?IMInIrOH7xOu2LuHuO1ELS2Xhcn5XFkwJVwyajeR3aNynbeIIp8urOzh2/TD?=
 =?us-ascii?Q?8A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a90791-d043-4f2f-cd5b-08db7ee1f9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 12:02:02.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WZRpmvASeuXz+qK5pF6KaBvXtdz/2R0PAPd478Cj6ZL+6NKNlAwCMx0toYj4Z9Mgc8BwIS52hSuBtU2opX1CXohS5KCXKoleYlPc480Tos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Wednesday, June 21, 2023 3:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; bcreeley@amd.com;
> daniel.machon@microchip.com; simon.horman@corigine.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 09/10] ice: enforce no DCB
> config changing when in bond
>=20
> To support SRIOV LAG, the driver cannot allow changes to an interface's D=
CB
> configuration when in a bond.  This would break the ability to modify
> interfaces Tx scheduling for fail-over interfaces.
>=20
> Block kernel generated DCB config events when in a bond.
>=20
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 50 +++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

