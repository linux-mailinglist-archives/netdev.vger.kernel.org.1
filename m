Return-Path: <netdev+bounces-153520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960039F877A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F197A29AB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693831AA1FA;
	Thu, 19 Dec 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5HFcAmU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD616FF3B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645963; cv=fail; b=KPh/bJe26pDlHGGmNByctmTfEIHwnV+3OU6sUYnECjePPFy3v0Cyr0L4UpWiraBuKDM128rfA/Izf1ECPOlKgp0KWeCvtnLxLa/Xl0mXobx40R4vswOhieBScitktR1G+Cq+jG9oMWcwzcMC1DkYNXxwRQQrsFGOZlqzH4eLV4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645963; c=relaxed/simple;
	bh=V3W5895/z2agSAtnvAtWO1rQgIf2GJps2qBSjkTv9zA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iTwQwX5glFS55zl4nZ6gyoM5Hw8SqAqivSDZo+VyZ/oKbzBybSIzVb7VHXMNbM/iedTZ502/n5FkcDzYtXsG8A1gaRvlX+xaKgu9q2ypiYH9er6+gZ+TPyU0if8tImMYUPH9R25KsGXrM+M8WkRWHe8UE+M7g2g0EIld2OnhB2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5HFcAmU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734645962; x=1766181962;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V3W5895/z2agSAtnvAtWO1rQgIf2GJps2qBSjkTv9zA=;
  b=E5HFcAmU2TkG51Zph0S5yKaUdCDr/bU3o09ZSfLYTvu7lu6R2RinTU5W
   F2e1hmpmit327SFfITrHoYMbZL+9Kg/+CZuM+aAQgRTXcun5lWJwVkcsh
   X9wOKzdMUfhkEell/LOPQWqwpuCbAl2yQKb/YJ9hx/92l/HSjFzBPf0Kd
   1gkEEM1GLooy3ei2DL4csvXs1bvEfuZeYmsBWieNniV8gf16KrXj0wJgA
   8h5CjF8aiWtfFTYJXcyIIay5myH+Gd4mSGMf7da+bQp6FCcH3eCF/o6dR
   8vEK8GRc01dQVdM1PyDNr/yKnqVYu0QZma8B7uELUn5vf1eygq7arNgvw
   g==;
X-CSE-ConnectionGUID: XGM3PogvReq4Zdbs4J67EQ==
X-CSE-MsgGUID: Q8cwrVthRIGR/iwckvv4kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35068277"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35068277"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 14:06:02 -0800
X-CSE-ConnectionGUID: IHmwK9GaTxiKNeHEGYWA9Q==
X-CSE-MsgGUID: FGiEjER/SmGPUo5lf+dc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="103195795"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 14:06:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 14:06:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 14:06:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 14:06:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1QrHG8o+tuWcFXqW4OundmDToBQUNeYRLWXGSBsQN2vqD4DO4DNQO1hwtJZsJstrYjlA6HE39wbIbESDTC6AnxhGL3A82eYEqpFku/aYesyTSeKFITjab9yjLKEjGwVJTKf+4SESWB0tlgNSmQplMHH0UaCjejMu6vvIQBspz2tw6c10YQ8SCR8PEwSysxYLUrVbTTsKig2vatYlUg5Y8alsiLlYiRmApogZ2n/jcdq0ga9ZvIbWbBdO4EOKcFOBsLXJF9DGlVoqoCAYbP41Znfh5hJtQIdbePIU26Tt1w7rrJMjPETyYXSDFJrubHAvsXASRCBr6zwCqK957m8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awI1JZ+HqnBHf/SU3aimhHdJC8BuaL3HOSNzlenWpsU=;
 b=IeHL9tI3X8C5xMWmLIdu6K5O+utDOae3Yx4dwgtdcg6UjaMBuwlceShK2nAgXf13Gw1HYfcrP/ABtDvJVIlcdCpdjuPK3aJAg3Dhex8gel7syzx0JAp9WjzY99vAiuQgX6sKfYR/Hq2HFed2776HbkTJ/1w1NN6YHQVTuXgZFEekfnifII9AadOmAYc+IoqSvRhJU/gsVc86hM5csERTz0Zt4KZnCnDvRnfJiM57Sbsyvg4ydSPEaAybPZFkf8VszZ0IHbbIw/EPLHj9hvuxXAuzeJNhKGrf/8rDoFx7PmbgI+ChPiB3taB8FoV4ELd88nYDKBNd6cwRI/8w0jfn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Thu, 19 Dec
 2024 22:05:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 22:05:45 +0000
Message-ID: <c606d8cf-4895-430a-b163-3a04b932736d@intel.com>
Date: Thu, 19 Dec 2024 23:05:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for
 Homa
To: John Ousterhout <ouster@cs.stanford.edu>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, <edumazet@google.com>, <horms@kernel.org>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
 <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be56a8f-0273-46a6-e58a-08dd2079492f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tmp6MjNZbHI0aHFLVk5SODhxcnlYNjZPSkNaNldEdTcwNjdqdFJlUDdMNDlG?=
 =?utf-8?B?Q0lWT3l4TjYyMENuSmdDRHQ1WWNmWW81NWdVN0dwZml5UGpiM3BJSyt0TXcy?=
 =?utf-8?B?YjNxQTdWYmxIZHlFNVVmY0xFUVA5OHpiOWtNb2pmN09Ga3ZFVG5RL05wS3Yx?=
 =?utf-8?B?VEYySGl2WkR5NmFrV3lzTW1kUDdaZm5CTGcvZGFDcHJBWGNQT29pZWt1cVJX?=
 =?utf-8?B?c0sydXhqbzBuNFVwRHhKSlBnazh3WElDeVpHZkFPL0NNOGVnbUVPSFI5MkFu?=
 =?utf-8?B?N2VjQktXc3ZnY3NXc2pOSyszS001OXhqUEwzdTF0cVh3REdWM1FwMU54ZUtP?=
 =?utf-8?B?SnlIakZKdlZpYSt3NmNhUGNicWVwcWlNTnlkRWJBY0NxS2dTY2dVRDR1YUJE?=
 =?utf-8?B?N3M0V2VzT2xMLzZmNjA1WE5abHJmQTlla3JMZzRnZVdUNEhjdzFFYzMzYXo5?=
 =?utf-8?B?Q3g1Z1Z4d2ltb1IxWUJvUHNkbldsbXZkZDdTcXl5NWkvbmh6Z0Q1MUdqNHJo?=
 =?utf-8?B?ZXVQcTFLZ1BtaVFRbEp2Wm91OEw2TC9vUGppUGRaNDMyUDlhNTlaU0pPRTFF?=
 =?utf-8?B?WDhrcjZwS0pkQThoa2xYQS9pVDFiS0wrSDJQL3ZNblh4aU94SEZteG5yc0Vh?=
 =?utf-8?B?ZFVraS8wRFRwMG45ckZZTGVhUjVLdFJoaVJRM3VPTjRNWnduTExnMzFCM2Rp?=
 =?utf-8?B?eTVlNlpUY01MOVNpMTB0YkwvR3Z2L1YwUHBqZnphd2E3SWhCei9xK3I1bmhE?=
 =?utf-8?B?KzZVUWw3aEdwRVJOZHBxTVd6Ym13YXI2aWFURzhTS20ydCtEamcxUUxuZG1N?=
 =?utf-8?B?S1NvSnhwN1QvaUtvQ3lyeWZRR3RxQjVJYUJ3TTlVZXh0TE1NWDdMTzcwUlYr?=
 =?utf-8?B?K0JyNUlOZE4wakY5WGNtbERKMkYwODVBZTJtRVpKclJyVmRLN3I2STgrV1Jj?=
 =?utf-8?B?Sk5WVlphMmJIMHRrRnA4SnBZalVadnRkOHJORWMwR1R6ZUZiakZvOWpscTRJ?=
 =?utf-8?B?TjU2US9nQWRFSVl3WlJ3M1VsZ2E5MC85ZWN1N2hWdG1Pa2ppdGhIWDNqMHNB?=
 =?utf-8?B?UGdaeEpIWU1zdStvWlhnYjZ4VU5CRzlRYjVRMTl2QVpKZ0NnRmtSOHUxSjRv?=
 =?utf-8?B?TjVrWUl2aWtXQVVVQVN4VmIxbExFd1dzSmZCdUZPNGdQdEhVUTJ1L0hBcVBw?=
 =?utf-8?B?anMvNUhZTUs1TWd2SDdUUnJMY0o5ZUFvSXdoanVPa0R0SUYvVE11OEUwcjJw?=
 =?utf-8?B?eXBETTdTSDlZUDJ3MGlmUVZBRWdXOFhWcCt5MWxva1VoYm5FNmZFNThrS1pU?=
 =?utf-8?B?bzFmaSsxLzNJNjJWaWdUYm5qS1B3Z2VhOUcrM1pud1lqU3llUUpVNE9hVmpC?=
 =?utf-8?B?ZS8yT1lqYjJiOGpsUWFlSFh3OWRiMngwOFZwb1ZwK0tpNVk2dWUwRVR4T3Na?=
 =?utf-8?B?U3Jrc251TkdONk5KZkp3ZXhGUDRKSzgzSUFTQS9tVTltTTIrNEQ4NHlKS1Av?=
 =?utf-8?B?OUVEaE5vOEp6aUxtUnkrMXBuL1ZFamJJdnNiZDRhakozQUhzYWw2QVJJcVJ6?=
 =?utf-8?B?Smp0L0pDRC9mWW5pV0JhNkVFMDVjNnRCbHNPSGN5V1Y2QTRXb0JteGVMOE0r?=
 =?utf-8?B?YzlIMGViWGhiNVUzcm54UnFyaStPd0dBSlVTRDkva2RxcHVQZnNJZnk5Sy9F?=
 =?utf-8?B?bjNvQ1plZklLMWNFbHJNSTl6cFBtZTFPY3EyMzkzSVRLbnlEN0ZlTTNwSUJt?=
 =?utf-8?B?SkZPNThibGhzVnNIVDI2M1BmVktLL1JHbmtKVVZsdkJ5d2NLZUNPSFRnaEdw?=
 =?utf-8?B?bWhmcENjaThBRjI1S1BQRWRSTHlsV1VUYTZ2QU1ONnQyQTFxdVVFeEJoL1Nj?=
 =?utf-8?Q?I+ic13ZVlb4Mc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU4wWGpFSzdtL2thRG9XVEhKUElNbW9pVGlWY1BNMHFCLytkVitPc2JwSTg0?=
 =?utf-8?B?M0JoSzNqRFNCbXZlSU84cWlHUm5ab1c4RVc4ZVNOK3laVWx5c2lhR1dpTU5B?=
 =?utf-8?B?MU9Ib25CbG1WMGw3OUlicTAvWTRhZjd4SFByVW9sajRxaTk2VGRhY0taWTBl?=
 =?utf-8?B?ekFhVDdJSU4yenUrNW9yTitEQWlPcC8rY1kyT3FtVlVOUlp5bENpZGRGdXJQ?=
 =?utf-8?B?dU90Y0ZDVlJ0blI5aVNvZDkxNUN0OGVsNm9lY1pZUXljaDJHaVBQUzlKOGZo?=
 =?utf-8?B?Vkc5dFpwUGIzcFpha3VSY2crQzNqUGJubXg2QWduT2F4dCtKeXNmZjJwci9i?=
 =?utf-8?B?STBMdWUzblpTdXVvemQ1RXR5K1dXcnpZUlhjRytiLzdIQnJGZzhOckI5bFN2?=
 =?utf-8?B?OXBVVVVuM2h6SVV4NmZ3RURYVmRiM2JXd0ZQNk53UUZWek9DcWRvN24vUlRs?=
 =?utf-8?B?ampWc1Joa0xGUklGMkxyTGRBTkVFUXRvMjdKMkJoMW44NXVKYjRSSHBzWThT?=
 =?utf-8?B?bXhqTnNxTDNUQWc1VVpEZ1JycGJ2SVloRzNsZjJrVlo3SWZsMnppaE5NMkgv?=
 =?utf-8?B?ajEyeDhLRVYzNGtCTkVDZWZQN1JqVmpOL3FYZW81Yys0Z1MvSWhYcm9VTGha?=
 =?utf-8?B?aW9NRGJKclY0bmpGL3hKajRqb09VbU5TaVl6eE5IUDMyenIvR0p3anFpWjNS?=
 =?utf-8?B?OEZiTmVvVHRrN1hpZlJHQkIzUjYvRWlDL3o2eUkvVDlGcXBYSTExYTNZVGZi?=
 =?utf-8?B?MlhTZ1cxTHYzWDNVQW9YM3ViMkRnZnRPQWd5N2g4RVNnS0wrT0Y5dFgwTVlG?=
 =?utf-8?B?d2h2eG90MGRDSjNjRzZST3J1dnIwbmNVQUF0cEpjOUE1bjJ2aWIzQi9RbXZy?=
 =?utf-8?B?ZkdiYzV1d1ZTM1BIKzZMSDh3RkJENWxjWFZjNHpST0FyQi96TGEzcnBIYXlt?=
 =?utf-8?B?OFFXU2tvMmxRSnZxbnFSTExQSGZwVlMxY0ZBSDRmcU05MlI4N1ozWFUyOEpi?=
 =?utf-8?B?Z3pXRG5pdEQrcGxyeWNlL2FHWVAvOEUzWXQwYUE4eDNiT1FQQ0NWeHFJU2xO?=
 =?utf-8?B?OFNoV1F0Mlc1emZBUXhBcnc4dERENHV2V0NEVVNCQS9IY2M5emlXTUJGNEph?=
 =?utf-8?B?eEVwZldxWjMzaXBxanhER3JaRytWNEJWd0M1aVBobEdTRk1XZkdNN2hraGp2?=
 =?utf-8?B?WndBZjJaZFQwMlNyWXRDclBDVjhndi93alRoUmZrbUw1NVJzODU5cnRDZjJp?=
 =?utf-8?B?NFhqN1ZTRS9yRzBoVFRObkRwYXlONTkrakFIVGNON3I4b3E4MHo4RmgreXov?=
 =?utf-8?B?OHNyUis2NDl4dXAwSUE5cHM4dW9JcU5BTFdFRzNlQUNyUFh3TFdLRWMxdGlK?=
 =?utf-8?B?NWF1TDVubWlzVlFRUXNjYThrSGVaejJqVEdwKzh1T1dBNnp1cXk4QVNYZjZo?=
 =?utf-8?B?OXptNkNSSFoxSk1KVnNaelJSVVdYcjdQRzQ4ancveEozeHFyNjVVeVEweVcx?=
 =?utf-8?B?VW44M21XYS9QNE9pRVdmRS96NjlyQkMwaldpTmRuc2lxeUxKb3d5VTdBQnEw?=
 =?utf-8?B?WHdwN3QrY294TTA5RFRSSUlwWmRMd21LWkhiTGJkYjNWSXhrYUdFMDFORmhC?=
 =?utf-8?B?am9VWnlPZlRHalRxcDJFZnc5MkJZU0p2QjlZTzNLcUVMZWRMYWR5QzduclhQ?=
 =?utf-8?B?Sm5kRGJMcnl3dnUwV0tnWnF0eWxBQThmdzRJMnI3U3l6b3QySWZmVS85UWZS?=
 =?utf-8?B?SndEQTM0b2VUNUV6d0FxZmVjbC9CMnBaR0VUWGV3M3VTVVdnczhBcmVZSkQ5?=
 =?utf-8?B?M1hNcisxSHRTWTVOdkszYTAwbFhGMlJxbkhLT3RGM0Z1NzFjK1MrbHI1TnRJ?=
 =?utf-8?B?ZndQUDVoZGlXL3poemdNVk1BdG05N0FzNENXcmo2NG1rcW4vNzliY29TMEJC?=
 =?utf-8?B?L3VzVjQ5bTBrRzIwNlBsWHZYL1dwcGt1cEtzQWlCTEhwbjRWL0FVVzFRUlVZ?=
 =?utf-8?B?eEw4QmhpMkxoR1NzR1NPdno1NmZXbWE1STVuTENLK1dRcm5hTllFRFBxMDB4?=
 =?utf-8?B?aTJPcnRMVU1JQWpOeTJJSnRDS21rNHVUUDFYUGFoTTRYQ2ViMzlqeVNNekVU?=
 =?utf-8?B?NDd3Mld4dlZPMmhJNzZYSlA0NG81OEZpempOZzFUaytMOGVoTTJ0VkN6NXV5?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be56a8f-0273-46a6-e58a-08dd2079492f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 22:05:44.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie7kKOlRx/LTwQt2xEA55eTdwqewBPhmB16acW0da/95HP8GkoR4nQ/2nk7GDiQt5gAvuhoVzAtjf6htTfg0r9t6sQ+e3G4M4Oiu2gOVQe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6982
X-OriginatorOrg: intel.com

On 12/19/24 19:57, John Ousterhout wrote:
> On Wed, Dec 18, 2024 at 5:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote:


>>> +#ifdef __cplusplus
>>> +}
>>> +#endif
>> --
>> pw-bot: cr
> 
> I'm not sure what "pw-bot: cr" means; I assume this is related to the
> "#ifdef __cplusplus" discussion above?

it's a shortcut for:
Patchwork Bot, please mark that as "ChangesRequested" [by Maintainer]

C++ program could simply wrap all includes by extern "C" section

not sure what is better, but there is very little precedence for any
courtesy for C++ in the kernel ATM

> 
> Thanks for the comments.
> 
> -John-
> 


