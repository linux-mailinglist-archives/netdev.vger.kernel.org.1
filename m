Return-Path: <netdev+bounces-54362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8950806C2A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FA21F21460
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9A2DF9F;
	Wed,  6 Dec 2023 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKlCGkkb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588C10C2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701859034; x=1733395034;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uqvq9WQKoEyV2bIFf61Fvn54fzIKsH6ct1KBU/p8oYI=;
  b=VKlCGkkbKD/BJbXNTHi0mcfxgaT6Y1/KkOJThfox8fnSUM1+cJXOShOK
   O0oLA1CZUJgx13X5bEoWbSjKQwJq8SIDpwfAMouh25oC822/5jHdrLlWN
   ooBswoe+4dFywtW64px9PCuMEvS1nD6aW6ul2P9EJi5pEs07yP/EARvnA
   TgYnW1mAr4a5XY06G1IYLYYQ0uzw3ssNYSilJ8AcDAzQ0Ft+Jtiosl8qW
   uGUK+qVYieq695FtWNyibHD2nwsiblOM/oGzWPLz5W8JStUBZSVEa2MC8
   ec9JHgZvKKyv4RlLRMWyqgtE1EOnb6NgjK/zZbV/Xiuc5cW2DPCqw02VW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393772631"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="393772631"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 02:37:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944609425"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944609425"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 02:37:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 02:37:13 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 02:37:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 02:37:12 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 02:37:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyu75X+UMQ+RmHDyceQ4rcVcHyxdKI59MoP8n3ohwJFPMOwVQxsHvZuFWq1XKaJ8dY2GII4N9mh0NzvS4Sid5YxH1XETxcKYuBIM0XRv5/f1KlyGsjp2g6bi/qctp12psmxJj283SuHfhspPov6XPu/vclwHk2LBIl5qHUustZVf8yo1X8UY6u5JXSHjUy62QWunzSzAW1fbeb2DKuusHEzoMRS9z4r1p+bRE4MGhODnbfteB1FRP+V4AeDGrxjNJVDXAJoBY6KW9X2JJlt5DJYIZUoe+zSbtQFub6XKDUwt9mfvYYqUEiPaW5tOad41CbXWx1GrglYhZCg+pXVWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJFW36Ru6aB3hQ/0KKR/Yykr4Y18IJ5nJjJTzkfSBzQ=;
 b=i8pHbPt2z0WW1eoy3RvwVsi44Mc7THZbCNMfyfEHrlx57btkGPumpWnoBCgSQpJMGmX5B0QEb+DtI//wtEF8xaYCWLn9WlW5WHRXm4MmKZKcLk6cXbiH5x77dNt9ARqDFECduOpC8vRIdo7Q6hvnQf156Z1X9FHEHoTaT5KUobzhd94x2DKG5T7Nf9UlUTPot2RgmBR2rOBlb/9coV/t62PFoc6TtLDR1XM8iU6vPMKrg1hjyhvBANgz/Ncf4xCTprYZNAnvdawq9sFrSNhOgycck90W8yPqoi44Z7l2187WmEkps4YJgCcWSrObUdX6O3+cMC1SWW5t7chCRZg27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 10:37:09 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 10:37:09 +0000
Message-ID: <14be0220-65d6-d0cd-e0da-26bcab4d3d1c@intel.com>
Date: Wed, 6 Dec 2023 11:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net] net: ethtool: do runtime PM outside RTNL
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <netdev@vger.kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Johannes Berg
	<johannes.berg@intel.com>, Marc MERLIN <marc@merlins.org>
References: <20231206110304.05c8a30623f4.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231206110304.05c8a30623f4.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 337e3f74-004d-4bed-c873-08dbf6474bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rnu0JJlPCIO6RuN/A7fxIg/05Jd64yriUTOb0YyDBpXTUCWOG0GFoLwB48BtT0m8U539G6L+aJqwLBBoiOO2irnzlsslYl3hC7UQ8ntbZM1uHKQd5QPOaqnOPPb1l//vSl6N56PTIRDRBLhLKyPnu/402Dpqit1l8HL2zCLvIsnM+ZoiIFGmGzL66gZiv4qfwGfMsF2HD7U59RlsYr1oEg+52dLltUego5ME+VHPHGy5qSHIEBzxkUclBLkd5uekrjATgdKXCNLa+zFagKuEa4BsAgAfCfcF5CHflROK/+FXWpeMOvG2vEtagvf/TAD542ZRkXC550i5wq8XhA1XopdaV0SgVAsR2PSdeESQQodf/8fZjcLb92rgSCSko45PSKIYl0SZJhtMbkwVw+hG+dnGAkYBSbSykEbHc0IT6ETsTIcxaj/7b+sonHP6v9iemQi1yP/RfSQHhuvou9vgfBZys7EV6XDVMp8KrXwxIYx6aUiGDp6R4lEnDTZTY530O9hzTJnxeyzJ27SD7enXyxYrq2r7NtdwlVthOooXd9RtIaIAg0Mb2Z6Fjfhq0Eck5YoUAgefP3+tD1GYriEFA2830r63BVXHCbv2UCaK3enNhTF1p3hElE6Lnb1qvo+ZLWFS+WP7f/rwQUsKFFG5+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2906002)(82960400001)(83380400001)(6512007)(53546011)(38100700002)(6666004)(6506007)(26005)(2616005)(5660300002)(478600001)(966005)(66556008)(6486002)(36756003)(41300700001)(66946007)(31696002)(54906003)(8676002)(86362001)(66476007)(4326008)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE80ZlRzdjFWMVZFeklCcEZERU5NbTlZTkRjb3c5WGJBNXJMeEhKRTlZR21X?=
 =?utf-8?B?OHYwbXhJVWtvNW5kSzlOcFJvRGxSQzJZYyszWmh2UW8wNGZ5Z285c3pmNFVk?=
 =?utf-8?B?ZXdQV0htdURrZ3NqNmtlTHBmdmd6eTBKK3RqUHNQMTdPbFZYNFE0dWZWTEw5?=
 =?utf-8?B?bEZmT1pVT0x6RS80emd1VkF5dStYb2V4OTZteHpFVG1WMUgwdTJwbjhQdlRo?=
 =?utf-8?B?WlRRRkVlRkdkT2Roak1MdmRLc1cwcEFLVkIycldLVXN6NFE1aTRnQVFBb3Bw?=
 =?utf-8?B?bjdic2pHcVNXZzI1VXdkZGdtTXZZN2RDR0E2RWlGeC9wYnJ2cDNVOGsyc2Zu?=
 =?utf-8?B?aVRXRXZWek0wb0lmaGQ0ck1PUVFBa2pJU0ZlcGlyQ1kxaUdINDNEWGIrdXN3?=
 =?utf-8?B?bUhKUFhYMU9HbnlzRDNIOTlrTXZTV2NTdm9PcVZFbmxOZ1YxNEZOYXhRUlcz?=
 =?utf-8?B?bW95SGhYTWUzRXArQ0dKVExNckNHOTNUWThJOGpRN096ZkV5a1cxekNlQi9R?=
 =?utf-8?B?Skd0c3ZBSWluNUhLODR2aXQ2bURoUFJzMmljVFV4SjRVdXRPUmlud1dvd1hL?=
 =?utf-8?B?UWQvK20yUm9TK2o3bW9sNUxvSGJSaHMxdFE4QlVFczRoOFUxVDhpcDB1a0dx?=
 =?utf-8?B?NGFZbyswaGRSS3R4cVUzTDBUMWpZUHlEWjJxbUZ1MGRQMktmbXc1ZEVyY0o0?=
 =?utf-8?B?dnhNbDRuNHVtalRpRmRrdFVFaVhTZDgzRUFUY2hPTjN0WjdUd1MrTTJmSDhS?=
 =?utf-8?B?dWI5Q1RPd0xBNnJRb05CMEI3TE0zVmk1MXZvYlA0ajE0ZEh0THlzRGV1dHA5?=
 =?utf-8?B?Qk1ZdUIraUQ5NURZeEE1T0RxaEdkbmJMMzJVMzdHOFRVcXp1WGh5dnliYUkx?=
 =?utf-8?B?eWtCKzZRYVFCTUlsdjljQkVISTRobldhSmVQSk41M0NPdHpZTGcva0dvNHBr?=
 =?utf-8?B?Yy95bTV3QllzRzExVGtKejFNRWF6bDJETnYrZ2E2dmU1R28vekNLTXVnL1NR?=
 =?utf-8?B?cys3U1AvMVhudnpudGt6dHlZVGo2ekdOblhaL2Nyci9KaDRMMjVWaDVUcU5y?=
 =?utf-8?B?dmlUVEhWblUxQ1ZHVkpiUElCUlJMdS9rUktqc0tQUmNwaXVoUlZ4OGN4ODdl?=
 =?utf-8?B?S1F3bFJRa3ZhY1Arcy84N2lTTjZkMnRjdFBLV3QzR2JRVzNLTG9xVVlDRU9J?=
 =?utf-8?B?bUphcHNhUlpuRmZoMlJZM0JXZ0xmR3RZOTF6QStIdUdrdGU4d0tGL05DT01n?=
 =?utf-8?B?TmZFendVTFZxbWp4RzUzZzcvdFN2UUhPYnduMUpVOHN6cUg3c2FlbzFxVmNy?=
 =?utf-8?B?MVhjc0xhR3hsOTNnclBzU1dRZURWMDVNcmlFUU8xY21BcFA3dy9vSlFOeUFH?=
 =?utf-8?B?emZZOCtPb0hjSjBJbjBmZDI4ZkVDYzIxbDE5bkY4bWx1Mm43T0Rjdi9IZTJC?=
 =?utf-8?B?eGtORUVEbzNpZGRQcWVtVkdMWlVHdmI5QVZNcW51Z1hKMExwdEdIYU5DRml0?=
 =?utf-8?B?R2tWK0R2N1dXQ2VtRXlZN2ZsMkpZT0VTR0dpZWNGYXphaWJUNTlBOW13d0hL?=
 =?utf-8?B?SUt3OHllallxQk8yN1dpSWdXUVIwcVh0M3ZhL01lVGtYSjlYVkQveCthdU5S?=
 =?utf-8?B?RkpDMzFSNG16V1JISkhlSHJ0dXg4SUUwaUxCWGFpOEdNVnkrdWVWVDN5dVRZ?=
 =?utf-8?B?S01VbE51TWlWV3lmVmF2Vjd0RXJNWmhwakdOTVV0azRUeGFvWVB0VktvUUZG?=
 =?utf-8?B?dXBMY2NqRWtpWkIxQ00xZTErTzZpVlE5KzRGVVcyVVRGY1lXa2lpSjNDMEFz?=
 =?utf-8?B?UVZ6bzdkMlRWTC91aUVTVkh6M3BoNXZqaittS1VBekRxVExsNlJlaVhEMWI4?=
 =?utf-8?B?QWk3em9DRlE3aHJTYVhBVzEwUHJLbGIrN3dSbHA5YmN4Y3BaSmRkZ3dxNWVN?=
 =?utf-8?B?dXY3V0NydUlSOVJndzI1NUp6WTZUREdid2c5MUdneHN5WDB4dHZVOVpBeXFZ?=
 =?utf-8?B?NUdLYU1tbHptemplZ1RLMXB3OTRZajNGNGpHaVNBZFdQOU9iNzZCeDRNeUlW?=
 =?utf-8?B?WlhCTnBObW5LRHpwVW1GaFVpRWhPdm5FdTBYLzlLMDhRZElOLy9tandiazdK?=
 =?utf-8?B?ZytGRVBXSlhvRzEwRU92ZlQxbG10WkkzSWtBV2k0bVg2enBTK1hoUUFzTWlu?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 337e3f74-004d-4bed-c873-08dbf6474bc5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 10:37:07.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlRvFuQDgCHHmsSn5IBNlYBKxz6tyl/ssPGkt7E3vJKsfjw5E4tVoqFPAzJe0y0vSEdoDQAhJXF39LPaKwOYKMq+yNbnnZ84bC9ZtFnd4gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

On 12/6/23 11:03, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As reported by Marc MERLIN, at least one driver (igc) wants or
> needs to acquire the RTNL inside suspend/resume ops, which can
> be called from here in ethtool if runtime PM is enabled.
> 
> Allow this by doing runtime PM transitions without the RTNL
> held. For the ioctl to have the same operations order, this
> required reworking the code to separately check validity and
> do the operation. For the netlink code, this now has to do
> the runtime_pm_put a bit later.
> 
> Reported-by: Marc MERLIN <marc@merlins.org>
> Fixes: f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool ioctl ops")
> Fixes: d43c65b05b84 ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
> Closes: https://lore.kernel.org/r/20231202221402.GA11155@merlins.org
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2:
>   - add tags
>   - use netdev_get_by_name()/netdev_put() in ioctl path
> ---
>   net/ethtool/ioctl.c   | 72 ++++++++++++++++++++++++++-----------------
>   net/ethtool/netlink.c | 32 ++++++++-----------
>   2 files changed, 57 insertions(+), 47 deletions(-)
> 

[snip]

> @@ -3070,7 +3065,9 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
>   int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
>   {
>   	struct ethtool_devlink_compat *state;
> -	u32 ethcmd;
> +	struct net_device *dev = NULL;
> +	netdevice_tracker dev_tracker;

nice :)

> +	u32 ethcmd, subcmd;
>   	int rc;
>   
>   	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
> @@ -3090,9 +3087,26 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
>   		break;
>   	}
>   
> +	dev = netdev_get_by_name(net, ifr->ifr_name, &dev_tracker, GFP_KERNEL);
> +	if (!dev) {
> +		rc = -ENODEV;
> +		goto exit_free;
> +	}
> +
> +	rc = __dev_ethtool_check(dev, useraddr, ethcmd, &subcmd);
> +	if (rc)
> +		goto exit_free;
> +
> +	if (dev->dev.parent)
> +		pm_runtime_get_sync(dev->dev.parent);
> +
>   	rtnl_lock();
> -	rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
> +	rc = __dev_ethtool_do(dev, ifr, useraddr, ethcmd, subcmd, state);
>   	rtnl_unlock();
> +
> +	if (dev->dev.parent)
> +		pm_runtime_put(dev->dev.parent);
> +
>   	if (rc)
>   		goto exit_free;
>   
> @@ -3115,6 +3129,8 @@ int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr)
>   	}
>   
>   exit_free:
> +	if (dev)
> +		netdev_put(dev, &dev_tracker);

this `if (dev)` check is the first line of netdev_put(), not needed here

>   	if (state->devlink)
>   		devlink_put(state->devlink);
>   	kfree(state);

[snip]

just a nitpick so,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


