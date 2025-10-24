Return-Path: <netdev+bounces-232305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0515C03FDC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0293B6E5E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9D156678;
	Fri, 24 Oct 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkFaOjrz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E588405C;
	Fri, 24 Oct 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268144; cv=fail; b=uNEOKkm+UXSYOAvkBc9IMSlyyqqSDej8TEFtCB+aqzbAZmxtDi7rVlzp+W6NorcB1c6F+doZTVYfLJqMtI/p3X5DtbtE+O7Z+O+9lI2TQ5htQu169S8hMMC2kBDpUuclmxpbdfLz8GoeORPaRKr5RXpiI0NP9bTRXleZRCFmoJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268144; c=relaxed/simple;
	bh=5lbJjzQxB150L+eybsTs8wu5b7ySviVCkw30azGTmDg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ak9N3529v3Q6f/V/7LV5QzOyXZMGqqPeI7Nc7qodkc9hSPazImFVQcXAOTFwClPRanxAyJuHJ2gOMNup6zdQ5cxjxOOwaBvXfp6Vlse22y2XhmV1bD+cajmXLRUsit/QkrxaJBz5pGG3r6Q36qdtNMyTDrGtGhkqThTdjgSKy7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkFaOjrz; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761268143; x=1792804143;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=5lbJjzQxB150L+eybsTs8wu5b7ySviVCkw30azGTmDg=;
  b=YkFaOjrzLCP1Og5Z5QBujgCjYj6wkMjoJmGwWVLEDqibpMRutIJRsTba
   GwtG8rrK9/9tPsb+6qahPL2xh8GglcU/Wt+vdEe+XaKQiAKMtZtF4Eb/U
   JhbA7wXXs/xDyLpQ7qsCtwHpcMYeRnRIANEDLH/zGybY8BxPSWD2v/7yI
   zKU7p8bduTFTieE1K0r8snZukFKzMCokNIvVVMHkl1nO76MvA9//E9Fbh
   VydZOBx6IPLQnj2I7Qo1FEp+PYEgkxQ2NMOncphU2oJhOtc9V7dAjRgn5
   f5X1Bt0R+Yv0Y/snUAmOQ9My6Fv9J816D6GkzMDS85r9uGIkXaMjWUiev
   w==;
X-CSE-ConnectionGUID: QQ9UpX0fQhuX97V6snhI5A==
X-CSE-MsgGUID: CaBFIiuDTKOwlYZY+f6nPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62658767"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="62658767"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:09:02 -0700
X-CSE-ConnectionGUID: PqFncKAYQ4K/EgrFJ269pg==
X-CSE-MsgGUID: T89zZ4nCQgmJlKYQ//HldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="221500626"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 18:09:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:09:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 18:09:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 18:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5mx3CaP6vAwGDwJd9OVrKAlR7WS55fTaLQdYL5Fxcy5TBltj6TibHN6LqPogjvRJ5hmYvs+LY7kJkuSGJRtYp12uoDbNEA3x+tv+N3atsZNAY0KtWxLXz8DjYxg0ifaAKZzkKcsY8X3QO0ZJiQhK6rUnE5rEf4ZuRtYJG92H/tCVm4BV4dw9Fw/goclN5PU6SYwBOg+wYJvcwsf2H31wRVRvwxcemqd3xiGeqGkK5rjtPwweqOAtXaIY2+ONf401EKUlxnRs6x5WK5WwYIVfVBCsCzCqQLyquMWgj0rozxurFl/fKRzlP4yuKwwOcY0bl3rBzrfK2rh4N1WkT0/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L2+yrWWITVodfYfveHs1tN9l1znCgR1JA0URZJc8rc=;
 b=a9IuoxJTM7lchx/IiPh4Lo+ppykM1cvusuGihhfLoqH/kU/O4WJvy8GbOGNDcn0pGjZK/B4fp7opu3DG94q6VUFIIR8fE/Q54w0X7Vq/t/c+WT6RgIUN4MYQsEaoa94OzfBcyRSjxNSqSbgF5uKbIh/9BkyYcpXR4lSg2Y0A61GCmyFzctRxJWzetFePup+9r9+qaIHEVQop7DENPQBzzgEsgnq/uY80yscLq+sFPbQTPyLK1WiySTss0kl7dnGHTptrAIaDySPO4HB8boYFODcAhmgSPkflwR5Z868IE9P5gqj2KMfPXViz+mvVBvEc/SN9wtHJkAy+HSTISiTjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 01:08:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:08:53 +0000
Message-ID: <49a1be1b-36c2-463e-8684-8781d4654da8@intel.com>
Date: Thu, 23 Oct 2025 18:08:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] There are some bugfix for hibmcge ethernet driver
To: Jijie Shao <shaojijie@huawei.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-1-shaojijie@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------VN5tlj7HU1EC5ax1EwXcAhKd"
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4311a3d6-4d70-4bdd-0364-08de1299e5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0d5K0Q2SXhXWDhqSjFVSzRWQTFWNHNwNk13UDFLdUZDSFFDUVNBZjI4ZW9p?=
 =?utf-8?B?UytwMmRKbVI3WUJITTE5M0pVaE00NGg0UnNUNERBUWVUYm50V1ZvQnhxL0pn?=
 =?utf-8?B?K2R2TjA4V1Z4QWdmV2pSdE5DYXU5WVNFSHAxM1Z4RlFEaHRXNXFZaVE0ak5V?=
 =?utf-8?B?WGNLN2xUeVgvY3pEeXlscWxhR055NDJobVhiRkpBVDhmbXZ6aTlsVGFuR2tY?=
 =?utf-8?B?Wjc2WVhLRXFmc3BNdzNZWFdEajdKNWZ0ald2RmhQSWhjZ1RMZ1BPZG94VkdY?=
 =?utf-8?B?NW94WGk2cWNZaWtIUWtRM3d6SUxyTVovdkFCdGZCNGc1SmJCZWk0MTF2cktm?=
 =?utf-8?B?RUhqRTBzSW14NDV0c2VtdCszTzZKT1pXVUxBSklySFlQM05CTVUyQVUzSVJX?=
 =?utf-8?B?dTczSXlzYkF2bTJKUnh0UjNGQXozTFNROFkyLzhnR1ZhUllMVWZ1OFc2L2ow?=
 =?utf-8?B?Z0NBYjNwOXhoZ0dnRUMrY1Nxa2M1bnBsYXhYdTMvMXk2cGJOR2YxV000OTgw?=
 =?utf-8?B?WXFKemllQ1Fpb29tWjc2cSs4WmJpdTIyRFlDUU16b3JCMWJtNlJYL25CTlhF?=
 =?utf-8?B?eG84NVEwd09lQ1JLeWpzd2dkaUk5YXBUaDRGV1NJaFduaFhwTVg5c3JWSGxD?=
 =?utf-8?B?SU1kV2FnRHJNd3RqZmVWcDZoa04yVXB1VFJUZkN0U2pPdGx0R2wwYk1FT3RK?=
 =?utf-8?B?RmdSQlI3ZFF5QVV0K2pKRkdXcGYwVEplb0lkNHpsMExuZml1dWNYUmNqVGxi?=
 =?utf-8?B?UkJMenhRY2dvYXpIdWpWdjZvNEhJRzNHejAzbDU1TldONE1qN3JZcGNoMGFa?=
 =?utf-8?B?YWJueDhJWXMzUnVrWEZRQkdsNTd1Q1RLai8wb25wUXJjN0loREtGVHVzSWRC?=
 =?utf-8?B?L0lrd05FK0NkU3FDMUNhRWdLdkJ5aW55OVRGS3ZiM1hsQWszSEdyTTh4MTZY?=
 =?utf-8?B?bUsxYnl0dmdKVml2cnVETVJHRVl5THpIR1pPaFcyS1VMNldlV2xIdmpjK1NZ?=
 =?utf-8?B?K1dWRHRXVWFUc01xZmxuVzF2NCt1cUsvNklpQVJkWm5SUVNZQW0vcElOTnpB?=
 =?utf-8?B?ZGRCNkYvSU1KV0pXaGhrdDREaXBuMU1sRUdrNHBud2FvTlZoT1ZaUmhyNzZa?=
 =?utf-8?B?aUx0TVNIbEkzRG1jSjlXS1J4U2lVOGFWc3d1UWxCdGROK0F5bWNZK25EaDgy?=
 =?utf-8?B?c21TcnR3Mk1FeXJsQXlpNmVlTGdCMjNObUhnMW5Bd2NobytWcGZwRUlvTUgr?=
 =?utf-8?B?ZGx4Q3NVQndUNlFUeFpJOUhnRXN3THhYdmI4d3RsMmdnM1Z3L01XdFhDeFNi?=
 =?utf-8?B?eVVTZXo4WkpnV0xBc0t6NWs1NHpObjJYRVkxcm9IbCtMdDlvNXZrZk0vUHYx?=
 =?utf-8?B?dkxPUE5QUUtnY0ZSZWllT1FBUm1tRXJWczZIZllxZnNlbXZ1MWt6VFNpMVJ4?=
 =?utf-8?B?WHBvdWdGY1F4SmZGeWhjcXJOaWJ6aHg2K1Z4aUpVd2IyQWtHK3hLc3psYmdl?=
 =?utf-8?B?QXZ3aFFwTmxURVFtU0J2QktsRHRFNVFMUTNVdG5kUE5YZ2Y1YVQ1RWYvNE9F?=
 =?utf-8?B?cFAySEpZVDlSSzY0ekhSaldsWGJkMTBxMW5zaVFtVWFHNVdpYWRGZDJGRC9q?=
 =?utf-8?B?Y3BNSzJSMVJHYndxSlpVWFRaaUR3WGZSYXFhR0tTYkdYTjZPWkJPS0YwQ2c0?=
 =?utf-8?B?WnZDNGN5NzE5bjZib1NaZEtDcTFzM0I3enN1aDZlV2dGd3RHRDh0UWpDbjlI?=
 =?utf-8?B?TzVEeEtrUERIL0N4d1Z4czN3RDJSM29uTFg3VERrLzI2UmdBYmlOR0NxQkVE?=
 =?utf-8?B?bkNuellzNjJpUjJSQ08wdm9RQlcxb2NwS0VDc0VZTG0zSEZHaUg4ZFB3Ymo0?=
 =?utf-8?B?UDFpUDRJckFYOE40dy9STkZSbml1VC9MVysrRjV0d1JJdmJtNFhJcU5oUXp3?=
 =?utf-8?Q?A242SI3LK6yMD9+8wx4XXKolko8bXX+g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJIYjdXdHg0bWVwV0ZTR0V5M1ByYW9RMXZWNkwrb2RkTXR2b2xVSjd4UE1p?=
 =?utf-8?B?Z3N5ZTNEckJRTW9mZDVtMmpVMWFvYW8rN3dtOW01dm9mMDdsZmcyWVpIOTlX?=
 =?utf-8?B?K2d1YjlqeDMzV0VHQ2piLzlUM0dGN2lFYjNVMEZDOGRVYjcycSttU3dwak1r?=
 =?utf-8?B?dXVIWnQ1dlZmUC9jTU9wbFZxZHhOSkQyam5QaGdac1dGUWVvOEpidjR6MFBE?=
 =?utf-8?B?RC9lNlVweGI2V29YQkg1eU93d09NZ01pcytBdjExTkVhR0ZWM3lQR0JMUW1I?=
 =?utf-8?B?d3VXZXkydnEzaFBRUjlUMlZmUFRINmlxNU9LQXRaR3E2TVU0alZ5Q2lGOFN5?=
 =?utf-8?B?UFNDMDU4MUc3aTVqQzliR1UzZklhODJqZHZFR0VpODdKUENhKzdGTXdOMVFx?=
 =?utf-8?B?bjZkVkQvOHlDcmpvOG5jYTZBdTM0R3R1NEtEeEJkVFFxMnNzc3hZeVhjZlFR?=
 =?utf-8?B?U2ZpWklIbWVpdGtBV1oxZ2dDWG8wcXEzNms5YWkrc0Y4Z2NaaTZsTEYwNDlF?=
 =?utf-8?B?QnAxWUswbTVEdC9idzlNRXlSUkVsK0JSTmkwWWtjSVdLbE5qZ2FjOWI3eTJ1?=
 =?utf-8?B?ZEhZOXZvUkVXVFo2dzUvUklzRmc2WXEzWVcwQk00YVNlelZjOERPZVNTczA2?=
 =?utf-8?B?VXN0QW5TRlJWd2NBS2pkOFN5Ty9EbVpYSk0rZk80OEppUlh3Y3dpTVlJZE96?=
 =?utf-8?B?WjhOWjBwSkN2NGdsWmdwcHVkQWV5cXR0clZFQ0tjWVZwQkZlYThJcTlEekZx?=
 =?utf-8?B?aXVoRUFKNDBMdDJNRWlGblJoWkZYb2l3anE5Wk5ITTZ3ZVJaTTdoQ3ZhNlZR?=
 =?utf-8?B?OEZLcWN1aHNWNURVWUpYMkd4U0dXVlJZY2gxZTNqLzRWVTRkQXNaSUF1UUpy?=
 =?utf-8?B?SUQ2cTVyTUNBRzJ3Y1FSVXczMHdPMXNFQjBZV3JLNVRlbE4zSTZSOHp3ZnZR?=
 =?utf-8?B?dXIyQTZlN3RLYjdqdGVyOEVmNWU3S3I5cU5mSGVQQ1dNbEhmOTEyTVZDNE1T?=
 =?utf-8?B?SGtqNER5amRmV2NxRERFRGZwdTh2ckttMzJOZWZDeVk4NEIydkZ5Y0o0Vk1G?=
 =?utf-8?B?cUhnZVFXNGVCZHlwQ0pnRkxsNWJVWDN0N2orRjZFWFd4NmRtMUVQT1FMWEEr?=
 =?utf-8?B?cG55T0tTU0dTL01EMmxsOHF4bXJrM3pjRWlIWmVvSDZCMDFDMWd2a3pHNGtk?=
 =?utf-8?B?QTMvZGtLckNjbFNmYTBIK2VISTVweHV1WUhnd2QrM2h6L1FMSm9NcmFGTjVL?=
 =?utf-8?B?U1o5YWhabU9IUHIwd0lRS1dJb2hnQ2pSTjBxR3huNVNQUUtOTHEra0VVZFlB?=
 =?utf-8?B?ZFA2UzZxclR2V05uSHR5U2tSTFlBMnFFR0ZWdnFialdmaS83MEJhbCtRKzZm?=
 =?utf-8?B?V0d0MlJUeFh3cDFGS3BiN3h6aVlYMk9nWTV4NkRQaFhUUkxkdmMxWVY5R2ha?=
 =?utf-8?B?TU12UEFnWnkyeVlWZTFLUzByTUl2cEJoYUh1QWVqYllCN2k2eHViOHFlSW9S?=
 =?utf-8?B?eG81R1dqc2lVLzZJYTMrcU92ZUtCWHJHeVR4YzZXbkNuM2lGTklxWmZKaU5S?=
 =?utf-8?B?WTRyV2dNSkRIMFh6UjBQRmlyME92OW9hb3h0Q2VjZjRnVDhsVDhWVGQ0L3ZR?=
 =?utf-8?B?OXdzeFNtcGpXLythNTdQNGZBdmRhOXF1WXZQTzVUQmd6b3lTWFMwcTVrY2l4?=
 =?utf-8?B?ck1ZaFV2UkZna3FtTEZqakE3VVpOQ0dEZFVPN1U5QTM3bFBJY2E0MnAvREh5?=
 =?utf-8?B?c1BnaUxnbUNNV2QxOHhlUHdUREk2em54WlJrQmZwVEFCcm1scko2a0QxcVQ4?=
 =?utf-8?B?U1VxYWY1Q2YwV2NUNDlCTHprUCtEWEZvNDRiS0VnQ1hZVkwybjE1OE1ZaW5p?=
 =?utf-8?B?RHhYakhOZkdZZkFuM2hiLzQ0OEQxazNnTWxGNHNHMnU1MHRhUTlLbko4ZjN3?=
 =?utf-8?B?akd3cFZLZ3YvUndpdzhnT3lUYWh0ditoM3NjMjA3K283UDE3QnlOd2J1ZTVU?=
 =?utf-8?B?Sk1reno4dmhINnJOSzhFQ1F2bjhVNU5YaWhTZXpDUkJIU3g4ZWRZKzhRNytO?=
 =?utf-8?B?emtHTFpRUDU3T0plaGVaY3NhakUzTVdlUzZZS2U1NGdmbElhejB2YXpyd2NL?=
 =?utf-8?B?MVpPTUY3R1FaNEpvQWV5L0tod2pHKzhBNXFHaHZDVTJUb2ZkZlhRQ25WTzBB?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4311a3d6-4d70-4bdd-0364-08de1299e5db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:08:53.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bCDU4804qcbYHaRxuDRY9GuJ12tYt2+DomShGaVrF8YPJf3QeAKHsPUO4LwYnwWjG9+vsF3b6a3N0xjBEg5NJsGnSePRpFF5uF5hJfAR0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

--------------VN5tlj7HU1EC5ax1EwXcAhKd
Content-Type: multipart/mixed; boundary="------------NLzOJUDFOUK0jlgMRXG43Km8";
 protected-headers="v1"
Message-ID: <49a1be1b-36c2-463e-8684-8781d4654da8@intel.com>
Date: Thu, 23 Oct 2025 18:08:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] There are some bugfix for hibmcge ethernet driver
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021140016.3020739-1-shaojijie@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251021140016.3020739-1-shaojijie@huawei.com>

--------------NLzOJUDFOUK0jlgMRXG43Km8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/21/2025 7:00 AM, Jijie Shao wrote:
> This patch set is intended to fix several issues for hibmcge driver:
> 1. Patch1 fixes the issue where buf avl irq is disabled after irq_handl=
e.
> 2. Patch2 eliminates the error logs in scenarios without phy.
> 3. Patch3 fixes the issue where the network port becomes unusable
>    after a PCIe RAS event.
>=20
>=20

We typically suggest using imperative wording for the subject such as
"bug fixes for the hibmcge ethernet driver".
> Jijie Shao (3):
>   net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issu=
e
>   net: hibmcge: remove unnecessary check for np_link_fail in scenarios
>     without phy.
>   net: hibmcge: fix the inappropriate netif_device_detach()
>=20
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h |  1 +
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c    | 10 ++++++----
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     |  3 +++
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c    |  1 +
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   |  1 -
>  5 files changed, 11 insertions(+), 5 deletions(-)
>=20


--------------NLzOJUDFOUK0jlgMRXG43Km8--

--------------VN5tlj7HU1EC5ax1EwXcAhKd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrRowUDAAAAAAAKCRBqll0+bw8o6JMs
AP9BGMaTE2pyNkyXe8e0NR3R1vyvYF60be2kwbL9YIpS2QEAxjTSMxYfmI695Fp2frA87eefdsu1
LCtf8NqIzQDUfwo=
=+oaF
-----END PGP SIGNATURE-----

--------------VN5tlj7HU1EC5ax1EwXcAhKd--

