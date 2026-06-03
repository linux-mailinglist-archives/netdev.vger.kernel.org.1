Return-Path: <netdev+bounces-294753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xo4QFz0tIGrcyAAAu9opvQ
	(envelope-from <netdev+bounces-294753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC86381A6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 15:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=apsPwv1Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294753-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294753-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB453010671
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA712C0F75;
	Wed,  3 Jun 2026 13:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596D2BE7DB;
	Wed,  3 Jun 2026 13:27:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493223; cv=fail; b=eoNj0FceFQCGt/jERVTpgccfVjovR2nSYrK4Efwjxug1dgS0GvxriqVYokUNOUPRNZ6Qn8t0O3m2IUo45eDPH8Ub9gcYA+vFHjgZ2JabMMUF9eB8SxJ/JMAdFPM0GvjINraMUm2KF39R2RvaZnN/uEIWGhEdCMoOQJDOhPvsoU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493223; c=relaxed/simple;
	bh=r2OyMJcI/LKEFiD9goHzLKvrO2Bd9HyA4m39saC0WR0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHBP3fodlxUgnaYusK8oLRXKQyeWGWm/yZpohSqf876NbcacR4O/32feAeSltcNECA85hPHsZv4Ok2AnfBYkIEtSj7rICQIkhSqv5tZGjfgt3+6LTP40h+DmRu86oiArVXUkTgZUJITAAhGt8lyANEC1jnXZNAHlOeGeJR4BDdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apsPwv1Z; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780493222; x=1812029222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2OyMJcI/LKEFiD9goHzLKvrO2Bd9HyA4m39saC0WR0=;
  b=apsPwv1Z2EOCfn3FBERonL8wd/n8jFmgW3tAe0hX3MFgwM6e1iPYMpRW
   w53mFUP2PrG3iuOpXTJxepPp8R+sSmT2XsAfn9rlboNgJu7o3Wt0fAva3
   ndWa9VRJgEryhBde8Ipho+oQmWyJrdI6pZRVMgInQGJKUEk/BbIcSPvTv
   i4cxInEXhie2zDKS7GJtuePaO4TQ4lHvViN9MbGRY9ZGyZ0qtcFwBVSdv
   V1p2hivhiVx11s3vmiaoMbeUnx2oCw/7cWy66qE03/3Iypzb4YcCZKSl/
   vflxN2BPph5CJngjqDYrCN0Ge7X038VaLrU/0EvP7Hc0eBkFK8ZpmfBre
   g==;
X-CSE-ConnectionGUID: LPqd6IuaR/2ljFPU6gAl3Q==
X-CSE-MsgGUID: XQ9yJXHgRWeKDv60qLg4xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="106753657"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="106753657"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:27:01 -0700
X-CSE-ConnectionGUID: a3raWPdCSiqhmdJTUrIUZw==
X-CSE-MsgGUID: 0g3SayxOSUeEU38wvs0Gjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244353584"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:27:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:27:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:27:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Im0rIriAsIdLTz+PC/T3F3OYKLwYkzeBljzqbiedvzvtEapmmYNe2GXaQhhWUnEV4LRjyuvPtXWyIKY2rteCp136wC7yrD8fkdl1xLzTCSmXI2j5tJcozh49PoGPMApbJfJsH7u0wD4L3HfQUXK6/Q8MQkC8W5RxORnkb/1RIt6voiGT/7xC0IAzEumftq6+X56EXjg2eU2s9tMMb8sy1jGcSkbi2FM4omD2szoPy6oPzZnTd1KBVmElK6DMgy/aN3yUVY/gRP84AYc1mmANgDNGliO3pr6kT1vtS/FB5mAKzz2oxisIzO0iNY4RuSm2qaH9vGExoJ64YjnnKFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dInK0FFQ8fDDv/Cm9D4JYNuO8R+iJLgqVXVmKY/Hk9Q=;
 b=Uj3cVKfC4bUc6rSeHEF+qAHos/bvAao0MWjCxJDzx4Hwvb0kKLPKE1bB+xj1kttHwOKm4trLmSCvBmwOqVYzCz76wl1RJHmszkThpFEx1QwQ9s9qqNDxklNwq2TgX8zTDYfcLOm1ujskmXQ2NSXMMS3/km9GUGJbIBxwh+vB/IE3elutY3mXO+zmfnOo7F463xFzsP1Jf7l8kiqAEJsJNZDwzyUvDacXfKmUrQ25A2H0m3gJ6ExA25ZNAWhKs6F++6g1Q4jxv1yuyDg80RHBbNvwkmc6842XbVXJZhhfTrYQ5xrey1rVKJU+W47Ie4ofHSpCNfjL/Z2O925Pby+jzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6174.namprd11.prod.outlook.com (2603:10b6:8:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 13:26:53 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:26:53 +0000
Message-ID: <8b5ee890-8245-4bde-af41-c689e3e12792@intel.com>
Date: Wed, 3 Jun 2026 15:26:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
To: David Laight <david.laight.linux@gmail.com>
CC: Justin Lai <justinlai0215@realtek.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
	<larry.chiu@realtek.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
 <f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
 <20260601224203.5d282c21@pumpkin>
 <d84e7de2-d30d-4ec1-bdfd-6d5e25d0271a@intel.com>
 <20260603105929.5f278675@pumpkin>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603105929.5f278675@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ac5f86-69cd-4cd3-4db8-08dec173c6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099006|4143699003|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: qg890x/uXrai1uEdCJ9ViZ7kacNTzTX+9NoC/ysAvItpqfve3X1dMTobQGhiM93wVWpwDT4Qm6EWrxabBv1CyovX9u33LO3AJ3jjzyt7tQzwtZKGtmwolfkc+Z2aJ/6HlyPZJiuro4LM6a4WRCiKl6XpXqrSZ2y5ZfIvKW+/+tBWXOksDIrBxGCTPL5f3swVkkF1IhGbsPHNbm0afj7UbSepgyoaizQLxCWVeecsxrwCFxqOOHMeLqQQ4rXPF1Orz0b3pxWYqJXnMeLRHmltSYTzCOWXc5DQgQeGQy6n8Ws7R2JNqjSXqvXIk8mfI+ct5vfe1A8clKCgziBCNtz1m1LbSL9pbqq8wHKdLxOjwUCkBWqvgBWLjbI/+mEEj6cJiNIzzlKyUSuZhCzkbLuyov8uzPoMQi59LkWzGz5+SkdaME5GwR38GLgiWYXiizTu3gk5oa3e7bsYGmIYqazqlHeqSiJQQ+NqhcJHc5ac29eBYTOkZ1OhsCwEpiHMg/zrYFriXrL3JyPh5/5d9a9yVhymqeaE8jFPpAY+I3HIstrpAXOc0vlnJtL7YxtRf6juVnXLTX0SxCf1NB0aJBIzM3Zxh6rwAIvSp13gS0Xb6t06a4k4CYDAVZsXnDiLoOcn0B/jwd3ukHqZY7Dp8g4IfYNSAePJq02PNV1CVbT8+W+6vdetSyo5IirEXp+RfUtY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FGRyt3cWFGMzR0dnZzeEFyS1BDdmd0YzgxbEowZFVPaWZGMlRCcHVSWGpU?=
 =?utf-8?B?bHoyZWNNQ0ZrRk9ybmNuQnZoeVNQN3BiTnVPdzVuT1NvZ2tVcGFuZXJyelpy?=
 =?utf-8?B?dnYxbVcrYmhKa3NONTN5VkVDYStpNDk4cWVGS0psV2ZnOW81NUZla29hYy9J?=
 =?utf-8?B?ZGJ6Si9iSnVDV01UNTExVTZOTmhldjhyMWtHWjJ2T0x0UGw0QTIwaE9iM2Yz?=
 =?utf-8?B?bnQvZmJwUXFSVmw4TUptTXYyMmptUTJsalNVM0FsTGxiZU9lNmlhNUxKdlox?=
 =?utf-8?B?dlZXMEs1ekhlNytGYjk4ZnA3SE90ajlFTCsydmF4Z1ZYUWY0MmtlNGc2UUE4?=
 =?utf-8?B?RE9BZldRUEtxenltYkMrVmlHaDlvZnBsb2k1UGx5YzBRU3FKMWFVL1J4U3RQ?=
 =?utf-8?B?d0RkSjdlVmxZaHBRV0F3UU9GVENabGMrVUNBaXpZaXZBSG9DdmhwVFBMaWE3?=
 =?utf-8?B?SmJ5eUNLa25PZjIvSlczcStpMzdiUS9DYXJUMEQwVGlYOWFjbzVGL1A0QWJX?=
 =?utf-8?B?a2Q1eGd1L3NRaXZJRlg3NVlHYlAvc283cWp6TEw2RHRaVlBYb01EYlNqM0Za?=
 =?utf-8?B?RDRBVXRsNFNyd0RIUmpGQ0twWEs2ZjVCMFVkQzdLVDUyQVVpVlNZVG9OaVFK?=
 =?utf-8?B?T0YvVkhPeFdqV0kwb055dERjeW85QXZkSXUrZ0xROFUvVFNSNHUyTGQrU2FP?=
 =?utf-8?B?amNWNmJvbGtFNDUxK1pCQ3pSSkpLQTJOckJWRHAzWnJVOW14dUR0Q3JrZSs0?=
 =?utf-8?B?STAxMk9XRnpibzFJK09mZXc4NW5uUDh5SWtnWXBIVVRTVE9xZVFZcHh0cVBG?=
 =?utf-8?B?Z0Jva0dNdmM4aEJTaUFSeXRUeWROQ1JPeDUzRXdIRU0rMnJHaTRZV1MvVDhS?=
 =?utf-8?B?dmp1bGEwU0pQallYTXVLWVRzR2wxckg4bFM5b3RCSDc4aVZNZUVGL0lFZUpF?=
 =?utf-8?B?NVB3dHhMREZIV0hXY0VlcWJyeGVmdUNKWHdzZ2ZFVndxeVl6c1FqRXJIQjR0?=
 =?utf-8?B?eTNScDdzQndtbzJ6bjg0MHhaQXFsS1FLWFB5VmJsWDZXb3NVMUs5MUVtNzN0?=
 =?utf-8?B?OFhVTmVsZmVKTW5WOEtYd0YxeWZiQlBUMTV0T0o4bTRYMUlkWW9iRG42Y29Y?=
 =?utf-8?B?OEJYbmFlOEdvM3lqV0dvYmE0WUNoeXladUVPQTlTZzVUUkFBT2VSRUVQQk1L?=
 =?utf-8?B?VUQyekRtb3Y5TGFqQmw4Z0xnVEN5V1dlTlBwRFVsakxpRUZGYkF4SkRVOTFD?=
 =?utf-8?B?OVZaUmRIcjFWMkdzMys1ZW5JL1JLV1IzUmhQaHJzcWtlRWhQL3A4RXZwZU1D?=
 =?utf-8?B?RVJXeDRnN2h1NEFsNC91OFM4TWhJb0UwTVVNeURWMGhrYU5XZW9laTJJVDVP?=
 =?utf-8?B?Y2srOGgxZ0JDTlZpSUxYcFUvSGozekF5SGg3cjF1VU5LOEc3b1dPYW5zajY4?=
 =?utf-8?B?Uk9HNlRmU0s1YW04VStiMDMxTzl5UHRQQUx3TldpVVNiaHUySllmSGxSYkNG?=
 =?utf-8?B?RnE3NXV6MnRiNGFpYktwYVI1V21sMnJsRHNKVFlmQUROaEhUdklQVkxFbUlD?=
 =?utf-8?B?M0xKaU03VTcyM2ZKZXpVdVJkNFBTSW1EMExWOENYNllaNDQ1QUdVUkJmMkRp?=
 =?utf-8?B?VTNHb3lyenpGcE8wZHliL0x1Zm45Mk8yZ2FJREFpY1prd0gxajBhditFekNh?=
 =?utf-8?B?ZGFUcmZUc2c0VXFEUEtYMUIvNXcxNHN5cXB6V3cvMjFxek85OTdHYVhEeG5J?=
 =?utf-8?B?WjFHQTlBOVdVYm53RWk4WVVrVXdueGtTMUROa1AraDJWeXFLTFdDRkQ2SkRT?=
 =?utf-8?B?Y0RXbXB2aTVyMXpnRDFnMjNQSkhROFN5N21ZYVR6NVNlZGM3RFN4cGIyaWFh?=
 =?utf-8?B?SDgxTHdWMFowa3ZDSTY3RUZENHpiZVhFRy9TdGx1OWVwdTlqRTFMdlpuWTZo?=
 =?utf-8?B?Ym1uejNERExWa1dPSWt1bzZCa3c5UUJWSXYvV0RzSm1mSGhtaVNWVzFzR2Fl?=
 =?utf-8?B?V1BsTXBNU3pxTTlLVE1vYzdGdUVQSVp5dFFDVmp3SUJqWWNRbm5oek54eFFn?=
 =?utf-8?B?SDBva0hIeEU3SUx6Y1I3TkJoc0hYc2hBT1A1UGt4cm92Zi9wc2xtNnJwVVRa?=
 =?utf-8?B?WWhtbjJFNXExb0RudXZjYThRS0lIMjZiSEJOR0ZRNFlOOWx4RmlSM2hGbkFT?=
 =?utf-8?B?Tjk2VDEwU1p0MkN6WjNQRXR2Wm5wUU50WlpTV0VsTkNjL1p2NmdDakdhVlc1?=
 =?utf-8?B?L3U2K3YyM0xmWlo5VlV6ZjhpSnV5VkVpRTlHTUwwLzg0ZlpvUGtvV0MvYzJB?=
 =?utf-8?B?emoxajFndlk1VXJMZnBMTXdBTWhMUHlJWU5SQXlPMFI4enVaMXozT1loM0Rm?=
 =?utf-8?Q?Fzz+CpfZCsX/bH7M=3D?=
X-Exchange-RoutingPolicyChecked: Lp//+/UCS9Wb+8RSVhecIrrygiWw1YlvPkykll1qhlovez3M68fctUqfck/XHOX4C3mges+N43eOzIWLO+zfjaMY1ai/Slk1zAc+nWic9A38qKYi6uKH9E6t2+p3fMAMQzetXX1pfGgO8XIZBkfu0evgulkhD0QoviIrIbe3nsU2iUpPFUZVcJfmjNGFFKW0RFL+8OeiP0kQ3Gh4FTUwt+iPu09DdAvGCUaaCKyw2vVMAPteYu3Fxgx3Q/SqtDm/AR+2mjHJZ/DumKnk2ddnk+1osOJAFWGpXt0N9LliaIKstyvLWFBD2+ck7lgF1zFQSa+qCUCAxSayiqwAUpoaUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ac5f86-69cd-4cd3-4db8-08dec173c6c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:26:53.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18iuqPOeX7FATCmDDB5V69SxiYT61BDtp8kpcT6Lt6oWxQ9n54h+Bd18uPwxlc9JycrudhKhbDTeMetXv/2vhMY936JB4XpyzcBY8z0Q8+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6174
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294753-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEDC86381A6

From: David Laight <david.laight.linux@gmail.com>
Date: Wed, 3 Jun 2026 10:59:29 +0100

> On Tue, 2 Jun 2026 15:43:04 +0200
> Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> 
>> From: David Laight <david.laight.linux@gmail.com>
>> Date: Mon, 1 Jun 2026 22:42:03 +0100
>>
>>> On Mon, 1 Jun 2026 15:14:50 +0200
>>> Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
>>>   
>>>> From: Justin Lai <justinlai0215@realtek.com>
>>>> Date: Mon, 1 Jun 2026 14:24:47 +0800
>>>>  
>>>>> The .ndo_get_stats64 callback must not sleep because it can be
>>>>> called when reading /proc/net/dev.
>>>>>
>>>>> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
>>>>> the tally counter dump bit with read_poll_timeout(). This may
>>>>> sleep while waiting for the hardware counter dump to complete.
>>>>>
>>>>> Use read_poll_timeout_atomic() instead to avoid sleeping in the
>>>>> get_stats64() path.
>>>>>
>>>>> Signed-off-by: Justin Lai <justinlai0215@realtek.com>    
>>>>
>>>> Looks legit.
>>>>
>>>> One question: for how long can this poll for in real life scenarios? Up
>>>> to ~1 ms is okay-ish for atomic, but if longer, then you'd better to
>>>> split it into shorter polls and reschedule() time to time.  
>>>
>>> Anyone trying to get a thread running at an RT priority won't thank you
>>> for spinning for anywhere near that long.
>>> When an RT processes becomes runnable the scheduler will preempt a lower
>>> priority process that is running on the cpu the RT process last ran on.
>>> The RT process won't run until the preempt actually happens.
>>>
>>> 1ms is a very long time.  
>>
>> That's why I wrote "okay-ish". Ideally atomic polling should not go past
>> 100 us, I usually used it for no longer than 10-50 us.
>>
>> The author says that it usually takes around 25 us which is acceptable
>> I'd say.
> 
> Just about :-)
> 
> Would anyone notice if the read stats code returned slightly old values
> and did a async request to get the current ones?

Yep, async would be ideal here.

> 
> Probably more work for a back-port though.
> 
> -- David

Thanks,
Olek

