Return-Path: <netdev+bounces-183667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79BA91794
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A13460E10
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513F22ACF7;
	Thu, 17 Apr 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD9KAabj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487A22A811;
	Thu, 17 Apr 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881583; cv=none; b=poT0aBVt15wMBFvZmXRjAqOwYOMTUwbyMhhwLkYtdSLxDt1olwRq70Hi4GBnixAKOM5/HwTvfVNLv+shl3+haWpQmq2yUHfaQtYlEPkgxF6ArrtLzC28lLXymgmTbO8eq/d7RpJ4J6DaQOyjGZuy0C4OwtmCcnayWYOEVFKIX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881583; c=relaxed/simple;
	bh=Rd8dR5mrLxtA4cWdfHrGRP8CZ4syR8GqQIiI8cKDki4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkf7Vj5LJfpyOxou0AoQOh2TvG7BnyiAVohMZ886Q5I7X/82jWjE9/8aiSQnrMCqNj70mPOSRbFlebpP3wgxrEEcSLWx5jGXrIwr4rW74v06GJeAxj4DmbXkVqXXjNrL06WEUkNriA0R9d2/qBPLmafb98o77YYYzTOLD13OTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD9KAabj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61089C4CEEE;
	Thu, 17 Apr 2025 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744881581;
	bh=Rd8dR5mrLxtA4cWdfHrGRP8CZ4syR8GqQIiI8cKDki4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FD9KAabj+GLPxJZyVB0XxL2tOJpdpCb0zHp5EfdMtghZZs0tI8Hr4DRmvItDg+FXw
	 R+VcjgwKDgKZ10FCnp0bUto0evEKZdxSfn/Fiu1kWfxZIPoOKEpKfWL7SR7xZHAL21
	 aE/vkmF6ddvoJ/ZJ7LFX/C7vimUg+qaKsrjRqKgLc2tpBPYewyC4J9odk7emTJHq30
	 5mcNDuWxHiSQIXNbe1ykg/u2pCznT2z+GbEiOFYTxtLvFMM9in7h7Z+OLropK5DqWT
	 lq/TAxo8X9NLowo93xVCB+awHqAygPv0kON9wIi0iErpsaGtIlXcprl0tyPkX8OfKE
	 7cgDHC7sYVm8g==
Date: Thu, 17 Apr 2025 10:19:36 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [net-next PATCH v3 03/11] net: pcs: Add subsystem
Message-ID: <20250417091936.GB2430521@horms.kernel.org>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415193323.2794214-4-sean.anderson@linux.dev>

On Tue, Apr 15, 2025 at 03:33:15PM -0400, Sean Anderson wrote:
> This adds support for getting PCS devices from the device tree. PCS
> drivers must first register with phylink_register_pcs. After that, MAC
> drivers may look up their PCS using phylink_get_pcs.
> 
> We wrap registered PCSs in another PCS. This wrapper PCS is refcounted
> and can outlive the wrapped PCS (such as if the wrapped PCS's driver is
> unbound). The wrapper forwards all PCS callbacks to the wrapped PCS,
> first checking to make sure the wrapped PCS still exists. This design
> was inspired by Bartosz Golaszewski's talk at LPC [1].
> 
> pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
> compatibility with existing drivers, which often attach to (devicetree)
> nodes directly. We use the devicetree changeset system instead of
> adding a (secondary) software node because mdio_bus_match calls
> of_driver_match_device to match devices, and that function only works on
> devicetree nodes.
> 
> [1] https://lpc.events/event/17/contributions/1627/
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Hi Sean,

I noticed a few build problems after sending my previous email.

I was able to exercise them using variants of the following to
generate small configs. I include this here in case it is useful to you.

make tinyconfig

cat >> .config << __EOF__
CONFIG_MODULES=y
CONFIG_NET=y
CONFIG_NETDEVICES=y
CONFIG_PCS=y
CONFIG_PHYLIB=m
__EOF__

cat >> .config << __EOF__
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_DYNAMIC=y
__EOF__

yes "" | make oldconfig

...

> diff --git a/drivers/net/pcs/core.c b/drivers/net/pcs/core.c

...

> +/**
> + * _pcs_get() - Get a PCS from a fwnode property
> + * @dev: The device to get a PCS for
> + * @fwnode: The fwnode to find the PCS with
> + * @id: The name of the PCS to get. May be %NULL to get the first PCS.
> + * @fallback: An optional fallback property to use if pcs-handle is absent
> + * @optional: Whether the PCS is optional
> + *
> + * Find a PCS referenced by @mac_node and return a reference to it. Every call
> + * to _pcs_get_by_fwnode() must be balanced with one to pcs_put().
> + *
> + * Return: a PCS if found, %NULL if not, or an error pointer on failure
> + */
> +struct phylink_pcs *_pcs_get(struct device *dev, struct fwnode_handle *fwnode,
> +			     const char *id, const char *fallback,
> +			     bool optional)
> +{
> +	struct fwnode_handle *pcs_fwnode;
> +	struct phylink_pcs *pcs;
> +
> +	pcs_fwnode = pcs_find_fwnode(fwnode, id, fallback, optional);
> +	if (IS_ERR(pcs_fwnode))
> +		return ERR_CAST(pcs_fwnode);
> +
> +	pcs = _pcs_get_tail(dev, pcs_fwnode, NULL);
> +	fwnode_handle_put(pcs_fwnode);
> +	return pcs;
> +}
> +EXPORT_SYMBOL_GPL(_pcs_get);
> +
> +static __maybe_unused void of_changeset_cleanup(void *data)
> +{
> +	struct of_changeset *ocs = data;

Code in pcs_get_by_fwnode_compat is conditionally compiled
based on CONFIG_OF_DYNAMIC. I think that is needed here too,
because of_changeset_revert() doesn't exist unless CONFIG_OF_DYNAMIC is set.

> +
> +	if (WARN(of_changeset_revert(ocs),
> +		 "could not revert changeset; leaking memory\n"))
> +		return;
> +
> +	of_changeset_destroy(ocs);
> +	kfree(ocs);
> +}
> +
> +/**
> + * pcs_get_by_fwnode_compat() - Get a PCS with a compatibility fallback
> + * @dev: The device requesting the PCS
> + * @fwnode: The &struct fwnode_handle of the PCS itself
> + * @fixup: Callback to fix up @fwnode for compatibility
> + * @data: Passed to @fixup
> + *
> + * This function looks up a PCS and retries on failure after fixing up @fwnode.
> + * It is intended to assist in backwards-compatible behavior for drivers that
> + * used to create a PCS directly from a &struct device_node. This function
> + * should NOT be used in new drivers.
> + *
> + * @fixup modifies a devicetree changeset to create any properties necessary to
> + * bind the PCS's &struct device_node. At the very least, it should use
> + * of_changeset_add_prop_string() to add a compatible property.
> + *
> + * Note that unlike pcs_get_by_fwnode, @fwnode is the &struct fwnode_handle of
> + * the PCS itself, and not that of the requesting device. @fwnode could be
> + * looked up with pcs_find_fwnode() or determined by some other means for
> + * compatibility.
> + *
> + * Return: A PCS on success or an error pointer on failure
> + */
> +struct phylink_pcs *
> +pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
> +			 int (*fixup)(struct of_changeset *ocs,
> +				      struct device_node *np, void *data),
> +			 void *data)
> +{
> +#ifdef CONFIG_OF_DYNAMIC
> +	struct mdio_device *mdiodev;
> +	struct of_changeset *ocs;
> +	struct phylink_pcs *pcs;
> +	struct device_node *np;
> +	struct device *pcsdev;
> +	int err;
> +
> +	/* First attempt */
> +	pcs = _pcs_get_tail(dev, fwnode, NULL);
> +	if (PTR_ERR(pcs) != -EPROBE_DEFER)
> +		return pcs;
> +
> +	/* No luck? Maybe there's no compatible... */
> +	np = to_of_node(fwnode);
> +	if (!np || of_property_present(np, "compatible"))
> +		return pcs;
> +
> +	/* OK, let's try fixing things up */
> +	pr_warn("%pOF is missing a compatible\n", np);
> +	ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
> +	if (!ocs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	of_changeset_init(ocs);
> +	err = fixup(ocs, np, data);
> +	if (err)
> +		goto err_ocs;
> +
> +	err = of_changeset_apply(ocs);
> +	if (err)
> +		goto err_ocs;
> +
> +	err = devm_add_action_or_reset(dev, of_changeset_cleanup, ocs);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	mdiodev = fwnode_mdio_find_device(fwnode);

fwnode_mdio_find_device() is unavailable for linking if PHYLIB is a module
(and PCS is built-in).

> +	if (mdiodev) {
> +		/* Clear that pesky PHY flag so we can match PCS drivers */
> +		device_lock(&mdiodev->dev);
> +		mdiodev->flags &= ~MDIO_DEVICE_FLAG_PHY;
> +		device_unlock(&mdiodev->dev);
> +		pcsdev = &mdiodev->dev;
> +	} else {
> +		pcsdev = get_device(fwnode->dev);
> +		if (!pcsdev)
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	err = device_reprobe(pcsdev);
> +	put_device(pcsdev);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return _pcs_get_tail(dev, fwnode, NULL);
> +
> +err_ocs:
> +	of_changeset_destroy(ocs);
> +	kfree(ocs);
> +	return ERR_PTR(err);
> +#else
> +	return _pcs_get_tail(dev, fwnode, NULL);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(pcs_get_by_fwnode_compat);

...

