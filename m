Return-Path: <netdev+bounces-121485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F0B95D612
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791781C21909
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B819148F;
	Fri, 23 Aug 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4FFABvL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96C12D20D;
	Fri, 23 Aug 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441473; cv=fail; b=BprtVJAiRKdtIK/zA8Dw5uRdSK481VPMnPwzcF5N8WkAGCy8FWWODCNrB/BY5LlhQugk+bgQQUgBdZqJOsUz6BRESNolMJRGg+FqUYLeXkX6bqejmA+nZgnOoM8HE/6f7LMl2tVGFMWQjIdq3bfPcS78AjDXg267tDlHAv7k4g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441473; c=relaxed/simple;
	bh=W31sfAyyrvRWBR7e/WRkgAGpyzm6GNVAyHu6+KnVmFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpV889bHt3vx8Y6Q0dioN+olSRigMY7nHBqmfI7HukPsQc592OijASvIwjQcpaXNm4zXhEoW1Zees+nfoBlwpr8lXGe30nWozvHf5CbxHFKNUZ59uIwJucdImVfIi+rzq0fQ9eik77XyRRNxSVXiyikkFoYV4BKkaNmZvmuteV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4FFABvL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724441472; x=1755977472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W31sfAyyrvRWBR7e/WRkgAGpyzm6GNVAyHu6+KnVmFc=;
  b=T4FFABvLmOs+on3K8acfqg6IuF0EAErxBsAj/WhSrsSbhHvKqHlblNWj
   1CIe6TNDG5RJYZ0n3X88WFyfE3E2YCgV1Q62hFh+jmjZuJbXAugSIQFI2
   4GlVlB3x6XdTbq3FNaLNUeO/B5qUEC/azqyNNPOMWOA2LD0m1ctpjA4fv
   5TXQvga5j9IA00UKfB3qDkrPm9CFzxLSZ1apCjw4W0k7YuRBDqT0wCuDF
   uPzvFc+qBF50S0tIeEOeKqyy6+KT22spvW2tGXSV8MbgrvTXStg4t0VU6
   kESjp7zUkXXNe3e6eaIMGw9WqQAhpAMuIoFT8QRuqUTsWVvumc2+NlDXN
   Q==;
X-CSE-ConnectionGUID: ksAybZK0TJiOM4yrCGmFqg==
X-CSE-MsgGUID: 4W9pgteCTQGvJ9bx4e0PLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22792704"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="22792704"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 12:31:11 -0700
X-CSE-ConnectionGUID: a0yuPGqoS7iLh0dPbF1MVA==
X-CSE-MsgGUID: uL4iPvqFTV6WFtxu4sMmjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61744999"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 12:31:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:31:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 12:31:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 12:31:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 12:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ8q0LSYkp+TqGJZLZHpkhua1SEUlmOQi/i2U57KvGdUExYrliBXIvrHLjTlk9Ydg2LcF4AItOpUprn/k58tl95nT7uQyKBe4HLLhrXxDJ1hXx6MazaxfwixdO3FY/6jpIp1IZRqY+lvgVRDwclEct6bd5oPBbVV1JItgTfDB/k/0DFBm0ZrLvaxXDr03wGdWciu3vjAqyb+SiWcBbKAV4/1BogOVzUjdIl7vBV+54gyyXy74ZGDarm1pApkrnxi/hCqpoQHOOfswU8UrYl5X0Zv23gkz9qS/IE6vk8z1wHepiFUpt29esA099jdcaHZVrfc89glnkfW28fjfs/ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BnMUT04VLzAZ5/rtHH5yCmSuaMT8eEnurOIP1inqp0=;
 b=cj/3CGx3tGmpHziYXz9EQ3ZVqFodaERSIeWOmqimfh8htBiH3uqWSAkNtHXWJ9L87PYf1JRBNzG8Xq/v9/7kHBDHoQSgbY1cN2JumoSZ43KDu4QjWuCLbb6wK9BFbP6cG+yYVSF3payniNROeIuyVJWSNYcfbOOleUZkm1lK+2pibbA8HtnA6qZmNNcRWUC49TxMpkHKG4cJd5NBitvjWvu2Qadjwt1amrcbkxu0v3DSkZQBXPUGR0Rvl5F45niVYpnqODCqeoeEesULj9odgNP6/ZmaJRPTbHyyx38KBrW8NMvlY7pC4ituuXl7TJmRmDpgGOl3iJxjqSCzI8Q+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 19:31:08 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 19:31:08 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Topic: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Index: AQHa9TkQuCaSryVCCUmbqP20abVdm7I0p2KdgACRUgA=
Date: Fri, 23 Aug 2024 19:31:07 +0000
Message-ID: <DM6PR11MB46578FDE21C9E875A7F3C1BE9B882@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
 <m2le0n5xpn.fsf@gmail.com>
In-Reply-To: <m2le0n5xpn.fsf@gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH0PR11MB8168:EE_
x-ms-office365-filtering-correlation-id: 4dcb48ce-1ebc-491b-ed53-08dcc3aa230e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UhZbt0mXP0QyReiPuSqQGZ561m1/+cJT9GBD4ZYXQbcRYlx2/ZQ/Hpp5DPqf?=
 =?us-ascii?Q?mg757nMJI1mKjH9RYwGYmAD7PQ0MRkuLqS9rzrlSAadUGH2u43IdtxGi9GVy?=
 =?us-ascii?Q?eyjb/+JOnbjhw5kd4yOIL2NxR0zXTGb0gjOZnzWQ7jqKikA/IbboCC/VORK+?=
 =?us-ascii?Q?RKrU4YTSFiVOin8BsVtBeC60s1/2QjkanUU/rT3s+Z++6oA6fRZic31b3hQk?=
 =?us-ascii?Q?pBbqX5pJtV8tTFxz0g8gkQgrx/ADzJu3D6kVlMm4uxl6ybtFuh3lVSXDOtRG?=
 =?us-ascii?Q?L6BubcL6WXYeHljtvzVNwNycmRaGBJir2lpdzrDk8zE+UWScsm+cFd6GQTEU?=
 =?us-ascii?Q?O2E90Gq1E7zgnDdbqN/tqSNw3x6ljNP+dh2WEH+1eVAUO7r5tDymv3n/ar2x?=
 =?us-ascii?Q?RY7P8FjGBcYkcmRrJGPahB0Tw7r2Z1kTN5T8YWsCrYecfK5cSKBQD4oNbsnv?=
 =?us-ascii?Q?xPqdKEuYlmoXl1kAne2s6J0MwvblZbn8b/622s+5UsZXPrKr+RF5QFw2f/HD?=
 =?us-ascii?Q?ftFRSlcCpSIPS1GB45Ig+7RE9kGM3TrGD73kqx6xvPJTVn6NbQYCjpGAXjU4?=
 =?us-ascii?Q?lQKjDPX/aFFmHyYi1UGyjDHaHj9iFj4c5461JdpGfByzFEDMp07BsBj0VL3b?=
 =?us-ascii?Q?4nQccFGs5U4SjPBskfzLRj39lLAAj/7v1cOvjjU3kZyB6sSmuQt0GjU69gis?=
 =?us-ascii?Q?EIbgnJsXIGk8U7tT1nDhCrfbqanHJcG0s8ymshKQ/6ClIGV+3iqhy0+0rgFR?=
 =?us-ascii?Q?1LpkCdaHVfsna1saaJSMcmUoYbxP1WxXGVW3h6a1vCs61nFC6fqOBURyfk8Q?=
 =?us-ascii?Q?mWcCJFEuVe3ppwidHpfaQ85ZGQl0GNxkjRv4/CGi3lqchF617wDrgAETc3CR?=
 =?us-ascii?Q?uMCAoV0FY5S2FivwYRP/oHnlAlJYVzrTpL5ytemWhnU9HHBK0sOunMx5MzAV?=
 =?us-ascii?Q?F1AQiTdYJtyGVIA9c/LUC0W4zUDbNMPZpobfUJdaZzHH78MgGrR5DTF2d/Me?=
 =?us-ascii?Q?BIo9Jyk8J84Jok+tQHYg8jsTJp1aSnRL0pOb/6nj7NzPBIG6Q+ui14DMn47H?=
 =?us-ascii?Q?NazmKOTdxs8S1Ns5mB2FKK2wipbdx3qzPxOow3rAsKr48s+adjifi3Dzcx5q?=
 =?us-ascii?Q?8xCR9WxIAfJb4If0gdaU9oOVbvFUQkxLSlODJ6YPy2X/uNKlcWB8Z03fF1kP?=
 =?us-ascii?Q?++PmvvwraR19zYbNGw23f1F+1rwLOgFiE0uW5HwNNwT6YBVuM7nr30qlIxya?=
 =?us-ascii?Q?wFNoFQvVJ3ZMFUWgEcuYAWweopCPtWu4A/HOEwkETJIn/EmZw5yEG/C/Cc2L?=
 =?us-ascii?Q?Wh9vA/QaEvX1eiqp3Ana/4ASOX0qCwSkCN8mBMTdMofDgqtqyBDYKRDA+1Q9?=
 =?us-ascii?Q?k6NiKTrawzwB0nItnhrkVmMZCDjqVTLeYxVCRb+LqebR89yM7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6W68oFpI8A2ZzgrT+xmnDFD/1KAbUt67f41mmEMLKzi6sDLaOycUUs9zxcu6?=
 =?us-ascii?Q?oh6jn0yuEcjZIEWyqxBEMHOdUPgWlOHP1MupSbuWig73bR2av4jIqy2N6t1y?=
 =?us-ascii?Q?yj+lHt8qF55v0EKRrF3zylUqwfriS2frnIBoEcAZS0k5nd+DAecV478W4jAe?=
 =?us-ascii?Q?rCgyqMHDmbd/QVOTKm60uMegbkmOYQ0GbSvneyfiMi5IeuV7pjlyw0ppAN8k?=
 =?us-ascii?Q?2WFM1DfjGbn4pzw+I1SIlrSk4ng/RmRYRHi/Mn9KWXmT7rtKJJ4PzOUJhOBk?=
 =?us-ascii?Q?FDnxCfxg3i0CFhNKSfIzfci3mGiJGHtw7hmM9hWjAsS+MBHVGTHx6Yuhcny/?=
 =?us-ascii?Q?ayyFguD8NlnjGaTAQHQOJSZsJ94rJxNkrRAEIFiBPhZJ0hsoqrp5A4z3BPAm?=
 =?us-ascii?Q?Oes9Jle44XMTlBs41LQgRv7JsUA+3LrwVyAef8c/K6KmBImAqR2Uh4vn/JeH?=
 =?us-ascii?Q?ocEHpy21AaUSlgdnwztlEk4pxAF6NUptA2xqzi1rUh7UgPGuVoZDdvToJTVB?=
 =?us-ascii?Q?BqSNzT5Ey2+keznjFV/F0hzRN1scPkLsQNB/PcMg0MX5noyWkIRL6XjZP298?=
 =?us-ascii?Q?Q/1fF8vAOPZvQ1mvU+72hJCMx/lpURWaMFTCBu5phWOo2CBdW73GWWYKliMI?=
 =?us-ascii?Q?XKxDevalEYl99/AGIjl7ezMDi8nRC8BVl88Mkvuh63RusGk9nbx7H7PTNRhs?=
 =?us-ascii?Q?nSVUBaQ2ImnDrLclYzAv+7xLnUHzSNODtwKE3K+CTssz36Agxowe2pXmpLMq?=
 =?us-ascii?Q?7na+sGQ86E2tEnmqeULqzTv0hv2t4lPUBXbomfPq2lnN4pv/aHed2qsFdNWH?=
 =?us-ascii?Q?zuwujRJSXqX3gaeUPOHxGgyk07TLScM+VLk8d49nIIaqMx1x4RdB5UuWgiTf?=
 =?us-ascii?Q?zLKiNwpub9RHE4WxSH3xrI6FH59hN25PLyOJ3P0hwcmL34zjJxQzy5MOB58p?=
 =?us-ascii?Q?7Z0KWI3Cqsa5B6rCKHFV8rtthupE2RHLW5JdRcNXu02iS+UWZgYCeMlSyUXS?=
 =?us-ascii?Q?B6r+Rf7EzD4OsEz325YHkqkwAeY0Z2GALBEykR8A0PG1KiPSu9ueEiSPKg2a?=
 =?us-ascii?Q?Ws0bdehvMjnRc9YLmUZZ843G8rOEpM8OFy1QllnX9UIVWWcpMHJVqZzVKkFY?=
 =?us-ascii?Q?x+c9yWNQHaW0+a+474GAB37YulACMtBa8yTc0wI6A3a8J1wE0zEE7HvNFY0a?=
 =?us-ascii?Q?w5bf8p2kzeNfAbVPvjoD8fm13yetpRKVtuwSTTDUlJzOiCr9+Rl4kijoRM/G?=
 =?us-ascii?Q?24Hqx8rI6Ae3qK/WeXlNifzXi2cddlvqbn/T+cx4+Pjz3w85pWcKhqMKMybW?=
 =?us-ascii?Q?CFm81Mh0gHFiAfnbgSlH1qwAogj5SEdzYTZIGjvUaXlc68eD41ahEoPlUCOi?=
 =?us-ascii?Q?XZEcrcYBKsvQ28NLHJ1iOxyF9+aNnsmKPPerlt+rF2t2yjUgj6kuegD4NNiG?=
 =?us-ascii?Q?wTwk7TluxYimIfl7S8eW29xxtPvCi8fvJeQO6eLhlFlp79hh4f8aoip64Oso?=
 =?us-ascii?Q?HwX8RESVQAgZfc8WqdZmWKWXm5NSZ0xkcKTY5y4QQYlsGyUs8BpxFdEkbe4U?=
 =?us-ascii?Q?1LMyAcvyG2/BHJj6zJAKl1AuaV2iYMSaNvyd3OlWpfg3JVBc3QajCNnonhx2?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb48ce-1ebc-491b-ed53-08dcc3aa230e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 19:31:07.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SUcwfdaY2TEw7C0ql17TD8p3Ef/KsT4B/VmJF7nVNo02c21bjBBrfjFuE/j5cv5CI/B6FnNy5jNDpLbWhX1krJ2NpiXEXjwAWv6kaJyDuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

>From: Donald Hunter <donald.hunter@gmail.com>
>Sent: Friday, August 23, 2024 12:40 PM
>
>Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com> writes:
>
>> Execution of command:
>> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
>> 	--subscribe "monitor" --sleep 10
>> fails with:
>> Traceback (most recent call last):
>>   File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 114, in <mod=
ule>
>>     main()
>>   File "/root/arek/linux-dpll/./tools/net/ynl/cli.py", line 109, in main
>>     ynl.check_ntf()
>>   File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 924, in
>>check_ntf
>>     op =3D self.rsp_by_value[nl_msg.cmd()]
>> KeyError: 19
>>
>> The key value of 19 returned from nl_msg.cmd() is a received message
>> header's nl_type, which is the id value of generic netlink family being
>> addressed in the OS on subscribing. It is wrong to use it for decoding
>> the notification. Expected notification message on dpll subsystem is
>> DPLL_CMD_PIN_CHANGE_NTF=3D13, seems at that point only available as firs=
t
>> byte of RAW message payload, use it to target correct op and allow furth=
er
>> parsing.
>>
>> Fixes: "0a966d606c68" ("tools/net/ynl: Fix extack decoding for direction=
al
>>ops")
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> ---
>>  tools/net/ynl/lib/ynl.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>> index d42c1d605969..192d6c150303 100644
>> --- a/tools/net/ynl/lib/ynl.py
>> +++ b/tools/net/ynl/lib/ynl.py
>> @@ -921,7 +921,7 @@ class YnlFamily(SpecFamily):
>>                      print("Netlink done while checking for ntf!?")
>>                      continue
>>
>> -                op =3D self.rsp_by_value[nl_msg.cmd()]
>> +                op =3D self.rsp_by_value[nl_msg.raw[0]]
>
>I don't think that is the right fix. It would break notifications for
>raw netlink messages. The point of NlMsg.cmd() is to abstract away where
>the op id comes from. GenlMsg.cmd() returns the value unpacked from
>raw[0].
>

Well, me either, thus the RFC. Your suggestion makes much more sense than
my workaround.

>The problem is that we are trying to look up the op before calling
>nlproto.decode(...) but it wants to know the op to check if it has a
>fixed header.
>
>I think the fix would be to change NetlinkProtocol.decode() to perform
>the op lookup, if necessary, after it has called self._decode() to
>unpack the GenlMsg.
>
>How about changing NetlinkProtocol.decode() to be:
>
>def decode(self, ynl, nl_msg, op, ops_by_value):
>    msg =3D self._decode(nl_msg)
>    if op is None:
>        op =3D ops_by_value[msg.cmd()]
>    ...
>
>The main loop can call it like this:
>
>nlproto.decode(self, nl_msg, op, self.rsp_by_value)
>
>and check_ntf() can call it like this:
>
>nlproto.decode(self, nl_msg, None, self.rsp_by_value)
>

Yes, again, this seems much better, I will prepare new patch and send
the non-RFC version soon.

Thanks for your help!
Arkadiusz

>>                  decoded =3D self.nlproto.decode(self, nl_msg, op)
>>                  if decoded.cmd() not in self.async_msg_ids:
>>                      print("Unexpected msg id done while checking for nt=
f",
>>decoded)

