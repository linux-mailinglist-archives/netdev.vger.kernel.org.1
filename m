Return-Path: <netdev+bounces-285498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMgtKBsB/WmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177DE4EF2D2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFAEE30053B4
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19873431F5;
	Thu,  7 May 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdGa+OsO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A537344030;
	Thu,  7 May 2026 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188568; cv=fail; b=EBgA3o3Z2GppBdWuMdBkr3RbKeppfuk+v4Bqp0At7/Lh8mGN/cxcoWhNz+ALBWUJe/xUL4a4RXXUKv7R0kpYtr9BXPVTaYwGRO9GXz6VxERCK6Z4CMhX81SzjY9LKmn6acWfSZmUIVvo1ZSLSCtRtxpGDvPVKAjLiGotSPTHJ2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188568; c=relaxed/simple;
	bh=61ZfduL7ulVrgzzVXqEGFLu4IdKEAmcEMh5JyFF2Ta8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOQ4n3/EnKg7DT7ciJvOBo/Jq+Dk00RD9TAeJlbfj5eHw4/1qLqBwf8E68jdiOhK38QMeYvXcWxlyaPKO9UxG/diYnaODuRo5yMqdPM9VAuhIFlHyiFfntHo23cTeESb0KPvKoRWxKndmEu14WObMgSPFHh9BJ8MERqt7Hht8MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdGa+OsO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778188566; x=1809724566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61ZfduL7ulVrgzzVXqEGFLu4IdKEAmcEMh5JyFF2Ta8=;
  b=GdGa+OsOa4I86QYziyt9ocPdcqDL4g+Y7DZr6NfLKbVCo5E9RU34WLBZ
   JwIcAbvm5yQbSQqPPxw3FN+Orxas9ooh7hGdv1HYzuqaSMV6x7Y3Jcmgf
   W1M2zABsEmy1pZ3c5cr468BGoZMA1YdEhn+dVvaex0HpVfF76DC9dYBDo
   XhGhkAvLNEFgBtKRSSVyEnARHnXyVkZL6MFt5a0s0mIzwQVGDzmO3+mFC
   wmOBq48ZV8WY3NqmndaN4GbCyuF33hou4t1GzPAOUNzi1PRDsMiA4dXAc
   nPg6WwQWObvreE/qTr366nh4uuLfWMNp5isFil6LRh8z+KDLRiRNZgmln
   w==;
X-CSE-ConnectionGUID: dLh7tPm+StaCI1SiSRf7OQ==
X-CSE-MsgGUID: rmbERifvRBqEvJ92lJH0cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96720833"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="96720833"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:16:04 -0700
X-CSE-ConnectionGUID: urZ7XNdQRgSDgNjpSwkgUQ==
X-CSE-MsgGUID: ghaPR56WQKOoaQkaX2SvRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="235591593"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:16:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:16:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 14:16:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0vFNM53n+RekOoe3MHyVuQ5HNZzSOYm1yYuaWtl7sypAnaUA4oKnPn8UhKm+ZHZVt2eYCEUgw4Q7m/sA+meowiUJHRmz10o0AFj7FzkMa2vgP9v97zex1ArMdL3aw8bAzBN0cM3E4AeLHadpZ9hpb0mzH8hElBiAXRi2kd2aMSB4Vv4Gr7wPwWcYtsjikN9jdoggjl2VTzujrsx+o6jKjmT092v9k4Dq/pNvGsVZ50SNbJm/w16mPNYBXzM9iu9ob15oD/9bcaWufLqx0wPSSRptipx73k8IjgfEokuAvaohKjaqWGxA9LqNDJaEPeC60T0w7B5z2sGZJOugih2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSAcvrpXwUb5VWwmvGEcUOfpdYlyMY00mSJ6wsaYxjE=;
 b=DHU4rc9WFpY9+UvT5LhJIq6yIN9JJqeeS43PJJ+epDUppUCpsEIAdsBk5hLs3XjCnw/kSKGu+dF5R77yuEk/MRK24NG76w2czHFhs55zptLK82keSCIaZNespFr/x87n19lW8TrkYs+Zb1mN3dgQgVTs9c6yE7FJaAxbst14V1Ddlcnf+VNjL9zBTO1Iu6CRRGLyA5RXPaUHgFe3IzZzMMu5CFswnqSJJHjmbG15oZ+lW5AuNf0L9VrLRgW/kij6PfKU5ygaSTenkzj42DcGPGItQDQZ22FqFN080KFm8sGwF9wMYZmHoq5PCiiHbDj2jw4K5i17k4vFHgue7zF96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by MW4PR11MB6840.namprd11.prod.outlook.com (2603:10b6:303:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 21:16:00 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 21:16:00 +0000
Message-ID: <547d6394-5c46-4a3d-9166-2d1f24c51932@intel.com>
Date: Thu, 7 May 2026 14:15:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/3] gve: make nic clock reads thread safe
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <jstultz@google.com>, <tglx@kernel.org>,
	<sboyd@kernel.org>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<jordanrhee@google.com>, <thostet@google.com>, <alok.a.tiwari@oracle.com>,
	<pkaligineedi@google.com>, <horms@kernel.org>, <dwmw2@infradead.org>,
	<yyd@google.com>, <jefrogers@google.com>, <linux-kernel@vger.kernel.org>
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-3-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260507211304.3046526-3-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|MW4PR11MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f9f037-4f6c-4ec4-f28f-08deac7dd6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zUMoZmve2KXP0An57bmKiu8rj4usfmuTQUau1cDe3jZuQMRufxOKCyRbafelUrLpROJnxSxWuH00zNBkzdAj1mYCZxS6ViWsm/xQawjBW4T6WEZ1wGp8otZjjl/RlWfGcHASqQOTYaOCgKHy2fwp9b+7RWyMbrIAYc4pp37F6pNX4ppHvRBrO0S3afV9QIvetpwzJYAEX8LjkoK2L0aFBhE7RkIzxGAWWRRt4l3OS1kV0keZBliP4od9RC7irbipGegY+Z5UsKFhbQ1Z1IscWvJgCQiM1PvAdAROh5tfybgOi9w7YyqiigJ5FEJVykGoxiyCrSEhGmAOsrDrXq0N+yU+e5jwTOw4pncpuhVnzh1TJYeyCQVlWv0a1MnCVHlCTPg5YaDtNr1EWG7DOUXRQoI5zGlHKJ36NBmB+5t6xC8/WFcOIYv8GQ9AZx/cAE61WXNocT/zL7E9A79t3UuoQH/c/d230QY5O+8tSnKlABGjiKVhOJ6yTK4oyYwSJp1tXmkbexw247CpzBcFUK2K69eHNbsQ9Ye4tcWsjXMWtH/s8ZMUJPQsE1htdUipdoKThFF/VHd/mw7hoUciifXEv+JfhHneu4YksTjFGb1NuDCRsxPz1+JrxE3chZRDvYQlwYkZQwKLRRlaZfbkM3jA3JFl8ip2OjdHRQcgEQulfDBZv0x3XHE7178AJzXmsZBr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnAxY3cxMVB3OHVZdVBEM1dxS0x6Zm9zRkRhcXMyRDFzUnlNbHVtbVJycmlW?=
 =?utf-8?B?QjhWV1Vua3BIbWFjUVhNdWxSSGZKSUgzaVRyampMK2R1MXBhaTMwZVBGN09G?=
 =?utf-8?B?RVBBaDNwRHE2RzRkSjM3NjBaREp1R0RZeENqUXlvOTVUakp4cFJDcE9zay9p?=
 =?utf-8?B?UzFqaldNNjJ4SHlJLzg0RExIQ1J6Rk1kTHRIRU83V2ltMHdCQzhVMEZrRFJ5?=
 =?utf-8?B?c3hIcWVMV0ZUZFQ4eW9VUW5aVGRaNHNUdFJKVGdXSERiZFNhSjVpQzYvNWF5?=
 =?utf-8?B?NDI4RmgrV3NjR3VHNDYxb0ZmL0xrL0RqMmludGs2R3c1MzhrclpKMHNZeWVP?=
 =?utf-8?B?WUpnMXBnd1VnVnNjaWoyUEpMcGFTN09OUEpFVVBTbkZVS3dOTWw4UHdadGNp?=
 =?utf-8?B?R0xBQkxFOXl0eW5OS0RqK05qMm5tbXd2OE9VK0FFWGowNVRaM0t0b2F4U0gw?=
 =?utf-8?B?bHBEYWxCQVZKNGJjSTgzWFQxWG1ZZ2UzNTRPb3pkL3hSbWppVmx5dVBCeFRs?=
 =?utf-8?B?QnB0SmsvQjlyVlpXU2NlZHJxKzR2bk1wVFRKdFl1NkVvQ0pQQ0pZZS9JNDc5?=
 =?utf-8?B?Mmd1UEtDMENXQm55R0ZLQ05sNXN0dWxFY0IrUUdCZE9TU0QrQ3gxY1lWM3lu?=
 =?utf-8?B?SElQOXp5TGg0bUFsSTVkMmUyZkpPR0pUT0dzQkozejM2d1hlZkdYZE4yTlVt?=
 =?utf-8?B?VmpqdHM4Ymg0TXJnZk5ZV2JuVUdZN3AvU1VYQzFWYjhNZHRseG8rVnRadzZ5?=
 =?utf-8?B?Wm9GaWZ4YlhWQjJMYWw2TXlWVkRtUkZSdHpGcHg3VGV4b3k1UURhVnZuQVpD?=
 =?utf-8?B?QXU1RU9PdEdwRlNFTTVFbjR6MWR6Wm1Fb1FBbWc5LzkybUZKV2ZlZEQyUk4r?=
 =?utf-8?B?ektrRFM0T1lQQ3RaZzdDRHd3WnJiR2c2NWFLZjVSaVplV1kreHBuZHd3UEJh?=
 =?utf-8?B?VGdrRVk3UitjaFhxZlBRRmw0Qk42RWpKVGVNSi9PZ0hmRkRibzlaZEYyTytH?=
 =?utf-8?B?VThtREtLV3BhbmhnMjJoNlZKemx0QmlQSnNjalREZkdmZHZxOENIZkZMVU9v?=
 =?utf-8?B?RVlIWkVtM2Z5aUZyT0RISklIVUtDclQ2K3dVcTVEQ0VWZ3FKenA0YmRUbzRL?=
 =?utf-8?B?NWk5ZDc3RFBNMVh0b3FLVW0xNGJOYi80WFlLaXUrYkQyNmQ4QXJIV1dTM1hh?=
 =?utf-8?B?L3JVYmZkRUs5eDF3VEFMb1I0V082UXc5TGd1ZjlBSzJMSUpQTGk1WDhEejZq?=
 =?utf-8?B?VU1mMnhqejlvaUQ5Kyt2cUlYTXQ4RFRlSG5icWVEMTQrVmdValJUN3pTV2Q3?=
 =?utf-8?B?MkFBaEhzTjhiT0Y4cWJMYkt5UHdpSWxFSkpEeDJxSzE0TC9LVDhiK2xKV2w5?=
 =?utf-8?B?d3pFZWJjSkpKcDZjSDFlM0hxeFlmZTNNUFlWTmRRUDZENkNOWTFoL0RNWUhy?=
 =?utf-8?B?TkpQcS9wckpMSGxwbWthZEZGRlA2YnN3TXozcWtuTnFLNmNjY1ZNTHJvR0Vl?=
 =?utf-8?B?RFRpOExBMHh5VGsyRjdHcnRXQzhyU0d5L2d4R2V5aFdZZEpvYmZTd2NkM1JS?=
 =?utf-8?B?ZFB2MjZUY2hxbG1ObWx2WkorRHh4OHNVb201OGtER2tkanpNSjZqQnBVQW1U?=
 =?utf-8?B?dHB4c2tOdW16S1c4UmM3NzlQNTJaVXFMZUJRY2ErRWgxL2Z4MWdQYWZWdjl1?=
 =?utf-8?B?YVlZNTFWRE81bC83WisyRFhJbnFYYjBHSTMxVWVFUFl6UVpDWnhjUFlMTlNZ?=
 =?utf-8?B?YWJqMUJBNm45UnhPQStVVU9IcjQyV0tsZmo4ajZ5Z2RKLzNyMnpXK0Vsd2R1?=
 =?utf-8?B?NDBDQ2IvK0Z6Y2l5ejBlL3JLWllJTkgxODMrMkU4Q2Y1dDNDZUpKRWRmR1dh?=
 =?utf-8?B?OUk1b1VrbzBRQ1VCazJJdGdacHIvOHM1U2hzUlR5d1EyZXU5SktHTWE2SnVN?=
 =?utf-8?B?d0xnTG56cytVK01SRkE5NzZPdjhJSjBPd2svQk1rNEd3QWNQcXV5TUN3Wld1?=
 =?utf-8?B?WHgyenNOcERKcFExZzBqN2hPUlo2Y3k0UjNJRVNUNk1OQ0lzWVhELzFlaHls?=
 =?utf-8?B?WjVEOU91NUFydGphT2I0Y3BKRzk0bWtVMHZkbkVzdzh3RTlNVms3NVV1dksz?=
 =?utf-8?B?ZW0rdTZHTGdiZk9NdHhvRy80WmhveWZtSTZmRjdQSGw1NUhRVC9tdThxbi95?=
 =?utf-8?B?UVZ0YWNOendRQ0tUeFRISjR5RzY0ZWpMZ3dxd00xUGRML01kSWNDaHR1NDlK?=
 =?utf-8?B?Q1locktpaWtrRHZuanBma0xhaVFNS1VESzIwUXJUbzVMTXlJcXY1TDJqZkgv?=
 =?utf-8?B?MEdBbTEvOTV5M0R6MCtyUktyaFJaWCsxNkVJdFFSNi9IWjNkdUM5Mmp1SDl0?=
 =?utf-8?Q?ENBNQXRRYK8vi8cQ=3D?=
X-Exchange-RoutingPolicyChecked: T5CqXGvJeruC/mNOK0V/xme1nOhvkO5e+IBGqwxxUIpApG2iJa06Ru3Z+DfcZeCptVbW8ECJBF1C0Aui1MpoFFWY/tgWrUSTiACs26ENL/Tr/tRd3dAOdFvJnqzrPJK6nWE1kKpBHOkj5pMImnTdqN3R+2dLFrkb+vPqi6upzzlW3z8CStEyo3OkN+SLjLDsCQB3plqGFp87bkABcbGppOa2JvRx4A7pxUqpylWnWdzz+DEL3hXLo8Rdvazgk+a2O3ddU+evUaeH367dLUzLD5IEGHRiCq+Zfpnvd/C7tr5bQOrPh3dJnhDZJ9UQuL53ZBQCRsKTmnOY77cVp6oFvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f9f037-4f6c-4ec4-f28f-08deac7dd6aa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:16:00.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnTPNl2Hmn0R8gUt+/aerjRbIZ9eMCxP1EyCrkL088Vt+spy3vZMvTUadDoiiXuhRhcUqgi0F2hXwPwjZS1BcIagwoig4SUS5MwiWBHoYMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6840
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 177DE4EF2D2
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
	TAGGED_FROM(0.00)[bounces-285498-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> Add a mutex to protect the shared DMA buffer that receives NIC
> timestamp reports. The NIC timestamp will be read from two different
> threads: the periodic worker and upcoming `gettimex64`.
> 
> Move clock registration to the last step of initialization to ensure
> that all data needed by the clock module is initialized before
> the clock is exposed to usermode.
> 
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

