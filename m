Return-Path: <netdev+bounces-135107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED999C472
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC472869E0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB415747A;
	Mon, 14 Oct 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXi3crDV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94E155345
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896283; cv=fail; b=m0NCkoKFhVviX3qb1tk1PGT7mfPclwM/U4pHVZsraTLRQUBoPS+QOS+avK+Y8WhIHSEKRAlXfIvP7zjt2utCiklzQtY3ZMHxzxWuUo59c7Wv3H2q+oo3IeGjHtt4IBFPtkpjyGqYDImKXgW4N4zfEZx4V2nd5gEff9AAInKQefY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896283; c=relaxed/simple;
	bh=1Uw8SHmFO5WAO9INE8S648zNjQpnmtd3z5v/jyb3nAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UfuL+Nkht01vEsS0vWE39yE3oS4sZ6VTHApLaUtYGiDRbD7HU1Nat/t/h2Yxp5xvbjYpuY7cJ8WDQqJH2bDaT6Vm649ZL3fgZCGKw0h68/ddY5NxGjv/MjKYP76rU7HIbKVQ3wCY65sZd6UfJs/9cVNSbtT0Kgs5859wVz6HjrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXi3crDV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728896282; x=1760432282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Uw8SHmFO5WAO9INE8S648zNjQpnmtd3z5v/jyb3nAk=;
  b=ZXi3crDV6I/JWM9Oa0dG2GSRzR5BpiRu8R5qhxNY4Ss8LpL0L8NELKt9
   1+AsENIaYXe4TWZSeO1CB02/ctlQQ/94soQxbHpKmEa4gB5C67cOBbo6j
   W0EWEQQ9AIy6snAlYo0N7rTLjHm8xObDw3XYOFSEwKC5TZyEL8Pi5o9NV
   IoO1lQx8sdCz3nT7Xsb5HBst1BOhS6yNIKLEgxVpFKV1cFfznTNJps2R2
   cpPSUwQAOfD36R7LjoA1fOlx3IlcKPbCo7kFR3xxvrWi/ww7OcCQBtW8h
   CSLvc0Wbb/fEXnugtVoqxz6CCQIH2IRCsP3Bs4NHY8OSblVJjkK//U3NS
   Q==;
X-CSE-ConnectionGUID: t9VPBp2rTFyT+LlpeSVM5A==
X-CSE-MsgGUID: 9cXvTGCHRAqUei7WfjZFUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28418939"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28418939"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:58:01 -0700
X-CSE-ConnectionGUID: wz2Nw4ldS0+Z8NB32pElZA==
X-CSE-MsgGUID: yTuUXX16StSCBmIxSlFRIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77167598"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 01:58:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 01:58:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 01:58:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 01:58:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 01:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRHiNMpaVMWMzDchpPnGEB7Wu8FZNB7nGJuBLnvyTKbgE9iaIZhyUUp3mFDGiLnZEgFI7kdQBqMG31eDRCuHDnA9Uyq+DcEl5z4HwlaEthtoJAFzAU/BL9fDsJcJzOy8eifLRuV3V7Gg2nxTjqhacqOKSzihlId8rQkihsNtIG3XIYUib1FdEA1EgMUP48Oo4WjyGWhoGQHaxfHPO/b/2fXh8mTUUwMu+IauSapyx2MGnt1XvQmYtpsDcKmQYLXzj1nazkIGOg/q+luQb8Iydqt5qy2bLKzFwU7ULj8QgPMS+Yvuoj3A7BXJSrTUdKFFph9SbHxakk8NxNPkAvP0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7Oiy/mjGUSlvY6qKeUSTKl5gZR6RST5uYozBkFKOIg=;
 b=QVGoFS3kZYxmwDrxLtXfeyJSkTmyL+ps0EgGTNHzGik54nkr1aRunYWFtfHQw2UR32552wWIPobvXL3lSUon8kGUlflCgvJbGOKsgo2hANSCZ8ruHGvYnJ/hjaSCC+3CR2t4MWKpLE3kXuTyil5TvLg6b0ZERivOOA1D9xyEGtZkKj9OvVD6+MdxQw8QabQfpESLDp2bAtVnphM7XWqpFjethd7y1xKGs3N0pX+CIZgVXNTNLhT0TCKI+0I14D6dQvUKlzcXxLWRI41jd/V+l7AGDwbOyXuVAAspAG3rG/7VPLWlwK6pb+RIY8C6D5HIegt39DUGoa4+7ZzUiaJpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ1PR11MB6130.namprd11.prod.outlook.com (2603:10b6:a03:45f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 08:57:57 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:57:57 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>
Subject: RE: [PATCH net-next v3 2/2] net/mlx5: DPLL, Add clock quality level
 op implementation
Thread-Topic: [PATCH net-next v3 2/2] net/mlx5: DPLL, Add clock quality level
 op implementation
Thread-Index: AQHbHhC9dS8KEgsYOEObfkVO0YCVmLKF8btw
Date: Mon, 14 Oct 2024 08:57:57 +0000
Message-ID: <DM6PR11MB4657657232010275ABCCA7629B442@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20241014081133.15366-1-jiri@resnulli.us>
 <20241014081133.15366-3-jiri@resnulli.us>
In-Reply-To: <20241014081133.15366-3-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ1PR11MB6130:EE_
x-ms-office365-filtering-correlation-id: 5a10cee8-4b8e-4dbc-bb3c-08dcec2e4c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CXXK+/ValtHWlE7okoaAgofYZPUydnF11Ymf+zs5paW4QjpDRAAFBEom1GAZ?=
 =?us-ascii?Q?LlDlIUrL8qk65Yz2WXSzDMWQn686w47KNp+TQrCqVlalpus7K/F1/Xt1HU5f?=
 =?us-ascii?Q?ew3SqSORN5/xk9ubRmp27L9dJMCeNvER7Uq4uYsRVjukaqx75wChafXDN8XL?=
 =?us-ascii?Q?P5EJxGV3Ns5S0zpNK98//Gem+dQLZBi1JOWTfITU69WJdPMP0f9pXtT57RdK?=
 =?us-ascii?Q?zwCU7yY6G8xPCeZ6JONyKdqc8NJz0DWKf6g2X7vDALXCO0aYwjHwWCGSv2Ye?=
 =?us-ascii?Q?Z0ZRCPR9Eu+iaf+Tb72YTWbexq8nWn2PWDqoWXbnEa4YXD+qSrJlyBkzwDyo?=
 =?us-ascii?Q?/e+6KU+OKO0wLqzFHa2zPNfJtjNJrXuEVpCyxqt4PrTk72J9hbYwdqoHtNzR?=
 =?us-ascii?Q?b/wpg/SDfAkZpCXOwO9sJY3KxB74T4Qpg08+28UIAPuUAjrCSn7FFIHg8OZO?=
 =?us-ascii?Q?SKkiVvuHQtywq7kZI1J3AgX8V90+6DROR9PlCNINKpTMy9rYM8KTY8aXCJQL?=
 =?us-ascii?Q?s5nm7W2RDFOK0VC1yPutQR8z8P0MbzviAliivzv/+rKve1eg5UTEiGMPGwau?=
 =?us-ascii?Q?gtEaJoZgqyHA8JXoK6GOHqmrzOkWaJ6L7b6nH53B5kNMImRIluQEMYpLxZwc?=
 =?us-ascii?Q?tL1OpYn0ThjLRVatDtTVAIBMR+DmIJgGGDvvo87bjJgr/VSyEIRfTLz77t8t?=
 =?us-ascii?Q?3ltGXLSUycA2tUw5sdmlAMCk77urLvfC1ZXwt/T/PEe4oyjI/mIXkwaAiwLi?=
 =?us-ascii?Q?AIvdghgllfeb4t9dITombThF2dvxpc0Yv+ju9S04SAVyfDSMvaHrdD5Dj339?=
 =?us-ascii?Q?gC67zBxEOv6sKtruNYXu732+TkxyGxdqKjCiRCSZIzVWoRpVro1KUaULoObo?=
 =?us-ascii?Q?MzeoVaSLIMDYRfxa7luer2D4Y+bYL0D9HQLiuQnbWOFErK+R9ri6qc7V6sWK?=
 =?us-ascii?Q?ltmahb46BL74R9K/dsomGTBQI56rN3nJm9TALyYlWxQmZ4IHm0Gp4q0UiwND?=
 =?us-ascii?Q?8fvt+HL1EJkfRLUufwtAKtfLw0L5QFAI/NLiHGzF3QotajIzoQ9Jsi8E0Eud?=
 =?us-ascii?Q?MjoTN7WM2uJJkryhWyORadCcoaJEP5EO3jzGP2HwRNAbuPuaUypliYq1ijAZ?=
 =?us-ascii?Q?ptA55LTG1so1uje5iuPT/ff8yqxfoV7lh6ejnSqjeu0vZ2yJMLradIUa03yl?=
 =?us-ascii?Q?E5bty2/MaH1dG7YpAvE9MmxjeeD0W3FSlv4KhEzgIKchK8YOYAN8je75Qcr+?=
 =?us-ascii?Q?Nnjt5HjFvXQDiWUrwLYWd+CDZKkGisUVITHC6phcpBF/pLX5Llzl1QYTvuIA?=
 =?us-ascii?Q?oVBBNhiEoq8QFsCwe7lg+9aQ52RvFP9daQbB2jBh1SGLmw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rL+17rPvQk4l6qOB5nH5V9w9Ft/AImzNC9kZotpLvacVqnD/BlUKA2cD6ZjS?=
 =?us-ascii?Q?i+PzRUx1ZVa5FL1mLAz9h7i9+Gix42fT9GrdzlXY75Jq1Q5B/LSNsabxAYd9?=
 =?us-ascii?Q?bxxpoZhevtLysGw3Vfw9ayta/xZH97gh5UzVmL3IW9oNWZPXpRJZ+tSKmNcb?=
 =?us-ascii?Q?mD8+cLgL59dey9/5Y8ElulKd+Dnn319oqXRKzVuqIGtHs96lodF0gObDb9NM?=
 =?us-ascii?Q?7gm2DiYFyxIoC9gau0F8zM5alrzCGVWpK2vR6Q0dyMivrWE62KKpYBlnGv5A?=
 =?us-ascii?Q?tZX7xDxwZO4RmQCh3sdcxPac7urrnjG9QyXD28nOmd7qlJGYw25gpMXGx/Bq?=
 =?us-ascii?Q?+y1dWhW4m5b8kmnaCWK8JjpMulue6WSWNYZ7zXk1SBWaC1KUuKSX1nDialFK?=
 =?us-ascii?Q?2Lacb77ZBKotP/a2owMwlyIB3UbIjClET4u72Le0u+rmBwD0Secx0nXbOyen?=
 =?us-ascii?Q?SGmie8vi3l8fbXecBtSo8hr39V18IOQBl7CQvVt6XIAoDuQfS8taqHhkohbm?=
 =?us-ascii?Q?ORDi7fp1VKzGZ8JAEwg8CieP2RWracPNC/jKOYn18IYAHbofyIMrvTHZ4Yhv?=
 =?us-ascii?Q?iiIPWUSRAyLu/1A992Yko/xkfSGmD0V50/u8YmLLKfcp1Vrdu5SmSWbESf4B?=
 =?us-ascii?Q?rR8l1+uVT4K12dgzmIuQ3WYLthRNVV+O1nXuVR3AKfTNQHeRcLREqnMeyaTW?=
 =?us-ascii?Q?GRC0cpYL7pV5SOWDVAmgD4MRa3Zu2x09k0bFquOCGIXcoz0fhhvDoaNr00U2?=
 =?us-ascii?Q?udFXvFB/aSv8r/qoK3jzuw8pG/3LywbTzJeT3nSo6esvDLudIUBVCfwYlUlw?=
 =?us-ascii?Q?VTdFGNHKsgj6S8dSlrSiaT4LHl8OdUn9k3I3TI2UnPONr3b4Cy5UBUX/TZnD?=
 =?us-ascii?Q?Onj6yktghxuZtA312ZY1tXYndRthAypuNbtU/zFpFFdWB423dTUUpXthQrWN?=
 =?us-ascii?Q?/QdSP+KZc6ob9AkyLg+9L4oo0Q12Mhwv8fRc8smncswbJZwqbrZdDGOFaN4S?=
 =?us-ascii?Q?i2m5+BKq5xs4kLoORxbsqmoWu2I0SMTDN0RXLBeOHuXJwoSLWtOX66SArI06?=
 =?us-ascii?Q?dy2U8g7AwmgyXdxxuiQsCBSqDNd5fvHeF/9Au8sU15XYoL2iK58b4447A2uS?=
 =?us-ascii?Q?aIQnc8mbX7/wSEVIML0g4FtPvTRbatIfd5Sjd9D1ZMn49noN8OlIMtif0VZ8?=
 =?us-ascii?Q?4VrL7oIpZj0Ti0tMord9slFLqoTB9ZY0HqTsHPaEBMNwcktnKny3dgWZzxKS?=
 =?us-ascii?Q?N5LGMB6qII5Vm3lFlD/cVK/0kvz6aoaHx9kTWvrjmAfbTfFjhQ9TFveo7Kpl?=
 =?us-ascii?Q?zil9fkpnKbbO9VheotMlm5pC0RIoOH4kw1E658pZj9SC3Eu8Tx03OQmCqEYE?=
 =?us-ascii?Q?luuD7ZYv6g/KVdeu3lSgHA/1oQX1zctb4dch3wB3wn0Yq5PH7fVy0suyoh/m?=
 =?us-ascii?Q?N+ZjqMWikLL+Lrz6vYlvmwf6ilbgJh2Eezo2X3OGe5surpa1QluvLqR8hHlH?=
 =?us-ascii?Q?8U05iR3dA/u9j7yct0lB2VJyT/9UON3R+78P0NL6IJslvp7VaDALu2ZubFeZ?=
 =?us-ascii?Q?vez0uZ6TBjrcK3vYm+l8+k1Fw+2MC63mOqNTMbDN7gNyo3UCCf8O/ZWdqBeB?=
 =?us-ascii?Q?fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a10cee8-4b8e-4dbc-bb3c-08dcec2e4c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 08:57:57.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00g9uTDzBJ60ocvrmfqIbR6o08jlWzbR1WEGeVxCAcowhHruaCJ6/sRBHPKRTRCvU9y4QfM+wwXaeRx7C11LEFjOWh0KnrHMqmM4bHpEF2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6130
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, October 14, 2024 10:12 AM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Use MSECQ register to query clock quality from firmware. Implement the
>dpll op and fill-up the quality level value properly.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
>v2->v3:
>- changed to fill-up quality level to bitmap
>- changed "itu" prefix to "itu-opt1"
>v1->v2:
>- added "itu" prefix to the enum values
>---
> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 81 +++++++++++++++++++
> 1 file changed, 81 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>index 904e08de852e..31142f6cc372 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>@@ -166,9 +166,90 @@ static int mlx5_dpll_device_mode_get(const struct
>dpll_device *dpll,
> 	return 0;
> }
>
>+enum {
>+	MLX5_DPLL_SSM_CODE_PRC =3D 0b0010,
>+	MLX5_DPLL_SSM_CODE_SSU_A =3D 0b0100,
>+	MLX5_DPLL_SSM_CODE_SSU_B =3D 0b1000,
>+	MLX5_DPLL_SSM_CODE_EEC1 =3D 0b1011,
>+	MLX5_DPLL_SSM_CODE_PRTC =3D 0b0010,
>+	MLX5_DPLL_SSM_CODE_EPRTC =3D 0b0010,
>+	MLX5_DPLL_SSM_CODE_EEEC =3D 0b1011,
>+	MLX5_DPLL_SSM_CODE_EPRC =3D 0b0010,
>+};
>+
>+enum {
>+	MLX5_DPLL_ENHANCED_SSM_CODE_PRC =3D 0xff,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_SSU_A =3D 0xff,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_SSU_B =3D 0xff,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_EEC1 =3D 0xff,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_PRTC =3D 0x20,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_EPRTC =3D 0x21,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_EEEC =3D 0x22,
>+	MLX5_DPLL_ENHANCED_SSM_CODE_EPRC =3D 0x23,
>+};
>+
>+#define __MLX5_DPLL_SSM_COMBINED_CODE(ssm_code, enhanced_ssm_code)		\
>+	((ssm_code) | ((enhanced_ssm_code) << 8))
>+
>+#define MLX5_DPLL_SSM_COMBINED_CODE(type)					\
>+	__MLX5_DPLL_SSM_COMBINED_CODE(MLX5_DPLL_SSM_CODE_##type,		\
>+				      MLX5_DPLL_ENHANCED_SSM_CODE_##type)
>+
>+static int mlx5_dpll_clock_quality_level_get(const struct dpll_device *dp=
ll,
>+					     void *priv, unsigned long *qls,
>+					     struct netlink_ext_ack *extack)
>+{
>+	u8 network_option, ssm_code, enhanced_ssm_code;
>+	u32 out[MLX5_ST_SZ_DW(msecq_reg)] =3D {};
>+	u32 in[MLX5_ST_SZ_DW(msecq_reg)] =3D {};
>+	struct mlx5_dpll *mdpll =3D priv;
>+	int err;
>+
>+	err =3D mlx5_core_access_reg(mdpll->mdev, in, sizeof(in),
>+				   out, sizeof(out), MLX5_REG_MSECQ, 0, 0);
>+	if (err)
>+		return err;
>+	network_option =3D MLX5_GET(msecq_reg, out, network_option);
>+	if (network_option !=3D 1)
>+		goto errout;
>+	ssm_code =3D MLX5_GET(msecq_reg, out, local_ssm_code);
>+	enhanced_ssm_code =3D MLX5_GET(msecq_reg, out, local_enhanced_ssm_code);
>+
>+	switch (__MLX5_DPLL_SSM_COMBINED_CODE(ssm_code, enhanced_ssm_code)) {
>+	case MLX5_DPLL_SSM_COMBINED_CODE(PRC):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRC, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_A):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_A, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(SSU_B):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_SSU_B, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(EEC1):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEC1, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(PRTC):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_PRTC, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRTC):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRTC, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(EEEC):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EEEC, qls);
>+		return 0;
>+	case MLX5_DPLL_SSM_COMBINED_CODE(EPRC):
>+		__set_bit(DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC, qls);
>+		return 0;
>+	}
>+errout:
>+	NL_SET_ERR_MSG_MOD(extack, "Invalid clock quality level obtained from
>firmware\n");
>+	return -EINVAL;
>+}
>+
> static const struct dpll_device_ops mlx5_dpll_device_ops =3D {
> 	.lock_status_get =3D mlx5_dpll_device_lock_status_get,
> 	.mode_get =3D mlx5_dpll_device_mode_get,
>+	.clock_quality_level_get =3D mlx5_dpll_clock_quality_level_get,
> };
>
> static int mlx5_dpll_pin_direction_get(const struct dpll_pin *pin,
>--
>2.47.0

LGTM,
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

