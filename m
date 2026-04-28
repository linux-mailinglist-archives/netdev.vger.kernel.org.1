Return-Path: <netdev+bounces-281893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LOrBtLC8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:23:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46724486DA6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352C730A30C1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376B3EF671;
	Tue, 28 Apr 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUYY4yW9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB23F2108
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383950; cv=fail; b=e1L429061mcRJE6bUiiKWRli2zCEdMtOwFXOG8AIWit9InYEbsopBDjP9H10ssT8dPlhwvFw/GVrpzb7IAoF6y9+A/+msMsBacjqbvOBqClZ3gJdNoHnqLjdt4ms5zY4WHhKB+dkwEyXz4MAMZG3uapzt1LETrstBPaYIiF4VFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383950; c=relaxed/simple;
	bh=hJle0brecgWuY1KVyu9vb/RvI98bVYn2NfbhGlitQC0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=drkSnXnhNz5b8UiC80pi7G1HbhkZ5JlSn6z15bF0oLzcfHgYigzNppSz80Chzf4lsNBejjxVSva3YrbIpl0+uAVJuNtUqmRdriOr8/f37Ui4xUKkQuFSivSIMtjsrO2H0YjtmbQVBAuzf0nU7TCgnmAT0uXm41K1Rh9pIXsPHH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUYY4yW9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777383949; x=1808919949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJle0brecgWuY1KVyu9vb/RvI98bVYn2NfbhGlitQC0=;
  b=YUYY4yW9g/1t3JOttZqLZjkoAJltS2a6bDTe92WcqrrUqDfQRLaP8xDe
   GWlleNuOe0gabYy2Bl4vRT6EjvtYOneWb6zHS9Fh0ZaKKGn5tEmUqZtT6
   8yVJvkZnoMCvRgAC3Yh1202Eru89qY9KjwjThpfPujwSMG7oZk+fZ8N3V
   lBSOkMVfXX38XKZRrPrjaUrP0EU3vG/LnOOZra+8ELEH1z+Ue+mLFLtvB
   kHKHlo0qwLRdsniot/lLhvciV3vkaPlIMQsrCwYC9BZuH3Mt6ojjg2KKO
   1hrbdpfXvaMAylZAUPhAUCkmKR3uZBVNSSaiOvXn9IuoKHILmS+y81QUP
   A==;
X-CSE-ConnectionGUID: okWS8Z1lRq2DkvnFTI0Xpw==
X-CSE-MsgGUID: FDtO/zsJSaSBHm6hQvGJ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95707541"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="95707541"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:45:48 -0700
X-CSE-ConnectionGUID: yfl540+RQ42torE9qse+tw==
X-CSE-MsgGUID: TDEwl5HHT/+2duay61dbMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233104734"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:45:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 06:45:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 06:45:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 06:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHQGqF9n36SG4biSOVLIxSPmR3gWnYXyAbH1SBOnFEkgxo1Vtf3qtmFOH+6CmIpRpGib6z6x8eOuS25aX/nWo3dk71b//SNb8kP1h+ZzdCr9UQplOoa6Sjyesij7Ny0Yx+hgB/3KgLSg1TpYAzRX8IVk0VADpor9V2HlJwzHRX72t0e6AdOMm4SGCN0qLA/vVWrKY0ZkhgOgmm7oizRa1OuVox6fc5i+SzQ62kk+QU0YFMlBikzwbEH/Is6gEB13g29dMIgEmXh8KTNDhOskbdcasZcoxv6mhLMkV6KWSVG16gMYZueHggLP4HhcMac/mbwlUj5OHU3vQkwTZprpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzhmgOuEbX2puRzO4QcsGD27lGpX2+bW+EKJUXp5JUI=;
 b=oX5aDwg/lwgq48dEu7K9h3r9zyn7gjW4P613qUoqYkAPyIKJB2eL0h9woXKduUjJfyE6yKpBVU7/HVBmMUItgbfUpEOXkGpHq0CBMqdMTiPoERW4qI92PiZYECwbnoVuE8kfKN0mimRwkO9KWVwufxQ9xzi5DGXrCcj/mxI5vYhbAdcF3BOLnR26h129RvckxWP+MbCXVITRN0jCb/CFNFDAw5t/hV67fWO7l4mZZvRgY0CeAxsK7n0lgXBHFlIBN1nr9NSaeh122HpAzI1efBP46IAs6dVbuzNWF9V4CRIl8AYlB1SMfIwZfiEPS0Ah/wtHb5PIPhoJzU3fgsCFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB5281.namprd11.prod.outlook.com (2603:10b6:610:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 13:45:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 13:45:43 +0000
Message-ID: <b94a55c7-3d86-47bf-8acc-b82e31766116@intel.com>
Date: Tue, 28 Apr 2026 15:44:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] devlink, mlx5: add init/fini ops for shared
 devlink
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Lukasz Czapnik
	<lukasz.czapnik@intel.com>, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Simon Horman
	<horms@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
 <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
 <afCU-3Xmole6v4X4@FV6GYCPJ69>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <afCU-3Xmole6v4X4@FV6GYCPJ69>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0142.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acf86ce-a400-4e18-329e-08dea52c7196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uEE0NF4RQQ0MpTSfEp/v9l7/qbSO+54oSEAYuwTeANwrSFTU/k/n8Tcbgy63jD1USclfgzCcQ9447M9DLlPtplV5Rn5m64EjzUspwuVow7P1Chh3uy6YMN74Ic7Je2lLEGamO6DmWlN5lVWdmVwi3xYf2x/TzISd/uvjFhFQ3S8zw0tM8akCwpg75srkQZlaa0kAL39NhWGO6j8W/qf9T04LjgwDtRD0Xk/65vJE4438w1fswBPHFnPl43PwPHxTq437H9iWAmKs4gMh/kFy+J9eBYaDwc/GQaQUz0gzUUf+lAFTVAnflqohunQ+f+23N4ivNtBJgN2Va/XH92ipWAPdUAwIEGx83R6TKJ84a40BshgXo3pyZxb5J5Nc02+4sNfarArTEPXn1fn7mYOadifGVYoRr5pOl0HwVP/XU+5Gk/Wur2HblJFK8i661HPAUSjGwsqVTlh24M3BYTWLPG1cjpHoC607RKRQtFYk9s3N0OxOeTU0EY1PzjTAEwzzkj6EtZsn8CNI0yUsPrUcaIU7p3FBYjyGfrabbmU6its1qpsNz1FnAdvFpCgQttA8s/OLkcP/eSg7kZnHhRM7pYcV71UQMXySXOl2w47h4mDhe2QXmSbAWzORfFyNuCwRk+q7ViA6tR0ha4jLpMeWuU0lwrchSBtdAI/aa87EMV+591mngvsTWQlmBUpySM+4w9wfqzzPe8Dup/f7Usjpl1GCcnBL5XJhuUG6gvbzvwUV6hIaWqSmzuCgfjiWIVjf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emEvM3Z3ODMrUytNZER3Yk43azc2QjR5UFZ6aWlLNHRWcGppNGg0Y3FxU1VS?=
 =?utf-8?B?T0RiYVErZTBybnRxLzFjWGt3cE1kakgrUmMzVGtQYXVnZ1plODJ1dnJiUHdo?=
 =?utf-8?B?OW9qYXZIMGNvMXVYOVFXcERQYUhqVWN2d2tsZ1dyb0JvL3RvOUdOYS9ldVN4?=
 =?utf-8?B?SnBwNnhJVndsa0I4WGdoODYxbWtBaldZZjV1NHY5a2ZBSEJBSVpydHdYMko0?=
 =?utf-8?B?bHdvdXJ5eEpSbEJBUmFlZ0dLVk5wU1dVT3ozNWRmbk51M0kyKzZoQXVMZm1v?=
 =?utf-8?B?bVhnMDBKalJLb1hyeFdQY1R6QzhXZGFKYytLMlFvRmZLbmV5TnNmZVlRSndP?=
 =?utf-8?B?ZG5FcktpRVhYazlPTmxKUHFDeG9nZkdFMlJvbFgvYXltU1Juc3g4VmdNTzRK?=
 =?utf-8?B?Uk41VGF3RGFCSWh6a1JTRDRWWEx4T3VHQ2ZBNjlubEoydUdZQ05Fek5BdmJa?=
 =?utf-8?B?ZGUxMkdMV1A0cE9OV1JMUHc5QjNlL1BRWkFJaU44dGp6c2MzemgrS25aOHg0?=
 =?utf-8?B?eE9vY1JRRklGaVh1aFhmWkpIOXlhMjJTdXpsMlNobC81VnNxYWhmZ0NmTGlh?=
 =?utf-8?B?YmRRbnZvenhkbEJBRlRscWZ4ZmVCZ0xsK0hNbHN2VGZkUnBBT0JrK1plYTJG?=
 =?utf-8?B?R0c0TGFqZ2hvVUpQMkQxeWdNYlJMWmYvY3NzU0srQmhJSDRzMmdoSkFaVVMz?=
 =?utf-8?B?bGd4UHFNa1RWYWpHYTdRUm02ckdZR283UzFSbE9zNzIrNWpWNHp4QjR4K1ly?=
 =?utf-8?B?bFNyR2hxalM2ZUE2dDFBaFIzUDBmY2RiUXoyNUtjV0tNbGg5NUxudDhyWi9n?=
 =?utf-8?B?aWdsM2tnUzUxQXI1VHBzODNQM3g4d3NCdTcwdGpFc1ljcWNRL0toN095Umxa?=
 =?utf-8?B?UXhmbFJ3TVZRTmNNbzY4elk5VVBMVEswaE1vaUlRc0hzaWZOODNEd0F2V3dj?=
 =?utf-8?B?b2FMTlBiZEV2ZkJLN21ndWVjeThSandUUkI3S2d1c2RXV1NiZS9rUXpSdzE0?=
 =?utf-8?B?ci9sV0h5VTNwSUh1OTB1dTAzSDNNR2FzY0RJbnJWbFgvYUwrNXRtenhGZEFl?=
 =?utf-8?B?ZTd4Zm01d01CTm5rUDJVNWR0NnNINTBmMEpUcktnZGlOeGI3djB1NklCL3RF?=
 =?utf-8?B?SjYybk56eHRqdXNNTU4zZ1JMTlQrdU84aytkc2l0R1Q2QUZUZHp4MHF5N01Q?=
 =?utf-8?B?ZFVrb2x5ZDhaZEw0SGtPVElUZG5YMVdwSkQzRzJHRkI1UXNBelBRRG1YemhC?=
 =?utf-8?B?VHlWa0FObVJkNW00V3VDUG55R1IzbzVta2I1QktiZlAweWhtcVJ3L3ZoYnBZ?=
 =?utf-8?B?Y1VEVy9CTmVlaW9wTDFvVG1qQ1lrUjFMY3RIT294aGpBVlltZ1JvUVFFTDJY?=
 =?utf-8?B?NVI4aVpiMC9tZWZnNnB3S3RYUGkvcm55aUt0VDhaZU9FYmNtK2srRHpLNnNq?=
 =?utf-8?B?M1FOVTJKWFgxUkoxK2prSXgwRE51M3V5eVdXMHVwZWxRTXBYZ2lzSnlMc1E2?=
 =?utf-8?B?UEk5R0VST1lpYWcwbmxxMlllY3pUYVZ6RXFLT2FDejZiL0RCOVFuNnRvbG1S?=
 =?utf-8?B?Q1pNMEdMQzVxTGZCVi83UWVhbDJwRmd1RjlmWUdLK1k0QXhTYVU2Z2FFcllQ?=
 =?utf-8?B?cDlnc2x2UmNlTzZrN3NZSmZwY1lNK2Rvbit2NGVMdzVPQ3ZYNGRBK09hZDRl?=
 =?utf-8?B?MlpUVGdESUtUNU5UQlBwcm9UV29haituaG5YN2RCTVdwaGpJUVo3QTJSUVRN?=
 =?utf-8?B?QWZUVW5nL0RaOW5PUnpsM1grU0htSTloQzlhdk5GTVkyWXZuUmVLeW52cnJJ?=
 =?utf-8?B?WGk3K2lyUU5oWkVPSVhCM2lXY3J0YU1ocFJBUXdCTHVVY3hyNmh5RHlRTUxt?=
 =?utf-8?B?Z1RWd2lIcnEyTE9sU2piUUdJWHZjZFJIVHlNWWpZNE5YaE1pZmhKUVpNRDNW?=
 =?utf-8?B?NUVEeHBwWkpOZkRLOGhlMCtPWDBkaUNsaC8yajdlMXRmWmF4QWRJZDdPTXN2?=
 =?utf-8?B?OTY4Wk8xOTkyMitNeE9Edk1pT1dsUTd1RUNyQmZIRmpSRmpnY2k3aktsWjhM?=
 =?utf-8?B?TjBzYWh2dkFURXE2VWYxcVh3dDFzaG0yaFFiOVVnQjNSVy9mancrMkJmc1Ar?=
 =?utf-8?B?OTVzcmhnVXJVcENyYTlMOVNXVmdyWStuN29lRG5OT3ZGTnRsVFJSc1gvbHpw?=
 =?utf-8?B?ekY5NTZEUVlEak9IRmsvQTdPWWJOYXpTK0ZsY3FOcmRQZEhKWUxxeDFMeGt6?=
 =?utf-8?B?Wk9OQ3hBUFQrYVBwVnF3bDNrVU9PSUZla2xEUWFUZUwyc1lhZ0JVSWxKV1V5?=
 =?utf-8?B?d3MyR2ZSQUZ5OWI4aTNxVjdqb1F2ZmVHNS9INW1yTDVMWU1ieFJFWkIyOXB3?=
 =?utf-8?Q?4IjtaAy2DHCoRe8I=3D?=
X-Exchange-RoutingPolicyChecked: e4ojeDHzdFMOdM6J8SqIhzPnDsbFKbYDUtgE9ne/US693Nwh57bvOcuTs9PP+zOLfwzlb6pQWDEWYAek3VuldLiNB0rhmmSac9a+ijNXUHvjM2jJOl4kB0b2SOYc3L6KWBIAzgFEalH4QIQlvoqDMwMPyn882MZvXYMqZsyEocqTrVtPtOc0XDMJMY9nQOHVb5SgsUbGP0AMx1YYL3QFsilOgvFUplZlRTGLbSgJNLx4JoanL3WoTqqehgMYzo/5MEIBAp5VWKHaYjuNXC4th/0IwTp8Xa27tUndCr0d7hYqTNGcjAAnpcUqmMFphGyC1UR1MbBzGEOh6F5FSQITYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf86ce-a400-4e18-329e-08dea52c7196
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 13:45:43.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNWk52lA7m5VZQvBcrHddWXtmMk+WrU5eYYVgLXgLu3cWmNARQSGlyXr0EubL5su8SAIwHGqV3xJb946Iu1ugS4Z/DURlNEPQ7wYdJcz1n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5281
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 46724486DA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-281893-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/28/26 13:10, Jiri Pirko wrote:
> Tue, Apr 28, 2026 at 11:09:11AM +0200, przemyslaw.kitszel@intel.com wrote:
>> Add .shd_init() and .shd_fini() ops, that will be called for the first
>> devlink_shd_get() (to initialize driver' priv data) and on the last
>> devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>>
>> .shd_init() could return an error, which will stop creation of shd
>> instance. The initializer also gets an additional, optional param,
>> that driver could use for any needs.
>>
>> If any of the callbacks will need to get devlink instance, it could
>> be accessed by shd_priv_to_devlink().
>>
>> Both callbacks are called with devl_lock held and devlink registered.
>>
>> Next commit will make use of the callbacks, another one will make use also
>> of the non-null additional param (outside of this series).
>>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> first discussed at:
>> https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
>>
>> Sashiko suggested to convert devlink_shd_create() to return ERR_PTR(),
>> and propagate that up to the driver. It think it will just make code more
>> verbose for not much benefit. And drivers could just store err if they
>> want in the passed @init_param.
>>
>> ---
>> include/net/devlink.h                         | 26 +++++++++++++
>> .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
>> net/devlink/sh_dev.c                          | 39 ++++++++++++++++++-
>> 3 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index bcd31de1f890..5d3a1337bfa1 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -1586,6 +1586,30 @@ struct devlink_ops {
>> 				    struct devlink_rate *parent,
>> 				    void *priv_child, void *priv_parent,
>> 				    struct netlink_ext_ack *extack);
>> +
>> +	/**
>> +	 * shd_init: Shared devlink instance initializer
>> +	 * @priv: shd_devlink' priv
>> +	 * @init_param: additional param to pass to driver callback
>> +	 *
>> +	 * Called once when the shared instance is first created (by the first
>> +	 * devlink_shd_get() call).
>> +	 * Should initialize the driver's private data embedded in the shared
>> +	 * devlink. May be NULL.
>> +	 *
>> +	 * Return: 0 on success, negative to prevent shared instance usage.
>> +	 */
>> +	int (*shd_init)(void *priv, void *init_param);
> 
> 1. "param" has specific meaning in devlink context
> 2. You don't use the arg in driver
> 
> Care to drop it?

I have a user for it, but it will be a separate series
(I have already 15 patches there), will post RFC to link here
to the user, will that work?

my intention was to not tie touching mlx code with big series for intel

> 
> Otherwise, this looks fine to me. Thanks! (small nitpick below)

ack for the nit

