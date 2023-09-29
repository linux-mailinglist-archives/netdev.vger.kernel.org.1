Return-Path: <netdev+bounces-37116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7B7B3B00
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8FBABB209F2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3266DEF;
	Fri, 29 Sep 2023 20:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27120F9
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:12:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D7B4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018347; x=1727554347;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dHgk9744BCjRz7nmxwjXJ4v7uYQsrO91xCw3vzRHyew=;
  b=WYHF3UOIOzmxtKv2fAki6eoCzHcyLqQjM/nkLf/0lwc6YxZgrpPQ7YH8
   ovpa9rUb25sqDFqGYt13+0bJ6SeAORob6wpr/lCtJ3xZwv3W+WtAhZw0D
   uFpyKuvGd7KxolXNMLWu6LjRECkvHsK9tdIPOpXunxF2m2K4huVtVQuBB
   vVI4wCKoA+IJRnYL+c5JnGC9k2CnM6hAvcvKrSVJ1DL6snBiqv+w8Tmm4
   2bpeg1bmrlv/Bf46GzG9vhw5KZ7Ww6T6DtfW7t8uiXa6iYDHu51ftq29P
   qhbjht56PZoFZ8KzbrrUd8ABr3G6tKyX421x3Y0W4d2vHbY77vKS/IqC3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="446510127"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="446510127"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="726667010"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="726667010"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:15:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:15:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:15:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXCqlCag+ZSBGrSDP5Kyg/kngSdEgdBaLtwnARpuvRS75SX/C0fLBLL6Y041TyB0AZzcl+uJZssl/BVt4osVuauFE+3jo7BrSoh1bFGkCzwDwbFIEF3fMcfhGOy7JkqxPMzQg931DsE7SEEiXPDeKJTmChE0OU/4hgiwzsMD8+WkUPnxETFkrPxEv+tBMqzyNOkZfJQizJGbGkeYPqpZf4QXPIgnk62RYt07slyoPkGcCZoyf3HfAq/aqx/JcqDv1VH9FgarSF9n/SnZJhCuE7vbknyfgeGB2p9SZQpmC1QBvdNazpWzgqpfZRbgMs9ECcQpO1dVszHfX/tiPnc8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRauRPXV4K/EXDnl/egaXItyAuTMPG2c8PfYKUg6mSk=;
 b=D5NnRHBlCE7wNLnqW1PL+jzlNdmaMIy//ekmY2kblVbCuDpVghgVA9KekXBHipYSVp93s49OS6uYR8oimk/MAmybHQZDwOgxgmd/OXQNe4v8PL7cqgbCs7M35UeWk308Pa2vEeItW8HwJb2Fp19MshKHSEwf9Ibikckw2/f/3Z7L7IHoSCw+u18nqZB5eWnAzdt738zR3kftIYA/y0JnqcUk3TyM3L3ZkJcHGHKj9MP2KTZcW9myts+cU9vAA0Cy1LWQQFN66yI2GvZsZk3tcNAuJ7zDfXyBrbIV8NJcHNRwhAI3PWW1Dj4EA8+JHB+55sHUVQYIMPPZLbt0F4ZIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8467.namprd11.prod.outlook.com (2603:10b6:610:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 29 Sep
 2023 18:15:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:15:17 +0000
Message-ID: <f4e3fcc6-25b6-6c61-7736-485d3005372d@intel.com>
Date: Fri, 29 Sep 2023 11:15:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Content-Language: en-US
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <hkallweit1@gmail.com>, <nic_swsd@realtek.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <31cdf199dad8e26bd5f732fd04b0d640c41f5616.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <31cdf199dad8e26bd5f732fd04b0d640c41f5616.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e38f0a-faf5-4c4f-4e97-08dbc1180891
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVk/Q9vHv+dx1LNnp16mUWbIH+H11B9mR2zZhFTLRYN5to9uFMbWwayGmzT+8hiXGdgO071au26VOdkDzrIe9NwDplcn1luKD9U3X+gtJ7D00DZXG3vFeP8cYbY6qLyyR04ciue0QagOrkSGdqyoo3gc8gUsjX5t+zAblLyOeRn7kz/xmMzkaElV1KAJm6nMjPMTNCLtiJqPxgLDGM9sR8uIBz0iXfSS6B96Yj0z4RYeUNJ+jNQmFPJfP4eJprG6Sh8zclD14NG4jjpE6h4g+4t5QV8VIm7a7e+UXY2E2Od2BkvQPx27afwZ3Q5oUTVxCPj+uhhX4IN7cq4VhVx20ZM1YtObtsJdrZbP8BVe4m0iXn3BQW7pCYGoQAcceeTi21g29eB96J7/IVZzo8ArbPjgoDr2vfrdJA9l8KTzlIFTRlW1fatQ4AvYrUasjJNaapW7j13BNklHA1/h67FSmDPAnZw3LpAiKgs9sW/b/1KH1o59x0NTcnIOR25nFTw/OPBvy883dwUv4EPb8LQOrm+HrsJwhUuBcyeIanfoMg4NV1QwDMLksM2hgEV8zDaGU5h9q+a4e22lLxuA4RaidrhaPZM2RFsPpd/9imKRk0pTBt99OftjDJXly1Jz0sdAvDltbvabrYyHxCcWpymW0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6486002)(6506007)(53546011)(6666004)(2616005)(26005)(6512007)(66476007)(66556008)(82960400001)(31696002)(86362001)(478600001)(38100700002)(2906002)(4744005)(7416002)(4326008)(66946007)(8676002)(8936002)(41300700001)(316002)(36756003)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFEyZk1YK243a29TSGtsVS96ckNNTU51Y1U4ejBRZGt6WGdZbFhsRGtlVStT?=
 =?utf-8?B?NXlURmtqNjlyWU5rMExzenVKVERwekQySE94dldvZFVpZzZvUjZzWWhWU0hv?=
 =?utf-8?B?T3hzdjU5Tng1YjVFdXZnQWVEdTRCWWtMU21RQTkxQVJqUzgySVJUZVFIUzIv?=
 =?utf-8?B?Zkd4SFhidDE1c3hLK3FOSVBtY25lRjFVWStHcnpUYmdBaStrN252ZGpkcjdD?=
 =?utf-8?B?VnRUYVNRK2NvQW0rNWdsRi9lYkNpd3IyS3NOQ0ppQ3I4b1l0WVByWnBpU2NQ?=
 =?utf-8?B?Wld5dGoybmQwdVdNOSsyWEhDVmMvdXZ4NjQ2ODF4OC9lWUNUcFpJN2JRWTBo?=
 =?utf-8?B?SzdvelA4YjZJZkVPTVBTOGNQajhjd21IcnMzU2MyS3VMYis0UWpNakllaWZE?=
 =?utf-8?B?dmhYaUF1U3VhTVcvZGhaTnArOUp5b2ZZVDE4M1l3d2k2V1BBK1kyV3lnVjRh?=
 =?utf-8?B?Qm1CSGNGdVNjUjF5Z25rdE9wUTlHaFBwTGtyaUxnbFI0c3NjWVVrSFdTSFBV?=
 =?utf-8?B?TUI3SlhVVFhyU0dRTGJWTmExeTQ4K3lHYmhlNk10NWsvaUtkT1NFK3NRT2ZR?=
 =?utf-8?B?cWVSbWFDdUJBMkFJaG9xK3dWbkRUQXp4MVRCRU5FOHQzYVZGSHZHY0ZzVSt5?=
 =?utf-8?B?MFFvOVBmcUhQcWlYbmdJMW1Ud3R2Y1NQeVpzYWo4M1hlcVpwcmFmS3gzd1VJ?=
 =?utf-8?B?MDQxazB4a1U4bXlsSDRsbXMyeGZLbmVra3llU0ZWM2o4STY1eHlpZEh5NXV0?=
 =?utf-8?B?Tm9qaktnQVc0MFA4QkVzVHRXL1B5QlFzNjIvNktHRHVpbXpqRCtrSUZQeW5G?=
 =?utf-8?B?cEFOUmtUSFpJT0tDR3IrY3IrTlpJNGYxSlF3L2Q0TjhrbWZreFVpdjJjTy9j?=
 =?utf-8?B?QXFoKzNTU1dUSXBZTkhtbmtJQS9ZWkR5QWd6TWFHb1Z5ZHNYZEd2QmgrSXZD?=
 =?utf-8?B?OFF1QTRhZjI5MERzMmdOdlFldzViVmxxeXM1a0VlRjJ1b3BQblZHQWVKNElk?=
 =?utf-8?B?QVhIRkRHVHU0YWwzcVBGbVVmU0hHNDhJYW8xMmNPMHcvYlZPc1NoYnhBalFl?=
 =?utf-8?B?VU01NWxYRE5TWjJPNHE1WjVrL0ZpaUFWZFQ4N3B0blNMbHlFbWcreEdDSFBZ?=
 =?utf-8?B?TzdnNUdsTVBjam1XSFA4TDB1Wms1eUVFNkRUaG1OamFWWTd1eGxXbjd6YnAz?=
 =?utf-8?B?QU8vSDJGb1lXN3FUZmluVzBmcnZzZzR6VXl5RUNIVFBJQ1BJNXJXc0N6YTdI?=
 =?utf-8?B?Vk9MS3RJbngzdmFtMVdkNVZ1cjIxMDV4SHdHRXlSTUFwNEpLSitvZ3IrcW5M?=
 =?utf-8?B?SU9LZHpoZVdUNHM2RzZlT0Q5ODNpNGNKa2piMmU5dHZUMFEvazZHS2lINVMy?=
 =?utf-8?B?T2ZnT1hPRDB1UlhDK2tUNmIxVUFFOVlKNzlYVjZ5OTJQSFZ4VWNNY1JwMVh4?=
 =?utf-8?B?MkZJUzdHV2lxVlg5czVmV0FKZXpPSjNmLzB4TCtzNVpxeThwRVJkZVN4RUQ3?=
 =?utf-8?B?ZERKaXVWYnh5cVorYVhnV2dlQXEwQWFKeUxHVDJlbnVyeEEwVUdWTXJsM0ln?=
 =?utf-8?B?MkgzSWs3Sm5OM3c1RnV5enZSa001RWFpcGh0MXJvbWhacSt1blBSTE5Vbi8z?=
 =?utf-8?B?RDVVTVFPYUxiSTdBNnRNNVNockxJRmFQSDE3Vm9JVitVanFnVXZiYkRXU0J4?=
 =?utf-8?B?aWdjRXdUcGI3WHRNRjl4Z2Uvdm41VEV2c2d6ajBiN3RkelN2R2JzN0F2QnlJ?=
 =?utf-8?B?cDV1cFoxbWd3Um9uU1pWVi93R3FrK1dCOFVTWWNpa01JVlJBVWYveVROVEY4?=
 =?utf-8?B?b2R3clJyRGtlVEhuUDRucUZQWnhxWGQ0WFhHTUNwaUpsK1VuVkFwWVozeHQ3?=
 =?utf-8?B?OVJoMWRZYWhUUVRITm9RdlNlZFZTNFNCaENidjMxS01Ua09YbS9LaVd3UjZv?=
 =?utf-8?B?Ukd2UWVDTG1teE9nY1NXYXpFOCs1b2pPWlgvL0UzK25lTnFVOHpTTGYzTUsv?=
 =?utf-8?B?TnBrVDlyR1V3TWU4SnVGM3JhOEVXNWhoM2xjNnhBWEYwVzErZmEvWnp0OHhI?=
 =?utf-8?B?am9RWVozWm9teVhIaDN3d245cWdJTjhRNGlCOFRvd3g3RTBuQ3VHZm9HRFRI?=
 =?utf-8?B?Vll5bElSakk2Y2NOcStRREVsNnZxNGttVXV0NDFXQk5MNzQ5L2dGcUdPT09G?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e38f0a-faf5-4c4f-4e97-08dbc1180891
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:15:17.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znHX9TTvM1Qh9J1Jt1Blk3iE5TiCTlKuVHIiT7ZUUH/zO5g1xV+H2YRXNa5yGb7SaNcYZ1sFZvpz3mUpPEl7B66WAi+wC3Oa0oe/evTX8Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
>  currently contains only the wol_enabled field.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Good suggestion, nice to consolidate these bits I think.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

