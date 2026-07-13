Return-Path: <netdev+bounces-307260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n2sSMPoqVWo7kwAAu9opvQ
	(envelope-from <netdev+bounces-307260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4974E624
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LWT3dswn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307260-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307260-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3895300F448
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0487352004;
	Mon, 13 Jul 2026 18:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35064270552;
	Mon, 13 Jul 2026 18:14:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966454; cv=fail; b=trGIrhqamF9S1V7DzC338bLKAqqIlak5NztvU/Y6c28zyLUqU9C6CUdOlnbhsQQ3gJCby2p+lMMI+tzf8DhnRE+xD+WfeedDOnbdb1AoV2+deF56hCl6hGYCBOiEbJUuWqJX4P4IA+zESQcW4vqR4XY4iyweYjNWPVtGUyNLHi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966454; c=relaxed/simple;
	bh=L5vC4TWf61dgqY88fh02f6w7KMLRdJQWQs3Wsdji5wc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=soGn9PaPHteMIsyOFiKEZ1ymyn0SbBwMJ+qw39Q2a7jr4Cbd94r/Mt8R4AB1LE4vAvwRisFX0RxfWkXtYAWdlgYGj/Of+Nz4n5lYMcaecWPQilS8kRUO6BS35SE69KhFrberOEmsqsqCDr7nco2qvuwes4d7C6RLs3kQX/ydI+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWT3dswn; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783966452; x=1815502452;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L5vC4TWf61dgqY88fh02f6w7KMLRdJQWQs3Wsdji5wc=;
  b=LWT3dswnqidrFLyvoQVUDCDxSSvsopUqh698bJ3lgNPu289APMQ3QyHD
   JOL6zt6nzA5SA94Lc07ktOcGxGXirdy9EvGIvG7hKp+T5vAzFdzi+TNDa
   83HjBiMIDd+qhrCsaMOcDam4gbA7AUdyRlxzrl7xrWGzE7XiI2Agkt51q
   +UlPwDedSao/+jlHDPM/WgOY7RvhcHtOHocBVC3zMSVmlFVWp3uQY+irK
   5zQDnTDUfMemPih5ba8wWGZVbtDWT1q9ioGZXTd6DpGq2QAWmxoYGsUbI
   9t7mZW/wrOD9RMEI0mo9pLog/pejKsA3aHJTlFVPVWLtY75vr5HfrkQa2
   g==;
X-CSE-ConnectionGUID: VJKsO9yYTFSMLyaj8PoYOw==
X-CSE-MsgGUID: b0wm95j9TwqPLYRUzbR4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107377964"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107377964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:14:11 -0700
X-CSE-ConnectionGUID: oDiSy/3+T+mV/Fyay7mQ+w==
X-CSE-MsgGUID: pBPqo+HlT1G374w2VCIdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255116446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 11:14:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 11:14:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 11:14:11 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 11:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghakapa8vgzxuGdVtzv1IRxC4UpuEm5Q6A7f2Vhof9wKmyJxhJlAcM912ybgiGsGS8renZSFzMDcPamkd6lAodrXBockOS0ITHjft7q96gD9ps+c8i0VBlyCGEnLJC02WkKQptY4E3edWe0+mh8vxWwdBmm5e3DcGN8Li+YISgjXzkc6YZ9/ON0r01hZ8OZfa2LNBIsDs/WkhoIuqXofYL/wEB9CzoZuuy3nvYalFCJs8vdwAxxYRNgWVyOMcN1u77CMuKLfCLyjtE9BeFGbKrO98z3j+v+uEQiyvjGLKSuaLcH26zCIMnLQBHLtzfS1OpeLVoTUu96L6qxd6XTQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqSJMtKjNpIz+sQdaPJqkMPvBvyBsC5r+/EUpvt7cbQ=;
 b=uoYe4PsscmuQ8e3JCQkHo94cTE+jeUqONmnfyMtkxiynC08WIeSfku9XLOwbiwJrlCIW0EqoTL6cn19IVUoizqHyXgv0H9kh3sN/5tQl+Mp3uI1R2sSxwOGcShsIxQq0PpXmZ+tdg6coaIQbhWQNCV5IPCYPxzfdIbzahevbTBf3UutOW4rRcfCTUb8m5uMNNvQIu60tzdRHDe+7DKnWhqWQDxScaZS2F/4dPbvrOj03BOVl2ooWr9XAIviXYIjDfNzcIKIDEYnH7AsnA64iyHg4T3bEnoW+ARPYZ906M+TbaJec+dLiEJ2sfrONEutafjn2bNsgLGIdjRLbCJ1dSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:14:07 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:14:07 +0000
Date: Mon, 13 Jul 2026 20:13:56 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<Bharath.r@intel.com>
Subject: Re: [PATCH net-next v4 14/15] ixd: add the core initialization
Message-ID: <alUq5HUVei4BSN7a@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-15-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-15-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VIUP296CA0096.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::10) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|DS7PR11MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7c277f-0c29-4588-f38b-08dee10a8750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10070799003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: M1v93XIxvbQZZ9dORezDbKWIXPmN7W9rHkAbKx3zTB0dMoQ0OjO3hlvTBFkRpEdwtgRxHJdq57QElRdegGY+yC+43X8haYzASkACP7CjpxBAQMPopS+7gPRdCJqtXwbodLuzzLIyhoPCjlXTXP3jp7Ddbp6o0sQDQWb6R39ZpZFUNWfolodHvvdrhW8G1XiG7FPmLg7F03ZKrLV7pe4c8V7VBWqJe0mGX9K3Zo7j+mX5qAhm8to5rDmNJns0KVf++dDrIWtTCWLtPz16DoNynvIRKYT7cpzAojfGZanvQCsFUH5J15UxuN6MuyHmYDQlReK6h0+sf07Nb9+E1q7ZNHKf+Vd30g5if4heQldphFSE9MrZVYph5HpEnerdBpCTOleNGpoHU65iySgzFgkjmsg4zXuu9azBy8wIH1AliETWv+dxKR1pdsYe53ZHdBP+K3iZkgklVooArUWxTNISaLzrMU0pPnQgkyC6R6g7Lexqn/mPHWdde3dJRI0QyA1GcPNG1d3qTBPkfNBXXZD2ONfQgliCjNR4ZBjGXuUOg1A1li+TpBBsLSqnqu9e2lB0xxXy0/CfwXjXnCw3y4fTzBdG5RCX76aHFot9G6SszWePlQGTm0O0uxB6B8J/R6Xjtoxry9yZgN7xOhCXc/4H0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBTahto20wUZEzsECoWxvytiLPpcGXso98keraRn51KCT45cKwD4sWAmGdOz?=
 =?us-ascii?Q?KYMkUrHck09HSWURr0YOEF5LXeitJSqkTvQYc9KjuQ0b9Q0HNJBQSpKaMHdm?=
 =?us-ascii?Q?gELdB+iAnFJdGlae07ekbU6iNoQka/AfHgRfGyhuQ7x3SsoR6M+24xPR+ooX?=
 =?us-ascii?Q?nwDQbW6Ts5VVub/fN9FKfcu+sIi0wOzZD6SD3TrThQ3zHAaUW4LhjuaePPbY?=
 =?us-ascii?Q?BuAFAtodKsP/asACxx0gws0erSCLRN9yrS8yBSo5qPO69jz+xYSU8BfwZ0Wv?=
 =?us-ascii?Q?iEC601ylTOY5zU8Vu34JGy9bgWHXGzxHG7iM1iQ6li32EmdaJ+eL0G1THxIS?=
 =?us-ascii?Q?rbmnsxTzNRT23flaSJajlVHLp51F1I/Ggho/Z4k4+GYYWDWQmse4n0NoB6jA?=
 =?us-ascii?Q?HoS47gvHQy85nMxTPQtzQS0ApuUB8WrGS8lDj52mUrCTXkrJimgrRbdcOtv9?=
 =?us-ascii?Q?FEHfXWdNGHnzsCyZeLd5IYQInuHaloQVUNbVB7VnaeLYDLnHSYGwvoO4/tkH?=
 =?us-ascii?Q?1yOYPb5vxFUvIW3Wg8iyPMJLn4imzRLtGdHk4B4Whws6VOMPUzAnHmOKbYvm?=
 =?us-ascii?Q?fEA7lnq9x8VY9fZpigv9xnyu3nc8ZJfXLiwNeO8jtUTP11/VXRo0aHiEd0OR?=
 =?us-ascii?Q?ifo+/2a1MbEFYQ+BVblbty5UczoWGAZ1f5eT5WEKGOIw5s702AtApMNDPmDV?=
 =?us-ascii?Q?HllZph+gXMDJCPJm7Hh++doyWawpxU6cUTEWTyLhTjYc88KckrS2aBAWSxMS?=
 =?us-ascii?Q?dthvggU8ISwTc3cYCnOkc/FWYmXbB+Y3N8Iv21tr635xzWyedA+whPf6hfob?=
 =?us-ascii?Q?lvtb7hpZ/NkZwkC04/8J9/r+j7xoCxhmkuFDe3CNqvXtcCbJaVxwXY6fcmir?=
 =?us-ascii?Q?DtHTwx+M4Ui/mqKaVHAMu22hK+Ljb8zk4P7lcQ+GV873GVdC6F3js5bz7hwD?=
 =?us-ascii?Q?HN6F6GRNAyu5wpLkHA3gF2jf0z1SqtF/dx180VLWPvPy1GFu6omoQ9WMV/7y?=
 =?us-ascii?Q?nyPkqXooZV3oId73GvAsp5gGhdLu9GKGMzEgF9fVYFJezJT/J9SQRRlyxZPI?=
 =?us-ascii?Q?excMkldZWE7i88TcJynqO6c3n/N7+Yv1+1pWLD2Zi/TetVp/IO3E7BGzjQkL?=
 =?us-ascii?Q?CPLa4pvvoVkpz2Bh5Ex748yiCnJhlwbFh/v+mkDRISuBdAAIuvRZz+Xip2Ix?=
 =?us-ascii?Q?AkVrvhVE/yEvh+X5Z7ByWbWe3v2wZgM28lFdWKW9HZKo3lTarPNYqrFnrXMt?=
 =?us-ascii?Q?ZrcWDpaLRZ1lRSKTOerBPaIeoaNEPURlZU96w4sJuJVxZEkaQjDMVoDG5VCJ?=
 =?us-ascii?Q?ScAkvZV+5+ewhQ55UpoYIoldYPwk0X7pyV2FqaRaKmLHvod5oQLorhahy1KV?=
 =?us-ascii?Q?AF24ITrG+tpT9WHGpdTv0a+vKSdkhdf24AdLWyIzffw2eeGKckH3UfS/PaKX?=
 =?us-ascii?Q?e2MfpjONlQcB1EAaFaj90ovYfOwes83PMtATrrABqhIS0nNI81mt3H3Y3S1L?=
 =?us-ascii?Q?tuMRmdpEsj+gJOUXFENb4I/AS/2YXt+2cMTyrxqgWa55w7Lgl9a7S/0C8ni7?=
 =?us-ascii?Q?Bfd/wl7iJogB5Rbbap2MFMSiBrWhPoH8YNrp5+zhYfyv1LhGwDYKnkSK+/7R?=
 =?us-ascii?Q?iwA334cPJQQ1LKMpTyfytJMcGsI4k/36l1xB2eVUBrOJUHvHKrNoH0r0yYH6?=
 =?us-ascii?Q?gGC/UJ9wzaHm7l4XBHPDkbAaTZK6PGzBciwmZ38/ANcGR6dzG4/F3T93Yrlp?=
 =?us-ascii?Q?XQ/sfxkMZsTenpmi5BT86/VLqCmqPfXxE6IOcMZGKjEAqM/vLOK6r0z5eKOU?=
X-MS-Exchange-AntiSpam-MessageData-1: REb4tgWvmoW/g0nZK3mdvk4//J2h8M90MnM=
X-Exchange-RoutingPolicyChecked: axFf42OfjIateABUrbIXZrt9c+m9OTCcu6ztQH6KPUbtXZEd0xCAdaJPhcl74QNz+JPmhLIwXbDxzYYEtoWMJ9RlGXJWOCV+w7c0DzMlxEC4vQ2GLDCuELQeNcutYzZmfHx6eRNOps8OcnqQ7nMzeH5yS44NdZblDbUt+SKnG5hk6pSiisxCSCP2lzvzhW+xVWqZbiV1lfTRn3m+c/ptk5N3c17BpFOWjsTCU82u/qlvJbNCUBiA4MgTDUDkRqxiEa00v6crYeC+69SSEQ1ubHju32yUJiHIEULzhrPtDV5LUZfstJlPGN/+XqeM6JL/zTWFiQRrcizEAZ+lYHmlOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7c277f-0c29-4588-f38b-08dee10a8750
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:14:07.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs/hvzt1kFyf2i75RlzUc7/vW5eAuf5uor43NvXLT6dGLuGBhxDQ7oASYEgkga06r1oHeD9GpbxXgpRX1MZopIKTd9tX1cupAXAWjooyLRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55B4974E624

Sashiko expressed concerns with virtchnl version handling in ixd. I think it is 
fine as-is, but here is how it can be addressed:

commit 736215457094a287aa8f40af322e0bc7ab94dddc
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 15:44:55 2026 +0200

    fixup! ixd: add the core initialization

diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
index 66049d1b1d15..5b04769443b9 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -120,8 +120,11 @@ static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
                return -EBADMSG;

        recv_ver = recv_buff;
-       if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
+       if (le32_to_cpu(need_ver.major) != le32_to_cpu(recv_ver->major))
                return -EOPNOTSUPP;
+       if (le32_to_cpu(recv_ver->minor) != le32_to_cpu(need_ver.minor))
+               dev_warn(ixd_to_dev(adapter),
+                        "Virtchnl minor version does not match, proceed with caution\n");

        adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
        adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);

Everything else:

[...]

> > +	libie_ctlq_xn_shutdown(adapter->xnm);
> > +	ixd_trigger_reset(adapter);
> > +	ixd_deinit_dflt_mbx(adapter);
> Could this sequence trigger a race condition causing PCIe AER fatal errors?
> The hardware reset is triggered here before the mailbox polling task
> (mbx_task) is canceled inside ixd_deinit_dflt_mbx().
> If mbx_task runs concurrently with or immediately after the reset trigger,
> it might access MMIO doorbell registers while the device is actively in a
> global reset.
> 
Not an issue with available HW

[...]

> >  	ixd_trigger_reset(adapter);
> >  	ixd_deinit_dflt_mbx(adapter);
> Similarly to ixd_init_task(), does triggering the reset before
> ixd_deinit_dflt_mbx() here risk the mbx_task touching MMIO during reset?
> Perhaps the newly added polling task should be canceled before the hardware
> reset is triggered?
> 
This is not an issue with available HW, and consistent with existing idpf flow.

[...]

> > +static int ixd_req_vc_caps(struct ixd_adapter *adapter)
> > +{
> > +	const struct ixd_ctlq_req req = {
> > +		.opcode = VIRTCHNL2_OP_GET_CAPS,
> > +		.send_size = sizeof(struct virtchnl2_get_capabilities),
> > +		.ctx = NULL,
> > +		.send_buff_init = NULL,
> > +		.recv_process = ixd_handle_caps,
> > +	};
> > +
> > +	return ixd_ctlq_do_req(adapter, &req);
> > +}
> Because send_buff_init is NULL, will the driver send an all-zero request
> payload for capabilities and resources?
> Requesting 0 max vectors and 0 RX queues might cause the Control Plane to
> respond with only the default mailbox vector, starving the driver of
> interrupts for its networking queues.
> 
We do not currently have any queues

[...]

