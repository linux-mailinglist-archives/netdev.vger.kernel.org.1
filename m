Return-Path: <netdev+bounces-302756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lw/ZGO6uQmqq/gkAu9opvQ
	(envelope-from <netdev+bounces-302756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:44:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E06DDD7E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:44:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=VSxyeUn9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302756-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302756-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5291030872E9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745644B663;
	Mon, 29 Jun 2026 17:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A6419311
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:29:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754149; cv=fail; b=LBaQQO0mUtaJT1ddAOK4Doa+2Tl08+GJCO8wyyqD8qB+UQ7s26aDTbxa3foh4QaOk6M0g3sq2OJEEIqO28qYNg3CStWre1LIrG1tB4l7QF8uTKnu0yI1HP8DEeDplg4IxE6LJcQtx84H4eFOwgypaUSNm3tZya3x8aqVMGTU5Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754149; c=relaxed/simple;
	bh=O1I55rcdQFknwxxKeHwKBq+xIjrz8HBSnSIbHGjU9G4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRcEK9TKRHvM3OJYf1VLCISTRcZ8bt/utErkDw23f4cyT0KkTlhp5nMG/S20tVfKYg+wYx35jzhknttJ063BcBggo3ZQVf0Bfh/JUlYzotrcWxin0phrsDKN80U061QhCqn9K0W364tBU8ag1M+NdPS8nW7s0GhEqdMzqpqXAVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSxyeUn9; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782754147; x=1814290147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O1I55rcdQFknwxxKeHwKBq+xIjrz8HBSnSIbHGjU9G4=;
  b=VSxyeUn97SBum2frHmyEs0PZ6X9y2nCr6pfeC6ix5SCJ91zWfwpDYL45
   0NM2Sxn/EBdsVi0gpZFPHmh6COigeYk7TJhjFqiDvAGQlQpVJKanGhCN2
   h0kqyWENOmirc4uJGXX5azMBZi/jZiugbr3iB66YARPr2yuxVbVnlFQwy
   vnKBc3OeCZAg8cxJjNNIvtrXAzQ4UAKkloAz/cOLt27IuTf3vyTCoX/4g
   T14DPyw+dlW3TOW0RaZuVxuuStyI8CVfDScWCycJOV5JHjb0fUWho/D09
   LlZ3calzhqQqvFJC7t/6P7hhJd+KivTeTzrdEdMVIV7iNq1oPDx7WgS+a
   g==;
X-CSE-ConnectionGUID: MJB+BUYFSQWhcK2PyXdk8g==
X-CSE-MsgGUID: 4Xa1j6u1Q4ywCyruzk2GPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106249496"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="106249496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:29:07 -0700
X-CSE-ConnectionGUID: dy1obXMaQpaiU7kp24eE0A==
X-CSE-MsgGUID: h9NczbrjSLOcELlESt7y2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250958933"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:29:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 10:29:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 10:29:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 10:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSvBzQv0ebyMfVaT5xNJgr/AbMLIk4as9mMzz5qWYzDcdFgKvFbJ5ZdWMTIgq8RWp7pKcfF3h7KzYDNGR6TLVDBUnjaxjuMJz1XOdDCX/BGppp6xI+1XLUSNdcaNtzrjUmf1SPX1w2EmvqgCwwclj/prSMbjSjv5bvrq9A4oRbVk1AdtLwAmDZS7mF1WSU6dFEkgVU8xO41T2zdtAFsFoJ2RWgr65fEqUdxG2sKSjEcydJrFk2cEtdqy37J0gKYJTfxeQ53yo49ocdGQ7YkPU4SuRwNXkqFnysl/a7aVv04LmUCx+Sbol7MWtgyc6FgqqTQAg3sKhOvEEks2dvuSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1I55rcdQFknwxxKeHwKBq+xIjrz8HBSnSIbHGjU9G4=;
 b=FaGMIRHxOx3TTv6Cidq00rVAnJOGQ9DLymXGQwrgF61cgtlj9N0lr48mDsyqVJYJ2gHQPNV9dBiq8T9Rh8YvesBdeiLgzKogGoZEVdBk87eKqMtentZ8HdZkwhnvgUEPqMowNz2/+TDPBIVhYb4z32ubuvjaU5usnfo3A0VOjlwFWQZ97LHzPeKG8MFD60ZTh9md9VcxTGTXfYmq/mwpAeltHSRN+vJiTHuw5dw+eQNsA0UpiWe2IsWFQXjgLk3USgaORdEF0ZxMi+xUs0Gg6tCW9wYhFBQ71S9/QRoNNsoyverL6xYzFM/huMyrxk4Hm9i/8e/Gfti0SGhn0txrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Mon, 29 Jun
 2026 17:29:03 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 17:29:03 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Michal Kubecek
	<mkubecek@suse.cz>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Das,
 Shubham" <shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, Niklas Damberg
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: RE: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQACWbSAAAchFbAAAMJTgAAAOH5gAIQ6zYAAAe+HAAAFwfUAAAihfaA=
Date: Mon, 29 Jun 2026 17:29:03 +0000
Message-ID: <SN7PR11MB69009867F1598517AC0557E29AE82@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
 <SN7PR11MB6900D73E1714AA8AE05BA7BF9AE82@SN7PR11MB6900.namprd11.prod.outlook.com>
 <deee3864-69dd-4eb5-bcfc-4ab771f4530c@lunn.ch>
In-Reply-To: <deee3864-69dd-4eb5-bcfc-4ab771f4530c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: bdaba0c4-920a-4f2a-e386-08ded603e9e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|11063799006|56012099006|4143699003|18002099003;
x-microsoft-antispam-message-info: 1OpBgFyamUZJ1rAIpJAGo9bskQT+SdskDKuPHAB6MjWNAyPUYu4JpawDJ+95alR2+GMWXPiWYuggExqeOv46nTM2j53MnfIfclZyNWfGBczR/pe5eEVsy/XOZ6NxgxF4JlPbVigpFr7gm/T2ZCiKKdrpxsNwyx74XiwM4gmfbyWIWDqAbgA8AIVyM4XEAtKOCJ2AKzLEfcoHUAWf156WYlT2ZgVbOD5J2jUiT9soVjZiIN/jSs8eWL0/A+gxyFakNfS5OUqvv4m3gw0UXiz9COc+2S6SUVpssD0ZtL3PNct33AEeClXGQtyXBTXmpqG5SrH7Eu8EMSrumwUikF1DvD6C0kpOr7mhrdDq75jMHtKI9Y92HekZA7Ueq4bvPcrbFiLod2h5Nf8C9XxtIwrMi98yT7tCPJHuMqszJYqIM5JtAwk67wF87ynnYwQ2IiD8bSR3l+cfrAAgUk2M8Y7d5CJlSNDDIR59i09QKe3B1xRdMoZw8Esr1+tSQN++/AVa9z35UGMrlssrtNQe2lRkJajQvfXmVh2IkxGV0JWfX2TH/VzoVVpiG4C47VsDlf4sdUKIhLha/RNv8VuBCJXmSNAUFFNLIDamm2wUdmbvNF4dmNWjavY6+Ett2iDoqHlEyC7iEiJwoyi5rSpK2ekFljnoTnDJUnLzzzzQOelfTKAVfMkqDGHiOGqP0J26tVAy7LGEdY/E7CtXqRLXgzdqZtfB8Ua69QIxvka4iVCuqDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3hmbm3F7cE6fQ4l3qK4xn/kT4njyuLg7/gzYA63p/hBYLm0FAN+lI//49jN?=
 =?us-ascii?Q?oxG/cusPOqVFobUUDfEnNo9flND9IRsmGprckZgnn8eLx5vC+6kjPSuFqzpN?=
 =?us-ascii?Q?wtzgZ6d72t+0pHLDvB6KJUzX5vNdh0LqiQdnwfXud6BAX0Y0F5R2/nkCN1lj?=
 =?us-ascii?Q?zPPFoU77KYisEZSAY6h5TeMVflNoKoBlHSOm6b7SSSHy51VH3LF7H/ccOJSr?=
 =?us-ascii?Q?BMq+oAoQJ0a6xhmiJcQQJoIXic/s8/JOs7a9bwt8JLRKQNaKi6VdrqJukLD9?=
 =?us-ascii?Q?acmZdRxx3nyrJ0bANPd1uAQMSiPihP+mEkeEDAlhVJsUviONO6xkov8qb1ur?=
 =?us-ascii?Q?LrJWoxX2hee3dZ2k0iBr7ToVWY3PjfNVleLEA7zy9gIN6eFK907oaRuZ/p3D?=
 =?us-ascii?Q?kyredHvdqlJonQyHDUFeo23UyKKK0IHmh4QZbuPFn8Lu8RYk///HEzMXSOta?=
 =?us-ascii?Q?NvV5E56xHq+fvUbvJjKQl2362/sdQFGs/c8DsZOh1UruNIDR/ZPDonyiYL/b?=
 =?us-ascii?Q?5qAn+vWdSRdgI7uhBNIgqA4p4SOK6uMhGO6nmYSvkot3jYmjEPjhnk66/JD0?=
 =?us-ascii?Q?6qgL+LGidm6gNV7uxXySfB+Y38pOlMkaLL0imVskx6ypoQXxRYqCROQmUbTn?=
 =?us-ascii?Q?2sBkzQ4QddFrTA5232fLgc0Smc5uhsVeKpvevNhAc6PYLgSLncyh0AOBGaDI?=
 =?us-ascii?Q?wQHY84yTPpun2El3ctS8RGm3xilk1ySuguBJKiObLmeQiSRj4Z9tEOwh5ele?=
 =?us-ascii?Q?7qCUk8ik//juM+dxNvvRLMMNuOU/KcPV/9ZlmDz7oU2iA8IqTb/AOjLhkTVz?=
 =?us-ascii?Q?8Re3rXCXwyi4BCZOi+PjzCLJQTQKtnVUleEZUN/n057ODNonyof7Mw6fN4wP?=
 =?us-ascii?Q?FaeViZHr4NY1stdgHM14r3qhcykGJNWUTUVTUiFqhMKk0Y5hRJYsTUehFUgN?=
 =?us-ascii?Q?cxxaf9Lk0rJblYgjPRK+FcCZpILNae4xqvtMYF0lb+0B6J93ScweniRvg46u?=
 =?us-ascii?Q?77LTPNu/B+sZHlUqV2QiCBdbcdxwuYFaBraiGRIsKn++P7BGXdBLY1OtgkQL?=
 =?us-ascii?Q?F89qsN40+swfeGX0S7X1pYF/Xe60gjRchmPgATMi09Lt6Gf4uDNWXo48UwPn?=
 =?us-ascii?Q?byf2ObFzde7cGPC2BfiK3ukFt/t9wj7ZZnRUuDOTX8+9RYpmRfHNIT/nfLXY?=
 =?us-ascii?Q?dBlHu8+2EsVhdAhx4v5keROtBIRrqaslr2QIxYJ5oOrlAuIC9iL7wom/YdNk?=
 =?us-ascii?Q?xj5p/bjfSOHpEbhUPbCq3dH/xS8f2RFbkhXJvyKVvhsKWGO2VP2qUbKeZyRG?=
 =?us-ascii?Q?1VcMK5qpdgdJmrqbf3zbWMzWo/F/SzJ9AdUz4DgdiUsYNJxHaWYf89iC+ihI?=
 =?us-ascii?Q?ANdur3f9suL8xxe6KnqQC8oYuPXk1mM48M+1BzdqxHfWkKZZ4aPohZfsA7/3?=
 =?us-ascii?Q?HNpXTWBTNNqKBR+bYm80qcIhnklaXgvd6tuyxr0fsMZybPpPAW79Jb6SM6hb?=
 =?us-ascii?Q?dY2AH1WGmIOlnpiJkWNXaE5AD51+ncciaUuUA1hhA7QAg1rAyxdXYrKhE4+q?=
 =?us-ascii?Q?z6q/Frw4yc/0e62v2KGJyJY+3gHWRTG7Ffs443qwFYyJyPfpaC4HhS6vAFzF?=
 =?us-ascii?Q?KoV4caa/nvbUxUCAMkkPyx/eoLTOFs+5KGf9abJnZyxMMsOJm13uFRCHiimD?=
 =?us-ascii?Q?iKhdbCrjqrB80/6wj8g/byN8F4StyP1IdHyMEbrPmCnR+4S2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R6Acifb0tgsxlQR8zJZFIj3ZDo9P0FUbUHOhpA8eQ4yggLGeeLJAGPmPt7uCJ3OuynaGXXQeEHqw9lhXUId7Zav2/+LDksXWfd9NtZd0Ae4BpmEqwZwA9lsAKqplfSAgi+I0JwPfoZS9HiGGNBjMeJ9iuZzCSQeTJB/FRlD0gfTPh3ZRImuXCmTxqbfVruD9F/d5nXurS/9nBetNoU+/mc0v4XoFcErYXRjVFldK3guM2R6ls5I6hwlFGNnpHSfT03t/w12d9yEjGRZN31nLbU49utykaCWe51SkffXddoPxWOXxkAPQuzpP6AXG2ex5U0is2ZsQQOvb0924zF7ypQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaba0c4-920a-4f2a-e386-08ded603e9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 17:29:03.0493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIZAXT0WeKkccercLTefwY9c1hM+sT1CDsaJXpFckOPIrNnXbd5+Ws5atHwDW1UolWH1+54vM3M56C1d+PIMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302756-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,suse.cz,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B6E06DDD7E

On 6/29/26, Andrew Lunn wrote,
> Is there confusion? git blame suggests it has been there 10 years,
> and this is the first time somebody has questioned it.
>
> I would limit changes to Documentation, man pages, help etc.

Yes Andrew, as summarized in the first email of this thread, there
is no standard to explicitly support 10000baseCR and it conflicts with
so many characteristics of a "typical IEEE *baseCR". Based on my internal
discussion & feedback, it seems people are using 10000baseCR
with 10G-SFI-DA cables but the question "why should I set it to 10000baseCR
while using 10G_SFI_DACables?" keeps coming back along with the subsequent
questions to seek clarity against the "IEEE *baseCR" definitions.

This is an effort to settle it down for once & all. With option-(c) it is
just to add a clarity that 10000baseCR is SFF-8431 SFP+ Direct Attach (DA)
standard with SFI interface.

- Thank you,
Siddaraju D H

