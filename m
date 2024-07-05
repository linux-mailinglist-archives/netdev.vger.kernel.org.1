Return-Path: <netdev+bounces-109463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003E9288E7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FA91F26317
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7314A611;
	Fri,  5 Jul 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSKdlmrh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A471E4B2;
	Fri,  5 Jul 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183562; cv=fail; b=IOI4oaMc5AqaIFXH+D1SkExH/jEYID+Jsvw5pPBMereXoHnHuUWSRlVkEkhjpIznkywLmE7htPONboP+azFjezTx/lXyFiFWJRVWONIb2mMKr79+4FtzS8G0cBX+UL815n98leLWkRPx+A8JVvaDA+3Oga7G8hcNwonwCbcQ12E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183562; c=relaxed/simple;
	bh=nWhNNPOiLMy3/Ly/5Dzo+UlEtyiu0I34GFvdoH6BNdE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Su+5IJpVmA5c8c29MD+a0XhQa8r39rIhvll32GeqPTvWMEIv3cQVd9r8CmH3I8k5IvrHrxbwG2E11UunzISXTUUnAPHlkcHgU9mWzp7dh2VRkzh/p38vOqvZPBZ+Eavuy/iUfK5XsQgiCB7Wl9bxSowP+Vdi7J72mtFZgAlLbSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSKdlmrh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720183561; x=1751719561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWhNNPOiLMy3/Ly/5Dzo+UlEtyiu0I34GFvdoH6BNdE=;
  b=QSKdlmrhWMtj2qTOyuFwR3wszjK6UZ7OZGML6N21DaPzB5lk5RBAFNeT
   SRFVGzG/1fqMMScqD7Y2F2r4v5s/MsPwc9fvIobOtQK7+jC+A1SqeMZo5
   jChizuq01Wtfrn8FhOB9zNW+WkzWm5RZPudjm2P9N+W0eCW+LlPFjNSmZ
   2pDmffuM3X+IDP329eGXHvbaIBrIzFTKWkSdAFoJNjG4WcFzHijtDJLJ6
   jJz/GvTAgqcqfPpruRy5f8CE8DxXauPihIPEqUCtBRtK45pUjgZKu1xSc
   1Qn1kcGG00QByqph2z0PcepIiTrD+qaN5zCWK7L1GdK1hoiez1nGTW0Wr
   Q==;
X-CSE-ConnectionGUID: 7eAgTekXS6ex5DmCjrSP8Q==
X-CSE-MsgGUID: if7MM30kRM6Y8GQqmg7eUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="20382447"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="20382447"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 05:46:00 -0700
X-CSE-ConnectionGUID: hjUIO3LSTxiAb9X3YqRJ7Q==
X-CSE-MsgGUID: tHjSykYqTrudhBqUPCXMXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51465816"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 05:45:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:45:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 05:45:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 05:45:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 05:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja5gKfel7sqNMp3rvwOLK6WpDCpfQcyImPLQsjI4+Ugg+uli6GrJ4Xdgq5On2BDQMLzQIpIjXfKfOzCDI8Y624POboIoVeOhDol3QOEZZmC9a3wIayZ/EjPiCWz1p4TtdJJ0sOGvVp7Aj72X6u9Yt6QlftAJ6Z7pnftHEdVUxoDsEEelLUwjcAZDHAP9e5kFpipruwBr23KkPXcw76drdxl4fqfxNTZqqs/UBUW69+lEBb48k77/PsahXmORrj/xi0mAcPwEMe8W3F9DpJfIT2r+VnGHYuDm7aYfN293vbVAJDT2Y+Pk+BR/p/9DWK0rBNdRChhjOZduCLkOq1wxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMXGFlhGDl/P9mX7eMhqfirj+uYzgC6m+T501dqWiCA=;
 b=oGzKMhZlmC7bCPuJg1rP4AK0n34pNVMZJpneiBRuDT62Db0t4Dw6i8Af4BbZ2V98HArf4fUkBOAR7ciQ4aoBKy/LdtGCDWPIBJ5l+Maps//DIy1++JMRP+DgTSnQWDC7K08uEjO6bZZD1ViySvhjXTfm1ODtCWghuaAc2SW9VEOPn10xZIlGkIGIZiHkczHHlHZbiC94DM0htS4WNa12dhAPMl6Nol7BvUvhzLiAgU9Ns+tnoDAw7w7Zo1Wncwkje+rGQGjSK10KQ2epLoaPEKidPl5Kbv3oE9RuGiSbFZZlv/ZenLE+yKrlE1izx0xzwW/3s1tBiBubeIpGlUYyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 5 Jul
 2024 12:45:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 12:45:56 +0000
Message-ID: <f5754d0a-1640-4d20-95fd-a2d74dfcc084@intel.com>
Date: Fri, 5 Jul 2024 14:45:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] netdev_features: convert NETIF_F_FCOE_MTU
 to dev->fcoe_mtu
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
 <20240703150342.1435976-6-aleksander.lobakin@intel.com>
 <20240704191646.06bb23c8@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240704191646.06bb23c8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: aeed157f-4d10-4054-9bb2-08dc9cf069f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1Rrc0Q0eENrZ1k2VURjK01JdFFJczFBcWFGQ2NyV0M1REVPdzV5dHlvZW1E?=
 =?utf-8?B?U3EydzNBaGdwQ2JaU3ZRNFFETENNT2dyTkVHSmRHRzgyZEQ1dXgwaEs5OEJl?=
 =?utf-8?B?eWFuVSthZlN0YUtMQ3BCcllsQkZJUWZHbW9LNC9McHNNcEU3NkFsM0t1TTN3?=
 =?utf-8?B?TVNQbFVGd0ErY1Z3clBIVUkvNU43VkR3azBVZzc1WXRFVit5bVdyS0FWUnd2?=
 =?utf-8?B?MTdLWDJMZHVMNlBHYUo3b2MwVFlsZlIvbkVldkJaMXl4NUFtUXJWMldwY3JJ?=
 =?utf-8?B?QzJ0ZnZDVlBmd01wVEFtbVA2bkZSR05Lb1VkcjY2SlZnRGJQbE9yYVhKYnpZ?=
 =?utf-8?B?MjRaempwMllobzdFOURGRk92RFlrdHVNaGZLSGVBS2kvelBWY0FHRk1YenR3?=
 =?utf-8?B?a3VIMzFQUjJOdWFTTkQwU1BwL3lDODNwVVZvNThia1pNaXdkUENUcWtYcHI1?=
 =?utf-8?B?Z1BnT1ErSVNQaVRmRk01azJ0TW1SV1Y1dVA0RjVRVFJYZThWSUs3SnhqZmhB?=
 =?utf-8?B?K3d1OXpjc0t0Y0RyMzdUUjllYzRMbzBCeGZtbTRHVWkvMHo2OGJxemo3WjNX?=
 =?utf-8?B?aHk1SjdIUG5FdlVTczlrMCtpVmpNYmN4NWJTL0Vmd3A5RGlrWWkzWVM1anAz?=
 =?utf-8?B?eE50RklUUENCRmR3YS9QOHJrQ3ozVWFHN2J0RHBXRzR6TWo2WGowWXd5eXpU?=
 =?utf-8?B?eUJCcGZIejVFM0VrWm1zR2hReC9OcW5GY2tMQUgvcmNicUlVb3dWd3Q5NlB5?=
 =?utf-8?B?c2hpK00zNlJRVHpqUU5lMCtlN1pjampzSFpyUGFoeUlna3FUQkVPdGNMT1Q3?=
 =?utf-8?B?bm1ZTC9RcXBhY2tsbjYrVW9ZeS9UV0JxamQzbC9kR3AzUHlYbnN3TVVXcXFu?=
 =?utf-8?B?Q09WRnBQVDkwdVVHQ0M1K2FXYjE5L05ucGFzcHB3WDdCVnA3RGxkOVJUcHE3?=
 =?utf-8?B?d1VpZUY4L2tDbHVOUkJIZU1lT2l6ZmkwbDNDUGpzYk5FeEx2Y0dsSGF1NmRl?=
 =?utf-8?B?SlRyQ3BkYVROMkdwckZtalRwTjMzMm0wTmVzaUM4dkRCSmN2ZE0yVHlZRGZ4?=
 =?utf-8?B?dys5TkltRG1HSXcvWjJQOU0rYzdoYkpUZHh0L2ZseFoxV0pDTHloWnRHY0la?=
 =?utf-8?B?TTNQSWM4RFIzN2sycWsrR08yWXc1amh3cUIxUHFPWFI3ZGM2KzZBQ0dmT3A3?=
 =?utf-8?B?Z20vS3AwbjRVREVZSkplVzRIaW9ING84TzhLQzRIUC84ZFd1R2VGVWRvbHNM?=
 =?utf-8?B?end3WmxDK0EyNVRhalBsQVQyeUlpL3FxVFR5NytuR2hmV0FHdFJBcTJNMVNv?=
 =?utf-8?B?RmtBMDNtREFDQytoeHl3TVhsTnRQTEZLTzNIMmo2bE41SmdUQUZFTG9hMlR0?=
 =?utf-8?B?M2c5L2VHU3VySXB4WGhTSUE4QWFmNDRYZTBSTW5ha3ZoL2NjRXpCaE1OVzFG?=
 =?utf-8?B?QmsxVDBtU0s0Mm1FQ3VUY1dNbXMvUHBlS3ZhVmNvQlkxZStYNytDZGVlT2U2?=
 =?utf-8?B?SHhMTUV2MUV3Y3MwMUJXWWFXYlhFL2FHWnhBTlhaL2I5d3F6eEJRZEMyMzVV?=
 =?utf-8?B?RCtGOUx4WlZYN0pVdEM3dmZnU1pkMzhLczFBL3doOFM2akdpbkNIRjYxR0xN?=
 =?utf-8?B?TUtERTJaWTRrTWg2MWhVU2FDZTBNRGFYNEVNOVdpMkYwQXlya1c3RUgzTDBZ?=
 =?utf-8?B?TUNmb1o5SDFaSGJkZXhYSTNwNThzT0tDbG5ZSWN5YnZ6bUJiSWhsaHZlSi9S?=
 =?utf-8?B?TkNnU2RtbmpNZklsOElZd3NwdWliRzlrdnMrOFVIYWM5UmVqTXNsNFhINlQ1?=
 =?utf-8?B?RzZnTTE1M0tWSWl2VWFMdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVxQ0dmUTlQYmp2cW1VYUhJVE84ZXpnMDRza3pubG1FTTk2VUtOVzJZOWMx?=
 =?utf-8?B?T0JmMERRT3N6N08wRDVjbVUvbnhlT2lQMHIwM0wrckdiMmw3NVowT2xWQnp0?=
 =?utf-8?B?Rk5ia29nWnhWOWZtV1pBNG1zR1B0WmxXcnBCdEdBMGZ4cWE1aWJzeTAwbW9O?=
 =?utf-8?B?dGVCTzQvUFdKMGdTblRBY1RBOXppam5LbkRyVVVDZlB0ejF0bVdSNXAxV3Vj?=
 =?utf-8?B?N3RkdzdrVkZ1VkV6K1A3N2xqTDBMUHhVbnd3b0VmVXhRb0pkYzFSQlZad2Fw?=
 =?utf-8?B?YWtLZVJQMnA5MEtiYVhXcjlranArNmRVaDlIR2tJVDdSbHljRUw1N0YwN2hh?=
 =?utf-8?B?RVBTRTZrbmdMTDU2VTdTUWJudTBsRXMyNnRZRER1MTRUOUJTMk0yQzV5S01s?=
 =?utf-8?B?YjJ3KzI5WU80THV2MXZLZVg3eGpSRVE2MWRaQUZhNnlaY3BhRVVTS2F0Y0FO?=
 =?utf-8?B?T2RlQXpEZTBNa0ZXY051dmh3cVVZRXZjVmYyNmNvZHp3M2pndCsxaGNMSVJz?=
 =?utf-8?B?aThRem11MHNBdERqQ0lENGtHMUhLUS9Yalh1R3hxMlpVa3NKeXhJTHFCYXFV?=
 =?utf-8?B?cUNSRzgwcXFuMkFidnk3MW5DUzBCVWo3N2h5ZUV2cUR0YUMvbThNY2RYR0sw?=
 =?utf-8?B?NnFBMVY1WUNmdDhyL3k4TWV3QlNiRXFKSlhkdHpTN1E1L01rUnVyS0JmWVBH?=
 =?utf-8?B?cEtuaWJ3K1VIYUZhZ3NFbHh0ZUZtaytleitncEhjaVo2dzZEc0RjSjIyTnds?=
 =?utf-8?B?VUVaQlpvYVlpbXdmcFduL0YrWUZGcDdvdzRxbVVJQktueXl4SElwYTNQUnVQ?=
 =?utf-8?B?TUpUYU1TaW5jaTBQNkhwMGNGcWV4NTlaVlJCVkJnSmdQN2x1RG1DbjFiLy9j?=
 =?utf-8?B?SU11UTVMV2N1YnVBeGhxeXkyTnkxTXhzYTQ3RVhqVXQ4cjdqMVF2VTlLeWxY?=
 =?utf-8?B?Wi93WWRBQ0xScklXRjFqQ25kR0dwdHNqN0pQajc2ZG5ITEtseGEyc1MxeHpT?=
 =?utf-8?B?czJOa3RIQS9WMHplVCt5aFAxcXdWVHk4Rys5anNKTU1oMk9CVTk3aTdoUjF0?=
 =?utf-8?B?ZGsrZVNWck1uVFdQRmw0akp4M1ZLNWF2czZoVURTbkFhNkRCQmNJN1NqUlJa?=
 =?utf-8?B?L2FDSllSbFBDTkV6UW5oZy9ubDZpeTM2UzlIQzI4NjJlMUR3M2hWUkIyN2tp?=
 =?utf-8?B?bUpsemxDVTc1OTdRRHF4SkllWWRHS3pBUWFFWWcxU0JCdVVkSGoxN0FOdi83?=
 =?utf-8?B?VStoODBsbUIrcTRjMjZsaWNGYkFXWVkwZGx3UTFXZEZSa0xvK3lnc2lpbVlN?=
 =?utf-8?B?QWhwOGR4TzhTM1IxR2FsQ1I2bk16ZjNQSkNteVZXb0ZXSTZuNVF3bE0yWGhV?=
 =?utf-8?B?U2Q1UUxRYWorbmROMzlXbGdXMkdIS2ZvZUNGeDBYYTEzL0RzakZSU2I2Y3pO?=
 =?utf-8?B?NEZhY01XWWhacWIyYmFXeGd5MFBacGhOTUx5WXdOZ3ljcTA4dFlTS0JJUGw3?=
 =?utf-8?B?cEhoSGhtaU1TdGxTZ2FKRDNkZm5UVkExRmZDajdRYzdaU1dHOEdySmhoNjVa?=
 =?utf-8?B?aFpCdTdGNDJNQU5aRktxSWMxempmWEVodng3UldsZysvS0ZmeDIyWGdNRWVM?=
 =?utf-8?B?K3BMMVJRS3NqRkoyMHRvaUdFMzd5MksvU2d3WEtuay9PS25ZNVpmaVplNFJJ?=
 =?utf-8?B?WHZ6am1Jc0lnbUVDQlorbUtKOHJFdFA3a01YMVQ4Q2xUWnF0RTcwZVFFMmZp?=
 =?utf-8?B?T1NGUUxmaDFQamJQakdGR0wwT2VyUkhZZEV4U0xla3lteWJvL2dxMlZESWps?=
 =?utf-8?B?d054eThFcGhuQU5EZGhOU0FxK1o3czVFZzkySmQ2N3dwV1RaZytMRFlhc2xP?=
 =?utf-8?B?aHhYK3JzMHB0UE1TZDZPZEYyYmZDOFBmNkZ4OFpjQnk0eGpvVDBZU1o3UVRn?=
 =?utf-8?B?YU05Z2pJcVB0N1BMM1JZdEZnczRtM3lBSXFONStDNVlGcm5heCtVbUhDSGlB?=
 =?utf-8?B?d2xHMFNuc0ZPOC9yMmFrRWlHYlYxQjhQNXlNOFo3QThNQzdjU3IwVkhvTGNT?=
 =?utf-8?B?bUhkSVN2a3pEejdVM3o5Q09HclVKQlhKbUdqNk5zOXEvdjV4NVA5RmtCUEtj?=
 =?utf-8?B?MU1ORElqb1JUQ3RIZ2pHMVVmY0NiVXZYdXk4bGhzTTFPSERLT20rTnBkMk42?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeed157f-4d10-4054-9bb2-08dc9cf069f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:45:56.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwgC8odmUpVKeWSht/t4TW+EGfMTwSHgPgt/FksW90JIjxuFIb31F8qMMfPs2dNPZW/XEojtmATlHCfn92Xm+Btp6yDQ0oDrwfeNFSiUe5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 4 Jul 2024 19:16:46 -0700

> On Wed,  3 Jul 2024 17:03:42 +0200 Alexander Lobakin wrote:
>> --- a/net/8021q/vlan_dev.c
>> +++ b/net/8021q/vlan_dev.c
>> @@ -571,6 +571,7 @@ static int vlan_dev_init(struct net_device *dev)
>>  
>>  	dev->features |= dev->hw_features;
>>  	dev->lltx = true;
>> +	dev->fcoe_mtu = true;
> 
> why?

Because (couple lines above on the baseline):

	dev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
			   NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE |
			   NETIF_F_GSO_ENCAP_ALL |
			   NETIF_F_HIGHDMA | NETIF_F_SCTP_CRC |
			   NETIF_F_ALL_FCOE;

			   ^^^^^^^^^^^^^^^^

then

	dev->features |= dev->hw_features | NETIF_F_LLTX;

			 ^^^^^^^^^^^^^^^^

#define NETIF_F_ALL_FCOE	(NETIF_F_FCOE_CRC | NETIF_F_FCOE_MTU | \
				 NETIF_F_FSO)

						    ^^^^^^^^^^^^^^^^

IOW, FCOE_MTU was always hitting dev->features previously :>

Re rebase due to 1/5: yeah unfortunately, but that happens :D
I'll rebase and resend on Monday.

Thanks,
Olek

