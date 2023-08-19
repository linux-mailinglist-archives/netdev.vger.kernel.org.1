Return-Path: <netdev+bounces-29052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B0781779
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 07:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59F31C20E18
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BB217C0;
	Sat, 19 Aug 2023 05:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA2ECD
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 05:12:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE33C06
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:12:09 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed0d.dynamic.kabel-deutschland.de [95.90.237.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8486C61E5FE01;
	Sat, 19 Aug 2023 07:11:59 +0200 (CEST)
Message-ID: <7b2b398b-b4dc-406e-8e3d-1b4483bc01d1@molgen.mpg.de>
Date: Sat, 19 Aug 2023 07:11:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/7] ice: Refactor finding
 advertised link speed
Content-Language: en-US
To: Paul Greenwalt <paul.greenwalt@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20230816235719.1120726-1-paul.greenwalt@intel.com>
 <20230816235719.1120726-3-paul.greenwalt@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230816235719.1120726-3-paul.greenwalt@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Paul, dear Pawel,


Thank you for your patch.

Am 17.08.23 um 01:57 schrieb Paul Greenwalt:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
> 
> Refactor ice_get_link_ksettings by using lightweight static link mode
> maps, populated at module init. This is an efficient solution introduced
> in commit 1d4e4ecccb11 ("qede: populate supported link modes maps on
> module init") for qede driver

Please add a dot/period at the end of sentences.

It’d be great if you elaborated and maybe even added the measurements, 
how much more lightweight it is.

> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h         |   1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 166 +++++++++++--------
>   drivers/net/ethernet/intel/ice/ice_main.c    |   2 +
>   3 files changed, 104 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 5d307bacf7c6..1030a4d1d94e 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -974,6 +974,7 @@ int ice_stop(struct net_device *netdev);
>   void ice_service_task_schedule(struct ice_pf *pf);
>   int ice_load(struct ice_pf *pf);
>   void ice_unload(struct ice_pf *pf);
> +void ice_adv_lnk_speed_maps_init(void);
>   
>   /**
>    * ice_set_rdma_cap - enable RDMA support
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index d3cb08e66dcb..9a858d8ae26e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -345,6 +345,100 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
>   
>   #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
>   
> +static const u32 ice_adv_lnk_speed_100[] __initconst = {
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_1000[] __initconst = {
> +	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_2500[] __initconst = {
> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_5000[] __initconst = {
> +	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_10000[] __initconst = {
> +	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_25000[] __initconst = {
> +	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_40000[] __initconst = {
> +	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_50000[] __initconst = {
> +	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_100000[] __initconst = {
> +	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
> +};
> +
> +struct ice_adv_lnk_speed_map {
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
> +	const u32	*cap_arr;
> +	u16		arr_size;
> +	u16		aqc_link_speed;
> +};
> +
> +#define ICE_ADV_LNK_SPEED_MAP(value, aqc_value)			\
> +{								\
> +	.cap_arr	= ice_adv_lnk_speed_##value,		\
> +	.arr_size	= ARRAY_SIZE(ice_adv_lnk_speed_##value),\
> +	.aqc_link_speed	= ICE_AQ_LINK_SPEED_##aqc_value,	\
> +}
> +
> +static struct ice_adv_lnk_speed_map ice_adv_lnk_speed_maps[] __ro_after_init = {
> +	ICE_ADV_LNK_SPEED_MAP(100, 100MB),
> +	ICE_ADV_LNK_SPEED_MAP(1000, 1000MB),
> +	ICE_ADV_LNK_SPEED_MAP(2500, 2500MB),
> +	ICE_ADV_LNK_SPEED_MAP(5000, 5GB),
> +	ICE_ADV_LNK_SPEED_MAP(10000, 10GB),
> +	ICE_ADV_LNK_SPEED_MAP(25000, 25GB),
> +	ICE_ADV_LNK_SPEED_MAP(40000, 40GB),
> +	ICE_ADV_LNK_SPEED_MAP(50000, 50GB),
> +	ICE_ADV_LNK_SPEED_MAP(100000, 100GB),
> +};
> +
> +void __init ice_adv_lnk_speed_maps_init(void)
> +{
> +	u32 i;

Maybe even use the non-fixed length type `unsigned int` [1]?

> +
> +	for (i = 0; i < ARRAY_SIZE(ice_adv_lnk_speed_maps); i++) {
> +		struct ice_adv_lnk_speed_map *map = &ice_adv_lnk_speed_maps[i];
> +
> +		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
> +		map->cap_arr = NULL;
> +		map->arr_size = 0;
> +	}
> +}
> +
>   static void
>   __ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
>   		  struct ice_vsi *vsi)
> @@ -2014,73 +2108,15 @@ ice_get_link_ksettings(struct net_device *netdev,
>   static u16
>   ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
>   {
> +	const struct ice_adv_lnk_speed_map *map;
>   	u16 adv_link_speed = 0;
> +	u32 i;
>   
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100baseT_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_100MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseX_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseKX_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_1000MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  2500baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  2500baseX_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_2500MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  5000baseT_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_5GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseKR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseSR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseLR_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_10GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseCR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseSR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseKR_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_25GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseCR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseSR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseLR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseKR4_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_40GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseCR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseKR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseSR2_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_50GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseCR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseSR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseLR4_ER4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseKR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseCR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseSR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseKR2_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_100GB;
> +	for (i = 0; i < ARRAY_SIZE(ice_adv_lnk_speed_maps); i++) {
> +		map = ice_adv_lnk_speed_maps + i;
> +		if (linkmode_intersects(ks->link_modes.advertising, map->caps))
> +			adv_link_speed |= map->aqc_link_speed;
> +	}
>   
>   	return adv_link_speed;
>   }
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 356bf8884a63..ffed5543a5aa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5672,6 +5672,8 @@ static int __init ice_module_init(void)
>   	pr_info("%s\n", ice_driver_string);
>   	pr_info("%s\n", ice_copyright);
>   
> +	ice_adv_lnk_speed_maps_init();
> +
>   	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
>   	if (!ice_wq) {
>   		pr_err("Failed to create workqueue\n");


Kind regards,

Paul

