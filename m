Return-Path: <netdev+bounces-50011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E537F43E8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BCC1C20ADA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509DF1A5A0;
	Wed, 22 Nov 2023 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/dsImI2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5A93
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700649104; x=1732185104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SiFi5t/lJ/MrWrkWAmEukQ4tyyy1cdQlg64LEg+E6Tc=;
  b=Y/dsImI26GUjJDEje2m5wgpGx1PEOdT/VxF3i76zVvjleLdN8uZ/osjl
   jOqfoquZkEDc2J51OGTf9EAMmaoR3ukFrnfUrTBF/6lZZDWhBoGWbu6um
   xgPPT8QHVW6yAm0dVQVeWh9z8Nn/C0JJcKSa+UgfeILT0616kHppjepk4
   c/ThXCp6bR2Xfteu+zG0Uv4bj4p9b9dfAO+Us6hZ6LRHNc0+1EFFaGbtd
   8a0JLu3RHy4vbemzlDv5pPKmuTtkwK7UFQSPdl0HDGlmJyHSD4tjFBywN
   1/CABfuVqXYy87RKKjnKOJWAOmL2AM+h35+YXa+cju16YtXukTLJlFfwa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478235462"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="478235462"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014189190"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1014189190"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:31:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:31:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:31:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:31:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW2zFJPtrQDz7VuzWcs1Eg2a0/zkE0Mi0MTgLGNUoMpRbCTDwLARHROCTJXvFMeU0l/D29Cmw6XG47v6PjzCZB+9zqx17/m5pUr/9c13N6dTgvy54PcbtsgdRU2lezPd4lUFgGIpzhKBLJ/q+gSsg+JY6dA1rirw4VmtLwoZ2v6cAD23SmqFqPZmY/iU/KZ9wdC50qYPu7B9VhiiM/bCuFvTMq4ToRlH2U3EgJqehTLAI4z64ciNSDWL0HH3hSRtCniQ5IBRzqqTQkBc9XJjcbf8aP2y5QoAYxT8nKVmfJtPVuVRyEDqFsm+/kDDl67c62vfNFCujXA66+2jleQySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpMhDS88npeB5Ym54RAPtTS8DsmiS0OCW907QcEmhfw=;
 b=FFYRtgGg9pYRN76Ap50EAjoyhhEv38ZlF8POm9kKV8JS7Ienl4Xw/IBxixyshJNxqfkLVKT6U8YYUh5VgR784vjsIX4+gyzL/hDm5HzwQyjEEt6ozacXLYIF32ua4EmZD6I6gHuU8yK2QRiG9W3idttmjaf4FaMPlBOSYmSueRRBSidaFLqKcA/saWscpnY0bHkNvf1bbzOCL9JgFNxfeRP3CBvz6OKwJJxrpmjb5jFbGYGiYk6Rh+PKnMDTWdOt4RHbcO9uERe1QpvpVye8S4BI0t1X/kfkaXk/Sg2YaTu9d7g/Oei3daIeiyUEf63/6rbwTMilLfy4qr/vLWRb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 10:31:25 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:31:25 +0000
Message-ID: <2f92839a-6cef-4707-a0cb-68312ae4e6d1@intel.com>
Date: Wed, 22 Nov 2023 11:31:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] amd-xgbe: handle corner-case during sfp hotplug
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
 <20231121191435.4049995-2-Raju.Rangoju@amd.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121191435.4049995-2-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ec4b00-84a5-413f-d0f2-08dbeb462cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9p45fUvjvDiuHoy6IeWsyUijbeGVaChPUZKDi9avfnnoSDeynMhb+E/Xz78JxtGJQtQMLFToHDhxeQIknk2p40wza2/OVWXmuEyDhIC8qRCh51snlP4ulFSqnJ91gXJl6aCYRPMpI56OLxexdV0KUBdAprvQh0YnUBjxE0ABZwplLIs24LQ9ALFi5vYEY4EYwZAowgObV3YqPXaW/eHPtyA8OyiB8v3/K/7mHaHYe7ZKQlid7lHr8/le+oXdbfw+4X5/S9horPrnXkwf90E2XR3lWdffE+xfCfRpWbRelmYSVQxe2s26q/amtH3xxs+2vX8j1f+883GO3IBOGWlITrDgeUtQGHlZXVdnP7hVcrZx//9nzBWywXjyG5jpizW6XJiXm9dF/wNRUBJzQtrNAUMkANROj7dIpLiu/v919/iANXmXYJjT/SLZp0eC20ZpXazMuFFBNStKMHyS4ePddeQqNBlsP3gDc0EiDKmkit3ZpivxAJ9SPJVbMPNcxL5BlwwGW0UUw7pJWhkFmYaPPOre4WiBfe5xOy6Qibyfc6pixVfXig+WMEsiO4WNlN9p31rXtKzWuYmxy3SYBNQmpambqUqvQDJtWVZAB7aJvV+89wi655rK5guzKWyqg2zYxxgeEVk4Lp8E7spvE1MGMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(53546011)(6666004)(6506007)(2616005)(6512007)(44832011)(5660300002)(8936002)(4326008)(8676002)(41300700001)(478600001)(6486002)(2906002)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(36756003)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRZTnllYm1RbnVhNS9qQW1ESGVZMHlaV0xnV3lCSmhaZ014Vng0YkZXNHp1?=
 =?utf-8?B?RXVKNXNCbzczeEdsK3h6M2o2b0VGYVRKN2kwOHRqL1RZdCtYdENPWFMvbG4w?=
 =?utf-8?B?d2tHbUhQU2ZzM3ZHN1RJMVMwUEUzekZwTGFoazNQUU1aMSthaDQ4UXNmNlJX?=
 =?utf-8?B?Slcvc1FKdWFSZitISXdFWGcvNG9qR3ZkUVpDWmJYOURUbmRSSDB4czdWRUFw?=
 =?utf-8?B?RGNZMnl0bHJhL0RiZUovZjBWR1FzUkVtR2xLSWVNUlFOcDRESEI5NW9rOENM?=
 =?utf-8?B?OHhvUUQyVVEzZ0lNYTh6M3A2ZFZ6cWR1ckxkYzJBcGo3WmhWYTZoV2JHN3Mx?=
 =?utf-8?B?YlprcUhkcU5zZDFRR0NLUFFwaEgreXlvWFJQZUF2WjBWZnZlTGNkc0VkSzFs?=
 =?utf-8?B?TnRDRWFLazJ0WFFTLzJVdXVGNUVOTy90cjZudnYyTlVxMVFKVUcyRnoyUW9Y?=
 =?utf-8?B?TUIvVzloZzhuY05wLzljRUVLTFQxMDJibVYzVWV5ei9rRDllNTE0TzQ0aEJV?=
 =?utf-8?B?SmFCYzByd3VZMWFnVDNrQlk0eTZuQk9CWDc2VnZvcXNwbFlFbTJ2ZzR0cHpK?=
 =?utf-8?B?emVWWlptUm9FMStNb2FzMXA0RVE3QVdiWU5CdlZwejJPOVBJcTNlalV5bVJG?=
 =?utf-8?B?RGhqOW9TN05qbmZWQzhPYkMrRnQxYVdUcFFSSU9KNkhRblQxNHBZOVhBNy9R?=
 =?utf-8?B?ZWJEN08yWlRzQUs3TW0rTzJVL2hncXBZeExNWVU2aStxd2dTbG1pU2NqL3RL?=
 =?utf-8?B?eHRNaTY0aHVHaTVnd2ZiTTAwWTNUdkNxcnA4OUM1bjc0M0N6NktoUkxYUGdM?=
 =?utf-8?B?UGZlZDlwU2pnVUEycEZiQnpXMkRXZUhqZDZBK3c3bmlvRmJndnJodUt0cW9y?=
 =?utf-8?B?VGlBamNQaDFkTTAwaXlqb2IvckRlWGRqa1E2Q0U4NDg1V2lEbkt6M2ZxenF2?=
 =?utf-8?B?SHdxQ2tGMld6Ly94em0wSUh5S21vcTVlWVk0LzdrcmdocjltL1pTRWkvbHdK?=
 =?utf-8?B?NVU0OTVZZXdhYXpWVDNicDVWUlpveDNvcjgzTXBiRW05c1dYUzZzWjZGUzZh?=
 =?utf-8?B?a29pNDJXamYwUk5YVU5HV3pmZnhsK2F1K0grU1BlOTF5RlkrSEJZQ2dLZ3hL?=
 =?utf-8?B?MjR2YmVwWVZ6cWhWTGFaS1JJS0lEWFJqQ05TOVliR3BlZDJGNFdBbmlweGdt?=
 =?utf-8?B?YXpnazY2RkR3NGdmMzZTMGFWb3cwOXZGMFg3K0k4Ymw0TVRxY2cvRDJXdVdj?=
 =?utf-8?B?YVQ3OWYwcXlZOUkxeGxSZzdKSXFZYjdyKzl2dFhPaTNKajV1bDRlVFhweC81?=
 =?utf-8?B?WkxkdnVSMEg5bmsrOUIvSDlEN1hPY3llMUFMNjZCV3VUSElQZ1VNYlhWcTd0?=
 =?utf-8?B?cmcza2Jrbkw2KzgrY1llcHVrU1dJdDB5TmNWTVMzVDBxaTBLRFQ4b21TZEZm?=
 =?utf-8?B?dzYrUDF3UmJXZkZjT1BaRDRrOFNmK2RxRytCN0xQZjVoaS9Wd21hNGZwU01m?=
 =?utf-8?B?eGlpNk5oZ2xnZUpncUpPMThNTDlNWVFuR3Bta2pjSkt5NHcyTXVTdDZWRkRs?=
 =?utf-8?B?eU5ob1J4M20vb0dlOFhIdUVxcW84cXRmbjNsanh6SEhrdUNmejNpUy8yOHlk?=
 =?utf-8?B?RWtKVTZGZkhUcFJ4VGhrdFd4S29zSHM2Yzl2ZnE5OUhXY0YyblVVQzRQSWtD?=
 =?utf-8?B?RUcwUzhPSmMrSmdKVjRkTU5ndllPSjZoL3BIejhFdVFNcFVzT3ZkcVd3Qnlx?=
 =?utf-8?B?bXpzVVlJaW0xUjVNV2RxU2JraTA5aERBWVpPRGwvMm5OZ2JkRzNWbHllQklF?=
 =?utf-8?B?MGE3dmp2OWlDU090dExsZ1RBMGtLNFVwVlBubStLbVF4VC92MEM5ZzdqUUVi?=
 =?utf-8?B?Y2dTeWZ0MDAyejdIUmwrQ0hrSEx3TjlGS05iS0RxTmxIZUExUjB1OEJNSGpC?=
 =?utf-8?B?djBsU0JCYTh2aG5UUDZqQ2JwNi9BWGNDN01JeG1rYjZWSXExc3RsZ3JlanFK?=
 =?utf-8?B?bytmcGl6dE5PeUttMFVlM3luSGExY296b3M3UnJZUGIxMGowSzZGRTY0QW4y?=
 =?utf-8?B?YWRVVy8wV1hSMitYVW16MlY0UjQ0UDQvMERzOExMVUlHNkNxMjVZV3Y4eXJl?=
 =?utf-8?B?elBYZDVvQmFTTUFva2t2Y2Z3V241Q0k1SmdDU1pJQzYyVGZ0WjEyWm5pS0lt?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ec4b00-84a5-413f-d0f2-08dbeb462cff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:31:25.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6al4z/dfix06KkSAX4ANmhdFsZJosqqh85DWG2suuNcBTaAT4UzZIgpWB+tE5n00CfnPhMIfryAUJD3RgunYFUneX1aPt0QlOsIMwjci0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com



On 21.11.2023 20:14, Raju Rangoju wrote:
> Force the mode change for SFI in Fixed PHY configurations. Fixed PHY
> configurations needs PLL to be enabled while doing mode set. When the
> SFP module isn't connected during boot, driver assumes AN is ON and
> attempts auto-negotiation. However, if the connected SFP comes up in
> Fixed PHY configuration the link will not come up as PLL isn't enabled
> while the initial mode set command is issued. So, force the mode change
> for SFI in Fixed PHY configuration to fix link issues.
> 
> Fixes: e57f7a3feaef ("amd-xgbe: Prepare for working with more than one type of phy")
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Thanks for our patches!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 32d2c6fac652..4a2dc705b528 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1193,7 +1193,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
>  	if (pdata->phy.duplex != DUPLEX_FULL)
>  		return -EINVAL;
>  
> -	xgbe_set_mode(pdata, mode);
> +	/* Force the mode change for SFI in Fixed PHY config.
> +	 * Fixed PHY configs needs PLL to be enabled while doing mode set.
> +	 * When the SFP module isn't connected during boot, driver assumes
> +	 * AN is ON and attempts autonegotiation. However, if the connected
> +	 * SFP comes up in Fixed PHY config, the link will not come up as
> +	 * PLL isn't enabled while the initial mode set command is issued.
> +	 * So, force the mode change for SFI in Fixed PHY configuration to
> +	 * fix link issues.
> +	 */
> +	if (mode == XGBE_MODE_SFI)
> +		xgbe_change_mode(pdata, mode);
> +	else
> +		xgbe_set_mode(pdata, mode);
>  
>  	return 0;
>  }

