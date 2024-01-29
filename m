Return-Path: <netdev+bounces-66579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675EA83FD6A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 06:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1C28263F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 05:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B2446C9;
	Mon, 29 Jan 2024 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkMaV3CA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B159446C7
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504650; cv=fail; b=nEySx7JrNk7U4hHIZwherWmTHz4Fo5yMjWQJKjCLjHP2kCmcwLhf6XeAHzN49TVPHo1ywpaIaUYEaWz/LbHjeUnzhiChENInrm7lRa+JZVneAPHWb0IS3NDmS7hX0rqvXsK+TtpsCcEWXCP6jL29jYWcPkh37K7eYSe42MbjJt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504650; c=relaxed/simple;
	bh=C+MHseRmHFk5fKeSdy0+fuW6tNmixbgoMMUYU4aLfpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSIBWj9d7sqaIVaaqILXZRECRqoDzP+4T1vzZPyo3J5dtgeLO9s4YLh29Y1x0gz1NKfWAnRO9eaoFQZ+V/wdIFYHbsAdoxxRSuyAxiAzVOtk8VE4lLbYldsPwkXiHa+jR6NbxF3JRYaCCThyU26j0iqvWlqtglqAP1Fu4znyW6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkMaV3CA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706504649; x=1738040649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+MHseRmHFk5fKeSdy0+fuW6tNmixbgoMMUYU4aLfpw=;
  b=gkMaV3CAKtr7auYCUOiLQZxSvdj4ZGmH/a5DjhLTu2ETIit4aiEmq3Bi
   wH8tvzSv1O5Xw4Prq6Uacgsb+h+eWAovRvtDoiD8BUEMMn4fFABadJUd8
   GygvFjrCPN/jN8091q82O/oUCznKsLPy/9teSW+Azp4kSnr/tILnO9QmM
   BbrK7wiHOlQuYBGXtKQnzcTXzvspkvgdt6UKFMEZAvdThhG8BTwkEhbqA
   Y2HQY7R9gjkOa59ISv+Lsgm8iynJ06MLH+jXDl+kDpvqLkO3hXW7ESizC
   hfZrgGp3z+Z7hIQmDTs5ZFSrOul6p2ZA9qTQP3M/mMAXRJXqnh4MErtxA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2740759"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2740759"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 21:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="906966856"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="906966856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 21:04:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 21:04:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 21:04:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 21:04:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 21:04:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6y27ZOEyuz4XofYE5+3KGlwO1JOsJtgqKOvlmV1JMEqq8XD6tSDFc6j24JnGj4MTvFrds0SoV9F0YojFS//2W9ANWX0OWTDmR6/rYxIgvuMOXq+RqDRWsMIYvjyQXLR+o6edPhwyXXboI2VmKUn8dxOYCk6sXa3/KF1e1jIP7lJXfvwVr4LtCj/P8MOz9eN2mPL9iZOeitdmot/qcc4Sq2NSwVchtVjFz6vbBaw+uc2gnuA2HHKS9lalnEPL2FdBjR48j2yuMxqmSe6i6xrIAJL3zdR5ug/m4lBntSon+qlKD2D1Y3b1mbKDlFnrnQ0M3Tnb2Xu2YlvUsnOKbQgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/dWu96Qvp5UMVWncFn4IrPKEKmDkIEyli5JJKIWUwM=;
 b=Fp9vsgqe+IqJXwtM/IN3KXryBCpmT3cKToBTqmoopQ3vb9PN0AST/TvkWztz4lQoNlWVDVolo+locEIzJCVErorpMMItnDP7EZd63N62FE112e3UVqznGjC0NnBwmjuRnozaBtsSBtDgwgL85nMF9K8DPr9atnniv1zq451OubTiKj26pmdYRFnA4TVsWhVHjcLRygrZPgb89EqlDpdKx10kLUvlzwosPYc85WnymlBBa6cuUbVtBC9jHlp52SjqLGclr8cdYZGD/2BHKHP0OhJTHF/WjWJRYLJzy+1++i7LRzccxx+stQWT9Oxt7JY8+XtGHR9noGKrQJVpDwAdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:03:59 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7228.027; Mon, 29 Jan 2024
 05:03:58 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"Stillwell Jr, Paul M" <paul.m.stillwell.jr@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ice: Remove and readd
 netdev during devlink reload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ice: Remove and readd
 netdev during devlink reload
Thread-Index: AQHaT2yJerHIvFJi0Eenh+0wQSKpR7DwQb6w
Date: Mon, 29 Jan 2024 05:03:58 +0000
Message-ID: <CYYPR11MB8429AED3A405D3B4298D3F15BD7E2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240125085459.13096-1-wojciech.drewek@intel.com>
In-Reply-To: <20240125085459.13096-1-wojciech.drewek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ2PR11MB8371:EE_
x-ms-office365-filtering-correlation-id: 1ed774ea-c32c-45cd-b4b1-08dc2087b38f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46bS8mcxgQU3ccvigXnFhitYhQBZyBo/evp/aYPXSxOPrtrPHC2zcVnDfUMbRK3+UeVXffjhjLv2hVw2e28f5QIlvQFOvgHSrq2rXMDsJNMokBZ+H7NgZr8q8wpkwIQpn8QceDNp9ER2sQ48BTcNoIywOQDk6HuD1LihFykFK8L2oDLEyIV7SaAqU/moutlClPygzVFGxu9Oyd0BLiPBdJ2WPZj5ShTsPTp8fQjNd0cbVobuIeLRhUIGAqiQeUtiXiZEpNW9A1+1STe7YRrdc+MGXcMnzUZNIvQyot/8vrxIDdepk2TXi8w8mAkzgYOezirU0sxc7X8wd9l9dqZYU0kbsDuTixIOL688VW13naKGF+8Os+akpRcdSAoCpiGUfcwYP47/JubF+QKIoAhNzsVFh6PiWc9wXgzgVJzJrhqzOvtzfd9vi7bgc9nyiLpy4I5oH3T8c+FJ3mLoXu0A8gC9FIZVjaNAi26LZRYkX1cv1WEuoE1dyuzRxcq+LD1Pw+OQigp+Gv3OhSs4h7kQIy06xJeD0qLIScbgAeKNlM3sH3/fZFY9JM9ycub+JJpJaJJsf/neL0Jowfm9ZzlUUBxoXYtx70XpvXuVt7ET2CFMfh7OTr6FUN/L2+dvu0/i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66446008)(52536014)(8936002)(8676002)(4326008)(33656002)(2906002)(5660300002)(86362001)(110136005)(66556008)(76116006)(66946007)(66476007)(316002)(54906003)(38070700009)(64756008)(38100700002)(122000001)(82960400001)(53546011)(7696005)(6506007)(9686003)(478600001)(83380400001)(71200400001)(26005)(107886003)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6vz4IYrDOxKV5fUN6QcCAEGrHcNj7YGA4jeoiwn7MsOSStfJt/Z5XmSwSSd/?=
 =?us-ascii?Q?0daRFAOSubITUip5fEWgACK1lNiJIqP4d8sVyYhCPXnIxi21MUu3SBffpQZH?=
 =?us-ascii?Q?OAPIeDHoG4ERx55XH+ayD7sQ+Vyl0rDu10m0DWqyWfZPSujt0AQX48xh/HxK?=
 =?us-ascii?Q?VQQE08ic9TLQ1um9GBPZ5Sv7wqQH4qKA0UwImVeO/g5Jk2j97Iy+35jxTJVL?=
 =?us-ascii?Q?XotljlClnbNiNh4G9vSdn9XqCON6yko1v3KbRiwr1Y+GcZ7PQ23Xg8F1+eoa?=
 =?us-ascii?Q?jrKVwShgl+0cij+jrpaEl8vGhjadKUFaGyLIn5B8gDld/7zYt4IWDtu5449s?=
 =?us-ascii?Q?WeoRddUJUiCQU/riRcEqK/6kiQNwQmhaO8gkf4ehXBV/hdnDjkqGDV+BRjyg?=
 =?us-ascii?Q?QXm+9712nELm23LVr7DHnDvsQScEYgaTymWNgvxnBjSIL3nJxoTIgkIqpdLP?=
 =?us-ascii?Q?71nG4g1PVGp2XIaB7TARdmHix3j1QizLWReLACmcJugS53Y7xCsxb41ucr8J?=
 =?us-ascii?Q?T0/TQXgyIF5yj8v3qtDDG0UJpZ4UE8ZkWRDVl9C1NAKm6oqZFI9Hw0l7YDIq?=
 =?us-ascii?Q?4jqGbGMGwyqEIjjeJaBoETfLyL9eovKN4xqtcfywtydOyFH+P4YP3QRNXXk4?=
 =?us-ascii?Q?kwkTeFNW/5sIZvhoJ9OKzu4IUl/mo48jNcHR4A0PKrvFN4SItwwcvUvI/kDb?=
 =?us-ascii?Q?ASMKYpxUxrn7X8SkulOwm/THMYCDrCgcxJ51r1WaKeo7Gh9zJ6Y21vyflpqm?=
 =?us-ascii?Q?7ZXd/UCa2r+Kb5VeKBeeKrSUr8knH7usaT2HxhIHCA5NjA5Y3dbvyn74KF0X?=
 =?us-ascii?Q?W0g+cxeOz7AxoKV0w7XTXhpDcARMqKDaPIWYm69VjcKC5Hnl8+w+W1ENR/vr?=
 =?us-ascii?Q?hJGncSUhDv8omn9lCkS69apR26mv0G04CMuvQQfKdiQjcRLhCOOfqJj7cnRH?=
 =?us-ascii?Q?TAh7ljgmbdNEo+plE0blopNuXcmTN9Z/Jrc3zZkalujUPuTLg7bZDpsvieVn?=
 =?us-ascii?Q?AZy6RTHDhgXuPj5G9H9TBw0gevgfXwmmqWUibqMOADKXS1WMBmtpo8Am1/x/?=
 =?us-ascii?Q?Zgv3q2YvFUBf+rgEwD0MtyI7ECb0irXgxmL8IF1EgegQyFQMEVt9Yo30fJfz?=
 =?us-ascii?Q?NYPUAGShRuXIw1GGEuDcNzt8454Ve+s1E27/X+/hsBkd3gHDVHgbxmcwnUsL?=
 =?us-ascii?Q?mYZ6dMJJAOmoyzC0ffn8QoHxk3zakZPP4RCDWu6nPHcL7J5fyCESBjA1gLh7?=
 =?us-ascii?Q?ip4om0SnJ8TfvefgTSg5P+daTdtpCRkq/eZyzPtzStKc6G4iTyrQRdpCqUm0?=
 =?us-ascii?Q?g5OPog8gTB+UmDxKvkTVK+J5oCKC0645dlulQOvDCDB7vRMHPfEso5zmIqY2?=
 =?us-ascii?Q?5/RRyZld24ZLH8wQY8qJRc30sCh/7q3Gw2kxJGmeB+sQ8M58wVQ7C+5J5HM/?=
 =?us-ascii?Q?xJFcPnYWx831ezskpYWRefQ4rx0Nrrj4rdmzw0Z+Numkqm8fKMjFmjtMHePi?=
 =?us-ascii?Q?VFrTPv6mxmzrEwZuRbJVLLldsLQft7ChKJj0o5v4+FsRpmhgv4D7P7S4elX7?=
 =?us-ascii?Q?fFWoFaW5avP0F4jTyZeeasVqwDMIjlV+QEVErSHah7gtDtiKR7X6iKUQcG/E?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed774ea-c32c-45cd-b4b1-08dc2087b38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:03:58.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnbbuNNglmiZpR7jMmoK4xA+MvfO1nQj//dX9iXFviweeJfGo6EikcZImXeZmmPdHqTKzr+2JyaDAeB3u7YWLLPqF/xhSeHMj76GxAqJinV5AiIX4J2kPTxE+aMqKIkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of W=
ojciech Drewek
> Sent: Thursday, January 25, 2024 2:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; vadim.fedorenko@linux.dev; =
Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: Remove and readd netd=
ev during devlink reload
>
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
>
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
>
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
>
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: empty init removed in ice_devlink_reinit_up
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   3 +
>  drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
>  drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
>  drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
>  5 files changed, 139 insertions(+), 133 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


