Return-Path: <netdev+bounces-65805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9383BCEF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA8D2930C8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41C1B97C;
	Thu, 25 Jan 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcfyJq1l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3E1CD1D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173806; cv=fail; b=HKgoe8G2WP+O2nyBG8VnKbyGx6pf7hf8w0JO5gwWd5Lgfw16Vue3XvzJlAmbabLKIboGzCTU8MLkiONU1TxRexKi7MtG305YVzMh8lLIXBqXmxLvg8/rCUzr1AWVBsjF4P8lWqYGqluiuX5+Kecte/cXkPXQ5YrIAHT0b48F4BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173806; c=relaxed/simple;
	bh=7TpghJH9nEd5ep4xMKkrtEU/DJfZcR3iiD+CuWRnjK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ias6QHZGqvTiYUxhjF0WU2Bho/lH1sAewMwt0lRVlBDFXZZ+ZuXpFGtJ4wJeZWIk/GFa8OxXaHsLaDm15NlBGuK++m/cCvwljASL4J0PByiutHhJHpC+zPAehpMD6j10Z9OBfhRty1bTIuFvk2Yn1bEyQPAzoME7UL3rpYKiXl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcfyJq1l; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706173805; x=1737709805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7TpghJH9nEd5ep4xMKkrtEU/DJfZcR3iiD+CuWRnjK0=;
  b=VcfyJq1lVhDvxUmpRhnSb/loZ68EAaZxEjb3zbKzpfs49sG7rEyEcQAO
   +YArphA+nHnIFT7Cp5qbO3xVzpe81a9zfjNPwWiHk6Hik6qtAht0YPF6O
   01lVP/sbKjpPM6/CZyMoLWjwuXWn3Tg5v0p9UGYA2cNn7h3HzvNwqMESA
   EorsefP3NR9x0ZT/egh/1I2mXw7OcjjwuWyADJvi9Cq8aa1EfTVWjXf7J
   L/2POYDVQSXtcQXDWrCOnMtHncg032wjKq0d1jxwiqBJb4YnOm73iG9XV
   TS1d46UAGKxgSgHg9b37mMgu/c4YEk3v0Bo3PfcA+8RAoWRDR79DNOdw0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8760964"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8760964"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28706370"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 01:10:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:10:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 01:10:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 01:10:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMy9WA3/GBk5yS42GEZiarPutsaZKFt/3+EoL3GHM8/UqLCrOav51HJQTKtSAXzh1rJSEVDzXHxNT9xyuV1X4mKc1Is6x9NHYZnHFKbTBCL2QITSU49nRehtw0uzFuKdCMv6G6dOyYkdK8/zW1zs3zx5+HG+EEFTSujhQXhVUEscpfLjfwxITRctCNXFo2SwWNVurQNdBYKZ/xtYp/XKEgCCz95nhxUZGv7j4YlD6AARVGHfMQv9I46EENRCxOW/5oBTVZcEbvavxcK8dOfAzmNjGf7lZrY8+R+9v/s5Bw5aLGE5ZYCVn6EhFJbtLFtmWO4LlzSIxj57qIdgxUeGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg+niwy/81b+FMvPGB4L7Vnym6vPtWAhUoHevsSistc=;
 b=dFcPqW7Bq3mieMrrqpodoC5jQHvi/Ts/48+RUyfdNvszna3B12/gNeLW+gakU1bBbhWWAtCRDDw/k2pkRNECJKGKzYSdKZdtkCJNMKl8lSoNV7JcOc1WDYQHz9jHic4/Q4PLna+FJQuct1qhIE9Rq1fnZ/bwl9kQOCImTb4a+dD0/RdJEiwht5DH/Wu2I0EajeN2qnEnK52YAe52RgSs1GYyhJcsLpdSI3ippC3ciGdO6/Ul/G2ysF9abPhf6Gus0XlCwiM/foI5AO1raGwO/x2ADpUQKBqGSkoUBOkAKuNZbgVnR37Rc5ZvAzHazvqGsPooQvZF9cH8O6/nOKfDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:10:01 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 09:10:01 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v7 iwl-next 4/7] ice: don't check
 has_ready_bitmap in E810 functions
Thread-Topic: [Intel-wired-lan] [PATCH v7 iwl-next 4/7] ice: don't check
 has_ready_bitmap in E810 functions
Thread-Index: AQHaTepIuzhEa2yCeU60THm5kUnoe7DqQGDQ
Date: Thu, 25 Jan 2024 09:10:01 +0000
Message-ID: <CYYPR11MB8429F043CC0633B0C4A5CC96BD7A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-5-karol.kolacinski@intel.com>
In-Reply-To: <20240123105131.2842935-5-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DS0PR11MB7878:EE_
x-ms-office365-filtering-correlation-id: 676e340d-7431-400a-9ba3-08dc1d85691e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whGXzGBFVBV/z7ZG+/t9SOGqZekpzBpDFVSJv1iuSxELAE/xgexvbbS7Fz0u2lfnFjJuWdK/Bj8FaoQGAiNqVUNPwI4zbS4n/hYF5F1+OgcnqM4GQbzrYC/S23Lyg5XorMpCKAQWPCOoAg5bX2K8Lg1hXbnIfSLiy+gQ5cxhfdjSc6bOeYPXvUu4TCKNdb/rcnm0V9DlS7PK8CPl1FDba+QMnsbw53M1IceaFI3q+vk8YanXwBDdYdHYftVy+swDze0BJxhzAPaqhMvvK7ukHS+ZIKTElMJGHbk9c8AxzyHZYUe0G55La0jEeN5HKzCA8iaPzRDm7LkurzZASBzsYXqqmWd9hqtLsyOlPldaPtLs8ZKjm3ZbOgT2VARye9+e3me6/HJJ4nmwGUIVc0jcPipu6/KZYgB//M7qge9dgK1sftN0rmm2c7RyJk2Lk3g13MqbU5Yi1OQB+d3Ah5qR7Btl5nMbwVmdthCFvGlmxdb0tYYZt37ifi0w80aXedmDWrj5nyWSNSdGl8q00wdO+AszlJyLbjeahK/dyjUKVNsCKRipcaPN3EKU9R+3B8irEIaA44jSCKinqM8illTHdq2WL5Lq5pjMZ9xQvpSQ8QfuWAskZ2t19kdARmLy/lOB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(66476007)(110136005)(316002)(66556008)(66946007)(64756008)(55236004)(53546011)(26005)(122000001)(54906003)(66446008)(9686003)(107886003)(478600001)(55016003)(38100700002)(6506007)(7696005)(71200400001)(8936002)(76116006)(8676002)(4326008)(52536014)(5660300002)(83380400001)(41300700001)(86362001)(2906002)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ISQclCfPbqyic65UJplMYWGUu7tgm8tBTGMvVEWiv1i3by9Gg2zieDsf1abL?=
 =?us-ascii?Q?DHUObiQY4w6VfV/t83/MRaBXRUX3d7hTYoSwW76s644bdmhWT2dJUJQpMGlZ?=
 =?us-ascii?Q?tfboe51N0GlwRZdxhx/o8CGcLue9xaE0zR8HoI7V8/8MCxpuPZ2KY36p2os+?=
 =?us-ascii?Q?mckWP+fzurAZAIF6BORb4jb9ruT8H5JQQmHpd87TIkHHB4FCCaBz3j7AH2Zp?=
 =?us-ascii?Q?XoeiLX7YT2yxRNPSVkfdrpE6v8UFkaBWBdoJaQa4Opbc0kb8htn2VQmvJRe/?=
 =?us-ascii?Q?+c2dXCLFVzBd6cSbu6IHOY3nCCU9KwUmEbnX728EGTWOY2/qWkL9bEumpUwn?=
 =?us-ascii?Q?qp3uh9T2++KYCnMxDN8amRRSFmcB6VEAuVnR39O9lsQuQjkOkHgbZPi9cDK2?=
 =?us-ascii?Q?ZdUE7y9BNcXGps+nfHqUtgfclJsIJG8sHBe6H/57JpKBtS9NoQW26kKHWBJg?=
 =?us-ascii?Q?jV7z9pbRT1jnPaLdzwf5KlBL93RKx1fyFdpXDJAniFpuTFgX81dZo47Z6aIH?=
 =?us-ascii?Q?KIdC4ancXpapyp+vZYIBu2AEIni9I49gsUQduXc2AKK4zqVxfRnJpLBZYuFL?=
 =?us-ascii?Q?CDtL3ZYd51+J4PoZGcucwVtM4v4uvbPR4OaE6fXeSOLh1/lpKwpRAl//5qsE?=
 =?us-ascii?Q?kfYFr6di3o7h1vPWzKBgR2OSfITzj6DahJPR0+lOfONIa/TvYlmrugvVYJp1?=
 =?us-ascii?Q?/ULQFlrEBxfiZ/+Jp+5Y2bmnis2A0Pufunlu/lz1hL6BIP7L2wUeBebK6CkA?=
 =?us-ascii?Q?sxD0b+3WfeZuNjapZB4gyYNJRsnku0J3icJp3GSYpb/eByTKAVqLvsVUtPh3?=
 =?us-ascii?Q?9j9aKGixezyKwVrHefem/Es2X0MxmGU0XvcsFXFjGOa7dx3hrnH/1OYnpvg0?=
 =?us-ascii?Q?UWDUFx/eiY2u2H2zWzwsg9xMCf7IvQ6yuQQV4jzCzP5Wt4A7Y/c69btEioKB?=
 =?us-ascii?Q?Y+F5VCK4KOfeNrYqKqzcTOxKhxByQ8OrksuVqilSIENWc7s0pSfX+gRFRyX6?=
 =?us-ascii?Q?BaCDkiLCM5LXmLCRiUvAE4VGQheYgXeBS4/ADQoPEcqjNF1NMpiKiyeSPlY+?=
 =?us-ascii?Q?lDomfxJDWTfxH8pWTrj/NdCficjvdtsvxpYr6GJSF114ecGZY9Sg1oV5PkAR?=
 =?us-ascii?Q?RrvQLGJ2fTtrreIsfidY1IFHe7UxGPVwVy6+FEInGtFseV2uG4pQYsPmhxmz?=
 =?us-ascii?Q?95KBpT0w2eCF9itOITyG5SNmVZ6I6bUpc4wWHRwMeYc1UaSOdZOzNz0/yFAy?=
 =?us-ascii?Q?T2Wzqym9dkeSzo0DulDSyUgpci+MrTdCyKFj7liGFho9JPQ+4VrDB9+tpbTX?=
 =?us-ascii?Q?2JO3LHd4Yrtp5Fa1oY2lvXz3cEDKqpISaPz5GmYJUj30tXSjzxiubxp2eyM9?=
 =?us-ascii?Q?c1e3GuFkBhxgxPaA/aamzJ7Ac74CE1jGCNyKtGDhTWOj6HPg/oWDlgpQhlzB?=
 =?us-ascii?Q?GjUZ10R7jDdC1cW6Apgx3sgZpjcUFfObIqiJgcJVzXPlLwHyz5KoCeCZgWyH?=
 =?us-ascii?Q?Q5gbIDSquMTSftsCt3/a+t4qz8t3ooGgohcAB5qzfO2QtqBDCcht8JAMSo3L?=
 =?us-ascii?Q?WbvR/iSG6pXSM/H6IAslEbqV26CYsKgfS8M5NY0LevPo+45lCqVw323yygt8?=
 =?us-ascii?Q?fQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 676e340d-7431-400a-9ba3-08dc1d85691e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 09:10:01.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbPJkkk1Zr25NfaN8cKSE1RppIIu91FinPeKTOv/m0MpcWGJW9hVy/QfpsMyvgwpggVUalDPZoOa+/QPW+N34e1FlpnVQEKXn/8Oe8+06pKHiM9sk7UF2zvf8RISQF49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, January 23, 2024 4:21 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 iwl-next 4/7] ice: don't check has_r=
eady_bitmap in E810 functions
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> E810 hardware does not have a Tx timestamp ready bitmap. Don't check
> has_ready_bitmap in E810-specific functions.
> Add has_ready_bitmap check in ice_ptp_process_tx_tstamp() to stop
> relying on the fact that ice_get_phy_tx_tstamp_ready() returns all 1s.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> V5 -> V6: introduced this patch which was a part of a previous one
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


