Return-Path: <netdev+bounces-35393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2A7A942D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77318B209E9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CDAD55;
	Thu, 21 Sep 2023 12:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7CAD4F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E3C4E67B;
	Thu, 21 Sep 2023 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695298356;
	bh=bQL3AQl35z0Mpm0hsevXA7UcZACqEF2ZtoPTHLG435A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cnze4tx8zonhwLGPuVWJlYD/J8Z8SjpOelH9sguQ/zee1GHefOl0qQH7bweVMRiVc
	 oxEFaOOEplGiioMRPANC4yRen/RuEaJ4OWitH001ZuzyRAsr4GsnFreOkqEVZTK9RX
	 ZuKwDcQ1uj+vouaq/P/W8ck2wmg2R0mjkyDv2AswDZA8Qz5XmqPERgUHMbVRs3meLl
	 2A2bbVBzbhlPBaIe7GWsOFHXHG50mBFxBbWqPZqbuO7jgc5ZMWS5izSI95vCl48Q5j
	 ZObPars069RIUsoBOKnyRFCI+I2VpVpoSyR6UqMg6K6ZPik0FxcATsVdOKeuCM8hmB
	 6f2B6JAMABm4w==
Date: Thu, 21 Sep 2023 13:12:29 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	andrew@lunn.ch, aelior@marvell.com, manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-next 1/2] ethtool: Add forced speed to supported link
 modes maps
Message-ID: <20230921121229.GK224399@kernel.org>
References: <20230915145522.586365-1-pawel.chmielewski@intel.com>
 <20230915145522.586365-2-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915145522.586365-2-pawel.chmielewski@intel.com>

On Fri, Sep 15, 2023 at 04:55:21PM +0200, Pawel Chmielewski wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> The need to map Ethtool forced speeds to Ethtool supported link modes is
> common among drivers. To support this, add a common structure for forced
> speed maps and a function to init them.  This is solution was originally
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the mapping.
> 
> Definitions for maps themselves are left in the driver code, as the sets
> of supported link modes may vary betwen the devices.

nit: between

> 
> The qede driver was compile tested only.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  .../net/ethernet/qlogic/qede/qede_ethtool.c   | 24 ++++---------------
>  include/linux/ethtool.h                       | 20 ++++++++++++++++
>  net/ethtool/ioctl.c                           | 15 ++++++++++++
>  3 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> index 95820cf1cd6c..9e0e73602abe 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
> @@ -201,14 +201,6 @@ static const char qede_tests_str_arr[QEDE_ETHTOOL_TEST_MAX][ETH_GSTRING_LEN] = {
>  
>  /* Forced speed capabilities maps */
>  
> -struct qede_forced_speed_map {
> -	u32		speed;
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
> -
> -	const u32	*cap_arr;
> -	u32		arr_size;
> -};
> -
>  #define QEDE_FORCED_SPEED_MAP(value)					\
>  {									\
>  	.speed		= SPEED_##value,				\
> @@ -263,7 +255,7 @@ static const u32 qede_forced_speed_100000[] __initconst = {
>  	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
>  };
>  
> -static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
> +static struct ethtool_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
>  	QEDE_FORCED_SPEED_MAP(1000),
>  	QEDE_FORCED_SPEED_MAP(10000),
>  	QEDE_FORCED_SPEED_MAP(20000),
> @@ -275,16 +267,8 @@ static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
>  
>  void __init qede_forced_speed_maps_init(void)
>  {
> -	struct qede_forced_speed_map *map;
> -	u32 i;
> -
> -	for (i = 0; i < ARRAY_SIZE(qede_forced_speed_maps); i++) {
> -		map = qede_forced_speed_maps + i;
> -
> -		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
> -		map->cap_arr = NULL;
> -		map->arr_size = 0;
> -	}
> +	ethtool_forced_speed_maps_init(qede_forced_speed_maps,
> +				       ARRAY_SIZE(qede_forced_speed_maps));
>  }
>  
>  /* Ethtool callbacks */
> @@ -565,7 +549,7 @@ static int qede_set_link_ksettings(struct net_device *dev,
>  {
>  	const struct ethtool_link_settings *base = &cmd->base;
>  	struct qede_dev *edev = netdev_priv(dev);
> -	const struct qede_forced_speed_map *map;
> +	const struct ethtool_forced_speed_map *map;
>  	struct qed_link_output current_link;
>  	struct qed_link_params params;
>  	u32 i;

nit: please preserve reverse xmas tree order - longest line to shortest -
     for local variable declarations in Networking code.

> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 62b61527bcc4..3d23a8d78c9b 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1052,4 +1052,24 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
>   * next string.
>   */
>  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
> +
> +/* Link mode to forced speed capabilities maps */
> +struct ethtool_forced_speed_map {
> +	u32		speed;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
> +
> +	const u32	*cap_arr;
> +	u32		arr_size;
> +};
> +
> +/**
> + * ethtool_forced_speed_maps_init
> + * @maps: Pointer to an array of Ethtool forced speed map
> + * @size: Array size
> + *
> + * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
> + * should be called during driver module init.
> + */
> +void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
> +				   u32 size);

nit: the indentation here is not correct.
     'u32' should align with the inside of the opening '(' on the preceding
     line.

void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
				    u32 size);

>  #endif /* _LINUX_ETHTOOL_H */
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b0ce4f81c01..1ba437eff764 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -3388,3 +3388,18 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
>  	kfree(flow);
>  }
>  EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
> +
> +void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
> +				   u32 size)

Ditto

> +{
> +	u32 i;
> +
> +	for (i = 0; i < size; i++) {
> +		struct ethtool_forced_speed_map *map = &maps[i];
> +
> +		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
> +		map->cap_arr = NULL;
> +		map->arr_size = 0;
> +	}
> +}
> +EXPORT_SYMBOL(ethtool_forced_speed_maps_init);
> \ No newline at end of file
> -- 
> 2.37.3
> 
> 

