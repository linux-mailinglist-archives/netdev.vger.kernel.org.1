Return-Path: <netdev+bounces-153433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523B9F7ED1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89331666BF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5D17836B;
	Thu, 19 Dec 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dyz3D2Pr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F93D3B8;
	Thu, 19 Dec 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624202; cv=fail; b=oDydAHnvlLdVPef9wT0xkRZUx3HPsuBvq6RGZl8U9vIQiHIOOpS0UR8jHqjomMyeOxBBKKGvXPS8Y+6TAznX30hiY6RJWCxaDBDHZbDWk4Yq3u5lUhMh6jsgvNjUIYtCqEBoQh9pdMQoZePLC6pnTvi304PZWA1wDW0g2ZVSTpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624202; c=relaxed/simple;
	bh=R1J/qL9Y7XSRZfWGUngSwzFkKvhMZ4J9+7HlGisHjDQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih1vdtpk30mQPswyW9hDsC0VBZY4ximeiVEsou0L97+pId3XEMAz0putQ81mz9tgQ/ZPaEXBadC4kA7RiQtpFn4h1gJhirNVbdVY4bWk8E9o7TTIDWzSsf6ugNVlkkc9U2kdWx6/N0qlBqJJen7wmPxASI+d6UxdWq9LGxn69Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dyz3D2Pr; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734624200; x=1766160200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1J/qL9Y7XSRZfWGUngSwzFkKvhMZ4J9+7HlGisHjDQ=;
  b=Dyz3D2Pro58jXPg4HxarXXnhJppDnFH1j1xWgxDua+H/N6hykzBiTAnm
   w5KeJd6GauZlOcs7wnl0mPPfJlbIn+Jv4tUnbcVyRq2IfX8wHonmB0naR
   eZsNgSzBEN2nwAPwNE5XNMuHZA/wDZgFUNpb4SbPK3K9PKX2zWQFUR/PU
   psCBidOS5Y6GbGGIkY+lDv3WLnejI1YzAm+KplW0hjm6u9wYcbRdY2/1S
   zOkr2JH2RuqIeGa/+6SgwlGqcnM09fRBD6stGor1ItHlUPuIC1/cs60Da
   KmXQgHcMjkhiSUuZmd3nUwbjRQhEBYpu5b6ds5Lz5ElQyPLA4veKzk0Cx
   g==;
X-CSE-ConnectionGUID: qi62/wNyQneqcgaPzxFZYQ==
X-CSE-MsgGUID: UOGyvwBZRv6+blW5odlPXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38921152"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="38921152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 08:03:08 -0800
X-CSE-ConnectionGUID: twdyeOTyTPmJm0dH5HXp7w==
X-CSE-MsgGUID: fBEtTP0rR7+vWk4kmlN7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="103216591"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 08:03:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 08:02:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 08:02:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 08:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt0H+r4igOCUN6a1a8gAj6ObU/t71eQdyh3aNxubffaLV+EqkKfEOYkOd1MMMmR0isXOKIZxMWJAm3hUYaVYteaEqur4Jg20rDCRRQyySymHV/EtF130kJp4HcRZ3qjzg/60rdMWf59YDN6y+pfKR+tKl/8fGG+ViGFrb262QqzukcCH8S1+dEyuS3v+U7t3mm4OnpKtHh5FGJflPAqLUmLHE7kiZkPREXYuOYn+lI4AmD8RnAL9mFMFYSgWoj0upIyiherPLGNAdcNkv8xl3zI1dr1s8lUCcXVCTH6p8VJWJpQ+BnGTYaWQzik9WHUSc/TIWIjtCOxc1MKhTbM+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37yJGDnUF4ucDOrtjdh8D9fAuD1SRGixahdsXVHZGpM=;
 b=PyzjqlYIx7Cns7qDKnxUTy7AgMNtUSrW8YL4swd+S2esbn1QGU+42T8vJzX1RGUvqRCxjMbgslh+i3PReKrfWGYAiDIdzYfH4EpYhNrRGp6gLzaobySHrOcEpmt+16wmqODgCtZN4Rg9ztj3NqD0Xxs+EQQOQ38iuexaTYTUgw9w8KnOcEauns90Zjw6xf6qeC9FIeD8OKMezs3iHvgYkYrq3yQn09zsfxcqlgNuk7O9JW782jc5MeiEfRxWpJgtFL7cUBYzuKlODWT2LD88SdWRwhCirXLM5XN1OC3Vtg3G1kd87tI16/nWhLrPlf9zhmD2l74UmGkH8pkvwwQWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:02:25 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 16:02:25 +0000
Message-ID: <c19f8761-1642-45a5-b05b-c880fb4ff3ad@intel.com>
Date: Thu, 19 Dec 2024 17:01:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net: page_pool: add
 page_pool_put_page_nosync()
To: Guowei Dang <guowei.dang@foxmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Yunsheng Lin <linyunsheng@huawei.com>, Furong Xu
	<0x1207@gmail.com>
References: <tencent_76E62F6A47A7C7E818FC7C74A6B02772F308@qq.com>
 <20241219062438.1c89b98b@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20241219062438.1c89b98b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: fab51d12-2999-4a00-93d4-08dd20468786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEQ0Tm1nUWgremw3RU5aQ2JYQkh1R2tOZWJSNmlueXIyMTNka2krZG8rTW5D?=
 =?utf-8?B?ajFMT0dTOUVlVGlnNjVMTW5udUpLZXNzMU5tSkxsUC9tL1JQUk1jY3AwaEZo?=
 =?utf-8?B?NjBCT2ZFRTF2b0x5OTZyMWJmVmV3R2kvNUh4aE81eXNmUEFLUXorQ21pUzlE?=
 =?utf-8?B?di9VeUVsSkxlOS9QRmhCemFFeVlIMmg1WFVENWJsWG40aTFoaGo4ekR0cTBG?=
 =?utf-8?B?ZmY4eGlvc1pGR09GT3B5SWxtZGEzU0pLU3VGd1ZZeC93K2ZsME1OWWhTVDVq?=
 =?utf-8?B?d1o2NXE1TUhkbGhaRU54VUx3bFVuQTgwNXEyNU95Y0ZFc25BMkFDNGg0VFgy?=
 =?utf-8?B?cXpkNGswbUpqai9jOTFFZmhGTE9idDRpRnpQalJWeS94UlIwOTZKTWhMVlh6?=
 =?utf-8?B?VmlNU3ZxU3YwNllIUzJ6WExtemhXT0F3bmpXVi9WcGJKNlQvN0V3czkrazU4?=
 =?utf-8?B?UU1sTUx6OVBtcHhrRXNZSm9Ec3F0M3FDQjBRaTZGNURvaDVES0QyMkNMOC9h?=
 =?utf-8?B?MmVob3owN2JtRkdnRU9yeTF5OVlwd1FpUU5venViWGduL284ZHA4U3UvRHla?=
 =?utf-8?B?M2kvNTBsa3BMcE5hVFl0em51VzZiUE51aGpySkZRclNIYlZVcG0xMU13MU1a?=
 =?utf-8?B?RGYvRDJTSHdzc1d5SVZMTlZaQTB2UjQ3UFRhUm9LM3FTSEhaN3hhOVRTSlJM?=
 =?utf-8?B?WmJQenZNaUZEM3gvT0NXTllNL0lnQ25Cc1RlT0lWWHhrRVc2ZUhuRFhsQlJl?=
 =?utf-8?B?WUdTbjlQelBSa0FHSWZMaHl2SjBuTUFNZWRTTFdqU2cwMEVlTk9RZlJoSlk1?=
 =?utf-8?B?L2JueHVDU04zcllBd0NJcVJ2eGUvaklaOVpkM3Baa0hlOXBvUlFETHdvSTRa?=
 =?utf-8?B?SjJlM1NnNzZ2V1Q3eTRaVTF6QjF1ejd4R0hKb1FGZmUxUWRkNDIxNkl5TFZY?=
 =?utf-8?B?K0lPd280UEtndXpWelY1MGpydU1DOGQzRVQ2eU9UTm5kajFvMXcwQmVkQnMr?=
 =?utf-8?B?SEVEa0FwZ1FHWUVwVUNFa1NYL2J2c2hpbHNXR3ZYbytPc2hSaERYRG9JejN3?=
 =?utf-8?B?MDFoT0kxUVhIZ1RvOS8wTncwM2RGSnpxdTdPWHFSbDBLWmswTGFWaXVtaGtr?=
 =?utf-8?B?VTlHL1ZIV0wyS2hSOEdjejB2aGNOc0ZzRGVDVVNaK3N5UjFSeVZ3eXF4cTU5?=
 =?utf-8?B?TkJ4SkJUanIyYytiaHFEbkVJN1YzbXk0UzVEbmtIL0I0dW4xR2hHNWVjeGY1?=
 =?utf-8?B?TUpkNG9ubHg0bThUT3hWNkxBS1I5NjVNK0VxVGpMaE5TVXhTRTgyNkFldkhh?=
 =?utf-8?B?VTNQNmNVRWZ6UGs0eHpZaHlEaGdxVDBGMktIelgwNFMvY2xXVlVmVEt2Rmcw?=
 =?utf-8?B?a1Y3UHN6b2RTRjFtYkF3Mm83ZGxWcWJxM0QzdENCRkMzdU9oQ1E3Y1pjQ21Y?=
 =?utf-8?B?dFhHZXVTb3M5bVJqd1BBTHJDeG05MHJVRWZrWUdEL2dVVElrb0NJTU9odTIy?=
 =?utf-8?B?aDZhM0F1UU90cHVBYmlDSSsrRUtaM3dCeFZ6bTYrVG5SQTN3LzNVRUU1cmZn?=
 =?utf-8?B?REJjWEEza1RJYnhUQUY4c1V5eFIreml4NFBQNC9zL3JyMDcyOHdVbGtMamd4?=
 =?utf-8?B?a2NZNmpNcm9mTGN1MEJIMytDa2tpbmxXNklYNG4vZGR4cHp3aWlGSk9rSGxZ?=
 =?utf-8?B?dkxzTDdwMHhNQllIQkNoZnllQmdDRW9oeW1XbDZuSHRPL0I1Ynl5bytnWnZj?=
 =?utf-8?B?NmVxREdIM2lHNldQSnFScEFWb1cxMEYrUGIveTcwRkR6bmlpR2FnWk1IKzVO?=
 =?utf-8?B?TzJxa0NqeVhMWTBTWTF1SEhOVjVFSzA5S1ZEVHFFTzkreDd4S3BwRjFmeWZZ?=
 =?utf-8?Q?2nNubxgoGDsIO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BLNEgzOEJidVRRSXJkeHVkM3hwb05CaVVCbncrbjZnbzNna3Uycm5YNWE0?=
 =?utf-8?B?SHRrSTMwU2xpR3FaZzMzTTM5NE5abXk1RFQ3c09tazBLMFAvTkRrUU5vK0Ri?=
 =?utf-8?B?ZmN6NUhBZ1pGc0EraHBjUUIrWWlocHdtL2lnUFZkMjFlZVB2VldYa3BKSmll?=
 =?utf-8?B?Z2ZPYkxGQ2pQRFFpZjZRQmp0SjEvVFlWamE2eWllSExNeUJmeTFKclQ0YTRF?=
 =?utf-8?B?U3ZPeFRydS84Z2I2bVNuYXlHK3BnbCtvckhta3M5Y3UvVEJ0c0cvTTZERWRu?=
 =?utf-8?B?bEV1K3VvV0N0MExQRWlVYkZuamxYdGRYS1E5MWYwVzRjREVsSUJabEpScVNG?=
 =?utf-8?B?d1c4SmlGdDgyMnh1L0xuNFBKdHJJUnhXd3lPWTloMWRFbGJ4Zlg1MmQvdDM5?=
 =?utf-8?B?Rld0M2hDZnArMk9XakgwbkpROXlYSnBIUWc1ckI5endWeVZleEczdVE2US9k?=
 =?utf-8?B?RkNFK2laSUh6dlZPUlRNVW9VNEJvWm1BQkIyT3pDL1VIdUlBYTV0ampFK1do?=
 =?utf-8?B?TzhadkNjMEZ1cU5LcU1OWGRnKzlteGQ2ZS8rcUc1aG5jTVBSK04xdUxtejJ3?=
 =?utf-8?B?UitlNW15Z013RTY4T1Yrdk9QR0NqRHpUOG1GaXlGZ2VQSEl0VEdPVElVVC9i?=
 =?utf-8?B?MEFubUxaQm5JbjQrNkJJTVIyWGZXYmdxb1JyY1JrZnQ3K3lWVlJGOGdFS3gx?=
 =?utf-8?B?ZWRTM2htZUdYNXpTK2ZQbUhLMUtYSkpVMkFaUXp6L0NpYnA4dFVncVdtTmUy?=
 =?utf-8?B?SjI5ZWdLV3lRY0RGWDJZZTZyNnFJYy9ra0x5NXdOTjNldHl6dVViNlJaREZj?=
 =?utf-8?B?R09pck5BS3dOTmYvcE1hTU0xMnVBcmdadjBmSjlQRlNkQWR4Q0lVVncvN3ZM?=
 =?utf-8?B?dUxFM1BXQ3hRbXV1N21NMGplek1FdWxtOXpKcG84cGpWZjdMRUMwMW1LdTcy?=
 =?utf-8?B?ak1FMnhOUWtiNVNuR0RRYks5S0h1ODJ1OGozUkg3b2J5OVN6R3BNT09DV3N4?=
 =?utf-8?B?RjRvN1FZLzVUV21FQ3VxUW5MQUtaSXF1YmlCSWMvQm5RK1NDc0VHMFNSaWZ6?=
 =?utf-8?B?MWxPN2J2bmR3SWZPVEQyektDbnNRWUUyMlFxblpBRVJBT25DQzJLczloeURr?=
 =?utf-8?B?ZGd6NTM4MDZJd0V3azJMZW1NS0hEMG8weS85R2RzV3J6azhhaDB4VVdaN3BZ?=
 =?utf-8?B?aWNJNHp2d3FGS1FuMjRxeEdzay8vM0Z1b0ZqQ3NSVFhPWFZpb25zcSs0TG04?=
 =?utf-8?B?UmN1ZFhTaXM2REN3dThGL2NZR1FzZmxsN0RINTlKTXRYbkJ5T2RQNjBlQnk5?=
 =?utf-8?B?UEQ2MG9TN1Z2d2VPd0ozcUVKOGJoN1RYejFvb005OXBBN2ovVXpTTEhLL0Vk?=
 =?utf-8?B?ZGQxYVpaRlZwOFVEWmV0N242WkEzM0tZYW1pb0xmYjBLbmQvWG83ZkUwZHJs?=
 =?utf-8?B?VjUyaDBWN0tBd1NrbXZFYUwyUGg1VHplSzA3d1BHZDIwR0IwaUFjUnhONitL?=
 =?utf-8?B?WkxFZE5kQTlLUlZNbGQ2SGxZNUE4aU93b0w4Sm0yZVJXaFdMZk52bTFqTDBB?=
 =?utf-8?B?d0dEcXJpamxzbDVOcGo5QzBGRWtNV2FSNFJIVDFrK2FNdUtWdVNJQm9hczlD?=
 =?utf-8?B?QVdUTUFaZmxjSlhGY3REeCtLbnJoR3FFUlQvMzJpY0cyRFZJM0lvVUM4UUxW?=
 =?utf-8?B?YzdWL2luM092WWZBcEFYTXE4SWxJZGQ0TW0zNGxmN0lBMjB1U3FyVEQ4ZnpI?=
 =?utf-8?B?ZGpkTkpVRjRWNHdnQ1JxZG1mRXdUa2luYmwycms3YUwxRXVXb1pxT1ZITm42?=
 =?utf-8?B?ckpzY1JmNUlOSkN3NE42UjJzQk9uaXVvMHc1UTVJMytXN1FtUjlhbUE1RnYz?=
 =?utf-8?B?R2krNmN0bW5mNG5mV2NIUlVNL3YyNlo2Nk9FcTYzaWJlR3QralQ1dDZLa0U5?=
 =?utf-8?B?eFcwQ2M3elhrczVhYThKRGNUTmZNMkpzcWx4YjQxQVlMeFFRRC9aSTJqZTZu?=
 =?utf-8?B?akMwSWFGaFhqYXN5c01ScGluRW9aZUtJemU2cEQ4ZUhHdU9mSlVDSVBkeXAy?=
 =?utf-8?B?cDdGdEZMdHRDcEV6dTl1WElYV2kvVzdJb1c3cGxOY29jQktiUkhDdis1K1Ju?=
 =?utf-8?B?YStkOUxVZDRsVG9USHMwaldBQnhMSzJNWmI3alE3Qk1ROGI5VUZSNk5ULzUr?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fab51d12-2999-4a00-93d4-08dd20468786
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:02:25.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWtePRAW8aAqc9eyIxubzi/skdA/X6ERkug+VUohKFPCCPGP8OoBCdvZ00Q8vdrGpRQ17fe4v2vgzz72Yl1i6CnWU0bq2WxTbTKgn6aL0F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 19 Dec 2024 06:24:38 -0800

(to the author of the patch)

> On Thu, 19 Dec 2024 11:11:38 +0800 Guowei Dang wrote:
>> Add page_pool_put_page_nosync() to respond to dma_sync_size being 0.

If PP_FLAG_DMA_SYNC_DEV is set, dma_sync_size == 0 can happen only when
the HW didn't write anything *and* the driver uses only one page per
frame, no frags. Very unlikely case I'd say, adding a separate wrapper
for it makes no sense.

>>
>> The purpose of this is to make the semantics more obvious and may
>> enable removing some checkings in the future.

Which checks do you want to remove?

>>
>> And in the long term, treating the nosync scenario separately provides
>> more flexibility for the user and enable removing of the
>> PP_FLAG_DMA_SYNC_DEV in the future.

Why remove SYNC_DEV?

>>
>> Since we do have a page_pool_put_full_page(), adding a variant for
>> the nosync seems reasonable.

Not really. put_full_page() is for cases when either the HW-written size
is unknown or the driver uses frags, those are common and widely-used.

> 
> You should provide an upstream user with the API.

Would be nice to see a real example as I don't understand the purpose of
this function as well.

> But IMHO this just complicates the already very large API, 
> for little benefit. 
> I'm going to leave this in patchwork for a day in case page
> pool maintainers disagree, but I vote "no".

I don't see a reason for this either.

Thanks,
Olek

