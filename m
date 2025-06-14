Return-Path: <netdev+bounces-197824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819BAD9F64
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C096017642D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C51E2E6D14;
	Sat, 14 Jun 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaZRY6F4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FE2D9EE5;
	Sat, 14 Jun 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749928726; cv=none; b=jrIa2HGrsYXRZJSZsMKLfcM9abbBY00YZHENR8n663DrtjKvjq0r0tczlFwGD4dVe6QwohzzczA4JL8CQ8lyNXR00n88Ve/NdVZVcu0SQnxI8nDx+v+e4ZrfmXHb6E2Fw8ujX+LjrWZbE92kyN5rX61o7IX2iQL9z0Ti9UMHgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749928726; c=relaxed/simple;
	bh=gPwIMB5yht2htyKvqFUobBWtnQjdvyxo2ukCqhh4kXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwiD1uWfW0Mu4tCqXifdsGApBnbWR+HfrUJ1RXjIC1fOO17DHOXeA+5tM8UwtlS9coDMrZPJMDzV+syBj1P6Jwfg7bTNljy1jVPUzOIyqOtzSTqpqwkQDUEO0AeeNTAe7yn5bjdfJQ+g3IjlY1cuZMwz+CTaD+CvqJXRuYpYWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaZRY6F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB48C4CEEB;
	Sat, 14 Jun 2025 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749928725;
	bh=gPwIMB5yht2htyKvqFUobBWtnQjdvyxo2ukCqhh4kXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaZRY6F4ANXmVtmzoU43md63FoORhMuuaEg6D1KxbydrRyNE4AZMpp4v21PUL9e6Y
	 Ut3F3Qe1tKwQBLo5z4tyl8j/afqQeaWrWBh0xoRie1lJyqtuolrC/Q4UhsEiG0YLk5
	 AaGStcgxhl1Dxo8xGoMVyOspopehw91mHqnIRUBN4o3IANSKSZJPQ1/MeIu/9+oq1S
	 /6O2gWJFbf442lqvEsm1u/tOiLDoZRxw3zZIh9n/pexCFgQxIvyC7P8CjdjDCxhfid
	 nythEmD4Xd4tHEB2eq58tRuCGE3DW6Y8gM2ojvN+BdgnqyfPkepge9+xZPfuFunvKE
	 P1IHqfiv8+A4A==
Date: Sat, 14 Jun 2025 12:18:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250614121843.427cfc42@kernel.org>
In-Reply-To: <20250610-feature_poe_port_prio-v13-2-c5edc16b9ee2@bootlin.com>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-2-c5edc16b9ee2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:11:36 +0200 Kory Maincent wrote:
> +static struct net_device *
> +pse_control_find_net_by_id(struct pse_controller_dev *pcdev, int id,
> +			   netdevice_tracker *tracker)
> +{
> +	struct pse_control *psec, *next;
> +
> +	mutex_lock(&pse_list_mutex);
> +	list_for_each_entry_safe(psec, next, &pcdev->pse_control_head, list) {

nit: _safe is not necessary here, the body of the if always exits after
dropping the lock

Do you plan to add more callers for this function?
Maybe it's better if it returns the psec pointer with the refcount
elevated. Because it would be pretty neat if we could move the 
ethnl_pse_send_ntf(netdev, notifs, &extack); that  pse_isr() does
right after calling this function under the rtnl_lock.
I don't think calling ethnl_pse_send_ntf() may crash the kernel as is,
but it feels like a little bit of a trap to have ethtool code called
outside of any networking lock.

> +		if (psec->id == id) {
> +			struct net_device *netdev = NULL;
> +			struct phy_device *phydev;
> +
> +			kref_get(&psec->refcnt);
> +			/* Release the mutex before taking the rtnl lock
> +			 * to avoid deadlock in case of a pse_control_put
> +			 * call with the rtnl lock held.
> +			 */
> +			mutex_unlock(&pse_list_mutex);
> +			/* Acquire rtnl to protect the net device
> +			 * reference get.
> +			 */
> +			rtnl_lock();
> +			phydev = psec->attached_phydev;
> +			if (phydev->attached_dev) {
> +				netdev = phydev->attached_dev;
> +				netdev_hold(netdev, tracker, GFP_KERNEL);
> +			}
> +			rtnl_unlock();
> +			pse_control_put(psec);
> +			return netdev;
> +		}
> +	}
> +	mutex_unlock(&pse_list_mutex);
> +	return NULL;
> +}

