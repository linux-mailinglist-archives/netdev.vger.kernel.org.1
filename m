Return-Path: <netdev+bounces-131497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B880B98EA94
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0B91C21559
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E51127B56;
	Thu,  3 Oct 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJzk0WBd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD6126BFC;
	Thu,  3 Oct 2024 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941380; cv=fail; b=K/rq5vZ80GVXOtzA5R7hGkkV/unHJZ/M7PcmL+QE/KJ91ku1u4NIWuE4P4nEoWCJvijY+se2ELUqqqn/o6EIxVcC1kr4lWnmiN9EQ3G8DJ0rrtvBUyhu4+o5raSkSFg97nQlcNr6bKFGiE+XGvHfLrJfCa4ayLgwwkFTdc+XRXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941380; c=relaxed/simple;
	bh=ssXL7omgwhLaWBdZRUtC87QyCAxT0Zr0lTFtJv46al4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTJIFl3r6Tb8X5s3GbmyFrsNLy9yCXqHEo3GHpr8jlAVj/Z6MfLlECFsHH0CcgYy0eqaqYe9Qv3cfrjmQ82aF34+9Ig+CyW8Y0/c2jCOX+nVn2IcTS6DFSdFVaXXHG6AItxvTD9AoBjAmI58Cj2F3datm0RuFjbc2Wh32gFDJQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJzk0WBd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727941379; x=1759477379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ssXL7omgwhLaWBdZRUtC87QyCAxT0Zr0lTFtJv46al4=;
  b=mJzk0WBdgXkMguyQ64DCwUTp/IcTnwR+W7xk2Oz64/cLtpqEtdhcWfjr
   /RgsanuYgA90/3oXWhQ4KWGGZJ8+NRVTR0x9ZWQGcW9X/luQgmEbi36F5
   zZir0oBdNrSB6DGiMqPc8DjNUjwEEXNcTMX787eCV7zLka+NMkWnZ4TEu
   9JgJbxh0drXbAszVw3Hqb9RnvLvI3RHWR5uaNJzb4tW+0Ke5QvQcI6cmS
   NwnBUCTpqZKyYGJ0I65x9ePexARukHsBZtf4M8Yu87chyvKF25aAgUNUu
   zd2Zm+eEojRqY52kqq9sZF4HuJCPAgFrlHYi6Eqy3j5FBMSItEH8D5JWF
   A==;
X-CSE-ConnectionGUID: Q0PtaSJuSc6Y4K3xU+rFtQ==
X-CSE-MsgGUID: 4AGfTqVyTaqqRKW8DdXVTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38508594"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38508594"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:42:59 -0700
X-CSE-ConnectionGUID: Pzr5cggWSuidFK42Cm9xkg==
X-CSE-MsgGUID: WXeYIPBvRheqDj0NUjxtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="73855447"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 00:42:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 00:42:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 00:42:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 00:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kojEa5pm2+jz0W0EKGGm6r8I4pVXRp4bGg7RjiLvBk922RLbdQ3hxK9E8A/kVVBDKMo+6sJMmvvNQtMBl+d45CVznXvTEYdEPhIuPFfuBxMpGmdVpIYBkGDXjfo9CBOLd/7P9K2uZ/qw1qPT/BlypxLuLeUgfT6pM7Sgq1eDu9/Bg5KPktEAM872WwcRcY15Wd0jfkytwcSphOcnuxXBtUnJGaE/xTVsQIWvVfaeXpLiK3HMSWBvlMAjiQLErsW+jPjEy9iQ/cFgIz2QJ9DdqENPLpwoQ4ZwDsbOhGGy3DnKL7RU52eEmNAtjErpSHOyNxYSykLedLveN8RACswqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFrGIgEG6S/Mxnm2zOeOpLlrdVJ1CngOVdu9u4WUcMs=;
 b=JYjLzzONN491KdOXuE70XbYmfOfqs9gdetyhU3F7qREecBKEnMuAKEmvH3EtuHyQEbvJsN1sj2TQ418Wbmyai0d5VMAdxUuYyNve/b3LMA2YI2cf27Udf9ZqiUVFAqM1rLKQE9pKcfoS5+1I0AKqSOehb8q5MIhhMsimR/tcBL78a7QnpO7+/wu3GGJmeZRMwYGOg5vO1N5Wybs+7zyQWVFf1Pcd+m7QBIHZQPytd/Z8bt6tIbkyhroEdYHt2BHqchdbXCtP9Oyt20oYPMxxnA0tbmksXLWkk+6FomKiOmdrpCMgrs+KvRxU9NZVZkRp+3zrT+NUFVY9d6qANkl84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:42:55 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 07:42:55 +0000
Message-ID: <bfd9406c-4786-43b9-850c-f1b76f9a9ec2@intel.com>
Date: Thu, 3 Oct 2024 09:42:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/1] net: phy: marvell: avoid bringing down
 fibre link when autoneg is bypassed
To: Qingtao Cao <qingtao.cao.au@gmail.com>
CC: Qingtao Cao <qingtao.cao@digi.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241003071050.376502-1-qingtao.cao@digi.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20241003071050.376502-1-qingtao.cao@digi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b96f38-ce3b-4b27-5d44-08dce37efe6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDVkSGpDMzh2UHlWeWsreUR5aEM5c1NtbDdnYTBrLzBab1JUeFhFRkxuVmFS?=
 =?utf-8?B?K2pLWmp0cmpBMHYyNEc4eGgxUW10Y08yN05Bb3dnTDZuRjVMVVFkWjZwZ1BK?=
 =?utf-8?B?blAvWHRIZkJybnB6VDZMOHROSG1LYlZuSklWVGZIcTFza0djOGc4dzErUFJ4?=
 =?utf-8?B?bWVTOUUzWnJDZkRUMnJ5dWp6SDV4dzF1ZGpEb2tiM0pmTitXeFRwbjVtajU4?=
 =?utf-8?B?bldzNzU3NzE3dTNQeklQVDRHK1lUVC9leW1yNU9wQ0VUTDJWWlZLSGZQNU1m?=
 =?utf-8?B?L1Q5dlhqM1NCUW50eXJ2VzJNTnJqbzFBTXV2QWVqWDN4OGt1dGJ5VkcvNU0z?=
 =?utf-8?B?WTZ0MTBKeVFlYlBjNkEwdG9qZUNTSTRUNzZDejVTYW0rS2lraDhWQ3lrVmM5?=
 =?utf-8?B?dStYRHYyWFNxSXVCWmREZmgwQk43MnVFWGdQTVJYekIvWTdWTTRMNlM4YS8y?=
 =?utf-8?B?RldZbzNMM3V0cTg5Z3BuNXF0UHppL28vU3BQbzhQYnpGM3FVc1pxeGYvbklF?=
 =?utf-8?B?STVYektQOWZjV0pEZG9OWWNVUDAzNVJvby9MS2lBZ2ZFUytjZzZ0bERPVGpY?=
 =?utf-8?B?MHExV0psdmVCb3pBMHRMeXNaa3BxNDZNeFA5OTBMbkt2cU5VQjFHRnVza0x3?=
 =?utf-8?B?UTd4UFdEa2RuMXhQRU5pdFpRbDZkSHlEd0EyOUFMK1FVbzFCVlVNb0g2d3lY?=
 =?utf-8?B?VlZoRWJzVW5zT2FVVmpSaVVVZWFLTkFINXJYNW1GTTFibWJGeHNsNThGWHZC?=
 =?utf-8?B?bkdBT0xSMUt6a3BJR1BhcjdleWFFZlZvNTJUZHdocnNTWFlDT055OUNvMGJI?=
 =?utf-8?B?cFVnQ3RVc1pGYjlGQWx1MFhpd1lRSlk1TDY4LzdDQzZWOUZzb3E0SktzRjVX?=
 =?utf-8?B?T2FYTzQ3UGpUcGplemtmOWw0dkE2eU1EOTlHaEJocS9rUERrSmszbWZ0TEJV?=
 =?utf-8?B?WDNSVVUwRlBGV21saFhxTVFiYVFIaHlNRFFMNFo0bTljT0xrZXQ2OUk4aEh4?=
 =?utf-8?B?b2xvY1N1RlQyNm9VbXBBU2ZpZ0ZpaVZWL0RyS1dYaU9vdkx1L200UWJaQVcr?=
 =?utf-8?B?VlQvN0U2NDBJaHJqc0xDMnJUTkErOUYvM2EvSDNIZ2hTd2RqZzFhajdxS3hD?=
 =?utf-8?B?N1U1RUVnMVlWbVpydGRkMFJvbnlMQk5mM0ZYU1VROGF1a0VHYzJUaGgyMmpP?=
 =?utf-8?B?a3VhRHpSMjVJalhJWGdTellRcGQ5cEwzTmJiTTVDNU1qc2ZwM3IwZnFlcHRC?=
 =?utf-8?B?WldueGVzRDFhaGpmWGx5MjVlM21rL21LSzRLd09vM2Y1QkQzaWdDR1ppTDg3?=
 =?utf-8?B?MFB2S1cxRUVuQ2hMcHJ0bzVHeVVFZXIrTlpWeDEyYUlZcENHNFl6N2d6UmI4?=
 =?utf-8?B?NUJYdWdjRGhxcS9jek9aUW1aeTFQWHhKRldQSndQSVRWcFhHWWJSMU90Zm4y?=
 =?utf-8?B?YitSUXhmejR2eWtDZ2pKbDN2NGM0cTMrenNpcUlUamYwLzFjL2RtMmk1MDQ5?=
 =?utf-8?B?OThmY0xVSWFyN0psUmh6NW12M2paNHZPZUdBNUFKV0lOeEE2WlZycTFWL3Nl?=
 =?utf-8?B?MkZ3MXVsMWx3NFBneDh3ejY1QTZXOUZPMjlrMENtQ2Y5SUJqU21FOWJZWGQ5?=
 =?utf-8?B?YURrQzl4RlJpSmtRNlBNOHE0TW1MVDFlY0U5bDFnb0N4NzlmWmMrSHR1aWVO?=
 =?utf-8?B?V21ZcTJRekg3WFVLVUQ4em5GcStuMVVBQlFVUWtGeVNuL0tTSWIxM3F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BlcHRHazg4ek9VLzZyL0ZHRjJQQnBwcG5DaUp1V0hQOFFFK09PbUMwTTln?=
 =?utf-8?B?WHRMU1Uyck9OSytnZ2Z3T2NtcHkvOUErN2gyL1d6QUJNc1BrSFI1b0JVMDNr?=
 =?utf-8?B?a1E1cFBIeEtKdithU3QwdUJETXhRajJSaDdCdTlZbjJqUkF6OTZtRytTQ2tE?=
 =?utf-8?B?NW9hb1VmYjQ0bTMwVHpoNk1Xell5Vmg2YlBmUHJOZ2FHc2lYSkI1cUpHcEFR?=
 =?utf-8?B?cjNHc1hWelNCZTgzWnRHNjhZQjZoSU54ZXJpQ2FzRTdnbWloaWN1d1pLYy9M?=
 =?utf-8?B?SFNXT1UwWlJDaldSdC9uanlsU3BmRHQrcnVCK3VPMU11TVdRR2tzRzg3NkRE?=
 =?utf-8?B?dEZhdDdDQXV6Ykdnck5jK1NOcUhRTndrbkZEbnJlWFN5R2YrNkM1VjdwYWJs?=
 =?utf-8?B?MlVld0hCTEFmaXl3aWF0eXNGWVh0aTRtU0NzbWc3eW5pUXlhVGNTUE4yM1dj?=
 =?utf-8?B?R1gzUnB3VWZWRm9uODRDTEFFWGNNL3R4dkhYeG0zSjZaNXJjdEtIbGxoL25o?=
 =?utf-8?B?QWxRSE9wOWNUaG1iMEllNE1hQWJabFdKU3lFY25UYTBSYXJ5Y3k1V05BNjhW?=
 =?utf-8?B?NTEvd1lucnQzNzlPSUE5RDQraFRFY3Nyb21GZ0ZMN3dGYWxLM0hLK0VUN2Ur?=
 =?utf-8?B?Nmp3ZW5KeitFVGJZbWp6RUhSMytWbmJKUklWYVd3UGpQVnRHcXNwZDNvYVFG?=
 =?utf-8?B?UHlDczB2MW5KQndjalhUV2d2YTk1cVhVcm5jUFZ2dTI0cEJaOHJRdnBxOEx2?=
 =?utf-8?B?YnNFMEZVUXpzN21UM09BNDBsSE9weTdZKzNrdUlHTVQ5MHdHTExybTNIV1F4?=
 =?utf-8?B?UTZUeEdSYWxUdG13bzdqN2xId3gxNkRaVmdjQ2J5dTY2M3lySHdoSzlYRVln?=
 =?utf-8?B?SVY0UU9HTzcyeVY2YjArWVE3MWNiSEIxeVZIYjJJL0VpckozMTRwS2RFaTdr?=
 =?utf-8?B?NThtNXNyeElPaFY3ejBVWWIvaEp5SERuVkhuVi92Ynp0cVNuKzJERVNMZ3dH?=
 =?utf-8?B?YmdVQUhGell2K2orZGcwR3ZFL1RrMDNNVTZ0YXc2ejMxOTVtUE9kYzNMRDBJ?=
 =?utf-8?B?SEF0NDlrcERkTGhtQ3JqTWRneU9DVmFUZGdZVVZXM0g0clZvSlJwdkRidnlG?=
 =?utf-8?B?OUdKcEF0WVB0N3Z3VW1zV1BXREh3elExVis0QUlLclZmSnNVZ2RjRGg0WW1o?=
 =?utf-8?B?Sm9UcWJza3R0RWhHNzYxN1NkK3hIZm82bHlLbm9JZmdTajkwemNYeFkxNE5i?=
 =?utf-8?B?YUpyc1hncG1MK1VwVldrRCt1RTh2TzltSDBidzgvVWhXaTRqTzQ1aXhsMkI4?=
 =?utf-8?B?VjlIYjBad00xZ3Z4SldMQ0ZkTDBUcTU5U01lNWNscnhaVnZsUG9SdS9pOVN3?=
 =?utf-8?B?M1VJbVdidUdpOXQvaGQ2U1QrQVZvWnllVjV6TjR3NXhLUVpkMkc0VG5DSUhz?=
 =?utf-8?B?aTRFYzdIYmRnZHMwdWRXNFhOaVJSMEVkWUFHT2Uya0U1MmRnVzZIaXZSalox?=
 =?utf-8?B?TWFBVE92TmVLdHBIQ2RKejF4Zk90YnNtNGNYbTFjcDg5dStESUI0dnU4cWkz?=
 =?utf-8?B?bnFQNVNOcGJZV09WL001V0VNckh1TzVhTlFhRDlJMkNMVWd5bUkxakhBd1Zz?=
 =?utf-8?B?Tlh4T0RnVGFhYzdpWlFIT3M5SHNoV3h1RTRlS0lqQ3NxWFJwTVVuUHc2bHdk?=
 =?utf-8?B?aTdTcWtmZTJBcmVhQy85M3IxMnFKT09lQUtHY1RsUHpOeHBveng1UW1jdjJq?=
 =?utf-8?B?djN0ZGpJYm0xOUNKdmYyL1lvTjVQWFpFSEpkRFRCK0JCanNoMFhPaE9FK0p0?=
 =?utf-8?B?TlJxNGxFbHZPOCtVRk5Xd29oSTlCdW1vT3RNZGNnajhKODlJMkduYVF6Z0c2?=
 =?utf-8?B?T0JaZFBoZ3lDbUZ2U3d1d3k5TEJMc0V1MUJwUWEvaFI3SlpSa0dzVjd4ZFV4?=
 =?utf-8?B?dGlBMVM3NjRSTldZaW5IUkR0YkYzY04wcTBRMU44UkpEZGRVMUJNL2RXTjBu?=
 =?utf-8?B?bFdTbDNCcjZTYk5manBLdU9RaDFQWWgzNDRub0Z0NytxUUVhSkFPZ1NYNjdG?=
 =?utf-8?B?VGh5SGZwdy9KanExODVUcTB1MDBReDRNejc5emN2eUJ5ellUM2xQMS9jRHBN?=
 =?utf-8?B?R1dYVlNMeTBKWUVoUWRnZ1lmcHZRTnU2dHNyY0w4TEhnWURrSDZHNzE5L2Fu?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b96f38-ce3b-4b27-5d44-08dce37efe6d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:42:55.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSps/hU1yIvDaYyaun/OKSFCH3g5eohzZQoN4Lfh0jg88HIcY/3FzIowXdlcG0pDxpi/IdolYPQiXXtmapm13/+2KiNpcOO2fLtK/k77vbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com



On 10/3/2024 9:10 AM, Qingtao Cao wrote:
> On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
> activated, the device assumes a link-up status with existing configuration
> in BMCR, avoid bringing down the fibre link in this case
> 
> Test case:
> 1. Two 88E151x connected with SFP, both enable autoneg, link is up with
>     speed 1000M
> 2. Disable autoneg on one device and explicitly set its speed to 1000M
> 3. The fibre link can still up with this change, otherwise not.
> 
> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> ---
>   drivers/net/phy/marvell.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 9964bf3dea2f..efc4b2317466 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -195,6 +195,10 @@
>   
>   #define MII_88E1510_MSCR_2		0x15
>   
> +#define MII_88E1510_FSCR2		0x1a
> +#define MII_88E1510_FSCR2_BYPASS_ENABLE	BIT(6)
> +#define MII_88E1510_FSCR2_BYPASS_STATUS	BIT(5)
> +
>   #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
>   #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
>   #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
> @@ -1623,11 +1627,21 @@ static void fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
>   static int marvell_read_status_page_an(struct phy_device *phydev,
>   				       int fiber, int status)
>   {
> +	int fscr2;
>   	int lpa;
>   	int err;
>   
>   	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
>   		phydev->link = 0;
> +		if (fiber) {
> +			fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
> +			if (fscr2 < 0)
> +				return fscr2;
> +			if ((fscr2 & MII_88E1510_FSCR2_BYPASS_ENABLE) &&
> +			    (fscr2 & MII_88E1510_FSCR2_BYPASS_STATUS) &&
> +			    (genphy_read_status_fixed(phydev) == 0))
> +				phydev->link = 1;
> +		}
>   		return 0;
>   	}
>   

LGTM.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

