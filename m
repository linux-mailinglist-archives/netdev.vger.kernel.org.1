Return-Path: <netdev+bounces-294820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bA8GJppMIGpx0gAAu9opvQ
	(envelope-from <netdev+bounces-294820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:47:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D5639623
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:47:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QeFhQljE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294820-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AF343075FE0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4CB390CA3;
	Wed,  3 Jun 2026 15:35:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBE3A3E96;
	Wed,  3 Jun 2026 15:35:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500919; cv=fail; b=QCoUsarmHofWIUfig7u8pUwJGHhC2LBeFdZVHPXzpgu5tyoNqCuAP2TRUPzo83T7i2WTwrha1B9sGr7321P1YA9iboCjMHXZcCNCYsO/v7t4rAwDU2b4pj9wUROJP2iCWrgrphdkfRNTGGl9HyQGP0XnhFrc/bhlKEXdqSK365U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500919; c=relaxed/simple;
	bh=YcU3QkXB4NgllUh7vsmKAFtx/wt6+hu3WKfityMBaBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jB5PSdnLIJNnYt5oP2a3s9Y+Elt2sgI9mx/ESM3yg5hvFpbtaYTdOUPaWX+S3Nl9hOEpOLxeBl5QbBxiN9rXVjsRaOvNWdWLSw7aKebUZ4dvVUXyHhg2CPQrFMsbIlteFmiZHe2IBi3NMN9cueaJwsK6O70ZXGBEpBetRhNL3Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeFhQljE; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780500918; x=1812036918;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YcU3QkXB4NgllUh7vsmKAFtx/wt6+hu3WKfityMBaBw=;
  b=QeFhQljEImcjG3dMTEb87F+RduvibH5ndrhDn3V0aIymHTBoqffHAZ2i
   LS1+ea/H+DQpsQ7D6sc9yX5hXPlZkCsnzS+2te0XgoeOpCoYsbmIs0RXH
   8PX6dUXbzzYG8peS10CFHbP8CVwllEhPGea2UHXJ/CMYUI1NoDgFkWZ1Q
   aDfnavPiIdIadathC/7y+CwGaOPpOrndjYdA8ZJZOG41nWwrfPDNRuXGM
   UgKwlIRDphrnzXhnY8dAdvl3N5A+Usa5nnKBXz4XJATg1Bm8X5r6q3JbG
   AGyTMEGWmBNte8/pNgaF702HvCPyFWuRzAl9PHfA8vv6lUACRA3VZPUGS
   A==;
X-CSE-ConnectionGUID: qjnf060OTxOXrrJa6cXKyg==
X-CSE-MsgGUID: UNhjAsPORxuZyCbz4b73EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80457485"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="80457485"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:35:17 -0700
X-CSE-ConnectionGUID: Op9pfJ/kTrih/bzm8HA8oQ==
X-CSE-MsgGUID: 30gT3e4LTPy/ITP951sM0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243210536"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:35:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:35:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 08:35:16 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0KHjYRQCG2JAuOZfuPdhRKOI9UyEpJIGJEutFR3KSbvm2daen50XJ9BaKjZuMVD5QJx6Eo9pI+edoBa2QqQHt2SnY8lKn5ftnZRhbVF26NNLyFnlE9oJRo3Ap0hsvtTFBXq7Avi3QmBIzlARngab9qZTVU1Lmur8pStlVYMNh+05HPBYh4VA1DQuh2mxMwxehHx42Fy8hrXU+owPgUn1/XU3ib/Q1ndZE/gNPAtx9l7hoLBwQdQgvbQDiVVxd4oV1xvAHDj+hDxEAxGF9x4urcIb7IlfD/twOLuYS1VkM/xdHVG5zaWPig6IepO34rxKQeE+6nxvGUwZChyOsuadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v+8Yjhj8+nEMMjsMQXFqaXolp5GOLFUdH3dszsTUv0=;
 b=Qi3MX7+YiyGr8x2ms+Gw1Ye0q04OjHGRBivWojARsWGAOP5YIipZukdUgLJ8goAxs6Lvz8CoqRez+k9ygMXjwUXBSatV+AlYRkFneIpMCyA6vRdh1S5B+jwNYdGNFc1g8FjqoWrUgJPa6CRMhX1pw0NCg3GGMm/ktZ+mJtkGAR85D6l51spJDHV5VdQu72sQ0DdEeD/2CkQYxtfzwLtPEvpOcF2uyhSnnrik8dAsEK2dmDVjzcqYUzsUBtFyGfLlB4KgPMFt/jzuYAu0/W++BG0PSh21yaDknlycJh6cOnYhKsfY3McyBmN9TNttna5n21zQ9MFoIzqPLw+N2X0bhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7775.namprd11.prod.outlook.com (2603:10b6:208:3f3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 15:35:11 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:35:11 +0000
Date: Wed, 3 Jun 2026 17:35:04 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kernelxing@tencent.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests/xsk: Introduce mmap_size in
 umem struct
Message-ID: <aiBJqLO24O9k1QzG@boxer>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
 <20260603060327.298389-5-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603060327.298389-5-tushar.vyavahare@intel.com>
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcda2cc-d954-4d0e-d3c9-08dec185b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9/c6azym19dGBWpGNCt2kISsSClDJwLVLxLzyJco90PMrOYkHnePzaqpEOANgTVehW5ehZejbCgMSkosge+DOvEaRaPfLQx5mqO7AYxdd0b4ltTEHPEfXb6pRVJHpWCy8viRKhWCOfPWIkMrnl44b6CTS3pRIvZslUA4WQi5lRh+SybTYgwduOGPiK56ROF5PnM1sg5wfR1mhszKWvIHuruvZQePM1RMCuomR82DJHorr5cya10rA9ttUbN4QCqMpYSF+sVLSh0zjBrQve/HoAeQ9ECQ6FZehv78m0D8GZoebA8MMj3HocptX7IE7aSGzqm5GMFBuc+iv049eGZEk7Zot2cdj+453yO+qqu3+BdCL9sWgm3TsHpD7XBndNYUK6RPg+HgbgODzV3nHdlBDb4cz7fToJEnz/wouxMZIE7OBKV2k56dBMrn4oQtUYuOoqVVpIEsu6Yuffi4I0V3ssVxFVvIfWMXheQu0ZLKqLRxioJeAwezmMgqt11RDiAfNWAPrf5/RXUnGQkIZHFaIqTUN6BpUtdvzGSKaiMadfNN1gPh6e0baq5OFBrL+9M5WsDvlmSKKP4i0O0gKdvJf3IVW3r7jcyAJbOjEkU01fEAbLV9Lxehpj4OLWLe00jbNmsrgb+HwQVHYN3D+npuwkUNqaHMgtcGDDIZ9zyk2mRquOEnIW8P7g9uFU03SDLq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dk0FNO1SP3X2ZLzkxhetNm7hekNpWZDJbUWBLXNN0Gqbz6rtmsGy6QegrXUV?=
 =?us-ascii?Q?rOt9hq6PMJXZDJuslM39l56EkYBQOhznfGUgC+qXd5BKSchxbMu9TXnWRzqT?=
 =?us-ascii?Q?9vB51W0CKSl2T3iKu4Z37uA6yx3ZT4PPpQelyFgt9HtmEFscK9f5HrQYNQJO?=
 =?us-ascii?Q?GA5bzHVxAHY1hJXe4tV1rwOlkCV3vFHYO5P/WnQMozPtnu+FiPOoS6kUk963?=
 =?us-ascii?Q?6nQSVVTEiPoKGKzrUU81OJUNYqz0eAaYxwlHEcd3lNoAmIvYxwJTCMd8HFyT?=
 =?us-ascii?Q?0rCd+nvD6hfAhr+CgBGactslwTIBd5NEYIsHWBbGmFaLgM/Rd3u/hnQru1gy?=
 =?us-ascii?Q?DAQiZ9o6lEZ8sdw1Ll2ocUbic4kKlXfWeUP+u7xMd4XHVxMYiwHkl87qS8b9?=
 =?us-ascii?Q?qcZpTMHf4i+1EVu+8Q29OwlicyZQVW9F1UroYMTVs7D/Pn55aIPRB0ddw+Em?=
 =?us-ascii?Q?CdBdVM6S6N+c68r+t1T97yUOfxYgOM9W3E2AEXiY7fkH1G3CmGhrPcoU/8vs?=
 =?us-ascii?Q?V9Q+s22KWT7mk8M7HTfcyybk97pILSDf5ZwzrS0Ud+fDskmkuRGpt7Up7hrd?=
 =?us-ascii?Q?iOpPpsVt4E60NFAG7ipoC5oXmh+RU7UIZLfshbGFn0W76mqVNlk/R7HuFwMZ?=
 =?us-ascii?Q?fSrxXA7/BLVFl+PxHNvobLlKL9GBN7fdbfuuwcBAdmyupyy3PY8e5VKfOJLh?=
 =?us-ascii?Q?3YC47qCiAhewngXyPGrI6du81xmTTI5staELT1AFnx8xF4B0EFTU15e2eBLY?=
 =?us-ascii?Q?oM8H7OXhfck122rPNSZbUIDZDK5hWkYn/QNtDYQ5L66e6EMt0Ii11Uq6Va3l?=
 =?us-ascii?Q?s7fjnp41Oh3tcqv5OrtG+5yReT/vEuMEz0cyq8O91SNZrnUiH0rTTEfN2OPk?=
 =?us-ascii?Q?dugheP27OkydmLOSL+bHiJYcVlAD4NxI8EIN9dHjFaSkjFTXJ7vNxfcQCg5x?=
 =?us-ascii?Q?cFzO6dMxLxXiFzkYahCLombMDgxXz3wZsrqBS+D0y7Qz/VXpJMjUQkQ9rhOy?=
 =?us-ascii?Q?bMu5C4wfkjAo9JEHUvA9O/bvw73cIAI49aIDPu0YF+AClMilMnEdUT1z/oYp?=
 =?us-ascii?Q?K4kacTfoI1KjDLTicQ7jjyaVbMsRKSiedxpKgk7vg82+/pnl2cpqpixd1QXi?=
 =?us-ascii?Q?wo0LVqLVflOndbfgBmkGp+5yJ/dlqXEN1S65cdPcB/q+whmBUMl+ufgnAdim?=
 =?us-ascii?Q?RVDc6STktd0psDDRlOGU51LAqH7dRr7fmVXxsCjKEDj22/be7zK/xoQbXnYA?=
 =?us-ascii?Q?v8p6din3sR9BWl3xrS2t3FaWscVIDBj/iuQutAL3I4PfPK+TMvhZAbkrhaZa?=
 =?us-ascii?Q?hNz3njQmDIWTYjCbvGhlYp6l148s1rIZm2pcP10q1SDeiRmSZEe573j4n6Nd?=
 =?us-ascii?Q?uZFh7NXbkko/gq20LiJ+yIIwNe2o9OcYV5sqUfIkQA2xEVibctzmkCbD11CE?=
 =?us-ascii?Q?JjGy+BgVM/UIM+VfZYSxnU9GtUCUTADz7xitTKoEOQqv4X3vIWVI0JkR4N2j?=
 =?us-ascii?Q?GKcucoi6wP2CuOJEsbC6CQ25wLIY7PEW2v8ct8HU/WAqeFKs8AtnHNr6Nv0c?=
 =?us-ascii?Q?fOzFd1E6wcyAt0wF8vBU2JIWMPdFaJ8aFY49TnzXVHARZs9w2AJ0z+UYY2eC?=
 =?us-ascii?Q?Hd5j+MO2XCpapz7KDFgiGZpD5NRLwljQ0uedszBtuSfpK/n3x++46awbGZWQ?=
 =?us-ascii?Q?B3uNcCLvRlKCxL0JfYrS4FU7i9MR1mqemjxWbVXjdcLNDG8b7jVPogWOpy7z?=
 =?us-ascii?Q?4cJRCZMiI8PeUBgcZcn8z1zySqOgsU0=3D?=
X-Exchange-RoutingPolicyChecked: GLw+5wNVSWEACD73OCQs0F8fmTW7Z1BMHFvigpy7kajmEIDg7uWo2WnfZABZ3zvs3rIw9FB4fVEOxlsZUknXk67A8AECyyln9Sdln+OuoLCE9oZSMyXj5KpcVZePbquz0FvFdUan+1YgjXEgvuJot9gCWsTdEB6F9nw9ojD2/je6khHJEfaLkjUs9q3GMxbDZKHuW299ir16fXLUN0jMIsarDg5Zxkdn+MOpOw/vhgtuwGn4pXw2zwYlX02Cj3j26mzk2pcgEfMh8RqCYJ/F37tKfiq7M1zagGZDofTVfvwzFaY4oN7kbzlw3YdeE9uOYcRIt9NEeXGFxbzRdAFUcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcda2cc-d954-4d0e-d3c9-08dec185b2f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:35:11.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjnSBGzTmPM7Rm6YUEjc7LWED6uBXNTKjqURzNG5WeWEQ4VRCRtDQn03r6Uzs93CWvFV/JJCdzzydCoHgA5JQGvbsspLuY4ApUIY4r36rE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7775
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294820-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[boxer:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E5D5639623

On Wed, Jun 03, 2026 at 11:33:27AM +0530, Tushar Vyavahare wrote:
> UMEM teardown currently recomputes the munmap() length from frame
> geometry, shared-UMEM adjustment, and hugepage rounding. This duplicates
> setup-time logic in cleanup and relies on re-deriving the mapping size
> instead of using the size originally established for the mapping.
> 
> Store the final mapping length in xsk_umem_info as mmap_size when the
> UMEM mapping is created, and use that value during teardown.
> 
> Also join the RX worker thread before cleanup in the single-thread
> path. This establishes synchronization before reading umem->mmap_size
> in teardown and avoids a potential visibility race.
> 
> This removes duplicated size arithmetic in cleanup and makes munmap()
> use the canonical mapping size recorded at setup time.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  .../selftests/bpf/prog_tests/test_xsk.c       | 20 +++++++++----------
>  .../selftests/bpf/prog_tests/test_xsk.h       |  1 +
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index f1730466ffd9..e94c38a1faf4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1581,7 +1581,7 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
>  	struct xsk_umem_info *umem = ifobject->xsk->umem;
>  	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
>  	int mmap_flags;
> -	u64 umem_sz;
> +	u64 umem_sz, mmap_sz;
>  	void *bufs;
>  	int ret;
>  	u32 i;
> @@ -1595,10 +1595,15 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
>  	if (ifobject->shared_umem)
>  		umem_sz *= 2;
>  
> -	bufs = mmap(NULL, umem_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
> +	mmap_sz = umem->unaligned_mode ?
> +		ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE : umem_sz;
> +
> +	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, mmap_flags, -1, 0);
>  	if (bufs == MAP_FAILED)
>  		return -errno;
>  
> +	umem->mmap_size = mmap_sz;
> +
>  	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
>  	if (ret)
>  		return ret;
> @@ -1706,15 +1711,9 @@ void *worker_testapp_validate_rx(void *arg)
>  static void testapp_clean_xsk_umem(struct ifobject *ifobj)
>  {
>  	struct xsk_umem_info *umem = ifobj->xsk->umem;
> -	u64 umem_sz = umem_size(umem);
> -
> -	if (ifobj->shared_umem)
> -		umem_sz *= 2;
> -
> -	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
>  
>  	xsk_umem__delete(umem->umem);
> -	munmap(umem->buffer, umem_sz);
> +	munmap(umem->buffer, umem->mmap_size);
>  }
>  
>  static void handler(int signum)
> @@ -1857,8 +1856,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
>  
>  	if (!ifobj2)
>  		pthread_kill(t0, SIGUSR1);
> -	else
> -		pthread_join(t0, NULL);
> +	pthread_join(t0, NULL);
>  
>  	if (test->total_steps == test->current_step || test->fail) {
>  		clean_sockets(test, ifobj1);
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> index 99003995d7c3..4313d0d87235 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
> @@ -103,6 +103,7 @@ struct xsk_umem_info {
>  	struct xsk_ring_cons cq;
>  	struct xsk_umem *umem;
>  	u64 next_buffer;
> +	u64 mmap_size;
>  	u32 num_frames;
>  	u32 frame_headroom;
>  	void *buffer;
> -- 
> 2.43.0
> 

