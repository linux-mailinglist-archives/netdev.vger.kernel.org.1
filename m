Return-Path: <netdev+bounces-165867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D669A3391B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63363A4E7B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DA20ADCF;
	Thu, 13 Feb 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfHAfh8y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADDB20A5E5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432697; cv=fail; b=CT4yLCRo0GBBpfYAoExCwtn5WBUSyD8ukULOOuQfGK0GRQT7/sNG6axcrh6nvbBcUptqR/MwxwsoUdaGUlh2/RPB+u9dFp1JzNvRsjpepYqfS5PTXSCdqh+AvFuZtsyq7qGBYzHo+s1xdSYFLxZnLmtwYFUGVOOsVYsnCbPxQy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432697; c=relaxed/simple;
	bh=qNiybVCjRVkqxv7DB9yZPEO2RbRdgAbpgQhpo/lFsho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3PhLk4683jWdXbn8NlTS034hz8Qi9Q9MnrfQ0sVULknjCyIrlAlsRU+3NAcyhjdwJrSh/eAVkk3aQuQQNMBNlpHhqAThLt0pIqvyMMNkwUjc55Piv0cTeBCUcTzH0JjT8N8n/G67kiALUfQjth6mlJMt10kYzYKkiiV7tMy8fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfHAfh8y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739432695; x=1770968695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qNiybVCjRVkqxv7DB9yZPEO2RbRdgAbpgQhpo/lFsho=;
  b=kfHAfh8yamT++tr7TNSDucp2fJkO7FlSEx1WiASBBePm61gKohJ3Off7
   sPcgBIjfbX31onzd+yffTIUdPF8GIV1/3f5WGTvmIxeDbX/vrpdApPVuP
   7vASucjlFcRejIOf+1Co5DBUFXLn2PSNIxGmzdX3BrwoEvUR/5Yjz0bfC
   vnerY38zA2b7VNbuZmwCxgYNc7yY+qJmo24XwfGp/1qyY/0oCpfHUcSjr
   MLxsTw5bOOQHQptLZjO6T1Db9HBFVeCtPk4XDQSubuulCCh708xk1gHpw
   S0HirfH1QLGZrpnvjNaara5FqK15oVFs2AQnu4jxBlNVVXaU3iYfr4WFR
   g==;
X-CSE-ConnectionGUID: NMd2714kSmCj4WIkXXG7tg==
X-CSE-MsgGUID: t4YIcC/wSRuPSr+BoaNnRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="27715185"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="27715185"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:44:55 -0800
X-CSE-ConnectionGUID: mYcUpbIuSiKa0EpLBParaQ==
X-CSE-MsgGUID: Q6Gwqy7CSiWdy0I5NOwaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113723551"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 23:44:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 23:44:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 23:44:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:44:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgHnCqUNtG1uWdy1xu7pvyh/YCEX14phRCPXptTv3WehCCTjkuYXHzSndUA+PDAMp4qRw/HrUkhQz2s4ZZXvLbg1hH0jyp9VblFa91NQUW5z0Zgskkd1Bf5kQnSTPmjsJSokcwLmMHLr4/SoIaHBPTrvEGsQA4JCqiWPdn3nCvd/LOBCwT1Y1LXUcUe6bMZvVqMVxXzhrjWgddXASunMPOLZYlKm4hkXvhspxUAL+J6C/YCFsNUw6ZNvs5m7Rt9p62gaw7q8O1RgXLID0wNmZqwyj8YUYkZRku9Ox4yMpLtLbF7zI/eCTGIwDKtVrtlaYY7pOjNfeMT/2lSBgLs44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNiybVCjRVkqxv7DB9yZPEO2RbRdgAbpgQhpo/lFsho=;
 b=PpQ0siFdwrdXfjxdA5gKcIT3LUbzvCP4bxd/VcBveAmse89gkXFg6LDlkuFopCfDxWNUISWtS/ZMhynmpWOhy8z3ifq7JpVYoGByVpBfPm6gEI3AuLLaMFluVJqp0rfUu/zm2RWRSSz/72kvBDHwBs1hykXCP9AONoo8Ee2xnA1t659k0GqIzjR675AhWXJkPSpvjASMLzTIumJlv5mOfdyP67zma4HeKzqlQc9+al/w7pkbSrznYhiC0GdbHodK6KYTpLcVlxBhnnMLFJiJRLsl8XvPyk3WluwGrYAgvevwcFAUFfLBSp8U/PvjrKJn/xR7wCZb58NY3lbQrFObaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 07:44:51 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%6]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 07:44:51 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: add support for
 thermal sensor event reception
Thread-Index: AQHbe6oYUcw9MSBhO0m17sppypxQfrNAadMAgAACY5CAAAUqAIAAGSeAgAFUsACAAEieAIACtduw
Date: Thu, 13 Feb 2025 07:44:51 +0000
Message-ID: <DS0PR11MB778541E49C5BCF95AF41D27CF0FF2@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
 <87644679-1f6c-45f4-b9fd-eff1a5117b7b@molgen.mpg.de>
 <DS0PR11MB77854D8F8DEEE0A44BB0E17EF0F22@DS0PR11MB7785.namprd11.prod.outlook.com>
 <442420d6-3911-4956-95f1-c9b278d45cd6@molgen.mpg.de>
 <7085302f-af69-484a-8558-2aa823379fbe@lunn.ch>
 <DS0PR11MB77856580F83D80DE883C82F0F0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
 <f8c9cc3f-4cba-488b-9c93-c31b404f4d63@lunn.ch>
In-Reply-To: <f8c9cc3f-4cba-488b-9c93-c31b404f4d63@lunn.ch>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|SA1PR11MB8490:EE_
x-ms-office365-filtering-correlation-id: 2953b3b5-2dbb-4333-eb39-08dd4c024ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f+mxtv2hXfk5EBBfDHu5kuAsluCqXK+trgCK1SNqyVVEn/SyQx4hN9w+CHiu?=
 =?us-ascii?Q?7wAjMy8gYUgo4hVyb+eV9PPSF9McV/KzR17oSpS/0CwGZej5eR2MiNAL/36q?=
 =?us-ascii?Q?k28JmoNnDflXf3Zn3phrS3+SvBbtsUdqhzyHBj23rnnkqPYyVcLLZ30uSxQ+?=
 =?us-ascii?Q?FhLzgN3beiAMVdOefJPU8mYZB29OUc1VRFFiTkGYIhoMVV0QXODwX6hMV7QB?=
 =?us-ascii?Q?g8+XaJ9wWOurU51hN7gnLZeK7GUjIKjDc5juLIu0LpwoAnoMBUvjmMipaJpH?=
 =?us-ascii?Q?9C0m2q1QdfiFZ4gBEIgFxlsbJ05TERQ8JTgWZD0w/sw/knCk81AYmLQKGkTK?=
 =?us-ascii?Q?kC7amo5dngnEHwvmq6o/DxqDO3c5O+IEjUzmHKt227dMtF3h6CS4+EMwcbwN?=
 =?us-ascii?Q?GpLHrgbRjBNSreuYOsUBKRdbrXT8gkAzih4UuRUYtDJMlKasrDAPdlpj7gmP?=
 =?us-ascii?Q?GddbTPXozmcyrveHdq5G7bkFOx8xLOA1w6+KonwA4XmbAw5eYz3ArCcs2EUb?=
 =?us-ascii?Q?8VNJPu/XcrF5HBs9LiY5KKyuz2tUQsglcsCHEc6o09wv2SSuxV/24878xozE?=
 =?us-ascii?Q?vo8PrDWwribLHPQjMMnA01v9O3PMIyf0xbPailTvRc0P+2VDOmR1zDHkQpVA?=
 =?us-ascii?Q?6hSjg2HeLSdlxqvMi2ofqRQPiZkP0O+Ww2KC49BsMu8aoqww+SpHkEBVbXTi?=
 =?us-ascii?Q?4i13hpy2wU7Jk53BJ1+qOsvwjsw634g8M1Wm/nJAJn5CEyvHappZDHSG25CQ?=
 =?us-ascii?Q?Rj9RpJDY8uLM3KLGnSe8YU6ZOU/JnimWGy/6I+Bt8/KF8cEqRGcaQA0KmKqr?=
 =?us-ascii?Q?F+AyvN35YvfwteusOWjyOCS8C54p4Om09NWezlYEgyYL099YyuOb2iyqdxVn?=
 =?us-ascii?Q?8b3akcCpwl7Nm6RBkxi1+YDD8h9Y93wwE7HGDJDWIvnx+FjRcxgSiwkbZYA2?=
 =?us-ascii?Q?IZgZpZ8F0Jrh5115A4MwmG86jPVReH0d/nyzE0yMHeKZG7BP0lZMKzHoPZeR?=
 =?us-ascii?Q?6kZkJ1enI3LH8TsszRE5nSZJnf4Ge1mw6uxeAgaZ9zeJgix66ZUn9kYC+Zx1?=
 =?us-ascii?Q?BYjTPLBhLal2fTPIugo2/9jH8O1OAChGo+lUHdfOXfIxs8NsiqcbH6FC8Lks?=
 =?us-ascii?Q?pdHFZ8oVGdUuctmLfvFKJJ3MIv8izbZzXIzGBEu1SEmC8y/lFM0CdepFnWXQ?=
 =?us-ascii?Q?4iZ+L6mDW7CEkZAFCoI4KJk6iOAzVOoTg92ZMQDokbG4yUfwQKAZMmVPKcgn?=
 =?us-ascii?Q?1o5agfM0wWt6xu02ZshAz0OdCZK2XRUBWUKV7hB0yVGsGxRP8cH7PB1TFt1x?=
 =?us-ascii?Q?KfliWRGckssOrE4T0axnimd6IwEpExiJbUZOrwDUkFac1+jmM5P8uG3oxgBg?=
 =?us-ascii?Q?fKxls3U5pQMYDbeVq0PbQkdb1paMX2Roj0pjDNz8oWlZDURu5n4JLaRpZ6cS?=
 =?us-ascii?Q?0LHhjpmg8KgUHnLWSYHb3BWMcbmUd1iw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zKZkiXaaoiruoqCjTLjM1ZbZ78zYi2o40AAjmLBrjoqlrjyoMHGxKXCMZ/PS?=
 =?us-ascii?Q?hEhQlD7A7Cs+Tz5P4bUwvIxPgdfU1shNA9LE5G9v4WKiCh14Ucu2yGmAJhUl?=
 =?us-ascii?Q?4JcBI58IkyiaKv7RX1E4OYfZoROKe6Yfbk1rbq9h9Mwlp0tgkbBHcGge24m5?=
 =?us-ascii?Q?fs6wV2sqSuLmEDpR4NqbaM8P3XkGmhC4zjC5sZJcSMSw6hVNCKteigPL9e4q?=
 =?us-ascii?Q?+jPboBRbnDiZQIe/V6Oig4vW8jhJ8dxm7p+VigxkaCGY7qMogBzPT44pCo0B?=
 =?us-ascii?Q?+N3rgLid6VnXzdIC6Q45FMuvqDaFKdR6uGNokxkDtBmeel8I4frluz/7DqSQ?=
 =?us-ascii?Q?4M+jNAq+HA7cMFZlqndeGTcihDixhQclLOKH/u0fIvlKGsjArYntzEnWEtol?=
 =?us-ascii?Q?ZoHdzy6X4FvqkH1tdf7hBbXb+3mx7jFDfcf3xTBmtzdASPUsrTUggbixwJmm?=
 =?us-ascii?Q?G2MWptcIEfZ38Rb7lYE6wGNbiFTFFqC49FPSB6QNRM1WRBfNuy2Fi0YQpl9V?=
 =?us-ascii?Q?891T++gGmmi+ukDfjGUPsDYjpYo+bdUKAqNGpaEhfOm7SwtIEOEGptfsdV8x?=
 =?us-ascii?Q?sPqkOW3ZVwi9YZpv47BhGg1rieL592ndyy6Tg87YkpG2CfHWGp+T0u93owty?=
 =?us-ascii?Q?HXPR/NdB/L3bnIW8FCfZddxJ9rMFtlRx8+ZAS3Rtp/L/JjPmzPYbrjXRepU3?=
 =?us-ascii?Q?G9/IICzQxwnRaCB6RHtHyRj9Q/uMkKGf6m+XYJwvCOkBVVhJ+1aD5ydyDGrA?=
 =?us-ascii?Q?Pye6e7Ps/N6+xLQD8hZ+FP3CxZPZCXz4KHBMioVWyOiSIztvC/6X5OY6Kj2k?=
 =?us-ascii?Q?ZmNfpkhWTFbRPwA1+qbrqhsNnmAtXHSRET+vIXb30T+Mjqxg4gQ5bdEeNp/R?=
 =?us-ascii?Q?SP5B9NOQyjHiOSo6xaCx/Keh3OjdF7l0P/X0u2Nq+dMgTNmkO1+OBtAtkgF1?=
 =?us-ascii?Q?4VLjECW1HJ211CP8FVYE3liSUxWqWdtfg6rwxhPQJNg3RHgx7FeaYz0g7zhq?=
 =?us-ascii?Q?Qb+6RHGd3A31uGqZdxfc3LO1cpCkMsgn5yH9+8S0mOPQl4y7wIQqI/tNUEeT?=
 =?us-ascii?Q?VTvXZ1lp5Z5KW+1/I6EYVUa3hjzdTlEfFKNSkUfmk4MFxQvdQ/yfKfkrHSzo?=
 =?us-ascii?Q?ckXUxTgpgQLKUk4wgxKCJDaphQgaDJIO97KZyAz1j+cfzLdkfvR0X7WAOFWs?=
 =?us-ascii?Q?L/yUD//hCiWO/JB8x85quwmx4LXEG+ry+TNcFh0dxY3YpymUIeEEKopnSjH0?=
 =?us-ascii?Q?NZbaifNhVCoEUYCOrPk14X6fm0iq0mSSdTQRIwufSAHNISnmGb5QULvFP7D4?=
 =?us-ascii?Q?8qlNlyQLjXY298ltHJ/ia4UKyJP0DFYNxk1nRBAogMa7rbGetSLXyi5OQty8?=
 =?us-ascii?Q?9gPOiCRrHLdoynkjTAZ1JTdDr6D6UGWKHAkD9BVK7m6Ht6oo/zW8gw2qO2T/?=
 =?us-ascii?Q?YuW/CaJe2jG3pcnQJPFMVJDCYGafuIWy5DjCtgPKlm5z/6wHvKrAwdeHAzmH?=
 =?us-ascii?Q?rgg02iUth2PKYdDdB+yxpknrHlofC/uMRnl4j6hyI759Sn4xJtZpw97jlfix?=
 =?us-ascii?Q?hPPGL5Dt3wTu9Ni2cjv9bHKLwsWW8V4P8h2W1H6m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2953b3b5-2dbb-4333-eb39-08dd4c024ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:44:51.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r04i4ehL/oE4EbwKz4MkuoJnfbvUaBRnHRVjHHWtJ0foFSYCNRv/hHOmZ99UnyWdG2EwQawKKGfGLTp0lvT2BPcsGXTQb/LkGEKO7YAkUlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Tuesday, February 11, 2025 3:17 PM

>> Actually there is only one adapter across all portfolio of ixgbe adapter=
s
>> which supports this feature. That is 82599, none other supports it.
>> Even next generations (x540, x550) didn't provide support for reading th=
ermal
>> data sensor.
>> As E610 is some type of extending x550 it also follows this path at this=
 point.
>
>It is something you should consider. The machine disappears off the
>net for no obvious reason, and needs a cold boot to get it back? vs
>HWMON entries you can monitor, a warning when the critical value is
>reached, which probably reaches the network console and so gets logged
>somewhere, and then the emergency value which shuts down the NIC
>without any notification getting out of the box.
>
>Also, if there is temperature information, Linux can take an active
>part in managing it. If the critical value is reached, it could
>downshift to a lower link mode. Better to have a slower link than no
>link and a cold boot.
>
Yeah, definitely
But at this point there is no support from the device/FW itself, so
the approach presented here is the solution to give at least any info
to user, without device disappearing without any note.

Once there will be possibility to get FW temp data this will
be applied into already existing HWMON infrastructure.

Thanks
Jedrek

