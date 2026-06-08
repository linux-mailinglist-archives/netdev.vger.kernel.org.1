Return-Path: <netdev+bounces-296637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lXdjD/XzJmqJogIAu9opvQ
	(envelope-from <netdev+bounces-296637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705B658F82
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:55:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jtjPJWk0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296637-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296637-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0F536C204A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366AD3DF011;
	Mon,  8 Jun 2026 15:09:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DE3DD870;
	Mon,  8 Jun 2026 15:09:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931396; cv=fail; b=S+yMgthOpozEDsfIqQjsMsrngpqvV4WX0KsYfQXfavVCuHnp5eWbdBVgYYnFDtq6hYG2F3SFFw7CWO78+iYARWxjCxytiM946vGIx2zBEvxWpY7UhS9m4gtxxRPpjkf3J611LvvBD/o1AUIIQwL0cS8EjkWxi/raf4jEOess+zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931396; c=relaxed/simple;
	bh=QAAjiATX3ofqei0zg0YJTOiQsQsBfXakw1nqmcTIhXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QiOz0OSnEntPiPeAmQKpVYsv5S4660zn6dlgfum3AvgeTr6h6nmbdJLnTwrPMCeyjJ+1voCgVn5D/B550DvxPBkeuRHXf9y8m4AC2vlkRefQQJUfvXOyH2sFkWJN+RjBx/qTiZViFFezjf1huSruxTXgl3P7JzA9XOEwfdxWRSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtjPJWk0; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780931394; x=1812467394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QAAjiATX3ofqei0zg0YJTOiQsQsBfXakw1nqmcTIhXc=;
  b=jtjPJWk01Rpa3UNvVcH/5vtu6704JPQrdVBiITbMR8LFe0t3pt/Gw5P9
   GmWUIphCEQ9/iMdWceYfyTNkoaVCPgrIdowosnnqb2dVsGDMrM4K79P1W
   nG3fZHwKbeTfKYalSttIWhSARj/AwQba+Vyx7X4EleCKnAkSvZK+BWw3K
   s9tEQ24DWbQpDex7atSGtHiRdneYh9i9hkLc7/wbywqQ8rKqRHUsePObu
   4/Ogatuwua5ABEFZhZOGkfJjAeE1GnqxW+qI6hA2mT2Hku45ch3/OW8v5
   zLNOWrxHyQcdBsXb7CFX7PUd2gGU1OpPsLNmSw50B3a27N7tIno0XTb8b
   g==;
X-CSE-ConnectionGUID: TBkJWw04QqCZm+H2f4B2mQ==
X-CSE-MsgGUID: oiV5Oa6TR+a9n20In/D2cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85557768"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85557768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:09:53 -0700
X-CSE-ConnectionGUID: p+XMafufRhG2+B/Iham83Q==
X-CSE-MsgGUID: tsF3vJzGQrWTyp8kX8n1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="245631909"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:09:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:09:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 08:09:52 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMFrciYv5iFKj8YIBw5pawSHZcdIxUzLvvDaR1W4JsZRhnj1GKZYMWeEhTw/OOe7zZP6583IcRw29S0HabMCjY3/bJCYPaIvDJyyBhKUCKL+FVNJW7Z1Rb9p33CNzKyUvYgKjaHLYiW/wGqRz27gGRZkbSq17RLIr67tUHHi8bh5Gh7Zjl44sW4pBsfvl1U4E77+f1jcUc3xhARgThET/VGVvM3gSxDj8g5x1MM/w9gBlmaMuiT2A7HVOZcmZQyFABsQL2UH6+5wwIspox5W6hbyGXXEu6gFSKjzFTjXykOdXsH8ormkzd8dWe+XPMFfINPvoh86GtNi9rATLkHvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NB59LdjtL3kTaG4ctlQG8nDQfJpg1UOovzyR/cnuh4M=;
 b=q+3UTvrwZDxd+4l+TL6/C9u3aWRl0ae0eJnC8SehpdWSfEJqKprgu0KFd+G9sA5Mb1NNs9BI4umQQOLwvBdvLDW7HlYD7SYkYzWbBLlFJSp0bDyszXW7Ih3n3YidhDJ3WCLFS0GFNUPi/jGfDHtVgUbKSc4fCbRXFUkNPnAu7k4/qiaGllhNXidKbaWsWI9N+1f8bPFpdjoloAsk1jEpXY1Js5Im+gQZDETg+BKh2extA16J1NjwNyfTuqyiVgMEZBF9xvOlae6LxeQRhBaO85fLDJ+qKReNvkG+iuAssOJXtK4uaZajwNBB4FW7czpy4QhBMjkcnDARQLraQMcRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN2PR11MB4631.namprd11.prod.outlook.com (2603:10b6:208:262::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:09:48 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:09:48 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 06/15] idpf: remove
 'vport_params_reqd' field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 06/15] idpf: remove
 'vport_params_reqd' field
Thread-Index: AQHc91UFA0kaLPGokU+CZ/HahIwBybY0wvBg
Date: Mon, 8 Jun 2026 15:09:48 +0000
Message-ID: <IA3PR11MB89868ECB549539C1AEB18004E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
 <20260608144127.2751230-7-larysa.zaremba@intel.com>
In-Reply-To: <20260608144127.2751230-7-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN2PR11MB4631:EE_
x-ms-office365-filtering-correlation-id: 93c3eda8-41c4-43cd-be44-08dec56ffb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: rLPSQ9660DR4GkXf0nYCdJMgwnkH11bD/2DumnZp/TUT+llMGmsgQ54cp9r9B+hpPLOvRq68U7GtHIQXjRSTMfPwvgyueF1mSQh/6nGV7E1ttEPU8264lQkRsgx8BLhmV7XBQ81A9M/WoC8BY60Dyt4JPJ6zNFgFKg2sFMtqA8d+APb0XELuUEix3GEwpe0GtNsuhk241O/s8oIckessRSqNkRr38AAhOEBWUuqQZaZv+xMEeJDENuvQ1iq4llKQZk5d1ctUQte/XmsWwdmsPpAgg5Qu7f5ZBXokiHPKA69TiDYF7UGT8I8Sd8pl/9RB7wrutsY+2kVffMx4u3xQeXxKOrv50LI9gyXyKTW/+ujZ/QJJZdC9O2OmI3pMZKaYKTyaQURDEHOEZ9QujM0G6T05MGfDXYY8jKrmgKg5uFVM7a39nPzQQSz+nh0FG5OZFteZggISGuLBNF9HczvNvfeeIGcPeo5y+PmrnsUB9iuV0Nt8pmYQn849fPZoqb1oPCVOFgXqwTr+QBFh1JdinTU1eVuMBFqZXPG4VWNdoIXTj3rc6AOAr5ZAiLIBA43njtHDd3VKNkydoaqqa2ncz0ndvhQMrkcbhzkQfzs23WmAIz6gPDAKFc0Wps5nOv2f5Oyf2SUvUli/8+kcwriYj7Y2rrVgFrkTdV8gcLa/KvuyBh1hAw4GOGy4z8IwlhMAT1kgIVcAZCHOpAJAV+1uJ7Bbkp/NZfgE5E93iLl0y3dgHPUISsbb0pCR+kbGTD0y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?26/F5ITqcAX60qSIsmpkBtTkl9XY72W50CQyk+1FT382k+SruhVGzjQt0VfY?=
 =?us-ascii?Q?DD47AD1PgxmrRaxA/JtvT+kgZAZwAI2sc0tBy+85Jxv7EUj2D23hxZKDFcKT?=
 =?us-ascii?Q?AKt7kaiUGOJaf8YYvQgoTUD/BHgpc8m7DXiHqOM2fhLTlpAN7D1gR3pjEVX/?=
 =?us-ascii?Q?OcqvzzpZ+4nV5C2t7REqALtSB0wXKnpFqz+la2zEAZHHkcd08UFsk6Rpnj7M?=
 =?us-ascii?Q?9Wg/k5XzYlhOBXIY3Qsec4qYQgWHyywPOTpwjMIQSKUATUjHq2LTFU8l79Ey?=
 =?us-ascii?Q?xAYWYMHg0ZSPoy/PeLZ1gX0P2NM8U9AUar09ApeJoOUg3cWSeJjEzA9abhRJ?=
 =?us-ascii?Q?+1RcmSAqNOOTjKcQ+ecsHjxxEZyB2KdN1jgSUGoB6msuNJtL2QhWk9/zspD8?=
 =?us-ascii?Q?mOJ8E4Oc5R2A4TLJmzcZeY1f9pLJnqeSA6NyI1/6wTQcICA8XYYwTLmmyL7R?=
 =?us-ascii?Q?OjWhTvRorAvkw0IBVhnP6yL+0LLpyFKpkERHIMPWvHPlELK7aH4TqclmD9YB?=
 =?us-ascii?Q?XzcHgo8BP4NjQjm84aqzETOZbtkpfBVk9lGdoIKZaQ4b6Y1XSMfWz/R8hIOs?=
 =?us-ascii?Q?itaaw/VxsYPAha9+IU6ozYFFUvxPrjtyV5++c0u5i0SLyl5MmAISjW7Uwfoo?=
 =?us-ascii?Q?5Tq372sl51HxbMxokLVIBqXx78mF6VBFiPFkRiyqdjy4uebPgHlZpcZvihKN?=
 =?us-ascii?Q?ITViKtfII3/mNVih1gi6zlzT+0vV+ZQj1ACG0JIj1NQuCPGX+99l2ocFsQbH?=
 =?us-ascii?Q?yjE1d9zJ4AC9CrEvm+jjnsNZADM7+5pV34HxlWIPbjl0/vOBvKLo9eom9o8S?=
 =?us-ascii?Q?VWAuigcGxtjXE38Wo5EV/HBxmZEWXI/hxrA+ozpEsfje3a5P04IEM3Uh9yFc?=
 =?us-ascii?Q?QLYTrp3Ai0XWisxH9mSBhX/fzG8Qj9vj5r3uQBpDoJ34ojGMB/rj21p+wsEk?=
 =?us-ascii?Q?NrcHQ9f5gYmUM00nYwJ55bqVDxmDMptMGdgwsIaANaOqXztwjIwz7iNOAddJ?=
 =?us-ascii?Q?KlWRQU6lR43Zi+5zJjXk8OO8Lmh/WLK9B3QPmpSQfE8yrIQaGX85fntwbBr/?=
 =?us-ascii?Q?ZgwWBNytCpUkF0dtY4iOAzn6H5IPKdPVkFb32qGu8k+MKmXIeIH+ve/depfd?=
 =?us-ascii?Q?z/Xsyp+dXlrxHEKMSKwMvU04LQk3AxEDzbHk01WFpf9sG/T6MKPX20pAqjgc?=
 =?us-ascii?Q?u+mbnJ6lGXkyTCpRXU8qfzTJOUbZ/zcA2LUuB96oNiPR7ftMqwIfrRWRjtfg?=
 =?us-ascii?Q?GJpfi+e/fZIsTZnf4z/EGbps9Z1t4g2Hon5fRc9OCmpUOHmyA8HxIPi9lt9r?=
 =?us-ascii?Q?mxDOA9sL7aZ5R/XeUwU7zgYXf8+X/unleVRoV0I1INeItiq1N6KTZWeTVfpY?=
 =?us-ascii?Q?GGiOk6wkfLFnED57HvAynZRWGb6R+YBtHdO166ebukQLxBwqNJsBfP4Yex9e?=
 =?us-ascii?Q?y96aunW60kBN2NtW+Hv/VQXx7Gg5c9cacdTqT0SXUWrWmCK5RHaOtxrrdJs6?=
 =?us-ascii?Q?aSufeDSTk4lpNwYDdNbFwnqqjVrKn5veKqOjoAZFeramMB//Bua+xg5jne3p?=
 =?us-ascii?Q?VryAzxQ4yJ882BLaJk8pFE5HazRfaDHv+zRC0GIYrgP6xISgKFxB4hRJL1va?=
 =?us-ascii?Q?yfI4k5rfkU5MaQ4d5QqFH1rg8ofEq/Y4pNB+CSAWS0cWHbU0Ta1jOT4+cLKw?=
 =?us-ascii?Q?VCQCBTGX0Sf0XBHRkI0Oc718DNI3bZCUj4W8c49A7SreLhAgmDCeF1Y/Ux81?=
 =?us-ascii?Q?CCcqQh47zV+k/NSne+2rZ0dPTT2zIy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WsCP3aPeRC6bnWp6oqX890tzqugBJi6G9FrQymuC9KtVPo7IUMd85jdlDvBQqPBKNEddo+TLVsDTFYNsmAFWBvOoB1H/8fHtmxf0HqkqgUsAVTfCc6LrQOeLoF35pu1JgEZ4nv+Z5TnUBf7hkzcLx+h4t+qqywlKC4B/ucKieWUViVW4LV4jtNBJhmhTYIS9NRAqGaDCI8yqo4aVS9c71XGnTwRC1nh4LrAYxHqVTdMcJRPKt8y3NQglKfNtgQTv0wBpDd9GY7VnzWLe9ai/Ck0wCb6iiDGXhvLe8e4sD0D3+KxyxnZK1wn6aVkjnFL2dRHSvaDIB/AsGKZmEXLv/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c3eda8-41c4-43cd-be44-08dec56ffb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 15:09:48.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWcPFxfNHommrXzuaw1beDktp6/gdwL9LUY/PgKNgXhSm5tivLctggoboYkiGIrc6VtFD2YGwbrDfe0SH7zfrkagwVP3LlDV0lY2uwVCKV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4631
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8705B658F82



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, June 8, 2026 4:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
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
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> <samuel.salin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 06/15] idpf: remove
> 'vport_params_reqd' field
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> While sending a create vport message to the device control plane, a
> create vport virtchnl message is prepared with all the required info
> to initialize the vport. This info is stored in the adapter struct but
> never used thereafter. So, remove the said field.
>=20
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  2 --
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 --
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 30 +++++++-----------
> -
>  3 files changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 984944bab28b..c5e47e79a641 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -638,7 +638,6 @@ struct idpf_vc_xn_manager;
>   * @avail_queues: Device given queue limits
>   * @vports: Array to store vports created by the driver
>   * @netdevs: Associated Vport netdevs

...

>=20
>  	adapter->vport_ids =3D kcalloc(num_max_vports, sizeof(u32),
> GFP_KERNEL);
>  	if (!adapter->vport_ids)
> --
> 2.47.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

