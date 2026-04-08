Return-Path: <netdev+bounces-276567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NAEC1xn1mnIEwgAu9opvQ
	(envelope-from <netdev+bounces-276567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D03BDB47
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2F0306B2C5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B63A8744;
	Wed,  8 Apr 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpZJoS8o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046E3D3CEF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658594; cv=fail; b=kANhBUxVwtBDAyD+/4DCtbX2D9LezFng4U/xSIPEZ0dsYLDsH8UoQ/1hUTOZPjdp0vvNAqj8jiN2Yesh+ROP9t4p59eHOD5udhfrgdwlnq+eEOnGkMeCPft3Fb6zKn+4cNYhYep8x+6M8IGMak9xeysL9fBZr6QghACYDkz1RSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658594; c=relaxed/simple;
	bh=rhcmQot4pvSxijETZW9o3b1bBsi+RW9HhxSNG3KFdL0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfAJPhUsKYN28GeLN6qTYee5D9VyFPKPSv+nH/dsbrLAG3AZmCU+JaDfhUyC5yd/6O2GFqYqk3BejBkYvkhOYfkRqVhBW/ivV/AI4cNez2g4POPoJl5+QM/QMvlY+KMuWSoHtG8n44o8qHPf3NZPS+WzjHLl1wuqzRd3rTQjmSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpZJoS8o; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775658593; x=1807194593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhcmQot4pvSxijETZW9o3b1bBsi+RW9HhxSNG3KFdL0=;
  b=dpZJoS8osOb5Ypz3Hi0CME/rUWUxHjI0oHMEEaew+05PYtUmIAwHWDxD
   1CsjTlT1wqcQ/0H+7+dmb8UidEyebpNyb/fwoX1hr1p9q96Mj1BoSku34
   TGbtDS+Vb4ykrWgedVX0pjDfekKgOQk0iyfsCSOHyjLs04TyAOI6+1qr3
   sRy2mbG/xZ9kC6Dh5OpDrpzET+pMeeBQaqdG7mnoUvgVtAbHG0lS1McuA
   TT1ffChffAe9R0YbpOi1UCnVouuOpTJslBprZLGff5ylUgyx4pMm8MJXR
   1h83/AjGlO9xEDtqTVX+4J4T3XkdZzpA5WJ6vOsbnjSyXHH4DnaBLFwz+
   g==;
X-CSE-ConnectionGUID: 6y9fbL32SpWcdspm7/nqIg==
X-CSE-MsgGUID: Nug4qnmNTHOb1OQpYq/HTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87269720"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="87269720"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 07:29:52 -0700
X-CSE-ConnectionGUID: wpMB7BeFQsCwgZ5yz1IhKA==
X-CSE-MsgGUID: 5RQtLLLuQ82uWXoEaKZVTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="230151555"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 07:29:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 07:29:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 07:29:50 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 07:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfHSfO56LptAWKn4YQwSYSMy0GmVM4ju+Oe5kEENVySYD3wEgx1mrlEUnZudti1hZwiVdXNxQEmquBLR2c2fa49xtOUGZywvhtJEjBnyw4epJmU20FuQ2BjwMgaoOmWUtIeZCE0KQ1xd/OEXMWH66XEr+SvoYcHr19iCXECpZnpzxRYZUlK419DUTa8ngC+zsF6pMZccGM0Ea1RvFc4nr95xberrO2i4GOqsIg0mcq+8/yjTdDwUuchEguoc7DfWT4Px+YTmfU9Lr58eF8Q0hqc9iaD7zoDTMs11hg8C9jDna4xzSuf4585/jvvYk/wfwqhpUpzqSU/6Nx4EK7+Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yivXx5xcczCK2XjJf46OfezU9bMs5/YKY23d4ZIHbDk=;
 b=guqmN9cic1/VxYQEJiJJCRd03OFmmPECI1pe1erNh338RfoDsXgZaRbwrikjMTttmeNcgeVMiIy9fhNNPqTYp8GxJ3gVvShNtQWlrl75TYjLg5PbAtG/7IovwSFFhUwahPlhiLakiZpZCDuhs4omiGmVl0sgJ8rGp8Ob+3Dvbqe1tbiabGx6GEr3LmAUzzr2EdfC1ptdKuOyRwtnlMBn3DKLNZZ2aRWomwYcSrqCe27SFx5qnmdYYQy8hWZBvwWStbUwoI5ezH8AnY7hM0LD2/T0vb9RP/NO9KxX83w3giSU8fN1//L1K/613UYcGHh9+wn60OdRgmElWgWl4Yh89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 8 Apr 2026 14:29:47 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:29:47 +0000
Message-ID: <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
Date: Wed, 8 Apr 2026 19:59:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
To: Raag Jadav <raag.jadav@intel.com>, <aravind.iddamsetty@linux.intel.com>,
	<rodrigo.vivi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <acPjxf5XTYuR7sbM@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0261.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::17) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 25de7fbe-a2e0-46a3-b7fa-08de957b48f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: bVzgxphNXsG0kR+oiNQDS8jWSYEPe1yKPbESo0Ynu80ZcFILR4izgDNioUAV9wAEgtFBY4tB4ypcXPAIFNNwoRK41TqKkiB6nfnhVeZ/6ZA1MUsxINLZy5GCLJsTf52/FQscX4qwMazwdqcW+uszNHaNDhuVIhAf51KaFcWDk2EVJfW+B3WgwnYJeljPQ7ddt3dIG8eFYll8ydKYp/47E3709neGGajbtsGYefk9XE+tE9v+vd9VaVWMgrKqdaNozSwH4AJnBuviTAS2LGR+zKQ1VAFQKh7npfiKhWPcevZaXYe9kZk+qAoGOv1KqnqoO6ydmLiMmZP8ME5vEJaotPKdjsAR4XclxO73hcG8b+mCJJzM9OBPP0KdmiOye06t5p1aBkN9ieYLN9uvU5cfFjsPMcJLGMbM9Fu/f6Bc7QZkGuAqZfEd92BKUQh1ELaCbub6pOFDlqjFylZiiihd5lGrovsRITLhpuMYY5HwvCR6pE2qtleDrSXoqN7fcmeNC+enk83X8CFk7B1091pgI/MphgOp7w792IgHb5yLAVxHlTmjkQMaP8SoPKY5jPlRCvZW5uc6KiNqTUwkvbTY0DzPMOUu9yuuwq6yIPwtHyL60gqaqkG2m09lVUWbT1ckqo5szzHa/HFLW9IhiirZFdqwHKPhWXx5xJSAkTc3MdCB8rCmN0dCceTTgnKgv6ZnqQXIGfo/QYkGeb3WlEreDKcF7jIAisUQrAvI9wsIJvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndLMXhsdzQvOFVXNk9JVnFrOExWeFpZcWQySmRZdmdodW02THpaUjk2dlZm?=
 =?utf-8?B?R21TWGt3Y1dGS1Z1WUpIelN5RjZidWllMGY5UU9oTFBpOUlydEpCYlV0QmhK?=
 =?utf-8?B?SU1HREFhSmlqMlMvaTJQYzBsSFlSZ29UUjNyeUx6eXVQdWRvY01kK1BYY0lz?=
 =?utf-8?B?SXlGSE9MUWM0dmVyS2pyZFpQM0pGaUFYYU9pR1dNclJ1VFdiZCtHQ3hYMkd1?=
 =?utf-8?B?Z0s3dFNwbnBVUjF3cis5VlV0cXo3TDhZaW5kbVVsUmlRdTZxZ001SkxzR3Jl?=
 =?utf-8?B?WFN0bW9QeXlNYjc5MUtNN0JkdU43UHFPQ2VCSXY1cFVSRnorSUk2dmpEN0NJ?=
 =?utf-8?B?SlBqWjJLTG1uR0R5b3kwemV4Kzh1MmZ3REEvZGg1RlVUUFBkeHU4Yzl1L2Q4?=
 =?utf-8?B?a21XSldpTHZlMnIySC9DVHgySkFQMndmR1JDNlZLNXRUZFNjUVZuTW40clpV?=
 =?utf-8?B?djZOWDEvY0xKYVJwNlBjTHVvWkI5RWVacnJQNnlpQ3FwbUpCWnVveXd0ZUtt?=
 =?utf-8?B?ZERyOHJrakgwbU9TdURSZjBCRmZ1RFhhZitFN29SanM1eHBOK2NlYjFuVlNv?=
 =?utf-8?B?SkphQ1hxSWZFNUtwS1Ftc055SWp4cUJNV3lJQUc1bmtnbUpYYlRvRGladG9k?=
 =?utf-8?B?VFNoVnVONm9EdHMrUXc2TmlUWmM0U1Juc2xNVHUrOHJkY1g5V0l1akErU2xz?=
 =?utf-8?B?aTJpa2FwQlFKdzFYUXcrZm1CMnl3bVJkMU5uakRMZzlYckF1ZURYWDF4TWl4?=
 =?utf-8?B?T09IV2htRlM2TXBhY2lwRmJJUEVxQVdzWXVDY3hRek1pOE8rL21SOElXTEVH?=
 =?utf-8?B?NjlzNkNkY09McWtEOFJoN0ZxMW8xSGY4Q0QxZFhER3VZVk1rS05yWi9vajFI?=
 =?utf-8?B?bnlBenNQcnFKQm9vb3BoSXE0YjEvTi95cjU5bGxwaXF2bFZwYjh5T2NOb0p5?=
 =?utf-8?B?OVdPZzhBTmNmM1IvZXVkZFdDTGNuN3AvQ3cxVE1abE9GSEZiblBqQkNnbkhY?=
 =?utf-8?B?clArOG9DSU9MemxsendkL3huUFRDbWcvYVhLQkZ2U3VlVk5FalRpMG14SVB2?=
 =?utf-8?B?NUhQa0JsMWJ0QWRzL01aOVZZVTQ1a3JwamI3WTAzZHVDdVVWT3NsenlubW84?=
 =?utf-8?B?Y3BXcE1LTXZ2Sk1tOGhDcGhsMXgwK1RwZ21KN2gwUnpzRGxPQ3JtSXpSb296?=
 =?utf-8?B?Q01xNnB3MDM0SUlJREdpWGQ0VjVWV3NFVTR2MnVWK1BQSXo4M0RqWGdta2VJ?=
 =?utf-8?B?Q3NDSTVtVStzYWN3L0g2UlNveUtSc0NXZTFjK2pPdHZCT3BOZ3Vrc1d6Z05M?=
 =?utf-8?B?VjVCOXZBYW9MMGRVdzRaeU15N3NkMGYreklmVzc2S1lFbkJFWFlrVFNXVnhK?=
 =?utf-8?B?Slpra0lRckpPOFBQUzhWb3JRSnVIQmZRb1RVVm9XRnRwYVBsaGlRRktyck1Q?=
 =?utf-8?B?eWVEN0RSOVUyZU1rT0M4L3VlcUw3QWp5OXNxaHVBUG9RTmVxMDJLS05jcmpK?=
 =?utf-8?B?Z1JhMGlFQjdHVjJ2cnlKRzRuVEh6VXQ1ck51bXBBTDZRRVYzcFVhOHJnNXNT?=
 =?utf-8?B?MmF2VTk3NEE2UGs1N1p3QXZXNitScmhjQjhwb3p3Z01odDVDTzNmL3VPSFlJ?=
 =?utf-8?B?VzVqeDdjaTl6eWhnVnh6aUtWbjRPa0NBQm1aSGRFM2kyK0tjSitvcVBtZVln?=
 =?utf-8?B?SEFGVmZWeEs1K1dTN3hqWW1ZL3ZJNXhETGgybUphVkxsYTd5ZE4wakVhTHlt?=
 =?utf-8?B?dTVRNk0wUXlEZ3Q2ZTlScjBlSHdhTnE1RG5WUCtCM1lzZ3ZueW5YTjVCS1Fp?=
 =?utf-8?B?VlJzU0lnWlRSSVBxZmQvUlNYN3QySUhKbmFrN1kzVXh4UnMrNm5NT3FBMVlN?=
 =?utf-8?B?cGRSQmFxUlFHOGlHVXBEeHIzdTVzSysrVG5oTzZlcWNYZjYyb1lhK3poN0NS?=
 =?utf-8?B?N2RaUkJCczlNcXl3YS9tcCs2WEVadWJkTTFEa2x3YlNPQ0dhRVArRTBxVTdZ?=
 =?utf-8?B?TTRjbkZWaURJSUtVZTJVVVRMd2Y0ZUxYdHBhSEU5a05aMHpuWVBxRURlUUFy?=
 =?utf-8?B?OTBkU2VtRENPS2ZrSGxZZURob0NkWW8xSWhyZEhKZit0eWFMTU9kWU9Ua2Ev?=
 =?utf-8?B?czlWcTZROEtOVm13aTlENGJvMEJnQkZ2ZytOdTZRNW5uSm9JU2pKQlBaMjlJ?=
 =?utf-8?B?bjR2N2VVSCtGVUJCVStlOG04L0ZZL2ZGcmJaQW1RS29KU1ZMRXVycHp4Z1hD?=
 =?utf-8?B?anQrdlFMdlE2WlBUSUVrTUU5Ni9UU3pJaENtK2RDL1VlVVRjNjB1WkZBRGV6?=
 =?utf-8?B?K2dXRXQxNzlrNGZDSGM0N3RQSzlpWkthVWxvRlQ5cnZSVFdZL0hhQT09?=
X-Exchange-RoutingPolicyChecked: PMOB8kwysrhDkLEBxIIiqll0WHUHhYBI5ABHZQDjoh37iw1TDpcfAs+/JwSR5vNNj4MV43qjKf8FjSKlNfeBA4XuOJ6crin+SUpxr7mxbfm3/htYIR1RLNVW6k1ANNL9Je5z2i+Nezljt2/MsP2dCpdDrgfdfOHtQ5nJxCj66pjYfXBgk1oCLFmex4mD+9J7G8WWeurFL8TKB8K+GZCTyQH2tDAqsLIBCmCIw6WWlA/VuzH87LyIcgchUK+7bZQTj7suZiNDG7c4f3+UAYUy6sVIpGQOAiWjOY9ezgZihG1xbOB2LJxbyqGfaj/SoVeK6nI9dDzDxQRZopKBhOUO2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25de7fbe-a2e0-46a3-b7fa-08de957b48f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:29:47.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeC0+nD2u9+MvKjrpgXerJuWiI/lwUu73V8PEiTQ4riyxzXGqDp/HSmpP9fOTjFxf8ZP7Ffaw8gHRWl4U4GN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-276567-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,qualcomm.com:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9E0D03BDB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/2026 7:01 PM, Raag Jadav wrote:
> On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:
>> Add support for asynchronous error notifications in drm_ras.
> It's either drm_ras or DRM RAS, make it consistent in all patches
> (both commit message and subject).
Sure.
>
>> Define a new `error-event` netlink event and a new multicast
>> group `error-notify` in drm_ras spec. Each event contains
>> a node-id and error-id to identify the type and source
>> of error.
>>
>> Add drm_ras_error_notify() to trigger this event from drivers.
>> Userspace can receive this event by subscribing to the
>> multicast group error-notify.
>>
>> Example: Using ynl tool
> Ditto. Either Usage or Example, make it consistent in all patches.
>
> Also, please utilize the full 75 character space where possible.

Will fix.

>
>> $ sudo ynl --family drm_ras --subscribe error-notify
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
>> ---
>>   Documentation/gpu/drm-ras.rst            |  9 +++++
>>   Documentation/netlink/specs/drm_ras.yaml | 14 +++++++
>>   drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_ras_nl.c             |  6 +++
>>   drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>>   include/drm/drm_ras.h                    |  2 +
>>   include/uapi/drm/drm_ras.h               |  3 ++
>>   7 files changed, 86 insertions(+)
>>
>> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
>> index 4636e68f5678..09b2918f67bd 100644
>> --- a/Documentation/gpu/drm-ras.rst
>> +++ b/Documentation/gpu/drm-ras.rst
>> @@ -54,6 +54,8 @@ User space tools can:
>>     ``node-id`` and ``error-id`` as parameters.
>>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>>     ``node-id`` and ``error-id`` as parameters.
>> +* Listen to ``error-event`` notifications for error events by subscribing to the
>> +  ``error-notify`` multicast group.
>>   
>>   YAML-based Interface
>>   --------------------
>> @@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
>>   
>>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>>       None
>> +
>> +Example: Listen to error events
>> +
>> +.. code-block:: bash
>> +
>> +    sudo ynl --family drm_ras --subscribe error-notify
>> +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
> Can we also have error-name and node-name? I'd be pulling my hair off
> if I need to remember all the ids.

Yeah makes sense. We can add the node_name, error_name.
Adding device_name would also be more useful in the event.

@Rodrigo/@aravind thoughts?

>
> On that note, I think it'll be good to have them as part of request
> attributes as an alternative to ids (also for existing commands) but
> that can done as a follow up.
>
We cannot use names as alternative because it won't work for multiple cards.
example in xe: Suppose there are 2 cards and each has 2 nodes. We cannot 
query using node_name+error_name.
Also most of the netlink implementations use id's as unique identifiers.

$ sudo ./cli.py --family drm_ras  --dump list-nodes
[{'device-name': 'bdf_1', 'node-id': 0, 'node-name': 
'correctable-errors', 'node-type': 'error-counter'},
  {'device-name': 'bdf_1, 'node-id': 1, 'node-name': 
'uncorrectable-errors', 'node-type': 'error-counter'},
  {'device-name': 'bdf_2', 'node-id': 2, 'node-name': 
'correctable-errors', 'node-type': 'error-counter'},
  {'device-name': 'bdf_2', 'node-id': 3, 'node-name': 
'uncorrectable-errors', 'node-type': 'error-counter'}]

>
> Also, what if I have multiple devices with multiple nodes. Do they need
> separate subscription?
>
No, we subscribe only to the group not the nodes. In this case the group 
is 'error-notify'

$ sudo ./cli.py --family drm_ras --subscribe error-notify
{'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
{'msg': {'error-id': 1, 'node-id': 3}, 'name': 'error-event'}


Thanks
Riana
>
> Raag

