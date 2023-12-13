Return-Path: <netdev+bounces-57074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA88120B1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391B01F21691
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689C7E79D;
	Wed, 13 Dec 2023 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ojo5CNGY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E5CF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702502801; x=1734038801;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8tY8a5B6Hb/yvq47D2rQAayBYxNeaoVSuP5ywludT7Y=;
  b=Ojo5CNGYhSYuJCm83hKH2YSExLz99b2E7YBFlcrrR4OF8qs9BTP2jIK9
   6jiZTcJBso+MYhxs7g21KszIJuJy8gsEce6MoamFEiWWTymKOaS0vfpLT
   KLwhtWCxy9dZWZYj0j208Mfgly+g03I7Tp4lCdWbEtuJ4hp+53itr8u7y
   /50vpGVn1zf2/9C1KqqSXY+DUGfqLceK443sibENcE8BVNlJn18R3aovn
   PwnmJtdIxvDL0yvHpfXSQ4bM+IuM0Sd6WgvBkzItEjilup9QVl/hUS13a
   2nq79zUbZPmemDA3s+o65lKVcO2oK6lzhqP3A03GkD1edA9Om14iXkfYi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2173985"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="2173985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767363461"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="767363461"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:26:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:26:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:26:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:26:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:26:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWFM3bVU04z9Iz35aIRreqDcp/UUz3bH+vDytc02ielGdY5PEKomqVYGsOXBinrXjy3L5Cspqviw75yvq/YEd03lRPyegHQNEvjN9EWPnE0R6+GBaTbzloSFN9jErxAtUnydlLP1Ye9cOIj35k8uY1ZU0OJY9t2G7emYI8JSZn6CIMeT7/2y99iX25t4A9+3MPer7HGOqsybgjFHa30C9Fj2BGRN+PmQjuUoK3FI20VJDIfT9auchHGPVnc9lyINRvQovwZcbqLZ5TFVdEBj5OfyY70IpHsezM+rXpRdDeVfm/vCXfcIntIBlS3aRgWog4qeh2pFm7k9jVEguast0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViL1UYG8ClyGlK2m3/TadJdmuu37OVEE09Lcvyz2Ufg=;
 b=jBMI3H3TXkm+NEpIzqnKcIQtYFu0K2btPxM4uM5hqx7Zs1wtBjQDKUD572MBO3P8juKmi0ZJNq17CVuVoFLD2kcff5eTvp7BIxI97dU8Vmm5YrG99eUdChjumr7Wd+OSk4on4N/xK8ZL6hVvGo3kvJaKR6ZuNcANQWASD27UXIvlmwwtX1AStDc5toHxn9yVATgJMkd/4PLtYFyAj6jzEYY0xLVTK/gtNBcOAjo0UZLFql/4SCarzkEDN/3QPUbum+xamQ5PDxl5H3Eze5Q68YY2ycggnqkHJV3FxAIMSvHkH6Giuk2Yph9bW9cw7YyFP/zJw6eL3Taht4rjgwaeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:26:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 21:26:37 +0000
Message-ID: <84e12519-04dc-bd80-bc34-8cf50d7898ce@intel.com>
Date: Wed, 13 Dec 2023 13:26:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-12-12 (iavf)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
References: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: b1667035-6ccc-49de-c1c1-08dbfc22303e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmu7QGgt5SeRrSYcZB5qhPgHuuW2KbJhnettuWWzRpE+eyQgYW+bCXrMsQoXFy6uI+3+5OdiHvLR3cPGuNh/SVs3nRfdCRtQEie3gmfagbu+2YaYs8Ig6D/s70dFgQ2bItSzbgjksKpZ8Lc+BW4VEUzu5EniNtu7t7XcvismDwcbBPhK3cCF+Plh2lYOkdV7q1C4xn42EWw0vNqB88/1uVG8XbJyDOg5wC5PtYfc53QeOmQbABiUZeZcXfFSu2VHNQmMYtkoJCSWqwwrQDQTbux/HJGGzxx53dTCBidvXaGfBXoTtEoQ7QnZ5Yc9yBG5vU/Kv3POzkuPWPLH1T+cS+5VEJ0bBuyyXmgkyumQzw8DtZIGgUWB+8O0VC74U2WQmMiZqz0q7b5OxWi+T1sFsafmDbe70aq/ILPPugDPrGgoOEDkXQQtzdw9ab8i83dDy7l0Kan8xP5Dhsx+dsv22PjOtXP/B//isql8p9H337khjDqTUes/CH+HXcAE5C56b48NlCKfeGSuw6zxnDSKrghJoFVz9mJDnvFyPxaE7wzEq1SwZX5oekkBETzoyJx/V2WRlHBmB12/p5H25U/coMGIACvp+rdLT0y0PilOrJ2r/JDkX1qlwGMgJnQuVnamwERVqhj/y2vznfopzOiUfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(66899024)(66476007)(66946007)(6666004)(6506007)(2616005)(26005)(6512007)(36756003)(31696002)(86362001)(38100700002)(53546011)(82960400001)(83380400001)(41300700001)(478600001)(6486002)(8936002)(8676002)(2906002)(31686004)(15650500001)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdIb1FEQVJ6ZjJKTThGWTRNN0VwUi9MYjRRenNQa0E5OG0wa1paMUxmcTdU?=
 =?utf-8?B?M3AzL1lkaWJVWGVrbFY0ZnRqeEVJTndqR09zbVZxVlR4UlNVWE1TZWp1THkx?=
 =?utf-8?B?N1NiTzZ1N01WVWxEOXZha2FUeW40aE5NYVhYb2VEOTQ3dGJ5VEJjZkpnN04x?=
 =?utf-8?B?U1dHU0lZcDRJZGZjbWNoWm1kdDdXa2lTaVpNS25YVjBQOVIyY3c4RlF5bnhQ?=
 =?utf-8?B?NnZKUU5Gblc3dnorbVpzZ3BaSnp1Y3JRMzVrYk55K2VSK0Nnang0bUs3R1hr?=
 =?utf-8?B?T0xoUkpFRmZ6RHFiUHNGNFdid3g1VnlrOFRlNEJxQ0FFTElvNFVVcHVrZjVX?=
 =?utf-8?B?SWU1YVlvOXREWDR3ejMvYkYxdDZzZXZ3R29FelA1Uzh6WFhrN2loVmExZmtK?=
 =?utf-8?B?ZUtKdHAwNUJPTnJrdkt2ck9OcXpiSWVBK2VaM25MRUZZWXIrNlkwY3JBMGxJ?=
 =?utf-8?B?RkQ3d3Jqcmpia0RxSGtlNmpxNHhsd3psVkYrcjdLOVpvQkovaXBiaXRpamNI?=
 =?utf-8?B?aVBKM1p2VThUcitFYmxVNVlnUktHKy91MFBNckU3QW5kcUpaYlFuVU1lQlJL?=
 =?utf-8?B?NTNtU0ZCSHRGNW1BZGNiQkVQMFdlNmd1S002VzJjSkt1ODVJQWY4VSt4UTZi?=
 =?utf-8?B?UUtFNXE2Tlg0Wkl5eUh1VEdtc2ExeHh0M2ZlMWFzcXFPQ0JFQ3pCS2R1c29C?=
 =?utf-8?B?dTNVKzNRcVJGRWZKaDZ3cCs5TkNPRmpZQmlHNks2azZZbW43M3lBejREZkJh?=
 =?utf-8?B?U3VMQnlaeGFOa2NrZlVoUnlrbkZNM05mQTIzS2w4a3RuUUN2ZUlFaG5oMzAv?=
 =?utf-8?B?aUdmOXU5bElIRkJ5SFVTelJmNDB0c2U4S3NVR2lPZzBYZnNONVlSWEZXRFhr?=
 =?utf-8?B?QVBVQVVma1Fpalh5bnI5ZWNqcnZ4ZWlkcUJvcFRKUCt3WDFRRjNwelVsK0xj?=
 =?utf-8?B?bHdmWUxUOE15WDlOOWs1OHlPVU9ud0Y3Y3ZKeDNVdW5LN3B3akNHY0NWSmFw?=
 =?utf-8?B?NXliRFhWRk9VbmE2NXlXMTBGY3BFb2swRkVOQ1BIYXdqcWlNaDlMV3pab1pl?=
 =?utf-8?B?S1B0U002a2Y2ZFBSRDNSZ0xJR0JiS2d5a1pIN1N0eC9YczVMcjg3aWRJVitO?=
 =?utf-8?B?ZThaNHgvNFprZjBsQVVic29oYTZTUnFWeFFucHJsUzRFbGFBcjFtemFsUU92?=
 =?utf-8?B?OWRSUUQ2V09IM0NNQ05VYkptM2taM3pib3lUZ3FMZFA3ZnRBWDJmVGhHSUxE?=
 =?utf-8?B?bWd3bVY2YWErcTloZFVQZ1JQWnNqM3UxR2ZCRmpRZm5NNFV2ZGNoREJJOVRD?=
 =?utf-8?B?cm1wUUNGNi9UM2lFUzVieXJlZ2h6Uk0zSURXQzkxL1RjbmVMVzI5VWpxcDZl?=
 =?utf-8?B?ODloYjZjM1FiSUFnenBMRGdHd0JtaStzaWc0UVlqSHZxQndLWVdrNi9FRGVJ?=
 =?utf-8?B?NlIxZkVvYVlqaWMvZXd4bkVNdG9JZDNHbnIxOGo4QUdVdzZMcTZEUnJuL21L?=
 =?utf-8?B?M3JVU3V5Lzc2ZFBUS2ZZTVhkQlpJRXMrSFdwWFNkaUVteDQ3ZFk0aEpuOHBt?=
 =?utf-8?B?ZlR2dDJOcnc4WlFZOUVNOTdQK0Q2cWdueXZjS3hlWkw5TnhJc3RiOGVOeGla?=
 =?utf-8?B?NE05TGFEbGsrczJBU0JweFBWT2J3N1JBc1VsN05MSnpxOEJRK2RLdk1hT2NI?=
 =?utf-8?B?VEwwVkN5N3BnT3EvNEE1V1dqa2laZ0NOdUg4ZGxmTkxVTiszdUtrRmdBYTdI?=
 =?utf-8?B?L3ZhVGJPNmhsQ1V0QzdPWnI2MXZqd1lsSTJ4ZUJmbkJ0UVFlcEZvNjgvNExS?=
 =?utf-8?B?QWZCUkNDeDluNnAza3pvZEZpL0xXbWJFWngwVVpNU3RoRVhpK2F1WUhUNGFp?=
 =?utf-8?B?dzc0UCtxeUUzdnJ1dDJFTWtYNlRaQzB4WndXUXF0V2J4aFhFUnMxUTJGdEFp?=
 =?utf-8?B?RGxPTlNaZTFYbm9QZW52YUxyVjZPM1AzODltK1dQZGZtYjcyWXlSR3NsNzds?=
 =?utf-8?B?NG9GaVVXY0p1c21HSjFBSllJSXBORG9Zem45b29KcVlmaVkyZVVMdXJqZGVp?=
 =?utf-8?B?dWpZczQydndMYVMrdEtzRUJJb2xFc0pYR2ZmbkhoaXZpVDBzdExuUm5FeWcr?=
 =?utf-8?B?V25hREt5WEZqRk9iOHRvdVNiemFyeW1JL3k3UlgxVVVKYlpaS09WS2xNTVFp?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1667035-6ccc-49de-c1c1-08dbfc22303e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:26:37.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9OGSDynY8eWKdLeqlOPSuMuj6JZpYNyjCBoE6y7GJhmL0JE+hSRwkRQ79cKDTtTRAvyGywqR9X5CTwYdzZYg6rGy6QByGqIzvUXGiO6Bek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com



On 12/12/2023 12:36 PM, Tony Nguyen wrote:
> This series contains updates to iavf driver only.
> 
> Piotr reworks Flow Director states to deal with issues in restoring
> filters.
> 
> Slawomir fixes shutdown processing as it was missing needed calls.
> 
> The following are changes since commit 810c38a369a0a0ce625b5c12169abce1dd9ccd53:
>    net/rose: Fix Use-After-Free in rose_ioctl
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

I forgot to add that this will conflict when merging with net-next.

Resolution:

@@@ -1435,11 -1436,16 +1435,15 @@@ static int iavf_add_fdir_ethtool(struc
         spin_lock_bh(&adapter->fdir_fltr_lock);
         iavf_fdir_list_add_fltr(adapter, fltr);
         adapter->fdir_active_fltr++;
-       fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
-       spin_unlock_bh(&adapter->fdir_fltr_lock);
  -      if (adapter->link_up) {
  +
-       iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_FDIR_FILTER);
++      if (adapter->link_up)
+               fltr->state = IAVF_FDIR_FLTR_ADD_REQUEST;
  -              adapter->aq_required |= IAVF_FLAG_AQ_ADD_FDIR_FILTER;
  -      } else {
++      else
+               fltr->state = IAVF_FDIR_FLTR_INACTIVE;
  -      }
+       spin_unlock_bh(&adapter->fdir_fltr_lock);

+       if (adapter->link_up)
  -              mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
++              iavf_schedule_aq_request(adapter, 
IAVF_FLAG_AQ_ADD_FDIR_FILTER);
   ret:
         if (err && fltr)
                 kfree(fltr);
@@@ -1469,6 -1475,12 +1473,11 @@@ static int iavf_del_fdir_ethtool(struc
         if (fltr) {
                 if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
                         fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
  -                      adapter->aq_required |= 
IAVF_FLAG_AQ_DEL_FDIR_FILTER;
+               } else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
+                       list_del(&fltr->list);
+                       kfree(fltr);
+                       adapter->fdir_active_fltr--;
+                       fltr = NULL;
                 } else {
                         err = -EBUSY;


