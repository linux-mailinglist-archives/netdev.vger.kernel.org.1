Return-Path: <netdev+bounces-164600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A660A2E6A6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E39163F45
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283821B87F1;
	Mon, 10 Feb 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZ1Hr9el"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF85A4D5
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176918; cv=fail; b=E68HEplO47teA5KgTwKOM+AZKw+1FcRwmDNnMdblTUuw8OgkM8EGHhXVJLSEZ2+qGd81IUGFt357QELHwjVgnLe+aqbtEZH3GE+KGIwoTHezIJt+1FgBr55o0yfsn0dcuFT8A7XplYNsKi0Mf8Iw/THi4rkVocDm92p8dxzqN4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176918; c=relaxed/simple;
	bh=711AqmLm7K/f9/WOjGrvnjGKHTcCjJUtREUrtyHH5qE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrf2ePtlFVcohKeqGQBZQxMy+bh/kOTuwO5WFQmGhGIdoAPr9yiv+AuyoVBo65Zs4+2lDCNkMSdtfuINq/ByvbE0JwOInEVCAD4xdQu9iya4lvNF2VsYLYMtF9i4XBe5QZp8K5LnPbxBdpFXloxcq55JiO9na56tnUzFTJVs5lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZ1Hr9el; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739176915; x=1770712915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=711AqmLm7K/f9/WOjGrvnjGKHTcCjJUtREUrtyHH5qE=;
  b=OZ1Hr9el47uPFsmf2996ufeBlRRLy6QsUn1i0vzRf1DIJxtO+oQ7mmgS
   jWohRZitDdjrhEO7rhwlDstcZuB/2jBgDYjOorRTU6WWTxIvRDbylDs7J
   hnT2P6X9TJKoZxzBFU+X1kDLNv/koeEwBVQN3WARqYmFGdxySz2MED2nX
   E3yIYiLoDqImUAtzGtZ2oxSFRNPvKudjAVBuIZHBfsxPtOf3iNnr1cXa8
   8A1gkcz3mUIu6w2butJXU50uvhENcPYstQK8QrvVdouV7TuLiuJbRsihL
   647xc54p8qJfnrNiZULBhEgYXL/SR3mYvG8vi7BJUnk19ZGR6GsEB3AnW
   w==;
X-CSE-ConnectionGUID: VdUf4F/ySfih9Zd73VJjzw==
X-CSE-MsgGUID: aukpCOosRZ6sGWYRRvI8+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39634853"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39634853"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:41:52 -0800
X-CSE-ConnectionGUID: GbgVHv15QNWWCNmyMmM8fA==
X-CSE-MsgGUID: gTYJifJ/TOCrQpvb2ImkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112645743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 00:41:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 00:41:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 00:41:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 00:41:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXfSwRZWIQpKWj9eNw+4z/RuPW/M6VpaIz7ZaogexYNIo0ObK7eXpkiFnTeuKnz9bo45YRmzqIwWuEgOQGI45DtiGxY9ZBSxxPvpwAY+3rxs3ZVWA0WdKOdP9vZNvSg4yv4U3j5zJgmiSBOSj7Plam/EKxk5NRFSK9OfhxObi7CxYx/K2L1ThpGpxBopWGfu+Hg5Tjr5jNbs9lxOWoyKthwIy563E3CDS9ntGSiMQuFD8tyCblAc7isPI67qU1dV9GlxfwcM1WSA9aZqWhW7l15xjTP+zePJdGujhoKa9Qu0C6I2ifYe/u1X327F7u7wfXx7TnR+m+XhSqyLQHbvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhQ6BfEw1vfGkReeUcuIAEpJ0hBGiwTf8XWejliysxU=;
 b=x086bVKDx7WKUW32hty9WyuKfvmgiCmJpzd5Z4LTtJm0Rd7o3xzV26b+c2w5wNyZaRxOqcpxWM2iD6F65g0RuWoP/X22Um1hOaV3xvrwZlShw+Pzfi9x8XDb12ONf7PZCGZCy7HLm4nQw/A/XUPxRbFsHuCQspnsvwEmCwqDAPnV45qUPZ4kjSlPtLPf47tYxFZiheQFxFg2NkG94IBgvlml8bDvHqkxsxinPH5yxqQ3uyr2Duvl3dfgb4j/eDH0j52pT/j+O3HKEbmlBfkBRH65FhSG7jLj2r4g8Nh7QM3OSpy0srhMbaL3XVxbkHLV+MQPD4WRQDhPsrrVYc0JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 08:41:17 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 08:41:17 +0000
Message-ID: <31325da6-d74b-4c9c-ada8-67100bd50310@intel.com>
Date: Mon, 10 Feb 2025 09:41:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, "Simon
 Horman" <horms@kernel.org>, <eric.dumazet@gmail.com>
References: <20250210082805.465241-1-edumazet@google.com>
 <20250210082805.465241-4-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250210082805.465241-4-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e77b3d4-9594-4a54-54e8-08dd49aeaf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0xIQ0ZZbFluYW1waWlHZlEya3dGUndXMXk1Qk5PbkNJUVlDd1NMZDhEVk4r?=
 =?utf-8?B?TnhpclFaekdkWW1lTENpdmpmeVc1OFIzNWZSVHgxOGU3S1N0NDFJSXBvaUQw?=
 =?utf-8?B?WG1pRTd6NW9BSGhqUjd0RU1CMm1vS3Z2TVVSMy8zeWVzQ3J5QUdGWUNXQUxK?=
 =?utf-8?B?R3ZWV3lxN0xRMVZSdHhCSEtRVi9seFFxMXV2a0U3ODVzNDBpTHA5ZnFIcXRH?=
 =?utf-8?B?ckNiVkZaOEkwVVd1MnJaaWdSZjVHUkRqd3Y0SUpvaklqeHJFTlFEN1E2eWZp?=
 =?utf-8?B?Q3FYRXRRdTRhbkpzKzFabitKZkVWVUQyYVVnMWNNU0lBa1RUR0lYazVGSTU0?=
 =?utf-8?B?SjZnNG5ON0dxQVF5di8yVlUzM1pkdTBhbU0yRCs4RTBULzJXcXlCQWlDT2Iz?=
 =?utf-8?B?TzFCdXFrR0FabFkvRnJIem40SzlFOVAvY21PeTEwYmVKbGVKOTFONlYyUUsz?=
 =?utf-8?B?TldQRmhYRkJNMTJoMmVJSjFEQXI5cUFySCtZTjBMdnN4bWxYU1ZrY1BJM0tW?=
 =?utf-8?B?OXlieVVwRlZIUTN6R05zRWk0TmZqR3dxelVWWkVzVmFhQUl2OC9PSFBjd1RY?=
 =?utf-8?B?azBoamI4S0dSMlNVaXRJSnVOeWpOclgzK2Jac2JkeTR4c3NsdW5lSzVXVjNM?=
 =?utf-8?B?QTVRNE94bVZqVzc2R2JtR1RCMkt0WVhhcmhFay83UzdwZ0ZjM0taemk1MVNn?=
 =?utf-8?B?Y01tNEhwNGs3cEtua0dqaWMwV1BzdUMvNkNma1dkbXVFRkpFMThYazNpeGpt?=
 =?utf-8?B?cGtQS09JcnZzSXI4M0dxT2lpeHlwSjc0eWt0SVBjRlZZd1ZFKzNtYjNtZjdB?=
 =?utf-8?B?dzNZVFY3WExwVjZhekd3UUxFVUVXd0pIY0I5cnowWm1GUFNIeVQ0VWJmT1Nk?=
 =?utf-8?B?UDYyaGZoN2o2RnNJd1NUaDhBd1ZLcUZBTzY2dnQ0c2FHOGZGOG5ZTUVWeEo1?=
 =?utf-8?B?OW5SWU5JL2pZZ2xFMHZQbVRDV2s4THFLOUpQdlhPTnc4V0JmWkI5TGZXSDUw?=
 =?utf-8?B?UVptdUJ0SDBMQzA2bjdNcUFuQkVteEZXTC9EZm1NMUdZQys3ZnUwN1dzbFhy?=
 =?utf-8?B?ekF1YmZweC93QmhPTTN0YUZUekJ3QnNmaWhOSlR6aDAvT0RYMXpPdS9wMWRI?=
 =?utf-8?B?TVdNSDBwSzRsdHhZc3ROVmhDRHB1OEVLYnVadDl1N1FPUklrMUZPeHRJMmY1?=
 =?utf-8?B?b2hKcXQ1dWlnL0VDdmZ2RWtWSk5hemNpNHNSUHJTdjhOZjU2d0s0eGlkOXJp?=
 =?utf-8?B?dEk0SWhYUVdxSHZHSHhmbVlDcGtLdzVzOE1TdDViSURFZFNwSVdDUS9jU0ZN?=
 =?utf-8?B?eHVRWThpOEU5UUczNTk0a2JHRmVzcDdBZlo0L3RaaUg2VmpFVTVVRHd5dEwx?=
 =?utf-8?B?K3JVZlpxZ1RlenZnYjkwMi96NU41em5wWHdBUlhGSDhMbzVNTzNCRHk4aFYv?=
 =?utf-8?B?aHZNUWJqdTZYYjBEWlo2NjlXSWR4S0tXQXJjS3ZGVXVSaS8zVHh6UUVaeGxw?=
 =?utf-8?B?NUNodUxVZmdMR2hnRkRiUzNXcjhRRE01UE1NcVp2UEdJcjM4aWZlL0hQWk5v?=
 =?utf-8?B?RTY4UnkwNlFMbGJBdTNpSzJ5ZHFldi9UYlJHWmxNcEU1a0lISVczeklSODFO?=
 =?utf-8?B?cXlHR0ZGcUlTV0lJSHVmSEdObWVvT3cvdkdPRXhwOEJUSC91MnZhQkNJaWlv?=
 =?utf-8?B?YmlVd1NDTnFubUR3K3dvRGU0RXpSWUpOS0JUZXRuY2JXcjFDNWgvc3VqTzFV?=
 =?utf-8?B?L2hkbUpkQWJ3dGQwL0xWQkRLbDU1WmJ4akhhWHBZUThmbnp5ZjdGN3JHYzBa?=
 =?utf-8?B?ekx2WGo4WTMwTGRXTC9Ebko5WElWc3U5YWN4Sng5VW9xSjZWTG1LWHVKb3hw?=
 =?utf-8?Q?b4LOOPIrnpyd+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENibnZkK2gwb3c4TTVaaSsySTVLdzVTTXVMNzVETjh2bFBmVE9XeDlBc1FX?=
 =?utf-8?B?VWU1SmZiSVBybU1RT09mOHZWKzFyNjVVVjNaK1A4T2ZDeDU4TXZ0ajhZV2NT?=
 =?utf-8?B?Rzk2YUZVUElVTXptRkxpcXEvNFQ5TW1qN0tFRWVlN0tFelB4SFhjQnk4VUxa?=
 =?utf-8?B?NlR3QXFZS0VxbEJYT2ljNUQvc1V5Y1lMOEhlUnAzZzBkb3NQZ3NhK05kakli?=
 =?utf-8?B?dEFJZVltUlY1ZHg5a1NaY0hLWDFmeXYyamJUVzd6Y1pRSE1xLzVjWVg4dWcy?=
 =?utf-8?B?S2Y5cHdQM0lGMzZ5R0ZJK2Z1OGN6SWhVZzkyQ3BLeXl5UCtVUXZ5cUJ4Z3Ni?=
 =?utf-8?B?ZkR5OWZ5N0JQU1ZiL1ptOUs4SldkaFc5NGFwTlJnRWlUZzdtbitjb3Z5NGdN?=
 =?utf-8?B?Q3BRWXYySWxRT0VieVZCR1pEU2VqdjFuLzZXdlJiL1lSdGdRRkx6ZW9kYkxR?=
 =?utf-8?B?RU9XSm1zU1Fzdjk3aHBaRUF1NnZrRUN1Ny85VWRrczdIbEdIdWp2NkE5SEJ6?=
 =?utf-8?B?bXBNS1BqcVlORmFQUkhNdXRHTHhMOVZBTkM5MlJ4cEZseEMwWVRGVjJVaGhs?=
 =?utf-8?B?Vm91YWt3UGRKd1lWRi9mNExBQXJldS9TZzIzYTRsaGs0cW9LRVdvRmU2UXdF?=
 =?utf-8?B?THIzSm5IZEgyRmJEVFRLNDBQUVgxZklYT2Y5L05YcER6d09rZWFFRmxFaHV5?=
 =?utf-8?B?Z283Z093U05SM1FTRlBkRCtGQll4UFhlR2VmWHVLZzZ0OHdiVmhobDdYQnFu?=
 =?utf-8?B?TmlZK0hvLzBmTm1lSHhMR1VKZHFrZkVTWnFyQzdsR0JtZ05IVkFIZ0RLd3RW?=
 =?utf-8?B?OEdWTGlyQW1xWEIyZFljUzdZZUNUbmQ2enMrR2R3NktHNGMxYXU0K1pRUGwy?=
 =?utf-8?B?empaVFpiblhWcWphcDhHMjdhQU9ZUVpJaHVMdXF3Uit2TEdVWk9senBTZWlH?=
 =?utf-8?B?WTI4b01RRWEvS1IvU1RVMnJYbE5obTZKSU5ad3NYY3ZaeXliREpEWmw4YzNy?=
 =?utf-8?B?NkZGMmZMODFKdURrQ2U3bjFIVnFYQUJ2cnRYQmFFTG1Fd1hsaUJ1akl2UytJ?=
 =?utf-8?B?UFZjTVozVlJWZU9MSitXTnh0T0Y1UUw3bWlRQlFDTEg3YUF4Zk9nenpNdTAv?=
 =?utf-8?B?YU8xUVoxZFBKaWVObUYzcmZwS2x6UHI2OUF1ZmNONUVHSVhTS29ucC9tN3F4?=
 =?utf-8?B?U2MyTkZtU2M3OGFJVW9YYjNZeC8vMW5qRm1yTVgvbDJrN05pcThGc1dtNVo3?=
 =?utf-8?B?QkVleXZhOHRuUVBTdHpDcFpJVXpNendLZE4vOEVYVTJ0RUxlRW9vajVYai8z?=
 =?utf-8?B?NnpZbWt0Uzg4Q0RVTllXOWdsKzZiM00xVnlwcUUvblZRYXcvVGNHQ1EzWXN6?=
 =?utf-8?B?MExZTjA5blNOblBwaC8yN0FPWlRyVURCZXdxaFlMZkx1cUUycXNydWNqL2dP?=
 =?utf-8?B?cEdEVjNYdElEMFBPdnNWRngwajhxY0Mxa1V2Mld4V0crdkw0TmNBdUdpNW5F?=
 =?utf-8?B?ZkhNeHA0QmZmTy9jUEZVdjlwQXVkYTk3d1ZPVkREQUFnZjhOT1BnUm1qRWlj?=
 =?utf-8?B?ZGdRK0pnUy9kWHFOS1RCc0pkV0hGTC9aZzdrdjNhcC8rakJhMXZNTzN3Zmsw?=
 =?utf-8?B?ZkhVUVZxUE1Dc3NmcVFNSTRNUWZkeWNlc3p4VnFkeHdEaXhmVWFER3U5WVQv?=
 =?utf-8?B?ZGtXYlpyZUpwVVd5UmVPUS9XTEdXc0hMK3pjRW9lcWRvaENpK0dWSFlLRWV0?=
 =?utf-8?B?RmxVeE5zSkY5anBlSlFoM2ZneWJZM29EcmtiUjQ2VEV5WWhCSVd2d3lrUE92?=
 =?utf-8?B?ejhUS3haZ3RlMUJlczhSK08vTkJVaVA2L3B0MXlqM3dBSU02cE5HY0FJOG1L?=
 =?utf-8?B?VC9WRXJhczU0azR5R21temxZUU15NTQzaXVUWTRXQXkrU1lDMDFndTg0Ym5p?=
 =?utf-8?B?M2VSTEJJV2NWMjdtVWpsalphV3NMUGhrc1lORUFJV0puSG4yalNQdDY2WFpS?=
 =?utf-8?B?ZEx6NVdQeVJJV3IrN2NCUG1aaldLRGpwRzdSaHhYb21MMzN3Q3dEMnhpbStJ?=
 =?utf-8?B?V2xqeitJQkZid3NJMG1KdTFvcWFHN2IxTkpST0NCRjBEbDkvN20zNElIYUdr?=
 =?utf-8?B?M1A2eENhNUlTc3JJb3VKY2dibGtvNEtYU3B1VTlOU1dHRXprMlRhRllpVE1L?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e77b3d4-9594-4a54-54e8-08dd49aeaf91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 08:41:17.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74TmxyqmCZvtmgW3GGFoxIFpitw1atQGAEb0VlLzmuNa4BS2or4M9fEKAze6tFX5p7Na9b0rbq5lxz0KBxuEusDZdVTNCgOylN+9f7TzqKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com



On 2/10/2025 9:28 AM, Eric Dumazet wrote:
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> tcp_hashinfo is no longer used from any module anyway.

You also removed EXPORT for tcp_openreq_init_rwin function. Quick
grep shows that it is also not used anymore by any module, so probably
you forgot to add this info to commit message? Do you think it is worth
to add?

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

[...]

> @@ -457,7 +457,6 @@ void tcp_openreq_init_rwin(struct request_sock *req,
>   		rcv_wnd);
>   	ireq->rcv_wscale = rcv_wscale;
>   }
> -EXPORT_SYMBOL(tcp_openreq_init_rwin);

Exactly here


