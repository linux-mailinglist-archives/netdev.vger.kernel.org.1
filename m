Return-Path: <netdev+bounces-115171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC894555D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214921C22D70
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137BE57D;
	Fri,  2 Aug 2024 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKNKml3V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007B11CAB;
	Fri,  2 Aug 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558205; cv=fail; b=BzRnaJ5TRF9BysfnDjG1CqWxLwpe9Hc58+gFIgtPaOcsjygtv5lYilJ95yaQfjmfbRzM4o9tqlWY2FSM7Y77yUJZ+tQVNKev49LjjzUQl/FL30RxS1j7u9GIzrzsGVJinezAft1HLcJ61lkxkSW8lgEihe9kO1cLEAw2mCOvh1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558205; c=relaxed/simple;
	bh=mhR40IDg6avjj7C5mwtXtI+3yjinsOuAp3mr13bZv7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdQ8pVmOnJcsKZy3GGWrW7MQ8MGGkmjLywZ4yUGGVXZUWGl9gXQyuCsxm5pQYH2j3oOagNMdtkdO7kE+kAEpBL4J9/GgwYR+8ZFeW1LG8EJjZxTo1hB5K9c1gyqbUWdBhR7wJ+0m4TJd9o1jUkPwdTwdpCM4JEhouEnnUBfR9rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKNKml3V; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722558203; x=1754094203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mhR40IDg6avjj7C5mwtXtI+3yjinsOuAp3mr13bZv7E=;
  b=CKNKml3V14H0MQjMJfawFP8LCp3jipFi8dvs1jGCV0BAfMwvI0/kvxj5
   IoE3ZVuTK6BYSTZR3QwMbNPfZEZ0RnI1zLixRbxp9F39LZbtUQl8++1id
   hQfD+FcfmDMZ9TXzMlhhQyxq2uBRBETaG7VMTxzNKaZjd31ZylKbMF+lK
   ZkJfWJ2/wcvItJZIkKYQC/VRHQoS7wOTVhl4GNO63jT87s6mUW9ilnfJf
   whitYI4/MiSy6YdlhibmgHYTRuSOVXem3voyw5VX337FENqqgZSiKDqU8
   KJK3FwhJgzYVRpC0DvjJGso9ZWJ7RgieO1Rg7VYBLvn2GVaC8FpYNmx5N
   g==;
X-CSE-ConnectionGUID: HvIQdlAaSRWSUmZQQ9fdsw==
X-CSE-MsgGUID: /vYSQIPHR4iMvH2Au67/nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="31705668"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="31705668"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 17:23:20 -0700
X-CSE-ConnectionGUID: 3gmuojDMT3yuBPAm/HeH4Q==
X-CSE-MsgGUID: fA3zZf1KSNyld6BYt+lPgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="55138254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 17:23:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 17:23:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 17:23:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 17:23:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 17:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjzNuHUc8tshmhFpC2Lbo/WrbVUAuagA72vFePsDNaqsy5ICqjfGdcUKLJ5gyePwqlMAbrhVuxwfPkMvj+MSE4tXTDnrl2nrP7lFgE9rafWA6B6ea7cfG+kyX7mPA/xvioC+oI5P6Uq8hCoN4O0ReAZV8s9UpQW5zch5S2HiURXwBLqAtoZdN84eyu9GOHIS41ePND0Hb6FAOpcXC75QmNjVyaJtEWbeTYjCWWcWm8neY6EtmMVYZNZegcZV3zlH39GzvkY4QuGA7TxKm8clOBOIZXfjgITDmLbTuupgMMWaRlYLM/pv/KCqwU8bSt/6rUqEQLisK7OBZk1BgACkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhR40IDg6avjj7C5mwtXtI+3yjinsOuAp3mr13bZv7E=;
 b=ucjaLf9qosJybjKRnoBdEiVfXCQtOUEoev2ocw9eFQ+TBFs25itCMjbac2mZG/U5gBXPVp4f73cMSU0svXF8wDFA+w+paGoKhKszAQOlLHzGlEh1pP7EUr0T53bEmI0rIWG2NEbIizSXi3fpvGg0lOcKV6uvQRsKgl+AxxTgjund17wimIXFMFzxog9EGGHKIPfY7lEEF4VCx2FUdpMafIq0Q4GFvxZJjTL7eR3/SS3ojk/GniqV4s2JDuhQJlLGEivci7B2oko7rwpm8yTCxv80dcZOJsuetB0HfFTSDc43hsulURDz3veO/XGHb6vWHESUH/BBbxBVazjkT9XiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 00:23:16 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%6]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 00:23:16 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Simon Horman <horms@kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "NEX SW NCIS OSDT ITP
 Upstreaming" <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubiak,
 Michal" <michal.kubiak@intel.com>
Subject: RE: [PATCH iwl-net 3/3] idpf: fix UAFs when destroying the queues
Thread-Topic: [PATCH iwl-net 3/3] idpf: fix UAFs when destroying the queues
Thread-Index: AQHa33gNrGcCod5NCUizKczc8duxibITJURw
Date: Fri, 2 Aug 2024 00:23:16 +0000
Message-ID: <MW4PR11MB591146D8D3AD442F7D60B3A6BAB32@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-4-aleksander.lobakin@intel.com>
 <20240726162214.GQ97837@kernel.org>
In-Reply-To: <20240726162214.GQ97837@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|DM6PR11MB4707:EE_
x-ms-office365-filtering-correlation-id: 8a15dd02-9e68-4584-9a91-08dcb2894d92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AF47eCKaVjZWL6fLhfV87XLlJHHoURnXUyurkaV1TQGIkZxqysb3HT7JCgC7?=
 =?us-ascii?Q?0/SWRZzv6m+ScHvTQgYgxUPE/+vQKDBESlwQp+Xd4n/KQtTyvTK0rKEeb10u?=
 =?us-ascii?Q?JhhFSqXqxJxxoAtj9eNURBz+dfeLp8LQ7c7/0emFGQCdoCn5+nw+YXajg/LB?=
 =?us-ascii?Q?jeX+U7RH9ehawQdyx+ZejcZDpiXrZzB74nj4xFfsfHT9Wlfg5dOTNIW4UF0f?=
 =?us-ascii?Q?KTR3LADgrD6yngZanN54+VKKUtN0OUCSeDO8JyY0C1We76nG1MSQcm1+Z9cb?=
 =?us-ascii?Q?B7JqnFEz9KIagfJgyX6HzaC1hgeXEIQujdOMW4tXuJGurDPkJN+P9ltV7Rq0?=
 =?us-ascii?Q?aDkxY42QVFMOWRP4fRH7IY6RBf3CGHgl7L1PwVvmJHAno9cmhgM7FnSP1M/E?=
 =?us-ascii?Q?9zzskNUwuzu9Ihhiz5arRK6y34jgYXXjGHUz8olrJsRpoS02nbkowBIEMJPl?=
 =?us-ascii?Q?lp+TCOw5kbHpgExiHZdZv+sVZqTBYGJSPDCXvBDdFTh8J1g9CJz7UcRx+1uC?=
 =?us-ascii?Q?2pHfZ+VOHbjlTOgWYyY9Dzb9NxKpCk5eCJjxtve4fkzzhAK55MeletuvnS+P?=
 =?us-ascii?Q?c5kf0qnYkz4iBsNnz4v2qvtB1K6m4TsxpZArRpzYRdvELBBpRtLV0DM2X10N?=
 =?us-ascii?Q?g5EoAcSSonj505tFluCvSHjlt84QKSxd74F3dqJYC/GLPG+fwC74TRavoLRg?=
 =?us-ascii?Q?/nOqDdYl6hqwSsDyuEAAu0t2jMhyPuceextnHWpOTo+QaMRqO2oDqsnsQIib?=
 =?us-ascii?Q?iNaWGZfrfFA4lSTKtR46ynULY3d+QYY5nSyAq+3tXysc3cEvHEdHSRvccI0Q?=
 =?us-ascii?Q?Ca9s//tDMc+fExseNVX/dimdd94oFUafchwjsuKlgqQnHM/0k9rX4TKAnR8S?=
 =?us-ascii?Q?Og2UsVvsQDnr23kGnFJbPPef/8+j0OWC/QjoujqUPd7AHNeBd7/HdYUMndYn?=
 =?us-ascii?Q?E2nBZDLbcR6OEjyti+vcwILwrWvgjnTLXvy32i9gmUl1Nmvp/2QZAkNBKkCN?=
 =?us-ascii?Q?PEDs6cA88HZ+IP7IEJxYrFrllgu9cpmAOKXw+R+fmm471u6DPW/cAIyCN+Bu?=
 =?us-ascii?Q?ajEELFMXH6UotRPxQTqWYsUmqjf/32IFaiZB6Z3A0ukJZtTTg11BqyZXl5n+?=
 =?us-ascii?Q?ChH5A3bFMx/9AcDjM/SJpwwEtoM6E7e332z9ta0DBK9CxtzdycbxPMP4q0jl?=
 =?us-ascii?Q?txZ4kNW3im0t51TuX1llBA8HEw2KnqtqHhBdu6XRg6gpX+wDFVypKLuLAUGr?=
 =?us-ascii?Q?IE9DmCVBnTP/t+47U4p2XxJPMS41rkfpYrF+/t695AP5m3lsITLIy3oMY1Q8?=
 =?us-ascii?Q?7/542rNvfvF83kKtdVKVOwbzY/GpimtszgL9Vv3q7XGUNeshCYJjET3lNtdT?=
 =?us-ascii?Q?WdBinBGfdwNueXEm/XyLb9cmFZxCIsVHYVaTun39wzCCTRepGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RgGVnYDazW/K4yh8vs4V2QwvZ4ngJJrI7xO4bahva5wsXq2mgjxsk2ZsYW+g?=
 =?us-ascii?Q?ilt/1LItaOHsa2bZ47LaVLPvMNRsRcnk5p1d6zXhvzUGe+2ER5dN4tTdiV7r?=
 =?us-ascii?Q?no95e4T0Y+bszequ4OlFCIbdvP+Q8/Xbdbm622t/GXU3Kzr20t2xMF03anBO?=
 =?us-ascii?Q?Ta6s1thu0Sm6YmvZsdquw+9TBdFRrmhLfS6R8pzcTYqEmudLObNG5pNtTKHl?=
 =?us-ascii?Q?+v2ebV3VUKQnrwMOghNvyWPaWwF0BnRizMxEtRW0jPlXGRYz+dBLQAzH2WO9?=
 =?us-ascii?Q?4HjOCEKweZIsXetQF26YsPUW++68vmUETFMh1go1dlYStDZzcr/h0Si3WOO7?=
 =?us-ascii?Q?D5T6O5UmGOMuIDwYkXVXnL6KZR84g36m/BgvzimTFU0//j/2XwwiHbY2C/FS?=
 =?us-ascii?Q?BP534eU1RxnLPC7QNh7MK1JyTNKleaNjixn0Rq8Cj9iSA//yrDfylz6RM7ui?=
 =?us-ascii?Q?WFvQW+nK1UtPYPl23FL1N8fRCJ9R/zIHlfWtMou4hU0U7OpIIVlu4hqzUjAp?=
 =?us-ascii?Q?zgu0PquXYN4uTtzX0/o/tmQGRO2Ck11qrpG3eYMVdSs2Y0dkKo6HgstuNi6L?=
 =?us-ascii?Q?ZEyLmr7Ug+D32+rhibRgBCsNy5DfkGLIZhwzPePYR3eZsU3W2lECRXgQztwD?=
 =?us-ascii?Q?itZUj6NbKsbB+vl1gIJLf1N3cR6MbRJK3RTuzzlQaWI+VorFXRA0A4DhylFz?=
 =?us-ascii?Q?qz0D4nKJmkqH+fhmp7XkaAfuRDYpK5/trm8kNuXIjWoY4KYeJWtg+eYAtkDM?=
 =?us-ascii?Q?ETW9b2L7vlhU8ViYDVIAsHtMNXgQVe3jqC/YLhkFHS964i8kp7CMfkqpAMIe?=
 =?us-ascii?Q?gF1tKmNewI2WyrYbmxmG+XrWCdXaob3IdfYR6ZFFgmgHnigeGG2NTtpBe5EC?=
 =?us-ascii?Q?aWepu3BSNBD1JuEUjbdagTLAQhdeYqY6c5xH7Sx2dtIBjO7xOWSCZ6CjExYp?=
 =?us-ascii?Q?xg5kxRytQJv7zNaeTNdz39D9xD2EP/XsGOZxh2rwrT93RduPrA5A/ortaBGR?=
 =?us-ascii?Q?n1MT0W+brG6u6eFgJFjUqpIq8LZk4Bhub9dw70qWvHaemoMqODR7UBKRTzlX?=
 =?us-ascii?Q?qxm6MA7UA188j5RKp/qiQ17ETw7xebBe7gVY2PU/3gbvUA0IH+4yIv7op0XF?=
 =?us-ascii?Q?R018ajVI895F0k8uC7neY0Ky/BH7mL7eZaTJ5Fd7uct1Hb4VqkyMIZ5WDbwt?=
 =?us-ascii?Q?jWERJEbwbhgVkvhh1bd5e7bNDnSJw5BBG2lKmQapewJMWI7pVUALXwIb5OV5?=
 =?us-ascii?Q?pbUTYEzTkiNPdIdCZuCaMupnc5SmcqXug/ryzm1AjsOX+cSo49HlidOjfyBJ?=
 =?us-ascii?Q?0ZTwzMRZd9c2vOkS88AzJiB8/EdgG+S8ZeyWoJMFS/ZXPNjG8SHe6RtOhkav?=
 =?us-ascii?Q?d7mfuD1rOfH6t4kBY9QP5/zs022AOj0hPTweh+vQRIEYaIzPb3g0HHJCbFFh?=
 =?us-ascii?Q?b9YLk6/mVlP69OXFObmkqM4XEvWov56eAEFuvf3PMlQSgzylnjxSELJMI17m?=
 =?us-ascii?Q?iLWtCVd+LQXBohbwV1C/nD4one9PRQ/fa6lNQzPTNi2xl+TQLjwDDuoLt50d?=
 =?us-ascii?Q?mP3TVPEq41a7p/bOoI47k9QtNtD9jyDPeHN338na3GIPdWBLaecH60oBJIFL?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a15dd02-9e68-4584-9a91-08dcb2894d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 00:23:16.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8s/nPIjMaHcdqyHwnoGD72etUgnt8hl+x9wz7r0iy+psZRuTfyoy18V+RIO3MoW6Jmfcz5jZ8/k218bKA51zn3JDGdP0LzaL4Q0PzwWDW1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, July 26, 2024 9:22 AM
> To: Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; NEX SW NCIS OSDT ITP Upstreaming
> <nex.sw.ncis.osdt.itp.upstreaming@intel.com>; netdev@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; Kubiak, Michal <michal.kubiak@intel.com>
> Subject: Re: [PATCH iwl-net 3/3] idpf: fix UAFs when destroying the queue=
s
>=20
> On Wed, Jul 24, 2024 at 03:40:24PM +0200, Alexander Lobakin wrote:
> > The second tagged commit started sometimes (very rarely, but possible)
> > throwing WARNs from
> > net/core/page_pool.c:page_pool_disable_direct_recycling().
> > Turned out idpf frees interrupt vectors with embedded NAPIs *before*
> > freeing the queues making page_pools' NAPI pointers lead to freed
> > memory before these pools are destroyed by libeth.
> > It's not clear whether there are other accesses to the freed vectors
> > when destroying the queues, but anyway, we usually free queue/interrupt
> > vectors only when the queues are destroyed and the NAPIs are guaranteed
> > to not be referenced anywhere.
> >
> > Invert the allocation and freeing logic making queue/interrupt vectors
> > be allocated first and freed last. Vectors don't require queues to be
> > present, so this is safe. Additionally, this change allows to remove
> > that useless queue->q_vector pointer cleanup, as vectors are still
> > valid when freeing the queues (+ both are freed within one function,
> > so it's not clear why nullify the pointers at all).
> >
> > Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
> > Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth +
> napi_build_skb()")
> > Reported-by: Michal Kubiak <michal.kubiak@intel.com>
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

