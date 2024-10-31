Return-Path: <netdev+bounces-140634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4B9B74BD
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137711C235CD
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2E146D6E;
	Thu, 31 Oct 2024 06:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA0146D53
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357669; cv=none; b=bxWbzjG2VM2tnzsTGfos2Xl4bOIJli+aLuLJCgetok2UmoBr+pTv1E4moTqvzpxWHXEC42/N9cwb9AJ6ys7EYqmLT0ap8jINTgzoe2Xw7t9/CRT3fDNHbifDJgzN3Vrw6yArAqJ49N2LNP43hyzo2AtghHrJioZfzL4+s63wW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357669; c=relaxed/simple;
	bh=7pZk6xURsLrp/rp1VDQ/01OCJzqZvLcza5ZMTiODdUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8ARiGbhoE8QAO3AoDleLRz73letW04PV2FlrpTPL4rLy4WVOC6bBdlKj2ggHloAd79ee5O+xb6Dky1ZfmcHNFCvKqEEB8dL6ueaucX1gzC+rHytxM6hskeW9pCoWPdkqt32crBULfn2ZwpdFcOLGKF9HV1e/ubGCfrIctJbIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t6P4M-0004us-N9; Thu, 31 Oct 2024 07:54:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6P4K-001JmE-1m;
	Thu, 31 Oct 2024 07:54:08 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6P4K-0069fz-1O;
	Thu, 31 Oct 2024 07:54:08 +0100
Date: Thu, 31 Oct 2024 07:54:08 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <ZyMpkJRHZWYsszh2@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

>  struct pse_control_status {
>  	u32 pse_id;
> @@ -74,6 +83,10 @@ struct pse_control_status {
>  	u32 c33_avail_pw_limit;
>  	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
>  	u32 c33_pw_limit_nb_ranges;
> +	u32 c33_prio_supp_modes;
> +	enum pse_port_prio_modes c33_prio_mode;
> +	u32 c33_prio_max;
> +	u32 c33_prio;
>  };
>  
>  /**
> @@ -93,6 +106,8 @@ struct pse_control_status {
>   *			  set_current_limit regulator callback.
>   *			  Should not return an error in case of MAX_PI_CURRENT
>   *			  current value set.
> + * @pi_set_prio: Configure the PSE PI priority.
> + * @pi_get_pw_req: Get the power requested by a PD before enabling the PSE PI
>   */
>  struct pse_controller_ops {
>  	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
> @@ -107,6 +122,9 @@ struct pse_controller_ops {
>  				    int id);
>  	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
>  				    int id, int max_uA);
> +	int (*pi_set_prio)(struct pse_controller_dev *pcdev, int id,
> +			   unsigned int prio);
> +	int (*pi_get_pw_req)(struct pse_controller_dev *pcdev, int id);
>  };
>  
>  struct module;
> @@ -141,6 +159,10 @@ struct pse_pi_pairset {
>   * @rdev: regulator represented by the PSE PI
>   * @admin_state_enabled: PI enabled state
>   * @pw_d: Power domain of the PSE PI
> + * @prio: Priority of the PSE PI. Used in static port priority mode
> + * @pw_enabled: PSE PI power status in static port priority mode
> + * @pw_allocated: Power allocated to a PSE PI to manage power budget in
> + *	static port priority mode
>   */
>  struct pse_pi {
>  	struct pse_pi_pairset pairset[2];
> @@ -148,6 +170,9 @@ struct pse_pi {
>  	struct regulator_dev *rdev;
>  	bool admin_state_enabled;
>  	struct pse_power_domain *pw_d;
> +	int prio;
> +	bool pw_enabled;
> +	int pw_allocated;
>  };
>  
>  /**
> @@ -165,6 +190,9 @@ struct pse_pi {
>   * @pi: table of PSE PIs described in this controller device
>   * @no_of_pse_pi: flag set if the pse_pis devicetree node is not used
>   * @id: Index of the PSE
> + * @pis_prio_max: Maximum value allowed for the PSE PIs priority
> + * @port_prio_supp_modes: Bitfield of port priority mode supported by the PSE
> + * @port_prio_mode: Current port priority mode of the PSE
>   */
>  struct pse_controller_dev {
>  	const struct pse_controller_ops *ops;
> @@ -179,6 +207,9 @@ struct pse_controller_dev {
>  	struct pse_pi *pi;
>  	bool no_of_pse_pi;
>  	int id;
> +	unsigned int pis_prio_max;
> +	u32 port_prio_supp_modes;
> +	enum pse_port_prio_modes port_prio_mode;
>  };

> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index a1ad257b1ec1..22664b1ea4a2 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -1002,11 +1002,35 @@ enum ethtool_c33_pse_pw_d_status {
>   * enum ethtool_c33_pse_events - event list of the C33 PSE controller.
>   * @ETHTOOL_C33_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
>   * @ETHTOOL_C33_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
> + * @ETHTOOL_C33_PSE_EVENT_CONNECTED: PD detected on the PSE.
> + * @ETHTOOL_C33_PSE_EVENT_DISCONNECTED: PD has been disconnected on the PSE.
> + * @ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR: PSE faced an error in static
> + *	port priority management mode.
>   */
>  
>  enum ethtool_c33_pse_events {
> -	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =	1 << 0,
> -	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =	1 << 1,
> +	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =		1 << 0,
> +	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =		1 << 1,
> +	ETHTOOL_C33_PSE_EVENT_CONNECTED =		1 << 2,
> +	ETHTOOL_C33_PSE_EVENT_DISCONNECTED =		1 << 3,
> +	ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR =	1 << 4,
> +};

Same here, priority concept is not part of the spec, so the C33 prefix
should be removed.

> +
> +/**
> + * enum pse_port_prio_modes - PSE port priority modes.
> + * @ETHTOOL_PSE_PORT_PRIO_DISABLED: Port priority disabled.
> + * @ETHTOOL_PSE_PORT_PRIO_STATIC: PSE static port priority. Port priority
> + *	based on the power requested during PD classification. This mode
> + *	is managed by the PSE core.
> + * @ETHTOOL_PSE_PORT_PRIO_DYNAMIC: PSE dynamic port priority. Port priority
> + *	based on the current consumption per ports compared to the total
> + *	power budget. This mode is managed by the PSE controller.
> + */

This part will need some clarification about behavior with mixed port
configurations. Here is my proposal:

 * Expected behaviors in mixed port priority configurations:
 * - When ports are configured with a mix of disabled, static, and dynamic
 *   priority modes, the following behaviors are expected:
 *     - Ports with priority disabled (ETHTOOL_PSE_PORT_PRIO_DISABLED) are
 *       treated with lowest priority, receiving power only if the budget
 *       remains after static and dynamic ports have been served.
 *     - Static-priority ports are allocated power up to their requested
 *       levels during PD classification, provided the budget allows.
 *     - Dynamic-priority ports receive power based on real-time consumption,
 *       as monitored by the PSE controller, relative to the remaining budget
 *       after static ports.
 *
 * Handling scenarios where power budget is exceeded:
 * - Hot-plug behavior: If a new device is added that causes the total power
 *   demand to exceed the PSE budget, the newly added device is de-prioritized
 *   and shut down to maintain stability for previously connected devices.
 *   This behavior ensures that existing connections are not disrupted, though
 *   it may lead to inconsistent behavior if the device is disconnected and
 *   reconnected (hot-plugged).
 *
 * - Startup behavior (boot): When the system initializes with attached devices,
 *   the PSE allocates power based on a predefined order (e.g., by port index)
 *   until the budget is exhausted. Devices connected later in this order may
 *   not be enabled if they would exceed the power budget, resulting in consistent
 *   behavior during startup but potentially differing from runtime behavior
 *   (hot-plug).
 *
 * - Consistency challenge: These two scenarios—hot-plug vs. system boot—may lead
 *   to different handling of devices. During system boot, power is allocated
 *   sequentially, potentially leaving out high-priority devices added later due to
 *   a first-come-first-serve approach. In contrast, hot-plug behavior favors the
 *   status quo, maintaining stability for initially connected devices, which
 *   might not align with the system's prioritization policy.
 *

> +enum pse_port_prio_modes {
> +	ETHTOOL_PSE_PORT_PRIO_DISABLED,
> +	ETHTOOL_PSE_PORT_PRIO_STATIC,
> +	ETHTOOL_PSE_PORT_PRIO_DYNAMIC,
>  };
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

