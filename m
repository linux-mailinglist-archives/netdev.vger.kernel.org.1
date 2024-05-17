Return-Path: <netdev+bounces-96908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90128C828F
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1B1F21267
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF041AAA5;
	Fri, 17 May 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CB2D51cZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF422260A
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934564; cv=fail; b=B4nYHD5snU36XDg2UWFULXCDUdQWdsyzgiNPsjCkCnsdn3GJ4aJ3AUXkj+3MfBrHulXq4tbngjdp/A6xNjnydP70qwA1xJn/G7rpUMMfDWOkPRwR8sCc9+WWnY+wY3z0jgfPlE1cL/1AxWn8KcxSHx4vn+Bn4lOZrFpuMrtJu+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934564; c=relaxed/simple;
	bh=/s5dt3d+yg8gaIuXo6U/xA18XoOhpEKIPQmmM6/e/ck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5dz/wcguLpe9NVCgRLEYmd2/iyBC1dOJJTd8nrwFZXsJpHKOKUCRQWkJgBVjoNU+INjp8s2orn+984/TUnuwV34Qp/nG+GPkqjD6FZHf+b5dwm9GA3Pqu0so/+VHplakvERQfdXJ2odRg7RLDwESUQrossugFJF2gKD7sAWiWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CB2D51cZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715934562; x=1747470562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/s5dt3d+yg8gaIuXo6U/xA18XoOhpEKIPQmmM6/e/ck=;
  b=CB2D51cZb/5Fy0LdXsjbteLB6c5gMfm3nRLfWlyNBz5lIW5LL2nLFPem
   2kL5h86Nzkc8S9gICeOfcRTdcFnN/J3vj0xgSP0RwTXfTG53ivjJ5ubYB
   6NTp+l3A5TMhUEiT4sRZRNpNydkbX4RpjuLdzlv4VqHiFw02SKgqWxnrF
   ro26dU81f3mWSCniMt2t2PacEKNE3ERnonl52JqnRWIl9NKaL2vM5qx98
   2p0e3Wo8F3McfX9K3TuzyxXiRGe3nbadI4TYTHN4rckccNa0KQnSl91wu
   VFwyPSWAEgjLgDAuzjgZ3wuqF2umaGK2XSBjyY2tKPwg3nNf/kkjuXbwm
   Q==;
X-CSE-ConnectionGUID: xjHTvw14SFq5nJrNvv3LFQ==
X-CSE-MsgGUID: RFjh18ZZSv2yZ+flcw59yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22678144"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22678144"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 01:29:21 -0700
X-CSE-ConnectionGUID: SYOGhRV8SLedwSqHB+wsHQ==
X-CSE-MsgGUID: Xk2H9iQBTseyzbp2R0Nddw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31819345"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 01:29:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 01:29:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 01:29:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 01:29:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 01:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfQroU1g8Ld5EGz8MRH1LyH3Hoojuu6XOG7leEKaasBjicryueUsiqwypt27mpz47HPnJUBnU+gvMO6PK2sqGhufWwkozwbMYiAUM1pm8FmN2/JGcrwqfqKlmedav/VJMTjHmW8NaFQFZYQajapJlwHSnjtm7AgepueH2Es+kxw5bg8j3tShPnE8sph6vDd9Tw7y6Vx2g5Px/3HYrN++kmjQK54aKIEXn6J5dau3kboOe1HZu4eL1fHOePwAXEVUnUZNChWztSEBSqPoBj4ASKSKzosTebm/cQL93GuonbN5Q9lKDK2giGc6rtcyPjeaqavlh8dLXOjjUOch4HdBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PwoNKHVigyQNcqMKJd3RFrYlF28hna5uhHvTQKhiBg=;
 b=Iqb6+dKq4d8fqfVSglXhRa7NpOgEQkwtYdb16EmWE7Xla91pAIafr3bNOjAQnhoZ39CG+tsgE3mMSFCn/PPgTAYP5V9RylljJZgBmQ0LM1nvcKFT9KT2CdlCDkAUOh8+j7b27TpiX0rgdrRUWFgWBTLqNy8vq72cTY4s6LkXXv/1wCRCrD0se1ogUZMDzUKEEIWool6EGG3cXA8jlcN+AonTvqmurbGUNzbtqfAaTFyrT99+CY5fAXXraRDz9go0f5EPbJCLu9Dh5oprzU3wNiwgmxHuyHJdBOmSmH372/z4T2NYaPcvhId+5yoqp66cG/HguLUsTadvsdubRonu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 08:29:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7587.025; Fri, 17 May 2024
 08:29:12 +0000
Message-ID: <428284fc-232a-41d7-a8cb-f4b01fd84691@intel.com>
Date: Fri, 17 May 2024 10:29:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: implement AQ download pkg
 retry
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, Brett Creeley
	<bcreeley@amd.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>
References: <20240516140426.60439-1-wojciech.drewek@intel.com>
 <342a9b10-97d7-4720-92ef-a548179b990f@amd.com>
 <eb7293ac-3674-4e89-a11d-a8b8fd470dcd@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <eb7293ac-3674-4e89-a11d-a8b8fd470dcd@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: a6714e74-2092-4686-ef0b-08dc764b6e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmZtYUYza1kwM05BcERSMDc5QmQ3MU43RTI2VDZrei9wRFlEYy9vZlZ6VmZu?=
 =?utf-8?B?UFFIaGFSbk5XSDNiY056ODhUMnVJQWVHNVh1YkhHaFM1MXJtMHZpS2JXeGJN?=
 =?utf-8?B?SHpIU0w4WW5QMEdPYkF6MG1ZTXdHbWNMQ2J6ZjFjdk1FQ1lhdFM2eWJOT3hZ?=
 =?utf-8?B?cDB5VE04RlpQaFF2Vk9XelpVZXVzeGsxVkNXcHdTM292WFhSMjZqYis5TmJN?=
 =?utf-8?B?R1J2SVBYNWsxcitwV05HMmEwMS9oY1FiSlVaSXFMc3piVmIrRXZPczNjZ04w?=
 =?utf-8?B?aWNSTjAzZ0g0eVFsRmVlQVgyTkVVMjk4ajVjLzJNTkxOTFR5YzR0a29IcGs5?=
 =?utf-8?B?cjkrbll2TW91RmloR3RlbFFyblJmVG5sZm5VNVBNWnc3TG1HcFJmMEdNelJ6?=
 =?utf-8?B?Y2l2ZmkvUWVIQk1sdFBIVFlUVzVkM2F1WEczSzREV3NUc3FOT2FQUFR5eDI5?=
 =?utf-8?B?UjlZY1lzZlRmR2tQV0YrWG9YcWpRWm9jOEZ4ektWb3I1TnQ5S2dxL0tOemdV?=
 =?utf-8?B?OCttNXF0ajZrRXVQL2txMXZkaHU0TEEvdmdIdXEvYzBTZGxJS21CS2F5cTNW?=
 =?utf-8?B?TGdBK3Y3MXdiTnF3S0dVSk5ObTRNYm1UUzliL2JIR2RORTZwUDJ5ZDNRamZ1?=
 =?utf-8?B?OEU2NXpQK05rY3ExS3ZrSzQxRFg2ZXp6OFBteGZhdG1tTEtHZHg3VzdmTGx2?=
 =?utf-8?B?emFib2FtRHl2MEpaa3VQK0RRVWtEaWlKTFhYbXIvVnNuS0FrcWE3djRQb1pK?=
 =?utf-8?B?OU9JUS9VTHlRaThDTVFuNkFBOVFvbjQ5cFdjRkg0bjVZZGVlcGFudEI0K2U0?=
 =?utf-8?B?VHhacGJYRnkrejZvNi9HTTBEQzJwMFVXcDlkSGdpQXZGZ1ZxQnJnYjU2WExz?=
 =?utf-8?B?Z2hFOTVzQzhnRksrU0tvVS9mcWtENFFvTUhTenRiOGRxMXFPbkVWVHhadTZM?=
 =?utf-8?B?enNHaU1pL1VzRHFaMm15Vk95Nlg5V0FONzQ3d0pSN3ZPUXZnbmJEVUJTQUJz?=
 =?utf-8?B?L0pSZS9IMVFONVNENmJXRkRNY2o4WGZGeUM5NlE5cEYxUXZ0bnJVdHBGOWFk?=
 =?utf-8?B?VE1rS3RHeTJqYnhMR1BtZ2RKTHBabVkzZVdQQ3ZQSHZ1dUgzRVJGUUpuL2pW?=
 =?utf-8?B?K0dkMC9RbWRDbVRDN0QwV2lsekp6UEZ2WlR0RS9ucUpVaUUrU0NWUlFvZ05P?=
 =?utf-8?B?ei82Q1NyREZROGxyVW1KSDZxOE1kTjR4ajFBREFDV2ZJMWUwM25rb00xSjM0?=
 =?utf-8?B?MUpaZWtHUlIzVHIrVzFZc2g0SkNuYTZiWThvWS9MYnUxWitsTTVyRTVXQ3ZR?=
 =?utf-8?B?eXRxNDNiL3dwMkxjcmxTQ2JCRG8rbXlNQ0hFTjZieURPRGMrdjlkMjdpcmNQ?=
 =?utf-8?B?RFlPQzBJNWV4OVZBSzdwOEU4YTd5Z0ZaeUhEL1BnRVBObXc1N1VEejN0OUxo?=
 =?utf-8?B?K3pwajhuRjI4a1pyV3ZtVEpjVVJ3bU84cnZjTVVhZzJkZS83V2JOK1QvUkpY?=
 =?utf-8?B?UjRmTjFPZlpINkhDWWdWU1g0M1J2amIxTEZTeEtaM1FneXdWZStSb2lmN1ZT?=
 =?utf-8?B?d0FSSkFBelA5QWUxc3pFUEI3UWxrSnRNU0xQcVJPT1Z4bW5nRGRXdEN2eWdL?=
 =?utf-8?B?SU1ZaitSNjF1N0x4VGg5dGgwWFpScGpPOE5BV0kxTXJzckZ3amUyeitxZmhu?=
 =?utf-8?B?NGswM0RzZDBlWlYzY3FackN0VGhZSEJHSHUvNXhuNEFVcCt4d0YrNmRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXd3c2RBWGc0L1hMc2E5OUdUZ0JoMytYN2MreTB5ZlRXbW5zTDdIRjlDTno1?=
 =?utf-8?B?VXcreVJsUEVBdWFzd1ZhdkpvTEVISFFzRzZCckpUalBqQlVEUHE2M1hNL0FP?=
 =?utf-8?B?UTByWXVReEN4ZzY2QkxValIwQ3ZlLzZXbXVSdU5hd1N0dkI2MDlGRFY4MlU0?=
 =?utf-8?B?ZmFkY2NwNWhBVnhZVWNOa0pOQWFPNXpQS1Yyd1Y4UWhaNkdkc1B3OGt1R1k0?=
 =?utf-8?B?eHFYWnpnTTVmOHAvdUZqdGhTUUJzb1BEQmpLNXVEbHEySHc1alRKSWZoUWVF?=
 =?utf-8?B?ZTZYazl6SVliZkcwa3dkeGhyZTBHQ2hyaFdaTVg4aWdVcnpmeVVtMjRJMk5w?=
 =?utf-8?B?NENxRm1IQ1d2QUxyRDJDazgyTWFPUGlPN0pqK0hvZVJHNE9aOEVKNXJ6bmhl?=
 =?utf-8?B?V1ZTdzJrTWtjSSttdGcvcUJ6WXc4K2pYMmgreVo0VmFSN0tncVM5SFFVbzNR?=
 =?utf-8?B?bVhaeXJpOFZDWkVVbC9zTTlGR1Y0dERjQXdua25iMlB4aldBZ2kvUUR2S0wv?=
 =?utf-8?B?WXVzMHU0ak9PYncwNk9NSjVYMjlrWGVWVkNkQzV5TEYyZ2lSZ2h1ZC83c2o5?=
 =?utf-8?B?dnc0N0pHbXMrYXkyaCtpUk1ob2xEMlA5eEN1eS8veUNNTkI3UGR3b1BkaXMw?=
 =?utf-8?B?TlhwdVhRaEtTYWp2UmIxS3dMb0JkaFdHSVUveWJuaFIva2tHZzVGcFE3VFRW?=
 =?utf-8?B?bFo0OHN6eGlzdks3dXpFVS9lSm1GandaODJ3dEJFYlZmdGtud04yVVkvMGdn?=
 =?utf-8?B?UElmRkRKT0dNeVFFUkN0d04yVjkxWGNZclNxVXdmMURQNTYxRHVoWmJFOCsy?=
 =?utf-8?B?VFVqTGFxcEZvaHF1OFNwbG5seHVIQjBJK0tld0Fjc1JxbkVmaVlDNjMwU1k1?=
 =?utf-8?B?L3dsV2FwalJEVUhCN1p6NHdOQlJwV2lESXQ4eUJWN3cwNEZPSzQ1dCs4dnpo?=
 =?utf-8?B?bVZYdk5tTnpGUi82bURXMjBaN21qbUJ3d0xseUVUemdjc1d6dWx5dHJFTTd0?=
 =?utf-8?B?anJ0U1U4RjRNa3hNcC95Q0RCazhoYkdmL2NROVFTSmwrYlJPV21qSnc2Tkpt?=
 =?utf-8?B?eFJGWVl3YXZQVzJ2MWt1dzNLZHZETlhEejhCT2JxSlNRWUJQTGppcUFnUTNL?=
 =?utf-8?B?b24yT3VzbHptd0tIY1ZRMmU1RXpFQWZTUTNCK0JYaFA4WjZ3TUw2YjF3TlNB?=
 =?utf-8?B?TE9vWG82eG9lS2lKaitIdHJmTi9OSElvMDFRazYrZG5xUG5FQUkveEx5Ukgw?=
 =?utf-8?B?bE85MHd1dUdZMnVuRzVIN3VjTldSQWRVOXFjRThSWkRNS1dEdkVqaXFJR05v?=
 =?utf-8?B?TXlVQm54ajMvTVE2WmdxTzVEVmhJYlRleUVVdUp4YjByMldmaWI3d0M4amRC?=
 =?utf-8?B?K0VKQnQzWVp0OTZyZkFLR25IOHZTdWpHNFZKbmtRMzZlMVJxSHJFeHo4N0FT?=
 =?utf-8?B?Q2twSW5NekQ3SkdxOHhaNUhTdURkN3hveU81U2ZRaEhBdzBQZmd1b0VEVlRX?=
 =?utf-8?B?dmhyRkdsNDIwaVY3NkZrc043bHgyV29lT2s0ZjJPQi8wcjVpK2MrZEJGbGg2?=
 =?utf-8?B?WVFNSEU3MEhzMUVKR0YwUlBkODhXSXJJdGpHUXE2dU1NMEo3NDQxNHFpNklR?=
 =?utf-8?B?NXgrK2l1eXhvVFRKMjl2YmxEK2dhYlp5VVhXdnBWcnlDZmVnOERjTkdiU21q?=
 =?utf-8?B?VUtpaWpTYmsxbXRGMW1NL21CYjRIYWM5YU95WEVmWUxSdzNZWGUzSVAzNGxh?=
 =?utf-8?B?bTNXWTZubUwwZS9OYWZMK2l4TytFWE1aTmNBSnA1SjNnbmZlUi93VGlsSjVM?=
 =?utf-8?B?cmVxUkpCdlgyNzBVZ2ZtR0VCV2NqOGJPTld3c0lhS3hrZGhoSnpNU2NKU2ZS?=
 =?utf-8?B?cXh2VFZ3R1ZwUWN6RUtHd20rMzU2Zmk5UHJ4Y1JSL1k2NkREUlJlQjNhVEln?=
 =?utf-8?B?NHB5S1NFOUZpRnhEbWpmVXEvbHY5Z1cyTFRta09kMHYwSHV6c25pL3Zxem1t?=
 =?utf-8?B?dnFwQ01VRWFlWWU3dVEwTVVIa2ZoYnNNRlZWUkRlcGFTakJrVVFUcWVOUTZK?=
 =?utf-8?B?SFN2end3RFRBQU5LUnpWQ3NUNENVMUN0cFMxMklPZlg0RW9tRWxkbkx5THRl?=
 =?utf-8?B?VldwWGtzQVpvNkZ6QjZXYWJublJCeTVsbkFScHlSTHh2Mmk1YjJQTi9EQVhV?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6714e74-2092-4686-ef0b-08dc764b6e85
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 08:29:12.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qikzmRp0Wz2bStp7fBXOv4Pt8t5VsBRrekX82fEEHiOiApb3aWEKYg7QQI8CZalKjcVOhKPwjcUlm7sKRhhuAbg6PsKVej2cvgUQJV5PFE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com

On 5/17/24 09:49, Wojciech Drewek wrote:
> 
> 
> On 16.05.2024 18:36, Brett Creeley wrote:
>>
>>
>> On 5/16/2024 7:04 AM, Wojciech Drewek wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
>>> to FW issue. Fix this by retrying five times before moving to
>>> Safe Mode.
>>>
>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_ddp.c | 19 +++++++++++++++++--
>>>    1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
>>> index ce5034ed2b24..19e2111fcf08 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
>>> @@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>>>
>>>           for (i = 0; i < count; i++) {
>>>                   bool last = false;
>>> +               int try_cnt = 0;
>>>                   int status;
>>>
>>>                   bh = (struct ice_buf_hdr *)(bufs + start + i);
>>> @@ -1346,8 +1347,22 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
>>>                   if (indicate_last)
>>>                           last = ice_is_last_download_buffer(bh, i, count);
>>>
>>> -               status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
>>> -                                            &offset, &info, NULL);
>>> +               while (try_cnt < 5) {
>>> +                       status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
>>> +                                                    last, &offset, &info,
>>> +                                                    NULL);
>>> +                       if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
>>> +                           hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
>>
>> Are these the only 2 sporadic errors that FW will return?
> 
> Yes, that's right. We don't want to retry in case of other errors since those might be valid.

I would say that those are the only two non-sporadic errors ;)

> 
>>
>>> +                               break;
>>> +
>>> +                       try_cnt++;
>>> +                       msleep(20);
>>> +               }
>>> +
>>> +               if (try_cnt)
>>> +                       dev_dbg(ice_hw_to_dev(hw),
>>> +                               "ice_aq_download_pkg failed, number of retries: %d\n",

s/retries/attempts/
(as retries = attempts + 1 ;))

>>> +                               try_cnt);
>>
>> If try_cnt is non-zero it doesn't mean the last download failed, it just means one or more attempts to download failed right? Maybe just "ice_aq_download_pkg number of retries: %d" since the if (status) check below will print on failure?
> 
> Sounds reasonable, we want this log only because we want to know if we hit this sporadic failure.
> 
>>
>>>
>>>                   /* Save AQ status from download package */
>>>                   if (status) {
>>> -- 
>>> 2.40.1
>>>
>>>


