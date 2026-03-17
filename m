Return-Path: <netdev+bounces-268699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO28NaaWuWkJKwIAu9opvQ
	(envelope-from <netdev+bounces-268699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F02B07B0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50FF307EFFD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7F37EFEE;
	Tue, 17 Mar 2026 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVE1aMFF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36D31E841;
	Tue, 17 Mar 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770271; cv=fail; b=dumFFb6d9nPdEkHX9RNR0cfgURHaTs2nTdJxrSFRuWjaq4tV7pXZGKhE4FpPCjm5lt699FgI5xDd/eIEcbxdJieITf7XAfhxEGfOP3YEzF7N0qzdfXelcRFjkIfu45CYpupeAxmZ5ipF1SnmPZz2seAi2dq8U/wLS6tiDIaijq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770271; c=relaxed/simple;
	bh=dmwJted2M/aGa5qZ0ixeuquMtszGkN3lwCXNy41ke2Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n09eKGoiOfzgorLEP9gngyXznMwdauiyzVxI8emTo0SMjuN9HZbVTCZc0sgHS2syOnG4fT8Sy9RPuV/Pf8xDqhYUmsBoprKBLcAhNYKM/UeLf7kJB9KQcRhqeLc/1gE1T+91H/wYA8eZQ1LIPDxjS8+IYvz2C4aApAznXnFvCk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVE1aMFF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773770268; x=1805306268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dmwJted2M/aGa5qZ0ixeuquMtszGkN3lwCXNy41ke2Q=;
  b=DVE1aMFFABZZHNHGD1un52mwk8drQ7LVeL3vDMQinjbaaUSR0mzq4HtL
   q0VUKVKxG2ybQBRHdQDL1r0S8Fv1Zut0Rqc1SI4Qavz05+t5fNAnB6ZNV
   3iWzEmGXVZnjqBvOyo778DPhxde42UGjuZnZmv+7oqTE+grTQJZL95Juf
   x4jCmYD9X1I94DXT9vvJJAAkgbnmPnqjvxnsLBxm6Cl2z5YBjIszlDyL+
   II66CIGtN6uvnip4mE0SVxIl3DyBD0C/4sq/hRy8v2iYJ2aZOeCOTGmbT
   51SBJg1E0rKm/otaCobKLwvuXfJnvzfERymjNLlFjsoiwogURgOL7MhQe
   w==;
X-CSE-ConnectionGUID: oCVZz+TOQt2/l00Mq53x0A==
X-CSE-MsgGUID: Q/uGn0JpQvyzFQMT9z7afg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74891415"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74891415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:57:47 -0700
X-CSE-ConnectionGUID: VVtq7woITLOtpasP4bxVAg==
X-CSE-MsgGUID: k/0ZKhJVQfyYfOMni8FApg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="227023820"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:57:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:57:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:57:46 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFw9KUvMtCIkdm0AnzUKRu/K1e0qpywm0zmvbrH+9Xz0HIAD6p7bt3mOBgEw1d9Ntp/Dj9Zv4qapI6Y0Un97/pnevATVI8EP2WDFSOEdeFtTJbbg1yxyK5y8l0Ft3h47vC8hsQLXOUslDaQ6rpAV4E45VGQlizLvjIEAd6FsaWuPYJOzDO1XLKDJ4KW4ZuKb9GaD8401UJi4Ybrdu4tbnXRqB8fuBeDxGJl+ccHKd8ZzC+N/gWGwHBAg5x6U9AJ/7on+T9RUkjsorXTru7b5p7CFo9fHvIXvzaK+Dz3mzs4db7xB8aeUZC3cElRq6IRhchJKMSxVptHIXityT8VWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHGg+KLS+kkoUq6KpVy387Z7kqh1MYfjTZqn8UrvGy0=;
 b=EzWUuPV6l86by0eyuTw6Dlpu6xyjkvcColc6NHwcmhy/+VPtjTjSaX7ctEtpGMPS5UStqykqAEQ4VJ2qxZMtf908CZ1sZC3zOyFVTKabiwuQodBRvFzJ3nyiTfyZxYR9QsZ2KQxBYVKXFWPNFFb+eyWJeFLG8kbnt692QtEfA03VTLc/h9x656XR8z6ifUUBlLN+y6rB0f8g8O13T0VpiBXUGUU3d0ZsnKWTYKoeQN0gQB3G1WloSfO8sZpYCHjUN0wQhs+lDj1zBDLUTeuUuj3ajVXcrGyaT8fVXzl9zj59vsxP0xYsN2mzpSsNwbF3sq81UUATbJpdNDUoIbtIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:57:41 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:57:41 +0000
Message-ID: <b616486f-f296-400e-ad12-e7d2bb8c9174@intel.com>
Date: Tue, 17 Mar 2026 10:57:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, <horms@kernel.org>,
	<edumazet@google.com>, <sdf@fomichev.me>, <aleksandr.loktionov@intel.com>,
	<ast@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<hawk@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<magnus.karlsson@intel.com>, <pabeni@redhat.com>, <jacob.e.keller@intel.com>,
	<daniel@iogearbox.net>, <maciej.fijalkowski@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
 <20260313014628.1509116-1-kuba@kernel.org>
 <4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
 <20260316161630.2d9ac04e@kernel.org>
 <a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
 <20260317085025.6459821c@kernel.org>
 <21a23b98-5014-4330-998f-53acfe705d67@intel.com>
 <20260317102917.14743543@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260317102917.14743543@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CY8PR11MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9488935a-ee0d-4901-ee16-08de844eaf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7jTwweNlFIEadYoipIc3A/+l7tL//srZGDEaBVEEWx+M1RUBOCWQPw6hNoWmZxCwQlcfuwVWCY6rI1LL3SenlESpMBGWhUtRA//ffK4Au62aCiYw8Fp1YvDh0/r9jpUQsP7QHjVMfRAuaAT1GmzSor1mbabdGsbHKsdXK/nFpX+yYWJPWaPswjJGj82IW/Y8Bsv08W9gWWTfw5gXbVbVcFhBzffvC95vCqsm4kjX3Tp3HtQ8N6yzbuckPlk5YwgHGRu0g3XRIEslSaPBCenN5clA3jnUHaiRhniNs7ulp5DVOX9SfOh/rIFJCEA1k0PoVI51YrxS24mIZP13l6l8eAIsFgccXnpyHrJQZWq1epRZ8hjGun1+13hP0BQQeL48kp3H6alyIItzYwGWcQw7V+Ks+lTgGn/ruFk09eb/I61KhXMANlSsgif3QCc9AKFQ/QOhwHJh64lznqXMz9gOxcJ64Dz/BcW3XXB3x7A+0eOG+s5zcMAX5DvSnWMSs79e1UZ2Kk3LczFLqkn4i34Kes8AkTd/qUKvwMnmBKHzQ9ol3Eluh84zP+X108u60tQF3q34pjrepF9ncu9qMFPuJlmOEywN143mDbFKcONbe91RzLeaW/zdSvWejXu+hTvqBRiPDLb9Ds/Fg0yIBbTRA9KV7q4UjqtaWajSZ0OEaQUPRRrRWG7u8aGsLqieIoKfdptatLCbblUIp9xWUXV6kuNbVXEZXINoVTVe801ciOcQRE4eTQgwNuCXBZd/oLwy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjMySUcwQTJrSHFiREQ5Tlc3ZkE3Q1dyZ1oxSzBTaGJHZWd3UnVuUVY2d3RE?=
 =?utf-8?B?b0JvTFZybVJINlRJeGZEOWNnL01HcVgzalAxVmZPT3pWcTd6cFFlUHFnakth?=
 =?utf-8?B?UW9NZitoY3ZBK0o2TGhaSXoxN3N0MVAyakI2MTJkNEdSa2dsSUdTc1EwQ0Ew?=
 =?utf-8?B?elNkTnk3N1VNWG1PbTgrL0pxSi96ZWtiZVNIMk81Q1pJRHRURnJOOFdpOTRz?=
 =?utf-8?B?M2ZMbjJHVC96THcyNFFwTkpUVVRoSlNCbkNLZnVkSzdGTVFyNzZJSXpCeXl2?=
 =?utf-8?B?K1JDNFlpcUlEcGlndDNWcG16ekpGNEUzMHVGWlRPVUxGdk1HUTR3b3ZXSlZp?=
 =?utf-8?B?R29JQ1l6TkgyT0E2eXJMQmNMTDhuUEx6QW1hSDJCTy93L1JNdGZ0MkVxNStB?=
 =?utf-8?B?VHpyQUdNMk5zNVBxb1hoYTFHQ3NMTFoxZTZ1d3pDT2ozbDdPcDNVTlZEV1Aw?=
 =?utf-8?B?alBtRGx6RWFXV3dSYnZLODBlZzdjWExwaWNERUFMcmVocmpSNEd1UmFZOHAz?=
 =?utf-8?B?cENRY0lHMm9qZWcwZVRvMnZBSUVOcmYrR1NDaUF4TWFPTUNweVZGL1hhcXFB?=
 =?utf-8?B?WVlicWZERVFlZGVwVUJ2VEZlSkx6Y0VMRXRUbDVsOFBWSWVtZ1pHdWJLZVp6?=
 =?utf-8?B?aUtDZjNFVGlsRnA2WUllam5XajUraG5oOXQyYnFFT0JMcFFTMzN1SkttQ2xQ?=
 =?utf-8?B?bnBWOGFPSTZLMTM3clJKZ0V4bk9HU2NUVkNiWmtWbWRaYlFGb1RTZFFRVlI4?=
 =?utf-8?B?OWpHc1JzaXhWN3MzUmxzdE1rSVMxa0FtSXEwQmg1WUdxMHE0RzNXSDVSU2g2?=
 =?utf-8?B?YmpINFhjak1jQldmUnRmVEpTUTFvM2hqMmRHZGhvVGFXYU5PVCt5VkhKUkt6?=
 =?utf-8?B?RVV5bXZXOFJlcXZOa29ma0JEQTFZMUlXeUhVcmQwOS9EZEFRdUtSdGhxdnVV?=
 =?utf-8?B?dGpWOExON0pwV3FzV1JiQ2l6dGJEMEE0VHJNQ1grNU43YnJwaTJQUVluOHE0?=
 =?utf-8?B?QS9ISTJYbHdCVE1kZHMxaXMyMk1SQWN2VjVUQzQxRnBJb1NYWEZHSHRaOExY?=
 =?utf-8?B?YzQwWCtjVTZsUkR6VE1GMnBia3N1bDFGbEM2QUlvcEozNzBSZkVYaDIrMitW?=
 =?utf-8?B?YVZnWG1zZElBZStUcU4wVi85UjVTZkdqVVJMVnQrZFA0eU9LUzU2SGlLejJS?=
 =?utf-8?B?NEJxak5zZVc5dWQvMXh5NTBBa2thbnBiUko3VlZnRlpFaFA2VkJvQTFsM3ox?=
 =?utf-8?B?Snp6bEZ3NjJwWU12b2pXeGk5NXJvenord1BMWlloYWptOGVsYXdnSnFkYjBK?=
 =?utf-8?B?bEFzUzJ2SVUzWDYyQzNZTkFWRWtRY2F0Sk94d2F4Szh0RlRibFV1c2MyNUxW?=
 =?utf-8?B?SjZlSXREY2NxSi8zVjJLanIyMTFMQ3JGdXJEbk1Bd0doRnhCSDJoQkJLQ3Ev?=
 =?utf-8?B?ajdwRFlEeXBKQmNZV0ZmR3FWMlhaZjd1VDN1N3hDeWJvazZZNHpYTVMxelhS?=
 =?utf-8?B?TVFWc0xBRHJYVlBIcUZSOGFSWUk5MUJ4cXh3UWd4RkV3OUp2L3dDMS9hOHdo?=
 =?utf-8?B?QXV3aWwwdytkcGxjaDhqZitOeWxpenVSTUdlMUEzV01JMHk5dVoxWXlNQTNv?=
 =?utf-8?B?aWVBYVdpRHZSWjdoYWRGd1Q1UkdKeitTQWYwd0FQTDZ3bVRxYXp2SUNBSVRL?=
 =?utf-8?B?UW1mTitKalJWYUZMdkU0L09QYXk4QWpZZmNGS3lHd2kxb0ZUNFpoN2xKdXZD?=
 =?utf-8?B?RG8vd0s0UTRxYXRmRjZrV1FLdXpZU3M2WU40TzdlRDhxM2twWDY3SDI2RGVX?=
 =?utf-8?B?Z3JSMXJDdzdVczB5UzcwdEhhYXlBM2RKMVZmS3gzSjFBMDhuZW52c3ppeXdR?=
 =?utf-8?B?RzZVdjM4dEJldzcwRFJMSGw3Umd2OURlS3lTdkRpbUtXbVhMeDNrbURlSjBZ?=
 =?utf-8?B?bTR1MC9LWUpLaDROWTRKNGR1OFduYWZSNnBUcDJoSDdqQmw1TlFjMXIzbkVD?=
 =?utf-8?B?dWd5TWVsRzZ0QUkxemN4WFp1Y3VIMjE5elk0MjZNQUE5bE5wWGMwTXNwZmds?=
 =?utf-8?B?d2wzeDJtN2Y3ajhwRFhCOG1nZ2RaYVhyNlNyUjV4VkoyUjB2WGJ0SW5zK1FU?=
 =?utf-8?B?NWpxZTNjQ21YaEJ1ekhTcnhFR2FSV0lITUxBVzBtQVJURXhXZk1CV2k1aWZK?=
 =?utf-8?B?ZU04d2RjUEwxSno3V1BrdkFzb3RvclkydEdWWW0zTExSRkg4MFNYT3YyK25T?=
 =?utf-8?B?clRjM0txcmdlb2FZZnl4aC9wZHFtU1lnc2xHK2FRalJXTld3YnhkdTdQVmJL?=
 =?utf-8?B?UFdadDZCOVpPZFFrZTBQZ2NLTSt6bW5TQ3hBajMrL1ZHZXdyNmlQd29PSGRR?=
 =?utf-8?Q?OJ2bKpzZ2jj4AtbM=3D?=
X-Exchange-RoutingPolicyChecked: QzN/lYlHe5lZ75nO8eujyq1RizfZY8/Q5qjZ+DtinBeLE1qDJwBZA5eCixGEPRahN3NmvKQIEn2AzrKq1v5gLQiTNAISOhwc1BPc2XU1RkHDCO79KG4Lt8c6ntCXZXtHRaSdYe9glDggv+UzhLvs3p5j9/4Esk5Q5Xlfj0ztfFNdhpq1sG3m9Vk6Kee6uqBG2Zi9q+pkiyRJRbnKBLE/bNc76vTRrAoPhjGfzEPhOoZJ0R7J6L2ux0Q5Wtz8VDJVKcBice/Tnnwz9iVcgSYWrrDoor+5oEYXDOJ6l8GzBzRRX2FG2TosQlhBRi7XeJiTkhqHpp0PwWO8lB4YvuGmAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9488935a-ee0d-4901-ee16-08de844eaf08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:57:41.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FcZPkizFZeuxCNi+pgk6bcKYrR49EEX0QcyzlnYHV4oxjf1DnmUE/YvLaP74cxoYpcJWrGy4wT+smCGw5fh0ZVzvEHEu9XFbnTuhGd6ksI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268699-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8B0F02B07B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 10:29 AM, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 09:15:46 -0700 Tony Nguyen wrote:
>> On 3/17/2026 8:50 AM, Jakub Kicinski wrote:
>>> On Tue, 17 Mar 2026 16:30:26 +0100 Alexander Lobakin wrote:
>>>> BTW, if it's not top secret, how do you run these AI reviews? Because
>>>> Tony used the same link as these reports provide to deploy a setup, but
>>>> we didn't manage to get as meaningful results as yours. That's why
>>>> several respins of this series only due to your AI reviews, sorry =\
>>>
>>> Nothing secret, I didn't push it to the main NIPA repo because it
>>> mostly vibecoded crap which is embarrassing. You can see it here:
>>>
>>> https://github.com/kuba-moo/nipa/tree/air
>>>
>>> It is just Chris's prompts + semcode. We run the prompts with
>>> sub-agents enabled (the "orc" prompt). Right now it runs on Claude,
>>> the subagents are supposed to pick the model by themselves depending
>>> on complexity.
>>>
>>> I don't think we do anything special, if anything it's probably the
>>> mode (orc mode thing) that makes a difference?
>>
>> That's possible. I'm still pursing it but, at least so far, I haven't
>> found a way to get orc mode working with my tooling.
> 
> I guess you have a different LLM? For Claude Code its enough to tell it
> "do X in a subagent" and it just spawns one.

It does use the Claude models, but it's not Claude Code :(


