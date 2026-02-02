Return-Path: <netdev+bounces-255775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMORAbtcgGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC69C9930
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C6E301487C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D27324B27;
	Mon,  2 Feb 2026 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLwZaGCS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7E3233E8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020004; cv=fail; b=DreVqqlOdCRT0z5vkv+F7dic2df6vObzzQ2yrV+ZLlibvIAztl0Iu3Zk0J6SLSntnGFUsr38qRQ1mqrJwjb8Zmhc1gl4lgodcXDj9sIA6d13y1P2+L4XZjEhs8p5OUx4p8PXD7GXb+gzaAiTgWd39lEsor8N21rLb9D/hzYddzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020004; c=relaxed/simple;
	bh=uHBBOFQtefn107Kd818TWinkddxeSBr6eIW/tkVTrYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoTY2Xi7g65F6nK8Mj42w3Q+HukNAjzW5Cb21X3jKW0lH4lxvV3ZKYo/WfzzKRY5uDQdoiLQF21+5/zx3xeXGec72NE+IO0adu43xLjgvsjN1Lm92bYnAZhLdz//XZOYXrrwKW8RX8in+Jf3ZaU5pKuxymzVRZtHADrxRt/41UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLwZaGCS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770020001; x=1801556001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uHBBOFQtefn107Kd818TWinkddxeSBr6eIW/tkVTrYo=;
  b=NLwZaGCSnhsO8dIAFMCI+UjVZVLXmHt8OMGXzzlWH1hzf72rDi+Vw6EU
   LFqtU5hcyoFcazN2J6fjdOjBIebdAk3FWkAGZeLtDrW9unNwlvszlgAbg
   5ZAmO/WNip3IyQkwfjs1AbYCfWiDOd2gj9RZ2w1qkppODWcYev0FOiDUf
   Fqbft8epzTs4I4tKU1dvtQi8dJiRpAxmG/amu/wpuhIzcWLHb9cwpu/J7
   o7SaV1fdDd8/l6mVaZ5EQIGPF/tghknhDeyqQqwpxrrDiO2sK/sJseaoR
   kUFKZX1eV+lS/4YUAwz5oxVeCoy8N61L5EwwG3gSax2pwqMfjMk8Ja0ps
   g==;
X-CSE-ConnectionGUID: IVAKKfhhT6OYarbBUGx2+A==
X-CSE-MsgGUID: dLbt1wk9QNKdNdeG/jDqkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81804398"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="81804398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 00:13:15 -0800
X-CSE-ConnectionGUID: imnkjHR/T7i8rVRT99DLKA==
X-CSE-MsgGUID: 54PJs17VSGq2UmG5eDjXeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="213988587"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 00:13:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 00:13:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 00:13:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 00:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7kXbBBTUtdxnLifhUJSb6bOkW0yBaFlM3AsmB+whHyQbLhFcyJLOP5ODO2ygY0fKsXWwbFBagRtCmPNYF6B+8+N+Dg9kqUsyoP+CWwJqA7I62umQRjhqlrcctGqEC3SAJSMZ6VFqUqoCCal+aLet2656L6beKAmgeXOyJ6rn9YH5v8N96RKQs+BkUb45Oc0RUSmFZneZQENJNS7EF+We4ZpWezd/0Om7x+GI9U6uJdf1zIzcsPRDeH/0CJlDVfzKy8buQh7vmz9CB2ZZ5Id79c7BBH2AFFcDsNfu+Ov2Lo8mf8UvMnH/Hk/K7AG++jR8FE7kK08UIq3iI6OCRGLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNLyGObJhs8O+c4i3amyEbt9urdw7hFpurp6s3mVlGw=;
 b=gdRKtYBZh7T8CJMsL+MmNyymKBLId7yhr3yzxHpqKteJTeKyTCgx+/b0WsezYPvEn7RvF2EdZaFNNw80sSP0ZYvTAbRM4QHegodfWkJxvXh/vg6KJPtkqrcmNo/tRN1fowNbSh4WpWAWbXKREIRNzvnYhZ6Cux//djB1jR88V25bMyuWN6rnYwCM6gIa1EmgzGMai4dRPqLQY6p+vUPy21m3EBIs9YcutemlKJ+I7SD19uvHVY0jpVYdooP9MOUbPHymnjEEv108lJXD/HVmSdh/j1h4mO3JtfzPgvI31FKZYs0J31vAX4hNMq4PP9q5dHkreFc3Q5I31ENeNRmutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV1PR11MB8818.namprd11.prod.outlook.com (2603:10b6:408:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 08:13:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 08:13:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, Simon Horman <horms@kernel.org>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when
 controlling PF is unavailable
Thread-Topic: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN when
 controlling PF is unavailable
Thread-Index: AQHck4WJ9IHX/hdvpk2qZG2eUgya67VvEG3A
Date: Mon, 2 Feb 2026 08:13:10 +0000
Message-ID: <IA3PR11MB898697BB2ABF14C9E714C700E59AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260201141430.131063-1-kohei@enjuk.jp>
In-Reply-To: <20260201141430.131063-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV1PR11MB8818:EE_
x-ms-office365-filtering-correlation-id: a4b36c8f-16cf-4841-0367-08de6232e7b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?SmlyqAIpODOVKDgaiJIIJ1pr15KYwM8P5mSTWP15dg+XHfYDecGDgBQVW0EM?=
 =?us-ascii?Q?ksSq+PtHxuI82w8YVzyq3ZWvMLYwSWKEKebBRbTw8Wf776ds1j9Zsq3GSnfV?=
 =?us-ascii?Q?HCwwOewK6cS7WV7ZnroE5MGpDjs+dAypSj7wTwzL/W9OHMr8KUrS+2t/rUhz?=
 =?us-ascii?Q?zWT7V3LCAwThTv1BxTq5yW4/73+sQgirsZWWswZjbFytGYsdo8kyeVcRxLeK?=
 =?us-ascii?Q?rlD1UG01aKgQJ3MO+1XAISoK8WbNrtkIl5L0P25pwt/3oxYj/N4hqvJmXnyd?=
 =?us-ascii?Q?CvboGg9AkXKCiRC9cL0slx+zYADx9pe0WhIUi9Hjsm3F4LtPmY38Ta0kDOrw?=
 =?us-ascii?Q?qSHyZ72VCC84wgKUZC63bfKTAiO0tY9sgELQ7wTLP6jTl0APgDrJeUJgwgkU?=
 =?us-ascii?Q?Gsi6eploWp+7ML/UsV647yD5w3wbQc8sycXQsZpKPqdczWXJpGJKVbXo5nKQ?=
 =?us-ascii?Q?U2sFyRH6W00k7H4fCNgbX8KWOnbQ8ZcViUH29HqCkmi5NUy2dV0zvjST4/CZ?=
 =?us-ascii?Q?aGLOTZvLdZfvfdI5rA03jPFkN5WwTueQ+Kcpg8p85kQGdDbesEmO9YwXTQ/+?=
 =?us-ascii?Q?t/+Iaq24osRl4Di8dkf5Afa4W17rlqZ26YFrKSL5QGQpQfQDWMLXMhFRpVf7?=
 =?us-ascii?Q?AtB9AF+YB+yjci3hAugtiJ41WmDJZ64U1WMKNHUMoQBXlwzgrzVNo8Ojpaew?=
 =?us-ascii?Q?QrI0XKgmuinH64LimVA48Y/246zCi1h/3mNs55kHbwiFY7BpWxfaCXyn9nuS?=
 =?us-ascii?Q?rBy/w5Wl8ww9iIdQk+kfNILabdW0mn57ELt7/RVV9yrjkusDWBirAKKNQsZZ?=
 =?us-ascii?Q?wQ55LigO3YOMEAL2qjKVdHzpp1e50Tlaj09BmiSAPLxuc1CQJeP1boqjFQu8?=
 =?us-ascii?Q?hpjVzyZrRr7l8m8Rg4bvgLIHIQxODLiVBaBi6hzJOieROoSS0DfQUrgto7jU?=
 =?us-ascii?Q?dlpEwxpa73w89pSQPG0Yg1NjlvxLJCD29zHAcPSXUZTpFFKMyWaUMn3+1H2f?=
 =?us-ascii?Q?jS7PXmifXrolq0MYU7wKLdcL+jrqQPKhLkKRHN1lFs8/ajKzBWK4SGQA/ybu?=
 =?us-ascii?Q?RG4ry/BjpjgjtnXzLoOHbVXi4pH7o4gDyE6bY4+RalYakLtA898oykOMApN7?=
 =?us-ascii?Q?8lWxRc7/d+KlJT76yoNOzxB7lg0Zixsgco+ETBRdDtLm83Uoh7/u2VqI/kHv?=
 =?us-ascii?Q?8KWQ8uMZT+wJgZYAjrGtS6Km2zFAklqQzNcSIOGAAYj3wLyF1k5XJynTP8zv?=
 =?us-ascii?Q?jAFZa/Hw1xgw8wgebCgU2oqc38YniVwziJf+CBs41LseVLEx+/IQhva21ht1?=
 =?us-ascii?Q?oYAC0XNnMG+5nVWy+zq139qHfO0gB1AFN/E/K2Xh2rf4a2YbQJWFg+kxOST7?=
 =?us-ascii?Q?T3LkT15oSH/E0tlaSiHqG6WsZzKA6ZoWWfZaf2DK13w1bDsdp6EvPSf/5LmZ?=
 =?us-ascii?Q?0R0YwKLipJeJM5Woni23whBjdeFulFvaBwFqBgIeobaVJiU7ljbgdXo+OB4O?=
 =?us-ascii?Q?6w2J//DM3aBsMWR+v6U7kHs1trYcrRHk1Ylij86E4D2YvTMhW3A3+H4csbU5?=
 =?us-ascii?Q?KzbnR53gkQacSMukhwlbaf4hVzS8Vn8rR7qhLFS11DkaCyrNC3NPGDj44swU?=
 =?us-ascii?Q?271Xw8xCFDbIoxXejPl9S3E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?onklteZqs8p369wA8gwjuuYfp9FcyherjcelwUWzay+9yZTBiSQGTFdNkeCm?=
 =?us-ascii?Q?vV3r6JDomfanvT4rEP5mtKrUF61k8DrCcpDcFKO0zR2IIDPpObxaMyiCk5ua?=
 =?us-ascii?Q?BDa/xxAQqQ0k7bXQc0roUU33kuQ2PugtUwRpRCTRGvIuK8ttyw6upkSdF+Wl?=
 =?us-ascii?Q?MTwIW7UQDum1wOjbCwHud6bZHGikAa//Tjf/nqadAOGyUMN6CZ14rFPYiipQ?=
 =?us-ascii?Q?9gAbsWZFKZ60x8oj4L9o1l8OpVAwtg7aQcZ02+IwiwiJRBV4KhP1PiN8KOLr?=
 =?us-ascii?Q?SWqiw1LUkDVHPRuemrCu+tGGz9+a+MKRAVG+0egAcr3Mqr1cDUABP1sIPN2Q?=
 =?us-ascii?Q?c2cSV0fU51T7bTnX3ZEckL+wpo9Bq+7XSHGuiLa+TlkbqNDDePrQc1k/YBy7?=
 =?us-ascii?Q?VKYPhSnYQmisOWHKMCr0khxlCYEDd6il+c77e7NlvROZNLn93tGX/082LJ+N?=
 =?us-ascii?Q?5kUO4Qmgwrxkw4dbjeQSqZ53sdpv+0W7xgekqzpn2zwvw6NZ0y/4r1yhYT4F?=
 =?us-ascii?Q?/kFuhh/NJ6BrUi8NMGSO05DBF7+g/1lLlX+qmwlzFCCtF0VyddbJxMZ4IADf?=
 =?us-ascii?Q?vMr2yfUole3TvRiZyKAg6T2IyEjPbpFVpxWB5aTp2/WY6ifsCdn4wV6m+OP4?=
 =?us-ascii?Q?ekzdKPgymxZ0OMJF/cxfNz3nNoNlZTPbgsiCSJJFaEMTWrmlSDb2wnqEI8td?=
 =?us-ascii?Q?HLZjYD60REo998tjLSBzRCdKK0gb0wql+TSj0f2NgH0oLS6Zz/kvg6d9Opea?=
 =?us-ascii?Q?UBYY6CNHkL6kl5schKyJpgRf2SXuH/Y1vdCc59L8C7Mh1gndlg8UN5IWRIfB?=
 =?us-ascii?Q?GF+h4qn8mW5iA8r77nWnkKP7iARYo5fV5WOQN8CwRY/JqT8voOtb8E+0Mnz1?=
 =?us-ascii?Q?Z6m7YFzQfUvKFCSJ6ZXiu0qMNE+q1onSA8YpRCxJngnbDrD5qDwz8dzEd/0r?=
 =?us-ascii?Q?XBOpqrgn2kVQcJXCZJTQRg7fp0uNkL3SAMD83bJOdHK6I8Rm4t+oBKWSR8L6?=
 =?us-ascii?Q?D8qVxI5srD5iqZ/muORe02907H8Io3x2L1r3enF8T39wtg8LxlPeeexkIRyE?=
 =?us-ascii?Q?6dzMKVw/R1NtcI4z6BoOaM7LhY/3KtyhILb4+gSyL5tGLs/qHPvSS9VYGyjT?=
 =?us-ascii?Q?WyMC/Ad5uQbyjmvdf0DR1zoRaXktpe06H4RT+J08rbQR76JxfZs3hhAoxQTb?=
 =?us-ascii?Q?e0+G2kA6TMB3QnM5tKyYpbMBbg1oekMsjIX5Xj6UzOc0uadM7cuqQ6wkHn9I?=
 =?us-ascii?Q?OJdQq7hf7mqO4ArRNgC5ll2BZLn2hxXxJgAV8Ktq3E7NU5BZrXkLfSdu5JMk?=
 =?us-ascii?Q?3pQyjIpz2ZqkIyjVHVpMcgmsteCWFYh59gaHe/1V+4L7YipyX1LiylVkD8WM?=
 =?us-ascii?Q?R8yuU5dfF60MnloxZkBZFOukH2kUbQJJg6r1DZdS7RLfroALd/E7NpShhTrg?=
 =?us-ascii?Q?/i0/kHK6z0EyPvz5N9NmwDjpxrPuUNP5DTOe5Yzz9abMldgE4Uab9HS7Xss7?=
 =?us-ascii?Q?Fv17YzMSId/AXBWWr8NiYzHPCu2gunpbOs0nSN529Tmx1E9VPt587frSYti7?=
 =?us-ascii?Q?jQgnA3QQfwXRdqSQkvMS9e2+bX0dBefySL9oEpcEpcWwNIH6tQKlNp6LkoZC?=
 =?us-ascii?Q?fNEIt/lZpqnhAWhFU5T3BP4UP5XZcWfK3RvuB8uknVBZMMQQTj/201qgYzB1?=
 =?us-ascii?Q?BHhfM5T3gd/qGc8PJUnAPcU6Zl7y/pNC/LU2K8KBogw8yHKKaSrGkSc93uYq?=
 =?us-ascii?Q?v9w3t3EGcg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b36c8f-16cf-4841-0367-08de6232e7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 08:13:10.8407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjO4FOEAqgupl+RcQx0XlOLu+pyDCdCT7AX/3AT/5JAC3EkoYzpGe5pWgGu9u0ZF3IcHONfDLicfL+MaP3brxHjmkC80oOD3wD2otmqDLu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8818
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255775-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,enjuk.jp:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6EC69C9930
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Sunday, February 1, 2026 3:14 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; Simon Horman
> <horms@kernel.org>; kohei.enju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH v1 iwl-net] ice: ptp: don't WARN
> when controlling PF is unavailable
>=20
> In VFIO passthrough setups, it is possible to pass through only a PF
> which doesn't own the source timer. In that case the PTP controlling
> PF
> (adapter->ctrl_pf) is never initialized in the VM, so
> ice_get_ctrl_ptp() returns NULL and triggers WARN_ON() in
> ice_ptp_setup_pf().
>=20
> Since this is an expected behavior in that configuration, replace
> WARN_ON() with an informational message and return -EOPNOTSUPP.
>=20
> Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead
> of auxdev")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 272683001476..082313023024 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3048,7 +3048,13 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>  	struct ice_ptp *ctrl_ptp =3D ice_get_ctrl_ptp(pf);
>  	struct ice_ptp *ptp =3D &pf->ptp;
>=20
> -	if (WARN_ON(!ctrl_ptp) || pf->hw.mac_type =3D=3D ICE_MAC_UNKNOWN)
> +	if (!ctrl_ptp) {
> +		dev_info(ice_pf_to_dev(pf),
> +			 "PTP unavailable: no controlling PF\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pf->hw.mac_type =3D=3D ICE_MAC_UNKNOWN)
>  		return -ENODEV;
>=20
>  	INIT_LIST_HEAD(&ptp->port.list_node);
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

