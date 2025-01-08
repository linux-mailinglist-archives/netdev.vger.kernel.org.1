Return-Path: <netdev+bounces-156082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173AA04E26
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1743165423
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74525949C;
	Wed,  8 Jan 2025 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz5GNW78"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9418EB0
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296439; cv=fail; b=PEVWsC+JqzCUXC6duTg2YEC2ImyxiVyRKV0aNefCUKp8vxPZWy4RWqFtg1VGEv4A43SWkyAJqOZQ2AnBHeeX+o0J5p/WbLT4nYHXEGblyD0sTTl4wIVy+b8cI16aa0wHgk084L1YCVkSHyBXJCrbxdUsGAVvVnGvIAgVOygjN8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296439; c=relaxed/simple;
	bh=B3vdVf1ZOcMPQXwgeCPyMWHES0infJL38cxZ920i52A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUIFq5SN3KFfjE+DRtpx7++lhE/wJo4hN2h9adwYZhVQ5Hw5BbCUrrXdgICwL/8B68LTutRU++MXwc4FqIrpvIjU3s/YZbnV2NUlnuF3sCZ/hPyYbDW0twU5t9hxZhuL8TN47hYNS7Sg0KftqUl4McDCyPB/fVhDrQQ30AmBvpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz5GNW78; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736296438; x=1767832438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B3vdVf1ZOcMPQXwgeCPyMWHES0infJL38cxZ920i52A=;
  b=Zz5GNW78p2fBqzPN+2syX1OIGZECwSBe7aewT+5sBAQYxPogXwueU7hb
   TBeYqnTfE2DQXc6FKt0WxhAuMSRZ3N37qFEGO0m5yzhmzOhXZtTgJwYoD
   w3HVVNVoTHtoZHtsYWjRpSlZQZ7LMElIS03JlcHznfi+L6QzUqAblGRRL
   AwoPUzN6pvEKStqew2/cAqzp0np9TbObW8LpFZbHyTHlJcTixXwT+AUkW
   PI4Zr9I47+WKhdrof13qnHVlQoeh+OC2deeu9tuiCnyol6rfWxaREBA0W
   QyQpPLSod2kBtLwq5PH1lpslIqMTPnPbJNFREztsJ21MwZoN7GBRpKWFG
   w==;
X-CSE-ConnectionGUID: wBo1SplASLmBCjfVPc+P5A==
X-CSE-MsgGUID: UQhdreieSG6iN+fGFmJW8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47496839"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="47496839"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 16:33:57 -0800
X-CSE-ConnectionGUID: 0inLIM5kQt+YLXNvndk9Dw==
X-CSE-MsgGUID: Qi50smJYRYu5rPlT6hUzOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103769377"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 16:33:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 16:33:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 16:33:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 16:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luqouhG/AWtEkX2NqlOsrBn+PagqQjfFfIzoKC0CKmlvkYYWQwet1tF5crGdNGXlzJK68hh8++Qnxiizok0w0mO+/PZj0nKfOyUka8EHh6IHR6KV5ROzd6ppY+kc2wp7Nz+iFrdLWx0aFhUTSERSqPIbA9+YlgqjXX5/H+M9ED0Oao1HHft0koMH/dTcKQ+FPlERvO1+HfY1y5109h3REIKqWxCkbwaE6F1JtSZjKPuN7UR41PlRJf/FGvQ87V/KVs8Q28RZ2j8gjmRt7RnJ4q7OFBMmnL3r9ENTm8lkVY5Ja/rZjW6dLppiYMPD2n5ETQl7vASghmC66MQXg3ijAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sLhorQdY5Lx9C4HZl/y/RglEBLSgQCJcOL6HAOTujA=;
 b=UugDytSbtb8eWi/S/Y1RShFRmgzC+A9PYF6hRdpVTFKD9ZZPrwJiWwn0WtSZFoDlmEgUbFJjdUTP8LSlMWiaWYtwRk0w9mrnAWcjQ2cA2vd9mZWCE3qhxuqX77Sogw2IS9bpoXBwseUCcClUNs0pY7j1ia4HUrsbW9aIOLCha87f6q++zfQYxTOSlIZgzNdzon9oUXNboWvYRyfW/NOy42TzSpYTD+wJmh43GRcCZGAQnBa1SPVwJ/FfSaf2SixMcE6uRGJUzDeXUlivjiOA3kHOLg56yRzuNjWJCSnpl2hAd/S7cihyo1FewPYO7WbVBJ6ST5DtMLsETwJqj3xwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 00:33:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8314.018; Wed, 8 Jan 2025
 00:33:21 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, 'Richard Cochran'
	<richardcochran@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Topic: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Index: AQHbYBScY5vYzjLaEE6Lwoq9cluMmLMJ27UAgABpgDCAAI01AIABNhxw
Date: Wed, 8 Jan 2025 00:33:21 +0000
Message-ID: <CO1PR11MB5089A5A5ED6C76AA479BE1F4D6122@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
 <20250106084506.2042912-4-jiawenwu@trustnetic.com>
 <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
 <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com>
 <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com>
In-Reply-To: <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5021:EE_
x-ms-office365-filtering-correlation-id: 8ba4dfd3-2bb1-4ebe-d678-08dd2f7c0e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t/gRiHG4YKdDCwoSyTH+ufMCCs3wpG/KRDGma6lXH5wDb8SGCNsuM27y27Xc?=
 =?us-ascii?Q?9OymwFyA70tdz28EW4uA6rpGe2ZGG2+Wg8HqvueOfkD/JUv4N3iGFKacVmL7?=
 =?us-ascii?Q?NEPEb7ldJVIhojljDjU2MT4Vs5QL3ojM8H7naB1zWPTNNXo8BdSU2BDJv/+2?=
 =?us-ascii?Q?2bU4OzdzC1tWYuwQxBqWMadEPN7OEZOxiyoMt+mJ7vWJkHw2oCbN9J7TcmHo?=
 =?us-ascii?Q?0XaosOUrDRDuZkSS0zd82bH6g8OaxBYHU2jw6I8cYcwYngri/HBvP7W7ENwQ?=
 =?us-ascii?Q?thZUB7P/eODjZa5teSgUbtyCasaXMgKmBK9b4e8Tt3hJbyFm8HpT+PFIC3by?=
 =?us-ascii?Q?RnablDzLGTcLBs3G1/g8frxCQhkm2dsDXklVDVJbyWufh28ykS+TUcQHRqm7?=
 =?us-ascii?Q?fthawAQdGPoGMwjYT1es+povC4dNjqK4cjUPFrVu5y8gAQCEX5RcrJFl2CeO?=
 =?us-ascii?Q?YZyLyzxq8F/iTNF/UiaDV1Rxhl94o6xFTBQdX0Y7251RR75dJtW2B3R7vHTE?=
 =?us-ascii?Q?YAYuaRcThTNGzJYEakpPhySJL5pMxWMIoXwRshOJ0VYjQh9zwWvQzgOtYiAM?=
 =?us-ascii?Q?SufykItM+wwV7PoiQIbaigKPgHqCz12WS3cm2VRTtI7JFIQchpKxn+xHkVW3?=
 =?us-ascii?Q?oqjT6kRNlMxK0Lun5nSjzgOA6y7dro/BzFTu2n0AwWd/QjJiCSYZHSUzv4WZ?=
 =?us-ascii?Q?qZBip82bO5L0O5QAHQekh07FcXWbLeB4ceG5HNSLukM8BY/5jQMgXYDzjdZS?=
 =?us-ascii?Q?EldLXYU7/22eCsYnc1EB6MMnY7TI/Kd7rVklgLQu26fL9IiW8I7qfbYdDKPm?=
 =?us-ascii?Q?ZhyYaLXenagToLl+Uqf/nchmjvpXtRAPnFhivABD9atGU1g93p+g6R9x/vkz?=
 =?us-ascii?Q?/85zC37iyYLjDy5DFZ10N7I+qXNVxNDWGtlnU1rfi9GnrrYjXrZKhBzXGviV?=
 =?us-ascii?Q?bhpqi6+WWu6vKEXuJfCdVNVLL4+Yq7CpCybIbJzYtLCtOey3gzNMhYnc91H6?=
 =?us-ascii?Q?JCeJ5rOImzIiI8Nx4IGqCZ5u+JJgrzwTb0iAsKYrIu2qhhGu4oCpbj8PUFJB?=
 =?us-ascii?Q?+J/LElDVgtBdvkB5biCdHseA4TbPnLLg6Baog3YbWgcMez1tVgZ5Ks4Nx4h0?=
 =?us-ascii?Q?rEIXFsP9fPY78OGUoxXVSeuze3g9iIlO34F5GesO4D3VDtCRO6uUep8x3hsb?=
 =?us-ascii?Q?yIdRns0Vk7gHqoVxxhJnVOQkkcCd9/4z7c5+wJkgumiYR1iwQED9JrwaQpCo?=
 =?us-ascii?Q?sZfwFeuZsqS5D8frcAUMpHjMaf7OHsGSrDT6hNyVbzImc2a/DMn1I9sbtoO5?=
 =?us-ascii?Q?Z0/GtQEwAnR3pHgS62KJEqjOYhA5f4sAGOecI/a8ZgzPcqjnY1V/SjZt9kNQ?=
 =?us-ascii?Q?0l048owLuMMXBVk7dxyUgs5ZmPmtHvcIZLw363M8G3VGn4tkrw1hC55paRPr?=
 =?us-ascii?Q?AGjz4z3S2zlxN4MbSOeVXWhkxyVXmVRt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMLsS7VfDAuKJEYTsBJ0WluMFqKA5D1DT9xq5SRFGjpAWZ/zTJw30KLPw9F6?=
 =?us-ascii?Q?bMpBgf9FfSgILiK2ogx+deEFAqgjR6S5KrWdSMnCCeRpIGzJ0OQe2tZWRgYz?=
 =?us-ascii?Q?//93jl0AxvNs7fidx/+2y43dS5Uj/mFRJY1SJMAhHi7uzSLDsqs7B8V/AlPg?=
 =?us-ascii?Q?wZGZMbej6jzVhrAQwo0XOuSDJ2yxdlz0xtwJ4OToxMHLAVons+2UnAu17u1B?=
 =?us-ascii?Q?n33Wi2P1hx/zqHp1DwKkmfvw/hsFwu+ihivgQHZwaLWOtrPf/SrHXohUZ4XW?=
 =?us-ascii?Q?go5Cmkzj9gHNdEHfVxShm55Amg6NuFdeVSbC9WGmrQYxW3dv1hglry06yEiP?=
 =?us-ascii?Q?529J/DuxluQGIcFoa7pH0gA10Lzld8JWu2AdKg6JNRjj4/rog7Qyjt6RwyV4?=
 =?us-ascii?Q?POLYbc5lcRZJH3bSmvrVbeqZVBhawfS3ZjzIc6fnlWkEv0ejAcQR2SLqhqL0?=
 =?us-ascii?Q?YT4ysfi3qXOkoj4vgwb4wX7B2YvAq+dUnF2OS9S1pPWrMKZsEJ18BVeDL7HM?=
 =?us-ascii?Q?xsUr94RJCkFqiAtAcpnwNydmmg0fNE3e7fmHt8xnv0PKkMm2T5mf9k64B503?=
 =?us-ascii?Q?OTry9pwOQ3BpG7IT1wvsz9xazobYUsWWNSm2pJ4LALodjlas5U0gaM5nH66C?=
 =?us-ascii?Q?rcWIQwdBswxpe+2otUeK8Ec0J4YTtnvwrQiiLSvQc56AWHwMbATH/O8NB7MK?=
 =?us-ascii?Q?XAHl8InEiixk0/TuaOiGq0hPyvKtA6B4AK7HCaEf8CSpZyftploweXRMKYO4?=
 =?us-ascii?Q?Qv5ZYjCxRwpwwO1nxPNTgZ9cfgJGVTLnX/S2DcKeRx4oJE31RIoJSjiFTSNC?=
 =?us-ascii?Q?BtXjfoR+LLgjiHTA0QxxZOsZXGMGI6wwdD/RcU9qrxo5whMN/FTK6rJMnHeN?=
 =?us-ascii?Q?nMUX7FteJ5B07E/dXHo3w8KT3S+9TVKSV0BfSg2GYuWdUR4fP/sG61oIl47t?=
 =?us-ascii?Q?/znZzRvI8D2of8PgL6kM/Nv6iXUeXkzWD3T6SNiRbKO5KaDXSZrj8hq+KE13?=
 =?us-ascii?Q?DTP2qgdvTcCuIxPTemELQjzYU9h98gFhMK9Yqd6RiDKKrb+kSeSAPiRurbnc?=
 =?us-ascii?Q?AeObVxXdfpLlb+++2O7+Nu8Z0S7JcMWO0iT2pXw8Q4TAk8IDgwLS7KvhYR/3?=
 =?us-ascii?Q?chAnrHEj0urIn5u1N34sHNW/znLQ7am2I1UUcD8IV9O0Hy7yuVytopo9I6Ri?=
 =?us-ascii?Q?/v63Bv9y1Nl9HyGEnln44SaXzw6/UuJ8epaPjxHU97edP9QE4jcs1FUbdo58?=
 =?us-ascii?Q?AjRkrJg4ljVmiEtnV5JSFbnKbxfr6PImrtAazp7YtGIQOGLjuVzOFn8XKvOM?=
 =?us-ascii?Q?9VuUx4w5LEwMruzyeT3eN2XrV+F/FTa6i3C4QsyOqAIUIyIik9LoomcSNXPx?=
 =?us-ascii?Q?RucLdAmwloctYi8t0wCUPGDj7fSCN9Gj86XHmzhuLVUoZ1IuKNUeCJgVBVL3?=
 =?us-ascii?Q?dCKq1umAIyYN5vdIxHeggH8wNdrQIUQkHGw3PSF0vURZGuEvLAq7ZHDm3avL?=
 =?us-ascii?Q?4HQPBoelb1VGfY4gVqN5T9upR47fIW6gvKLqci6WI2RKgIzl69/1SkyUIal0?=
 =?us-ascii?Q?FcCcoBvfp3ZAj+6PEBpTm2mLlbYlvTVv2UT4JdQQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba4dfd3-2bb1-4ebe-d678-08dd2f7c0e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 00:33:21.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJhgAsL6tFUUsfn00j3/PHKdh+29eDFdLBGXTK7EubyNLhfPvIS4hd9QiHlZFeEDigiiRMBgpk0Z1s5akzaOLvFQ5g5AEF7gc0yBNfWvdDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, January 6, 2025 9:59 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; 'Richard Cochran'
> <richardcochran@gmail.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux@armlinux.org.uk;
> horms@kernel.org; netdev@vger.kernel.org; vadim.fedorenko@linux.dev;
> mengyuanlou@net-swift.com
> Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work =
of
> ptp_clock_info
>=20
> > > > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > > > +				 struct ptp_clock_request *rq, int on)
> > > > +{
> > > > +	struct wx *wx =3D container_of(ptp, struct wx, ptp_caps);
> > > > +
> > > > +	/**
> > > > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > > > +	 * feature, so that the interrupt handler can send the PPS
> > > > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > > > +	 * disabled
> > > > +	 */
> > > > +	if (rq->type !=3D PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > > > +		return -EOPNOTSUPP;
> > >
> > > NAK.
> > >
> > > The logic that you added in patch #4 is a periodic output signal, so
> > > your driver will support PTP_CLK_REQ_PEROUT and not PTP_CLK_REQ_PPS.
> > >
> > > Please change the driver to use that instead.
> > >
> > > Thanks,
> > > Richard
> >
> > This is a common misconception because the industry lingo uses PPS to m=
ean
> > periodic output. I wonder if there's a place we can put an obvious warn=
ing
> > about checking if you meant PEROUT... I've had this issue pop up with
> > colleagues many times.
>=20
> Does a periodic output signal mean that a signal is output every second,
> whenever the start time is? But I want to implement that a signal is
> output when an integer number of seconds for the clock time.
>=20

The periodic output can be configured in a bunch of ways, including periods=
 that are not a full second, when the signal should start, as well as in "o=
ne shot" mode where it will only trigger once. You should check the possibl=
e flags in <uapi/linux/ptp_clock.h> for the various options.

Thanks,
Jake

>=20


