Return-Path: <netdev+bounces-279351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDTEDCVR4mnx4QAAu9opvQ
	(envelope-from <netdev+bounces-279351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE541C979
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 072D5309829D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EC311C2F;
	Fri, 17 Apr 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwYXmq+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F259311C1B;
	Fri, 17 Apr 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439370; cv=fail; b=QH9VLUqAhVvatqV9BJUJIdBd0zW2npC0GXW/z89/4r9i99sbIwcJouMfyb5pmrMSlVt6jsbH/RBz5tEdD7/9toIFaAyhfajUz0sTjQg+oRRvfYtFJ1F4qWn4hwfvniuapq1RYFGmvk6sbJ0d3BEgLLBjD1odmVEH4CG7Z+lYBiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439370; c=relaxed/simple;
	bh=O8GVySNV6Kvq8LhmDSZ4dBsm7SSOmO5GetSPDWgoM9M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTIuvqSNZKGuRKXLkqtHiB03Vd4rZuWNg7wYcuD6b/Y/ibh8SV+e+hcYz43MRpxmjUC7ufqtksvgaeKufyvdG6wDRuLHdwIIs7SZwGzTBXLfy0YWxwNU8jaMbJIK6mU27PNBLkJ1iJnLlD/XiuGZWkZC1JP0yU8QJ5pUzdY8j4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwYXmq+Q; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776439367; x=1807975367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O8GVySNV6Kvq8LhmDSZ4dBsm7SSOmO5GetSPDWgoM9M=;
  b=UwYXmq+QeJzIH8FXa96D16VFlLSZ/fptJGIK5gLiudXE2pfJjXAjS1WJ
   8nOCVlz/Kx0hITGJj1/fMy8PAO78LNnYdSdgCspubml6dRr4rJS3uMjfN
   c5T4qnVf1N4OBGDuVnpN4EMi0oHnfsjG1HIzi3PWXC0Nr2pVAD6AMx33i
   e+tg3qhCYjjWflaGt0yK5u7rO1X9YAqmDXlBjO9jVDgDycJctaMHKqLUU
   QKrcBGu2eaba2Y+pIdXCGMr6mNO+TO6oXr8+K+U0HAMa0UHuFyaDfRBnF
   pJKZVod/mW8ZwVufkf63Eur4vZBkoiy/XNluvSxWDjnTAKPOklc7U+CZW
   Q==;
X-CSE-ConnectionGUID: oXLTSlF+RfCYxDgFIKD9XQ==
X-CSE-MsgGUID: 4qPciNfjT3S4AAcDEvRf5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88834726"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="88834726"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 08:22:46 -0700
X-CSE-ConnectionGUID: jXXBsiNARDicIgB9GoSYPw==
X-CSE-MsgGUID: uCX5VOHCQpWm4R/0BGJmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="226719414"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 08:22:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 08:22:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 08:22:45 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 08:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcqRMZO+7/qbXOz5Gh05Ilm3mK38wyebLua5wGei37a5AQ7Uv0FtT7pFodDGsaBOs2m0QtuYWRLS5S/kYQhr28TjS8ocn+2XPidZXUEP4t9OzU7gMX//zi2xLVhCNwHHEJ9eN8jRXhjhuk5qX2yrHZbbz10xmtfl04sQG9IQX2Ae/Bz2n96a/mGjuM8M7YlT7WkwXnyBmA+OIsByvhBAe6Uk1CdYRxWp/iWb2FaNmPvtS657GN/VFns4fZ1txDXxXJmFz5L/CbUzmCcYGxpo2r/8B5B+WOuknoe3CNcrgONm+AcbUDFppQXEl/f8/Tsh+lltfOqqrgqk1Gg+YtjeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1CO0SShBs+uWiXhoc4fYpg9VPcHXXSB8M0vovOalOw=;
 b=NJ69KCwmdHRGtMidXII+b+sxroBsmWTyhX3obIHLY0xGiPxBYGZeHE3qlQRgIS5Jh0MXq89+i3egC1894CyTK9IXhl0a89X3qU+sD/sHE/m6QUzFWT/HQ5hnQCzDHqWWTGO59rBjzAOhOwrmHX+9JQy7OeA+CUgZkkY8giLqxgA/wWKLSAK/f7RDP0NK/TEQfrmDAQyRmWD1dMIsc5k5a5QW5YqWqXmD7T//oD034q3VWN80mh0JchU3uVgjx51RcWuvrQsDyNi8qpzZsUiEMvRke8O+t/ScBxbQX4drL0+gGZvCR3Dh7W/z8N+bVGGCPsAgPaHUww4oYvuQJE7BTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:22:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 15:22:38 +0000
Message-ID: <0a78a89a-1f2f-4ee4-9b9a-74e824511380@intel.com>
Date: Fri, 17 Apr 2026 17:22:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 0/4] iavf: fix VLAN filter state machine races
To: Petr Oros <poros@redhat.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "Mitch Williams" <mitch.a.williams@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>, Przemyslaw Patynowski
	<przemyslawx.patynowski@intel.com>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <jacob.e.keller@intel.com>
References: <cover.1776426683.git.poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1776426683.git.poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:8::20)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cabf0c-0005-46b7-be0d-08de9c952919
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: kLS8+xt35N3cf1CBm6EdQJBeskrP8S7eFS8aRKP8Iz/8qJlF4iwecJCBejyQq3z1+sqW9TRf+p/3tQwxdnQcxf8LGVWl282KhlMV1COHoIropACsnI8xMfmcVZAdJH8hWrIWa30eHV1p4GyR1TIvhchjL1lbhoGaiKft3d+B6j7ODe2+RXnhMazqRHHg/NCmuZa/uo8MkIeSmRxo1dF3TrncFiN5BfiD6ac0cgA++Ng5LvoXiCRt1llShCwZ8Cy9JuTtcJCIphN0FGCbfDhvzy14/GKknYXrRgpErKUSUmA1vIN+weGpuag0kH3WxrVYdqSSmM2/dUTMhoFRK8l7cO6XSNs4N1VnIWT/wAvscW2oyeO5y9TE8zu8R5BqH9FtdYJhKNIYCX0hTtsLM1l4tPwXN1nux0sPQb/g//4pnFTIOH7Vk5sgRjY7PVCgmKAdiL6zTSkWx3d191UIuBUkBFWd+3jl1sRz8d/Z/BZIv1o+JS+OcJ3CtCRGOpwwAkQHUzqw1IVDkkeG1BS++UtI3XIygxoiowejVHJC31LP+P4UCYv2s04K7CjmuUMITgxhQnqK06372A+jUhI5b/9NBt4jzkYLvJD7hACtD9pmqwqlt5ubIEKJcCSlFUSZj3dyYEnk6m0Lkj6/rlC1NVbZ7+9YZY6K2+s3kFG4HvElQyZp6F3gbL6pECiSxSS0Lj8UpdeRjSvj2GpyjsXNKosJqVFPpMpx+LAwAx9KvfQxKNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NJdm9wYWpNRG04cGVaRC8zNnRYekJ5VWlFK0RwWEpORHNvZElNMGZ4aVh0?=
 =?utf-8?B?SDBJSnhYRjMrUU1RTXIvQ1pybEVaTW1qKzJvckhzbE9UTVBvVGV4WEkyQWVv?=
 =?utf-8?B?WHREZy84OWpNbkd5UUpPRHdta2JoVXU1a2hWbE9jYmpLV2poRnFpL0VjdzZp?=
 =?utf-8?B?UXBlNUJMbGl5V1FoTmF0b0lmQ09nL1Q5NHJGSzJYQnUrR3NBUlNyeVlxRGpD?=
 =?utf-8?B?Q0MySWFMMkx1emY5MUZ6S21vN2ZZMzArZU9DZDF4TVUzVWFEVUZDK01ObkRP?=
 =?utf-8?B?VThEU2tJeW44ejh3a2U0OVlJRGNHdDJIZ0hJc3dtaFJUdnJQcGJpY0JjbTFp?=
 =?utf-8?B?Vit3Q00wanE1eG4wY3BXejRHS1hmR3lzRXhjcjZPM3phVENWY2dlclRYYi9S?=
 =?utf-8?B?TkUrYlgrdFdVdzBsVnc5S0hsUjNIa3NtM3RvYm5LVEZudWZWTG1DYkR2aEMr?=
 =?utf-8?B?Ym1xRE5vRXNpeCtjMTlUMFNTWDVWdGpCWEhlU3JIMTJIR1pvbzJDbHpnZzR1?=
 =?utf-8?B?WUpHY0dDdVgzRjl5NE9CYUtUcHp2WldnTlU4OTdxcjg2Wm9LemJqOXpRNVkz?=
 =?utf-8?B?cTFBZU5lM1ZyQkxDek1YRFA3VUJldVQ5U3ZXYzVNYmlEK1pMTVcvRW42R1Qy?=
 =?utf-8?B?aHk0V05KQjgzY2psZWJ2ZVJCV3VxMWxFMjdjYWZKUjE3ZzNTcFNlZFhOcWg5?=
 =?utf-8?B?aHBkMjJOeWxuUFhmV2twVGRRQ2pEaUJxa3FGNjFqRllpTjkvMGFoNVBLMEdD?=
 =?utf-8?B?ekZWNFpOV2FrU3Y1b2NqaG5KSzdCazlIOEJFVC9vZjBWSkRWeTdHbzJFYSt4?=
 =?utf-8?B?ZUlINllodWF0QTErS1Y4UlFob1B0c1gvczc2N2JCcHdyMzB6RW9ZbURieGlV?=
 =?utf-8?B?R21OZ0M0dnMybGN6MUlBZFRtWGEvYXRnUjNiZkR4eC9Ma1BQeGE0a3VGU2Zt?=
 =?utf-8?B?aU8xbXhJMTZqMGt1UmtUSGR6MGFUR2U5NVBwYk5Ed3BZMDc5K3I5K252NXp5?=
 =?utf-8?B?UUxzUnN1eEMvQnIyamJ5bWl6UW0yN1MvQmdGaXcxL1k0OTZ3dTNJK0RubWVY?=
 =?utf-8?B?a3R2TGFhL3dsUmdycUt3QVVEUlRpNC9TS0JxTTYwbURlRFFWeDlJb09OYjUx?=
 =?utf-8?B?S0M3N2tEc2MrdTB3SzF4d2I4elExZWlzaUFaakFENVVhY0hqbXI5MXJIa0dx?=
 =?utf-8?B?VUxMYTVWaHg1WUZHWWZ0aThGcE1Id2pYOE1YSnN3UEcwa3pKeUhaM2VXMXQ5?=
 =?utf-8?B?Ni9oaldyZlQ3T0lCWXJZS0ZKNHpvSERreUt6TFBRUllveTVoclZoQTM4aGl6?=
 =?utf-8?B?VXFEVHYwZ092OVdvS3E5TEhSUHVoeU5MWG9aKzFLc2t2MTlDN0l4eWM1RGRv?=
 =?utf-8?B?ck9lTEJyc2tCdFRkVU5qdytwSW1nYnhxR1gyT0lkSmpRb1dtUjExNVJtdHBm?=
 =?utf-8?B?MTg0VHRZQ0Fuc1hvTm0rUHZ5WTRoQ1QwdHFtSk9YTkdYZ2ZBMEpncEhGTktR?=
 =?utf-8?B?RjkzRnVzMG5aS1c5bEtWb3BtaDd3OVQwdU42RkZUNzNRZzB1WXRtRzZhWFNx?=
 =?utf-8?B?T3l6OFFrbkVLenA4bnJJWmNrYzkvaHFVa0VyMWJiUWdYMEJHN2dJR1BVbC9W?=
 =?utf-8?B?UmpoVVhYczR0WW5wWDVpNzZCcmNPQVNuOEx3aXk2eWdkR2I4WWNGaVI4RlFo?=
 =?utf-8?B?dUYvNXpQNlFSTlFUTGtDY21uUUFBVlpIZVVVclozdTFtK1picVc4enh4NUpw?=
 =?utf-8?B?ZGEzRnpJYkVZKytWRkdVdDJFcVd4NnRVY3ROUURiekIxbGVNZ0V1YkEvTDJO?=
 =?utf-8?B?WU5hSjBGMGJwNE40K1hJZ2ZIamxJWEtFa3ZhUVo2N3ZMU3VQRnZFQm9tcGdh?=
 =?utf-8?B?Y3UzdFNLV3ZOWGFxQS9CeHdyNnJiaXBuWEh3cWpJUnUxUERQdkRFZyt1NWtC?=
 =?utf-8?B?Vkl5RjRsb09WeGxJNnRaUVBJMEF2V2c5RzlaYk9FdkJxcE55eW1OTjY4ZUp3?=
 =?utf-8?B?Q0JzaW51d1htNjgrSjd0QThCU1E1ckhHTFFKdjBSNFoyMUFCTmlPQVdYVXFj?=
 =?utf-8?B?cWM1OGtHOU9NdXB1bFBzRFpEVjhOUzhNOXV5YlRjYkpiMW9qcTU3MkRQZ1dQ?=
 =?utf-8?B?S1U2WTZ6ZzhPN3AwTGdRZHNtTFRyMFhjZzJNU2lwTVRUcnZnUE5TaEZqKzNW?=
 =?utf-8?B?VVFWdGROM253S1EvbjNvSHpKbVJBMUtmYlBiS2tDSTdnNFFQSkwxWVJTZmZk?=
 =?utf-8?B?VlVUczBnZ0g4MHNpTFNpNHVZVXRqRWYvMjVzRTE5czlIV3o2VFc5YzNCOVRS?=
 =?utf-8?B?c2FVcWd0MEFFYnlQdkVoNmJqRHMrem5PTDloZGV4RW1hTSsrL0lVNGh6enRO?=
 =?utf-8?Q?fVNc1jgTD1a2iJew=3D?=
X-Exchange-RoutingPolicyChecked: SZC6bEARCty7RHSFCvFb3de7jE9Fr1MdsRZz9yXKe5IBKyn5Wl2BtcXrj7abreuwyBQCfX530GB1+WwoG/LdHVjD2uI51Zse12cPstP91hiRQ5SxnQGS75E50ed4kn8a6QnNi7c88lZ8d1PRF85tBwVeak+8Xgrx4shRJHlI2n7fZCgOMJmXALDPDcaxzxskByNU7Pd+R04jo5Tcwcle4Wf0ExUao72IgYcy+OS4P6R9UAMaIqt2JlOLGXgPruQT5u1Vf1y6b2rPoDZ0eyVM0gzdXQcCcGMcu+0sSiA38i5Alzdl6NnHE36F5Y4u2x90nkNC40geHFFVo7QDEreATw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cabf0c-0005-46b7-be0d-08de9c952919
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:22:38.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkbNm0c+hBHshag3GkPA3lGT7rquQ0YfilsR8udy1TtWFSd8YAyFJeuKCvXpNfd5+GYPdRc8GF9TdrQaZbgd/qoMi50GK3gM5mlJhoWiViE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279351-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ADBE541C979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 16:29, Petr Oros wrote:
> The iavf VLAN filter state machine has several design issues that lead
> to race conditions between userspace add/del calls and the watchdog
> task's virtchnl processing.  Filters can get lost or leak HW resources,
> especially during interface down/up cycles and namespace moves.
> 

[...]

> 
> v2: Retarget from iwl-next to iwl-net; these are bug fixes.
>      Rebase on current net tree (conflict resolved).
> 
> Petr Oros (4):
>    iavf: rename IAVF_VLAN_IS_NEW to IAVF_VLAN_ADDING
>    iavf: stop removing VLAN filters from PF on interface down
>    iavf: wait for PF confirmation before removing VLAN filters
>    iavf: add VIRTCHNL_OP_ADD_VLAN to success completion handler
> 
>   drivers/net/ethernet/intel/iavf/iavf.h        |  9 +--
>   drivers/net/ethernet/intel/iavf/iavf_main.c   | 52 +++----------
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 76 +++++++++----------
>   3 files changed, 52 insertions(+), 85 deletions(-)
> 

Thank you for the series, it looks good.
Also thanks for the not obvious details, like changing
list_for_each_entry_safe() -> list_for_each_entry() in places that
no longer alter the list

for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

