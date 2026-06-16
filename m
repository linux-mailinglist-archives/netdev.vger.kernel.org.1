Return-Path: <netdev+bounces-299989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U7zvCIPcMWqarAUAu9opvQ
	(envelope-from <netdev+bounces-299989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:30:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597E695B75
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:30:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Rad7MzRv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299989-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25E993006827
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3546AEE1;
	Tue, 16 Jun 2026 23:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C342B72B;
	Tue, 16 Jun 2026 23:30:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652606; cv=fail; b=Jn0+AOenR/TNdLkpEpiLx+t6xuj3gu+GINVXRIdG73HoXJDbb5maNo7lfuUbWb3QZ36Usye3zY6gyzHoDwOSDXlWSx/Rel874+S2D0J1o70m3XBQ+9bTIZt9MbArdQp2LT+RPymVKlgEw5YX794k1A0ioPDt8XTtTydwcz3hhQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652606; c=relaxed/simple;
	bh=uMummPjs0EbsOIvRMGXpWkBCmRbGLx5NANycQB3cUn4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5f4oeLk1jF9ejgWpt+ro7jnTbsnpVcU9J8Ci9MHyldWiF/pUtnDLEavSpAziRSbpZiZzw85FH6g5ZCw7so647tKBkUu3D6qheOIRgCtPaUbb2ZTE+q7xFCnqVkpjQb4w3y/62UphMkCHQQFMBRHWV+Zp9U2SXTP0w3vFA/mwsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rad7MzRv; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781652605; x=1813188605;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMummPjs0EbsOIvRMGXpWkBCmRbGLx5NANycQB3cUn4=;
  b=Rad7MzRvJAmLzUnMuJpmny6mncvzXcC658M7iWYLiiySxfzfbwxqlxAB
   XJB/cz+lk9JCt1boPZtJPihx6ihLonxJvW5TapqNygHFHnRk5xUYFQG7E
   dQsWPVEyB+FsKpf2oN/+5/8KYQa0A5KildzVsLYW7eLoL5Yd5XqXd1SwV
   veQP3AjR/jaZLZiFiUdoMMhJR6/xlaPt0y6+d5ok5SFvbSDioy7SLamf/
   4cZ7vUl0YV957fKU1ZzE+voQauInMOQ2htVimQsJtmlNe2TxnX+klQDrR
   38Vg2N4TN6vPTijopHnbiPMy8pe6xKfELlvV6PMU4xwQ5G+gYgLKoiqj9
   A==;
X-CSE-ConnectionGUID: JXzZ03DYQqiHBf4vnqksFw==
X-CSE-MsgGUID: JaEs03ORSsm//geskX/l+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82445609"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82445609"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 16:30:04 -0700
X-CSE-ConnectionGUID: yKrxBXovRSinSPNNuhZv+A==
X-CSE-MsgGUID: Yr6tWthGRHWQmpcu8bcVIw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 16:30:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 16:30:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 16:30:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 16:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuu3spsuJMg9Vt4dN/TnXj2E7NG4fGaUA3R8nAVL4b6lPE68TLEwa/z9g3N4BefGYHy7VAVFCy+je1k3u+CwADHzR+6dPRFkwSfBNsmhyO+pzHLoB1VzVHZUXuqEvidHiabg/3JE4QQ9n4+AB2QDFxLjU9qSGjlEqGQy2QuSpZmysTkNy3P8Y2U1fgAxcd5Vs41XDOra40c9e3RKZF1WAV/yjo6sdAVPGrSBGvadqlen50+u+dlMdFpptBcU2Rn2IfMcO2/PMt8xCSKRLeGqaEp4/FyOHu6W9qM4jsVLYX/fsQQjGEu+aGsQHvj6xItjKY/oIRdrakS6wmGlhhkNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dei1c/8d3NrBr71EUD/ASG2Ayin6SE7odMn9JlYnEmw=;
 b=nGMmpyjnv7y/JFIXaiGnlzGYr64GrCBrgrkOrDV2xn3LDJx6MFsHqrzuymNvTkZ3lWBcIdV9LSu89pO/n0IQoligZdIJpI57hCxOe2o/Wq42TCjQYpcH2N1KEDS4aDH69uPW20Zx+rzHZdxvd/lTUKxkb4zuWjJ331r9I17/3NiFVAAK7BzkSfVkYo8RVZuOHOvL2rzJP28Izyn2OskOt7RBvkFu2jM6X9lKSd8BTIDEXG9/0arWz57+mSR5Iw+bWxyuSdd2VL8LJiwq04EQNjcv0r/ZP1Vp1Cu0soNL4YxPASsRTAC5YgbiCWBnfG8G+en0V7uNfLGYcmQCChXDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 23:30:01 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 23:30:01 +0000
Message-ID: <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
Date: Tue, 16 Jun 2026 16:29:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
To: Ziran Zhang <zhangcoder@yeah.net>, Jiri Pirko <jiri@resnulli.us>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260616013245.7098-1-zhangcoder@yeah.net>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260616013245.7098-1-zhangcoder@yeah.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN2PR11MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2de70e-df50-4138-8614-08decbff2f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: aE/8RIYtFeuw3ql2VUO90UFclJo3v8r4HgbfQhJujlKYInaZwKkUXAYoNV1397HK/u1/KSg8mSn16STammiHEmUlP8tp+6MFjYM8+lodIN/Qs8dkFuHQNcZxa4MakBqhRHSe1lMLjcJQ41f6U3qotn2IRVVVDIS+yj2yhY5u9xTzHIIzb2r/UndEiUaKZ/hIKx0Rw05XaZsN8YQf+OmJEKJlgOYbst/IuVPtdQvqKzeblKS8z9Ekgv/7vkkYYgxCZRGg6BBHCaNSztqcxWcXNli8YwmxZyCW5V14GDw02RIvmiNsGCTJjt+s/HuY38c/es2e4YjSPFgbsg76cPy5G8eR0WoS22MRfU6Uz/3oU/Il/IDYTIo0jQFHsS/m5SYkkFtRDm4+BTgYaLlvgsUMD56TFq8xZT1aYUUROYRpe8/pnc2KRy0mh9Y8ELyXQer3sO5lSYU09Z72gqyp6SLhxAXUK/CrBzn0tSwEbNVCsGyhTNSsH1kAGp7z4OYDtyXgbXR6wVMvgDBQpik0SsXWhmaKR7pVz+16V8wVG0JHwAzdG5XNYMHEt56/LJMpiJKI35pc9QG8LLVIyUFJgOEog6UaxS/2vG/kWH4Yvafc9qbtWGhEE/s/PgzWIWlskfgBhCBlo1F1WJ3FZEJPcYMv/6/KLLlJrm/B8B0/PE03tZ9/ryTheobgTU/sjKPCZPSj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE02Zm5iaWE5WXRVR0NLNkpPOWFNMmxxRGRmcEh3SzZZWEtwTmwya0pMekpK?=
 =?utf-8?B?NHBVRkVsSnF0NmMxNm5wR1d0dFZwU09jaEFLdFRzdmxLVVk1WGp6bG11UkhB?=
 =?utf-8?B?VGRyTlFxU01Od2d5U3YxT1pDL1VUMG9jTGt5SUhoRWg4UGp1ZWV6Z29VNmlV?=
 =?utf-8?B?bEYzQlBvbTJ4US96RjQ3a3dSUGVwSytaMlpoaFlOeVJ3WjVVUG55ZXZBSE5u?=
 =?utf-8?B?ZnF0c2NKZmszNnIyWVFYelBUSW5aTlZwTXAxN08rc0hWTTcrTUhib3NZNVFQ?=
 =?utf-8?B?SHc5NTYvRVpmdExnYnZKb3BYTWl0M2YrZ2J0c1NTNklqSndDbXoxVmxZajli?=
 =?utf-8?B?bk9kMGFGeno2NTNaTUNaM05uZzh6NFFrNzZUU213RlVFOE11NXRXcEFpMnRV?=
 =?utf-8?B?SDhUMHBSVWRsTEpEVUYzVGNoWVhya1RxV0FGczF5UDMyZ0o3WXBGbW0reWRK?=
 =?utf-8?B?TlBEMEVQV0NJdDhKNkhROHg1d0huVVAxcWlSMU1rcnU5ZWdKcmZuMWpmUEcw?=
 =?utf-8?B?Yy9NbWdjVWcrUGg5VU90OVV5NU0wYUJmcVk5Rkg2aHdGVkdMTm5RU3RRRkdM?=
 =?utf-8?B?ZHdXYitNNVZPMG9hRWJ1Z2FWSUhZMzBEMkpIc2ZCTTAvS2RzTU93NGFGZVND?=
 =?utf-8?B?MFBDQnJQOGNGM0pqT1IxUHNFR0xhdFR1R1ltMjhacXBkMXlJSTQreGMvZGxN?=
 =?utf-8?B?UzRqWkhCSXBZdG1JclNCT3E0cURkSzJxMU43N2lxaEQyR21nQU9qTTRjcWgr?=
 =?utf-8?B?YzVEVUE4NDNJenhhZFdIRWFKR3VBTzZDeVlKcG5HcGpXL25EZ1BMQi8yaWU2?=
 =?utf-8?B?dmx4L210S1pURlB3S3MyRjVrb2ZlSXplTU83NmpETTE2b0orUDlubWdoV0Qz?=
 =?utf-8?B?Mmw3ZStoVnZDSGFiRFBTbVBHUFpEalByLzc5LzhjL2tiUi92RjRXc2k1eDJl?=
 =?utf-8?B?U3M2cDlqZ3ZHb2g2YTRvQ1U5dFdMNnZqWFNPN213STRDZitZWXk5YzA5UEoy?=
 =?utf-8?B?UDMvbDdBK1VwY2gxbzhYcVduUFRMb25EWitZUkRpSTJwQk1VcUMxVktJUms0?=
 =?utf-8?B?ZVpRRTQvanJtSHRtaFlNcDA0V2dEMHVWSlBMdFFDakp5VVhOWUdGalJRWTl3?=
 =?utf-8?B?U1A1ZnFXWVNYdk9TWHVxYXlHa2Fwa1NGQ1hQdEozdXlMYVVNV1MyWWFzTGtY?=
 =?utf-8?B?dll1eENZTnBvSS80eTdIVFg4WUtlb1dUMGVKbXZRTlVZQnI0ODZaRDRQSXFW?=
 =?utf-8?B?K3BlMWM1a1dkTkpQQXNFNWxWajRQV0pobENpSlB2RjVvVU5GSVVTL2pPMWMw?=
 =?utf-8?B?RElTU0xwejg5Nys0RTI5Y1kveXlrQjk2OVU0V0RsZEtCZnpHN0NHQTUxSzRR?=
 =?utf-8?B?WEJvbXJnZ0UyRzhNcldlcGRIUXZGY1VMeWFmR0hwOFdsQVdlNHdOZEtrZCs3?=
 =?utf-8?B?Rm90T3NPL0VQblgwUUZaRnpSTkJqWnVWRDZjQStMaGh5WXZBMkYvSS9Tem11?=
 =?utf-8?B?ZE80eVl4N1ZjMVBkQVJpZDgxaTd0dVpYZzMveTVlK0xlSGZRb25FMG85NEtr?=
 =?utf-8?B?NXV1aGlhbGR0NDVYZlFZSFh6U045MTZodXZhK0phaDlvZVozUlVpMnJiQU1G?=
 =?utf-8?B?M1JvMWgrUjRMbnM2VDFHbXlXYXhhQi9zZU1NeVhIVGFTUGgvdXFHaUErWkNi?=
 =?utf-8?B?N3R5TUNiQ3A0YW1HSzc4UVFjMFkwU05TL0ZZMlNpaVBLQTd2VjloOFc2anV0?=
 =?utf-8?B?UjcwUjAzRVFoTmJNT2dYUlBtYW84dWZCajl6d2FkdjZmSGlRN0tGQ1lzY0tM?=
 =?utf-8?B?YlhyYUJJRERVN2NQaFU1MGRiNzdCMGZudTYrWitsejVjREhVVzBLUTJzYmRF?=
 =?utf-8?B?SVExR3pUbm8weGs3bUphdGZJUnNMYXBJRHd1REVrdll0V3BRTW9NNzIrSHQ3?=
 =?utf-8?B?WENYQjMreG5lUHNSd0dCQSsyQ1BVaW12SkMxdTFnNEQ5S0E1TlRtV3lzN2dC?=
 =?utf-8?B?ekRzVjQvUTZydnB4K2FFWEZpNUQ1bGdFd1hncWdpL05UeHJaMHVWUURmWHlw?=
 =?utf-8?B?by9icGFoczFFZ3pWZTZkUzFjZ2dyT1d4VEZVb0Q3bS9kcmd5TVpnb0tZMUVX?=
 =?utf-8?B?VjVDSkV1OVlJOGhzcmZsRGhQNU96N1d0a25KK2hNc1lzL1RpS2xya1pMVHpj?=
 =?utf-8?B?bmQ4TWJuUjZBQzZ6QXFzQXVjVTB1QW5zL0tCRHl5MWdYeVh0UlJhTWhLUFZ1?=
 =?utf-8?B?cGVWcnRxT0Y1OUl4KytQWTY4SllaaUtkMTRUcXYwVThqL1cxWWNQdEpvb0VF?=
 =?utf-8?B?aHhQR29NM290L0xGQ2x4b3YzY05wVHZnYjlhL001TUJHSllNUlJiZz09?=
X-Exchange-RoutingPolicyChecked: Fkuh+yRtstyMGgcUppRA+aUeVKCXwdWO4frOzNI+cROQ04TLUnwzQYt0TZMoWr2t/qyfTN4Ipeb6WbrUTXyJtgHge6PlLYx72jKj6r6BDY00BNRjdER+fnqrqGdieiFjBTsKn6tj6IHSrgFyNK7mS3nZeUDndvebSBeITkcXbjFsDLWcYNd0MjODyJ2G93a/K+i1ujabJIvQpf9d6OB/WstmzKzTqhp5JDCw+ByHwzIVgBDAc1v8B/j+1lZuKa9jCSQX87h1N1lPUGcSOELCdkliV2VY9/B4Gcou2Vx3qo4T7kMtaUTTGnL/bpTHaS3x892JSuDRxdrW6XLRMcrrSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2de70e-df50-4138-8614-08decbff2f9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 23:30:01.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+onXSVHywfsu48EVsNofRnxGifopEUK0HPFlT95GBFS7aeRnt7Mi+7iGqURmZ2upDhIgx6Wqlv6K1EknQvtgLR8SRvSRspCcrAq2pbaFR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299989-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhangcoder@yeah.net,m:jiri@resnulli.us,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[yeah.net,resnulli.us,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2597E695B75

On 6/15/2026 6:32 PM, Ziran Zhang wrote:
> In ofdpa_port_fdb(), the hash_del() only unlinks the node from
> hash table, but does not free it.
> 
> Fix this by adding kfree(found) after the !found == removing check,
> where the pointer value is no longer needed.
> 
> Found by Coccinelle kfree script.
> 
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
> ---
>  drivers/net/ethernet/rocker/rocker_ofdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> index 66a8ae67c..15d19a8a1 100644
> --- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
> +++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
> @@ -1924,6 +1924,9 @@ static int ofdpa_port_fdb(struct ofdpa_port *ofdpa_port,
>  		flags |= OFDPA_OP_FLAG_REFRESH;
>  	}
>  
> +	if (found && removing)
> +		kfree(found);
> +
>  	return ofdpa_port_fdb_learn(ofdpa_port, flags, addr, vlan_id);
>  }
>  

I looked at the surrounding code and I can't find any other place that
would have released the found entry, so this does indeed look like a
memory leak.

You could potentially verify it using the slab allocator stats and
setting up a test where you add and remove port fdb in succession and
see if the allocation of the correct size continue to grow.

This whole flow is somewhat confusing by combining both the add and
remove into a single functional flow. I guess it is intended to reduce
code duplication but it sure makes the processes difficult to follow.

I suspect the original code mistook freeing the searched entry as
freeing the found entry.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

