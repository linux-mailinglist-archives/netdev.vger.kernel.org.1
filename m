Return-Path: <netdev+bounces-80511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4287F7AD
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A244A1C21A76
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2D51C55;
	Tue, 19 Mar 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J48XDD+H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128251036;
	Tue, 19 Mar 2024 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830580; cv=fail; b=DSF/PuBHJ0guH5+razKipuR4lc37+h1kr8uaaxcW0wCbtF5spU7K4LRW0hO48pbnhkxHn10BfLYrDik/h1exr94B6OLGf/w6BlgXZqDXBOrToo9vHPH5PMgzPhuwWPRxD5IoeVI8U51V/jpPjqO28vog6OYLUc830UIAlC19XmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830580; c=relaxed/simple;
	bh=DY9Cgpf0JHggy4+mOAD8Cc3MHPDVTJoFbXZ8o/S6lbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VAkQ9mF3FOo/Gs2FRdSEsyQOYeY86GybP8YK1/2OtgPiW8AfkFtfqp403O1QeqLgj+bG6gadft8lnSdJyr+HpdrjLNaj37PdIhcLlkiRmVpf12wynQ/UDjAEE9N0RVLM1bi8CvTgmf9fkiUplzQF0JDoj181v4i0Ce2PYFRY/QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J48XDD+H; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710830579; x=1742366579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DY9Cgpf0JHggy4+mOAD8Cc3MHPDVTJoFbXZ8o/S6lbk=;
  b=J48XDD+HGze7GsUnHij9uZFFMAN5MqnH0a8FW5Jf1M0K1bBIPs/slnMt
   4fXw0GJOj/pBpaQNfkyx3Qg0RGFTkmJTS8TapMfqbPxbCJAOUw9JPe04I
   1iExwWaMHlvCvylYjh6M2yR5bgJjAyftmckQGUYYYPJoBu1paslON3549
   OWSPruF8XOLnvTfyk2TNoDmuy2Q5QZAdUc6b3MAaXznUsC1zVyOWMB7cr
   VVMoU4ho6cNYAObxC6mugSkmHVpqLEnnl4EUg1q6YYhN17A9ZmDUmNJbJ
   SF+26mXBeZwCy31T/KLB+iK7V8H1/Y2B/QxwKrLzkHEg7SjQimFnJ8OBb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5802139"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5802139"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18288932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 23:42:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:42:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:42:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:42:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUea7hZrQ7rgIxZqp9gEtgOLF1aUFTXI3wIjMbWoQNtTM4mypPjdLC6zo0/NeHFf5CQcD9FlwcYnUmhGAcv3eD5XQGYHMPdujoSiGhE4N5uMTEPrqkS2oZ5vo3iVG+uYwt1uKQywpt/nFMG6BUJ2XdCFoTk/B8QKanOi9HQAHXw4wIY6JzIKiyPUST1LAUH61/hwKRuWWetwuJTRcAimZ+gIY6noosc8R3piNOTiQGLeDucRVtxda9u8vx3hohPFuJ3BiYevBnlktfKU0RaKzmMKo5j9QB7WCLSM5aPFFv+FQ3uLU5a0gSVVCsnr4gTFmxrp+6/9AMCAybcmbA1vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY9Cgpf0JHggy4+mOAD8Cc3MHPDVTJoFbXZ8o/S6lbk=;
 b=Ki7Bi6SArl/BZySciOky/jMKkLkuyVxOwpC3SD0KIiuIKaoXW/+KN6oyp9gsqM3unNc3xb3ZKktgLCJuG1epLKfDQ2fe2acpb+GDmk3yggwV6AqiJHYe+jU4rCH+KtCRdD8jTm6KIaZOZn4j6S6Ivw5cZfLnPnvhnmP7/O2Z2M0sB60d7l2vvUKaSdJHV354qupKkAAb6ELlUKrtuSmVjphRqNy58IqCDzDOk/FWoOKlP87/fJEpTDXt8SJu6W0jiBvGKygIquxYPn+cHUDE2PyQdVdjadcUXm3P2p/pA1TwugJyK8ktu2ae+oilaCj6bFj2KbaRHizrVLJ+ej4AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) by
 MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.12; Tue, 19 Mar 2024 06:42:54 +0000
Received: from DM4PR11MB6526.namprd11.prod.outlook.com
 ([fe80::18b2:7397:cbff:b3e1]) by DM4PR11MB6526.namprd11.prod.outlook.com
 ([fe80::18b2:7397:cbff:b3e1%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:42:54 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next 1/6] tools/include: add ethtool_ringparam
 definition to UAPI header
Thread-Topic: [PATCH bpf-next 1/6] tools/include: add ethtool_ringparam
 definition to UAPI header
Thread-Index: AQHaduRg5Dk6ApXf3EmvZpkT8Nvbi7E5ECAAgAWTOqA=
Date: Tue, 19 Mar 2024 06:42:54 +0000
Message-ID: <DM4PR11MB652658E811CE77877C252C108F2C2@DM4PR11MB6526.namprd11.prod.outlook.com>
References: <20240315140726.22291-1-tushar.vyavahare@intel.com>
 <20240315140726.22291-2-tushar.vyavahare@intel.com>
 <ZfSGhI9hu_Yat9kI@google.com>
In-Reply-To: <ZfSGhI9hu_Yat9kI@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6526:EE_|MN0PR11MB6088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIKGjy8MWAxmRWpK/oGaeh8XQB4Pwi6ERRvEp98xnRhKY9zuZ54q/NIq7y+AtWAW6R6XR39Fjem4LT00WVizLaCWwPy/0FDnewxjC/o04ELo/kCTasC3Gko+rkOiCynKRj9dvyAdxkVtkjS0/2eP6qRV+s0m0ZDOIzzswfu86RjUjs7bUGJXAZZBd3mTYvsj5peuYUNl7jBOP7afujjGl1rrqgggyli3s0FcYcgCRb6J5q+BnUjJMDpx+bYFGswNm0Xm1ehG8ortJAerPY+LU9Y652X7RNTqyhGZYCs9dYZUOpkJPJ399X8dV2khAuETEbIno/S48r+t2Nt75ywr/7EYZ13D6KV1OuCWfg1vERwGXDRz7oj/vRNZzdFa7nL1e4nt2MqZVHBW+KgTG3s95+NoRYJE0xvl9811euxlkZxbtT1NV3TMhqlq6A8rlvBKUkOt+r6634Lxok4vHaCI9vc7cLvx9ELgHS05IWXNTvThj1errN20xhty2OMJ7qtTjzcM6SriG29iO9Ys23qPKWh4yiIrNb8K0JPBdmQRKUdUxcN5OKEqfc8YOQtWyG3rsxyPUuSBCv+Qq9EQ+Ecti4FcIG9dtT3Tm/TH3xS5br53keSa3ys28RbmEOQGxYLCrpSZWf+LIpOXPAi/I8AubprKXmOE7Nohuf8CkLPi0CI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJZZWxQUC83MHYrZThWa1RJbVY5YkROVTVxWU1vSnNmdXRrRGNYNk1WeTIw?=
 =?utf-8?B?aVVuTUlZYUsvNnRIdU9BT3NzSG5Mc0o1ZTg4ejE3Y2RpNDhtaytVdXZPdFdU?=
 =?utf-8?B?MEVaZTdJYkw4ZldRNzhiZGRzU2QwLzZTMXYxRmRZWFk5dW05aEFYS2JtaENw?=
 =?utf-8?B?L2JRa2NJM2dLUDdnT3JRNUoxL01zUzNUOW56UWZKck9Cc050N2RjZ1FVU1RM?=
 =?utf-8?B?ZmpZQTRBc2x3S3JKcUVSc01oREluN05XdTlMbUJXVEYyaXhrM2U4WVdVdUJv?=
 =?utf-8?B?ZFdKUkx2RFNQSEVtV0RTZW9tUGs2S2Nrb3IrSVRsSWJ2L2FQeCtVSXlOZmN4?=
 =?utf-8?B?QTNJYnN5Lzd6ZjEzUC9FUmV1S2E1MGxTUGNFc3dSQXdJakdBeUJaSXVNbHVi?=
 =?utf-8?B?dEJ1R3hNTmtsYzV4Q2Y4UGZZVDE1SDJvQndORFduSFYrVmlUMG1vdHlXbEZq?=
 =?utf-8?B?VkgvRGFoWHgzUlFnV3RTL2VlaGsvRnEvVk0rMUlxbFV5THl5NTFXSms4S2J5?=
 =?utf-8?B?enRDbkV6ZU41ajFEcmtoOFJCdkVGVzMyWGJ5bHpZZGZHSW5QeDdDRnoxU0VZ?=
 =?utf-8?B?TndHb05LR2xlVys1WEZ6TDgzdDJydmhNbnRRQXllS2dVclh6eWdreG5nK3BD?=
 =?utf-8?B?cHJ3ZEpVWDlNSk5pWkkzOFlsRUQ1YW0rOE9tb1ZoQU5yRUJaU0lEU0Z4dEZY?=
 =?utf-8?B?QkVVb3RaSXlhR2dUcEtoUk1qMWYrSVF4V1Iwclc2Ull3OWZhWlR4Z1VEdHhO?=
 =?utf-8?B?WEVjMVVFM1NDTmV5cTBBWDhOKzByb0JodUhpY25lL0NXSXdlUzFFck5TZXlo?=
 =?utf-8?B?OTdxY1FSSDEvTVQ4amVvWElJMTZpbjVOYjhtc0o3U1Rxb1k5d2VHZFpZaTM0?=
 =?utf-8?B?bURITnFjdEFSbmFGdUJzV0hQaURXejhmMXg4bkFiQ3BVaWdUQThVdkw0dTZN?=
 =?utf-8?B?dE01K3pJTEFLQnNZNUpYcWRTTHFqQlh1UmtqVjA5VzBOS0QxanMrbHlTY090?=
 =?utf-8?B?S2Z3eCt4Ky9UTUtYSlFoK1hxRzlwQXE2d3ZZdkY3ZVFnSFhyRXNkNjByWUc3?=
 =?utf-8?B?TnI5c2lqTWltM2E2eEZjVS9FQ2phaElEb05IbjhqSVRVZkNiTEJmMG9TaWIz?=
 =?utf-8?B?TThKZnc5d2YvTG0zeVFOa3BPTElXMXJrQjh6RXpmQnY1SFYzbEZtWkVhYzlM?=
 =?utf-8?B?WXZEV1ZRdEptc1Znc281ZUtTVGxULzFZdjdVd1MzWDBuWWoyUGQvREFJNkIv?=
 =?utf-8?B?YmdudTRXd0tUMFJzSVRaMUhZS3pvdFEyMVVhazFIR3BzZDhIVGEwc2JEYlF0?=
 =?utf-8?B?SzliQVUwbEdhRFNheGtYYVFneEE0TERzMDBQTzZIQ1BFK0N1R0RaSEI3WU1y?=
 =?utf-8?B?UFZkSjhrL0xHNlhabnZYaEhhOE0zQVFkckdlbHBhZ3hxWXdxV1g3ZlllS3Zp?=
 =?utf-8?B?WHpzVlhiNTM4SkRlMmc1ODFFUXNJNlNJQzVRSm5vUm54V0Z1YlA5THJEVWhJ?=
 =?utf-8?B?eksrME9lQnFkVWxKWldXcFdTdGlVMnZQNzJNV0ZaRlJXNGd5R1JoSXI1RUZk?=
 =?utf-8?B?eEQ3NUVNS25zK2hFQjhobFFnZ2tnL25ad2htRDZla1crK3BNRzNaMGkyRExw?=
 =?utf-8?B?a00zV3hZNVBwLzJYSTNpY2xNTmhSZ0dCUnQ4UGN0dTlHcjdzS3R5akRISjJv?=
 =?utf-8?B?WmgxUlJDVnRYdnVvOFhnN05HU0c0MjE0eXJvU0tjTkc2K3paMHBWWGxxWC95?=
 =?utf-8?B?bS9ud1BTOURMY2NpOUNGVTN0S3ViQnNTeUZmYUVXRmJXbWtMc1lwWUZ1bTU4?=
 =?utf-8?B?eXVXZ0NrWlE2QktGZ2FqeFJTbjYrdDZueWszOXFWODgvYml3cW5XaHZqY2Jy?=
 =?utf-8?B?ZlF4by9hK0kxSVRRVURSTFdybkJjTlNraEdDMVZ6ZG9QV2tVVGNqUWsxM0Jy?=
 =?utf-8?B?bURQUFhGVkg0bEhBNEhOUVc4RS92c0RyaFcvSWNsbk56d1p1TUlqOFZJRGNE?=
 =?utf-8?B?MjczZlVUQWM1MnRRRStKNDdDVVc0MlhTa2NkQ0lOa1pCMzB1SXQ5RG9SdGFW?=
 =?utf-8?B?dldNNXovdXVZVlQybmRkSkhXdGJUU0N5ZVl3cHpoOWZaeDVCd2FyVkRxSlQz?=
 =?utf-8?B?NTJ6WjMxOWszeWFwYi9MQ0Z5V1RucGNSZ0NGZlF2YjdBSHQzRzZramJHTUxU?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327fab32-1470-4fcb-6536-08dc47dfce2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:42:54.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWCE6rpZpLhwbpK7s1rPMxHcSdrr7NRN78MJUXCiLsiiIzNw646Y2xIxZ8GvmTt1cjRCfOH0SQL0Z5L54MBc+J4HMi15kbzFB1gbZ5x+uUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmlzbGF2IEZvbWlj
aGV2IDxzZGZAZ29vZ2xlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxNSwgMjAyNCAxMTow
NCBQTQ0KPiBUbzogVnlhdmFoYXJlLCBUdXNoYXIgPHR1c2hhci52eWF2YWhhcmVAaW50ZWwuY29t
Pg0KPiBDYzogYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgYmpv
cm5Aa2VybmVsLm9yZzsNCj4gS2FybHNzb24sIE1hZ251cyA8bWFnbnVzLmthcmxzc29uQGludGVs
LmNvbT47IEZpamFsa293c2tpLCBNYWNpZWoNCj4gPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+OyBqb25hdGhhbi5sZW1vbkBnbWFpbC5jb207DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1
YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFzdEBrZXJuZWwub3JnOyBkYW5p
ZWxAaW9nZWFyYm94Lm5ldDsgU2Fya2FyLCBUaXJ0aGVuZHUNCj4gPHRpcnRoZW5kdS5zYXJrYXJA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGJwZi1uZXh0IDEvNl0gdG9vbHMvaW5j
bHVkZTogYWRkIGV0aHRvb2xfcmluZ3BhcmFtDQo+IGRlZmluaXRpb24gdG8gVUFQSSBoZWFkZXIN
Cj4gDQo+IE9uIDAzLzE1LCBUdXNoYXIgVnlhdmFoYXJlIHdyb3RlOg0KPiA+IEludHJvZHVjZSB0
aGUgZGVmaW5pdGlvbiBmb3IgZXRodG9vbF9yaW5ncGFyYW0gaW4gdGhlIFVBUEkgaGVhZGVyDQo+
ID4gbG9jYXRlZCBpbiB0aGUgaW5jbHVkZSBkaXJlY3RvcnkuIFRoaXMgaXMgbmVlZGVkIGJ5IHRo
ZSBuZXh0IHBhdGNoZXMNCj4gPiBhcyB0aGV5IHJ1biB0ZXN0cyB3aXRoIHZhcmlvdXMgcmluZyBz
aXplcy4NCj4gDQo+IEFueSByZWFzb24gbm90IHRvICdjcCB7LHRvb2xzL31pbmNsdWRlL3VhcGkv
bGludXgvZXRodG9vbC5oJyBpbnN0ZWFkPw0KPiBMZXNzIGRpdmVyZ2VuY2Ugc2hvdWxkIGJlIGVh
c2llciB0byBzdXBwb3J0L3VuZGVyc3RhbmQuDQoNClN1cmUsIEkgd2lsbCBkbyBpdC4NCg0K

