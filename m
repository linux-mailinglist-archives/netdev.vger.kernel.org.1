Return-Path: <netdev+bounces-286572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKFeNHamAWpDhQEAu9opvQ
	(envelope-from <netdev+bounces-286572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D183250B521
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA481309878B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA03BAD84;
	Mon, 11 May 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLdsV1/v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629342A9D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492276; cv=fail; b=LoxzuwxUZdDrsIPXBDk+M9g59ralVZXH0+/sWCygX/KjHchq86yPQXgiZ7php3Ws9lHqFRnxN8OKDyDnKWGK6Q+Vz8Pqvow3VStpBtDdvDwR6idIHoTADSvSI2ueLHpXAcQIA96QHDFtIqUo8uNpSF3wsF5KaOfsnWLyosCyjz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492276; c=relaxed/simple;
	bh=ur+IS6wihaPxMR9pT3JatONMbRNmRQhC9qDt84VwXd0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ik29P6bRR2z/YnSQUkJ2L07RKEWyhOKuupvtZ8OhlURZDV1exgqKI8ewhYF8e3/vb/EqD8gb68GNl930UCAJcXgKzPW0p5tg1LAYkSidSj4qf2YGIzSqDyuKAhopkNm/NUD/Nna3n7t+kYuTKNFgHCsLcYpejRaPnv9JqcSedPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLdsV1/v; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778492275; x=1810028275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ur+IS6wihaPxMR9pT3JatONMbRNmRQhC9qDt84VwXd0=;
  b=DLdsV1/vIvUKIuN30ZzM5y1vA5y+skcfBkO5aydbGTTGB0bD2hOZfqES
   7PliVrMj+MoCT9HJ40BTWJouY/6LvOzGREReNygc8aOBk0lVolqs6uMvR
   Gsrex6nJ1N28BCKaLRIXbbRppR1XzHvZBkCTCmHsEGMNSY/cAqJ7Ej/5d
   Kwh4lp4nfUm8ar8UfcGUYxU5XrOesMR1c9eRWRQsUR8jNVMJ9JwkjBTOg
   bA4EQ3CLYTwf1QNmXes0UvF3VsFMgEUjfJaq35xH/Gn7hiB+qzaB2NroY
   dOdBh1zi/KKAJtxK+vRACm78Zv0eIFGcSp2bLndW6qdSoLAOWrpal0e6Z
   w==;
X-CSE-ConnectionGUID: SVM8xz8MSamZvJn7ioLwmQ==
X-CSE-MsgGUID: IXbEI5xgSLKUaGuC1tTB3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83244829"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="83244829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:37:54 -0700
X-CSE-ConnectionGUID: VDcIG6VvSJufaIVGOwWdqg==
X-CSE-MsgGUID: jX8VOHMhT4y39Q6Sk9rfGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="275540477"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:37:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:37:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 02:37:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHdDExwRIT6eAN6WViJmijOAa47DrXAMim5Cm1pEcoVghm3KYOWrYUfzl4iedIimmH3+V7SA+6IJlEQkLpRJIu53lNow1htNlhyqUo/o8VaLAUayemFjCFhTmqiBlFTeGgueX0BM+i/Sv4tv/9r3JoBfAhjPwibc1vyLMMnmZcOQ5tVsX+dN2vd5ItrxggG9V3nec/ZM5zZVXPaYlr/qnZtbg1JUtXRz/hdxvYQ0LZ4tUIYACWmELQl7pFuiItXq282JHAstj8+hqnuatkBN35TlUObseUKnw7DnIcFujIkPfBuxnIXmZIL4aJvR2A/QPw/IBH+FJf9rYpQjS9iViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfdyIMfBaZwjVef/ySXRA1uvzgUhS1vjqARbnbClQ/c=;
 b=d/HP/tSHwlBHm7lddw8H+byZpzXVeOfOZ1CND/xf5m7IUISVakCoiPySWwDsJJP8kWNDviV1ZmFyuiCvcM5fJJTd9sDTp4v7ddh5XUNNFbplU8ltgQDCnDWoastcZFo2XThhjVHt9ISVGzMxAnLyAeJ6WO+qg6l/a+YF4Bw/Lm+p8tVAX5muAgvcQ5y7JbgpLONnBGxBm5/OrC13k6qtpsjecokUlZJ+i8o/Ma/Jjo2xxG0RT4y2fay363X9DA/m4v3O17k851yp67pEj4d1XJD4ti86TXNPJX1Z/3V54OO5UY6j7r/wpTi6ialdY1KIw5Wz0Tm5cSYt32KbwfzhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:37:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:37:45 +0000
Message-ID: <c3df8514-9f69-4502-b9ec-debf4b1da290@intel.com>
Date: Mon, 11 May 2026 11:37:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v1 10/15] iavf: increase max number of queues to
 256
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Schmidt, Michal" <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-11-przemyslaw.kitszel@intel.com>
 <IA3PR11MB8986A92C9A9F7763410E8607E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <IA3PR11MB8986A92C9A9F7763410E8607E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::25) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f6ae89-8a0b-464d-3163-08deaf40f4b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ayL7KrcSkAAQ2tT6aGyZ+qYRtQcv9zWh/JsLB95gugD2+lENI1mSPTMfsltgpCm3cq9chQkvMONOUF5eojNkm0J5/87SUUJJAmjQCH94EckOK8AyWly2EeXL+e4wnzO4bgFk6gqso1SSRByMPEsQ9eEBB3u8kVcez7jQVZssz0rQRHLUg20zou0OqrOQs7ODJAqrdFzrFyoK5nI4RHqLPh/pkpcO9ULS/qtBi+PdkeFpNyVSUAWRsUXj9lUuaOwbTBAPJzlum2njATGQG/alXjMo5Q3In7Li+bU5OAgiA+ksFFTiNd2HekKHaqptwnZyE0dSAzmx0Xi8Q1if88+JymD5WfwP7jmcWIjbqz/pL5GDNrLrBy/nfaIMt6iTgmo1HNzl+OkhkVbIy2vW/khulbH/6tOTLaAon4A1/EmzV61TJG2aOGbU5QvjCNK1J6W9XRJRxNr6JOyHYpE6qy/Qqt6Mqb8nbpNr2QGwDFKAw6k1yWQb7sLP7OEwa6WqIUqolK2o8+Tf2v8ob6gmCw5NsEOlIqczt0RT87tMK9OChxVzvLJks+4jrDXVrftFIdXVwD94HL7eJBMknEnQoqAfC8EWQOpxyqYmJOv3WuPchDcr9dQkrVeCTZJDKCctwwJU9QQe3z4z2n6YwBRgp6rS+MV0QyDWOcYHoVGZP8i01JAGCtrNq8kuN51+xN1VqMpG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RCR3hrTWtPc2t6elM1anpLNWE4ZzN3d3ZBdG9qRnQ5Vk9kd1VPQVlzazAw?=
 =?utf-8?B?eXY4TjFzc3dCOXdmazQ2Qkk1aVJYQjVpM0k1dVh5d0RQV3JIQm9rNUhzREUy?=
 =?utf-8?B?YTlheHpOaThoVVhMeklaUVhyeWd0aUNWOE1PdXRENjN5eU55STNES08zUndj?=
 =?utf-8?B?WW5KeW5UaWpvRGZtTFRzdGduZkNuSFFUOEFOU0d5b1BmZzMyWE9MNllhZHJv?=
 =?utf-8?B?YndQNWVaRm41WTNVT1VJOGRJK0h5b1g5cit2ZUxkdGo4eXA4TG1YbDRMa1dJ?=
 =?utf-8?B?Q202bWYrQiszL3VreWswbitQZU1QWFdTNkFtc2NkczRDOVZVV1NzbWN3elZu?=
 =?utf-8?B?eVk0N2VOaHRKNmZxd0dBVnZqOEdRemtXa21naCtSRzJTODRObUxjQ09QQUtV?=
 =?utf-8?B?OWp0SXZBNUd3UVBjYlJvUXF5dEdMNENYU1p0Z05sT2szQWlkRWd5dUtZODlX?=
 =?utf-8?B?OEEycFhmUmgvczZhcW1uRU5rR1RFeGlWVGUxdWlaaEV1QjhsOS9qTjdUeEVh?=
 =?utf-8?B?bTRVTy8ycFo4cFdSWk5VWTVIV29aaVlmMUUyWTdNTEtpdTEyWGE3eWNYbjlN?=
 =?utf-8?B?M0dpSW8zSVovVG9yemhYSWp0SzVScjJVTEo1WUFWT2dYd3pvNllUS3B6UEhV?=
 =?utf-8?B?M2NBUEpyNTZnWEtEZEx3cmE2UzdJdVJFKzRXcExFc255alF2VnZCdDNQM1VD?=
 =?utf-8?B?eGo3cWk2OHMrUTVzcDFlVjFLWHRGSUlwYlNCeit0eFUwWjQrSWJOQ0xNVGdj?=
 =?utf-8?B?eHVINnN6TW16Szk4aC83L082R0x6RjV6TGljdm95dDgvRklQNXczTDVNZlVP?=
 =?utf-8?B?RUc1QjcrQUVCSGV2MVpMR2Y1N21OTFdkMDNjU21rSTNZK3B6cTZhMjI1UlU0?=
 =?utf-8?B?TVZtYkZPSWJFQVd6NzQ3K2xGelVoOFlJVzFVN2UvWGNQTWZiaEhmNENpRnY3?=
 =?utf-8?B?QzVsdXlodFF6OXNnbVdjb3A1bmRaWnh5UndSUTFIR0VCdzNtTXBRTW9wOENQ?=
 =?utf-8?B?Mm1aUHFaeW44aEhONi9DeG9lTFJOOW1zZlM5d2FSTSt0RFdMVVduNE1aajU0?=
 =?utf-8?B?VTBIUXhwbjREdW9MUDg3d1BCZXdJYUVRUXVwQkYvUVE0RWJKMUFtYzhyZW1q?=
 =?utf-8?B?a2tkVU9qTGhtOURBN2VlNEdSNDVwVXJQZjJ4cWV0MEt5LzhkTmtYY1FwNEZz?=
 =?utf-8?B?MUl5bmhlOFZoM1ZCQkZ4MFZVdEszak4rQk92YUNqMHZFK21NbUUyNEFmQkZM?=
 =?utf-8?B?VGY2SUIxeHhuQVJMbm91OEFHcHdXRkw5U0pWMWxvQi9zNTJrZU1NQmV5RHMz?=
 =?utf-8?B?aWZaSWV5ci9Lalk4T3VJVlQybUl1L1BUMnd4bkxGM1c5N2RveEdyRlduRzFl?=
 =?utf-8?B?SHZUL1Q4YjNZQ0xMRGUrK1RMSE5wQ0JYR2hHUmM1SnpYUHBoZ2dvNFRKeERq?=
 =?utf-8?B?eFFaUGdtTjlHVGRjTDYvMU0ydENEaXhKeWdkSlcvWHhMOGQvK0lmcFFiZURh?=
 =?utf-8?B?dDl3TGFmSTNudE1tUjNpZzJaOUU5WHdDeWRLcWtMY3JUQTFVNExaOC92NlJ1?=
 =?utf-8?B?TGtMMDZYK05jZk1LRUw5SXJHeXp0bVBLTU5LanhUbmhsdkVTTlFrMGtuT3c4?=
 =?utf-8?B?WWhqanVIQ1BWQUVrclk2K0dOWVo2TFVZM29UVno0b2ZZeGZ5Q3ZtSWQyT3dw?=
 =?utf-8?B?THRzZGIwcXpkc3M4V1pBeGpvMndGbW1MSk9PbU5RaFk0UGJTSzlpTTBtZnlu?=
 =?utf-8?B?RkJxcFJEM2ppQVJUTUQzWUxLZU5NaC92aWFQUm5EY3pnbVA5K0pRcldIWEI1?=
 =?utf-8?B?eklEZitSVmIxa21QUXNCcUdOZ1o2WERTSDJjMWY1RTE1M3Z0SUQ1eEhiVHU2?=
 =?utf-8?B?bktMbDFSMXdsMkRoSTBjVG85VmpuU2VEL1gzc0d3K2d5YTlYZmw3T2k5bEJs?=
 =?utf-8?B?TWRYdjBpaE9pYUFVUWQra0VTRDBUaFNTcmpIQ0Rzc3ZSaStjT0FOZlY5T0hQ?=
 =?utf-8?B?ZnlBTzFvN3l5bTNQOEFqbjRYVmZEUUNyMEZDcnh3SkwxOXNRRzVMWm8xZHZO?=
 =?utf-8?B?VS9VSytFazB5UmtiMm5iZXdjdzliUEpFbnZBdEVaYjNYcUJVNVF6UkJSSExi?=
 =?utf-8?B?MmRnOTFJa25jdHBNelI2a3FWNEZJc2tXSi9EM2dpZkpONEJTYThEV29HSW93?=
 =?utf-8?B?Mm5VZW1lWXlOMUlmUmI5N1dPN09TNFZpTU91OWxvUGhXMmFiREkvb0FSblYy?=
 =?utf-8?B?SzNKQ3VURVozU0JyYk4rd0VDZU1CNEtaOUlhSG0xaUFGL1JEYU1uVVVTdkhY?=
 =?utf-8?B?Nm53MEtIbkRjT3BHRWhrSWRJb0RwVGUxMUw4c0o4amRBZ1pvMFVsRWIzbURC?=
 =?utf-8?Q?cR0oIhm+GUVsRy4k=3D?=
X-Exchange-RoutingPolicyChecked: WHyVur7S/bivHnPT8qmlb7oAx5Jw9B80MTEdm+cu1WsB6jI8fAz995dSAwzaHcfpf1JdogRpYkUbXXeYcfYGubLauZ5a5rnm5H52yT6ymFitlB5vjqoT+5l2iZl4+x53Q3uF++W8JbwMNTHbw0rL8y2WOK15cYjDJqNAZcdSSJZPSpMExXZu6UXdrVF2FrTE1oDqGCP+BoKgwgTr54o6g34XJFwZ44Az5s1mEwrP+is7+hyjt890S4ilI96OV9Hr0lFXRCTvdan/lnmKmTYNUrcttJPht1+1APCiYFFAnELEQrGM2U0Wuz3y8BbRCMOuAvye0JiQBwKGncUQxAZ4kQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f6ae89-8a0b-464d-3163-08deaf40f4b5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:37:45.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2onLYIXFtHawBbtQ1XhMN7o76f/RZm8eJ2AHeo2d0QSbPkdml8cD3ZkjNqrn4RcDQudS794WemAlZOVe2hmY67DhUq8qZRX9imMKx3hFHEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D183250B521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286572-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


>> @@ -554,8 +554,9 @@ void iavf_map_queues(struct iavf_adapter *adapter)
>>
>>   		vecmap->vsi_id = adapter->vsi_res->vsi_id;
>>   		vecmap->vector_id = v_idx + NONQ_VECS;
>> -		vecmap->txq_map = q_vector->ring_mask;
>> -		vecmap->rxq_map = q_vector->ring_mask;
>> +		vecmap->txq_map = bitmap_read(q_vector->ring_mask, 0,
>> +					      IAVF_MAX_REQ_QUEUES_VCV1);
> It looks like a silent data loss on the legacy/V1 opcode path.
> You read only 16 bits here.

and this VC opcode is used only with upto 16 now
next patch (11th) adds an early check in this function to dispatch
to new opcodes in the case that more than 16 queues are used

(so, no need for change IMO)

> 
>> +		vecmap->rxq_map = vecmap->txq_map;
>>   		vecmap->rxitr_idx = IAVF_RX_ITR;
>>   		vecmap->txitr_idx = IAVF_TX_ITR;
>>   	}
>> --
>> 2.39.3
> 


