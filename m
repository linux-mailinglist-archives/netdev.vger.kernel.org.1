Return-Path: <netdev+bounces-260604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJJiAHLdnWmuSQQAu9opvQ
	(envelope-from <netdev+bounces-260604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:18:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5040E18A724
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2997330338A9
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA63A9DAB;
	Tue, 24 Feb 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGIkOuvH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769B3A9D8C;
	Tue, 24 Feb 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953465; cv=fail; b=gLza+dX7h/EEBPjLeZghcvX0+/ou3zc8IxzskzPoEDE7iIEghcOOOVKmCjEdTQwtFJ7VsvcxvW4ESQCvFjRgMYl4hSH6LApaTQQuc1JgXjGEkVGdaKYLGwVQDWqsokLt65Us/9if/5NvMmsBQViZfBrWXR9eTU3P07HzFs0T+PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953465; c=relaxed/simple;
	bh=FZddx/aIipUg2INcYMSYUl1bWW3BzyNkZbUVIx2M1Kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGouOHRg4o/uvZlyket1uVURA6DrpcDHhC+fr5U2LMEUqhl5bmi//EWmK+U6VSeW8+C7dA6LuZuDbqD/JoYNs1XsGPlWUWNl0Qh0K466FWiTKEHuU7u5RIW+XNxcB+wOPhacbtXEvZUsvBxRc0Ru2gyb+SFEFCHYNXMTXa8kxio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGIkOuvH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771953463; x=1803489463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FZddx/aIipUg2INcYMSYUl1bWW3BzyNkZbUVIx2M1Kw=;
  b=hGIkOuvHzxbtZBcvjLMfX9YqHio8yAgt3oItr+6MIE2e2FDiL8+zAFjH
   FKRAxKvtgDKRTXijzZf2hTwmgGpiWzHq3GnnYrMv0BFinPYNDJMsl9iH+
   2SgSBLOyTqOWn6gsqgJR1NhHGnY/JW2iUmyU92YK8jc/g9+3NJcpiOxzz
   +M/IAs794Fod5QUls8sout1IUudLXJ88tJK7FrzjStx8UWwPBEhFlQSSO
   FbwqFz+e3b1ZGMPlWR/G/JH6Ysl6dDla6YTYDTV9BVanp4ht7Lic4Qms6
   2auVeg2yL8Z93QgNS/TgtL6NvVd/79+uG3/1ItKFLwPG/4oH590uhm6ir
   Q==;
X-CSE-ConnectionGUID: VSFiJTdDQRqLHS4nI/uidQ==
X-CSE-MsgGUID: F5SPH3jyTaysloKPfSgCHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90555727"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="90555727"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:17:42 -0800
X-CSE-ConnectionGUID: dHmN6iwaR0KxjilgOabA4w==
X-CSE-MsgGUID: M8p1hwSQT7+3n5A3JDFYJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="246535379"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 09:17:43 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:17:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 09:17:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 09:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cml1PI+Zp/Ro5itOEnjHcMwOVv36R1fvBrF7kbUgzrTzYi16HVbFj5x0oltK9TXU8VLBuhbpqCyDSZSMfWAEIl93XUthkdn+N4N5ah898Ovqu25cQYPxGwblyey1nRMoGxxWDTw3hrvGHoknUn9tdc3IpSBY7PIEFTndNMTTX8tXxd5TWfaS4GkBAQE/DJOIFiAmjsnN2/13GpT0rM28dl2mLLH4BFikcfAkQAETaIGejlpMHg218XM1GIEdOF8rHV3NLW06w1qPvtDAwAdq9+ZJ8smNbt6e6Jk8FB+dj14UceHkEWGA9mCIRZxOAfjorCH1ht1nU0n0WswvyS8hOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1yxeCJQO2ZJyaJBXiTCwyl33gM14ZXSrkKSXybKE8s=;
 b=XTd9cxIuL/rgbnOoBeoObuvh18jhi9Yesx4TH0jX4tlSYQsvdkEs6T/OZcO0UpCvHvCK/vx9kZ1c5FrKq1DYhxFPwojkeEJ7SHse5j2fRvQSdaKWZ/7wCGRMdbc2X/vWLQ2j+HE8x8k9BprkRcGz7CGZuGqbXZL4fg355aCjtv3lMFzc7ZCntv18kfncowF3HHKFX/4HwqpyBtg4pZZP6iRckxVGWCfWwPubL38d5i/hBDeIZZPbobfABYKDfXexsV9dqAxL6U4iOrKltremYrRL1zDplfzMedGoFUHOBajG+gvOck1uqs3XWNWEKrJVxkncu/CkXbRZ8PenuDL/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 24 Feb
 2026 17:17:36 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:17:36 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "R, Bharath" <bharath.r@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, "Wochtman, Natalia"
	<natalia.wochtman@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Burra, Phani
 R" <phani.r.burra@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 05/15] libie: add control
 queue support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 05/15] libie: add control
 queue support
Thread-Index: AQHcV8kMgsX/izY/CUWTKLDhPx0pirWSCyAAgACn1mA=
Date: Tue, 24 Feb 2026 17:17:36 +0000
Message-ID: <SJ1PR11MB629762DDAB1BA7643EDFE4EB9B74A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251117134912.18566-1-larysa.zaremba@intel.com>
 <20251117134912.18566-6-larysa.zaremba@intel.com>
 <PH8PR11MB7965291BE16CC4F1EA7E4E7FF774A@PH8PR11MB7965.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB7965291BE16CC4F1EA7E4E7FF774A@PH8PR11MB7965.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM3PPFE9E88246B:EE_
x-ms-office365-filtering-correlation-id: 2153a606-6102-464a-8e15-08de73c89b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?PsfOottPl60CC7WBAkKDqw8BLErl/X26Gxv6OM92Othx/Up9OM99uBi9nMpN?=
 =?us-ascii?Q?hdJ5aQrENW+0GEQn2OuooASP7yElBlYO/6ktn6H7tap3bI5UUjzw88539caO?=
 =?us-ascii?Q?gAVpUv9UjVhViDam/wHbjZFwV2lsCLoD16AY2d4IqHO2EVBS+v0q/6aVTS7W?=
 =?us-ascii?Q?1qCiJvyOTTL6kYfY+aWoQSMQni5Hd0T1ed7bj1q+45AAoeqoBh9RBfSooIJ2?=
 =?us-ascii?Q?ahhFC8XkR7CS/1IfRVCZyUc7Y5FWUR5vIaPaES5Vn4IWx/8s/b8kzr9m80PQ?=
 =?us-ascii?Q?Zrl9TLHrdiMmPPj7aSI7zRCAtQKYmLkppfgaoybcff3c/jWd3/CTG3XHBOSo?=
 =?us-ascii?Q?B4Cb4j4vsIySaQHGNIXmQTLT2HCLLTPp99QG111rMz45tkVTtDEhpSkyt4G2?=
 =?us-ascii?Q?F7hI4S4vdpjOucU0ywvpFt2uEkQMdBLnLvycTBNlNpyEVILI3PKp+UuCKxwm?=
 =?us-ascii?Q?zQcew0YVaXgpnk8ZRIq+9uSCDr4YeMNg2CqWd0BuNMAyrVhk+MvH/UxklKV/?=
 =?us-ascii?Q?3CCvi+iNTRYRzDEVk9wGDdq/iCHsU35BPrm8+ufOHxZEO+scQGXu2LksX6GU?=
 =?us-ascii?Q?juI+01KdRvOgyH6a+crzK6Ao+QYlilXPGrqoK54E/kES8eIZNddDUCHlPkAq?=
 =?us-ascii?Q?aXBALB2lE7f0JgXbIma5lsTuOxXOcaXlUuUA3Fl6DcTJwNGW1YczxvDBbv4F?=
 =?us-ascii?Q?S9ynpRBK5aJcaU0iPxLsc/gbHQLeFmbxI/FOHsytpz735/aeJxs98xPfSYtH?=
 =?us-ascii?Q?KRshVxLLL8uh0LthIAc8P03tinTrLaW0CFv3Q4CUzmjqU/IvNb+PnNO/F55L?=
 =?us-ascii?Q?E3Y0+nOq9GxCQYC+AQyjsJYYW5CeA6FET1jfqVKWhzF9M1+BBsSV1UJf7zoh?=
 =?us-ascii?Q?7WwP5Hwpp0wEP1BXJWWTNBfAAqazKQQZE0qXjpzlo4lYipuSgt7wDvqGdBjx?=
 =?us-ascii?Q?VjvrxPqoCq0WnDBwubti96qHCrMB+4tXBZypysMyAEiQofyjN9jbRj9xRhX6?=
 =?us-ascii?Q?qXD9qGFIrlT/yRHbKeD3Z5yaTENQkChGNHZSFAYe7x5TyTvCh5F8oMLK78VX?=
 =?us-ascii?Q?YFzVUjc5ODLeuY2/fFe47rD/4cX54bWIsD5hf+0VKm8pTzwXzMgbagx0fAx3?=
 =?us-ascii?Q?/PkaanbGSTzOsmo8dsk9ifG0NX6RFwE/IM86r71fvsd/NzyNVRoO4D8IfRor?=
 =?us-ascii?Q?6/KL+9QhnE6wzXfQLLOAz9DUn0d+NKdF0BlkITNjzzZSUYN7JTD9vE4TLzHF?=
 =?us-ascii?Q?JqOylENXhNyNztvqPecpGxeMRRPyUPoGDvriuD4ozEJWL5mN6VawfG8XWnRr?=
 =?us-ascii?Q?fyvmSk55E3sD4k91MsOtX4/VkOPIqk1dMNMroOo0qf73Wh6otRjoqROGFe45?=
 =?us-ascii?Q?iMfE1JHI9VFESn51oBkyiaUy9YaJQg3qJnIk0KwRIrhT/uVeGd8/cmQKrHiU?=
 =?us-ascii?Q?6Ex5fQC2BhaIy3TDwnZ3O0T9HEd4GDzqXbKPylebI7nrQ4p7X0XZegaIBgbT?=
 =?us-ascii?Q?pyiPyxzcyICVjDjcuoXmrbsa0F08iIQGANMK6RTv0GB3X4QT+C4BzJ7YOX3q?=
 =?us-ascii?Q?4uEtvJ5qp9ZHIZvGTOlxK7ugdc7htFnambS3noOOE9a/FYcJphGOIL2Gx0wm?=
 =?us-ascii?Q?OOP7KXP8gJGNB1ZIMBoC24o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oILtG58/7XfjDhXOK/vcOE1hT07FuC34R4+nqePbFlm4MOeQIYDflEyffMlF?=
 =?us-ascii?Q?+GT+44ISboHLFpiu/btPe6uHYv9a0X2n6dCUzrMRk8s1JbsZsvq2qrQml3Bd?=
 =?us-ascii?Q?QCdfrZtppSCtlqvdlSo+iYWJ2hJfoxlYqwMu6T2D1nX3rCwuOzDr+SWP9I47?=
 =?us-ascii?Q?m+sVETAwg5RrFGUUgR6aPQm8T3IbL9anyU9ZuIZLwot74Vn74VneuSkFS3Vp?=
 =?us-ascii?Q?gGPOHOhYjV9lkKwOk68m+Bp8hMdLxHHvytGycZfuOTSU58tjVeKyIsspIDjg?=
 =?us-ascii?Q?V5vctyWEK9RGMtGG1fWyhgkhqNjlwOdj6PavAESrjDXzLTEGP/2I/Y9mRNEH?=
 =?us-ascii?Q?fTlWsRl+hEhLPuyew41U3h9f2HpPbyn+s4qLc4FeANgRB5n3/xikDynCaSg+?=
 =?us-ascii?Q?mIqqXtdKxZkzOLIKM3qfxleYqfy11jgwuq+2JkY9M9w0gGWKrSGKcJf4NrWH?=
 =?us-ascii?Q?hw+bhQDDZhesE5TyfmSUK0I3yW6oLZv7L1f2S+KoYf32++oeFwpYrANLMtgz?=
 =?us-ascii?Q?bmsQZfWn3GPsIvd1ES7TDqwO9HlMnEvDmHgvUvmBx2AS9VXMkMb+nPMBu6PV?=
 =?us-ascii?Q?F+Lu2BPtzwEGULt1tOCqR7IG+3e6ZOqkXCyxvuSEHDT6YB8cSUlC1/NhuTjK?=
 =?us-ascii?Q?CCJZauSZbUjSVajM/OxplMgEjUsxb1B1h/Ha6DuLTslQyeHaqjc7PNO7srl1?=
 =?us-ascii?Q?0Gd2mX0pTL23arJNAl+hr1yVJfWlN0F6DYByyDo6p6in7Rbz5vt49iTWWJVV?=
 =?us-ascii?Q?hczH5Lqp2yQxGTz3rhKRpHltJPnD3zykjS8T9GJ7tJahyKiRR6deTjsPFTKC?=
 =?us-ascii?Q?0NIp4N/ZD99y424Mt66wbXJHSFQIwLXxQn4R0aOQMm+IGg1mhNg4/hKfUDBd?=
 =?us-ascii?Q?v6BtaSVpAr90fh2xA0nU9N9QTV8iWRpMlZ/DgoKQMa+n2EBYr/FILsmaawRX?=
 =?us-ascii?Q?DBZgiBQgd88hTxD6K9ggCsCUaHHHOEvxHO3sRbnPs9m3QQo7aID3lacWq92H?=
 =?us-ascii?Q?+m5hjG/x4a0xu09SYU+Mm6BL5CaDHbYbaaPdXFHXUUl7Zkteq2Q/OESxhXgy?=
 =?us-ascii?Q?Hk4a847vwEP0RPiKqLdy6DPWdqhS7St4COz3B1L6+C7G2S2RSM6tWpQSym1J?=
 =?us-ascii?Q?Sl+L+4wkzEpULRmzr04p5YDk2svM34TQBg+oQe1+BYdNHMNq2EW4T/nzeVsJ?=
 =?us-ascii?Q?Ei/Cjt7QHhuV6BpYDxV3dHl98NztF0oZfnRK1fhlidoygcqT02xRX0c1ey0u?=
 =?us-ascii?Q?CMPlOou/v2w3as/Ds17VURgKg1n+wm8/pWvs9tHKfxKvlxp8bJHZoWNvCmUu?=
 =?us-ascii?Q?tqdiqC9jiIc0Pd17/ByJy8jvbptzm8n9oTVrkZosRDrMziWo/nkvlg1o2PL1?=
 =?us-ascii?Q?QRCNbpbaGgGFtsIhKHlqJC83hWxcHQGJnYsed0EIcVI3wT3RXrS1l38bBAg/?=
 =?us-ascii?Q?nyNSWcwcljg+yYxxsxsyz0wuRnI2sck3giKkn+IvS8D4842Szis+hZ2GzQZL?=
 =?us-ascii?Q?2gEsNBHNh1MQHLNEoY/cYzKKbi3K/yySWRBMW8ACCj4RUaHGiAD6lu6l78Xl?=
 =?us-ascii?Q?cKNCKvD8p2ripIhdjrZ+IEpdV3sbcaJ7LN4jRgqf5VBAIdv1dhbdqRkg6tuo?=
 =?us-ascii?Q?d4rTuHv6a5DcYpmYoVFeC5KXToIXR5vzE1c6KUd3ojGj8CpTDCNgh3fYvUXJ?=
 =?us-ascii?Q?prsu5SSsHmSnNbiTdfQkp3xMOiQOWqCu6VAcqMA2Qv1u+dLrr3vZB9CP2ZXm?=
 =?us-ascii?Q?Jnb2GuYyRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2153a606-6102-464a-8e15-08de73c89b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 17:17:36.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCO1hitTSfBaa9HcontJzZT+P69/d8Bkd8edfcGwoL2jY8YLiXIsDF+LqrX+ICyFO3EqAUWCdPjEfwG4cZUZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260604-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5040E18A724
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of R=
,
> Bharath
> Sent: Monday, February 23, 2026 11:15 PM
> To: Zaremba, Larysa <larysa.zaremba@intel.com>; intel-wired-
> lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala, Sridha=
r
> <sridhar.samudrala@intel.com>; Singhai, Anjali <anjali.singhai@intel.com>=
;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S <emil.s.tantilov@intel.c=
om>;
> Chittim, Madhu <madhu.chittim@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Shanmugam, Jayaprakash <jayaprakash.shanmugam@intel.com>;
> Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> <phani.r.burra@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 05/15] libie: add contr=
ol
> queue support
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Larysa Zaremba
> > Sent: 17 November 2025 19:19
> > To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> > Sridhar <sridhar.samudrala@intel.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> > <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> > <jayaprakash.shanmugam@intel.com>;
> > Wochtman, Natalia <natalia.wochtman@intel.com>; Jiri Pirko
> > <jiri@resnulli.us>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> Jonathan
> > Corbet <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>;
> > Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; Burra, Phani R
> > <phani.r.burra@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v5 05/15] libie: add
> > control queue support
> >
> > From: Phani R Burra <phani.r.burra@intel.com>
> >
> > Libie will now support control queue setup and configuration APIs.
> > These are mainly used for mailbox communication between drivers and
> control plane.
> >
> > Make use of the libeth_rx page pool support for managing controlq buffe=
rs.
> >
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> > Co-developed-by: Victor Raj <victor.raj@intel.com>
> > Signed-off-by: Victor Raj <victor.raj@intel.com>
> > Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/libie/Kconfig    |   8 +
> >  drivers/net/ethernet/intel/libie/Makefile   |   4 +
> >  drivers/net/ethernet/intel/libie/controlq.c | 607 ++++++++++++++++++++
> >  include/linux/intel/libie/controlq.h        | 249 ++++++++
> >  4 files changed, 868 insertions(+)
>=20
> Tested-by: Bharath R <Bharath.r@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

