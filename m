Return-Path: <netdev+bounces-290376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FzGOA31Dmq+DgYAu9opvQ
	(envelope-from <netdev+bounces-290376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 905875A480E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5EE23023BB8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A33CCFB8;
	Thu, 21 May 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igkEU1wX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539933CC330;
	Thu, 21 May 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365103; cv=fail; b=Rx328r/3IdccpcDeMRe6shKUJ3sTzOMDwxUpQBNHWi9WqBD9BHKMN1h+B8/nwez1PiCTG+UEOv4REL7I38EkN6EKryyj4eSbirhRCUWKugQ7uPDNYHxw5344ic1uAIbf9wse4lRCjj3Yiy61yZkJ0acCfvEIOzgsO3/aTKr+ZTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365103; c=relaxed/simple;
	bh=vCS30JT0yVpNc8K5wdjVNU3sYrghj3uw8+f+Y4masQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DwSlXJ2V6aEImaDBIlbAQthighzS+JFWIO+LpTMEulgfohhsEoqv7CHuHJU2ooT4hG0uWZiHlfUzqAvNuxEJoFJaaGV/GIGk7aisfx0MYhn4/2n+ouiSJ4i5lbUgh4yXF+sT/rJEqIJqyvy0/WduPQQLDtOmWdf0ROLIFSLLaBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igkEU1wX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779365103; x=1810901103;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vCS30JT0yVpNc8K5wdjVNU3sYrghj3uw8+f+Y4masQw=;
  b=igkEU1wXY0DZxAXidzCC8xrt0v9QoTIzHmmANKEi5Tv88w/XTrgEhWr9
   d5xEVKnIiKHH0Ni+xd4MAeS4UW0oh/6o21TpsPy6DDoLL1EpepnAcoosB
   LX5sqonwNDnonX/xligtCQyHvo/nz2j066huDXTLFpYsbYgJbyDgnShIz
   KrJlOHLN9GFiV98H0GNxafH68j21xOMoDJC7vevkdprFXuv9O5JzGC07P
   iJOMnqO9vnk3HRpCnM6xJeiyW230sPkVo5flWlu3mm6hwPhOT9nMwR6FO
   E2ZTijfCajoXRcuFyrQmV8KA3ixYEq8hLF7f10RhxxA8kXLECAsTs0ZOL
   A==;
X-CSE-ConnectionGUID: o4mmeOX9RUyDHKJoBZ8OiA==
X-CSE-MsgGUID: L4Q2a7VRQ5OhkHh77ull5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91752540"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="91752540"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:05:02 -0700
X-CSE-ConnectionGUID: 6b0HXCxdSpmPCAgQ09GVoA==
X-CSE-MsgGUID: fzg6XfqeRLOebQg0SmpZgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="240745454"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:05:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:05:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:05:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZarPnLmByBKOxbXYDqZKho5PHnFyS4EwOJN+Z2G75MBeSk/oLE/IbS+bmSo2Tkx4Bhr+TZdavAJnAJ0dcwnJyWPTkKDqjW4PNi3FRo7Pc7mdt89fK9vgliau4NpF3VCVodWm6IEFnc1KN7bzi8if0D6n834ag7nsiJbEMqR1ua0EuAAeHLS1bu17+jo9pEjQ0S8eJoDvY0liQEzyONs604ANOBZvYqp18HmU/tr3AjbVkBNhvpma8I7vu+HzTRXxiiiXtW/V1X+NeFZEAjEO1zNEFZlM7FKLlvYA3PapDEyn4ITp/NkAuwpH9lGQjLE9msyNd75MAAY7BFlGXRhMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzdplDYHlZKMuZQ/UKO4Nnw3anCXCmYmPANP4FDVgz0=;
 b=mgiTXqiJ2R7OyMqkx97/PZz4syNEPUdVf9rHt+x3Besx0UO1RhZJ4PYuh0aIK7V2kblsINNkq/VkrJZ3dBtXogyf92pAe+4lXokQ/zr8dgp9adxmtZrbihRZhI3/rB//DfCgO0uH2tm4TnXxkOmLR/WUmZ3ATDhV1GkBjpyPL2Ls70qVHmYoeT54yqovjx6J4pJW4+MxAfCfdqB7kSZNrWYbHH+/inox+ML2AvOf6DWZQeMaBm5g5LftjeYVzLXRlLD9ET3VDZcUyHzWlQIEHF1UMtTIk7LCyS9lZFl+jFsBl4tvFRcpX4gXyhyGcP2FpGtI7hGWaH/D8zZsvu3hqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 12:04:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:04:51 +0000
Date: Thu, 21 May 2026 14:04:43 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 1/5] xsk: cache csum_start/csum_offset to fix
 TOCTOU in xsk_skb_metadata()
Message-ID: <ag702/kGzzo4R6pn@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520004244.55663-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e563876-d9e8-458c-c019-08deb73129a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4x1uALA55spChBViYZdctPgeOlt6JXr0mdetYyNm33aSrkvyCGjSnwXtNzPZvch9NqdwVfYuvizcx9MuO6jv7sutW9oUv1j3UdRGGHtEAwrOsOv4+TgDG+hHX4V2jn+puJvtwuDhQLU8hbAcPz4PBTjVhaVl0YSxHX2YaEnjioOjYJykJ/V2ijg5JbShSHhIIfo+P+b0AIDV6s00YFgpYFy4kcOz58sVgzFH70l5HQIE3MTdWggh2LFgPfa9lvIF48oIAHfZdstathDjdSWLQ1zHRKZqlbAC84arvcZ+5kPtmiBnObEMqFS87My5/IzCZDPFXxmeHd2VEPD74E7SfkSPjh3Tdy6eyonCA3ktMzGfp5K9Q4QPLvcW3XOqLX74hxAFKLXLxOuJGvC/m9dSB3K2WjzUjrTewKUWrMBpeNLG/E1avcDBw27bAlDQPslsc+1qHOILdIvc6QwOuoi1GzJLywxHAUO8SSVJOjG8y9QIHoS2ndcvFYTvgiq1xYAB0HD7a7aV2UL36+ZGhD6DnFPo116nS6zqXfXJs70J25jBLj597SqY15GjwPqIGcO5xcGkjrtJdA7l6YaF4nSwyp23ESIdOqiotzh5dV2U04VeqN0GagteeHvdnf4FDABMOkEFhrbKJy6Et56gJ/dB/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+GqnyGY5TqmABhrppufGiZU7Hdk5GY0QXbLwNLBBdx+yf8oBuz8Y32Ir69a?=
 =?us-ascii?Q?dfl6Tj1lftK2U9Q2OLCbC1axS9nUs+iHLOTTHlYzZ3To4i39MyOsIEoidCac?=
 =?us-ascii?Q?9k61jd531Md3DeF09gJuIHoEIqkwg1WWaq4KuT8ctrr6dKwb8I+un/XwIyhc?=
 =?us-ascii?Q?RxfgG0Sps/Q4u0c585bevkUtSkd2d2QLDniZavG1UTA+BaqRQJ0Hf8Lu2yL5?=
 =?us-ascii?Q?MWEPdz69A5FtHagZZUwUCe/dMxklQJZ8dQcPo2q1No179LwmgxCiPzEj3BXk?=
 =?us-ascii?Q?KWUnYI6BggQaA8b+qt+mkhAcpMm4vjEHOqDgj1PoLqHJz8FMriQZuc/r5yla?=
 =?us-ascii?Q?o57YKMaM7xO9tbM8XdMBjetdxkFOf72j5i67TyKDiLX2vdlQlnUehM6e+Q3n?=
 =?us-ascii?Q?NYkFOcYvq/tV0b9bb+fhzEtqbIlecJ1oZe/nXexqam5i/h6gF+2yGzHXEDFA?=
 =?us-ascii?Q?bf2WXQmj5y1kP97mOwqd/ZBXoRxvsTuFXSVpuRYalVxEkypEr3D9MB5U9zk8?=
 =?us-ascii?Q?LB7mPCJvwKilBVj6oQPIxxNVlTgFMGwGSx3Fhm+A/Ao0MnS+EP1KgKJFsnBO?=
 =?us-ascii?Q?TgfAxCDA4GGYQDtDfFnfLk9NgaBlhyT7Fvv+33unjNClnV2Yc5j6cOsWcfHg?=
 =?us-ascii?Q?CszNfjwoEy8j2BcpOxyEqDcs6a3YymuJbr/b06+0H7IoKmPtklExF61BWte2?=
 =?us-ascii?Q?JuJvdOeo2sTpv3nSy4Alc6NvPIbq5pUplHHfu3CVBd4bHINmEAONOkmc5186?=
 =?us-ascii?Q?WyMrSdWUvOVdIx54F0U5BSmnJRRi8Iwo147PFgYVENIRa7t3yE6fiqrSdqGp?=
 =?us-ascii?Q?7xmFwerH3ITiWD20LSjUsAxT4jcpjRGHz+qLvwo4McYGAVIBJEFQ7FU0VV87?=
 =?us-ascii?Q?ws9eDez6VZ7vIYp7kuXjL3ROAWDxVRIu3ZxFXP7MFzEFz/0RuTGnXp9nkmwY?=
 =?us-ascii?Q?qdNQKVSzRdwA/CsD5st0m2oqH2kBv7vLSZ1cbvi5MQ2cC8soXaHeMTlosApb?=
 =?us-ascii?Q?2T2AmM9jfOqGe5yKUoeGvZJNs9CxTPhll0/Gy7daKrfS3EMA5PWUA7MIAGYX?=
 =?us-ascii?Q?/8fJ2rzWywhG6zYsh8qSLN5H9d1fw6zUaF7MvoNvH2m+isWG42lSz9UeORnp?=
 =?us-ascii?Q?k1md5fz4YNxxFM+rELtpN14mhMWlSBlBWTgQ0q1fnfVlFOvM3Om1APa61qRA?=
 =?us-ascii?Q?u140g+9XroNNjKDdCbx7W4+sQFeYiit/p5QMQuVd2uXuW1Bj9fWnHSJ+RU6m?=
 =?us-ascii?Q?lfTbHD77wnIRoYj2H/NTpxAQX2bLUa6vMsHLhBmGst21Nt/yGCamqUizINux?=
 =?us-ascii?Q?EKBvO0Tx+TgM27XT0nNbXflnm5aR6Ka2FFKL4jAlcvDlnBOza9wRUtH5kbh0?=
 =?us-ascii?Q?oH69wrgm1KVzey8eqzxYDCZ7XGs8UpSmYqIvow5HWBazUFQmD2pXr/HZ5AwL?=
 =?us-ascii?Q?VMHeWM28B2xnO4HpvaaXGZ/e29MyA4KZMBXsje48snlXQFk9svptGlHsEZ8f?=
 =?us-ascii?Q?pwbO6ZGHSLmexqZeYOhvecPzXhASmlGLULiLa6m/gSdsLr1Ov7ZhnkKncJO+?=
 =?us-ascii?Q?da28FeMX6F9LjU7NlZFqD9wtNt03IHwQckdnLUAuJRuP1z5d7RjUEsrwtlLo?=
 =?us-ascii?Q?5WSFrO9lVRIgZfMuef1rrCQFvDfPvcFdWxJPojoYZNOgjZo3rhAGOcF15rVS?=
 =?us-ascii?Q?QgCvmMyKhd5JuIFyqY5V3mocZrOxcnACvmsB9WAcm/AEPLZbn2o7ui/O5duU?=
 =?us-ascii?Q?onNorMR+grE0w0xJCZlPO+smtDgggMI=3D?=
X-Exchange-RoutingPolicyChecked: sjG7W+UR1ZytRpBGwIc330ImuHWzdfVFROubun6WVuVjLHwdPhl2Ks/NfiLkD/4HZcjasWSiuDdWIBtPizaq5rIiIBQMaTl7yJIUQj2QlANMzkuymnBTFQrAaWIRZJZu/IMneAGTM7d/eoX2v11qCDjoP3VN/63Qg//HP9fldV7D+SdmIAMD4eoDqngvLAGGIi64jLz80uvJBaZG4u84+FBmZGI2HMoxEpt48MG1JBW8h3KYynyJ61uqMoFGgJE152+W5HW21+DtkG7ovWYWH4LEIGj77Nq4w4vDgYnnykVmmZEj2UcBVhcItxTXpimsNAlkAMX9nPe9Z+J9qJ1hGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e563876-d9e8-458c-c019-08deb73129a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:04:51.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm3kZ1FIea7yd6JQ1JFnUFB6QfcuP7SZCL6b3wFmFbA+07E6dbYBONCNbMCEt7VG0BOgDQkLokw082ZRQiVTUzWYbXGf9dyXUw/fBeDeIiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290376-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 905875A480E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:42:40AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> Fix this by reading csum_start and csum_offset into local variables
> once, then using the local copies for both validation and assignment.
> 
> Note that other metadata fields (flags, launch_time) and the cached
> csum fields may be mutually inconsistent due to concurrent userspace
> writes, but this is benign: the only security-critical invariant is
> that each field's validated value is the same one used, which local
> caching guarantees.
> 
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  net/xdp/xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5e5786cd9af5..f8c8a8c9dfba 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -802,6 +802,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  			    u32 hr)
>  {
>  	struct xsk_tx_metadata *meta = NULL;
> +	u16 csum_start, csum_offset;
>  
>  	if (unlikely(pool->tx_metadata_len == 0))
>  		return -EINVAL;
> @@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  		return -EINVAL;
>  
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		if (unlikely(meta->request.csum_start +
> -			     meta->request.csum_offset +
> +		csum_start = READ_ONCE(meta->request.csum_start);
> +		csum_offset = READ_ONCE(meta->request.csum_offset);
> +
> +		if (unlikely(csum_start + csum_offset +
>  			     sizeof(__sum16) > desc->len))
>  			return -EINVAL;
>  
> -		skb->csum_start = hr + meta->request.csum_start;
> -		skb->csum_offset = meta->request.csum_offset;
> +		skb->csum_start = hr + csum_start;
> +		skb->csum_offset = csum_offset;
>  		skb->ip_summed = CHECKSUM_PARTIAL;
>  
>  		if (unlikely(pool->tx_sw_csum)) {
> -- 
> 2.43.7
> 

