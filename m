Return-Path: <netdev+bounces-263325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMoyGYIRp2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:51:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B41F421D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2B0F3011F2E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64513D75C1;
	Tue,  3 Mar 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+juAsiS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD113BFE5C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556410; cv=fail; b=HrsXLKl6zKoYwaHoemyJt3hreSEtUT6bthOPatbUw15A4rnprWtL10gWr/RIUeIFcrdbcqkWe7y2ZpjF4oWAg+KHQBk12zLHLDeO2QycSYAc+tGUtkf2Jije8tztN3vvS3F+p5iAz5Nr3Gef6EgVXtoIGS8yhXl2r9sbt2NQ8O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556410; c=relaxed/simple;
	bh=IAydP8ldoGSt19oTOpGSlO4AVNVLEcx8XLWe3KXTRRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/nIVSO+4lvtW3r4ZbTsqdl0dNRZ2Ani7pHINTZ64sgEwObNdS/i6ngIhuA+FsFE3up7P9GSiY3MzrfFjo8uoC3ps0vlpFdEZSAcyEsHXgL8RArDfGDVLkU+rlwEEHlWS5nxZ1U+2oN5+rRQzB+I6ncU/IEejamQfmhMyWpD01I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+juAsiS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772556409; x=1804092409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAydP8ldoGSt19oTOpGSlO4AVNVLEcx8XLWe3KXTRRg=;
  b=c+juAsiS5RfvzvXNjdgrK969hqTxt3aB6AzsqXo482Rx2PZMw2nBuSNK
   ZIhSZKsfzV/ThLkPlC/rCBS28xQ3Nq0/6Jn5LbNPXmbA4ypkkvSZNMpNg
   20MPRZsOJZP2INRotgdgOJd0UleINwZgOsw+5N+ot/ESpzaZZgI6897lQ
   KIXy4aXRCKoTnmNB8+n0u0kf3dcc4Q5V6RVZm6LfVUC4qNusc6jDV3Hz9
   qAQXk/mxC4Ex07wu50up5li17bvwVS7eoedmOI0HuDT6TsDhDs6zrGOLh
   EoCHIy7qrXhkg7D3B/dot4Med5lFmTsVqWIWJLC/dJ7Dcg5P1YxiKTdtU
   A==;
X-CSE-ConnectionGUID: JKDM1qilSRuwkHbQu8sDxA==
X-CSE-MsgGUID: e6DlPZZjRHyM3UAKbpUNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73725480"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73725480"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:46:48 -0800
X-CSE-ConnectionGUID: 1b0n3ZXPQweK8vQxPExp0w==
X-CSE-MsgGUID: fnjZ5BdeSbChklbW1lAuMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217225232"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 08:46:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:46:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 08:46:47 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 08:46:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGT7RE7LlzQrH/Ruvdjeh1HKi/r+yQlQ5kyUMgw8OShydA6kRj8lwKFIp/eEyydrKJlsiBbPLlYeY5ZsWR2BDC4RBJstxutfdTcxYVfB5AIRSbWDUwQaxvzw0/Ylve7u7RJnY75kxFo2FdUFb4h5M1RKDbVwnNTjNlOeD+odKxEHkX5Ak6dLYRbyxaBbM1X4fii2DU6GbSeG17qt3k6bcH8esLnjfpFrXnMHBXYOPsAck4Cac0BN3Wc427SdLQ/RlTi0qdGx1oZXKYXM9gbWv1eKZqo7wFdcWXcSvD//35ZfhPYhPAb81V3PAH26/qFcfOLqeJU4El9zSu0MzI3pNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTNe/5R/uL0azEILfBEbj3D4LlklDISmYoc1lPUK5FM=;
 b=lDJ3gPXnFBHw3GD7oLLFmAPEDuxE+AYg86JR6v0K8bDffxJwj7vbJqbaUkML1nnbSoNlzcv5NR8nt6UI1mKyPLHZHyHeeKNg1azxJ3gpyNG3VtkiBMLKsPAHB9L/Ow9WeAjPVjCt3+JBt7PyVpURnE6CHCBvzXr4MNb7N+gb2bQ/GAlcNu7Cb8rfCvCVEgsK9UsCdQlMvWtYucG7CxBonEe/fes1UVqA2GuBcezb/CseD6CpR4NKCW5cGdA6B3e1dlWlzeuomuG3wYIFi7hgicZ7l8e1CIr3AJxU1ZilXjgPmZEYhUXcgM44VulwPd510VzaWqfcwCgZKO6MSlGeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 3 Mar
 2026 16:46:40 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:46:40 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/6] ixgbe: E610: add
 discovering EEE capability
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/6] ixgbe: E610: add
 discovering EEE capability
Thread-Index: AQHcihV8picD0s9Aa060AMO+XGdfJbWdFrIQ
Date: Tue, 3 Mar 2026 16:46:40 +0000
Message-ID: <IA1PR11MB62410BA42CDBCB38062B182D8B7FA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
 <20260120134434.1931602-2-jedrzej.jagielski@intel.com>
In-Reply-To: <20260120134434.1931602-2-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH3PPF383C22AA3:EE_
x-ms-office365-filtering-correlation-id: 9c18e394-ad73-4f2b-61ef-08de79447177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: zX1ROAOJ2TgHaHzcg5Zg6D7/Nf7VtrG4bLvNa/sdpked6+H8GI0MeabEzyLpu1W0vi8D18FxXHD6S41/inZqgypHXdWXN012U9Mc/4SC4IvfYU2q8+s1B2tCuQbtx4XvfxW7soqfjW9Yp1Pn98F+eHSELXMAbAWYLdTogZo8NuygCdfC6fhOPp9m8xpDsSnbsCB3bi82aDhoWe+KYXUL7cFRgK29pTkouwTzVz1Kz87ntUCsYeJXbfdjQmJYrPlAkP1VBYyIbhn7V+TPpgJZZ8pbL/TaaDrHd3L1v/6hE9CBQA4JX9KjSXfzD5q0U947kXYJiLtTdQStNvyndc/ZNsEo3u5n83e6zK/xHL/iH7vVnu+Jh8Q3wgxLzAw6DVeaLuNQsxhQugXV98R4knTt9vwG683B+1hD+Ed7J8pulL4mtxsLYaVBF1gg7X1oDuEdRtTZO/BO88/5oTpP5yYNLYhswQUTIt4LERlFhNlmrUNBs7erKppHdgIq8KOqxCq3Ylp0jpNnsuUZRN++RzIkYYCiXZdd+FN/KsgPHJmhmTDnLk/FNJFH1fbkWCwG1lb2Q18S2j2J6YGPVq9cZz7vs+9L5Hif3N60uMztObshHOir5Qv/ZorHKup3nMASYavRLycLn4HFNRxQ1G+zDKk2MPtc7nfirQ16C/R5+21qexKlrj7U863TGpl1+u9I+rC3trG9gH6Z+mZVHR3aU9fMZFDY14W0wM2ayyJZvPyDEo/FUwW/M117+F20ZzXQZmffUrgs0I4NSWAGuGK4tngarZpUHDvV1D4hCGtRXgzhQMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?veSMnubzp+MyyADKazeQg0qoVj6FSrUEs/ImY1CQFGNXVwY5E5mTSaltKy7k?=
 =?us-ascii?Q?9Vf04svrTy4WPL0BXLjix8MltCQwPQwEd7nk1/CdT1YHCCdTKEHpRD8KstU/?=
 =?us-ascii?Q?PcyKcXCM7s3CKUnw0ibc1tkV/1JTKtwT73F0PNe2yb3x9asyWwyMmBALRR6H?=
 =?us-ascii?Q?udIUHiW7xAoi4nVIsGtUnbFrXY06EHfS1Zqw6WcsC1Klp15o+gXvnKxDPmP3?=
 =?us-ascii?Q?rXwkGltoDM4NMv1gwv2D2JsqXmjrxgUGXV3/5se2HijTE/6tLN+PekSKT+7a?=
 =?us-ascii?Q?Jr88mOH3a6/gxyCaCQcW0DL+jtG7WwVJ/vk82cS6M7jfvAMne6w22UG1Cqc+?=
 =?us-ascii?Q?5y9kZ7cWSTqWiQgSgwDMYm/Axd4sNN3FfO1UI64KLiGY/sw7Q9L1N1Fv6s0S?=
 =?us-ascii?Q?aifvozXFp/UhC2W90nXIjr02STzfPFWirVuFvKxSCprwbcU/kZRdLYjarM02?=
 =?us-ascii?Q?ZdFWvhKD8Qmmm0ekra1g4tQA9wxi/IwFT/FIoTDUL8IwKRV5hLH4Okb64e8T?=
 =?us-ascii?Q?Mfv0EsY5wVIvH7/O5uGXiL70Jg/fyWzfQpS+UJO/EABZ3rD7wLE+QdO+PoQe?=
 =?us-ascii?Q?nD6MW++TBp7Wu00Q0c00ekU2VP/T0UeSUGON3H0eJPFMgfJVst8z+5N19+pj?=
 =?us-ascii?Q?KF40C7h5d7YxqLW0b8RXp2zx0aBLuNUaSAjZkueK9BUrfc+yla5rhlLdEzss?=
 =?us-ascii?Q?PaKOcpIaoUbHVV/9JSpRf4CpqB6mOwMYEEZ023HBNd8OsxYOkvVg8FMcXdVK?=
 =?us-ascii?Q?HRER7Ex0c2FI+EURizHiS/SYdPCaBH9cw0MABCBKgY2arJekjmy8i2ZdlEvF?=
 =?us-ascii?Q?MR/mkQn5j2piQrVjWfjcysSOnSwX/8bQ5hHiUWgygbzlwYOWZbPJwFqXNAi/?=
 =?us-ascii?Q?5IsesK0Hggrxay77teJ+Kbf/ZewhDLvUEVrNYZKAaNRJ8C+OVt9t8U0cHL7d?=
 =?us-ascii?Q?wm5FKXX4Tp+8Kafawq4CU+1EsPrEt68x+MP08dSUjvH+smAPHa3EVRNFWRUz?=
 =?us-ascii?Q?O3wFPt3/04/w/IFB1JknYarST0C1GOTG9qp4SZ1zNMl3YeVDSCb8Vgd2b2vn?=
 =?us-ascii?Q?Lip54/oWlfLuezmrex0EZyDFNJxIKjZ9QJIAGaM/O1MX/i6VB2WBRt9/taW3?=
 =?us-ascii?Q?wmZbid/LAoclleWyFqEMz3FxdxEA7985OyYtKXURUP4TaMhd5kiMSfMWZcxy?=
 =?us-ascii?Q?/PdUNrZotp0oGBufPChGMbC69CcUaKBLlpv5SNUtUKqcznDO+qAJPOqJCZXQ?=
 =?us-ascii?Q?WqAhP8nllJnH9+PXcBB5+k1BT/jfoHEik1ACB0IYMdIUpiLLKzSHSiEd+7qo?=
 =?us-ascii?Q?IJlJWEJdYxVAl2XONgkPEXVhtgU6Wh5IYN0oP3qMQOvqbRzszXPOhaFxrqga?=
 =?us-ascii?Q?2OOY4O1IeRGEDlIUUAWOke2GXBDdnhnE5p892ZsDAU/QAq6YxIu6CLXjqVXc?=
 =?us-ascii?Q?ME+pcE5HUrTfuXVJIHkBoxN5c14v7ssMHDz3Z9dFmzPZKQCMPdhAOCO0vR5E?=
 =?us-ascii?Q?gYqqCPtY2zxLyrlhYUP2/rkQIyQ2Xwm1vojSHOlJPnopX24gwCn62BWs3rsP?=
 =?us-ascii?Q?DtGNrttbt2bO/657lOnOznq9vmsMieGOJCDSDBt3GCAp4w0l1DNBZIRmfppd?=
 =?us-ascii?Q?2VKqIOFV4PDdztPwOj1GSU0uEelmsVETq9EijysynB9gUHuTlBEmpSW6BrLh?=
 =?us-ascii?Q?tK9FO1M3PGy4bJnutXhaSHqEqfbE7yDPJ7DrsjJgTH+VeGzF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c18e394-ad73-4f2b-61ef-08de79447177
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 16:46:40.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mxSOpQC1g9qGRAt+bI4N6k8U+oLCsjZnruziF/CQIiWrS0eLhw5690kxYhNeFe4Afic2H2Oh0HlmUoQ75hn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BD8B41F421D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263325-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
edrzej Jagielski
> Sent: 20 January 2026 19:14
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger.kernel.or=
g; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr <=
aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/6] ixgbe: E610: add disco=
vering EEE capability
>
> Add detecting and parsing EEE device capability.
>
> Recently EEE functionality support has been introduced to E610 FW.
> Currently ixgbe driver has no possibility to detect whether NVM loaded on=
 given adapter supports EEE.
>
> There's dedicated device capability element reflecting FW support for giv=
en EEE link speed.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 3 +++
> drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 7 +++++++
> include/linux/intel/libie/adminq.h                 | 1 +
> 3 files changed, 11 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

