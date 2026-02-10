Return-Path: <netdev+bounces-258062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPZ9CZsXi2ljPgAAu9opvQ
	(envelope-from <netdev+bounces-258062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:33:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADB11A452
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F73303B4EF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D9319852;
	Tue, 10 Feb 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nncU744a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559A3195E8;
	Tue, 10 Feb 2026 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723219; cv=fail; b=gyybfPG+X6ZLhyLvkneF0I1INil9elzH9hUdho6EI5GD+b5XpoO+JJZncUfNE5b+O8PM5QfQ8Vw8bSQageNpwZJbkDzPag3Yvx7vrk4/GGi8sRwvyiz5QRyw/EEXqveXUkOq9l7ZIGcWJJM45Aj+PThjDTSFZvQgetAcEaoM9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723219; c=relaxed/simple;
	bh=cyj3N5KVV0w9fbIlR+oXXz1htTGoXgiKSZuSfVvQvKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcvR0IBZze/NwCSR6Rw4vGsTdg+i/wJe92lmTrIf3I+e8oQrIIRe56kCRevlDBXhxWoGJhUvw3p91cLppMQMW2ZsEIPUjEXwN3+X5szouwsMAq3RAqurHOiQKPVrPEQ/oSpoVvMTL9xFuAMNoABJSFn8xqjvPHsqaIWt/3PltWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nncU744a; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770723218; x=1802259218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cyj3N5KVV0w9fbIlR+oXXz1htTGoXgiKSZuSfVvQvKw=;
  b=nncU744ap/E1MPfB5Q6WwAMHbicZlLxnzJHccR4j4MN/IXic9kt1pYFS
   F9TwYzm6S5n8bQVLRRLadcl0ja8yh2RzajaVif3VyUNRd5eGLBlZ01O4q
   ewgkHJzU9bI5rTolwsyQIdt3SH7Rm0Y2l7V1Wp0Zr0Zi0Xqeqf96ok5iR
   xIxdTNNRdIxZqC5N8yck5NR7JM9f9MZvW82XPjl2Ro5RgKJAYtdFV0Ca2
   0da2WNXLgy68d2vg+wCSSzGuGBFoLm4Y2+bD6Ia4d9Q+YJQ3n7WpRKgEn
   ipukXGmhaaMIYt+x5cU3UePrmhIkgBEsCUG9GTn+ynDz8x84gLB6W1Q2A
   Q==;
X-CSE-ConnectionGUID: 02H0KCBPSi6E8ZvxyBK18w==
X-CSE-MsgGUID: Fl2hXFzLQ2eC7sFVJfLo7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="59415865"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59415865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 03:33:36 -0800
X-CSE-ConnectionGUID: S1CHZQ1VRiu4AIBmx9/hcg==
X-CSE-MsgGUID: eI9skxf9RKaO+smtmKDkqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="210974400"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 03:33:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 03:33:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 03:33:36 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.44)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 03:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfBmhj7KmqKG1cxbXiDvZbQWw+Cpwcgk1CBCTNCqAMJqTfIjm9DXnPGpIB8n0cYBLIJgkbGqm3IGz1PbtazggqdeSV3KCMu8ra7gAlca+Oln1b3eTsFyHtKFlSQRjV/hIsW5gJ1I+Lq4ecpag+Ubrirs0x/xiAMxlfgwFMrXZ29FSC1nKNFZwV+ws9jeiSFg+XhCROcYRsV9UTVGLMDr9wKxrYJQ+mEC66h27mbo6rX+O4WHhDwS+gYufOcNhxSawVtPlT7GT/O619hFD2X9AyhDU/cLkPHA3RSVdJMFImz1RVPzbwa4umtfiQ1bstLnvSpgfDw3PC3stPXvoNiJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z16JSBXIJqbTvfgjaqyzVj/58PPxumQKtLWkf3na3LI=;
 b=mP33c9VFqEWqJQwlY0LDgOuCBzYYdUdzpfGeYzkyx2o5B6o99EH0Js++aGb56HMPP4gEsdjWCrDgC1y+O4dYq5MOc0FL6STx3359Iv/kUjhyxjUBhQYpfLLXhFHpGs/bz9CKrDeM6ZJ+yrHNSs2ZrY0CzvlNTmrRy1RRoPbf20673rxSsHtfgSrcnfoAa7Qw8AFhLdYqb74By3g29+5odGPU8FqYjWtrUgVh7GQy16JMDDdyujmj8oCVnITurPujr+d1TBTAaVrhGxlxHXVo7Pqn6hMtxDuTTNyeCTiBTRsW85ldcPVn555PVpWicbC4ydRYJMaxDJQ+UdYDoLKS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 11:33:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 11:33:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, open list
	<linux-kernel@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ice: dpll: fix rclk pin state
 get and misplaced header macros
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ice: dpll: fix rclk pin state
 get and misplaced header macros
Thread-Index: AQHcmnofHNzMvEmWqEyTOrF6mfbg0bV7zR1g
Date: Tue, 10 Feb 2026 11:33:27 +0000
Message-ID: <IA3PR11MB8986ACB5E997DF945710253CE562A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260210104259.121729-1-ivecera@redhat.com>
In-Reply-To: <20260210104259.121729-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: b1f45d1c-ef75-4748-65c2-08de6898357b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eAjznVDg827OXjtpGiBxMKWw34vDbqobpG3Llt7kSz7A5flAiSFn/4fVAzPk?=
 =?us-ascii?Q?YFyKxxy+zZm5wQVHcakASI0c2hF+zBZ7rQxft6heDITiHry4DMfSfuhnq4JI?=
 =?us-ascii?Q?GpT4YbbHo1U8BygBY8yiNn4F+/saXMLgDRcnqSvz91wdKYwLmXvokssJbmFp?=
 =?us-ascii?Q?xpcj9WeymBD3sxvWY45cN3QHrutZqrEbNAKcbjhALQ2mOzI3Y1mjsqmwIUEO?=
 =?us-ascii?Q?jfRZN/XFRoSkBJhrvXI7IQeqeMfAhJdf2ZGtcCCTu6MIbiEa0mWNzX5Jlq4R?=
 =?us-ascii?Q?TOiKC7Br82fiCWqgJ3SZWXA3w2B7RjpseVCUl8J5rP6X9FYqQlLbjnOStt/d?=
 =?us-ascii?Q?4eHsOnFcH7kBMsuWtYaFp76wjUkK+9FHBDy1Zg+PWirAgHk+Ss4+VR+Fgxib?=
 =?us-ascii?Q?eUjflkCvFIgPdU8wmekkPgD7+EoO+QzrxBHWIVdHzzurX/gRafED/mSYqxFf?=
 =?us-ascii?Q?yTY2NM8Dwy1KU1saW+vHDpIiCg1el/9dcHtcUDmg5g1l6ozrxtuN+g/fWCGu?=
 =?us-ascii?Q?ffdqOcveCO7W1s+Pqqu5y+/L02/E/erRapXAbw51FtfsQh/DPRaHRMIrw+8k?=
 =?us-ascii?Q?7rh+S/VnIhtbtoZuGPzC5p2kz/Q7wmXv1NIPuA9aFrYwv05QGP2qfvX+y+/J?=
 =?us-ascii?Q?lgUa5aL+bLA/I/du8I1F6k2PDyHxOsJvNpnhLGb3xIpU6B496JKGq8QCaA8g?=
 =?us-ascii?Q?Y6oW+pVRQypK6QiYWAYc21VVizbihWuwQpoJgDHKU5WKIyyOyIBPv2U3MPfA?=
 =?us-ascii?Q?rf8AdssT1Ia5yd0HzRC/HDGf566MM5ghPkHxW+K6tW2UGsy8cwwweGfREqAB?=
 =?us-ascii?Q?iJdXEDmUwkV1Uh/aMerm+4jYTq8kdZJp+zlbDpFKoWXvsN1rtb0PYmQym5MS?=
 =?us-ascii?Q?y5+a2eUnXcFkZLZUeIvpScCW/2smugGW/rIhCd0jx/R44x/Ck69uIXSBqgJo?=
 =?us-ascii?Q?qULNTyTEvcYQO3TnMuYYrCzy/etPi+opR8i/NF1DklJGcBfKfzjqcuKC7c14?=
 =?us-ascii?Q?eESU7tHPfOj/OfrcX7GVLUrYOCAJ1+q/shw7HSlbMO7XwuTkhRqRaTwwGgqS?=
 =?us-ascii?Q?fGhZ9T6j7CpBnUwlmhvjE9ucm33bVY3Y8YFn4rX9UU+NznmCjG1eVGrSwETy?=
 =?us-ascii?Q?XoDjD/njo/2lclGpeshNGck9pQXZ+kK9Tok+PnpwxKLslle6IBy1wAUqOcef?=
 =?us-ascii?Q?XOnZXdUi1Fm2E66UuCSLHAd1eNdWaWQDoxkK3wRdXxcCTclgYaCJsIq7Eayg?=
 =?us-ascii?Q?ezkUwTtRqao3oAuTkauhgjkW5IshE2CWJZ4H2rTU3vsvKGtKxqhbCJgG2ASB?=
 =?us-ascii?Q?ixA6K8NKIquwPY1bOdCXWlYlQfMNi0gMb8Ur1T7EgJnxnG0mRjk0v4POLOox?=
 =?us-ascii?Q?HOYKME9Ex9lHnMTBrRqKvih2Xv97WDn9N//vn5u8/nTQoD/4FPyG/BRESwxS?=
 =?us-ascii?Q?wMgr5W9jqMwcjAFcsX4MzkZPww2BMKPPpubFchblSpcoNpVkk15lb/vEUr2b?=
 =?us-ascii?Q?jeRzEFoPhiiMSlh0ZE3Ud6rSaZrT1teP0WwwE3i05eVTBzcnFWtNQ4eW5qbp?=
 =?us-ascii?Q?Lb0hBiasupj8IPZXiq1WuSU64yodsWUrtmcDFS4rUNy9ETUxJ1P4Zr6WlsHH?=
 =?us-ascii?Q?oVoPpGnOJBkkeqhPlgRLfdQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NE1DLQYgKfitdxPcKADynYhHXpSFxJ0nxgrb0FHvy/1d7eUwtu0IaPJdAzQR?=
 =?us-ascii?Q?V9MzEQaUs2PUCY80hK1edUsViq9Lc2/dv4HHhUBbGQ2BaWST1Vx666sr2j15?=
 =?us-ascii?Q?kZRnssS7X5uPImrMGdnzcgyi73FOXHJw6HcfFM8f7jukHh5K3HclvObTjz8X?=
 =?us-ascii?Q?vCmgsHZrHa71/xBJFmD/5lMKIIGGqiEcYZc7KrsL+dNeH/qtmxcO8rb0Fo8H?=
 =?us-ascii?Q?d8ttIYl9eZh1uoS0pY7e1uENhQbVwtY5aedE1oZlTw7DEMlTs0nTy0Aashwp?=
 =?us-ascii?Q?iAEDbBzUDxWOQ2nMM0htlnkIx2ETSqUHk2YU/qrJT4UDDXkH1vw23SyQysrx?=
 =?us-ascii?Q?4aDlfhCEV1625/n+XwtmVq5gb+k9MC4OU06auHoSUubOHEgc8J+7ixDYkdMV?=
 =?us-ascii?Q?JwJ8Dx6By79Gh5vo7whVR7C3DBe+yYLhsfQrRAOclIwEcxD9nJvQmIN1nP9v?=
 =?us-ascii?Q?v5eKV9sTjgGpxhbnR31L75oMjsW1xjGteAiSnhWYxfII4wDYagBsmn94sMNg?=
 =?us-ascii?Q?zcJ1k0iqMzZX+VIzwpKDEWh/PRq9rpgqD8jP8XKJQBe1I8gWgwpXkuyWvIOq?=
 =?us-ascii?Q?utxr632AfRnwXKRPtEptz48kKEjulK2swy/8nQi6ehBhiD69ovOyMa/RAd2P?=
 =?us-ascii?Q?uvBUVYCuSiILM551lFmazdGletwwSY5T3CgkT9jv78eEaL3/JEtiLG4MZi9R?=
 =?us-ascii?Q?igHh5bWEavHKmXLl9xQT9nzXXWYdnP1vLry/s+j3caXH/LOjjGqtQ8Rl57Vq?=
 =?us-ascii?Q?k4njTxxxH1Kdxqvg19RBYCnMm2a4eud/ChftoAPocPsDB+R8QZQ4mP73mkAy?=
 =?us-ascii?Q?Ksm1solGk3fOYwAKiEDws1O66fHz/3J+JIDUsIcCAelgSgjZibFl61p8fJ+7?=
 =?us-ascii?Q?M5AXUzO3WzzI2zuihYn1voEBdzPSCRmoMGTnXA+M5BMODDF7oY8982oVzuFs?=
 =?us-ascii?Q?TTNpEjY3oF8Cs/26mZ1hLMtuWaYzxOcuZiaPPx3X9HjMB/0hcPJVXXS53bYb?=
 =?us-ascii?Q?6OimQY4vC3jRnHnPeOfDH3vrTuhRfnguBTkgkPXMcZ4EeJ4ul9llks2Mq4Nb?=
 =?us-ascii?Q?pIdAhYluShFs6a0dIw/9TbE67P6ED0AcISuwnOYe4pFtP0qNTPdUV282mWmf?=
 =?us-ascii?Q?jD3ZpWQWXBzHPTNaWwinXd74s5K6sP7g64G1znHUqocRn5/ko07rmrEd3z7H?=
 =?us-ascii?Q?Ogh5cGYmxJwraDx85gwktA9DZueBYXnFK1jdSH/khR6kERin+KfJr+A3KlAu?=
 =?us-ascii?Q?dlwMOqN0pV7lI2iDmmDcSelp7byWy3dVse7XSy1P/pKLIUt/I6qWlxUikfLY?=
 =?us-ascii?Q?BXoeesyMRj5aWB3Xb/1GbY0xZv0VYEq113DYbstfFoVmoIjNbVIY5n9B+WO2?=
 =?us-ascii?Q?y+Rz32epz0Bj2L39MQRVOT6LHuzmJcTKz9nu9WXWM5Q7qgCDoTCgtti1N75/?=
 =?us-ascii?Q?R6fIT3y6lw9J9FGUSlbwNUDUAlIsuQmAwkaiZwYtLKVXYuEc4DJJwTL0+K8E?=
 =?us-ascii?Q?1gKOj/gYhOX4bCi0xqYFXuXPvmrUXOoVuAikMeI1J1YE7xyrbf+mnAkRMDqo?=
 =?us-ascii?Q?KY7n4Hn33cB2zJlD1ltGqUOFAqq5/TO1yTEIS8umWutTa/oNcNRAiE9MIvag?=
 =?us-ascii?Q?S9XHOaVO3w0FQAcFVKT9f1ELVb2QevFzqsO57Hv6lFVRhyKZPH7MQ/vUTjdt?=
 =?us-ascii?Q?3CnNrN2FYiIrtSXNBSlDoP3oRQ9wDKmpUmExs7fH+QPy1f5pgStn+xWkmHgW?=
 =?us-ascii?Q?zy9Yepcm+fcShcLJ/vOW+ePRSvNiArE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f45d1c-ef75-4748-65c2-08de6898357b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 11:33:27.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doE9bMUK3lmiIoog5O7xH5EOTMkN0un58u7f2nrEVPvzsQg4O6MHRzQgDIz5ZdFA/RAvgPX4we4ClTSOi3OYC2qvOAMHPu3PoDW6PDm5hAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5CADB11A452
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Ivan Vecera
> Sent: Tuesday, February 10, 2026 11:43 AM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; open list
> <linux-kernel@vger.kernel.org>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; moderated list:INTEL ETHERNET DRIVERS
> <intel-wired-lan@lists.osuosl.org>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next] ice: dpll: fix rclk pin
> state get and misplaced header macros
>=20
> Fix two issues introduced in commit ad1df4f2d591 ("ice: dpll: Support
> E825-C SyncE and dynamic pin discovery"):
>=20
> * The refactoring of ice_dpll_rclk_state_on_pin_get() to use
>   ice_dpll_pin_get_parent_idx() omitted the base_rclk_idx adjustment
>   that was correctly added in the ice_dpll_rclk_state_on_pin_set()
> path.
>   This breaks E810 devices where base_rclk_idx is non-zero, causing
>   the wrong hardware index to be used for pin state lookup and
> incorrect
>   recovered clock state to be reported via the DPLL subsystem. E825C
> is
>   unaffected as its base_rclk_idx is 0.
>=20
> * Add bounds check against ICE_DPLL_RCLK_NUM_MAX on hw_idx after the
>   base_rclk_idx subtraction in both
> ice_dpll_rclk_state_on_pin_{get,set}()
>   to prevent out-of-bounds access on the pin state array.
>=20
> * The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related
> field
>   masks) were placed after the #endif of the _ICE_DPLL_H_ include
> guard,
>   leaving them unprotected. Move them inside the guard.
>=20
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin
> discovery")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c |  5 ++++
> drivers/net/ethernet/intel/ice/ice_dpll.h | 32 +++++++++++------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index baf02512d041a..73a4e28ed75fc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2440,6 +2440,8 @@ ice_dpll_rclk_state_on_pin_set(const struct
> dpll_pin *pin, void *pin_priv,
>  	if (hw_idx < 0)
>  		goto unlock;
>  	hw_idx -=3D pf->dplls.base_rclk_idx;
> +	if (hw_idx >=3D ICE_DPLL_RCLK_NUM_MAX)
> +		goto unlock;
>=20
>  	if ((enable && p->state[hw_idx] =3D=3D DPLL_PIN_STATE_CONNECTED) ||
>  	    (!enable && p->state[hw_idx] =3D=3D
> DPLL_PIN_STATE_DISCONNECTED)) { @@ -2503,6 +2505,9 @@
> ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void
> *pin_priv,
>  	hw_idx =3D ice_dpll_pin_get_parent_idx(p, parent_pin);
>  	if (hw_idx < 0)
>  		goto unlock;
> +	hw_idx -=3D pf->dplls.base_rclk_idx;
> +	if (hw_idx >=3D ICE_DPLL_RCLK_NUM_MAX)
> +		goto unlock;
>=20
>  	ret =3D ice_dpll_pin_state_update(pf, p,
> ICE_DPLL_PIN_TYPE_RCLK_INPUT,
>  					extack);
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
> b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index ae42cdea0ee14..8678575359b92 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -8,6 +8,22 @@
>=20
>  #define ICE_DPLL_RCLK_NUM_MAX	4
>=20
> +#define ICE_CGU_R10			0x28
> +#define ICE_CGU_R10_SYNCE_CLKO_SEL	GENMASK(8, 5)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_M1	GENMASK(13, 9)
> +#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD	BIT(14)
> +#define ICE_CGU_R10_SYNCE_DCK_RST	BIT(15)
> +#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL	GENMASK(18, 16)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_M1	GENMASK(23, 19)
> +#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD	BIT(24)
> +#define ICE_CGU_R10_SYNCE_DCK2_RST	BIT(25)
> +#define ICE_CGU_R10_SYNCE_S_REF_CLK	GENMASK(31, 27)
> +
> +#define ICE_CGU_R11			0x2C
> +#define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
> +
> +#define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
> +
>  /**
>   * enum ice_dpll_pin_sw - enumerate ice software pin indices:
>   * @ICE_DPLL_PIN_SW_1_IDX: index of first SW pin @@ -157,19 +173,3 @@
> static inline void ice_dpll_deinit(struct ice_pf *pf) { }  #endif
>=20
>  #endif
> -
> -#define ICE_CGU_R10				0x28
> -#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
> -#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
> -#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
> -#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
> -#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
> -#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
> -#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
> -#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
> -#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
> -
> -#define ICE_CGU_R11				0x2C
> -#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
> -
> -#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

