Return-Path: <netdev+bounces-270913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIXcKeJEwmktbQQAu9opvQ
	(envelope-from <netdev+bounces-270913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:01:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE0304499
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7233A31A286D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF835E921;
	Tue, 24 Mar 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtd/M4RC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523F359A94;
	Tue, 24 Mar 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338872; cv=fail; b=h7wa9kXiCl7vFOIptL/+kONJLhDpg3cjGTyaB5Ea7EeDL15gYiNSG6lZDhfX68BSeIqzuudvNfGa6F8AIdutXx6cPWm41jxby1M0g3qzwDFc/aIavmM2XJtAdIWlnxfEKgjgBv22OBVjWoTmP5i0s2gx+7p8OWHW+2o2Jv2YVJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338872; c=relaxed/simple;
	bh=k9IANY1fvhMAH1FtLg0C5TltfVPiW0jT67gXCzcz5Nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=csdxTjb6d8jjsEjx6ndm8Ssm++rg6gdloEXERugcRKjRkcNLtPkN0H7iQZy0cbqqng1Hg3AHy20PlL0fd5F5qCLWCtVFAmsU3mZ0xi4t1OFw4Nhduq8Sdh9nhHbinSLPf3uGfw1iXyg+7Plr6B5lC+1fqv5XL08sSiUlGVJCW3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtd/M4RC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774338858; x=1805874858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9IANY1fvhMAH1FtLg0C5TltfVPiW0jT67gXCzcz5Nc=;
  b=jtd/M4RCOEVJwwD1EmIe1htc8rz2S0xrdTKZkgHAg/D4BbP+STx/eIGk
   ULfoYXQtDObXT/rWXvEJ1uGKPNi6ByrCGmcrmOFtJWpCeAnzcxlgzH8hM
   RnUY+2Lo9DAXWF0PF7RuvfQlmEJ6fIFOz1J5k1yXDeTbRTL2zUWhmlghO
   XXBbSHTHjOunS8zs/Wm7sMrIw6O5CpE0SEtLB1XTyxtzEYBEGoBYRrx92
   lqNFaYRjycUew/gOeJsJ3eyrHS2UcTANSRbybHTGNVPrKNREC2/g5n+e2
   NN8ndV6yghktZPT5SV9QP10Jijf8TRWKq7YKEokCthSEI6+gBeIsBMywD
   A==;
X-CSE-ConnectionGUID: RNj+PTysQ8mLWNXWrbTkTQ==
X-CSE-MsgGUID: D+tMJy5MTEyNpMZaQ7pEPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="79204716"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79204716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:54:17 -0700
X-CSE-ConnectionGUID: HjrW04UnQWS1pV56kya+wg==
X-CSE-MsgGUID: DEuYI97cSA2DaRz2dcsmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217712397"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 00:54:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:54:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 00:54:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 00:54:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui2k8YtUDRWr5E2ecu4g2UbrxRxxCGOXKL0TkH8AZZLDx/sZUQS+3i4OL0LEouzpMQKmjKjP2az6uFk0ekq5pjuW5IGDWwjf/2axSZeDhw+QBm86lbXfjW/I5jTnlWVT25ienD60aBbHX53GOHcGNWVfFyFOvnP5TKP1Hu2NQ6YHJ120sR0WPEx2uhMlYpw/A8a2gKPdpE4mmHj0MqJKCbLgIVpVofAhH18x1XzhWcF4ymtP+Sn4xzN/Bx9ozbcIZhCezHC0w27d+RCmJcbLGbgfMg4bK9q/xFEiyXfzWd8UssXt/WlUxN4BR6Ed3NUsxtipgWaOQfRQRslXE41HfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2ZFeOi4sHBrd4hqqDdMfp3dMKj2Z+EvC6Od1eRf8jg=;
 b=LgEB6lJjBnj52BodMDTrsR26NJi2EO/+J6ibZ5YzbA1n85lGLXWYNrxC6rnzAMWotRTfdgUfmINUtFvff80X/GZ207t9daIy3RwCXON9G9NptjJzeQtqSactCSRsQzWd8F/7i2J2eY1n7RyOAbarRDENgKVUA3ugfAu1Gtl726iA1z3VJFlgXs/o4o0zAn6Hkfs6ZhFiZEXLcdB0YFBwcy4r0vvZ41iyfKK79GQsy51UXxevjqJWLYRU7R9g87jvEnaxWa+mqYqv4UPI+GoI9NXwAA24650LSl5IvW3aWznSrxH2+6SRtxXEOurXvuJM4ZtHjBssv0UJY5NxBP6hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:54:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 24 Mar 2026
 07:54:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 04/14] libie: add control
 queue support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 04/14] libie: add control
 queue support
Thread-Index: AQHcuuxOhIu9s/mf8EGdr3ax+ylasbW9UNrA
Date: Tue, 24 Mar 2026 07:54:07 +0000
Message-ID: <IA3PR11MB898667FFD8F010CF6BF0B5B7E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323174052.5355-1-larysa.zaremba@intel.com>
 <20260323174052.5355-5-larysa.zaremba@intel.com>
In-Reply-To: <20260323174052.5355-5-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: fb407e75-8912-484c-5165-08de897a8735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|18002099003|7053199007|56012099003|22082099003;
x-microsoft-antispam-message-info: IMWb5qyjr3eQ1/c2xzwlf4wolPgHLSlWLckNgjKxXxp9TA98aQhW6icZLRZYDrko5V1YwGrpksYldWnf28moyBW8UIHCL7ByNZojIOeUGi4KkoXJZfkXKxhZbfbWU52FncUyQBi5eRF0TY+kPJ0ucdGkC36kZ1ZAr2bMBNl1D8ep/s1lLqbsVYnUPS4FhUI8437LhU2Jy7ISF/pZDXTWDRfmM/pqgKAS9boeW3ylH+xFKPb/Zk73gFdJEADFSmSDFRhu0+76r/kYr1RIy4/c1pSMHbXjRzEbl4huQ5bmHexumdMoqV5IJZsEequcIwkNRT/JIxiA7k9ABX0QGD+nae67lMrM9qL5rfe+3hd9ZK4B5PXRM2ohGIfzAHGBGy7By9Xwoy1R/TM2G4IX643MbF7+nxOH1viLOssSMF2eRLEVcnfyBRPsOjjCAEWRH5OoFT6e/Wb8ob5zVrRh+XsLjQiHOGu8VrYgPmFM168vzxV11uQ96P/Dp+/nj2D2AoxupN+Nes+1lU654GJw3FFtmtXdcIjqZgRpjBXQbfoIYhoNGa2uCpiDrUM9vMJoZWQlUjSv9mhspEIn7iHdPUv8mIVCjCANpCjiZNXFDN/5daBnnyWK3BJ17uH1535S073pMcMQc3fw741eJU6Jfa6Phm4dCGP9ZC/9hLU6jKBjTfifJTyMD+vNZjIsmcmQMGzYP365Ne1zsPtEfbI03Rmbab1wW2c4hyLTdxUepeJ2OZ39b8SUDO0lfZ6sNQXX8osiAp4fqVzGY77eYUHY263rri5LKBwrWlcCVM81E1PM+us=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gMYCsBzizI3mYkxTsstL8F0ZxwhBHry2QWCYfu0dWGVWv6fIg0tFtm9CGq2k?=
 =?us-ascii?Q?MjHNrxU6KRyhKuE9uBsO8yV0UqJIy20yxpGYLmFxGy2FgLvrviDKlpiu5WDc?=
 =?us-ascii?Q?mlF9LJ/QgyDvX2OT0WDw74TwrZ4ILWIXSUplVJali4RPXHy7E8hzqyJGA1Xj?=
 =?us-ascii?Q?Bp8eArFQ/i3QBKvLxzTG+MX5f6L5DZEIRqiPOCaYeh/GwKXKJl0iQ9zoiy9O?=
 =?us-ascii?Q?Cv1GGtUAkelYaf+wsY82pWcCvUuOfOkw1hiiJkkl6XyGD31QkDHrTsfnRTqi?=
 =?us-ascii?Q?esYcVhaJEAwSYtbzzJmeWdRG+jGwfsPPRAUG+1DchRA61U2/6VhY+m+MDDum?=
 =?us-ascii?Q?Fr8g0Eklskkfb9XnrywTAD+ffDcZelpOGAwAC1+KhHvtHQ3NeEUZ7Ax1FReJ?=
 =?us-ascii?Q?WGmfH1dbbQtLEKwAehnN+n8eg0DEtg7q7vRsIoICcN6ZJFr7236xLkU2JLZI?=
 =?us-ascii?Q?r9yuC9lPC6JJRao6McYD2fPS7zRZE1RtMFA54e65G8gfBscpqjrXWlTmxMNL?=
 =?us-ascii?Q?Fmo28nrwDg90ZmD6ZBuGyVx/yRKY03LSlEyx6WEKbO1ieLsR3jbGIXAxq4Mi?=
 =?us-ascii?Q?WnsIop6Un6cVXn1momrQhTLgit/Ed+wyez30F2kun4zlY/8B+fYPsvO6LNrZ?=
 =?us-ascii?Q?ludCGEEr8aftoOZzsdJPdibQV8xJY5tSzqrJB1DFybrBm+to/MHB1le2PLSL?=
 =?us-ascii?Q?C+iprPgPGzTKVkBDLlAqKLy1NUgkMEd+KHeSe159cWJK+5aNA0N9mtUSPtmC?=
 =?us-ascii?Q?7PpakurVzBS3ledpf748adJyXBchx4OciusS0HT8bzHlMpQ0oo3mJDVlAwSq?=
 =?us-ascii?Q?AtxEjFLO3f55i6B3Q8Qa9bvD3Oc3sgokisQrXIiX6AsCSDySzkRFaBJ3VWhL?=
 =?us-ascii?Q?O4dsfpoaToyi68VDojr5YCEP4Xk0z//B/q54EHf37KBsZr0svvutZit1KH1n?=
 =?us-ascii?Q?VYxpdnW22ha8YAIa2Q5KJdWRPCeGmYdiYooMx4weaH3jeNKFGU2z1XJN15rN?=
 =?us-ascii?Q?rMYpjn6PWEd9dwUkSdgvRh3HBT0gwYZ1NkOtd3iBQg5pLl49jxeT30RdHwD+?=
 =?us-ascii?Q?nAf5CfC0ZLvcIxikJRZNPqXy04vIFMWqU1K/d+0vzQvU7cBeZeLobqPsT8Dm?=
 =?us-ascii?Q?bxZqctm7r37+crgzklVoGSTzYAcysI9FJGP1UaapARa+UxuHG60yEgG30zPZ?=
 =?us-ascii?Q?iy/BOET0Q5KOE8KAKgcTQ5HLKe+FsvIhmRk8TEl7hmtyovqyX1yxQU8JOovh?=
 =?us-ascii?Q?puzohxgIx6a1pHXfX/7CthmjRRxerbMsO8rZaa9v7Q/6hkYxRj0gYW9mlVG4?=
 =?us-ascii?Q?Rk6cbjKZ+t+Wzplog6YleukqN1Xnma810bROqFzxbNmnz1lBd4PKyMIvlLNB?=
 =?us-ascii?Q?7Md8z7dfn+9vO/D0mUS0dGGxMAcWFsFNAAH2ntfYYUV5HgtbXfA5yNkTYWkJ?=
 =?us-ascii?Q?qysQLXLLr2mr6tKe1bj95xcSlUlzYQKWqj1eYVK79NFNQiknU0DDzyyj8ve2?=
 =?us-ascii?Q?BGcJFjV+73QOeNk4CINu9x24lLUWfrtUufjA55mOkDkWn0mTBVpN6RggRDE1?=
 =?us-ascii?Q?v4tkv9lq3qkrhspklO/MIqNRolFZp2zZUrejlw8EFu4kEpf34TzOg+lhfefH?=
 =?us-ascii?Q?+74sNTxVVZGSYdb6xwzOJmMl6EdSQBnc0Q3kBAt2YLNhgaGbm8vQOFmYG5MC?=
 =?us-ascii?Q?selGhskrbvCsy1xMEvihuf4NlWCWFppWeEEIR5IWB3Jug5tlriKKo6nV/q6O?=
 =?us-ascii?Q?ytaRjzvvVYAVN8azQ4XHCqtnGn9ujdM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aQHlSWZ4fR4vmLn4vfMQ3ewL7ksUW9pWCcc5DRJTg+0PrXNQ9XPbSWgdYFQfI1dh9ACM0rHomA1hvmvl2MuXYKxV8noZEhmiFs1aplZR33TrXkkxdktDnGIYSY8KDOYltxAbjz2jV1BFA4kOKD2YeB2hmRO0CmFglJZmPmfBuQarye4OgfrgINULvJAj0ASrcj8NzXbWzhWHDQcU6hoY/Rcakbf/ns5xNLfmaE7WDQcGH4jnrls+AFw8Ex7odSk+2Tf/qKe8z08P2ib3wClvHavM/asXZ1ppkYmrjsJGzD4h/gHPJp6lBUFgGylVDi5padNOKOoqOU+R1znYuhcJmA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb407e75-8912-484c-5165-08de897a8735
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:54:07.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGQMBPIXP/maS6gkEPNXgdMLIne0f7eKofPzhTLMRbk7oQOGuZ95AuJmc6SUJok1gCNAhFQ1RmEGx/CkP4cQHy+9AZG+4mPBya8PExHu1aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270913-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[victor.raj.intel.com:query timed out,jayaprakash.shanmugam.intel.com:query timed out,pavan.kumar.linga.intel.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4BFE0304499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, March 23, 2026 6:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 04/14] libie: add
> control queue support
>=20
> From: Phani R Burra <phani.r.burra@intel.com>
>=20
> Libie will now support control queue setup and configuration APIs.
> These are mainly used for mailbox communication between drivers and
> control plane.
>=20
> Make use of the libeth_rx page pool support for managing controlq
> buffers.
>=20
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/Kconfig    |   8 +
>  drivers/net/ethernet/intel/libie/Makefile   |   4 +
>  drivers/net/ethernet/intel/libie/controlq.c | 603
> ++++++++++++++++++++
>  include/linux/intel/libie/controlq.h        | 249 ++++++++
>  4 files changed, 864 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
>  create mode 100644 include/linux/intel/libie/controlq.h
>=20
> diff --git a/drivers/net/ethernet/intel/libie/Kconfig
> b/drivers/net/ethernet/intel/libie/Kconfig
> index 500a95c944a8..9c5fdebb6766 100644
> --- a/drivers/net/ethernet/intel/libie/Kconfig
> +++ b/drivers/net/ethernet/intel/libie/Kconfig
> @@ -15,6 +15,14 @@ config LIBIE_ADMINQ
>  	  Helper functions used by Intel Ethernet drivers for
> administration
>  	  queue command interface (aka adminq).
>=20

...

> +#endif /* __LIBIE_CONTROLQ_H */
> --
> 2.47.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

