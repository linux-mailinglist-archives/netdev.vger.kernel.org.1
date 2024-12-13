Return-Path: <netdev+bounces-151728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E29F0BDA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B77188AE22
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204EB1DF263;
	Fri, 13 Dec 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfXrGtX1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312181DE2B2;
	Fri, 13 Dec 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091497; cv=fail; b=c2u8OKVQeJUbc8VceXExIGKG4wPvq3ksxR3Il18PObkVMJ3nMm5qDxR9qVZ6BQCopWVuMEnDCir3E+fsGjQB7cctNrKmrAvSQOMa2Ls5Fulfp2rz5Y5fZ9nswVSPcB8RpvRnadrTswpe0f8iGmbwdwr1hTLtIL3PHC+em8ob9lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091497; c=relaxed/simple;
	bh=IJj2A0TpahfSDjQbTxH0M41Gz9q3uEE5ittvsXt6JEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0b6gohDfCHFD5FS8al1tLG7DkC1Adjk0Ss2CN/aPoew9BvTo/B1tMfbi+ho5RLpljmePrArVcMTD+8xvxa7I00TZXY0Nop2oAaP8w7ScqcLPGpdAYZxDx5CK8AuhvbQcS6QQKu8Y5L0cYSaVkojANO22lld+UYgpmUISn/spwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfXrGtX1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734091495; x=1765627495;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJj2A0TpahfSDjQbTxH0M41Gz9q3uEE5ittvsXt6JEc=;
  b=BfXrGtX1H5/KlgPpTAWH7QQyTwqRDOan5V4fk7pXAQ7aCyRVIJbeKsuO
   Ik/LvkHY1odN9duxnVXQfHj0/rg3cInHHu00q8xWDte2Mt9TA6s9FnHKD
   xw7GYo6si7oj7K0s4rHGQPjrMGamTd9X41y39+FKA1tT+fUuSckSyvDiM
   K5T4y1TFSJ3jr/uM0c6LvV0X8OsVkY/eDIWK4nZDpr/dKzqBJ1kxfu+y7
   clPEaILrcu/NFvkvba6KEZAOBHW+dJKxNdXYR/zxT3/V270+xj7KQKvaC
   xqIWC5zVYva4IkKYyb0PrUtZLWbheMVK0QIHX4HecjN81oHmHVDzEmNSP
   g==;
X-CSE-ConnectionGUID: 8Q6/02nPRxiiROfUF8f8YA==
X-CSE-MsgGUID: 6d9g30/XTJysD+INCdSI0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="33870013"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="33870013"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:04:54 -0800
X-CSE-ConnectionGUID: 8KYD8N5JSqaN2cjS85YV0A==
X-CSE-MsgGUID: YNFEv/HgStKG8uAY6twq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="96937658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 04:04:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 04:04:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 04:04:53 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 04:04:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqA/XYJxU+ioXDXkeDc/FFV81XTMaVJVfph8OAl2nUxOxGfX9uuusuifhhOdCg64JJDekKovRI4uJXQAvBt3KHs+jeLX3CLCR30upKzCxCoiQv8DPovyeZVK5fMx0+brWXY8Pv5xnuUw++cuwBhzojGjO+u2DZpXNXzrUcitdUt6PZ87FnI3Rn/s1BPcQwSv4w/+RVWlrS3FggepMG4wTqtH3PXRvyOh9t5iQxzf7Fu3OlDlKktSUMTGnB5IXEjs9E1uhgTk7hm1DA5UrEwNNHnRRPiAh6HFtasIFTjw3jLnDP6xt1GJQ6UmODPTW9rUVJMsf7Pj12eslsHe2fzunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqCDbEADje7fO21Qa02fh5oNDuq7n3wLt2xjV7uGqj4=;
 b=OgTo5MCPyE6juL5vSeDOym7iAKy7yQMfJa5XT7C9wAywdiS/y9/C97jI2YEa6ZAYMkh6yFdG2O9RdAl+ngJjH3EArHfx9ytjvch02LwmuLJZpGPKmRRFCNwZQmjINLFhSuPwAMeFhSpTQ3QVRbd0WqxRGETONCW42M+IqvOvDNqxEV2rBYFM6br8zU4DaeMnSPtjxmB2OBe/EzgyzroN+9YzmSLqaCfhXoBUDQ6gR40JuzYIsGtWaEU0TXPZ1YELu85DKJB89TaptQufxrH7H7kljoDtvqODdL4blWls/KZgw23r8r3rlTT2cCTVke7WVS31qGwgE39rh2+1hxizNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 12:04:11 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 12:04:11 +0000
Message-ID: <bc9fe988-76f5-4106-b063-96941b5fc7fe@intel.com>
Date: Fri, 13 Dec 2024 13:04:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: stmmac: Drop redundant dwxgmac_tc_ops
 variable
To: Furong Xu <0x1207@gmail.com>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <xfr@outlook.com>
References: <20241212033325.282817-1-0x1207@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241212033325.282817-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: f28af127-e8be-4ded-89ff-08dd1b6e4124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MStjd2ZHYkFHelhLMnEyS0FYazlyTlJ4MGtWcmhoQ2FIZVNodXR2eVZFcUdo?=
 =?utf-8?B?Vm1xd05KVjNFZkRLQklROW9helVqRmdjMUQvNHpNVVptTjloSHRYOUlTL3Mv?=
 =?utf-8?B?UkRYYmdPeVhxbzlzQmVwNDdWKzFGWkJZaC9Ga0ZBUFhTVlE5WEMrRFllRE1Z?=
 =?utf-8?B?SFBESHEyTjFIdS9CQkxPZEh5UzRrWThydkdOY09WNnFFTGJCQW1idUsrcUYy?=
 =?utf-8?B?L3NselR5cndhUG8zVW1uKzByOUcwNHU2MkNHeFgrM21vQ3BZT0R1bFRhemR4?=
 =?utf-8?B?UHNFZ1ZPNmdGcE95bytDK2l6ZzVSWnlXbHFwYlgreGE3WkMzaUhZK0R0Zjlm?=
 =?utf-8?B?Z3YxbktzRGN5TlQ5cVQ0Um94QTZ4WFlyUS85KzlEZjRMdVpNTU1hZUFhUDU0?=
 =?utf-8?B?aVI1MkJUM3cwZTFFTmN4K3BUSUNwZTVpcUlXMFZpaWFWSis5Mnluekt6Y2VC?=
 =?utf-8?B?aVRSUUNnaFFWcjV0Qy9ieTZjZEhiaTlLRk9EeUlIbVc2a0dveEpRZ2JzT29v?=
 =?utf-8?B?RGk4bWhlRDFLNkk3S0lSMk42UUx3dndjWjNlRjlOZ2Ira0J3MSthekJwNUR2?=
 =?utf-8?B?WTg3QWMxaGFkZm1lZWhncUdVMlMwUSt3ZkUwTnFpYzEvSGF4bm1mVHJHY2RH?=
 =?utf-8?B?Yy9qR3hKdE4yQWlsNmNhaWdPbllNRENSRWZZWVUvK3N2THZUZ1FkTEZUcE9n?=
 =?utf-8?B?UXZPV05qOG1KN0greG9YZnNnZlluVkVmd2NjcUFqWldySlhZK3RGWjZPd1J2?=
 =?utf-8?B?RnpPZ1VyT2ZrM0hJZzR1eWphYmh4RTNYV0tRQjhNWk5PTXNqOGRyKzU5NEV0?=
 =?utf-8?B?ZCthcWcrbkNpUFM3ZXBCaE9aTjFhTmFmTXk1anZqSjhDMmtCRm04d1E5amZj?=
 =?utf-8?B?a0dqV2ZRM1dqaGRadUtnUDlQTXRtOFlRQmRZR05DUjd1ZFU1dEplQVBLOVZa?=
 =?utf-8?B?RDVwT0ZTZHpqOE4xM0JTdWk3RjBBbUdIeURGV0ZUYUVqNzc2Qm1JK3cxZFk0?=
 =?utf-8?B?Rm9GYlU2V1doT2ZZOG55THBmRFlkSXFBaXFGTTBGd1hteGl0UVJ4ZDE4c0Rz?=
 =?utf-8?B?WVl4Qjc1K2JKU0ljWHF6Z1JLRzU2eEU4QUJRcVRRakVyNmJ5QldDSndxcDZJ?=
 =?utf-8?B?VzR4M20wU0hzejBGQXN0VnlHZkpSZWxyS1cyNFlOdnVFTkUrMy8zK0NSVFls?=
 =?utf-8?B?L0ZNM1MrWXlmQ1VqUlA1Y1JYZ2NEQkhNYmtsb0o1ZThwWDlES0ZlNXJHNjVS?=
 =?utf-8?B?V2F4MTZLS1VZaEpkTXBRZEtHUWpXUERWUU5wanZaeWZpS2tyMGpxSFM2NWFJ?=
 =?utf-8?B?ZzdOUlNsRThjVmVzMEQySWxPT2NkZ0hNSkNXajk5Ky95Zk1VeXR2a3MwMFAz?=
 =?utf-8?B?c1JBNjByb2Q3Nms3R09FWlBET255eERabjZBcE9WMnVzMU5GSjd0SDFMeDBJ?=
 =?utf-8?B?U2lHWC9YcVg0Z2FacHNURUVtcm43YzNGSkdiQmNzVFdxaW5GM3B1dEQyZkFz?=
 =?utf-8?B?YXlUcExjckZNa2dITnFrb3VNMEYvYndUSHNKMjh0UjgwaTBrZmZMKy9ZemFX?=
 =?utf-8?B?Y3VKSVh2bDIvSHZDaFdOb01KTUNWWS9sUlJNcGk2VWMvNEZvNndVUDJSRExF?=
 =?utf-8?B?eXB4MFRGK0F5VUloY2xhRnNoWkRFeVhEcUZ1VHVtWlRpdzN4OUNVTGxDa1Jt?=
 =?utf-8?B?bEFjNXZtZEZJeDlVWUFkVWNreHB6R0IxZzZUU0dJQkl6Zkp3cU1SUEZoR3Jx?=
 =?utf-8?B?b0huL21ZMVVUNW5nUG9tUE40Q0NmZTFtdEN6SGpydXhacHFtcDV4YXVWdEJ4?=
 =?utf-8?B?eFl3OTlXNi9mU2xKazB6QXowUnJ6dGZRQzBnRWs5T1FLaytpRDR6NkhPd1kr?=
 =?utf-8?Q?YxEx1Ae704tcd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlB1ZXhveU1UTVg4Z1U0NG1MeWkyaW83TVYxekdxN1JUQ3NJdzRUNmVrODlq?=
 =?utf-8?B?bXhhaXMvZU5JUWxGQjZaSmRkZzIxbWR5RDV0T0Fpc2pjNE1jTEUrZ3pHMnJp?=
 =?utf-8?B?STN6Rm1iRENSL2ZqSnpiUmN6OHlvQ2ZVYko4VzJBYUE0UVJzQlZWOFIrTHZm?=
 =?utf-8?B?ZjhhQ0pNeFEzM0pXRjRoWFNOOWwzOXhXTUxjcjZLUU9EMG1uMjBDcEo1cTdN?=
 =?utf-8?B?T00yVDNyWDR4dVZxTCt4MlVFbFFHQzNJZmdpb2hOWnJ6YklFdG5taHZXZVRt?=
 =?utf-8?B?dmdUQksrM1YzUy9jaHVPMUxTWG9VazdYZ3QxWkYvbzVzb1FGTVVvZlE0Zkdx?=
 =?utf-8?B?RzJPalRaVlRYOVRMQ21UdUtGY1dzbEJHZUpUUktsaWRqYUJyYnlBK1BCT3Ft?=
 =?utf-8?B?SUxSSG9HWTRrSkUzTW85dGg3bHNmd2psdFpyN2o3YnlXYUNLQjhUbDk5eWcv?=
 =?utf-8?B?bCt0eTAxQzBhSDF0bVYyWEx0NnJjbkMwWGRBQk04bWdYTU5xcnVlN0pZSzd2?=
 =?utf-8?B?WmFxUTQrOUVsK3ltUitidUdZS1lyOTlxMzRMbCtJd0dwOE9USldWMzhPVThZ?=
 =?utf-8?B?dlIzZ0l5dmJ3bDJuZlRvUnBYVFVCV0xNcEh5TkwvV1ArdEFhRy9EZFFEekoy?=
 =?utf-8?B?aWhUYzFnd1FoV09WczVhWmN1ZlNuM08wOTBvNE8zOHVNZEQ4UnByNUhwanln?=
 =?utf-8?B?L0I5d1FUdlRRS09QdXRSTnd5OEVveGIzdlc3WlhVWmo2c1FBdExGbzBraVlU?=
 =?utf-8?B?RXpVbGdOaDdtYS9sdTZMQ3lSckswaFg4b1ZiL1poa0ZId01mUDI2QXhxaXVI?=
 =?utf-8?B?N0M5VzdFbnBXU2V4d1d1WFYvSnJUNGJEOUkvWmNqRzdrb0VDR0hCZTNua0lT?=
 =?utf-8?B?TDJqTUp2anlBTXhRd0JjT1piaEpnL0lOZFhPREJSZy82NHN4dk5obVZRREd3?=
 =?utf-8?B?eS9VRUs5emZ1TUMyNDZNTkxxZ0ZTd3dNejFmMWVNaEJ0NjMzWjAvZHVianFu?=
 =?utf-8?B?blBZMXVlakluZnFieVhFdGZGakdJaTF4SFV2bVlxVFVRcWpyZDcvKzlRNDlZ?=
 =?utf-8?B?R0lwRDFkWDRvTStCWUdUa3o2MUlVZmtScktkVnhHS1h1dHFycWJOaGhwcWY5?=
 =?utf-8?B?OEtMdXNVcDRqdzB1WGNUOWpjdGpoanpGVGZ5SGtSMjhGOVdWR0x1ZHFubmo3?=
 =?utf-8?B?b3BCenBCUWdVSE5UOUk4bXczR0VzUmVtSk0xVWxhMzh2UTZsZHpFakQyQmla?=
 =?utf-8?B?dm44cEk5cWJlSHJ6aVFLTHVmZkFoKzgrWjJzeW1zYnNjMWtXaEVjNHR3ZTky?=
 =?utf-8?B?S0hTTEE0dWdzSFZVcm9sY2FncUxKYnQ3eGtPS2NPVHFtZ05EK3NtdS8xVTNI?=
 =?utf-8?B?SUxEM3hKVzhSdTNmKytuaFZ1bklJalRzbnZRQTgyWFhHbmdOcUJFUC9Xdy9X?=
 =?utf-8?B?VlpoTzhjV250RFdBYnE3MHpzMnNveHNEMkI2dTRmdm5SRmpOMkZFUlB5UVFi?=
 =?utf-8?B?Unh5NkFzc2VRem50SmVRbk5yOEdweUdxOGZZOU5YbmIweEh1ejR1RStpbUVa?=
 =?utf-8?B?U2ZrSE9PRlFlQmllRENzNm1YWjRYeTduTElvaVZsRFpRK3c5ZmVHcDlMM0Nh?=
 =?utf-8?B?cnB0aXk2K1V2TFdDQUZhUzNxUHFaN29KMElpN2N1dVJpbk5vNHQzUk5oQmR3?=
 =?utf-8?B?YktzT1I5dUg4a04zUnhPTG1kcU9YZi9SVVBIbWxqUVg4ZkhWL3F6QXRTdUM1?=
 =?utf-8?B?THNYQVE2aWIwWXpMNXZVTVg3M2pSQWhHSzBtTTNuRkMxalVNblk2WkpZVSth?=
 =?utf-8?B?bTVtQm96bjZwajRYaVRtdk9jRVFJZ21lTE14MjlKWGxQTHhKSEpwd2Z1K1VN?=
 =?utf-8?B?WU1WdzhCZUsvNlJYWWV5QnMwSDBtUHo1eTNFcTZ2ZGM4dG1McGJ6OHpiVUxw?=
 =?utf-8?B?KzZZbjlJMy9pN2tLL2tnNWxLYk1oSzN4aUNFTTVaZDlQOEdRYi8rRm1OeXpJ?=
 =?utf-8?B?ZG1PZUkxUW0vdDNkQlFxcFF3SkMraC9PTTc3bjVGUlpIcm5VbGlzY1JxK081?=
 =?utf-8?B?bXh2S1AzL1JaQmRWcWxoekFQeitKNDIvT1g5NExwSGJJWmpTZU5ZSFI2dmVy?=
 =?utf-8?B?S0I5YnA5eWU1MWtHQ05GM1JnRTVhbUVSOXZkL0F1cnNQMFVocUVtL2RYN2Ew?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f28af127-e8be-4ded-89ff-08dd1b6e4124
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:04:11.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVk5z81BhhlQI2gL1zVnxHEuejCaKnawAVCsvlQuY+GAxcss3myHqaVXDaMnMDVdONKkrnhgeko2GxnP8860PgVHBiZSigqajC/POS0kITA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com



On 12/12/2024 4:33 AM, Furong Xu wrote:
> dwmac510_tc_ops and dwxgmac_tc_ops are completely identical,
> keep dwmac510_tc_ops to provide better backward compatibility.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/hwif.c      |  4 ++--
>   drivers/net/ethernet/stmicro/stmmac/hwif.h      |  1 -
>   drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 11 -----------
>   3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 4bd79de2e222..31bdbab9a46c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -267,7 +267,7 @@ static const struct stmmac_hwif_entry {
>   		.hwtimestamp = &stmmac_ptp,
>   		.ptp = &stmmac_ptp_clock_ops,
>   		.mode = NULL,
> -		.tc = &dwxgmac_tc_ops,
> +		.tc = &dwmac510_tc_ops,
>   		.mmc = &dwxgmac_mmc_ops,
>   		.est = &dwmac510_est_ops,
>   		.setup = dwxgmac2_setup,
> @@ -290,7 +290,7 @@ static const struct stmmac_hwif_entry {
>   		.hwtimestamp = &stmmac_ptp,
>   		.ptp = &stmmac_ptp_clock_ops,
>   		.mode = NULL,
> -		.tc = &dwxgmac_tc_ops,
> +		.tc = &dwmac510_tc_ops,
>   		.mmc = &dwxgmac_mmc_ops,
>   		.est = &dwmac510_est_ops,
>   		.setup = dwxlgmac2_setup,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index e428c82b7d31..2f7295b6c1c5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -685,7 +685,6 @@ extern const struct stmmac_dma_ops dwmac410_dma_ops;
>   extern const struct stmmac_ops dwmac510_ops;
>   extern const struct stmmac_tc_ops dwmac4_tc_ops;
>   extern const struct stmmac_tc_ops dwmac510_tc_ops;
> -extern const struct stmmac_tc_ops dwxgmac_tc_ops;
>   
>   #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
>   #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 6a79e6a111ed..694d6ee14381 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1284,14 +1284,3 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
>   	.query_caps = tc_query_caps,
>   	.setup_mqprio = tc_setup_dwmac510_mqprio,
>   };
> -
> -const struct stmmac_tc_ops dwxgmac_tc_ops = {
> -	.init = tc_init,
> -	.setup_cls_u32 = tc_setup_cls_u32,
> -	.setup_cbs = tc_setup_cbs,
> -	.setup_cls = tc_setup_cls,
> -	.setup_taprio = tc_setup_taprio,
> -	.setup_etf = tc_setup_etf,
> -	.query_caps = tc_query_caps,
> -	.setup_mqprio = tc_setup_dwmac510_mqprio,
> -};

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


