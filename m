Return-Path: <netdev+bounces-190225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C0AB5C27
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109157B2839
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592112BEC41;
	Tue, 13 May 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPlyclbu"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FB2BE7A9;
	Tue, 13 May 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160303; cv=none; b=i5yB6usMJdH9kIcpf8wxJ8tvxOrQg0vB3U7CZxk1m5UrKEtU5J4KKeqg3Wdk3fq0hO2l/FgurO0Bj4rYRBZz5zqdP2u75kusC6zJB3pyXa+UyfaqAN5P1hElj8qVWJpWd+Q4Zn+4nNVPMPhdPy2LRHFjoSknHy+QjHwu0RIwyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160303; c=relaxed/simple;
	bh=HBeE+0wW+om85cfwNdDKrlxMpD223ZWbB4T/sjnTmUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qULUXtRBMDleC8xiOBIXd64Y3lBxl0yGD7nUwoDYhttzCUDliDNde7u3oARO4gBtg8TZl4LrqzzKV3ZGj9MNrjyMcp9W1vM380qg+RYNMXgprSFPhe5yX0BuvS0n8cKSVo3MLhBsFiBzQNLTO8SXh1osKjufEOUKo9EApFZIZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPlyclbu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d004048-ef8f-42ad-8f17-d1e4d495f57f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747160288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VergU86i4ALqHioN7prEA0AAZk9+sq3Anjg1pRxRhn4=;
	b=qPlyclbuJUlY7oA1oyMI6KtiOFLQQSlpFZTLSvv7LtOlknSkR0ugZM5yzrkqmDrUA6nA7F
	chAbq7FK2QjJfTS8ASDxGJBEdcEMRF3Ozp/TQU43p9LTaEQ+zHFfiseu+E64QEUNbA4MOk
	OCOzXqR7SQ05S0U4iEqYyWWuWVAf2QE=
Date: Tue, 13 May 2025 14:18:02 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 03/11] net: phylink: introduce internal
 phylink PCS handling
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-4-ansuelsmth@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250511201250.3789083-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/11/25 16:12, Christian Marangi wrote:
> Introduce internal handling of PCS for phylink. This is an alternative
> to .mac_select_pcs that moves the selection logic of the PCS entirely to
> phylink with the usage of the supported_interface value in the PCS
> struct.
> 
> MAC should now provide an array of available PCS in phylink_config in
> .available_pcs and fill the .num_available_pcs with the number of
> elements in the array. MAC should also define a new bitmap,
> pcs_interfaces, in phylink_config to define for what interface mode a
> dedicated PCS is required.
> 
> On phylink_create() this array is parsed and a linked list of PCS is
> created based on the PCS passed in phylink_config.
> Also the supported_interface value in phylink struct is updated with the
> new supported_interface from the provided PCS.
> 
> On phylink_start() every PCS in phylink PCS list gets attached to the
> phylink instance. This is done by setting the phylink value in
> phylink_pcs struct to the phylink instance.
> 
> On phylink_stop(), every PCS in phylink PCS list is detached from the
> phylink instance. This is done by setting the phylink value in
> phylink_pcs struct to NULL.
> 
> phylink_validate_mac_and_pcs(), phylink_major_config() and
> phylink_inband_caps() are updated to support this new implementation
> with the PCS list stored in phylink.
> 
> They will make use of phylink_validate_pcs_interface() that will loop
> for every PCS in the phylink PCS available list and find one that supports
> the passed interface.
> 
> phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
> where if a supported_interface value is not set for the PCS struct, then
> it's assumed every interface is supported.
> 
> A MAC is required to implement either a .mac_select_pcs or make use of
> the PCS list implementation. Implementing both will result in a fail
> on MAC/PCS validation.
> 
> phylink value in phylink_pcs struct with this implementation is used to
> track from PCS side when it's attached to a phylink instance. PCS driver
> will make use of this information to correctly detach from a phylink
> instance if needed.
> 
> The .mac_select_pcs implementation is not changed but it's expected that
> every MAC driver migrates to the new implementation to later deprecate
> and remove .mac_select_pcs.

This introduces a completely parallel PCS selection system used by a
single driver. I don't think we want the maintenance burden and
complexity of two systems in perpetuity. So what is your plan for
conversion of existing drivers to your new system?

DSA drivers typically have different PCSs for each port. At the moment
these are selected with mac_select_pcs, allowing the use of a single
phylink_config for each port. If you need to pass PCSs through
phylink_config then each port will needs its own config. This may prove
difficult to integrate with the existing API.

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phylink.c | 147 +++++++++++++++++++++++++++++++++-----
>  include/linux/phylink.h   |  10 +++
>  2 files changed, 139 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index ec42fd278604..95d7e06dee56 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -59,6 +59,9 @@ struct phylink {
>  	/* The link configuration settings */
>  	struct phylink_link_state link_config;
>  
> +	/* List of available PCS */
> +	struct list_head pcs_list;
> +
>  	/* What interface are supported by the current link.
>  	 * Can change on removal or addition of new PCS.
>  	 */
> @@ -144,6 +147,8 @@ static const phy_interface_t phylink_sfp_interface_preference[] = {
>  
>  static DECLARE_PHY_INTERFACE_MASK(phylink_sfp_interfaces);
>  
> +static void phylink_run_resolve(struct phylink *pl);
> +
>  /**
>   * phylink_set_port_modes() - set the port type modes in the ethtool mask
>   * @mask: ethtool link mode mask
> @@ -499,22 +504,59 @@ static void phylink_validate_mask_caps(unsigned long *supported,
>  	linkmode_and(state->advertising, state->advertising, mask);
>  }
>  
> +static int phylink_validate_pcs_interface(struct phylink_pcs *pcs,
> +					  phy_interface_t interface)
> +{
> +	/* If PCS define an empty supported_interfaces value, assume
> +	 * all interface are supported.
> +	 */
> +	if (phy_interface_empty(pcs->supported_interfaces))
> +		return 0;
> +
> +	/* Ensure that this PCS supports the interface mode */
> +	if (!test_bit(interface, pcs->supported_interfaces))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int phylink_validate_mac_and_pcs(struct phylink *pl,
>  					unsigned long *supported,
>  					struct phylink_link_state *state)
>  {
> -	struct phylink_pcs *pcs = NULL;
>  	unsigned long capabilities;
> +	struct phylink_pcs *pcs;
> +	bool pcs_found = false;
>  	int ret;
>  
>  	/* Get the PCS for this interface mode */
>  	if (pl->mac_ops->mac_select_pcs) {
> +		/* Make sure either PCS internal validation or .mac_select_pcs
> +		 * is used. Return error if both are defined.
> +		 */
> +		if (!list_empty(&pl->pcs_list)) {
> +			phylink_err(pl, "either phylink_pcs_add() or .mac_select_pcs must be used\n");
> +			return -EINVAL;
> +		}
> +

This validation should be done in phylink_create.

>  		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
>  		if (IS_ERR(pcs))
>  			return PTR_ERR(pcs);
> +
> +		pcs_found = !!pcs;
> +	} else {
> +		/* Check every assigned PCS and search for one that supports
> +		 * the interface.
> +		 */
> +		list_for_each_entry(pcs, &pl->pcs_list, list) {
> +			if (!phylink_validate_pcs_interface(pcs, state->interface)) {
> +				pcs_found = true;
> +				break;
> +			}
> +		}
>  	}
>  
> -	if (pcs) {
> +	if (pcs_found) {
>  		/* The PCS, if present, must be setup before phylink_create()
>  		 * has been called. If the ops is not initialised, print an
>  		 * error and backtrace rather than oopsing the kernel.
> @@ -526,13 +568,10 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
>  			return -EINVAL;
>  		}
>  
> -		/* Ensure that this PCS supports the interface which the MAC
> -		 * returned it for. It is an error for the MAC to return a PCS
> -		 * that does not support the interface mode.
> -		 */
> -		if (!phy_interface_empty(pcs->supported_interfaces) &&
> -		    !test_bit(state->interface, pcs->supported_interfaces)) {
> -			phylink_err(pl, "MAC returned PCS which does not support %s\n",
> +		/* Recheck PCS to handle legacy way for .mac_select_pcs */
> +		ret = phylink_validate_pcs_interface(pcs, state->interface);
> +		if (ret) {
> +			phylink_err(pl, "selected PCS does not support %s\n",
>  				    phy_modes(state->interface));
>  			return -EINVAL;
>  		}
> @@ -937,12 +976,22 @@ static unsigned int phylink_inband_caps(struct phylink *pl,
>  					 phy_interface_t interface)
>  {
>  	struct phylink_pcs *pcs;
> +	bool pcs_found = false;
>  
> -	if (!pl->mac_ops->mac_select_pcs)
> -		return 0;
> +	if (pl->mac_ops->mac_select_pcs) {
> +		pcs = pl->mac_ops->mac_select_pcs(pl->config,
> +						  interface);
> +		pcs_found = !!pcs;
> +	} else {
> +		list_for_each_entry(pcs, &pl->pcs_list, list) {
> +			if (!phylink_validate_pcs_interface(pcs, interface)) {
> +				pcs_found = true;
> +				break;
> +			}
> +		}
> +	}
>  
> -	pcs = pl->mac_ops->mac_select_pcs(pl->config, interface);
> -	if (!pcs)
> +	if (!pcs_found)
>  		return 0;
>  
>  	return phylink_pcs_inband_caps(pcs, interface);
> @@ -1228,10 +1277,36 @@ static void phylink_major_config(struct phylink *pl, bool restart,
>  			pl->major_config_failed = true;
>  			return;
>  		}
> +	/* Find a PCS in available PCS list for the requested interface.
> +	 * This doesn't overwrite the previous .mac_select_pcs as either
> +	 * .mac_select_pcs or PCS list implementation are permitted.
> +	 *
> +	 * Skip searching if the MAC doesn't require a dedicaed PCS for

dedicated

> +	 * the requested interface.
> +	 */
> +	} else if (test_bit(state->interface, pl->config->pcs_interfaces)) {
> +		bool pcs_found = false;
> +
> +		list_for_each_entry(pcs, &pl->pcs_list, list) {
> +			if (!phylink_validate_pcs_interface(pcs,
> +							    state->interface)) {
> +				pcs_found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!pcs_found) {
> +			phylink_err(pl,
> +				    "couldn't find a PCS for %s\n",
> +				    phy_modes(state->interface));
>  
> -		pcs_changed = pl->pcs != pcs;
> +			pl->major_config_failed = true;
> +			return;
> +		}
>  	}
>  
> +	pcs_changed = pl->pcs != pcs;
> +
>  	phylink_pcs_neg_mode(pl, pcs, state->interface, state->advertising);
>  
>  	phylink_dbg(pl, "major config, active %s/%s/%s\n",
> @@ -1258,10 +1333,12 @@ static void phylink_major_config(struct phylink *pl, bool restart,
>  	if (pcs_changed) {
>  		phylink_pcs_disable(pl->pcs);
>  
> -		if (pl->pcs)
> -			pl->pcs->phylink = NULL;
> +		if (pl->mac_ops->mac_select_pcs) {
> +			if (pl->pcs)
> +				pl->pcs->phylink = NULL;
>  
> -		pcs->phylink = pl;
> +			pcs->phylink = pl;
> +		}
>  
>  		pl->pcs = pcs;
>  	}
> @@ -1797,8 +1874,9 @@ struct phylink *phylink_create(struct phylink_config *config,
>  			       phy_interface_t iface,
>  			       const struct phylink_mac_ops *mac_ops)
>  {
> +	struct phylink_pcs *pcs;
>  	struct phylink *pl;
> -	int ret;
> +	int i, ret;
>  
>  	/* Validate the supplied configuration */
>  	if (phy_interface_empty(config->supported_interfaces)) {
> @@ -1813,9 +1891,21 @@ struct phylink *phylink_create(struct phylink_config *config,
>  
>  	mutex_init(&pl->state_mutex);
>  	INIT_WORK(&pl->resolve, phylink_resolve);
> +	INIT_LIST_HEAD(&pl->pcs_list);
> +
> +	/* Fill the PCS list with available PCS from phylink config */
> +	for (i = 0; i < config->num_available_pcs; i++) {
> +		pcs = config->available_pcs[i];
> +
> +		list_add(&pcs->list, &pl->pcs_list);
> +	}

Why do we have a separate linked list if we are getting all the PCSs
in an array at configuration time? From what I can tell there is no
dynamic configuration of PCSs.

>  
>  	phy_interface_copy(pl->supported_interfaces,
>  			   config->supported_interfaces);
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		phy_interface_or(pl->supported_interfaces,
> +				 pl->supported_interfaces,
> +				 pcs->supported_interfaces);
>  
>  	pl->config = config;
>  	if (config->type == PHYLINK_NETDEV) {
> @@ -1894,10 +1984,16 @@ EXPORT_SYMBOL_GPL(phylink_create);
>   */
>  void phylink_destroy(struct phylink *pl)
>  {
> +	struct phylink_pcs *pcs, *tmp;
> +
>  	sfp_bus_del_upstream(pl->sfp_bus);
>  	if (pl->link_gpio)
>  		gpiod_put(pl->link_gpio);
>  
> +	/* Remove every PCS from phylink PCS list */
> +	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
> +		list_del(&pcs->list);
> +
>  	cancel_work_sync(&pl->resolve);
>  	kfree(pl);
>  }
> @@ -2374,6 +2470,7 @@ static irqreturn_t phylink_link_handler(int irq, void *data)
>   */
>  void phylink_start(struct phylink *pl)
>  {
> +	struct phylink_pcs *pcs;
>  	bool poll = false;
>  
>  	ASSERT_RTNL();
> @@ -2400,6 +2497,10 @@ void phylink_start(struct phylink *pl)
>  
>  	pl->pcs_state = PCS_STATE_STARTED;
>  
> +	/* link available PCS to phylink struct */
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		pcs->phylink = pl;
> +
>  	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
>  
>  	if (pl->cfg_link_an_mode == MLO_AN_FIXED && pl->link_gpio) {
> @@ -2444,6 +2545,8 @@ EXPORT_SYMBOL_GPL(phylink_start);
>   */
>  void phylink_stop(struct phylink *pl)
>  {
> +	struct phylink_pcs *pcs;
> +
>  	ASSERT_RTNL();
>  
>  	if (pl->sfp_bus)
> @@ -2461,6 +2564,14 @@ void phylink_stop(struct phylink *pl)
>  	pl->pcs_state = PCS_STATE_DOWN;
>  
>  	phylink_pcs_disable(pl->pcs);
> +
> +	/* Drop link between phylink and PCS */
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		pcs->phylink = NULL;
> +
> +	/* Restore original supported interfaces */
> +	phy_interface_copy(pl->supported_interfaces,
> +			   pl->config->supported_interfaces);
>  }
>  EXPORT_SYMBOL_GPL(phylink_stop);
>  
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 30659b615fca..ef0b5a0729c8 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -150,12 +150,16 @@ enum phylink_op_type {
>   *		     if MAC link is at %MLO_AN_FIXED mode.
>   * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
>   *                        are supported by the MAC/PCS.
> + * @pcs_interfaces: bitmap describing for which PHY_INTERFACE_MODE_xxx a
> + *		    dedicated PCS is required.
>   * @lpi_interfaces: bitmap describing which PHY interface modes can support
>   *		    LPI signalling.
>   * @mac_capabilities: MAC pause/speed/duplex capabilities.
>   * @lpi_capabilities: MAC speeds which can support LPI signalling
>   * @lpi_timer_default: Default EEE LPI timer setting.
>   * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
> + * @available_pcs: array of available phylink_pcs PCS
> + * @num_available_pcs: num of available phylink_pcs PCS
>   */
>  struct phylink_config {
>  	struct device *dev;
> @@ -168,11 +172,14 @@ struct phylink_config {
>  	void (*get_fixed_state)(struct phylink_config *config,
>  				struct phylink_link_state *state);
>  	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
> +	DECLARE_PHY_INTERFACE_MASK(pcs_interfaces);
>  	DECLARE_PHY_INTERFACE_MASK(lpi_interfaces);
>  	unsigned long mac_capabilities;
>  	unsigned long lpi_capabilities;
>  	u32 lpi_timer_default;
>  	bool eee_enabled_default;
> +	struct phylink_pcs **available_pcs;
> +	unsigned int num_available_pcs;
>  };
>  
>  void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
> @@ -469,6 +476,9 @@ struct phylink_pcs {
>  	struct phylink *phylink;
>  	bool poll;
>  	bool rxc_always_on;
> +
> +	/* private: */
> +	struct list_head list;
>  };
>  
>  /**

