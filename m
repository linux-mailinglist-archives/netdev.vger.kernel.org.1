Return-Path: <netdev+bounces-244302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3BECB43DB
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C5B30274D6
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD254302CB1;
	Wed, 10 Dec 2025 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TY/9i+yj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD32E7BDF
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408936; cv=fail; b=FRzFIATY3aA48j6btpm+zcDB2ljx0LcFhVfTiPR87TI76YVaHtjAQpC4wUzF7Uiwk2UU9ccKgtDY2mg7NkSXX49E9xaP5j6yR2jqwP2W6QSutLQ+cQkrRyBRYa44Oc5lXaS+SrcN8IjcDXqL5ti42Ii75av2mHO94hFRdDXiZA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408936; c=relaxed/simple;
	bh=dJuWI2bSMPtvA0sG/osGP6+I21ZxFTcowlzYFKe0ygc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBHLk/LvpdGxOCXwOXYotf/vEgYTMgINwlTUx9tJWSbhHnpsTtsyhTN0U3jl/M5HCPGRCqIdhAh4PH+HCcLbYypeZR/0NdG5c/hoLvt1MURmgI3T7QTI3M9gaeIFzxnctVUhQ0AFIeO5ajV9ZPZqL8l0k0QGufOYZPyjNGSP1NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TY/9i+yj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765408931; x=1796944931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJuWI2bSMPtvA0sG/osGP6+I21ZxFTcowlzYFKe0ygc=;
  b=TY/9i+yjUukYQMLlbLKaksE0HmBcJhke2Mk5Xn/URt4b87niB5fR4RHO
   pDJCtalEbnT1QQi5K1F8wQIlXsxWuqzQv46aCnHMDi8pZOOeTLPDCCcgJ
   6zYW38NG/jq5xKbUe4ZBcKVbfudr4ZON+7+ed+HLgY4ZqkbF84E1Mm1cQ
   jYW63x2n1SGRrnjItBQhknPe6UwDehGO41Nud4RQIGt9ASJrnzxeI6naj
   9QavjvAP3L/2gqhsK7ik9nJa6NzIlRVDA+Ef+QB5gETP9xsB4G6d2sgwO
   kD2r8LiubIjZ9xHWpskB9UA5hN2FYvYwwNq9diY4wS0bM3hV1EtizvfA6
   w==;
X-CSE-ConnectionGUID: jjyvC4DCRVCnrsQm5bKBMQ==
X-CSE-MsgGUID: 2qjAKd4iRvi8RBfJh3mV8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84994701"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="84994701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:09 -0800
X-CSE-ConnectionGUID: W3OY8x4FSaSuKHoKjJ5wdQ==
X-CSE-MsgGUID: Pyk1JtycTpeRju2c+PllQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="197445230"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:22:08 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:08 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 15:22:08 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:22:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHSX4kIEsJ1DK0QVlcsykVcV+3jiy9GIpfehABDhad2Km85pwwcj0h2FyOG90wPDaDEASdSLZEWCScQtB1WP0gCUnW9pTkU3MWMtRPnYS6NlUntQfL3SNObZDRLkd0PFTFwD4OKbjAD3nQfC4hw2zYXgl9wiWd/7BBXoicipjs7b4NdPo1LBOZ9JtoNs+EShf0K85xVCuUA9W7CtOb+7l1O7Elj15f+hXwqBRvj4yk6Gvg0+1SXiG4/P62AFcptW9hnJdW0T3QUVbVOcdw2zWWgE4PYgpNqUW3WsqtSTQZv/oyIRrcpN2wvmllLc38QgSCm7GzrlICkVinG2owPjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJuWI2bSMPtvA0sG/osGP6+I21ZxFTcowlzYFKe0ygc=;
 b=isglGcZeY5BGiEwnp2tAhj/zVw53PccdQbp9epvP3HVqGuTzElSRfJxl4e5aa4xjDqQV2lKoWR1rgD7VXLcsYtHK0S+rcM3oIYVzqHenNR2JlnBRs06EhKNv7+KBF6JCEfP0+0+83HdIUs8TJYkPoBBltgZjtEdT10MEdO/Pp8Vl664K2edIz+408RZELdwW0keI3OieZl3Q3xH/KmmD+WbbY6085bMD7gaK8Xu2Sev3KtECANQKNjIMQ8cawqqq7WG+qP86fGBOkIYf/J27gp4BMEBSYN9BQZii5NmQ9CfMw6AaPmpGVTXIwT4f4vPNEStfA+Fb8IeL7ZvKIKJL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 23:22:05 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:22:05 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 04/10] idpf: move some
 iterator declarations inside for loops
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 04/10] idpf: move some
 iterator declarations inside for loops
Thread-Index: AQHcVDTnU6yUmaX5uEiDR5ilsxUlqbUbrOjw
Date: Wed, 10 Dec 2025 23:22:05 +0000
Message-ID: <SJ1PR11MB62970B888023FC699BCB462D9BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-5-joshua.a.hay@intel.com>
In-Reply-To: <20251113004143.2924761-5-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: a063eda2-74f9-4608-b674-08de3842eec5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?uoZTDbNDAOC5N1WyjbtQTTnzXM8msfl8AH9ynVlEh0oeqEVeHVHHdQGW/g9s?=
 =?us-ascii?Q?sMS7qqMspgGu4SE73Eidgx4HAuJ/QnxxbPgUhJknVayMkBhzCTkCSM4Rr+xx?=
 =?us-ascii?Q?xR3mPqDaceOyQHNCE0xYSqet1KK/3vwGQ87WS+S+Gj/REA4hk7ldNvjSQnLu?=
 =?us-ascii?Q?8MjwgEpdzMPNoMnczhEKuIeC155dT2zcl2ARvSGqGn9xl62NIH7NUpeUIM69?=
 =?us-ascii?Q?ky7IzD/i5Wz39eWEGRCo30c/IlGgszQQ9GRlY7QThIQqTDNDEDimqczG/zyA?=
 =?us-ascii?Q?Ej9Bnlzgt7GYY+/z/VVsuwbOxg2sCmIQBE8OnFxHcoo1z2BX529pqcdIwk+h?=
 =?us-ascii?Q?gzySkQbf05IVbdN51m02ilBTK+5hK4rM+lAHgo/5lhUEghitOz28Es4cCAEU?=
 =?us-ascii?Q?RaZ0VXHRYQ+puhlsE6bKRrTJM4o1ZYA5ABiYwWtnZwQsTXGJl7rqQwSpqf5W?=
 =?us-ascii?Q?8Y3QJB8PXny0jUTHwNgwQnQNFwd4CCXM+Y4hYcRCPV+WjE6EjT20UgxtgxNq?=
 =?us-ascii?Q?xkRBk0hmV2ryO9N27b6B4F1uE31OBFKwKg2Qc7qZ4RRCr4sxCaNy+S8/DLae?=
 =?us-ascii?Q?tbjSi/U1mIlDuHOvPl1Q435Z2Gn0f3T7Bx2fxlnRh4E17ahTd/tlKWY6F2Fx?=
 =?us-ascii?Q?rSmm7XJ4G3crwikCozEMu9zteKaVsz9Sr++i78cEfbC1jZtXscBZUitamKHO?=
 =?us-ascii?Q?i69XikA+DoN6KQzsydmbQPBvBgdqwS9JcCX5f7P64H1l4c2pneOdb+uSmu44?=
 =?us-ascii?Q?XNAnKUJsIjbE6W+B3Q87MJTfwjohrRpIOe7gYlDmcgjYR9YmjWjkNfwqhUAi?=
 =?us-ascii?Q?oAmXYtIi2SompqKv9eTntjwD9z3OmBcxdciUXn0piWblpTmUQHdUYJ6+t+/F?=
 =?us-ascii?Q?m2ugZhoaZopJZJBOuxzYc7yDmTLSAK7Jn/aIvzN+KP6fvm+UuVrPVvR6tLh+?=
 =?us-ascii?Q?w3HH75bss1E8i2+kfa30BzKRkx2DCW/MQ2nFcK9yNzr7sV47nMXCbZ/ybAof?=
 =?us-ascii?Q?aCEFODAO8nj2eSdTDNzBNkIDw1LvtR0QgvvfHpxR4+ISW/H6YSO7uFayS9rw?=
 =?us-ascii?Q?iA+r4PwGKHm93mGK5AJycGD+7rzJybqUBOCwMh5A3XOC3fogARpBUHHQKAYK?=
 =?us-ascii?Q?0/7RqOe+6qiIBlOoQ3FzOycrNORfwgntdb/AYN9MsECXfTw7X33/0H/d+u73?=
 =?us-ascii?Q?ECXyfmND3w6Zfnw97TFr8beJc/8u4zHq79RoZMN4M3wShaD2RD+NFNhMxkyq?=
 =?us-ascii?Q?lzYGPKABeTIlZYY+nRZDr6sEsAiJKQIj4z32ePtH74OPv9jo4nDwUalbMPXP?=
 =?us-ascii?Q?pcvJ+ACDPgf4uTDTHMbK0wXrPnn3ZjhxKNomCh9EkYQFU2aooAxLCmBnz0jF?=
 =?us-ascii?Q?HHd1+gjEa0jfLp83BplXqcZt/NNvh99EQhNoZPOq1HrWW+3JPYbNnJ4BKY/x?=
 =?us-ascii?Q?4uUJQgOrjc+AnsCmiQ+xUWaCoGpEWfv/xc5EDZdEnNOPZkDCx9yK8Myp/hXs?=
 =?us-ascii?Q?FNmA7iFl7vuRt8RpU2NxGIvHDBSlNpdK5iej?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ih7JTeBECnxK+ga2DjAw2axA4HuKTfmUCwsYseom7Y+hk6nNyqy4UXxUiYpu?=
 =?us-ascii?Q?+XFmgKB2mFLrFLvUlo781/9xEaK3ugJZi/Qjiew1mCKwI6qNa7DmIwR/9T4B?=
 =?us-ascii?Q?HWLkqv8R/dD26lm4fZvRvySc5+ftrihAMIItCxG5xFTx10fxw3cf3ntcbeCx?=
 =?us-ascii?Q?tN38LffDQjVJSdOXIwXXlm361708Jxl3xY2TbAWUwXtPqMNtiiHk7J+l0pBg?=
 =?us-ascii?Q?cGX6ISrIRFQlYcrA8jXfTl7fjYg6kZkoDTXj9Tr0uVW2JsiLrIWqb2TGW7Nh?=
 =?us-ascii?Q?NFux4XN2Wm/P05spWipIyGqqHjIy8QzBzpH5y3/5aYKb33Dadb5gFgtpOI5j?=
 =?us-ascii?Q?ONpOkkMZ4tLBoOS3K+iSWiN5EEka1hzZ3jwW3QvdbSLF12yyyJzaMixStWEa?=
 =?us-ascii?Q?yPvrtUiG9VEalPCWepYkHHaCH3M8ZQ5vx65kJA/tCBMWUhJ3g2PpSB6KUGkl?=
 =?us-ascii?Q?BNrx+cYYwdHycPo0qJXqKkoZX3GC/FpW3bweD9EvAXHBdQOud5SLZDPJMT0j?=
 =?us-ascii?Q?lZlSu5rKV9KPV5W5UvvDiYKbKe5WkrNk9U0IszUrgXBeE+3MGfUsEkRAh3XE?=
 =?us-ascii?Q?Jzpb6QJ/bcuKQpuxeVVtgvwaAZFtdMJvxrRNnb8ru6+M3FO3PbfybP3wJ/qR?=
 =?us-ascii?Q?f/rpOXBckXYPMwoI2eqY9cvrjXg50KIZiTSyTiC5+zlgOE0+HA+MwW81m2FR?=
 =?us-ascii?Q?0FZdxljgd0QUj00ivLT+CYVWV/4zafSYAdqtE/kfhhDTxhrQfDeYfI5DRbeJ?=
 =?us-ascii?Q?xzBknPCmP3j3X2VhjMTeLrEOo/Vh0RKt1oRJHXjogMV6KngDj1cRbcaBYk0o?=
 =?us-ascii?Q?Xk5J3CrDIcBExby5mOrb2HNNjhyLkXaRbO3pRyyJxi8E6agNs/dU09Jm+/IA?=
 =?us-ascii?Q?OIxR7g02NYBLAe/CgGOtwhjmgVh8QAd68pLBxu1Xlonch8iP6ACh4Mmjagkm?=
 =?us-ascii?Q?gqh9Xq+zImYacSIboYl/qgIj1Gyl82Pha3WPVMiVBzyVGPr2C1wsB1BSsnN4?=
 =?us-ascii?Q?ssbIfsHn3pTcXAxeNrPmGJrZsuctOOQ2VC7LJXF2y1booyu+3iF1vCbgrbpH?=
 =?us-ascii?Q?DvwZAdzLnFjxlvSGaqdEKhDXLyafpYbONspkJ0Kh4819TGIEiB2o0xzmLpwN?=
 =?us-ascii?Q?+JoGTRNwbrP6ELjKraG8TfeCPRDGPRDQmlaZQwLuML1WC78vKiB9eep/QHXZ?=
 =?us-ascii?Q?csxFf89bzH32fmoT3NLPWP5sEAxviVULXZfhafRXAIWL11L9W1avandn7J79?=
 =?us-ascii?Q?FS8ojhsmGR2KxB6rHDcHVcMf2DMi696vcDvPFG//pNaIEJk3qlLpIhB6JdnP?=
 =?us-ascii?Q?58/hJkcuyG0lZzLbQj+j0HpYgUygDBJepx26mVwzrNwVI8ARuwvtDm+s6nZn?=
 =?us-ascii?Q?EpfRfFhR4ec8wX1PiidYhYvm7d9xHGjrfeBzbVfPIw85jqAwJRoAditfDQ4V?=
 =?us-ascii?Q?2UFgqo/GqnR7/fb2I7GV9UytTZ9ZXyr00Vt9CoCubWmAXikzOnvNM81MDgw0?=
 =?us-ascii?Q?JNyst9UKN07141HKWO4bN+kW3B7Q+sXdEJOCSmI3YtcgkauHRfdzMdck4F74?=
 =?us-ascii?Q?xS8bKU3kDHjODF7H2WeJ/P0AJIoFSIHmxU4HK5iN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a063eda2-74f9-4608-b674-08de3842eec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 23:22:05.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ewf0yWCfddnObh3/9JufZQ2UUucIbycGiweVCFceyCxrRE5MrUA2eDJ0slkVg+t3pokSd7l2h5ila6V9f6RP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Wednesday, November 12, 2025 4:42 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v10 04/10] idpf: move some
> iterator declarations inside for loops
>=20
> Move some iterator declarations to their respective for loops; use more
> appropriate unsigned type.
>=20
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

