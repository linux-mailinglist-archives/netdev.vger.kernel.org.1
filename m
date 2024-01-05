Return-Path: <netdev+bounces-61940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7F825481
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C91F21D35
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6052D634;
	Fri,  5 Jan 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GV29Yveo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0F2D61B
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704461539; x=1735997539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N61yChgMFyEdakxn72AXCs/FwcZ2Y1sj4uj0VVkT5qw=;
  b=GV29YveodM3hAIKCz2ftDmKW1oKAOHgGIwTOjOJXTqha3Ids7tB+IMEJ
   BK1Q+3RHcsQ2VIJNhVliuOBm1b9huRt0M+ZIAe7eXqnhU9Njkjfa6akEt
   Gj/dV5uSNtLWOjLhmbteBnMYf2MTVxFlEkpZzan8Sgky/K7Lr6ndd1nEo
   ZqPIl2Apbaf9VL8KwI2Q7wu5vHvf31ONLfrfipRe8pGgBobouokmllE41
   Jm0umqclS/pmEAz+c+hBeGX60ZQr28I4FbchYnwJlR40ka0USUWxcuGm/
   4l2uNdEH5sW1nHObcOKeYQbrNI4aXjaY7wxHCH6fNUx57J7DGFfUzYFGB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="401291341"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="401291341"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 05:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="730476010"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="730476010"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 05:32:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 05:32:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 05:32:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 05:32:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 05:32:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpwgrpweGbVbHc1g5AyOHix90lsJ75SI6c1L8XnS7bgQMx2LUs4YpCotiXgRuJdT9kzLAH5cHUQ7FDNTLh1IFWhRZUN7DGvsaY+a+c/52k+PkVAJW67uakOYj47w2MLmk5atPwYWFPRhFlOSNCVxBMEinJIO0Ab3qpWF8i/NUK37TUvNnm0MyJI+U34jrIH4orZlvEvq1QDpnITl2DUWMVjHIo/A/joW0MhMf2z3qzvjIVbjDPloQ9MI4RPrILKjiYTGHSLbg7ISNNZ9riAa8Eixcwbqs0G+2ErQXl4MsL9i5+sO/Ng2yYtA9QAsji3crOtEQeYQZGZjP2qzhUU69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr8aJKK4VxAdXFcMFzD/ZnPEZiZAQ8HDN7bj8hinyx8=;
 b=YqYhd3iYHeRMtniHrSo3CDe4psHXz2T6uAhXgxQ1PI16Q6R2YoAcsxPHkrACNJZqVarplfXqbaI3SITsjdSINtMOFBiw/5zDxRw4Op0x/S1265NY0WRoGNluP/ktcHQdPDmX2pjseie83C4+kXt4gjTEEIaFcsjYVaIGCZy6pst02W7IY9RpBn9Eg1LTsAB1oMglQA9p0BDW7kAlQFWhUagxjmPSdN4GuhkeR6TnjQluvIMA8gDfplsl5H16YFoofH1s/2l0P56stBm1Vo/EA6qLgtK5NRij+2M9cj3wBf6BImsRnxOUerzMlcEKWeMpLVxL3ArqkQ4sBDzOp8mdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Fri, 5 Jan
 2024 13:32:14 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:32:14 +0000
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
Subject: RE: [patch net-next 3/3] net/mlx5: DPLL, Implement fractional
 frequency offset get pin op
Thread-Topic: [patch net-next 3/3] net/mlx5: DPLL, Implement fractional
 frequency offset get pin op
Thread-Index: AQHaPkjaDPKv4TKSL0SSvj3dxJdlfLDLOBYg
Date: Fri, 5 Jan 2024 13:32:14 +0000
Message-ID: <DM6PR11MB465767BB4F64CCC4A92114B59B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
 <20240103132838.1501801-4-jiri@resnulli.us>
In-Reply-To: <20240103132838.1501801-4-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: 20cb62a8-4374-463a-4210-08dc0df2bae6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzWjyHB6QW+Iydiwfrk+AKmFx8h8QX+FwqnkWhcDzIkjOTZSELiV8S5sgyubW/6MKmPM6ynMD9LacRHgSYOd5c+wxWmUjXZ21H4Bur0ksGIUtV/dEx0dA5O1iuACPaaxUaxeGJ1QSm80oLg7PFaRQM+xlm01qNjgE7O/bV9skz+LeHyTnUBUrYPllMDuw1e6hbZAh75SHWkWJyKI8rUgJIut4ZF7IrGWqvz3ByC1wEmDyBFpjiZH82wqS5ByJzLLOu3F0HWIZIPHV+zIGiiw2w8HR8ORYfLEQK65Z6UpEhkcS32ZKL/5O5JhT/ejurg2cQ6zpPzGyfRGqfcTEHMC8kXQrbw2jUA88Uxc2WD526bwvooBjlMfGGe5tuVA84hq5RHHWEoFmRyqwQQSrzla9nfvmBjr/qINSkf4v9W7ft5bepjuJ2rGs6/4y5pJ52dwdYLUVypenYJLeIukyHREFTO9YWzdPyLm/s1/Ot8Obj682Wb48KUYMrjQiXIvFnCKF0umX0rZ0X+YZAMBrxi9pJRizqXLcfhx6D7HGeWeYBKJ8N1gIfwH1TdI7zpZRUJhkshFq5ULfUNPpt3GMUNQv6cYvp4QMVnIlfOYs4SSFr4MkjS5Blxm8TfMeTJwqNjF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66446008)(66556008)(7696005)(76116006)(66476007)(66946007)(71200400001)(26005)(38070700009)(33656002)(122000001)(86362001)(38100700002)(82960400001)(83380400001)(41300700001)(478600001)(6506007)(64756008)(9686003)(52536014)(7416002)(4326008)(5660300002)(316002)(55016003)(54906003)(110136005)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ZKbIIA7PhPNmP8e1Gf6a78KG82LoLGuEBpJ45lw9abulp332hgOQ6T+6cJl?=
 =?us-ascii?Q?fE/zZ8Xr5tBqDn5zyU/bOFG9gaosx4zaMZXuoC58zAkyog0kqAfp47PD7Tqa?=
 =?us-ascii?Q?vdf/kmRJ70dvC2oI7dOTF/6aGFFRS0e1utOunEp6mU4LMw8aUsZqJRj1tUti?=
 =?us-ascii?Q?eQEbw/pM1BlgVWFWSfw+2g0A0lguzN0XQksY+sbgteCSWXa7jURqyqjsdP01?=
 =?us-ascii?Q?o7x6klUZpwnDCBX5ru41FrcgMeWIFguH3lRqEKys/3Ry8hz7DauBVDgrLX7s?=
 =?us-ascii?Q?UoWqCpuWVQtGXJGgutKnQlD2YNe32MnkOSoBjBY+0ngaHXYu4rckd07U84KI?=
 =?us-ascii?Q?s903D65gznWPSjd88sUZgCJmqf13OR32aJVQwJYhUOLfWim6KsVejKiecX7E?=
 =?us-ascii?Q?Vhq2QoKDHm0se6bUn1390icUOXGJMCA58a7aE71tdBQerkhiVv493ugKWJce?=
 =?us-ascii?Q?2T86eR5dwCyEM8TooAUr0oHcOgHbtTWOEO9sZ/CC6VMjgtf5B5NpJzPMbUEz?=
 =?us-ascii?Q?40pbwP9TSdaYFh944Y2fQGcRYAEj5NdzJuYGmTTuoBJ+8F+m0Im97cBPQH5U?=
 =?us-ascii?Q?XhNJgRjEKQkgMS+uFqOjqT81puEglscDF5CPUxqTBIYmt3XiW5gTvAyx0nRj?=
 =?us-ascii?Q?secn1lxwtjXENJQ4ewX7IDdfrQBC1P7PifhU+MkM6PNMn6VcmJu9J7HrW3yK?=
 =?us-ascii?Q?xy3KXxsf7lbFUDlL2A8uBcr1gYLd8/IHJDvZ6erp03swM0NXqrjphtG/ikVU?=
 =?us-ascii?Q?+XJKwf4risTEVnXoUyR+MCPNA1FY3frO5cUGj5uTzwCXtF/puN+6pS0LIt6H?=
 =?us-ascii?Q?mZtpTfGxT4cpoIKdNLzFK5GjdDFZMOqNHcdB6fS9+f1RzqZt0JZu8zZ3QVU2?=
 =?us-ascii?Q?G6PfRGRr/H3aJtrs+zNoaWzOEm6hMtbW4TBESTempl3x0Dx0uUNcHxcgTnc/?=
 =?us-ascii?Q?tD6bKtAF35Ot3OQBh6uXf3Ci7BU/Oc6e93S4ULBtzS/0ydLwmuc3x934kq8l?=
 =?us-ascii?Q?RdRjFqQ0eb2Vgj/7gGMUAc7hDQ6BU19msRw4lVdHTYthHHmAI7vXLIf3s7n1?=
 =?us-ascii?Q?UUtotjRdxm30BBOY9ZP/6ENVO0W2Eh5aqdwQyn+7rX5pioZTQj0yJkkXt5MZ?=
 =?us-ascii?Q?kZoqJ/AvvYeSLBKkA12GrZDo/6Uj6yio+mqDvhHw9m2GWma0mnOWjnZUDXLF?=
 =?us-ascii?Q?2YfUU5NpljN/H2Ie1GTGVE9UwmkLaindq14yby531OSZVFdaiXChgwHg+/PD?=
 =?us-ascii?Q?KXxtcLjSM8cM2SL6ngDfkzeJsWsvPifYC0gmlshW/U4VZnrGCDQ8Ck40uk+3?=
 =?us-ascii?Q?OLO7WoZPUw6/p64RFS8KizQxZX63xmEWM3M19dLCXHM2Ou1s02Y4Kjr6aO35?=
 =?us-ascii?Q?BpgiTQf3xptD1FK9ZYHv0f1c1Nxqi2B9/bP3E7KLoV/KA2Aam+qgKqiSQUmt?=
 =?us-ascii?Q?+k7McRLWjLsh4xffLHw+XEWT/jnc0dtb+bgWYONsIee/ShHabvYxOACgEI/s?=
 =?us-ascii?Q?gTqNAvBl6Iqh6R1Pj7OHyvOBa4eTFGB7SpezY+0JyCSzWs2p8tigdZaHhJy2?=
 =?us-ascii?Q?vbG45jja+DtTdTrXcZz3tCHDLvg5USvpkevlYo34x+zh1zczYG6KNJNTuAiH?=
 =?us-ascii?Q?TA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cb62a8-4374-463a-4210-08dc0df2bae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 13:32:14.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujZfpAuNfxHw5R4Au2MPshdGWZdeup49WKntUYXioDS0QAl2dE3DneiukHR9IDSwP5zl1HDFAxYdr6I9xR1Fyf6BAybKuOaTVMnLwAaLo8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, January 3, 2024 2:29 PM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Implement ffo_get() pin op filling it up to MSEED.frequency_diff value.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 31 +++++++++++++++++++
> 1 file changed, 31 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index dbe09d2f2069..18fed2b34fb1 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -40,6 +40,8 @@ struct mlx5_dpll_synce_status {
> 	enum mlx5_msees_admin_status admin_status;
> 	enum mlx5_msees_oper_status oper_status;
> 	bool ho_acq;
>+	bool oper_freq_measure;
>+	s32 frequency_diff;
> };
>
> static int
>@@ -57,6 +59,8 @@ mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
> 	synce_status->admin_status =3D MLX5_GET(msees_reg, out, admin_status);
> 	synce_status->oper_status =3D MLX5_GET(msees_reg, out, oper_status);
> 	synce_status->ho_acq =3D MLX5_GET(msees_reg, out, ho_acq);
>+	synce_status->oper_freq_measure =3D MLX5_GET(msees_reg, out,
>oper_freq_measure);
>+	synce_status->frequency_diff =3D MLX5_GET(msees_reg, out,
>frequency_diff);
> 	return 0;
> }
>
>@@ -69,8 +73,10 @@ mlx5_dpll_synce_status_set(struct mlx5_core_dev *mdev,
>
> 	MLX5_SET(msees_reg, in, field_select,
> 		 MLX5_MSEES_FIELD_SELECT_ENABLE |
>+		 MLX5_MSEES_FIELD_SELECT_ADMIN_FREQ_MEASURE |
> 		 MLX5_MSEES_FIELD_SELECT_ADMIN_STATUS);
> 	MLX5_SET(msees_reg, in, admin_status, admin_status);
>+	MLX5_SET(msees_reg, in, admin_freq_measure, true);
> 	return mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out),
> 				    MLX5_REG_MSEES, 0, 1);
> }
>@@ -102,6 +108,16 @@ mlx5_dpll_pin_state_get(struct mlx5_dpll_synce_status
>*synce_status)
> 	       DPLL_PIN_STATE_CONNECTED : DPLL_PIN_STATE_DISCONNECTED;
> }
>
>+static int
>+mlx5_dpll_pin_ffo_get(struct mlx5_dpll_synce_status *synce_status,
>+		      s64 *ffo)
>+{
>+	if (!synce_status->oper_freq_measure)
>+		return -ENODATA;
>+	*ffo =3D synce_status->frequency_diff;
>+	return 0;
>+}
>+
> static int mlx5_dpll_device_lock_status_get(const struct dpll_device
>*dpll,
> 					    void *priv,
> 					    enum dpll_lock_status *status,
>@@ -175,10 +191,25 @@ static int mlx5_dpll_state_on_dpll_set(const struct
>dpll_pin *pin,
> 					  MLX5_MSEES_ADMIN_STATUS_FREE_RUNNING);
> }
>
>+static int mlx5_dpll_ffo_get(const struct dpll_pin *pin, void *pin_priv,
>+			     const struct dpll_device *dpll, void *dpll_priv,
>+			     s64 *ffo, struct netlink_ext_ack *extack)
>+{
>+	struct mlx5_dpll_synce_status synce_status;
>+	struct mlx5_dpll *mdpll =3D pin_priv;
>+	int err;
>+
>+	err =3D mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
>+	if (err)
>+		return err;
>+	return mlx5_dpll_pin_ffo_get(&synce_status, ffo);
>+}
>+
> static const struct dpll_pin_ops mlx5_dpll_pins_ops =3D {
> 	.direction_get =3D mlx5_dpll_pin_direction_get,
> 	.state_on_dpll_get =3D mlx5_dpll_state_on_dpll_get,
> 	.state_on_dpll_set =3D mlx5_dpll_state_on_dpll_set,
>+	.ffo_get =3D mlx5_dpll_ffo_get,
> };
>
> static const struct dpll_pin_properties mlx5_dpll_pin_properties =3D {
>--
>2.43.0

Hi Jiri,

Looks good to me.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

