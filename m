Return-Path: <netdev+bounces-128391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0149794ED
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310B71F22AF1
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BEB381AD;
	Sun, 15 Sep 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRR+SIv6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226D2E62C;
	Sun, 15 Sep 2024 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383839; cv=fail; b=g1y18G/Df9usAsPaxJu2aXl8c8HryFaZFtrPeOdXuYV3y1OEfZiRUS61G/qt8PgTtaEFHQF3Q1uqbcXz9X81+lOiFNxcK0zt5U4gdy9o8aWFZcc5fcKA0dDt6m/baYpaQ8mKjFJLDqyUgmf+kUvrC2dDgFsVAg6ThyWlUDLH5VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383839; c=relaxed/simple;
	bh=qUaHwXosy9gKDccneiH4XII07iIMGSWKDLa/0khkuv4=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Gd3t1LNPtWHHKjfLuMoQEnka11l80KxrfnepduOvA4HZecWZUAQT2lynZ6deI5gwmqOhkDcHzRlb0Kqdv0xOv1EBLcEYDFGdDj2GH70aHSoN58Dq1qnGwkogJb51UfdWVHLPPrqcG5UdvOzT4ZT6QyXotaPRQ9ardS+hVR2vCNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRR+SIv6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726383837; x=1757919837;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qUaHwXosy9gKDccneiH4XII07iIMGSWKDLa/0khkuv4=;
  b=DRR+SIv62KPGDlJs83zfzwNxjsCHMj1j9ZNnB5xCvau3IiHUI+QLRNZy
   igkdp3fGuGGlD9Es4fdLWslO1Me0q3EQtGTuDhbX79nPcIRYPkjnOPBw2
   8P9eIESashOb6t/KABTkMCDitIP/WiRht9Zj+X57S+IQgOJtmeOhVJBf+
   neyW9jBUoZC2IfzFlkkjpaNDavWkWiYFexjl+5ZVXYVH5FgdF8+meCmqy
   +DdFp+I0utqOF+TivMsE95rxixU6Ddkeod49SLJphHD45tnIxeV3y2ZxZ
   mnCSjsaDEBqdCLXMrbNLkw+QpGClIZsLAaZTeDHNnEJZLrGcC70g+VN3V
   A==;
X-CSE-ConnectionGUID: qXr6NBRARDyk3G7avOAGUQ==
X-CSE-MsgGUID: rOaI5Sy4TDqPZsLI6+Qp2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="47754499"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="47754499"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:03:56 -0700
X-CSE-ConnectionGUID: N5552g/WSsqvJoxUPuh1XA==
X-CSE-MsgGUID: w6sHWZJZQQmmOCurTqxTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="73317125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2024 00:03:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 15 Sep 2024 00:03:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 15 Sep 2024 00:03:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 15 Sep 2024 00:03:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 15 Sep 2024 00:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uunvtt/BhEQbp50e/Omt6B38Wn8kuuJAu+JAVackT3r1QiObIWJmIt1RWjXDoqoc7xmjFxR/foZ+a6GU33BaOR1yZ/mNGauRgk0XAWLOv6PVo2aNpbsHsv5mtjrUuvJ9euV3evCecuOy2EPvWFjNSKmQ2diRzECZQt3765F51qodZZRK5LJhBjuLAvKNydTrJCzXMc/Mq2LCUsTs7mWW+J6a7UT8gDU0IjHqCLNkdCzyP0Qx1DE+0J7ijNuuhKYFNUpBbQuPDoFQI17EtZXVLveAh6sUp9cCcACeG3keHR+O6boZJ0AaqRlamYr2TrO9m9UiW2ajJq2RAbNAhyXqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAMA178h90qGOnX63m7Y424Xu1Wyo++bEJg1iSLC7Dc=;
 b=kgSzFjgpDImCTp+frvMBMnhRmffJEKCFpPJQBeeT2VR7PiKMc+CtBbVEAd1IewxEfnHWF3jy8VfB0PZ4aOC2ByRQ7dZgQAQiXNn5c5LTbHhXh0rhRXSYk0cWrVBnhMTghW3YNciXUmqvew/GzQPDmkCoToYTOSzUaQp9KiTAQhtbUrl3+cc0inlVqhz8fgRRu6pBwYt6HUlq9e4ZjG2AqFoF/yFo+ro6+zmmZFVAfoN12cGhrn3sMqfjcOF7hHVB4DNsNx8f4/y5ykAqais2vh1LP9CrLq+XXa6mLYMLsHZ0plSy+tSjcG4+xO7uRaiHwTAn9wMQ+VXdO2B7j5bWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sun, 15 Sep
 2024 07:03:51 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 07:03:51 +0000
Subject: Re: [Intel-wired-lan] igc: Network failure, reboot required: igc:
 Failed to read reg 0xc030!
To: Jesper Juhl <jesperjuhl76@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
 <CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
 <20240912083746.34a7cd3b@kernel.org>
 <CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
 <656a4613-9b31-d64b-fc78-32f6dfdc96e9@intel.com>
 <CAHaCkmfkD0GkT6OczjMVZ9x-Ucr9tS0Eo8t_edDgrrPk-ZNc-A@mail.gmail.com>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <534406c8-80d3-4978-702a-afa2f33573f7@intel.com>
Date: Sun, 15 Sep 2024 10:03:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHaCkmfkD0GkT6OczjMVZ9x-Ucr9tS0Eo8t_edDgrrPk-ZNc-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e21298d-64e2-4e31-2ba2-08dcd5548dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU9WVW1YTHdKbmp4SjkxRjlya2VtQXptZVlyamRYejRwR3J4QUorSzhSVm4x?=
 =?utf-8?B?WHUyUERYMnVvNlB5cVB0ZWpFd0gzMHJzbXpadDhHVUJ0T0RXR3loU1M1STFE?=
 =?utf-8?B?WjU3cjN0YUF2amRaQ3hzaGNsSDI2bTd2WHVrWXRvTHg1T29Mb1pacWl2QkJw?=
 =?utf-8?B?bnRRUC8xcjVDYnJtSnJYTEo5R2xKeEc2KzdENm9nSGlMSjBFZGN4UXBSUzZ4?=
 =?utf-8?B?QmxPNTRjSVpJWG1oKysybVEvUDN3RS8wbFVWV3pyZGF1dU9NWDdsaGJiTUJw?=
 =?utf-8?B?M1VSZndiUk12NWYrRk5HQ3JCam9LcUxmbUxJV2pUa2FVQkJHeFZHbzVuOUEx?=
 =?utf-8?B?eFVac3p4SVlWbExocFdILzBubHBialNjd0lMdVRraUJFNzFGWFNObDZoVUVI?=
 =?utf-8?B?U0VXalNYQ2hQMFRkVzNmRFpwcHlyQXltakE2N0hPOGZidkZ1ekJmSkZtM283?=
 =?utf-8?B?YkphOUpLVVdpVVUrOGhOLzlRK1ZiQWV0RGdSbzJXVmZ2VzVDZWlrOWlpTjhz?=
 =?utf-8?B?anpRSGVweEF0Vyt5bXdlQ1hLQitZY0VyWkE2TTYwNkNKZzNnSm9CaS9vek1P?=
 =?utf-8?B?cThQemd5K0dkbjNOSWI0aFJtcUpSUWFzL2JJWlVsd0x2TlJkY0txUUxrRTBE?=
 =?utf-8?B?NVU4eGhLVHdVT3dHaVI4WlB1MmJ1aEJDOTQwQTVaUEQrL1Z4RU5yNFJ5bGdB?=
 =?utf-8?B?VHU4S25GZVRXdGh1TlRsTDhvQUJ6TVQyZVlYSGZZQUhZMGxOeXBIanRzNHpi?=
 =?utf-8?B?SFVlRlJScEFpdDBnN0lTanB3OWdXZmJwOElRSHp3VmFycHV6NkUwdDhZTS9X?=
 =?utf-8?B?b05kWC90Q3pxMTQvajFkUDM0MVpVbkFYTlNpdFlFKytsSGVJTjN5VjM1QW80?=
 =?utf-8?B?Z2FhclhkY1NYMllaWngyZjJ1bkNrMmd6eE1wTkxCMWF5cDN1REN4T3Bab2U0?=
 =?utf-8?B?bmVNa1Z5VkV3VkFCRjdYMWMza1JRRU5yeWVKektYK3p6R2JlZEtNU2N2REwz?=
 =?utf-8?B?WWUwTnYwMlBkdnhieXdSKzZyZkpSVXNnUWZZVjRQcTNvamR6SWZjZ1oycXpx?=
 =?utf-8?B?bE1tZlZwOVJnMmRqSC9KRThJcTEwS0IwLzFHR3RkU0djM2NJRy9rVzJrcWk2?=
 =?utf-8?B?M21UZ09Dd3k1Y3RZOHU4aEhHdEh5REtZSnhoWk00ODQyRTZ6dDB5WnE0dTha?=
 =?utf-8?B?MEFyWlBmWjhudmhHSTc4aUl3akdvamRXZTRULzVlck1aWG10akQ5VEZDV0o1?=
 =?utf-8?B?eXJJN0NSZ3pMUWZqTi9oR25YK3crQyt3MVlOWGFzTUhrUk43UWFXTW91UE9I?=
 =?utf-8?B?OGJuUHh0LzI4QUEzUytQbzJSOGNmNngwRlorTjB1d2trSEZ4Y1pQWUZCWWJl?=
 =?utf-8?B?Z2ZWTldaSTNtVDVIREdBdVdrbXlvV0hVMG04NkhhbC9WZVJWV1dkWUNDb3lG?=
 =?utf-8?B?MjYra1dOUUpMRjdPb3k4NEJKcGVYLzVJclBWUWZjVFk0N2liaklucldVMy93?=
 =?utf-8?B?WXN2cmRGQzFRdXl3ZUtIZWpHNmZxS1E4dzZTV215dkIrckJYSmdXaUNFSFVx?=
 =?utf-8?B?alE2REJ6Rm1JREV6S1VySUVNYzdHekdSSnBzaE5DQnZoclZoV2p5WDlDbmEv?=
 =?utf-8?B?cHNsYUY1UGJaVmdEVm5hc05KYXRWQWYvNU83TW5PMjY1aXM4N3QydmYwNUhQ?=
 =?utf-8?B?S0N1V3RxVWVnY2VoZklrSTBOUnZkZGdzTm9CTWYxczYwcGlGcklSZGpudlpt?=
 =?utf-8?B?b0dMb09xNUZVTmM5cmZlbnErUEpUSkJFZlRUMlpNdDZpYndCMkJ0NGtsMUhw?=
 =?utf-8?B?aTlmV1RvR01WbGFrbTBxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRVbFZja012T2tMemdzZ3FYazhOVjM0eE0xV2FEYmVlcE5EaXNadHN5NWMy?=
 =?utf-8?B?bWV5c3k1S0pjbXBYa2V1UEFuSDYzbWE3ZXlEVjZ6emlKUEtjaHlQNW5ESVF4?=
 =?utf-8?B?aUtKT0loM21aUWwrWDVxR3k0WTRWcUE3bjhjOEVCMlN1YmxPRzA2bDJkcTFl?=
 =?utf-8?B?UVZZNVk2YkZwYXFNR1k0Tno5WHZORkRyQXkxMmVscHV6K0VoMFVRQ05TRWVm?=
 =?utf-8?B?a2VOYUYrQkh6OWVMRXJIQ3NDREJXdTdBM2pwbytUZUROWENOWFVqMmdlaXZO?=
 =?utf-8?B?VDlpVVVvSUt5QjlMc2tjVXp0SnFydXZJZEZsK05Gak9BQWxIcldqY2dlNCt3?=
 =?utf-8?B?a1ZlOXJoWnJneS9MS0RCYkVHUDRZL0hjYkN6cjltZTdrSHJWT3UzbWJUZzJK?=
 =?utf-8?B?cjFMYWhYeDJVYTRjY1JZNytWb0ZNYlN6YTJKaERXZG5nL2RReVVPU21ENkdC?=
 =?utf-8?B?WFQzK0tTMVpsUXlOcUFsWUx0bWpGTFE0T3pTZFFmalgxY0poN0dwT3V2bVpz?=
 =?utf-8?B?S1dQekNyS3A5NjRqaENTZFRyWkhrWXF4MWZnRDg2aHRKYU5mdVNHSkRzeWZo?=
 =?utf-8?B?M01Xb1kxSmlhaDBZcDZLamRRdHpCN3JaNlB1Y042SXB3YWtCa2RDejZkTnFp?=
 =?utf-8?B?ZDVoaHp2WDFGSmZxL3BiamVOT2FueG5PM2tuQXR0bTNralliSDdFbXhvaXd0?=
 =?utf-8?B?RXR0cS9Qa2NIcEhFQ0oyVVpldFJqRlIzakRhS1l4YWdpMGI2QVFYSlAvWkdJ?=
 =?utf-8?B?UmxHWE02SXpZcGVxWUsyMGJHR3J6UWE5UjNDcW96emYyNjd3T2FGSnhUMzBT?=
 =?utf-8?B?K1FVUVovY2dETHpPNXpNbDE1bGZnTGJkZlVmUWhUTTMvWFdTc0hBSE5SeXpS?=
 =?utf-8?B?amtTaWpaQ2s1SXBoTnVNQzlmNXVSZlV0S2ZOd01zNG1jUHpJZWQvNkE5SGhk?=
 =?utf-8?B?Y0c4Y2FjS1BJTHMrdmRIbS9DOEMzVE80NDhsK21UR0xUYVRjcVhTU1J5SEdS?=
 =?utf-8?B?dUE1dVZhRXhYSzRaWm1PY2xzWml4YzBvOHZwUmRzcG9iaUdZWHRobUhKYW92?=
 =?utf-8?B?TFNHekVmcWQ1ZVZsTldRN0RFQ2ZKTmVWR3VSTXB2T0NFRHhCKzMwenJoT2cx?=
 =?utf-8?B?K2IwaVlyWmIrN3lvaEFMbGtZWkxiay9mTTJ6S2drYk5HSUpndWtDZlZ6TFAz?=
 =?utf-8?B?ajcza0Z0U0dCb1ZOUHIvd1JyZCt6QyttRUVSVGlCcnkwUVRsbkYrdk9wQjNi?=
 =?utf-8?B?QUJVRU5Od3haN2prRTUzZVFUV05GN1RaZHIwakViTG5NY01tOS81QVFCa2Ri?=
 =?utf-8?B?dy9QQkt0TkhJdG9pNzk0U3orQXZoeHp6MWFmeXJWQW5VK2tyaXJPVCtzb0J5?=
 =?utf-8?B?Z1J6R2lTVHp0RHJzVFJjdWM2a0RGYmFYZm1SMmNSb2R3cEY3bU9OL1g4ZThX?=
 =?utf-8?B?UHR3Tjk3aDI3OGEzMzFER2NNajdta0NiTDZvRnlDdEdUWExubU9ObTVnQ3FE?=
 =?utf-8?B?TEFaZ1V6VEFBZHlsN3ZPUFlIbFBJdWl2UDdTeDIxckNjL0NsVEhNcWxrcGo2?=
 =?utf-8?B?d0ptQWhNNjRWdGxXTHFEL09oQlpHd1Y3alR0WUl0QTUvOStxQXltelIyVEdn?=
 =?utf-8?B?bkgrYkNIMWhac0p2NmpKV2FzSEhKS0hyYVBYM1pEbUpBTGhmYmJtNk5KYXVF?=
 =?utf-8?B?VEdpY25hQjRiRlI5UzAxL211VnpXUE83cTBYMHhQSlJyN0VPakZaRHhFdWVj?=
 =?utf-8?B?ZFM5OWFzMTNBU0R3ME5tbjlSd3Jrb1BpUWc1L1V0Z1FJYjFGcDZKUHdtZVZB?=
 =?utf-8?B?enZHQVpCRGdvVEJrZVRUWHA2QVZUcFhjOUQveGlTRnE3VFBMOWdiWk5zNFFR?=
 =?utf-8?B?SmZKWEtCUHplUFZtQjEzN2x1SVlucnhZb3pZYlJyOEZWeUxqNEpZelRJaURI?=
 =?utf-8?B?bkJURDVvL1J2TTUwTDFlcWdJL3M2YmdkN1l0M2QrSktBRTRYd3JFQnRPNms1?=
 =?utf-8?B?bGtxbTJpWldRcURsRHoveVhIaEIvRlZxNXkvSEVSb1poYmxXbzQ4RzRBRkdD?=
 =?utf-8?B?SUZJQWttTzNQMnBZb1Nwdm9WR1pxcHMvMkl1TjBrbmNVQXdTZldmM2ttWTM4?=
 =?utf-8?B?UWI4YXYxY253dS8wTk03blNCOENWMldhdVFxb2FSS1lWeWlXa0xETmZiNHJW?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e21298d-64e2-4e31-2ba2-08dcd5548dff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 07:03:51.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS+XmFcmOhMkTf1H6e0UmPjBh2O5AGTXwktlTEfx/kR/TooxUJx31Rfx5uDGd1kcRYf8ncl/CQita+KcrY4XFzeKl33tekdB2dx4Gj2g1ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com


On 9/14/2024 12:52 AM, Jesper Juhl wrote:
> On Fri, 13 Sept 2024 at 09:02, Lifshits, Vitaly
> <vitaly.lifshits@intel.com> wrote:
>> On 9/12/2024 10:45 PM, Jesper Juhl wrote:
>>>> Would you be able to decode the stack trace? It may be helpful
>>>> to figure out which line of code this is:
>>>>
>>>>    igc_update_stats+0x8a/0x6d0 [igc
>>>> 22e0a697bfd5a86bd5c20d279bfffd
>>>> 131de6bb32]
>>> Of course. Just tell me what to do.
>>>
>>> - Jesper
>>>
>>> On Thu, 12 Sept 2024 at 17:37, Jakub Kicinski <kuba@kernel.org> wrote:
>>>> On Thu, 12 Sep 2024 15:03:14 +0200 Jesper Juhl wrote:
>>>>> It just happened again.
>>>>> Same error message, but different stacktrace:
>>>> Hm, I wonder if it's power management related or the device just goes
>>>> sideways for other reasons. The crashes are in accessing statistics
>>>> and the relevant function doesn't resume the device. But then again,
>>>> it could just be that stats reading is the most common control path
>>>> operation.
>>>>
> I doubt it's related to power management since the machine is not idle
> when this happens.
>
>>>> Hopefully the Intel team can help.
>>>>
>>>> Would you be able to decode the stack trace? It may be helpful
>>>> to figure out which line of code this is:
>>>>
>>>>     igc_update_stats+0x8a/0x6d0 [igc
>>>> 22e0a697bfd5a86bd5c20d279bfffd131de6bb32]
> I didn't manage to decode it with the distro kernel. I'll build a
> custom kernel straight from the git repo and wait for the problem to
> happen again, then I'll report back with a decoded trace.
>
>> Hi Jasper,
>>
>> I agree with Kuba that it might be related to power management, and I
>> wonder if it can be related to PTM.
>> Anyway, can you please share the following information?
>>
>> 1. Is runtime D3 enabled? (you can check the value in
>> /sys/devices/pci:(pci SBDF)/power/control)
> $ cat /sys/devices/pci0000\:00/power/control
> auto
>
>> 2. What is the NVM version that your NIC has? (ethtool -i eno1)
> $ sudo ethtool -i eno1
> driver: igc
> version: 6.10.9-arch1-2
> firmware-version: 1082:8770
> expansion-rom-version:
> bus-info: 0000:0c:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes

I see that you have an old NVM version, 1.82.

In the recent versions, some power and stability bug fixes were 
introduced to the NVM.

These fixes in the NVM might resolve completely your issue.

Therefore, I'd like to ask you to contact your board vendor, Asus, to 
update the NVM to the latest version.

>> 3. Can you please elaborate on you bug?
>> Does it happen while the system is in idle state?
> I don't know. It might, but I've only ever observed it while actively
> using the machine. I usually notice the problem when watching a
> youtube video or playing an online game and suddenly the network
> connection dies.
>
>> Does it run any
>> traffic?
> Yes, there's usually always network traffic when the problem occurs.
>
>> What is the system's link partner (switch? other NIC?)
> It's a "tp-link" switch: TL-SG105-M2 5-Port 2.5G Multi-Gigabit Desktop Switch
>
> Kind regards
>   Jesper Juhl

