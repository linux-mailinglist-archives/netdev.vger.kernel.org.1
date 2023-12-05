Return-Path: <netdev+bounces-54012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FCF80598A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D351C2096E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E863DDC;
	Tue,  5 Dec 2023 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POOAFOgy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F9C3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792601; x=1733328601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C/oHXb4JfloEcj9RUEqYmf3NTcPJpcC7thkzrpT0SMQ=;
  b=POOAFOgybeSjRIiVtxP07AQ/NPGOrzxgj9+IiJsOtOqdPC9l24JFVLGn
   ohmPLvlu3ldpPP4c0LMGi4IiwO3B2KTwygYbN8lNz/dbREdSKPn/eo6f6
   O96YWdYJ+JAGChIc+pzNvKdeguLG5BJOwNKR9ySmoV2lRclxuVsY8ymyp
   V4k73rqGlHyg7ocmQ5fscmq9lh/nSuVyrvchOZAlkv06a03n8DHSrZrzy
   ZRprckUcfod9mynQyY6spFOVeRfQbqhe3R4l/50XAjhKqrMDxCLd+Uuhf
   jOZkCPGnLKexxZ3LCIIp5yy4wW8eqbWNW308b7b8IVaW4NDPZ++JnxBky
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392780235"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392780235"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="888992792"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="888992792"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 08:10:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 08:10:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 08:10:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 08:10:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 08:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPko4fT5Gp+VGl2+ks9sEj1wQVHm0Yrj8ql/4PO2tlBcdscgXNhP+2tsyyylTuuiAebaBAb0d8GMgiEipbf8MOwwIkLA4NzqeV2vI5O0KhxwIc6rBnjIqOHVOTALF/qCFQyFHDQGYMTgvgyJpMUf8O5kDAfjhF85JOAtDNcf5m0bX9ZMQx/2WujIVBR0GcuONLsJ0xc+vQnslR57qZu+s3XHzYHE1N2+NjJrQHpoOrLaFgr2ELXeQ9Noikug/w8uB/6ImlDjvWV2I8LnsxNHcEeVhrlNe9m6RLVsvfldv+UYWMJ6TaQLPxyuk+9QJdZdJSSnU4OpfATS3ud0sIxnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BvyqlErlpRNH+sXPi2e5T3qmLMD291kVkkmKfiizy4=;
 b=fnfDzORqJNWsEZPggC/aiBvG10XpNHpC3vealsv6vnE9T3zn5JOpVVOk9mxGH7vkK4Km6noqXapLu99Cbuy6I6VtD/OsT3hUkB0yQ/ssgDydyJrda6uqyvmaVeZUKzwkpW47CbbSfehZJr0Vf4ImEIeIsMv/1c45rqmdX+mqwhdf1ZNa2l4lli7l55U0SXMwz8SUJSuxSpByITIO/EPBQKFyNuwOqXrzblSxy6ZHD7KAX3i+nN3ufsZrfjV3kaWWoZ9sWNpnSYddkoSgzq8z9HuHT9Mdei5f0yYILwF/+JkpvxzUZErdDzOzH4QfOjf9sifzY5694jeRpqyT2NAtKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB7665.namprd11.prod.outlook.com (2603:10b6:806:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 16:09:56 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 16:09:56 +0000
Message-ID: <8eca364e-8796-d01f-ead3-2a419a9f7658@intel.com>
Date: Tue, 5 Dec 2023 17:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next] ice: Do not get coalesce settings while in reset
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Ngai-Mint Kwan <ngai-mint.kwan@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20231205152620.568183-1-pawel.chmielewski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231205152620.568183-1-pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a149d36-9209-4fff-51fc-08dbf5ac9f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMbWqLM6qs6Ew4nCMfXSmguF93jAV2Zk0xF6KNIZ/haCLm7ySbu5Y+rERhBEVs3vktmk4gXJne1jbxye6DtHNZ57pgZIXx2jPmGZi+NkK+LB84t0YAqGdn5ta9l74v0qKJvbukNWGf4zG8ea8tm5eAERlb4qIanOCE1P1JLgFr0cLRxYnXW2rJ2SAGh+mh2vvm5ZbdMWHVaCXepti7BquKHiJ/OBBQ3kKKBUDArUkN7f8NN2HDpsMuAJ9l7DMdjoMmpOa4Z2Dfv9Bnjr/pbNUe4UxK+EiZ0y4UCLi7FWd6fvMuOkbDeSdgDwDkXo5aYF7sf/OA7npWusjDaG/IIJcxy5pvi0tHz7N2B6OZWpZBVG49qfsEfDN5Ol/7u9l63Ix8LngUQIxJGNLoXj3Mm+AsRV4MVpXKHgS2dH0UgJSaefxI/OjCsglLLXXIvcFjZoa0lMwdhVjpj2lw34oHmmOQA4J7ka8QKbXMgm8+SWis0cs7k5eAp7QiMyZz+ZAg470jnyMb2Se46MagJBnf1Pwtx2Dopr+LmBAOrdScarGqQ87xHnHPrcP4eGUCbpYSjIDnxfNn1uvL42iLxf1nsa1YI/V9ne3G011/aOssKZJcNas+CV2ol/yZc+GEdKzji1OW7TWNswcG4j378HO9Z86Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(6486002)(6666004)(6512007)(6506007)(53546011)(82960400001)(36756003)(2616005)(107886003)(316002)(66556008)(66476007)(66946007)(54906003)(31686004)(38100700002)(5660300002)(86362001)(4326008)(8936002)(8676002)(2906002)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRZUERxSFN5elljdVVnbExnUE5CdmJFN3lFTmVzaEM0N3NRWGJ6ZEJhOGpZ?=
 =?utf-8?B?MTBTd1podFFTN1hCMEIvNnZ1RGc2N1BUZzhyNUhjOU5uTnRMTGdNYmJkUk5S?=
 =?utf-8?B?RVRDdGFPQ21HSk5TMVo5ekVGbjZJK2YwVmhVOUg2endCbWtuZjBFTkVwanJE?=
 =?utf-8?B?YnpuZ3ROWWdJa3luRUZRNU50SkFRWUlpNnlLRnYyVzBTVng2Q2F4aEpvTU9Z?=
 =?utf-8?B?N1ltSDRQekZ5VWpFb0NneHEzL0FuZS9vK1dDVHJqektOS1hOTHA3ME1uWTlV?=
 =?utf-8?B?M2I4QTFNN2pjb0lqSVpLUHhuNnJJTVF2T0VOMk5BS0ZuM3FQaklEc1lwaklr?=
 =?utf-8?B?b2U2MXJWdXJ1cndlRmFXRFIvU0RRZVRCWnNaZFBPbmZKVnlQVFYzMjJVQ2hO?=
 =?utf-8?B?ZE9HdjZvNkZjOWNVa3BCajQ2bG5DdmliTGtpQm9tQWFTaHN0a09XUUJtNllj?=
 =?utf-8?B?ZUJ4bjc5YVdsMlJlVXRCeSs0N1dTNDFJbFpQazBPRHJQL2pWT05yQXJvZG44?=
 =?utf-8?B?TkdLcEVhNHprRGRBV2p4eU9odHVTTmZMZzYrZ2JmMjdQMVFycERtbEFPTW9E?=
 =?utf-8?B?STZNdDNGaFA3d1N1Q2pLOWMxaHlMdWhQMkx5cVlIdWJXYTRlTFhDT0dJWTdr?=
 =?utf-8?B?TE5nTGovMmc1UjdlWXF0d3dXSEpTdmk1d0UzbmhKSmxIYXNUN3ZYSHZYaWly?=
 =?utf-8?B?OEdEa09HVU1pemE1NG5aVEJLZGJlTlFzQUhHSU9qUHpZc2ZsUE01OTdVdWha?=
 =?utf-8?B?S2l3Wk05ZlgxMHZSdTQwS1pMdy9jSlR0RSszcHhyeHExL0x5ZWVVcWp4VGlh?=
 =?utf-8?B?UkkyT3I5RDFuZEJIR2pRZzR2T0lhaUJYbU9aQzVLM0FsVEtMcXJKQUVzN3NC?=
 =?utf-8?B?MGhFNmwwWWFCdzJGQXZ6QWVKd3Y0ZVR4bVMvVzgrYWhqK0ZLUnd6MWNBUHhr?=
 =?utf-8?B?N3hNMWFGNjBHejRzcHBOWWRTdmNGSXluM1hBK3hlNFVkaG5qdlV1R2JhM3VI?=
 =?utf-8?B?ZFpyYU85Qng5R0xtT0RuZmEzSmg0L0VHeWlJaVZVYVV5R3pPcU5FU3RhSmFl?=
 =?utf-8?B?aWE1WGtrRG9CMk9iRFZRVmRwRzJHQmRnd1AvckRGZUc4WFBxWU5ZNUt0eHpH?=
 =?utf-8?B?ZnRIOS9zZjBBNG9zcURFbWNrWEdUL1ZxTWh6WjdUWUVWZ2pmRmxIekdsM2F1?=
 =?utf-8?B?OUxiS1BqWWYxRkJ2UmFxaHZMT0w4UnFRanFqRVFXQzNBeEsrUWVQelpQbVNH?=
 =?utf-8?B?aStGZm5LaWtPbFI3WnB5OGwzdk5lU1Z6amg1cGJ5Z2d0RXJNcC8wZElIb0V3?=
 =?utf-8?B?eUxDVGlOeG5sYjQrMk8weXI2Vml0NG5HdGdHSHVYaWtCcjFtdzl1bzUvWVlQ?=
 =?utf-8?B?Vy9GaytPbWFtM0pJQTBBcVI5cHpVOTNFUHUrZ2NVRnNBeitvZGxCeGllaEF1?=
 =?utf-8?B?eG5wM0h4eVYwemliK2lybTRsMElENlZyM2JtSDFkNDZDd3FuUHA1dzZ5U0F0?=
 =?utf-8?B?TGtNL2I3dHZPald4UnN2dHp2NHRqRDFoOWdWL3k4OElYdFNMb0JqWDZDbDJW?=
 =?utf-8?B?RTJiaWNEQTlnYlpRb2dKdTBnejQ4ZmtDeFJZVzg5eXFBa254U2NWQmNEa2dt?=
 =?utf-8?B?M3BRZmZJODQ3eXc4UnZLVDRDaDJsc1drQ2QxSUptL29GbEpaZy9zSXY1b1gy?=
 =?utf-8?B?YUU3V05VTEFSdlpoSGx2Q0dUdThTVTZzanpyTExnQ3NybXdpTmI5UEZEVWF6?=
 =?utf-8?B?UHNxUS8ranlBYSs5NFc4QmYzRUYxMzNqUEVvUzgvc3AzeC9ZNnBMcmxPK2tQ?=
 =?utf-8?B?ZXpVeWhNcFlZZEtaNmFCRElSYXVLb1VDQzF2dUMxdStWU2Uyby9uWkZtVGE3?=
 =?utf-8?B?bTBZbTBwdXlOdU9DWWQ4QURkUlFUbVZLT296Ui90MldjcTczS05jTXdpM0d2?=
 =?utf-8?B?ak9BY0JqbUZ2aFVRa0o4UWRTU1dOTmlGMUFsUjl4UFlyeDBHTGFxYktuK0gr?=
 =?utf-8?B?UXRYbEdQSmJIZHdIWnZ1Mnp4YVgvaERJUHRYUnZMZVkwczBtSTQwOTRaMGtq?=
 =?utf-8?B?V1BBcElJWElSQ2gxdXUzNk5STXFMcTIyMDl4TXVCNm12Szc5VU0vKzBTbkFO?=
 =?utf-8?B?TUlSOW1VRWwxdEluSGNGaEpSZVZnUjRaMUVteXdlVzJhd29HQlFxN052alMv?=
 =?utf-8?Q?Zo7JjXRHch3A5M5vIbytSBw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a149d36-9209-4fff-51fc-08dbf5ac9f56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 16:09:56.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU4uZZGlDUoz0ENB5qXtnpK3JGE3uipiW4axid8hgq8Eid2og2GghIKFclLMIuEtNW7aegoKDtWfFzNcj3+Zj4t2V+RtaaxCmLRHJpc1ULU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7665
X-OriginatorOrg: intel.com

On 12/5/23 16:26, Pawel Chmielewski wrote:
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> 
> Getting coalesce settings while reset is in progress can cause NULL
> pointer deference bug.
> If under reset, abort get coalesce for ethtool.
> 
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index bde9bc74f928..2d565cc484a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3747,6 +3747,9 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   	struct ice_vsi *vsi = np->vsi;
>   
> +	if (ice_is_reset_in_progress(vsi->back->state))
> +		return -EBUSY;
> +
>   	if (q_num < 0)
>   		q_num = 0;
>   

Sorry for a late review,
This asks for a Fixes: tag, and targeting at iwl-net instead :)

