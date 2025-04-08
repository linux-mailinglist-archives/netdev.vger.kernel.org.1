Return-Path: <netdev+bounces-180414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F1A8144A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B2E4C23FE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D123E34A;
	Tue,  8 Apr 2025 18:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFE23E349
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135827; cv=none; b=CwFeMGBxS4Wmceb8+mLVJI0fMb49+TQPm+exWVUoZfbdAvu4Z480uEfo4IFZ536LIeRM81zldjrma20qys6f5bB5UwQe8N0MV1pcFdr4wqiiQH504/cKRqkj6Y+peU3AekAopWFEDNBPK+iWGjMyLL7vJ1dg9TEJSudqKNTRB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135827; c=relaxed/simple;
	bh=CRYNZL7wx3ySZCZ3RPL/sRT5R2HDnhGnZWOTrQc1SbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ljs6pqA+ebHofr9Vdt7z8aHtS3DOdYxqhuWPi7ZclXcvtNpxAkXCQ2e6OrIZNsMVStu8IFFvjuFLfGFPP0dAHxEunP+HAhccSJM1YtEvCRS754AhkRRdrqsRdU9cWRW1M3XVgzGDNeh21LJt4FBW6100EP8gxSGoJg4o/bsG1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2DOH-0006O8-0P; Tue, 08 Apr 2025 20:09:41 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2DOC-003yjn-2S;
	Tue, 08 Apr 2025 20:09:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2DOC-006eVd-1x;
	Tue, 08 Apr 2025 20:09:36 +0200
Date: Tue, 8 Apr 2025 20:09:36 +0200
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/13] net: pse-pd: Add support for PSE power
 domains
Message-ID: <Z_VmYMvqfrBPR1l5@pengutronix.de>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
 <20250408-feature_poe_port_prio-v7-4-9f5fc9e329cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408-feature_poe_port_prio-v7-4-9f5fc9e329cd@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

here are some points

On Tue, Apr 08, 2025 at 04:32:13PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Introduce PSE power domain support as groundwork for upcoming port
> priority features. Multiple PSE PIs can now be grouped under a single
> PSE power domain, enabling future enhancements like defining available
> power budgets, port priority modes, and disconnection policies. This
> setup will allow the system to assess whether activating a port would
> exceed the available power budget, preventing over-budget states
> proactively.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---
> Changes in v7:
> - Add reference count and mutex lock for PSE power domain in case of PSE
>   from different controllers want to register the same PSE power domain.
> 
> Changes in v6:
> - nitpick change.
> 
> Changes in v4:
> - Add kdoc.
> - Fix null dereference in pse_flush_pw_ds function.
> 
> Changes in v3:
> - Remove pw_budget variable.
> 
> Changes in v2:
> - new patch.
> ---
>  drivers/net/pse-pd/pse_core.c | 138 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pse-pd/pse.h    |   2 +
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 8755c2e00b6a..d26045e6ca85 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -13,8 +13,12 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  
> +#define PSE_PW_D_LIMIT INT_MAX
> +
>  static DEFINE_MUTEX(pse_list_mutex);
>  static LIST_HEAD(pse_controller_list);
> +static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
> +static DEFINE_MUTEX(pse_pw_d_mutex);
>  
>  /**
>   * struct pse_control - a PSE control
> @@ -35,6 +39,18 @@ struct pse_control {
>  	struct phy_device *attached_phydev;
>  };
>  
> +/**
> + * struct pse_power_domain - a PSE power domain
> + * @id: ID of the power domain
> + * @supply: Power supply the Power Domain
> + * @refcnt: Number of gets of this pse_power_domain
> + */
> +struct pse_power_domain {
> +	int id;
> +	struct regulator *supply;
> +	struct kref refcnt;
> +};
> +
>  static int of_load_single_pse_pi_pairset(struct device_node *node,
>  					 struct pse_pi *pi,
>  					 int pairset_num)
> @@ -440,6 +456,123 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
>  	return 0;
>  }
>  
> +static void __pse_pw_d_release(struct kref *kref)
> +{
> +	struct pse_power_domain *pw_d = container_of(kref,
> +						     struct pse_power_domain,
> +						     refcnt);
> +
> +	regulator_put(pw_d->supply);
> +	xa_erase(&pse_pw_d_map, pw_d->id);
> +}
> +
> +/**
> + * pse_flush_pw_ds - flush all PSE power domains of a PSE
> + * @pcdev: a pointer to the initialized PSE controller device
> + */
> +static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
> +{
> +	struct pse_power_domain *pw_d;
> +	int i;
> +
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		if (!pcdev->pi[i].pw_d)
> +			continue;
> +
> +		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> +		if (!pw_d)
> +			continue;
> +
> +		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
> +			       &pse_pw_d_mutex);
> +	}
> +}
> +
> +/**
> + * devm_pse_alloc_pw_d - allocate a new PSE power domain for a device
> + * @dev: device that is registering this PSE power domain
> + *
> + * Return: Pointer to the newly allocated PSE power domain or error pointers
> + */
> +static struct pse_power_domain *devm_pse_alloc_pw_d(struct device *dev)
> +{
> +	struct pse_power_domain *pw_d;
> +	int index, ret;
> +
> +	pw_d = devm_kzalloc(dev, sizeof(*pw_d), GFP_KERNEL);
> +	if (!pw_d)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1, PSE_PW_D_LIMIT),
> +		       GFP_KERNEL);
> +	if (ret)
> +		return ERR_PTR(ret);

Missing "kref_init(&pw_d->refcnt);" ?

> +	pw_d->id = index;
> +	return pw_d;
> +}
> +
> +/**
> + * pse_register_pw_ds - register the PSE power domains for a PSE
> + * @pcdev: a pointer to the PSE controller device
> + *
> + * Return: 0 on success and failure value on error
> + */
> +static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
> +{
> +	int i, ret = 0;
> +
> +	mutex_lock(&pse_pw_d_mutex);
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		struct regulator_dev *rdev = pcdev->pi[i].rdev;
> +		struct pse_power_domain *pw_d;
> +		struct regulator *supply;
> +		bool present = false;
> +		unsigned long index;
> +
> +		/* No regulator or regulator parent supply registered.
> +		 * We need a regulator parent to register a PSE power domain
> +		 */
> +		if (!rdev || !rdev->supply)
> +			continue;
> +
> +		xa_for_each(&pse_pw_d_map, index, pw_d) {
> +			/* Power supply already registered as a PSE power
> +			 * domain.
> +			 */
> +			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
> +				present = true;
> +				pcdev->pi[i].pw_d = pw_d;
> +				break;
> +			}
> +		}
> +		if (present) {
> +			kref_get(&pw_d->refcnt);
> +			continue;
> +		}
> +
> +		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
> +		if (IS_ERR_OR_NULL(pw_d)) {

s/IS_ERR_OR_NULL/IS_ERR

devm_pse_alloc_pw_d() is not returning NULL.

> +			ret = PTR_ERR(pw_d);
> +			goto out;
> +		}
> +
> +		supply = regulator_get(&rdev->dev, rdev->supply_name);
> +		if (IS_ERR(supply)) {
> +			xa_erase(&pse_pw_d_map, pw_d->id);
> +			ret = PTR_ERR(supply);

Here:
Either we need to ensure pse_flush_pw_ds() handles incomplete setups
or immediately clean up earlier entries in the loop when an error
occurs.

> +			goto out;
> +		}
> +
> +		pw_d->supply = supply;
> +		pcdev->pi[i].pw_d = pw_d;
> +	}
> +
> +out:
> +	mutex_unlock(&pse_pw_d_mutex);
> +	return ret;
> +}
 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

