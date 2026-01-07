Return-Path: <netdev+bounces-247898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F002D0055A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2ED2302CB86
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD02C11DB;
	Wed,  7 Jan 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8aOVzfE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF023373D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825254; cv=fail; b=eSeXYYJEgdQhF0W9JTJpvzQPhJbLiMH68zqfbKK256gh0KvTVP8kW8hFhjgY3JP88M65cJ/CX7H6aGi//W7yLhzUZEK3+/crn6DLQnifH9pL9yAki/LfWXiE5vjWZMM64OgLr76j2pF7fDzk25UD1ONJjsucmNjTfBUOIouUIvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825254; c=relaxed/simple;
	bh=DtHYxvkfAE2rd0ZXirfId35LODjxHW6uFxgrt7BhX5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbRcCuEIl09YkEPGVQl1cZU02KJ1esGfqCLFYTDcCPrEw4NdS9ujHthcE2NlhYhFR+nBMTHiIvSezUa4I6xjAHaAoCvWxfdGplrH0Qces+nnfIW+ZfZrWj/xSieYLbUJ1xA8NbRWtV1BOaHjwp5yTgcrws5qBpO3jxTw5VinovY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8aOVzfE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767825253; x=1799361253;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DtHYxvkfAE2rd0ZXirfId35LODjxHW6uFxgrt7BhX5A=;
  b=X8aOVzfE5PynzHrPPmz7Icn1UjoTibYK8KTLas+3NsY0MjQ/QCvhQe+E
   caNy9PDqYjIZ60Aw1YGHst1OpRtTepTI1xPk8hPzjNLHK2TPhg8k4VrfL
   nuaaKjY2T1kBsiMJFK35mILpVCb8YJWDT7WAgkcMa+AS9P/ZaZ9dD3k8k
   MUMDJxQA3ma/h7M8/uyheC2tR41UPLmPwarhyVMErEYFHYoIPDfvGDCom
   qcRGeydiuFEVLJFYDi/v1HkHkGzdDIY4TeGA3spoXjMAePcY+KmGZwkBN
   ZRejGUk1X2uVTIFQXC87VOrw3j3qgCILg6nXzVw2gD4zpLCceS6AyeH0o
   Q==;
X-CSE-ConnectionGUID: yCTML+4PRlOrlLA4hgVcfw==
X-CSE-MsgGUID: 1c/GBXunSfeAkKjU5p9FTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79843285"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="79843285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:34:10 -0800
X-CSE-ConnectionGUID: iAxW/y3TSs+rg2Ftfl+uOQ==
X-CSE-MsgGUID: rTf+h+VIQW2e745EwasDEQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 14:34:10 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 14:34:09 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 14:34:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 14:34:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TA84QrT9quz/juzwz+4tG8rjK6BAn3PTuK84ARMyqJx/buKNWEPM0kukrcK5x8fSBWWDFADIzrns18W4lY57lBCakNNMw2B3D73kOTaLA/BiCYA61TR2+VnYfyXaZBZdPNgxcouu3JjaKL9Kd7ybPgeFw4R6x0DDrqj3DnvzuumhWgd6JAWZxWAZVdzjTQl7UDm5SMeuLkd7+jB8j/SiV0xaKnXJFOIO+swgYUaHVkRKYdU7L/B8hHWkEufVSMQeaVYe5JbOYlrCup6NSZkzW+RcChIpC0InlPX/ShrH4grsrlTN7gzISFjf9KCUxrvhHV2tq1RP/Sc01c+qreuxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcQn4RkLi90LCh34PkgZX1g9xckgGyBH9HQWycs//FY=;
 b=cH8QcgSMKHPVz7dumkveFE1wMCsFQzVIi9MWKpoNQ6/SAqiH10UQ0AybhiQ/qvrkUehYRbLQ1QkTLqun8RhZatuKzQ5LR/TNCQ+pP9Y7+Ab4+RttzgQO9Xkn92B0ZtUSUQ+AO4UmBPYVkV1z6t6qThkgVGyUu7vHPhbTk6ZJYYx/t9HQ3cc3M/Iygg7i95UCSgCSBDOZaTv23ONxFt7E4mWqLbwEOPWjKVvsWiRToaGqDOO81X4GHTZFzXDG+TjJ8vdGiUGIf/pw+QLbqDKCYxBg/gPHNV8Tb+JtjCJdKJfqCnqeY84iCgtvblrFQoNttlNU5FrsWywJMOqnku9Y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 22:34:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 22:34:08 +0000
Date: Wed, 7 Jan 2026 14:34:06 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: Eric Dumazet <eric.dumazet@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Willy Tarreau <w@1wt.eu>, Reinette Chatre
	<reinette.chatre@intel.com>
Subject: Re: [PATCH net-next] once: add DO_ONCE_SLOW() for sleepable contexts
Message-ID: <aV7fXuvIMNOP0Kp8@agluck-desk3>
References: <20221001205102.2319658-1-eric.dumazet@gmail.com>
 <aV7JKsNpsmnf5oQL@agluck-desk3>
 <CANn89iK72b5bSjq0MeedXJ5Onk22Pnw6cjNr0cAYP_-hv8RhAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK72b5bSjq0MeedXJ5Onk22Pnw6cjNr0cAYP_-hv8RhAQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f78b8b-c334-4037-f0ef-08de4e3cdeee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUF6Q0l0MjJYajE1TjVXbnZzRHQ2NjFtZndCVGt2N2VOYlZrbEZDWlFDVWcv?=
 =?utf-8?B?YXdvTVkzUzVzRjg5ck5LT3JhdXNWd3cyN3pPU2ltdW5IY0VEdFZKdEFCL0FB?=
 =?utf-8?B?bTU5NUxwMFZxZVdFdklXYWZUcU1nZ1E3RDhwSEp2NmdORGsrV0FJM3VWc1hD?=
 =?utf-8?B?ZVQ1WGJYMVFYbU9TU2o0V2NZREtHSmJOSUF3MEowUWlMbWg1QkszdnNRdmUv?=
 =?utf-8?B?SHpISWRUTnJxcDRpd3ZEU3JaeGM4SWZyK1EybjNhTFpaM1BRV0QrcnRqSHdL?=
 =?utf-8?B?NEEvUm41SlRYZmkxSzErSGxxRTcxa3UxR0lVc2M4SDd6ZER0WGlvZzZBNitx?=
 =?utf-8?B?VjVPTmROeUZkQkxIQ0diNnlzZHVKemlmdDhYcDk2V2RvZVVHN2RSODA0UUxZ?=
 =?utf-8?B?MnZPWFZKUDBzU2JENlM3UXNuMXUwWGt4cjdhREdvbmhqQ3QxM0JUSE1XZVY0?=
 =?utf-8?B?TjNqSDR3WGI1WW5UcUs3a0JERVBQZHdwSy8ydzJLZ0lRMG5IU3N5bU9WQ3F2?=
 =?utf-8?B?c3NiUWY5WmlhUk1uTkhsN053NXRzOXpLeVJIU3MrYlFNeDBaZE95RmRra1ZN?=
 =?utf-8?B?T21iWXk1MkJmb1NISEtCWTNQUHE5Q0s5SWtwV1FxMTRaS0lxaU5uQWZxT3BH?=
 =?utf-8?B?Rm40ZTNsNi9LOVB2d2hHYThjMWh5dktPZmtIKy9OWHpuUFVEWm5lbVVHTTh5?=
 =?utf-8?B?WU5VSW1ySUZwZGFGMHB3NkxhVytyM0pMbm5yTVl4ZXRtVC8vekpROU15S0RB?=
 =?utf-8?B?eEV2eXczdHJwZ1RmYkZ4VSsyaXM3Nm9jUkRIRlpFekRIYS9VVEl5VVhaSXJ4?=
 =?utf-8?B?MU5hWm56N0NMb0VVRXNiTHBqam5IUklkYjlpS0hJT2h3R2pyZEZ4U01ZVUlh?=
 =?utf-8?B?S3FXRUR1d2NaUXRpVGdraUpNMGVSYWVwQW42U0JKYVptOUVTRDg4Y2dXTFFk?=
 =?utf-8?B?WWJxWFE0THlHUzZsVFZnOG0ycktqM1VSS0pabi9leUtKZVgzdWh1dlhiZFZS?=
 =?utf-8?B?VUZ2OXFzeVE3S2hyMXhTOExvcXZsN2JMeFNVeUZBYiszTE4rQWdRTjFybVky?=
 =?utf-8?B?Tkd5clBCWmtDUUx3ZXFVUkFwMUhXditGSy9EelQrellxWERwN3F6MFpMQlAz?=
 =?utf-8?B?Zk9DdTNudEdvTjZCYW1sN3liY1dvNDFxcnprR1YrNGpTZEVoY0dYUnY0dDBP?=
 =?utf-8?B?bHYwK3QvTHo0Ky9yWnBXTnB6RU83MkRobFR5Q2k5T09BaFhiUE5HdEYvUTc0?=
 =?utf-8?B?cmJFaE9za1JxM1h0S2tvN2FaVkhuTDJwQlVHUWhId0VDTjlLY0dCQW9BVWxS?=
 =?utf-8?B?YmRKWTB5eDYxL29KaDlWWHlPSHk2T3paM3Uzblp2UWpoTmFTaXNHUDBxbHY5?=
 =?utf-8?B?aXNQVm5TdjRFRDF1ZmpVc3dUZVJ5Q0FBTkZIeUh5WW9jZGp0NTBpd1JYTlM0?=
 =?utf-8?B?VURGb2xDWTZVZ1ZmMnY1cnQ1NVphOGZDZWJSZ3hMTjZMcVAzNHRhckJ4cTB3?=
 =?utf-8?B?UTZlbGlvLzNlZExIeSsyNUpKbnlSTUwvZzhDeC9SRjdFenBLZEoyUDcyL3Jr?=
 =?utf-8?B?dVhUUzdXb0d5UHJLVkRQQUV1RWRiSDlhUmpqKy9LTGlGczhrK2YwaTlWeWFr?=
 =?utf-8?B?ZEJOZlJCL1gvWDVsNFF3L2pHSG4velBNNkNnYzFldWlRNThPVVRzcnNZSU9H?=
 =?utf-8?B?d01tUTNXS0pyUm5yQnVLTHdPek0zcC80OUlCZUlmNDl3Mjh0Qm9idUhBZEIw?=
 =?utf-8?B?dXJoWUt6eUpITGdhMFVhK1RyVDN6dkoxRC9GcGRwUVdlZGtxQWRtMnkrUEor?=
 =?utf-8?B?N1dYMG5aaHh2ZTdHd2NEM2ZUdjJPaXlUanBtV042MG5VdEFxYW9ydUFLckZz?=
 =?utf-8?B?QmtKV1pjR0RPYVlwMFQxRjBoQ3hQSDhyWmJ4cDl0blNDRnlPU1JzQVY5UFJq?=
 =?utf-8?Q?pC6KtN3lj/rIhHi7sSzZybRBZYQW0zwL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5ZWDZqNndRNGhUUUtKN3IxazZCd0FFSUZacVZnZmV6b2R4Zko1YnFMQzB4?=
 =?utf-8?B?QzRReUFEY2VheDRFbXFFamY3UCs4Q3hmbFFJTG5mU3VMWGs0ZlBDQVNjL3FE?=
 =?utf-8?B?SHUwanNSSWM2MTZKbEtWRUxKTzB1RmVSVTJiMWp4TUhURkNCYmo4NFlLYVJa?=
 =?utf-8?B?bml1cDNCRkdwQVIvQjg3R2JjRHhHZk91WEJxcnNOb0FkeUJSZUxRZGcySkJY?=
 =?utf-8?B?REtCMmdGeG1FNnhYMXNsaFp2TU03OWRYWkl1Uk9ySFZBcDYwZndQaDFwUExK?=
 =?utf-8?B?WUYrMEhhWkpaYjcyeXZTSlZ5NVk1clRUUlBuOGpWT2xRMmV0V3BpUklHWERt?=
 =?utf-8?B?Um1ka09ocWZTMlVvS29yWWRsM3RzOE9YS2lEM3FJMDQreDVQa1ZDalMzSGlD?=
 =?utf-8?B?TVkzQStmbWRML1k2Tk1pQkhzeGMrOFIxSUQ2Y2NMbUJxODJQQUVVWTN6blN1?=
 =?utf-8?B?Y2k2ZlpxMFJ0M2VKaVk0Nm9vTEJjV0g5TUQ3eElJeHV6bnU1Qjl3NlBCWVZU?=
 =?utf-8?B?YzJidHY5cEV6Q2plMnF5dXhOd0R2NEdvU2tZRVJsSWpIejlYVktNT3FRRGZV?=
 =?utf-8?B?SzBCbVF6UFJ0V3AzNUo3OXJQbDRGTmtGa2F5QVdteWMyMXNhSUV6UGdvdXNo?=
 =?utf-8?B?cFViNk5oUS80YVNMdFl3ci85eTh6UnlNM1ppdHBUM3BsTk9RZzRkdXJWc2pQ?=
 =?utf-8?B?ZUdEN01yNFAyQ3JWMm05S1EvME1SMTQxblVabHQySGFHSWV2N1F0MnA3a25w?=
 =?utf-8?B?bFpYd0hkQ0Q0MjdwcGtWY1dlZ2ZnMnVpTzQwRm1qSDAzbUsvQUZnQ1E2RU1k?=
 =?utf-8?B?d2Rnc0d0bTV4Ym40UUVOdUx6Zk0vV3AxVlo3dlRESC9yeHpZU2VsRXJkUjZH?=
 =?utf-8?B?K2p4ZC93UllqRnlySnptdS85dUdrc2ppNG9nT3BLZnUzaUJydGFWUEh6ZTRm?=
 =?utf-8?B?eW1aWGdiVnZzUTJuSmZscGZVSkp2ekpsUzZiaFRmMkwzRThyMEc2Y0p6b3lD?=
 =?utf-8?B?YWJiUkFocFJ4dFRMVE5nQTlpL2gzYUpuSGwveEpUaXNxeTdxQ0xsSjhXMHBt?=
 =?utf-8?B?QTAwV21nTDZxT3NZS0FpNU1yZlBMNmJCb0NKekpob1NvOXh1Yy9lOWZaRXFu?=
 =?utf-8?B?cUNaY3c4V2wxam50d3BhYWRyWjkzVE0vSUluak9ONlB3NGdZV2VSQVg3WGVr?=
 =?utf-8?B?QjJnK0dNSXJKcFY0T3owSHo4RTg5S0svVzU5Z0RXVUFQN21lU0Y2cTNsMHUz?=
 =?utf-8?B?T1Axdy9aUXVmQ1hiSXJ4Z09OUWxNZVUyd2hEYTRkdDFmQ1RXK2ZtL2cxQmEw?=
 =?utf-8?B?L1FuR3l4aHpnbVphT3h0bjM2ZFgvamVxc2FSeXBwMTd4RDdiL1oxQUZFenRN?=
 =?utf-8?B?Y1VnQkljMVE4ZXhsVi9PMWx3MHg2aCtwSHJISERXdDc4T2VxdVhvWUwvdmJ6?=
 =?utf-8?B?cnlsYjRtTzJqdmxmT0pTbnVFbE1jb1QrVkJySDZSQ2dGZXQzQ1AxTXVaZk1D?=
 =?utf-8?B?SWNCUWR4UTRHdUlXZDlUZHh4QkhEUmNhMHNnQzBOM2JYeEpQN0RWTUoxY09v?=
 =?utf-8?B?MllscFBSQkdNOE5hcTBIR3N1czk5aC9jSFdYdTF0bTc0cXJwaXNYdVpMb3Ji?=
 =?utf-8?B?STVueHZ6Y0lCSno5cW5DZ2xrN2lvcU1nbWtKKy83YVQ5UnpoRTVRakcvQWFh?=
 =?utf-8?B?NVowRE1hWUN3QjFERW1nSnE4dzQyb2U4aU9PTk9KQUdHaG84R1pVUzk3TVhw?=
 =?utf-8?B?cUhETk5VNGdLQUZvUTRrQ2xQb2xZdUJiZkJZQ0NhcDJZTXJDb2xBTXEzZnhz?=
 =?utf-8?B?MUhJMEM2WnVUdGZUZHl3VXJUMThzMXlqOGRtQUJSQW5wbDhIWFNmeUhnS2lN?=
 =?utf-8?B?VlJQUDFSTU0vc0xiT1crUlJwYzFnSXR3NmNXa0xycnQxcWxYOFRlQldrMGw0?=
 =?utf-8?B?NnNvdndrZWlSV3NCTk5jQVNKRHhPdmFjU3J2ZXYyVmNCYnNXVDUwcTE4WmxS?=
 =?utf-8?B?eEpVOUNUbmhSMm9wUkUycWpLVFloUVRMUytYSEFncVcvZkNnQVBBenBXaExv?=
 =?utf-8?B?bTltRm4xRGJGUjNGLzkrVThqUm9wY0FPdjhjMWV1YjZiSlFaSzkyL3Y4dC82?=
 =?utf-8?B?NzZxVitldVphWkF4WWlHeGtvcUg5dlhWRWs1YjFoZ3RpWDJUOGo1Zi8wQTlO?=
 =?utf-8?B?VnZSc01xZ25BTW04UmpPUkcwWngxajdJZlRPV1JPWWhESjQrWWdod3E4eTJI?=
 =?utf-8?B?Q0YzT1lIQmFnTjNCNTNrNWlHZ3pyVlVzMmh6VjIveURKMkI2V3M0WE02Qll5?=
 =?utf-8?B?K3ptVFRNQnZjVkFqdXB4bUhITE9rVFM1ZytOTXNsR1MyNDlqLy84Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f78b8b-c334-4037-f0ef-08de4e3cdeee
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 22:34:07.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfKJnzHIr2tP7KuLXKs9o8aJwHAulSu0OstIiXzsrGBFszHdH4Spcnk0bPipXNfzkZVnWvpX8oviZr40WQbcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 10:17:52PM +0100, Eric Dumazet wrote:
> On Wed, Jan 7, 2026 at 9:59 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > On Sat, Oct 01, 2022 at 01:51:02PM -0700, Eric Dumazet wrote:
> > > +void __do_once_slow_done(bool *done, struct static_key_true *once_key,
> > > +                      struct module *mod)
> > > +     __releases(once_mutex)
> > > +{
> > > +     *done = true;
> > > +     mutex_unlock(&once_mutex);
> > > +     once_disable_jump(once_key, mod);
> >
> > This seems to have been cut & pasted from __do_once_done(). But is there
> > a reason for the "sleepable" version to defer resetting the static key
> > in a work queue? Can't we just inline do:
> >
> >         BUG_ON(!static_key_enabled(once_key));
> >         static_branch_disable(once_key);
> >
> > > +}
> >
> > -Tony
> >
> > Credit to Reinette for raising this question. Blame me if I didn't spot
> > why a work queue is needed.
> 
> Note this is used from one single place, one time...

Boris pointed me to <linux/once.h> when reviewing a patch with open-coded
"do this once" section. So there may be about to be a second user. Perhaps
more to follow as the DO_ONCE*() macros look to be a very neat, concise,
and obvious way to call a function just once.

> Why would you care ?

It looks like unnecessary overhead, but I wondered if there was
something I was missing. Some reason why the SLEEPABLE version
needed to delay clearing the static key to a work queue.

-Tony

