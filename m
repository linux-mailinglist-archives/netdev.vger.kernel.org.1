Return-Path: <netdev+bounces-21998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1D765A19
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081B41C211E5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395027147;
	Thu, 27 Jul 2023 17:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7402712E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:22:06 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA42D75
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690478514; x=1722014514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aFNwpUxu/E0+qPCkDr74idJvuEXdo1ly4a61SAWoSuw=;
  b=i7JTC+75n4kEhoyJAxC8d8RQ/gx/c/VFY0s9iqR7o5bfDG+1AKe7j7Yx
   2Ci9RJWeqoTwqg1iZRiVO+cPZHBAnnLi3V5YaoSsNwVWngI3SZgd99rf0
   6Rcz2y7G8M/pk/ZwamsrqVFhPA4CAcPiTCczlVZtRGNfSOKNftgnNimCc
   WLT+8wi8yc2O5UKiFF7IH2415UnuVA1Sejs/UxTdzWTNtGylfQjWiNa3P
   +VYTHPkPU4aFGQqHI1ruKAxhj6X259EWfuXwicVkaMdCPdWbhVNrQ+AyM
   ++Ev/XQ6V7Y2zH3J28dFfXYi7uNTY+iLQwzu2h/Ovv39db04213FCJplz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368397356"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="368397356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 10:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817185509"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817185509"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 10:21:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 10:21:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 10:21:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 10:21:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 10:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0W/GBTkq15oG6AUlHQ+JYIRvncFqSBJlAcVXh+hlW5tZR7nfG7l5QaoQIPb3rF3gUKoFINQJ/zG4oMx0IqwlJ8TUEFpmOJBwqVEZpHsuJrd5Q76wsuRSpqvfVb1SZ53XQrUCLJPDdC/AkVT3mIULQFrbEzKtmngNljT22FRJY8/uSN6bdnO3m0rHxfqHDcjWGAdlZOwebGvoOxLJLaby3EIWb/AGwKaMVSxDEaNjFC4B8Xt4obWJ1qBehMpE26hN0TZLP/a8nct8pbNpvDXXHjMc7r2E+su6tG8ala34Y0PaZDF/D/x8fbMP+BkmrwCpCxCGHiUncAv/sXLhsYWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGxKF1G1vaDaFAv5I6CvscjI1NrUSyj6w24tVpe0jPs=;
 b=DGWTJq5eLGL9z+WskqWLWdmbOgmG3/uoG57brOeSZERYptlKSyYvhdXiyVkFmVNHoCCmd/J/8vQz7NcX5SmIsaZY+CgPp2VIn9/Mbxdiy40tDcze/js8iC/B/H9mPDULtiNQTBib4x3dGFX1UzD24JwLOGiQUBl9IItZyd1Aa8hV3HxEvINEQbYIZ3zpcwtiMgA5XqKuR+wKKqHm4s3/rrRsPP56+x/alPhB7ztA9MgKiS5XVuONyQM5EBMQ1M6+TrGe0TDGjjlQ4WRzpxXKi8ceGknoSGXY7Po0zSdvkZ1xncEKM+xVgIumuhu3Hf6mxagXy3+lQSEAvKhLMTOgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:21:50 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::db55:d183:4a1:7938]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::db55:d183:4a1:7938%4]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 17:21:49 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Simon Horman <simon.horman@corigine.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net-next 06/10] ice: Flesh out implementation of support
 for SRIOV on bonded interface
Thread-Topic: [PATCH net-next 06/10] ice: Flesh out implementation of support
 for SRIOV on bonded interface
Thread-Index: AQHZv+7z39ohb5YYLESRbbHyr33d3K/NhLKAgABYXyA=
Date: Thu, 27 Jul 2023 17:21:49 +0000
Message-ID: <MW5PR11MB58113A29853DFFF8AFEC3F5ADD01A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
 <20230726182141.3797928-7-anthony.l.nguyen@intel.com>
 <ZMJc8VeEogsI8aRF@corigine.com>
In-Reply-To: <ZMJc8VeEogsI8aRF@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|MN0PR11MB6033:EE_
x-ms-office365-filtering-correlation-id: b5fdfce6-2a9b-4204-daed-08db8ec5f688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTO3tHEeUVZrY2NaiN1PXHBPSjHdmImX+cD6HWQPZ+Bc5hXA4cA77xmkqkaxKRIrg71ao5yTWYlKm6o80wBAMQNofSZ1mJUiSuJyS3SApzkf4td26tjKH04hEU2ClV/70+6pp/shExVCImNgSj7hzfOQEoSMJ8krHUwvtE8RtsLty82Hb1j+zThF3zhRvTlqbuyqdlrmSsGZWcmXFkUbG2DVR06dIfyXDVpkULWmGXbAjcFHU60Okw6+s0SqTvgcC94j1vUw/0dgPmp9iPulEjTw/TgHhUVO+b4SBn+el3MMFQbR6il3rW14b044qnLQo37QDE7s1tCZUgYirPIStUwNZll9PbxsdR60BDVqDgBAjehvbi3M4ieSBfujNhHVZSH94oAw3onWTA5O720LegfxCDHgjT0Bx8znLJXfe9eNoi9NPakTGN2wSkN7BzTbOa/8sJgrqUtmATmctENTIXyH+tWlOKeI/czxCUsq6HcZ3l/U1qV8p3/avgYwHLFsA0CDbD/L1sdBgL8PexXyxyRb8B2gIQzK3zwtRSoHUPghZ8Jlmz07+hIV9sux+RJJLisXzE6OBsYYtkjkKseFtAX8ZjBSf9pBusupbZIapNTK51K6ZRsEgvZmX6V26mG5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(52536014)(5660300002)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(110136005)(54906003)(82960400001)(478600001)(26005)(6506007)(107886003)(186003)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(4326008)(66476007)(6636002)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IC7xuGw6J1aCc+TtjsEgyr1MPisWf3f+8nZ6yCguQA05dV2K9cYIdHRArnUH?=
 =?us-ascii?Q?XeaPlW22b6yA/NarwgxRiohR4kj3A4wTwPnNAkJ5sAvIqPJt9oqp8uC8Ga9l?=
 =?us-ascii?Q?m+H0FsBwv6vW4Fp8skuO7EkHy/rN89usbZHCYMhg0HovgnL3gnh0Lir0Rckx?=
 =?us-ascii?Q?FOUBfqgmgwTiAW0vC1bFwh/Fq8EN/Jx7Bd+b94gQSQaF3zMSUXdYm547tLyL?=
 =?us-ascii?Q?BR86trAkcQxV/TLjnojnJxQaWgQ/Tf3KPAGuiN/f1DCAZFpGmWTRiGAH0OEM?=
 =?us-ascii?Q?IhQEXl7vozXLYp2yY7idiIAfMk7QmXHiZXt+xmO6dLSOKYxg3Gesu/5/UeHM?=
 =?us-ascii?Q?pPpYtkTASSS+LOiy26mKMSmVxUEGk7JXj6GNbyjmb9AfXok5/IG3N8EEuggK?=
 =?us-ascii?Q?n6pG1pVQS1xBWXbtRcHaKKo1oX4TSGILTDvuD71Z1MYMSyMlItm/ML7uBpcY?=
 =?us-ascii?Q?qexMQIWs5OYs92+acn0iOwomRxCCPiECPr5Lm+0SRzeRq9BkheoK/b4sykIw?=
 =?us-ascii?Q?kV87CTb2kvrmwPBlaMCb6Q6chohi/MrjjTR8byezcexMIwnHF78JnjJ4zGfP?=
 =?us-ascii?Q?rSce1DF3csHFlXgXfHtt3wZNFv4TaLqTMbDv//FvJyCssGAkmguAdlzi1VBk?=
 =?us-ascii?Q?CoSV8ZTIf2n91SZeteOwM4bN0dExJ7kqTFTjqz0sz64ZcZretBupizlm9D8e?=
 =?us-ascii?Q?gF97wYN1Fu2ywttagfiSP5nMePWiVQejfhlXawFo3U6UmT6UbSEoRXN5YMjH?=
 =?us-ascii?Q?D9+FjvXfTCr0FaCpEm5LKlED5lWMBQlrRGSGMskc718jYsjfd6+phDvBJQiL?=
 =?us-ascii?Q?kXUEeqsqkFSobA5MVI3isp+Ey1oq8NxHVWptvkAtiPezslVYnWGjlXCJM4A7?=
 =?us-ascii?Q?s+cfrcQoEazHKe7LvKGxULhiPDVpczkpIij3T1pZLMncpHcDZmhPmq9kJkKR?=
 =?us-ascii?Q?sxyw5lFCmV7rNUsJuC+phgqwT4zFCp7ArWQu9nF3cme6HtdBnOhIemNlYHg6?=
 =?us-ascii?Q?UUb0EiHEK9L2H6uAFrz4YuWj0MN8nZ7HQtN+m8tv6v3To2wu7OvOGmRQKUsk?=
 =?us-ascii?Q?pziU8BsbHd+WJswnZlxVYDOvFvMlhQ1G5EYGg/meuvP3ZiVIkWm6xfYT3HPB?=
 =?us-ascii?Q?ofZnOtrof9SmxllXRaAEfX28zi7QGBbcsIfNLocVicvfUXousTkG6jbzQMjr?=
 =?us-ascii?Q?JFzoAf9xAublEdVWlnf1xXrJqFlbd9W/J0CMU5SIEuXZ8/hrDEcK+VxPYwQk?=
 =?us-ascii?Q?p5n5KePg4XsHJhxL0w7ERo2+OrOP/qeeH/k5pfDfBC6fqIWHb/UUq8f3WmQs?=
 =?us-ascii?Q?0GGfehTb3h6DTxtPncx29JaFigQVRXzSD4OMohkweLb/xBA4ITwnZRjfPy/T?=
 =?us-ascii?Q?4oOxe7uFbvRwmgns6P6e8l9x0TawxXw0yHK+gySx7ta6ya6pDU5etdkS4ZV6?=
 =?us-ascii?Q?t7qSR45scUpC4wAseNTcPw9tFihTX9T9ZrKd3BMqPtITg61AStmD2sZrR6lf?=
 =?us-ascii?Q?sAlaTWJGsoQ3DeJfYbr0txhqu/NYmlgDfWDiv4T8uk2i2oNpWKARQE5Cg7Ri?=
 =?us-ascii?Q?1LeUPjglD9k9bwOPAmmVP4ZcnxY38eyRLOt5yDU4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fdfce6-2a9b-4204-daed-08db8ec5f688
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 17:21:49.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCvCnRNUM31lq89n/rSsqu2q1cf4lEHb+n1YvD4Uec68WxG7LbTiIXjfEkjrBoUxOXfV98OrPmOJjBXmWQdyTt2T887MphQ9tQ4hZoLnJVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Simon Horman <simon.horman@corigine.com>
> Subject: Re: [PATCH net-next 06/10] ice: Flesh out implementation of
> support for SRIOV on bonded interface
>=20

...


> > +ice_lag_qbuf_recfg(struct ice_hw *hw, struct ice_aqc_cfg_txqs_buf
> *qbuf,
> > +		   u16 vsi_num, u16 numq, u8 tc)
> > +{
> > +	struct ice_q_ctx *q_ctx;
> > +	u16 qid, count =3D 0;
> > +	struct ice_pf *pf;
> > +	int i;
> > +
> > +	pf =3D hw->back;
> > +	for (i =3D 0; i < numq; i++) {
> > +		q_ctx =3D ice_get_lan_q_ctx(hw, vsi_num, tc, i);
> > +		if (q_ctx->q_teid =3D=3D ICE_INVAL_TEID) {
>=20
> Hi Tony and Dave,
>=20
> sorry for not noticing this earlier.
>=20
> Here q_ctx is dereferenced...
>=20
> > +			dev_dbg(ice_hw_to_dev(hw), "%s queue %d INVAL
> TEID\n",
> > +				__func__, i);
> > +			continue;
> > +		}
> > +
> > +		if (!q_ctx || q_ctx->q_handle =3D=3D ICE_INVAL_Q_HANDLE) {
>=20
> ...but here it is assumed that q_ctx may be NULL.
>=20
> Flagged by Smatch.
>

Nice catch Simon!!  Thanks for the review!
Fix incoming in V2.

DaveE
=20
> > +			dev_dbg(ice_hw_to_dev(hw), "%s queue %d %s\n",
> __func__,
> > +				i, q_ctx ? "INVAL Q HANDLE" : "NO Q
> CONTEXT");
> > +			continue;
> > +		}
> > +
> > +		qid =3D pf->vsi[vsi_num]->txq_map[q_ctx->q_handle];
> > +		qbuf->queue_info[count].q_handle =3D cpu_to_le16(qid);
> > +		qbuf->queue_info[count].tc =3D tc;
> > +		qbuf->queue_info[count].q_teid =3D cpu_to_le32(q_ctx-
> >q_teid);
> > +		count++;
> > +	}
> > +
> > +	return count;
> > +}
>=20
> ...

