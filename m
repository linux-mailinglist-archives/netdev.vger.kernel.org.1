Return-Path: <netdev+bounces-302156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ThjjJ41nPmq0FQkAu9opvQ
	(envelope-from <netdev+bounces-302156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED096CCA33
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:50:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NRcWEPr3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302156-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302156-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D1E3044092
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC23DB652;
	Fri, 26 Jun 2026 11:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDF3DA7F2
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 11:46:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474400; cv=fail; b=MhEF3OUBkk84EGxZTcqF1CYMVUQQzr1x9dUptvS3cbZOvrREdTCRFCZKQIsoKewl2FzLcxh0Jx6n/i7pEeHBw5YkUfLgFAQTjW7rksT3074BWmDeBrzN43k78y6pebMzmyNUAMgXqop1Qwq4QNBjGACrpaGm9dXJYu5J8FtD0Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474400; c=relaxed/simple;
	bh=nHzi2FXniijWAB3xa2ChzIItYrvHlqDtbBmYlNe9TOg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOsJ+vx32asjXUee1isL97fvc+C7YKhvdwSXFqDPhqhHGnH4fibJJjwy4uQMNDfeb4ZBtoyAY4cCdG18rLYCm9tfLpCSXKbB0agzouhiYNTr/Ph61cfhqqr+qbhUApzzEkZMKLYLQJ0Wwk91tDNGMaa4wfvuR5XxR7W67h5AKGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRcWEPr3; arc=fail smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782474399; x=1814010399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nHzi2FXniijWAB3xa2ChzIItYrvHlqDtbBmYlNe9TOg=;
  b=NRcWEPr3x5hIgPuOTQbp8HGflDlxf954Oax7MQmmfUUzioLOorMY3q1o
   nnHTQHrIPuFHB8JfHzipqSaBsNPYCHL7Mwya1f9Y88lwsTnBst+U54sKd
   svyHIfICGXnXScRKduuaLJtT6shBfcIHLTMAIfNVXtoQ4Fcakl9mGSEBj
   MjBeC9BMdKG1pAwwzQiC1RK1r7xiCxD6RwRQBwViioeaYPnYwuYBrR+E+
   uMrii6Tcg+SKrd1oFfJj/PbmPonC56M9Di8nmX5vwM5U7ximuWjFrZL6d
   9rHKYPC1zwo7JXSfFypT1NAKCTc4bZPeSGPgH4v/vANkwAC7DWNGJYEct
   A==;
X-CSE-ConnectionGUID: JYh/xP/HRwGrbQBkjvvyiQ==
X-CSE-MsgGUID: J7tclEG/Sh+7dvuyrGnLJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85817347"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="85817347"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:46:39 -0700
X-CSE-ConnectionGUID: hPuIJHH8QxajMIybdU6SzQ==
X-CSE-MsgGUID: mp4t+xA+Qlu7ysAHMV4sGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247339456"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:46:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:46:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 04:46:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+3To2EThBOhLo+y2ODvz/I7F7JI4qdpbxRFDod7kl3pZWAmgmolTSSIPKfmtMKN247ax3gzDJHBVEbdg86PlnvqNPUN7Fb9a6ajvQe7yBBz8/Zh+rjA5Ic4dPGEV3G+aJY3ugU0bzeaDZSyi0QMz2xApp4DYwzSL4UXjZVDUGS7XBCDRVFE5DveRtk2M7Hi8JqMz231HvjWOclEfGyOIbLnL5mIrDi58THKEAmWgn+u5VyAuSLDHkNpn3i9s0NrHPpjQ7wmbk2rFX3vdELgzvGmvHwQOEFOnY3O1ySf4Mo4p2oLasVKZncF9DQl82AQ7NJZkK4aCsWFzRCvBzh62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99IaiIOdyaWvneJuhK/GEyJe09c4tXZh3Iybl65KU6I=;
 b=Az2SdbO1yAMtCbkQuDh+dJADvZGbc7/HExAV62db/ZLOCwqtgmubiX8TEqGsyyjjh29oo7QQA8JZbb93vO15Jszzqfs4vi21S7L4ONGaBuprn9g6wGzuMb5B+LmPxl7JMP/LtA4YyEV1GW4VYgN8gOStzC8qoXrSdYPIFklzbjNZgw6vk8W2kfOdseOcf8U6eyp2S0WfbL4VPBALZBp49an+HNSH7uSC9tiJOVFOje8BHuyqa81hsTFWEoSRbM2267iVt4cWHDtQZa4abNenYbm3knm+LnUBZjeetsUNWOQqPiP8dpz2HMDDMo3MrT2ZrrXyNgLYyKMENxg+dHLvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 11:46:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0159.014; Fri, 26 Jun 2026
 11:46:35 +0000
Message-ID: <abe7fbc3-522c-4eb4-989d-21270f1ef2af@intel.com>
Date: Fri, 26 Jun 2026 13:46:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl v3] ice: retry reading NVM if admin queue returns
 EBUSY
To: Robert Malz <robert.malz@canonical.com>
CC: Simon Horman <horms@kernel.org>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>, <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20260617120753.1785565-1-robert.malz@canonical.com>
 <20260618152003.909400-1-horms@kernel.org>
 <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
 <5658849b-0425-4132-ba32-5801e2907c60@intel.com>
 <CADcc-bwd2CcWJ1AFDm1GR1HBzo2OOh=Xr3moNS+-RVuai6yVBA@mail.gmail.com>
 <CADcc-bwC4FGQSGyRcnj2ZpGT5+0Q6mjQd-FTCB-mCmmwYrC8Qw@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CADcc-bwC4FGQSGyRcnj2ZpGT5+0Q6mjQd-FTCB-mCmmwYrC8Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DS7PR11MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c3f65b-6dd3-4816-e2b8-08ded3789302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: tsU+YleBv3Hbs4YN/l1btRCwQTXC5J8ugHyPgIWtEtDFy8Bwodo+NPv6+02gq8LSFotT3xCYW4YLKey98bTaQF5qGd9tNK8BIFl4a/YHfBgGyBBwbSmb68nkzXdgpkteb30eA2v5Qk4deAExgyZrPnpSkGM84t9leUBQrR14jr1ULOKxR8c8AR6y7q4kRwk9I6R/luqEZ4eORainpqMDfEWgrzbxsq2TNGpMnxtR6RlaklTbxbW7gnv3mtbJzugaVf34xmkYCXny7LosAsMPHde5/2p0qxgTk6XZ1JY/g6hUrAOv6mj5v7zEWnDYIfHVXJklV4OQCJEM59xnJZbsKVb5dJotmrEwRRRIXi5jAWPxvNOLQzw8pGCE/WKzjwBtrXpkILarmi5s6OWBoFSkBwneIvpIkWp87hFy44Kdo1jLufkG4JM7KwmrhTOAQyxDhKR1p1G06xT2tzGe7701MMgUunUK45x1WqTTtwk/P3aBAur4EwYOy4dwmMuYuspTleRY5T9xkT4BXpluVF3aISjVgrieWVrlrJzqT91ZbEvqkRsAHey17zB9OvffrgUFWtZ+n3dz3yut/lHLaq9sr16I/tFFfXWr3KwshgMDO0EGxoZ7cabKxhq9KNVsbdZwJpqF1VsFMzGcJpC55mO8bP7xJLMlMgCID8OwfsYAiJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THhrYi9EMWprUEo3SGtHNkl4SmRtWnk3S0dVbDVxd1VRV2lTUlRsUCt6RktY?=
 =?utf-8?B?TmkvYU15bFovdlZ1SXUxNlFLcXhQRHkrT3ZxVlpLZjNvWEZncVdMNENNdGt0?=
 =?utf-8?B?emFTa01Hc25QRWwrbzFTbktZMXNIRlh2MGRSWlh2SEgzY2wwa29YdU5IRTNZ?=
 =?utf-8?B?Q2ZRZVJqWWtmWHJIMjBQWFRmM0dWV29wUmdHbnJCelgrcm1WSHVTRzY0cUFL?=
 =?utf-8?B?U3MxWUlCMXg2aWxvakowQnltTy9RRzl0SE56aSt5Z2xBNW5xUnk0SU9ZYXp1?=
 =?utf-8?B?QWRCNmtCR2hBcCszNEYyR1ZVTGNzSk50MmZTK3pialZETW84SWNRNEV6ekdH?=
 =?utf-8?B?K2M4MlpNdVNrZ0hEK3VPc3JhQVBhK0VwRmt5eUowSWRmN2xWVjdjcU50TStS?=
 =?utf-8?B?cWFBYXlWYU5La0Y0Qi9IZytzRzZzbUpjUi9oOUR5WU9STzBBdm9LMTJxNkFT?=
 =?utf-8?B?ZzNVdUlqUCtiTFlZVTR4R0FPMW9LVTI1dWY5aGlieXRrbjVpQjVPUGtGcjYz?=
 =?utf-8?B?ZTc3MUZIVU9meEE5NEFSckhORk4rMVY2U1lERHY5ekptOEpJMEtLVk5zNHhR?=
 =?utf-8?B?MHl2eXUrOE15Q29KczJwZ2xuMi9XSGpoM1cxSUhUSGFhR0VXYzBVWGN2S28x?=
 =?utf-8?B?YzZ0eVRIT1NxSlRiVktjbXZrWmhpdkFqWXM0ZytRZmkzaWJGb2NlaXhUd1li?=
 =?utf-8?B?QzR0Q1A3elRXYklnWXVQSWsrTzBxOG1zYk9SWXpuaWNBSjN2TEJUMHAxd0Fm?=
 =?utf-8?B?UlB3bHQ4emVIclIybDVBL2lJbzZuRU5nQStZUnhqWW82QXB4bmhYenI5bW04?=
 =?utf-8?B?VXFiNURiblpTYnZXK0JXemppdkliR0lNY1ozSWFsYUd5Q3lUTTFoUGw4UGZG?=
 =?utf-8?B?dkNBb2YzeUp2NUNTUy8rRGc5dTYxOTR0VlEwN0RlNEVkNElRYVVSd3VFR1ha?=
 =?utf-8?B?V1ZsQkU2aSt5L0lwT2E2V0dId3liNjc0U3oxQzk5ZHI4WWFDUEdMMGwwd2hz?=
 =?utf-8?B?ekdUVlhZa1VQUjZsQjl5bVcxTkpYZHdPdHlYSzRpL2cwdjMvMmkvMkwyZ1d4?=
 =?utf-8?B?cDk1NjZLTmJBaWdqeHNmdGpjaHUvcDBCUUVDdFEzOVdzQ1BXbjBGdVdzaW9Z?=
 =?utf-8?B?V2lUKzR4TEYrWGpydnNBV3J5UHFlT283akFYM05TUVI0MGkvWG1QMXBkaUow?=
 =?utf-8?B?VXkxMmxCZ0xicm9LWm5QQStNM25CRHNyMWJJMTZVQkxHYTkvZG5nanU4NUF0?=
 =?utf-8?B?QWpDaXNsdUFSSUZCUVFpbWF6MEl6bDdIMWdCQndxRHpna1R1cnozU3BYbERE?=
 =?utf-8?B?RmVCSHBBQjlwOGZDMWhmRmRUajNaN0hPeWhpTC9JL3ZWME1HV2lRU0Q1aE5K?=
 =?utf-8?B?bnRrTkh6bUpOVEhDOUVvTStsSWRZYW9qYkdzMTVOTWZvTC92VXZBQ0tIb0J2?=
 =?utf-8?B?YUZ0R09oZkJZT2ZwMm5GaWNhNEZuTnl0eUpWZUc5MHhGQ2I2VmppbUE2akFU?=
 =?utf-8?B?bE5HVHY1UVFPRWl1MjJENmtLK2lqbzRIdGRJdHowN0hyT0V2a2w2TXMyeGI5?=
 =?utf-8?B?bXhLT096azFia010WUovUFkyQkN6ZUw0Myt0c0E3bzFSS29BSXJPQ3JJWWsx?=
 =?utf-8?B?N3N0SGlwRzZuNmxpejZndUxSMkFKQnVUSW9kUDlyRm1WQW15T0YxaE5PL29y?=
 =?utf-8?B?UU5LdmtXcWtoZDd6L0Y1cXdPc2tpQWJtMzIrcjFpamhmeDNrVERETWZoUFpH?=
 =?utf-8?B?Ym5CdzlVUkF6ajJ0MVdyRVFHa0luSm14eEpDMXlSN3V4Qlp0R3BmUDNkN0dM?=
 =?utf-8?B?U0VJTEttNXBTSThwSUUvYzhmODl5bytXMnNnOW56bmJGekNQU2ZjT2hWbmpT?=
 =?utf-8?B?dmNlaUhxOUN0dktJVzYreEVoTGIxNUgyaTMwZU5FOStKd01GN25tbVpTL2kw?=
 =?utf-8?B?WW95dFBMbTVwckVtSHVYNGFEVGdoVW1NTFptVi9IWWF1ZGs0ak9vTVZDQ0NN?=
 =?utf-8?B?dXVaNjRWT3JGOTh5SG9yQXJIZG9IUVI0NllTWDQ1R01YTzZrcHcrK25WZ3FW?=
 =?utf-8?B?SnppU3phekdpaGJORzJLckFXdzQxZk9kOWVHcmVIekxrMjdIUDNMVmw0RVh3?=
 =?utf-8?B?Y1NFOWt3Sm9xclBwSkNHa0hvbmNabDZjNU82Y2FZQ3lWUDE1K2ZBWEpwMEp3?=
 =?utf-8?B?RmppRjd5Ty94b1RHNDh0alFoNk9hLzdmS0g3d0ZJWDcvSDF3VmpPZEIxNWJs?=
 =?utf-8?B?ODVDU1Z3Vnh4ckVJQmI3bG1xSlY1U2Y4SXE5OVBtellES0c1SkhXcldPRWNR?=
 =?utf-8?B?Z1FiZGFyNDd0SFVKTUxvQVdEOUtiUElGRkRmbTlXRWU3VlRwci9GRkFxOXNS?=
 =?utf-8?Q?DFDPMIKjlMTIvq1o=3D?=
X-Exchange-RoutingPolicyChecked: qUpiMr0caU6GEoPpAj4Co84eFKIjTbTuZHVmZEafjPWVR5KwsFuMWj1LM5yDbZa+HIt+DPNCun64jNyh7jHTGG8Oa/btobHXPXJRQfrp5MR4JdBsMsFjtOPwkJJDgLIMscbm9/oj0TTt5WbLgogaa85GKGEQW91sJa6iaj7y3eCjVpZkHya10wTBylp8d6HnQ3QbJCZ/bTL9zoMYLMj9i/oew0nDu2f7PSqyexuBzwLJkFQoO6z09UNEjASQhG+QySh3WOkE4IZwCWbFW54rwbg82YuzNN4cNwn0HfmbAPrcos7hCVYCtggEmgxoufJ2I5zPWm/Z9SJ13Nb+bbCoxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c3f65b-6dd3-4816-e2b8-08ded3789302
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:46:35.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CJNQY/KRyLMc3w/X1FjloKZmTWp6WhdIfdeLCvxzMwueBf8V9Rf98XudviM8UHHxbE65KvbB+H4K9jcHlITXlFvOiPKSh1S8Hh+OkYV5xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-302156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robert.malz@canonical.com,m:horms@kernel.org,m:grzegorz.nitka@intel.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EED096CCA33

On 6/26/26 10:15, Robert Malz wrote:
> Hey Przemek,
> I ran some tests and unfortunately, the following sentence from the
> datasheet is true:
> "For specific resources, such as Change Lock (0x0003) and Global Config Lock
> (0x0004), this field is used by software to override the default timeout for the
> operation, and also to specify the timeout used for this operation."
> 
> This means we can only change a default timeout for 0x0003 and 0x0004
> but not for 0x0001 (NVM resource).
> Whatever timeout I provide FW defaults to 0xB88
> Input:
> [ 2209.656758] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
> datalen 0x0000, retval 0x0000
> [ 2209.656760] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000000
> [ 2209.656761] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000BB9
> Output:
> [ 2209.656927] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2003,
> datalen 0x0000, retval 0x0000
> [ 2209.656929] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000000
> [ 2209.656931] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000BB8
> 
> Correct me If I'm wrong, but the only way to properly handle it is to
> ensure the resource is locked and released between every
> ice_acquire_nvm call.
> I'll start working on this.

thank you for checking out!

I agree that simple retries with improved (refactored) locking will be
good solution.
Failure to lock should count as an unsuccessful attempt, with possible
retry after a sleep.

> 
> Regards,
> Robert



