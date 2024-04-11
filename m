Return-Path: <netdev+bounces-87007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B058A1425
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA91F1C21EAE
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAB14A618;
	Thu, 11 Apr 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSiM4syX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3B14AD3F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837669; cv=fail; b=aLmMC34T8Qtw3bjHPJJaGx1pybXY8l01hpnrDZs/kB5enX31U/ENx3Xg2wFSmbk4M4evzeGrPfaOYsT5wRQnIw41em28kVbqxdRNWtiTmzFHDMc56QGhUH6nYEL/7kZUT85djYXk91bM19TwqtvWC5VrsQgoYDnT9FT0zn0YMGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837669; c=relaxed/simple;
	bh=cXLk5ERiVmQTZs7fYmsA7hH5vNLykNdUb21uwRNRPWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QWnFZKck6L6qJF6dH14PGHNt21w8VIX8qGb7HeSBiJsZKraS22ikQ5WMW9coW4pct+zIfMHCz+T8jgllpingKyoO6+FpShLnd/sRb3W5FmZ0vbgSJCYxK446N4KO45h3soynakMP9OJIMUvx1GQ7dp1I8WV/rUKB9vFjMQM7jgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSiM4syX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837667; x=1744373667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cXLk5ERiVmQTZs7fYmsA7hH5vNLykNdUb21uwRNRPWs=;
  b=iSiM4syXgVFTWyrF7rhNVo40Ag2NbTk8c0n1R+4UWT8g4ExLlk6JzXM+
   Ng1UMzAav0D8Z3R3pFuqpPvVpIjqvNm+vav0n7e4SDeJwKunhIMwKwJko
   kE+VWGnGmQz62DOTRE8Bd/33lPbPOclh/3B6VrBfOsNXuoJgOE1hgyl0B
   pSGm3tDzsX0cMT1rPb4q+O6ZBaQ0dOsmaln+fFmr0+xVcfky35fgvkROK
   jT6pgsy7SSJgbsVhpRcYTOc6+Xh1yj8mca5+Cly4L06xixwaUVzmlkHq8
   qsyi2472bq7Ka1kgoiJp5ii5gME7P1UNcJ2AQKbkzfMrPUKCHbaT7QnJG
   Q==;
X-CSE-ConnectionGUID: XZS3AJq6TOW173OXRpjE7A==
X-CSE-MsgGUID: ix+mVdKaR+G9ozPePJJaZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18845206"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18845206"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:14:27 -0700
X-CSE-ConnectionGUID: B6Sl6RABT7G+13pP5jZiyA==
X-CSE-MsgGUID: +2rb+hn4QYeOIcbQfPfs0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20846020"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 05:14:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 05:14:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:25 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 12:14:23 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 12:14:23 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"Wilczynski, Michal" <michal.wilczynski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Raj,
 Victor" <victor.raj@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 5/6] ice: Add
 tx_scheduling_layers devlink param
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 5/6] ice: Add
 tx_scheduling_layers devlink param
Thread-Index: AQHahZvB9AgupWLHVEe/0XViGRMlyrFjB7ZQ
Date: Thu, 11 Apr 2024 12:14:22 +0000
Message-ID: <CYYPR11MB8429C68B610E3FBD13E333BBBD052@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
 <20240403074112.7758-6-mateusz.polchlopek@intel.com>
In-Reply-To: <20240403074112.7758-6-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: bbe0d3cb-a516-4e6e-1141-08dc5a20ec4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htbrBN1f9ERrM4YhAke5EwvE8q7UN9RF9VHBavANR+/1DyFxDCQ7AmFyr4y7w6Tzn3E4L42kFXPKspjgSuAl7Q4jtF1XyAuOAycNyU8vcrNOPL84e0hbbdY6bxv7NXrnyDiu4pT8QPwIB3AhJ1foC1TIqNuzG2HaQAbwxF1wk4+DNm1rdWIPfw/ztDNsBM1yVZDBhBCpLZduSGAFNF9Z/DFCGQUVquiQacWx1oKcJhH+yKjA9VjJb3PCwhXaX/b34hwOWeBT+Ad7/btQTj+Vwje5S3Jn4Y705KwyckoV4GEB4+G3V7bfSEYNWoHrQFfrYSvAjoPM/YfKK3RPDQIuUQpVtPIW+VQCPxsIfbzvyvJ9NPWd4cIVWQoGGscPJMVr+b0amD4hqYtoBRg8cxhRCrnR9HKBC/2zRAnlmzT2QYujiUtWs2TlLI+h0OoViA16byXKDixYwHBXONIQEFF2wTG8q8f4vx+bLi5Svxg1yX/1lPmpbn+NJt0/jYwxzvrdZZqFjOERvTNqkn2F5ljjo4/7bqIntvTPjXmX30Zmt2OxEfAzpnN+u/jP19YwEaYXjHoq3emt50j+wYxGEafP+GS3lTvJ38ID0NvdkSuVJpXwC8KYOhVeS65XuFD0ikbXwHVvKJ2HhOgKt/k9qC7CjoemFyCMkdOnZNy2c4CZsdlsI+voTlyh9rM/QTqY3mw7Pji4WEQx9kcmirtKH63OMWfszMQQTVomgaShggdJp4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AnbEJQGYem5Ope5lFutgxqEOhxxlGRPGj5Tae2vx6v/+RWqLb0FNmzS4l1Eg?=
 =?us-ascii?Q?Ql+vEVW5sM2US9SkeoQ+YSTq5ZJrMPfYv6wPiP8wF4vawszCriF1MPuC+QWj?=
 =?us-ascii?Q?XmCvGewNqJp5KwbgHlTHAUtMVf3/2YYAVOP14S66wl93poSVYNSOefqmtaFV?=
 =?us-ascii?Q?sqfK2ax83eSqpFu+cKOnpA7Y56p7H+mBaRkREGkk5f+0/xlQQrkJHEVEQF35?=
 =?us-ascii?Q?rC5PLAWHxFcnzxXNIsPbI4s3lq9S+MELvBXg+B7GUZCbwb3cjvHY1hjbz6A2?=
 =?us-ascii?Q?EiPttlgclft2JpfV9QuWtNPf1B3atiOfBbtl28JiaVvaFve3WfWt/uBk7Giy?=
 =?us-ascii?Q?MNxlH2N0NJ/1VSwwlWtBFNr1KyfTLhMSTG5NK6ZgXRS+4n3EYVKUiDp7lptp?=
 =?us-ascii?Q?Gzc7dV9pMflu0yiMJoqO+3GwqBE9L4OLqAbxORNQbd431ixHD7v+angWf/jL?=
 =?us-ascii?Q?mgb7T8MUPwa2LA6LN9Ln/szGMP3haoqYiubVzeRHQsXIXv1/8aLLACoREd8D?=
 =?us-ascii?Q?auXeNsYfTZcHJxuSsoFtGLxPOLwoZwVCBbRqXS7zf+RdbEi+0IvYYiVk7Inn?=
 =?us-ascii?Q?fTZH2FVjx8oiZU5pAI5WlIRIkQYHfbFUlqpAYr/jPAnsLmz/Ntt0QmA9VWb/?=
 =?us-ascii?Q?hzZHl8u0nqBN+bq40zyAnl5JX/m5OIN9HRvhfHiqOSsYRM0IixXDblD2stBa?=
 =?us-ascii?Q?FiDXq20jpUlizc44iSzYYLi1mV0Jrtdo1lvmGaKzLkPwRG86h+xIkb28aHMu?=
 =?us-ascii?Q?zbUrBdmALp0c7nAeKQSsnxMGvYbsStcEYwuSDsErQXaHKBXEGysbQ93sS5Qm?=
 =?us-ascii?Q?kRb69AJX/mcfmA442qskZ3Adla8kqXG+A9aitA544RRTbTo+gX8gqacyqold?=
 =?us-ascii?Q?XKf+cDq8rW2tQXHN7EYs13wbdzqmETPtIriVJjTT1Ts6V1tVu9pA6E3pgMR+?=
 =?us-ascii?Q?fPxRDy/Lm/1/uSwhltwYZp7LfJbEs2UBjM2yy/pCzqcitBVl6nVyeGWBuz6u?=
 =?us-ascii?Q?nJfWLqRh6dc6R41LV1GhHYjIrL+43DCZ6QKWL9lSIoueeBEihLpT1TaU/2D+?=
 =?us-ascii?Q?rDI5HmXD7ZaXwYl54PL+iIUiPRmU0HYQFuvGYdhcKPgdDFLMsMBhkOZeLo2j?=
 =?us-ascii?Q?PMrEd0PHPOcR1UnoDS9Pq7hfgNBs6/MqvCMc3/fVps4gLYFZPR9ek/8DfGDL?=
 =?us-ascii?Q?da6IX9HiUrOTzbPnDVtv3NKCSSczN3mjt8qL0O0zk3qXfMZQLAAMEYHtmWwH?=
 =?us-ascii?Q?3RyLoxcxh4IgzoYYroIyiPJk32/UfQjhWlCF888gg/TcNxk5CxSQHX/X8Yyn?=
 =?us-ascii?Q?MukMUBCtSqJXAFkidCE5XxZJF20oDIFcjvtCiptQIXbR8TkIwjl9+EinqBm2?=
 =?us-ascii?Q?Ogaax76NDDRTxj8wkXdmKJajtGOW0QyXuqE+D8du9S4OrF+J8GzK1wlSAMwP?=
 =?us-ascii?Q?pwyY35hgSV19e4EiIBJL9KJkQuB8LK7mVtKOi0lP3m8j/9Rp3Ld8FG58sHc7?=
 =?us-ascii?Q?Ofc1m/48pGYME8rhru97juUbCf1m65ldlL4Tie0vcRpHuPM3kB2OtxnpTyc5?=
 =?us-ascii?Q?IYchxmFmY31CO/gNYeTlPolIc55+irIUlANzrMbEDmIF2SiR2eivWHYFnIdR?=
 =?us-ascii?Q?2A=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGqVaxtOnNpGL9XTvQCzj2g8kq47tkd/nNPsV0uic45lYlS8np4wp8Bnusfr+W9vlV44v3dDq2eJbjvQKg2Dy4K2CCMtNtr/qWDp3h/Pj83CsU+MiW28JHYAqpIcD+B9u1PjfFVi4Jt/c2z39JJYP9MgvVjWjzR7XLLzDiXXDDxMjRJVgWKgJQhCetB5/ctY/J7YrZqy2fFfDqnph6ggCfq2eC5Pbsitr/N7ijYUmNG5ztxoYo3JBCJ3NDh8kxvFzzOg5O9iNrDzF0h5CBOieqeUjlQXGaHSwn/xh8P0qxZYaAnCv69r7bBlaxLc0S79FvHyotbTqqmgWM1xuauXfg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkIt3BgENLpG+NjOkYeZTM4dp71/9QWpeY2M5CgZbw4=;
 b=lEPvv0YqUOekXW52JbWYCwdVeTLD0N31G2maGGRaT1K31/Q8wPXc3FKx0P9nNF3kIESqtyIrEnLmo2V3XdX82g7h2Bq3iw7rZmngarlrQfEjDgvZWLZdeVE8b+gHQ/ECQqo2xsoPwf9adA32ISAGgzwoUaCQRU4sAIxDqjSYEnihN8Aj8lnlzFGqWQu0aTMOqp7xf+ahZn5Nd7p4zCG+r5f46euIyxDM6WOBLkFlqvECOGru+B8Ez8yo9B6KcObGgmM7SPdRR0u8wkn+hNyDzAl/7DCJ++UnPjZfsWTii1m64wDn80FRib/+8gbHqv26SOzeNVlAUFQYLwRm/QArXA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: bbe0d3cb-a516-4e6e-1141-08dc5a20ec4b
x-ms-exchange-crosstenant-originalarrivaltime: 11 Apr 2024 12:14:22.9533 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: m7X8Tegv40Uw+PF0XRlKX/WtkWnL4i7PQsIvON2PoXKFg4OMJRaoOrX+zoC03VHb33+4KUZ7Jbi+VBRZyMiU/lg612JvSiaiXuOfBwC2j/XXyoFSkkHxIe45PIR7h4gZ
x-ms-exchange-transport-crosstenantheadersstamped: DM6PR11MB4657
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ateusz Polchlopek
> Sent: Wednesday, April 3, 2024 1:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; jiri@resnulli.us; Wilczynski, Michal <michal.wilczyns=
ki@intel.com>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@v=
ger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Raj, Victor <vi=
ctor.raj@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; horms@=
kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; kuba@kernel=
.org
> Subject: [Intel-wired-lan] [PATCH net-next v9 5/6] ice: Add tx_scheduling=
_layers devlink param
>
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>
> It was observed that Tx performance was inconsistent across all queues an=
d/or VSIs and that it was directly connected to existing 9-layer topology o=
f the Tx scheduler.
>
> Introduce new private devlink param - tx_scheduling_layers. This paramete=
r gives user flexibility to choose the 5-layer transmit scheduler topology =
which helps to smooth out the transmit performance.
>
> Allowed parameter values are 5 and 9.
>
> Example usage:
>
> Show:
> devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
> pci/0000:4b:00.0:
>   name tx_scheduling_layers type driver-specific
>     values:
>      cmode permanent value 9
>
> Set:
> devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5 =
cmode permanent
>
> devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 9 =
cmode permanent
>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
> .../net/ethernet/intel/ice/devlink/devlink.c  | 172 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 +
>  .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
>  .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
>  drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
>  6 files changed, 191 insertions(+), 10 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


