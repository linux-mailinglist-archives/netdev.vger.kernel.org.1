Return-Path: <netdev+bounces-72374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98247857C5F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A7EB210BE
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E74378683;
	Fri, 16 Feb 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH2LVhqv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BB77F2C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085629; cv=fail; b=XOaPBHkYTLyl5EbfR2IOjanaWtTmbmyfQxF4FrOFxdP3QRY8J2b6FW+xEL9gOVfE5M3pLvIeYpaTPZYUG2nHu23gzZIrQWR9cDjWpsPziAGrrdavDzxBSITmP9Jsbaja8n12Drqh4H1S2uMuFY7t2QLhPNk0RjN1llUnFcBLvWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085629; c=relaxed/simple;
	bh=x6Zi//yqI/qK5Y82pKa/P9W+7q3JY8+oFnVICnKgmPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eB/BlXb1yLbn53vxUA3VtlRMO9rByV8atWOPSG+BLArpx6WnLsg90uc24kLLBgQUriOoejYVFnKC+zvQLgWC4bdnVHwgzXKnb9/WGSStxmR9b801gLApJvuFVnjuVY2zwtroummKmST6LwILIK8l2oFSDEF5Lb1lRbVvTV3vZvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH2LVhqv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708085628; x=1739621628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6Zi//yqI/qK5Y82pKa/P9W+7q3JY8+oFnVICnKgmPk=;
  b=JH2LVhqv83JSsFueZ80+hTHTrL2OGD8ae6WtgLVqSFSZSinWwuWaHjXx
   SUkNaPsODx/qIfczccB0zli7Iw1euwW94IUhMPmTT9rWazv0xvNHokB4u
   gJAD5Os2JYSPOb4OvlNgSyPtM0S7MkZlY6KoeUF7LjGpeonXgD6r3JcO/
   kgjZZ5t5jC67P4ZbXjyObGYS/YVYfImdVepQWgLwcyHDbkiWvAho1aDZo
   SR2peVI+evK7zm9LZb+c9XaQfPOt15x3NPX58iHVuOnsKoi0eHkuzMCR5
   MWfbboWD4LRoZLVQ4ozA8Ga9QpPUi0r20RlrHhuqR9oFjUnnlKWRBqHRV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12924712"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="12924712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="34606916"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 04:13:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 04:13:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 04:13:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 04:13:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 04:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOkkUhFVg6crjCB5W/4XBGlUY1PvST9+LIRz7jMTSbff6wzeDmjO5rTfzaa1nCADHDLSUg7NZOTEmVzzRSLSycz1uRgp7lwppa90YIEh29oNH2CJCanIsu+mPbGyziIRGWgW0poor+0pxgpC3x6dMcK371pKf8DlN4Vo0wvzNREVdsNbbibcZcn65wacRCnoJDzqR1h5INGC/EOnVpN05VQQKDt94m6XKASHJDQYtGGwQm55y0+1X3HHmzrrgXOj4MOj/pAgrx+xM1pMmPSMr5nJ3sh5wMpDXOJB051yFLGVAtYDz9b0T27xMlpjtIIxwqx9ED2d3aJCWmJX6ZxBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDidzVW2Rzee6HuCwzWg0/QpFA+IX2qsLWFiP9qkhyg=;
 b=fBw/8pJ2xEXI6dHFbaoG6jh3FgnSKFfzB0F0nK2HPThP2Dbb8I8UAPckB2wC61eahzNbEFK9CYMgwBxxC5ly+a/CpF6amKMB1c/vfWL/GZJOniDafkIqamlIMDx5NmLNOnqQjfKhyCufp1Q2Un5rj96phas3eB6RTdvTS/88zxdWWn8Al+QGwO8ROfl14njvftrP/uO1Qbm7ZZ/1TKfJ5h9vKjdATDvVZYL/YsvsOSIAKrQmps/CAoUPl8iyOvS+8SAGI7+TLNvRGjQ+k42pAbWtdD1i/J8pLZrxElwO7kVZg1V2DAHZRnTettOw50v5mb6b5QCQO0GX6sEoxgbiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 12:13:35 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::c04d:e74b:bf92:d1bc]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::c04d:e74b:bf92:d1bc%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 12:13:35 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-next v2 1/8] ice: remove eswitch changing
 queues algorithm
Thread-Topic: [Intel-wired-lan] [iwl-next v2 1/8] ice: remove eswitch changing
 queues algorithm
Thread-Index: AQHaVefq8SlvyLdSTU6hkGx6bdk6RLEM9oxw
Date: Fri, 16 Feb 2024 12:13:35 +0000
Message-ID: <PH0PR11MB5013FE0E638F52C059BC9A5F964C2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240202145929.12444-1-michal.swiatkowski@linux.intel.com>
 <20240202145929.12444-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240202145929.12444-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH0PR11MB7470:EE_
x-ms-office365-filtering-correlation-id: 95828759-8c80-453d-73ca-08dc2ee8b322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOTGOq38W4fNoIE2GKCLRGKdtFbt9y0vdvfNdCixqGCDL4MQrfZ8PmSVKH0V6Oc9HczCaePlHBoM1xGTIh6JQLO9eUaYJgWpfKNLlaie22SFZ8ZnEibGXsRNkrU41rTLn0aloHWV1xCKvwqlXdrTVpDt1LKqHfjJSt3zZ24q8dlloYsd0IDVxOAOX1YesJVeuJnQuFbbblsXlr9370gA8nHSnc890C/VPI/Ox77EYGfh9fpZ/GwF1ziPnP8B4SYhGb0/3W7fjy6n5U+hs3TgoswQ6rxYAU2jGYKQmoe8RIeAjEYxAqp9JuAER8K0tChDf0bst7Fv0nH8PZEAqlcA+SF68X+RMi8qilHPo/2zBEsBFqbCdo0ZBuDEluPr/wsA4fX7THxeIjhhMp0Fo4ccf+7dKGFbP1ACa2tSN5dNqsvPPyMnC7ZvCTHog4dUVEFk7bqwL/DD06kqW99RlYI4mw3aebWM0aI53FSpmDPHHwETg4j0+zgeRMh3J/mPYPU7iF6GQzeAR9dgC4bZihmpSC63kXWVrDsfa8N/W9/WE7duMi5itaPy1L48Wteim2+c1iWQ5MAU2queCjgor/YvWnFebv4kEYI6qHKLBkLl7n5hEKes/ZP/zW9p1fyV/lDh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(7696005)(6506007)(9686003)(478600001)(41300700001)(5660300002)(55016003)(2906002)(4326008)(66476007)(8676002)(66946007)(52536014)(76116006)(66446008)(64756008)(66556008)(8936002)(110136005)(316002)(54906003)(26005)(83380400001)(33656002)(38070700009)(82960400001)(71200400001)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5HLlL5JJ2KtGj/GUel0pI+zTj6XkRhLebw3MnDZICF1zHhQEXGDVrFudyGsu?=
 =?us-ascii?Q?tgUI+JEYOhJqzSNGuKxxYf4kOfzlYvyHgnn1Sx3Ffs56kcw0/yR/YAOISX+9?=
 =?us-ascii?Q?osAlO3eNHKWEw93NuGPaZabBiOEUvFG2mhcP6QNYuNo4oD92HI6OLIQhU4aP?=
 =?us-ascii?Q?H8tU0NHXTNgJBAXP3WaHsB6A5/1aV6eMO7uLL8bOw/VIKcy8K0T92NcrPzyK?=
 =?us-ascii?Q?gslqh+rBhJEEsuSiUeW3fvAY/ypL/ImIVDn/Nh8QkP/KSYhviU1HA3BaBYmo?=
 =?us-ascii?Q?zJKRFVZxIt58WDt4MQQA/lToWbejeedd/M1MfdUN/tGbOznU75SGaAnKwqgl?=
 =?us-ascii?Q?AH9ahlLXkzvKwKk9D78oO2OOaPL3vGeXj7kyPGoxl0r87JzoPUePk0Bvj1sT?=
 =?us-ascii?Q?bH8Dey9N0EL480qmDxytdOemGhXQXPSBdqm0J6V2VUNQGCQeq55DCAOwxrRm?=
 =?us-ascii?Q?3VEmRuWZLUf49hPVUOuGBhcfXbFVl114c0zggDoYGyC7y8DCmw+JFwXiUxQk?=
 =?us-ascii?Q?eAgPU3bDY+0mdaW7jNjU2BI8agWC2pjd3fi8x5qRr/D54pFZaO08f8y21XpL?=
 =?us-ascii?Q?gOVde3VvVWcY6lePEPD4BT5WBXLcN2MYecoOw5B06TOcDNYN6Dkv89CQp+kq?=
 =?us-ascii?Q?lRcHi++MoEPJT5zLtZsDf57cIki101Sl7L5YnC77d+litAx0+8F3axOFD6iK?=
 =?us-ascii?Q?ru93pHJKMQhAfjOJyXXEC9X9dtvtrjW1YuWoMLNTOUZxnvY1ywMZ8iXeAqve?=
 =?us-ascii?Q?X5erh0DcODiOfBk9VzxmkoALeE576SnzpRRPgu9ka/ZHEaDnlzPSzKtnnW2k?=
 =?us-ascii?Q?axWmtkzXSsNzTmwTeD7rMSAU55hNmY5Ima0ktdHXuP0kS1Ex+Mdgf+exatm1?=
 =?us-ascii?Q?srUVxv/CMcIgnluqhwsDg9y98G2VvJ05cUht5nlmAepHFHuNxVYolKuqpgOd?=
 =?us-ascii?Q?DCxWp24njiIj/ds6FDHTQdFKSAg2AS4JyLClrtLj7fPxryu86Nc8gVeT7WKZ?=
 =?us-ascii?Q?eOsoJQ6+fxKsgYLjJ79sgIJNvLvsyjREALwrSQnokzPwGAqv11XmfqZhompL?=
 =?us-ascii?Q?l5/VU3xfIPbG62SvYDFI8KvD7GNwW86Aqo9+OG/55I7KMStW6k5O/fcVIS3Z?=
 =?us-ascii?Q?lxo/B+S81+d5U+8EmaJ/Qn5AtT3iDx8hTriIWFJVxL1Z/PP4VvnL+gKAz88R?=
 =?us-ascii?Q?iwwsEeOQq/xORmmLtIX9nTOSoi+dpXkc91LN+6zcFK1zq/oerTBWENiQFXex?=
 =?us-ascii?Q?EdcDNbDXmNUuCj+hRfT0AO+BVNunuOYJ747SVQEO4WtW18ZXGKAQl96oDAbh?=
 =?us-ascii?Q?Lr+mvotLBkMIEwLpr0UfPDKQ9LhUNczPQvjOquendujDJJoHE0s/hEgP2bAI?=
 =?us-ascii?Q?FvjEiJoiWd8Axs+uwT/k5w3+bF9QXNeD90TJlNzDevKoMwjkeu+pVEPi3ooQ?=
 =?us-ascii?Q?U0SVsPYFH1zIA1Gwb53CxmY1Tx4vMawAoP/2eePGetfyIC3XZyPE9i7B6ua7?=
 =?us-ascii?Q?8ySHuhQPdk15FT6Y1to7rVXsEg7Zmx9XXu6rrYjkgRhXVo4SmSPgU0zb6XFm?=
 =?us-ascii?Q?4wzwC4pjcjYNa0Qh8SiIEKZAK56V5nxjX04ti8pvT7yEHRJZPo+CRpu9Trzw?=
 =?us-ascii?Q?Iw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95828759-8c80-453d-73ca-08dc2ee8b322
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 12:13:35.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1U1pEJvyLevABmhNLz2mjDn8EJLND4HsMKYNBRlIfUanP8ZGDhoFxbkTeRQAVmWYYE+K+OVl8R6ouGoYxUI93dtJvBtApKeaEEg8w22AE3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Friday, February 2, 2024 8:29 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Szycik, Marcin
> <marcin.szycik@intel.com>; Marcin Szycik <marcin.szycik@linux.intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; horms@kernel.org;
> netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-next v2 1/8] ice: remove eswitch changing
> queues algorithm
>=20
> Changing queues used by eswitch will be done through PF netdev.
> There is no need to reserve queues if the number of used queues is known.
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  6 ----
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 34 --------------------
> drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c   |  3 --
>  4 files changed, 47 deletions(-)
>=20

Hi Michal,

We are observing VF-VF ping issue with these new upstream patch series - "i=
ce: use less resources in switchdev".
Ping between VFs is not working when bond is used. VF to peer client is wor=
king with bonding.

However without bond, both VF-VF and VF to client is working properly.

Thanks,
Sujai B=20

