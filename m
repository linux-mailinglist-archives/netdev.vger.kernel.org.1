Return-Path: <netdev+bounces-288945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOzaDHfXCmqc8gQAu9opvQ
	(envelope-from <netdev+bounces-288945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D764569649
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4859030316C0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4443E51E2;
	Mon, 18 May 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0jBqeyU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F43E4C70
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095123; cv=fail; b=c46mqAMhKR6B4F/o4Ls0p5DXSJSqoXIdyj6RN8uChd2ijtmeS/aieRVxJXfHKspsvkyjeYGUMJnM2PfZnugInDQl8es/ICeJlvJUW/4T+Py51KSirqhg5197HdaaU6K0Nn8gh+QQjR1VJSzRyQv9C3Rt0sSPF4g2DUdd1Rp+uZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095123; c=relaxed/simple;
	bh=L5dZfGF4F0FHXq2XZPGqCtPH9i3V+g9tYQ2680Jem4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0kFYvG3GHq99RIoLP/G8v1/DMpajy7AsCVfv1FnBYMNVm+V8xzdEm1VLUmLPRnBkxeIe1b37QGkRdAOlqYxP9760jXa5076tzLr+k1+TBTbo71/28Hkasg0GZz+1W1Su4AXDEPX5tYVGXJrdQ9VBNU3aQyWWDf+35gnyRzudjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0jBqeyU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779095122; x=1810631122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5dZfGF4F0FHXq2XZPGqCtPH9i3V+g9tYQ2680Jem4g=;
  b=F0jBqeyU4I0+n8qKvy5yw+rKqqScbB7alUchUYq+hE+fXEJMZmoupSQb
   15Tv646ips8kXWq7MbnO4exsSYYKaNd6rbV6tyT9dpGzKrdFjOuSymMvM
   jqzJDo0+Rf0sDNEnIdXau2wR8RU0CvPhRTROba1OTwRHlODvDzRDKEGU8
   hsA/VkWWIbajmL99GMC07/gKIdDpQdKcV2ZkTWGa7l8gn2ZuvnQ/Y4kB4
   wTFMPpwHohXuT/HdHgqfR9YYdAdT6oJ2KNZclQ8pMcaIaYLftES74rz4V
   mmNSOUTsbMAVuSeOLD1RaZI8hUaleQvxykTT7eSdoiq8QK72PsSEJIG+V
   A==;
X-CSE-ConnectionGUID: j2mPVNErT3Wnekb55IywiQ==
X-CSE-MsgGUID: CRQ18XJdQ621QxKWXr+Eag==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91047582"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91047582"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:05:21 -0700
X-CSE-ConnectionGUID: /4d3suNRQZKtC6frTbBieA==
X-CSE-MsgGUID: XdGacaLgR+iU7BYR0BXenQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="269710776"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 02:05:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:05:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 02:05:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 02:05:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTnX7K4BFnyOtAkrnV2Iqfr2WLNNcGNPmvkD3fBzZhNfeIKhx2TIpTaPnNAH7jDoV6xnTvD37lss49y5WlLSD2SjURaejy7GzH3SqkR+8n8eP9qscNLXqDcbbkEw3NDz+cRdoaJ1BOSHoZ6Zu0HCdadz0dvcOapwv9LQuExKZnGUhZ6kCeY0LDV8ekvBiivjEzyl0NsdXGj+oDTWFEWdcD5/tdul0dkyldE9J4XKMLnB+a37xHY+PKL9nC5Aio4WZ2Zs01Ca3542KDdvTfeQvQrtxoCY2Zjrf91IBypZXx8jy2QULuyMz57ExqcMnhD1t8qUIKcJgMHGdRzHxPj5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OrL29Sxmu+QTMhAfjM5re+I7qiVZ6Es/ME0awgACm4=;
 b=Dhh4A+kwvGqlfMrpFSnThFhdEk3ofpoVgIK2zEWnWz2MCYZ/d4uT+pkqqtX6iUXCSBuXrplcJjmeTW9p/UMay0fB34Kyhi/3GxvQolEnBo8nH3N6Phixu0JU6DqDdBCoc7cdqhwJw+LaTaC/VR7V5lpRJrXfOjMM32EJ3IjH5w9YaE/VA0OZ/PTygOk32XpMr3GjRn/ePd/edtmMtoib83Dn0x7sBlEQtWA4gffLFt1wa/7D5lO7KBVsS6nj/yOYL7MOUX5D06kx+Djkz9zrKZxSusLngceUSZPRE6ROqutSVnXsLK7vKaoSUUCZleHgpWJ2PFhhT59fHsp3S/VtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:05:16 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 09:05:15 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Simon Horman <horms@kernel.org>, Kohei Enju <kohei@enjuk.jp>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Drewek,
 Wojciech" <wojciech.drewek@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix UAF/NULL deref when
 VSI rebuild and XDP attach race
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix UAF/NULL deref
 when VSI rebuild and XDP attach race
Thread-Index: AQHczxJLDrkriVuuzEOMfkgdiU5/2bXrZZ8AgChHCXA=
Date: Mon, 18 May 2026 09:05:15 +0000
Message-ID: <IA3PR11MB930134C1B4DBAE9C275FDF578A032@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260418090137.411506-1-kohei@enjuk.jp>
 <20260422180020.GQ651125@horms.kernel.org>
In-Reply-To: <20260422180020.GQ651125@horms.kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|CH3PR11MB8749:EE_
x-ms-office365-filtering-correlation-id: 8e65c06d-ffde-4a43-c1dc-08deb4bc93ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|3023799003|38070700021|4143699003|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: reJ32TPzH8CpfBtjDVcDLtydgx5BMY7G5G8oaOXitwSPxPIpt1lNvhoKoWPee6xbZfAbdUQgqMP2QF1QaPrfyRTPD/cMcyTf1oT0pgR9arYs0Gou7euPCEDbp4aop9aJYTcaNHxrqyZsnfuGHaqDog/sDYeHXK73sZ42kR5qFeZH+rAMkpfrVgapdGborHwL6rI1/VL/MzRGCRprWchGCjYlrWZTw04O75ZnFfdfVSVjUV6IA5GiM+L4MFgM7UrExcAZUBBVM54IHSyhxPdxZBdXA5Zoj5pNusg0RgVbmSvRNKdcym2MMVWMx1CyGPEhD4+sn1AyymY99OmDOrlv4nsZbtvrJRrD6y84S0QV3auDeiw+B95vZUp6PKPYPhfYvyj+nx020bwo3B0e1Z81V0+QDO5FOsH2XroikTQ8BQMfqtEcvigJq3whAFFRNEIrJIzSisu2tdZwBjCuNGC1bbfV8G4QZgrSXG1MNzyaGrgLCSlmpv57eQBfjXs02a/CfTmRQLSdd2fkkDAIvWvvqyOWpeKwXLwYPvXbhhH0UX8TsQmPptzie3tbSAtdJkQ2J4OI75buhaqPRGBqg53DZHz2wBrzkinEHoYz+esbEq9W32nk0xMXe6rSzih0+CVzUZyCTPFjtJBKojn+g7+RJ41hAS5hbW7nHz+tC0upIZTVeHtw9KiGgi0Qhmven3ns/pNIM8zhx1BKMlbnZBPJ8GkA3mhzEJyNCdylqZTGz1LM8fBVz9C80TrDIG7ZzaRE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(38070700021)(4143699003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zTjI8gJ3IzG4ZOrYuY4H0SIL1GnD3kDf2kaozw5gEFIFiYaRRSduDzG+O2?=
 =?iso-8859-1?Q?Reg1Uw87IV0qlvy/b2g2BkCtwGf66nYvPyZqqsm/il+jWY+4T5hC7VasnL?=
 =?iso-8859-1?Q?I4+tvY9ohy+PcrQ8E8UO2//lnFgDjazUaQkVGa4fWqE0AT5Z+7fO6J/NfC?=
 =?iso-8859-1?Q?F9RSqV4HaXrokUXfaCuaYQmutv4S/ixiA6D+wNxQeVf6PwuVLVyq6zAZ3V?=
 =?iso-8859-1?Q?B3FcWn0FzdVcHfgYw8r06nrrhZSaDDwFw07+mxoOHeEv9eZtyG7yCWTj86?=
 =?iso-8859-1?Q?PCfcz+kKVOa6luiNx8kdhmNtrd9Lajq3tcSn2sJJFERfzCyQ/cSdk0OoeX?=
 =?iso-8859-1?Q?wg6M2kCe8XP0smUJrKgRP170P+88TSUIuIAR5Hn4pa0rEdfgiHoIwWWnG8?=
 =?iso-8859-1?Q?OPE4B3GlroBgVjRKSlLWam6ZJGUKrjMSTquk6b7GGRC469iBg9Lx0ielt1?=
 =?iso-8859-1?Q?fx6KPwZjUY6Ynf/dQjD2Z0yfw04XJPz/YwItwxNk8kwMImKHXElt8kFrwX?=
 =?iso-8859-1?Q?TBUfWkg2AlWDnnMSIHCyzxwkzlv5MOeVzzhsP5+jE5EdmmT/niWbISadDX?=
 =?iso-8859-1?Q?UfcMakScAO/TnhE4+FVzSyDll8DQiOyGmO4AzHTLqJSVLDTa6FYyt1pmvK?=
 =?iso-8859-1?Q?kqysURcK1ajw+yfqMiSPc0wFLwf+OY8Gq2g23X8xY9mk90nMKDXkY7W2Al?=
 =?iso-8859-1?Q?07EHwCYnPAIY7bq9crqcC3chyTE1Ho7N0sG4hxaDDAfQmIsT+0zM4r9aJP?=
 =?iso-8859-1?Q?GxcdSiokXQe2sbXlTTQCmW4Beed47d0pGBQjnbwCPOthzwhdhQZhni39+L?=
 =?iso-8859-1?Q?yL9mIi/E1hgPJDvFvElm2ZsxvyPqdY4lS2AjkfjwyU4nEwVucPWZSDMkw7?=
 =?iso-8859-1?Q?r4dfFojzASJCyaYFrGU4hOfm+DKkIBA/BnyJidRrRlbfkOuA5EX0KNpJgb?=
 =?iso-8859-1?Q?XJGk5xurTb2Jqf3a3y3FjThPEHJsAaBNTix1ReUOsN23oX508R/U34wY5r?=
 =?iso-8859-1?Q?IM4Z+oFYmHYJ0RvI0ocEzYzNWlhlAIt4kzqQfmO26MqY8iYLfwRyl47Ty9?=
 =?iso-8859-1?Q?Jo3c04MAibq7WJwNvH1N0hrj1KH1G7KP+7vuzpJi/C8rRXDCKhDMMN1aAK?=
 =?iso-8859-1?Q?OVRDFSr5ldjLxw54xIoe4mAyIGsno940L5jk52RFFe+dh6uBclcdTLjmbu?=
 =?iso-8859-1?Q?yE5W3o+3QUofHm4R3FpgdFekntWOvNZSzLQr+FLyBPbmCW2nFSouvxHcZo?=
 =?iso-8859-1?Q?py/nwgaVehE42VeYFjK5mtfrzt1alZktpGMeR/WVQFrhB6y9qZq0PoSj2D?=
 =?iso-8859-1?Q?CRT5r4f7wyMjeE7+WQMASLN/c5GEGq2rPC1GoLvlQVJN/SCoolrdy8WcTl?=
 =?iso-8859-1?Q?RGAR3TJcl6ctR+qIWsPX4whW5hHnLv/vOLM3Yrn6j+BhMcgwFOZQCCR6Wk?=
 =?iso-8859-1?Q?GK+N14S+GpS/4lwyQ4OScHokoEANtkx7lRxFflS4cIXVHhdLf26/3qW8ND?=
 =?iso-8859-1?Q?8rREwc7se1U9C7fmXExQRtOrLC1PqWt6e0mPcD62/Hjv2T3+IfmPu7jDAH?=
 =?iso-8859-1?Q?1d9wxLWuDnu0eQ6T3PlFTmsV9g6XJMZYUzWdes7qHvpp3nd5IhBXtPwRDP?=
 =?iso-8859-1?Q?tu+LTJwguyqjDO2Bii99iMoP7FVyUa8DfnCJFCCOAGiul0zDH11wzoEttw?=
 =?iso-8859-1?Q?wYAngkUz2yH95BNRPv42nAFFkyBUP+1m6VQgATpnPoPFfTT8LidrzhOJDr?=
 =?iso-8859-1?Q?guow8OEFp7TKdeTlvhhnxoaCvanNAiR9tL2kxxPjLXrR7RuNjrSUeN926C?=
 =?iso-8859-1?Q?UqMqIujeGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y6YzaAJTFWpPKHyxXmgiq9v7lUtnhMbO5mL98oh6d5+kXpdj39baGzNWgABbQ1xT9YkPA4RNEIYa9W3FvJWxmx5ZwYom4+dfSqaRFiaMIDUg6CYECBLpAe4hAsviFhSOBvPy4jCVpNy29mVrBsWBrs2aVNZhc2QFjk+FfpLHOxP6OyTDUL7x+8lVUfOQsC8226UiuIccKc37K1GqITenfCH94a9brjySXwvW5sJDOovXqBpJuxX+jNWjm3dOHj2NFQq/DOBMdgDUnePFG8zAqOIAoQdpsT1Y9eUSt0XT6/rrLpdKN6qbBb/EQqRu5kdjth9UuPEGsDYxEGeEIDHFpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e65c06d-ffde-4a43-c1dc-08deb4bc93ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:05:15.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEdXRRunmDbDRXSAiDm8VYM0ynRf9FK7A+2pXVfxrhuEJma5PTgODPhRGWARxPf/JE2TrWWBuMmMettaFqY0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9D764569649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288945-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Wednesday, April 22, 2026 8:00 PM
> To: Kohei Enju <kohei@enjuk.jp>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Drewek, Wojciech <wojciech.drewek@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix UAF/NULL deref=
 when
> VSI rebuild and XDP attach race
> Importance: High
>=20
> On Sat, Apr 18, 2026 at 09:01:15AM +0000, Kohei Enju wrote:
> > ice_xdp_setup_prog() unconditionally hot-swaps xdp_prog when
> > ICE_VSI_REBUILD_PENDING is set. In the attach path, this can publish a
> > new rx_ring->xdp_prog before rx_ring->xdp_ring becomes valid while the
> > rebuild is pending. As a result, ice_clean_rx_irq() may dereference
> > rx_ring->xdp_ring too early.
> >
> > With high-volume RX packets, running these commands in parallel
> > triggered a KASAN splat [1].
> >  # ethtool --reset $DEV irq dma filter offload  # ip link set dev $DEV
> > xdp {obj $OBJ sec xdp,off}
> >
> > Fix this by rejecting XDP attach while rebuild is pending.
> > Keep XDP detach allowed in this window. Detach clears
> > rx_ring->xdp_prog, so the RX path will not attempt to access rx_ring-
> >xdp_ring.
> >
> > [1]
> > BUG: KASAN: slab-use-after-free in ice_napi_poll+0x3921/0x41a0 Read of
> > size 2 at addr ffff88812475b880 by task ksoftirqd/1/23 [...] Call
> > Trace:
> >  <TASK>
> >  ice_napi_poll+0x3921/0x41a0
> >  __napi_poll+0x98/0x520
> >  net_rx_action+0x8f2/0xfa0
> >  handle_softirqs+0x1cb/0x7f0
> > [...]
> >  </TASK>
> >
> > Allocated by task 7246:
> >  ice_prepare_xdp_rings+0x3de/0x12d0
> >  ice_xdp+0x61c/0xef0
> >  dev_xdp_install+0x3c4/0x840
> >  dev_xdp_attach+0x50a/0x10a0
> >  dev_change_xdp_fd+0x175/0x210
> > [...]
> >
> > Freed by task 7251:
> >  __rcu_free_sheaf_prepare+0x5f/0x230
> >  rcu_free_sheaf+0x1a/0xf0
> >  rcu_core+0x567/0x1d80
> >  handle_softirqs+0x1cb/0x7f0
> >
> > Fixes: 2504b8405768 ("ice: protect XDP configuration with a mutex")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> Sashiko has provided some feedback on this patch.
> However, I believe the issues it raises are not introduced by this patch =
and
> should not block progress of it.
> I'd like to ask if you could take a look over that feedback and see if an=
y follow-
> up is appropriate.
>=20
> Thanks!

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0



