Return-Path: <netdev+bounces-49304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3377F1986
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EC81C21004
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5BE20311;
	Mon, 20 Nov 2023 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVRE/+XX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB941B273;
	Mon, 20 Nov 2023 17:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87989C433C7;
	Mon, 20 Nov 2023 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700500537;
	bh=AkkfU8G24k1NiAgfHtVNcu8s1LD50aIEJGUxYBFMhPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVRE/+XXz0iFRCsh3l/F3VMi5GzyLj1gOMJ3PpZSyecz5K+rsVhWJVJzt1K/4WZxz
	 Yo5sD/WLWqoXgT+IG7Q5I0ocgYPInoP230a98e7YAf4dEfSzG8leeXztWj0PBQgKlt
	 SkKRQHHgGUc/xB2MqHEkvkxGX9xPVEdYAbyCCYEvXY+xe0uR4NxAVnZqHtZo4YGzBq
	 XVnPKk3fZdH4fNOcli9GO0PNRWt0ZHdeB692YvObKH2ohs+CscEBO7Dp6cFQyfLEX/
	 U2ca7wTc05iUzhnUsqN/x+mYBHxJEZkU8UO+iq1LEzaUJKkw0FAd7HsJfWokpUVJ3J
	 oAKQ50t/G/InQ==
Date: Mon, 20 Nov 2023 17:15:31 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Michalik <michal.michalik@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, jonathan.lemon@gmail.com,
	pabeni@redhat.com, poros@redhat.com, milena.olech@intel.com,
	mschmidt@redhat.com, linux-clk@vger.kernel.org, bvanassche@acm.org,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH RFC net-next v3 1/2] netdevsim: implement DPLL for
 subsystem selftests
Message-ID: <20231120171531.GA245676@kernel.org>
References: <20231117190505.7819-1-michal.michalik@intel.com>
 <20231117190505.7819-2-michal.michalik@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117190505.7819-2-michal.michalik@intel.com>

On Fri, Nov 17, 2023 at 08:05:04PM +0100, Michal Michalik wrote:
> DPLL subsystem integration tests require a module which mimics the
> behavior of real driver which supports DPLL hardware. To fully test the
> subsystem the netdevsim is amended with DPLL implementation.
> 
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>

Hi Michal,

Nice to see tests being added for DPLL.
some minor feedback from my side.

> diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c

...

> +static void nsim_fill_pin_pd(struct nsim_pin_priv_data *pd, u64 frequency, u32 prio,
> +			     enum dpll_pin_direction direction)

nit: Please consider limiting Networking code to 80 columns wide.

...

> +int nsim_dpll_init_owner(struct nsim_dpll *dpll, int devid,
> +			 unsigned int ports_count)
> +{
> +	u64 clock_id;
> +	int err;
> +
> +	get_random_bytes(&clock_id, sizeof(clock_id));
> +
> +	/* Create EEC DPLL */
> +	dpll->dpll_e = dpll_device_get(clock_id, EEC_DPLL_DEV, THIS_MODULE);
> +	if (IS_ERR(dpll->dpll_e))
> +		goto dpll_e;

Branching to dpll_e will cause the function to return err,
but err is uninitialised here.

As there is nothing to unwind here I would lean towards simply
returning a negative error value directly here. But if not,
I'd suggest setting err to a negative error value inside the
if condition.

Flagged by clang-16 W=1 build, and Smatch.

> +
> +	dpll->dpll_e_pd.temperature = EEC_DPLL_TEMPERATURE;
> +	dpll->dpll_e_pd.mode = DPLL_MODE_AUTOMATIC;
> +	dpll->dpll_e_pd.clock_id = clock_id;
> +	dpll->dpll_e_pd.status = DPLL_LOCK_STATUS_UNLOCKED;
> +
> +	err = dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &nsim_dds_ops,
> +				   &dpll->dpll_e_pd);
> +	if (err)
> +		goto e_reg;
> +
> +	/* Create PPS DPLL */
> +	dpll->dpll_p = dpll_device_get(clock_id, PPS_DPLL_DEV, THIS_MODULE);
> +	if (IS_ERR(dpll->dpll_p))
> +		goto dpll_p;
> +
> +	dpll->dpll_p_pd.temperature = PPS_DPLL_TEMPERATURE;
> +	dpll->dpll_p_pd.mode = DPLL_MODE_MANUAL;
> +	dpll->dpll_p_pd.clock_id = clock_id;
> +	dpll->dpll_p_pd.status = DPLL_LOCK_STATUS_UNLOCKED;
> +
> +	err = dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &nsim_dds_ops,
> +				   &dpll->dpll_p_pd);
> +	if (err)
> +		goto p_reg;
> +
> +	/* Create first pin (GNSS) */
> +	err = nsim_fill_pin_properties(&dpll->pp_gnss, "GNSS",
> +				       DPLL_PIN_TYPE_GNSS,
> +				       PIN_GNSS_CAPABILITIES, 1,
> +				       DPLL_PIN_FREQUENCY_1_HZ,
> +				       DPLL_PIN_FREQUENCY_1_HZ);
> +	if (err)
> +		goto pp_gnss;
> +	dpll->p_gnss =
> +		dpll_pin_get(clock_id, PIN_GNSS, THIS_MODULE, &dpll->pp_gnss);
> +	if (IS_ERR(dpll->p_gnss))
> +		goto p_gnss;
> +	nsim_fill_pin_pd(&dpll->p_gnss_pd, DPLL_PIN_FREQUENCY_1_HZ,
> +			 PIN_GNSS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
> +	err = dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
> +				&dpll->p_gnss_pd);
> +	if (err)
> +		goto e_gnss_reg;
> +
> +	/* Create second pin (PPS) */
> +	err = nsim_fill_pin_properties(&dpll->pp_pps, "PPS", DPLL_PIN_TYPE_EXT,
> +				       PIN_PPS_CAPABILITIES, 1,
> +				       DPLL_PIN_FREQUENCY_1_HZ,
> +				       DPLL_PIN_FREQUENCY_1_HZ);
> +	if (err)
> +		goto pp_pps;
> +	dpll->p_pps =
> +		dpll_pin_get(clock_id, PIN_PPS, THIS_MODULE, &dpll->pp_pps);
> +	if (IS_ERR(dpll->p_pps))
> +		goto p_pps;

This branch will cause the function to return err.
However, err is set to 0 here. Perhaps it should be set
to a negative error value instead?

Flagged by Smatch.

> +	nsim_fill_pin_pd(&dpll->p_pps_pd, DPLL_PIN_FREQUENCY_1_HZ,
> +			 PIN_PPS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
> +	err = dpll_pin_register(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
> +				&dpll->p_pps_pd);
> +	if (err)
> +		goto e_pps_reg;
> +	err = dpll_pin_register(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
> +				&dpll->p_pps_pd);
> +	if (err)
> +		goto p_pps_reg;
> +
> +	dpll->pp_rclk =
> +		kcalloc(ports_count, sizeof(*dpll->pp_rclk), GFP_KERNEL);
> +	dpll->p_rclk = kcalloc(ports_count, sizeof(*dpll->p_rclk), GFP_KERNEL);
> +	dpll->p_rclk_pd =
> +		kcalloc(ports_count, sizeof(*dpll->p_rclk_pd), GFP_KERNEL);
> +
> +	return 0;
> +
> +p_pps_reg:
> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
> +			    &dpll->p_pps_pd);
> +e_pps_reg:
> +	dpll_pin_put(dpll->p_pps);
> +p_pps:
> +	nsim_free_pin_properties(&dpll->pp_pps);
> +pp_pps:
> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
> +			    &dpll->p_gnss_pd);
> +e_gnss_reg:
> +	dpll_pin_put(dpll->p_gnss);
> +p_gnss:
> +	nsim_free_pin_properties(&dpll->pp_gnss);
> +pp_gnss:
> +	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
> +p_reg:
> +	dpll_device_put(dpll->dpll_p);
> +dpll_p:
> +	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
> +e_reg:
> +	dpll_device_put(dpll->dpll_e);
> +dpll_e:
> +	return err;
> +}

...

> +int nsim_rclk_init(struct netdevsim *ns)
> +{
> +	struct nsim_dpll *dpll;
> +	unsigned int index;
> +	int err, devid;
> +	char *name;
> +
> +	devid = ns->nsim_dev->nsim_bus_dev->dev.id;

devid is set but otherwise unused in this function.

Flagged gcc-14 and clang-16 W=1 builds.

> +	index = ns->nsim_dev_port->port_index;
> +	dpll = &ns->nsim_dev->dpll;
> +	err = -ENOMEM;
> +
> +	name = kasprintf(GFP_KERNEL, "RCLK_%i", index);
> +	if (!name)
> +		goto err;
> +
> +	/* Get EEC DPLL */
> +	if (IS_ERR(dpll->dpll_e))
> +		goto dpll;
> +
> +	/* Get PPS DPLL */
> +	if (IS_ERR(dpll->dpll_p))
> +		goto dpll;
> +
> +	/* Create Recovered clock pin (RCLK) */
> +	nsim_fill_pin_properties(&dpll->pp_rclk[index], name,
> +				 DPLL_PIN_TYPE_SYNCE_ETH_PORT,
> +				 PIN_RCLK_CAPABILITIES, 1, 1e6, 125e6);
> +	dpll->p_rclk[index] = dpll_pin_get(dpll->dpll_e_pd.clock_id,
> +					   PIN_RCLK + index, THIS_MODULE,
> +					   &dpll->pp_rclk[index]);
> +	kfree(name);
> +	if (IS_ERR(dpll->p_rclk[index]))
> +		goto p_rclk;

This branch will call kfree(name), but this has already been done above.
Likewise for the other goto branches below.

Flagged by Smatch.

> +	nsim_fill_pin_pd(&dpll->p_rclk_pd[index], DPLL_PIN_FREQUENCY_10_MHZ,
> +			 PIN_RCLK_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
> +	err = dpll_pin_register(dpll->dpll_e, dpll->p_rclk[index],
> +				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
> +	if (err)
> +		goto dpll_e_reg;
> +	err = dpll_pin_register(dpll->dpll_p, dpll->p_rclk[index],
> +				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
> +	if (err)
> +		goto dpll_p_reg;
> +
> +	netdev_dpll_pin_set(ns->netdev, dpll->p_rclk[index]);
> +
> +	return 0;
> +
> +dpll_p_reg:
> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
> +			    &dpll->p_rclk_pd[index]);
> +dpll_e_reg:
> +	dpll_pin_put(dpll->p_rclk[index]);
> +p_rclk:
> +	nsim_free_pin_properties(&dpll->pp_rclk[index]);
> +dpll:
> +	kfree(name);
> +err:
> +	return err;
> +}

...

