Return-Path: <netdev+bounces-51680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21067FBA45
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E1D2828CA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4442E3E8;
	Tue, 28 Nov 2023 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etp9JDri"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A733FD59
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701175153; x=1732711153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z9A0nHC6JwObVDsFMxN8xG3vDaUsrSzVw+2zb+R/rWY=;
  b=etp9JDri2tpFwIvK7zdY/rp9rnFUhH27L1JHzy667psTOzDR4cnB8pAm
   cfH3z9oCoOz38AaxbG835jfGoBl58iYzuYWV7HZjKjkiyhx6Fit6TE/YS
   PiBx2dpuUB4GIzTERm7VqGkFW8KS/vLhasCZffRrMVsO1MdfdEUrd7ROE
   vTm8OY321pRKH1v14cWfbx5mXO+M4jhQjb4/nZ24Kb2QPMQ9/wT1OlBQm
   3R7aY4AWe2CiH4E+j0voP0g4GJya9GFZkmy1rAsD1eTJkCeovi2ok1C42
   4yN7WuDcojE+OhPwNxwDDTeK4BAsDBUNOeeY+iaKW0xyFoYg8JYs6SuxJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="11612530"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="11612530"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912421571"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="912421571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 04:39:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 04:39:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 04:39:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 04:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeXelj0GfMzMQTOxacPxv31xiikm+tet6NOoGH22ooUl67HnqM4rF6bywVkIHxRILvEC+8bn5zmYe7aoLFEDZX7jhkufAJGo3nplfGgnIrGjaZYKD+cERdZGjXCBSHl3cJA1eFnGCmddHO/hua3bXTzcHGVkvLn7w1hNKaNZqV59kZP3NOOxlyLaZDgpOFDrO5fEK9T8ksMc29LjFOMhqr1PF+PLWKbagoekcegduMDR5iAR+IINvPpUBVJMjT9FoaoSC2SjBTFSDKoQv6GkYABFgdLA3cnBWQitghScTepeQa+YcKsHlJ6vkV1xQc5ye+VMjwEJrXDx1NjNdG3EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h6nM8iDbIURaOmiXhJ+vTo3z8foUK+MQxpTGZrBzfY=;
 b=NUJCSc1XZm+ZDZWgvWrZSt8YIvJatdjXVUNuoD2O48aN9z5vS4GtWTDkYXasSoUgo2j9sJzD4OPuYXsoSzpqAfIoFJdAAMzN35ZAU+lxG6W78zL6YZ6pGjMD+fDpjBGQdtZkK4N51gicd/sNlmsbxEH1G7OYcDPOnZwH7uHydvX5xpzmgF1CMDhnZVHXx9r9pb7N7XDoisux3ADOie6JlbJwkmVphxdBPlKU++8kwSMH391wScsTriClfOXH62aeTg5EEIXQT8eLpXW1Z1+vCj/cLi85yDR+eugakE2ODLoKVpiNhHQXRpLIgQAqhO66wihJt49zUNoPCIE/hiVnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 12:39:03 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 12:39:03 +0000
Message-ID: <bb4a8c25-a45a-7981-9b3f-b67d938150a6@intel.com>
Date: Tue, 28 Nov 2023 13:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [patch net-next 1/2] Documentation: devlink: extend reload-reinit
 description
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jacob.e.keller@intel.com>, <corbet@lwn.net>,
	<sachin.bahadur@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20231128115255.773377-1-jiri@resnulli.us>
 <20231128115255.773377-2-jiri@resnulli.us>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231128115255.773377-2-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY8PR11MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d70940-428a-4382-1383-08dbf00f00b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9RJtTrUHxOr/+v1ej6LMjSINrSM86Oq6khe2ddncxpwkkZU5wN68oRrRWjBWPkXsGQgHef87gMgsNajTNwMQPLiDGbHdUGyegMcyFxmNp1fgG9DyaneaaZ32ZsWctBamd0ZuPeEp8eOVvPqYTOarEJezOJam4sDpVCc14aJnqoiJgGGE/M4gO27csxmiY+1Uoak+orb+QBoteNELrM0JydPG7IojntWsfqvE5N+MBs2DTKTdrCrzwa1aiXR0MoDdX1RlrZXDZ+w7fuBURBcMJ8XeXI2+B05NRIfNIMqk5iiq3G47ddHA5vw/hCuUBqkNNcqeeNwM6bqkZnNX3CU4Gd3YfkalSHBqRTTL3JfDWnA3gI+hwJ4gh5vOtE9AAFhTumbh7QLlcpBHxywEnX924zMi2G2ZY0aSbH+auOnk4llIWwAg+3AY4Fl/Bq1oSHa4txlQvF/XBPyHRt9FrTM0nzgFw7529iRfy2Wb41krMWogy/s4Azfpab9KdaN+b3Q56xU3FSNih99P8nrl6M81IUnOu4sn8stxu6eJ/mQDCCfqQwRMqfk6Kytbnr4d+85GcM69IN9NI00yP0j6Xk14/jjGvC/659bSn/EaAKbWgMN8thHPoFp3FJGZiuer2p2PaNKbzZ/Pl4Ba5l+5E9fSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(6666004)(66556008)(6486002)(6506007)(53546011)(2616005)(6512007)(83380400001)(41300700001)(5660300002)(4326008)(8676002)(8936002)(478600001)(2906002)(316002)(36756003)(54906003)(66946007)(82960400001)(86362001)(38100700002)(66476007)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmJKeXVDV0Z6QlhhOEJ6Z1V6SEVLOXFJSkpJb24zbHFiZDdhZmVHQXRicXpr?=
 =?utf-8?B?QkVYRFBVcS9OUUx5VzV5RG5tTWxSaHZ5b3JSbTFJY25tWHJ5T041anM3K1BO?=
 =?utf-8?B?V1lRTDJYZjZUOUs2eTZsQUh5ZkFLcEdzUS80WkVDbGl6NElSTFRSd0I2VEho?=
 =?utf-8?B?UUFHbHNDNTV2SEdndWdkZk1Xa3NjY2FtYlVXL0RCcGxUek51YjNaUXhtYkhs?=
 =?utf-8?B?eWtpeUhxVjZmV0RKSVlPeEJ1SjZNUWVVZzVkaVpVd2k3VHVaT0piSytPaVBK?=
 =?utf-8?B?RVQwLzgzNG5QbTA5eDRVYmd3WW5Nbm5HTmwvTjdlWG1FRU1IbFFsODFWaW1y?=
 =?utf-8?B?WnBRamVyRExuQW0yNkFZcklMT3pQVWtHS3FUMndMUGI5b3hxSS92ME83VUht?=
 =?utf-8?B?a3laMVJzSGJySmxPZkxVdkFPbWxMdzVKL09tTURHMElJYWJFMXV0Q3ZxVEJY?=
 =?utf-8?B?ZWIxaElwd1ZHZkJkZUV0QVlNOUdxQk5iTWFiRmo0SGFtcXNBRnBwdTJvMTJs?=
 =?utf-8?B?UWt3SnJ5ckpCMURPNVQzVVd5Z2JGUkpVSmwzaWd4UkNUUHZzRndJMXN3UDJI?=
 =?utf-8?B?ZGxIUitzUUhKMEl1Mm1FV2dTQVI0Vi9RZmpOL2hlblVmczVpREt4Y1NCeW9I?=
 =?utf-8?B?aEVLSDh0T1hMdDdIUFZTbkNXOTI1dmNBMkZEQXdNWll2M3lXRVdVaU9oZEpD?=
 =?utf-8?B?dXl6Q3h0eUN2YUpIcFNXdERPam9DR2hTemZWby9YUFVtRlgybnBkVzg0Y3ZI?=
 =?utf-8?B?SFk0QmxHcmFIejFhVDhLSW41RjRoN09DNVhXTlZ4bnFxWkJka2l4ZTEzN2FF?=
 =?utf-8?B?VzdUL2gyYzlNYVZXSnZjeTZNU1oyVmIzN3oxNUFxOW01L0VCckxFbk5Ld0xz?=
 =?utf-8?B?aDFIYkRTY2hSV2pZTG5tRENmdXFPSm01RHMvVTFXUFMxK2hxU2QvNzRhZm8r?=
 =?utf-8?B?aXhqNFBwZVpJc1czbjZkdVN6OVdjNTZZRHFvd1ZUamZvcFp2T2NrdmMwVGVl?=
 =?utf-8?B?KzBZTE9vdWo1eFU1NVBZMFlYRzFnbEs2bTVBTXk3V2FiNUF3VkhpL25DZmlO?=
 =?utf-8?B?eWVVUVVmcGNVdXBZNVRERmFtRklCU1RJRDdjWDFOdjdCa1l5R25xcnE2VzU4?=
 =?utf-8?B?anB3R01pdHNYRE50dFgwdk5tRGlmVE5xeWN2M0xQZXlVdXNxYk5zalNtdG03?=
 =?utf-8?B?MmFCc2ZCS1FzWGkxZ1N0R2RoVk9IM25nWnpUa0NWZFZTTUc4em5OZjBJVGJl?=
 =?utf-8?B?WnpDR0VLNmtWMzhOaktCbkRuMEFxVit0NmdUdnREM2VINHhGKzQyT1NGUjRl?=
 =?utf-8?B?RnVnbXFSVjh4azA2ZW5RK3o3OXFvZmRvVHFLZlBqU2xxUS9tRVhFcDVDb1Fh?=
 =?utf-8?B?ZkFKQnZCT2JaS1U1TUVtbzNGcVVpbkxwRWhZb1UvSGNxK3VMampZNldscy9B?=
 =?utf-8?B?SjFva1QrWGRySUhzMFRUd2ErV2pJZXE3UDlxYVhxTW1GRnlXUHZjL0p4TUQw?=
 =?utf-8?B?bW1PbHhGN0Z1ek5iUzFIbVRvWnVhWFBPakUySVJBbFlWUHVOdEQrQUxUVG1G?=
 =?utf-8?B?L3hFM3hWZ2xXQVl1ZE5qY2p2MFRILyt0ZEdBSzBiTjl0bmI1b283aXZRWjBJ?=
 =?utf-8?B?ZVRCelFzRHB6dENpMVNCNG94dVU1RXFybGRraUk3N2djNjIxOTFYV2kyYlNJ?=
 =?utf-8?B?NDNuUlp5b0I2NVRnODJHOWMrL25VbEY0a25lcEMzYzVaQ1ZHR3FzUXNoWUpB?=
 =?utf-8?B?UUdoMG8reW5nM3hDTzR0Q2dvS1FaRFFZd2M1UlV4TzREZnduSC9vS3Zramts?=
 =?utf-8?B?Q2wwYWJCREp4WG5Fa2d2T3g0bkQ2VUp3V013YStOalgvWFNkY2VnRTdDbENP?=
 =?utf-8?B?SWowdThuZklvK2JGS1NYZGIvSFRkMHlhQ3Q2YXVtS3dQNXo4MXl5UDNQd1Rl?=
 =?utf-8?B?TmFyNXlIYUJRdElWODN4ZklCMXltTUFDNGFLNW5jdDFqTjFRMURDVjNNZ3Bn?=
 =?utf-8?B?dTU1cDVXS3FXa1FkYVBVVEc4NUpBYVdoenRlWEhXUktPZ2t6TEFUSHRHNGdO?=
 =?utf-8?B?NkZRUjcrVmhtK1AwaEx4bnhuOEtQNEVlVExRZ05QcUFTdWxBbEdoZnNsaFJC?=
 =?utf-8?B?ZzVzRGJkUDN0MVRrTStsdUhHc2VXU3pRN3VNbnF6RGJ0MXJSSXJvMldhN3VG?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d70940-428a-4382-1383-08dbf00f00b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 12:39:03.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zD4rKAUWceTbiqUYaFH0Fsa7VoOKNU9JNezPofplXjIks3DqUMm/R5DKac6l8lRuCFYghnwdZ+TIsth7L16Gf9WLhoEjZ0Ss3FzD1f3BpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com

On 11/28/23 12:52, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Be more explicit about devlink entities that may stay and that have to
> be removed during reload reinit action.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   Documentation/networking/devlink/devlink-reload.rst | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/devlink-reload.rst b/Documentation/networking/devlink/devlink-reload.rst
> index 505d22da027d..2fb0269b2054 100644
> --- a/Documentation/networking/devlink/devlink-reload.rst
> +++ b/Documentation/networking/devlink/devlink-reload.rst
> @@ -22,8 +22,17 @@ By default ``driver_reinit`` action is selected.
>      * - ``driver-reinit``
>        - Devlink driver entities re-initialization, including applying
>          new values to devlink entities which are used during driver
> -       load such as ``devlink-params`` in configuration mode
> -       ``driverinit`` or ``devlink-resources``
> +       load which are:
> +
> +       * ``devlink-params`` in configuration mode ``driverinit``
> +       * ``devlink-resources``
> +
> +       Other devlink entities may stay over the re-initialization:
> +
> +       * ``devlink-health-reporter``
> +       * ``devlink-region``
> +
> +       The rest of the devlink entities have to be removed and readded.
>      * - ``fw_activate``
>        - Firmware activate. Activates new firmware if such image is stored and
>          pending activation. If no limitation specified this action may involve

Thank you!

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

