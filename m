Return-Path: <netdev+bounces-165859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25050A338D5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F5E162FA4
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E889209F57;
	Thu, 13 Feb 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt0cvnR/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1F208974
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431702; cv=fail; b=JPnKFwzFtqVwZHr8Sj1Yw5tML4jDyuSZsKaqD9rCRCKxK8T52WCasNFS+gbSZHo8rBQxKig388BFrMAQWA1xiCjD4CIIQ2oV0gqrIHI7N7HtzLGYM7zCDJoiJIOACO1wsBbH/Tu9dESLM65j0Z2QeHto+cKZucqx6Ujh0qgBKis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431702; c=relaxed/simple;
	bh=gMT5wqHuNMbbITDlyVYGxbrzuWBkB54NRQSuoqlIJXI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjXFKHuDxFmcZaNGltYyUvA14TDszPlb22mT03SpmKJQEEU5d3mXmZdJL+1NEJ8ElTPVFjEqyQ9DZ+Yv8+WyZtzkA8DM1bx4J2bJtVjpwwMEUPTd7ou1HV99NrMULURsvT+wLt/fLs1zXeiMPpncJA7pTpVqLxgUlfpK2JbLCHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt0cvnR/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739431701; x=1770967701;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gMT5wqHuNMbbITDlyVYGxbrzuWBkB54NRQSuoqlIJXI=;
  b=Jt0cvnR/EPb5xcpgnkxrgLuYkO2fpiEioOXsSEjNCdQvtU3tmn89BroJ
   6pvkPHEx0qazUiteW3OZi27ZsjuGqPz4bLGaDYDUdD8ji1VZIOsqqKfQ9
   qgaP8L+kcv8E3UcHTTAH39QkTMeVjvGJg3O3ldlEE5OfeT2dvhu/vgdfh
   X69sq4NmOf+E874CEd0r2e+IXusR38kjV2FMNbP3L06BnD1JnqOR5STZm
   ahrmExtbl+azXdwtJGHRs1y30nsceuP2PjflRPj/n0gGoyqHDOZbzLXYy
   EMKV30OOfepPLgEOh02NfKhQo+cq3tF1kta3BQYc4zG6g4U7EOEG13MQv
   w==;
X-CSE-ConnectionGUID: 69HKwOwIQDmAkRS12Jw8xg==
X-CSE-MsgGUID: bnQslw7LRiWx1MEix8Gr5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62587013"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="62587013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:28:20 -0800
X-CSE-ConnectionGUID: grb6tt57RJK2Rf2Dgxm1tQ==
X-CSE-MsgGUID: VuNF9XGgTTuuazeBc4ITzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117172400"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 23:28:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 23:28:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 23:28:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:28:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEYplcfuPm8PgmOxRSP/daWe054D1H8/yHyuRkLbA3O+KjQn+5J+52nMWZXrKXTmQY3E/ZEsL4bSX2BI0LUCln8hbDGjDlejxRXuQG2UqUo0jOYvdeAI0KjrixdZsLHGGsYt+pgp/wFSZmGcoAGoYvdpVtNQUbICkhSQ7Cq5tb8OxAogV7QT2me1fEVbmTiYHZ2/rZ5eFVJbrrM/HoUZBtS2zzynsQEl6N22oFTNSkb6G9HSvlLAWYnLTU5pngcPd/to5NRQ2Z7w9NHxCwS6VhgD6vnixd7jxg0alfbmrcJrNnhokQApqBarkmB7M5yreen/senpkOVLEMZMaMuCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZmnSDpRqW30STLFKiD38yKgiol4lA1ikfV+rVhi0Es=;
 b=SW6j5SZaRaebwMuh/PpCPUbRO4GlrSM9TwEvn22/R2/3dD6tJSW4dTYnRuG0LOAI7wnrcdP7Q7YOAhT+rdyy4mmmApZa4+L4fKq97IGvik0JoP3+Pqne1okVeYuGRXZOEGxvSSCBU4eH5mlOw32LW8o8r/AvCNnHLtCmI4iCilZkqifyG27bzgWteY7vzDAthRTWEnbh8tVxRWKLrJpPB0ZDWncFHsdsrb2MHJFjM0moZzZ36moaHQaVIHJW739BNF+PDp4E98NvjlnFHvVh1siCmaTp6nSSyF8sNM8momTpWTDxikV18dnQqn5MfRl8RMvRDt44wmBEVCwCgYb8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by PH8PR11MB8063.namprd11.prod.outlook.com (2603:10b6:510:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 07:28:18 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:28:18 +0000
Message-ID: <3135409e-d92a-41d0-a865-e7db0c6e7ce4@intel.com>
Date: Thu, 13 Feb 2025 08:28:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, "Neal
 Cardwell" <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<eric.dumazet@gmail.com>
References: <20250212132418.1524422-1-edumazet@google.com>
 <20250212132418.1524422-5-edumazet@google.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250212132418.1524422-5-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|PH8PR11MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4c9f71-6350-441a-047a-08dd4bfffc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RWdmFSUVYzbVJzdDlONGd1TC9ZMDFwcG16ZS9CdGRyeCtBSGFSdDByYlZW?=
 =?utf-8?B?MDd5UldwNS9BNU94N2d6QkRuOFl3WjdUeUNHV0U4blcrVmlETUFkeTBHbXhF?=
 =?utf-8?B?ZlRKampveHNxSEN2OGFKRWdERTF6RHFkSXN4RzkxU2V5eCtpQ0ZXcW9lZEFC?=
 =?utf-8?B?UnNZc1BuaHQ5OG5vVDhFbU84U05mN05qcys2d25MUkVDQ3ZFakZDV3ZkRTd0?=
 =?utf-8?B?ZjIwVDg5eW1ZUDJtaGY2bjE4ZGQ2Z2w0RGp2blZvNG5GVHJaa21IcmV5bGR5?=
 =?utf-8?B?MUJobWtjWXdSVWhXSkZDRTg4VWtyb2dPeW5lQ00yQlBuVXJnTUZUOFlZZ2kr?=
 =?utf-8?B?RFd2cTl2MXRTQkFpNjQ4SDc5TENlYW9VNjJ6aWFKMC82MVF0TVBZRm80Y2xi?=
 =?utf-8?B?bklPNUJJNHRqQzV6MVZMTlcyamhDZm94ZlllUVhLU2RaM29aT2FJamtWL0VE?=
 =?utf-8?B?UTlNU1N6S1FRRDF6NmNWcm5CeVBuQXFqUEpDejEvNHo3amkvQ2loV2xjOGs3?=
 =?utf-8?B?RGp2QUVaNjdoRm1wRmFqc0x0NGp6OEhpQjZVbVE1Z1FkZG5zcmxlOGNPRTcw?=
 =?utf-8?B?MEpkcTVaNEU4YWJ0Mmc3RUVqNDhDQ0ZFaHBnNWJYaFNzUHE4L1IyMTVVSk5H?=
 =?utf-8?B?MnFVcTZwTVppMUFpOGwyWlJlTC91WGxWZkIvQ1VFV0xhdG8rTkp3VHkrQjhh?=
 =?utf-8?B?b1pRTFM4K0tqZnRlMUppQzlSRGk4MG9RK1BWTk9tOTRvdVlrdk1OV3dCd0VU?=
 =?utf-8?B?dm1zWndDSW5lWUM3aFhHQ01CV2NYVVpTNGp2TXVXRlcwaHV5MjRDSjVJNndX?=
 =?utf-8?B?eFR1Wm1pRHYzeGVZVE85bldBSXBtS0pGL1QzWlRXOHVXVng1bDQ0c2NZNXY2?=
 =?utf-8?B?bnlvVTVBekVyVkh0bzhHNDlxYVM2RlMrOXY5dTYzZDNYU3I1SVkyNTZWMzNp?=
 =?utf-8?B?bWsvNGdpSjZCbGFVL2xFM2htWmFZaUFSbzBiQXFTNmsyMlpQa0xCQkh6UWs1?=
 =?utf-8?B?T3V6ZmFTMjhWT2xNOEtOUEVmMUc4aGlYYWQ1RkRMQURlYVpJZzRnc0xnbER5?=
 =?utf-8?B?VDhmSGhIa0NtTU9HaktFWWRYc3JQRHA0MnMwWlpRT1pUb0czUkJ1ZHNlRy8r?=
 =?utf-8?B?ZmhzYk12VG9NRGdjMGliSVozZExmSUJXM2xRMmxxc1Rmd0h5QnZQUHRTMzlV?=
 =?utf-8?B?UkZzTnI2Z25xRjh5Y1R4b0d2aVBna1hNQ1hWOWUyQUkrRnpWRkNuZXFTUXZq?=
 =?utf-8?B?NkcvMXVlS2JBZWZFS28zNFRLZ25TQVRDbG9rTWs3Sm85dTdnUEJkYThDb2l6?=
 =?utf-8?B?aWpBVGRNcDBFbFduY3RCRFBRcHJXcEVZN3NKM3c5b1J6VkN5eHZoSGRKZEh4?=
 =?utf-8?B?cllJRStJWW5HdjBUWnpiQ0FMYlVJOFQxNFVDUW9yejcxMDc2M28rdTF0MnBz?=
 =?utf-8?B?bWVQcUp3bVFlVklraDRFL2MwTEZoOW1zM1lsZ2h6ekZ4K0ozMjhvODZoWUZh?=
 =?utf-8?B?TS92ZmNiN2ZDS2F4WS9JUEhDMkpXOXc1OWxPR0tGSEFRSGJZcTZ6dmFWN1RF?=
 =?utf-8?B?Vmk3V0I0WDdsUHQwNVYzdjVQUHFFbEx6VWl2YXZLN2RYNmg0TTVlaDdhUTJH?=
 =?utf-8?B?K3RtNmZiMFJQVVpBUnJQdGtxcDBhMElBWXlIbVJuSEUyY2xqSWhuWi9VY1M1?=
 =?utf-8?B?RXBQaTdTa0oxUS9KTStvVEJJbXE5b2NOeWJybkxQS1BHQUkyZ1pNSWhLdGdv?=
 =?utf-8?B?TkN6Z1Ryazc2SnB0QW4zR0g4ZGdrdk1XVS9OT1VPaE1TUVpqSkordmVnaWJU?=
 =?utf-8?B?VjFkbTJRb09zaERscmV3UGIxd29PTVErV2txdDZQRitDZWZwM0RyY285VUZS?=
 =?utf-8?Q?OcxnWaikpvY1V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklhUHpwdUJaby9OdE92VWd4MDg0SnBCKy9CaW8wTGlYUlNxSVorSGZrS3Bt?=
 =?utf-8?B?ZnZNQU43cEpvaXpsNkN5ZmZiaUVlOWt1QUNJSjh6Wmp2d1VkNVhmSEh3QStx?=
 =?utf-8?B?LzFUZmxHZjJXaFJpRXpZVHRJRnV0azd6dUcwc3Y4dzZqYjdnWTBlS2tOUFFo?=
 =?utf-8?B?akJ2bHplUWU0WUlpendidnJRT0VSVUNWb3VrOC9GWWo4MXJpRzNydWpCWXNl?=
 =?utf-8?B?VjRYUnpNOXBTZzBGT2tIanY0TEFmcWlxUGV0b2ZDaVVUcFJGMEk5L0s3RXJF?=
 =?utf-8?B?cEZhZzZZbkIvZVdwNWF2VWtaQWVJdmNiYVBwNG9PbmNpSFRrQllVcm1PSGx1?=
 =?utf-8?B?RW5wMks0Z25wKzBjYUZEM05wdXNSL1IrblNLZUpDajN2SExqWW8ycGl4SlVo?=
 =?utf-8?B?Zll1dGdWcC9tOFMrSGlvbldURTdYVktLYm95T2JQZXRSNStDc2lLbExqQjRo?=
 =?utf-8?B?ekpFTFV2NEJROFpaTmU4ZjZiZ1AxY0N4bVNrQlljaWJzV1ExUzducjg2UTU2?=
 =?utf-8?B?SGRNQWpmQll3NkVCMlhYd2FLQVJSa1p2Y2xwMEZuOFMrekRTdkRGcjI3eDRt?=
 =?utf-8?B?elZuaWJrcFZja255c2ovL2wrNVA1T3BDSEtNSlRRc21IZk9wTkFaS2xGa2ZS?=
 =?utf-8?B?akgxa1V5TjdzRmZ6UTlCcXh2Rkk1Z0lZOEhtcE83bzBwKzhaYnRzdDlLbmpi?=
 =?utf-8?B?bHYzRHN6S3pXcHNQTzhvVldEa016TytxN3ZhU1dNOWdrcE96RGg0V2pQV01Y?=
 =?utf-8?B?Q3ZqWjNCNkw2MHl2L2c4OU5jNHJtQTFkOEZCVllZZUd3YmFTdmdvMmNsUTlh?=
 =?utf-8?B?R0pRUnBzbm1kUjlOVUFmbFFkQm4yS1VkRjlsdnYzenZsbmxTK2RXZUMrQjU3?=
 =?utf-8?B?VFdjQTgxc3h6c3hob1FpUHFod1YxT2lvNjI0c1V4cHlJUjdjdW9ZTGJIL1d6?=
 =?utf-8?B?emlQd1hZcVRPb2Z2RGFXNXduNWlkM01tQjN1b011dTVRdk1Wb2FXNFNKMEhp?=
 =?utf-8?B?YmF0NzJhdEVkSEhsMU1DRTAyRmwyYUtFYTlJdDRMbUJ5bUZMK3hMdWxLMTBY?=
 =?utf-8?B?VE1NZkRlSFY2dmova2gvQjViZ0NjdVhVcG5McDhWTHV5aGt1LzRaQXlxdkVa?=
 =?utf-8?B?cnlpRDVrSHVJMUJQY1l3NkRUa2t6OFFVRHBGZG9SekVCN2UrVWIxM2M4Vnly?=
 =?utf-8?B?WHh0VlBQVkR1eGxZUG5WOEc3Y1ZLRDdGQllOZDdJNFZYeWIzcGlCVUhrTjZs?=
 =?utf-8?B?MEtzSjI3OTlwMnJlblAxYkhuaGJoUFVEMmFqZ2dsL2pzeC9EblhSZnowWEQ2?=
 =?utf-8?B?VVQyVFF0elMzL1gyYnZadDB3dGNIUGJGdzh0U3hzam4rNGJid2lzUmMxbzJU?=
 =?utf-8?B?MUUydlE5ZDJPMWZhb2Vxbm5NaTQwWGk2NlhYMEREWUUzSSs5cHZlQVVNek92?=
 =?utf-8?B?TmJNYk95cjF6dkNnUTZHWm1xZW5vNnJXYnhHZG54cDNlM1BmRndLVFVKdEV1?=
 =?utf-8?B?RDJ6dDdCUTdtOEtOSHJvaTVOVFgzNjhNamMxZk5aQlRVZ1lHQ1FIU3JLdFRw?=
 =?utf-8?B?TlZ0dFQybVV0WFZxeUZ5Q3hqbHBLYUtiQ29iZFhVL3lGMkRqOEpKSkxGV2RV?=
 =?utf-8?B?cWYyRENETXFQU25BajM0emZ2U2RSNlJQeTYzT1ZhRnh3RDFySTh4MWdiaTZ6?=
 =?utf-8?B?czk4WklRS0tzaEtFTC82SmtqaERCeHljWVp1UlBtZUFSQUROSHVvdVJMOWNj?=
 =?utf-8?B?UUcyd1k2YXQ4ODVLZHdNN1QxQnl6VHRHaXUvZzVRWW9MUHA2MlQyNkFDV2tk?=
 =?utf-8?B?dlFNVVN4ekFRdVhhWUYxdXRnTVN5STR4OHZIc1hxYXIwaWdxNzFwMldqb2VS?=
 =?utf-8?B?dkcvUlNoUExDMmx4N2l4eStKcTZEaysydFJaczY2SzFyaEpZK08xZTF4WktY?=
 =?utf-8?B?K251YWp5RmdVRFIzanNSL09WcnQ5YlVieGdaakFUUGE5b1pQOGRWOEx6OFE3?=
 =?utf-8?B?cFRIcTBCcWNmU2I1NVhDc2MyaCsrS2FMTGp0aDJ0Wm4xbVluay9PWlRQZjM5?=
 =?utf-8?B?T2tGMVhmY3gzdHVPL1d1ZjVTb0tHVTkzRzBObVc4Wng3UDdsT2U4eFBQcy9q?=
 =?utf-8?B?bWdNc0t2aDlnTXRaU0JZZk1BekIwRG00YnlldGVTOUZqNTBSZC9lU1pyMjZs?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4c9f71-6350-441a-047a-08dd4bfffc3b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:28:17.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jroPUSvZfm5TyvunkoKhvbkEdV0uY69LSChevkQwz7gLu0n53Y+MWWYWoPmwJOhKY5IBtfGjd1xSEj3sgyS3HLq1pF3Un7Z+qzhWOaJVT2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8063
X-OriginatorOrg: intel.com



On 2/12/2025 2:24 PM, Eric Dumazet wrote:
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> udp_table is no longer used from any modules, and does not
> need to be exported anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/ipv4/udp.c | 63 +++++++++++++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index a9bb9ce5438eaa9f9ceede1e4ac080dc6ab74588..3485989cd4bdec96e8cb7ecb28b68a25c3444a96 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -121,13 +121,12 @@
>   #endif
>   
>   struct udp_table udp_table __read_mostly;
> -EXPORT_SYMBOL(udp_table);

[...]

> -EXPORT_SYMBOL(udp_seq_stop);
> +EXPORT_IPV6_MOD(udp_seq_stop);
>   
>   /* ------------------------------------------------------------------------ */
>   static void udp4_format_sock(struct sock *sp, struct seq_file *f,
> @@ -3616,7 +3615,7 @@ const struct seq_operations udp_seq_ops = {
>   	.stop		= udp_seq_stop,
>   	.show		= udp4_seq_show,
>   };
> -EXPORT_SYMBOL(udp_seq_ops);
> +EXPORT_IPV6_MOD(udp_seq_ops);
>   
>   static struct udp_seq_afinfo udp4_seq_afinfo = {
>   	.family		= AF_INET,

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>



