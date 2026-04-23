Return-Path: <netdev+bounces-280761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEQHJP0c6mmUuQIAu9opvQ
	(envelope-from <netdev+bounces-280761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B89452CD8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64B233046471
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76643F0757;
	Thu, 23 Apr 2026 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/mHoG7v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517793EFD13
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950054; cv=fail; b=B85weGL+mC8rIiUuWtbmffSHj+Ir2jRAicH0rU9nhcCHHgHPr5YdsrkWwITweJlu4SmuwjdtBie6hNybTqGXGEvB7KBG0qWV1sGMUWu3GuG2aHeiFtJOuZ42Dir5yKRiTOAZb30t2VEIwvTnNPuLBVqNVwrn4OnI5YdCNiwd3eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950054; c=relaxed/simple;
	bh=vyFzYq9PGMEOuKNuShmB9AX+HUWmfYTTfktA65sBLU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gfc2V6s/g0g5Dyex1nwNlojWdsPvC2cqG85Uwd7ZFXutcFbs+YNereSVSzU/0+Z7qLZONJAJALqwBNE8Lak5vFHh0AlZaRZpXZ/Z+vGLNTzIW+UXs1PioNkgjBR1xmsjL8MfxJXIsfhPod52BesUlh9gRXf9JtoDz0UyrwylKIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/mHoG7v; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776950051; x=1808486051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vyFzYq9PGMEOuKNuShmB9AX+HUWmfYTTfktA65sBLU0=;
  b=B/mHoG7vCZ7zFV+Kpgldyf4Eodlk4r7QreoZ8d15dXQhsmlmIGPFrD93
   qOCnJjoF5OdqcWBMSSJXUSDN4NdYZX5fkTbxLIpV88VfMpMLFTvvnpJYS
   J562kys3PoA93dIPtbqnwSusYsHY0oOq8OtD/afAm+s0U90I7ItRMt32F
   ikUP34eOinH3vokoP6B5rJm/WUQK/zVMkyQOOqGZuQlXpcPolhETQune+
   qzX6q0Boe+YPTJmdoCl25Yc6X++aGnZwBCgTrHSh2a/BanV20WAPlhNAB
   jY658Yp3WPDjNrpMBamaxaqhI5r6FNZL+4z9vZrtEnzamMiYSjPmLiZU8
   A==;
X-CSE-ConnectionGUID: 8eKYXWZUQ8KXqlowYBHsAg==
X-CSE-MsgGUID: pkUWf2fBQ6KLP0dULN62iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77083925"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77083925"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 06:14:10 -0700
X-CSE-ConnectionGUID: bbSVx8ooRpqN+QmP6kNYTg==
X-CSE-MsgGUID: S5qjm+6XRDeZgksC489ilA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="237017704"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 06:14:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 06:14:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 06:14:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 06:14:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahiwcmogsd4TxorLtoLlw/8MP5BfWz5F7eIxVIeYe8mDbotCUKY4YsM7lx9Yl9Xuszs7b4/YkFoaFrtPlPRZ05fZC9Dud5IBpkwGQ/VXzpBCy92m8RxFs9loPIcJQhgH8lxn6oiwFUTtevTwPk+PDVDZ6VrFO6pzxbkDPIOfvPLcmjuSqm85t3xcILa+WzB4Hm9BR6gHlsLFFJKpx6hxIh4OaBOh/bgi6JPWUB8Qlgud0aYajr/Zt7AfuCODSqsTokaTOuN4hfhReU1cm3uR9NqGFXWo9PKkhqGSV83wOYgldv/WXz5EeGglMc5EH4UDfdTOfWSrGXIaBPCBqqxaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFvKTJ2R0bgIZu5IVSOpGLu1Bi50vEdjWx8VX0qlKsg=;
 b=D+O0qYY2YNhdCu4ttGr4u6nn3Q78OsSK/5qsai8J73w7YuEd02WooMOMuffc67UaMugO0zpOP1yIz1M7zDyTr70QePNG1LSX1vz8eraRPytJYKl0JBH7Mcewk1ASXZxt1kcGlFltFvzi7TPuUfgxaN5/AGsL4SlknqyGdf9BAOdLlYEmIRzoPO2nKzJoOvJxJN6D2eGncuMMGWWzL/FzIzPBYxIuK+cONY1LZqYWRztVFItzCFsboT/jbMQkKQB8GTymHzlTliLFE2cOsfcWqm2FiXyV7NXyleO+Q1HrV0ZRsCrFnY7Ud/Y9toI0zAqr/UL6Gmd0PrnHIdcP6Hyhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 13:14:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 13:14:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net v4 1/4] iavf: return EBUSY if reset in progress or not
 ready during MAC change
Thread-Topic: [PATCH net v4 1/4] iavf: return EBUSY if reset in progress or
 not ready during MAC change
Thread-Index: AQHc0yHBXinznxpkQkm+PAWUoJajtrXsn8ug
Date: Thu, 23 Apr 2026 13:14:05 +0000
Message-ID: <IA3PR11MB8986CB8CCF01A323EC675F5EE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260423130405.139568-1-jtornosm@redhat.com>
 <20260423130405.139568-2-jtornosm@redhat.com>
In-Reply-To: <20260423130405.139568-2-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB4891:EE_
x-ms-office365-filtering-correlation-id: bcc71130-46bc-4879-000a-08dea13a321d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 3lt0Ub0wXlXSstRKYj+7+Al/Ft8Wa2+cab/i8WuxaPjGfS3GhEn+shBBMle6UXEMLqooIBC8JEDHU+ajIUdHOeJx1wj9l/WitA+ezmcI4/H0CjSlX96rBalJZhCFrx/9yfBrR7T1jWXtQX38fN6TWZchCLv1NAg+i5c3gh0gdJRPKVpmPgL55gqwsh3xgfDJccPXxJE0WsZYiDHLOnLrQK8jPcd/P9xIbSi5z0o3B0Yxm+VVvgNm63292oV2HVxGmqqfg5Xux4kvNX98YfzsjSmSi+7XEayVDx9aBy4kHhAQCEghcw0EnFoMfTf08PdPNUE/oEHtPOE4Y2maexJcKtTf5NfLNWMDQfVxZnwm9fyAl6i51AUYHWHEecQFZE9e1tdj1KRVVjtkpFaohKTRcgOulDUA0ZadokWpoCQZlB/Bg5p+qtqdlFf6NhNCHJpy3Z+LEcQ21hUERtLZCT/wERiIT+R/VoIqqty5brXRTIG7XhaKZuSek0TlC/lZTdFoVUhDAPIGCdw+dRKOO3dfN+ol/TvJwa2Z4UgEOlk7ktoyLC7UFWF0Xr2WU+8qkmJ0Nw7AGbru8/PLtZPSKE7tjxKhLOhq8FEEp8gRv98HhJn3gz4N53vwtpCdEP9uV+vmgOnxLJXsso1FjBXXa98803LKiirtQmHuY0wUqBIM2Oezi1PUq3N1EoHGJ67gU1rqzcnYQ8YaJH/QJ3CY6UlPHLEbkMh6QPsl+CeZmMwm52pQyFNmVFyjp+qM2DtsFiRbaj9YNZGFGbY8gVml3AJDsogoXVTxm0WhkqBO0fl+cV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xU6E8u3D4LXd2ozVBxhkbUpknhMi/VmJ3lP/t+Ssa4ufuMz81gvUbKd2mn5f?=
 =?us-ascii?Q?qYFz4LTEEGoaRr+kMbGBRiEalzZzfmc0PNWw0MqIs7mjYlwYfOWsPVIN8jBO?=
 =?us-ascii?Q?BduxQGC9pTd2CdYL/hxPOtl8tk+IRQBPCXtxVIo6xRrHTpDxRDLtbkMQ+dwp?=
 =?us-ascii?Q?wSWhDtT7xM8dNnt2XEir1YUQPppMlMutVLBuRKZtlaPD4D5MbZXL5Nnre8pt?=
 =?us-ascii?Q?Zqfsoc9J/ZtLjVXcLSZ51R6dsBQ/5wKFZw/UxiWDnrqoVdz/blm3TBBZRI4x?=
 =?us-ascii?Q?+sue79BuZypo6YBVmZ2TrJSH/+XBqOcRaruMyBihrDbqOsTvvzyHGJL26a9X?=
 =?us-ascii?Q?zJ9bTvakhjjH8S+GFkD0ZqsBPQu1Z6zPfQwgjBdf/ek/WRGuelXHTbgkplob?=
 =?us-ascii?Q?L52DFy97GeczHcx8GDT56i9mm/QfYSGW1sYtgcrM5zQaQ0sxE8lvuWEPq+HB?=
 =?us-ascii?Q?67NUt+oXe5jzB9M87xqrxeiV1f0+M9GCzimRNcBBe35mQU4kYLKg96hIxG6E?=
 =?us-ascii?Q?pSlHey/zk2KkUit/dY3/rO5d++WWX0eJTpdb45L2/mM3ne19Qlqs1u+VxaOx?=
 =?us-ascii?Q?6PteTilExtPQqe5aBIrBKLmW6Gj9IUvLQOOv3SHC3lXM+9lns3C3FhzbpgLV?=
 =?us-ascii?Q?4K0zYhoEZKitNjkYEKrO1Vn4QIBTDzbIWs+uaLjt2HUjlGzc7C3/Gu63xI/3?=
 =?us-ascii?Q?9QZb6VvB2VW3TR90Zz1hz1VxeKN5CZdYsSM6jEYNHu+4MYati9rJNSTz0U1E?=
 =?us-ascii?Q?ReLBk8fLgMEDF8Pjpd4iJ4lbyxkoQf9crQ3cJWiJZpbwAmHZIm3XbBAE/jVJ?=
 =?us-ascii?Q?vxFuW0hBIwks04z4JTOC3DAQoxm0foWER/rfCaM3uoWGG1gSSJijWxMjPGH+?=
 =?us-ascii?Q?CYEJsYI+KzTOpYFx+frITWslUIjX6l9OiKvPXnAnBRCegelamPMaQ8KPF5wN?=
 =?us-ascii?Q?//lc3aCf4/2CH/FXNBE5gQ41Lot0Mn2LE04abwUR63BOleTx8qYf/HjwFe3O?=
 =?us-ascii?Q?TZ1NTCoh84OM3eJmKvWViYhyFrgcvHwG3FnYarUDqXAJ37n4+zEZftUaoMfC?=
 =?us-ascii?Q?KSSBAV46H93GcinmUA99aIJSaA8pnQl1SqTdGoJ1BDzfgnplMWz2tJMw4OgW?=
 =?us-ascii?Q?RYdIh84/wbY8fUrbYVYPfZ5NU2E0YElKhIMLV5uT+sKChFH/qAsuqkRWBQQu?=
 =?us-ascii?Q?lXYI5RIcLxuaRV7ieDslicRBUqjEjp7nrO3lGWXjC87P9lzDO4wz2a41mGQ6?=
 =?us-ascii?Q?qFgBHGuqYL/h1L9ev/N4hnV3JRbnzMYsr5mUZax1JsspQsaEAktvP9DzD2Ks?=
 =?us-ascii?Q?mBrvdnwEFbgCVcyKH60Rq9vaT10dpIr2P+D7S/6tEdi/IWwhn384o3QlWPc2?=
 =?us-ascii?Q?3H0moATrj/zVPJ4vwevwyBtBdAzyXD6yod28PNdUHHhSSRTB/E29wiHQetxa?=
 =?us-ascii?Q?X7IrFxZDQYUHczxdBtNjckL6OJF6r+I1tCh2M3R8oTo1IQ17n65KlaGSJ99j?=
 =?us-ascii?Q?GjCujjxTU3tZnY/OLnCzoG2kUIn5hMzPjPP3pDXTaiRO6k5WKvIQnwQoCMZo?=
 =?us-ascii?Q?MNA+lPSs6Ug4d4kwRA9KERcRZTNcLPXnZ9eRdJJFdt6vgJvNJztWTCGgqoWO?=
 =?us-ascii?Q?AlctedjrR8MJESmJbCFxHbGWqSrjy1ctCghKBmC7kOD/yPXiSE6XrBjwtqbG?=
 =?us-ascii?Q?ZUZiRHHcKObUzJvYg44vvx2sAAN96WW/bfB5DTZJtJkb0d5kNRiFo1ti/OmI?=
 =?us-ascii?Q?q0a/V3arN5DpBlOjKcil+oR1UtIAelc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: or9qkFDQtj4IzqIhgeJstu++R3PPeaigvNp8+IY8ucivkesnc+Dmx3SPERloQpAqflS1sjKB28d38S0IweEOW+1JylXVHmVXlyXUUB5h1IatDHG5l2BygP+JVPshZVJWkm9Uv36+c3hyNwtOwLSV0Ucr14ZqkgQefUe+oy+xYtA1ZS5O3WseGHr5rfm49RH006ZhuMxZmMcqcsKE/B0mu/TcDxp2tpuNKX+oZB/ItJpnm11gD/GT/kC6WDoK4TZaWalVi4vuvSpVpYiS9ghWuUvtoRzH9TrXwo8XYG9FDERn60aV28qweIijqxhRgqWxvLZSTitjBEG1woLd+ZDJzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc71130-46bc-4879-000a-08dea13a321d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 13:14:05.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ot7z82KBNj/tGo/vzqEPTeT8KjlA8DazHz+KVnMzlhQSLNoy3zZad2VUQ7VDomeNEPd//fvcY3EVpVucaZfemTCUDReq/OtZ5oMTqHyxRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280761-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 71B89452CD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Sent: Thursday, April 23, 2026 3:04 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; horms@kernel.org;
> jesse.brandeburg@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jose Ignacio
> Tornos Martinez <jtornosm@redhat.com>
> Subject: [PATCH net v4 1/4] iavf: return EBUSY if reset in progress or
> not ready during MAC change
>=20
> When a MAC address change is requested while the VF is resetting or
> still initializing, return -EBUSY immediately instead of attempting
> the operation.
>=20
> Additionally, during early initialization states (before __IAVF_DOWN),
> the PF may be slow to respond to MAC change requests, causing long
> delays. Only allow MAC changes once the VF reaches __IAVF_DOWN state
> or later, when the watchdog is running and the VF is ready for
> operations.
>=20
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during
> sysfs operations"), MAC changes are called with the netdev lock held,
> so we should not wait with the lock held during reset or
> initialization. This allows the caller to retry or handle the busy
> state appropriately without blocking other operations.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>=20
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001abc908..67aa14350b1b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1060,6 +1060,9 @@ static int iavf_set_mac(struct net_device
> *netdev, void *p)
>  	struct sockaddr *addr =3D p;
>  	int ret;
>=20
> +	if (iavf_is_reset_in_progress(adapter) || adapter->state <
> __IAVF_DOWN)
> +		return -EBUSY;
> +
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;
>=20
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

