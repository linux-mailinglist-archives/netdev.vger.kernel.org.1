Return-Path: <netdev+bounces-62994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D182AA9D
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6422854F6
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BAA101C5;
	Thu, 11 Jan 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIsVgcZR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FE10785
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964571; x=1736500571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M4WSqGAM0xnUJQmV+l+cucmqODaZTqnVvNHny0/FyPA=;
  b=RIsVgcZRfhjR7mOpv2fbSm/jiAXtwkdBe7VTWo3M7MLcDdLkiRPRq5SH
   hQyjJdd7qzs8qosJIbAPvjOofqyXNG5aapN2nolyE124rWV617OPxMVKG
   MWU5z2XPgp5m7sOv2pkPhiBhNoPr1nOZ8vGNXrf2d+yr4P4LGXkYP6ZKG
   KSvcfK9xsrsRDCJUVEdQsNg//tVSzf/Qtxa5KEbaiqaXsRSI9KSIyzjbD
   n7bMnLwOEwFjKdj8ofS1ezYLbfsf365g4AmixJgUC2aruQGqbT8s/By0O
   HsqwU3kjkX6Vd0nb177foZny6VPk9XtcC6q6c1LlN6j007VxDzMM6LPCY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6148845"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6148845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905882932"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905882932"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:16:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:16:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C87NkfXfw4pDlB1z9x0gTzuCJ9WnGRQ5oZ7yRdZ/A2RcY21eAPedwftvqIyzkdUVt1moy1Mug7DrGv+mv0AQDxiCnbw1NrCuKj4x2h5JMXoBSdyUWctidCO3nYyQGHT9DSrs3HwDqKgJu2eO9+C99Jx+rKdfFjRbo3d4CLOexd5unz4ND2romeECWFImBzW6J4yKxtu0mCD7DtfXFvyr3tSodOJXOD+WyhlNH2gPDWfU+BOxWx/IhLI88tnPwdirqFYdoP/zHtKA0Ze203+slDM6zJh1J7DApDE5obWmELUG21uQWVqdD8+waPdQE/bMEIGn9ZpZ56KUJ8YyfwoAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riZvqRn7pqkcnB6E7p3pSuAbwtnjXUn3oErXPX/3qUI=;
 b=KCgzK6YEJzrnRAJcw20hXynQcNSVw8yG+rsJFsI6gmlNPQr0fPTX/QhZYg20FAAOSDpqhhc654bNmcXmupBJW01kPXHirwASYZSVTt+JSxw5B4zvRGfmGyjvxKTROHgTMjqtTbzm7fL/kQI69gzyDkEtit/F1wv3/KQLsdyYMuNYJHeik44uli1dRzAT3LKvHIbA0G3bzMrKyNaLGKtDS9sne9e/aScH6Qj00kVCBYxXLQJpvnFIUn4aiNhrD71vgLOsplF+CgmqyKYXqtKES6Sm2B/B6vzTKabYUXwzt/egygePbjcStDTdPJUNC1P0ia+G81LSKvoiioNJU5MYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Thu, 11 Jan 2024 09:16:03 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:16:02 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Topic: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Index: AQHaPv9PdEbVjXsF8EmuApoVd3S7HbDJwgQAgAqcpMA=
Date: Thu, 11 Jan 2024 09:16:02 +0000
Message-ID: <DM6PR11MB4657BB73F4B898CE25121A589B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
 <ZZbKJjoNG7o8opKi@nanopsycho>
In-Reply-To: <ZZbKJjoNG7o8opKi@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: e78df79c-7392-4b57-1da4-08dc1285eefa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ngtwHQGYQvgmnkbeb7KpVAIZBoFtri5tyj6BwxKj/IQAN/ZvBWKSP8Wfu2IEo2JDHNNyqC43DxsGZo98npE8M22Mwv7aKo5/MppbuPAM0zJhObXK/7phiobKjqJW2jFrRmYbKt0MEjt2TsPFGkcMAxcXd1DJO3ogPHQkQ13BIqGvB9IIfed9Xjq0w6ZAgh8oc6/DJeIEfjy4rMZ1hcR8C4jMb9oGHvPxkl38Rw8crdGvOshpwwllp0N0l4tQ68dGjxW+YnS01K2e6VwjaXGWgMVIm2rIiY6VZRvp00TfU5HD7lUntgj48rRJsdMtM+MFnVARUQNtLJRP4+GzRo14nUSlvuHJF0h7IP0Yvny9FXT85DQWSvk3gPGPH9IfYLwzZy31PZNazwZHWslK2d1DQbieKQv4U1e2WsNne/gkjFM3zv+pQwNhVI6CNf6u1Ztw48+bw02Z5nX2g4fvD9V2xUMpShMcynrUhXrVvSbZywakp6bb3KvN5PQXzA4C4JhQUBPf5K5MmUguG9hjurPHk2a34YfdzLo3ie5o6yJlcOSCLUYO6T6nfDe9JvIysrFXe10G4f/EgDSKhqso2jq1eUn4dbniepb3krNbxd0twBWwL2L+L34iZ6tEwnjZypW9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(478600001)(5660300002)(107886003)(82960400001)(71200400001)(86362001)(7696005)(6506007)(8676002)(9686003)(66556008)(66946007)(316002)(66476007)(41300700001)(8936002)(76116006)(33656002)(66446008)(64756008)(6916009)(54906003)(38100700002)(26005)(122000001)(52536014)(38070700009)(4326008)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R46Yu4W4iT6TS3gEz7YBXX/xsvGIAewnGNaVB2HNoCm3UII2aoHWG5iIJ/yD?=
 =?us-ascii?Q?tpLvQFxOzqmRD6BJe2zF8uvJsmHR/poCU8KEHVet+/R50/wRzwYUwn9nOseb?=
 =?us-ascii?Q?NLB09iOdu0Jps0a8f7bhWaMfTd/UzMmGUZVcBpRrqL+QayGg6pvR6xJl4YtZ?=
 =?us-ascii?Q?mIMcnXx/iiHUoF95ReQ9TNI2VATl7bljQj1HU5yEUWI2qtpYYTx4owiunteS?=
 =?us-ascii?Q?FbJSJsSt0o6Hzr+PDScSUJ3/bu6a0QqmtOEsg1ZR2JbR9kUjG7GIag6fXtoN?=
 =?us-ascii?Q?fOBOhCzPslG4A3hYp0Owd1rvlPCbCS5a2w4XSDOatIJuLn4oTrQhQXCeOIJc?=
 =?us-ascii?Q?ATw9m1Edx2pvXFtA+QcXxz95N3NrgYFfaz59D2MOY5R5o832R18Nd5rvkXGF?=
 =?us-ascii?Q?5n6PShjO3oE5pGU71vQUg69m6KAvP01CKxPo/EU3VZN47FnaV9Bdq1Xi5FSH?=
 =?us-ascii?Q?BUKgvewwWehLjiLAsd+aA6nRi+qC/Qf5NLSangx26x4NmqnLUd9sMqT05huv?=
 =?us-ascii?Q?syePrpw39+BT2ga6QfzUkyaBBfsZkkdqyXjFYXvSDj5rAXYavHlbuJBJVbZF?=
 =?us-ascii?Q?LrOM2bqkuAx0e824Apa+jV98vRpEOM0WpIQxbVrBLfsKNpqFxZscPaDqMhQa?=
 =?us-ascii?Q?13rt8ab1Ev3gqrEuxVdEE/D3b7rmDacbgt7iXF7R/aDfP+TZpM/2nRNt+qwz?=
 =?us-ascii?Q?QkhA5/5FRFcOsNWyhvL2fFvv7uUQDkhBKFq9vIaqMjshnDcqWl7IoB4v2Fo7?=
 =?us-ascii?Q?mZ/wIaE7zEOjw16wto8XLRbCNWFUjC9RPwHKDEuJsJCq87B8ejnsjHRJmroO?=
 =?us-ascii?Q?AOXEWCpnYnIe2eeaHLluwXdYVzZHNyEbmA11WNQD48ECozgb1tnn7Tq9sx1N?=
 =?us-ascii?Q?0dcBUOUc9RSzm15dbjK2XsMowTeUVGZuiIlozLYo/+xl28wm50u6Caw/4kTM?=
 =?us-ascii?Q?g8rhUCXwofb1gDRuAn46oiean6f3GwkbnEgJ9imHyuk9Tz7A5sGm6Y/0m8Cb?=
 =?us-ascii?Q?KLwhmSYGvWfXRBIIULnDaRVzSZ60jpBz/Qpe+Usz+oa6l7LDqO3lxYbMijje?=
 =?us-ascii?Q?xuRd1tyxaTogF+llIkEuhpcmr2LWRsrjKZO08dT/s71Pk4dFC/LMQ/45YjVi?=
 =?us-ascii?Q?xE8smOGEMZfn2EsHxcWocIBXywfZ/CF8lLSdy5bw1aV1/ZAa2YMaryrsX6xb?=
 =?us-ascii?Q?ygvRjODmasiaRca5Y2aLke4nRi+nH2TdTmUKsLElrn0k07zgsGD/pmyNAu86?=
 =?us-ascii?Q?0KlhOGseDNquxfABVbj00hjz56xRZUayr92jt1VX7W0JCHjlE+NQ0366usne?=
 =?us-ascii?Q?Lix2qmbSyzAJXNLxlroezaF0K0CD+bx/RczEjmGWaz1UcIkfScr2tGd2JHuA?=
 =?us-ascii?Q?Ti5M4RWTflMSwJkdklMlcxcAw8GxUCx62i7wGsw194ZcSFp4uTOnhYXjelCD?=
 =?us-ascii?Q?Kyhe3XhE+04rWz1KBc4hQKhHE8jdJnKiN2hdxYJ+Djew/Y9ejAyb9C/MU7Mn?=
 =?us-ascii?Q?CL3SGl5GmGbMqBAMEEZVQ2KMU6gqVGrBdHvQEA9I15vju1VLwAwAsLeZhXSQ?=
 =?us-ascii?Q?iUBtASHMtZiGjNvureESXA952pz2iepQM38vVVczrmz8Ypgma7+Gnurbt23T?=
 =?us-ascii?Q?xg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e78df79c-7392-4b57-1da4-08dc1285eefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:16:02.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X76dBEW/vSwS1cxndkNYSAjgwEtlfJZx2qAkwAPAfsUyWdXAvQFs9m4i/iuBQ+Z7dW1qZig0xzK/rO+E6mGH0fQ0RTKWBnm+8ebAwCFgmcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 4:09 PM
>
>Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:
>
>[...]
>
>>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb,
>>struct genl_info *info)
>> {
>> 	struct dpll_pin *pin =3D info->user_ptr[0];
>>
>>+	if (!xa_empty(&pin->parent_refs) &&
>>+	    !dpll_pin_parents_registered(pin))
>>+		return -ENODEV;
>>+
>
>Also make sure to prevent events from being send for this pin.
>

Sure, will do.

Thank you!
Arkadiusz

>
>> 	return dpll_pin_set_from_nlattr(pin, info);
>> }
>>
>>--
>>2.38.1
>>

