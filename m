Return-Path: <netdev+bounces-237857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43415C50F38
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F1E3ADEB9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC822D0C64;
	Wed, 12 Nov 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3UxKJ84"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFE165F1A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932567; cv=fail; b=KGmhxdi2GqStekugOqXp1UUtTrv1eqJEoQMlidiGKE+ht0EeC9wgHPE/0ZDLxusXkzy8NhSPKGZIkVClVU/3kcAcu4gzl86IS/N/PA+dFjJg7FZ2ghA6bo8Jr5DN0JSFWebCh26m44mKT66DhThNg68zc8VqnJsVXKEY3Xjh1FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932567; c=relaxed/simple;
	bh=xSXJ1J1/sLG7OehqF7q5KjjN3+okBQO7lgZ669+GB54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cW8kfvEgYf5grLVBv82A9E3kky0ZsLZ8klFRHcIqGtMQbrpQ6IHyvRTXkxSIZgE+TndtE+ItFj9QMEkY+cLjlaz2Y9eWerqOx7YH5kkmNoFfv4lq0PGv9llXAK5TriZdZ0fZ05SBgBc91Upie6GnbuyVfnFRmcH9y/nhRWQqNWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3UxKJ84; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762932565; x=1794468565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSXJ1J1/sLG7OehqF7q5KjjN3+okBQO7lgZ669+GB54=;
  b=E3UxKJ84i8cWvkJgFY5eMNMLVmtgmvNPSB5JDLnmTJh3S4EeJO6JBvJq
   vucfSQFmiKEA/uUA8f55FQXl7ZUXi8UHOzbGgPxsfEstgqqckXtC24jr4
   ZO4XDKq2JMzxStDEe2NUkjmUrUPtSrLXHKF6aUyJ2q5g5pp3PC7w3M1/5
   wkejdegyeiMgNOTx8wz0/qJYAoU38Pb6uDPXHz905g9nRE8/KLK1bzrTU
   Qlwepi+7dEFZtyUGMAcZkNuqwhG2qodvk/RQ3MYudKZCBCO+X8/+skLdr
   4sDENBwSUdVBJLIzxKnVXXaTNOVndAqruoqMwMT61VAQ+NiSVE0uoc28x
   g==;
X-CSE-ConnectionGUID: iPbf7Y9YQOGmjk/bhiFNXQ==
X-CSE-MsgGUID: hdc2RSvAQYK5pScBNEem4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="63996622"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="63996622"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 23:29:24 -0800
X-CSE-ConnectionGUID: lVjQGjzORvmmmC+PKMljNw==
X-CSE-MsgGUID: IjJfRqLvSzenFcTjePsmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="193261035"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 23:29:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 23:29:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 23:29:23 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 23:29:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIwG7cRx2dw40xiW5q3812xe3i4nYaPBKvT06HDt9xUDuLjdsP1TVt0FGTH7MXO2f2bYtushpH2ZGH1tlipo4YgTBtOrPJ7Vi2e4k2Bk/zCR0EHKUYqaXXYRHuebDOkMu2N70sMPjQE5hvmsaT6mvXYzXr/f9V5vtIReDDwsrBXIdQ6F0uQ5eymjPw/bfjcNwaNLNktEL/bcP+uQ8uDCeQTkhRZvlz4VHUdR3aU9r8amA3IZ1VeAo7QcmRk9NA5qBnou/Db3wDvTqyQBUKFs+LGnyF1SdhH913XUgESpWs3li/G0HM6T9dq1SAY/s8QFcjUiPyEJGT/F4VXDOZjXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSXJ1J1/sLG7OehqF7q5KjjN3+okBQO7lgZ669+GB54=;
 b=h+CU5qW8VQipCzscRVXBH8kdRVjlEFu/JPor+W2ED3TjX60JRbjIL+GJlkcvw4zsZkrBNk1X6fevKxakbtHz+izsMb6T2ELwD+BdMRz8q1508JQz7C0k/l5sEYNMmI4tv2hnZ8gEiH9PWh9tJC6s1P/ykYs5qtigiUYQe9T9G1k2D+MwE+fC+P+/m/hF0LkW8vqzTPwFfWZ3sC3EEKNCWZ1xbVmnl3itmJ4CBzhnzU9A+jhqo0ug2Gxz/XTyrBmK1lzny2Z9Iwo3XBlCX8xQ0tEk59M2bqgpJQOZwFeZe+LcZjTb3mUEOjpDmxroMo2XQiujeBirQ/G6Xwyt7FsONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CH3PR11MB8096.namprd11.prod.outlook.com (2603:10b6:610:155::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:29:15 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:29:15 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next] ice: unify PHY FW loading
 status handler for E800 devices
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next] ice: unify PHY FW loading
 status handler for E800 devices
Thread-Index: AQHcP0JKLWbT1M1bE0ehSDR2wysoWLTuzQow
Date: Wed, 12 Nov 2025 07:29:15 +0000
Message-ID: <IA1PR11MB62410706491A19216C8823BC8BCCA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20251017084228.4140603-1-grzegorz.nitka@intel.com>
In-Reply-To: <20251017084228.4140603-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CH3PR11MB8096:EE_
x-ms-office365-filtering-correlation-id: cb8fe2e4-3fe8-4eb2-71bd-08de21bd2f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y1TMqSSn3JiIOxJv2I0/UubbaZQS2++kGdcJcCw9ZO9HFbYUobyf+G2oyKTn?=
 =?us-ascii?Q?f1SxamrNh2CZaJbqQk4Cz9JW+ZJhg6PYN65/nCJUHD3FfoIHEGfCKDdwCNYX?=
 =?us-ascii?Q?iDAor/lVmnKXGkNQ6muPPsnq9zesH6bT0Y5S3Hsnslw9/WaY3A34Dr983znc?=
 =?us-ascii?Q?xTwxTWbG7GSa19dOlj5IPEYCfC9XCvN+LSDzBILnKYbiIbMkQcQz6ieh8DXT?=
 =?us-ascii?Q?UjgfxmiCTfCgtsvFI6AGF5v87fSSLoVJs7s/M80hQ0g6Ydsqth07RWnDCUaU?=
 =?us-ascii?Q?9mhAbhPCD31vFwltRvbG1cDlC6qHFl1Q84emWzVaSkC0Cbnq/f+hIOSp31sV?=
 =?us-ascii?Q?lRV4fxtD7jjbI8f90VbSGemb4GVzjcg0etmIPxfGKMjTO0JlHJjkjNSQD2jO?=
 =?us-ascii?Q?OARApGoyF5l5+67f1xpdnmCGCSNHsOyNnNoeAH+Ul8C0yIVHPkpiJR0LYJJI?=
 =?us-ascii?Q?lGeGsp6dYaNLOKkqvk92S2rxiv589MREqrxG8NXtGG/VVpX9gbax2C4MlsHd?=
 =?us-ascii?Q?84xySwCTcTheVw/vydGmwPg/ucrhaDC2XDw3rF8gD1t1CWCUKoowE0sZK6I+?=
 =?us-ascii?Q?4NHqWxSR8SdWKFcxN14q1+NBuBs819b5oyIqwdZVGRsaqoTvO/er02NXQlBs?=
 =?us-ascii?Q?WHazGpEV31AEC+FqZx/yeVZ7e5HHOPfqb3W2+O8+wXs4Mws21qfT3LxmzFpm?=
 =?us-ascii?Q?cCzzSHssOtiPurNXHzrZTK1m3Mdn2EmaD+gA/331vPRxSBr5CjUH7obMyNIz?=
 =?us-ascii?Q?SLRd89xhRRxwu5ZOo3dh8xF1wHvmkVVkhCH8iyIApLS81WY/geHuqEWDkXiG?=
 =?us-ascii?Q?3i8Kz5C2ZbTLfy0VsNoOBWGMI0JCdLYGv2HfiJFnZd/9v6gFib+HlmHmyyhG?=
 =?us-ascii?Q?XC2SjEPqzobAxa7L6Hr4p8MxHBd8pKZIfYiAnWMCYd9QSaZ0/P1iImU6Ter4?=
 =?us-ascii?Q?0JLbuYrSzhmSTMCpEfLDtwz63R0j/sKAzHJGWDA0YCRFSeREBoPgxWXqwCqW?=
 =?us-ascii?Q?KnfYbbHKPz+jo/hTSpdtEHKl6U+uBxDYGxXkUAg+FUNPrfiDgT09VaQKOy9v?=
 =?us-ascii?Q?1qtL85Ed/hSw/DgQYBoxsoZ+cTc69YF6aQQPq60prnI2u7K1MqiU+4HzpCjk?=
 =?us-ascii?Q?x73oXyWaMpX03kbjOgZGI9y6chb4pofQoLlP/4XXkHUHhxLkYCrrqAXXVhy2?=
 =?us-ascii?Q?oM2ADWA/sv6Gi3u2pSmVYTEe8aFJQhjH6XNq0jLu1Gz5OQ4lmppyBlNU6E+M?=
 =?us-ascii?Q?UFI23vHG4hLh9b3tamLPBwXwId5Z04l8ZX0ZRlaNawtQlvuxJeaIiNlKNo2C?=
 =?us-ascii?Q?1Iiv1b1B6/Brm3OJkRKj8RWlDbHyE4UIm8WL9DZFurPHiHM3QeiE24bZbP09?=
 =?us-ascii?Q?2aWr5tYekaDHhp6r0f1yRgBuP/yNkETm73KyMQy0pNqEfI9lS4wOgCIYzZds?=
 =?us-ascii?Q?0kOLczuKfWeslltpa6/3712IW99VIxa9jkpMu5soyPPjvNPBVuLqh5VKFiJh?=
 =?us-ascii?Q?EcHgdPcOwHNfV5QXoUHArdsBlKdCZYbUbS+L?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ABu+d/z66pYM7vm38tTbMbxeihY9o0TaDEOPYUfJTen+lre/h25/ro8SSORv?=
 =?us-ascii?Q?tk8Lp7ktmqoweRPtlwN2QhcaGDVtGdvK5EqF/GM68gdMz9G58lUcJOljCtAe?=
 =?us-ascii?Q?AWhi+DP6aEe8NsdJ33v793V2GxuNppEY7FAr4vJd2nXEqNERANtB1Hc3AcFL?=
 =?us-ascii?Q?v++1YhSCIbpIlvMpJ/D9eteq30Ws3Td5KKG2ILjMtYDXa2XLAOnjEo/JZAYn?=
 =?us-ascii?Q?KZ35M1Q3xQr5mLLdyYevRHR6rHAvGQr+0hqfBYAxVJaDXvQQFp6iMrlN3JEG?=
 =?us-ascii?Q?+/Wklq8+PZIpNEQ2OGrTgEDsk59kQ/2U8zKHSteOKyuFAbsxObD7aH1jIFac?=
 =?us-ascii?Q?4IRUzgSiwTjkoqFvaXfzkmo3maxKA8zKFOiecmc7TVmCce8+ynQFp6viH94f?=
 =?us-ascii?Q?0SzbNtlchj8PtwtUeioeS9ORu3EKNEBnLUHY7JJTUfFTq8xgVLOvYv2eH6Yl?=
 =?us-ascii?Q?53ZMG/AAFUSp4GF6l9oami/jgXwIstFjnJWjPNTKQWK32yzzmK8ySH/H7qUs?=
 =?us-ascii?Q?SgTAmMgQc/nb2RAq2mUgUOpbLmX7Hup8YjiNZfHPdLg+11Cx7OImc7s/STme?=
 =?us-ascii?Q?eBkVRVL9YDBMdTlbFJKH6TLWyQm+iCroYK8cq/r6C8idu0yA8J83NH22vF6a?=
 =?us-ascii?Q?86ZbGXY+Qm6h18/JiA75yeCnkURhweq/CcC8Uj3OGWLDzkfNPn8f6yJQdsbc?=
 =?us-ascii?Q?Hwe1qcW1rhnjihL5E86SPKU+JQI67OFkkS5pHQddGxSFNX9gaxAgVbEvmhAx?=
 =?us-ascii?Q?OFq1QqFacPkmMZHLK7sskSjrl3VrXEYMljAyQ1Tu5BIg0f20mKBOymLoX3YI?=
 =?us-ascii?Q?02i16URoghNeV8K2/+zvcgClEGD7NLrbWsm/thS43iC5aP23zkITm56oMFMw?=
 =?us-ascii?Q?51ohcZ7b+BJiF9NjLCPROHDtem3sctupkgmHj7HowXmQrf83laRaM5CVQjrK?=
 =?us-ascii?Q?/L+Cz5hrq99LvHCLMKdBjSkmPImCHTd4YyX2+V8wCiq5bcEcbffB1CfDqeTV?=
 =?us-ascii?Q?c2eg+MHH4a6+kM3wO1yACqGVPBe1f7d7EYiNzUzcaU4IBVFnUlOAw028YGn1?=
 =?us-ascii?Q?r2j/bZjEapCld4bd+VgfdmFLSuBiHqR60cWw0dar5ZXZ0YdRA1V+Kd7whOUy?=
 =?us-ascii?Q?2zgJBGx23H1hD3AzJJjF8L19Z+BeTnueD55XoI5qjtQu/XsDEWNHrhFZNzJg?=
 =?us-ascii?Q?6ee91BJJUezHC8QL9WT8KqzeGoQbet0j6TTxjbgJC1JLnUEHgTS8WGzb1Gyk?=
 =?us-ascii?Q?mO3OWs6iJ8BAE7nypDbtfxNWZG33eW+1/dQW43utKBs8D4x6vE3v9660zlk1?=
 =?us-ascii?Q?+mc8r5XyKQTS8kS8nRxof/wLMBy3IJXXTFPCJ0WcTvVUTrxgdw0VWYJQiBOV?=
 =?us-ascii?Q?OyNAwW8hxS87y8TtOWuc4phYAtxz3ZEWF8sAQ5e4tmX9CUp+smfuRjUKnp91?=
 =?us-ascii?Q?mC6sMORAGo2N5CXOHkr0qEFJbeuxORfLz2r6QBbDogUKODZeRJHd74K7rl1u?=
 =?us-ascii?Q?u40OhmJDQr1WQkldtzH33mlQGjdCNtKR68KpHRrw+5bA9VUKboOAzM8les0E?=
 =?us-ascii?Q?LNBRk6C0EfduASKHpsHNbQWSrdAVF0r3gPC9tXcY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8fe2e4-3fe8-4eb2-71bd-08de21bd2f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:29:15.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJl/QPubwnP5M7Jxkdkz93IfppMjXW2C2Egl4NwAMm3eQAF2dJ2K2lP5rDhs9kf4X3Ud59BWeTiBN/PVJNzHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8096
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 17 October 2025 14:12
> To: intel-wired-lan@lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; netdev@vger.ker=
nel.org; Simon Horman <horms@kernel.org>; Paul Menzel <pmenzel@molgen.mpg.d=
e>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next] ice: unify PHY FW loading =
status handler for E800 devices
>
> Unify handling of PHY firmware load delays across all E800 family devices=
. There is an existing mechanism to poll GL_MNG_FWSM_FW_LOADING_M bit of GL=
_MNG_FWSM register in order to verify whether PHY FW loading completed or n=
ot. Previously, this logic was limited to E827 variants only.
>
> Also, inform a user of possible delay in initialization process, by dumpi=
ng informational message in dmesg log ("Link initialization is blocked by P=
HY FW initialization. Link initialization will continue after PHY FW initia=
lization completes.").
>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v1->v2:
> - rebased
> - pasted dmesg message into the commit message
> ---
> drivers/net/ethernet/intel/ice/ice_common.c | 81 ++++++---------------
> 1 file changed, 24 insertions(+), 57 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

