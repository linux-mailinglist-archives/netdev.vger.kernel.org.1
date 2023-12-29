Return-Path: <netdev+bounces-60600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC478201F6
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3B61C2107D
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BACF14A85;
	Fri, 29 Dec 2023 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx87DkGg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327E14A84
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703886367; x=1735422367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uiLNLDVchMEL9dLmieHOLqP8DQHJFgZrL7ZO6f+74kE=;
  b=kx87DkGgPc2ByaCEuPKXIb9IapIEadp0adw9CpMNgzJ3LgAanavcdWF1
   WwMWO54gDbMaOrR+kwxTl13KpzYdV7W9riMRydGrw9fN0pAOiXLbI72yu
   hPpz6Ndy0iWCnWLgLI5yOUPz7oDBL3PVc6UZqfeNKCC11oT8maJXtvpVw
   hTtDdV90JmY8oUiqbWVGpFhRDOrwVXFlS/6p1+VPbUpXKNDMsU3Dt3kRZ
   mby+n7cwbpf5ajphUOnzQnz/1X14fc3pdWy3jQ9Ey1O1cKwpTs5iAru2d
   w2482FNlkWS7NwLq1+ukV5WELa+kQ4SNYKlvLXwSDM+9/uEh2Vi0b+WXM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3513358"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="3513358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 13:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="849315313"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="849315313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 13:46:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 13:46:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 13:46:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 13:46:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 13:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNHL6PTWZdgg9Z13N4CIB+0EyxCNeIQkVx+M2WDsPLtevFQuldxFVwLctkYOH7/GG+kLsTcxVA4eAaFVENiU4GJNjSk9h5BEq60LvojSlcdYJ8EMhPGFUtq4vPW2l0JRcBkEscbct2oMd5OZeb2IYsB4o9tZruhXZyMsbPWUXM/T/DRG4j4z3hRRhp2WzsEXZf/ubrSpYvnECsxBtAgt7ohX2g+T2/Ap7Ok2ySCG2qAiEzCJJpobJ0umWKCzF/bede+/kqyssJG+HB02WB0JezwL6CeGt3cJeWdvYUfwgOjIS2dndCBxOmUaZOKD6EEf6UsfuNUTK7MGAYSLtgOMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJEJVlNWrEnOd/qfDCiKok0l9ZfrjXAQInW4ox85SEw=;
 b=SvNUk2C4wDUTrUMkUVPEMc0O/J6hMTflq0gxB9/y5xP4gZi2/nbe9plTc+32Lgb9c3ZDJho7O8E9JE1VzRsNna/pTnwMHAYeR78Y2xdQqc0qChlWHs/e/Ed5KAW62N4MF750WLwatRizT2j9iD4rIlhcJOteHO50Q7WR4EWMGTx0XFp6pw+aBjjcyOvTvITj9XH34dXl7IgXCG+f4V76bCzzqRoNneXvN4VWDO7q1tPFINqjISQKNjss5/TT8t9K+BG9JGGLz4hCXAUNJUAdLvfnGtyIM4ra7zN6ERbQs+dkEnzNOyA7xxHOpGBJVxbZHAlEyG1LbSHrP/SbnvSTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 21:46:03 +0000
Received: from CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::bcf6:6bb9:953e:6a2e]) by CO1PR11MB5028.namprd11.prod.outlook.com
 ([fe80::bcf6:6bb9:953e:6a2e%6]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 21:46:03 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ixgbe: Refactor
 overtemp event handling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ixgbe: Refactor
 overtemp event handling
Thread-Index: AQHaMZ/gboocVaAsPEqEwl7UVr4jibDA2kxQ
Date: Fri, 29 Dec 2023 21:46:03 +0000
Message-ID: <CO1PR11MB50289F08FA6AE9A9E9B5E799A09DA@CO1PR11MB5028.namprd11.prod.outlook.com>
References: <20231218103926.346294-1-jedrzej.jagielski@intel.com>
 <20231218103926.346294-2-jedrzej.jagielski@intel.com>
In-Reply-To: <20231218103926.346294-2-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5028:EE_|DS0PR11MB7215:EE_
x-ms-office365-filtering-correlation-id: d9744b4b-15cc-457c-a1ba-08dc08b78dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/Q4yhDuqGD76GB/aB6J54F7xg1cSYuFJGq1YuqKcz3Q/dHGm6x+5bdhunl+eE9/zuWJowaeMaPRy0u04om9MdyRDbngoIPTqFROqKwtUEEUVV4LtVotLXbjR5C3CaG2jcBg5fo6DjbjgyHFLAaWM+80jVs6O8x6AjD2LIhrmOn2716bn0GTCE2WTQhQfZpseqgFZW+CONlt4No72eLOGGTvceGVLIaRdHAFHWNqFWNQDB8iwJAT/EOwprw56kvbldVhht2PLU4b5uk5niYnsFE9PrbkB11WXHVtffmFl67RiZTyPTBfSmEoKPbnOFOGEW8TfozD4A2p3vWNgtQkDUrwYgxoVdIXHoF7XloMI2px3WdebGKFxw6w/XX6VvwvNl5M0TyXzFYaJl0XZDF6oMR+4K1ttdWYzN4Pg4hNZpI9f7eMB3e6bKZFU4NE1F+Gk+HajuCslO6Nj3NEOQo8f8v2vFizSbrAnjg3kfnvyk7RR5S8S8cPQLsj4xMCdhzJ3THfYfD/ysuFHuUcught4J0Bc01DHOxAkOR90aW2IL3EFN1Z0UIgESWvwwuWQm8Of7H8b4N7Aht9Ju6x/sR0Rs79XlLXaLpg6f79WyBxJ4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5028.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(7696005)(9686003)(64756008)(54906003)(66446008)(66476007)(66556008)(6506007)(71200400001)(76116006)(110136005)(316002)(66946007)(966005)(478600001)(8676002)(4326008)(8936002)(5660300002)(38070700009)(52536014)(107886003)(122000001)(55016003)(86362001)(38100700002)(83380400001)(26005)(2906002)(82960400001)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H0CiRW3CgPcm2IaBgWBTAxjnRlN3nRO5WUHl277c0kFr9MmnYxbj4IPjinfs?=
 =?us-ascii?Q?MtMuLMnSeAWlQnHy1RRPmmWKRQkCdvp0g99WBUqgrflRjZqUzYRvfl2CInGi?=
 =?us-ascii?Q?a52/UgXLvS/u54NV6a0a6rWKCu5374AmesM1DBAKa/akOUhOZ5pG5qgyGb1/?=
 =?us-ascii?Q?gLk+2HkDHHich6SIvUn7Vy9GjQItT6Jtp2z/cXn+eo6xpt1/6/ZLrIfaHXR8?=
 =?us-ascii?Q?x7mj5bPPZTl2SCqLFHBG41XaVDacmLElej8Z2nIgJEq0v7axgpTWEWZ7FMHa?=
 =?us-ascii?Q?/nbZef7f/ZSPZURKmLgnTegXJJSpsc9tmamAjCttcca9oLcY/TLCRZynTQNF?=
 =?us-ascii?Q?1kqhSP41IZjegbXi45B1cum6/DrD7d6Ybiao9dFYJ39EXltosBwmwDV3GKGe?=
 =?us-ascii?Q?1sBrzu10GZ/8Abu9NO44u1SY/eB53kHrpcXRZdlmf7oJ/nR7i2l0vojwBZ4o?=
 =?us-ascii?Q?Uwd98DHDabRtC9i9LcgxizMziR2ieNMl1iDQqDTKgd8stUqI01T9ijD+e3aA?=
 =?us-ascii?Q?6PlE9pfrKyo0VZ6DwEf/jidU7valpRJ+2HDamn8vImDlckysvDx/+jh0QbjS?=
 =?us-ascii?Q?mFpDFjHEXbMG+WP5v5ZpOMu0v7Uj/K4wsQyjajVY3J0p5+HsPArlWNPLm1Tx?=
 =?us-ascii?Q?Vd0LxaIzUDOQHEPXzxvVwGJSSBMf7ZOKInFq39VTnDq1r9wfa8y8EWdBv2uX?=
 =?us-ascii?Q?Qo51Dv6zws4/wNMMdx72y12QUjzYrx+dVlTe+5HTqwn9Wv0O439Q2JIWwgCs?=
 =?us-ascii?Q?RBY7lQ6kp2Q8owI/h8xFdBGYHYePMAExljtMhpJXOk/ItyY+R9MdGVd9Z6y6?=
 =?us-ascii?Q?5xpVZDzLQL9BDljsqlk6Igd9KTEwtsiZVwazmRiSBDiyUSt1cuXCBw867Tcg?=
 =?us-ascii?Q?ziVEXFpNX9x3ec8Xp5knezRP7nlM5iE+94i10oyjSLB9eJw9gNJ3EkZE2OMc?=
 =?us-ascii?Q?ulU+oS7ZHfAULStzsAf+c0u/m+81WjqpijHwkOIAOwylpWqRidrAE9+DusTp?=
 =?us-ascii?Q?D+hIDeMU0XS6VxbyeuoDos05kvtRQ1uJHaBKXKAAyDpc2sjHsnPpJVZxU0Py?=
 =?us-ascii?Q?Wm+4dd1kQuWcU4GQoNHhGUMgwnkmKa4IkIkmSV0Hsk2XkzFuV668h+wtOGUh?=
 =?us-ascii?Q?4/EAYLzBo7C0rNu8Uod0tZwme+Ma/zgzvimNX/Q56nEI37Jkeq4gsJDZ/dWV?=
 =?us-ascii?Q?lDX6GWoRg+CjLGYLPIMVCgL8bZIGWf6BkDKXD+ZTehbAnNAIa4gWmSKOKUgc?=
 =?us-ascii?Q?7TJQi2yWggTT2x5hbXy1pSbr4m4TnjfLASKyJ8U5n92vVBRd1WtAwXcHnqRe?=
 =?us-ascii?Q?pGukcbl6N/QRZ01gp30+zsrkige6EQ1KcWbWpaOQOPdbfyT9gg8lbFULG/pN?=
 =?us-ascii?Q?L6n8QGPmFtMQGby2MpdkdMZVcvuoKXsJ+3CGAzvUAGdOXDCRbIMZ+H9F1Sw6?=
 =?us-ascii?Q?liJI6TVpNmWDRFxxbC7lKYbBv1Ns//pAlE46QSCvCaJVjqeQWYvlyIQggG36?=
 =?us-ascii?Q?1hbxciZhUxXSXklbRSd+ZCJ8LPqyzpIHHpwmTsnlF0Mu9AvjbgjZYTFbBlLJ?=
 =?us-ascii?Q?G9LyLPfnIsn6mXLQgIprA51NIw9xuztkVZv+cqWZ/No1v87V2ViqDWiuayzh?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5028.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9744b4b-15cc-457c-a1ba-08dc08b78dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 21:46:03.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3z3+VC5hmjjO8H4qrro8blbbtdTzTvO/KC+RAt1LSyZ3Qq+uHzocUwj6BpfjU8tyt/pCngTI2GP8Ir2AxLlC/xYKHORRFEyV0RQcZR5Yu9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com

> Currently ixgbe driver is notified of overheating events
> via internal IXGBE_ERR_OVERTEMP error code.
>
> Change the approach for handle_lasi() to use freshly introduced
> is_overtemp function parameter which set when such event occurs.
> Change check_overtemp() to bool and return true if overtemp
> event occurs.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: change aproach to use additional function parameter to notify when ov=
erheat
> v4: change check_overtemp to bool
> v5: adress Simon's comments
>
> https://lore.kernel.org/netdev/20231217093800.GX6288@kernel.org/
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 21 +++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 41 +++++++++++--------
>  5 files changed, 43 insertions(+), 41 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

