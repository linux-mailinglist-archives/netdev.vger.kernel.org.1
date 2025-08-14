Return-Path: <netdev+bounces-213622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87672B25E92
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934D91C86B6F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63642E2DCD;
	Thu, 14 Aug 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pw2i6Sz1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14622D78F
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159458; cv=fail; b=U4h6eHZLnhifRj6StImLylESGsTgB3cZGsuOA9niJuqzb+jvaN586+G5JGnR8tFzHaB+pcgoALeop/3ypCf+tZ/mxE6DjwE6V/j7aZZ2hHdwC1vF6+AlIRz1cjDi0Lh726TKWqPAq12VTmBLsn7zzP/wC1e4styFuMk6/wHOjZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159458; c=relaxed/simple;
	bh=m6P4ZgSi0C4O+LovFB1AjOuvdT7s4LvzpC9VXLvsg2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7fDcXvDu2fhYQqMrTiORSEQ6uM0dXnsEmH6fVA72jtSDq/PBwQrhkpLbqkOQuyArLzm+geK9tiWYvnWZG1Kj5fUaSKXWSh7Gv/VeqoMn3dzg24OinPxwamiOKc0W0RBAc3N6v0IQR5fqfkEH/9kkh2BL23zU92II0OvzlfDTPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pw2i6Sz1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755159457; x=1786695457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m6P4ZgSi0C4O+LovFB1AjOuvdT7s4LvzpC9VXLvsg2A=;
  b=Pw2i6Sz1wKherAei+3ySmG5CPTybLraDQqYrZ5IeKEia5KfIleXxTnwt
   x0d1pXWuf0GZld+pptjx7KMWns2yCI4LdGF0P86QMx+D/qEJBBy5mqSYm
   CDK4bEiWrmBLys07uuyJtQ9dNzE11GTSgIijR7ZIz/13eQ8f4qByYS8zX
   6doTSwBTehD6G1zfuKa0wpi7/t0UDuaoH5Yp62krPguKl68dwEhQIOW4y
   fqqnBqKv028maJp6kMteCG5cyzpIhDrZxQgMb7BxfUfno+NfN2AKHPnWF
   XkMJY6Lnm+Nh2LyyaDrrPcFbRDNGe+iuGnlfBL6BejL+FDKWfWkAfgzEd
   g==;
X-CSE-ConnectionGUID: TmZr+KfURuy/L7Mt7uOo5w==
X-CSE-MsgGUID: UIQx9pJ/Tni47mjaZDTDgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56677545"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="56677545"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 01:17:19 -0700
X-CSE-ConnectionGUID: I9BKFjqCRPCYdde35ror8Q==
X-CSE-MsgGUID: /doGlSGcSfymrdff2OyH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197691442"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 01:17:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 01:17:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 01:17:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.76) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 01:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULKkHWYAtjO+4mdnPxcxQL1xBS4RGtchg4ZV391Li42qvR67Zjn8tElSBVOvNJ9ynHVC4wLIcPBTsM2APZqLY7NEBLBREzx8da9Rn4qyjzWCWTZ/si4fYF+dUBF5DReLaChb6VU8eU5+cC+8aKtxdBjDI5sPMdhaKB8vJf5IN4kWeWVkLgOhmYqFBvHSFm2Ctb8ZypdMPVdv1KdJ7k9SpO0ElNl8pFZaUFjOuUdrQ75PrhOlkrkJEgtiGsgpGqWB8Q7MhX1IXKKFPKGtVXIBpnMUr8gEgVZPA2/6No0qz24ZW7sUpF7gWgN1d1rI2nQnEwELfHOe10nJE0Szvi51/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFNU0GDre6MkJFquXv+L/1H2UfwivFHgdkKhEhTxvBY=;
 b=k38vn1mufuLHXFCuf93ys+DJIQ5TIivjtbj1e3lsEtTgIbEjlqs5G6ZUvfzxtLHeuIAteiRU/zwD0n1DfcaUi9av3w28UMeEvx5aivkzsttKj2TsbT5hvePQPROtRUoKqeznVDk3vrxpX3JTKCZMhkZw9JiZJPhcos06/anXqwJDyUmQ24nqaHMClPuEWg5quX4oPZk1YQG0HgNZ9X0TUbvvM2vX2LmbnXwmn1tx/8dRhPbP6ckd0yOZMz24e+Xq+8wY4YWTKnbBdU991opyGwLpGpBSj944zK7bQqUf5cWlZml35yB7DmKjG8Ax9f46o8+X4D8XeY/WWEdmyelGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 08:17:05 +0000
Received: from IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::c08b:cd53:5bd7:7784]) by IA1PR11MB8152.namprd11.prod.outlook.com
 ([fe80::c08b:cd53:5bd7:7784%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:17:05 +0000
Message-ID: <5b196a7e-1992-439a-9407-30c1867bb9ee@intel.com>
Date: Thu, 14 Aug 2025 10:17:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: cleanup remaining SKBs in
 PTP flows
To: Paul Menzel <pmenzel@molgen.mpg.de>, Milena Olech <milena.olech@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <richardcochran@gmail.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20250813173304.46027-1-anton.nadezhdin@intel.com>
 <ad9058eb-f1f9-4c38-b04f-9761121a48df@molgen.mpg.de>
Content-Language: en-US
From: "Nadezhdin, Anton" <anton.nadezhdin@intel.com>
In-Reply-To: <ad9058eb-f1f9-4c38-b04f-9761121a48df@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To IA1PR11MB8152.namprd11.prod.outlook.com
 (2603:10b6:208:446::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8152:EE_|MW3PR11MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: a5db0e1e-4bdb-40e8-a803-08dddb0af469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXdHS1N6ajhJczJtSDdMOHBWTzNNMzB3NjJZNVFKK1ZSNkxlcEFlL0dDLzJD?=
 =?utf-8?B?NVduaHFyc1NBYkJLaWl4dUNIVnBhcGhhNGxFakMveTJYeEhsbGJZMWZ0UUMv?=
 =?utf-8?B?R0tsNlBDSmxiU1FaQXU3WVhJbTlPZmU1WlMwazFXQVRBUVZ3N3JkWk11Tk53?=
 =?utf-8?B?OHIzTUg1SFNqS21IbktFSWVlNmdKNVpwMWVvMXJqcFd5aWE2RzJ6NWVOckNQ?=
 =?utf-8?B?Q01iZVRkZDR1Lzkxc1E5eFpCZFdCNW5JVml1S1QzdytjaGpxWEpKc2NrakFh?=
 =?utf-8?B?THVtK3BjRllydmNaeGRHVUxieWlXU3kveWJRWnFzeHBWVllCUTlTd0FmVXRF?=
 =?utf-8?B?alUzeTdWRWlOTkhiR2JKbHBtZUc1ZmdjcVpOTWVJQ0doRmRmR3pSWkR2VUc3?=
 =?utf-8?B?TzlOL3BoWTlYeU9iZ1dEL2dXNC8yUXJCWDVySEJIVStIVHduMzNIVWtRMy9Z?=
 =?utf-8?B?UUJ2eExMM2VDbGRqbktIWkU4WUpMMHVZNmJPZVUwQll6bVkvajhVQ1RwS04v?=
 =?utf-8?B?TlN3WXdsTU5SSzU2aDdQNE1Gb2I3MmVpd3IzTjNyZE9IcmVyZHZudVErZzJV?=
 =?utf-8?B?YVBMNWE3dDdzNGltaWFqYWNpdldIbnA5Nkttd2pPeGFkbDV3K1EwejhhbDUz?=
 =?utf-8?B?WHMrZkZ0SWgvTjFLVm1ERVMrWDVFcmFuS0xId3dKQkNCL2k1d0JoSG9DUFBF?=
 =?utf-8?B?VlErdmFhNEt6S0lTcVY3RE84cmptZE1xNmZ4aVJLSDhWRnFnSDd5a1l1R1hi?=
 =?utf-8?B?T2NtOUtQcE4yWW1JNTFxbTB5TDR6Y2tHQkNtam0rSmVWK2tRWmNqOEZGTzdl?=
 =?utf-8?B?dm1oVjkyOWluSXo4WjhrVkZxTU5hQ3U4a2NBRElPZDhIeUlhcUQ0S21lcE1H?=
 =?utf-8?B?ZE5ESWY1MFpzMTlDdi9nVnlUdm1hbzIvWXBMKytEUWFXN2dGUnVmbDhQU1pY?=
 =?utf-8?B?aDlKS2pBYktQMEoyUjdhSWlYWUxCZEJsQ0NLcGdMUTlnazd2RVd0SzRyelhu?=
 =?utf-8?B?UGtlY2VFSUFGaVRXS05BMnZmdWhlbzk5ZlhwS1F3TnpseEVBME9HVVFyYThB?=
 =?utf-8?B?cVVmckk2MlpudkV4OEYzQjhnSDZZZ2I5S0NpNmRCRGI0ME1YTTFjb1NuUWcx?=
 =?utf-8?B?cXM2ZWRDbDR3VExBN1VTYWIySFJ1dmhyMkNyOVdJeVRiaWF5Q1dlV2FlQ2Vp?=
 =?utf-8?B?V08rTkhWanZ0ZFZCenl3OUZIR2JWOTlFMGlXU2xvTVdCczhoT1BmNkYvMFZ4?=
 =?utf-8?B?TWVjSisySUErS0xCMm1BeE16ZFJhVmtDS0t6SHlMSFY3V0xsTWUva1FXQkh4?=
 =?utf-8?B?VWs4cWxLYW1DblE1b2pQeWVMYjk2c3FwbHZXVktvcnE5VzRlK0thOVBMN2Vz?=
 =?utf-8?B?N2xLZmhaRlpnU0ZCK2kraktBeEsxN2Y5bVZXV3g3VnBNQ1V5bG9mbFFkWDVa?=
 =?utf-8?B?VkZ1cG5CSjNPUnlGOFEvelIxNlZhTFJkSTdxTUVSRnQybml1WVNDREF2Q2dt?=
 =?utf-8?B?MjJHYXUzM29BUGtWR3ZCYjdiNHFvTk5UZjdzNjBiZjdaWEoyNmtwVjM1dWV5?=
 =?utf-8?B?Vy9BRHRRY1p4emZZSVNGVnUvRVFhVjFQbHdsT1h2d1gvdlhWU0owLzlUYW5Z?=
 =?utf-8?B?VGdjQ05CTnpRZGhwaVhvaldjbEZRc0k5UWpzSjhreVd0Sm5NZjhZR0dGZHlT?=
 =?utf-8?B?RHBPUXdGV05PZ2RWSFV5c1BudXpDZnp0b0UrWkVZd2RkZjAxTlB4bkZjVG85?=
 =?utf-8?B?ZkhEbFNpM3FkTWp0c2dYOC9ydzMyWENXdUtKOVZ1UXRvV25xenUyQUx4bkdh?=
 =?utf-8?B?aFFRMDB3WmtiNlZJK3A5NjdWTjhNOXpXUDYvOHp3YzRPNHY2SUhqSTNRWEFp?=
 =?utf-8?B?eU9oaGdCREpGbHJuMkNjUVcwaWxiQzNUbWp4VUZ1aHVaZ1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZ0WWRhWTNlQW1hM0NwQmlpM0xqWjFEbFliSCt5N1RaWWJEU3BQU3M5cU9Y?=
 =?utf-8?B?K3MyNlBxZjBaQ1UxOFRJZzQyK0RIU0lWMzZDdFV2dXdBR0xJanFSV2ZMVktP?=
 =?utf-8?B?SjU3SlRDNkR0K21WMkxianQvNHJTTWJtbEFEZlUrU0JoTm5Ma2p6UjlESUhW?=
 =?utf-8?B?blU1QTRnOTUwRzRheWQwMnVVc0Z0TmUxSktLVVBqbUk2R01ka0F5NEpkNDJU?=
 =?utf-8?B?bjljSUQrdFlUMmtJbTdMWnV5RDBveVZ0UXgvQkphRTBQVjlvK3R5NjlMeHZQ?=
 =?utf-8?B?RXEzNU9qNTBEYnJjak5QR2w2Lzd4V0hrL3BKTXpmUjhJV3pFR1NxT0pSdnQr?=
 =?utf-8?B?dFpjbXBEZENpdzlkN2RrTTZpd3ppRjIwNllHM1Bva2NRVUpCaXlSaTVOR2lC?=
 =?utf-8?B?ME84L01UMjdUek1lYitJZmdiM2xLSjU3SHAwdUtSRVhQQTJjYnNPQ0x5YW1L?=
 =?utf-8?B?bHhkTmxSVE9Mb3NyMVNONlFYTnZlb0FEb1ZueE4rcGFZaDlGSDBNT1BZN0E2?=
 =?utf-8?B?anhrSDRpaS90ci9KdVpnVXptN0ZlTHhkOXdZcVVZRHpkLzVlWmV2cDBPT1NR?=
 =?utf-8?B?RUgrSkxLcFNFY3lBTThhU3RqWmVud2pLeWE1SXdueDRBODdUeVJRNzY0WUxt?=
 =?utf-8?B?Z0xOYk9sZzl5RXNBT1Awek1BcVJURk5UN20wV1phTnJSQVNMQ1RiQjFHWDAx?=
 =?utf-8?B?TjFBdHptcXNaQnh3MU1QSEczdk9OT3grTnZaeW1Nckc3eG9HMDdPSCt1UUl3?=
 =?utf-8?B?akkwNExHNUJ2Y3BEOHRobmMvSm9reVVOeTBWWHB6d09lWG5IYXZGakZpUnRW?=
 =?utf-8?B?UjIvcnUxclRucW9QVGJUNmYzaXFibkxSeUtXeXVPQ2tycW1PcHVwZGRDeFR4?=
 =?utf-8?B?cGVPaTF1djc4QURQZ3lHWW9MSjhnOHhBTVhoU29EL0lDNHJPY1praW1FYnVQ?=
 =?utf-8?B?UkNrMnNXcit5TEdsL2h4ZFJhVTB5cktFa2xSYVlmOEdaTS9ETjRkR1NuME1u?=
 =?utf-8?B?RVJ2K2lXTHQ5UWt3Ynh3Z25adXNvcVRiMU9vZ1BwZXlJcVI3RG1FWVorVzQ4?=
 =?utf-8?B?MFdkcXJLdzRFNi83Q3IrL1FkenozZkN3RHozRnR2aWJqL3B5NXZRSHhnMUJv?=
 =?utf-8?B?a0hpYm9kL0sxR0t3YSt2TE5xelFPbVBYZFF0ZlR1NG1zUWVpKy9qbFRTSGN4?=
 =?utf-8?B?NXQ5eCtLV2tXZ3FTajUxOS9qSXgveGQzdVZVSythUWxmdzVvUno1RFZRUDFB?=
 =?utf-8?B?ek0rZ3RjeGZWVjZmYy93bU1CbVVtdE1OVTFxOG90VSszN3c1SUVQd0haZEZW?=
 =?utf-8?B?dVB3ckZRWnI0Wjdsd05FMkVGbU5oUFZZM2tDNi84MVo1TTJoOXg2QnJTWEdn?=
 =?utf-8?B?YUpzZWRQQyt2UDBHSWh2UDZtTS9OTHNkU0h6bnlyMG9YQXR3NTFrRWczZEhy?=
 =?utf-8?B?dEYxZkZlTjR3YnhKUmZyU0lWS3hBd1dYY2N1R3JPekVGbkhUR29XQzNBVlFO?=
 =?utf-8?B?Ylh0NkY1RDl1YTE0MEEzK1ZMaDNzcGFzaTN3YmJCdWVacjlQVHlUWDNWWE5p?=
 =?utf-8?B?R1pVdVVPZWFvQ0NkNGxZdEh6QUF1Ujlra3M4OHlrVmhKankzTTc3dlIzSzRQ?=
 =?utf-8?B?UFB4dS9OR3I2YjE2V1l2TjRJWUJVNFBVR1hiaTNkbm1rSkE2Znd0OHR3dm92?=
 =?utf-8?B?d2JuaDJ3Q0YwWE1IUDVTc2svc3FRYTkzcmxNNVNhU3kySWlvVEExaWNPWitB?=
 =?utf-8?B?V1BmY1FXcW1nWjlhS0tTZFkzY3p4Y3hPOTkwaGVldG5NMmVvSGRmK0xqL1c0?=
 =?utf-8?B?VjdVSU5zMFBpcjliaUo4OENnV2RRTjVuRVFwYlhnQTk4L3Q0S3hXZnEra0o5?=
 =?utf-8?B?bHFUeWRyblRHYUYrY2hvbnFhUzlCTEVZTVBYM0lYeThGekNEYUFnVXh4aUdn?=
 =?utf-8?B?Umt5d2RVdEwyK0RncXRVckhZcHFhMTlxc0hKdlJNazh2UHFYWDhINEpRWmNh?=
 =?utf-8?B?WDZVaTg4K1YxeXVNZjhyeTZuMHNNeVdWMjY4VHpxdFVHK3RIQTE5VUZ5QnJQ?=
 =?utf-8?B?dDh3RHdmUVdPYlFRQTFyd0d3blNGVHY1OWwwSHIwL21WSllBeVFhcW5HanlF?=
 =?utf-8?B?aDk5YkpGSXB6ck5lc095clpwaDBLWU4xSXFPWG9WTkE3U3Vmb1lqQndHMzRX?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5db0e1e-4bdb-40e8-a803-08dddb0af469
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:17:05.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW2U4obifU9D/ViXvt/s85sth9QysWsy6KiZSN22NG6kjMqULCYbXpgEDIAMB6wvt34J0AryMH0pxGBTux9A+oJ8GkQLaOFjgj3SDdxSLqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com

On 8/14/2025 7:19 AM, Paul Menzel wrote:
> Dear Anton, dear Milena,
> 
> 
> Thank you for the patch.
> 
> Am 13.08.25 um 19:33 schrieb Anton Nadezhdin:
>> From: Milena Olech <milena.olech@intel.com>
>>
>> When the driver requests Tx timestamp value, one of the first steps is
>> to clone SKB using skb_get. It increases the reference counter for that
>> SKB to prevent unexpected freeing by another component.
>> However, there may be a case where the index is requested, SKB is
>> assigned and never consumed by PTP flows - for example due to reset
>> during
>> running PTP apps.
>>
>> Add a check in release timestamping function to verify if the SKB
>> assigned to Tx timestamp latch was freed, and release remaining SKBs.
>>
>> Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
>> Signed-off-by: Milena Olech <milena.olech@intel.com>
>> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
>>   drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/
>> ethernet/intel/idpf/idpf_ptp.c
>> index ee21f2ff0cad..63a41e688733 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>> @@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct
>> idpf_vport *vport)
>>       head = &vport->tx_tstamp_caps->latches_in_use;
>>       list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
>>           list_del(&ptp_tx_tstamp->list_member);
>> +        if (ptp_tx_tstamp->skb)
>> +            consume_skb(ptp_tx_tstamp->skb);
>> +
>>           kfree(ptp_tx_tstamp);
>>       }
>>   diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/
>> drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
>> index 4f1fb0cefe51..688a6f4e0acc 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
>> @@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
>>       shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
>>       skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
>>       consume_skb(ptp_tx_tstamp->skb);
>> +    ptp_tx_tstamp->skb = NULL;
> 
> This hunk is not clear to me from the commit message, and the whole diff.

So in idpf_ptp_request_ts the code is making copy of skb, normally when
this copy is consumed in idpf_ptp_get_tstamp_value but in case of a
reset the normal flow is interrupted and skb is still in hold.
This patch release it during reset procedure.

> 
>>         list_add(&ptp_tx_tstamp->list_member,
>>            &tx_tstamp_caps->latches_free);
> 
> Kind regards,
> 
> Paul


