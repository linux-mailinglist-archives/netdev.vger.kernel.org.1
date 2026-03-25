Return-Path: <netdev+bounces-271354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HGnFPZRw2mIqAQAu9opvQ
	(envelope-from <netdev+bounces-271354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:09:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C231F121
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 372343041930
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CC28B7EA;
	Wed, 25 Mar 2026 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9Te93OV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FE17BA2
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408180; cv=fail; b=qoHzIFcuTZwspte5jNi4acE+kYhybtFhm6jswyEtoLr26xqRO5YzIrOiccOyCjvASPiHcOjKgFhmMsX0p/rUhnTC1T0BTkAryzIlKwBpvyiZ5044V1MSoMCodOh7KK9gBDVTr60+osoBXCRzJxRbYe7sI5/Mci8/Y9KhaaiftHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408180; c=relaxed/simple;
	bh=TQPZl5lqfchU10L31+x6rZ+FLX33hsYePpK1M+9LZJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHw6S6lhtdJQ52qxpb7J0NJ9eLlSVvP+tsVfxERjI96bvXDzjd4QbdhSP7iIMtDcYfbDyesUHqm/sM8/wjeXinb5yMCRIjnCv6WqNZ5pOp+qCq3DhshWeLtt6OpD5/1fUkUd5ajfK3MdVFQksXaxGQ9xfkCiRMsFhyxAXd5w55Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9Te93OV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774408179; x=1805944179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TQPZl5lqfchU10L31+x6rZ+FLX33hsYePpK1M+9LZJw=;
  b=d9Te93OVcHYaHQw4KPZ49zRb0eWHaUQHCc52Y0M3DfvuDISsKbM7FkCG
   Eq1hD+VKH4xbEuVKLUHQaZSMmk2oKP7RqWlJB0HbonogYLDcQjfhvNFs2
   3lJdFfCkld+IIXGAaTdoNN/ysamqSOkN9ubdkkGj4iyfZ6Nh2+mtg206V
   I5/+4SZ5iwESjBdi7Uvcxgjbj89pS2Y+v/FnoQ7gAe6vh7PtuYePcDDDU
   TKs/JWiXVOS7kQMQjG6LlFoqKIpmpDiqkDfpMkZyO4lEoQUeIr8w0+Rvp
   FxsDftXsBpwCXgIzyDgCIShPNbr5S/7PhiQDyadDV6fLrqa2Uh76liMi9
   A==;
X-CSE-ConnectionGUID: y2YP0goaSGCXJd8gWM+77Q==
X-CSE-MsgGUID: 7RBRsuQUR0m3KLxPmGVgDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75325300"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75325300"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:09:38 -0700
X-CSE-ConnectionGUID: tT21L0CyTWuglWB7muTO7Q==
X-CSE-MsgGUID: TCYreRmNTxmheVXX9TlUMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="262474130"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 20:09:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 20:09:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 20:09:37 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 20:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/DndEwjew2nn0M+Xw4Y36vB7hEaoSMAkPBLWhSkmlMFyVeKRIAixRjcMHCqLCqkdt9A0TH97AqXgI8GLtEdbLO2cVeFZznTiPmMBxoCkL2iJKeLP4+uPUUBBNcFYqqShOstoObmcZxp91TACDT7UMIf3HSQhYR+ogkEWDXFmZLdbNGnqaHgKNRaFi1qwNzKUFiwZ6QBaTbsH5AIAOv759lkC4XHSH5AzVbJz/pVj9eOnytQCaLZKlZsP+W/kkW19pz3H/dcVmIIOaCvqq1IAm7mDwQC+4u6HydOTcvVUqLEngFKLJA1EKVEKl0igp464V99pxYGE1ZNJfT5Uu14Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFFQEiOXeYXcICk9pla6WFpyjGRBwO2mgoNo8JsMkjc=;
 b=LBkwTfR7x+PswpzFlzb3OBy1D9AloDRX/Nwgo4G4jGztKUD8W5uHXfwQfD+t/HLioAcFXFdYfwnayE3bSl3wCrj6GGv7KL7GDUNbHe6XPqGql9Y/G9PEVBFRYhLTRA2qkJwMumbErceJp5Y/UFYcy/ubvyBKS80TdhrAyzzrlk8XNhFoV8X6UQtY35TeZ87n/TcM5OKK/aQaS5Dp8kxoAjVXFpDbnMhP5WaPxTQp7/rigK2Y0mMo67ONX8aW3bHknoBA0qsz4YMUpsxSQpvZcA1K96Uq5GYQvSAf8lD0vJ8UCC3/RoereI5N65dbye8NoXFGcqdW2UTr2lgTUPyYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 03:09:33 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 03:09:32 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
Thread-Index: AQHct5HAV1+EWoOYwUm6AaVsngdBtbW9SVnA
Date: Wed, 25 Mar 2026 03:09:32 +0000
Message-ID: <IA1PR11MB62415F7D91D29F788094E4618B49A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260319111659.551039-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7549:EE_
x-ms-office365-filtering-correlation-id: e36feb03-20ed-412a-6092-08de8a1befb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|7053199007|56012099003;
x-microsoft-antispam-message-info: ugdrWdGGXaEJ/YZwqgVhWamz5+uegWRhAafnhrDUVhUbxMNjzo6/wBcFhPyCvOyBzotIroLDYqMS2TvOHe3UWyQXbyizMh27x0gZh5TCNmcQLyyF6eaGGZRo6nLBBbMLlWOSzEp5AxHIs6VuZLLyrpYpZKxOARPeo7Q1vjlleRz5syoq1eNO146FVgsTidC5mntW1SD5szUbBxKoQZVzBjfVxZ/zqZsI2F/LL0/tQ2P9svumPJ5fZlQIPWrtTW4+KrWqr1OFeSJAzALv6sEVB99PTKAlrEAyrCMe2n1BWbefHWMlljNJUxkVJbqxtOnP5L4OmgkteFvcN/cfHDcrxsKc++FYxGqxZpAziLrhSX1WTftIUM6imXCec4dhWwq/eIzONeq09QKPShAhjgOt1QuYo6zk0oM/iD6IMhBYcfJ9JT4b+e1h2mQJLdhvnQt2cYuuJjYkRVlsOLbqD7MMhRK1pB6H8+sLQhTtoydJq8db4OO+4X5ia+Rc1GeppvAf4Qo9njKQlFbIj1Sa8IWMVks0Pp6+AXO/K8CNQyfc3EBNrH1fucrsklYo2yK5CCyjpGmTDcfxWJFDdZYDjaNORqXTIAhI3s5gdwkLoqQ/UknTG0XLe9kowKlMgR8If44M1JirHG6gF5lGZU/l54u/HcszFqKl41YNBRCu0LeDupc9bXbLdf1HVmmNlKNb7aUHEYcLNNQmyxqkdKzs00vnyRl16bEPCJ1ly7BS3pUASvwzI8Zhr2Xfm2oZ8eI2HYWeLwS0u3GRT4x4Iaxycppz1//IrG6enmhJ9NjBl6ar6xI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sdsdUCeDXCfAK39gDErfLDjogiZwizyXaP+7nrLbw3IYmkEAlWLPopYku6Bh?=
 =?us-ascii?Q?a+MB0dy4W8XZ3pBDLbJjxWNBR7moMZQQRVF4zNDFZXsUsePUEpF6rQ/bNeng?=
 =?us-ascii?Q?8a4TwvNRCc3FEyjGYUOhpMhphGw48pNnNlukVAxzCgC2GDOpehXTeJMUwzRB?=
 =?us-ascii?Q?Zyjsrm6T/M2t/UM6vrGOV8TozGdm1jg427ltfGLIvxi+fudn4AaHoy6GaFVC?=
 =?us-ascii?Q?Ce5/UOsXGqCQbVnYYF7iQlPc8MfY4r4UD6tpThqaTZLvfnSczvR7nalkkLYp?=
 =?us-ascii?Q?UScBRTdx1b4KQE3EWxvL/tzG71x4z+4RWhhNdTpDYf1MA0STsseDKK299dC6?=
 =?us-ascii?Q?qg7CVQ8E294j/two2+z3DRMvcU4MXKPjTtZBdXdUptcF3txBd2yWiQACPnHO?=
 =?us-ascii?Q?r2edYSP4jHa1vjLhn8FaneCPnpt3ed3prO7mDoZgQlQvuIN7LVSPnitBRPge?=
 =?us-ascii?Q?YNWDQTQun4gI0WJ5LUz3ZtKYr58O2JfyZr8cD7tYKuBePu/8NaI5SvxG2Kl3?=
 =?us-ascii?Q?IkzUo+vAnS53GfQ1KfawWGPUfCGSntGrDSUdzYXhNNF+5jqoCPnCGO1c7/oy?=
 =?us-ascii?Q?P52mdCnp6AhAggkmE9iJ4YrNkXdzJZmpG9mnUD0gIr8vYCCSW12wA1VE2TE1?=
 =?us-ascii?Q?Htr2q3+f9xYeDbT4rVjUemLIuhd25bsYCvBAskhPsP0zE73jO8bFMMzE5dY0?=
 =?us-ascii?Q?zssJEtWrIn5Hyfsz3TtXVU43GHX5qs5DdvhYObLfZbxep8xDn8QRk8bw22p1?=
 =?us-ascii?Q?ndQTWzw3VmqTfp0SzayGyEnPhO38HJCK1b/tUbaeEAwGYxNjkyOQsiYyGoK4?=
 =?us-ascii?Q?o2oSdV6YyDGH6EcvtItgDWf39DyIJLDveBCP16MzmngN64af6P0q1Sg4lHne?=
 =?us-ascii?Q?zQyPecXybGvdukE840bLXfosFyZWCJWFbHqPryRennJJC6Zdx6/8CaRXNJoc?=
 =?us-ascii?Q?cnUtqA0RxHVhtKiHPK0+nMLy9Z3icaHzR8KkAiMb6sDUwgNVJHleFrwJJvwf?=
 =?us-ascii?Q?DoPAIi85Xd4w7r7PwhvTg9Q66xryJAa+gWI4uhiQSUoAaHatxJ0JnxM5IBen?=
 =?us-ascii?Q?Bsb0u/mCZyKkVisvaB/AhRVw1PxaDnG7ao/pNQC7uHSEeiatvlt1P1z4jp+4?=
 =?us-ascii?Q?AQ/efIpVLRc96trTuj6WjRxAZBmjufN4w5WPy4ZFCOjp5gyLpgQ8PvHiLht+?=
 =?us-ascii?Q?ALS/QQRd7EECmyvI3yQ8dvcZIet+/ads9YTqQaAnxEuWdsaYIuo/WCIUOCdI?=
 =?us-ascii?Q?rFf858soNptyG4arR7w/pio67OAw9TF69tllQ2oXcCElbB+irRj4v1HH1Y5R?=
 =?us-ascii?Q?gAF6JUKrYcQSfdcuJQ+uAlLShd/IrRV96VIzMd0xXmZpZz9wadM9Jl2nYfzw?=
 =?us-ascii?Q?ch7MSdQhJq9RNdRNV8x7mNWNoLr3zgJsb3HFqv+FofQAhdDsGTSwmBV+OIjM?=
 =?us-ascii?Q?50lazX/Eouk5zf4tgwawQ/HmxG4DOcCbGN+UESGaGlZHX2iGUKE31jlOAgIu?=
 =?us-ascii?Q?b43eockFJ2kd3l+28g3PixWolqOinTr8gwA76Gm/XMMz8kkU6cURtn+9o3pv?=
 =?us-ascii?Q?OSkrSL3KecxpCOBDldcMdmIo6JvsPyyQKz00VeqHG62mvbS0NFJft94HY02B?=
 =?us-ascii?Q?2g3iRAIDZOpZxfhkP7hoQAUycFG9Tr3tqadZTqvjPUEbp5ik0Imk1EIUyYB5?=
 =?us-ascii?Q?DO58AobWb2tvPfBNKfjKGFrevIbOWDLPk68HHIR8yLi2J7AP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HaIfyCuPBroUeb4aAQMU9tMKBPpswdAv9tPyhAMZDDi+rfrIJjPrQouKCkLx8k2uP2VqWNUiAWWs1qO3glLZmFWLYhCDzyvGbjRLAvvRyQqZKwRYnI8lg3NntpImtFWWvvhEV8lgCf6+BALMTUP1flWLUV9PBkvjXMw2p9xnl3ErT4XzHO0Z1Kse/RpNqTMVr+GH44/BblknIrTNV2MN6Ix0QPpFUTCauyCQwuWI7rG/RQJNLjCCxrgAb8rSQvap/Jz1Y72psxQqwbZy9f06A+O7VEWPyIILKzsppIMXk/1WAGCxgYEOIq8jNxJTJiSAAnjvrgr2R3ma5yBl9HOEWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36feb03-20ed-412a-6092-08de8a1befb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 03:09:32.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQ9hVbgS6SnzzMPz2nNEYZbUdW+VLHg9+oCcKLhGoeaJpucn2420lSsFCI0YDELFeWE8DHyKlsvaN4Lr282kmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271354-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA1PR11MB6241.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EB9C231F121
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemyslaw Korba
> Sent: 19 March 2026 16:43
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Korba, Przemyslaw <p=
rzemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write suppo=
rt for sideband queue operations
>
> On E830, PTP time adjustment commands sent via SBQ don't generate complet=
ion responses, causing the driver to timeout waiting and return -EIO, when =
trying:
>
> phc_ctl eth8 get adj 2 get
> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
>
> Add support for posted mode not to wait for completion response.
>
> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - change "postpone" to "posted"
> - init struct with {} instead of {0}
> v1:
> https://lore.kernel.org/intel-wired-lan/20260310110700.345904-1-przemysla=
w.korba@intel.com/
>
> drivers/net/ethernet/intel/ice/ice_common.c   | 7 ++++++-
> drivers/net/ethernet/intel/ice/ice_controlq.c | 4 ++++  drivers/net/ether=
net/intel/ice/ice_controlq.h | 1 +
> 3 files changed, 11 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

