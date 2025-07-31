Return-Path: <netdev+bounces-211230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F434B1742E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35739166348
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098681DE4E7;
	Thu, 31 Jul 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFRQK3XL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B4142E7C
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977105; cv=fail; b=O8ERt5TMfZ2jg9hhlPnPwNZfZdDfJdGCmb5WrRYhieK4J2BhPytUN52QvnQRxKtyXjV0l6LK+9wujXBwlE9szX7wO078ZfSoWOYp/s9DvJSmLNMkaBQDTYRAkzXFG9tiaIWKlMAWL8d+nSG3UBjVfItu5HEdz3uT0ZUUHukmpBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977105; c=relaxed/simple;
	bh=0xkhTGfPO3oatKl++FKASjLomP7q1E6nGgfD+xppPyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USkDieqanoSrnCIzL9kyOWLVExKDfq2U+qIn3ltacOWElz94AoeyZrx8CMIxT1puUvArk0D44GV5CB80ZN7ePO1hbgEELnWrN7PTboremC1h1PULtulHeTB1mdZDEq8Y4hh52zLG7LS1T+XMGnEuE7atw4WX4mN5XEEEv+i14Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFRQK3XL; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753977105; x=1785513105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=0xkhTGfPO3oatKl++FKASjLomP7q1E6nGgfD+xppPyA=;
  b=aFRQK3XLGj2AraxCcuGrucOsB8I1m7vh6nG7aL8N7kXJz+p/Hlqua5oV
   hIVqSqn71wHxBuQVPuxFfKuKA4U8kl6oznKTnmlQvICvvEZ2K7bwxVtTq
   vwfL4tbjMZzpzQNVKDWW9Yy+jvGl0FybFnPzaP8tds4QRZxJJVXcr7+ZN
   JHz4VJVSez5y1VxjZlGm116rMR2ZIfJN9UVXocECjfQnAFBOk5GcLxxvZ
   rssg61Rd/bBmmyEDbtsmuMNc0t/nDtEYas47GGWQp+GTCmYXhO+ZyQuDU
   HPfvDwaTgGQawYDnbbDxw9rn/HN++1ZkI51Ys1EZBbD/ye42lWJU716uI
   A==;
X-CSE-ConnectionGUID: ychuO3eUS22YSnSzZT/d2A==
X-CSE-MsgGUID: SPsbqChGTGugEwpgak+4xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="73764622"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="asc'?scan'208";a="73764622"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 08:51:26 -0700
X-CSE-ConnectionGUID: xfFA8DaDSqGx13ymJErPeQ==
X-CSE-MsgGUID: Fv3dL8e4SaK65m3bdodw5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="asc'?scan'208";a="162572922"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 08:51:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 08:51:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 08:51:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 08:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnwAuZLB7fpT7SbvVdN0nEuJqHrDLvMs28LTE0+q+TO5hJ1L12pEgvXeU19YP10553TZw24PS6mAVo0IUeQcEyacK43ir99nCiR1+sZ5NEev9Jteo7GXG0e3VYqzu6eeIV5esWpwaygiS2yUGeoLWzUs1cpIw/w1CLvVM8jqYvmXDm9mzsa3wXGV/2tv/vcyKTXZqtux/qJ18xUKlVX7TEwQor5ODNHbW0+zx9qp8gqwluiayUR++4zYv9Sa3jQ7EBQUOvKQCXRlWP2vaBQxPWvz1XuaBJ5HV/o7UHRKghObwqyTn7mpYinUGrktf2kq99OELZzMLECCyM/Pr7iA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xkhTGfPO3oatKl++FKASjLomP7q1E6nGgfD+xppPyA=;
 b=wTeIebH/1f3szo+OvLuNLgX5ofzePL3mmBcu1VGwPnH+QGYNxo59ZaLCsUcV11Jyo7xDxFKq93ZtTpstD9mokWAnfiGymYN+zJJlveXLahLWRzV6dXTOcYxdMZAKwaItn3U9tdCuJ6dcCPBtEMt9SwfXKSEEqIayuMbxLv2MgFc9AmNuRt7zvDsZcwxS1Qh/GZsteFxLPW1d4kJ6LyL1Z67qg3HgrAwPdiETD0UOiVZvNg4EO3QDFGyo61U25EiKZFpPChF4kTslSRrTCHPVzG08+DT8QzocnPagKD/rtJmVZ3kfUQ5QlGS50tmk/MjO3qbkRO0z5qFP5PWQPmzMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 31 Jul
 2025 15:51:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 15:51:23 +0000
Message-ID: <f27620c4-479b-4028-8055-448855991e6a@intel.com>
Date: Thu, 31 Jul 2025 08:51:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: Jakub Kicinski <kuba@kernel.org>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>
CC: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Simon Horman
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
 <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
 <20250730170641.208bbce5@kernel.org>
 <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
 <20250731071900.5513e432@kernel.org>
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
In-Reply-To: <20250731071900.5513e432@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------qETPKKfAVxnhdRymuYUUy1uz"
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: e20b5832-c201-4f9b-224e-08ddd04a1974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzF5REwzdm13Si9PQWNUdUM0dmlFOU51TjhkOThHMVVuUjdBMjJPdzdYakdX?=
 =?utf-8?B?RktGUVRGNVRnaUIwSkFsQmxkZFRselpGaXY5cmNmM1UzdzErZzY4NW9Sc0Jp?=
 =?utf-8?B?eVVySUhrVE1mWTdGY1Z1OGlyaG4yWnhYNDgxOXNISWVxcHhxSXBaZnd6d292?=
 =?utf-8?B?TndicitkL0ZJT0lFUzBHMnVRYlNGcWJyZEhCL21maEhNUXVZMno4L2l1S1FX?=
 =?utf-8?B?aXJ4akNwOTV1alNITEE5R1MrVlMvY3VlZW43SnRWWUVlSEEwQjJlRldhOHc5?=
 =?utf-8?B?Q29vY2VhSU9aaG80T3FuNktKRzRwYnNYV2dPVE43RzJXSjh0clI3WjBjWEhO?=
 =?utf-8?B?VWhselNJZ2FDSnZZSU5lMmZyK2d4ZURvNDFOajA5VXlCZkRIMFdrOEgxZmJk?=
 =?utf-8?B?M2FZVEpNL0o0RzZYMzFLM0sva0RLSkhWMlNWQXg3cHVZV2lGQjNHRTRCdGlL?=
 =?utf-8?B?c3YzQXVFbWszZGtXODdwajN0ZG1qODQwYmdBS1RkdGFaRVl0dlQ3Nm1EK3h6?=
 =?utf-8?B?dTNtN3Z5cGxzVGd2ek02WUIzQ203TWdyTDFZQXc1NHdMeGRlWkF0d3NsK1Nt?=
 =?utf-8?B?UmRmN0k0dExvVFMrL1hvMGNEK2lxdlh0OXVBRldyVGNSN2xXSlIydHloR0JY?=
 =?utf-8?B?QmFRKzZPYXU0VEhIRHlPZytWOFByS0JpQUtOTmF6VWxnemVWMzRKT0l2Wmdl?=
 =?utf-8?B?eERldzAxc2Y2aGtYRUlSTEtLRkxzY3lldzlNUmNUWmZBbThpdjV0RFM2R0c1?=
 =?utf-8?B?clFsWVB5RGZmUFU3UzNlV1VnZkJwSjJhbitnTlNza0d0TlU1V3lwTVlIUlJR?=
 =?utf-8?B?eWx4WXY0UXdTbW1iRWxXK1oyRThadkltejMvcTF3WnpncXhHSUtueTZzK294?=
 =?utf-8?B?T3NIQmc5VG01eDE5dmNrNHh5VmZ1citISEhqYW5HeklpSUU5TW13cDMxR25n?=
 =?utf-8?B?R01vWS9xUVZpQ3ZoU0syeHR6dzBjRFVra21MSVhaTGZCZlRRM0E1T2lJaDdn?=
 =?utf-8?B?eVV2aFdzb1o4eGNtMFV1VDhzcnFRSk9UbnAya2NpeFdENDJBcHVkSWZIZlpK?=
 =?utf-8?B?dnZiWWpBMkU3Zjh3cWdqV3c0WTg3TElITTRBN2NBMkRRMlZSZ2pjNDdnZURv?=
 =?utf-8?B?cmFaRTV3MkdzV1Y5MGtaRzZvWmxKdytGTXN2ZEoyOXowcDFSY1dtdDBQRTQ2?=
 =?utf-8?B?dWxjZ1J6ekVmNGxBZFRHcXR1NlNmejZhNHd4ejhIUitaWitXaHZqMlAvOHN5?=
 =?utf-8?B?RG8zUllVekpMcG1rVG43czF0eElwMW9Pc0xnMC9IOGxYOVZmRTV3ajBGTmJZ?=
 =?utf-8?B?TjFzSWhxY1dTcmRlRGNYVXFuTDNCL3RQKytiaWIyWndkRFAxaEZsYjZqQkVC?=
 =?utf-8?B?V2FUMm9DWVZWakFta092UnFBd2VjVHBlOUhpZ05sMmJEcGNhd3J5c0VubnJp?=
 =?utf-8?B?eWthTldQUU5kOFk0QVhiLytvVDFxRXRESldRY043a2NHQVVpd29iaXFRTzN2?=
 =?utf-8?B?V0Jub0FVdXdpWS9DbnkvRVZJaDQ4ZElYL2Z3QjJ2UVRvbWkrNGdZK0JmUGhn?=
 =?utf-8?B?N2M3K3I0V1JiQ1B2ZGY4WVcrNHp4d1lIdHdYSWhQK2hJQkxURlJsNWJqTHRy?=
 =?utf-8?B?WklSbXhTQUlDTmVVQ2w3a0h5aE1xd2U4UDJ0OGw1TGJoRlBQdHNMWFcwc0Z4?=
 =?utf-8?B?VXJNNUpyeU8vWHQyWDdZdlY1ZTlhNVZ6emcwS0N6UWJXYTFMUUtaZUtYcDVH?=
 =?utf-8?B?WlQ5ckVoa0RNelc4SXdSVHEycFhCWW1DeDE0cFRwanJIWEVBcTkrQWVIR0R4?=
 =?utf-8?B?RXhzcnFDM1VnaXVvY1B1YklkcUV3K3E0MnVYb081TkVWTUxSd0pkaFExRVdt?=
 =?utf-8?B?Qy9BbzlMWHU4Q0FVdEUvdjdTUWlZSVRmVXhtdnE0K2lEWWlaV1g1Sm9OZkxC?=
 =?utf-8?Q?EUjW3XyyXEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rjh6VnpvNERIL0ZYWkpLMzN3QTZqUTd3czlKYVB3SG4wZWJiNDNmbDJNMGkz?=
 =?utf-8?B?TW5XTkZzOGVNSFBiaXZpRTlDQ3kxOUVtWnpwS01IWWQ1Zmp1UmRhQnEvNXJS?=
 =?utf-8?B?NEd1RUp3Y2pJUE9KSnJWRHZadmJha3lwUlN0aGtSOWQ3OXlSZjlDeTlMTWd6?=
 =?utf-8?B?bDVJRnVpemZPVTZLSStIV2NTN1F5amh1OUcwcHVxUzY0eDVkL0E3dU16UzhJ?=
 =?utf-8?B?bG90dWdzV2VXK2hoMjBQTXM0aFNVend2R3N6cnRDclNBK1NuOVNuVXFNZFRD?=
 =?utf-8?B?bWQwWmxFQjlnYXFFZnp4TnBWalFqcTYwUkp4dXhqTmIxRVl5YmZsRGd1M0Vj?=
 =?utf-8?B?SUZBTWZJUk9FcVZYQTgxYmVYRm1XMzRBTXphWnN5MXNsbk4zdEpFbUFESlZQ?=
 =?utf-8?B?KzNNTS94NGtVL0cyT0I5eE5VMVd6dGJrcEYwenphdDVhWTBXMmpveUlnL0JO?=
 =?utf-8?B?MFN2d3U4WEY5aC9lZEE5MFROTDg4SGpJbE1rMnI2dThObTBCVWVaZytibjRq?=
 =?utf-8?B?K2xZKzVvRE9RRitibllaL2FHVjdUZ05KNmNkMllWeW5BNTk3YU9DeFpuZnk3?=
 =?utf-8?B?VGpuVWk5VHZDVFM4b0x2R09KTUR4YWdoM2VvMWZkRHVTQzhmK3Z2OWQrVUw1?=
 =?utf-8?B?YXhFZm9DaGVmQjNIZGlSWVgzbFEyeWQvUEZ3WTA0L3hQcGNnVlpCUzFHek1o?=
 =?utf-8?B?RUk2cXFCOEExa3FsL1BsbThxb21kWlBzS25WQjFJVlIrSVVqVmdjWVRwZTlo?=
 =?utf-8?B?dkRORllNNjhsNlQyRzBFQU5LQlhrY3hwUDhVQ3FjZlJZVXZaWW1nQmJhU3Rj?=
 =?utf-8?B?b21ySHZzdXpVa1dBKytmbnl4RmJhNUg1Rm15V0Y1VFRRY3pGNmxaL1IxbGNJ?=
 =?utf-8?B?cjJrYnFIckRwcUxCZ24wRW92Z2RWRUg4dTF6RzZvUmpJQjBaUDhsWnNUOVpY?=
 =?utf-8?B?L3J4N0FwUGR5QUNOZXMvVkRrdnYzNlJsUGZnZ3c0a3d0VjlTc0FWSlB6VFoy?=
 =?utf-8?B?N3ZGc0NEdmFLcndPRlpsT0Z2Sk4weDh6d1pCZFlROUVXOTBIODZpbWI4N1lo?=
 =?utf-8?B?OTRJUzRrRDY5K1l6V0dSQXpGZmt1NTQ3eEoyWlBTK010VUdxWjhndHlEb3Jx?=
 =?utf-8?B?L3Rya2hUTjFaazZUMmVyNk0wWVB1TXdRUkNVb3ZwaEc4Mzg0aDRIWGd3Y3hZ?=
 =?utf-8?B?MVpoOVhXellYRWV2MGpYNHRHWnhuWjlrVFVMZE1tN2d4SjFSK0pUSVJUajgv?=
 =?utf-8?B?cEZpM3p0cElvd0hJWlZwZTFkZDBRTURBZkt6eHBvWlhBZlNzQVVnNDV3TmdO?=
 =?utf-8?B?RC9xL0ozU0czU1VSQ2RwYisxK2R4UnhLNDZYaDgwTDkwZGlLOVVHR0NRUTg0?=
 =?utf-8?B?bXVHZnBVak9nQ0luQUc4aDZybkNjcGpqbUJrbkF2cExRdEZXL2oyc3QwOC9T?=
 =?utf-8?B?S1lCQ2E3RTBxWDBGeDBtbDFMR0E1WXdKcGlLaHd6VFVjUWVWaUdoOGVPVEt4?=
 =?utf-8?B?OXgzYVo2SzlyMXNkQ3J0dVg4blhwTzVhY1RYTEtXK0htK2tvTG85VVFlME9J?=
 =?utf-8?B?SGlhZUc3UUVSZHIxZDJLazlBUHdTV05NSUxEVGl6RnJwcmRKZFV6clJPeCtn?=
 =?utf-8?B?YW9qT0xvbzRHL3pSUlFMK2VpbzEzVmRGaVZCekNQNE8xeXJlQ1EwT2pjWjdN?=
 =?utf-8?B?QVZydjNyb2Y1eDQ5VFVqYkdPSGFDMU1nR1Q0bjJpcm1EZkg4WHhDQ1pyOHFX?=
 =?utf-8?B?QUltSXkwYlAwTWZtYXREYWYzU2xkdmFMejZXVmVuSzVtOVEweWxSUHRic00v?=
 =?utf-8?B?NXBkMGVjWEUzcm42bTQ1bktLUG81WjRPU2t1V3BTdDc2cURqc3M0VUNhR1gr?=
 =?utf-8?B?NmJEeWs1RlIxbGFNVmtVNFI0VDd6L0VoanM0YndyUkFZS0REaHRXZHBlOUVv?=
 =?utf-8?B?ZjVBVFpyV3lnSWtyNXhkQ1FDVXMvckpzYTc5cDJXaitOYmwzbmgwajA1OHRm?=
 =?utf-8?B?ckhjN1FCcjdTenJVbHpTR1AzT0lIOGxKZHo3QXdOd0JiUTRqV00raEhQVUZN?=
 =?utf-8?B?REo5MGpSNFhZbXNqSUwxaGVmczd0bGJpdnVTV0hwMkx4dkRwVnQ3N0U1Z0xY?=
 =?utf-8?B?NzVySFNLREZBNC9MQ3cwYkVkdlIvZHNBY0U4dHIxS1ZKT0NvaEFPeEd1UWdQ?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b5832-c201-4f9b-224e-08ddd04a1974
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:51:23.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiXGjAdoLo+sVZwF+hK7zjv0biNFx3oRv3Yy25UtS1TbIh6koIhDkR+8I0/nPKZ0LAPFsHOCUN5k75XK7wR11Q4mpzS4adpIkBSGRdUKhhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com

--------------qETPKKfAVxnhdRymuYUUy1uz
Content-Type: multipart/mixed; boundary="------------v6LERzGmksOGmBI2O8Bqcgx0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>
Cc: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Simon Horman <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Message-ID: <f27620c4-479b-4028-8055-448855991e6a@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
 <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
 <20250730152848.GJ1877762@horms.kernel.org>
 <20250730134213.36f1f625@kernel.org>
 <55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
 <20250730170641.208bbce5@kernel.org>
 <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
 <20250731071900.5513e432@kernel.org>
In-Reply-To: <20250731071900.5513e432@kernel.org>

--------------v6LERzGmksOGmBI2O8Bqcgx0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/31/2025 7:19 AM, Jakub Kicinski wrote:
> On Thu, 31 Jul 2025 10:00:44 +0300 Ruinskiy, Dima wrote:
>> My concern here is not as much as how to set the private flag=20
>> automatically at each boot (I leave this to the system administrator).=

>>
>> The concern is whether it can be set early enough during probe() to be=
=20
>> effective. There is a good deal of HW access that happens during=20
>> probe(). If it takes place before the flag is set, the HW can enter a =

>> bad state and changing K1 behavior later on does not always recover it=
=2E
>>
>> With the module parameter, adapter->flags2 |=3D FLAG2_DISABLE_K1 gets =
set=20
>> inside e1000e_check_options(), which is before any HW access takes=20
>> place. If the private flag method can give similar guarantees, then it=
=20
>> would be sufficient.
>=20
> Presumably you are going to detect all the bad SKUs in the driver to
> the best of your ability. So we're talking about a workaround that lets=

> the user tweak things until a relevant patch reaches stable..
>=20

I think you could just default to K1 disabled, and have the parameter
for turning it on/off available. Ideally you'd default to disabled only
on known SKUs that are problematic?

--------------v6LERzGmksOGmBI2O8Bqcgx0--

--------------qETPKKfAVxnhdRymuYUUy1uz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIuQ+gUDAAAAAAAKCRBqll0+bw8o6I1M
AP4ureo3J6eNQ5y564+h2aicm+K3GQO8nDwGMOi+OxjuJgD7BqpOcmuQuFlI7fqeSou2RoZ1buCU
kWE1PinZV7MtCw4=
=mw0c
-----END PGP SIGNATURE-----

--------------qETPKKfAVxnhdRymuYUUy1uz--

